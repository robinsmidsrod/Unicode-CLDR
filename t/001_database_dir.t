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
ok( $cldr->all_locales > 570, 'all locale files seem to be available' );

done_testing();
