# cxdiag — reconstructed outline of CrossOver 26.3 lib/python/cxdiag.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Provides efficient access to the cxdiag diagnostics."""
import os.path
import time
import re
import cxconfig
import cxlog
import cxproduct
import cxutils
import cxwhich
import distversion
from cxutils import cxgettext as _
import bottlequery
CHECK_NOBIT = 1
CHECK_32BIT = 2
CHECK_64BIT = 4
CHECK_PKGDEB = 16
CHECK_PKGRPM = 32
CHECK_OPENSSL = 64
CHECK_PERLFILECOPY = 128
CHECK_GZIP = 256
CHECK_PKEXEC = 512
_CACHE = {}
def _get_cached_cxdiag(libpath, flags):
    # globals: _CACHE, time, cxlog
    # attributes: get, time, timestamp, log
    # strings: 'cxdiag: pruning obsolete results'
    ...

_LOCALIZE_LIB_RE = re.compile('^(?P<type>Broken|Missing) (?P<bitness>32|64)-bit (?P<library>.+) library$')
_LOCALIZE_GST_RE = re.compile('^The (?P<module>.+) (?P<bitness>32|64)-bit GStreamer plugins appear to be missing (?P<plugin>.+)$')
def localize_title(title):
    # globals: _LOCALIZE_LIB_RE, _, _LOCALIZE_GST_RE, cxutils
    # attributes: match, group, cxgettext
    # strings: 'type', 'Broken', 'Broken %(bitness)s-bit %(library)s library', 'bitness', 'library', 'Missing %(bitness)s-bit %(library)s library', 'The %(module)s %(bitness)s-bit GStreamer plugins appear to be missing %(plugin)s', 'module', 'plugin'
    ...

class CXDiag:
    """Stores the cxdiag warnings and properties for the given library path
setting.

Once a CXDiag object is created it is never updated. So users should not
keep references to them but instead systematically call cxdiag.get().

The warnings are stored in the warnings dictionary which maps issue ids
to their already localized titles.
The properties are stored in the properties dictionary.
"""
    def _run_cxdiag(self, env, bitness, bitsuffix):
        # globals: os, cxutils, cxconfig, localize_title, cxlog, _
        # attributes: path, join, CX_ROOT, run, GRAB, Raw, read_string, items, lower, properties, warnings, libs, access, R_OK, X_OK, log, warn
        # strings: 'cxdiag', 'bin', 'properties', 'Title', 'Lib', '%s is missing / not executable', 'could not run %s', 'Missing %(bitness)s-bit %(library)s library', 'C', 'missinglibc', '%s failed (%d)', '%s failed', 'broken'
        ...

    def _get_cxdiag(self, libpath, flags, bitflag):
        # globals: _get_cached_cxdiag, CXDiag, min, os, cxlog, CHECK_32BIT
        # attributes: libs, update, warnings, properties, timestamp, environ, copy, join, log, _run_cxdiag
        # strings: 'LD_LIBRARY_PATH', ':', 'running cxdiag* with ', '=', '32', '', '64'
        ...

    @classmethod
    def _has_tools(cls, tools):
        # globals: cxwhich, os
        # attributes: which, environ
        # strings: 'PATH'
        ...

    def _check_pkgdeb(self):
        # globals: CXDiag, _
        # attributes: _has_tools, warnings
        # strings: 'Missing Debian packaging tools', 'packagingdeb'
        ...

    def _check_pkgrpm(self):
        # globals: CXDiag, _
        # attributes: _has_tools, warnings
        # strings: 'Missing RPM packaging tools', 'packagingrpm'
        ...

    def _check_openssl(self):
        # globals: CXDiag, _
        # attributes: _has_tools, warnings
        # strings: 'Missing openssl tool', 'missingopenssl'
        ...

    def _check_perlfilecopy(self):
        # globals: os, _
        # attributes: system, warnings
        # strings: 'perl -MFile::Copy -e 1 2>/dev/null', 'Missing File::Copy Perl module', 'missingperlfilecopy'
        ...

    def _check_pkexec(self):
        # globals: CXDiag, _
        # attributes: _has_tools, warnings
        # strings: 'Missing pkexec tool', 'missingpkexec'
        ...

    def _check_gzip(self):
        # globals: CXDiag, _
        # attributes: _has_tools, warnings
        # strings: 'Missing gzip tool', 'missinggzip'
        ...

    def __init__(self, libpath, flags):
        # globals: time, distversion, CHECK_32BIT, CHECK_64BIT, CHECK_PKGDEB, CHECK_PKGRPM, CHECK_OPENSSL, CHECK_GZIP, CHECK_PERLFILECOPY, CHECK_PKEXEC, _CACHE
        # attributes: libpath, libs, warnings, properties, time, timestamp, IS_MACOSX, _get_cxdiag, _check_pkgdeb, _check_pkgrpm, _check_openssl, _check_gzip, _check_perlfilecopy, _check_pkexec
        ...


def get(bottlename=None, flags=0):
    """Return a CXDiag object with the results for the specified bottle.

The results are cached so we don't run cxdiag a dozen times if we have
half a dozen bottles. However they are also expired after a while so we
detect configuration changes such as the addition or removal of packages.
"""
    # globals: bottlequery, cxproduct, os, cxutils, CHECK_NOBIT, CHECK_32BIT, CHECK_64BIT, _get_cached_cxdiag, CXDiag
    # attributes: get_config, get, expand_unix_string, path, join, CX_ROOT
    # strings: 'Wine', 'LibPath', 'lib', 'Bottle', 'WineArch', '', 'win64'
    ...

def clear():
    """Clears the cxdiag cache.

This forces redetecting issues. This should be called whenever packages
have been installed to fix issues.
"""
    # globals: cxlog
    # attributes: log
    # strings: 'cxdiag: clearing obsolete results'
    ...
