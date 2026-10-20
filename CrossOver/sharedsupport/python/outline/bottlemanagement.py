# bottlemanagement — reconstructed outline of CrossOver 26.3 lib/python/bottlemanagement.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import cxproduct
import distversion
import cxutils
import cxobjc
import cxlog
import bottlequery
from cxutils import cxgettext as _
class BottleManagement(cxobjc.Proxy):
    pass

def _bottle_tool():
    # globals: os, cxutils
    # attributes: path, join, CX_ROOT
    # strings: 'bin', 'cxbottle'
    ...

create_bottle = <function create_bottle>()
copy_bottle = <function copy_bottle>()
def publish_bottle(bottlename, bottleToCopy):
    """Publishes the specified bottle and returns a (success, err_msg) tuple.
    """
    # globals: cxproduct, os, cxutils, bottlequery, _bottle_tool
    # attributes: is_root_install, path, join, CX_ROOT, get_prefix_for_bottle, run, GRAB
    # strings: 'bin', 'cxsu', '--ignore-home', '--bottle', '--copy', '--install', '--scope', 'managed'
    ...

restore_bottle = <function restore_bottle>()
def rename_bottle(bottlename, newBottleName):
    """Renames the specified bottle and returns a (success, err_msg) tuple."""
    # globals: bottlequery, os, _bottle_tool, cxutils
    # attributes: get_prefix_for_bottle, path, join, dirname, get_default_bottle, exists, run, GRAB, rename, append
    # strings: 'Cannot rename; that bottle already exists.', '--bottle', '--removeall', 'Failed to uninstall the old bottle name: %s', '--new-uuid', '--install', '--default', 'Failed to install the new bottle name: %s'
    ...

def delete_bottle(bottlename, isManaged=False):
    """Deletes the specified bottle and returns a (success, err_msg) tuple.
    """
    # globals: cxproduct, os, cxutils, _bottle_tool, cxlog
    # attributes: is_root_install, path, join, CX_ROOT, run, GRAB, log, to_str
    # strings: 'bin', 'cxsu', '--ignore-home', '--bottle', '--removeall', '--delete', '--force', 'Failed to delete %s.', '--scope', 'private', 'Failed to delete the stub for %s.'
    ...

def set_default_bottle(bottlename, inState):
    """Makes or unmakes the bottle the default bottle and returns a
(success, err_msg) tuple.
"""
    # globals: _bottle_tool, cxutils
    # attributes: run, GRAB
    # strings: '--default', '--undefault', '--bottle'
    ...

def package_bottle(bottlename, packagetype, release, productid, packager, outdir):
    # globals: _bottle_tool, cxutils
    # attributes: run, GRAB
    # strings: '--%s', '--release', '--bottle', '--productid', '--packager'
    ...

archive_bottle = <function archive_bottle>()
_TEMPLATE_PROPERTIES = {'win98': (0, _('Windows 98 (deprecated)')), 'win2000': (1, _('Windows 2000 (deprecated)')), 'winxp': (2, _('Windows XP 32-bit (deprecated)')), 'winxp_64': (3, _('Windows XP')), 'winvista': (4, _('Windows Vista 32-bit (deprecated)')), 'winvista_64': (5, _('Windows Vista')), 'win7': (6, _('Windows 7 32-bit (deprecated)')), 'win7_64': (7, _('Windows 7')), 'win8': (8, _('Windows 8 32-bit (deprecated)')), 'win8_64': (9, _('Windows 8')), 'win10': (10, _('Windows 10 32-bit (deprecated)')), 'win10_64': (11, _('Windows 10')), 'win11_64': (12, _('Windows 11'))}
def _get_template_key(template):
    # globals: _TEMPLATE_PROPERTIES
    # attributes: get
    # strings: 'Unknown'
    ...

get_template_name = <function get_template_name>()
template_list = <function template_list>()
def is_running(bottlename):
    # globals: os, cxutils
    # attributes: path, join, CX_ROOT, system
    # strings: 'bin', 'wine', '--bottle', '--no-update', '--ux-app', 'wineserver', '-k0'
    ...

def quit_bottle(bottlename):
    """Return True if shutdown succeeded, False if failed or canceled."""
    # globals: is_running, os, cxutils
    # attributes: path, join, CX_ROOT, run, GRAB
    # strings: 'bin', 'wine', '--bottle', '--no-update', '--wl-app', 'wineboot.exe', '--', '--end-session', '--shutdown', '--force', '--kill'
    ...

def get_up_to_date(bottlename, scope='private'):
    # globals: _bottle_tool, cxutils
    # attributes: run, GRAB
    # strings: '--bottle', '--status', '--scope', 'Status=uptodate'
    ...

def kill_bottle(bottlename):
    # globals: is_running, os, cxutils
    # attributes: path, join, CX_ROOT, system
    # strings: 'bin', 'wine', '--bottle', '--no-update', '--ux-app', 'wineserver', '-k'
    ...
