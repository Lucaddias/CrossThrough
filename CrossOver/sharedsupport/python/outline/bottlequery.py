# bottlequery — reconstructed outline of CrossOver 26.3 lib/python/bottlequery.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import fcntl
import subprocess
import threading
import time
import collections
import cxproduct
import cxlog
import cxutils
import cxevent
import cxconfig
import cxobjc
import distversion
from cxutils import cxgettext as _
class BottleQuery(cxobjc.Proxy):
    pass

class NotFoundError(Exception):
    pass

def _validate_wineprefix(prefix):
    # globals: os
    # attributes: path, isdir, access, R_OK, exists, join, isfile
    # strings: '', 'system.reg', 'cxbottle.conf'
    ...

reserved_names = ['default', 'icons', 'installers', 'logs', 'tie']
_bottleListCache = []
def get_bottle_list():
    # globals: set, cxproduct, os, cxutils, _bottleListCache, reserved_names, _validate_wineprefix, list
    # attributes: get_bottle_path, get_managed_bottle_path, split, path, exists, listdir, string_to_unicode, add, lower, join
    # strings: ':'
    ...

unique_bottle_name = <function unique_bottle_name>()
is_valid_new_bottle_name = <function is_valid_new_bottle_name>()
def get_default_bottle():
    # globals: cxproduct, os, cxutils
    # attributes: get_bottle_path, get_managed_bottle_path, split, path, exists, join, string_to_unicode, basename, realpath
    # strings: ':', 'default', ''
    ...

def get_prefix_for_bottle(bottlename):
    # globals: cxproduct, os, _validate_wineprefix, NotFoundError, repr
    # attributes: get_bottle_path, get_managed_bottle_path, split, path, exists, join
    # strings: ':', 'There is no bottle named %s'
    ...

_nativePathCache = {}
def get_native_paths(bottlename, windowspaths):
    # globals: _nativePathCache, BottleManipulator, cxlog, time, KeyError
    # attributes: append, is_on, time, send, log_, join, pop, get, startswith, debug_str
    # strings: 'timing', 'unixpath %s', 'got %s unix paths in %0.2f seconds', ' ', 'path ', ''
    ...

def get_native_path(bottlename, windowspath):
    # globals: get_native_paths
    ...

_windowsPathCache = {}
def get_windows_paths(bottlename, unixpaths):
    # globals: _windowsPathCache, BottleManipulator, cxlog, time, KeyError
    # attributes: append, is_on, time, send, log_, join, pop, get, startswith, debug_str
    # strings: 'timing', 'windowspath %s', 'got %s unix paths in %0.2f seconds', ' ', 'path ', ''
    ...

def get_windows_path(bottlename, unixpath):
    # globals: get_windows_paths
    ...

def get_control_panel_info(bottlename, windowsdir=None):
    # globals: is_disabled, BottleManipulator, get_native_path, os, cxutils, cxconfig, distversion, _, OSError
    # attributes: send, get, path, join, mkdir, CX_ROOT, run, NULL, exists, Raw, read, lower, IS_MACOSX, append
    # strings: 'getwindowsdir', 'control-panel.db', 'ControlPanelDB', 'bin', 'wine', '--bottle', '--no-gui', '--wl-app', 'cxcplinfo.exe', '--all', 'appwiz.cpl/0', 'desk.cpl/0', 'Path', '', 'Name', 'Description', 'winecfg.exe', 'Wine Configuration', 'Built-in tool for configuring bottle settings', 'taskmgr.exe', 'Task Manager', 'Manage the applications and processes running in this bottle', 'wineboot.exe', 'Simulate Reboot', 'Simulate a system reboot in this bottle', 'cxassoceditui', 'Edit Associations', 'Manage the Windows programs used to open files in the native environment', 'cxmenueditui', 'Edit Menus', 'Manage the menus and desktop icons in this bottle'
    ...

def config_file_path(bottlename):
    # globals: get_prefix_for_bottle, os
    # attributes: path, join
    # strings: 'cxbottle.conf'
    ...

