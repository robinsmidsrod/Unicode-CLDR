package Unicode::CLDR::Role::ComputedIdAttribute;

use Moose::Role;

# ABSTRACT: Computes the id attribute from type and alt attributes

requires 'type';
requires 'alt';

has 'id' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_id {
    my ($self) = @_;
    return $self->type . '@' . $self->alt if $self->alt;
    return $self->type;
}

no Moose::Role;

1;
