package commonman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw(COMMON_help common_help);

$version = '0.01';

use dataman qw(ParseOptions);
use myIO qw(read_binfile UniqueElementsOnly);
use ipman qw(Masked IPaddrASCII_To_Bin);

# main help


sub Usage() {

    return sprintf <<END;

    xtract [file1] COMMON -with file2 file3 ... -type datatype
    ----------------------------------------------------------
        identify common elements, defined by arguments passed to -type, of two or more files, such as file1 and file2
END
}
our $common_help = Usage();

# optional argument handlers, explanations

my %COMMON_options = (
    "-with" => \&myIO::ProcessAdditionalFiles,          # read in additional files' binary data and return pointers to the data 
    "-type" => \&AddTypeValue,                          # add a type specification to pull data out of the raw binary
    "-mask" => \&AddMaskValue,                          # add a mask specification to fuzz the matching of IP addresses
    "-excl" => \&AddExclValue,                          # force strict matching (must be present in all input files to qualify)
    "-numfiles" => \&AddNumFilesValue,
    "-nocommon" => \&SetNoCommonFlag,
    );

our %COMMON_help = (
    "-type" => '-type [filetype]: built-in file extraction according to filetype type to save a step. Note that the arguments to -type are the same as those for simpler "xtract" commands eg "xtract ... IP" or "xtract ... STRINGS". At least one argument to -type is required.  Flags may be specified appropriate to the -type, but the flags need to be prefixed with -- instead of -, e.g.: "xtract file1 COMMON -with file2 -type IP --pcap"',
    "-mask" => '-mask [mask]: CIDR mask that allows incomplete matching of IP addresses according to arbitrary /[0-32].',
    "-excl" => '-excl: force exclusive matching, i.e. elements matching criterion must be present in all files',
    "-numfiles" => '-numfiles [number of files]: require elements matching criterion be present in at least a specified number of files.',
    "-nocommon" => '-uncommon: only return those elements which are NOT in common in more than one file.  Useful for example for screening out IP addresses that fall within subnet blocks and which might not be as interesting as standalone IPs."'
    );


# global state variables

my %FLAG = (
    "mask" => 0,                 
    "type" => 0,
    "excl" => 0,
    "numfiles" => 0,
    "nocommon" => 0,
    );

my %VALUE = (
    "type" => 0,
    "mask" => 0,
    "numfiles" => 0,
    );

sub CommonsEntry {
    my $data_array_ref = shift;
    my $additional_arguments = shift;

    my @options = @$additional_arguments;

    if ($#options) {
	dataman::ParseOptions($data_array_ref,\%COMMON_options,\@options); # the additional files' binary data is inputted via -with processor
    } else {

	die "at a minimum specify a comparison file using -with [comparison file] and a -type!\n";

    }

    return FindCommons($data_array_ref);             
}

