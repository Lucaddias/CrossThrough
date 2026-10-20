# cxfixesobjs — reconstructed outline of CrossOver 26.3 lib/python/cxfixesobjs.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Defines classes to represent and manipulate the CXFixes information."""
import re
from cxutils import cxgettext as _
def _validate_regular_expression(pattern, location, allow_empty=True):
    # globals: re, AttributeError
    # attributes: match, error
    # strings: '', 'the ', ' regular expression for ', ' is overly broad', ' is an invalid regular expression for '
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

class CXDistGlob:
    """Contains the information needed to detect a given distribution."""
    file_glob = None
    patterns = tuple()
    def __init__(self, file_glob, patterns=None):
        # attributes: file_glob, patterns
        ...

    def validate(self, distid):
        """Checks that all the mandatory fields have been set for this
distribution glob.
"""
        # globals: AttributeError, _validate_regular_expression
        # attributes: file_glob, patterns
        # strings: 'CXDistGlob.file_glob is not set in %s', 'the CXDistGlob.patterns field of %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class CXDistribution:
    """Describes a distribution: its name, how to install packages, etc."""
    distid = None
    name = None
    priority = 0
    updatecmd = None
    lockcmd = None
    packagecmd = None
    globs = None
    fallback = None
    def __init__(self, distid, name, priority):
        # attributes: distid, name, priority
        ...

    def add_glob(self, glob):
        # attributes: globs, append
        ...

    def validate(self):
        """Checks that all the mandatory fields have been set for this
distribution.

Note that this only checks internal consistency, not consistency with
other distributions.
"""
        # globals: AttributeError
        # attributes: distid, name, globs, validate
        # strings: 'CXDistribution.distid is not set', 'CXDistribution.name is not set'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class CXProduct:
    """Identifies a CrossOver product so fixes can be assigned priority
levels for it."""
    cxid = None
    fallback = None
    productid = None
    version = None
    priority = 0
    def __init__(self, cxid, fallback, productid, version, priority):
        # attributes: cxid, fallback, productid, version, priority
        ...

    def validate(self):
        """Checks that all the mandatory fields have been set for this
cxproduct.

Note that this only checks internal consistency, not consistency with
other cxproducts.
"""
        # globals: AttributeError, _validate_regular_expression
        # attributes: cxid, productid, version
        # strings: 'CXProduct.cxid is not set', 'the CXProduct.productid field of %s', 'the CXProduct.version field of %s'
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class CXDistFix:
    """Describes how to fix a specific issue on the specified platform."""
    distid = None
    bitness = None
    prepackages = frozenset()
    packages = frozenset()
    commands = frozenset()
    def __init__(self, distid, bitness):
        # attributes: distid, bitness
        ...

    BITNESSES = frozenset((None, '32', '64'))
    _PACKAGE_RE = re.compile('^[a-zA-Z0-9+_.:-]+$')
    def display_name(self, errid):
        # attributes: distid, bitness
        # strings: '/', ':'
        ...

    def validate(self, errid):
        """Checks that all the mandatory fields have been set for this
distribution fix.

Note that this only checks internal consistency, not consistency with
the known distributions list.
"""
        # globals: AttributeError, CXDistFix
        # attributes: distid, bitness, BITNESSES, display_name, endswith, packages, _PACKAGE_RE, search
        # strings: 'CXDistFix.distid is not set in issue %s', 'Invalid bitness value ', ' for ', '64', '.amd64', '.arm64', 'The ', ' error cannot happen on the 32-bit ', ' distribution', "invalid package name '", "' in "
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class CXFix:
    """Groups the known fixes for a given error."""
    errid = None
    fallback = None
    lib = None
    title = None
    description = None
    maskedby = frozenset()
    cxlevels = {}
    distfixes = {}
    def __init__(self, errid, fallback, lib, title, description):
        # attributes: errid, fallback, lib, title, description
        ...

    def add_distfix(self, distfix):
        # attributes: __dict__, distfixes, distid, bitness
        # strings: 'distfixes'
        ...

    _suffix = <function CXFix._suffix>()
    def validate(self):
        """Checks that all the mandatory fields have been set for this fix.

Note that this only checks internal consistency, not consistency with
other fixes.
"""
        # globals: AttributeError
        # attributes: errid, distfixes, fallback, _suffix, maskedby, values, validate
        # strings: 'CXFix.errid is not set', 'No actual fixes are present for CXFix %s', 'Architecture mismatch in fallback: ', ' vs. ', 'Architecture mismatch in <tiedto> or <maskedby>: '
        ...

    def dump(self, out, indent=''):
        # globals: _dump_fields
        ...


class CXFixes:
    """All the data from a CXFixes file."""
    def __init__(self):
        # attributes: release, distributions, cxproducts, fixes, maskedby
        ...

    _fallback_check = <function CXFixes._fallback_check>()
    def validate(self):
        # globals: set, CXFixes
        # attributes: distributions, values, _fallback_check, cxproducts, maskedby, fixes, append, errid, add, cxlevels, keys, distfixes
        # strings: 'distribution', 'distid', 'cxproduct', 'cxid', 'fix', 'errid', 'The ', ' fix is masked by a nonexistent error: ', ' error has properties for the nonexistent ', ' product', ' error has a fix for a nonexistent distribution: '
        ...

    def _fill_in(self, prepared, dst, srcid):
        # attributes: fixes, _prepare_fix, title, description
        ...

    def _prepare_fix(self, prepared, fix):
        # globals: _, CXFix
        # attributes: add, errid, replace, title, lib, startswith, description, _fill_in, fallback, fixes
        # strings: '.amd64', '', '.arm64', 'missinglib', 'Missing %(bitness)s-bit %(library)s library', 'brokenlib', 'Broken %(bitness)s-bit %(library)s library', 'missinggstreamer1', 'Missing %(bitness)s-bit gst-plugins-%(plugin)s GStreamer plugins', 'broken'
        ...

    def prepare(self):
        # globals: set, list
        # attributes: fixes, keys, _prepare_fix
        ...

    def get_fix_level(self, fix, cxid):
        # attributes: cxproducts, cxlevels, fallback
        ...
