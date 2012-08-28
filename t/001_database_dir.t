#!perl

use strict;
use warnings;
use Test::More;
use Unicode::CLDR;

my $cldr = Unicode::CLDR->new();
isa_ok( $cldr, 'Unicode::CLDR' );

can_ok( $cldr, qw(database_dir all_locales) );
like( $cldr->database_dir, qr/auto/, 'database dir seems to be right' );
note( "Database directory: " . $cldr->database_dir );
ok( -d $cldr->database_dir->subdir('main'), 'database dir contains a main folder' );
ok( $cldr->all_locale_codes > 570, 'all locale files seem to be available' );
is( scalar $cldr->all_locale_codes, scalar $cldr->all_locales, 'number of locale codes and locale files match' );

done_testing();
