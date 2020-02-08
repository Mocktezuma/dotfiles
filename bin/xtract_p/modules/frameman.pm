# module for handling frames / datagrams
# once frames have been parsed out of parent file

package frameman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

@EXPORT = qw(PCAP_IP_Extract);
$version = '0.01';

# globals

my $FLAGS          = 0xE000;
my $FRAGMENT_OFFSET = 0x1FFF;

my $IP_HEADER_LENGTH = 0xF;

my $DONT_FRAG = 0x4000;
my $MORE_FRAG = 0x2000;

my $IP = 2048;
my $ARP = 2054;

# link layer (Ethernet frames)

sub Parse_Datagrams {

    my $frame_bucket = shift;
    my @defragged_datagrams = ();

    my %fragged = ();
    my %frag_state_table = ();

    my $count = 1; 

    use bytes;
    
    foreach my $frame (@$frame_bucket) {
	my %frame_data;

	if (Protocol(\$frame) eq $IP) {

	    %frame_data = ParseIP_Data(\$frame);

	} elsif (Protocol(\$frame) eq $ARP) {

	    %frame_data = ParseARP_Data(\$frame);
	    
	}

	# Don't Fragment bit set -> datagram cannot be fragmented

        if ($frame_data{net_prot} eq $IP) {
	    if ($frame_data{flags} & $DONT_FRAG) {

		push @defragged_datagrams,\%frame_data;
		next;
	         
	    } else {
		
		my $fragged_pointer = Log_Fragged_Datagram(\%fragged,\%frame_data,\%frag_state_table);
	        push @defragged_datagrams,$fragged_pointer;
		next;
	    }

	}

	# datagram not IP -> defragmentation not a concern


	elsif ($frame_data{net_prot} > 0) {

	    push @defragged_datagrams,\%frame_data;
	    next;

	} 

    }



    DeFragment(\@defragged_datagrams,\%frag_state_table);

    return \@defragged_datagrams;
}


 
# defragmentation routines

# Use the following hash tree to organize IP fragments: 
#                
# KEY 1:                                SRC IP
#                                      /   /  \
#                                     /        \
# KEY 2:                             ...     DST IP
#                                             /  \
#                                            /
# KEY 3:                                  PROTOCOL
#                                         /  \
#                                             \
# KEY 4:                                      IDENT #
#                                              / \
#                                             /   \
# KEY 5:                                  FRAG1...FRAGX
#

# 1. Fill hash tree, logging in state table at same time (Log_Fragged_Datagram)
#
# 2. @defragged datagrams contains either datagrams that are not fragmented, or pointers to the correct IDENT # 
#    for the datagram segments which need to be reassambled by DeFragment()
#
# 3. DeFragment takes this pointer, sorts the first level keys (which will be the fragment offset #s) from 0 to whatever,
#    concatenates the payload.
#
# 4. The concatenated payload is logged in the datagram with frag offset 0.  The pointer originally for the IDENT # 
#    level of the hash is reset to point to the actual datagram.  Using state infromation all other pointers to frags
#    belonging to the same identification number are nullified



sub Log_Fragged_Datagram {
    
    my $frag = shift;
    my $d = shift;
    my $state = shift;

    # add a pointer to the fragged datagram contents to the hash, keyed by SRC IP->DST IP->PROTOCOL->IDENTIFICATION #

    my $src_ip = $d->{src_ip};
    my $dst_ip = $d->{dst_ip};
    my $net_prot = $d->{net_prot};
    my $ident = $d->{ident};
    my $offset = $d->{frag_offset};


    $frag -> {$src_ip} -> {$dst_ip} -> {$net_prot} -> {$ident} -> {$offset} = $d;

    # return a pointer to the parent node (i.e. the IDENT # in question)

    return $frag -> {$src_ip} -> {$dst_ip} -> {$net_prot} -> {$ident};

}

sub DeFragment {
    
    my $datagrams = shift;
    my $state = shift;
    my $protocol;

    foreach my $possibly_fragged (@$datagrams) {
	

	# skip any datagrams with DONT FRAG bit set or which are not IP}

        # flag value set in possibly_fragged meaning its IP, if DONT_FLAG bit is set, skip

	if ($possibly_fragged -> {flags} & $DONT_FRAG) {          
	    
	    next;

	} 

        # possibly_fragged has 0-value net_prot meaning it's a null pointer, hasn't been processed

        elsif (!$possibly_fragged->{net_prot} && !Processed($possibly_fragged->{0},$state)) {        

	    my $payload;
	    
	    foreach my $frag_offset (sort keys %$possibly_fragged) {   
		
	      $payload .= $possibly_fragged->{$frag_offset}->{payload};

	      if ($frag_offset) {         # null out any datagram w/ non-zero frag offset

		  $possibly_fragged->{$frag_offset} = '';

	      }
       
	    }

	    $possibly_fragged->{0}->{payload} = $payload;              
      	    $possibly_fragged = $possibly_fragged->{0};  

	    RecordAsProcessed($possibly_fragged,$state);
	} 

	# net_prot has a value but it ain't IP, don't worry about it 

        elsif ($possibly_fragged->{net_prot} ne $IP) {

	    next;

	} 

    }
}
 

