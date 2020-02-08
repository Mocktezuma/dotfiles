# module for handling ethernet frames / datagrams
# once frames have been parsed out of parent file

package etherman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

@EXPORT = qw(PCAP_IP_Extract);
$version = '0.01';

# reference variables

my %NETWORK_PROTOCOL =(
    
    "08" => "IP",
    
    );

my %TRANSPORT_PROTOCOL = (
    
    "06" => "TCP",
    "11" => "UDP",

    );

# link layer (Ethernet frames)

sub Parse_Frame_Contents {
    my $frame_data_ref = shift;

    use bytes;

    (my $net_prot,
     my $total_len,      
     my $ident,
     my $flags,
     my $ttl_val,
     my $transp_prot,
     my $src_ip,
     my $dest_ip,
     my $datagram) = $$frame_data_ref =~ 

               /^

               .{12}         # skip first 12 bytes of frame, containing src and dest MAC addrs


               (.{2})        # capture next 2 bytes containing the Network Layer Protocol (IP,ICMP,etc)

               .{1}          # skip next byte containing version information         

               .{1}          # skip next byte containing diff services field

               (.{2})        # capture next 2 bytes containing total length

               (.{2})        # capture next 2 bytes containing identification

               (.{2})        # capture next 2 bytes containing flags (first byte) and fragment offset (second byte)

               (.{1})        # capture next byte containing TTL

               (.{1})        # capture next byte containing the Transport Layer Protocol (TCP,UDP,etc)

               .{2}          # skip 2 bytes containing checksum
       
               (.{4})        # capture next 4 bytes containing SRC ip address

               (.{4})        # capture next 4 bytes containing DEST ip address

               (.*?$)        # pass the rest of the frame contents back for datagram analysis

              /sx;          

    return ($net_prot,$transp_prot,$src_ip,$dest_ip,$datagram);

}

sub Parse_Frame_IPs {
    my $frame_bucket = shift;
    my $ip_bucket = shift;

    use bytes;

    foreach my $frame (@$frame_bucket) {

	(my $src_ip,my $dest_ip) = $frame =~ /^.{26}(.{4})(.{4})/s;       
	
	my @pair = ($src_ip,$dest_ip);

	push @$ip_bucket,\@pair;
    }

}

# transport layer (TCP/UDP datagrams etc)

sub Parse_UDP_Datagram {
    
}

sub Parse_TCP_Datagram {
    
}

