package myIO;
use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

@EXPORT = qw();
$version = '0.01';

# module imports

use jpegman qw(JpgHelp);
use regularman qw(RegExHelp RGXP_help);
use commonman qw(COMMON_help common_help);
use ipman qw(IPhelp);
use sessionman qw(SESSIONhelp);
use zipman qw(ZIP_main_help);
use allman qw(ALL_main_help);
use exeman qw(EXE_main_help);
use webman qw(WebHelp);
use xorman qw(XOR_main_help);

# global state variables for myIO.pm


my $file_count = 1;

my %FLAG = (
    
    "AllowDupe" => 0,         # 1 -> duplicates are not stripped
    "ReturnStream" => 0,      # 1 -> no carriage return between elements
    "CustomOutput" => 0,      # 1 -> calling function has its own output function to use
    "RootDir" => 0,
    "OutputDir" => '',
    );

my %VALUE = (
    
    "CustomOutput" => 0,      # will contain pointer to appropriate function
    );

# point to what type of output is appropriate for type of data extraction

my %output_function_pointer = (         
    "JPG" => \&print_array_into_files,
    "COMMON" => \&print_stdout,
    "IP" => \&print_stdout,
    "RGXP" => \&print_stdout,
    "SESSIONS" => \&print_stdout,
    "ZIP" => \&print_array_into_files,
    "EXE" => \&print_array_into_files,
    "HTML" => \&print_array_into_files,
    "ALL" => \&print_array_into_files,
    "XOR" => \&print_stdout,
    );

# point to explanation for options and sub-options for each function


my %function_help = (                   # help lines that print by default for each type of function

    "JPG" => \$jpegman::JpgHelp,

    "UTF8" => => \$chinaman::UTF8_Help,			     

    "COMMON" => \$commonman::common_help,

    "IP" => \$ipman::IPhelp,

    "RGXP" => \$regularman::RegExHelp,				       				  

    "SESSIONS" => \$sessionman::SESSIONhelp,

    "ZIP" => \$zipman::ZIP_main_help,

    "ALL" => \$allman::ALL_main_help,			       
 
    "EXE" => \$exeman::EXE_main_help,

    "HTML" => \$webman::WebHelp,
			
    "XOR" => \$xorman::XOR_main_help,				       
    );


my %OptionString = (
    "COMMON" => \%commonman::COMMON_help,
    "IP" => \%ipman::IP_help,
    "UTF8" => \%chinaman::UTF8_options_help,
    "SESSIONS" => \%sessionman::SESSION_help,
    "ZIP" => \%zipman::ZIP_help,
    "RGXP" => \%regularman::RGXP_help,
    "XOR"  => \%xorman::XOR_Options_help,
    );


# wrapper

sub ReturnOutput {
    my $data_array_ref = shift;
    my $arg_array_ref = shift;
    
    my $output_function;

    my $file_type = @$arg_array_ref[0];


    if ($FLAG{CustomOutput}) {
	$output_function = $VALUE{CustomOutput};

    } elsif (!$output_function_pointer{$file_type}) {

        die "myIO.pm: no output function set for $file_type\n";}
    
    else {

	$output_function = $output_function_pointer{$file_type};	
    }

    &$output_function($data_array_ref,$arg_array_ref);
}

# help strings to print 

#
# Optional argument handler for -dupes
#

sub SetDupeFlag {
    $FLAG{AllowDupe} = 1;

}

sub SetStreamFlag {
    $FLAG{ReturnStream} = 1;
}

sub CustomOutputFunction {
    my $output_pointer = shift;   # the new pointer to use

    $FLAG{CustomOutput} = 1;
    $VALUE{CustomOutput} = $output_pointer;


}
#
# I/O Subroutines
#

sub SetRootDir {
    my $dir = shift;

    $FLAG{RootDir} = $dir;

}

sub ReturnProgramOptions {                       # return some tips and exit program

    for (keys %function_help) {
	print(${$function_help{$_}});
    }
    exit;
}


sub ReturnProgramSubOptions {                       # return some tips and exit program    my $extraction_type = shift;
    
    my $extraction_type = shift;

    if (! $OptionString{$extraction_type}) {die "no options available for $extraction_type!\n";}
    for (keys  %{$OptionString{$extraction_type}}) {
	print( %{$OptionString{$extraction_type}}->{$_}."\n\n");
    }    
    
    exit;
}

# Input Routines

sub read_binfile {                              # binary read is slow but doesn't munge data
    my $file = shift;

    my $buf;
    my $content;

    open FILE,$file or die "cannot open $file\n";
    binmode(FILE);
    
    while (read(FILE,$buf,1)) {
	$content .= $buf;
    }

    close FILE;

    return \$content;                           # return *pointer* to binary file content
}