sub RecordAsProcessed {
    my $d = shift;
    my $state = shift;

    $state -> {$d->{src_ip}} -> {$d->{dst_ip}} -> {$d->{net_prot}} -> {$d->{ident}} = 1;    

}

sub Processed {
    my $d = shift;
    my $state = shift;
    
    return $state -> {$d->{src_ip}} -> {$d->{dst_ip}} -> {$d->{net_prot}} -> {$d->{ident}};

}

# Ethernet datagram, IP/ARP parsers

sub Protocol {
    
    my $frame = shift;


    use bytes;

     # deal with null loopback format used on BSD systems (http://wiki.wireshark.org/NullLoopback.

    if ($$frame =~ /^\x02\x00\x00\x00\x45/) {

	#crude fix to make the regex parser work

	$$frame =~ s/^\x02\x00\x00/^\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x99\x08/;

	return $IP;
    }

    else {
	(my $prot) = $$frame =~ /^.{12}(.{2})/s; #otherwise normal frame with 2 6-byte MACs that are ignored
	return binman::Packed($prot);

    }	


}

sub ParseIP_Data {
    
    my $frameref = shift;
    my $version_header;

    use bytes;

    ($version_header) = $$frameref =~ /^.{14}(.{1})/s;         
	 
    my $total_length = (binman::Packed($version_header) & $IP_HEADER_LENGTH) * 4;  # header length in units of words

    my $options_length = $total_length-20;          # calculate length of any optoins fields

         (my $net_prot,
	 my $ident,
	 my $flags_fragOffset,
	 my $ttl_val,
	 my $transp_prot,
	 my $src_ip,
	 my $dst_ip,
	 my $app_data) = $$frameref =~ 

               /^

               .{12}         # skip first 12 bytes of frame, containing src and dest MAC addrs


               (.{2})        # capture next 2 bytes containing the Network Layer Protocol (IP,ARP,etc)

               .{1}          # skip next byte containing version information         

               .{1}          # skip next byte containing diff services field

               .{2}          # skip next 2 bytes containing total length

               (.{2})        # capture next 2 bytes containing identification

               (.{2})        # capture next 2 bytes containing flags (hi three bits) and fragment offset (low 13 bits)

               (.{1})        # capture next byte containing TTL

               (.{1})        # capture next byte containing the Transport Layer Protocol (TCP,UDP,etc)

               .{2}          # skip 2 bytes containing checksum
       
               (.{4})        # capture next 4 bytes containing SRC ip address

               (.{4})        # capture next 4 bytes containing DEST ip address

               .{$options_length}   # skip however-many bytes of optional data

               (.*?$)        # pass the rest of the frame contents back for datagram analysis

              /sx;          

    return (
	
	    "flags" => binman::Packed($flags_fragOffset) & $FLAGS,
	    "frag_offset" => binman::Packed($flags_fragOffset) & $FRAGMENT_OFFSET,
	    "ident" => binman::Packed($ident),

	    "net_prot" => binman::Packed($net_prot),
	    "transp_prot" => binman::Packed($transp_prot),
	    "src_ip" => binman::Packed($src_ip),
	    "dst_ip" => binman::Packed($dst_ip),
	    "payload" => $app_data,


	);

}

sub ParseARP_Data {
    
    my $frameref = shift;

    use bytes;

    (
      my $net_prot,
      my $opcode,
      my $src_ip,
      my $dst_ip,

      ) = $$frameref =~ /                   

                                    ^.{12}      # same as for IP 
                                    (.{2})

                                     .{2}       # skip 2 bytes for hardware type

                                     .{2}       # skip 2 bytes for protocol type (ex IP)
 
                                     .{2}       # skip 2 bytes for hardware,protocol sizes
 
                                     (.{2})     # capture 2 bytes for opcode

                                     .{6}       # skip 6 bytes for sender MAC address

                                     (.{4})     # capture 4 bytes for sender IP address      

                                     .{6}       # skip 6 btes for target MAC address

                                     (.{4})     # capture 4 bytes for target IP address

                                  /sx;

    return (

	"src"  => binman::Packed($src_ip),
	"dst"  => binman::Packed($dst_ip),
	"net_prot" => binman::Packed($net_prot),
	"type"   => binman::Packed($opcode),
	
	);
}

# miscellaneous

sub Parse_Ethernet_Frame_IPs {
    my $frame_bucket = shift;
    my $ip_bucket = shift;

    use bytes;

    foreach my $frame (@$frame_bucket) {

	(my $src_ip,my $dest_ip) = $frame =~ /^.{26}(.{4})(.{4})/s;       
	
	my @pair = ($src_ip,$dest_ip);

	push @$ip_bucket,\@pair;
    }

}

