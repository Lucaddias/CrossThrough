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
    profileChanged = <function InstallTaskDelegate.profileChanged>()
    sourceChanged = <function InstallTaskDelegate.sourceChanged>()
    categorizedBottle_ = <function InstallTaskDelegate.categorizedBottle_>()
    categorizedAllBottles = <function InstallTaskDelegate.categorizedAllBottles>()
    analyzedBottle_ = <function InstallTaskDelegate.analyzedBottle_>()
    bottleCreateChanged = <function InstallTaskDelegate.bottleCreateChanged>()
    bottleNewnameChanged = <function InstallTaskDelegate.bottleNewnameChanged>()
    bottleTemplateChanged = <function InstallTaskDelegate.bottleTemplateChanged>()
    bottleNameChanged = <function InstallTaskDelegate.bottleNameChanged>()
    profileMediaAdded_ = <function InstallTaskDelegate.profileMediaAdded_>()
    profileMediaRemoved_ = <function InstallTaskDelegate.profileMediaRemoved_>()

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

    _getprofiles = <function InstallTask._getprofiles>()
    _setprofiles = <function InstallTask._setprofiles>()
    profiles = property(_getprofiles, _setprofiles)
    def initWithDelegate_(self, delegate):
        # globals: cxobjc
        # attributes: Proxy, nsobject_init, __init__
        ...

    def init(self):
        # attributes: initWithDelegate_
        ...

    set_delegate = <function InstallTask.set_delegate>()
    _queue_delegate_call = <function InstallTask._queue_delegate_call>()
    _flush_delegate_calls = <function InstallTask._flush_delegate_calls>()
    select_profile_from_source = <function InstallTask.select_profile_from_source>()
    auto_fill_settings = <function InstallTask.auto_fill_settings>()
    volume_matches_profile = <function InstallTask.volume_matches_profile>()
    _get_condition_languages = <function InstallTask._get_condition_languages>()
    _scan_url_locales = <function InstallTask._scan_url_locales>()()
    profile_languages = <function InstallTask.profile_languages>()
    def profileLanguages(self):
        # globals: list
        # attributes: profile_languages
        ...

    _getprofile = <function InstallTask._getprofile>()
    _setprofile = <function InstallTask._setprofile>()
    profile = property(_getprofile, _setprofile)
    def setProfile_(self, profile):
        # attributes: profile
        ...

    update_profiles = <function InstallTask.update_profiles>()
    use_autorun_file = <function InstallTask.use_autorun_file>()
    _is_virtual = <function InstallTask._is_virtual>()
    virtual = property(_is_virtual)
    _get_display_name = <function InstallTask._get_display_name>()
    displayName = property(_get_display_name)
    SetLocale = <function InstallTask.SetLocale>()
    AddDependencyOverrides = <function InstallTask.AddDependencyOverrides>()
    RemoveDependencyOverrides = <function InstallTask.RemoveDependencyOverrides>()
    def ClearDependencyOverrides(self):
        # attributes: dependency_overrides, _trigger_bottle_analysis, _flush_delegate_calls
        ...

    _component_categories = set(['Component', 'Component/Font', 'Component/Fonts', 'Non Applications/CrossTie Snippets', 'Non-Applications/CrossTie Snippets', 'Non-Applications/Components', 'Non-Applications/Components/Fonts'])
    def SuggestedDependencyOverrides(self):
        # attributes: profile, appid, target_bottle, bottle, installed_packages_ready, installed_packages, profiles, items, _profile, app_profile, download_urls, flags, extra_fors, raw_category, _component_categories, append
        # strings: 'virtual'
        ...

    add_source_media = <function InstallTask.add_source_media>()
    remove_source_media = <function InstallTask.remove_source_media>()
    download_search_paths = <function InstallTask.download_search_paths>()()
    set_installer_source = <function InstallTask.set_installer_source>()
    def setInstallerSource_Requested_(self, inSource, inRequested):
        # attributes: set_installer_source
        ...

    set_installer_download = <function InstallTask.set_installer_download>()
    def setInstallerDownload(self):
        # attributes: set_installer_download
        ...

    set_installer_steam = <function InstallTask.set_installer_steam>()
    def setInstallerSteam(self):
        # attributes: set_installer_steam
        ...

    _get_download_url = <function InstallTask._get_download_url>()
    download_url = property(_get_download_url)
    _get_steamid = <function InstallTask._get_steamid>()
    steamid = property(_get_steamid)
    _clear_installer_source = <function InstallTask._clear_installer_source>()
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

    _trigger_bottle_analysis = <function InstallTask._trigger_bottle_analysis>()
    _categorize_list = <function InstallTask._categorize_list>()
    _categorize_bottles = <function InstallTask._categorize_bottles>()
    add_bottle = <function InstallTask.add_bottle>()
    installed_applications_ready = <function InstallTask.installed_applications_ready>()
    trigger_bottle_analysis = <function InstallTask.trigger_bottle_analysis>()
    remove_bottle_by_name = <function InstallTask.remove_bottle_by_name>()
    remove_bottle = <function InstallTask.remove_bottle>()
    is_new_bottle_name_valid = <function InstallTask.is_new_bottle_name_valid>()
    _set_target_bottle = <function InstallTask._set_target_bottle>()
    _get_target_bottle = <function InstallTask._get_target_bottle>()
    target_bottle = property(_get_target_bottle, _set_target_bottle)
    def _get_new_bottle_name(self):
        # attributes: newBottleName
        ...

    _set_new_bottle_name = <function InstallTask._set_new_bottle_name>()
    new_bottle_name = property(_get_new_bottle_name, _set_new_bottle_name)
    set_create_new_bottle = <function InstallTask.set_create_new_bottle>()
    def createNewBottle_template_(self, newbottlename, template):
        # attributes: set_create_new_bottle
        ...

    def GetCreateNewBottle(self):
        # globals: isinstance, TargetTemplate
        # attributes: targetBottle
        ...

    create_new_bottle = property(GetCreateNewBottle)
    _get_existing_bottle_name = <function InstallTask._get_existing_bottle_name>()
    _get_bottle_name = <function InstallTask._get_bottle_name>()
    _set_bottle_name = <function InstallTask._set_bottle_name>()
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

    get_profile_names = <function InstallTask.get_profile_names>()
    def _get_installation_notes(self):
        # attributes: get_installer_profile, installation_notes
        ...

    installationNotes = property(_get_installation_notes)
    def _get_post_install_url(self):
        # attributes: get_installer_profile, post_install_url
        ...

    post_install_url = property(_get_post_install_url)
    _RE_SINGLE = re.compile('^[a-zA-Z0-9:_-]*$', re.IGNORECASE)
    _find_warning_in_mapping = <function InstallTask._find_warning_in_mapping>()
    _filter_cxdiag_messages = <function InstallTask._filter_cxdiag_messages>()
    _cxdiag_level_cmp = <function InstallTask._cxdiag_level_cmp>()()
    _application_name = <function InstallTask._application_name>()
    application_name = property(_application_name)
    get_cxdiag_messages = <function InstallTask.get_cxdiag_messages>()
    get_apply_cxfixes = <function InstallTask.get_apply_cxfixes>()
    get_summary_string = <function InstallTask.get_summary_string>()
    get_dependency_details = <function InstallTask.get_dependency_details>()
    get_installer_details = <function InstallTask.get_installer_details>()
    get_bottle_details = <function InstallTask.get_bottle_details>()
    get_language_details = <function InstallTask.get_language_details>()
    get_misc_details = <function InstallTask.get_misc_details>()

get_missing_dependencies = <function get_missing_dependencies>()
