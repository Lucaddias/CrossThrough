# proxyinfo — reconstructed outline of CrossOver 26.3 lib/python/proxyinfo.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import traceback
import sys
from urllib.request import request as urllib2
import cxlog
import cxproduct
import cxutils
import distversion
_DESKTOP_ENVIRONMENT = None
def get_desktop_environment():
    """Returns the name of the currently running desktop environment."""
    # globals: _DESKTOP_ENVIRONMENT, cxutils, cxproduct, distversion, os, cxlog, Exception, str
    # attributes: CX_ROOT, get_config, get, IS_MACOSX, environ, DBusProxy, new_for_bus_sync, BusType, SESSION, DBusProxyFlags, NONE, call_sync, Variant, new_tuple, new_string, DBusCallFlags, log
    # strings: 'unknown', 'CrossOver', 'ManualProxySettings', '0', '1', 'config', 'macosx', 'GNOME_DESKTOP_SESSION_ID', 'gnome', 'KDE_FULL_SESSION', 'kde', 'org.freedesktop.DBus', '/org/freedesktop/DBus', 'NameHasOwner', 'Found desktop environment: %s', 'could not connect to D-Bus: %s\n'
    ...

_USE_LIBPROXY = False
_LIBPROXY_FACTORY = None
def get_libproxy_factory():
    """Detects whether libproxy is available and sets it up."""
    # globals: _USE_LIBPROXY, _LIBPROXY_FACTORY, Exception, cxlog, str
    # attributes: ProxyFactory, log
    # strings: 'could not load libproxy: %s\n'
    ...

def has_libproxy():
    """Returns True if libproxy support is available."""
    # globals: get_libproxy_factory
    ...

def get_proxy_libproxy(req):
    """Returns the default proxy to use for the specified URL."""
    # globals: get_libproxy_factory
    # attributes: getProxies, get_full_url
    # strings: 'direct://', ''
    ...

def get_proxy_gconf(req):
    """Detects GNOME's proxy settings using GConf."""
    # globals: ImportError
    # attributes: Client, get_default, type, get_bool, get_string, get_int
    # strings: 'https', 'secure', 'http', '/system/http_proxy/use_http_proxy', '', '/system/http_proxy/host', '/system/http_proxy/port', '/system/proxy/mode', 'none', '/system/proxy/%s_host', '/system/proxy/%s_port', '/system/http_proxy/use_authentication', '/system/http_proxy/authentication_user', '/system/http_proxy/authentication_password', ':', '@'
    ...

def get_proxy_gsettings(req):
    """Detects GNOME's proxy settings using gsettings."""
    # globals: cxutils
    # attributes: run, GRAB, rstrip, replace, type
    # strings: 'which', 'gsettings', '', 'org.gnome.system.proxy', 'get', 'mode', "'", 'none', 'org.gnome.system.proxy.', 'host', 'port', ':'
    ...

_HAS_KDE = None
def _init_kde():
    """Initializes the KDE environment so we can query its proxy settings."""
    # globals: _HAS_KDE, Exception, cxlog, str
    # attributes: Qt, QApplication, log
    # strings: 'could not initialize the KDE 4 libraries: %s\n'
    ...

def get_proxy_kde_int(config, name):
    """Helper for get_proxy_kde(). Retrieves the value of an integer KDE
property.
"""
    # globals: int
    # attributes: readEntry
    # strings: ''
    ...

def get_proxy_kde(req):
    """Detects KDE's proxy settings using PyQT4 and PyKDE4."""
    # globals: _HAS_KDE, get_proxy_kde_int, cxlog, str
    # attributes: kdecore, KConfig, group, warn, readEntry, type, replace, startswith
    # strings: 'kioslaverc', 'Proxy Settings', 'ProxyType', '', 'Cannot handle KDE proxy of type %d; using environment instead of KDE settings', 'NoProxyFor', 'ReversedException', 'false', 'Cannot handle proxy exceptions; ignoring them', 'Cannot handle proxy exceptions; using environment instead of KDE settings', 'AuthMode', "Don't know how to read KDE proxy authorization; using environment instead of KDE settings", 'Proxy', ' ', ':', '//:'
    ...

def get_proxy_env(req):
    """Detects the environment's proxy settings."""
    # globals: os
    # attributes: environ, get, type
    # strings: '_proxy', ''
    ...

def get_proxy_conf(req):
    """Reads proxy settings from the configuration."""
    # globals: cxproduct
    # attributes: get_config, get, type
    # strings: 'CrossOver', 'Proxy', ''
    ...

class DynamicProxyHandler(urllib2.ProxyHandler):
    """A proxy handler that dynamically detects the proxy settings each time
it is queried so it can react to proxy configuration changes.
"""
    handler_order = 100
    _PROXY_DETECTORS = {'gnome': (get_proxy_gconf, get_proxy_gsettings, get_proxy_env), 'kde': (get_proxy_kde, get_proxy_env), 'xfce': (get_proxy_gconf, get_proxy_env), 'macosx': (get_proxy_env,), 'unknown': (get_proxy_env,), 'config': (get_proxy_conf,)}
    def __init__(self):
        # globals: urllib2, has_libproxy, get_proxy_libproxy, get_desktop_environment
        # attributes: ProxyHandler, __init__, _detectors, _PROXY_DETECTORS
        ...

    def get_proxy(self, req):
        # globals: cxlog, traceback
        # attributes: _detectors, log, warn, format_exc
        # strings: 'Proxy settings detected.  Network communication will be attempted via proxy.\n', 'Could not get the proxy info:\n%s'
        ...

    def do_open(self, req):
        # attributes: get_proxy, proxy_open, type
        ...

    def ftp_open(self, req):
        # attributes: do_open
        ...

    def http_open(self, req):
        # attributes: do_open
        ...

    def https_open(self, req):
        # attributes: do_open
        ...

    def socks_open(self, req):
        # attributes: do_open
        ...


def install_default_opener():
    """Sets up a default opener that auto-detects the current proxy settings."""
    # globals: DynamicProxyHandler, urllib2
    # attributes: build_opener, install_opener
    ...

def _init():
    """Performs the initialization tasks that must be performed at startup."""
    # globals: has_libproxy, get_desktop_environment, _init_kde
    # strings: 'kde'
    ...

# if not __name__ == '__main__' ... (offset 218-360)
cxutils.CX_ROOT = os.path.join(os.path.dirname(sys.argv[0]), '../..')
_init()
def main():
    # globals: print, get_desktop_environment, DynamicProxyHandler, sys, urllib2
    # attributes: stdin, readline, get_proxy, Request
    # strings: 'Desktop environment: ', 'Hit Enter to refresh, Ctrl-D to quit', ' -> [', '://codeweavers.com', ']'
    ...

# if not __name__ == '__main__' ... (offset 392-408)
main()
