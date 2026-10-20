# installtask — reconstructed outline of CrossOver 26.3 lib/python/installtask.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import os.path
import re
import cxfixes
import cxlog
import cxobjc
import cxproduct
import cxutils
import distversion
from cxutils import cxgettext as _
import bottlemanagement
import bottlequery
import c4profiles
import c4profilesmanager
import cxaiemedia
import cxdiag
import downloaddetector
class SourceMedia:
    """Keeps track of installation wizard data associated to a potential
installation media.
"""
    def __init__(self, path, label, device=''):
        """Source is the absolute path of the installation media. This normally
corresponds to the mount point of a CD or a directory, but it may also
point to a user-specified file.

The label is the string that should be used to describe that media.
"""
        # attributes: path, label, device, _profile_ids
        ...

    def _get_profile_ids(self):
        """Returns the list of profile ids that this media could correspond to
(in the form of a dictionary mapping the ids to the profile objects).
"""
        # globals: c4profilesmanager
        # attributes: _profile_ids, get_matching_profiles, path
        ...

    profile_ids = property(_get_profile_ids)

CAT_NONE = 0
CAT_RECOMMENDED = 1
CAT_COMPATIBLE = 2
CAT_INCOMPATIBLE = 3
REASON_MAIN = 0
REASON_DEPENDENCY = 1
REASON_STEAM = 2
REASON_OVERRIDE = 3
OVERRIDE_EXCLUDE = 0
OVERRIDE_INCLUDE = 1
class TargetBottle:
    def __init__(self, installtask, bottle):
        # globals: CAT_NONE
        # attributes: installtask, bottle, name, bottlename, _newtemplate, _profile, _locale, _category, _installers, _missing_media, _missing_profiles, _warnings, _use_steam, _dep_overrides, _sourcefile, _sourcetype, _reasons, compatible, is_template, installed_packages_ready
        ...

    def _gettemplate(self):
        # attributes: _newtemplate, bottle, template
        ...

    template = property(_gettemplate)
    def is64bit(self):
        # attributes: template, endswith
        # strings: '_64'
        ...

    def _get_sourcetype(self):
        # globals: os
        # attributes: installtask, installWithSteam, installerDownloadSource, installerSource, path, isdir
        # strings: 'steam', 'file', 'cd', 'unset'
        ...

    def check_cache(self):
        """Checks whether the cached data is still relevant and throws it away
if not (typically because either the profile or the locale changed).
"""
        # globals: CAT_NONE
        # attributes: _profile, installtask, profile, _locale, realInstallerLocale, _use_steam, installWithSteam, _dep_overrides, dependency_overrides, _sourcefile, installerSource, _sourcetype, _get_sourcetype, copy, _category, _installers, _missing_media, _missing_profiles, _warnings, _reasons
        ...

    def analyzed(self):
        """Returns True if the bottle has been analyzed already and False
otherwise.
"""
        # attributes: check_cache, _installers
        ...

    def _break_dependency_loops(self, appid, parents):
        """Detects, breaks and reports dependency loops."""
        # globals: set, cxlog
        # attributes: add, _installers, pre_dependencies, bottlename, warn, to_str, installtask, profiles, name, template, _break_dependency_loops, remove
        # strings: 'The dependency of ', ' on ', ' creates a loop in bottle template ', '.'
        ...

    def _add_reason(self, appids, reason, other_appid=None):
        # attributes: _reasons
        ...

    def _is_predependency(self, dep_appid, appid):
        """Returns True if dep_appid must install before appid, must be called
after postdependencies are mapped to predependencies."""
        # globals: set
        # attributes: pop, _installers, add, pre_dependencies, update
        ...

    def analyze(self):
        """Analyzes the bottle so that we know all there is to know for
installation and about its suitability for the selected profile and
locale. This means:
- creating aggregated installer profiles for the selected profile and
  all its dependencies,
- detecting and reporting any potential issue like dependency loops,
  template incompatibilities, etc.
"""
        # globals: cxlog, set, REASON_MAIN, REASON_OVERRIDE, OVERRIDE_EXCLUDE, c4profiles, REASON_DEPENDENCY, REASON_STEAM, cxaiemedia, sorted, _, cxutils, OVERRIDE_INCLUDE
        # attributes: analyzed, bottle, installed_packages_ready, log, to_str, bottlename, installed_packages, installtask, profiles, _installers, _missing_media, _missing_profiles, _warnings, _reasons, compatible, _dep_overrides, _profile, appid, _add_reason, pop, is_for_current_product, add, get, C4InstallerProfile, installer_profiles, use_if, use, get_use_if_properties, update, append, extend, pre_dependencies, post_dependencies, unknown_installer, copy, _use_steam, parent, template, app_profile, bottle_types, name, flags, get_builtin_installer, download_urls, steamid, join, warn, html_escape, items, _is_predependency, extra_fors, _break_dependency_loops, trusted
        # strings: 'analyze: %s is not ready', 'com.codeweavers.c4.206', 'use', 'install', 'virtual', ', ', 'The ', ' template is compatible with ', ' but is incompatible with dependencies: ', "You have selected the '%(bottlename)s' bottle, which is incompatible with %(applications)s.", 'You have chosen to install in a new %(template)s bottle but it is incompatible with %(applications)s.', "<span style='color: red;'>This installation will include profiles from untrusted sources</span>: %s."
        ...

    def _getinstallers(self):
        """Returns the aggregated installer profiles for the application and
all its dependencies.

Note: Installation information can be split up across multiple
C4InstallerProfile objects which makes it unusable as is. This is
unlike the installer profiles in this map where all the pieces have
been 'aggregated' together into a single installer profile object.
"""
        # attributes: analyze, _installers
        ...

    installers = property(_getinstallers)
    def _getmissing_dependencies(self):
        """Returns the dependency application ids for which have not been
installed in the target bottle.
"""
        # attributes: analyze, _installers, items, parent, app_profile, _profile, appid, installed_key_pattern, installed_display_pattern, installed_registry_globs, installed_file_globs, steamid, append
        ...

    missing_dependencies = property(_getmissing_dependencies)
    def _getmissing_media(self):
        """Returns the dependency application ids for which we cannot
automatically get an installer. The GUI will have to ask the user for
an installation source for these.
"""
        # attributes: analyze, _missing_media
        ...

    missing_media = property(_getmissing_media)
    def _getmissing_profiles(self):
        """Returns the dependencies for which there is no C4 profile
information at all for the current product.
"""
        # attributes: analyze, _missing_profiles
        ...

    missing_profiles = property(_getmissing_profiles)
    def _getwarnings(self):
        """Returns a list of localized strings describing the issues found
while analyzing this bottle.

This may be the presence of dependency loops for instance, missing
profiles, etc.
"""
        # attributes: analyze, _warnings
        ...

    warnings = property(_getwarnings)
    def _getreasons(self):
        """Returns a dictionary mapping appids in the install to the reason
they will be installed, as a tuple of (code, appid). code is REASON_MAIN
for the main selected profile, REASON_DEPENDENCY for dependencies, or
REASON_STEAM for the Steam profile if the install source is Steam.

If code is REASON_DEPENDENCY, appid is the profile with the dependency."""
        # attributes: analyze, _reasons
        ...

    reasons = property(_getreasons)
    def get_use_if_properties(self, appid):
        """Returns a mapping containing the use_if properties for the selected
profile, locale, source and bottle combination."""
        # globals: distversion, os, cxproduct, cxdiag, cxlog
        # attributes: check_cache, _profile, appid, _sourcetype, CX_VERSION, split, BUILTIN_PRODUCT_ID, rjust, PLATFORM, _locale, template, _sourcefile, path, basename, is_wow64_install, CHECK_64BIT, CHECK_32BIT, is64bit, get, bottlename, properties, items, err
        # strings: 'dependency', '..', '.', '0', 'file', 'sourcefile', 'the %s cxdiag property collides with a builtin one'
        ...

    def has_category(self):
        """Returns True if we have determined this bottle's category."""
        # globals: CAT_NONE
        # attributes: check_cache, _category
        ...

    def _cache_category(self, category):
        """A convenience method that caches the category and returns it."""
        # attributes: _category
        ...

    def get_category(self):
        """Returns the bottle's category which is a measure of its suitability
for the profile selected for installation.

CAT_INCOMPATIBLE means the bottle is incompatible with it.
CAT_RECOMMENDED means we recommend installing in this bottle, which
  happens if it contains an application the profile is an extra for,
  or that belongs in the same application bottle group as the profile.
CAT_COMPATIBLE means the bottle is compatible.
"""
        # globals: CAT_NONE, CAT_INCOMPATIBLE, CAT_COMPATIBLE, CAT_RECOMMENDED
        # attributes: check_cache, _category, _profile, template, app_profile, bottle_types, _cache_category, application_group, _use_steam, bottle, extra_fors, installtask, templates, get_category, analyze, compatible, installed_packages, items, profile
        # strings: 'use', 'Steam'
        ...

    getCategory = get_category
    def _get_installprofile(self):
        # attributes: installers, _profile, appid
        ...

    installprofile = property(_get_installprofile)

