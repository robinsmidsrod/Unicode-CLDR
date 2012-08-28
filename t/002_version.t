#!perl

use strict;
use warnings;
use Test::More;
use Unicode::CLDR;

my $cldr = Unicode::CLDR->new();
isa_ok( $cldr, 'Unicode::CLDR' );

can_ok( $cldr, qw(get_locale) );
my $locale = $cldr->get_locale('zh_Hans_CN');
isa_ok( $locale, 'Unicode::CLDR::Locale' );

isa_ok( $locale->identity, 'Unicode::CLDR::Identity' );
can_ok( $locale->identity, qw(version date language_id territory_id script_id) );

ok( $locale->identity->version > 4000, 'version number looks sane' );
isa_ok( $locale->identity->date, 'DateTime' );
ok( $locale->identity->date->year >= 2009, 'date looks sane' );
is( $locale->identity->language_id, 'zh', 'file language looks sane' );
is( $locale->identity->script_id, 'Hans', 'file script looks sane' );
is( $locale->identity->territory_id, 'CN', 'file territory looks sane' );

done_testing();
