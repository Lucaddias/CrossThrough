# cxfixes — reconstructed outline of CrossOver 26.3 lib/python/cxfixes.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import collections
import os.path
import re
import subprocess
import cxlog
import cxproduct
import cxutils
import distversion
from cxutils import cxgettext as _
FIXES_URL = 'http://ftp.codeweavers.com/pub/crossover/cxfixes/cxfixes.xml.gz'
WIKI_URL = 'https://support.codeweavers.com/missing-libraries/'
_LOCK = None
def run_from_main_thread_callback():
    # globals: _LOCK
    # attributes: release, main_quit
    ...

def run_from_main_thread(fun):
    # globals: _LOCK, RuntimeError
    # attributes: main_level, Lock, acquire, threads_add_idle, init_check, main
    # strings: 'No display found'
    ...

def display_error_internal(title, text):
    # globals: markup_error_message, run_from_main_thread
    def done(_response):
        # globals: run_from_main_thread_callback
        ...

    def create_dialog(_data):
        # attributes: CXMessageDlg, STOCK_OK, MessageType, ERROR
        ...

    ...

def display_error_zenity(title, text):
    # globals: cxutils
    # attributes: string_to_str, run
    # strings: 'zenity', '--error', '--no-markup', '--title', '--text'
    ...

def display_error_kdialog(title, text):
    # globals: cxutils
    # attributes: string_to_str, run
    # strings: 'kdialog', '--title', '--error'
    ...

def display_error_xmessage(title, text):
    # globals: isinstance, str, cxutils, UnicodeEncodeError
    # attributes: encode, run
    # strings: 'iso-8859-1', 'xmessage', '\n', 'utf8'
    ...

def display_error(gui, title, text):
    # globals: print, display_error_internal, display_error_zenity, display_error_kdialog, display_error_xmessage
    # attributes: stderr, write
    # strings: '\n'
    ...

def refused_internal(title, text, prompt):
    # globals: run_from_main_thread
    def done(response, userdata):
        # globals: run_from_main_thread_callback
        ...

    def create_dialog(_data):
        # attributes: CXMessageDlg, STOCK_NO, STOCK_YES, MessageType, QUESTION
        # strings: '\n\n'
        ...

    ...

def refused_zenity(title, text, prompt):
    # globals: cxutils
    # attributes: string_to_str, run
    # strings: '\n\n', 'zenity', '--question', '--no-markup', '--title', '--text'
    ...

def refused_kdialog(title, text, prompt):
    # globals: cxutils
    # attributes: string_to_str, run
    # strings: '\n\n', 'kdialog', '--title', '--yesno'
    ...

def refused_xmessage(title, text, prompt):
    # globals: isinstance, str, cxutils, UnicodeEncodeError
    # attributes: encode, run
    # strings: 'iso-8859-1', 'xmessage', '-buttons', 'No:1,Yes:0', '-default', 'Yes', '\n', '\n\n', 'utf8'
    ...

def refused(gui, title, text, prompt):
    # globals: print, input, refused_internal, refused_zenity, refused_kdialog, refused_xmessage, EOFError
    # attributes: stderr, write
    # strings: ' [Y/n] ', '\n'
    ...

CXFIXES = None
UPDATE = True
def _load_fixes():
    # globals: CXFIXES, os, cxproduct, UPDATE, FIXES_URL, cxlog, cxutils
    # attributes: path, join, get_user_dir, update, read_file, warn, CX_ROOT, CXFixes, release, log, prepare
    # strings: 'cxfixes.xml', 'share/crossover/data/cxfixes.xml', 'Could not load any fixes information', 'using the downloaded fixes information (release %s)', 'using the builtin fixes information (release %s)'
    ...

_DISTROID = None
def detect_distribution():
    # globals: _DISTROID, _load_fixes, CXFIXES, cxlog, re
    # attributes: FileContentGlobTree, distributions, items, globs, add_content_glob, file_glob, patterns, matches, priority, log, err, error, warn
    # strings: 'found a match for distro ', ' (', ')', 'Could not identify the distribution', 'the ', ' fileglob of ', ' contains an invalid regular expression'
    ...

