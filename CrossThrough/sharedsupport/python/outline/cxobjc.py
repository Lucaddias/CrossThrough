# cxobjc — reconstructed outline of CrossOver 26.3 lib/python/cxobjc.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Helpers to simplify calling  Python functions from Objective-C code using
PyObjC.

The obstacle to overcome is that PyObjC provides no support for calling regular
functions. The workaround is to declare proxy class methods with Objective-C
imposed names and this module aims to simplify that process.
"""
import Foundation
class CXMacObject(Foundation.NSObject):
    pass

from objc import super
from objc import python_method
_FUNC_CODES = {}
def thunk(func, wrapper_name):
    """Returns a class method encapsulating the func function.

This makes it easy to declare class methods that act as a wrapper for
regular functions as part of a class declaration. For instance:

def some_function(arg):
    pass

class MyClass(cxobj.Proxy):
    someFunction_ = cxobj.thunk(some_function)

# Then the following call is valid:
# MyClass.someFunction_(my_arg)
"""
    # globals: _FUNC_CODES, _FUNCTION_TYPE, classmethod, KeyError, range, eval
    # attributes: count, __name__, join, __code__
    # strings: '_', 'func', 'clsmethod_%s', ',', 'lambda _cls, ', ': func(', ')'
    ...

_FUNCTION_TYPE = type(thunk)
class Proxy(CXMacObject):
    """Serves as a base class for defining proxies so one can call Python
functions from Objective-C code using PyObjC.
"""
    @python_method
    @classmethod
    def add_thunk(cls, meth, func):
        """Dynamically adds a class method wrapper for the specified function.

This makes it possible to declare class methods that act as a wrapper
for regular functions right next to the function declaration, that is
outside of the class declaration. For instance:

class MyClass(cxobj.Proxy):
    pass

def function_one(arg):
    pass

MyClass.add_thunk('functionOne_', function_one)

def function_two():
    pass

MyClass.add_thunk('functionTwo', function_two)

# Then the following calls are valid:
# MyClass.functionOne_(my_arg)
# MyClass.functionTwo()
"""
        # globals: setattr, thunk
        ...

    def nsobject_init(self):
        """Calls the init() method of NSObject. Classes that need an Objective C
init method should implement it like so:

def init(self): # with arguments if applicable
    self = cxobjc.Proxy.nsobject_init(self)
    if self is not None:
        self.__init__() # with arguments if applicable
    return self"""
        # globals: super
        # attributes: init
        ...

    def valueForUndefinedKey_(self, key):
        """Override of -[NSObject valueForUndefinedKey:] which directly
accesses the named attribute. NSObject's implementation throws an
exception, which provokes PyObjC to do this, but all the exceptions
makes it nearly impossible to debug CrossOver. Plus, they slow things
down quite a bit. I also suspect they cause leaks (e.g. KVO change
dictionaries)."""
        # globals: getattr
        ...

    def setValue_forUndefinedKey_(self, value, key):
        """Override of -[NSObject setValue:forUndefinedKey:] which directly
accesses the named attribute. See valueForUndefinedKey_."""
        # globals: setattr
        ...


class _ObjCDecorator:
    """Decorators receive either their parameters or the function to decorate.
So we use this callable class as a trampoline to get both at the same time.
"""
    def __init__(self, cls, meth):
        """Store the name of the method to create and the class to create it
into.
"""
        # attributes: _cls, _method
        ...

    def __call__(self, function):
        """Create the class method and return the original function."""
        # attributes: _cls, add_thunk, _method
        ...


def method(cls, meth):
    """This decorator specifies that the function it applies to should be
callable from Objective-C code as the 'cls.method' class method.

This simplifies equivalent to Proxy.add_thunk() but simplifies the syntax.
Here is an example:

class MyClass(cxobj.Proxy):
    pass

@cxobjc.method(MyClass, 'functionOne_')
def function_one(arg):
    pass

@cxobjc.method(MyClass, 'functionTwo')
def function_two():
    pass

# Then the following calls are valid:
# MyClass.functionOne_(my_arg)
# MyClass.functionTwo()
"""
    # globals: _ObjCDecorator
    ...

def delegate(func):
    """This decorator is a NOP.

Its sole purpose is to identify methods that are part of a delegate design
pattern, where the delegate may be implemented on the Objective-C side and
thus have to follow its naming conventions.
"""
    ...

from objc import namedSelector
def _object_wrapper(object_type, *args, **kwargs):
    # attributes: pop, getter
    # strings: 'python_name', 'ivar', 'depends_on', 'getter'
    ...

from objc import object_property as _object_property
def object_property(*args, **kwargs):
    # globals: _object_wrapper, _object_property
    ...

from objc import array_property as _array_property
def array_property(*args, **kwargs):
    # globals: _object_wrapper, _array_property
    ...

from objc import dict_property as _dict_property
def dict_property(*args, **kwargs):
    # globals: _object_wrapper, _dict_property
    ...

from objc import _C_BOOL as BOOL
# except ImportError:  (handler offset 268)
class CXMacObject:
    pass

# except ImportError:  (handler offset 312)
# except ImportError:  (handler offset 336)
def python_method(func):
    """
This decorator (added in PyObjC 3.0) must be added to any method
definitions in a bridged class (e.g. inheriting from cxobjc.Proxy) that
don't follow PyObjC's naming conventions (with an underscore for each
argument).

For methods using multiple decorators, python_method must be the
outermost / first one.
A no-op decorator is defined for non-macOS and older PyObjC versions.

See <https://github.com/ronaldoussoren/pyobjc/blob/master/docs/changelog.rst#version-32>
"""
    ...

# except ImportError:  (handler offset 366)
def namedSelector(_name, _signature=None):
    """
Use this decorator to explicitly set the Objective-C method name
instead of deducing it from the Python name.

This decorator should be used instead of making a separate "alias"
(like 'fileIsInBottle_ = file_is_in_bottle'). PyObjC 3.2 and later
require use of the 'python_method' decorator on methods in a bridged
class that don't follow PyObjC naming conventions and the decorator
would apply to both the original method and the alias, rendering it
unusable from ObjC.
"""
    def _namedSelector(func):
        ...

    ...

# except ImportError:  (handler offset 400)
def object_property(*_args, **_kwargs):
    ...

def array_property(*_args, **_kwargs):
    ...

def dict_property(*_args, **_kwargs):
    ...

# except ImportError:  (handler offset 442)
BOOL = None
