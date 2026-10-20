# cxutils — reconstructed outline of CrossOver 26.3 lib/python/cxutils.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import errno
import fcntl
import hashlib
import locale
import mmap
import os
import re
import selectors
import stat
import subprocess
import sys
import time
import webbrowser
from urllib.parse import urlparse
from urllib.parse import unquote
import cxlog
import distversion
import cxobjc
class CXUtils(cxobjc.Proxy):
    pass

CX_ROOT = None
def mkdirs(path, *args, **kwargs):
    """Similar to os.makedirs() but returns False to signal errors and logs
errors.
"""
    # globals: os, OSError, errno, cxlog
    # attributes: makedirs, errno, EEXIST, err, debug_str, strerror
    # strings: "unable to create the '", "' directory: "
    ...

PERMISSIONS_OK = 0
PERMISSIONS_NOREAD = 1
PERMISSIONS_NOEXEC = 2
def check_mmap_permissions(filename):
    # globals: open, mmap, PERMISSIONS_OK, IOError, PERMISSIONS_NOREAD, PERMISSIONS_NOEXEC
    # attributes: mmap, fileno, MAP_SHARED, PROT_READ, PROT_EXEC, close, error
    # strings: 'rb'
    ...

def check_fake_dll(path):
    # globals: os, open
    # attributes: path, exists, seek, read, startswith
    # strings: 'rb'
    ...

class FileDigest:
    def __init__(self, filename):
        # globals: time
        # attributes: _filename, stat, _mtime, _size, _inode, hash, _hash, time, _time
        ...

    def stat(self):
        # globals: os, OSError
        # attributes: stat, _filename, st_mtime, st_size, st_ino
        ...

    def hash(self):
        # globals: open, hashlib, AttributeError, OSError
        # attributes: _filename, file_digest, hexdigest, sha1, read, update
        # strings: 'rb', 'sha1'
        ...

    def existed(self):
        # attributes: _mtime
        ...

    def modified(self):
        # attributes: stat, _mtime, _size, _inode, _time, hash, _hash
        ...


class FLock:
    def __init__(self, name):
        """Creates and takes a lock called name using flock().

This is used to avoid races between processes.
"""
        # globals: os, mkdirs, int, stat, ValueError, open, cxlog, fcntl, OSError, errno, Exception
        # attributes: _name, path, join, environ, get, geteuid, lstat, S_ISDIR, st_mode, st_uid, _path, S_ISREG, _lock, log, getpid, flock, LOCK_EX, errno, ENOENT, warn, close
        # strings: 'TMPDIR', '/tmp', '.wine-%d', '700', "'%s' is not owned by you", '77', "'%s' must not be accessible by other users", '.lock', "'%s' is not a regular file", 'wb', "%d: Grabbing the '%s' lock", "unable to take the '", "' lock: "
        ...

    def _getname(self):
        """Returns the lock name."""
        # attributes: _name
        ...

    name = property(_getname)
    def locked(self):
        """Returns True if the lock has not been released yet."""
        # attributes: _lock
        ...

    def release(self):
        """Releases the lock.

Note that deleting a lock carries a very high risk of causing races
outside the scope of this class and has essentially no benefit. So the
file created for the lock is not deleted and no support is provided
for deleting it.
"""
        # globals: cxlog, os, fcntl, Exception
        # attributes: _lock, log, getpid, _name, flock, LOCK_UN, close, warn
        # strings: "%d: Releasing the '%s' lock", "unable to release the '", "' lock: "
        ...


def string_to_unicode(string):
    # globals: isinstance, str, bytes, memoryview, NameError, TypeError, ValueError
    # attributes: decode, tobytes
    # strings: 'utf8', 'surrogateescape', 'utf-8', 'string_to_unicode called with non-string'
    ...

def string_to_utf8(string):
    # globals: isinstance, str, bytes, memoryview, NameError, TypeError, ValueError
    # attributes: encode, tobytes
    # strings: 'utf8', 'surrogateescape', 'string_to_utf8 called with non-string'
    ...

string_to_str = string_to_unicode
def cmp(v1, v2):
    ...

