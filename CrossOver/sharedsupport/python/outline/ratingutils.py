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

    @cxobjc.namedSelector(b'fetchRating')
    def get_rating(self):
        # globals: webutils, proxyinfo, get_platform, cxlog, urlencode, cxurlget, json, cxutils, isinstance, dict, int
        # attributes: login_required, connection_failed, get_token, token, install_default_opener, get_version, log, url, fetch_content, loads, string_to_unicode, get, notes, name, rating, HttpError, code, reason, UrlError, warn
        # strings: 'Obtaining a rating with arguments:', 'token', '?', 'Obtained rating data:', 'rank_notes', 'name', 'medal_id'
        ...

    @cxobjc.namedSelector(b'setRating:Notes:')
    def set_rating(self, rating, notes):
        # globals: webutils, proxyinfo, get_platform, json, systeminfo, cxlog, cxurlget
        # attributes: login_required, connection_failed, get_token, token, install_default_opener, get_version, dumps, get_system_information, log, fetch_content, url, HttpError, code, reason, warn, UrlError
        # strings: '', 'Submitting a rating:', 'token'
        ...
