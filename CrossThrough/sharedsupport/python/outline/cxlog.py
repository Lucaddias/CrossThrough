# cxlog — reconstructed outline of CrossOver 26.3 lib/python/cxlog.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Handles logging and error reporting."""
import atexit
import os
import sys
import time
import threading
_all_on = None
_channels = {}
_log_file = None
_close_log_file = False
_start = None
def log_to(out, append=True):
    """Sets up logging to the specified file object, name, or handle.

If append is true, then the log is appended to.
"""
    # globals: _close_log_file, _log_file, hasattr, open
    # attributes: close
    # strings: 'at', 'wt', 'write', 'utf8', 'backslashreplace'
    ...

def get_file():
    """Returns the file the traces are sent to if any, and None otherwise."""
    # globals: _log_file
    ...

def get_filename():
    """Returns the name of the file that receives the logs.

If logging goes to a file descriptor, then "&n" is returned where 'n' is
the file descriptor. If logging is turned off, then None is returned.

Occasionally exceptions were thrown here causing all kinds of
weird hangs and breakages. Since logging is non-critical,
we now catch all exceptions during writing.
"""
    # globals: _log_file, AttributeError, repr
    # attributes: name, fileno
    # strings: '<fdopen>', '&%s'
    ...

def is_on(channel=None):
    """Returns False if logging is turned off globally or for the specified
channel. Otherwise returns True.

The channels correspond to what is put in $CX_DEBUGMSG.
"""
    # globals: _log_file, _all_on, _channels
    ...

def _exit_logging():
    # globals: _close_log_file, _log_file
    # attributes: close
    ...

def _init_logging():
    """Sets up logging based on the CX_LOG and CX_DEBUGMSG variables.

This is called automatically when cxlog is first imported.
"""
    # globals: atexit, _exit_logging, os, log_to, sys, _channels, is_on, time, IOError, warn, str
    # attributes: register, environ, stderr, split, startswith, lstrip, time
    # strings: 'CX_LOG', '-', 'CX_DEBUGMSG', ',', '+all', '-all', '+', 'timestamp', 'could not open log output file: '
    ...

def _tid_prefix():
    # globals: is_on, threading
    # attributes: get_ident
    # strings: 'tid', '%s:', ''
    ...

def _timestamp_prefix():
    # globals: _start, time
    # attributes: time
    # strings: '', '%.3f:'
    ...

def _to_str(string, always_repr):
    # globals: repr, isinstance, str, _to_str, type
    # strings: '<object of type %s could not be converted to a string>'
    ...

def to_str(string):
    """Format an arbitrary object for printing.

The result is guaranteed to be a string, and this function will never cause
an exception. If it's a string or unicode object, the contents are used
literally."""
    # globals: _to_str
    # strings: '<exception raised while converting an object to string>'
    ...

def debug_str(string):
    """Format an arbitrary object for debugging purposes.

The result is guaranteed to be a string, and this function will never cause
an exception. If possible, this is a python representation of the object,
or something in <angle brackets>."""
    # globals: _to_str
    # strings: '<exception raised while converting an object to string>'
    ...

def log(message):
    """Prints a log message.

What is printed is 'fmt % args' and a linefeed is automatically added.
"""
    # globals: _log_file, _all_on, _timestamp_prefix, _tid_prefix, to_str
    # attributes: write
    # strings: '\n'
    ...

def log_(channel, message):
    """Same as cxlog(), but the message is only logged if logging is turned on
for the specified channel.
"""
    # globals: is_on, _log_file, _timestamp_prefix, _tid_prefix, to_str
    # attributes: write
    # strings: ':', '\n'
    ...

def name0():
    """Returns the current executable basename."""
    # globals: os, sys
    # attributes: path, basename, argv
    ...

def warn(message):
    """Issues a warning to the user on stderr.

A linefeed is automatically appended to the message.
"""
    # globals: name0, to_str, sys, _log_file
    # attributes: stderr, write
    # strings: ':warning: ', '\n'
    ...

def err(message):
    """Issues an error to the user on stderr.

A linefeed is automatically appended to the message.
"""
    # globals: name0, to_str, sys, _log_file
    # attributes: stderr, write
    # strings: ':error: ', '\n'
    ...

_init_logging()
