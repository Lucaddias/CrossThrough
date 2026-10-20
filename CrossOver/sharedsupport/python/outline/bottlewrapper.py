# bottlewrapper — reconstructed outline of CrossOver 26.3 lib/python/bottlewrapper.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import platform
import time
import distversion
import bottlequery
import bottlemanagement
import c4profilesmanager
import cxconfig
import cxdiag
import cxfsnotifier
import cxlog
import cxmenu
import cxobjc
import cxutils
import pyop
from cxutils import cxgettext as _
menu_observer_queue = pyop.PythonOperationQueue(2)
class BottleWrapper(cxobjc.Proxy):
    STATUS_INIT = _('Scanning…')
    STATUS_UPGRADE = _('Needs upgrade')
    STATUS_READY = _('Ready')
    STATUS_ARCHIVING = _('Archiving…')
    STATUS_DEFAULTING = _('Making default…')
    STATUS_RENAMING = _('Renaming…')
    STATUS_DELETING = _('Deleting…')
    STATUS_DOWNING = _('Shutting down…')
    STATUS_FORCE_DOWNING = _('Forcing shutdown…')
    STATUS_UPGRADING = _('Upgrading…')
    STATUS_REPAIRING = _('Repairing…')
    STATUS_INSTALLING = _('Installing…')
    STATUS_DISABLED = _('Disabled')
    STATUS_SUSPENDED = _('Suspended')
    STATUS_GRAPHICS_BACKEND_UNKNOWN = 'Graphics: Unknown'
    STATUS_GRAPHICS_BACKEND_AUTO = 'Graphics: Auto'
    STATUS_GRAPHICS_BACKEND_D3DMETAL = 'Graphics: D3DMetal'
    STATUS_GRAPHICS_BACKEND_DXMT = 'Graphics: DXMT'
    STATUS_GRAPHICS_BACKEND_DXVK = 'Graphics: DXVK'
    STATUS_GRAPHICS_BACKEND_WINE = 'Graphics: Wine'
    STATUS_VULKAN_BACKEND_UNKNOWN = 'Vulkan: Unknown'
    STATUS_VULKAN_BACKEND_MOLTENVK = 'Vulkan: MoltenVK'
    STATUS_VULKAN_BACKEND_MTLVK = 'Vulkan: MTLVK'
    STATUS_DLSS_UNKNOWN = 'DLSS: Unknown'
    STATUS_DLSS_ENABLED = 'DLSS: Enabled'
    STATUS_DLSS_DISABLED = 'DLSS: Disabled'
    STATUS_DLSS_UNAVAILABLE = 'DLSS: Unavailable'
    STATUS_HIGHRES_UNKNOWN = 'High resolution mode: Unknown'
    STATUS_HIGHRES_ENABLED = 'High resolution mode: Enabled'
    STATUS_HIGHRES_DISABLED = 'High resolution mode: Disabled'
    STATUS_HIGHRES_UNAVAILABLE = 'High resolution mode: Unavailable'
    STATUS_MSYNC_UNKNOWN = 'MSync: Unknown'
    STATUS_MSYNC_ENABLED = 'MSync: Enabled'
    STATUS_MSYNC_DISABLED = 'MSync: Disabled'
    STATUS_MSYNC_UNAVAILABLE = 'MSync: Unavailable'
    STATUS_PREVIEW_UNKNOWN = 'Preview: Unknown'
    STATUS_PREVIEW_ENABLED = 'Preview: Enabled'
    STATUS_PREVIEW_DISABLED = 'Preview: Disabled'
    STATUS_PREVIEW_UNAVAILABLE = 'Preview: Unavailable'
    name = cxobjc.object_property()
    appid = cxobjc.object_property()
    winePrefix = cxobjc.object_property(python_name='wine_prefix')
    systemDrive = cxobjc.object_property(python_name='system_drive')
    changeableName = cxobjc.object_property(python_name='changeablename')
    currentDescription = cxobjc.object_property(python_name='current_description')
    lastQuitFailed = cxobjc.object_property(python_name='last_quit_failed', typestr=cxobjc.BOOL)
    isDefault = cxobjc.object_property(python_name='is_default', typestr=cxobjc.BOOL)
    isManaged = cxobjc.object_property(python_name='is_managed', typestr=cxobjc.BOOL)
    isUpToDate = cxobjc.object_property(python_name='up_to_date', typestr=cxobjc.BOOL)
    isD3DMetalAvailable = cxobjc.object_property(python_name='is_d3dmetal_available', typestr=cxobjc.BOOL)
    isDXMTAvailable = cxobjc.object_property(python_name='is_dxmt_available', typestr=cxobjc.BOOL)
    isMoltenVKAvailable = cxobjc.object_property(python_name='is_moltenvk_available', typestr=cxobjc.BOOL)
    isMTLVKAvailable = cxobjc.object_property(python_name='is_mtlvk_available', typestr=cxobjc.BOOL)
    controlPanelTable = cxobjc.array_property(python_name='control_panel_table')
    isControlPanelReady = cxobjc.object_property(python_name='control_panel_ready', typestr=cxobjc.BOOL)
    isHighResolutionEnabledReady = cxobjc.object_property(python_name='is_high_resolution_enabled_ready', typestr=cxobjc.BOOL)
    installedPackages = cxobjc.dict_property(python_name='installed_packages')
    isInstalledPackagesReady = cxobjc.object_property(python_name='installed_packages_ready', typestr=cxobjc.BOOL)
    menuChangedTime = cxobjc.object_property()
    def __init__(self, name):
        # globals: cxobjc, BottleWrapper
        # attributes: Proxy, __init__, name, changeablename, config, _change_delegates, current_description, template, windows_version, arch, last_quit_failed, _config_changed_observer, _windows_version_observer, operations, control_panel_loading, control_panel_ready, control_panel_table, STATUS_GRAPHICS_BACKEND_UNKNOWN, graphics_backend_state, is_d3dmetal_available, is_dxmt_available, STATUS_VULKAN_BACKEND_UNKNOWN, vulkan_backend_state, is_moltenvk_available, is_mtlvk_available, STATUS_DLSS_UNKNOWN, is_dlss_enabled_state, is_high_resolution_enabled_ready, is_high_resolution_enabled_loading, STATUS_HIGHRES_UNKNOWN, is_high_resolution_enabled_state, STATUS_MSYNC_UNKNOWN, is_msync_enabled_state, STATUS_PREVIEW_UNKNOWN, is_preview_enabled_state, installed_packages, installed_packages_ready, installed_packages_loading, STATUS_INIT, status, status_overrides, initialize
        # strings: ''
        ...

    def initWithName_(self, inName):
        # globals: cxobjc
        # attributes: Proxy, nsobject_init, __init__
        ...

    bottle_changed = <function BottleWrapper.bottle_changed>()
    config_changed = <function BottleWrapper.config_changed>()
    set_menu_changed_time = <function BottleWrapper.set_menu_changed_time>()
    menu_changed = <function BottleWrapper.menu_changed>()
    add_menu_observers = <function BottleWrapper.add_menu_observers>()
    def add_menu_observers_main(self):
        """This can be really slow so this should not be performed on the main thread."""
        # attributes: menu, add_observers, menu_changed
        ...

    remove_menu_observers = <function BottleWrapper.remove_menu_observers>()
    get_config_value = <function BottleWrapper.get_config_value>()
    set_config_value = <function BottleWrapper.set_config_value>()
    def unset_config_value(self, section, name):
        # globals: cxlog
        # attributes: config, get_save_config, warn, to_str, name, lock_file, save_and_unlock_file
        # strings: 'Unable to unset a config value in bottle %s'
        ...

    def suspend(self):
        # globals: BottleWrapper
        # attributes: add_status_override, STATUS_SUSPENDED, operations, suspend
        ...

    def resume(self):
        # globals: BottleWrapper
        # attributes: operations, resume, remove_status_override, STATUS_SUSPENDED
        ...

    initialize = <function BottleWrapper.initialize>()
    remove_observers = <function BottleWrapper.remove_observers>()
    load_basic_info = <function BottleWrapper.load_basic_info>()
    reload_info = <function BottleWrapper.reload_info>()
    refresh_up_to_date = <function BottleWrapper.refresh_up_to_date>()
    set_is_default = <function BottleWrapper.set_is_default>()
    add_config_observer = <function BottleWrapper.add_config_observer>()
    remove_config_observer = <function BottleWrapper.remove_config_observer>()
    add_windows_version_observer = <function BottleWrapper.add_windows_version_observer>()
    remove_windows_version_observer = <function BottleWrapper.remove_windows_version_observer>()
    on_windows_version_changed = <function BottleWrapper.on_windows_version_changed>()
    is_macos_version = <function BottleWrapper.is_macos_version>()()
    is_apple_silicon = <function BottleWrapper.is_apple_silicon>()()
    load_graphics_backend_info = <function BottleWrapper.load_graphics_backend_info>()
    set_graphics_backend_auto = <function BottleWrapper.set_graphics_backend_auto>()
    set_graphics_backend_d3dmetal = <function BottleWrapper.set_graphics_backend_d3dmetal>()
    set_graphics_backend_dxmt = <function BottleWrapper.set_graphics_backend_dxmt>()
    set_graphics_backend_dxvk = <function BottleWrapper.set_graphics_backend_dxvk>()
    set_graphics_backend_wine = <function BottleWrapper.set_graphics_backend_wine>()
    is_d3dmetal_enabled = <function BottleWrapper.is_d3dmetal_enabled>()
    isD3DMetalEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_d3dmetal_enabled, depends_on=['graphics_backend_state'])
    is_dxmt_enabled = <function BottleWrapper.is_dxmt_enabled>()
    isDXMTEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_dxmt_enabled, depends_on=['graphics_backend_state'])
    is_dxvk_enabled = <function BottleWrapper.is_dxvk_enabled>()
    isDXVKEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_dxvk_enabled, depends_on=['graphics_backend_state'])
    is_wined3d_enabled = <function BottleWrapper.is_wined3d_enabled>()
    isWineD3DEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_wined3d_enabled, depends_on=['graphics_backend_state'])
    load_vulkan_backend_info = <function BottleWrapper.load_vulkan_backend_info>()
    set_vulkan_backend_moltenvk = <function BottleWrapper.set_vulkan_backend_moltenvk>()
    set_vulkan_backend_mtlvk = <function BottleWrapper.set_vulkan_backend_mtlvk>()
    is_moltenvk_enabled = <function BottleWrapper.is_moltenvk_enabled>()
    isMoltenVKEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_moltenvk_enabled, depends_on=['vulkan_backend_state'])
    is_mtlvk_enabled = <function BottleWrapper.is_mtlvk_enabled>()
    isMTLVKEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_mtlvk_enabled, depends_on=['vulkan_backend_state'])
    load_is_dlss_enabled = <function BottleWrapper.load_is_dlss_enabled>()
    enable_dlss = <function BottleWrapper.enable_dlss>()
    disable_dlss = <function BottleWrapper.disable_dlss>()
    is_dlss_enabled = <function BottleWrapper.is_dlss_enabled>()
    isDLSSEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_dlss_enabled, depends_on=['is_dlss_enabled_state'])
    is_dlss_available = <function BottleWrapper.is_dlss_available>()
    isDLSSAvailable = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_dlss_available, depends_on=['is_dlss_enabled_state'])
    get_logpixels = <function BottleWrapper.get_logpixels>()
    load_high_resolution_info = <function BottleWrapper.load_high_resolution_info>()
    def enableHighResolution(self):
        # attributes: enable_high_resolution
        ...

    enable_high_resolution = <function BottleWrapper.enable_high_resolution>()
    disable_high_resolution = <function BottleWrapper.disable_high_resolution>()
    is_high_resolution_enabled = <function BottleWrapper.is_high_resolution_enabled>()
    isHighResolutionEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_high_resolution_enabled, depends_on=['is_high_resolution_enabled_state'])
    load_is_msync_enabled = <function BottleWrapper.load_is_msync_enabled>()
    _enable_msync = <function BottleWrapper._enable_msync>()
    enable_msync = <function BottleWrapper.enable_msync>()
    _disable_msync = <function BottleWrapper._disable_msync>()
    disable_msync = <function BottleWrapper.disable_msync>()
    is_msync_enabled = <function BottleWrapper.is_msync_enabled>()
    isMSyncEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_msync_enabled, depends_on=['is_msync_enabled_state'])
    load_is_preview_enabled = <function BottleWrapper.load_is_preview_enabled>()
    enable_preview = <function BottleWrapper.enable_preview>()
    disable_preview = <function BottleWrapper.disable_preview>()
    is_preview_enabled = <function BottleWrapper.is_preview_enabled>()
    isPreviewEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_preview_enabled, depends_on=['is_preview_enabled_state'])
    disable_rating_nag = <function BottleWrapper.disable_rating_nag>()
    should_nag_for_ratings = <function BottleWrapper.should_nag_for_ratings>()
    shouldNagForRatings = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=should_nag_for_ratings, depends_on=['config'])
    load_control_panel_info = <function BottleWrapper.load_control_panel_info>()
    launch_control_panel_applet = <function BottleWrapper.launch_control_panel_applet>()
    load_application_info = <function BottleWrapper.load_application_info>()
    file_is_in_bottle = <function BottleWrapper.file_is_in_bottle>()
    write_description = <function BottleWrapper.write_description>()
    wait_for_shutdown = <function BottleWrapper.wait_for_shutdown>()
    delete = <function BottleWrapper.delete>()
    rename = <function BottleWrapper.rename>()
    add_change_delegate = <function BottleWrapper.add_change_delegate>()
    remove_change_delegate = <function BottleWrapper.remove_change_delegate>()
    add_status_override = <function BottleWrapper.add_status_override>()
    remove_all_status_overrides = <function BottleWrapper.remove_all_status_overrides>()
    remove_status_override = <function BottleWrapper.remove_status_override>()
    def get_can_run_commands(self):
        # attributes: up_to_date, is_managed, is_busy, is_disabled
        ...

    can_run_commands = property(get_can_run_commands)
    canRunCommands = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_can_run_commands, depends_on=['up_to_date', 'is_managed', 'is_busy'])
    def get_can_edit(self):
        # attributes: up_to_date, is_busy, is_managed
        ...

    can_edit = property(get_can_edit)
    canEdit = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_can_edit, depends_on=['up_to_date', 'is_managed', 'is_busy'])
    def get_is_usable(self):
        # attributes: status_overrides, STATUS_INIT, STATUS_UPGRADE, STATUS_READY, STATUS_DEFAULTING
        ...

    is_usable = property(get_is_usable)
    isUsable = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_is_usable, depends_on=['status'])
    def get_can_install(self):
        # attributes: is_managed, is_usable
        ...

    can_install = property(get_can_install)
    canInstall = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_can_install, depends_on=['is_managed', 'is_usable'])
    def get_is_active(self):
        # attributes: status_overrides, up_to_date
        ...

    is_active = property(get_is_active)
    isActive = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_is_active, depends_on=['status', 'up_to_date'])
    def get_can_force_quit(self):
        """Be careful of race conditions with this property.  If all you've done
is initiate an asynchronous operation to quit the bottle, these statuses
won't necessarily be set yet."""
        # globals: BottleWrapper
        # attributes: last_quit_failed, STATUS_DOWNING, status_overrides, STATUS_FORCE_DOWNING
        ...

    can_force_quit = property(get_can_force_quit)
    canForceQuit = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_can_force_quit, depends_on=['status', 'last_quit_failed'])
    def get_is_32_bit(self):
        # attributes: arch
        # strings: 'win32'
        ...

    is_32_bit = property(get_is_32_bit)
    is32Bit = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_is_32_bit, depends_on=['arch'])
    def get_is_busy(self):
        # globals: BottleWrapper
        # attributes: STATUS_RENAMING, status_overrides, STATUS_DELETING, STATUS_REPAIRING, STATUS_ARCHIVING, STATUS_INSTALLING, STATUS_DOWNING, STATUS_FORCE_DOWNING
        ...

    is_busy = property(get_is_busy)
    isBusy = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_is_busy, depends_on=['status'])
    def get_is_disabled(self):
        # globals: BottleWrapper
        # attributes: STATUS_DISABLED, status_overrides
        ...

    is_disabled = property(get_is_disabled)
    isDisabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_is_disabled, depends_on=['status'])
    def get_is_deleted(self):
        # globals: os
        # attributes: path, isdir, wine_prefix
        ...

    is_deleted = property(get_is_deleted)
    isDeleted = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_is_deleted)
    def get_is_renaming(self):
        # globals: BottleWrapper
        # attributes: STATUS_RENAMING, status_overrides
        ...

    is_renaming = property(get_is_renaming)
    isRenaming = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_is_renaming, depends_on=['status'])
    def get_is_suspended(self):
        # globals: BottleWrapper
        # attributes: STATUS_SUSPENDED, status_overrides
        ...

    is_suspended = property(get_is_suspended)
    def get_can_rename(self):
        # attributes: status_overrides, is_managed
        ...

    can_rename = property(get_can_rename)
    canRename = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_can_rename, depends_on=['status', 'is_managed'])
    def get_needs_upgrade(self):
        # attributes: is_managed, up_to_date
        ...

    needs_upgrade = property(get_needs_upgrade)
    needsUpgrade = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=get_needs_upgrade, depends_on=['up_to_date', 'is_managed'])
    quit = <function BottleWrapper.quit>()
    force_quit = <function BottleWrapper.force_quit>()
    def get_display_name(self):
        # globals: _
        # attributes: is_default, name
        # strings: '%s (default)'
        ...

    display_name = property(get_display_name)
    displayName = cxobjc.object_property(read_only=True, getter=get_display_name, depends_on=['name', 'is_default'])
    get_windows_version_display_name = <function BottleWrapper.get_windows_version_display_name>()
    windows_version_display_name = property(get_windows_version_display_name)
    windowsVersionDisplayName = cxobjc.object_property(read_only=True, getter=get_windows_version_display_name, depends_on=['windows_version', 'arch'])
    def get_appid(self):
        # attributes: get_config_value, startswith, isdigit
        # strings: 'EnvironmentVariables', 'CX_BOTTLE_CREATOR_APPID', 'com.codeweavers.c4.'
        ...

    def get_profile(self):
        # globals: c4profilesmanager
        # attributes: appid, C4ProfilesSet, all_profiles, get
        # strings: 'com.codeweavers.c4.%s'
        ...

    profile = property(get_profile)
    get_missing_dependencies_profile = <function BottleWrapper.get_missing_dependencies_profile>()
    def bottleName(self):
        # attributes: name
        ...

    callback = <function BottleWrapper.callback>()

