package Unicode::CLDR::Role::DataQuality;
use Moose::Role;

# ABSTRACT: data_quality float attribute

requires 'draft';

has 'data_quality' => (
    is         => 'ro',
    isa        => 'Num',
    lazy_build => 1,
);

sub _build_data_quality {
    my ($self) = @_;
    return 1 unless $self->draft;
    return 0.99 if $self->draft eq 'approved';
    return 0.75 if $self->draft eq 'contributed';
    return 0.50 if $self->draft eq 'provisional';
    return 0.25 if $self->draft eq 'unconfirmed';
    return 0;
}

no Moose::Role;
1;
