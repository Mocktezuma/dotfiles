
package sessionman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

@EXPORT = qw(PCAP_IP_Extract SESSIONhelp);
$version = '0.01';

# external modules

use dataman qw(ParseOptions);
use frameman qw(Parse_Ethernet_Frame);
use pcapman qw(Parse_Frames);
use myIO qw(CustomOutputFunction ReadConf SetOutputDir);
use binman qw(Packed TestFlag);
use ipman qw(IPaddrDec_To_ASCII CIDR_regex);

# globals

sub Usage() {

    return sprintf <<END;

    xtract [file] SESSIONS:
    -----------------------
	extract all streams from a network capture file.  Output into dump files or return activity in a network diagram.
END


}


our $SESSIONhelp = Usage();

our %SESSION_help = (

    "-viz" => '-viz: display session information as GraphVizdiagram.',

    "-onlyport" => '-onlyport [portnum]: only extract sessions involving port [portnum].  Right now only allows one port to be specified per run but this will be corrected later.',

    "-noport" => '-noport [portnum]: only extract sessions *not* involving port [portnum]. Right now only allows one port to be specified per run but this will be corrected later.',

    "-nomin" => '-viz|-paj -nomin: by default wire diagram output labels the line with the Min of the two ports in the assumption that the smaller valued port is the one which identifies the service.  If you want diagram output to show typically random high ports use this option.  Only valid in conjunction with -viz or -paj.',

    "-noprot" => '-noprot [TCP|UDP|ICMP...]: only extract sessions not involving a certain protocol.',

    "-onlyprot" => '-onlyprot [TCP|UDP|ICMP...]: only extract sessions involving a certain protocol.',

    "-noIP"     => '-noIP [list of IPs in ASCII format]: skip any packets which include one of the listed IPs as the sender or recipient',

    "-onlyIP"     => '-onlyIP [list of IPs in ASCII format: only log data for any packets which include one of the listed IPs as the sender or recipient',

    "-separated" => '-separated: dump each side (client/server) of each file into a separate file.  Warning: can lead to a large number of files being created, not an easy way to work thru traffic.',

    "-dir" => '-dir [path to dump directory: specify a path to where you want output session files to be saved.  Otherwise xtract will place files in current directory.  WARNING: if you specify a path to an existing directory, that directory will be clobbered.',

    "-carve" => '-carve [filetype]: once SESSIONS have been dumped to file go back through the files looking for files of type [filetype] as defined by other xtract routines.',

    "-paj" => '-paj: dump session information to a .net network diagram file readable/editable by Pajek (http://vlado.fmf.uni-lj.si/pub/networks/pajek/',

    "-subnet" => '-subnet [number]: resulting net diagram will draw lines between IP addresses which fall within a /[number] CIDR-notation subnet.  Must be used with the "-paj" or "-viz" option.',

    "-concat" => '-concat [file2 file3...: concatenate data from multiple pcap files for processing in a single session.'

    );

my %SESSION_Options = (
    "-viz" => \&Set_Viz_Flag,
    "-paj" => \&Set_Paj_Flag,
    "-noport" => \&Set_NoPort_Flag,
    "-onlyport" => \&Set_OnlyPort_Flag,
    "-separated" => \&Set_Separated_Flag,
    "-dir" => \&Set_Output_Directory,
    "-carve" => \&Set_Carve_Flag,
    "-subnet" => \&Set_Subnet_Flag,
    "-concat" => \&myIO::ProcessAdditionalFiles,
    "-onlyprot" => \&Set_OnlyProt_Flag,
    "-noprot" => \&Set_NoProt_Flag,
    "-onlyIP" => \&Set_OnlyIP_Flag,
    "-noIP"   => \&Set_NoIP_Flag,
    "-nomin" => \&Set_NoMin_Flag,
    );

my %FLAG = (
    "viz" => 0,
    "paj" => 0,
    "onlyport" => 0,
    "noport" => 0,
    "separated" => 0,
    "dir" => 0,
    "subnet" => 0,
    "concat" => 0,
    "noprot" => 0,
    "onlyprot" => 0,
    "noIP" => 0,
    "onlyIP" => 0,
    "nomin" => 0,
    );


my %Sessions = (         
 
    );

# network layer protocols

my $IP = 2048;         # 0x0800
my $ARP = 2054;        # 0x0806

# transport layer protocols

my $UDP = 17;
my $TCP = 6;
my $ICMP = 1;
my $IGMP = 2;

# TCP-specific values

my $TCP_DATA_OFFSET = 0xf000;
my $TCP_FLAGS = 0x00ff;

my $FIN = 0x1;
my $SYN = 0x2;
my $RST = 0x4;
my $PSH = 0x8;
my $ACK = 0x10;

my $URG = 0x20;
my $ECE = 0x40;
my $CWR = 0x80;

my @TCP_masks = ($CWR,$ECE,$URG,$ACK,$PSH,$RST,$SYN,$FIN);

# miscellaneous system-specific crap

my $dump_path = "./";
	    
# general routines