def unescape_string(string):
    """Unescapes a string that was placed in double-quotes."""
    # attributes: replace
    # strings: '\\"', '"', '\\\\', '\\'
    ...

def escape_string(string):
    """Escapes the string so it can be placed in double-quotes."""
    # attributes: replace
    # strings: '\\', '\\\\', '"', '\\"'
    ...

def unmangle(string):
    # globals: len, chr, int, ValueError
    # attributes: append, join
    # strings: '+', ' ', '_', '/', '~', '\\', '^', ''
    ...

_ACCELERATOR_RE = re.compile('&(.)')
def remove_accelerators(string):
    """Remove the ampersands that identify the accelerator keys on Windows.

While only the first one is meant to be significant, they should all be
removed, and '&&' should be turned into a regular '&'.
"""
    # globals: _ACCELERATOR_RE
    # attributes: sub
    # strings: '\\1'
    ...

def md5sum_path(path):
    # globals: hashlib, open
    # attributes: md5, read, update, hexdigest
    # strings: 'rb'
    ...

def is_valid_windows_filename(filename):
    """Checks that the given filename is valid."""
    # strings: '\\/*?:|<>"\''
    ...

def sanitize_windows_filename(filename):
    """Turns a filename that may contain invalid characters into a valid
Windows  filename."""
    # globals: ord
    # attributes: append, join
    # strings: '\\:*?"<>|\x7f', '_', ''
    ...

def allow_bottlename_char(character):
    """Returns False for characters that are forbidden in bottle names."""
    # globals: distversion
    # attributes: IS_MACOSX
    # strings: '\\/*?:|<>"\'{}', ' '
    ...

def is_valid_bottlename(bottlename):
    """Checks that the bottle name is valid."""
    # globals: allow_bottlename_char
    # strings: '.'
    ...

sanitize_bottlename = <function sanitize_bottlename>()
def path_to_uri(path):
    # globals: string_to_utf8, chr
    # attributes: append, join
    # strings: 'file://', '%%%02X', ''
    ...

def uri_to_path(uri):
    # globals: urlparse, unquote
    # strings: 'file'
    ...

def html_escape(string):
    """Escape characters that have special meaning in html."""
    # attributes: append, get, join
    # strings: '&lt;', '&gt;', '&amp;', ''
    ...

_HTML_BR_RE = None
_HTML_P_RE = None
_HTML_LI_RE = None
_HTML_A_RE = None
_HTML_URL_RE = None
_HTML_TAGS_RE = None
_LF_RE = None
def html_to_text(string):
    """Use some heuristics to turn an HTML string into a readable plain
text string."""
    # globals: _HTML_BR_RE, re, _HTML_LI_RE, _HTML_P_RE, _HTML_A_RE, _HTML_TAGS_RE, _LF_RE
    # attributes: compile, IGNORECASE, replace, sub, strip
    # strings: '<br/?>(?:\\s*\n)*', '</?(?:div|p|ol|ul)(\\s+[a-z]+=([\'"])(?:[^\\\\\'"]|\\.)*\\2)*>(?:\\s*\\n)*', '(\\s*\\n)*\\s*<li(\\s+[a-z]+=([\'"])(?:[^\\\\\'"]|\\\\.)*\\3)*>', '</?a(\\s+[a-z]+=([\'"])(?:[^\\\\\'"]|\\.)*\\2)*>', '\\shref=([\'"])((?:[^\\\\\'"]|\\.)*)\\1', '(?:</?[a-z]+(\\s+[a-z]+=([\'"])(?:[^\\\\\'"]|\\\\.)*\\2)*/?>)+', '\\s*\\n\\s*\\n(?:\\s*\\n)+', '\r', '', '\n', ' ', '\n * ', '\n\n', '&lt;', '<', '&gt;', '>', '&amp;', '&', '&nbsp;', ' +'
    def replace_link(match):
        # globals: _HTML_URL_RE
        # attributes: group, search
        # strings: '[', '] ', ''
        ...

    ...

cmdlinetoargv = <function cmdlinetoargv>()
def argvtocmdline(argv):
    """Convert an argument list to a windows-style quoted command line."""
    # attributes: replace, append, join
    # strings: '\\', '\\\\', '"', '\\"', ' ', '"%s"'
    ...

