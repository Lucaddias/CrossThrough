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

@cxobjc.method(DemoUtils, 'demoStatusForLicenseFile_andSig_')
def demo_status(licenseFile, sigFile):
    """Checks the demo-status of the install. Returns a 5-tuple.
The first item is a simple boolean:  True if we're in demo
mode, False if we aren't. The second item is a string which
will describe the account used to register the demo, if any.
The third entry is the expiration date of the license.
Fourth entry:  License ID
Fifth entry:  True if this license has been revoked
"""
    # globals: os, cxlog, fileupdate, cxconfig, distversion
    # attributes: path, exists, log, is_signed, get, DEMO_SKU, C4ProfilesSet, get_revoked_licenses, DATE
    # strings: 'Unable to locate license ', ' and/or signature ', '.\n', 'Signature ', ' for file ', ' is invalid.\n', 'customer', 'expires', 'license', 'id'
    ...

def can_register_as_current_user(licenseDir):
    """Returns True if we have current permission to register. Return
False if we need to authenticate as root before registering.
"""
    # globals: os
    # attributes: path, join, exists, access, W_OK, dirname
    # strings: 'license.txt', 'license.sha256', 'license.sig'
    ...

@cxobjc.method(DemoUtils, 'serialRegistrationURL')
def serial_reg_url():
    # strings: 'https://www.codeweavers.com/bin/serial'
    ...

@cxobjc.method(DemoUtils, 'licenseUrlForLogin_andPassword_')
def reg_license_url(login, password):
    # globals: hashlib, cxutils, distversion
    # attributes: md5, update, string_to_utf8, hexdigest, DEMO_EXTREP
    # strings: 'HTTPS://www.codeweavers.com/bin/register/', ';', ';lic;', ';md5;0;bom'
    ...

def json_format_start():
    # strings: '{'
    ...

def json_format(key, value):
    # strings: '"', '":"', '",'
    ...

def json_format_end(key, value):
    # strings: '"', '":"', '"}'
    ...

@cxobjc.method(DemoUtils, 'createAccountRequestBodyForEmail_name_andPassword_withSerialCode_')
def create_account_request_body_for_email_name_password_with_serial_code(email, name, password, serial):
    # globals: json_format_start, json_format, distversion, json_format_end, cxutils
    # attributes: CX_VERSION, string_to_utf8
    # strings: 'ver', '1', 'cxver', 'name', 'email', 'password', 'sub', '0', 'serial'
    ...

@cxobjc.method(DemoUtils, 'checkSerialCodeRegistrationResponse_')
def checkSerialCodeRegistrationResponse(responseBuffer):
    # globals: _, lastResort, lastResortErroneous
    # attributes: find
    # strings: 'OK', 'UNKNOWNSERIAL', 'CrossOver does not recognize this activation code.\n\nBe sure you have entered the activation code correctly.\n\n', 'WRONGPASSWORD', 'An account already exists for the email address which you have entered, but you have not provided the correct passwo..., ' ', 'BADEMAIL', 'The email address you have entered is not in a valid format. Please enter a valid email address.\n\n', 'SERIALREGISTERED', "The activation code you have entered has already been registered, and cannot be used again. Please click 'Take Me to..., 'EXPIRED', 'The activation code you have entered has expired and can no longer be used.', 'ERROR', 'The server has encountered an unknown error trying to create your account or register your activation code.\n\n', '\n', 'CrossOver has received an unrecognized response from the server while trying to create your account and register you...
    ...

@cxobjc.method(DemoUtils, 'splitLicenseAndSigFromBuffer_')
def splitLicenseAndSigFromBuffer(licenseBuffer_data):
    # globals: cxutils, fileupdate, cxlog, os, stat
    # attributes: string_to_utf8, save_data_and_sig, splitlines, log, remove, chmod, S_IRUSR, S_IWUSR, S_IRGRP, S_IROTH
    # strings: 'license.txt', 'The license file we downloaded has no signature, so is probably broken.'
    ...

@cxobjc.method(DemoUtils, 'lastResort')
def lastResort():
    # globals: _
    # strings: 'If this problem persists, contact CodeWeavers sales support at sales@codeweavers.com.'
    ...

def lastResortErroneous():
    # globals: _
    # strings: 'If you believe this is in error, contact CodeWeavers sales support at sales@codeweavers.com.'
    ...

@cxobjc.method(DemoUtils, 'checkLicenseDownload_')
def checkLicenseDownload(licenseBuffer_data):
    # globals: cxutils, _, distversion, lastResort
    # attributes: string_to_unicode, find, PRODUCT_NAME
    # strings: 'FILE NOT FOUND', 'Unable to locate a key for %(product)s.\n\n', 'product', 'USER EXPIRED', 'Your support period has expired. You are no longer entitled to product upgrades.\n\nVisit store.codeweavers.com to e..., 'USER NOT FOUND', 'BAD PASSWORD', 'Unable to validate your username and password.\n\nVisit www.codeweavers.com to make sure you have a valid login, and..., 'ERROR', 'An unknown error occurred while downloading your license file.\n\n'
    ...

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