sub ExtractSessions {       

    my $in_data_ref = shift;
    my $additional_arguments = shift;
 
    my @ReturnData = ();
    my @options = @$additional_arguments;

    my $TransportNames = myIO::ReadConf("Transport_Names");

    my $TCPnames = myIO::ReadConf("TCP_Protocol_Names");
    my $UDPnames = myIO::ReadConf("UDP_Protocol_Names");
    my $ICMPnames = myIO::ReadConf("ICMP_Type_Names");
    my $IGMPnames = myIO::ReadConf("IGMP_Type_Names");
    my $ARPnames = myIO::ReadConf("ARP_Type_Names");
    
    my $Parse = \&ParsePCAPs; # can easily fill %Sessions from other sources of network data such as log files

    my %PROTOCOL_NAME = (

	$TCP => $TCPnames,

	$UDP => $UDPnames,

        $ICMP => $ICMPnames,

        $IGMP => $IGMPnames,

        $ARP => $ARPnames,

    );

    if ($#options) {
	dataman::ParseOptions($in_data_ref,\%SESSION_Options,\@options);
    }

    if ($FLAG{dir}) {             # set output path if specified
	
	MakeDir($FLAG{dir});
	$dump_path = $FLAG{dir}."/";

	myIO::SetOutputDir($dump_path);   # so that any carved files appear in the same directory
    }

    # set output function

    if ($FLAG{viz} || $FLAG{paj}) {             

	myIO::CustomOutputFunction(\&GenerateLinkDiagram);

    } 

    else {
	    
	myIO::CustomOutputFunction(\&CreatePayloadFiles);

    }

    # log parsed pcap data into the %Sessions hash

    foreach my $file_contents_ref (@$in_data_ref) {

	    &$Parse(\%Sessions,$file_contents_ref,$TransportNames);

    }

    # clean everything up and return the hash for output
    
    Clean_TCP_Sessions(\%Sessions);

    push @ReturnData,\%Sessions;
    push @ReturnData,\%PROTOCOL_NAME;
    push @ReturnData,$TransportNames;

    return \@ReturnData;

}

sub ParsePCAPs {

   (my $Sessions,
    my $in_data_ref, 
    my $TransportNames) = @_;

    my $frames = pcapman::Parse_Frames($in_data_ref);

    my $datagrams = frameman::Parse_Datagrams($frames);

    foreach my $datagram (@$datagrams) {


	if (!$datagram) {next;}            # some versions of Perl may spaz out with the null pointers generated during defragging. 
                                           # better will be to eliminate the null pointers entirely but this is a stopgap solution in the
                                           # meantime.


	
	# check net protocol: kill anything other than ARP or IP

	my $network_protocol = $datagram->{net_prot};
	    
        if ($network_protocol eq $ARP && ProtocolsAllowed($ARP,$TransportNames)) {        
	    
            LogMPsession($ARP,$Sessions,$datagram);	   

        } 

	elsif ($network_protocol ne $IP) {   
	    
	    next;

	} 

	# it's IP from here on out!

	my $transport_protocol = $datagram->{transp_prot};

	if (!ProtocolsAllowed($transport_protocol,$TransportNames) ||
            !IPsAllowed($datagram->{src_ip},$datagram->{dst_ip}  )   ){next;}
	
	if ($transport_protocol eq $UDP){ 
	    
	    (my $src_port,my $dst_port,my $payload) = Parse_UDP_Datagram($datagram);
	    
	    if (!PortsAllowed($src_port,$dst_port)){next;} # involves an illegal port

	    my %UDP_Connection = (
		"src_port" => $src_port,
		"dst_port" => $dst_port,
                "src_ip" => $datagram->{src_ip},
		"dst_ip" => $datagram->{dst_ip},
		);

	    LogUDPsession($Sessions,\%UDP_Connection,\$payload);

	} 

	elsif ($transport_protocol eq $TCP){
	    (my $src_port,
	     my $dst_port,
	     my $SEQnum,
	     my $ACKnum,
	     my $ACKflag,
	     my $RSTflag,
	     my $SYNflag,
	     my $FINflag,
	     my $offset,  
	     my $payload) = Parse_TCP_Segment($datagram);

	    if (!PortsAllowed($src_port,$dst_port)){next;}
	    my %TCP_Connection = (		
		"src_port"=> $src_port,
		"dst_port"=> $dst_port,
		"src_ip" => $datagram->{src_ip},
		"dst_ip" => $datagram->{dst_ip},
		
		"seq"=> $SEQnum,
		"data"=> $payload,
		);

	    LogTCPsession($Sessions,\%TCP_Connection);

	} 

	elsif ($transport_protocol eq $ICMP || $transport_protocol eq $IGMP) {

	    (my $mp_type) = Parse_MP_Segment($datagram);

	    my %MP_Transmission = (           
		"src" => $datagram->{src_ip},
		"dst" => $datagram->{dst_ip},
		"type" => $mp_type,
		);

	    LogMPsession($transport_protocol,$Sessions,\%MP_Transmission);
	    
	}
    }	   
}

# MP (ICMP,IGMP) routines

sub Parse_MP_Segment {
    
    my $datagram = shift;

    use bytes;

    (my $message_type) = $datagram->{payload} =~ /(^.{1})/s;

    return binman::Packed($message_type);
    
}

