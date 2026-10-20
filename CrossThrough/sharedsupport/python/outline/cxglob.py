# cxglob — reconstructed outline of CrossOver 26.3 lib/python/cxglob.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import c4profiles
import cxutils
import globtree
import bottlequery
def find_files(bottlename, path, max_results=-1):
    # globals: bottlequery, cxutils, ValueError
    # attributes: BottleManipulator, send, string_to_str, get, split, startswith, append, NotFoundError
    # strings: 'findfiles ', ' ', '\n', 'file ', 'dir ', 'got unexpected data: %s'
    ...

class FileGlobTree(globtree.GlobTree):
    environ = None
    def listdir(self, path, bottlename='default'):
        # globals: find_files, bottlequery
        # attributes: replace, NotFoundError
        ...

    def exists(self, path, bottlename='default'):
        # globals: len, find_files, bottlequery
        # attributes: endswith, replace, NotFoundError
        ...

    def isdir(self, _path, _bottlename='default'):
        ...

    def add_profile(self, profile, bottlename='default'):
        # globals: bottlequery, c4profiles
        # attributes: app_profile, environ, get_win_environ, ENVIRONMENT_VARIABLES, installed_file_globs, add_glob, expand_win_string, replace
        # strings: '\\', '/'
        ...


class RegistryGlobTree(globtree.GlobTree):
    _root_keys = set(['hkey_classes_root', 'hkey_current_user', 'hkey_local_machine', 'hkey_users'])
    def listdir(self, path, bottlename='default'):
        # globals: bottlequery
        # attributes: _root_keys, lower, replace, endswith, get_registry_key, NotFoundError
        ...

    def exists(self, path, bottlename='default'):
        # globals: bottlequery
        # attributes: lower, replace, endswith, get_registry_key, NotFoundError
        ...

    def isdir(self, _path, _bottlename='default'):
        ...

    def add_glob(self, glob, data):
        # globals: super
        # attributes: replace, add_glob
        # strings: '\\', '/'
        ...

    def add_profile(self, profile):
        # attributes: app_profile, installed_registry_globs, add_glob, key_glob
        ...

    @staticmethod
    def get(profiles):
        """Returns a RegistryGlobTree() object for the specified C4ProfilesSet
object.
"""
        # globals: RegistryGlobTree
        # attributes: userdata, values, add_profile, setdefault
        # strings: 'RegistryGlobTree'
        ...
