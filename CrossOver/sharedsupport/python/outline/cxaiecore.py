# cxaiecore — reconstructed outline of CrossOver 26.3 lib/python/cxaiecore.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import errno
import os
import os.path
import shutil
import stat
import zipfile
import tarfile
import tempfile
import threading
import traceback
import cxlog
import cxutils
import globtree
import bottlequery
import cxaiebase
import cxaiemedia
import distversion
import appdetector
from cxutils import cxgettext as _
def tar_member_depth(member):
    """Returns the number of directories leading up to this file"""
    # globals: os
    # attributes: path, normpath, name, count
    # strings: '/'
    ...

class AIECore(cxaiebase.AIETask):
    """Installs a specific application."""
    def _getniceness(self):
        """Start downloads before all else."""
        # attributes: depth
        ...

    niceness = property(_getniceness)
    def can_run(self):
        """Returns True if this task is runnable and no other instance of it
is running.
"""
        # globals: cxaiebase
        # attributes: scheduler, userdata, AIETask, can_run
        # strings: 'AIECore'
        ...

    def schedule(self):
        # globals: cxaiebase
        # attributes: AIETask, schedule, scheduler, userdata
        # strings: 'AIECore'
        ...

    def done(self):
        # globals: cxaiebase, KeyError, cxlog
        # attributes: AIETask, done, scheduler, userdata, err, to_str
        # strings: 'AIECore', ': AIECore should have been set'
        ...

    def __init__(self, engine, installer):
        # globals: cxaiebase, _, set, threading
        # attributes: AIETask, __init__, parent, name, installer, _has_printed_install_log_err, download, insert_media, scan_media, release_media, canceled, interactive, parent_media, Lock, cleanup_lock, depth, state
        # strings: 'Installing %s'
        ...

    def _getname(self):
        """A helper function that returns the associated profile name."""
        # attributes: installer, parent, name
        ...

    name = property(_getname)
    def _getaiecore(self):
        """A helper function that makes AIECore more similar to other types of
tasks.
"""
        ...

    aiecore = property(_getaiecore)
    def __unicode__(self):
        # attributes: __class__, __name__, name
        # strings: '(', ')'
        ...

    def create_download_task(self):
        # globals: cxaiemedia
        # attributes: AIEDownload, download
        ...

    def create_media_tasks(self):
        # globals: cxaiemedia
        # attributes: AIEInsertMedia, insert_media, AIEScanMedia, scan_media, add_dependency, AIEReleaseMedia, release_media
        ...

    def run_routines(self, prefix, routines):
        # globals: iter, AIECore, cxlog, _, KeyError
        # attributes: state, canceled, __dict__, log_, to_str, error, err
        # strings: 'iter', 'routine_iterator', 'no_', '_', 'aie', '  running ', '  -> returned False', ' did not set self.error', 'An unknown error occurred in %s', 'AIECore._', ' does not exist!'
        ...

    def _prep_all_fonts(self):
        # globals: cxlog, isinstance, AIECore
        # attributes: log_, to_str, installer, parent, appid, dependencies, state, name
        # strings: 'aie', 'appid=', 'com.codeweavers.c4.6959', 'silentfontinstall', 'set silentfontinstall on '
        ...

    def _prep_collate_skips(self):
        # globals: set
        # attributes: scheduler, state, installer, skip_assoc_creation, skip_menu_creation
        # strings: 'skipassoc', 'skipmenu', 'mainmenu_never', 'defaulteassocs', 'alteassocs'
        ...

    def prepare(self):
        """This method is called by the install engine after all the
AIECore tasks have been created. The calls are made on children before
the tasks that depend on them. They are not allowed to fail.
"""
        # attributes: run_routines
        # strings: 'prep'
        ...

    def _main_setup_drive_letter(self):
        """Create a drive letter for the install source if needed."""
        # globals: os, bottlequery
        # attributes: state, get, path, isdir, add_drive, scheduler, installtask, bottlename
        # strings: 'install_source', 'temporary_drive'
        ...

    def _cleanup_delete_drive_letter(self):
        """Delete the temporary drive letter if we created one."""
        # globals: bottlequery
        # attributes: state, rm_drive, scheduler, installtask, bottlename
        # strings: 'temporary_drive'
        ...

    def _main_setup_winver(self):
        """Temporarily change the windows version of the bottle if needed."""
        # globals: bottlequery
        # attributes: installer, installer_winver, version_nicknames, get, scheduler, installtask, bottlename, get_windows_version, state, set_windows_version
        # strings: 'orig_winver'
        ...

    def _cleanup_reset_winver(self):
        """Restore the windows version in this bottle if we changed it."""
        # globals: bottlequery
        # attributes: state, set_windows_version, scheduler, installtask, bottlename
        # strings: 'orig_winver'
        ...

    def _main_set_installer_file(self):
        """Check that we have an installation source and initialize
installer_file as appropriate.
"""
        # globals: cxlog, _, os
        # attributes: state, get, installer, parent, app_profile, flags, warn, debug_str, name, error, path, isfile, dirname, lower, startswith, isdir
        # strings: 'install_source', 'virtual', 'install_source = ', ' for the ', ' virtual profile!', 'No installation source was provided for %s', 'installer_file', 'steam:', "The '%(source)s' installation source of %(name)s is neither a file nor a directory!"
        ...

    def _main_setup_installer_environment(self):
        """Set up the Unix environment to be used by the Windows installer
(i.e. any of this task's child process).
"""
        # attributes: scheduler, state, copy, installer, installer_environment, expand_win_string, value, name, get, lower, startswith
        # strings: 'environ', 'CX_HACK_REMOTE_DRIVES', 'yz', 'install_source', '', 'steam:', 'steam.exe', 'WINE_WAIT_CHILD_PIPE_IGNORE'
        ...

    def _main_setup_bottle_environment_pre(self):
        """Sets up the bottle so the specified Unix environment variables will
always be set.
"""
        # globals: bottlequery
        # attributes: scheduler, installtask, bottlename, get_config, get_save_config, lock_file, installer, pre_install_environment, value, name, save_and_unlock_file
        # strings: 'EnvironmentVariables'
        ...

    def _main_setup_registry_pre(self):
        """Tweak the windows registry for child processes.

Do it early enough so that it's ready for self-extracting installers.
"""
        # globals: bottlequery
        # attributes: installer, pre_install_registry, values, set_registry_key, scheduler, installtask, bottlename, key, name, data
        ...

    def reset_cwd(self):
        # globals: os
        # attributes: state, chdir
        # strings: 'previous_cwd'
        ...

    def _main_uncompress(self):
        """Check if the installer file is an archive.

If so uncompress it into a temporary directory and arrange for it to
be used as the install_source in the following steps. Thus installers
can be compressed and it's transparent to the later steps. Also arrange
for the temporary directory to be deleted at the end.
"""
        # globals: os, bottlequery, _, tempfile, zipfile, cxlog, open, cxutils, tarfile, sorted, tar_member_depth, range, len, stat, OSError
        # attributes: state, get, installer, installer_treatas, lower, endswith, selfextract_threshold, path, getsize, scheduler, expand_win_string, get_native_path, installtask, bottlename, name, error, mkdtemp, getcwd, chdir, ZipFile, namelist, startswith, split, warn, debug_str, zip_encoding, encode, join, decode, makedirs, rsplit, read, write, extract, CX_ROOT, run, GRAB, reset_cwd, log_, open, getmembers, normpath, lstat, st_mode, S_ISDIR, get_windows_path, get_win_environ, basename, selfextract_options, append, selfextract_silent_options, to_str
        # strings: 'install_source', 'installer_file', '.zip', 'zip', '.cab', 'cab', '.tgz', 'tar', '.tar.gz', '.tar.bz2', '.tar', '.tbz', '.tb2', '.rar', 'rar', '.7z', '7z', 'selfextract', '%temp%', 'Unable to get a temporary directory for %s', 'temporary_source', 'previous_cwd', 'r', '/', '..', 'Skipping file ', ' in ', ' (bad filename)', 'ascii', 'CP437', '\\', 'wb', 'bin', 'cabextract', '-q', '-d', 'environ', 'Extracting archive ', ' to ', ' (not a directory)' ...(+13)
        ...

    def _main_locate_installer(self):
        # globals: cxaiemedia, os, cxlog, _
        # attributes: needs_installer_file, installer, state, path, isdir, locate_installer, log_, debug_str, name, error
        # strings: 'no_installer', 'installer_file', 'install_source', 'aie', 'installer_file = ', "Unable to find an installer for %(name)s in '%(source)s'"
        ...

    def _main_scan_installer(self):
        # globals: bottlequery, os, cxutils, cxlog, _
        # attributes: state, lower, startswith, get_config, scheduler, installtask, bottlename, get, path, join, CX_ROOT, log_, run, GRAB, error, canceled, _cleanup
        # strings: 'installer_file', 'steam:', 'CrossOver', 'AntiVirusScan', 'start', 'never', 'bin', 'cxavscan', '--gui', 'aie', 'antivirus_command=%s', "'%(file)s' contains a virus", 'file', "'%(file)s' could not be scanned"
        ...

    def _main_setup_source_selinux(self):
        # globals: distversion, os, cxlog, cxutils
        # attributes: state, IS_MACOSX, download, lower, startswith, path, isfile, endswith, log_, isdir, access, W_OK, X_OK, join, CX_ROOT, run, GRAB, error
        # strings: 'no_installer', 'uncompressed', 'install_source', 'installer_file', 'steam:', '.exe', '.com', 'aie', '%s is not an executable, not setting the SELinux context', '%s is neither a file nor a directory, not setting the SELinux context', '%s is read-only, not setting the SELinux context', 'bin', 'cxselinux', '--auto-textrel'
        ...

    def _main_build_install_command(self):
        # globals: os, cxutils, bottlequery, print, _, cxlog
        # attributes: state, path, join, CX_ROOT, scheduler, installtask, bottlename, installer, installer_dlloverrides, extend, installer_treatas, lower, get_windows_paths, dirname, endswith, startswith, append, installer_options, expand_win_string, get, installer_silent_options, remove, name, error, log_, debug_str
        # strings: 'no_installer', 'installer_command', 'installer_file', 'bin', 'wine', '--bottle', '--wait-children', '--no-convert', '--new-console', '--dll', '/autorun.inf', '--wl-app', 'autorun.exe', '--', 'steam:', 'steamurlhelper.exe', '.exe', '.com', '.bat', '.cmd', 'silentinstall', '.msi', 'msiexec.exe', '/i', '/quiet', '.msp', '/p', '.msu', 'wusa.exe', '.otf', '.ttc', '.ttf', 'cxinstallfonts.exe', "'%(file)s' is of an unknown installer type for %(name)s", 'aie', 'installer_command=', ' '
        ...

    def _main_collate_menus_and_assocs(self):
        # attributes: scheduler, state, update, installer, mainmenu_never, default_eassocs, alt_eassocs
        # strings: 'mainmenu_never', 'defaulteassocs', 'alteassocs'
        ...

    def install_failure_detected(self):
        # globals: cxlog, appdetector
        # attributes: installer, parent, needs_office_2013_hack, app_profile, installed_key_pattern, installed_display_pattern, installed_registry_globs, installed_file_globs, _has_printed_install_log_err, log_, state, get, lower, startswith, is_profile_installed, scheduler, installtask, bottlename
        # strings: 'aie', 'We have no way to detect success or failure for this package. Assuming success, with optimism.', 'installer_file', '', 'steam:'
        ...

    def _main_run_installer_and_check(self):
        # globals: os, cxutils, _
        # attributes: state, get, lower, startswith, path, isdir, dirname, system, install_failure_detected, name, error
        # strings: 'no_installer', 'install_source', 'steam:', 'installer_command', 'environ', 'The installer has exited but %s does not seem to be installed'
        ...

    def _main_remove_fake_dlls(self):
        # globals: bottlequery, os, cxutils, shutil, cxlog
        # attributes: scheduler, installer, pre_rm_fake_dlls, get_native_path, installtask, bottlename, expand_win_string, path, exists, join, check_fake_dll, remove, move, log, debug_str
        # strings: '%WinSysDir%', '.bak', ' %s is not a fake dll '
        ...

    def _main_copy_files(self):
        # globals: globtree, cxlog, bottlequery, len, os, _, shutil, OSError, errno, str
        # attributes: state, scheduler, installer, files_to_copy, glob, get, FileGlobTree, add_glob, matches, append, log_, debug_str, destination, get_native_path, installtask, bottlename, expand_win_string, endswith, path, isdir, dirname, makedirs, name, error, join, basename, isfile, copy2, copytree, errno, EEXIST
        # strings: 'install_source', ':installer:', 'installer_file', 'aie', '* ', ' -> ', '/', "Cannot copy the %(profile)s file(s) into '%(dir)s' because it is not a directory.", 'copying ', " to '", "'", "Unable to create the destination directory '%(dir)s' for '%(profile)s':\n%(error)s", "An error occurred while copying '%(source)s' to '%(destination)s':\n%(error)s"
        ...

    def _main_reboot(self):
        # globals: os, cxutils
        # attributes: installer, post_install_reboot, scheduler, path, join, CX_ROOT, installtask, bottlename, run, state, GRAB, error
        # strings: 'bin', 'wine', '--bottle', '--wait-children', '--wl-app', 'wineboot.exe', '--restart', 'environ'
        ...

    def _main_create_lnk_files(self):
        # globals: os, cxutils
        # attributes: scheduler, installer, lnk_files, path, join, CX_ROOT, installtask, bottlename, expand_win_string, shortcut, target, workdir, extend, run, state, GRAB, error
        # strings: 'bin', 'wine', '--bottle', '--wait-children', '--wl-app', 'cxmklnk.exe', '--', '--lnkfile', '.lnk', '--target', '--workdir', 'environ'
        ...

    def _main_setup_bottle_selinux(self):
        # globals: distversion, bottlequery, os, cxutils
        # attributes: IS_MACOSX, scheduler, get_native_path, installtask, bottlename, path, join, CX_ROOT, run, state, GRAB, error
        # strings: 'c:', 'bin', 'wine', '--bottle', '--ux-app', 'cxselinux', '--auto-textrel', 'environ'
        ...

    def _main_register_dlls(self):
        # globals: os, cxutils, bottlequery
        # attributes: scheduler, installer, post_registerdll, expand_win_string, path, join, CX_ROOT, installtask, bottlename, get_native_path, dirname, isdir, run, state, GRAB, error
        # strings: 'bin', 'wine', '--bottle', '--wait-children', '--no-convert', '--wl-app', 'regsvr32.exe', '--', '/s', '/', '\\', 'environ'
        ...

    def _main_setup_registry_post(self):
        """Tweak the windows registry for the application.

Do it as late as possible so it won't be overridden by some part of
the installation.
"""
        # globals: bottlequery
        # attributes: installer, post_install_registry, values, set_registry_key, scheduler, installtask, bottlename, key, name, data
        ...

    def _cleanup_delete_uncompressed_files(self):
        # globals: shutil
        # attributes: reset_cwd, state, rmtree
        # strings: 'temporary_source'
        ...

    def _main_check_silent_steam_install(self):
        # globals: type
        # attributes: installer, parent, appid, parents, __name__, state
        # strings: 'com.codeweavers.c4.206', 'AIECore', 'silentinstall'
        ...

    def _main_check_silent_font_install(self):
        # globals: cxlog
        # attributes: log_, to_str, installer, parent, appid, state, get, scheduler
        # strings: 'aie', 'appid=', ' silentfontinstall=', 'silentfontinstall', ' global=', 'silentinstall', ' -> silentinstall = True'
        ...

    def _main_set_silent_font_install(self):
        # globals: cxlog
        # attributes: log_, to_str, installer, parent, appid, state, get, scheduler
        # strings: 'aie', 'appid=%s', 'silentfontinstall', ' -> global silentfontinstall = True'
        ...

    def _main_cxhack_mplayer2(self):
        # globals: os, bottlequery
        # attributes: installer, parent, appid, scheduler, path, join, expand_win_string, get_native_path, installtask, bottlename, exists, remove
        # strings: 'com.codeweavers.c4.96', '%WinDir%', 'wininit.ini'
        ...

    def _main_cxhack_cxhtml(self):
        # globals: os, cxutils
        # attributes: installer, parent, appid, scheduler, path, join, CX_ROOT, installtask, bottlename, run, state, GRAB, error
        # strings: 'bin', 'wine', '--bottle', '--wait-children', '--wl-app', 'iexplore.exe', '-regserver', 'environ'
        ...

    def _main_cxhack_dotnet(self):
        # globals: appdetector, cxutils
        # attributes: installer, parent, appid, scheduler, get_uninstall_applications, installtask, bottlename, displayname, run, uninstallcommand, state, GRAB
        # strings: 'environ'
        ...

    def needs_office_2013_hack(self):
        # globals: os
        # attributes: installer, parent, appid, state, path, isfile, isdir, join
        # strings: 'com.codeweavers.c4.10518', 'install_source', 'autorun.inf'
        ...

    def _main_cxhack_pre_office2013(self):
        # attributes: needs_office_2013_hack, state, index, remove
        # strings: 'installer_command', '--wait-children', '--no-wait'
        ...

    def _main_cxhack_msync(self):
        # globals: distversion, os, cxutils, bottlequery
        # attributes: installer, parent, appid, IS_MACOSX, scheduler, installtask, bottlename, path, join, CX_ROOT, run, state, GRAB, error, shutdown_manipulator, get_config, get_save_config, lock_file, save_and_unlock_file
        # strings: 'com.codeweavers.c4.21821', 'bin', 'wine', '--bottle', '--wl-app', 'wineboot', '--', '--end-session', '--shutdown', '--force', '--kill', 'environ', '--no-update', '--ux-app', 'wineserver', '-w', '1', 'EnvironmentVariables', 'WINEMSYNC'
        ...

    def _cleanup_cxhack_taskkill(self):
        # globals: os, cxutils, bottlequery
        # attributes: installer, parent, appid, scheduler, path, join, CX_ROOT, installtask, bottlename, run, state, GRAB, error, shutdown_manipulator
        # strings: 'com.codeweavers.c4.8882', 'bin', 'wine', '--bottle', '--wl-app', 'wineboot', '--', '--end-session', '--shutdown', '--force', '--kill', 'environ'
        ...

    def _cleanup_delete_downloaded_installer(self):
        # globals: os
        # attributes: state, get, remove
        # strings: 'temp_install_source'
        ...

    def _cleanup(self):
        # globals: getattr, cxlog, traceback
        # attributes: cleanup_lock, warn, format_exc
        # strings: '_cleanup_%s', 'Cleanup function failed:\n%s'
        ...

    def can_cancel(self):
        ...

    def cancel(self):
        # globals: cxaiebase
        # attributes: AIETask, cancel, canceled, _cleanup
        ...

    def main(self):
        # attributes: run_routines, _cleanup
        # strings: 'main'
        ...