sub LogMPsession {

   (my $MessageType,
    my $sessions,
    my $transmission) = @_;

    my $src = $transmission->{src};
    my $dst = $transmission->{dst};

    if (! $sessions->{$MessageType}->{$src}->{$dst}) {

	push my @message_log,$transmission->{type};
	$sessions->{$MessageType}->{$src}->{$dst} = \@message_log;

    } else {

	push @{$sessions->{$MessageType}->{$src}->{$dst}},$transmission->{type};

    }
    
}

# UDP routines

sub Parse_UDP_Datagram {
    
    my $datagram = shift;

    use bytes;

    (my $src_port,
     my $dest_port,
     my $length,
     my $checksum,
     my $payload) = $datagram->{payload} =~ 
      
     /

         (^.{2})                    # 2 bytes for source port
         (.{2})                    # 2 bytes for dest port
         (.{2})                    # 2 bytes for length
         (.{2})                     # 2 bytes for checksum
         (.*)
     /sx;

    return (binman::Packed($src_port),binman::Packed($dest_port),$payload);

}

sub LogUDPsession {
   (my $Sessions, 
    my $connection, 
    my $payload) = @_;
    
    my $src_port = $connection->{src_port};
    my $dst_port = $connection->{dst_port};

    my $src_ip = $connection->{src_ip};
    my $dst_ip = $connection->{dst_ip};

    $Sessions->{$UDP}->{$dst_port}->{$dst_ip}->{$src_port}->{$src_ip} .= $$payload;

}

# TCP routines

sub Parse_TCP_Segment {

    my $datagram = shift;

    use bytes;
    
    (my $src_port,
     my $dest_port,
     my $SEQ_num,
     my $ACK_num,
     my $segment_parameters) = $datagram->{payload} =~

     /
       
       (^.{2})                      # 2 bytes for source port
        (.{2})                      # 2 bytes for dest port
        (.{4})                      # 4 bytes for sequence number
        (.{4})                      # 4 bytes for acknowledgement number
        (.{2})                      # capture: 2 bytes for offset,reserved field,flags

    /sx;

    
    my $data_offset = ParseDataOffset($segment_parameters)*2;   # size is given in words so mult. to get bytes
    my @flags = Parse_Segment_Flags(binman::Packed($segment_parameters));      # (CWR,ECE,URG,ACK,PSH,RST,SYN,FIN)


    (my $segment_payload) = $datagram->{payload} =~

    /

        .{$data_offset}             # skip however-many header bytes
        (.*$)                       # grab the payload

    /sx;

    return 
    (
	    binman::Packed($src_port),
	    binman::Packed($dest_port),
	    binman::Packed($SEQ_num),
	    binman::Packed($ACK_num),
	
	    $flags[3],     # ACK flag
	    $flags[5],     # RST flag
	    $flags[6],     # SYN flag
	    $flags[7],     # FIN flag
	    
	    $data_offset,
	    $segment_payload
   ); 
}

sub ParseDataOffset {
    my $param_field = binman::Packed(shift);

    # data offset will be the high nibble (0xf000) of the parameter field
    
    return ($param_field & $TCP_DATA_OFFSET) >> 11;

}


sub Parse_Segment_Flags {
    
    my $param_field = shift;

    my $flag_field = $param_field & $TCP_FLAGS;

    return map(binman::TestFlag($flag_field,$_),@TCP_masks);
}

sub LogTCPsession {      # simply log the src/dst port+IP information together with the sequence number of the datagram
                         # and the datagram payload as a pointer to a hash. Clean_TCP_Sessions will handle the cleanup 
                         # later 

    my $Sessions = shift;
    my $connection = shift;

    my $src_port = $connection->{src_port};
    my $dst_port = $connection->{dst_port};

    my $src_ip = $connection->{src_ip};
    my $dst_ip = $connection->{dst_ip};

    if (! $Sessions->{$TCP}->{$dst_port}->{$dst_ip}->{$src_port}->{$src_ip} ) {    #  beginning of new session
#	printf("new session\n");
	push my @stream_log,$connection;                                  
	$Sessions->{$TCP}->{$dst_port}->{$dst_ip}->{$src_port}->{$src_ip} = \@stream_log; 

    } 

    else {

	push @{$Sessions->{$TCP}->{$dst_port}->{$dst_ip}->{$src_port}->{$src_ip}},$connection;

    }

}

sub Clean_TCP_Sessions {            # eliminate duped packets, write final payloads for streams
    
    my $sessions = shift;

    my $DST_PORTS_HASHref = $sessions->{$TCP};

    for (keys %$DST_PORTS_HASHref) {

	my $dst_port = $_;       
	my $DST_IP_HASHref = $DST_PORTS_HASHref->{$dst_port};

	for (keys %$DST_IP_HASHref) {

	    my $dst_ip = $_;
	    my $SRC_PORT_HASHref = $DST_IP_HASHref->{$dst_ip};
	    
	    for (keys %$SRC_PORT_HASHref) {
		    
		my $src_port = $_;
		my $SRC_IP_HASHref = $SRC_PORT_HASHref->{$src_port};

		for (keys %$SRC_IP_HASHref) {
		    my $src_ip = $_;
		    my $stream_log_ref = $SRC_IP_HASHref->{$src_ip};       		    
		    $SRC_IP_HASHref->{$src_ip} = Return_TCP_Payload($stream_log_ref);
	#	    printf("src port %d dst port %d payload ref %s",$src_port,$dst_port,$SRC_IP_HASHref->{$src_ip});

		}
		    
	    }
	}
    }
}

