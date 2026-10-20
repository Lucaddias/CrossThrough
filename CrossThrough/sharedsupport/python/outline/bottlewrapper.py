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

    @cxobjc.python_method
    def bottle_changed(self):
        # attributes: callback
        # strings: 'bottleChanged'
        ...

    @cxobjc.python_method
    def config_changed(self, *_args):
        """Called when the bottle config has changed.
This means that all bottle information has to be
reloaded from the main thread."""
        # globals: pyop
        # attributes: STATUS_DELETING, status_overrides, STATUS_RENAMING, perform_on_main_thread, reload_info
        ...

    @cxobjc.python_method
    def set_menu_changed_time(self):
        # globals: time
        # attributes: time, menuChangedTime
        ...

    @cxobjc.python_method
    def menu_changed(self):
        """Called when the bottle menu has changed.
This means that all bottle information and launchers have to
be reloaded from the main thread."""
        # globals: pyop
        # attributes: STATUS_DELETING, status_overrides, STATUS_RENAMING, perform_on_main_thread, set_menu_changed_time, reload_info
        ...

    @cxobjc.namedSelector(b'addMenuObservers')
    def add_menu_observers(self):
        # globals: AddMenuObserversOperation, menu_observer_queue
        # attributes: enqueue
        ...

    def add_menu_observers_main(self):
        """This can be really slow so this should not be performed on the main thread."""
        # attributes: menu, add_observers, menu_changed
        ...

    @cxobjc.namedSelector(b'removeMenuObservers')
    def remove_menu_observers(self):
        # attributes: menu, remove_observers, menu_changed
        ...

    @cxobjc.python_method
    def get_config_value(self, section, name, default):
        # attributes: config, get
        ...

    @cxobjc.python_method
    def set_config_value(self, section, name, value):
        # globals: cxlog
        # attributes: config, get_save_config, warn, to_str, name, lock_file, save_and_unlock_file
        # strings: 'Unable to set a config value in bottle %s'
        ...

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

    @cxobjc.python_method
    def initialize(self):
        # globals: bottlequery, os, cxmenu
        # attributes: reset_cache, name, remove_config_observer, get_prefix_for_bottle, wine_prefix, get_config, config, add_config_observer, load_basic_info, path, join, system_drive, get_default_bottle, is_default, MenuPrefs, is_managed, menu, add_windows_version_observer
        # strings: 'drive_c'
        ...

    @cxobjc.namedSelector(b'removeObservers')
    def remove_observers(self):
        # attributes: remove_windows_version_observer, remove_config_observer, remove_menu_observers
        ...

    @cxobjc.namedSelector(b'loadBasicInfo')
    def load_basic_info(self):
        """This function loads the bottle's basic properties.
On the Mac, this function MUST be called in the main thread because
it modifies properties which are bound to the UI.
"""
        # attributes: wine_prefix, get_config_value, arch, current_description, is_managed, template, split, windows_version, get_appid, appid, refresh_up_to_date, load_graphics_backend_info, load_vulkan_backend_info, load_is_msync_enabled, load_is_preview_enabled, bottle_changed
        # strings: 'Bottle', 'WineArch', 'win32', 'Description', '', 'Updater', 'Template', 'win98', 'WindowsVersion', '_'
        ...

    @cxobjc.namedSelector(b'reloadInfo')
    def reload_info(self):
        # attributes: load_basic_info, installed_packages_ready, load_application_info, control_panel_ready, load_control_panel_info, is_high_resolution_enabled_ready, load_high_resolution_info
        ...

    @cxobjc.namedSelector(b'refreshUpToDate')
    def refresh_up_to_date(self):
        """On the Mac, this function MUST be called in the main thread because
it modifies properties which are bound to the UI.
"""
        # globals: bottlemanagement, BottleWrapper
        # attributes: is_managed, get_up_to_date, name, up_to_date, add_status_override, STATUS_UPGRADE, remove_all_status_overrides
        # strings: 'managed'
        ...

    @cxobjc.namedSelector(b'setIsDefault:completionHandler:')
    def set_is_default(self, state, callback=None):
        # globals: SetIsDefaultOperation, pyop
        # attributes: sharedOperationQueue, enqueue
        ...

    @cxobjc.python_method
    def add_config_observer(self):
        # globals: cxconfig
        # attributes: config, add_observer, RELOADED, config_changed, _config_changed_observer
        ...

    @cxobjc.python_method
    def remove_config_observer(self):
        # globals: cxconfig
        # attributes: config, remove_observer, RELOADED, _config_changed_observer
        ...

    @cxobjc.python_method
    def add_windows_version_observer(self):
        # globals: os, cxfsnotifier, open
        # attributes: remove_windows_version_observer, path, join, wine_prefix, add_observer, on_windows_version_changed, _windows_version_observer, exists
        # strings: '.version', 'w', 'ascii'
        ...

    @cxobjc.python_method
    def remove_windows_version_observer(self):
        # globals: cxfsnotifier
        # attributes: _windows_version_observer, items, remove_observer
        ...

    @cxobjc.python_method
    def on_windows_version_changed(self, _event=None, _path=None, _data=None):
        # globals: bottlequery, IOError, cxlog, str
        # attributes: STATUS_DELETING, status_overrides, STATUS_RENAMING, get_windows_version, name, windows_version, set_config_value, config_changed, log
        # strings: 'Bottle', 'WindowsVersion', 'Error while updating windows version in bottle ', ': '
        ...

    @staticmethod
    @cxobjc.python_method
    def is_macos_version(version):
        # globals: platform, distversion, int
        # attributes: mac_ver, split, IS_MACOSX
        # strings: '.'
        ...

    @staticmethod
    @cxobjc.python_method
    def is_apple_silicon():
        # globals: platform
        # attributes: machine, CDLL, util, find_library, c_int, sysctlbyname, byref, c_size_t, value
        # strings: 'arm', 'c'
        ...

    @cxobjc.python_method
    def load_graphics_backend_info(self):
        # globals: BottleWrapper
        # attributes: is_macos_version, is_apple_silicon, is_d3dmetal_available, is_dxmt_available, get_config_value, STATUS_GRAPHICS_BACKEND_D3DMETAL, graphics_backend_state, STATUS_GRAPHICS_BACKEND_DXMT, STATUS_GRAPHICS_BACKEND_DXVK, STATUS_GRAPHICS_BACKEND_WINE, STATUS_GRAPHICS_BACKEND_AUTO, load_is_dlss_enabled
        # strings: 'EnvironmentVariables', 'CX_GRAPHICS_BACKEND', '', 'd3dmetal', 'dxmt', 'dxvk', 'wined3d'
        ...

    @cxobjc.namedSelector(b'setGraphicsBackendAuto')
    def set_graphics_backend_auto(self):
        # attributes: set_config_value, load_graphics_backend_info, bottle_changed
        # strings: 'EnvironmentVariables', 'CX_GRAPHICS_BACKEND', ''
        ...

    @cxobjc.namedSelector(b'setGraphicsBackendD3DMetal')
    def set_graphics_backend_d3dmetal(self):
        # attributes: set_config_value, load_graphics_backend_info, bottle_changed
        # strings: 'EnvironmentVariables', 'CX_GRAPHICS_BACKEND', 'd3dmetal'
        ...

    @cxobjc.namedSelector(b'setGraphicsBackendDXMT')
    def set_graphics_backend_dxmt(self):
        # attributes: set_config_value, load_graphics_backend_info, bottle_changed
        # strings: 'EnvironmentVariables', 'CX_GRAPHICS_BACKEND', 'dxmt'
        ...

    @cxobjc.namedSelector(b'setGraphicsBackendDXVK')
    def set_graphics_backend_dxvk(self):
        # attributes: set_config_value, load_graphics_backend_info, bottle_changed
        # strings: 'EnvironmentVariables', 'CX_GRAPHICS_BACKEND', 'dxvk'
        ...

    @cxobjc.namedSelector(b'setGraphicsBackendWine')
    def set_graphics_backend_wine(self):
        # attributes: set_config_value, load_graphics_backend_info, bottle_changed
        # strings: 'EnvironmentVariables', 'CX_GRAPHICS_BACKEND', 'wined3d'
        ...

    @cxobjc.python_method
    def is_d3dmetal_enabled(self):
        # globals: BottleWrapper
        # attributes: graphics_backend_state, STATUS_GRAPHICS_BACKEND_D3DMETAL
        ...

    isD3DMetalEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_d3dmetal_enabled, depends_on=['graphics_backend_state'])
    @cxobjc.python_method
    def is_dxmt_enabled(self):
        # globals: BottleWrapper
        # attributes: graphics_backend_state, STATUS_GRAPHICS_BACKEND_DXMT
        ...

    isDXMTEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_dxmt_enabled, depends_on=['graphics_backend_state'])
    @cxobjc.python_method
    def is_dxvk_enabled(self):
        # globals: BottleWrapper
        # attributes: graphics_backend_state, STATUS_GRAPHICS_BACKEND_DXVK
        ...

    isDXVKEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_dxvk_enabled, depends_on=['graphics_backend_state'])
    @cxobjc.python_method
    def is_wined3d_enabled(self):
        # globals: BottleWrapper
        # attributes: graphics_backend_state, STATUS_GRAPHICS_BACKEND_WINE
        ...

    isWineD3DEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_wined3d_enabled, depends_on=['graphics_backend_state'])
    @cxobjc.python_method
    def load_vulkan_backend_info(self):
        # globals: BottleWrapper, distversion
        # attributes: STATUS_VULKAN_BACKEND_UNKNOWN, vulkan_backend_state, IS_MACOSX, is_moltenvk_available, is_macos_version, is_apple_silicon, is_mtlvk_available, get_config_value, STATUS_VULKAN_BACKEND_MTLVK, STATUS_VULKAN_BACKEND_MOLTENVK
        # strings: 'EnvironmentVariables', 'CX_LIBVULKAN', '', 'libvulkan.dylib'
        ...

    @cxobjc.namedSelector(b'setVulkanBackendMoltenVK')
    def set_vulkan_backend_moltenvk(self):
        # attributes: set_config_value, load_vulkan_backend_info, bottle_changed
        # strings: 'EnvironmentVariables', 'CX_LIBVULKAN', 'libMoltenVK.dylib'
        ...

    @cxobjc.namedSelector(b'setVulkanBackendMTLVK')
    def set_vulkan_backend_mtlvk(self):
        # attributes: set_config_value, load_vulkan_backend_info, bottle_changed
        # strings: 'EnvironmentVariables', 'CX_LIBVULKAN', 'libvulkan.dylib'
        ...

    @cxobjc.python_method
    def is_moltenvk_enabled(self):
        # globals: BottleWrapper
        # attributes: vulkan_backend_state, STATUS_VULKAN_BACKEND_MOLTENVK
        ...

    isMoltenVKEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_moltenvk_enabled, depends_on=['vulkan_backend_state'])
    @cxobjc.python_method
    def is_mtlvk_enabled(self):
        # globals: BottleWrapper
        # attributes: vulkan_backend_state, STATUS_VULKAN_BACKEND_MTLVK
        ...

    isMTLVKEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_mtlvk_enabled, depends_on=['vulkan_backend_state'])
    @cxobjc.python_method
    def load_is_dlss_enabled(self):
        # globals: BottleWrapper
        # attributes: STATUS_DLSS_UNKNOWN, is_dlss_enabled_state, graphics_backend_state, STATUS_GRAPHICS_BACKEND_AUTO, STATUS_GRAPHICS_BACKEND_D3DMETAL, STATUS_GRAPHICS_BACKEND_DXMT, STATUS_DLSS_UNAVAILABLE, is_macos_version, is_apple_silicon, is_d3dmetal_enabled, get_config_value, set_config_value, STATUS_DLSS_ENABLED, STATUS_DLSS_DISABLED
        # strings: 'EnvironmentVariables', 'D3DM_ENABLE_METALFX', '0', 'DXMT_ENABLE_NVEXT', '1'
        ...

    @cxobjc.namedSelector(b'enableDLSS')
    def enable_dlss(self):
        # globals: BottleWrapper
        # attributes: set_config_value, is_macos_version, STATUS_DLSS_ENABLED, is_dlss_enabled_state, bottle_changed
        # strings: 'EnvironmentVariables', 'D3DM_ENABLE_METALFX', '1', '0', 'DXMT_ENABLE_NVEXT'
        ...

    @cxobjc.namedSelector(b'disableDLSS')
    def disable_dlss(self):
        # globals: BottleWrapper
        # attributes: set_config_value, STATUS_DLSS_DISABLED, is_dlss_enabled_state, bottle_changed
        # strings: 'EnvironmentVariables', 'D3DM_ENABLE_METALFX', '0', 'DXMT_ENABLE_NVEXT'
        ...

    @cxobjc.python_method
    def is_dlss_enabled(self):
        # globals: BottleWrapper
        # attributes: is_dlss_enabled_state, STATUS_DLSS_ENABLED
        ...

    isDLSSEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_dlss_enabled, depends_on=['is_dlss_enabled_state'])
    @cxobjc.python_method
    def is_dlss_available(self):
        # globals: BottleWrapper
        # attributes: is_dlss_enabled_state, STATUS_DLSS_UNAVAILABLE
        ...

    isDLSSAvailable = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_dlss_available, depends_on=['is_dlss_enabled_state'])
    @cxobjc.python_method
    def get_logpixels(self):
        # globals: bottlequery
        # attributes: get_registry_key, name, get, NotFoundError
        # strings: 'HKEY_CURRENT_USER\\Control Panel\\Desktop', 'HKEY_LOCAL_MACHINE\\System\\CurrentControlSet\\Hardware Profiles\\Current\\Software\\Fonts', 'logpixels'
        ...

    @cxobjc.namedSelector(b'loadHighResolutionInfo')
    def load_high_resolution_info(self):
        # globals: LoadHighResolutionInfoOperation, pyop
        # attributes: is_high_resolution_enabled_ready, is_high_resolution_enabled_loading, sharedOperationQueue, enqueue
        ...

    def enableHighResolution(self):
        # attributes: enable_high_resolution
        ...

    @cxobjc.python_method
    def enable_high_resolution(self, logpixels):
        # globals: SetHighResolutionEnabledStateOperation, pyop
        # attributes: sharedOperationQueue, enqueue
        ...

    @cxobjc.namedSelector(b'disableHighResolution')
    def disable_high_resolution(self):
        # globals: SetHighResolutionEnabledStateOperation, pyop
        # attributes: sharedOperationQueue, enqueue
        ...

    @cxobjc.python_method
    def is_high_resolution_enabled(self):
        # globals: BottleWrapper
        # attributes: is_high_resolution_enabled_state, STATUS_HIGHRES_ENABLED
        ...

    isHighResolutionEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_high_resolution_enabled, depends_on=['is_high_resolution_enabled_state'])
    @cxobjc.python_method
    def load_is_msync_enabled(self):
        # globals: BottleWrapper, distversion
        # attributes: STATUS_MSYNC_UNKNOWN, is_msync_enabled_state, IS_MACOSX, STATUS_MSYNC_UNAVAILABLE, get_config_value, STATUS_MSYNC_ENABLED, STATUS_MSYNC_DISABLED
        # strings: 'EnvironmentVariables', 'WINEMSYNC', '0'
        ...

    @cxobjc.python_method
    def _enable_msync(self):
        # globals: BottleWrapper
        # attributes: set_config_value, STATUS_MSYNC_ENABLED, is_msync_enabled_state, bottle_changed
        # strings: 'EnvironmentVariables', 'WINEMSYNC', '1'
        ...

    @cxobjc.namedSelector(b'enableMSync')
    def enable_msync(self):
        # attributes: suspend, quit
        def quit_callback():
            # attributes: _enable_msync, resume
            ...

        ...

    @cxobjc.python_method
    def _disable_msync(self):
        # globals: BottleWrapper
        # attributes: set_config_value, STATUS_MSYNC_DISABLED, is_msync_enabled_state, bottle_changed
        # strings: 'EnvironmentVariables', 'WINEMSYNC', '0'
        ...

    @cxobjc.namedSelector(b'disableMSync')
    def disable_msync(self):
        # attributes: suspend, quit
        def quit_callback():
            # attributes: _disable_msync, resume
            ...

        ...

    @cxobjc.python_method
    def is_msync_enabled(self):
        # globals: BottleWrapper
        # attributes: is_msync_enabled_state, STATUS_MSYNC_ENABLED
        ...

    isMSyncEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_msync_enabled, depends_on=['is_msync_enabled_state'])
    @cxobjc.python_method
    def load_is_preview_enabled(self):
        # globals: BottleWrapper, distversion
        # attributes: STATUS_PREVIEW_UNKNOWN, is_preview_enabled_state, IS_PREVIEW, STATUS_PREVIEW_UNAVAILABLE, get_config_value, STATUS_PREVIEW_ENABLED, remove_all_status_overrides, STATUS_DISABLED, STATUS_PREVIEW_DISABLED, add_status_override
        # strings: 'Bottle', 'Preview', '0'
        ...

    @cxobjc.namedSelector(b'enablePreview')
    def enable_preview(self):
        # globals: BottleWrapper
        # attributes: set_config_value, STATUS_PREVIEW_ENABLED, is_preview_enabled_state, remove_all_status_overrides, STATUS_DISABLED, config_changed
        # strings: 'Bottle', 'Preview', '1'
        ...

    @cxobjc.namedSelector(b'disablePreview')
    def disable_preview(self):
        # globals: BottleWrapper
        # attributes: set_config_value, STATUS_PREVIEW_DISABLED, is_preview_enabled_state, add_status_override, STATUS_DISABLED, config_changed
        # strings: 'Bottle', 'Preview', '0'
        ...

    @cxobjc.python_method
    def is_preview_enabled(self):
        # globals: BottleWrapper
        # attributes: is_preview_enabled_state, STATUS_PREVIEW_ENABLED
        ...

    isPreviewEnabled = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=is_preview_enabled, depends_on=['is_preview_enabled_state'])
    @cxobjc.namedSelector(b'disableRatingNag')
    def disable_rating_nag(self):
        # attributes: set_config_value, bottle_changed
        # strings: 'Bottle', 'AskForRatings', '0'
        ...

    @cxobjc.python_method
    def should_nag_for_ratings(self):
        # globals: distversion, int, time, ValueError
        # attributes: get_config_value, IS_PREVIEW, time, set_config_value
        # strings: 'Bottle', 'AskForRatings', '1', 'RatingHookDate', '0', '%d'
        ...

    shouldNagForRatings = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=should_nag_for_ratings, depends_on=['config'])
    @cxobjc.namedSelector(b'loadControlPanelInfo')
    def load_control_panel_info(self):
        # globals: LoadControlPanelInfoOperation, pyop
        # attributes: control_panel_ready, control_panel_loading, sharedOperationQueue, enqueue
        ...

    @cxobjc.namedSelector(b'launchControlPanelApplet:')
    def launch_control_panel_applet(self, applet):
        # globals: os, cxutils, __import__
        # attributes: path, join, CX_ROOT, lower, endswith, name, append, start, run
        # strings: 'bin', 'wine', '.exe', '--bottle', '--wl-app', 'wineboot.exe', '--restart', '.cpl', 'rundll32', 'shell32.dll,Control_RunDLL'
        ...

    @cxobjc.namedSelector(b'loadApplicationInfo')
    def load_application_info(self):
        # globals: LoadApplicationInfoOperation, pyop
        # attributes: installed_packages_ready, installed_packages_loading, sharedOperationQueue, enqueue
        ...

    @cxobjc.namedSelector(b'fileIsInBottle:')
    def file_is_in_bottle(self, filename):
        # globals: os
        # attributes: path, abspath, realpath, system_drive, startswith
        ...

    @cxobjc.namedSelector(b'writeDescription')
    def write_description(self):
        # attributes: get_config_value, current_description, set_config_value
        # strings: 'Bottle', 'Description', ''
        ...

    @cxobjc.python_method
    def wait_for_shutdown(self):
        """Wait a bit for for the bottle to truly shut down after calling quit"""
        # globals: range, bottlemanagement, time
        # attributes: can_force_quit, is_running, name, sleep
        ...

    @cxobjc.namedSelector(b'delete:')
    def delete(self, callback=None):
        # attributes: suspend, quit
        def quit_callback():
            # globals: DeleteBottleOperation, pyop
            # attributes: sharedOperationQueue, enqueue
            ...

        ...

    @cxobjc.namedSelector(b'rename:completionHandler:')
    def rename(self, new_name, callback=None):
        # attributes: suspend, quit
        def quit_callback():
            # globals: RenameBottleOperation, pyop
            # attributes: sharedOperationQueue, enqueue
            ...

        ...

    @cxobjc.namedSelector(b'addChangeDelegate:')
    def add_change_delegate(self, delegate):
        # attributes: _change_delegates, append
        ...

    @cxobjc.namedSelector(b'removeChangeDelegate:')
    def remove_change_delegate(self, delegate):
        # attributes: _change_delegates, remove
        ...

    @cxobjc.namedSelector(b'addStatusOverride:')
    def add_status_override(self, status):
        # attributes: status_overrides, append, status, bottle_changed
        ...

    @cxobjc.namedSelector(b'removeAllStatusOverrides:')
    def remove_all_status_overrides(self, status):
        # attributes: status_overrides, remove_status_override
        ...

    @cxobjc.namedSelector(b'removeStatusOverride:')
    def remove_status_override(self, status):
        # globals: len, BottleWrapper
        # attributes: status_overrides, remove, status, installed_packages_ready, control_panel_ready, STATUS_INIT, STATUS_READY, bottle_changed
        ...

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
    @cxobjc.namedSelector(b'quit:')
    def quit(self, callback=None):
        # globals: QuitBottleOperation, pyop
        # attributes: sharedOperationQueue, enqueue
        ...

    @cxobjc.namedSelector(b'forceQuit:')
    def force_quit(self, callback=None):
        # globals: ForceQuitBottleOperation, pyop
        # attributes: sharedOperationQueue, enqueue
        ...

    def get_display_name(self):
        # globals: _
        # attributes: is_default, name
        # strings: '%s (default)'
        ...

    display_name = property(get_display_name)
    displayName = cxobjc.object_property(read_only=True, getter=get_display_name, depends_on=['name', 'is_default'])
    @cxobjc.python_method
    def get_windows_version_display_name(self):
        # globals: bottlequery, _
        # attributes: get_windows_version_name, windows_version, arch
        # strings: 'win32', '%(version)s 32-bit (deprecated)', 'version'
        ...

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
    @cxobjc.namedSelector(b'getMissingDependenciesProfile')
    def get_missing_dependencies_profile(self):
        # attributes: profile, copy, app_profile, flags, add, steamid
        # strings: 'virtual'
        ...

    def bottleName(self):
        # attributes: name
        ...

    @cxobjc.python_method
    def callback(self, name, *args):
        """Perform a callback in the main UI"""
        # globals: getattr
        # attributes: _change_delegates
        def do_nothing(*_args, **_kwargs):
            ...

        ...


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
