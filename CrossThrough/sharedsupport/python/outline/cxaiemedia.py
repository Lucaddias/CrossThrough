# cxaiemedia — reconstructed outline of CrossOver 26.3 lib/python/cxaiemedia.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import os.path
import stat
import tempfile
import hashlib
from urllib.parse import parse as urlparse
import cxproduct
import cxlog
import cxurlget
import cxutils
import globtree
import cxaiebase
import cxhtmlutils
import shutil
from cxutils import cxgettext as _
def needs_installer_file(iprofile):
    """Returns True if the specified installer profile needs an installer
file. False means the profile is either virtual, or just copies files
around.
"""
    # globals: len
    # attributes: parent, app_profile, flags, files_to_copy, installer_file_globs
    # strings: 'virtual', ':stop:'
    ...

def find_file(path, globs):
    """Looks for a file matching the one of the globs in the list."""
    # globals: globtree, range, len
    # attributes: FileGlobTree, add_glob, matches, append
    ...

def locate_installer(iprofile, install_source):
    """Tries to find an installer file for the specified profile."""
    # globals: find_file, cxlog, len
    # attributes: installer_file_globs, append, extend, log, debug_str
    # strings: ':stop:', 'no match for ', 'got a tie for ', ': '
    ...

class AIEInsertMedia(cxaiebase.AIETask):
    """Asks the user to insert or specify the path to the installation media
needed for the associated AIECore (either a CD or a file installer).

This also marks the media as being in use until it is released by the
corresponding AIEReleaseMedia task.
"""
    def can_run(self):
        """Returns True if this task is runnable and another media is not
already in use.
"""
        # globals: cxaiebase
        # attributes: scheduler, userdata, AIETask, can_run
        # strings: 'AIEMedia'
        ...

    def _getniceness(self):
        """Run whatever installers are available before asking for new media.
        """
        # attributes: aiecore, niceness
        ...

    niceness = property(_getniceness)
    def schedule(self):
        # globals: cxaiebase
        # attributes: AIETask, schedule, scheduler, userdata
        # strings: 'AIEMedia'
        ...

    def __init__(self, aiecore):
        # globals: cxaiebase
        # attributes: AIETask, __init__, scheduler, aiecore, add_dependency, install_source
        # strings: ''
        ...

    def __unicode__(self):
        # attributes: __class__, __name__, aiecore, name
        # strings: '(', ')'
        ...

    def main(self):
        # globals: _, os, needs_installer_file, locate_installer
        # attributes: install_source, error, startswith, aiecore, state, path, isfile, isdir, installer, udf_remount_check, exists, join, scheduler, installtask, source_medias, device, getuid
        # strings: 'The source media is not set.', 'steam:', 'install_source', "'%s' should either be a file or a directory", '', '/dev/cdrom', 'This disk contains two sections, one for Mac and one for Windows. In order for CrossOver to use this disk it must be..., 'installer_file', "Unable to find an installer in '%s'"
        ...


class AIEReleaseMedia(cxaiebase.AIENop):
    """Releases the media that was inserted by the AIEInsertMedia task.

This signals other AIEInsertMedia tasks that they can run.
"""
    def __init__(self, aiecore):
        # globals: cxaiebase
        # attributes: AIENop, __init__, scheduler, name, aiecore, add_dependency
        # strings: 'Release '
        ...

    def __unicode__(self):
        # attributes: __class__, __name__, aiecore, name
        # strings: '(', ')'
        ...

    def done(self):
        # globals: cxlog, cxaiebase, KeyError
        # attributes: scheduler, userdata, aiecore, insert_media, err, to_str, AIETask, done
        # strings: 'AIEMedia', 'mismatched Insert/Release (', ' / ', ')', ': AIEMedia should have been set'
        ...


def get_builtin_installer(appid):
    """If the application has a builtin installer, returns the path to that
installer. Otherwise, returns None.
"""
    # globals: os, cxutils, cxlog
    # attributes: path, join, CX_ROOT, log_, to_str, exists, listdir, startswith
    # strings: 'lib', 'installers', '.', 'aie', 'looking for ', '  -> '
    ...

def get_cached_filename(url, filename):
    """Use the hashed URL so we can cache each localized installer separately,
and so we automatically update the installer if the URL changed.
"""
    # globals: hashlib, cxutils
    # attributes: md5, update, string_to_utf8, split, hexdigest
    # strings: '#', '.'
    ...

def _is_cache_filename(name):
    # globals: len, all
    # attributes: startswith
    # strings: 'local.tmp.', '.'
    ...

def size_cached_installers():
    # globals: cxproduct, os, _is_cache_filename, stat
    # attributes: get_installer_dir, path, exists, listdir, join, lstat, S_ISREG, st_mode, st_size
    ...

def delete_cached_installers():
    # globals: cxproduct, os, _is_cache_filename, stat
    # attributes: get_installer_dir, path, exists, listdir, join, lstat, S_ISREG, st_mode, unlink
    ...

def verify_checksum(filename, checksum):
    # globals: hashlib, open, cxlog, ValueError, TypeError, len
    # attributes: split, new, read, update, hexdigest, lower, warn, debug_str
    # strings: ';', ':', 'rb', 'Checksum mismatch: got ', ', expected ', 'Failed to create hash object for %s'
    ...

