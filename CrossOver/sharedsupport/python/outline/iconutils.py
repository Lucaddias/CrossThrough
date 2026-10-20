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

    get_icon_path = <function IconUtils.get_icon_path>()
    fetch_icon_list = <function IconUtils.fetch_icon_list>()
    urlgetter_failed = <function IconUtils.urlgetter_failed>()
    fetch_icon = <function IconUtils.fetch_icon>()
