# cxfixesparser — reconstructed outline of CrossOver 26.3 lib/python/cxfixesparser.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import time
import traceback
import xml.sax
import xml.sax.handler
import cxlog
import cxfixesobjs
class _CXFixesHandler(xml.sax.handler.ContentHandler):
    def __init__(self):
        # globals: xml, cxfixesobjs, _CXFixesHandler
        # attributes: sax, handler, ContentHandler, __init__, CXFixes, cxfixes, parse_errors, locator, _objects, state_init, _states, _skip, _key, _property, _string, _default
        ...

    def setDocumentLocator(self, locator):
        # attributes: locator
        ...

    def startElement(self, name, attrs):
        """Called when the SAX parser finds an opening XML tag, <cxfixes> for
instance.

This calls the startElement handler which is at the top of the state
stack. In turn this handler normally pushes a new state on top of the
state stack to handle the tags contained therein.

If the opening tag corresponds to an object, for instance <fix>, then
it will also push the new object on top of the object stack.
"""
        # attributes: _states
        ...

    def endElement(self, name):
        """Called when the SAX parser finds a closing XML tag, </cxfixes> for
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
        """Prints a warning as a debug trace in the cxfixesparser channel."""
        # globals: cxlog
        # attributes: log_, locator, getSystemId, getLineNumber, getColumnNumber, to_str
        # strings: 'cxfixesparser', '%s:%d:%d: %s'
        ...

    def _startof_unexpected(self, name, _attrs):
        # attributes: fail
        # strings: 'unexpected opening tag %s'
        ...

    def _end_simple(self, name):
        """Pops the state stack but leave the object stack as is.

