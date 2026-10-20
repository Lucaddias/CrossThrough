# cxurlget_urllib — reconstructed outline of CrossOver 26.3 lib/python/cxurlget_urllib.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import errno
import ftplib
import gzip
from http.cookiejar import cookiejar as cookielib
import os
import socket
import threading
import traceback
import time
from urllib.request import request as urllib2
from urllib.parse import parse as urlparse
from urllib.error import error as urllib_error
import proxyinfo
import cxlog
import cxurlget_base
proxyinfo.install_default_opener()
def _get_rfc822_value(string):
    # attributes: startswith, split, append, join
    # strings: '"', ''
    def is_token_breaker(c):
        # globals: ord
        # strings: ' ()<>@,;:\\"/[]?='
        ...

    ...

def wrap_exception(exception):
    # globals: isinstance, urllib_error, cxurlget_base
    # attributes: HTTPError, HttpError, code, reason, URLError, UrlError
    ...

class DownloadError(Exception):
    pass

class UrlGetter(cxurlget_base.UrlGetterBase):
    make_cookie_storage = <function UrlGetter.make_cookie_storage>()
    def __init__(self, *args, **kwargs):
        # globals: cxurlget_base, urllib2
        # attributes: pop, opener, UrlGetterBase, __init__, cookie_storage, HTTPCookieProcessor, add_handler, build_opener
        # strings: 'opener'
        ...

    getfield = <function UrlGetter.getfield>()
    def _gzip_decoding_thread(self, infile, outfile):
        # globals: gzip, Exception, cxlog, traceback
        # attributes: GzipFile, read, write, close, decoding_event, set, log, to_str, url, format_exc, decoding_exception
        # strings: 'rb', 'failed to decode gzip data from ', ':\n'
        ...

    def _setup_gzip_decoding(self):
        # globals: os, threading
        # attributes: pipe, fdopen, outfile, Event, decoding_event, Thread, _gzip_decoding_thread, start
        # strings: 'rb', 'wb'
        ...

    def _analyze_headers(self, headers):
        # globals: int, NotImplementedError, urlparse, ftplib, cxurlget_base, _get_rfc822_value, Exception, cxlog, traceback
        # attributes: getfield, bytes_total, last_modified, etag, content_encoding, notify_headers, infile, geturl, _setup_gzip_decoding, urlparse, url, scheme, FTP, netloc, login, size, path, close, get, split, url_to_sanitized_basename, basename, log, to_str, format_exc
        # strings: 'content-length', '-1', 'Last-Modified', 'ETag', 'Content-Encoding', 'identity', 'gzip', 'Unsupported Content-Encoding: %s', 'ftp', '', 'filename=', 'content-disposition', 'failed to read size of url ', ':\n'
        ...

    def _fetch_chunk(self, start_time, start=0, end=-1):
        # globals: cxlog, urllib2, int, DownloadError, len, time
        # attributes: log, to_str, url, Request, data, add_header, user_agent, content_encoding, last_modified, add_unredirected_header, etag, opener, open, timeout, infile, urlopen, info, try_count, _analyze_headers, getfield, bytes_downloaded, bytes_total, notify_progress, read, blocksize, outfile, write, finished, time, notify_finished
        # strings: 'fetching url %s from %d to %d', 'Accept', '*/*', 'User-Agent', 'bytes=%d-', '%d', 'Range', 'identity', 'Accept-Encoding', '%s, *;q=0', 'If-Modified-Since', 'If-None-Match', 'gzip', 'content-length', '-1', 'Download size changed from %d to %d', 'Content-Encoding', 'Server changed encoding from ', ' to ', 'expected to download %i bytes, got %i', 'fetched url %s (%i bytes) in %0.3fs\n'
        ...

    def fetch(self):
        # globals: DownloadError, time, socket, cxlog, repr, errno, cxurlget_base, urllib_error, traceback, wrap_exception, Exception
        # attributes: infile, time, finished, bytes_downloaded, _fetch_chunk, close, try_count, outfile, content_encoding, decoding_event, wait, decoding_exception, error, log, errno, ECONNRESET, StopDownload, HTTPError, code, to_str, url, format_exc, notify_failed
        # strings: 'fetch() has already been called', 'gzip', 'caught %s last_position=%s bytes_downloaded=%d', '%s has not changed (%0.3fs)', 'failed to fetch url %s (%0.3fs):\n%s'
        ...
