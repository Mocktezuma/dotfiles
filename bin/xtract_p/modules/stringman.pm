package stringman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw(StringsIdentify StringsThreshold STRINGS_options STRINGS_help StringHelp);

$version = '0.01';

# additional shit for optional argument processing

use dataman "ParseOptions";

our $StringHelp = '"xtract [raw data file] STRINGS":'."\n".'extract ASCII strings from a raw data file';

our %STRINGS_help = (
    "-min" => '"xtract [file] STRINGS -min [number]": match a minimum of [number] ASCII chars',
    );


my %STRINGS_options = (
    "-min" => \&MinThreshold,
    "-max" => \&MaxThreshold,
    );


# hashes containing pointers to options for each function

sub StringsIdentify {
    my $data_array_ref = shift;
    my $additional_arguments = shift;
    
    my @options = @$additional_arguments;
   
    my @ReturnData = ();

    if ($#options  > 0) {                                                       # note that main function will never have a chance to 
	dataman::ParseOptions($data_array_ref,\%STRINGS_options,\@options,\@ReturnData);             # get at the data directly after this. So the option handler either calls 
    } else {                                                                 # the main function eventually (as StringsThreshold does) or does something 
	(@ReturnData) = ${@$data_array_ref[0]} =~ /([\w\s\:\!\/\\]+)/gs;        # completely different
    }

    return @ReturnData;
}

# optional argument handlers

sub MinThreshold {                                                        # impose threshold on minimum number of ASCII that constitute a "string"
    my $data_array_ref = shift;                                                     # scalar pointer to original data
    my $options_ref = shift;                                                  # array pointer to container of arguments


    my $thresh_value = shift @$options_ref;                                   # get the threshold value specified
   
    my @FilteredData = ();                                                    # array to store final data

    my @data = StringsIdentify($data_array_ref,$options_ref);                       # call main function StringsIdentify...

    foreach my $d (@data) {                                                   # ... and then massage returned data before sending it back to xtract
	if (length($d) >= $thresh_value) {
	    push (@FilteredData,$d);
	}
    }

    return @FilteredData;
}

sub MaxThreshold {                                                        # impose threshold on minimum number of ASCII that constitute a "string"
    my $data_array_ref = shift;                                                     # scalar pointer to original data
    my $options_ref = shift;                                                  # array pointer to container of arguments


    my $thresh_value = shift @$options_ref;                                   # get the threshold value specified

    my @FilteredData = ();                                                    # array to store final data

    my @data = StringsIdentify($data_array_ref,$options_ref);                       # call main function StringsIdentify...

    foreach my $d (@data) {                                                   # ... and then massage returned data before sending it back to xtract
	if (length($d) < $thresh_value) {
	    push (@FilteredData,$d);
	}
    }

    return @FilteredData;
}
