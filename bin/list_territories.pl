#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use rlib;
use Unicode::CLDR;

# ABSTRACT: Prints territory names in the given data file
# PODNAME: list_territories.pl

STDOUT->binmode('utf8');

die "Please specify a territory code" unless $ARGV[0];
my $cldr = Unicode::CLDR->new();
my $locale = $cldr->get_locale($ARGV[0]);
say $_->id . ' = ' . $_->name for $locale->all_territories;