sub FindCommons {

    my $data_array_ref = shift;

    my $line_separator = "\n";

    my $count = 0;
    my @array_of_rawdata = @$data_array_ref; 

    my @data_array = ();
    my $CommonTest;

    if ($#array_of_rawdata < 1) {die "no additional file specified using -with\n";}

    if (!$VALUE{type}) {die "no -type specified!\n";}          

    if ($FLAG{mask} && (@{$VALUE{type}}[0] eq "IP")) {                                # determine commonality criterion

	$CommonTest = \&NetMask;

    } else {

        $CommonTest = \&Identity;                                       # default to simple test of equality

    } 

    while (@array_of_rawdata) {                                                  

	my $bindata_ref = shift @array_of_rawdata;                                  

	push my @TmpArray,$bindata_ref;

	my @tmp_array = dataman::IsolateContents(\@TmpArray,$VALUE{type});  

	$data_array[$count++] = \@tmp_array;                       

    }

    return Commons_Search(\@data_array,$CommonTest);
    

}

sub Commons_Search {

    my $data_array = shift;                  # reference to array of references to arrays of data from each file
    my $IndexMapper = shift;


    my %index_hash = ();
    my @CommonEls = ();
    my $ExclusionFunction;

    my $num_of_files = @$data_array;
    
     if ($FLAG{excl}) {
	 $ExclusionFunction = \&Exclusive;
     } 

    elsif ($FLAG{nocommon}) {
	$ExclusionFunction = \&ExcludeCommon;
    }

     else {
	 $ExclusionFunction = \&Inclusive;
     }

    # 1. construct one huge hash keyed to each unique data element from each file. Value of the key depends on how IndexMapper parses the data.

    foreach my $file_data_array (@$data_array) {

	foreach my $datum (@$file_data_array) {

	    my $mapped_datum = &$IndexMapper($datum);

	    unless ($index_hash{$mapped_datum}) {
		my @tmp_array = (0);
		$index_hash{$mapped_datum} = \@tmp_array;        
	    }

	}
    }

    # 2. Having constructed the hash, go through each file and apply appropriate operations to the index hash

    while (@$data_array) {
	   my $file_elements = shift @$data_array;                                 

	   @$file_elements = myIO::UniqueElementsOnly(@$file_elements);            

	   foreach my $element (@$file_elements) {   

	       my $mapped_element = &$IndexMapper($element);                         


	       if ($IndexMapper eq \&Identity) {                              # simple equality: increase the count by one

		   @{$index_hash{$element}}[0]++;                                          
		   push @{$index_hash{$element}},$element;                                 

	       } elsif (!ElementInArray($index_hash{$mapped_element},$element)) {  # non-simple equality: increase by one                                                                                     # but only if the item hasn't been 
                                                                                   # counted already
		   @{$index_hash{$mapped_element}}[0]++;                                          
		   push @{$index_hash{$mapped_element}},$element;                                  

	       }

	   }
    }

    # 3. Now go back and see how the index hash is doing.  Exclusive test requires that the count for any data match the # of files.  Inclusive test requires that the count be greater than 1 i.e. file present in at least two files.  This algorithm is nice insofar as it is easy to require data match in any arbitrary # of files. :)

    for (keys %index_hash) {

	my $key_count = shift @{$index_hash{$_}};

        # key_count == num_of_files -> return values occuring in all files
        # key_count > #  -> return values occuring in more than # files  (# = 1 -> any values occuring in more than one file)

	if (&$ExclusionFunction($key_count,$num_of_files)) {     
	    foreach my $value (@{$index_hash{$_}}) {
		push @CommonEls,$value;
	    }
	}
	
    }
    
    return \@CommonEls;
}

# comparators to test equality between values 

sub Identity {             # returns whatever value it receives

    my $val = shift;
    my $args = shift;

    return $val;
    
}

sub NetMask {       # if two IP addresses are within the same subnet as defined by $VALUE{mask}

    my $ascii_ip_addr = shift;

    return ipman::Masked(ipman::IPaddrASCII_To_Bin($ascii_ip_addr),$VALUE{mask});

}

# exclusion functions to determine how many files must contain matched items

sub Inclusive {                               # anything that hit in more than 1 file counts as a common element
    my $keycount = shift;

    if ($keycount > 1) {return 1;}
    return 0;
    
}

sub Exclusive {                               # anything that hit in x # of files or more counts as a common element
                                              # if x = total # of files then that means must be common elments present in all files
    my $keycount = shift;
    my $fileNumber = shift;
    
    if ($FLAG{filenums}) {                    
	$fileNumber = $FLAG{filenums};
    }

    if ($keycount eq $fileNumber) {return 1;}
    
    return 0;
}

sub ExcludeCommon { # no element that is present in more than one file.  effectively, only those elements that don't match across files
    my $keycount = shift;

    if ($keycount > 1) {return 0;}

    return 1;

}

### helper functions


# handle global state variables

sub AddExclValue {
    $FLAG{excl} = 1;
}


sub AddMaskValue {
    my $data_array_ref = shift;
    my $options_ref = shift;

    my $maskval = shift @$options_ref;

    $FLAG{mask} = 1;
    $VALUE{mask} = $maskval;
    
}


sub AddNumFilesValue {
    my $data_array_ref = shift;
    my $options_ref = shift;

    my $filenumber = shift @$options_ref;

    $FLAG{numfiles} = 1;
    $VALUE{numfiles} = $filenumber;
    
}

sub AddTypeValue {

    my $data_array_ref = shift;
    my $options_ref = shift;
    
    $FLAG{type}   = 1;

    StripExtraHyphen($options_ref);                       # any options will be present as --options, need to correct for parsing

    $VALUE{"type"} = $options_ref;                        # set pointer to options array

}

sub StripExtraHyphen {
    my $options_ref = shift;
    foreach my $option (@$options_ref) {
	$option =~ s/\-{2}/\-/;
    }
}

sub ElementInArray {

    my $index_array_ref = shift;
    my $search_element = shift;
    
    my $start = 1;                                        # the first element of $index_array will not be data so skip

    while (my $el = @$index_array_ref[$start]) {
	if ($el eq $search_element) {
	    return 1;
	}
	$start++;
    }
    
    return 0;
}

sub SetNoCommonFlag {
    
    $FLAG{nocommon} = 1;

}
