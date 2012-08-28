package Unicode::CLDR::Language;
use XML::Rabbit;

# ABSTRACT: Language names
# id = ISO 639 identifier
has_xpath_value 'id'    => './@type';
has_xpath_value 'alt'   => './@alt';
has_xpath_value 'name'  => '.';

has_xpath_value 'draft' => './@draft';
with 'Unicode::CLDR::Role::DataQuality';

finalize_class();