class TargetTemplate(TargetBottle):
    def __init__(self, installtask, template):
        # globals: TargetBottle
        # attributes: __init__, _newtemplate, is_template
        ...


class InstallTaskDelegate:
    """This class defines the delegate interface that InstallTask uses to
notify the GUI of changes in the installtask state.

The GUI (especially the Mac one) does not have to provide an object that
derives from this class, but it must implement all of the methods defined
here.
"""
    @cxobjc.delegate
    def profileChanged(self):
        """Notifies the GUI that the profile selected for installation has
changed.
"""
        ...

    @cxobjc.delegate
    def sourceChanged(self):
        """Notifies the GUI that the media selected for the installation has
changed.
"""
        ...

    @cxobjc.delegate
    def categorizedBottle_(self, target_bottle):
        """Notifies the GUI that the specified bottle's category is now
available, where target_bottle is either a TargetBottle or a
TargetTemplate object.

This may be used to implement a GUI that shows the bottles right away
and then updates a field as their categories become known.
"""
        ...

    @cxobjc.delegate
    def categorizedAllBottles(self):
        """Notifies the GUI that all the bottles have been assigned a
category.

It also means that the bottle picking, if any, is done.
This can be used to implement a GUI which only shows list of bottles
one can install into once all their categories are known.
"""
        ...

    @cxobjc.delegate
    def analyzedBottle_(self, target_bottle):
        """Notifies the GUI that the specified bottle has been fully analyzed.

This means we have determined everything there is to know in order to
perform the installation into this bottle. So once one has received
this notification one can query the list of dependencies that will
need to be installed, and the list issues (such as dependency loops,
etc).
Note that the order of the analyzedBottle_() and categorizedBottle_()
notifications is undefined. However, once a bottle has been analyzed
its category can be computed and it is ready for installation (if
compatible).
"""
        ...

    @cxobjc.delegate
    def bottleCreateChanged(self):
        """Notifies the GUI that the flag specifying whether to install in a
new bottle or in an existing one has changed.
"""
        ...

    @cxobjc.delegate
    def bottleNewnameChanged(self):
        """Notifies the GUI that the new bottle name has been modified.
FIXME: Specify if one can receive such notifications when not
installing in a new bottle.
"""
        ...

    @cxobjc.delegate
    def bottleTemplateChanged(self):
        """Notifies the GUI that the new bottle template has been modified.
FIXME: Specify if one can receive such notifications when not
installing in a new bottle.
"""
        ...

    @cxobjc.delegate
    def bottleNameChanged(self):
        """Notifies the GUI that the name of the bottle to install into has
been modified.
FIXME: Specify if one can receive such notifications when
installing in a new bottle.
"""
        ...

    @cxobjc.delegate
    def profileMediaAdded_(self, filename):
        """Notifies the GUI that a non-mountpoint source was found for the
selected profile and added to profile_medias.
"""
        ...

    @cxobjc.delegate
    def profileMediaRemoved_(self, filename):
        """Notifies the GUI that a non-mountpoint source in profile_medias was
removed because it no longer applies to the selected profile.
"""
        ...