_CXID = None
def detect_cxproduct():
    # globals: _CXID, _load_fixes, distversion, CXFIXES, re, cxlog
    # attributes: BUILTIN_PRODUCT_ID, CX_VERSION, cxproducts, values, productid, search, version, priority, cxid, log, err
    # strings: 'found a match for cxproduct ', ' (', ')', 'Could not identify the CrossOver product'
    ...

def arch_add_multilib(cmd):
    # globals: os, cxutils, re
    # attributes: path, isfile, run, GRAB, NULL, search
    # strings: '/etc/pacman.conf', '^# *\\[multilib]', 'sed --in-place "/^# *\\[multilib]/,/Include/ s/^# *//" /etc/pacman.conf; (', ')', '^\\[multilib]', '(echo "[multilib]"; echo "Include = /etc/pacman.d/mirrorlist") >>/etc/pacman.conf; ('
    ...

def debian_add_architecture(arch, cmd):
    # globals: cxutils
    # attributes: run, GRAB, NULL, find
    # strings: '\n', 'dpkg --add-architecture ', ' && (', ')'
    ...

_ERRORS = {}
ErrorInfo = collections.namedtuple('ErrorInfo', ('level', 'title', 'lib'))
def add_error(errid, title=None, level=None, lib=None):
    # globals: _load_fixes, CXFIXES, detect_cxproduct, _, cxlog, ErrorInfo, _ERRORS
    # attributes: fixes, get, get_fix_level, title, lib, warn
    # strings: 'Unknown error %s', 'The ', ' fix provides ', ', not the needed '
    ...

def add_masked_errors(levels=None):
    """Check if there are any other errors that may have been masked by the
current set and which should be fixed at the same time."""
    # globals: _load_fixes, detect_cxproduct, set, _ERRORS, CXFIXES, add_error
    # attributes: keys, pop, maskedby, fixes, get_fix_level, add
    ...

def remove_error(errid):
    # globals: _ERRORS
    ...

def has_error(errid):
    # globals: _ERRORS
    ...

def get_error_level(errid):
    # globals: _load_fixes, CXFIXES, detect_cxproduct
    # attributes: fixes, get, get_fix_level
    ...

def get_error_description(errid):
    # globals: _load_fixes, CXFIXES, _
    # attributes: fixes, get, description
    # strings: 'Unknown error %s'
    ...

def get_error_title(errid):
    # globals: _ERRORS
    # attributes: get, title
    ...

def get_error_url(errid):
    # globals: WIKI_URL
    # attributes: endswith, replace
    # strings: '.amd64', '.arm64', 'brokenlib', 'missinglib', '.', '-'
    ...

def has_errors():
    # globals: _ERRORS
    ...

def get_error_count():
    # globals: len, _ERRORS
    ...

def get_errors():
    # globals: _ERRORS
    ...

def clear_errors():
    ...

def strip_fix_overrides(sources, errid, key):
    # globals: cxlog, CXFIXES, len
    # attributes: log_, remove, distributions, get, fallback
    # strings: '32', '64', 'cxfix', '   not overriding ', '/', ' with '
    ...

def get_fix(errid, distroid=None):
    # globals: _load_fixes, CXFIXES, cxlog, strip_fix_overrides, detect_distribution
    # attributes: fixes, fallback, log_, distfixes, distributions, get
    # strings: 'cxfix', 'Building merged fix for %s:', ' merging fixes from %s', '   merged ', '/', ' as ', '64'
    ...

def get_distribution_property(distroid, name):
    """Returns the distribution's property, using the fallbacks if necessary.
If there is no such property, then None is returned.
"""
    # globals: CXFIXES
    # attributes: distributions, __dict__, fallback
    ...

def get_commands(errid, distroid=None):
    # globals: _load_fixes, get_fix
    # attributes: commands
    ...

def get_packages(errid, distroid=None, pre=None):
    # globals: _load_fixes, get_fix, list
    # attributes: prepackages, extend, packages
    ...

