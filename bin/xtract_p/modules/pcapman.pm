# module for parsing frames out of pcap files
# as the format is defined at http://wiki.wireshark.org/Development/LibpcapFileForamt

package pcapman;

use strict;
use extendedPCAP;

use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

@EXPORT = qw(PCAP_IP_Extract);
$version = '0.01';

use ipman qw(IP_ASCII);

# state variables

my %FLAG = (
    
    "EXTRACT_IP" => 0,

    );

# reference variables

my %NETWORK_PROTOCOL =(
    
    "08" => "IP",
    
    );

my %TRANSPORT_PROTOCOL = (
    
    "06" => "TCP",
    "11" => "UDP",

    );

# globals


sub Parse_Frames {
    my $source_data_array_ref = shift;                     # in from a scalar pointer
    my @frame_bucket = ();                                 # out to an array containing each parsed frame

    my $count = 1;

    Identify_PCAP_File_Format($source_data_array_ref);

    while (length($$source_data_array_ref) > 0) {
    
	my $pcap_frame_preamble = PCAP_Frame_Preamble($source_data_array_ref);

	my $pcap_frame_length = PCAP_Frame_Size($pcap_frame_preamble);

	my $frame_contents = PCAP_Frame_Contents($source_data_array_ref,$pcap_frame_length);
	
	push @frame_bucket,$frame_contents;

    }   
 
    return \@frame_bucket;

}



sub Identify_PCAP_File_Format {             # check whether header has the magic bytes for .pcap

    my $pcap_file_data = shift;

    use bytes;

    (my $pcap_file_header) = $$pcap_file_data =~ /(^.{24})/s;             # first 24 bytes of PCAP file

    (my $magic_bytes) = $pcap_file_header =~ /(^.{4})/s;

    my $magic_ascii = unpack("H32",$magic_bytes);

    if ($magic_ascii =~ /d4c3b2a1/) {          # classic pcap file format

	$$pcap_file_data =~ s/^.{24}//s;       

    } 

    elsif ($magic_ascii =~ /0a0d0d0a/) { # extended pcap file format simple header block identifier

	extendedPCAP::Parse($pcap_file_data);    # pass to another module to handle extended "next gen" pcap format

    }

    else {

	die "uncecognized pcap file format\n";

    }

}

sub PCAP_Frame_Preamble {                   # parse metadata preceding each frame, grabbing length of frame
    my $pcap_file_data = shift;

    use bytes;
    
    (my $pcap_packet_preamble) = $$pcap_file_data =~ /(^.{16})/s;          # 16 bytes of packet metadata used by PCAP file precede each actual packet data
    
    $$pcap_file_data =~ s/^.{16}//s;

    return $pcap_packet_preamble;
}

sub PCAP_Frame_Size {                          # return  size of proceeding packet from preamble information
    my $preamble = shift;

    use bytes;

    (my $packet_size) = $preamble =~ /(.{4}).{4}$/s; # the actual # of packets saved to file

    my $packet_size = unpack("H8",$packet_size);
 
    return unpack ("I",pack("H8",$packet_size));    
}

sub PCAP_Frame_Contents {
    my $pcap_file_data = shift;
    my $length = shift;

    my $frame_block = qr/(^.{$length})/s;

    use bytes;

    (my $pcap_frame_contents) = $$pcap_file_data =~ /$frame_block/;

    $$pcap_file_data =~ s/$frame_block//s;

    return $pcap_frame_contents;
}