sub Return_TCP_Payload {  

    my $stream_log_ref = shift;
    my $count = 1;
    my $payload;

    while ($count <= @$stream_log_ref) {

	my $current_segment = @$stream_log_ref[$count];
	my $previous_segment = @$stream_log_ref[$count-1];

	if ( $current_segment->{seq} > $previous_segment->{seq}) {

	    $payload .= $previous_segment->{data};

	}

	$count++;
    }

    return $payload;
}

# output routines


sub CreatePayloadFiles {            

    my $data_ref = shift;

    my $sessions = @$data_ref[0];      # session information based on parsing pcap file
    my $ProtocolNames = @$data_ref[1];      # equivalences between port #s and protocols
    my $TransportNames = @$data_ref[2];

    my $dump_file_name;
    my @FileNames = ();
    my %FileHandle_Hash;
    my $XtractStreams;

    my @SessionProtocols = ($TCP,$UDP);
    
    if ($FLAG{separated}) {
	
	$XtractStreams = \&OutputSocketSession;
    }

    else {

	$XtractStreams = \&OutputProtocolSession;
	
    }

    foreach my $transport_layer (@SessionProtocols) {

       my $DST_PORTS_HASHref = $sessions->{$transport_layer};          

       for (keys %$DST_PORTS_HASHref) {

	   my $dst_port = $_;       
	   my $DST_IP_HASHref = $DST_PORTS_HASHref->{$dst_port};

	   for (keys %$DST_IP_HASHref) {

	    my $dst_ip = $_;
	    my $SRC_PORT_HASHref = $DST_IP_HASHref->{$dst_ip};
	    
	    for (keys %$SRC_PORT_HASHref) {
		    
		my $src_port = $_;
		my $SRC_IP_HASHref = $SRC_PORT_HASHref->{$src_port};

		for (keys %$SRC_IP_HASHref) {
		    my $src_ip = $_;

       
		       &$XtractStreams($SRC_IP_HASHref,$transport_layer,$src_ip,$dst_ip,$src_port,$dst_port,$TransportNames,$ProtocolNames,\%FileHandle_Hash,\@FileNames);
		}
		    
	    }
	   }
       }
    }
      

    CloseAllFiles(\%FileHandle_Hash);

    CarveOutFiles(\@FileNames);
}

sub OutputProtocolSession {

    (
     my $sessions,
     my $transport_layer,
     my $ip_src,
     my $ip_dst,
     my $port_src,
     my $port_dst,
     my $TransportNames,
     my $ProtocolNames,
     my $filehandle_hash,
     my $filename_array
    ) = @_;

    my $ip_srcASCII = ipman::IPaddrDec_To_ASCII($ip_src);
    my $ip_dstASCII = ipman::IPaddrDec_To_ASCII($ip_dst);

    my $lo_port = Min($port_src,$port_dst);
    my $hi_port = Max($port_src,$port_dst);

    my $src_client_server;
    my $dst_client_server;

    my $protocol_name = ReturnTypeName($transport_layer,$lo_port,$ProtocolNames,$TransportNames);

    if ($sessions->{$ip_src} && #non-zero payload
	(my $file_path = CreateFileHandle($protocol_name,$filehandle_hash))){

	push @$filename_array,$file_path;		  

    } 	       

    if ($port_src eq $hi_port) {
			   
	$src_client_server = "CLIENT";
	$dst_client_server = "SERVER";
			   
    } 

    else {

	$src_client_server = "SERVER";
	$dst_client_server = "CLIENT";			  

    }

    my $session_banner_start = sprintf("\n\nSTART:\n\n%s %s -> %s %s\n====\n\n",$src_client_server,$ip_srcASCII,$dst_client_server,$ip_dstASCII);

    my $session_banner_end = sprintf("\n\nEND=======%s %s -> %s %s======\n\n",$src_client_server,$ip_srcASCII,$dst_client_server,$ip_dstASCII);
		       
    
    if ($sessions->{$ip_src}) {
			   
	my $filehandle = $filehandle_hash->{$protocol_name};

	print $filehandle $session_banner_start;

	print $filehandle $sessions->{$ip_src};

	print $filehandle $session_banner_end;
	
    }
		       
}

sub OutputSocketSession {        # dump each side of each socket session into separate file


    (
     my $sessions,
     my $transport_layer,
     my $ip_src,
     my $ip_dst,
     my $src_port,
     my $dst_port,
     my $TransportNames,
     my $ProtocolNames,
     my $filehandle_hash,
     my $filename_array
    ) = @_;

    my $ip_srcASCII = ipman::IPaddrDec_To_ASCII($ip_src);
    my $ip_dstASCII = ipman::IPaddrDec_To_ASCII($ip_dst);
		       
    my $protocol_name = ReturnTypeName($transport_layer,Min($src_port,$dst_port),$ProtocolNames,$TransportNames);

    my $socket_key = sprintf("%s___%s_%s->%s_%s",$protocol_name,$ip_srcASCII,$src_port,$ip_dstASCII,$dst_port); 


    if (my $file_path = CreateFileHandle($socket_key,$filehandle_hash)) {
 
	push @$filename_array,$file_path;

    }

    my $filehandle = $filehandle_hash->{$socket_key};

    print $filehandle $sessions->{$ip_src};

    1;
}

