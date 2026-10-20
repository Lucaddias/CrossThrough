# cxaiebase — reconstructed outline of CrossOver 26.3 lib/python/cxaiebase.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import threading
import cxlog
import cxobjc
TASK_QUEUED = 0
TASK_RUNNABLE = 1
TASK_RUNNING = 2
TASK_DONE = 3
STATUS_STR = ['queued', 'runnable', 'running', 'done']
_TASK_SCHEDULED = set((TASK_RUNNING, TASK_DONE))
class AIETask:
    """Represents a task that can be run by the AIEScheduler."""
    error = None
    ismarkuperror = False
    interactive = False
    download_task = False
    def __init__(self, scheduler, label):
        """The label specifies how to call this task in the GUI."""
        # globals: set, TASK_RUNNABLE
        # attributes: scheduler, add, label, dependencies, parents, add_runnable, _status
        ...

    def add_dependency(self, dependency):
        """Makes this task depend on the completion of the specified task."""
        # attributes: scheduler, lock, parents, add, dependencies, remove_runnable, unlock
        ...

    def remove_dependency(self, dependency):
        """Removes the specified dependency."""
        # globals: _TASK_SCHEDULED
        # attributes: scheduler, lock, parents, remove, dependencies, discard, _status, add_runnable, unlock
        ...

    def clear_dependencies(self):
        """Removes all the dependencies."""
        # globals: _TASK_SCHEDULED
        # attributes: scheduler, lock, dependencies, parents, discard, clear, _status, add_runnable, unlock
        ...

    def is_runnable(self):
        """Returns True is the object can be run, and false otherwise.

Any task that has no unfulfilled dependencies is put on the
scheduler's runnable list, and normally is_runnable() returns True in
that case. But one can override this function to prevent an otherwise
runnable task from being run by checking for some other criteria. See
also schedule().
"""
        # globals: _TASK_SCHEDULED
        # attributes: _status, dependencies
        ...

    def can_run(self):
        """Returns True if the task can be run now, False otherwise.

Together with is_runnable() this can be used to ensure that only one
instance of a given type of task is being run at a given time.
"""
        # attributes: is_runnable
        ...

    def _getniceness(self):
        """Returns a value to help decide which of two runnable tasks to run
first.

Specifically, the task with the lowest niceness value should be run
first. This is so that a regular sort returns them in the recommended
run order.
"""
        ...

    niceness = property(_getniceness)
    def schedule(self):
        """Tells the task that it will be run now."""
        # globals: TASK_RUNNING
        # attributes: _status
        ...

    def can_cancel(self):
        """Returns True if the task can be canceled."""
        ...

    def canCancel(self):
        # attributes: can_cancel
        ...

    def cancel(self):
        """Tells the task to stop whatever main() is doing as soon as it can.

Tasks that cannot be interrupted need not do anything.
This raises RuntimeError if the task was not started yet.
"""
        # globals: _TASK_SCHEDULED, RuntimeError
        # attributes: _status
        ...

    def done(self):
        """Marks this task as done and update the tasks that depend on it.

Note that the main() method does not mark a task as done. Only
this function does. It's perfectly valid to call done() without
actually running the task if the caller thinks it can replace it (for
downloads for instance), or decides it should not be run after all.
"""
        # globals: _TASK_SCHEDULED, TASK_DONE
        # attributes: scheduler, lock, _status, schedule, done, parents, dependencies, discard, status, append, add_runnable, clear, unlock
        ...

    def _getstatus(self):
        # globals: TASK_QUEUED, TASK_RUNNABLE
        # attributes: _status, dependencies
        ...

    status = property(_getstatus)
    def main(self):
        """Performs the task and returns True for success and False for
failure.

Note that this method does not call done(). Doing so is the
responsibility of the caller. This makes it possible to call this
method again in case of failure.
"""
        # globals: NotImplementedError
        ...


def task_sort_key(task):
    # attributes: niceness
    ...

def tasks_str(iterable):
    """Converts a sequence of tasks into a human-readable string."""
    # globals: str, isinstance, set, list
    # attributes: append, join
    # strings: 'None', ', ', 'set([', '])', '[', ']', '(', ')'
    ...

class AIENop(AIETask):
    """This task does nothing.

Its use is as a focal point for dependencies. For instance if you have two
or maybe three tasks that need to be done before a bunch of others, you
can create an AIENop instance, make all the other tasks depend on it, and
then make the AIENop instance depend on the tasks that must be done first
as you determine what those are.
"""
    def __init__(self, scheduler, logname=''):
        # globals: AIETask
        # attributes: __init__, logname
        # strings: ''
        ...

    def __unicode__(self):
        # attributes: __class__, __name__, logname
        # strings: '(', ')'
        ...

    def main(self):
        """Does nothing."""
        ...


