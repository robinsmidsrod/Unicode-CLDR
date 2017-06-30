package Unicode::CLDR::Identity;

use XML::Rabbit;

# ABSTRACT: Database version information

use DateTime::Format::ISO8601;

# Version is an RCS-like string, let's just get the digits
has_xpath_value '_version_str' => './version/@number';
has 'version' => (
    is         => 'ro',
    isa        => 'Int',
    lazy_build => 1,
);

sub _build_version {
    my ($self) = @_;
    ( my $version = $self->_version_str ) =~ s/[^\d]//g;
    return $version;
}

# Date is an RCS-like string, let's just extract the date part we need
has_xpath_value '_date_str' => './generation/@date';
has 'date' => (
    is         => 'ro',
    isa        => 'DateTime',
    lazy_build => 1,
);

sub _build_date {
    my ($self) = @_;
    ( my $date = $self->_date_str ) =~ s/^\$Date: \s*? ( \d{4}-\d{1,2}-\d{1,2} ) \s+? (\d{1,2}:\d{1,2}:\d{1,2}) .* $/$1T$2/x;
    return DateTime::Format::ISO8601->parse_datetime($date);
}

# The locale codes for this particular file
has_xpath_value 'language_id'  => './language/@type';
has_xpath_value 'script_id'    => './script/@type';
has_xpath_value 'territory_id' => './territory/@type';
has_xpath_value 'variant_id'   => './variant/@type';

finalize_class();