class BottleWrapperOperation(pyop.PythonOperation):
    def __init__(self, bottle):
        # globals: pyop
        # attributes: PythonOperation, __init__, bottle
        ...

    def __repr__(self):
        # attributes: __class__, __name__, bottle, name
        # strings: ' for '
        ...

    def cancel(self):
        # globals: pyop
        # attributes: PythonOperation, cancel, bottle, operations, remove
        ...

    def enqueued(self):
        # globals: pyop
        # attributes: PythonOperation, enqueued, bottle, operations, append, is_suspended, suspend
        ...

    def main(self):
        # globals: NotImplementedError
        ...

    def finish(self):
        # globals: pyop
        # attributes: bottle, operations, remove, PythonOperation, finish
        ...


class AddMenuObserversOperation(BottleWrapperOperation):
    def __init__(self, bottle):
        # globals: BottleWrapperOperation
        # attributes: __init__
        ...

    def main(self):
        # attributes: bottle, add_menu_observers_main
        ...


class LoadApplicationInfoOperation(BottleWrapperOperation):
    def __init__(self, bottle):
        # globals: BottleWrapperOperation
        # attributes: __init__, _installed_packages_off_thread
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation, BottleWrapper
        # attributes: enqueued, bottle, installed_packages_ready, installed_packages_loading, _installed_packages_off_thread, add_status_override, STATUS_INIT
        ...

    def main(self):
        # globals: c4profilesmanager
        # attributes: C4ProfilesSet, all_profiles, fast_get_installed_applications, bottle, name, _installed_packages_off_thread
        ...

    def finish(self):
        # globals: BottleWrapper, BottleWrapperOperation
        # attributes: _installed_packages_off_thread, bottle, installed_packages, installed_packages_ready, installed_packages_loading, remove_status_override, STATUS_INIT, finish
        ...


