# c4profilesmanager — reconstructed outline of CrossOver 26.3 lib/python/c4profilesmanager.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Handles refreshing and reading the C4 profile information."""
import os
import threading
import time
import cxobjc
import cxlog
import cxutils
import cxproduct
import c4profiles
import distversion
import fileupdate
import cddetector
import downloaddetector
import c4parser
import shutil
class _C4PSource:
    """This is a helper class for C4ProfilesSet.

It keeps track of a couple of extra data about a C4Pfile object: its old
list of profiles and its last modification time.

The 'trusted' flag marks profiles that are official
CodeWeavers profiles. Untrusted profiles will produce a
user warning upon selection. Ideally this will be handled via
signing but at the moment it is based on where the files came from.

The 'source' member marks profiles which were added at runtime via
associations or drag and drop. It's used for ranking when
there are profile collisions. Possible values are
builtin, download, dropin
"""
    def __init__(self, c4pfile, trusted=True, source=c4profiles.builtin):
        # attributes: c4pfile, profiles, mtime, trusted, source
        ...


class C4Profiles(cxobjc.Proxy):
    pass

@cxobjc.method(C4Profiles, 'profilesSet')
def profilesSet():
    # globals: C4ProfilesSet
    # attributes: all_profiles
    ...

@cxobjc.method(C4Profiles, 'dropinC4PFile_withSig_')
def dropin_C4PFile(c4pfilename, sigfilepath):
    # globals: cxutils, C4ProfilesSet, c4profiles
    # attributes: string_to_str, add_c4p_file, dropin
    ...

@cxobjc.method(C4Profiles, 'tasteC4PFile_')
def taste_c4p(sourcetie):
    # globals: C4ProfilesSet, os
    # attributes: taste_new_c4p_file, remove
    ...

@cxobjc.method(C4Profiles, 'prepareSingleUseC4PFile_')
def prepare_temp_c4p(c4pfilename):
    # globals: fileupdate
    # attributes: prepare
    ...

