# c4parser — reconstructed outline of CrossOver 26.3 lib/python/c4parser.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os.path
import time
import traceback
import xml.sax
import xml.sax.handler
import cxlog
import c4profiles
class _C4PHandler(xml.sax.handler.ContentHandler):
    autorun = None
    def __init__(self, trusted, source, disabled_licenses_only):
        # globals: xml, _C4PHandler
        # attributes: sax, handler, ContentHandler, __init__, highlightedapps, revokelist, disabled_licenses, apps, parse_errors, locator, disabled_licenses_only, _objects, state_init, _states, _skip, _key, _property, _string, _default, _trusted, _source
        ...

    def setDocumentLocator(self, locator):
        # attributes: locator
        ...

    def startElement(self, name, attrs):
        """Called when the SAX parser finds an opening XML tag, <c4p> for
instance.

This calls the startElement handler which is at the top of the state
stack. In turn this handler normally pushes a new state on top of the
state stack to handle the tags contained therein.

If the opening tag corresponds to an object, for instance <app>, then
it will also push the new object on top of the object stack.
"""
        # attributes: _states
        ...

    def endElement(self, name):
        """Called when the SAX parser finds a closing XML tag, </c4p> for
instance.

endElement() calls can always be exactly matched to a startElement()
call. If the XML file is malformed, for instance if it has a mismatched
closing tag, then the SAX parser will raise an exception rather than
call endElement() on the mismatched tag.

This calls the endElement handler which is at the top of the state
stack. This handler must always pop the state stack, and should also
pop the object stack if an object was created by the opening XML tag.
"""
        # attributes: _states
        ...

    def characters(self, content):
        """Called by the SAX parser to handle the characters in between tags.

This calls the characters handler which is at the top of the state
stack. Note that these characters may be given by the SAX parser in
arbitrarily small chunks. So it is usually necessary to concatenate
them together.
"""
        # attributes: _states
        ...

    def endDocument(self):
        # globals: len
        # attributes: _states, fail
        # strings: 'an internal error occurred: len(_states) = %d'
        ...

    def fail(self, error):
        """Reports a fatal error as a SAXParseException."""
        # globals: xml
        # attributes: sax, SAXParseException, locator
        ...

    def warn(self, message):
        """Prints a warning on stderr for non fatal format errors."""
        # globals: cxlog
        # attributes: warn, locator, getSystemId, getLineNumber, getColumnNumber, to_str
        # strings: '%s:%d:%d: %s'
        ...

    def trace(self, message):
        """Adds a trace to the c4parser channel."""
        # globals: cxlog
        # attributes: log_, locator, getSystemId, getLineNumber, getColumnNumber, to_str
        # strings: 'c4parser', '%s:%d:%d: %s'
        ...

    def _startof_unexpected(self, name, _attrs):
        # attributes: fail
        # strings: 'unexpected opening tag %s'
        ...

    def _end_simple(self, name):
        """Pops the state stack but leave the object stack as is.

This is mostly used by attribute handlers.
"""
        # globals: len, cxlog
        # attributes: trace, _objects, _states, to_str, pop
        # strings: 'objects=%d states=%d %s'
        ...

    def _end_popobj(self, name):
        """Pops the state and object stacks."""
        # globals: len, cxlog
        # attributes: trace, _objects, _states, to_str, pop
        # strings: 'objects=%d states=%d %s'
        ...

    def _endof_unexpected(self, name):
        # attributes: fail
        # strings: 'unexpected closing tag %s'
        ...

    def _unexpected_characters(self, content):
        """Warns about unexpected string snippets."""
        # globals: cxlog
        # attributes: isspace, warn, debug_str
        # strings: 'unexpected characters %s'
        ...

    def _string_characters(self, content):
        """Collects the string snippets as SAX returns them so we can
concatenate them later.
"""
        # attributes: _string, append
        ...

    def _string_unexpected(self, _content):
        # attributes: fail
        # strings: 'unexpected string content'
        ...

    def _startof_objectlist(self, prop, child, state):
        # attributes: _objects, __dict__, append, _states
        ...

    def _startof_tuplelist(self, childprop, child, attrs, prop):
        # globals: _C4PHandler, cxlog, len
        # attributes: _startof_objectlist, state_tuplelist, trace, debug_str, _property, _string, items, __dict__, _objects, _states, to_str
        # strings: 'attrs=', 'objects=%d states=%d %s'
        ...

    def _endof_tuplelist(self, _unused):
        # globals: len, cxlog
        # attributes: _objects, pop, join, _string, __dict__, _property, _states, trace, to_str
        # strings: '', 'objects=%d states=%d %s'
        ...

    state_tuplelist = (_startof_unexpected, _endof_tuplelist, _string_characters)
    FALSE_SET = set(['false', '0', ''])
    def _startof_boolean(self, prop):
        # globals: _C4PHandler, len, cxlog
        # attributes: _property, _string, _states, append, state_boolean, trace, _objects, to_str
        # strings: 'objects=%d states=%d %s'
        ...

    def _endof_boolean(self, _unused):
        # globals: cxlog, _C4PHandler, len
        # attributes: _objects, join, _string, trace, to_str, _property, debug_str, FALSE_SET, __dict__, _states, pop
        # strings: '', 'obj=', ' property=', ' value=', 'objects=%d states=%d %s'
        ...

    state_boolean = (_startof_unexpected, _endof_boolean, _string_characters)
    def _startof_integer(self, prop):
        # globals: _C4PHandler, len, cxlog
        # attributes: _property, _string, _states, append, state_integer, trace, _objects, to_str
        # strings: 'objects=%d states=%d %s'
        ...

    def _endof_integer(self, _unused):
        # globals: int, cxlog, len
        # attributes: _objects, join, _string, trace, debug_str, to_str, _property, __dict__, warn, _states, pop
        # strings: '', 'obj=', ' property=', ' value=', '%s has been set already', 'objects=%d states=%d %s'
        ...

    state_integer = (_startof_unexpected, _endof_integer, _string_characters)
    def _startof_string(self, prop, strip=False):
        # globals: _C4PHandler, len, cxlog
        # attributes: _property, _string, _strip, _states, append, state_string, trace, _objects, to_str
        # strings: 'objects=%d states=%d %s'
        ...

    def _endof_string(self, _unused):
        # globals: cxlog, len
        # attributes: _property, _objects, join, _string, _strip, strip, warn, to_str, debug_str, trace, __dict__, _states, pop
        # strings: '', ' contains leading and/or trailing spaces: ', 'obj=', ' property=', ' value=', '%s has been set already', 'objects=%d states=%d %s'
        ...

    state_string = (_startof_unexpected, _endof_string, _string_characters)
    def _startof_stringlist(self, prop, strip=False):
        # globals: _C4PHandler, len, cxlog
        # attributes: _property, _string, _strip, _states, append, state_stringlist, trace, _objects, to_str
        # strings: 'objects=%d states=%d %s'
        ...

    def _endof_stringlist(self, _unused):
        # globals: cxlog, len
        # attributes: _objects, join, _string, _strip, strip, warn, to_str, _property, debug_str, trace, __dict__, append, _states, pop
        # strings: '', ' contains leading and/or trailing spaces: ', 'obj=', ' property=', ' value=', 'objects=%d states=%d %s'
        ...

    state_stringlist = (_startof_unexpected, _endof_stringlist, _string_characters)
    def _startof_stringset(self, prop):
        # globals: _C4PHandler, len, cxlog
        # attributes: _property, _string, _states, append, state_stringset, trace, _objects, to_str
        # strings: 'objects=%d states=%d %s'
        ...

    def _endof_stringset(self, _unused):
        # globals: cxlog, set, len
        # attributes: _objects, join, _string, trace, debug_str, to_str, _property, __dict__, add, _states, pop
        # strings: '', 'obj=', ' property=', ' value=', 'objects=%d states=%d %s'
        ...

    state_stringset = (_startof_unexpected, _endof_stringset, _string_characters)
    def _startof_stringmap(self, prop, attr, attrs):
        # globals: _C4PHandler, len, cxlog
        # attributes: _property, get, _key, _string, _states, append, state_stringmap, trace, _objects, to_str
        # strings: '', 'objects=%d states=%d %s'
        ...

    def _endof_stringmap(self, _unused):
        # globals: cxlog, len
        # attributes: _objects, join, _string, trace, debug_str, to_str, _property, _key, __dict__, _states, pop
        # strings: '', 'obj=', ' property=', ' key=', ' value=', 'objects=%d states=%d %s'
        ...

    state_stringmap = (_startof_unexpected, _endof_stringmap, _string_characters)
    def _startof_skip(self, name, _attrs=None, warn=True):
        # globals: _C4PHandler
        # attributes: _skip, warn, _states, append, state_skip
        # strings: 'skipping unknown tag %s'
        ...

    def _endof_skip(self, _unused):
        # attributes: _skip, _states, pop
        ...

    def _ignore_characters(self, _content):
        ...

    state_skip = (_startof_skip, _endof_skip, _ignore_characters)
    def _childof_init(self, name, _attrs):
        # globals: _C4PHandler, len, cxlog
        # attributes: _states, append, state_c4p, trace, _objects, to_str, warn
        # strings: 'c4p', 'objects=%d states=%d %s', 'expecting c4p tag, got %s'
        ...

    state_init = (_childof_init, _endof_unexpected, _string_unexpected)
    def _childof_c4p(self, name, attrs):
        # globals: _C4PHandler, len, cxlog
        # attributes: disabled_licenses_only, _startof_skip, _states, append, state_revokelist, trace, _objects, to_str, state_highlightedapps, state_disabledlicenses, state_applications, autorun
        # strings: 'disabledlicenses', 'revokelist', 'objects=%d states=%d %s', 'highlightedapps', 'applications', 'autorun', 'appid'
        ...

    state_c4p = (_childof_c4p, _end_simple, _unexpected_characters)
    def _childof_highlightedapps(self, name, attrs):
        # globals: c4profiles, _C4PHandler
        # attributes: C4HighlightedProfile, appid, get, platform, highlightedapps, append, _states, state_highlightedapp, _startof_skip
        # strings: 'highlightedapp', 'appid', 'platform'
        ...

    state_highlightedapps = (_childof_highlightedapps, _end_simple, _unexpected_characters)
    state_highlightedapp = (_startof_unexpected, _end_simple, _unexpected_characters)
    def _childof_revokelist(self, name, attrs):
        # globals: c4profiles, _C4PHandler
        # attributes: C4RevokeProfile, appid, get, first, last, revokelist, append, _states, state_revokeapp, _startof_skip
        # strings: 'revokeapp', 'appid', 'first', 'last'
        ...

    state_revokelist = (_childof_revokelist, _end_simple, _unexpected_characters)
    state_revokeapp = (_startof_unexpected, _end_simple, _unexpected_characters)
    def _childof_disabledlicenses(self, name, _attrs):
        # attributes: _startof_stringlist, _startof_skip
        # strings: 'id', 'disabled_licenses'
        ...

    state_disabledlicenses = (_childof_disabledlicenses, _end_simple, _unexpected_characters)
    def _childof_applications(self, name, attrs):
        # globals: c4profiles, _C4PHandler, len, cxlog
        # attributes: C4Profile, appid, get, timestamp, _trusted, trusted, _source, source, apps, append, _objects, _states, state_app, trace, to_str, _startof_skip
        # strings: 'app', 'appid', 'timestamp', 'objects=%d states=%d %s'
        ...

    state_applications = (_childof_applications, _end_simple, _unexpected_characters)
    def _endof_contributor(self, _unused):
        # globals: cxlog, len
        # attributes: _objects, join, _string, trace, debug_str, to_str, _property, name, pop, _states
        # strings: '', 'obj=', ' property=', ' value=', 'objects=%d states=%d %s'
        ...

    state_contributor = (_startof_unexpected, _endof_contributor, _string_characters)
    def _childof_app(self, name, attrs):
        # globals: c4profiles, _C4PHandler, len, cxlog
        # attributes: _startof_tuplelist, C4CXVersion, _startof_stringmap, _objects, C4CXContributor, userid, __dict__, contributor, append, _string, _states, state_contributor, trace, to_str, C4ApplicationProfile, parent, app_profile, fail, state_appprofile, C4InstallerProfile, appid, installer_profiles, state_installprofile, C4CDProfile, cd_profile, state_cdprofile, _startof_skip
        # strings: 'cxversion', 'cxversions', 'name', 'localized_names', 'lang', 'contributor', 'userid', '', 'objects=%d states=%d %s', 'appprofile', 'an application profile has already been declared', 'installprofile', 'appid', 'installer_profiles', 'cdprofile', 'a cd profile has already been declared'
        ...

    def _endof_app(self, _name):
        # globals: len, AttributeError, cxlog, traceback, Exception
        # attributes: _objects, pop, validate, fail, _states, apps, appid, parse_errors, append, is_on, warn, print_exc
        # strings: 'internal error: len(_objects) = %d', ' contains errors, ignoring it: ', 'c4parser', 'an unexpected error occurred while reading the ', ' profile, ignoring it: '
        ...

    state_app = (_childof_app, _endof_app, _unexpected_characters)
    def _endof_medal(self, _unused):
        # globals: cxlog, len
        # attributes: _objects, join, _string, trace, debug_str, to_str, _property, medal, pop, _states
        # strings: '', 'obj=', ' property=', ' value=', 'objects=%d states=%d %s'
        ...

    state_medal = (_startof_unexpected, _endof_medal, _string_characters)
    def _childof_appprofile(self, name, attrs):
        # globals: c4profiles, _C4PHandler, len, cxlog
        # attributes: _startof_string, _startof_stringmap, _objects, C4CXMedal, get, platform, version, number, timestamp, raw_rating, __dict__, medals, append, _string, _states, state_medal, trace, to_str, _startof_stringset, _startof_objectlist, C4RegistryGlob, state_installedregistryglob, _startof_stringlist, _startof_bottletemplate, _startof_downloadmap, _startof_skip
        # strings: 'comment', 'description', '_description', 'lang', 'medal', 'platform', 'version', 'num', 'last', 'rating', 'medals', 'objects=%d states=%d %s', 'category', 'raw_category', 'flag', 'flags', 'installerid', 'installer_id', 'installedkeypattern', 'installed_key_pattern', 'installeddisplaypattern', 'installed_display_pattern', 'installedregistryglob', 'installed_registry_globs', 'installedfileglob', 'installed_file_globs', 'bottletemplate', 'appbottlegroup', 'application_group', 'downloadurl', 'download_urls', 'downloadurl64', 'download_urls_64bit', 'downloadpageurl', 'download_page_urls', 'downloadglob', '_download_globs', 'extrafor', 'extra_fors', 'steamid'
        ...

    state_appprofile = (_childof_appprofile, _end_popobj, _unexpected_characters)
    def _startof_downloadmap(self, prop, attrs):
        # globals: _C4PHandler, len, cxlog
        # attributes: _property, get, _key, _checksum, _string, _states, append, state_downloadmap, trace, _objects, to_str
        # strings: 'lang', '', 'checksum', 'objects=%d states=%d %s'
        ...

    def _endof_downloadmap(self, _unused):
        # globals: cxlog, len
        # attributes: _objects, join, _string, _checksum, trace, debug_str, to_str, _property, _key, __dict__, _states, pop
        # strings: '', 'obj=', ' property=', ' key=', ' value=', 'objects=%d states=%d %s'
        ...

    state_downloadmap = (_startof_unexpected, _endof_downloadmap, _string_characters)
    def _childof_installedregistryglob(self, name, _attrs):
        # attributes: _startof_string, _startof_skip
        # strings: 'key', 'key_glob', 'value', 'value_pattern', 'data', 'data_pattern'
        ...

    state_installedregistryglob = (_childof_installedregistryglob, _end_popobj, _unexpected_characters)
    def _startof_bottletemplate(self, attrs):
        # globals: _C4PHandler, len
        # attributes: _string, get, _property, _states, append, state_bottletemplate, trace, _objects
        # strings: 'purpose', '', 'use', 'install', 'objects=%d states=%d'
        ...

    def _endof_bottletemplate(self, _unused):
        # globals: cxlog, len
        # attributes: _objects, join, _string, trace, debug_str, __dict__, _property, append, _states, pop
        # strings: '', 'obj=', ' property=bottle_types value=', '_bottle_types', 'use', 'install', 'objects=%d states=%d bottle_types'
        ...

    state_bottletemplate = (_startof_unexpected, _endof_bottletemplate, _string_characters)
    def _childof_installprofile(self, name, attrs):
        # globals: c4profiles, _C4PHandler
        # attributes: _objects, __dict__, fail, C4ConditionUnary, use_if, append, _states, state_condition, _startof_string, _startof_stringmap, _startof_stringlist, _startof_stringset, _startof_objectlist, C4EnvVar, state_environment, _startof_integer, C4FilesToCopy, state_filestocopy, _startof_boolean, C4Registry, state_installregistry, C4LnkFile, state_lnkfile, _startof_skip
        # strings: 'useif', 'use_if', 'Duplicate <useif> tag', 'comment', 'installnotes', '_installation_notes', 'lang', 'udfcheck', 'udf_remount_check', 'localinstallerglob', 'local_installer_file_globs', 'predependency', 'pre_dependencies', 'postdependency', 'post_dependencies', 'cxdiagcheck', 'cxdiag_checks', 'installerglob', 'installer_file_globs', 'installertreatas', 'installer_treatas', 'installeroption', 'installer_options', 'installersilentoption', 'installer_silent_options', 'installerwinver', 'installer_winver', 'installerdlloverrides', 'installer_dlloverrides', 'installerenvironment', 'installer_environment', 'selfextractthreshold', 'selfextract_threshold', 'selfextractoption', 'selfextract_options', 'selfextractsilentoption', 'selfextract_silent_options', 'zipencoding', 'zip_encoding', 'filestocopy' ...(+29)
        ...

    state_installprofile = (_childof_installprofile, _end_popobj, _unexpected_characters)
    def _childof_condition(self, name, attrs):
        # globals: c4profiles, isinstance
        # attributes: state_condition, C4ConditionCompare, OPERATORS, name, _property, _string, state_equal, C4ConditionMatch, state_match, C4ConditionNot, C4ConditionAnd, C4ConditionOr, _startof_unexpected, _objects, C4ConditionNary, __dict__, children, append, fail, child, _states
        # strings: 'name', 'value', 'match', 'regexp', 'not', 'and', 'or', 'children', 'child', 'Too many children in a unary condition node'
        ...

    state_condition = (_childof_condition, _end_popobj, _unexpected_characters)
    state_equal = (_startof_unexpected, _endof_tuplelist, _string_characters)
    state_match = (_startof_unexpected, _endof_tuplelist, _string_characters)
    def _childof_environment(self, name, _attrs):
        # attributes: _startof_string, _startof_skip
        # strings: 'name', 'value'
        ...

    state_environment = (_childof_environment, _end_popobj, _unexpected_characters)
    def _childof_filestocopy(self, name, _attrs):
        # attributes: _startof_string, _startof_skip
        # strings: 'glob', 'dst', 'destination'
        ...

    state_filestocopy = (_childof_filestocopy, _end_popobj, _unexpected_characters)
    def _childof_installregistry(self, name, _attrs):
        # globals: c4profiles, _C4PHandler
        # attributes: _startof_string, _startof_objectlist, C4RegistryValue, state_value, _startof_skip
        # strings: 'key', 'value', 'values'
        ...

    state_installregistry = (_childof_installregistry, _end_popobj, _unexpected_characters)
    def _childof_value(self, name, _attrs):
        # attributes: _startof_string, _startof_skip
        # strings: 'name', 'data'
        ...

    state_value = (_childof_value, _end_popobj, _unexpected_characters)
    def _childof_lnkfile(self, name, _attrs):
        # attributes: _startof_string, _startof_skip
        # strings: 'shortcut', 'target', 'workdir'
        ...

    state_lnkfile = (_childof_lnkfile, _end_popobj, _unexpected_characters)
    def _childof_cdprofile(self, name, _attrs):
        # globals: c4profiles, _C4PHandler
        # attributes: _startof_string, _startof_objectlist, C4CDGlob, state_cdglob, _startof_skip
        # strings: 'comment', 'cdglob', 'globs'
        ...

    state_cdprofile = (_childof_cdprofile, _end_popobj, _unexpected_characters)
    def _childof_cdglob(self, name, _attrs):
        # attributes: _startof_string, _startof_stringlist, _startof_skip
        # strings: 'glob', 'pattern', 'patterns'
        ...

    state_cdglob = (_childof_cdglob, _end_popobj, _unexpected_characters)