sub read_txtfile {                              # binary read is slow but doesn't munge data
    my $file = shift;

    my $buf;

    open FILE,$file or die "cannot open $file\n";
    
    while (<FILE>) {
	$buf .= $_;
    }

    close FILE;

    return \$buf;                           # return *pointer* to binary file content
}

sub ProcessAdditionalFiles {       
    my $data_array_ref = shift;            # reference to contents of first file1
    my $file_list = shift;                 

    # need to add any additional data from other files into @$data_array_ref as well.
    # then pass $data_array_ref to another routine which will 

    foreach my $filename (@$file_list) { 
	push (@$data_array_ref,myIO::read_binfile($filename));      # push a pointer to each additional file contents onto existing 
    }                                                               # data array reference
    
    return @$data_array_ref;                                        # what is returned is a series of *pointers* to raw file contents

}

sub ReadConf {
    
    my $section_name = shift;
    my $confile = "$FLAG{RootDir}/xtract.conf";

    my $confblock_begin = "{";
    my $confblock_end = "}";
    my $param_terminator = ";";

    my $in_input_section = 0;

    my %hash = ();

    my $COMMENT = qr/^\#.*$/;
    my $PARAMETER_LINE = qr/^\s{0,}(.*?)\s{0,}\=\s{0,}(.*?)$param_terminator.*?$/;            # terminated by semicolons

    my $CONF_SECTION_START = qr/^\s{0,}$section_name\s{0,}$confblock_begin.*$/;

    open CONF,$confile or die "cannot open $confile\n";

    while (<CONF>) {
	
	if (/$COMMENT/) {

	    next;

	} 

	elsif ($in_input_section) {

	    if (/$PARAMETER_LINE/) {
		
		$hash{$1} = $2;
		
	    } 

	    elsif (/$confblock_end/) {
	
		last;

	    }
	} 

	elsif (/$CONF_SECTION_START/) {

	    $in_input_section = 1;

	} 

    }

    close CONF;

    return \%hash;
    
}

# Output Routines

sub DbgPrint {                    # trivial routine but it will make it easier to clean up print statements used for debugging
    
    my $format_string = shift;

    $format_string = "DEBUG::: ".$format_string;

    printf($format_string,@_);


}

sub print_stdout {                             # extraction of simple text patterns you can view via STDOUT
    my $array = shift;
    my $arg_array_ref = shift;

    my $file_type = @$arg_array_ref[0];
    my $separator = $FLAG{ReturnStream} ? '' : "\n";
    
    print "\===BEGIN $file_type     \n";
    
    print join($separator,$FLAG{AllowDupe} ? @$array : UniqueElementsOnly(@$array));

    print "\n===END $file_type       \n";
}

sub print_file {                    
    my $content_ref = shift;
    my $filename = shift;
    open FILE,">",$filename or die "cannot create $filename\n";

    print FILE $$content_ref;
    close FILE;
    return;
}

# if you've isolated discrete chunks of binary data you want to save, best to use this one

sub print_array_into_files {                    

    my $data_array = shift;
    my $extra_options = shift;

    my $file_suffix =  @$extra_options[0];
    my $org_filename = CleanFileName(@$extra_options[1]);

    my $OutputDir = $FLAG{OutputDir};

    foreach my $content (@$data_array) {

	my $file_name = sprintf("FROM___%s_%s.%s",$OutputDir.$org_filename,$file_count,$file_suffix);
	printf("Carved file $file_name\n");
	print_file(\$content,$file_name);
	$file_count++;
    }

    return;
}


sub PrintBytes {           # change binary value into hex form for printing
                           # useful for debugging

    use bytes;

    my $binval = shift;
    my @bytes = split(//,$binval);
    foreach my $byte (@bytes) {
	print ( unpack("H2",$byte));
    }
    print "\n";
}


sub UniqueElementsOnly {    # courtesy of stackoverflow.com

    my %seen = ();
    my @r = ();

    foreach my $a (@_) {
	unless ($seen{$a}) {
	    push @r,$a;
	    $seen{$a} = 1;
	}
    }

    return @r;

}


sub CleanFileName {
    my $raw_filename = shift;

    $raw_filename =~ s/^\.//g;
    $raw_filename =~ s/\//_/g;

    return $raw_filename;
}

sub SetOutputDir {
    
    my $out_dir = shift;

    $FLAG{OutputDir} = $out_dir;
    myIO::DbgPrint("OUTDIR SET TO %s\n",$FLAG{OutputDir});
}
