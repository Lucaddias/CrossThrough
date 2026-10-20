# cxhtmlutils — reconstructed outline of CrossOver 26.3 lib/python/cxhtmlutils.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import re
import sys
import cxutils
_REFRESH_RE = re.compile(b'http-equiv\\s*=\\s*["\']?refresh["\']?', re.IGNORECASE)
_CONTENT_RE = re.compile(b'content\\s*=\\s*(?P<quote>["\'])(?P<content>.*?)(?P=quote)', re.IGNORECASE)
_CONTENT_DELAY_RE = re.compile('^(?P<delay>[0-9]*)(?:\\s*;|\\s+|$)')
_CONTENT_PREFIX_RE = re.compile('^url\\s*=\\s*', re.IGNORECASE)
_CONTENT_URL_RE = re.compile('^["\\\']?\\s*(?P<url>[^"\\\']*[^ "\\\'])')
def parse_meta_refresh(meta):
    """Given a <meta ... /> tag string, returns a (match, delay, url) triplet.
match - True if the string is an http-equiv=refresh <meta> tag.
delay - None if the content field is invalid, and the delay in second
        before the redirect happens otherwise.
url   - None if no URL was specified (reload the same page), and the
        URL to load otherwise.
"""
    # globals: _REFRESH_RE, _CONTENT_RE, cxutils, _CONTENT_DELAY_RE, int, _CONTENT_PREFIX_RE, _CONTENT_URL_RE
    # attributes: search, unescape, string_to_unicode, group, lstrip, end
    # strings: 'content', 'delay', '', 'url'
    ...

_HTML_RE = re.compile(b'<(?:!doctype html|html|meta|p|script|title|\\?xml)[ >]', re.IGNORECASE)
_BODY_RE = re.compile(b'<body[ >]', re.IGNORECASE)
_META_RE = re.compile(b'<meta (?P<attrs>[^>]+)>', re.IGNORECASE)
def is_html(filename, size):
    """Checks whether the specified file is an html file, or similar, and if
it is, whether it redirects us elsewhere.

The redirect value can be one of:
False - If the page does not contain a redirect.
True  - If the page implicitly redirects to itself.
A url - If the page explicitly specifies the target URL.
None  - If we do not know if the page contains a redirect, typically
        because we don't have the full file yet.
"""
    # globals: open, _HTML_RE, _META_RE, parse_meta_refresh, _BODY_RE
    # attributes: read, search, finditer, group
    # strings: 'rb', 'attrs'
    ...

def test_meta_refresh(fmt, delay, url):
    # globals: parse_meta_refresh, cxutils, print, sys
    # attributes: replace, string_to_utf8, exit
    # strings: '&', '&amp;', "'", '"', "http-equiv='refresh' content=", 'content=[%s]', ' -> match=', ' delay=[', '] url=[', ']', '', '*** failed to match ***', '*** bad delay ***', '*** bad url ***'
    ...

def main():
    # globals: test_meta_refresh
    # strings: '%s', '%s;', ' %s ; ', '2a', '2a;', 'http://www.codeweavers.com', 'http://www.codeweavers.com;', '%s;%s', '%s;url=%s', '%s;URL=%s', ' %s ;  %s ', ' %s ; url = %s ', ' %s %s ', '  http://www.codeweavers.com', '  url=http://www.codeweavers.com', "%s;url='%s'", '%s;url="%s"', "%s ; url = ' %s ' ", '%s; %s ', 'http://www.codeweavers.com/?param=1;2', '%s %s ', '%s; url=%s', 'https://www.codeweavers.com/path/1.2/File.exe?p1=&p2=1234&p3=whitequeen', 'http://www.codeweavers.com/?param=1;2 3', ';%s', ' ; %s ', ";url='%s'"
    ...

# if not __name__ == '__main__' ... (offset 482-498)
main()
