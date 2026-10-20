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

profilesSet = <function profilesSet>()
dropin_C4PFile = <function dropin_C4PFile>()
taste_c4p = <function taste_c4p>()
prepare_temp_c4p = <function prepare_temp_c4p>()
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
    from_profile = <function C4ProfilesSet.from_profile>()
    add_c4p = <function C4ProfilesSet.add_c4p>()
    add_c4p_file = <function C4ProfilesSet.add_c4p_file>()
    is_c4p_file_trusted = <function C4ProfilesSet.is_c4p_file_trusted>()
    taste_new_c4p_file = <function C4ProfilesSet.taste_new_c4p_file>()
    _rebuild_profiles = <function C4ProfilesSet._rebuild_profiles>()
    all_profiles = <function C4ProfilesSet.all_profiles>()
    revoked_licenses = <function C4ProfilesSet.revoked_licenses>()
    load_tie_files = <function C4ProfilesSet.load_tie_files>()
    get_revoked_licenses = <function C4ProfilesSet.get_revoked_licenses>()
    def copy(self):
        # globals: C4ProfilesSet
        # attributes: update
        ...


online_file = os.path.join(C4ProfilesSet.tiedir, 'crossover.tie')
getOnlineFilePath = <function getOnlineFilePath>()
update_online_profiles = <function update_online_profiles>()
get_matching_profiles = <function get_matching_profiles>()
