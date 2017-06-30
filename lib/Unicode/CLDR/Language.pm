package Unicode::CLDR::Language;

use XML::Rabbit;

# ABSTRACT: Language names

has_xpath_value 'type'  => './@type';
has_xpath_value 'alt'   => './@alt';
with 'Unicode::CLDR::Role::ComputedIdAttribute';

has_xpath_value 'name'  => '.';

has_xpath_value 'draft' => './@draft';
with 'Unicode::CLDR::Role::DataQuality';

finalize_class();
