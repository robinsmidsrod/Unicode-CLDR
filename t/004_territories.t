#!perl

use strict;
use warnings;
use Test::More;
use Unicode::CLDR;

my $cldr = Unicode::CLDR->new();
my $en = $cldr->get_locale('en');
is( $en->get_territory('001')->name, 'World', 'name of the world in English matches' );
my $nb = $cldr->get_locale('nb');
is( $nb->get_territory('001')->name, 'verden', 'name of the world in Norwegian matches' );

done_testing();