_NULL_DELEGATE = InstallTaskDelegate()
def _do_nothing(*_args, **_kwargs):
    ...

class InstallTask(cxobjc.Proxy):
    """The InstallTask class will keep track of the state of a user-selected
c4 profile as we go through the process of installing it. It will also
provide an interface to installation information that must be returned at
run-time, e.g. bottle compatibility.
"""
    def __init__(self, delegate=None):
        # globals: cxobjc, _NULL_DELEGATE, cxutils, c4profiles, set, bottlemanagement, TargetTemplate
        # attributes: Proxy, __init__, _profiles, _delegate, set_delegate, _queued_delegate_calls, _profile, _profile_requested, installerLocale, get_preferred_languages, LANGUAGES, _userInstallerLocale, realInstallerLocale, installer, source_medias, profile_medias, _installer_source_requested, installerDownloadSource, installerSource, installWithSteam, apply_cxfixes, dependency_overrides, bottles, templates, template_list, targetBottle, _target_bottle_requested, newBottleName, _new_bottle_name_requested
        # strings: ''
        ...

    @cxobjc.python_method
    def _getprofiles(self):
        # globals: c4profilesmanager
        # attributes: _profiles, C4ProfilesSet, all_profiles
        ...

    @cxobjc.python_method
    def _setprofiles(self, value):
        # attributes: _profiles, _profile, appid, profiles, _setprofile, _profile_requested, profile
        ...

    profiles = property(_getprofiles, _setprofiles)
    def initWithDelegate_(self, delegate):
        # globals: cxobjc
        # attributes: Proxy, nsobject_init, __init__
        ...

    def init(self):
        # attributes: initWithDelegate_
        ...

    @cxobjc.namedSelector(b'setDelegate:')
    def set_delegate(self, delegate):
        # globals: _NULL_DELEGATE
        # attributes: _delegate
        ...

    @cxobjc.python_method
    def _queue_delegate_call(self, methodname, arg1=None):
        # attributes: _queued_delegate_calls, append
        ...

    @cxobjc.python_method
    def _flush_delegate_calls(self):
        # globals: InstallTaskDelegate, getattr, _do_nothing
        # attributes: _queued_delegate_calls, __dict__, __code__, co_argcount, _delegate
        ...

    @cxobjc.python_method
    def select_profile_from_source(self):
        # globals: len, next, iter
        # attributes: installerSource, _installer_source_requested, _profile_requested, source_medias, profile_ids, _setprofile, values
        ...

    @cxobjc.namedSelector(b'autoFillSettings')
    def auto_fill_settings(self):
        # globals: len, next, iter
        # attributes: _profile_requested, _installer_source_requested, source_medias, values, profile_ids, _setprofile, select_profile_from_source
        ...

    @cxobjc.namedSelector(b'volumeMatchesProfile:')
    def volume_matches_profile(self, volume):
        # attributes: profile, source_medias, appid, profile_ids
        ...

    @cxobjc.python_method
    def _get_condition_languages(self, condition, result=None):
        # globals: set, isinstance, c4profiles
        # attributes: C4ConditionUnary, _get_condition_languages, child, C4ConditionNary, children, C4ConditionCompare, C4ConditionMatch, name, add, value
        # strings: 'locale'
        ...

    @staticmethod
    @cxobjc.python_method
    def _scan_url_locales(urls, default_locales, nondefault_locales):
        # attributes: items, add
        # strings: ''
        ...

    @cxobjc.python_method
    def profile_languages(self, profile=None):
        """Returns the set of languages that should be presented to the user for a profile"""
        # globals: set
        # attributes: _profile, installer_profiles, update, _get_condition_languages, use_if, app_profile, download_urls, _scan_url_locales, download_urls_64bit, download_page_urls, add
        # strings: ''
        ...

    def profileLanguages(self):
        # globals: list
        # attributes: profile_languages
        ...

    @cxobjc.python_method
    def _getprofile(self):
        # attributes: _profile
        ...

    @cxobjc.python_method
    def _setprofile(self, profile, requested=True):
        # globals: cxutils, len, next, iter, set, downloaddetector, c4profilesmanager, cxaiemedia, list
        # attributes: _profile, appid, dependency_overrides, _profile_requested, profile_languages, get_preferred_languages, installerLocale, realInstallerLocale, _userInstallerLocale, installerDownloadSource, installWithSteam, _clear_installer_source, profile_medias, find_installers, download_search_paths, C4ProfilesSet, from_profile, _queue_delegate_call, _installer_source_requested, get_builtin_installer, source_medias, values, profile_ids, path, _get_download_url, set_installer_source, steamid, set_installer_download, set_installer_steam, _trigger_bottle_analysis, _flush_delegate_calls
        # strings: '', 'profileMediaRemoved_', 'profileMediaAdded_', 'profileChanged'
        ...

    profile = property(_getprofile, _setprofile)
    def setProfile_(self, profile):
        # attributes: profile
        ...

    @cxobjc.namedSelector(b'updateProfiles')
    def update_profiles(self):
        # attributes: _profiles, _profile, appid, profiles, _setprofile, _profile_requested, profile
        ...

    @cxobjc.namedSelector(b'useAutorunFile:')
    def use_autorun_file(self, c4pfile):
        # attributes: _profile_requested, get_autorun_id, profiles, _setprofile
        ...

    @cxobjc.python_method
    def _is_virtual(self):
        # attributes: _profile, app_profile, flags
        # strings: 'virtual'
        ...

    virtual = property(_is_virtual)
    @cxobjc.python_method
    def _get_display_name(self):
        # attributes: _profile, name
        ...

    displayName = property(_get_display_name)
    @cxobjc.namedSelector(b'setLocale:')
    def SetLocale(self, locale):
        # attributes: installerLocale, realInstallerLocale, installerDownloadSource, installerSource, set_installer_download, _profile, _trigger_bottle_analysis, _flush_delegate_calls
        ...

    @cxobjc.namedSelector(b'addDependencyOverrides:ofType:')
    def AddDependencyOverrides(self, appids, override_type=OVERRIDE_INCLUDE):
        # attributes: dependency_overrides, _trigger_bottle_analysis, _flush_delegate_calls
        ...

    @cxobjc.namedSelector(b'removeDependencyOverrides:')
    def RemoveDependencyOverrides(self, appids):
        # attributes: dependency_overrides, _trigger_bottle_analysis, _flush_delegate_calls
        ...

    def ClearDependencyOverrides(self):
        # attributes: dependency_overrides, _trigger_bottle_analysis, _flush_delegate_calls
        ...

    _component_categories = set(['Component', 'Component/Font', 'Component/Fonts', 'Non Applications/CrossTie Snippets', 'Non-Applications/CrossTie Snippets', 'Non-Applications/Components', 'Non-Applications/Components/Fonts'])
    def SuggestedDependencyOverrides(self):
        # attributes: profile, appid, target_bottle, bottle, installed_packages_ready, installed_packages, profiles, items, _profile, app_profile, download_urls, flags, extra_fors, raw_category, _component_categories, append
        # strings: 'virtual'
        ...

    @cxobjc.namedSelector(b'addSourceMedia:withLabel:andDevice:')
    def add_source_media(self, mountpoint, label='', device=''):
        # globals: SourceMedia
        # attributes: source_medias
        ...

    @cxobjc.namedSelector(b'removeSourceMedia:')
    def remove_source_media(self, mountpoint):
        # attributes: source_medias, installerSource, _clear_installer_source
        ...

    @staticmethod
    @cxobjc.python_method
    def download_search_paths():
        # globals: distversion, os, cxutils
        # attributes: IS_MACOSX, environ, get, get_download_dir, get_desktop_dir
        # strings: 'HOME', '/'
        ...

    @cxobjc.python_method
    def set_installer_source(self, inSource, requested=True, flush_delegate=True):
        # attributes: installerSource, add_source_media, installerDownloadSource, installWithSteam, _installer_source_requested, select_profile_from_source, _queue_delegate_call, _trigger_bottle_analysis, _flush_delegate_calls
        # strings: 'sourceChanged'
        ...

    def setInstallerSource_Requested_(self, inSource, inRequested):
        # attributes: set_installer_source
        ...

    @cxobjc.python_method
    def set_installer_download(self, requested=True, flush_delegate=True):
        # attributes: _get_download_url, installerDownloadSource, _clear_installer_source, installerSource, installWithSteam, _installer_source_requested, _queue_delegate_call, _trigger_bottle_analysis, _flush_delegate_calls
        # strings: 'sourceChanged'
        ...

    def setInstallerDownload(self):
        # attributes: set_installer_download
        ...

    @cxobjc.python_method
    def set_installer_steam(self, requested=True, flush_delegate=True):
        # attributes: _profile, app_profile, steamid, installerSource, _installer_source_requested, installWithSteam, installerDownloadSource, _queue_delegate_call, _trigger_bottle_analysis, _flush_delegate_calls
        # strings: 'steam://install/%s', 'sourceChanged'
        ...

    def setInstallerSteam(self):
        # attributes: set_installer_steam
        ...

    @cxobjc.python_method
    def _get_download_url(self):
        # attributes: _profile, app_profile, download_urls, download_urls_64bit, is64bit, installerLocale
        # strings: ''
        ...

    download_url = property(_get_download_url)
    @cxobjc.python_method
    def _get_steamid(self):
        # attributes: _profile, app_profile, steamid
        ...

    steamid = property(_get_steamid)
    @cxobjc.python_method
    def _clear_installer_source(self, flush_delegate=False):
        # attributes: installerSource, installerDownloadSource, _installer_source_requested, installWithSteam, _queue_delegate_call, _trigger_bottle_analysis, _flush_delegate_calls
        # strings: 'sourceChanged'
        ...

    def _has_installer_source(self):
        # attributes: installerSource, installerDownloadSource, virtual, installWithSteam
        ...

    has_installer_source = property(_has_installer_source)
    def _take_bottle_snapshot(self):
        # attributes: targetBottle, newBottleName, _bottle_snapshot
        ...

    def _send_bottle_change_notifications(self):
        """An internal helper for sending the relevant notification(s) when
the selected bottle gets changed.
"""
        # globals: cxlog
        # attributes: _bottle_snapshot, err, targetBottle, _queue_delegate_call, newBottleName
        # strings: 'No bottle snapshot was taken!', 'targetBottle', 'bottleCreateChanged', 'bottleTemplateChanged', 'bottleNameChanged', 'newBottleName', 'bottleNewnameChanged'
        ...

    def _unpick_bottle(self):
        """This gets called when the target profile is unset and resets the
relevant fields.
"""
        # attributes: _take_bottle_snapshot, _target_bottle_requested, targetBottle, _new_bottle_name_requested, newBottleName, _send_bottle_change_notifications
        ...

    def _pick_new_bottle_name(self):
        """Picks a suitable name for the new bottle if we are free to do so.

The caller is responsible for sending the bottle change notification(s).
"""
        # globals: os, bottlequery, cxutils
        # attributes: _new_bottle_name_requested, _profile, name, is_unknown, installerSource, source_medias, label, path, basename, rstrip, split, unique_bottle_name, sanitize_bottlename, newBottleName
        # strings: '/', '.'
        ...

    def _get_new_bottle_template(self):
        """Returns a suitable template for the new bottle."""
        # globals: CAT_COMPATIBLE
        # attributes: _profile, app_profile, bottle_types, templates, get_category, profiles, unknown_profile, preferred_bottle_type
        # strings: 'use'
        ...

    new_bottle_template = property(_get_new_bottle_template)
    def _pick_new_bottle(self):
        """Picks a suitable template for the new bottle if we are free to do so.

The caller is responsible for sending the bottle change notification(s).
"""
        # attributes: _target_bottle_requested, templates, new_bottle_template, targetBottle
        ...

    def _pick_bottle(self):
        """This method performs the automatic bottle selection when
appropriate.

It is a helper for _categorize_bottles() and must only be called when
all bottles have been assigned a category.
"""
        # globals: CAT_RECOMMENDED
        # attributes: _take_bottle_snapshot, _target_bottle_requested, targetBottle, bottles, values, get_category, _profile, app_profile, flags, _pick_new_bottle, _pick_new_bottle_name, _send_bottle_change_notifications
        # strings: 'component', 'application'
        ...

    @cxobjc.python_method
    def _trigger_bottle_analysis(self):
        """Triggers a bottle analysis to:
- determine which ones are compatible or incompatible with the
  selected profile and installation source,
- determine which ones to recommend installation into (if any),
- pick a bottle if possible,
- and acquire all the data we need to start the installation.
"""
        # attributes: _profile, _categorize_bottles, _unpick_bottle, templates, values, _queue_delegate_call, bottles
        # strings: 'categorizedBottle_', 'categorizedAllBottles'
        ...

    @cxobjc.python_method
    def _categorize_list(self, target_iter):
        """This is a helper for _categorize_bottles()."""
        # globals: CAT_NONE
        # attributes: analyzed, analyze, _queue_delegate_call, has_category, get_category
        # strings: 'analyzedBottle_', 'categorizedBottle_'
        ...

    @cxobjc.python_method
    def _categorize_bottles(self):
        """This goes through all the bottles and templates trying to determine
their category. If it was successful it then calls _pick_bottle() and
notifies the GUI.
"""
        # attributes: _categorize_list, templates, values, bottles, _pick_bottle, _queue_delegate_call
        # strings: 'categorizedAllBottles'
        ...

    @cxobjc.namedSelector(b'addBottle:')
    def add_bottle(self, bottle):
        """Notifies InstallTask that a new bottle was detected.

The caller MUST then schedule the detection of that bottle's installed
applications and, when that's done, it MUST notify InstallTask through
installed_applications_ready(). The one exception is if the bottle
disappears before then and in that case it MUST notify InstallTask
through remove_bottle().

This MUST be called in the main thread.
"""
        # globals: TargetBottle
        # attributes: bottles, name
        ...

    @cxobjc.namedSelector(b'installedApplicationsReady:')
    def installed_applications_ready(self, bottle):
        """Notifies InstallTask that the specified bottle's installed
applications list is now available.

This MUST be called in the main thread.
"""
        # attributes: bottles, get, name, installed_packages_ready, trigger_bottle_analysis
        ...

    @cxobjc.namedSelector(b'triggerBottleAnalysis')
    def trigger_bottle_analysis(self):
        """Notifies InstallTask that the bottles may
have changed while notifying installed_applications_ready
was disabled.

This MUST be called in the main thread.
"""
        # attributes: _trigger_bottle_analysis, _flush_delegate_calls
        ...

    @cxobjc.python_method
    def remove_bottle_by_name(self, bottlename):
        """Notifies InstallTask that the specified bottle has been removed.

This may be called _instead of_ installed_applications_ready() if the
removal happened before the installed application detection could
complete. In this case installed_applications_ready() must not be
called for that bottle.

It is also a bug to call remove_bottle_by_name() twice or to call it on
unregistered bottles.

This MUST be called in the main thread.
"""
        # attributes: bottles, targetBottle, bottlename, _take_bottle_snapshot, _send_bottle_change_notifications, trigger_bottle_analysis
        ...

    @cxobjc.namedSelector(b'removeBottle:')
    def remove_bottle(self, bottle):
        """Use remove_bottle_by_name instead."""
        # attributes: remove_bottle_by_name, name
        ...

    @cxobjc.namedSelector(b'isNewBottleNameValid:')
    def is_new_bottle_name_valid(self, new_bottle_name):
        """Returns True if the new bottle name is valid and False otherwise.

In particular this checks for that it does not match an existing
bottle name, file or directory.
This MUST be called in the main thread.
"""
        # globals: bottlequery
        # attributes: is_valid_new_bottle_name
        ...

    @cxobjc.python_method
    def _set_target_bottle(self, target_bottle):
        # globals: isinstance, TargetTemplate, ValueError
        # attributes: templates, template, bottles, bottlename, targetBottle, is64bit, _target_bottle_requested, installerDownloadSource, set_installer_download, _queue_delegate_call, _flush_delegate_calls
        # strings: 'bottleCreateChanged', 'bottleTemplateChanged', 'bottleNameChanged'
        ...

    @cxobjc.python_method
    def _get_target_bottle(self):
        """Returns the TargetBottle object for the bottle selected for
installation. This object can then be used to get all the details about
that bottle: its category, the dependencies to install, and potential
issues.

Note also that this works equally well for existing bottles and new
bottles.
"""
        # attributes: targetBottle
        ...

    target_bottle = property(_get_target_bottle, _set_target_bottle)
    def _get_new_bottle_name(self):
        # attributes: newBottleName
        ...

    @cxobjc.namedSelector(b'setNewBottleName:')
    def _set_new_bottle_name(self, new_bottle_name):
        # attributes: newBottleName, _new_bottle_name_requested, _queue_delegate_call, _flush_delegate_calls
        # strings: 'bottleNewnameChanged'
        ...

    new_bottle_name = property(_get_new_bottle_name, _set_new_bottle_name)
    @cxobjc.python_method
    def set_create_new_bottle(self, newbottlename, template):
        # attributes: new_bottle_name, target_template, templates, target_bottle
        ...

    def createNewBottle_template_(self, newbottlename, template):
        # attributes: set_create_new_bottle
        ...

    def GetCreateNewBottle(self):
        # globals: isinstance, TargetTemplate
        # attributes: targetBottle
        ...

    create_new_bottle = property(GetCreateNewBottle)
    @cxobjc.python_method
    def _get_existing_bottle_name(self):
        # attributes: targetBottle, bottlename
        ...

    @cxobjc.python_method
    def _get_bottle_name(self):
        # globals: isinstance, TargetTemplate
        # attributes: targetBottle, newBottleName, bottlename
        ...

    @cxobjc.python_method
    def _set_bottle_name(self, name):
        # attributes: bottles, target_bottle
        ...

    bottlename = property(_get_bottle_name, _set_bottle_name)
    def _gettarget_template(self):
        # attributes: targetBottle, template
        ...

    target_template = property(_gettarget_template)
    def is64bit(self):
        # attributes: target_template, endswith
        # strings: '_64'
        ...

    def get_installer_profile(self):
        """Computes the appropriate installer profile for the selected
profile, locale and bottle type combination."""
        # attributes: targetBottle, _profile, app_profile, preferred_bottle_type, templates, profiles, unknown_profile, analyzed, template, installprofile, copy
        ...

    @cxobjc.python_method
    def get_profile_names(self, appids):
        """Converts a list of profile ids into a list of human-readable
profile names."""
        # attributes: target_bottle, installers, append, parent, name
        ...

    def _get_installation_notes(self):
        # attributes: get_installer_profile, installation_notes
        ...

    installationNotes = property(_get_installation_notes)
    def _get_post_install_url(self):
        # attributes: get_installer_profile, post_install_url
        ...

    post_install_url = property(_get_post_install_url)
    _RE_SINGLE = re.compile('^[a-zA-Z0-9:_-]*$', re.IGNORECASE)
    @cxobjc.python_method
    def _find_warning_in_mapping(self, warning, mapping):
        # globals: re
        # attributes: _RE_SINGLE, match, compile, IGNORECASE
        ...

    @cxobjc.python_method
    def _filter_cxdiag_messages(self, messages, profile):
        # globals: list, cxlog
        # attributes: items, cxdiag_checks, lower, startswith, split, _find_warning_in_mapping, _replace, warn, to_str
        # strings: 'required', 'recommended', 'apprequire:', 'apprecommend:', ':', 'suggested', 'ignore:', 'closed', 'unrecognized cxdiagcheck string: %s'
        ...

    @staticmethod
    @cxobjc.python_method
    def _cxdiag_level_cmp(a, b):
        # globals: cxutils, ValueError
        # attributes: cmp, index
        ...

    @cxobjc.python_method
    def _application_name(self):
        # attributes: _profile, is_unknown, displayName
        ...

    application_name = property(_application_name)
    @cxobjc.python_method
    def get_cxdiag_messages(self):
        """Returns a dictionary of cxdiag messages that apply to the current
profile."""
        # globals: cxproduct, cxdiag, cxfixes, set
        # attributes: is_wow64_install, CHECK_64BIT, CHECK_32BIT, is64bit, get, _get_existing_bottle_name, clear_errors, warnings, items, add_error, add_masked_errors, get_errors, _profile, target_bottle, analyzed, installers, values, _filter_cxdiag_messages, _cxdiag_level_cmp, copy
        ...

    @cxobjc.python_method
    def get_apply_cxfixes(self):
        """True if this task should apply necessary cxfixes, False otherwise."""
        # attributes: apply_cxfixes
        ...

    @cxobjc.python_method
    def get_summary_string(self):
        # globals: OVERRIDE_EXCLUDE, OVERRIDE_INCLUDE
        # attributes: profile, append, name, installerLocale, bottlename, installWithSteam, installerSource, installerDownloadSource, dependency_overrides, items, profiles, join
        # strings: 'Installing: %s\n', 'Locale: %s\n', 'Bottle: %s\n', 'From Steam: %s\n', 'From file: %s\n', 'From download url: %s\n', 'Manually removed from install: %s\n', 'Manually added to install: %s\n', ''
        ...

    @cxobjc.namedSelector(b'getDependencyDetails')
    def get_dependency_details(self):
        # globals: distversion, cxfixes, len, _, OVERRIDE_INCLUDE, OVERRIDE_EXCLUDE, cxutils
        # attributes: IS_MACOSX, get_cxdiag_messages, get_packages, apply_cxfixes, target_bottle, analyzed, installers, virtual, append, dependency_overrides, items, reasons, profiles, name, html_escape, join
        # strings: 'notes', 'CrossOver will install dependencies only', 'CrossOver will make configuration changes only', 'CrossOver will also install additional dependencies', 'CrossOver will also install the following manually added items: %s', ', ', 'warnings', 'The following dependencies were manually excluded from the install: %s'
        ...

    @cxobjc.namedSelector(b'getInstallerDetails')
    def get_installer_details(self):
        # globals: _, cxutils
        # attributes: virtual, installWithSteam, application_name, append, installerSource, html_escape, installerDownloadSource, profile, app_profile, download_page_url
        # strings: 'notes', "CrossOver will install '%(application)s' via Steam", 'application', 'CrossOver will install this software via Steam', "CrossOver will install '%(application)s' from %(location)s", 'CrossOver will install this software from %(location)s', 'location', 'CrossOver will download the installer from %s', "You need to provide the installer file or disk in order to install '%(application)s' using CrossOver", 'You need to provide the installer file or disk in order to install this software using CrossOver', "You need to provide the installer file or disk in order to install this software using CrossOver. If you don't have ..., '<a href="', '">', '</a>', 'warnings'
        ...

    @cxobjc.namedSelector(b'getBottleDetails')
    def get_bottle_details(self):
        # globals: _, cxutils, bottlequery, cxproduct, bottlemanagement
        # attributes: bottlename, application_name, append, target_bottle, analyzed, create_new_bottle, new_bottle_name, sanitize_bottlename, html_escape, unique_bottle_name, profile, app_profile, preferred_bottle_type, get_config_boolean, compatible, get_template_name, template, newBottleName, has_installer_source
        # strings: 'warnings', "You need to select the bottle to install '%(application)s' into", 'application', 'You need to select the bottle to install this software into', 'errors', "Invalid bottle name '%s'", "There is already a bottle named '%s'", 'Microsoft Office', 'OfficeSetup', 'Enable32BitBottles', "'%s' needs to be installed in a 32-bit bottle. Please enable them through the preferences dialog.", 'notes', "CrossOver will install '%(application)s' into the '%(bottlename)s' bottle", "CrossOver will install '%(application)s' into the '%(bottlename)s' bottle. This bottle may be incompatible", "CrossOver will install this software into the '%(bottlename)s' bottle", 'bottlename', "CrossOver will install this software into the '%(bottlename)s' bottle. This bottle may be incompatible", "CrossOver will install '%(application)s' into a new %(template)s bottle named '%(name)s'", "CrossOver will install '%(application)s' into a new %(template)s bottle named '%(name)s'. This bottle may be incompa..., "CrossOver will install this software into a new %(template)s bottle named '%(name)s'", "CrossOver will install this software into a new %(template)s bottle named '%(name)s'. This bottle may be incompatible", "The install cannot continue until the '%s' bottle is scanned for dependencies. Please wait."
        ...

    @cxobjc.namedSelector(b'getLanguageDetails')
    def get_language_details(self):
        # globals: _, cxutils, c4profiles
        # attributes: installerLocale, application_name, append, html_escape, LANGUAGES, get
        # strings: 'notes', "CrossOver will install the %(language)s version of '%(application)s'"
        ...

    @cxobjc.namedSelector(b'getMiscDetails')
    def get_misc_details(self):
        # globals: _, cxutils, os, cxaiemedia, distversion
        # attributes: target_bottle, analyzed, missing_profiles, join, append, html_escape, missing_media, get_profile_names, installerSource, installWithSteam, path, isdir, profile, get_installer_profile, locate_installer, IS_MACOSX, check_mmap_permissions, PERMISSIONS_NOREAD, PERMISSIONS_NOEXEC
        # strings: ', ', 'errors', 'The install cannot continue because one or more profiles it depends on could not be found: %s', 'The install cannot continue because no installer could be found for the following dependencies: %s', "The installer file '%s' cannot be read.", 'warnings', "The installer file '%s' is on a noexec filesystem. This may cause the install to fail."
        ...


@cxobjc.method(InstallTask, 'getMissingDependencies_')
def get_missing_dependencies(bottle):
    # globals: InstallTask
    # attributes: can_run_commands, installed_packages_ready, profile, app_profile, copy, steamid, add_bottle, name, bottlename, target_bottle, missing_dependencies
    ...
