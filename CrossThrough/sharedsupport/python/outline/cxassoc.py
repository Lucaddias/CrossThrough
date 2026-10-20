# cxassoc — reconstructed outline of CrossOver 26.3 lib/python/cxassoc.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import bottlequery
import cxconfig
import cxutils
import cxlog
class Error(Exception):
    pass

def cxassoc_path():
    # globals: os, cxutils
    # attributes: path, join, CX_ROOT
    # strings: 'bin', 'cxassoc'
    ...

def run_cxassoc(args, grab_stdout=False, background=False):
    # globals: cxutils, cxassoc_path, tuple, Error
    # attributes: GRAB, run
    ...

class Association:
    """A single extension/appname/verbname set, which corresponds to one
section in the cxassoc.conf file.
"""
    def __init__(self, parent, section):
        """Initializes an Association object based on the specified
cxassoc.conf section.
"""
        # globals: bottlequery
        # attributes: parent, name, eassoc, split, extension, get, current_mode, new_mode, lstrip, lower, mimetype, description, appname, rsplit, verb, index, action, verbname, expand_unix_string, bottlename, iconname
        # strings: '/', 'mode', 'ignore', 'alternate', 'alternative', 'mimetype', 'application/x-crossover-%s', '.', 'description', '', 'appname', 'open', 'verbname', 'icon'
        ...

    def get_iconfilename(self):
        """Returns the full path of the icon for this association, or '' if
there is no icon.
"""
        # globals: bottlequery, os
        # attributes: iconname, startswith, get_prefix_for_bottle, parent, bottlename, path, join
        # strings: '/', 'windata', 'Associations'
        ...

    def set_mode(self, new_mode):
        # attributes: parent, set_mode, eassoc
        ...


class CXAssocPrefs(dict):
    """A set of preferences for the associations in a bottle.

As the modes of the preferences are changed, this class keeps the changes
in memory. They can then be applied using commit()

Changing one preference can have a side-effect of changing others. When
this happens, the caller will be notified with the mode_changed()
function.
"""
    def __init__(self, bottlename, managed):
        # globals: dict
        # attributes: __init__, bottlename, managed
        ...

    def config_filename(self):
        # globals: os, bottlequery
        # attributes: path, join, get_prefix_for_bottle, bottlename
        # strings: 'cxassoc.conf'
        ...

    def read_config(self):
        """Reads the association information from cxassoc.conf."""
        # globals: cxconfig, Association
        # attributes: get, config_filename, clear, values, name
        ...

    def query_config(self):
        """Updates association states based on cxassoc --query"""
        # globals: cxutils, cxassoc_path, Error, cxconfig
        # attributes: managed, run, bottlename, GRAB, Raw, read_string, get, current_mode, new_mode
        # strings: 'managed', 'private', '--query', '--bottle', '--scope', 'default', 'alternative', 'mime', 'ignore'
        ...

    def refresh(self):
        """Reads the association information for this bottle."""
        # attributes: read_config, query_config
        ...

    def mode_changed(self, eassoc, newmode, user):
        """Called when the mode of an association has changed.

user is True if the change was requested by a call to set_mode().
user is False if the change was made automatically.

Users should override this method.
"""
        ...

    def _set_mode(self, assoc, new_mode, user):
        # globals: cxlog
        # attributes: new_mode, log_, to_str, eassoc, mode_changed
        # strings: 'assoc', 'Set mode for ', ' to ', ' (user=', ')'
        ...

    def set_mode(self, eassoc, new_mode):
        """Set an association's mode, updating others as necessary."""
        # globals: ValueError
        # attributes: _set_mode, mimetype, action, values, new_mode
        # strings: "new_mode must be 'ignore', 'mime', 'alternative', or 'default'", 'ignore', 'mime', 'default', 'alternative'
        ...

    def commit(self):
        """Save and apply the changes using cxassoc."""
        # globals: cxassoc_path, cxutils, Error
        # attributes: values, new_mode, current_mode, append, eassoc, join, extend, bottlename, replace, run, GRAB
        # strings: '=', ':', 'all', 'ignore', 'install', '--bottle', '--mode', ';', '.', '\\.', '--mode-filter', '--install', '--install-filter', '--uninstall', '--uninstall-filter'
        ...

    def recreate_assocs(self):
        # globals: run_cxassoc
        # attributes: bottlename
        # strings: '--bottle', '--sync', '--mode', 'mime', '--removeall', '--install'
        ...