class LoadControlPanelInfoOperation(BottleWrapperOperation):
    def __init__(self, bottle):
        # globals: BottleWrapperOperation
        # attributes: __init__, priority, _control_panel_off_thread_table
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation, BottleWrapper
        # attributes: enqueued, bottle, control_panel_loading, control_panel_ready, add_status_override, STATUS_INIT
        ...

    def main(self):
        # globals: bottlequery
        # attributes: get_control_panel_info, bottle, name, _control_panel_off_thread_table
        ...

    def finish(self):
        # globals: BottleWrapper, BottleWrapperOperation
        # attributes: _control_panel_off_thread_table, append, bottle, control_panel_table, control_panel_ready, control_panel_loading, remove_status_override, STATUS_INIT, finish
        # strings: 'exe', 'name', 'description'
        ...


class LoadHighResolutionInfoOperation(BottleWrapperOperation):
    def __init__(self, bottle):
        # globals: BottleWrapperOperation
        # attributes: __init__
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation, BottleWrapper
        # attributes: enqueued, bottle, is_high_resolution_enabled_ready, is_high_resolution_enabled_loading, add_status_override, STATUS_INIT
        ...

    def main(self):
        # globals: BottleWrapper, distversion, int, float, cxdiag, bottlequery, set
        # attributes: STATUS_HIGHRES_UNKNOWN, bottle, is_high_resolution_enabled_state, IS_MACOSX, get, properties, STATUS_HIGHRES_UNAVAILABLE, get_registry_key, name, STATUS_HIGHRES_ENABLED, get_logpixels, STATUS_HIGHRES_DISABLED, NotFoundError
        # strings: 'HKEY_CURRENT_USER\\Software\\Wine\\Mac Driver', 'display.dpi', 'retinamode', 'yYtT1'
        ...

    def finish(self):
        # globals: BottleWrapper, BottleWrapperOperation
        # attributes: bottle, is_high_resolution_enabled_ready, is_high_resolution_enabled_loading, remove_status_override, STATUS_INIT, finish
        ...