# various link diagram (ViZ,Paj) output routines

sub GenerateLinkDiagram {
    
    my $data_ref = shift;
    
    my $sessions = @$data_ref[0];
    my $ProtocolNames = @$data_ref[1];
    my $TransportNames = @$data_ref[2];
    my %IP_Index = ();
    my %link_hash = ();

    my $CurrentNodeNumber = 1;
    my $LF = "\\n";

    my $KEYSTRING_TEMPLATE = "\"%s\" -> \"%s\""; 

    # Iterate through protocols involving transmission of various port-aware application traffic over TCP/UDP

    my @ApplicationProtocols = ($TCP,$UDP);

    DiagramApplicationTraffic($sessions,\@ApplicationProtocols,$ProtocolNames,$TransportNames,\%link_hash,$KEYSTRING_TEMPLATE,\%IP_Index,\$CurrentNodeNumber,$LF);

    # Iterate through protocols involving transmission of various message types/opcodes (ICMP,IGMP,ARP,etc)

    my @MessageProtocols = ($ICMP,$IGMP,$ARP);

    DiagramMessageTraffic($sessions,\@MessageProtocols,$ProtocolNames,$TransportNames,\%link_hash,$KEYSTRING_TEMPLATE,\%IP_Index,\$CurrentNodeNumber,$LF);

    # output file of appropriate type

    if ($FLAG{paj}) {
	
	OutputPajFile(\%IP_Index,\%link_hash,\$CurrentNodeNumber,$LF);
    } 

    elsif ($FLAG{viz}) { 

	OutputVizFile(\%IP_Index,\%link_hash,$LF);
    } 

    1;
}


sub DiagramApplicationTraffic {
   
    (my $sessions,         
    my $protocols,         
    my $ProtocolNames,     
    my $TransportNames,    
    my $link_hash,         
    my $TEMPLATE,          
    my $IPindex,           
    my $CurrentNodeNumber,
    my $LF) = @_;

    my $LOOPBACK = "127.0.0.1";
    my $src_node,my $dst_node;

    foreach my $transport_layer (@$protocols) {
                     
       my $DST_PORTS_HASHref = $sessions->{$transport_layer};          

       my $DST_PORTS_HASHref = $sessions->{$transport_layer};          

       for (keys %$DST_PORTS_HASHref) {

	   my $dst_port = $_;       
	   my $DST_IP_HASHref = $DST_PORTS_HASHref->{$dst_port};

	   for (keys %$DST_IP_HASHref) {

	    my $dst_ip = $_;
	    my $SRC_PORT_HASHref = $DST_IP_HASHref->{$dst_ip};
	    
	    for (keys %$SRC_PORT_HASHref) {
		    
		my $src_port = $_;
		my $SRC_IP_HASHref = $SRC_PORT_HASHref->{$src_port};

		for (keys %$SRC_IP_HASHref) {

		       my $src_ip = $_;

		       my $type;

		       ($src_ip,$dst_ip) = IndexIPs($src_ip,$dst_ip,$IPindex,$CurrentNodeNumber);
		       
 # if the communication is on the local interface i.e. 127.0.0.1 <-> 127.0.0.1, then the links are discriminated by 127.0.0.1:PortA -> 127.0.0.1:PortB.  No point labeling links since the port information is included in the node label.
		       
		       if ($src_ip eq $LOOPBACK && $dst_ip eq $LOOPBACK) {
			   
			   (my $src_type,my $dst_type) = map(ReturnTypeName($transport_layer,$_,$ProtocolNames,$TransportNames),($src_port,$dst_port));

			   $src_node = sprintf("$LOOPBACK:%s",$src_type);
			   $dst_node = sprintf("$LOOPBACK:%s",$dst_type);
			   $type = "LOCAL";

		       }

		       else {

			  $src_node = $src_ip;
			  $dst_node = $dst_ip;

			  my $IdentifyingPort = $FLAG{nomin} ? 
                                                $src_port : 
                                                Min($src_port,$dst_port);     		    

			  $type = ReturnTypeName($transport_layer,
						    $IdentifyingPort,
                                                    $ProtocolNames,
		         			    $TransportNames);  

		       }


		       my $key_string = sprintf($TEMPLATE,$src_node,$dst_node);
	       
		       AddLink($type,$link_hash,$key_string,$LF);
		}
	    }
		    
	    }
	}
    }

}

sub DiagramMessageTraffic {     # diagram network activity involving message protocols ex ICMP,IGMP,ARP

    (my $session,         
    my $protocols,         
    my $ProtocolNames,     
    my $TransportNames,    
    my $link_hash,         
    my $TEMPLATE,          
    my $IPindex,           
    my $CurrentNodeNumber,
    my $LF) = @_;

    foreach my $protocol (@$protocols) {
	my $src_ips = $session->{$protocol};
	
        for (keys %$src_ips) {
	    my $src_ip = $_;
	    my $dst_ips = $src_ips->{$src_ip};

	    for (keys %$dst_ips) {
		 LogAllTypes($protocol,$dst_ips,$src_ip,$_,$IPindex,$CurrentNodeNumber,$TEMPLATE,$ProtocolNames,$TransportNames,$link_hash,$LF);
	    }
	}
    }
}

