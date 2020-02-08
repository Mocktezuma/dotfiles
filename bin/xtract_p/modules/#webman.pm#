package webman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw(JpgIdentify JpgHelp);

$version = '0.01';

# help string


sub Usage() {

    return sprintf <<END;

    xtract [file] HTML:
    -------------------
	Extracts web pages from [file]
END


}

our $WebHelp = Usage();

# signatures

my $HTML_Begin = qr/<html>/i;
my $HTML_End = qr/<\/html>/i;

# routine

sub WebExtract {
    my $data_array_ref = shift;
    my $additional_arguments = shift;

    (my @WebPages) = ${@$data_array_ref[0]} =~ /($HTML_Begin.*?$HTML_End)/gs;          
    return \@WebPages;
}