class SetHighResolutionEnabledStateOperation(BottleWrapperOperation):
    def __init__(self, bottle, state, logpixels=96):
        # globals: BottleWrapperOperation
        # attributes: __init__, state, logpixels
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation
        # attributes: enqueued, bottle, is_high_resolution_enabled_loading, is_high_resolution_enabled_ready
        ...

    def main(self):
        # globals: distversion, bottlequery, max, hex, BottleWrapper
        # attributes: logpixels, state, IS_MACOSX, set_registry_key, bottle, name, get_logpixels, unset_registry_value, STATUS_HIGHRES_ENABLED, is_high_resolution_enabled_state, STATUS_HIGHRES_DISABLED
        # strings: 'HKEY_CURRENT_USER\\Software\\Wine\\Mac Driver', 'HKEY_CURRENT_USER\\Control Panel\\Desktop', 'RetinaMode', 'y', 'LogPixels', 'dword:'
        ...

    def finish(self):
        # globals: BottleWrapperOperation
        # attributes: bottle, is_high_resolution_enabled_ready, is_high_resolution_enabled_loading, quit, finish
        ...


class SetIsDefaultOperation(BottleWrapperOperation):
    def __init__(self, bottle, state, callback):
        # globals: BottleWrapperOperation
        # attributes: __init__, state, callback, success
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation
        # attributes: enqueued, bottle, add_status_override, STATUS_DEFAULTING
        ...

    def main(self):
        # globals: bottlemanagement
        # attributes: set_default_bottle, bottle, name, state, success
        ...

    def finish(self):
        # globals: BottleWrapperOperation
        # attributes: bottle, remove_status_override, STATUS_DEFAULTING, success, callback, finish
        ...


