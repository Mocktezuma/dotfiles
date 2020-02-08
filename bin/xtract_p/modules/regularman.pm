package regularman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

use myIO;
use dataman;

require Exporter;

@ISA = qr(Exporter Autoloader);

@EXPORT = qw(RegExHelp RGXP_help);
$version = '0.01';

# help

sub Usage() {

    return sprintf <<END;

    xtract [directory] RGXP -f <regex file name>:
    ---------------------------------------------
	Search recurisvely for the regex stored in a regex file (path specified in xtract.conf). Unlike grep this will search across multiple lines of text.  This also provides a facility to store and reuse regexes since the introduction of parameters is possible.  Please see hthe sample Regex.txt in the "regexes" file for an illustration.
END


}

our $RegExHelp = Usage();

our %RGXP_help = (

    "-L <regex file>" => "[-L]: list contents of regex file",
    "-g" => "[-g]: return all matches in each file",
    "-mask" => "[-mask <mask>]: only search in files whose names match <mask>. Useful for confining searches to certain classes of files",
    "-\#" => "[-\#] <regex number>: if the regex file contains multiple regex definitions, choose a regex assigned a specific number i.e. 2,3,4. See the sample regex file for an example.",
    "-value" => "[-value A=x B=y...]: in cases where the regexes include placeholders \$A,\$B etc define the values of these placeholders dynamically",
    "-f" => "-f <regex_file>: MANDATORY: specify the name of the regex file ,don't need the preceding path (which should be specified in xtract.conf), the engine will assume a .txt extension."

    );

# option handlers

my %REGEX_Options = (
    
    "-L" =>     \&SetListFlag,
    "-g" =>     \&SetGlobalFlag,
    "-mask" =>  \&SetMaskFlag,     
    "-\#" => \&SetIndexFlag,      # index of regex in the file
    "-value" => \&SetValueFlag,    # -values A=... B=... and so on
    "-f"     => \&SetFilenameFlag, # name of regex file
    );

my %FLAG = (
    
    "index" => 0,
    "value" => 0,
    "mask"  => 0,
    "global" => 0,
    "list"   => 0,
    "rgx_file" => 0
    );

# xtract [directory path] RGXP -f

sub RegExPull {
    my $data_array_ref = shift; # should be a handle to a directory
    my $additional_arguments = shift;
    
    my @ReturnData;

    my $basedir = @$data_array_ref[0];    # wherever the search starts
    
    ReturnFullPath(\$basedir);             # deal with the fact that Perl has no built-in way to return abs pathnames
	
    my @args = @$additional_arguments;
    
    dataman::ParseOptions($data_array_ref,\%REGEX_Options,\@args);

    if (!$FLAG{rgx_file}) {die "must specify a regex file to use with -f!\n";}

    # get options from the config file most importantly the path to the regex folder as $options->{rgx_dir}

    my $options = myIO::ReadConf("Regex_Options");

    # add pointer to return data into options to filling results easier

    $options->{bucket} = \@ReturnData;
   
    # start processing, $options->{path} will be the full path to the regex definition file
    # if -L has been specified display contents of regex file and quit

    my $rgx_file = $FLAG{rgx_file};    

    $options->{path} = "$options->{rgx_dir}$rgx_file.txt"; 

    if ($FLAG{list}) {
	exec("cat $options->{path}");	
    }

    ParseRegexFile($options);

    # now $options->{rgx} points to the regex, replace the variable placeholders with  the values from ValueTable if necessary

    if ($FLAG{value}) {

	my $ValueTable = FillValueTable($FLAG{value},$options);

	for (keys %$ValueTable) {

	    $options->{rgx} =~ s/\$$_/$ValueTable->{$_}/g;

	}

    }

    printf "\nREGEX: $options->{rgx}\n";

    $options->{rgx} = qr/$options->{rgx}/;

    Traverse($basedir,0,\&PerformSearch,$options);

    return \@ReturnData;
}

# directory recursion, data processing

