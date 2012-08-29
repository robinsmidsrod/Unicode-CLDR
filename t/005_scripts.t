#!perl

use strict;
use warnings;
use Test::More;
use Unicode::CLDR;

my $cldr = Unicode::CLDR->new();
my $en = $cldr->get_locale('en');
is( $en->get_script('Arab')->name, 'Arabic', 'name of the Arabic script in English matches' );
my $nb = $cldr->get_locale('nb');
is( $nb->get_script('Arab')->name, 'arabisk', 'name of the Arabic script in Norwegian matches' );

done_testing();