def get_config(bottlename):
    """Returns a cxconfig.Stack object that takes into account all the
configuration files relevant to the specified bottle."""
    # globals: cxproduct, config_file_path
    # attributes: get_config, copy, addconfig
    ...

def is_disabled(bottlename):
    # globals: distversion, get_config
    # attributes: IS_PREVIEW, get
    # strings: 'Bottle', 'Preview', '0', '1'
    ...

def is_managed(bottlename):
    # globals: get_config
    # attributes: get
    # strings: 'Bottle', 'Updater', ''
    ...

def get_system_drive(bottlename):
    # globals: get_win_environ, expand_win_string, get_native_path
    # strings: '%SystemDrive%'
    ...

def resolve_icon_path(iconPath, bottlename):
    # globals: BottleManipulator, os, get_native_path
    # attributes: send, get, path, join, basename, exists
    # strings: 'getwindowsdir', ''
    ...

def shutdown_manipulator(bottlename):
    # globals: BottleManipulator, NotFoundError
    # attributes: clean_shutdown
    ...

class AsyncManipResult(cxevent.AsyncResult):
    def __init__(self, manip):
        # globals: cxevent
        # attributes: AsyncResult, __init__, manip
        ...

    def _get(self):
        # globals: IOError
        # attributes: event, isSet, poll, manip, wait, r_pipe
        # strings: 'The cxmanip process quit before serving this query.'
        ...

    def get(self):
        # globals: IOError, is_disabled, NotFoundError
        # attributes: _get, manip, bottlename, with_traceback, __traceback__
        ...


_BottleManipulator_cache = {}
class _BottleManipulator:
    def __init__(self, bottlename):
        # globals: threading, time
        # attributes: bottlename, Lock, lock, started, got_ok, closing, thread, subp, stdin, buf, results, to_write, chars_written, time, _last_activity_time
        ...

    def _fail_pending_requests(self):
        """self.lock must be acquired when this is called."""
        # globals: IOError
        # attributes: results, set_error, to_write, chars_written
        # strings: 'The cxmanip process quit before serving this query.'
        ...

    def _start(self):
        """self.lock must be acquired when this is called."""
        # globals: os, cxutils, cxlog, subprocess, fcntl, threading
        # attributes: started, _fail_pending_requests, path, join, CX_ROOT, bottlename, log, to_str, Popen, PIPE, subp, stdin, fileno, stdout, fcntl, F_SETFD, FD_CLOEXEC, buf, got_ok, closing, Thread, _thread_proc, thread, start, debug_str
        # strings: 'bin', 'wine', '--no-wait', '--no-gui', '--bottle', '--wl-app', 'cxmanip', 'starting command ', ' ', ' in '
        ...

    def _read(self):
        """self.lock must be acquired when this is called
read from the pipe, without blocking.
"""
        # globals: cxutils, cxlog, os, time
        # attributes: started, select, stdout, log, to_str, bottlename, read, subp, poll, _close, buf, time, _last_activity_time, got_ok, startswith, split, results, pop, set, string_to_str, is_on, log_, closing
        # strings: 'cxmanip process in %s died (read error)', 'cxmanip process in %s died with return code %d (read error)', 'manip', ': <- '
        ...

    def _write(self):
        """self.lock must be acquired when this is called
write any remaining bytes to the pipe, without blocking.

Returns True if it worked, False if the process needs to be started.
"""
        # globals: len, cxutils, cxlog, time, os, OSError
        # attributes: started, chars_written, to_write, select, stdin, log, to_str, bottlename, time, _last_activity_time, write
        # strings: 'cxmanip process in %s died (write error)'
        ...

    def wait(self, r=None, timeout=None):
        """blocks until r becomes readable, the cxmanip process dies, or there
is no activity for at least timeout seconds"""
        # globals: cxutils, time
        # attributes: started, to_write, stdin, stdout, select, results, time, _last_activity_time, lock, _write, _read, select_error
        ...

    def _thread_proc(self, subp):
        # globals: time
        # attributes: started, wait, lock, results, time, _last_activity_time, _close
        ...

    def _send_command(self, string):
        """self.lock must be acquired when this is called.

Send the given command to cxmanip and return an async result for it,
if cxmanip is started. Otherwise, return None."""
        # globals: AsyncManipResult, cxutils
        # attributes: to_write, string_to_utf8, results, append, _write
        ...

    def send(self, string):
        # globals: cxlog, cxutils, AsyncManipResult, IOError
        # attributes: log_, to_str, bottlename, debug_str, string_to_utf8, lock, _send_command, _start, set_error
        # strings: 'manip', ': -> ', 'Could not start the cxmanip process'
        ...

    def _close(self):
        """self.lock must be acquired when this is called"""
        # globals: cxlog
        # attributes: started, subp, stdin, close, stdout, log, to_str, bottlename
        # strings: 'shutting down cxmanip process in %s'
        ...

    def close(self):
        # attributes: lock, _close
        ...

    def clean_shutdown(self):
        """cleanly shut down the cxmanip process when there are no pending requests"""
        # attributes: lock, results, _close, closing
        ...

    def __del__(self):
        # attributes: close
        ...


