package Unicode::CLDR::Locale;
use XML::Rabbit::Root;

# ABSTRACT: Access data from a specific locale file

has_xpath_object 'identity' => '/ldml/identity' => 'Unicode::CLDR::Identity';

has_xpath_object_list "languages" => '/ldml/localeDisplayNames/languages/language' => 'Unicode::CLDR::Language',
    handles => {
        all_languages => 'elements',
    };
has_xpath_object_map "language_map" => '/ldml/localeDisplayNames/languages/language',
    './@type' => 'Unicode::CLDR::Language',
    handles => {
        get_language => 'get',
        language_ids => 'keys',
    };


has_xpath_object_list "territories" => '/ldml/localeDisplayNames/territories/territory' => 'Unicode::CLDR::Territory',
    handles => {
        all_territories => 'elements',
    };
has_xpath_object_map "territory_map" => '/ldml/localeDisplayNames/territories/territory',
    './@type' => 'Unicode::CLDR::Territory',
    handles => {
        get_territory => 'get',
        territory_ids => 'keys',
    };

finalize_class();