sub Traverse {
    
    (my $current_file,
     my $prev_file,
     my $DirFunction,
     my $options) = @_;

    if (opendir($options->{current_handle},$current_file)) { # current_file points to directory
	printf("opened directory %s\n",$current_file);

	my @files = readdir($options->{current_handle});

	close ($options->{curent_handle});
	chdir($current_file) or die "could not change to $current_file\n";

	$options->{current_file} = $current_file;
	&$DirFunction(\@files,$options);

	foreach my $file (@files) {

	    if ($file eq "." or $file eq "..") {next;}
	    
	    Traverse("$current_file/$file",$current_file,$DirFunction,$options);

	}
	
	
    }

    close ($options->{current_handle});
}

sub PerformSearch {
    
    (my $files,
     my $options) = @_;

    my $rgx = $options->{rgx};
    my $cwd = $options->{current_file};

    foreach my $filename (@$files) {

	next if
	    $filename eq "."    or
	    $filename eq ".."   or
	    readlink($filename) or
	    ($FLAG{mask} && $filename !~ /$FLAG{mask}/);

	my $Buffer,my @matches;
	my $path = "$cwd/$filename";

	my $Buffer = myIO::read_txtfile($path);

# search the file for data (finally!!!)

	if ($FLAG{global} && ((@matches) = $$Buffer =~ /($rgx)/sg)) {

#	    @matches = myIO::UniqueElementsOnly(\@matches);
	    
	}


	elsif ((my $match) = $$Buffer =~ /($rgx)/s) {

	    push @matches,$match;
	    
	}

# push a match notification into the return data bucket
	  
	if ($#matches > -1) {
	    push @{$options->{bucket}},sprintf($options->{match_string},$path,$#matches > 1 ? join(",",@matches) : $matches[0]);
	    
	}  

    }
}



# text processors

sub FillValueTable {

    my $values = shift; # pointer to array containing string of "A=x","B=y"...

    my %Vals=();

    foreach my $value (@$values) {

	if ($value =~ /(^.*?)=(.*?$)/) {
	    $Vals{$1} = $2;	    
	}

    }

    return \%Vals;
}

sub ParseRegexFile {

    my $options = shift;

    my $SPACE = qr/\s{0,}/;

# default to #1 regex if no others 
	
    if (!($options->{rownum} = $FLAG{index})) {
	$options->{rownum} = 1;
    }
 
    open TMP,"$options->{path}" or die "could not open $options->{path}!";

    while (<TMP>) {

	next if /^$SPACE\#/;

	if ((my $rgx) = /^$SPACE$options->{rownum}\.$SPACE\/(.*?)\//) {

	    close TMP;
	    $options->{rgx} = $rgx;
	    return;

	}
    }
    
    close TMP;
    die "could not find regex in $options->{path}!\n";
}

sub ReturnFullPath {
    
    my $path = shift;

    if ($$path =~ /^\.\.$/) {

	($$path) = $ENV{PWD} =~ /(^.*)\/.*?$/;

    }

    elsif ($$path =~ /^\.$/) {

	$$path = $ENV{PWD};

    }


    elsif ($$path =~ /^\~/) {

	$$path =~ s/^\~/$ENV{HOME}/;

    }

}

# Flag andlers


sub SetListFlag {

    $FLAG{list} = 1;

}

sub SetGlobalFlag {
    
    $FLAG{global} = 1;

}

sub SetMaskFlag {
    
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{mask} = @$argument_array_ref[0];

}

sub SetValueFlag {
        
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{value} = $argument_array_ref; 

}

sub SetIndexFlag {
    
    my $data_ref = shift;
    my $argument_array_ref = shift;

    $FLAG{index} = @$argument_array_ref[0];
}

sub SetFilenameFlag {
    my $argument_array_ref = $_[1];

    $FLAG{rgx_file} = @$argument_array_ref[0];
 
    
}

sub SetGlobalFlag {
    
    $FLAG{global} = 1;

}
