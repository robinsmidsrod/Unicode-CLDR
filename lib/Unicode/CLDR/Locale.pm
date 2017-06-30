package Unicode::CLDR::Locale;

use XML::Rabbit::Root;

# ABSTRACT: Access data from a specific locale file

sub BUILD {
    my ($self) = @_;
    $self->xpc->registerFunction('string-join', sub {
        my $sep = shift;
        my @parts = grep { defined and length $_ > 0 } @_;
        return join($sep, @parts);
    });
}

# Information about the currently loaded CLDR file
has_xpath_object 'identity' => '/ldml/identity' => 'Unicode::CLDR::Identity';

# Names of spoken/written languages
has_xpath_object_list "languages" => '/ldml/localeDisplayNames/languages/language' => 'Unicode::CLDR::Language',
    handles => {
        all_languages => 'elements',
    };
has_xpath_object_map "language_map" => '/ldml/localeDisplayNames/languages/language',
    q{string-join('@', ./@type, ./@alt)} => 'Unicode::CLDR::Language',
    handles => {
        get_language => 'get',
        language_ids => 'keys',
    };

# Names of locations/regions around the world
has_xpath_object_list "territories" => '/ldml/localeDisplayNames/territories/territory' => 'Unicode::CLDR::Territory',
    handles => {
        all_territories => 'elements',
    };
has_xpath_object_map "territory_map" => '/ldml/localeDisplayNames/territories/territory',
    q{string-join('@', ./@type, ./@alt)} => 'Unicode::CLDR::Territory',
    handles => {
        get_territory => 'get',
        territory_ids => 'keys',
    };

# Names of writing systems used by different languages
has_xpath_object_list "scripts" => '/ldml/localeDisplayNames/scripts/script' => 'Unicode::CLDR::Script',
    handles => {
        all_scripts => 'elements',
    };
has_xpath_object_map "script_map" => '/ldml/localeDisplayNames/scripts/script',
    q{string-join('@', ./@type, ./@alt)} => 'Unicode::CLDR::Script',
    handles => {
        get_script => 'get',
        script_ids => 'keys',
    };

finalize_class();

