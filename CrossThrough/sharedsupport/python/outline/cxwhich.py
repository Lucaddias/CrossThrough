# cxwhich — reconstructed outline of CrossOver 26.3 lib/python/cxwhich.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
def which(path, app):
    """Looks for an executable in the specified directory list.

path is an os.pathsep-separated list of directories and app is the
executable name. If app contains a path separator then path is ignored.
If the file is not found, then None is returned.
"""
    # globals: os
    # attributes: path, isabs, isfile, access, X_OK, sep, altsep, join, getcwd, split, pathsep
    # strings: ''
    ...
