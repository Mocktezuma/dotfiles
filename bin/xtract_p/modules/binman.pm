package binman;               # never be used in direct call from command line but useful to store binary data processing,formatting-related routines

use strict;
use vars qw($version @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qr(Exporter Autoloader);

our @EXPORT = qw();

$version = '0.01';


sub Packed {                               
# convert a raw sequence of bytes into a # Perl can understand
    my $bytes =  shift;

    use bytes;

    my $num = length($bytes)*2;
    
    return hex(unpack("H$num",$bytes));

}

sub ByteLength {
    my $bytes = shift;
    use bytes;

    return length($bytes);
}

sub TestFlag {
    my $test_val = shift;
    my $mask_val = shift;

    if ($test_val & $mask_val) {
	return 1;
    }

    return 0;
}

sub PrintBytes { # for debugging
    my $stream = shift;
    use bytes;
    my @bytes = split('',$stream);
    foreach my $byte (@bytes) {
	print unpack("H2",$byte);
    }
    print "\n";
}


sub Packed_DWORD {         # like Packed but operates on DWORD-length values                          
    my $bytes =  shift;

    use bytes;

    my $num = length($bytes)*2;

    (my $high_word,my $low_word) = $bytes =~ /(^.{2})(.{2}$)/s;

    
    my $reversed = Reversed($high_word);

    myIO::PrintBytes($reversed);
    
    return $reversed;

}


sub Reversed {     # correct reversed byte ordering

    my $word = binman::Packed(shift);
    printf "here %x\n",$word;

    my $high = $word  & 0xf0;
    my $low  = $word  & 0x0f;

    printf "here %x\n",$high;

    return ($low | $high);
}


