# pyop — reconstructed outline of CrossOver 26.3 lib/python/pyop.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os
import threading
import traceback
import cxlog
from PyObjCTools import AppHelper
perform_on_main_thread = AppHelper.callAfter
from Foundation import NSThread
def is_main_thread():
    # globals: NSThread
    # attributes: isMainThread
    ...

class PythonOperation:
    canceled = False
    priority = 0
    def __init__(self):
        # globals: threading
        # attributes: Event, suspended, set
        ...

    def __unicode__(self):
        # attributes: __class__, __name__
        ...

    def enqueued(self):
        """This is run as soon as the operation is queued for execution.

Any initialization task that should be done if, and only if, the
operation is going to be run should be performed here rather than in
__init__(). This way, if one creates an instance of the operation but
then never queues it for execution there's no harm done. Same this if
one creates a single instance and then runs it multiple times.

Since operations often modify variables that affect the UI
from this function, this should only be called from the main
thread.

"""
        # globals: is_main_thread, cxlog
        # attributes: log, to_str
        # strings: 'queued '
        ...

    def main(self):
        """This function must be overridden and will be run in a background
thread.

Do not perform any GUI interaction here!
"""
        # globals: NotImplementedError
        ...

    def finish(self):
        """This will be run in the main thread after the operation
completes.

Because this function runs in the main thread it can perform GUI
operations.
"""
        # globals: is_main_thread, cxlog
        # attributes: log, to_str
        # strings: 'finish '
        ...

    def cancel(self):
        # attributes: canceled, resume
        ...

    def suspend(self):
        # attributes: suspended, clear
        ...

    def resume(self):
        # attributes: suspended, set
        ...


class PythonOperationQueue:
    def __init__(self, maxThreads=0):
        # globals: os, threading, ValueError
        # attributes: sysconf, maxThreads, Semaphore, threadPool, Lock, lock, operationList
        # strings: 'SC_NPROCESSORS_ONLN'
        ...

    def spawnOpThread(self):
        """Spawns a new thread to run operations, if necessary"""
        # globals: threading
        # attributes: operationList, threadPool, acquire, Thread, runOperations, daemon, start
        ...

    def enqueue(self, operation):
        # attributes: enqueued, lock, operationList, append, spawnOpThread
        ...

    def _popOperation(self):
        # globals: range, len
        # attributes: lock, operationList, priority, pop
        ...

    def runOperations(self):
        # globals: threading, cxlog, perform_on_main_thread, IndexError, traceback
        # attributes: current_thread, name, _popOperation, threadPool, release, suspended, wait, acquire, canceled, log, to_str, main, finish, spawnOpThread, err, format_exc, rstrip
        # strings: ': canceled ', ': running ', 'an operation raised an exception:\n%s', '\n'
        ...


sharedOperationQueue = PythonOperationQueue()
def main():
    # globals: PythonOperation, PythonOperationQueue, range
    # attributes: enqueue
    # strings: 'TestOperation'
    def TestOperation():
        """main.<locals>.TestOperation"""
        # globals: __name__
        def main(self):
            # globals: print, len
            # attributes: append, sleep, SystemRandom, random, pop
            # strings: 'start %s', 'end %s'
            ...

        ...

    ...

# if not __name__ == '__main__' ... (offset 162-178)
main()
# except ImportError:  (handler offset 190)
from gi.repository import GLib
perform_on_main_thread = GLib.idle_add
main_thread = GLib.thread_self()
def is_main_thread():
    # globals: GLib, main_thread
    # attributes: thread_self
    ...
