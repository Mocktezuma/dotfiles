package zipman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw(ZipExtract ZIP_main_help ZIP_help);

$version = '0.01';

# imports

use binman qw(Packed);

# help string

sub Usage() {

    return sprintf <<END;
    xtract [file] ZIP -version:
    ---------------------------
	Isolate files compressed by some version of ZIP, eg \"-pkz\",\"gz\" etc
END


}

our $ZIP_main_help = Usage(); 

# globals

my %Processors = (
    "-pkz" => \&PKZipExtract,
    );

# a very generic wrapper. can be adapted for any filetype like ZIP for which there are multiple specifications

sub ZipExtract {               

    my $data_array_ref = shift;
    my $options = shift;
    
    my @ZIPs = ();
    my $processor;

    for (keys %Processors) {          # iterate through various processor for zip types

	my $processor = $Processors{$_};
	push @ZIPs,&$processor($data_array_ref); # &$processor should return a ref to array containing partic. results
	
    }

    @ZIPs = Flatten(\@ZIPs);

    return \@ZIPs;
    

}

# extraction functions

sub PKZipExtract {
    
    my $data_array_ref = shift;

    my @PKZs;

    use bytes;


    # PKunzip signatures

    my $PKZ_Begin = qr/\x50\x4b\x03\x04/;      # start of first file record
    my $PKZ_End = qr/\x50\x4b\x05\x06.{16}/;   # end of central directory field (not including comments)

   

    (my @PKZ_Payloads) = ${@$data_array_ref[0]} =~ 

                     /

                     ($PKZ_Begin .*? $PKZ_End # make sure to use minimal matching in these files!

                     .{2}                     # 2 bytes for the comment length

                     )/sgx;

    
    foreach my $payload (@PKZ_Payloads) {
	
	(my $comment_length) = $payload =~ /(.{2}$)/s; 

	if ($comment_length = binman::Packed($comment_length)) {     # nonzero comment length
	    
	    (my $comment) = ${@$data_array_ref[0]} =~ /$payload(.{$comment_length})/s; # tack on proper # of bytes
	    push @PKZs,$payload.$comment;
	    next;
	}   
	   
	push @PKZs,$payload;
    }
    
    return \@PKZs;

}

sub Flatten {      # Flatten expects a ref to an array containing arbitrary # of array refs, it will 
                   # return a flat array containing all elements of all referenced arrays :P

    my $array_bucket = shift;
    my @ReturnArray = ();

    foreach my $array_ref (@$array_bucket) {

	foreach my $element (@$array_ref) {
	    push @ReturnArray,$element;
	}

    }

    return @ReturnArray;

}