class C4ProfilesSet(dict):
    """A mapping of application ids to the corresponding C4Profile objects."""
    def __init__(self):
        """Adds a data mapping attribute that third parties can use to store
or cache data related to this profiles set.
"""
        # globals: dict
        # attributes: __init__, userdata
        ...

    def installer_profiles(self, appid):
        """Returns the application's installer profiles if any, and the
unknown application installer profiles otherwise.
"""
        # globals: c4profiles, KeyError
        # attributes: app_profile, installer_id, installer_profiles, UNKNOWN
        ...

    def unknown_installer(self):
        # globals: c4profiles
        # attributes: UNKNOWN, installer_profiles
        ...

    def unknown_profile(self):
        # globals: c4profiles
        # attributes: UNKNOWN
        ...

    def contentsDict(self):
        # globals: dict
        ...

    _lock = threading.Lock()
    _update_lock = threading.Lock()
    _updating = False
    _retry_update = False
    _sources = {}
    _last_checked = 0
    _profiles = None
    _revoked_licenses = set()
    _mtimes = {}
    tiedir = os.path.join(cxproduct.get_user_dir(), 'tie')
    @classmethod
    def from_profile(cls, profile):
        # attributes: appid
        ...

    @classmethod
    def add_c4p(cls, c4pfile):
        """Adds the specified CrossTie profile to the global database.

The CrossTie file is then watched for updates and re-read if it is
modified.
"""
        # globals: _C4PSource
        # attributes: _lock, trusted, source, _sources, filename, _last_checked, _updating, _retry_update
        ...

    @classmethod
    def add_c4p_file(cls, c4pfilename, sigfile=None, source=c4profiles.builtin):
        """Reads the specified c4p file and add its profiles to the global
database.

The c4p file is then watched for updates and re-read if it is modified.
"""
        # globals: c4profiles, os, shutil, cxlog, c4parser
        # attributes: _sources, is_c4p_file_trusted, download, path, exists, move, err, remove, C4PFile, add_c4p
        # strings: '.new', "Deleting '%s' because it lacks a valid signature."
        ...

    @classmethod
    def is_c4p_file_trusted(cls, filepath, sigfilepath=None):
        """Evaluate the trustworthiness of a c4p. Typically the
signature filename (if it exists) can be derived from
the filepath. When using temp files (e.g. via taste_new_c4p_file)
the sigfile may have been uniquely generated in which case
it needs to be specified here.
"""
        # globals: cxutils, fileupdate
        # attributes: startswith, CX_ROOT, is_signed
        ...

    @classmethod
    def taste_new_c4p_file(cls, sourcetie):
        """For GUI purposes it is useful to be able to detect if a file will be
trusted or untrusted before we actually load it into any CrossOver
dirs. This function prepares and tests the signature of a CrossTie file
using disposable temp files.

Returns a (trusted, tmptie, tmpsig) triplet where trusted is True if
the file is trusted and False otherwise, and tmptie and tmpsig are the
temporary filenames if the file is trusted.
"""
        # globals: fileupdate, os
        # attributes: prepare, is_c4p_file_trusted, remove
        ...

    @classmethod
    def _rebuild_profiles(cls, sources):
        # globals: C4ProfilesSet, distversion, c4profiles, cxutils, len, time, Exception, cxlog
        # attributes: values, c4pfile, profiles, highlightedapps, platform, PLATFORM, append, appid, trusted, revokelist, get_revokelist_file, lock_file, string_to_str, first, last, save_and_unlock_file, is_revoked, is_highlighted, score, _lock, _retry_update, _profiles, time, _last_checked, _updating, err, debug_str
        # strings: '', '..', 'Range%s', 'an error occurred while reading ', ':\n'
        ...

    @classmethod
    def all_profiles(cls):
        """Returns a mapping of application ids to the corresponding C4Profile
objects.

This automatically reads or re-reads the relevant c4p files if needed
but will always return a consistent view of the underlying c4p profile
database.
"""
        # globals: time
        # attributes: load_tie_files, _lock, _updating, _profiles, _last_checked, time, _retry_update, _sources, copy, _update_lock, values, c4pfile, update, _mtimes, trusted, _revoked_licenses, disabled_licenses, _rebuild_profiles
        ...

    @classmethod
    def revoked_licenses(cls):
        """Read only the revoked licenses from the c4p files."""
        # globals: time
        # attributes: load_tie_files, _lock, _updating, _profiles, _last_checked, time, _sources, copy, _update_lock, values, c4pfile, update, trusted, _revoked_licenses, disabled_licenses
        ...

    @classmethod
    def load_tie_files(cls):
        # globals: os, cxutils, c4profiles, online_file
        # attributes: _update_lock, path, join, CX_ROOT, add_c4p_file, builtin, exists, tiedir, listdir, splitext, basename, download, dropin
        # strings: 'share/crossover/data', '.c4p', '.tie'
        ...

    @classmethod
    def get_revoked_licenses(cls):
        """Returns a set of revoked license id's."""
        # attributes: revoked_licenses, _revoked_licenses
        ...

    def copy(self):
        # globals: C4ProfilesSet
        # attributes: update
        ...


online_file = os.path.join(C4ProfilesSet.tiedir, 'crossover.tie')
@cxobjc.method(C4Profiles, 'getOnlineFilePath')
def getOnlineFilePath():
    # globals: online_file
    ...

@cxobjc.method(C4Profiles, 'updateOnlineProfilesFromURL_')
def update_online_profiles(url):
    # globals: fileupdate, online_file
    # attributes: update
    ...

@cxobjc.method(C4Profiles, 'getMatchingProfiles_')
def get_matching_profiles(path):
    # globals: C4ProfilesSet, os, cddetector, downloaddetector
    # attributes: all_profiles, path, isdir, get_cd_profiles, isfile, find_profiles
    ...