sub IndexIPs {   

   (my $src,
    my $dst,
    my $index,
    my $count) = @_;

    $src = ipman::IPaddrDec_To_ASCII($src);
    $dst = ipman::IPaddrDec_To_ASCII($dst);

    if (!$index->{$src}) {
	$index->{$src} = $$count;

	$$count++;
    }



    if (!$index->{$dst}) {
	$index->{$dst} = $$count;
	$$count++;

    }



    return ($src,$dst);

}

sub ReturnNodeLine {
    
   (my $current_string,
    my $ip_ascii,
    my $index,
    my $template) = @_;

    my $node_string = sprintf($$template,$index->{$ip_ascii},$ip_ascii);

    if ($$current_string =~ /$node_string/) {return '';}

    return $node_string;

}

sub RecordSubnets {

   (my $Buffer,
    my $IP_Index,
    my $TEMPLATE,
    my $mask, 
    my $ViZ) = @_;

    my %mask_hash;

    for (keys %$IP_Index) {
	    
	my $binIP = ipman::IPaddrASCII_To_Bin($_);

	my $maskedIP = ipman::Masked($binIP,$mask);
        $maskedIP = ipman::IPaddrDec_To_ASCII($maskedIP);

	if (!$mask_hash{$maskedIP}) {
		
	    push my @maskedIPs,$_;
	    $mask_hash{$maskedIP} = \@maskedIPs;

	} else {
		
	    push @{$mask_hash{$maskedIP}},$_;

	}

    }

    for (keys %mask_hash) {

	my $subnetMembers = $mask_hash{$_};
	    
	    
	while (my $member = shift @$subnetMembers) {
		
	    foreach my $remaining_member (@$subnetMembers) {
		    
		if (!$ViZ) {$$Buffer .= sprintf($$TEMPLATE,$IP_Index->{$member},$IP_Index->{$remaining_member});}
		else {$$Buffer .= sprintf($$TEMPLATE,$member,$remaining_member);}		    
	    }
		
        }
	    

    }
}


sub ReturnTypeName {

   (my $prot_type,              # numeric code for TCP/ICMP/UDP/etc
    my $type_val,               # port value (HTTP/DNS) / message type value (ICMP/IGMP)
    my $net_prot_ref,           # hash for specific protocol labels ex "DNS","ICMP-ECHO",etc
    my $transp_prot_ref) = @_;  # hash for general protocol labels ex "TCP" "UDP" etc
    
    if (my $type_name = $net_prot_ref->{$prot_type}->{$type_val}) {       # HTTP
	return $type_name;
    } 

    else {
	return sprintf("%s_%d",$transp_prot_ref->{$prot_type},$type_val); # UDP_1130
    }

}
sub AddLink {

   (my $new_member,
    my $hashref,
    my $key,
    my $separator) = @_;

    if ($hashref->{$key} !~ $new_member) {
	
	$hashref->{$key} .= $separator.$new_member;

    }
}


sub LogAllTypes {

   (my $current_prot,
    my $hashref,
    my $src,
    my $dst,
    my $IPindex,
    my $current_num,
    my $key_template,
    my $ProtocolNames,
    my $TransportNames,
    my $link_hash,
    my $LF) = @_;

    my $typelist = $hashref->{$dst};

    (my $src_ip,my $dst_ip) = IndexIPs($src,$dst,$IPindex,$current_num);
    my $key_string = sprintf($key_template,$src_ip,$dst_ip);

    foreach my $type (@$typelist) {
	
	$type = ReturnTypeName($current_prot,$type,$ProtocolNames,$TransportNames);
	AddLink($type,$link_hash,$key_string,$LF);
	
    }
}

sub OutputVizFile {        # Wrap together the .dot file

    (my $IP_Index,
    my $link_hash,
    my $LF) = @_;

    my $DOT_file_contents = "strict digraph Net { \n ";

    my $VIZ_LINK_TEMPLATE = "\t\t%s [dir=\"directed\" label=\"%s\" fontsize=\"9\"];\n";
    my $SUBNET_LINK_TEMPLATE = "\t\t\"%s\" -> \"%s\" [dir=\"none\" fontsize=\"9\" style=\"dotted\"];\n";

    
    my $tmp_file_name = "Tmp.gv";
    
    my $SysCom = myIO::ReadConf("System_Commands");

    my $ViZcommand = sprintf($SysCom->{Viz},$tmp_file_name); 

    my $SubnetBuffer = '';

    for (keys %$link_hash) {
	$DOT_file_contents .= sprintf("\t\t%s [dir=\"directed\" label=\"%s\" fontsize=\"9\"];\n",$_,$link_hash->{$_});
    }

    if (my $mask = $FLAG{subnet}) {
	RecordSubnets(\$SubnetBuffer,$IP_Index,\$SUBNET_LINK_TEMPLATE,$mask,"VIZ");
    }
    
    $DOT_file_contents .= $SubnetBuffer."\n}";

    open DOT,">",$tmp_file_name or die "cannot open!\n";

    print DOT $DOT_file_contents;

    close DOT;
	    
    exec($ViZcommand);

}

