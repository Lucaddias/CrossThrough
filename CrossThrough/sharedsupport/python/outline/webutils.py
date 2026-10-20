# webutils — reconstructed outline of CrossOver 26.3 lib/python/webutils.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import cxlog
import cxobjc
import cxproduct
import cxurlget
import cxutils
import distversion
import fileupdate
import proxyinfo
import hashlib
import json
import os
from urllib.parse import urlencode
class WebUtils(cxobjc.Proxy):
    pass

def get_version():
    """Put the version number in the right format for the REST API"""
    # globals: distversion
    # attributes: join, CX_VERSION, split
    # strings: '.'
    ...

def get_token():
    # globals: cxproduct
    # attributes: get_config_string, get_config, get, set_config_string
    # strings: 'CrossOver', 'Token'
    ...

@cxobjc.method(WebUtils, 'createToken_password_')
def create_token(login, password):
    # globals: hashlib, cxutils, proxyinfo, cxurlget, json, cxproduct, cxlog
    # attributes: md5, update, string_to_utf8, hexdigest, install_default_opener, fetch_content, loads, string_to_unicode, set_config_string, UrlError, log, reason
    # strings: 'https://www.codeweavers.com/bin/rest/create_token', 'CrossOver', 'Token'
    ...

@cxobjc.method(WebUtils, 'updateCompatDB')
def update_compatdb():
    # globals: get_version, os, cxproduct, urlencode, fileupdate
    # attributes: split, path, join, get_user_dir, update
    # strings: '.', 'compatdb-', '.dat', 'https://www.codeweavers.com/bin/rest/compatdb', 'version', '?'
    ...
