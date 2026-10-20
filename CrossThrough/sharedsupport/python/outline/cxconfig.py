# cxconfig — reconstructed outline of CrossOver 26.3 lib/python/cxconfig.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Provides support for reading and modifying configuration files."""
import os
import re
import sys
import threading
import time
from collections.abc import MutableMapping
from collections.abc import Mapping
import weakref
import cxfsnotifier
import cxlog
import cxobservable
import cxutils
MODIFIED = 'modified'
RELOADED = 'reloaded'
_EMPTY_RE = re.compile('^\\s*$')
class Section(MutableMapping):
    """Stores the data corresponding to a given configuration file section."""
    def __init__(self, parent, name):
        # attributes: _parent, _name, _blocks, _field_lines, _values
        ...

    _section_re = re.compile('^\\[(?P<section>.*)\\]\\s*(?:;[^\\]]*)?$')
    _quoted_field_re = re.compile('^\\s*(?P<comment>;+\\s*)*"(?P<name>(?:[^\\\\"]|\\\\.)*)"(?P<equal>\\s*=\\s*)\\"(?P<value>(?:[^\\\\"]|\\\\.)*)"\\s*(?...)
    _field_re = re.compile('^\\s*(?P<comment>;+\\s*)*(?P<name>[^[=;][^=]*?)(?P<equal>\\s*=\\s*)(?P<value>.*?)\\s*$')
    def _add_field(self, match, blockline, quoted):
        """A helper for read_lines() which records the specified field."""
        # globals: cxutils
        # attributes: group, unescape_string, lower, _field_lines, _values, append, insert
        # strings: 'name', 'comment', 'value'
        ...

    def _add_block(self, block):
        """Adds a block of lines to this section and the configuration file."""
        # attributes: _blocks, append, _parent, blocks
        ...

    def read_lines(self, lines, first_lineno, start_lineno):
        """Parses the specified configuration lines until the start of the next
section. Any encountered field is stored in the current section.

This function should really only be called by Raw.read_lines().
"""
        # globals: ValueError, len, _EMPTY_RE
        # attributes: _parent, read_only, _quoted_field_re, match, _add_field, _field_re, _section_re, group, extend, _add_block
        # strings: 'This object is currently read-only', 'in-section', '=', ';', 'empty', '[', 'section', 'other'
        ...

    def _getname(self):
        """Returns the section name as it appears in the configuration file."""
        # attributes: _name
        ...

    name = property(_getname)
    def fieldname(self, name):
        """Given a field key, returns the field's original name.

Since the configuration files are case insensitive, the section
iterators do not preserve the case and may return all lowercase names.
This method lets callers that care recover the original field name.
"""
        # globals: cxutils
        # attributes: string_to_str, _field_lines, lower, _quoted_field_re, match, unescape_string, group, _field_re
        # strings: 'name'
        ...

    def iterblocks(self):
        """Returns an iterator over the section's blocks of lines."""
        # globals: iter
        # attributes: _blocks
        ...

    def sortedkeys(self):
        """Returns a list containing the section's field names in the order in
which they appear in the file.

Note that only uncommented fields are returned. Also the case of the
field names may not match the case they have in the file.
"""
        # globals: list
        # attributes: _parent, lock, _values, sort, unlock
        def key_key(k):
            # globals: enumerate, ValueError
            # attributes: _field_lines, _blocks
            # strings: 'block not found'
            ...

        ...

    def __contains__(self, name):
        """Returns True if this section contains a field by the specified name
and False otherwise. Note that field names are case insensitive."""
        # attributes: lower, _values
        ...

    def __getitem__(self, name):
        """Returns the value of the specified field if present and raises a
KeyError exception otherwise. Note that field names are case
insensitive."""
        # attributes: _values, lower
        ...

    def __iter__(self):
        """Returns an iterator over the section's field names.

Note that only uncommented fields are returned. Also the case of the
field names may not match the case they have in the file.
"""
        # globals: iter
        # attributes: _values, keys
        ...

    def keys(self):
        """Returns a list containing the section's field names.

Note that only uncommented fields are returned. Also the case of the
field names may not match the case they have in the file. Finally,
unlike for sortedkeys(), the order is random.
"""
        # attributes: _values, keys
        ...

    def __setitem__(self, name, value):
        # globals: ValueError, cxutils, len
        # attributes: _parent, read_only, string_to_str, lower, lock, _values, get, unlock, _blocks, add_section, _name, _field_lines, _quoted_field_re, match, escape_string, group, _field_re, append, modified
        # strings: 'This object is currently read-only', '"', 'equal', '"\n', '\n', '" = "'
        ...

    def __delitem__(self, name):
        # globals: ValueError, cxutils
        # attributes: _parent, read_only, string_to_str, lower, lock, _values, modified, _field_lines, pop, unlock
        # strings: 'This object is currently read-only'
        ...

    def __len__(self):
        # globals: len
        # attributes: _values
        ...


class Raw(MutableMapping, cxobservable.Object):
    """A class for reading, writing and modifying configuration strings or
files.
"""
    observable_events = frozenset((MODIFIED, RELOADED))
    read_only = False
    def __init__(self):
        # globals: cxobservable, threading
        # attributes: Object, __init__, _real_sections, _all_sections, RLock, _obj_lock, modified, blocks
        ...

    def lock(self):
        """Locks the object so its state can be modified in a thread-safe way.

Note that this does not lock the underlying file (if any). Also all
individual methods are already thread-safe (that is they take this
lock) so calling this method from outside cxconfig should rarely be
needed.
"""
        # attributes: _obj_lock, acquire
        ...

    def unlock(self):
        """Unlocks the object. See lock() for details."""
        # attributes: _obj_lock, release
        ...

    def read_lines(self, lines):
        """Parses the specified configuration lines.

Note that this function considers the lines preceding the first section
to not to belong to any section even if some data has been read
already. So it should at a minimum be given complete sections.
"""
        # globals: ValueError, Section, cxlog
        # attributes: read_only, lock, read_lines, lower, _all_sections, setdefault, _real_sections, log, unlock
        # strings: 'This object is currently read-only', 'found a duplicate section on line %d'
        ...

    def read_string(self, string):
        """Reads configuration data from the given string and merges it with the
settings that have already been read.

Note that this function considers the lines preceding the first section
to not to belong to any section even if some data has been read
already. So it should at a minimum be given complete sections.
"""
        # attributes: read_lines, splitlines
        ...

    def read(self, filename):
        """Reads the specified configuration file and merges it with the
settings that have already been read.

Note that this function considers the lines preceding the first section
to not to belong to any section even if some data has been read
already. So it should at a minimum be given complete sections.
"""
        # globals: ValueError, open, list
        # attributes: read_only, readlines, startswith, read_lines
        # strings: 'This object is currently read-only', 'r', 'utf8', '\ufeff'
        ...

    def dump(self):
        """Prints the configuration file's blocks of lines to stdout for
debugging.
"""
        # globals: sys
        # attributes: blocks, stdout, write
        # strings: '---\n', '<None>\n', '| '
        ...

    def write(self, out):
        """Writes the in-memory settings to the specified file.

The configuration file is replaced atomically so that another process
or thread should never see an incomplete configuration file.
"""
        # globals: hasattr, isinstance, int, os, open, cxutils
        # attributes: fdopen, path, dirname, exists, makedirs, lock, blocks, write, string_to_utf8, close, rename, unlock
        # strings: 'write', 'wb', '.tmp'
        ...

    def add_section(self, name):
        """Adds a new empty section of the specified name and returns it.

If the section already exists, then it is returned.
"""
        # globals: ValueError, cxutils, Section, _EMPTY_RE
        # attributes: read_only, string_to_str, lower, lock, _real_sections, unlock, _all_sections, setdefault, blocks, match, read_lines
        # strings: 'This object is currently read-only', '[%s]\n', '\n'
        ...

    def __contains__(self, name):
        """Returns True if this configuration object contains a section by the
specified name and False otherwise. Note that section names are case
insensitive."""
        # globals: cxutils
        # attributes: string_to_str, lower, _real_sections
        ...

    def __getitem__(self, name):
        """Returns the specified section.

Note that for convenience the following syntax works even if the
specified section does not exist:

    var = config['Nonexistent']['FieldName']

This means __getitem__() returns stub section objects for nonexistent
sections. However these sections will not be seen by __contains__() or
the iterator methods, and will not be saved when the configuration is
written to a file. Further note that section names are case
insensitive."""
        # globals: cxutils, KeyError, Section
        # attributes: string_to_str, lower, _real_sections, _all_sections, setdefault
        ...

    def __iter__(self):
        """Note that this method iterates over the lowercased section names.

Since the section names are case insensitive this should not bother
the caller or he should be able to deal with case differences anyway."""
        # globals: iter
        # attributes: _real_sections, keys
        ...

    def keys(self):
        """Returns a list containing the configuration's section names.

Note that because section names are case insensitive, the returned
section names may not have the same case as in the file (to get the
unaltered section name, query the section's name attribute).
"""
        # attributes: _real_sections, keys
        ...

    def __setitem__(self, _name, _value):
        # globals: ValueError
        # strings: 'Cannot assign to sections directly'
        ...

    def __delitem__(self, name):
        """Deletes the specified section."""
        # globals: ValueError, cxutils, range, len
        # attributes: read_only, lock, string_to_str, lower, _real_sections, pop, _all_sections, modified, iterblocks, unlock
        # strings: 'This object is currently read-only'
        ...

    def __len__(self):
        # globals: len
        # attributes: _real_sections
        ...


class File(Raw):
    """Loads a configuration file and automatically keeps it up to date.

Note that this means the object is read-only until the on-disk file has
been locked with lock_file(). The changes can then be committed to disk
with save_and_unlock_file(), at which point the object is read-only again.
"""
    def __init__(self, filename):
        """Creates an object corresponding to the specified configuration
file.

Note that it is ok to specify a nonexistent filename. Also note that
the File object will automatically read the configuration file if some
other process creates eventually.
"""
        # globals: Raw, cxfsnotifier
        # attributes: __init__, _read_only, _filename, _digest, _file_lock, refresh, add_observer, _fs_observer
        ...

    def _getread_only(self):
        """False if the configuration can be modified, True otherwise.

The object is in read-only mode at all times except between
lock_file() and save_and_unlock_file() calls.
"""
        # attributes: _read_only
        ...

    read_only = property(_getread_only)
    def _getfilename(self):
        """Returns the path of the configuration file this object corresponds
to."""
        # attributes: _filename
        ...

    filename = property(_getfilename)
    def _fs_observer(self, _event, path, _data):
        """Called by cxfsnotifier whenever something happens to the
configuration file."""
        # attributes: _filename, refresh
        ...

    def refresh(self):
        """Re-reads the file if it has been modified on disk.

Note that cxconfig.File objects refresh themselves automatically
although there may be a small delay introduced by the platform's
file change notification mechanism. So calling this method is only
needed if you know the file has been modified outside of this object's
control and want to make sure the object has been refreshed before
continuing.
However note that any on-disk change will be ignored if the in-memory
data has been modified. However that also means that lock_file() has
been called and thus the on-disk file should not have been changed in
the first place.
"""
        # globals: cxlog, time, cxutils, RELOADED, IOError
        # attributes: modified, warn, _filename, time, lock, _digest, _read_only, unlock, log, to_str, FileDigest, _real_sections, _all_sections, blocks, read, emit_event
        # strings: 'Not re-reading %s because it has been modified in memory\n', "reading '%s' took %0.4fs"
        ...

    def lock_file(self, lock_name=None):
        """Creates and takes a write lock for the specified configuration file,
refreshes the in-memory settings and makes them read-write (see the
read_only attribute).

Note that the OS-level lock is not taken on the configuration file
itself so we can lock nonexistent files and also so we allow
unfettered read access. The latter means using atomic renames to put
the new file in place when saving which would interfer with locks
taken on that file.
"""
        # globals: os, cxutils
        # attributes: lock, path, basename, _filename, FLock, _file_lock, refresh, _read_only, modified, unlock
        ...

    def file_is_locked(self):
        # attributes: _file_lock
        ...

    def save_and_unlock_file(self, rm_if_empty=False):
        """Marks the in-memory settings as read-only, saves them if they have
been modified and then unlocks the configuration file."""
        # globals: ValueError, cxlog, os, cxutils, MODIFIED, OSError
        # attributes: _file_lock, lock, _read_only, modified, _real_sections, log, to_str, _filename, unlink, write, FileDigest, _digest, emit_event, release, unlock, warn
        # strings: 'The configuration file must be locked first', "'%s' is empty -> deleting it", "saving '%s'\n", "'%s' not modified -> no need to save\n", "could not delete '%s', saving it instead\n"
        ...

    def __del__(self):
        # globals: ValueError
        # attributes: _file_lock
        # strings: 'The file must be unlocked before being thrown away!'
        ...


_CACHE = weakref.WeakValueDictionary()
def get(filename):
    """Returns a cxconfig.File object containing the requested file.

Note that the resulting object is cached based on the specified filename.
This is done so all callers see the same data at all times even across
threads. To ensure this, the path is normalized a bit so a doubled path
separator does not throw it off. However symbolic links, parent directory
references, and absolute vs. relative paths result in different objects
because they may refer to different files in the future.
"""
    # globals: _CACHE, File
    # attributes: startswith, replace, refresh, setdefault
    # strings: './', '/./', '/', '//'
    ...

class _StackSection(Mapping):
    """This is a proxy class that presents a unified view of the sections of
the configuration objects contained in a configuration Stack instance."""
    def __init__(self, parent, key):
        """Creates a proxy instance for the section whose key is key for the
specified parent Stack instance."""
        # attributes: _parent, _key
        ...

    def _getname(self):
        """See Section._getname() for details."""
        # attributes: _parent, iterconfigs, get, _key, name
        ...

    name = property(_getname)
    def fieldname(self, name):
        """See Section.fieldname() for details."""
        # globals: KeyError
        # attributes: _parent, iterconfigs, get, _key, fieldname
        ...

    def __contains__(self, name):
        """See Section.__contains__() for details."""
        # attributes: _parent, iterconfigs, _key
        ...

    def __getitem__(self, name):
        """See Section.__getitem__() for details."""
        # globals: KeyError
        # attributes: _parent, iterconfigs, _key
        ...

    def __iter__(self):
        """See Section.__iter__() for details."""
        # globals: set
        # attributes: _parent, iterconfigs, _key, add
        ...

    def keys(self):
        """See Section.keys() for details."""
        # globals: set, list
        # attributes: _parent, iterconfigs, _key, update, keys
        ...

    def __len__(self):
        # globals: len
        # attributes: keys
        ...


class Stack(Mapping, cxobservable.Object):
    """Provides a read-only seamless view of a stack of configuration files.

One faces a layered configuration file set whenever the configuration
settings are spread over multiple configuration files. This is typically
the case when the settings are split between a per-user file and a
system-wide file containing the defaults. For instance:

    ~/.cxoffice/cxoffice.conf
    /opt/cxoffice/etc/cxoffice.conf

One can view this as a stack with the file containing the most specific
settings on top and the one containing the defaults at the bottom.

Furthermore the Stack implementation guarantees that any change made in
the underlying configuration objects will be immediately visible in the
Stack object. So the following code would work:

    stack = cxconfig.Stack()
    stack.addconfig('bottom.conf')
    stack.addconfig('top.conf')

    config = cxconfig.get('top.conf')
    config['Section']['Setting'] = 'Changed'
    assert stack['Section']['Setting'] == 'Changed'
"""
    observable_events = frozenset((MODIFIED, RELOADED))
    def __init__(self):
        # globals: cxobservable
        # attributes: Object, __init__, _configs, _cache
        ...

    def copy(self):
        """Creates a copy of the Stack object.

One can then add more configuration files to the copy without
impacting the original object.
"""
        # globals: Stack
        # attributes: _configs
        ...

    def addconfig(self, filename):
        """Adds the specified configuration file on top of the stack.

The order in which the files are added is important: the settings
contained in the top-most file override those of the files below it.
The configuration file will be taken from the cxconfig cache to ensure
consistency with concurrent direct accesses to that file.
"""
        # globals: get, cxobservable
        # attributes: _configs, insert, add_observer, ANY_EVENT, _event_forwarder
        ...

    def _event_forwarder(self, _source, event, *args):
        """Forwards selected events from the underlying configuration
objects."""
        # attributes: emit_event
        ...

    def iterconfigs(self):
        """Returns an iterator over the configuration objects that have been
added to this Stack instance. The configuration objects are iterated
in top to bottom order."""
        # globals: iter
        # attributes: _configs
        ...

    def configs(self):
        """Returns a list containing the configuration objects this Layered
instance is based on. See iterconfig() for the order of the objects in
the list."""
        # attributes: _configs
        ...

    def get_save_config(self):
        """"Returns the top-most writable configuration file.

This is typically the file you would want to save modifications to.
Note that the underlying configuration file may not exist yet. It is
enough that it can be created and written to if needed.
"""
        # globals: os
        # attributes: _configs, filename, path, lexists, isfile, isdir, access, W_OK, dirname
        ...

    def refresh(self):
        """Synchronously refreshes each of the underlying files.

See File.refresh() for more details.
"""
        # attributes: _configs, refresh
        ...

    def __contains__(self, name):
        """See Raw.__contains__() for details."""
        # attributes: _configs
        ...

    def __getitem__(self, name):
        """See Raw.__getitem__() for details."""
        # globals: _StackSection
        # attributes: lower, _cache, setdefault
        ...

    def __iter__(self):
        """See Raw.__iter__() for details."""
        # globals: set
        # attributes: _configs, add
        ...

    def keys(self):
        """See Raw.keys() for details."""
        # globals: set, list
        # attributes: _configs, update, keys
        ...

    def __len__(self):
        # globals: len
        # attributes: keys
        ...


# except ImportError:  (handler offset 362)
from UserDict import DictMixin as MutableMapping
from UserDict import DictMixin as Mapping
