package Unicode::CLDR::Territory;
use XML::Rabbit;

# ABSTRACT: Territory names, a.k.a. countries and regions

has_xpath_value 'id'    => './@type';
has_xpath_value 'alt'   => './@alt';
has_xpath_value 'name'  => '.';

finalize_class();
