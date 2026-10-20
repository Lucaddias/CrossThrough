# downloaddetector — reconstructed outline of CrossOver 26.3 lib/python/downloaddetector.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import globtree
class ConstGlobTree(globtree.GlobTree):
    """A globtree object for searching a constant list.

Use matches('', sequence_of_filenames) to do a search."""
    case_sensitive = True
    def listdir(self, path, filenames):
        ...

    def exists(self, path, filenames):
        ...


def _get_downloads(filenames, profiles):
    # globals: ConstGlobTree
    # attributes: userdata, values, app_profile, download_globs, add_glob, setdefault, matches
    # strings: 'DownloadGlobTree', ''
    ...

def find_installers(dirs, profiles):
    # globals: set, os, _get_downloads, OSError
    # attributes: listdir, path, join, isfile, append
    ...

def find_profiles(filename, profiles):
    # globals: os, _get_downloads
    # attributes: path, isfile, split, appid, is_for_current_product
    ...