class DeleteBottleOperation(BottleWrapperOperation):
    def __init__(self, bottle, callback):
        # globals: BottleWrapperOperation
        # attributes: __init__, callback, success
        ...

    def suspend(self):
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation
        # attributes: enqueued, bottle, add_status_override, STATUS_DELETING
        ...

    def main(self):
        # globals: bottlemanagement
        # attributes: bottle, wait_for_shutdown, delete_bottle, name, is_managed, success
        ...

    def finish(self):
        # globals: BottleWrapperOperation
        # attributes: callback, success, bottle, is_deleted, remove_status_override, STATUS_DELETING, operations, cancel, finish
        ...


class RenameBottleOperation(BottleWrapperOperation):
    def __init__(self, bottle, new_name, callback):
        # globals: BottleWrapperOperation
        # attributes: __init__, new_name, callback, success
        ...

    def suspend(self):
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation, BottleWrapper, bottlequery
        # attributes: enqueued, bottle, add_status_override, STATUS_RENAMING, new_name, changeablename, name, success, is_valid_new_bottle_name
        ...

    def main(self):
        # globals: bottlemanagement, cxlog
        # attributes: success, bottle, wait_for_shutdown, rename_bottle, name, changeablename, warn
        # strings: 'Rename from ', ' to ', ' failed: '
        ...

    def finish(self):
        # globals: BottleWrapper, BottleWrapperOperation
        # attributes: success, bottle, load_basic_info, name, changeablename, menu, config_observer, remove_menu_observers, initialize, add_menu_observers, resume, remove_status_override, STATUS_RENAMING, callback, finish
        ...


