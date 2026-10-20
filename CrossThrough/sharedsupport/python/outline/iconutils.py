# iconutils — reconstructed outline of CrossOver 26.3 lib/python/iconutils.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import cxobjc
import cxproduct
import cxurlget
import cxutils
import os
import json
import shutil
import tempfile
class IconUtils(cxobjc.Proxy):
    url = 'https://www.codeweavers.com/bin/rest/app/img_icon'
    def __init__(self):
        # globals: cxobjc
        # attributes: Proxy, __init__, icon_list, failed
        ...

    def init(self):
        # globals: cxobjc
        # attributes: Proxy, nsobject_init, __init__
        ...

    @cxobjc.namedSelector(b'getIconPath:')
    def get_icon_path(self, appid):
        # globals: os, cxproduct
        # attributes: icon_list, get, path, join, get_icons_dir
        # strings: 'sha1'
        ...

    @cxobjc.namedSelector(b'fetchIconList')
    def fetch_icon_list(self):
        # globals: cxurlget, json, cxutils, Exception
        # attributes: fetch_content, url, loads, string_to_unicode, icon_list, get
        # strings: 'com.codeweavers.c4.%s', 'app_id', ''
        ...

    @cxobjc.python_method
    def urlgetter_failed(self, _urlgetter, _exception):
        # attributes: failed
        ...

    @cxobjc.namedSelector(b'fetchIcon:')
    def fetch_icon(self, appid):
        # globals: cxproduct, cxutils, os, tempfile, cxurlget, shutil
        # attributes: icon_list, get_icons_dir, mkdirs, get_icon_path, path, exists, failed, mkstemp, fdopen, get, UrlGetter, urlgetter_failed, fetch, unlink, move
        # strings: 'local.tmp.', 'wb', 'img_icon'
        ...