def BottleManipulator(bottlename):
    # globals: is_disabled, NotFoundError, repr, _BottleManipulator_cache, KeyError, _BottleManipulator
    # strings: 'Bottle %s is disabled'
    ...

def reset_cache(bottlename):
    # globals: _bottleListCache, shutdown_manipulator, _BottleManipulator_cache, _nativePathCache, _windowsPathCache
    # attributes: remove, pop
    ...

REG_WIN32 = '32\\'
REG_NATIVE = ''
REG_BOTH = '3264\\'
def _manip_unescape(string):
    # attributes: replace
    # strings: '\\0', '\x00', '\\n', '\n', '\\\\', '\\'
    ...

def deserialize_reg(lines):
    # globals: _manip_unescape, int, range, len, NotFoundError, ValueError
    # attributes: startswith, split, rstrip, lower, join, append
    # strings: 'value ', ' ', '\\0 ', '\x00', '=', '', 'subkey ', 'registry key not found', 'got unexpected data: %s'
    ...

def get_registry_key(bottlename, path, arch=REG_NATIVE):
    # globals: BottleManipulator, cxlog, time, cxutils, deserialize_reg
    # attributes: log, debug_str, to_str, is_on, time, string_to_str, send, get, log_, split
    # strings: 'getting registry tree for ', ' in ', 'timing', 'getregkey ', 'got registry tree for %s in %0.3f seconds', '\n'
    ...

def set_registry_key(bottlename, path, name, value, arch=REG_NATIVE):
    # globals: BottleManipulator, cxlog, time, cxutils
    # attributes: log, debug_str, to_str, is_on, time, string_to_str, startswith, send, get, log_
    # strings: 'setting registry [', '/', '] in ', ' to ', 'timing', '\\n', 'str:', 'setregkey %s', 'set registry tree for %s in %0.3f seconds', 'success', 'setting registry error is %s'
    ...

def unset_registry_value(bottlename, path, name, arch=REG_NATIVE):
    # globals: BottleManipulator, cxutils, cxlog
    # attributes: string_to_str, send, get, log, to_str
    # strings: '\\n', 'rmregvalue %s', 'success', 'removing registry value error is %s'
    ...

