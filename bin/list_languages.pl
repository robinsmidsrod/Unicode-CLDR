#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say);
use rlib;
use Unicode::CLDR;

# ABSTRACT: Prints language names in the given data file
# PODNAME: list_languages.pl

STDOUT->binmode('utf8');

my $cldr = Unicode::CLDR->new();

unless ($ARGV[0]) {
    say for sort $cldr->all_locale_codes;
    exit;
}

my $locale = $cldr->get_locale($ARGV[0]);
say "Version: " . $locale->identity->version;
say "Date: " . $locale->identity->date;
say "Language: " . $locale->identity->language_id;
say "Script: " . $locale->identity->script_id;
say "Territory: " . $locale->identity->territory_id;

if ( $ARGV[1] ) {
    my $lang = $locale->get_language($ARGV[1]);
    say  $lang->id . ' = ' . $lang->name . " (" . $lang->data_quality . ")" if $lang;
    exit;
}

say $_->id . ' = ' . $_->name . " (" . $_->data_quality . ")" for $locale->all_languages;
