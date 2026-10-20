# cxaiengine — reconstructed outline of CrossOver 26.3 lib/python/cxaiengine.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""This is the Application Installation Engine, AIE for short.

Based on the InstallTask data, it is responsible for determining which tasks
will be needed to perform the installation, and what their dependencies are.

Note that the installation profiles form a general directed graph. So it is
necessary to have in mind this graph in order to understand the what the
engine does.

Here are the tasks it may create:
 * One task is created to install a each application. The dependencies between
   these tasks reflect the dependencies between the install profiles. Obviously
   cycles cannot be allowed so they must be detected and reported.

 * If the installer needs to be downloaded then a separate task is created to
   handle that.

 * If the source media needs to be specified for an application, then a set
   of tasks is created to handle its insertion and release.

 * If a downloadable installer may also be found on CD, then the relevant
   download task is 'linked' to the compatible media sources, where the notion
   of 'compatibility' stems from the necessity to avoid introducing loops in
   the task graph.

 * Finally, additional tasks are created to handle the bottle creation, the
   pre-installation tasks and the post-installation tasks.


Here's a more detailed description of how the engine transforms the install
profile graph into an installation tasks graph:

1. Get the aggregated installer profiles of all the applications to
   install from the parent InstallTask.

2. If the main application comes on CD but there are applications to
   install first that come on a CD too (potentially), then the first
   thing we will do is ask the user to eject this CD before we've had
   time to scan it to see if there might be something useful on it.
   We may still get an opportunity to scan it when it gets inserted
   later, but that may be too late for some applications and will
   in any case delay the start of the downloads. So create a dummy
   AIECore we can attach this 'initial media' to so we can handle it
   normally.

   If installtask says we're installing from a directory, then:
   - Create an AIECore object for a fake 'DummyApp' application.
   - Call its done() method so it is not actually run and does not
     prevent other tasks from running.
   - Associate a media triplet to the AIECore object.
   - Call the AIEInsertMedia object's done() method so it is not
     actually run (and thus does not ask the user to insert the
     already present CD), but does not prevent other tasks from
     running.

3. Create an initial set of tasks for each application to install.
   This includes the tasks directly connected to these applications
   like tasks to download them, to insert the media they come on,
   etc.

   We do that through a recursive depth-first traversal starting from
   the main application profile and following the dependency links,
   ignoring installed applications. This really needs a recursion
   because we need to gather data both as we go down and up the
   recursion path.
   As we recurse:
   - If an AIECore object exists for the current application already (look
     it up in the global aiecores map), then:
     - Make the parent depend on it.
     - If parent media is set, then add it to the parent-media set of all
       AIECore objects in the children-scan set (note that if this object
       has a media, then its children-scan set is empty).
     - Return the cached result tuple.

   - Otherwise, create an AIECore object and add it to the global aiecores map.
   - Associate the AIECore object with the corresponding installer profile.
   - Make the AIECore object depend on the PreInstall task.
   - Make the parent depend on the new AIECore object.

   - If the application installer is already available skip to the next
     group.
   - Else if the application can be downloaded, create an AIEDownload object
     and make the AIECore object depend on it. If the LocalInstallerFileGlobs
     field is set, add the AIECore object to the global scan list.
   - Else create an (AIEInsertMedia, AIEScanMedia, AIEReleaseMedia) triplet
     with meaningful dependencies between them and the AIECore object and
     set parent-media to the current object.

   Then recursively process the dependencies. For each of the dependencies
   we get back a tuple of (children-scan set, children-media set,
   descendents-media set) containing AIECore objects. With them:
   - Aggregate the children-scan sets into a single set.
   - Aggregate the children-media sets into a single set.
   - Aggregate the descendents-media sets into a single set.

   On the recursion return path:
   - If the current object has an AIEInsertMedia object, then:
     - If DummyApp exists, the current object is the not main profile
       and the children-media set is empty, then add the DummyApp AIECore
       object to the chidren-media and descendents-media sets.
     - Make this object's AIEInsertMedia depend on the AIEReleaseMedia
       objects of all the AIECores in the children-media set.
     - Reset the children-media set so it contains only the current object.
     - Make the children-scan set empty.
     - Add the current object to the descendents-media set.
   - If it does not have an AIEInsertMedia object but its descendents-media
     set is non-empty, then add it to the parent-media set of all the objects
     in its children-scan set.
   - If the LocalInstallerFileGlobs field is set for the current profile,
     then add the AIECore object to the children-scan set.
   - Store the (children-scan set, children-media set, descendents-media
     set) triplet in the result mapping based on the AIECore object.
     This is the result triplet.
   - Finally, return the result triplet to the caller.

4. The objects in the global scan list may be able to find their
   installer on a CD instead of having to download them. So link
   them to the compatible AIEScanMedia objects.

   For each object in the global scan list:
   - First compute the set of compatible media:
     - Initialize the compatible media set with those objects of the
       AIECore's parent-media set that have a media.
     - If the children-media set is non-empty for the download's
       AIECore object, add them to the compatible media set.
     - Otherwise add the descendents-media set of each of the
       objects in the AIECore object's parent-media set.
   - Then, make the corresponding AIEDownload object depend on the
     AIEScanMedia objects of the objects in the compatible media set.

