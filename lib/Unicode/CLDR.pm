package Unicode::CLDR;
use Moose;
use namespace::autoclean;
use File::ShareDir ();
use Path::Class::Dir ();
use Unicode::CLDR::Locale;

# ABSTRACT: Access data from the Unicode Common Locale Data Repository

has '_loc' => (
    is       => 'ro',
    isa      => 'Str',
    init_arg => 'locale',
    lazy_build => 1,
);

sub _build__loc {
    my ($self) = @_;
    my $lang = $ENV{'LANG'} || 'en_US.UTF-8';
    ( my $loc = $lang ) =~ s/^(.*?)\./$1/;
    return $loc;
}

has 'locale' => (
    is         => 'ro',
    isa        => 'Unicode::CLDR::Locale',
    init_arg   => undef,
    lazy_build => 1,
);

sub _build_locale {
    my ($self) = @_;
    return Unicode::CLDR::Locale->new(
        file => $self->database_dir->subdir('main')->file($self->_loc . '.xml')
    );
}

has 'parent_locale' => (
    is         => 'ro',
    isa        => 'Unicode::CLDR::Locale',
    lazy_build => 1,
);

sub _build_parent_locale {
    my ($self) = @_;
    return $self->locale unless $self->_loc =~ /_/;
    ( my $parent_locale = $self->_loc ) =~ s/^(.+)_.*$/$1/;
    return Unicode::CLDR::Locale->new(
        file => $self->database_dir->subdir('main')->file($parent_locale . '.xml')
    );
}

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
has 'locales' => (
    is         => 'ro',
    isa        => 'ArrayRef[Str]',
    traits     => ['Array'],
    lazy_build => 1,
    handles    => {
        all_locales => 'elements',
    },
);

sub _build_locales {
    my ($self) = @_;
    return [
        map { s/\.xml$//; "$_" } # Strip .xml extension
        map { $_->basename } # Only want the filename
        Path::Class::Dir->new( $self->database_dir )->subdir('main')->children
    ];
}

__PACKAGE__->meta->make_immutable();

1;