WindowsVersion = collections.namedtuple('WindowsVersion', ['Version', 'Description', 'CurrentVersion', 'MajorVersion', 'MinorVersion', 'BuildNumber', 'UBR', 'PlatformId', 'CSDVersion', 'ServicePackMajor', 'ServicePackMinor', 'ProductType'])
_windows_versions = [WindowsVersion('win11', 'Windows 11', '6.3', 10, 0, 22000, 588, 2, ' ', 0, 0, 'WinNT'), WindowsVersion('win10', 'Windows 10', '6.3', 10, 0, 19045, 5796, 2, ' ', 0, 0, 'WinNT'), WindowsVersion('win81', 'Windows 8.1', None, 6, 3, 9600, 0, 2, ' ', 0, 0, 'WinNT'), WindowsVersion('win8', 'Windows 8', None, 6, 2, 9200, 0, 2, ' ', 0, 0, 'WinNT'), WindowsVersion('win2008r2', 'Windows 2008 R2', None, 6, 1, 7601, 0, 2, 'Service Pack 1', 1, 0, 'ServerNT'), WindowsVersion('win7', 'Windows 7', None, 6, 1, 7601, 0, 2, 'Service Pack 1', 1, 0, 'WinNT'), WindowsVersion('win2008', 'Windows 2008', None, 6, 0, 6002, 0, 2, 'Service Pack 1', 0, 0, 'ServerNT'), WindowsVersion('vista', 'Windows Vista', None, 6, 0, 6002, 0, 2, 'Service Pack 2', 2, 0, 'WinNT'), WindowsVersion('win2003', 'Windows 2003', None, 5, 2, 3790, 0, 2, 'Service Pack 2', 2, 0, 'ServerNT'), WindowsVersion('winxp', 'Windows XP', None, 5, 1, 2600, 0, 2, 'Service Pack 3', 3, 0, 'WinNT'), WindowsVersion('win2k', 'Windows 2000', None, 5, 0, 2195, 0, 2, 'Service Pack 4', 4, 0, 'WinNT'), WindowsVersion('winme', 'Windows ME', None, 4, 90, 3000, 0, 1, ' ', 0, 0, ''), WindowsVersion('win98', 'Windows 98', None, 4, 10, 2222, 0, 1, ' A ', 0, 0, ''), WindowsVersion('win95', 'Windows 95', None, 4, 0, 950, 0, 1, '', 0, 0, ''), WindowsVersion('nt40', 'Windows NT 4.0', None, 4, 0, 1381, 0, 2, 'Service Pack 6a', 6, 0, 'WinNT'), WindowsVersion('nt351', 'Windows NT 3.5', None, 3, 51, 1057, 0, 2, 'Service Pack 2', 0, 0, 'WinNT'), WindowsVersion('win31', 'Windows 3.1', None, 3, 10, 0, 0, 0, 'Win32s 1.3', 0, 0, ''), WindowsVersion('win30', 'Windows 3.0', None, 3, 0, 0, 0, 0, 'Win32s 1.3', 0, 0, ''), WindowsVersion('win20', 'Windows 2.0', None, 2, 0, 0, 0, 0, 'Win32s 1.3', 0, 0, '')]
_gettable_versions = [WindowsVersion('win10', 'Windows 10', '6.3', 10, 0, 19043, 1466, 2, ' ', 0, 0, 'WinNT'), WindowsVersion('win10', 'Windows 10', '6.3', 10, 0, 18362, 0, 2, ' ', 0, 0, 'WinNT'), WindowsVersion('win10', 'Windows 10', None, 10, 0, 10240, 0, 2, ' ', 0, 0, 'WinNT')]
_gettable_versions.extend(_windows_versions)
version_nicknames = {'win2000': 'win2k', 'nt2k': 'win2k', 'nt2000': 'win2k', 'win2k3': 'win2003', 'winvista': 'vista', 'win2k8': 'win2008', 'win2k8r2': 'win2008r2'}
_settable_versions = [WindowsVersion('winxpsp1', 'Windows XP', None, 5, 1, 2600, 0, 2, 'Service Pack 1', 1, 0, 'WinNT'), WindowsVersion('winxpsp2', 'Windows XP', None, 5, 1, 2600, 0, 2, 'Service Pack 2', 2, 0, 'WinNT')]
_settable_versions.extend(_windows_versions)
def set_windows_version(bottlename, version):
    # globals: version_nicknames, _settable_versions, get_config, WindowsVersion, unset_registry_value, REG_BOTH, set_registry_key
    # attributes: get, Version, PlatformId, MajorVersion, MinorVersion, BuildNumber, CSDVersion, Description, CurrentVersion, UBR, ProductType, ServicePackMajor, ServicePackMinor
    # strings: 'winxp', 'Bottle', 'WineArch', 'win32', 'win64', 'Windows XP', 'Service Pack 3', 'WinNT', 'HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion', 'CSDVersion', 'CurrentVersion', 'CurrentMajorVersionNumber', 'CurrentMinorVersionNumber', 'CurrentBuildNumber', 'CurrentBuild', 'ProductName', 'UBR', 'HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\ProductOptions', 'ProductType', 'HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Windows', 'HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\Session Manager\\Environment', 'OS', 'HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion', 'VersionNumber', 'SubVersionNumber', 'HKEY_CURRENT_USER\\Software\\Wine', 'Version', 'str:', 'str:%d.%d.%d', 'str:Microsoft ', '%d.%d', 'dword:%02x', 'str:%d', 'dword:%02x%02x', 'Windows_NT'
    ...