This is mostly used by attribute handlers.
"""
        # globals: cxlog, len
        # attributes: log_, _objects, _states, to_str, pop
        # strings: 'cxfixesparser', 'objects=%d states=%d %s'
        ...

    def _end_popobj(self, name):
        """Pops the state and object stacks."""
        # globals: cxlog, len
        # attributes: log_, _objects, _states, to_str, pop
        # strings: 'cxfixesparser', 'objects=%d states=%d %s'
        ...

    def _endof_unexpected(self, name):
        # attributes: fail
        # strings: 'unexpected closing tag %s'
        ...

    def _unexpected_characters(self, content):
        """Warns about unexpected string snippets."""
        # globals: repr
        # attributes: isspace, warn
        # strings: "unexpected characters '%s'"
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

    def _startof_string(self, prop):
        # globals: _CXFixesHandler, cxlog, len
        # attributes: _property, _string, _states, append, state_string, log_, _objects, to_str
        # strings: 'cxfixesparser', 'objects=%d states=%d %s'
        ...

    def _endof_string(self, _unused):
        # globals: cxlog, len
        # attributes: _property, _objects, join, _string, log_, debug_str, to_str, __dict__, warn, _states, pop
        # strings: '', 'cxfixesparser', 'obj=', ' property=', ' value=', '%s has been set already', 'objects=%d states=%d %s'
        ...

    state_string = (_startof_unexpected, _endof_string, _string_characters)
    def _attr2string(self, prop, attr, attrs):
        # attributes: _objects, get, __dict__, warn
        # strings: '', '%s has been set already'
        ...

    def _startof_stringlist(self, prop):
        # globals: _CXFixesHandler, cxlog, len
        # attributes: _property, _string, _states, append, state_stringlist, log_, _objects, to_str
        # strings: 'cxfixesparser', 'objects=%d states=%d %s'
        ...

    def _endof_stringlist(self, _unused):
        # globals: cxlog, len
        # attributes: _objects, join, _string, log_, debug_str, to_str, _property, __dict__, append, _states, pop
        # strings: '', 'cxfixesparser', 'obj=', ' property=', ' value=', 'objects=%d states=%d %s'
        ...

    state_stringlist = (_startof_unexpected, _endof_stringlist, _string_characters)
    def _attr2stringset(self, prop, attr, attrs):
        # globals: set
        # attributes: _objects, get, __dict__, add
        # strings: ''
        ...

    def _attr2stringmap(self, prop, keyattr, valattr, attrs):
        # attributes: _objects, get, __dict__
        ...

    def _startof_childless(self, _name, _attrs=None):
        # globals: _CXFixesHandler
        # attributes: _skip, _states, append, state_skip
        ...

    def _startof_skip(self, name, attrs=None):
        # attributes: _skip, warn, _startof_childless
        # strings: 'skipping unknown tag %s'
        ...

    def _endof_skip(self, _unused):
        # attributes: _skip, _states, pop
        ...

    def _ignore_characters(self, _content):
        ...

    state_skip = (_startof_skip, _endof_skip, _ignore_characters)
    def _childof_init(self, name, attrs):
        # globals: int, _CXFixesHandler, cxlog, len
        # attributes: get, cxfixes, release, _states, append, state_cxfixes, log_, _objects, to_str, warn
        # strings: 'cxfixes', 'release', '0', 'cxfixesparser', 'objects=%d states=%d %s', 'expecting c4p tag, got %s'
        ...

    state_init = (_childof_init, _endof_unexpected, _string_unexpected)
    def _childof_cxfixes(self, name, _attrs):
        # globals: _CXFixesHandler, cxlog, len
        # attributes: _states, append, state_distributions, log_, _objects, to_str, state_cxproducts, state_fixes, _startof_skip
        # strings: 'distributions', 'cxfixesparser', 'objects=%d states=%d %s', 'cxproducts', 'fixes'
        ...

    state_cxfixes = (_childof_cxfixes, _end_simple, _unexpected_characters)
    def _childof_distributions(self, name, attrs):
        # globals: int, cxfixesobjs, _CXFixesHandler, cxlog, len
        # attributes: get, CXDistribution, _objects, append, _states, state_distribution, log_, to_str, _startof_skip
        # strings: 'distribution', 'priority', '0', 'id', 'name', 'cxfixesparser', 'objects=%d states=%d %s'
        ...

    state_distributions = (_childof_distributions, _end_simple, _unexpected_characters)
    def _childof_distribution(self, name, attrs):
        # globals: cxfixesobjs, _CXFixesHandler
        # attributes: CXDistGlob, _startof_objectlist, state_glob, _startof_string, _attr2string, _startof_childless, _startof_skip
        # strings: 'glob', 'file', 'globs', 'updatecmd', 'lockcmd', 'packagecmd', 'fallback', 'distribution'
        ...

    def _endof_distribution(self, _name):
        # globals: len, AttributeError, str, cxlog, traceback, Exception
        # attributes: _objects, pop, validate, cxfixes, distributions, distid, fail, _states, parse_errors, append, is_on, print_exc, warn
        # strings: 'internal error: len(_objects) = %d', 'the %s distribution is not valid, ignoring it', 'cxfixesparser', 'an unexpected error occurred while parsing the %s distribution, ignoring it'
        ...

    state_distribution = (_childof_distribution, _endof_distribution, _unexpected_characters)
    def _childof_cxproducts(self, name, attrs):
        # globals: int, cxfixesobjs, _CXFixesHandler, cxlog, len
        # attributes: get, CXProduct, _objects, append, _states, state_cxproduct, log_, to_str, _startof_skip
        # strings: 'cxproduct', 'priority', '0', 'id', 'fallback', 'productid', 'version', 'cxfixesparser', 'objects=%d states=%d %s'
        ...

    state_cxproducts = (_childof_cxproducts, _end_simple, _unexpected_characters)
    def _childof_cxproduct(self, name, _attrs):
        # attributes: _startof_skip
        ...

    def _endof_cxproduct(self, _name):
        # globals: len, AttributeError, str, cxlog, traceback, Exception
        # attributes: _objects, pop, validate, cxfixes, cxproducts, cxid, fail, _states, parse_errors, append, is_on, print_exc, warn
        # strings: 'internal error: len(_objects) = %d', 'the %s cxproduct is not valid, ignoring it', 'cxfixesparser', 'an unexpected error occurred while parsing the %s cxproduct, ignoring it'
        ...

    state_cxproduct = (_childof_cxproduct, _endof_cxproduct, _unexpected_characters)
    def _childof_glob(self, name, _attrs):
        # attributes: _startof_stringlist, _startof_skip
        # strings: 'pattern', 'patterns'
        ...

    state_glob = (_childof_glob, _end_popobj, _unexpected_characters)
    def _childof_fixes(self, name, attrs):
        # globals: cxfixesobjs, _CXFixesHandler, cxlog, len
        # attributes: CXFix, get, _objects, append, _states, state_fix, log_, to_str, _startof_skip
        # strings: 'fix', 'id', 'fallback', 'lib', 'title', 'description', 'cxfixesparser', 'objects=%d states=%d %s'
        ...

    state_fixes = (_childof_fixes, _end_simple, _unexpected_characters)
    def _childof_fix(self, name, attrs):
        # globals: cxfixesobjs, _CXFixesHandler
        # attributes: _attr2stringset, _startof_childless, _attr2stringmap, _objects, CXDistFix, get, add_distfix, append, _states, state_fixfor, _startof_skip
        # strings: 'tiedto', 'maskedby', 'id', 'cx', 'cxlevels', 'level', 'fixfor', 'distribution', 'bitness'
        ...

    def _endof_fix(self, _name):
        # globals: len, AttributeError, str, cxlog, traceback, Exception
        # attributes: _objects, pop, validate, cxfixes, fixes, errid, fail, _states, parse_errors, append, is_on, print_exc, warn
        # strings: 'internal error: len(_objects) = %d', 'the %s fix is not valid, ignoring it', 'cxfixesparser', 'an unexpected error occurred while parsing the %s fix, ignoring it'
        ...

    state_fix = (_childof_fix, _endof_fix, _unexpected_characters)
    def _childof_fixfor(self, name, attrs):
        # attributes: get, _attr2stringset, _startof_childless, _startof_stringlist, _startof_skip
        # strings: 'package', 'preinstall', 'prepackages', 'packages', 'name', 'command', 'commands'
        ...

    state_fixfor = (_childof_fixfor, _end_popobj, _unexpected_characters)

def read_file(filename):
    # globals: time, _CXFixesHandler, xml, cxlog, Exception, hasattr, traceback
    # attributes: time, sax, parse, cxfixes, validate, log, to_str, parse_errors, extend, errno, ENOENT, append, is_on, print_exc, warn
    # strings: "parsing '%s' took %0.3fs", 'errno', "'%s' does not exist", "an unexpected error occurred while parsing '%s'. Ignoring this file", 'cxfixesparser'
    ...
