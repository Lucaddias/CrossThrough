# demoutils — reconstructed outline of CrossOver 26.3 lib/python/demoutils.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import stat
import cxlog
import distversion
import hashlib
from urllib.request import request as urllib_request
from urllib.error import error as urllib_error
import cxobjc
import proxyinfo
import cxutils
import cxconfig
import fileupdate
from cxutils import cxgettext as _
class DemoUtils(cxobjc.Proxy):
    pass

demo_status = <function demo_status>()
def can_register_as_current_user(licenseDir):
    """Returns True if we have current permission to register. Return
False if we need to authenticate as root before registering.
"""
    # globals: os
    # attributes: path, join, exists, access, W_OK, dirname
    # strings: 'license.txt', 'license.sha256', 'license.sig'
    ...

serial_reg_url = <function serial_reg_url>()
reg_license_url = <function reg_license_url>()
def json_format_start():
    # strings: '{'
    ...

def json_format(key, value):
    # strings: '"', '":"', '",'
    ...

def json_format_end(key, value):
    # strings: '"', '":"', '"}'
    ...

create_account_request_body_for_email_name_password_with_serial_code = <function create_account_request_body_for_email_name_password_with_serial_code>()
checkSerialCodeRegistrationResponse = <function checkSerialCodeRegistrationResponse>()
splitLicenseAndSigFromBuffer = <function splitLicenseAndSigFromBuffer>()
lastResort = <function lastResort>()
def lastResortErroneous():
    # globals: _
    # strings: 'If you believe this is in error, contact CodeWeavers sales support at sales@codeweavers.com.'
    ...

checkLicenseDownload = <function checkLicenseDownload>()
def create_acct_apply_scode(login, password, username, serialcode):
    # globals: create_account_request_body_for_email_name_password_with_serial_code, serial_reg_url, proxyinfo, urllib_request, cxutils, checkSerialCodeRegistrationResponse, urllib_error, _, lastResort, cxlog
    # attributes: install_default_opener, Request, urlopen, string_to_str, read, URLError, warn
    # strings: 'Mozilla/5.0 (like Gecko) CrossOver', 'User-Agent', 'Registration failed', '\n\n', 'registration failed: %s'
    ...

def download_and_split_license_file(login, password):
    """Attempt to download a license file and drop it into the appropriate dir.
Returns licensefile, sigfile, errorstring where filename will be None
if the download failed. Otherwise licensefile and sigfile are temporary
files; it is the caller's responsibility to test, move, and/or delete
them.
"""
    # globals: reg_license_url, proxyinfo, urllib_request, checkLicenseDownload, splitLicenseAndSigFromBuffer, _, lastResort, urllib_error
    # attributes: install_default_opener, urlopen, read, URLError
    # strings: 'The license file download is corrupt.\n\n', 'Download failed.\n\n'
    ...

def register(login, password):
    """Perform the entire registration process"""
    # globals: download_and_split_license_file, demo_status, _, os, cxutils, can_register_as_current_user
    # attributes: remove, path, join, CX_ROOT, extend, run, GRAB
    # strings: 'Unable to download a valid license file.', 'Your support contract is not valid for this product. You may need to purchase a support extension or an additional l..., 'etc', 'bin', 'cxsu', '--ignore-home', 'cxregister', '--install', 'Registration failed'
    ...
