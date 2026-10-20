# c4profiles — reconstructed outline of CrossOver 26.3 lib/python/c4profiles.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Defines classes to represent and manipulate the C4 profile information."""
import os
import re
import iso8601
import cxproduct
import cxconfig
import cxlog
import cxurlget
import cxutils
import distversion
from cxutils import cxgettext as _
UNKNOWN = 'com.codeweavers.unknown'
LANGUAGES = {'': _('Default'), 'af': _('Afrikaans'), 'ar': _('Arabic'), 'as': _('Assamese'), 'az': _('Azerbaijani'), 'be': _('Belarusian'), 'bg': _('Bulgarian'), 'bn': _('Bengali'), 'ca': _('Catalan'), 'cs': _('Czech'), 'da': _('Danish'), 'de': _('German'), 'el': _('Greek'), 'en': _('English'), 'en-au': _('English (Australia)'), 'en-bz': _('English (Belize)'), 'en-ca': _('English (Canada)'), **{'en-gb': _('English (Great Britain)'), 'en-ie': _('English (Ireland)'), 'en-jm': _('English (Jamaica)'), 'en-nz': _('English (New Zealand)'), 'en-ph': _('English (Philippines)'), 'en-tt': _('English (Trinidad & Tobago)'), 'en-us': _('English (USA)'), 'en-za': _('English (South Africa)'), 'en-zw': _('English (Zimbabwe)'), 'es': _('Spanish'), 'es-mx': _('Spanish (Mexico)'), 'et': _('Estonian'), 'eu': _('Basque'), 'fa': _('Farsi'), 'fi': _('Finnish'), 'fo': _('Faroese'), 'fr': _('French')}, **{'gd': _('Gaelic'), 'gu': _('Gujarati'), 'he': _('Hebrew'), 'hi': _('Hindi'), 'hr': _('Croatian'), 'hu': _('Hungarian'), 'hy': _('Armenian'), 'id': _('Indonesian'), 'is': _('Icelandic'), 'it': _('Italian'), 'ja': _('Japanese'), 'ka': _('Georgian'), 'kk': _('Kazakh'), 'kn': _('Kannada'), 'ko': _('Korean'), 'ky': _('Kirghiz'), 'lt': _('Lithuanian')}, **{'lv': _('Latvian'), 'mk': _('Macedonian'), 'ml': _('Malayalam'), 'mn': _('Mongolian (Cyrillic)'), 'mr': _('Marathi'), 'ms': _('Malay (Malaysia)'), 'mt': _('Maltese'), 'nb': _('Norwegian (Bokmål)'), 'ne': _('Nepali (India)'), 'nl': _('Dutch'), 'no': _('Norwegian'), 'or': _('Odia'), 'pa': _('Punjabi'), 'pl': _('Polish'), 'pt': _('Portuguese (Portugal)'), 'pt-br': _('Portuguese (Brazil)'), 'rm': _('Romansh')}, **{'ro': _('Romanian'), 'ru': _('Russian'), 'sa': _('Sanskrit'), 'sb': _('Sorbian'), 'sk': _('Slovak'), 'sl': _('Slovenian'), 'sq': _('Albanian'), 'sr': _('Serbian (Latin)'), 'st': _('Southern Sotho'), 'sv': _('Swedish'), 'sw': _('Swahili'), 'syr': _('Syriac'), 'ta': _('Tamil'), 'te': _('Telugu'), 'th': _('Thai'), 'tn': _('Tswana'), 'tr': _('Turkish')}, **{'ts': _('Tsonga'), 'tt': _('Tatar'), 'uk': _('Ukrainian'), 'ur': _('Urdu'), 'uz': _('Uzbek'), 'vi': _('Vietnamese'), 'xh': _('Xhosa'), 'yi': _('Yiddish'), 'zh': _('Chinese'), 'zh-cn': _('Chinese (Simplified)'), 'zh-hk': _('Chinese (Hong Kong SAR)'), 'zh-sg': _('Chinese (Singapore)'), 'zh-tw': _('Chinese (Traditional)'), 'zu': _('Zulu')}}
RATING_DESCRIPTIONS = {5: _('Runs Great'), 4: _('Runs Well'), 3: _('Limited Functionality'), 2: _('Installs, Will Not Run'), 1: _('Will Not Install'), 0: _('Untested'), -1: _('Untrusted')}
ENVIRONMENT_VARIABLES = ('accessories', 'allusersprofile', 'appdata', 'comspec', 'desktop', 'programfiles', 'programfiles64', 'programw6432',...
_localized_categories_seq = {'Component': (_('Non-Applications'), _('Components')), 'Component/Font': (_('Non-Applications'), _('Components'), _('Fonts')), 'Component/Fonts': (_('Non-Applications'), _('Components'), _('Fonts')), 'Component/Service Pack': (_('Non-Applications'), _('Components'), _('Service Packs')), 'Educational Software & CBT': (_('Educational'),), 'Educational': (_('Educational'),), 'Games': (_('Games'),), 'Games/1st Person Shooter': (_('Games'), _('First Person Shooter')), 'Games/Action Games': (_('Games'), _('Action Games')), 'Games/Adventures': (_('Games'), _('Adventure Games')), 'Games/Adventure Games': (_('Games'), _('Adventure Games')), 'Games/Adventures/Visual Novels': (_('Games'), _('Adventure Games'), _('Visual Novels')), 'Games/Adventure Games/Visual Novels': (_('Games'), _('Adventure Games'), _('Visual Novels')), 'Games/Casual Games': (_('Games'), _('Casual Games')), 'Games/DOS Games': (_('Games'), _('DOS Games')), 'Games/Educational games & children': (_('Games'), _('Educational Games')), 'Games/Educational Games': (_('Games'), _('Educational Games')), **{'Games/Emulators': (_('Games'), _('Emulators')), 'Games/Fighting Games': (_('Games'), _('Fighting Games')), 'Games/First Person Shooter': (_('Games'), _('First Person Shooter')), 'Games/Fun Stuff': (_('Games'), _('Fun Stuff')), 'Games/Fun stuff': (_('Games'), _('Fun Stuff')), 'Games/Game Tools': (_('Games'), _('Game Tools')), 'Games/Online (MMORPG) Games': (_('Games'), _('Online Games')), 'Games/Online Games': (_('Games'), _('Online Games')), 'Games/Puzzle Games': (_('Games'), _('Puzzle Games')), 'Games/Racing Games': (_('Games'), _('Racing Games')), 'Games/Rhythm Games': (_('Games'), _('Rhythm Games')), 'Games/Role Playing Games': (_('Games'), _('Role Playing Games')), 'Games/Simulation Games': (_('Games'), _('Simulation Games')), 'Games/Sports Games': (_('Games'), _('Sports Games')), 'Games/Survival Games': (_('Games'), _('Survival Games')), 'Games/Strategy Games': (_('Games'), _('Strategy Games')), 'Multimedia': (_('Multimedia'),)}, **{'Multimedia/Audio': (_('Multimedia'), _('Audio')), 'Multimedia/Audio/Audio Players': (_('Multimedia'), _('Audio'), _('Audio Players')), 'Multimedia/Audio/Music Composition': (_('Multimedia'), _('Audio'), _('Music Composition')), 'Multimedia/Audio/Sound Editing': (_('Multimedia'), _('Audio'), _('Sound Editing')), 'Multimedia/Graphics': (_('Multimedia'), _('Graphics')), 'Multimedia/Graphics/Animation, Rendering & 3D': (_('Multimedia'), _('Graphics'), _('Animation, Rendering & 3D')), 'Multimedia/Graphics/Graphics Editing': (_('Multimedia'), _('Graphics'), _('Photo Editing')), 'Multimedia/Graphics/Graphics Viewer': (_('Multimedia'), _('Graphics'), _('Graphics Viewer')), 'Multimedia/Graphics/Photo Editing': (_('Multimedia'), _('Graphics'), _('Photo Editing')), 'Multimedia/Media Players': (_('Multimedia'), _('Media Players')), 'Multimedia/Music Composition': (_('Multimedia'), _('Music Composition')), 'Multimedia/Photo Editing': (_('Multimedia'), _('Photo Editing')), 'Multimedia/Video': (_('Multimedia'), _('Video')), 'Multimedia/Video/Video Editing': (_('Multimedia'), _('Video'), _('Video Editing')), 'Multimedia/Video Editing': (_('Multimedia'), _('Video Editing')), 'Networking & Communication': (_('Networking & Communication'),), 'Networking & Communication/Browsers': (_('Networking & Communication'), _('Browsers'))}, **{'Networking & Communication/Chat, Instant Messaging & Telephony': (_('Networking & Communication'), _('Chat & Instant Messaging')), 'Networking & Communication/Chat & Instant Messaging': (_('Networking & Communication'), _('Chat & Instant Messaging')), 'Networking & Communication/Email, News & Groupware': (_('Networking & Communication'), _('Email & News Readers')), 'Networking & Communication/Email & News': (_('Networking & Communication'), _('Email & News Readers')), 'Networking & Communication/Email & News Readers': (_('Networking & Communication'), _('Email & News Readers')), 'Networking & Communication/File transfer & Sharing': (_('Networking & Communication'), _('File Transfer & Sharing')), 'Networking & Communication/File Transfer & Sharing': (_('Networking & Communication'), _('File Transfer & Sharing')), 'Networking & Communication/Net Tools': (_('Networking & Communication'), _('Net Tools')), 'Networking & Communication/Remote Access': (_('Networking & Communication'), _('Remote Access')), 'Non Applications': (_('Non-Applications'),), 'Non Applications/CrossTie Snippets': (_('Non-Applications'), _('CrossTie Snippets')), 'Non-Applications': (_('Non-Applications'),), 'Non-Applications/CrossTie Snippets': (_('Non-Applications'), _('CrossTie Snippets')), 'Non-Applications/Components': (_('Non-Applications'), _('Components')), 'Non-Applications/Components/Fonts': (_('Non-Applications'), _('Components'), _('Fonts')), 'Non-Applications/Components/Service Packs': (_('Non-Applications'), _('Components'), _('Service Packs')), 'Productivity': (_('Productivity'),)}, **{'Productivity/Database': (_('Productivity'), _('Database')), 'Productivity/Defect Tracking & Help Desk': (_('Productivity'), _('Project Tracking & Help Desk')), 'Productivity/Desktop Publishing': (_('Productivity'), _('Desktop Publishing')), 'Productivity/Finance, Accounting & Project': (_('Productivity'), _('Finance & Accounting')), 'Productivity/Finance & Accounting': (_('Productivity'), _('Finance & Accounting')), 'Productivity/Project Tracking & Help Desk': (_('Productivity'), _('Project Tracking & Help Desk')), 'Productivity/Legal & law': (_('Productivity'), _('Legal & Law')), 'Productivity/Legal & Law': (_('Productivity'), _('Legal & Law')), 'Productivity/Office Suites': (_('Productivity'), _('Office Suites')), 'Productivity/Office Utilities': (_('Productivity'), _('Office Utilities')), 'Productivity/Presentation': (_('Productivity'), _('Spreadsheet & Presentation')), 'Productivity/Spreadsheet & Presentation': (_('Productivity'), _('Spreadsheet & Presentation')), 'Productivity/Spreadsheet': (_('Productivity'), _('Spreadsheet & Presentation')), 'Productivity/Text Editors': (_('Productivity'), _('Text Editors & Document Viewers')), 'Productivity/Text Editors & Document Viewers': (_('Productivity'), _('Text Editors & Document Viewers')), 'Productivity/Web Design': (_('Productivity'), _('Web Design')), 'Productivity/Word Processing': (_('Productivity'), _('Word Processing'))}, **{'Programming & Software Engineering': (_('Programming & Development Tools'),), 'Programming & Development Tools': (_('Programming & Development Tools'),), 'Reference, Documentation & Info': (_('Reference, Documentation & Informational'),), 'Reference, Documentation & Informational': (_('Reference, Documentation & Informational'),), 'Reference, Documentation & Informational/Cooking & Nutrition': (_('Reference, Documentation & Informational'), _('Cooking & Nutrition')), 'Reference, Documentation & Informational/Religious Studies': (_('Reference, Documentation & Informational'), _('Religious Studies')), 'Reference, Documentation & Informational/Foreign Language & Speech': (_('Reference, Documentation & Informational'), _('Foreign Language & Speech')), 'Reference, Documentation & Informational/Genealogy': (_('Reference, Documentation & Informational'), _('Genealogy')), 'Scientific, Technical & Math': (_('Scientific, Technical & Math'),), 'Scientific, Technical & Math/Astronomy': (_('Scientific, Technical & Math'), _('Astronomy & Weather')), 'Scientific, Technical & Math/Astronomy & Weather': (_('Scientific, Technical & Math'), _('Astronomy & Weather')), 'Scientific, Technical & Math/Biology': (_('Scientific, Technical & Math'), _('Biology & Chemistry')), 'Scientific, Technical & Math/Biology & Chemistry': (_('Scientific, Technical & Math'), _('Biology & Chemistry')), 'Scientific, Technical & Math/CAD & CAE': (_('Scientific, Technical & Math'), _('CAD & EDA')), 'Scientific, Technical & Math/CAD & EDA': (_('Scientific, Technical & Math'), _('CAD & EDA')), 'Scientific, Technical & Math/Chemistry': (_('Scientific, Technical & Math'), _('Biology & Chemistry')), 'Scientific, Technical & Math/EDA': (_('Scientific, Technical & Math'), _('CAD & EDA'))}, **{'Scientific, Technical & Math/Flowchart, Diagramming & Graphs': (_('Scientific, Technical & Math'), _('Flowchart, Diagramming & Graphs')), 'Scientific, Technical & Math/Mapping & GPS': (_('Scientific, Technical & Math'), _('Mapping & GPS')), 'Scientific, Technical & Math/Mathematics': (_('Scientific, Technical & Math'), _('Mathematics')), 'Special Purpose': (_('Special Purpose'),), 'Special Purpose/Crafting': (_('Special Purpose'), _('Crafting')), 'Special Purpose/Health & Medical': (_('Special Purpose'), _('Health & Medical')), 'Special Purpose/Device-Specific Interfaces': (_('Special Purpose'), _('Device-Specific Interfaces')), 'Unknown': (_('Unknown'),), 'Utilities': (_('Utilities'),), 'Utilities/Compression': (_('Utilities'), _('Compression & Conversion')), 'Utilities/Compression & Conversion': (_('Utilities'), _('Compression & Conversion')), 'Utilities/File System': (_('Utilities'), _('File System')), 'Utilities/Catalog & Inventory': (_('Utilities'), _('Catalog & Inventory')), 'Utilities/Disc Burning': (_('Utilities'), _('Disc Burning'))}}
# <unparsed CALL at offset 6340>
# <unparsed CALL at offset 6348>
# <unparsed STORE_NAME at offset 6356>
def tie_product():
    # globals: cxproduct
    # attributes: this_product
    # strings: 'productid', 'CrossOver', 'cxoffice', 'cxpreview'
    ...

_RESTRICTED_GLOB_RE = re.compile('(?:^|/)\\.[.?*]+(?:/|$)')
def _validate_file_globs(globs, location):
    """Check that the file globs don't try to escape the directory they are
applied to.

We do that by simply forbidding any path component that could match '..'.
"""
    # globals: _RESTRICTED_GLOB_RE, AttributeError
    # attributes: search
    # strings: "invalid file glob '", "' in "
    ...

def _validate_file_paths(paths, location):
    """Check that the file paths don't try to escape the directory they are
applied to.
"""
    # globals: _RESTRICTED_GLOB_RE, AttributeError
    # attributes: search
    # strings: "invalid file path '", "' in "
    ...

def _validate_regular_expression(pattern, location, allow_empty=True):
    # globals: re, AttributeError
    # attributes: match, error
    # strings: '', 'the ', ' regular expression for ', ' is overly broad', ' is an invalid regular expression for '
    ...

def _validate_language_field(field):
    # attributes: values
    ...

_CXDIAG_CHECK_RE = re.compile('^(?:AppRequire:|AppRecommend:|Ignore:|Closed$)', re.IGNORECASE)
def _validate_cxdiag_checks(cxdiag_checks, location):
    """Check that the format of the cxdiag_check fields is correct.

Note that this does not verify that the specified issue is known since
old CrossOver versions should just ignore new issues.
"""
    # globals: _CXDIAG_CHECK_RE, AttributeError, _validate_regular_expression
    # attributes: search
    # strings: "invalid cxdiag_check '", "' in "
    ...

def _dump_value(out, indent, value):
    # globals: hasattr, type, repr
    # attributes: write, dump
    # strings: 'dump', ' %s\n', '| '
    ...

def _dump_fields(out, indent, obj, fields):
    # globals: isinstance, dict, sorted, _dump_value, list, enumerate
    # attributes: __dict__, write
    # strings: '{', '} =', '%s%s[%d] =', ' ='
    ...

def _copy_value(value):
    # globals: AttributeError, type, list
    # attributes: copy
    ...

def _copy_values(attributes):
    # globals: _copy_value
    # attributes: items
    # strings: 'parent'
    ...

def _update_value(this, oth):
    # globals: AttributeError, type, list
    # attributes: update, extend
    ...

def _update_values(attributes, others, exclude=(), special=()):
    # globals: type, _update_value, _copy_value
    # attributes: items
    ...

def _update_html(this, oth):
    # strings: '<br/>'
    ...

def _update_html_dict(this, oth):
    # globals: _update_values, str, _update_html
    ...

class C4Condition:
    """Represents a boolean expression."""
    def is_true(self, _properties):
        # globals: NotImplementedError
        ...


class C4ConditionUnary(C4Condition):
    """A condition node with a single sub-node."""
    child = None
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError
        # attributes: __dict__, child, validate
        # strings: 'child', 'C4ConditionUnary.child is not set for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def is_true(self, properties):
        # attributes: child, is_true
        ...


class C4ConditionNot(C4ConditionUnary):
    """Inverts the value of the child condition node."""
    def is_true(self, properties):
        # attributes: child, is_true
        ...


class C4ConditionNary(C4Condition):
    """A condition node that merges the result of multiple condition subnodes.
    """
    children = []
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError
        # attributes: children, validate
        # strings: 'C4ConditionNary.children is empty for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def is_true(self, properties):
        # globals: NotImplementedError
        ...


class C4ConditionAnd(C4ConditionNary):
    """Returns True if all the children nodes evaluate to True."""
    def is_true(self, properties):
        # attributes: children, is_true
        ...


class C4ConditionOr(C4ConditionNary):
    """Returns False if all the children nodes evaluate to False."""
    def is_true(self, properties):
        # attributes: children, is_true
        ...


class C4ConditionCompare(C4Condition):
    """Returns True if the specified property has the expected value."""
    OPERATORS = frozenset(('equal', 'lt', 'le', 'ge', 'gt'))
    name = None
    value = None
    def __init__(self, operator):
        # globals: C4Condition, C4ConditionCompare, AttributeError
        # attributes: __init__, OPERATORS, operator
        # strings: 'unknown operator %s'
        ...

    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError
        # attributes: __dict__
        # strings: 'name', 'C4ConditionCompare.name is not set for application %s', 'value', 'C4ConditionCompare.value is not set for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def is_true(self, properties):
        # attributes: operator, get, name, value
        # strings: 'equal', '', 'lt', 'le', 'ge'
        ...


class C4ConditionMatch(C4Condition):
    """Returns True if the specified property matches the given regular expression."""
    name = None
    regexp = None
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError
        # attributes: __dict__
        # strings: 'name', 'C4ConditionMatch.name is not set for application %s', 'regexp', 'C4ConditionMatch.regexp is not set for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def is_true(self, properties):
        # globals: re, cxlog
        # attributes: match, regexp, get, name, error, warn, debug_str
        # strings: '', 'useif match pattern ', ' for name ', ' is an invalid regular expression'
        ...


class C4CDGlob:
    """Contains a specific glob for detecting an application CD."""
    glob = None
    patterns = tuple()
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError, _validate_file_globs, _validate_regular_expression
        # attributes: __dict__, glob, patterns
        # strings: 'glob', 'C4CDGlob.glob is not set for application %s', 'the C4CDGlob.glob field of %s', 'the C4CDGlob.patterns field of %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4CDProfile:
    """Contains the C4 CD Profile information."""
    parent = None
    globs = None
    def copy(self):
        # globals: C4CDProfile, _copy_values
        # attributes: __dict__, update
        ...

    def update(self, oth):
        # globals: _update_values
        # attributes: __dict__
        ...

    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError
        # attributes: parent, globs, validate
        # strings: 'C4CDProfile.parent is not set for application %s', 'C4CDProfile.globs is not set for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4RegistryGlob:
    """Contains a specific registry glob for detecting an installed
application.
"""
    value_pattern = ''
    data_pattern = ''
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError, _validate_regular_expression
        # attributes: __dict__, value_pattern, data_pattern
        # strings: 'key_glob', 'C4RegistryGlob.key_glob is not set for application %s', 'the C4RegistryGlob.value_pattern field of %s', '', 'C4RegistryGlob.data_pattern is set but not the corresponding value_pattern for application %s', 'the C4RegistryGlob.data_pattern field of %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4ApplicationProfile:
    """Contains the C4 Application Profile information."""
    ALL_MEDALS = set(('gold', 'silver', 'bronze', 'ungold', 'unsilver', 'unbronze', 'knownnottowork', 'untested', 'untrusted'))
    SUPPORTED_MEDALS = ['gold', 'silver', 'bronze']
    UNSUPPORTED_MEDALS = ['ungold', 'unsilver', 'unbronze']
    UNTRUSTED_MEDAL = 'untrusted'
    parent = None
    _description = {'': ''}
    _medalcache = 'empty'
    raw_category = None
    _category = None
    medals = tuple()
    flags = set()
    installer_id = None
    installed_key_pattern = None
    installed_display_pattern = None
    installed_registry_globs = tuple()
    installed_file_globs = tuple()
    _bottle_types = {'use': ('win10_64', 'win10', 'win7', 'win7_64', 'win11_64', 'winxp', 'winxp_64', 'win8', 'win8_64', 'winvista', 'winvista_64..., 'install': ()}
    application_group = ''
    download_urls = {}
    download_urls_64bit = {}
    download_page_urls = {}
    _download_globs = tuple()
    _auto_download_globs = None
    extra_fors = set()
    steamid = None
    def copy(self):
        # globals: C4ApplicationProfile, _copy_values
        # attributes: __dict__, update
        ...

    def update(self, oth):
        # globals: _update_values
        # attributes: __dict__
        ...

    def validate(self, app_name):
        """Checks that all the mandatory fields have been set on this profile
and in the connected profiles.
"""
        # globals: AttributeError, _validate_language_field, _validate_regular_expression, _validate_file_globs, cxlog
        # attributes: parent, _description, category, medals, validate, trusted, UNTRUSTED_MEDAL, medal, installed_key_pattern, installed_display_pattern, installed_registry_globs, installed_file_globs, to_str, _download_globs
        # strings: 'C4ApplicationProfile.parent is not set for application %s', 'C4ApplicationProfile has no default description for application %s', 'C4ApplicationProfile.category is not set for application %s', 'the C4ApplicationProfile.installed_key_pattern field of %s', 'the C4ApplicationProfile.installed_display_pattern field of %s', 'the installed_file_globs field of %s', 'the download_globs field of %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def _getdescription(self):
        """Returns the application description in the current language.

If no description is available for the current language, then the
default description is returned.
"""
        # globals: cxutils
        # attributes: get_language_value, _description
        ...

    description = property(_getdescription)
    def _get_download_page_url(self):
        """Returns the download page url for the current language.

If no url is available for the current language, then the
default url is returned.
"""
        # globals: cxutils
        # attributes: download_page_urls, get_language_value
        ...

    download_page_url = property(_get_download_page_url)
    @staticmethod
    def _get_platform():
        """Ratings for Chrome OS are stored as "Android" for historical reasons."""
        # globals: cxproduct, distversion
        # attributes: is_crostini, PLATFORM
        # strings: 'Android'
        ...

    def _getmedal(self):
        """Returns the application medal for the current platform."""
        # globals: cxutils, C4ApplicationProfile, supported_list
        # attributes: _medalcache, version_as_tuple, medals, platform, _get_platform, version, split_version, medal, SUPPORTED_MEDALS, UNSUPPORTED_MEDALS, ids, parent, appid, index
        # strings: 'empty'
        ...

    def _getmedal_rank(self):
        """Returns the most applicable medal rank (gold, silver, etc.)"""
        # attributes: _getmedal, medal
        # strings: 'untested'
        ...

    _medal = property(_getmedal_rank)
    def _getmedal_date(self):
        # attributes: _getmedal, timestamp
        # strings: ''
        ...

    medal_date = property(_getmedal_date)
    def _getmedal_rating(self):
        """Returns the most applicable star rating (0..5)"""
        # attributes: parent, trusted, _getmedal, rating
        ...

    medal_rating = property(_getmedal_rating)
    def _getmedal_version(self):
        # attributes: _getmedal, version
        ...

    medal_version = property(_getmedal_version)
    def _getmedal_count(self):
        # attributes: _getmedal, number
        ...

    medal_count = property(_getmedal_count)
    def _get_rating_description(self):
        # globals: RATING_DESCRIPTIONS
        # attributes: medal_rating
        ...

    rating_description = property(_get_rating_description)
    def _getis_supported(self):
        """Returns true if the application is supported."""
        # globals: C4ApplicationProfile, KeyError
        # attributes: parent, trusted, _medal, SUPPORTED_MEDALS
        ...

    is_supported = property(_getis_supported)
    def _getis_virtual(self):
        # attributes: flags
        # strings: 'virtual'
        ...

    is_virtual = property(_getis_virtual)
    def _getbottle_types(self):
        # globals: cxproduct
        # attributes: _bottle_types, items, endswith, get_config_boolean, append
        # strings: '_64', 'OfficeSetup', 'Enable32BitBottles'
        ...

    bottle_types = property(_getbottle_types)
    def _getpreferred_bottle_type(self):
        """Returns the profile's preferred bottle type."""
        # attributes: bottle_types
        # strings: 'use'
        ...

    preferred_bottle_type = property(_getpreferred_bottle_type)
    _GLOB_VERSION_RE = re.compile('[^0-9](?!32_)[1-9][0-9]*(?P<subver>(?:[_.][ab]?[0-9]+(?:[ab](?=[._-]))?)+)[^0-9]')
    _GLOB_DEMO_RE = re.compile('\\*?[.-_]?(?:demo|downloader|full)(?=[0-9._-])', re.IGNORECASE)
    def _getdownload_globs(self):
        # globals: set, cxurlget, cxutils, os, C4ApplicationProfile, len
        # attributes: _download_globs, _auto_download_globs, download_urls, download_urls_64bit, items, url_to_basename, is_valid_windows_filename, lower, path, splitext, _GLOB_VERSION_RE, finditer, start, end, _GLOB_DEMO_RE, sub, append, add
        # strings: '', 'subver', '*'
        ...

    download_globs = property(_getdownload_globs)
    def _get_category(self):
        # globals: _localized_categories, cxlog
        # attributes: _category, get, raw_category, warn, to_str
        # strings: 'category %s has no localized category name'
        ...

    category = property(_get_category)

UNIX_ENVIRONMENT_BLACKLIST = frozenset(('IFS', 'LD_LIBRARY_PATH', 'PATH'))
class C4EnvVar:
    """Describes an environment variable to set."""
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError, UNIX_ENVIRONMENT_BLACKLIST, distversion
        # attributes: __dict__, PLATFORM
        # strings: 'name', 'C4Environment.name is not set for application %s', "Modifying the '", "' ", ' environment variable is not allowed for application ', 'value', 'C4Environment.value is not set for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4FilesToCopy:
    """Specifies a set of files to copy."""
    glob = None
    destination = None
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError, _validate_file_globs, _validate_file_paths
        # attributes: __dict__, glob, destination
        # strings: 'glob', 'C4FilesToCopy.glob is not set for application %s', 'the C4FilesToCopy.glob field of %s', 'destination', 'C4FilesToCopy.destination is not set for application %s', 'the C4FilesToCopy.destination field of %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4RegistryValue:
    """Specifies a registry value to set."""
    def validate(self, app_name, key):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError
        # attributes: __dict__
        # strings: 'name', 'C4RegistryValue.name is not set for ', ' in application ', 'data', 'C4RegistryValue.data is not set for '
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4Registry:
    """Specifies a set of registry values to set."""
    key = None
    values = tuple()
    ROOT_KEYS = frozenset(('HKEY_CLASSES_ROOT', 'HKCR', 'HKEY_CURRENT_USER', 'HKCU', 'HKEY_LOCAL_MACHINE', 'HKLM', 'HKEY_USERS', 'HKU'))
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError
        # attributes: key, split, ROOT_KEYS, values, validate
        # strings: 'C4Registry.key is not set for application %s', '\\', 'C4Registry.key ', ' contains no backslashes for application ', ' has an invalid root key for application '
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4LnkFile:
    """Specifies a wnidows shortcut to create."""
    shortcut = None
    target = None
    workdir = ''
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set."""
        # globals: AttributeError, _validate_file_paths
        # attributes: __dict__, shortcut, target
        # strings: 'shortcut', 'C4LnkFile.shortcut is not set for application %s', 'target', 'C4LnkFile.target is not set for ', ' in application ', 'the C4LnkFile shortcut or target fields of %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4InstallerProfile:
    """Contains the C4 Installer Profile information."""
    parent = None
    appid = None
    use_if = None
    _installation_notes = None
    udf_remount_check = ''
    local_installer_file_globs = tuple()
    pre_dependencies = frozenset()
    post_dependencies = frozenset()
    mainmenu_never = tuple()
    cxdiag_checks = tuple()
    installer_file_globs = tuple()
    installer_treatas = ''
    installer_options = tuple()
    installer_silent_options = tuple()
    installer_winver = ''
    installer_dlloverrides = ''
    installer_environment = tuple()
    selfextract_threshold = None
    selfextract_options = tuple()
    selfextract_silent_options = tuple()
    zip_encoding = ''
    files_to_copy = tuple()
    post_install_reboot = False
    pre_install_environment = tuple()
    pre_install_registry = tuple()
    pre_rm_fake_dlls = tuple()
    lnk_files = tuple()
    skip_menu_creation = False
    skip_assoc_creation = False
    default_eassocs = tuple()
    alt_eassocs = tuple()
    post_registerdll = tuple()
    post_install_registry = tuple()
    post_install_urls = None
    always_redownload = False
    def __init__(self):
        # globals: set
        # attributes: _installation_notes, pre_dependencies, post_dependencies, post_install_urls
        ...

    def copy(self):
        # globals: C4InstallerProfile, _copy_values
        # attributes: __dict__, update
        ...

    def update(self, oth):
        # globals: _update_values, _update_html_dict
        # attributes: __dict__
        # strings: '_installation_notes'
        ...

    def validate(self, app_name):
        """Checks that all the mandatory fields have been set on this profile
and in the connected profiles.
"""
        # globals: AttributeError, _validate_file_globs, cxlog, _validate_cxdiag_checks
        # attributes: parent, local_installer_file_globs, pre_dependencies, startswith, post_dependencies, installer_file_globs, mainmenu_never, lower, endswith, warn, cxdiag_checks, installer_environment, validate, selfextract_threshold, selfextract_options, selfextract_silent_options, files_to_copy, pre_install_registry, lnk_files, skip_menu_creation, skip_assoc_creation, default_eassocs, alt_eassocs, post_install_registry
        # strings: 'C4InstallerProfile.parent is not set for application %s', 'the local_installer_file_globs field of %s', '.', "C4InstallerProfile.pre_dependencies '", "' must not start with a dot for application ", "C4InstallerProfile.post_dependencies '", 'the installer_file_globs field of %s', '.lnk', '.url', ': C4InstallerProfile.mainmenu_never entry does not end with a recognized extension: ', '/', ': C4InstallerProfile.mainmenu_never entry should be a basename: ', 'the C4InstallerProfile.cxdiag_checks fields of %s', 'C4InstallerProfile.selfextract_options is set but no threshold has been specified for application %s', 'C4InstallerProfile.selfextract_silent_options is set but no threshold has been specified for application %s', 'C4InstallerProfile.lnk_files mainmenu_never must be empty when skip_menu_creation is True for application %s', 'C4InstallerProfile.default_eassocs and alt_eassocs must be empty when skip_assoc_creation is True for application %s', '\\', 'C4InstallerProfile.default_eassocs and alt_eassocs must must all start with a dot and not contain backslashes (', ') for application '
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def use(self, use_if_props):
        # attributes: appid, use_if, is_true
        # strings: 'appid'
        ...

    def _getinstallation_notes(self):
        """Returns the application installation notes in the current language.

If no installation notes are available for the current language, then
the default installation notes are returned.
"""
        # globals: cxutils
        # attributes: get_language_value, _installation_notes
        ...

    installation_notes = property(_getinstallation_notes)
    def _getpost_install_url(self):
        """Returns the postinstall web page to open for the current language.

If no URL is specified for the current language, then the default
URL is returned.
"""
        # globals: cxutils
        # attributes: get_language_value, post_install_urls
        ...

    post_install_url = property(_getpost_install_url)

class C4CXVersion:
    """Identifies a product plus version combination which is compatible with
the corresponding profile.
"""
    product = None
    cxversion = None
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set on this profile
and in the connected profiles.

Note that this only checks internal consistency, not consistency with
other profiles.
"""
        # globals: AttributeError
        # attributes: product, cxversion
        # strings: 'C4Profile.product is not set for application %s', 'C4Profile.cxversion is not set for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def copy(self):
        # globals: C4CXVersion, _copy_values
        # attributes: __dict__, update
        ...

    def update(self, oth):
        # globals: _update_values
        # attributes: __dict__
        ...


class C4PTimestamp:
    datetime = None
    def __init__(self, timestamp):
        # globals: iso8601
        # attributes: parse_date, datetime
        ...

    def __cmp__(self, oth):
        # globals: isinstance, C4PTimestamp, TypeError, cxutils
        # attributes: datetime, cmp
        ...

    def __lt__(self, oth):
        # attributes: __cmp__
        ...

    def __le__(self, oth):
        # attributes: __cmp__
        ...

    def __eq__(self, oth):
        # attributes: __cmp__
        ...

    def __ne__(self, oth):
        # attributes: __cmp__
        ...

    def __gt__(self, oth):
        # attributes: __cmp__
        ...

    def __ge__(self, oth):
        # attributes: __cmp__
        ...


class C4CXContributor:
    """Identifies a contributor to the profile
    """
    name = None
    userid = 0
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set on this profile
and in the connected profiles.

Note that this only checks internal consistency, not consistency with
other profiles.
"""
        # globals: AttributeError
        # attributes: name
        # strings: 'C4Profile.name is not set for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def copy(self):
        # globals: C4CXContributor, _copy_values
        # attributes: __dict__, update
        ...

    def update(self, oth):
        # globals: _update_values
        # attributes: __dict__
        ...


_medal_ratings = {'gold': 5, 'silver': 4, 'bronze': 3, 'ungold': 5, 'unsilver': 4, 'unbronze': 3, 'knownnottowork': 1, 'untested': 0, 'untrusted': -1}
class C4CXMedal:
    """Identifies a contributor to the profile
    """
    medal = None
    platform = None
    version = None
    number = 0
    timestamp = None
    raw_rating = None
    _rating = None
    def validate(self, app_name):
        """Checks that all the mandatory fields have been set on this profile
and in the connected profiles.

Note that this only checks internal consistency, not consistency with
other profiles.
"""
        # globals: AttributeError, C4ApplicationProfile
        # attributes: medal, ALL_MEDALS
        # strings: 'C4Profile._medal is not set for application %s', 'C4Profile._medal invalid medal for application %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def copy(self):
        # globals: C4CXMedal, _copy_values
        # attributes: __dict__, update
        ...

    def update(self, oth):
        # globals: _update_values
        # attributes: __dict__
        ...

    def _get_rating(self):
        # globals: C4ApplicationProfile, _medal_ratings, int
        # attributes: _rating, raw_rating, isdigit, medal, UNTRUSTED_MEDAL, get
        ...

    rating = property(_get_rating)

builtin = range(3)[0]
download = range(3)[1]
dropin = range(3)[2]
class C4Profile:
    """This is an umbrella class which ties a C4 entry's CD, Application and
Installer profiles together.

It also stores the common parts between these, that is the application id
and its name.
"""
    trusted = False
    source = builtin
    appid = None
    is_highlighted = False
    timestamp = None
    cxversions = tuple()
    localized_names = None
    contributor = tuple()
    cd_profile = None
    app_profile = None
    installer_profiles = tuple()
    def validate(self):
        """Checks that all the mandatory fields have been set on this profile
and in the connected profiles.

Note that this only checks internal consistency, not consistency with
other profiles.
"""
        # globals: AttributeError, _validate_language_field
        # attributes: appid, startswith, localized_names, cxversions, validate, name, cd_profile, app_profile, installer_profiles
        # strings: 'C4Profile.appid is not set', '.', "C4Profile.appid '%s' must not start with a dot", 'C4Profile.localized_names is not set for %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...

    def copy(self):
        # globals: C4Profile, _copy_values
        # attributes: __dict__, update, cd_profile, parent, app_profile, installer_profiles
        ...

    def update(self, oth):
        # globals: _update_values
        # attributes: __dict__, cd_profile, parent, app_profile, installer_profiles
        ...

    def _getname(self):
        """Returns the application name in the current language.

If no name is available for the current language, then the
default name is returned.
"""
        # globals: cxutils
        # attributes: get_language_value, localized_names
        ...

    name = property(_getname)
    def _version_score_for_product(self, version, product):
        # globals: dropin, cxutils, C4PTimestamp
        # attributes: product, source, cmp_versions, cxversion, subtract_version, timestamp, app_profile, medal_date
        # strings: 'productid', 'productversion'
        ...

    def score_for_product(self, product):
        """A score that defines the profile's adequation to the given
product. The lower the score the better.

Product is a dictionary containing keys named productid and version.

The result is actually a tuple of
(product_mismatch, source, old_product, version_difference, timestamp)

Where
* product_mismatch is 0 if the profile matches the current product and 1
  if it does not.
* old_product is 1 if the product is too old for this profile
* source is 0 if the profile is a dropin, 1 if it's from a builtin tie
* version_difference is a tuple of the magnitude of differences between
  components of the version numbers
* timestamp is a C4PTimestamp object representing the timestamp"""
        # globals: min
        # attributes: cxversions, _version_score_for_product
        ...

    _score = None
    def _get_score(self):
        """A score that defines the profile's adequation to the current
product. See score_for_product for the score's meaning."""
        # globals: tie_product
        # attributes: _score, score_for_product
        ...

    score = property(_get_score)
    def _is_for_current_product(self):
        """Returns True if one of the cxversion properties match the current
product (though not necessarily this version), and False otherwise.
"""
        # attributes: score
        ...

    is_for_current_product = property(_is_for_current_product)
    def _getis_ranked(self):
        # globals: dropin
        # attributes: app_profile, medal_rating, source
        ...

    is_ranked = property(_getis_ranked)
    def _getis_revoked(self):
        # globals: get_revokelist_file, cxutils, iso8601
        # attributes: string_to_str, appid, values, split, timestamp, parse_date
        # strings: '..', ''
        ...

    is_revoked = property(_getis_revoked)
    def _getdetails_url(self):
        """Returns the url to a page with more information about this profile,
or '' if there is no such page."""
        # attributes: appid, startswith, replace, isdigit
        # strings: 'com.codeweavers.c4.', '', 'http://www.codeweavers.com/compatibility/browse/name?app_id=%s'
        ...

    details_url = property(_getdetails_url)
    def _is_application(self):
        """Returns True if the application flag is set."""
        # attributes: app_profile, flags
        # strings: 'application'
        ...

    is_application = property(_is_application)
    def _is_component(self):
        """Returns True if the component flag is set."""
        # attributes: app_profile, flags
        # strings: 'component'
        ...

    is_component = property(_is_component)
    def _is_unknown(self):
        """Returns True if this is the unknown profile."""
        # globals: UNKNOWN
        # attributes: appid
        ...

    is_unknown = property(_is_unknown)

class C4HighlightedProfile:
    """Contains the identifying information of the C4Profile instances to
revoke.
"""
    appid = None
    platform = None
    def validate(self):
        """Checks that all the mandatory fields have been set on this profile.
        """
        # globals: AttributeError
        # attributes: appid, platform
        # strings: 'C4HighlightedProfile.appid is not set'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class C4RevokeProfile:
    """Contains the identifying information of the C4Profile instances to
revoke.
"""
    appid = None
    first = None
    last = None
    def validate(self):
        """Checks that all the mandatory fields have been set on this profile.
        """
        # globals: AttributeError
        # attributes: appid
        # strings: 'C4RevokeProfile.appid is not set'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class supported_list:
    _supported_list_read = False
    _supported_list = []
    @classmethod
    def ids(cls):
        # attributes: _supported_list_read, parse_supported_list, _supported_list
        ...

    @classmethod
    def parse_supported_list(cls):
        # globals: os, cxutils, open, IOError
        # attributes: path, join, CX_ROOT, strip, startswith, _supported_list, append, string_to_unicode, close
        # strings: 'share/crossover/data', '.supported', 'rt', 'ascii', '', '#'
        ...


_REVOKELIST_FILE = None
def get_revokelist_file():
    """Returns a cxconfig file used to store all the revokelist entries we've seen."""
    # globals: _REVOKELIST_FILE, cxconfig, os, cxproduct
    # attributes: File, path, join, get_user_dir
    # strings: 'tie', 'crossover.revokelist'
    ...
