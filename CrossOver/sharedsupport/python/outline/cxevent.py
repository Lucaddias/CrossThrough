# cxevent — reconstructed outline of CrossOver 26.3 lib/python/cxevent.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import threading
import cxutils
class Event:
    """We are not using threading.Event because it works by polling and is
not as fast as it could be.
"""
    __fields__ = ['r_pipe', 'w_pipe', 'lock']
    def __init__(self):
        # globals: os, threading
        # attributes: pipe, r_pipe, w_pipe, Lock, lock
        ...

    def isSet(self):
        # globals: cxutils, bool
        # attributes: select, r_pipe
        ...

    def set(self):
        # globals: os
        # attributes: isSet, write, w_pipe
        ...

    def clear(self):
        # globals: os
        # attributes: lock, isSet, read, r_pipe
        ...

    def wait(self, timeout=None):
        # globals: cxutils
        # attributes: select, r_pipe
        ...

    def __del__(self):
        # globals: os
        # attributes: close, r_pipe, w_pipe
        ...


class AsyncResult:
    """Stores value and makes it possible to wait for it to be set."""
    def __init__(self):
        # globals: Event
        # attributes: event, value, error
        ...

    def set(self, value):
        """Sets the value and signals its arrival."""
        # attributes: value, event, set
        ...

    def set_error(self, error):
        """Set an exception to be raised when the value is requested."""
        # attributes: error, event, set
        ...

    def poll(self):
        """Returns the value if it is set, otherwise None."""
        # attributes: error, value
        ...

    def get(self):
        """Waits for the value to be set and returns it."""
        # attributes: event, wait, poll
        ...
