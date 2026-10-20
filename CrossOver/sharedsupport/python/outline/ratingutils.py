# ratingutils — reconstructed outline of CrossOver 26.3 lib/python/ratingutils.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import cxlog
import cxobjc
import cxproduct
import cxurlget
import cxutils
import distversion
import proxyinfo
import systeminfo
import webutils
import json
from urllib.parse import urlencode
def get_platform():
    """Put the platform in the right format for the REST API. We submit
ratings from Chrome OS as "Android" for historical reasons"""
    # globals: cxproduct, distversion
    # attributes: is_crostini, PLATFORM
    # strings: 'Android'
    ...

class RatingUtils(cxobjc.Proxy):
    def __init__(self, bottle, appid):
        # globals: cxobjc
        # attributes: Proxy, __init__, url, login_required, connection_failed, token, rating, notes, name
        # strings: 'https://www.codeweavers.com/bin/rest/rank/'
        ...

    def initWithAppID_(self, appid):
        # globals: cxobjc
        # attributes: Proxy, nsobject_init, __init__
        # strings: ''
        ...

    get_rating = <function RatingUtils.get_rating>()
    set_rating = <function RatingUtils.set_rating>()