5. If the AIEScanMedia object of the DummyApp we created in step 3
   has nothing to do then mark it and the AIEReleaseMedia tasks as
   done.

6. Again make sure we will have a chance to scan the CD of the main
   profile before starting the downloads.

   So if the main profile has a media triplet:
   - Detach the AIEScanMedia object from the corresponding
     AIEInsertMedia object.
   - Make the DummyApp's AIEReleaseMedia object depend on this
     AIEScanMedia object. This is so we don't try to insert another
     media before this scan is done.
   - If the main AIECore's AIEInsertMedia object has no dependencies
     (i.e. there is only one CD involved), then arrange for it to
     not trigger asking the user to insert the CD.

7. Compute the AIECore object niceness based on their depth in
   the dependency graph.

8. Make the PostInstall task depend on the main profile AIECore
   object.
"""
import os.path
import os
import cxlog
import cxutils
import appdetector
import bottlequery
import c4profiles
import cxaiecore
import cxaiemedia
import cxaiemisc
import cxaiebase
import cxobjc
import systeminfo
class Engine(cxaiebase.AIEScheduler):
    @cxobjc.python_method
    def start_logging(self, logfile, channels, extra_env):
        """Initializes the global environment block and sets up logging.

This function never fails. Logging is there to help diagnosis in case
things go wrong, not to cause things to go wrong.
"""
        # globals: os, cxutils, open, IOError, cxlog
        # attributes: environ, copy, state, mkdirs, path, dirname, write, installtask, get_summary_string, close, log_system_info, log, strerror
        # strings: 'environ', 'w', 'utf8', 'surrogateescape', '\n', 'CX_LOG', 'logfile', 'CX_ENV', 'CX_DEBUGMSG', '+wineboot,-cxassoc,-cxmenu', 'unable to open log file: '
        ...

    @cxobjc.python_method
    def log_system_info(self):
        # globals: open, systeminfo, IOError, cxlog
        # attributes: state, get, system_info_string, write, close, log, strerror
        # strings: 'logfile', 'a', 'utf8', 'unable to open log file: '
        ...

    @cxobjc.python_method
    def _getlogfile(self):
        """Returns the path to the installation log if any, and None
otherwise.
"""
        # attributes: state, get
        # strings: 'logfile'
        ...

    logfile = property(_getlogfile)
    @cxobjc.python_method
    def _add_profile(self, appid, parent, parent_media):
        # globals: cxlog, cxaiecore, set, cxaiemedia
        # attributes: log, to_str, _aiecores, _results, add_dependency, parent_media, add, _installers, parent, app_profile, AIECore, _bottle_init, installtask, installWithSteam, steamid, download_urls, get_builtin_installer, appid, create_download_task, download, needs_download, local_installer_file_globs, _scan, append, pre_dependencies, state, flags, create_media_tasks, _add_profile, insert_media, update, _dummy_app, release_media, post_dependencies, _postdeps
        # strings: 'Processing %s', 'com.codeweavers.c4.206', 'steam://install/%s', 'install_source', 'installer_file', 'virtual'
        ...

    @cxobjc.python_method
    def _set_depth(self, aiecore, depth):
        # globals: min, isinstance, cxaiecore
        # attributes: depth, _parents_left, parents, AIECore, dependencies, _set_depth, prepare
        ...

    def __init__(self, installtask, log_filename=None, log_channels=None, log_env=None):
        # globals: cxaiebase, appdetector, os, cxaiecore, cxaiemisc, set, len, cxlog, KeyError
        # attributes: AIEScheduler, __init__, installtask, state, profile, appid, profiles, GetCreateNewBottle, installed, fast_get_installed_applications, bottlename, target_bottle, installers, _installers, installerSource, path, isdir, AIECore, unknown_installer, copy, _dummy_app, create_media_tasks, done, insert_media, install_source, get_bottle_init_task, _bottle_init, _aiecores, _scan, _results, _postdeps, _add_profile, pop, installer, parent, parent_media, add, update, download, add_dependency, scan_media, parents, release_media, remove_dependency, dependencies, _parents_left, _set_depth, get_postinstall_task, values, start_logging, is_on, check, log_, get_sorted_tasks, to_str
        # strings: 'install_source', 'Engine.__init__()', 'aie', 'Sorted task list:', '  '
        ...

    def initWithInstallTask_logFile_channels_env_(self, installtask, log_filename, log_channels, log_env):
        # globals: cxobjc
        # attributes: Proxy, nsobject_init, __init__
        ...

    @cxobjc.python_method
    def get_win_environ(self):
        """Initializes the 'winenv' state variable and returns it."""
        # globals: bottlequery, c4profiles
        # attributes: state, get_win_environ, installtask, bottlename, ENVIRONMENT_VARIABLES
        # strings: 'winenv'
        ...

    @cxobjc.python_method
    def expand_win_string(self, string):
        """Expands the references to the authorized Windows environment
variables.
"""
        # globals: bottlequery
        # attributes: expand_win_string, get_win_environ
        ...
