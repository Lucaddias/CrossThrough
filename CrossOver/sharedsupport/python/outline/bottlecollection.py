# bottlecollection — reconstructed outline of CrossOver 26.3 lib/python/bottlecollection.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import bottlequery
import bottlewrapper
import cxobjc
import distversion
class BottleCollection(cxobjc.Proxy):
    bottleList = cxobjc.array_property()
    def __init__(self):
        # attributes: bottleList, ignored_bottles, changeDelegates, bottleChangeDelegates, refresh
        ...

    def init(self):
        # globals: cxobjc
        # attributes: Proxy, nsobject_init, __init__
        ...

    @cxobjc.namedSelector(b'refresh')
    def refresh(self):
        # globals: bottlequery
        # attributes: get_bottle_list, bottles, name, is_renaming, removeBottle, remove, changeablename, ignored_bottles, addBottle, changeDelegates, bottleCollectionChanged
        ...

    @cxobjc.namedSelector(b'reset')
    def reset(self):
        # attributes: bottle_names, removeBottle, refresh
        ...

    def has_32_bit_bottle(self):
        # attributes: bottleList, arch
        # strings: 'win32'
        ...

    has32BitBottle = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=has_32_bit_bottle, depends_on=['bottleList'])
    @cxobjc.python_method
    def add_ignored_bottle(self, new_name):
        # attributes: ignored_bottles, append
        ...

    @cxobjc.python_method
    def remove_ignored_bottle(self, new_name):
        # attributes: ignored_bottles, remove
        ...

    @cxobjc.namedSelector(b'refreshDefaultBottle')
    def refreshDefaultBottle(self):
        # globals: bottlequery
        # attributes: get_default_bottle, bottleList, name, is_default
        ...

    @cxobjc.namedSelector(b'bottleWithName:')
    def bottle_with_name(self, bottle_name):
        # attributes: bottleList, name
        ...

    @cxobjc.python_method
    def bottle_names(self):
        # attributes: bottleList, name
        ...

    @cxobjc.python_method
    def bottles(self):
        # globals: list
        # attributes: bottleList
        ...

    @cxobjc.python_method
    def addBottle(self, bottle_name):
        # globals: distversion, bottlewrapper
        # attributes: bottles, name, IS_MACOSX, BottleWrapper, alloc, initWithName_, bottleList, append, add_menu_observers, bottleChangeDelegates, add_change_delegate, refreshDefaultBottle
        ...

    @cxobjc.python_method
    def removeBottle(self, bottle_name):
        # attributes: bottle_with_name, bottleList, remove, remove_change_delegate, remove_observers, refreshDefaultBottle
        ...

    @cxobjc.namedSelector(b'addChangeDelegate:')
    def addChangeDelegate(self, inDelegate):
        # attributes: changeDelegates, append
        ...

    @cxobjc.python_method
    def removeChangeDelegate(self, inDelegate):
        # attributes: changeDelegates, remove
        ...

    @cxobjc.python_method
    def addBottleChangeDelegate(self, inDelegate):
        # attributes: bottleChangeDelegates, append, bottles, add_change_delegate
        ...

    @cxobjc.python_method
    def removeBottleChangeDelegate(self, inDelegate):
        # attributes: bottleChangeDelegates, remove, bottles, remove_change_delegate
        ...


@cxobjc.method(BottleCollection, 'sharedCollection')
def sharedCollection():
    # globals: sharedBottleCollection, NameError, distversion, BottleCollection
    # attributes: IS_MACOSX, alloc, init
    ...