class QuitBottleOperation(BottleWrapperOperation):
    def __init__(self, bottle, callback):
        # globals: BottleWrapperOperation
        # attributes: __init__, callback, success
        ...

    def suspend(self):
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation, BottleWrapper
        # attributes: enqueued, bottle, last_quit_failed, add_status_override, STATUS_DOWNING
        ...

    def main(self):
        # globals: bottlemanagement
        # attributes: quit_bottle, bottle, name, success
        ...

    def finish(self):
        # globals: BottleWrapper, BottleWrapperOperation
        # attributes: success, bottle, last_quit_failed, remove_status_override, STATUS_DOWNING, callback, finish
        ...


class ForceQuitBottleOperation(BottleWrapperOperation):
    def __init__(self, bottle, callback):
        # globals: BottleWrapperOperation
        # attributes: __init__, callback, success
        ...

    def suspend(self):
        ...

    def enqueued(self):
        # globals: BottleWrapperOperation, BottleWrapper
        # attributes: enqueued, bottle, add_status_override, STATUS_FORCE_DOWNING
        ...

    def main(self):
        # globals: bottlemanagement
        # attributes: kill_bottle, bottle, name, success
        ...

    def finish(self):
        # globals: BottleWrapper, BottleWrapperOperation
        # attributes: success, bottle, last_quit_failed, remove_status_override, STATUS_FORCE_DOWNING, callback, finish
        ...
