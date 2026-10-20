# cxproduct — reconstructed outline of CrossOver 26.3 lib/python/cxproduct.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os.path
import re
import cxconfig
import cxobservable
import cxutils
import distversion
import Foundation
_PRODUCT_ID = None
def get_product_id():
    """Gets and checks the effective product id.

An invalid product id is a fatal error and will raise an exception.
"""
    # globals: _PRODUCT_ID, os, cxutils, open, distversion, len, RuntimeError, re, OSError
    # attributes: path, join, CX_ROOT, exists, readline, rstrip, BUILTIN_PRODUCT_ID, search
    # strings: '.productid', 'r', 'utf8', "product id '%s' is too short", '^[a-zA-Z0-9_][a-zA-Z0-9_][a-zA-Z0-9_][a-zA-Z0-9_][a-zA-Z0-9_]*$', "product id '%s' contains bad characters", "unable to open, read or close '%s'"
    ...

_CELLAR_ID = None
def get_cellar_id():
    """Gets and checks the cellar identifier.

The cellar is where the CrossOver bottles and associated data (user
configuration, Windows installer cache, CrossTies, etc) are stored.
The cellar identifier sets the location of the cellar and is also part of
the unique identifier used to tag the associated resources such as the
bottle menus and associations.

An invalid cellar identifier is a fatal error and will raise an exception.
"""
    # globals: _CELLAR_ID, get_product_id, distversion
    # attributes: IS_PREVIEW, IS_MACOSX, PRODUCT_NAME
    # strings: 'cxpreview', 'cxoffice', 'CrossOver'
    ...

def get_home_dir():
    # globals: os, RuntimeError, KeyError, OSError
    # attributes: environ, stat, geteuid, st_uid, errno, ENOENT
    # strings: 'HOME', '$HOME (%s) does not belong to root', '$HOME is not set!', '$HOME (%s) does not exist!'
    ...

def get_user_dir():
    # globals: get_home_dir, distversion, os, get_cellar_id
    # attributes: IS_MACOSX, path, join
    # strings: 'Library/Application Support/', '.'
    ...

def get_icons_dir():
    # globals: distversion, os, get_home_dir, get_cellar_id, get_user_dir
    # attributes: IS_MACOSX, path, join
    # strings: 'Library/Caches/', 'com.codeweavers.%s', 'icons'
    ...

def get_installer_dir():
    # globals: distversion, os, get_home_dir, get_cellar_id, get_user_dir
    # attributes: IS_MACOSX, path, join
    # strings: 'Library/Caches/', 'com.codeweavers.%s', 'installers'
    ...

def get_managed_dir():
    # globals: distversion, os, get_cellar_id, cxutils
    # attributes: IS_MACOSX, path, join, CX_ROOT
    # strings: '/Library/Application Support', 'support'
    ...

def is_root_install():
    """Returns True if this install is owned by root.
This is intended to distinguish between system-wide and private installs.
"""
    # globals: os, cxutils
    # attributes: stat, CX_ROOT, st_uid
    ...

def is_arm64_install():
    # globals: os, cxutils
    # attributes: path, exists, join, CX_ROOT
    # strings: 'lib', 'wine', 'aarch64-unix'
    ...

def is_wow64_install():
    # globals: os, cxutils
    # attributes: path, exists, join, CX_ROOT
    # strings: 'lib', 'wine', 'i386-unix', 'i386-windows'
    ...

def is_crostini():
    """Returns True if we're on Crostini (Linux on Chrome OS). We check
the presence of the file below which says no password is needed to
become root on Crostini."""
    # globals: os
    # attributes: path, isfile
    # strings: '/etc/sudoers.d/10-cros-nopasswd'
    ...

_CONFIG = None
def get_config():
    """Returns the CrossOver configuration, merged from the relevant sources
as needed.

To avoid races when changing the configuration file it is necessary to
follow these rules:
- The data obtained prior to locking the writable configuration file with
  must not be trusted. This is because the configuration file was not yet
  locked and thus may have changed between the two calls.
- So the proper way to test the value of a setting and then modify it
  race-free is:
      config = cxproduct.get_config()

      # This returns the file the changes should be saved into
      wconfig = config.get_save_config()

      # This locks the file and re-reads it if needed, ensuring wconfig
      # *and* config see the very latest data.
      wconfig.lock_file()

      if config['section']['field'] ...:
          wconfig['section']['field'] = ...

      # Saves the changes. If nothing was changed above then the file is
      # left untouched. Then the file is unlocked.
      wconfig.save_and_unlock_file()

      All the while config can still be used in a read-only fashion and is
      guaranteed to be in sync with the latest modifications made in
      wconfig.
"""
    # globals: _CONFIG, cxconfig, os, cxutils, get_product_id, get_user_dir, get_cellar_id, KeyError, RuntimeError
    # attributes: Stack, path, join, CX_ROOT, addconfig
    # strings: 'etc', '.conf'
    ...

