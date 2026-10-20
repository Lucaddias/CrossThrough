# cxfsnotifier — reconstructed outline of CrossOver 26.3 lib/python/cxfsnotifier.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Monitors the filesystem and notifies the registered observers of any change
to their paths of interest."""
import os
import sys
import threading
import time
import cxlog
import cxobservable
import cxutils
CREATED = 'created'
DELETED = 'deleted'
MODIFIED = 'modified'
class _Path(cxobservable.Object):
    """This is a helper class that monitors a single path."""
    observable_events = frozenset((CREATED, DELETED, MODIFIED))
    def __init__(self, path):
        # globals: cxobservable, set, cxutils, os, OSError
        # attributes: Object, __init__, _path, _dentries, FileDigest, _digest, listdir
        ...

    def emit_event_for_observer(self, event, observer, observer_data, *args):
        """Override the cxobservable.Object method."""
        ...

    def poll(self):
        """Checks this path object for changes and emits the events if any."""
        # globals: cxutils, set, os, DELETED, CREATED, MODIFIED, OSError
        # attributes: _digest, modified, _dentries, FileDigest, _path, listdir, existed, difference, emit_event, path, join
        ...


class PollingFSNotifier:
    """The fallback filesystem notifier implementation.

It works by polling the specified paths at regular intervals.
"""
    interval = 2
    def __init__(self):
        # globals: threading
        # attributes: _paths, Lock, _lock, Thread, worker, _thread, daemon, start
        ...

    def add_observer(self, path, observer, observer_data=None):
        """See cxfsnotifier.add_observer()."""
        # globals: _Path, cxobservable
        # attributes: _lock, _paths, poll, add_observer, ANY_EVENT
        ...

    def remove_observer(self, path, observer_id):
        """See cxfsnotifier.remove_observer()."""
        # globals: cxobservable, KeyError
        # attributes: _lock, _paths, remove_observer, ANY_EVENT
        ...

    def all_observers(self):
        """Return a dictionary containing all observers"""
        # attributes: _paths, items, all_observers, values, extend
        ...

    def poll(self, path):
        """See cxfsnotifier.poll()."""
        # attributes: _paths, get, poll
        ...

    def worker(self):
        """This method implements the polling loop and runs in the background
thread.
"""
        # globals: time, list
        # attributes: sleep, interval, _paths, keys, poll
        ...


_NOTIFIERS = {}
_NOTIFIER = None
def add(cls, priority):
    """Registers a filesystem notifier implementation class.

The implementation with the highest priority (a positive integer) will be
selected, providing that the object instantiation succeeds. Otherwise the
implementation with the next highest priority will be used.

It is an error to register an implementation after observers have been
added.
"""
    # globals: _NOTIFIER, AssertionError, _NOTIFIERS
    # strings: 'A cxfsnotifier implementation has already been selected'
    ...

add(PollingFSNotifier, 0)
def get():
    """Returns the filesystem notifier implementation."""
    # globals: _NOTIFIER, sorted, _NOTIFIERS, Exception, cxlog, str
    # attributes: __getitem__, log
    # strings: ' is not available: '
    ...

def add_observer(path, observer, observer_data=None):
    """Adds an event observer for the specified path.

path is the path to monitor. This can either be a file or a directory. It
  can also be a nonexistent path, the observer will then be notified when
  and if it gets created. Also note that paths are not canonicalized. This
  means two observers may in fact be watching the same filesystem objects
  but just with two different paths. They will still each receive the
  relevant events, each for its own path. If path points to a directory
  the observer receives events for the creation and deletion of files and
  folders in that directory.

observer_data is any data the observer would like to be given back
  when it gets called.

observer is a callable. Its signature must be of the form:
    observer(event, path, observer_data)
  Where event is one of CREATED, DELETED or MODIFIED, path is the relevant
  path and observer_data is the data that was specified in add_observer().
  Observers must not raise exceptions.

Returns an id that can be used to remove the observer.
"""
    # globals: get
    # attributes: add_observer
    ...

def remove_observer(path, observer_id):
    """Removes the observer for the specified path and observer id.

No exception is raised if the observer has already been removed.
"""
    # globals: get
    # attributes: remove_observer
    ...

def poll(path):
    """Synchronously checks whether there are any events to report for the
specified path.

Note that because this is done synchronously the observers will be called
in the current thread.
"""
    # globals: get
    # attributes: poll
    ...

def main():
    # globals: add, add_observer, os, time
    # attributes: getcwd, sleep
    # strings: 'FakeNotifier', 'FakeNotifier2', 'new', 'stop'
    def FakeNotifier():
        """main.<locals>.FakeNotifier"""
        # globals: __name__
        def __init__(self):
            # globals: AssertionError
            # strings: 'FakeNotifier.__init__ should not be called'
            ...

        ...

    def FakeNotifier2():
        """main.<locals>.FakeNotifier2"""
        # globals: __name__
        def __init__(self):
            # globals: AssertionError
            # strings: 'FakeNotifier2.__init__ should not be called'
            ...

        ...

    def test_observer(event, path, _data):
        # globals: print
        # strings: 'observer: ', ': '
        ...

    def stop_observer(event, path, _data):
        # globals: print, sys
        # attributes: exit
        # strings: 'stopper: ', ': ', 'stop', 'Exiting'
        ...

    ...

# if not __name__ == '__main__' ... (offset 214-230)
main()
