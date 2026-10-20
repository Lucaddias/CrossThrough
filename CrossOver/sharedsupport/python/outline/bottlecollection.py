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

    refresh = <function BottleCollection.refresh>()
    reset = <function BottleCollection.reset>()
    def has_32_bit_bottle(self):
        # attributes: bottleList, arch
        # strings: 'win32'
        ...

    has32BitBottle = cxobjc.object_property(read_only=True, typestr=cxobjc.BOOL, getter=has_32_bit_bottle, depends_on=['bottleList'])
    add_ignored_bottle = <function BottleCollection.add_ignored_bottle>()
    remove_ignored_bottle = <function BottleCollection.remove_ignored_bottle>()
    refreshDefaultBottle = <function BottleCollection.refreshDefaultBottle>()
    bottle_with_name = <function BottleCollection.bottle_with_name>()
    bottle_names = <function BottleCollection.bottle_names>()
    bottles = <function BottleCollection.bottles>()
    addBottle = <function BottleCollection.addBottle>()
    removeBottle = <function BottleCollection.removeBottle>()
    addChangeDelegate = <function BottleCollection.addChangeDelegate>()
    removeChangeDelegate = <function BottleCollection.removeChangeDelegate>()
    addBottleChangeDelegate = <function BottleCollection.addBottleChangeDelegate>()
    removeBottleChangeDelegate = <function BottleCollection.removeBottleChangeDelegate>()

sharedCollection = <function sharedCollection>()