sub OutputPajFile {     # rip the .net file

   (my $IP_Index,
    my $link_hash,
    my $CurrentNodeNumber,
    my $LF) = @_;

    my $PAJ_FILE_TEMPLATE = "*Vertices %d\n%s*Arcs\n%s%s";

    my $PAJ_VERTEX_TEMPLATE = "%d \"%s\" 0.0 0.0 0.0\n";
    my $PAJ_ARC_TEMPLATE = "%d %d 1 l \"%s\"\n";
    my $PAJ_EDGE_TEMPLATE = "%d %d -1 1 c Red \"SUBNET\"\n";
    my $ArcBuffer = '';
    my $VertexBuffer = '';
    my $EdgeBuffer = '';

    # first do subnet analysis if called for

    if (my $mask = $FLAG{subnet}) {

	RecordSubnets(\$EdgeBuffer,$IP_Index,\$PAJ_EDGE_TEMPLATE,$mask);
	$EdgeBuffer = "*Edges\n".$EdgeBuffer;
    }
    

    # fill in vertices)

    for (keys %$IP_Index) {
	
	$VertexBuffer .= sprintf($PAJ_VERTEX_TEMPLATE,$IP_Index->{$_},$_);
	
    }

    # arcs

    for (keys %$link_hash) {
      
	(my $src,my $dst) = $_ =~ /\"(.*?)\" -> \"(.*?)\"/;

	my $srcIPindexed = $IP_Index->{$src};
	my $dstIPindexed = $IP_Index->{$dst};

	$link_hash->{$_} =~ s/^$LF//;

	$ArcBuffer .= sprintf($PAJ_ARC_TEMPLATE,$srcIPindexed,$dstIPindexed,$link_hash->{$_});

    }

    my $PAJ_file_contents = sprintf($PAJ_FILE_TEMPLATE,$$CurrentNodeNumber-1,$VertexBuffer,$ArcBuffer,$EdgeBuffer);

    open TEMP_PAJ,">","Tmp.net";

    print TEMP_PAJ $PAJ_file_contents;

    close TEMP_PAJ;

    return 1;

}

sub CarveOutFiles {

    my $name_list = shift;   
    my $filetype;

    my $command = "xtract \"%s\" %s";

    unless ($filetype = $FLAG{carve}) {return 1;}

    foreach my $file (@$name_list) {
	print "\nexamining $file:\n---------\n";
	system(sprintf($command,$file,$filetype));
    }

}

# minor helper routines

sub CreateFileHandle {
    
    my $fname = shift;
    my $fhandle_hashref = shift;
    my $long_filename = shift;

    my $dumpfile_suffix = ".dump";

    unless (! $fhandle_hashref->{$fname}) {return;}          # do nothing if the handle already exists

    my $complete_path = $dump_path.$fname.$dumpfile_suffix;

    open my $filehandle,">>","$complete_path";
    printf "generated %s\n",$complete_path;

    $fhandle_hashref->{$fname} = $filehandle;

    return $complete_path;	
}

# port, protocol filters

sub PortsAllowed {
    
   (my $port1,
    my $port2) = @_;
    
    if (my $ports_ref = $FLAG{onlyport}) {

	
	if (AnyPortsEqual($ports_ref,$port1,$port2)) {return 1;}

	return 0;

    } elsif (my $ports_ref = $FLAG{noport}) {

	if (NoPortsEqual($ports_ref,$port1,$port2)) {return 1;}

	return 0;
	
    } else {

	return 1;

    }
}

sub AnyPortsEqual {   # test whether $p1 / $p2 match at least one of the ports in
                      # portref
   (my $onlyports,
    my $p1,
    my $p2) = @_;
    
    foreach my $port (@$onlyports) {
	
	if ($p1 ne $port && $p2 ne $port) {next;}

	return 1;           # return true if p1/p2 has matched a port
    }
    
    return 0;               # otherwise none of the ports match

}

sub NoPortsEqual {

   (my $noports_ref,
    my $p1,
    my $p2) = @_;

    foreach my $port (@$noports_ref) {
	
	if ($p1 eq $port || $p2 eq $port) {return 0;}
	
    }

    return 1;

}

sub ProtocolsAllowed {
    
   (my $current_protocol,
    my $prot_index) = @_;

    if (my $input_prots = $FLAG{onlyprot}) {
	
	return AnyProtsEqual($input_prots,$current_protocol,$prot_index);

    } 

    elsif (my $input_prots = $FLAG{noprot}) {
	
	return NoProtsEqual($input_prots,$current_protocol,$prot_index);

    }

    return 1;

}

sub AnyProtsEqual {
    
   (my $only_prots,
    my $current_prot,
    my $prot_idx) = @_;

    foreach my $input_prot_name (@$only_prots) {

	if ($prot_idx->{$current_prot} eq $input_prot_name) {return 1;}

    }
    return 0;

}

