package Unicode::CLDR::Script;

use XML::Rabbit;

# ABSTRACT: Script names, a.k.a. writing systems

has_xpath_value 'type'  => './@type';
has_xpath_value 'alt'   => './@alt';
with 'Unicode::CLDR::Role::ComputedIdAttribute';

has_xpath_value 'name'  => '.';

finalize_class();
