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

create_token = <function create_token>()
update_compatdb = <function update_compatdb>()