basename = <function basename>()
dirname = <function dirname>()
def abspath(path, cwd=None):
    # globals: os, uri_to_path
    # attributes: path, expanduser, realpath, join
    ...

_OCTALCHAR_RE = None
def expand_octal_chars(string):
    """Expand escaped octal characters of the form '\040' in the specified
string.
"""
    # globals: _OCTALCHAR_RE, re, chr, int
    # attributes: compile, finditer, append, start, end, join
    # strings: '(\\\\[0-7]{3})', ''
    ...

_UNIXVAR_RE = None
def expand_unix_string(environ, string):
    """Expand references to environment variables of the form '${VARNAME}' in
the specified string.

Note that unlike os.path.expandvars(), if a given environment variable is
not set it expands to an empty string.
"""
    # globals: _UNIXVAR_RE, re
    # attributes: compile, finditer, append, start, group, end, join
    # strings: '\\${(\\w+)}', ''
    ...

def _int_for_version_component(comp):
    """A version component can have a non-numeric suffix (e.g. the "local" in
"25889local").  That interferes with converting to integer. This function
collects just the numeric prefix and converts that.
"""
    # globals: int
    # attributes: isdigit
    ...

def subtract_version(v1, v2):
    # globals: len, range, cmp, _int_for_version_component, tuple
    # attributes: split, extend, append
    # strings: '.', '0'
    ...

def cmp_versions(v1, v2):
    # globals: len, range, cmp, _int_for_version_component
    # attributes: split, extend
    # strings: '.', '0'
    ...

def split_version(s):
    # globals: tuple, len, _int_for_version_component
    # attributes: split
    # strings: '.'
    ...

_version_as_tuple = None
def version_as_tuple():
    # globals: _version_as_tuple, split_version, distversion
    # attributes: CX_VERSION
    ...

def get_user_languages():
    # globals: ImportError, os, locale
    # attributes: preferredLanguages, append, environ, get, getlocale, split, normalize, startswith, replace
    # strings: 'pt', 'pt-BR', 'zh-Hans', 'zh-CN', 'zh-Hant', 'zh-TW', 'LANGUAGE', '', ':', '_', '.', '@', 'en', 'pt_PT', '-'
    ...

_SINGLETON_RE = re.compile('(-x)?-[a-z]$')
_PREFERRED_LANGUAGES = {}
_LANGUAGE_ASSOCIATIONS = {'zh-hans': 'zh-cn', 'zh-hant': 'zh-tw'}
def get_preferred_languages(language=None):
    """Returns a sequence of the user's preferred languages if language is
None; and a sequence of variants otherwise.

All languages must be identified by their RFC 1766 / RFC 3066 / RFC 5646 /
BCP 47 language id.
In the None case the result corresponds to the user's preferences on
Mac OS X, while on Unix it is derived from the user's locale.
When starting from a single language, the variants added allow broader
matches to be established. For instance 'pt-br' gives ('pt-br', 'pt', '').
"""
    # globals: _PREFERRED_LANGUAGES, get_user_languages, set, _SINGLETON_RE, len, reversed, _LANGUAGE_ASSOCIATIONS
    # attributes: lower, append, add, rsplit, sub, insert
    # strings: 'en', '-', ''
    ...

get_language_value = <function get_language_value>()
_LOCALE_PATH = None
def setup_textdomain():
    # globals: _LOCALE_PATH, os, CX_ROOT, cxlog, hasattr, locale
    # attributes: path, join, log, debug_str, bindtextdomain, textdomain
    # strings: 'share', 'locale', 'locale path %s', 'bindtextdomain', 'crossover'
    ...

_GETTEXT_TRANSLATOR = None
def _translator():
    # globals: _GETTEXT_TRANSLATOR, setup_textdomain, get_preferred_languages, _LOCALE_PATH
    # attributes: append, replace, translation
    # strings: '-', '_', 'crossover'
    ...

def cxgettext(message):
    # globals: string_to_unicode, _translator
    # attributes: gettext
    ...