def get_package_key(name):
    # attributes: endswith, startswith
    # strings: ':i386', ':amd64', ':arm64', '.i686', '.x86_64', '.aarch64', '-32bit', 'lib32-'
    ...

def get_fix_command(update=True, checklock=False, allatonce=True, yes=False):
    # globals: has_errors, detect_distribution, get_distribution_property, cxlog, CXFIXES, set, _ERRORS, get_packages, get_package_key, get_commands, cxutils, sorted, tuple, arch_add_multilib, debian_add_architecture
    # attributes: warn, distributions, name, update, append, startswith, endswith, extend, join, argvtocmdline, values, add
    # strings: 'packagecmd', 'No command has been set for installing the packages on %s', '', 'pacman', ' --noconfirm', ' -y', 'apt', 'DEBIAN_FRONTEND=noninteractive; export DEBIAN_FRONTEND; ', 'lib32-', ':i386', '; ', ' ', 'libc6:i386', ' -o APT::Immediate-Configure=0 libc6:i386; ', ' || rc=1', 'set -x; rc=0; ', '; exit $rc', 'lockcmd', 'updatecmd', 'i386'
    ...

def fix_errors(new_console=True, update=True, allatonce=True, gui=True, yes=True):
    # globals: get_fix_command, cxproduct, _, distversion, os, cxutils, run_from_main_thread, refused, subprocess, remove_error
    # attributes: is_crostini, PLATFORM, path, join, CX_ROOT, check_gtk, OK, retcode, DEVNULL, run, returncode
    # strings: '%(platform)s Package Installation', 'platform', 'CrossOver needs to install several %(platform)s Packages in order to run Windows applications.', 'Proceed with the installation?', 'bin', 'cxsu', '--description', 'CrossOver needs your permission to install missing packages.', '--console', '--ignore-home', 'sh', '-c'
    def create_dialog(_data):
        # globals: run_from_main_thread_callback
        # attributes: FixDialog
        ...

    ...

def markup_error_message(message):
    # globals: re
    # attributes: compile, split, sub, append, join
    # strings: '(?P<base>https?://[^\\s]+/)(?P<errid>\\w+) \\((?P<bitness>32|64)-bit\\)', '\n'
    def _linkify(match):
        # globals: get_error_title
        # attributes: group
        # strings: 'base', 'errid', 'bitness', '64', '.amd64', '<a href="', '">', '</a>'
        ...

    ...

def get_fix_message(distfixes, distroid, bitness, distname=True):
    # globals: get_distribution_property, detect_distribution, sorted, CXFIXES, _
    # attributes: prepackages, packages, append, extend, join, commands, distributions, name
    # strings: '', 'packagecmd', ';', ' ', '; ', '%(name)s (%(bitness)s-bit)', '23', '\n'
    ...

def get_error_message(prefix=True, verbose=False):
    # globals: has_errors, _, distversion, detect_distribution, set, _ERRORS, get_fix, get_fix_message, sorted, CXFIXES, get_error_url
    # attributes: PRODUCT_NAME, packages, commands, append, join, add, lib, endswith, fixes, level
    # strings: '', 'Some errors may prevent %s from working correctly.\n', 'missing', 'fix', '  ', '\n', 'nofix', 'other', '64', '  --- ', 'or on other platforms:', 'The following issues can be fixed:', 'The following issues have no known automated fix for your platform but the fixes for other platforms may help you:', 'The following issues cannot be fixed on this platform. Check online for more information:', 'The following issues need to be fixed manually. Check online for more information:', '.amd64', '.arm64', '64-bit, ', '32-bit, ', '%s, ', 'obsolete', '* ', ' (', ')\n', 'Note that the fixes may also apply to older or newer distribution versions.'
    ...

def report_errors(prefix=True, verbose=False, gui=True):
    # globals: has_errors, get_error_message, display_error, _, distversion
    # attributes: PLATFORM
    # strings: 'Could not install some %(platform)s packages', 'platform'
    ...
