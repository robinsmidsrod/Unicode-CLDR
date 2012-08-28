package Unicode::CLDR::Language;
use XML::Rabbit;

# ABSTRACT: Language names
# id = ISO 639 identifier
has_xpath_value 'id'    => './@type';
has_xpath_value 'alt'   => './@alt';
has_xpath_value '_name'  => '.';

has 'name' => (
    is => 'ro',
    isa => 'Str',
    lazy_build => 1,
);

sub _build_name {
    my ($self) = @_;
    ( my $name = $self->_name ) =~ s/^ \s* (.*?) \s* $/$1/x;
    return $name;
}

has_xpath_value 'draft' => './@draft';
with 'Unicode::CLDR::Role::DataQuality';

finalize_class();