class AIEDownload(cxaiebase.AIETask):
    def __init__(self, aiecore):
        """Initializes the download task for the specified AIECore object."""
        # globals: cxaiebase, _
        # attributes: AIETask, __init__, scheduler, name, aiecore, add_dependency, _getter, canceled, download_task
        # strings: 'Downloading %s'
        ...

    def __unicode__(self):
        # attributes: __class__, __name__, aiecore, name
        # strings: '(', ')'
        ...

    def can_cancel(self):
        ...

    def cancel(self):
        # globals: cxaiebase
        # attributes: AIETask, cancel, canceled
        ...

    def _getniceness(self):
        """Start downloads as soon as possible."""
        # attributes: aiecore, niceness
        ...

    niceness = property(_getniceness)
    def _get_url_and_checksum(self):
        # globals: cxutils
        # attributes: aiecore, installer, parent, app_profile, download_urls_64bit, scheduler, installtask, is64bit, download_urls, get_language_value, realInstallerLocale
        ...

    def _geturl(self):
        # attributes: _get_url_and_checksum
        ...

    url = property(_geturl)
    def _getchecksum(self):
        # attributes: _get_url_and_checksum
        ...

    checksum = property(_getchecksum)
    @property
    def download_page_url(self):
        # attributes: aiecore, installer, parent, app_profile, download_page_url, url
        ...

    def validate_installer(self, filename):
        """Checks whether the specified file is valid.

Returns a tuple of:
    True if the file is valid, otherwise False.
    The target if the file is html with a redirect.
    A suggested error message if the file is invalid.
"""
        # globals: cxhtmlutils, _, verify_checksum
        # attributes: is_html, url, checksum
        # strings: 'Got an HTML file instead of an installer for %s', 'The downloaded installer did not match the checksum for %s'
        ...

    def get_cached_installer(self):
        """Checks whether we have an installer for the specified url in our
downloaded installers cache.
"""
        # globals: get_cached_filename, cxlog, os, cxproduct, OSError
        # attributes: url, log_, to_str, path, isdir, join, get_user_dir, get_installer_dir, rename, get_managed_dir, listdir, startswith, isfile, validate_installer, unlink
        # strings: '', 'aie', 'looking for ', 'installers', '  -> ', '  -> deleted (%s)'
        ...

    def _needs_download(self):
        """Returns True if the installer needs to be downloaded, and False
otherwise.
"""
        # globals: os, get_builtin_installer, KeyError
        # attributes: aiecore, state, path, exists, installer, parent, appid, always_redownload, get_cached_installer
        # strings: 'install_source'
        ...

    needs_download = property(_needs_download)
    def set_installer_file(self, installer_file):
        """Sets the installer file to use."""
        # globals: cxlog
        # attributes: log_, to_str, debug_str, aiecore, state, installer, always_redownload
        # strings: 'aie', ': install_source = ', 'install_source', 'temp_install_source'
        ...

    @staticmethod
    def get_installers_dir():
        # globals: cxproduct, cxutils
        # attributes: get_installer_dir, mkdirs
        ...

    installers_dir = property(get_installers_dir)
    def _getsize(self):
        """This is -1 if the download has not started yet.

This is 0 if the download has started but the size is unknown.
Otherwise it is the size in bytes.
"""
        # attributes: _getter, bytes_total
        ...

    size = property(_getsize)
    def _getdownloaded(self):
        """This is the number of bytes that have been downloaded."""
        # attributes: _getter, bytes_downloaded
        ...

    downloaded = property(_getdownloaded)
    def _getprogress(self):
        """This is a number between 0 and 1 representing the percentage that
has been downloaded. If the download size is 0, then progress is -1.
"""
        # attributes: _getter, bytes_total, bytes_downloaded
        ...

    progress = property(_getprogress)
    def urlgetter_failed(self, urlgetter, exception):
        # globals: isinstance, cxurlget, _, cxlog, str
        # attributes: HttpError, code, user_agent, to_str, url, error, UrlError, debug_str
        # strings: "'%s' returned an HTML file instead of the installer", "HTTP error 404: The file '%s' could not be found.", 'The HTTP server returned failure code %s.'
        ...

    def urlgetter_progress(self, _urlgetter):
        # globals: cxurlget
        # attributes: canceled, StopDownload
        ...

    def main(self):
        # globals: cxurlget, range, tempfile, os, urlparse, get_cached_filename, shutil, cxutils, OSError
        # attributes: needs_download, canceled, UrlGetter, make_cookie_storage, get_installers_dir, url, USER_AGENT, mkstemp, fdopen, urlgetter_progress, urlgetter_failed, _getter, fetch, error, unlink, validate_installer, urljoin, path, join, basename, move, chmod, UMASK, set_installer_file, strerror
        # strings: 'local.tmp.', 'wb'
        ...


class AIEScanMedia(cxaiebase.AIETask):
    """Scans the media looking for extra installers for dependencies.

This helps us avoid downloads.
"""
    def __init__(self, aiecore):
        # globals: cxaiebase
        # attributes: AIETask, __init__, scheduler, aiecore
        # strings: ''
        ...

    def __unicode__(self):
        # attributes: __class__, __name__, aiecore, name
        # strings: '(', ')'
        ...

    def main(self):
        # globals: os, globtree, isinstance, AIEDownload, len, range, cxlog
        # attributes: aiecore, insert_media, install_source, path, isdir, FileGlobTree, parents, needs_download, installer, local_installer_file_globs, add_glob, matches, append, items, log, to_str, debug_str, add_dependency, release_media, state
        # strings: 'got a tie for ', ': ', 'install_source', 'silentinstall'
        ...

    def done(self):
        # globals: isinstance, AIEDownload, cxaiebase, cxlog
        # attributes: scheduler, lock, parents, aiecore, parent_media, insert_media, status, TASK_DONE, log_, to_str, append, unlock, clear_dependencies, AIETask, done
        # strings: 'aie', '  clearing the %s dependencies'
        ...
