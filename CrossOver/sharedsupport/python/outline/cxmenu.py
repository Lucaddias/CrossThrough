# cxmenu — reconstructed outline of CrossOver 26.3 lib/python/cxmenu.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import threading
import os
import re
import cxobjc
import cxconfig
import cxlog
import cxutils
import cxfsnotifier
import cxobservable
import bottlequery
from cxutils import cxgettext as _
class Error(Exception):
    pass

class CXMenu(cxobjc.Proxy):
    pass

def cxmenu_path():
    # globals: os, cxutils
    # attributes: path, join, CX_ROOT
    # strings: 'bin', 'cxmenu'
    ...

def config_path(bottle_name):
    # globals: os, bottlequery
    # attributes: path, join, get_prefix_for_bottle
    # strings: 'cxmenu.conf'
    ...

def run_cxmenu(args, grab_stdout=False, background=False):
    # globals: cxutils, cxmenu_path, tuple, Error
    # attributes: GRAB, run
    # strings: '%d: '
    ...

def get_menuroot(bottlename):
    # globals: os, bottlequery, cxconfig
    # attributes: path, join, get_prefix_for_bottle, get
    # strings: 'cxbottle.conf', 'Bottle', 'MenuRoot', ''
    ...

def set_menuroot(bottlename, new_root, update=True):
    # globals: bottlequery, run_cxmenu
    # attributes: get_config, get_save_config, lock_file, save_and_unlock_file, get
    # strings: 'Bottle', 'MenuRoot', 'MenuMode', '', 'install', '--removeall', '--install', '--bottle'
    ...

local_start_menu_path = <function local_start_menu_path>()
local_desktop_path = <function local_desktop_path>()
create_custom_shortcut = <function create_custom_shortcut>()
class MenuItem:
    """A single menu shortcut."""
    def __init__(self, parent, section):
        # globals: os, bottlequery
        # attributes: parent, name, path, join, get_prefix_for_bottle, bottlename, launcher_path, get, mode, new_mode, lower, type, description, include_in_mainmenu, _config_icon, expand_unix_string
        # strings: 'desktopdata/cxmenu/Launchers', '.desktop', 'Mode', 'ignore', 'Type', 'raw', 'Description', 'IncludeInMainMenu', 'Icon'
        ...

    def menu_name(self):
        # globals: re, os
        # attributes: sub, path, basename
        # strings: '\\.(lnk|url)$', ''
        ...

    def get_iconfile(self, sizes=cxutils.S_MEDIUM, fallback='crossover'):
        # globals: os, bottlequery, cxutils
        # attributes: _config_icon, path, join, get_prefix_for_bottle, parent, bottlename, get_icon_path, CX_ROOT
        # strings: '/', 'windata', 'cxmenu', 'icons', 'hicolor', 'apps', 'share', ''
        ...

    iconfile = property(get_iconfile)
    def start(self):
        # globals: run_cxmenu
        # attributes: parent, bottlename, path
        # strings: '--bottle', '--start'
        ...

    def _get_lnkfile(self):
        # globals: cxlog, cxutils
        # attributes: type, path, startswith, warn, split, unmangle
        # strings: 'windows', 'StartMenu/', 'c:/Windows/Start Menu/', 'Desktop/', 'c:/Windows/Desktop/', '/', 'StartMenu.', 'StartMenu_', '/Start Menu/', 'Desktop.', 'Desktop_', '/Desktop/', 'cxmenu._get_lnkfile: unrecognized path %s'
        ...

    lnkfile = property(_get_lnkfile)

class MenuPrefs:
    """An editable menu configuration for a bottle"""
    def __init__(self, bottlename, managed=True):
        # globals: threading, cxconfig
        # attributes: bottlename, managed, items, Lock, lock, get, config_filename, config, delegates, config_observer, lnkfile_observers
        ...

    def run_cxmenu(self, *args, **kwargs):
        # globals: run_cxmenu
        # attributes: lock
        ...

    def config_filename(self):
        # globals: config_path
        # attributes: bottlename
        ...

    def read_config(self):
        """Reads the menu information from cxmenu.conf."""
        # globals: MenuItem
        # attributes: config, refresh, items, clear, values, name
        ...

    def query_config(self):
        """Update menu settings from cxmenu --query."""
        # globals: cxconfig
        # attributes: managed, run_cxmenu, bottlename, Raw, read_string, values, name, items, get, mode
        # strings: 'managed', 'private', '--query', '--bottle', '--scope', 'IDs', 'install', 'ignore'
        ...

    def refresh(self):
        """Read the menu configuration for this bottle"""
        # globals: get_menuroot
        # attributes: read_config, query_config, bottlename, new_menuroot, menuroot
        ...

    def commit(self):
        """Save and apply the changes using cxmenu."""
        # globals: set_menuroot
        # attributes: items, values, new_mode, mode, append, path, run_cxmenu, bottlename, join, new_menuroot, menuroot
        # strings: 'install', '--bottle', '--mode', '--install', '--filter', ':', 'ignore', '--uninstall'
        ...

    def install_menus(self):
        # attributes: run_cxmenu, bottlename
        # strings: '--bottle', '--install'
        ...

    def recreate_menus(self):
        # attributes: run_cxmenu, bottlename
        # strings: '--bottle', '--sync', '--mode', 'install', '--removeall', '--install'
        ...

    def sync_menus(self):
        # attributes: run_cxmenu, bottlename
        # strings: '--bottle', '--sync'
        ...

    def add_observers(self, delegate):
        # globals: cxlog
        # attributes: delegates, append, log, bottlename, config, refresh, add_config_observer, on_config_changed
        # strings: 'cxmenu: Adding observers to '
        ...

    def remove_observers(self, delegate):
        # attributes: delegates, remove, remove_config_observer, remove_lnkfile_observers
        ...

    def add_config_observer(self):
        # globals: cxobservable
        # attributes: remove_config_observer, config, add_observer, ANY_EVENT, on_config_changed, config_observer
        ...

    def remove_config_observer(self):
        # globals: cxobservable
        # attributes: config_observer, config, remove_observer, ANY_EVENT
        ...

    def on_config_changed(self, *_args):
        # globals: cxlog, bottlequery
        # attributes: log, bottlename, read_config, add_lnkfile_observers, delegates, NotFoundError
        # strings: 'cxmenu change observed in '
        ...

    def add_lnkfile_observers(self):
        # globals: bottlequery, os, cxfsnotifier
        # attributes: remove_lnkfile_observers, items, values, lnkfile, get_native_path, bottlename, path, exists, sync_menus, add_observer, on_lnkfile_changed, lnkfile_observers, NotFoundError
        ...

    def remove_lnkfile_observers(self):
        # globals: cxfsnotifier
        # attributes: lnkfile_observers, items, remove_observer
        ...

    def on_lnkfile_changed(self, _event, _path, _data):
        # globals: Exception
        # attributes: sync_menus
        ...
