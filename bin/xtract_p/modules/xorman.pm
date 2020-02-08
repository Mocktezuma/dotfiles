
package xorman;

use strict;
use myIO;

use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter AutoLoader);

@EXPORT = qw();
$version = '0.01';

# globals


sub Usage() {

    return sprintf <<END;

    xtract [file] XOR -k <key>:
    -----------------------
        extract an ASCII hexdump of binary data which has been XOR\'d by the value specified by <ey>.  <key> should be in the format 0x??.

END
}

our $XOR_main_help = Usage();

my %XOR_Options = (
    "-k"    => \&Set_XOR_Key,
    "-file" => \&Set_File_Flag,
    );

our %XOR_Options_help = (
    "-file" => '-file: write XOR\'d data to binary file (name automatically generated).',
    );

my %FLAG = (

    "file" => 0,
    "key"    => 0,
    );
# locals

my $buf;

sub ApplyXOR
{

    my $data_ref = shift;
    my $arg_ref = shift;

    my @options = @$arg_ref;

    my @ReturnData = ();
    my $XOR_Output;

    if (!$#options) 
    {
	die "must specify a -k <key>!";
    }
    
    dataman::ParseOptions($data_ref,\%XOR_Options,\@options);

    ($FLAG{key}) = $FLAG{key} =~ /^0x(..)$/ or Error("key must be specified as 0x??");

    $FLAG{key} = unpack("C",pack("H2",$FLAG{key}));
    
    if (!$FLAG{file})
    {
        $XOR_Output = \&HexDump;
    }
    else 
    {
	$XOR_Output = \&WriteToFile;
	myIO::CustomOutputFunction(\&myIO::print_array_into_files);
    }
    
    &$XOR_Output(@$data_ref[0],\@ReturnData);

    return \@ReturnData;
}

sub HexDump
{

    my $in_data = shift;
    my $out_data = shift;

    my $hex_dump;
    my $count;
    my $offset = 0x10; # can change the # of bytes to display in a row, mebbe can specify that at command line later
    my $rownum = 0;
    my $count = 0;
    my $hex_dump;
    my $ascii_dump;
    my $row = "%8x| %s | %s\n";
    my $dump;

    use bytes;

    while ($$in_data)
    {
	(my $buf) = $$in_data =~ /(^.)/;
	$$in_data =~ s/^.//s;
	$count++;

	my $bufNative = hex(unpack("H2",$buf));
	my $bufNativeXOR = $bufNative^$FLAG{key};

	$hex_dump   .= sprintf("%2x ",$bufNativeXOR);
	$ascii_dump .= sprintf("%s",ReturnASCII($bufNativeXOR));

	if (!($count % $offset)) 
	{
    
	    $dump .= sprintf($row,$rownum,$hex_dump,$ascii_dump);
	    $hex_dump = '';
	    $ascii_dump = '',
	    $rownum += $offset;
	}
    }

    if ($count < $offset) # fewer chars than even a single row, still add what you got
    {
	    $dump .= sprintf($row,$rownum,$hex_dump,$ascii_dump);
	
    }

    push @$out_data,$dump;


}

sub WriteToFile # set $data = binary dump, which will be written to file by myIO
                # the name of the file is all messed up, but it's there :-)
                # also note that there will be a final bogus byte, the null termination byte
                # XOR'd by your key.  I'll fix this later.
{
    
    my $in_data = shift;
    my $out_data = shift;
    my $buffer;
    use bytes;

    while ($$in_data)
    {
    	(my $buf) = $$in_data =~ /(^.)/;
	$$in_data =~ s/^.//s;
	
	$buf = hex(unpack("H2",$buf));
	$buf ^= $FLAG{key};

	$buffer .= sprintf("%c",$buf);
    }
    
    push @$out_data,$buffer;

}
sub Set_XOR_Key
{

    my $data_ref = shift;
    my $arg_ref = shift;

    $FLAG{key} = @$arg_ref[0];

}

sub ReturnASCII
{

    my $val = shift;

    if ($val >= 0x20 && $val <= 0x7e)
    {
    
	return sprintf("%c",$val);

    }
    else
    {
	return ".";
    }

}

sub Set_File_Flag
{
    $FLAG{file} = 1;
}
sub Error
{

    my $error_string = shift;

    printf($error_string."\n");
    Usage();
    exit;

}

1;
