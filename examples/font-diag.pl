#!/usr/bin/perl -w
use strict;
use Font::FreeType;

die "Usage: $0 font-filename\n"
  unless @ARGV == 1;
my ($filename) = @ARGV;

my $face = Font::FreeType->new->face($filename);

$face->set_char_size(10, 0, 96, 96);
$face->set_diag(sub{
    my ($glyph_id, $mess_code, $message,
        $opcode, $range_base, $is_composite,
        $IP, $callTop, $opc, $start ) = @_;

    print $message, " ";
    print $opcode, ":";
    if ( $range_base == 3 )
    {
        if ($is_composite != 0) {
            print " Composite Glyph ", $glyph_id;
        }
        else {
            print " Glyph ID ", $glyph_id;
        }
    }
    elsif (( $range_base == 1 ) || ( $range_base == 2))
    {
        print " Pre-Program";
    }
    else
    {
        print " Unknown?";
    }
    print ", At ByteOffset ", $IP;
    if ($callTop > 0) {
        print ", In function ", $opc, " offsetted by ", ($IP - $start);
    }
    print "\n";
                });
$face->foreach_glyph(sub {
     $_->load;
});
$face->unset_diag();

# vi:ts=4 sw=4 expandtab
