# globtree — reconstructed outline of CrossOver 26.3 lib/python/globtree.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import re
import os
import cxlog
import cxutils
class GlobNode:
    name = None
    is_glob = None
    is_dir = False
    string_children = None
    glob_children = None
    client_data = None
    def __init__(self, name):
        # globals: re, bytes
        # attributes: endswith, string_children, glob_children, is_dir, append, escape, compile, join, IGNORECASE, name, is_glob, client_data
        ...


class GlobTree:
    """This abstract class provides a way to efficiently find all the matches
for a list of globs in a tree of objects.

This is meant to be a general tool and should in particular be equally
applicable to filesystem and registry searches.

Note that on Unix filesystems the filenames are arbitrary strings of bytes
that may not respect any specific character encoding. Because of this, this
class too deals with byte strings.
"""
    case_sensitive = False
    def __init__(self):
        # globals: GlobNode
        # attributes: _root
        ...

    def add_glob(self, glob, data):
        """Adds a glob to the glob tree.

A glob is a '/'-separated path which may optionally contain the
following wildcard characters:
- '?' which matches any character except '/'.
- '*' which matches zero or more non-'/' characters.

If the glob ends with a '/', then only 'folders' will be matched.
Otherwise, both files and folders will be matched. All globs are
case-insensitive and will be lowercased to avoid duplicates like
'Windows' and 'windows'.

A given glob can be added multiple times. The specified data object
will be returned with each match.
"""
        # globals: cxutils, GlobNode
        # attributes: string_to_utf8, find, _root, lower, glob_children, string_children, endswith, rsplit, client_data, append
        ...

    def matches(self, root, *user_args, **user_kwargs):
        """Returns an iterator over the matches.

For each match the pair (path, data) is returned so this can be used
as follows:
    for path, data in globtree.matches(root):
        ...

If additional arguments are given, they will be passed on to other functions.
"""
        # globals: cxutils, len, cxlog
        # attributes: string_to_utf8, endswith, _root, pop, case_sensitive, glob_children, string_children, log_, to_str, listdir, lower, client_data, _isdir, string_to_str, debug_str, append, values, is_dir, name, match, _exists
        # strings: 'globtree', 'listdir(%s)', 'found match for ', ': '
        ...

    def _exists(self, path, *user_args, **user_kwargs):
        # globals: cxlog
        # attributes: log_, to_str, exists
        # strings: 'globtree', 'exists(%s)'
        ...

    def _isdir(self, location, path, *user_args, **user_kwargs):
        # globals: cxlog
        # attributes: log_, to_str, exists
        # strings: 'globtree', '(', ')isdir(', ')'
        ...

    def listdir(self, _path, *_user_args, **_user_kwargs):
        """This is an abstract method which must be implemented by subclasses.
It returns a tuple of (dirs, files) in the specified path.

If the implementation cannot distinguish between dirs and files quickly,
it may claim that files are dirs. The implementation will verify that
they are dirs if necessary using listdir() or exists().

If the path doesn't exist, return empty sequences.
"""
        # globals: NotImplementedError
        ...

    def exists(self, _path, *_user_args, **_user_kwargs):
        """This is an abstract method which must be implemented by subclasses.
It returns True if the specified path exists, and False otherwise.

Note that path will have a trailing '/' if it is meant to only match a
'folder'.
"""
        # globals: NotImplementedError
        ...

    def isdir(self, path, *user_args, **user_kwargs):
        """This is equivalent to exists(), but GlobTree will only call it
for dirs returned by listdir() and will always provide a /.

If the dirs tuple contains only directories, you may implement this by
returning True unconditionally. Otherwise, do not override the function,
and it will call exists()."""
        # attributes: exists
        ...


class FileGlobTree(GlobTree):
    """Implements the GlobTree class for file trees."""
    case_sensitive = True
    def listdir(self, path):
        # globals: os, OSError
        # attributes: listdir
        ...

    def exists(self, path):
        # globals: os
        # attributes: path, exists
        ...


def file_exists_insensitive(filename):
    # globals: FileGlobTree, os, len, list
    # attributes: add_glob, path, basename, matches, dirname
    # strings: ''
    ...

class FileContentGlobTree(FileGlobTree):
    """Performs the same FileGlobTree but further filters out files based on
their content. Specifically, the content of matching files must match
every regular expression pattern specified for that specific filename glob.
If that list is empty, then the file automatically matches.
"""
    def add_glob(self, glob, data):
        # globals: FileGlobTree, tuple
        # attributes: add_glob
        ...

    def add_content_glob(self, glob, patterns, data):
        """patterns is a list of strings specifying the regular expression
patterns that the file content must match.
See GlobTree.add_glob() for other details.
"""
        # globals: re, cxutils, FileGlobTree
        # attributes: append, compile, string_to_utf8, add_glob
        ...

    def matches(self, root, *user_args, **user_kwargs):
        # globals: FileGlobTree, open, IOError
        # attributes: matches, read, replace, search
        # strings: 'rb'
        ...
