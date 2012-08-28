#!perl

use strict;
use warnings;
use Test::More;
use Unicode::CLDR;

my $cldr = Unicode::CLDR->new();
my $en = $cldr->get_locale('en');
is( $en->get_language('en')->name, 'English', 'name of English language in English matches' );
my $nb = $cldr->get_locale('nb');
is( $nb->get_language('en')->name, 'engelsk', 'name of English language in Norwegian matches' );

done_testing();