sub NoProtsEqual {

   (my $no_prots,
    my $current_prot,
    my $prot_idx) = @_;
    
    foreach my $input_prot_name (@$no_prots) {
	
	if ($prot_idx->{$current_prot} eq $input_prot_name) {return 0;}

    }

    return 1;
    
}

# IP filtering

sub IPsAllowed {
    (my $src,
     my $dst) = @_;

    
    if (my $input_IPs = $FLAG{onlyIP}) {
	return AnyIPsEqual($input_IPs,$src,$dst);
    }

    elsif (my $input_IPs = $FLAG{noIP}) {
	
	return NoIPsEqual($input_IPs,$src,$dst);
    }

    return 1;
}

sub AnyIPsEqual {
    
    (my $inputs,
     my $src,
     my $dst) = @_;
    
    my $IP_regex =  qr/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/;
    my $CIDR_regex = qr/$IP_regex\/\d{1,2}/;

    foreach my $input_IP (@$inputs) {

	# cidr-notation.  restrict traffic to a subnet, so require that
	# $src and $dst both fall wihtin this subnet

	if ((my $ip,my $mask) = $input_IP =~ /($IP_regex)\/(\d{1,2})/) { 

	    my $NetIP = ipman::IPaddrASCII_To_Dec($ip);
	    my $MaskVal = ipman::CIDR_Mask($mask);
	    my $NetIPmasked = $NetIP & $MaskVal;

	    if (($src & $MaskVal) eq ($NetIPmasked) &&
		($dst & $MaskVal) eq ($NetIPmasked)) 
	    {
		return 1;
	    }

	    else {
		return 0;
	    }

	}

	else { # comparing single IP address inputted in ASCII

	    my $input_IP_Dec = binman::Packed(ipman::IPaddrASCII_To_Bin($input_IP));

	    if ($src eq $input_IP_Dec || $dst eq $input_IP_Dec) {

		return 1;

	    }       
	    
	}
    }
    
    return 0;
    
}

sub NoIPsEqual {

    (my $inputs,
     my $src,
     my $dst) = @_;

    my $IP_regex =  qr/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/;
    my $CIDR_regex = qr/$IP_regex\/\d{1,2}/;

    foreach my $input_IP (@$inputs) {

	# cidr-notation.  if either src or dst fall w/in a subnet eliminate

	if ((my $ip,my $mask) = $input_IP =~ /($IP_regex)\/(\d{1,2})/) { 

	    my $NetIP = ipman::IPaddrASCII_To_Dec($ip);
	    my $MaskVal = ipman::CIDR_Mask($mask);
	    my $NetIPmasked = $NetIP & $MaskVal;

	    if (($src & $MaskVal) eq ($NetIPmasked) ||
		($dst & $MaskVal) eq ($NetIPmasked)) 
	    {
		return 0;
	    }

	    else {

		return 1;

	    }

	}
	
	else {

	    my $input_IP_Dec = binman::Packed(ipman::IPaddrASCII_To_Bin($input_IP));

	    if ($src eq $input_IP_Dec || $dst eq $input_IP_Dec) {
		return 0;
	    }       
	    
	}
    }

    return 1;    
}

# miscellaneous

sub CloseAllFiles {
    
    my $fhandle_hashref = shift;

    for (keys %$fhandle_hashref) {
	close $fhandle_hashref->{$_};
    }

}

sub Min {

   (my $a,
    my $b) = @_;
   
   if ($a < $b && $a > 0) {return $a;}

    return $b;
}

sub Max {

   (my $a,
    my $b) = @_;
 
   if ($a > $b) {return $a;}
    
    return $b;
}

sub MakeDir {

    my $path = shift;
    my $handle;

    my $SysCom = myIO::ReadConf("System_Commands");

    my $MkDirCommand = sprintf($SysCom->{MakeDir},$path);
 
    if (!opendir($handle,$path)) {system($MkDirCommand);}

    close $handle;

}


# set flags

sub Set_Viz_Flag {
    $FLAG{viz} = 1;
}


sub Set_Paj_Flag {
    $FLAG{paj} = 1;
}

sub Set_NoPort_Flag {

    my $data_ref = shift;
    my $argument_array_ref = shift;
    
    $FLAG{noport} = $argument_array_ref;

}

sub Set_OnlyPort_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{onlyport} = $argument_array_ref;

}

sub Set_OnlyProt_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;
    
    $FLAG{onlyprot} = $argument_array_ref;
}

sub Set_NoProt_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{noprot} = $argument_array_ref;    
    
}


sub Set_OnlyIP_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;
    $FLAG{onlyIP} = $argument_array_ref;

}

sub Set_NoIP_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{noIP} = $argument_array_ref;
}

sub Set_Concat_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{concat} = $argument_array_ref;

}

sub Set_Separated_Flag {
    $FLAG{separated} = 1;
}

sub Set_Output_Directory {
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{dir} = @$argument_array_ref[0];

}

sub Set_Carve_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{carve} = @$argument_array_ref[0];

}

sub Set_Subnet_Flag {

    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{subnet} = @$argument_array_ref[0];

}

sub Set_NoMin_Flag {
    
    $FLAG{nomin} = 1;

}