def get_windows_version(bottlename):
    # globals: get_registry_key, _gettable_versions, _windows_versions, int, NotFoundError
    # attributes: Version, MajorVersion, MinorVersion, BuildNumber, PlatformId, CurrentVersion, ProductType
    # strings: 'HKEY_CURRENT_USER\\Software\\Wine', 'version', 'HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion', 'versionnumber', '%d.%d.%d', 'winxp', 'HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion', 'HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Control\\ProductOptions', 'currentversion', 'currentbuildnumber', 'producttype', '%d.%d', '%d'
    ...

def get_windows_version_name(version):
    # globals: version_nicknames, _gettable_versions, _
    # attributes: get, Version, Description
    # strings: 'Unknown'
    ...

def get_unix_environ(bottlename=None):
    """Get the Unix environment that should be in effect for the specified
bottle.

If bottlename is None, then only the non-bottle specific variables (i.e.
CX_ROOT) are set."""
    # globals: os, cxutils, get_prefix_for_bottle
    # attributes: environ, copy, CX_ROOT
    # strings: 'CX_ROOT', 'CX_BOTTLE', 'WINEPREFIX'
    ...

def expand_unix_string(bottlename, string):
    """Expand references to environment variables of the form '${VARNAME}' in
the specified string.

The environment is the one appropriate for the specified bottle (see
get_unix_environ()).
"""
    # globals: cxutils, get_unix_environ
    # attributes: expand_unix_string
    ...

def get_win_environ(bottlename, varnames=None):
    """Returns a mapping of the specified environment variable names to their
values. If no variable name is specified, then all the Windows environment
variables are returned.

Note that the actual Windows environment is augmented with a couple of
variables: accessories, desktop, startmenu and programs. In order to get
these, they must be requested by name though. FIXME: Or not, we'll see.
"""
    # globals: BottleManipulator
    # attributes: send, get, lower
    # strings: 'getexpandedstr %s'
    ...

def expand_win_string(environ, string):
    """Expands references to Windows environment variables using the specified
environment block.
"""
    # globals: cxlog, ValueError
    # attributes: split, lower, warn, to_str
    # strings: '%', 'unable to expand %s', ''
    ...

def add_drive(bottlename, unix_path):
    # globals: BottleManipulator, NotFoundError, repr, ValueError
    # attributes: send, get, strip, startswith
    # strings: 'adddrive %s', '', 'drive ', 'errno 2', 'Path not found %s', 'got unexpected data: %s'
    ...

def rm_drive(bottlename, drive_letter):
    # globals: BottleManipulator, NotFoundError, repr, ValueError
    # attributes: send, get, strip
    # strings: 'rmdrive %s', 'errno 2', 'No such drive letter as ', ' in ', 'got unexpected data: %s'
    ...