class C4PFile:
    """The in-memory representation of the contents of a c4p file."""
    def __init__(self, filename, trusted, source):
        # globals: c4profiles
        # attributes: mtime, mtime_disabled_licenses, _filename, _highlightedapps, _revokelist, _disabledlicenses, _profiles, _autorun, _trusted, _source, _updatedonce, dropin, update
        ...

    def update(self, disabled_licenses_only=False):
        """Updates the C4PFile object if the file has changed since it was last
read.

Returns the mtime of file, or None if an error arises during parsing.
"""
        # globals: c4profiles, os, OSError
        # attributes: _source, dropin, _updatedonce, mtime, path, getmtime, _filename, mtime_disabled_licenses, _parse_file
        ...

    def _parse_file(self, disabled_licenses_only):
        """Reads the CrossTie file and returns True on success, False otherwise."""
        # globals: time, _C4PHandler, xml, cxlog, KeyError, traceback, Exception, type
        # attributes: time, _trusted, _source, sax, parse, _filename, parse_errors, warn, highlightedapps, _highlightedapps, revokelist, _revokelist, disabled_licenses, _disabledlicenses, apps, _profiles, autorun, _autorun, log, to_str, is_on, print_exc, SAXException, __name__
        # strings: "parsing '%s' took %0.3fs", "could not read '", "': missing ", ' attribute', 'c4parser', 'could not read the CrossTie: %s', "': unexpected ", ' exception: '
        ...

    def get_autorun_id(self):
        """Returns the application id of the profile that should be selected
when this file is loaded, or None. If no autorun profile is specified
and this file contains profiles for only one appid, use that id."""
        # attributes: autorun, profiles, appid
        ...

    def get_supported_product_ids(self):
        """Returns a set of product id strings of products that this file
supports."""
        # globals: set
        # attributes: get_autorun_id, profiles, appid, append, setdefault, cxversions, add, product, values, copy, intersection_update
        ...

    def _useful_for_current_product(self):
        # globals: c4profiles
        # attributes: tie_product, get_supported_product_ids
        # strings: 'productid'
        ...

    useful_for_current_product = property(_useful_for_current_product)
    def _getfilename(self):
        """Returns this CrossTie's filename."""
        # attributes: _filename
        ...

    filename = property(_getfilename)
    def _gettrusted(self):
        """Returns True if this CrossTie file is trusted."""
        # attributes: _trusted
        ...

    trusted = property(_gettrusted)
    def _getsource(self):
        """Returns this CrossTie's source category."""
        # attributes: _source
        ...

    source = property(_getsource)
    def _getmalware_appid(self):
        """Returns an appid of a malicious profile, if this file is considered
malicious overall."""
        # attributes: get_autorun_id, profiles, appid, is_revoked
        ...

    malware_appid = property(_getmalware_appid)
    def _gethighlightedapps(self):
        """Returns a list of highlighted applications contained in the c4p
file.
"""
        # attributes: update, _highlightedapps
        ...

    highlightedapps = property(_gethighlightedapps)
    def _getrevokelist(self):
        """Returns a list of the profile revocations contained in the c4p
file.
"""
        # attributes: update, _revokelist
        ...

    revokelist = property(_getrevokelist)
    def _getdisabledlicenses(self):
        """Returns a list of the disabled license id's contained in the c4p
file.
"""
        # attributes: update, _disabledlicenses
        ...

    disabled_licenses = property(_getdisabledlicenses)
    def _getprofiles(self):
        """Returns a list of the profiles contained in the c4p file."""
        # attributes: update, _profiles
        ...

    profiles = property(_getprofiles)
    def _getautorun(self):
        """Returns the application id of the autorun profile if any, and None
otherwise.
"""
        # attributes: update, _autorun
        ...

    autorun = property(_getautorun)
