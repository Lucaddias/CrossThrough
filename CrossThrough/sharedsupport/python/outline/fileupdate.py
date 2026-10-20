# fileupdate — reconstructed outline of CrossOver 26.3 lib/python/fileupdate.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Updates a file, checking the signature if needed."""
import os
import shutil
import datetime
import time
import subprocess
import tempfile
import binascii
import cxlog
import cxutils
import cxurlget
def save_data_and_sig(lines_iterator, filename=None):
    """Separate the data from the signature information and save each in a
separate file.

Returns a (datafile, sigfile) tuple containing the filenames of the data
file and its signature.
"""
    # globals: os, tempfile, len, binascii
    # attributes: path, splitext, basename, mkstemp, fdopen, partition, write, find, strip, split, unhexlify, close
    # strings: 'wb', '.sha256', '.sig'
    ...

def prepare(filename, urlname=None):
    """Unzip the file and/or extract its signature so it can be checked.

Returns a (datafile, sigfile) tuple containing the filenames of the prepared
file and its signature. If an error occurs, datafile will be None.
"""
    # globals: os, subprocess, open, save_data_and_sig, cxlog
    # attributes: endswith, which, environ, Popen, PIPE, stdout, communicate, returncode, err, unlink, close
    # strings: '.gz', 'PATH', 'pigz', 'gzip', '-d', '-c', 'rb', 'an error occurred while unzipping %s. This file will be ignored.'
    ...

def is_signed(datafile, sigfile=None):
    """Returns True if the file has a valid signature."""
    # globals: os, cxutils, cxlog
    # attributes: path, exists, endswith, join, CX_ROOT, run, NULL, err
    # strings: '.sig', '-sha1', '-sha256', 'share', 'crossover', 'data', 'tie.pub', 'openssl', 'dgst', '-verify', '-signature', 'The file %s is signed, but the signature is invalid.'
    ...

def install(dstfile, tmpfile, tmpsig):
    """Replace filename and filename.sig with the specified temporary files so
as to minimize the impact of race conditions and errors.
Returns a tuple containing the filenames of the new data and signature
files."""
    # globals: os, cxutils, shutil
    # attributes: path, dirname, mkdirs, move, splitext, rename
    # strings: '.new'
    ...

def update(filename, url, needs_signature=False, timeout=None, leeway=7200):
    """Updates the specified file from the URL and returns True if it was indeed
updated. Returns False if the download failed or the file was already up to
date."""
    # globals: os, time, cxurlget, datetime, cxutils, tempfile, prepare, is_signed, cxlog, install
    # attributes: path, exists, getmtime, time, format_http_date, datetime, fromtimestamp, timezone, utc, dirname, mkdirs, splitext, basename, mkstemp, fdopen, UrlGetter, timeout, fetch, finished, unlink, utime, warn
    # strings: 'w+b', 'The newly downloaded %s file is not properly signed. Discarding.'
    ...
