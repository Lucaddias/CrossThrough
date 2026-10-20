# cxobservable — reconstructed outline of CrossOver 26.3 lib/python/cxobservable.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

"""Provides a framework for classes that have observable properties."""
ANY_EVENT = None
class Object:
    """Provides a framework for a class that has observable properties.

The derived classes should have an observable_events class attribute that
defines the set of events this class can emit. Events can be strings or
any other type of object.
"""
    observable_events = frozenset()
    def __init__(self):
        # attributes: _observers
        ...

    def add_observer(self, events, observer, observer_data=None):
        """Adds an event observer for the current object.

events can either be a single event or a sequence of events the
  observer is interested in. To subscribe to all the events from
  this object, specify the ANY_EVENT value.

observer_data is any data the observer would like to be given back
  when it gets called.

observer is a callable. Its signature must be of the form:
    observer(obj, event, observer_data, *args)
  Where obj is the object the event happens on, event is the event that
  was emitted, observer_data is the data specified above, and *args is
  an optional set of extra data specific to the event. Observers must
  not raise exceptions.
"""
        # globals: isinstance, str, hasattr, TypeError, repr, id
        # attributes: observable_events, __class__, _observers, setdefault
        # strings: '__iter__', 'class ', ' has no ', ' observable event'
        ...

    def remove_observer(self, events, observer_id):
        """Removes the specified observer for the specified events.

No exception is raised if the observer has already been removed.
"""
        # globals: isinstance, int, TypeError, str, hasattr, repr, KeyError
        # attributes: observable_events, __class__, _observers
        # strings: 'Observers should be removed by id', '__iter__', 'class ', ' has no ', ' observable event'
        ...

    def emit_event_for_observer(self, event, observer, observer_data, *args):
        """Emits the specified event for a specific observer. Override this
method if you want the observers to be called in a different
way.

"""
        ...

    def emit_event(self, event, *args):
        """Emits the specified event.

Note that observers will be called in the same thread as emit_event().
"""
        # globals: TypeError, repr, ANY_EVENT, list
        # attributes: observable_events, __class__, _observers, values, emit_event_for_observer
        # strings: 'class ', ' has no ', ' observable event'
        ...

    def all_observers(self):
        """Return a dictionary containing all observers"""
        # attributes: _observers, items, values, append
        ...