_ = cxgettext
installer_logging_preset = <function installer_logging_preset>()
logging_presets = <function logging_presets>()
GRAB = 1
NULL = 2
def run(args, stdout=None, stderr=None, background=False, cwd=None, env=None, logprefix=''):
    """Works the same way as subprocess.Popen, but simplifies retrieving
the output and exit code. Returns (retcode, out, err) triplets.

If stdout or stderr are set to GRAB, then they are captured and
returned. If they are set to NULL, then they are redirected
to/from /dev/null instead. If the command cannot be run, then
returns -1 as the exit code instead of raising an exception.

Finally, the execution is timed and traced with cxlog. If stdout
or stderr are being captured, then they are logged too. If
logprefix is set, then the trace is prefixed with it.

"""
    # globals: time, cxlog, GRAB, subprocess, NULL, TypeError, os, hasattr, selectors, Exception, sys, OSError
    # attributes: time, is_on, log, join, PIPE, DEVNULL, fork, Popen, _exit, waitpid, PollSelector, SelectSelector, stdout, register, EVENT_READ, stderr, get_map, poll, select, read, fd, unregister, fileobj, append, wait, decode, encoding, errors, replace, close, debug_str, path, basename, count, write, to_str
    # strings: '', ': ', ' &', 'Running: ', ' ', 'invalid value for stdout', 'invalid value for stderr', 'PollSelector', '\r\n', '\n', '\r', '%s%s -> rc=%d  (took %0.3f seconds)', 'out=<%d lines>', 'out=[%s]', 'err=<%d lines>', 'err=[%s]'
    ...

def system(args, background=False, cwd=None, env=None, logprefix=''):
    """Works the same way as run(), except that neither stdout nor stderr are
captured, and only the retcode is returned.
"""
    # globals: run
    ...

def launch_url(url):
    """Open the specified URL in a web browser."""
    # globals: webbrowser
    # attributes: open
    ...

from select import select as select_select
from select import error as select_error
def select(iwtd, owtd, ewtd, timeout=None):
    """Same as select.select() but retries on EINTR (with the same timeout)."""
    # globals: select_select, select_error, errno
    # attributes: args, EINTR
    ...

def _xdg_dirs_skip_whitespace(pos, string):
    # globals: len
    # strings: ' \t'
    ...

def _internal_load_xdg_dirs():
    # globals: os, open, _xdg_dirs_skip_whitespace
    # attributes: BaseDirectory, load_first_config, path, join, environ, get, rstrip, find, replace, close
    # strings: 'user-dirs.dirs', 'HOME', '/', '.config', 'rt', 'utf8', 'surrogateescape', '\n', 'XDG_', '_DIR', '=', '"', '$HOME/', '', '\\'
    ...

_xdg_dirs = None
def _load_xdg_dirs():
    # globals: _xdg_dirs, _internal_load_xdg_dirs
    ...

def get_download_dir():
    # globals: distversion, _load_xdg_dirs, os, _
    # attributes: IS_MACOSX, path, join, environ, get, isdir
    # strings: 'DOWNLOAD', 'HOME', '/', 'Downloads'
    ...

def get_desktop_dir():
    # globals: distversion, _load_xdg_dirs, os, _
    # attributes: IS_MACOSX, path, join, environ, get, isdir
    # strings: 'DESKTOP', 'HOME', '/', 'Desktop'
    ...

S_MEDIUM = ('48x48', '32x32', '')
def get_icon_path(root, subdir, iconname, sizes=S_MEDIUM):
    # globals: os
    # attributes: path, join, exists
    ...

def get_icon_paths(root, subdir, iconname):
    # globals: os
    # attributes: listdir, path, join, exists
    ...

def not_yet_implemented():
    """If a method raises NotImplementedError(), pylint regards it as an
"abstract method" that must be implemented in all subclasses, and the
class as an "abstract class". Sometimes this is desired, but in some cases
we use this exception for parts of the API that we are not using now but
plan to implement and use in the future. Those functions should instead
raise cxutils.not_yet_implemented()."""
    # globals: NotImplementedError
    ...

UMASK = os.umask(0)
os.umask(UMASK)
