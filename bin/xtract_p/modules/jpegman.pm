package jpegman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw(JpgIdentify JpgHelp);

$version = '0.01';

# help string


sub Usage() {

    return sprintf <<END;

    xtract [file] JPG:
    ------------------
	Identify presence of jpeg files in raw data dump.

END


}

our $JpgHelp = Usage();

# signatures

my $JFIF_Begin = qr/\xff\xd8.{4}\x4a\x46\x49\x46/;
my $JFIF_End = qw/\xff\xd9/;

# routine

sub JpgIdentify {
    my $data_array_ref = shift;
    my $additional_arguments = shift;

    use bytes;

    # use fact that all JPGs begin with 0xFF 0xD8 and terminate with 0xFF 0xD9

    (my @ReturnData) = ${@$data_array_ref[0]} =~ /($JFIF_Begin.*?$JFIF_End)/gs;        # make sure to dereference the scalar pointer when handling $data_references!
    
    return \@ReturnData;
}
