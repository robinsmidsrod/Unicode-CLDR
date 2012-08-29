#!/usr/bin/env perl
use strict;
use warnings;
use rlib;
use Unicode::CLDR;
use feature 'say';

# ABSTRACT: Example of how you can do a language choice screen in multiple languages
# PODNAME: language_choice.pl

STDOUT->binmode("utf8");

my $cldr = Unicode::CLDR->new();
my $en = $cldr->get_locale('en');
my @languages = map { $_->id } $en->all_languages;
foreach my $language_id (sort @languages ) {
    my $locale = eval { $cldr->get_locale( $language_id ); };
    next unless $locale;
    my $lang = $locale->get_language( $language_id );
    next unless $lang;
    say "id=" . $lang->id . ", name=" . $lang->name;
}
