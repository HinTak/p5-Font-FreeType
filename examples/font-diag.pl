#!/usr/bin/perl -w
use strict;
use Font::FreeType;

die "Usage: $0 font-filename\n"
  unless @ARGV == 1;
my ($filename) = @ARGV;

my $face = Font::FreeType->new->face($filename);

$face->set_char_size(10, 0, 96, 96);
$face->set_diag(sub{
    print join("\t", @_), "\n";
                });
$face->foreach_glyph(sub {
     $_->load;
});
$face->unset_diag();

# vi:ts=4 sw=4 expandtab