class AIETaskGroup(AIENop):
    """Makes it possible to manipulate a group of tasks as if they were a
single task.

To add a task to the group, make it depend on group.first, and make
group.last depend on it. Only the first task in a chain need to depend on
group.first, and similarly only the last one needs to be depended upon by
group.last.
"""
    def __init__(self, scheduler, logname='', first=None, last=None):
        # globals: AIENop
        # attributes: __init__, first, last, add_dependency
        # strings: ' (Group)', ' (First)', ' (Last)'
        ...

    def add_dependency(self, dependency):
        """Makes the first task of the group depend on the specified task."""
        # attributes: first, add_dependency
        ...

    def remove_dependency(self, dependency):
        """Removes the specified dependency."""
        # attributes: first, add_dependency
        ...

    def insert(self, task):
        """Inserts a task between the group's first and last tasks."""
        # attributes: add_dependency, first, last
        ...


class AIEScheduler(cxobjc.Proxy):
    """Schedules AIETasks for execution in an order that respects their
dependencies.

Note that this class does not actually run the tasks; this is the
responsibility of the caller. Also it provides a userdata mapping attribute
that third parties can use to store or cache data related to this
scheduler.
"""
    def __init__(self):
        # globals: cxobjc, set, threading
        # attributes: Proxy, __init__, _tasks, _runnable, Lock, _lock, userdata
        ...

    def lock(self):
        """Locks the scheduler to make some operations thread-safe."""
        # attributes: _lock, acquire
        ...

    def unlock(self):
        """Unlocks the scheduler."""
        # attributes: _lock, release
        ...

    @cxobjc.python_method
    def add(self, task):
        """Registers a new task to be run."""
        # attributes: _tasks, add
        ...

    @cxobjc.python_method
    def done(self, task):
        """Tasks use this function to tell the scheduler they are done."""
        # attributes: _runnable, discard, _tasks
        ...

    @cxobjc.python_method
    def add_runnable(self, task):
        """Moves the task to the set of runnable tasks.

A task calls this function when all its dependencies have been
fulfilled. Note that this does not mean that it can actually be run
right away as it can impose other constraints through its can_run()
method.
"""
        # attributes: _runnable, add
        ...

    @cxobjc.python_method
    def remove_runnable(self, task):
        """Removes a task from the set of runnable tasks.

This can either be called by a task when a dependency is added to it,
or by the scheduler itself when a runnable task is scheduled.
"""
        # attributes: _runnable, discard
        ...

    def sortedRunnable(self):
        """A convenience method for objc. It returns the current
Runnable set sorted by niceness.

This is doubly helpful in objc because it returns a list
rather than a set (which is what runnable is, ordinarily.)
Sets are opaque in objc.
"""
        # globals: sorted, task_sort_key
        # attributes: runnable
        ...

    def runnable(self):
        """Iterates over the runnable tasks.

Note this iterator may raise StopIteration even though there are still
tasks to be run. In particular this happens if none of the remaining
tasks are runnable because they are waiting for other tasks to
complete.
"""
        # globals: set, cxlog, RuntimeError
        # attributes: _runnable, can_run, add, log_
        # strings: 'aie', 'No more runnable tasks'
        ...

    @cxobjc.namedSelector(b'schedule:')
    def schedule(self, task):
        """This function MUST be called before starting to run a task. It
tells the task that it is about to be run, removes it from the set of
runnable tasks and returns True.

If it turns out the task cannot be run, then returns False.
"""
        # globals: cxlog
        # attributes: lock, _runnable, can_run, log_, niceness, to_str, unlock, remove_runnable, schedule
        # strings: 'aie', '%d: %s cannot run', 'Scheduled %d: %s'
        ...

    @cxobjc.python_method
    def all_done(self):
        """Returns True if there is no more task to run."""
        # globals: cxlog
        # attributes: _tasks, log_
        # strings: 'aie', 'All Done '
        ...

    def allDone(self):
        # attributes: all_done
        ...

    @cxobjc.python_method
    def _sort_tasks(self, task, tasks, seen):
        # globals: sorted, task_sort_key
        # attributes: add, dependencies, _sort_tasks, append
        ...

    @cxobjc.namedSelector(b'sortedTasks')
    def get_sorted_tasks(self):
        """Returns a list of the tasks roughly sorted in their execution order.
        """
        # globals: set
        # attributes: lock, _tasks, parents, _sort_tasks, unlock
        ...

    @cxobjc.python_method
    def dump_task(self, prefix, task, dumped):
        # globals: TASK_DONE, TASK_RUNNING, cxlog
        # attributes: status, append, _runnable, can_run, join, log_, to_str, add, dependencies, dump_task
        # strings: 'done', 'running', 'runnable', 'cannot-run', 'dumped already', ' (', ', ', ')', '', 'aie', '| '
        ...

    def dump_tasks(self):
        # globals: cxlog, len, set
        # attributes: log_, _tasks, add, parents, dump_task
        # strings: 'aie', '+-- Dumping %d tasks', '| ', '| There are some phantom tasks', '+-- %d tasks dumped'
        ...

    @cxobjc.python_method
    def check(self, label, dump=False):
        # globals: _TASK_SCHEDULED, cxlog, STATUS_STR, len
        # attributes: _tasks, dependencies, status, _runnable, log_, to_str, err, dump_tasks
        # strings: 'aie', ': Found AIEScheduler bugs', 'in ', '', '%s (status=%s, deps=%d) is %srunnable'
        ...