def get_config_string(section, name, default):
    """Obtains a string from the CrossOver configuration file on Linux and NSUserDefaults on macOS."""
    # globals: distversion, Foundation, get_config
    # attributes: IS_MACOSX, NSUserDefaults, standardUserDefaults, stringForKey_, get
    ...

def set_config_string(section, name, value):
    """Saves the specified string in the CrossOver configuration file and NSUserDefaults on macOS.

This function must not be used if value is based on another configuration
setting as this would have races.
"""
    # globals: distversion, Foundation, get_config
    # attributes: IS_MACOSX, NSUserDefaults, standardUserDefaults, setObject_forKey_, get_save_config, lock_file, save_and_unlock_file
    ...

def get_config_boolean(section, name, default):
    """Obtains a boolean from the CrossOver configuration file and NSUserDefaults on macOS."""
    # globals: distversion, Foundation, get_config_string
    # attributes: IS_MACOSX, NSUserDefaults, standardUserDefaults, boolForKey_
    # strings: '1', '0'
    ...

def set_config_boolean(section, name, value):
    """Saves the specified boolean in the CrossOver configuration file and NSUserDefaults on macOS.

This function must not be used if value is based on another configuration
setting as this would have races.
"""
    # globals: distversion, Foundation, set_config_string
    # attributes: IS_MACOSX, NSUserDefaults, standardUserDefaults, setBool_forKey_
    # strings: '1', '0'
    ...

_ENVIRON = None
def refresh_environment():
    ...

def _refresh_environment(config, *_args):
    """Refreshes the block holding CrossOver's environment settings."""
    # globals: os, cxutils, distversion, get_user_dir, get_managed_dir, get_config, cxobservable, _refresh_environment, reversed
    # attributes: environ, CX_ROOT, IS_MACOSX, path, join, add_observer, ANY_EVENT, configs, sortedkeys, fieldname, expand_unix_string, get, copy
    # strings: 'CX_ROOT', 'CX_BOTTLE_PATH', 'Bottles', 'CX_MANAGED_BOTTLE_PATH', 'EnvironmentVariables', 'CrossOver', 'BottlePath'
    ...

def get_bottle_path():
    # globals: _ENVIRON, _refresh_environment
    # strings: 'CX_BOTTLE_PATH'
    ...

def set_bottle_path(path):
    # globals: os, set_config_string, refresh_environment
    # attributes: environ
    # strings: 'CX_BOTTLE_PATH', 'CrossOver', 'BottlePath'
    ...

def get_managed_bottle_path():
    # globals: _ENVIRON, _refresh_environment
    # strings: 'CX_MANAGED_BOTTLE_PATH'
    ...

_CROSS_PRODUCT_CONFIG = None
def get_cross_product_config():
    """Returns a configuration object containing the registered CrossOver
product."""
    # globals: _CROSS_PRODUCT_CONFIG, cxconfig, os, cxutils
    # attributes: Stack, addconfig, environ, geteuid, CX_ROOT, startswith, path, join
    # strings: '/etc/crossover.conf', 'HOME', '.crossover.conf'
    ...

def this_product():
    """Returns a dictionary describing the current product.

The following values will be present:
* name - Human-readable product name
* productid - The product ID used to test <cxversion> tags.
* productversion - The CrossOver version used to test <cxversion> tags.
* publicversion - The public version.
* root - The value of CX_ROOT."""
    # globals: cxutils, distversion
    # attributes: CX_ROOT, PRODUCT_NAME, BUILTIN_PRODUCT_ID, CX_VERSION, PUBLIC_VERSION
    # strings: 'root', 'name', 'productid', 'productversion', 'publicversion'
    ...

# except ImportError:  (handler offset 230)
