# appdetector — reconstructed outline of CrossOver 26.3 lib/python/appdetector.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import re
import distversion
import cxutils
import bottlequery
import c4profilesmanager
import cxglob
import cxlog
import cxobjc
def _get_uninstall_info(bottlename):
    # globals: bottlequery
    # attributes: get_registry_key, append, NotFoundError
    # strings: '%s\\Microsoft\\Windows\\CurrentVersion\\Uninstall', '\\'
    ...

class InstalledApplication(cxobjc.Proxy):
    """Describes an application installed in a specific bottle.

Each such object has an appid property which uniquely identifies it in a
bottle.

If there is a corresponding C4 profile then this is the profile's id. This
makes it easy to check if the application for a given profile is installed
or not.

If there is no corresponding C4 profile, then it's a string of the form
'.local.<keyname>' (since only applications that have a proper Uninstall
key can be detected without a profile. Since this id starts with a dot it
cannot collide with a profile id.

This class inherits from cxobjc.Proxy so that we can bind to it properly from
within ObjC. That means that it must always be created via the special
platformconstructor.
"""
    keyname = None
    displayname = None
    systemcomponent = False
    uninstallcommand = None
    _profile = None
    def __init__(self, bottlename, profile, keyname):
        # globals: cxobjc
        # attributes: Proxy, __init__, bottlename, keyname, _profile, appid
        # strings: '.local.'
        ...

    def initWithBottleName_profile_andKeyName_(self, bottlename, profile, keyname):
        # globals: cxobjc
        # attributes: Proxy, nsobject_init, __init__
        ...

    @cxobjc.python_method
    @classmethod
    def platformconstructor(cls, bottlename, profile=None, keyname=None):
        # globals: distversion
        # attributes: IS_MACOSX, alloc, initWithBottleName_profile_andKeyName_
        ...

    @cxobjc.python_method
    def _getprofile(self):
        # attributes: _profile
        ...

    @cxobjc.python_method
    def _setprofile(self, profile):
        """Associates a profile and updates the appid property accordingly."""
        # attributes: _profile, appid
        ...

    profile = property(_getprofile, _setprofile)
    def _getname(self):
        """Returns the installed application name.
This is the name of the C4 profile if there is one, or the display
name if there is one, and the registry key as a last resort.
"""
        # attributes: _profile, name, displayname, keyname
        ...

    name = property(_getname)
    def canUninstall(self):
        # globals: bool
        # attributes: uninstallcommand
        ...

    def uninstall(self):
        # globals: cxutils
        # attributes: uninstallcommand, run
        ...


def get_uninstall_applications(bottlename):
    """returns a list of applications in the Uninstall section of the registry, ignoring CrossTies"""
    # globals: os, cxutils, _get_uninstall_info, InstalledApplication
    # attributes: path, join, CX_ROOT, platformconstructor, get, displayname, systemcomponent, uninstallcommand, append
    # strings: 'bin', 'wine', 'displayname', 'systemcomponent', 'uninstallstring', '--bottle', '--wl-app', 'uninstaller', '--remove'
    ...

class AppDetector(cxobjc.Proxy):
    pass

def get_installed_applications(bottlename, profiles):
    # globals: bottlequery, cxglob, get_uninstall_applications, set, re, cxutils, InstalledApplication, str, len, cxlog
    # attributes: is_disabled, FileGlobTree, values, app_profile, installed_key_pattern, compile, IGNORECASE, match, string_to_unicode, keyname, platformconstructor, appid, uninstallcommand, add, steamid, lower, installed_display_pattern, displayname, add_profile, matches, RegistryGlobTree, get, value_pattern, replace, endswith, get_registry_key, data_pattern, items, split, systemcomponent, error, warn, debug_str
    # strings: 'Steam App %s', '', '/', '\\', '%s\\', '@', 'hkey_local_machine', 'hkey_current_user', 'software', 'microsoft', 'windows', 'currentversion', 'uninstall', 'installed key pattern ', ' in profile for ', ' is an invalid regular expression', 'installed display pattern ', 'registry data pattern ', 'registry value pattern '
    ...

def fast_get_installed_applications(bottlename, profiles):
    """return a list of InstalledApplication objects in a bottle, using the C4
cache to work quickly"""
    # globals: get_installed_applications
    ...

def is_profile_installed(bottlename, profile):
    """returns an InstalledApplication if the profile is installed, None if not"""
    # globals: c4profilesmanager, get_installed_applications
    # attributes: C4ProfilesSet, appid
    ...
