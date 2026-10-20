# cxurlget_base — reconstructed outline of CrossOver 26.3 lib/python/cxurlget_base.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

from urllib.request import request as urllib
from urllib.parse import urlencode
import cxutils
USER_AGENT = 'Mozilla/5.0 (like Gecko) CrossOver'
_WEEKDAY_NAMES = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
_MONTH_NAMES = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
def format_http_date(date_time):
    """Converts a datetime object to an RFC-1123-compliant string for
use in HTTP headers. Note that this does not rely on strftime() to avoid
locale issues.
"""
    # globals: _WEEKDAY_NAMES, _MONTH_NAMES
    # attributes: weekday, day, month, year, hour, minute, second
    # strings: '%s, %02d %s %04d %02d:%02d:%02d UTC'
    ...

def url_to_basename(url):
    # globals: len, urllib
    # attributes: split, rsplit, url2pathname
    # strings: '#', '?', '/', 'download', '.'
    ...

def url_to_sanitized_basename(url):
    # globals: cxutils, url_to_basename
    # attributes: sanitize_windows_filename
    ...

class StopDownload(Exception):
    """Stops the download if raised from a notify_headers or notify_progress
handler.
"""

class UrlError(Exception):
    """Base class for errors raised by UrlGetter."""
    reason = ''
    def __init__(self, reason):
        # globals: Exception
        # attributes: __init__, reason
        ...

    def __str__(self):
        # globals: str
        # attributes: reason
        ...

    def __repr__(self):
        # globals: repr
        # attributes: reason
        # strings: 'cxurlget.UrlError(%s)'
        ...


class HttpError(UrlError):
    """Exception class for error responses from an HTTP server."""
    code = 0
    def __init__(self, code, reason):
        # globals: UrlError
        # attributes: __init__, code
        ...

    def __str__(self):
        # attributes: code, reason
        # strings: ': '
        ...

    def __repr__(self):
        # globals: repr
        # attributes: code, reason
        # strings: 'cxurlget.HttpError(', ', ', ')'
        ...


class UrlGetterBase:
    bytes_downloaded = 0
    bytes_total = -1
    last_modified = None
    etag = None
    try_count = 0
    finished = False
    url = ''
    basename = ''
    outfile = None
    infile = None
    notify_progress = None
    notify_finished = None
    notify_failed = None
    content_encoding = None
    decoding_event = None
    decoding_exception = None
    blocksize = 4096
    make_cookie_storage = <function UrlGetterBase.make_cookie_storage>()
    def _do_nothing(self, *args):
        ...

    def __init__(self, url, outfile, notify_progress=_do_nothing, notify_finished=_do_nothing, notify_failed=_do_nothing, notify_headers=_do_nothing, user_agent=USER_AGENT, last_modified=None, etag=None, verb=None, data=None, timeout=None, cookie_storage=None):
        # globals: url_to_sanitized_basename, hasattr, open, isinstance, dict, urlencode
        # attributes: split, url, user_agent, last_modified, etag, basename, outfile, notify_headers, notify_progress, notify_finished, notify_failed, timeout, cookie_storage, userdata, verb, encode, data
        # strings: '#', 'write', 'wb', 'GET', 'POST', 'ascii'
        ...

    def fetch(self):
        # globals: NotImplementedError
        ...

    def flush(self):
        """Ensures the on-disk file contains an up-to-date view of the download
in progress. This method must not be called after the download has
completed."""
        # attributes: outfile, flush
        ...
