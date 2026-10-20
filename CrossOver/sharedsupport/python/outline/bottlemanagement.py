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

@cxobjc.method(BottleManagement, 'createBottle_fromTemplate_')
def create_bottle(bottlename, template='win10_64', env=None, appid=None):
    """Creates the specified bottle and returns a (success, err_msg) tuple.
    """
    # globals: _bottle_tool, cxutils
    # attributes: append, run, GRAB
    # strings: '--bottle', '--create', '--template', '--install', 'EnvironmentVariables:CX_BOTTLE_CREATOR_APPID=%s', '--param'
    ...

@cxobjc.method(BottleManagement, 'duplicateBottle_fromBottle_')
def copy_bottle(bottlename, bottleToCopy):
    """Copies the specified bottle and returns a (success, err_msg) tuple.
    """
    # globals: _bottle_tool, cxutils
    # attributes: run, GRAB
    # strings: '--bottle', '--copy', '--install'
    ...

def publish_bottle(bottlename, bottleToCopy):
    """Publishes the specified bottle and returns a (success, err_msg) tuple.
    """
    # globals: cxproduct, os, cxutils, bottlequery, _bottle_tool
    # attributes: is_root_install, path, join, CX_ROOT, get_prefix_for_bottle, run, GRAB
    # strings: 'bin', 'cxsu', '--ignore-home', '--bottle', '--copy', '--install', '--scope', 'managed'
    ...

@cxobjc.method(BottleManagement, 'restoreBottle_fromArchive_')
def restore_bottle(bottlename, archiveFile):
    """Restores the specified archive to the specified bottle name and
returns a (success, err_msg) tuple.
"""
    # globals: _bottle_tool, distversion, os, cxutils
    # attributes: IS_MACOSX, environ, copy, run, GRAB
    # strings: '--bottle', '--restore', '--install', 'LANG', 'LC_CTYPE', 'LC_ALL', 'UTF-8'
    ...

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

@cxobjc.method(BottleManagement, 'archiveBottle_toPath_')
def archive_bottle(bottlename, inArchivePath):
    """Archives the bottle to the specified file and returns a
(success, err_msg) tuple.
"""
    # globals: _bottle_tool, distversion, os, cxutils
    # attributes: IS_MACOSX, environ, copy, run, GRAB
    # strings: '--bottle', '--tar', 'LANG', 'LC_CTYPE', 'LC_ALL', 'UTF-8'
    ...

_TEMPLATE_PROPERTIES = {'win98': (0, _('Windows 98 (deprecated)')), 'win2000': (1, _('Windows 2000 (deprecated)')), 'winxp': (2, _('Windows XP 32-bit (deprecated)')), 'winxp_64': (3, _('Windows XP')), 'winvista': (4, _('Windows Vista 32-bit (deprecated)')), 'winvista_64': (5, _('Windows Vista')), 'win7': (6, _('Windows 7 32-bit (deprecated)')), 'win7_64': (7, _('Windows 7')), 'win8': (8, _('Windows 8 32-bit (deprecated)')), 'win8_64': (9, _('Windows 8')), 'win10': (10, _('Windows 10 32-bit (deprecated)')), 'win10_64': (11, _('Windows 10')), 'win11_64': (12, _('Windows 11'))}
def _get_template_key(template):
    # globals: _TEMPLATE_PROPERTIES
    # attributes: get
    # strings: 'Unknown'
    ...

@cxobjc.method(BottleManagement, 'displayNameForTemplate_')
def get_template_name(template):
    # globals: _TEMPLATE_PROPERTIES
    # strings: 'Unknown'
    ...

@cxobjc.method(BottleManagement, 'templates')
def template_list():
    # globals: os, cxutils, cxproduct, sorted, _get_template_key
    # attributes: path, join, CX_ROOT, listdir, endswith, get_config_boolean, exists, append
    # strings: 'share', 'crossover', 'bottle_templates', '_64', 'OfficeSetup', 'Enable32BitBottles', 'setup'
    ...

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
