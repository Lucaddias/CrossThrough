# cxurlget_nsurl — reconstructed outline of CrossOver 26.3 lib/python/cxurlget_nsurl.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import threading
import Foundation
import objc
import cxurlget_base
_NSURLSessionDelegate = objc.protocolNamed('NSURLSessionDelegate')
_NSURLSessionTaskDelegate = objc.protocolNamed('NSURLSessionTaskDelegate')
_NSURLSessionDataDelegate = objc.protocolNamed('NSURLSessionDataDelegate')
NSURLSessionResponseCancel = Foundation.NSURLSessionResponseCancel
NSURLSessionResponseAllow = Foundation.NSURLSessionResponseAllow
NSURLSessionResponseBecomeDownload = Foundation.NSURLSessionResponseBecomeDownload
NSURLSessionResponseBecomeStream = Foundation.NSURLSessionResponseBecomeStream
class _UrlGetterDelegate(Foundation.NSObject):
    __pyobjc_protocols__ = [_NSURLSessionDelegate, _NSURLSessionTaskDelegate, _NSURLSessionDataDelegate]
    def initWithOwner_(self, owner):
        # globals: objc, _UrlGetterDelegate
        # attributes: super, init, owner
        ...

    def URLSession_didBecomeInvalidWithError_(self, _session, _error):
        # attributes: owner, event, set
        ...

    def URLSession_task_didCompleteWithError_(self, _session, _task, error):
        # globals: cxurlget_base, Exception
        # attributes: owner, notify_failed, UrlError, localizedDescription, finished, notify_finished, event, set, exception
        ...

    def URLSession_dataTask_didReceiveResponse_completionHandler_(self, _session, _dataTask, response, completionHandler):
        # globals: isinstance, Foundation, NSURLSessionResponseAllow, cxurlget_base, NSURLSessionResponseCancel, str, Exception
        # attributes: NSHTTPURLResponse, statusCode, owner, notify_failed, HttpError, localizedStringForStatusCode_, event, set, allHeaderFields, objectForKey_, last_modified, etag, expectedContentLength, NSURLResponseUnknownLength, bytes_total, suggestedFilename, basename, notify_progress, StopDownload
        # strings: 'Last-Modified', 'ETag', 'unknown'
        ...

    def URLSession_dataTask_didReceiveData_(self, _session, dataTask, data):
        # globals: len, Exception, isinstance, cxurlget_base
        # attributes: owner, outfile, write, bytes_downloaded, notify_progress, StopDownload, notify_failed, cancel, event, set
        ...


class UrlGetter(cxurlget_base.UrlGetterBase):
    @classmethod
    def make_cookie_storage(cls):
        # globals: Foundation
        # attributes: NSURLSessionConfiguration, ephemeralSessionConfiguration, HTTPCookieStorage
        ...

    def __init__(self, *args, **kwargs):
        # globals: cxurlget_base
        # attributes: UrlGetterBase, __init__
        ...

    def fetch(self):
        # globals: threading, Foundation, _UrlGetterDelegate
        # attributes: Event, event, exception, NSURLSessionConfiguration, ephemeralSessionConfiguration, timeout, setTimeoutIntervalForResource_, cookie_storage, setHTTPCookieStorage_, setHTTPAdditionalHeaders_, user_agent, alloc, initWithOwner_, NSURLSession, sessionWithConfiguration_delegate_delegateQueue_, NSURL, URLWithString_, url, NSMutableURLRequest, initWithURL_, setHTTPMethod_, verb, data, setHTTPBody_, dataTaskWithRequest_, resume, wait, invalidateAndCancel, outfile, close
        # strings: '*/*'
        ...
