package allman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw();

$version = '0.01';

# imports

use dataman qw(function_pointer IsolateContents);
use myIO qw(ReturnOutput);

# help string

sub Usage() {

    return sprintf <<END;

    xtract [file] ALL:
    ------------------
	Isolate all known file types (with certain exceptions such as SESSIONS,COMMON,etc) from a given binary file.
END


}

our $ALL_main_help = Usage();

# globals

my %Not_This = (          # specify which functions do NOT get applied to the target file.  For example it doesn't make
                             # sense to include SESSIONS or COMMON in a run of xtract ALL.  
    "STRINGS" => 1,      # output is annoying
    "SESSIONS" => 1,
    "COMMON" => 1,
    "RGXP" => 1,
    "ALL" => 1,           # make sure this stays set to 1! otherwise you'll have a nasty infinite loop on your hands lol

    );

sub ExtractAll {
    
    my $data_array_ref = shift;
    my $options = shift;

    my @AllResults = ();
    
    my @Args = @$options;
    my $filename = $Args[$#Args];

    for (keys %dataman::function_pointer) {

	my $filetype = $_;

	unless ($Not_This{$filetype}) {
	    
	    my @arguments = ();
	    push @arguments,$filetype;

	    if (my $ReturnData = dataman::IsolateContents($data_array_ref,\@arguments)) 

	    {
		
		push @arguments,myIO::CleanFileName($filename);		
		myIO::ReturnOutput($ReturnData,\@arguments);

	    }

	} 
   }

    return;

}
