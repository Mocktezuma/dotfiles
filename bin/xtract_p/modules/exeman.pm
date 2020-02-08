package exeman;

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw(EXE_main_help);

$version = '0.01';

# imports

use binman qw(Packed Packed_DWORD Packed_Reversed);

# help string

sub Usage() {

    return sprintf <<END;

    xtract [file] EXE:
    ------------------
	xtract Win32 exe binaries. WARNING: This code is still in draft stage. Does not work on UPX packed binaries yet. Does not work on 64-bit executables.
END


}


our $EXE_main_help = Usage();

# globals

my $DOS_signature = qr/\x4d\x5a/;
my $PE_signature = qr/\x50\x45\x00\x00/;

my $DOS_header_length = 0x3E; # 0x3c is start of last field in DOS header, add 4 bytes for last field length, subtract 2 bytes for the magic signature at the start of DOS header

my $PE_offset_offset = 0x3B;  # 0x3c from start of MZ indicates offset from start of file to beginning of PE data

my $WIN32 = 0x0b01;
my $WIN32_PLUS = 0x0b02;

# a very generic wrapper. can be adapted for any filetype like ZIP for which there are multiple specifications

sub ExeExtract {               

    my $data_array_ref = shift;
    my $options = shift;
    my @EXEs = ();
    
    use bytes;

    (my $EXE) = ${@$data_array_ref[0]} =~ /(MZ.*$)/s; # currently there better only be one EXE file in the stream. will fix this later.

    # check for valid DOS file signature, correct file offset and PE signature to minimiize chance of false positive

    (my $DOS_header) = $EXE =~ /($DOS_signature.{$DOS_header_length})/s;

    (my $reloc_offset) = $DOS_header =~ /.{23}(.{2})/s;

    (my $PE_offset) = $DOS_header =~ /.{$PE_offset_offset}(.{4})/s;

    $reloc_offset = binman::Packed($reloc_offset);

    $PE_offset    = binman::Packed_DWORD($PE_offset);

    (my $PE_header) = $EXE =~ /^.{$PE_offset}(.{4})/s;

    unless ($reloc_offset eq 0x40 && $PE_header =~ /$PE_signature/s) {return;}


    # calculate the option header values and check for a Win32 Binary

    (my $COFF_header) = $EXE =~ /^$DOS_header.*?$PE_header(.{20})/s;

    (my $SectionTableNumber) =  $COFF_header =~ /^.{2}(.{2})/s;

    my $SectionTableSize = binman::Packed_Reversed($SectionTableNumber)*40;
    (my $OptionHeaderSize) = $COFF_header =~ /^.{15}(.{2}).{2}/s;

    $OptionHeaderSize = binman::Packed($OptionHeaderSize);

    (my $OptionHeader) = $EXE =~ /^$DOS_header.*?$PE_header.{20}(.{$OptionHeaderSize})/s;

    (my $format) = $OptionHeader =~ /(^.{2})/s;

    if (binman::Packed($format) ne $WIN32) {return;}

    # Finally, calculate the section table size and the size of the individual sections in the rest of the file

    (my $SectionTable) = $EXE =~ /^$DOS_header.*?$PE_header.{20}.{$OptionHeaderSize}(.{$SectionTableSize})/s;
    (my @sections) = $SectionTable =~ /(.{40})/sg;

    my $section_size = 0;

    foreach my $section (@sections) {

         (my $SizeOfRawData) = $section =~ /^.{15}(.{4})/s;
   
	 $section_size += binman::Packed_DWORD($SizeOfRawData);
    }

    my $beginning_of_EXE = qr/^$DOS_header.*?$PE_header.{20}.{$OptionHeaderSize}.{$SectionTableSize}/s;

    (my $carved_EXE) = $EXE =~ /(^$beginning_of_EXE)/s;

    $EXE =~ s/$beginning_of_EXE//s;

    while ($section_size >= 0) {

	if ($EXE =~ /^.{2}/s) {
	
	    (my $bytes) = $EXE =~ /(^.{2})/s;
	    $EXE =~ s/^.{2}//s;	
	    $carved_EXE .= $bytes;

	} else {

	    (my $byte) = $EXE =~ /(^.{1})/s;
	    $EXE =~ s/^.{1}//s;
	    $carved_EXE .= $byte;
	}

	$section_size--;
    }

    push @EXEs,$carved_EXE;
    
    return \@EXEs;
}
