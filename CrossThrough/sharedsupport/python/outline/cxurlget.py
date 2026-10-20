# cxurlget — reconstructed outline of CrossOver 26.3 lib/python/cxurlget.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import io
import sys
import distversion
from cxurlget_base import StopDownload
from cxurlget_base import USER_AGENT
from cxurlget_base import UrlGetterBase
from cxurlget_base import url_to_basename
from cxurlget_base import url_to_sanitized_basename
from cxurlget_base import format_http_date
from cxurlget_base import UrlError
from cxurlget_base import HttpError
UrlGetter = None
# if not distversion.IS_MACOSX ... (offset 104-118)
from cxurlget_nsurl import UrlGetter
from cxurlget_urllib import UrlGetter
class _FetchContentHandler:
    exception = None
    def __init__(self):
        # globals: io
        # attributes: exception, BytesIO, bytesio, BufferedWriter, writer
        ...

    def write(self, data):
        # attributes: writer, write
        ...

    def notify_failed(self, _urlgetter, exception):
        # attributes: exception
        ...

    def close(self):
        # attributes: writer, flush
        ...

    def flush(self):
        # attributes: writer, flush
        ...


def fetch_content(url, **kwargs):
    """Fetches a url with UrlGetter and returns it as a bytes object.

Any keyword arguments passed in will be forwarded to the UrlGetter
constructor, except for notify_failed and outfile.

Returns a bytes object containing the content.

Raises an exception on failure."""
    # globals: _FetchContentHandler, UrlGetter
    # attributes: notify_failed, fetch, exception, bytesio, getvalue
    # strings: 'notify_failed'
    ...

__all__ = ['StopDownload', 'USER_AGENT', 'UrlGetterBase', 'url_to_basename', 'url_to_sanitized_basename', 'format_http_date', 'UrlGetter', 'UrlError', 'HttpError', 'fetch_content']
def main():
    # globals: len, sys, isinstance, bytes, UrlGetter, print
    # attributes: argv, encode, fetch, basename
    # strings: 'utf8', 'Suggested basename: %s'
    def notify_progress(urlgetter):
        # globals: sys
        # attributes: stdout, write, bytes_downloaded, bytes_total, flush
        # strings: '\r%d/%d bytes (%.1f%%)'
        ...

    def notify_finished(_urlgetter):
        # globals: print
        # strings: '\nSuccess.'
        ...

    def notify_failed(_urlgetter, exception):
        # globals: print, repr, str
        # strings: '\nFailure.', 'Exception: %s', 'Message: %s'
        ...

    ...

# if not __name__ == '__main__' ... (offset 182-198)
main()
