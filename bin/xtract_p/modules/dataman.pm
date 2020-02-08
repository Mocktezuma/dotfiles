package dataman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

@EXPORT = qw();
$version = '0.01';

# modules for various processing functions

use jpegman qw(JpgIdentify);
use commonman qw(CommonsEntry);
use ipman qw(IProcess);
use regularman qw(RegExPull);
use sessionman qw(ExtractSessions);
use zipman qw(ZipExtract);
use allman qw(ExtractAll);
use exeman qw(ExeExtract);
use webman qw(WebExtract);
use xorman qw(ApplyXOR);

# hashes containing pointers to functions, options for each function

our %function_pointer = (

    "JPG" => \&jpegman::JpgIdentify,

    "COMMON" => \&commonman::CommonsEntry,

    "IP" => \&ipman::IProcess,

    "RGXP" => \&regularman::RegExPull,

    "SESSIONS" => \&sessionman::ExtractSessions,

    "ZIP" => \&zipman::ZipExtract,
    
    "ALL" => \&allman::ExtractAll,

    "HTML" => \&webman::WebExtract,

    "EXE" => \&exeman::ExeExtract,

    "XOR" => \&xorman::ApplyXOR,

    );

# Wrapper

sub IsolateContents {
    my $data_array_ref = shift;
    my $additional_arguments = shift;

    my $filetype = @$additional_arguments[0];                                 # isolate contents corresponding to this $filetype
    
    if (!$function_pointer{$filetype}) {die "unknown filetype $filetype\n"};

    &{$function_pointer{$filetype}}($data_array_ref,$additional_arguments);   # pass raw data, additional args to appropriate function pointer

}

# support subroutines (e.g. for parsing optional arguments)

sub ParseOptions {
# reference to input data so optoinal arg handlers can process if necessary

    my $data_array_ref = shift;                                                     

# the hash used to ID optional argument handler function

    my $option_pointer = shift;              

# an array (NOT reference) containing the additional arguments to parse

    my $additional_args = shift;                                              



    my $results_need_storage = shift;                                         


    my $potential_option_arg;

    while (my $option_flag = shift @$additional_args) {

	if ($option_pointer->{$option_flag}) {

	    my @option_arguments;
	
	    while (@$additional_args) {
		if (@$additional_args[0] =~ /^\-[^\-]/) {last;}                   # found another -flag so need to restart the loop
                                                                                  # however need to be able to include -- prefixes because they
                                                                                  # may show up as suboptions when used with -type (see commonman.pm)

		my $potential_option_arg = shift @$additional_args;
		push (@option_arguments,$potential_option_arg);

	    }

            if ($results_need_storage) {             # returning modified data

		@$results_need_storage = &{$option_pointer->{$option_flag}}($data_array_ref,\@option_arguments);

	    } else {                                 # going to act on the data w/o returning any final array

		&{$option_pointer->{$option_flag}}($data_array_ref,\@option_arguments);

	    }
	    
	} elsif ($option_flag =~ /^\-/) {            # something thatt looks like an option but not registered
	   die "unknown option $option_flag\n";
	}
       }   
}
 
