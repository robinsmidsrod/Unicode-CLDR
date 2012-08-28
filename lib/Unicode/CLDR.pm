package Unicode::CLDR;
use Moose;
use namespace::autoclean;
use File::ShareDir ();
use Path::Class::Dir ();
use Unicode::CLDR::Locale;

# ABSTRACT: Access data from the Unicode Common Locale Data Repository

# Where to find the Unicode CLDR database files (should contain folders named main, rnbf, etc)

has 'database_dir' => (
    is         => 'ro',
    isa        => 'Path::Class::Dir',
    lazy_build => 1,
);

sub _build_database_dir {
    my ($self) = @_;
    return Path::Class::Dir->new(
        File::ShareDir::module_dir(__PACKAGE__)
    );
}

# Lists all the valid locale codes you can use
has 'locale_codes' => (
    is         => 'ro',
    isa        => 'ArrayRef[Str]',
    traits     => ['Array'],
    lazy_build => 1,
    handles    => {
        all_locale_codes => 'elements',
    },
);

sub _build_locale_codes {
    my ($self) = @_;
    return [
        map { s/\.xml$//; "$_" } # Strip .xml extension
        map { $_->basename } # Only want the filename
        Path::Class::Dir->new( $self->database_dir )->subdir('main')->children
    ];
}

# List of all the locales available, as Unicode::CLDR::Locale instances
has 'locales' => (
    is => 'ro',
    isa => 'ArrayRef[Unicode::CLDR::Locale]',
    traits => ['Array'],
    lazy_build => 1,
    handles => {
        all_locales => 'elements',
    }
);

sub _build_locales {
    my ($self) = @_;
    return [
        map { $self->get_locale( $_ ) }
        $self->all_locale_codes
    ];
}

sub get_locale {
    my ($self, $code) = @_;
    my $filename = $self->database_dir->subdir('main')->file( $code . '.xml');
    confess("Please specify a valid locale code") unless $filename->stat();
    return Unicode::CLDR::Locale->new( file => "$filename" );
}

__PACKAGE__->meta->make_immutable();

1;
