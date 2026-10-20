# systeminfo — reconstructed outline of CrossOver 26.3 lib/python/systeminfo.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import struct
import cxdiag
import cxobjc
import cxutils
import distversion
class SystemInfo(cxobjc.Proxy):
    pass

def get_bottle_information(bottle):
    # globals: str
    # attributes: graphics_backend_state, vulkan_backend_state, is_dlss_enabled_state, is_high_resolution_enabled_state, is_msync_enabled_state, is_preview_enabled_state, name, template, windows_version, is_managed, arch, update, strip, split
    ...

def get_system_information(bottle=None, include_cxdiag=False):
    """Put the system information in a dictionary so we can store it in JSON format."""
    # globals: get_bottle_information, distversion, cxutils, struct, os, hasattr, open, cxdiag, ImportError
    # attributes: PRODUCT_NAME, PUBLIC_VERSION, CX_ROOT, calcsize, environ, get, Screen, get_default, get_window_manager_name, path, exists, strip, partition, run, GRAB, splitlines, warnings, properties, libs
    # strings: 'Bottle', 'Product', 'Version', 'Install location', '%s-bit', 'P', 'Bitness', 'DESKTOP_SESSION', '', 'Desktop session', 'get_window_manager_name', 'Window manager', 'Locale', 'LANG', 'System Information', 'r', 'utf8', 'surrogateescape', '=', '"', ':', 'Warnings', 'Properties', 'Libraries'
    ...

system_info_string = <function system_info_string>()
_system_info_string_for_bottle = <function _system_info_string_for_bottle>()
