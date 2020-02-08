package ipman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw(IProcess IP_help IPhelp);

$version = '0.01';

# explanation


sub Usage() {

    return sprintf <<END;

    xtract [file] IP
    ----------------
        Identify all IP addresses in a file
END
}

our $IPhelp = Usage();

our %IP_help = (
    "-pcap" => '-pcap: extract IP addresses from a .pcap file.',
    "-cidr" => '-cidr IPv4/xx": extract IP adddresses matching only those IPv4 addrs falling within a range defined according to CIDR notation.',
    );

# imports 

use pcapman qw(Parse_Frames);
use frameman qw(Parse_Frame_IPs);

use dataman qw(ParseOptions);
use myIO qw(CustomOutputFunction);

# globals

my %IP_options = (
    "-pcap" => \&Set_PCAP_Flag,
    "-cidr" => \&Set_CIDR_Flag,
    );

my %FLAG = (
    "pcap" => 0,
    "cidr" => 0,
    );

my %VALUE = (           
    "cidr" => -1,
    );

our $IP_regex =  qr/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/;
our $CIDR_regex = qr/$IP_regex\/\d{1,2}/;

my $full_mask = 0xffffffff;

# wrapper

sub IProcess {
    my $data_array_ref = shift;
    my $additional_arguments = shift;

    my @options = @$additional_arguments;

    my $IP_Parser_Func;
    my @ReturnData;


    # process, sanity-check any options

    if ($#options) {
	dataman::ParseOptions($data_array_ref,\%IP_options,\@options);
    }

    # set the correct parsing function

    if ($FLAG{pcap}) {                               

	$IP_Parser_Func = \&PCAP_IP_Extract;

    } else {

	$IP_Parser_Func = \&Simple_IP_Extract;
    }


    &$IP_Parser_Func($data_array_ref,\@ReturnData);

    # post-processing


    if ($IP_Parser_Func eq \&PCAP_IP_Extract && $FLAG{viz}) {             # output going to graphviz


	IPaddrArrayBin_To_ASCII(\@ReturnData);               
	return \@ReturnData;

    } elsif ($IP_Parser_Func eq \&PCAP_IP_Extract) {                         

        @ReturnData = FlattenArray(\@ReturnData);                            


    }

    if ($FLAG{cidr}) {  # kill any IP that doesn't match CIDR restriction

	@ReturnData = IsolateCIDR(\@ReturnData);                    

    } 


    @ReturnData = map(IPaddrBin_To_ASCII($_),@ReturnData);
    return \@ReturnData;

}

# extraction routines

sub Simple_IP_Extract {      

    my $in_data_ref = shift;                     
    my $out_data_ref = shift;                   
    
    (@$out_data_ref) = ${@$in_data_ref[0]} =~ /($IP_regex)/gs;
    
    @$out_data_ref = map(IPaddrASCII_To_Bin($_),@$out_data_ref);

}

sub PCAP_IP_Extract {
    
    my $in_data_ref = shift;
    my $out_data_ref = shift;

    my $frames = pcapman::Parse_Frames($in_data_ref);
    
    frameman::Parse_Ethernet_Frame_IPs($frames,$out_data_ref);
    
}


# dealing with CIDR-related stuff

sub IsolateCIDR {              # return only those IP addrs in a bucket falling with arbitrary CIDR mask

    my $ip_bucket_ref = shift;
    my @ReturnArray = ();
    
    (my $ascii_index_ip , my $maskval) = $VALUE{cidr} =~ /(^$IP_regex)\/(\d{1,2}$)/;

    my $bin_index_ip_masked = Masked(IPaddrASCII_To_Bin($ascii_index_ip),$maskval);                  
    
    foreach my $ip (@$ip_bucket_ref) {

	if ( Masked($ip,$maskval) eq $bin_index_ip_masked) {

	    push (@ReturnArray,$ip);
	}

    }
    
    return @ReturnArray;
}

sub Masked {                     # return IP address masked by netmask i.e. (IP address)/mask_val                     
    my $bin_ip_addr = shift;
    my $mask_val = shift;

    my $a =  hex(unpack("H8",$bin_ip_addr)) & CIDR_Mask($mask_val);

    return $a;
}

sub CIDR_Mask {                  # return netmask with proper # of 0s given $slash_val
    my $slash_val = shift;
    
    my $a= $full_mask - ($full_mask >> $slash_val);

    return $a;
}

# IP address formatting


sub IPaddrASCII_To_Bin {      # return packed binary version of ASCII IP address
    
    my $ascii_ip_addr = shift;
    my $bin_ip_addr;

    (my @octets) = split('\.',$ascii_ip_addr);

    foreach my $o (@octets) {
	$bin_ip_addr .= unpack("H2",pack("C",$o));
	
    }
    return pack("H8",$bin_ip_addr);
}

sub IPaddrASCII_To_Dec {
    
    my $ascii_ip_addr = shift;

    my $bin_ip_addr = IPaddrASCII_To_Bin($ascii_ip_addr);

    return binman::Packed($bin_ip_addr);
}

sub IPaddrBin_To_ASCII {      # return ASCII version of packed binary IP address
    
    my $bin_ip_addr = shift;
    $bin_ip_addr = binman::Packed($bin_ip_addr);
#hex(unpack("H8",$bin_ip_addr));


    my $first_oct   = ($bin_ip_addr & 0xff000000) >> 24;
    my $second_oct  = ($bin_ip_addr & 0x00ff0000) >> 16;
    my $third_oct   = ($bin_ip_addr & 0x0000ff00) >> 8;
    my $fourth_oct  =  $bin_ip_addr & 0x000000ff;
    
    return sprintf("%d.%d.%d.%d",$first_oct,$second_oct,$third_oct,$fourth_oct);
}


sub IPaddrDec_To_ASCII {      # return ASCII version of decimal IP address
    
    my $dec_ip_addr = shift;



    my $first_oct   = ($dec_ip_addr & 0xff000000) >> 24;
    my $second_oct  = ($dec_ip_addr & 0x00ff0000) >> 16;
    my $third_oct   = ($dec_ip_addr & 0x0000ff00) >> 8;
    my $fourth_oct  =  $dec_ip_addr & 0x000000ff;
    
    return sprintf("%d.%d.%d.%d",$first_oct,$second_oct,$third_oct,$fourth_oct);
}

sub IPaddrArrayBin_To_ASCII {
    
    my $array = shift;
    foreach my $array_ref (@$array) {

	@$array_ref[0] = IPaddrBin_To_ASCII(@$array_ref[0]);
	@$array_ref[1] = IPaddrBin_To_ASCII(@$array_ref[1]);
    }

}

sub FlattenArray {              
    my $src_array = shift;
    my @flat_array = ();
    

    while (my $sub_array = shift @$src_array) {
	push @flat_array,@$sub_array[0];
	push @flat_array,@$sub_array[1];
    }

    return @flat_array;
}

# flags


sub Set_PCAP_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{pcap} = 1;
}

sub Set_CIDR_Flag {
    my $data_ref = shift;
    my $argument_array_ref = shift;

    if (@$argument_array_ref[0] !~ /$CIDR_regex/) {
	die "incorrect CIDR notation\n";
    }

    $VALUE{cidr} = @$argument_array_ref[0];
    $FLAG{cidr} = 1;
    
}


sub Set_Viz_Flag {
    $FLAG{viz} = 1;
}
