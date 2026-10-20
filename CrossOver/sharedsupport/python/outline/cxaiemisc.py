# cxaiemisc — reconstructed outline of CrossOver 26.3 lib/python/cxaiemisc.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import os.path
import re
import cxutils
import distversion
import bottlemanagement
import cxaiebase
from cxutils import cxgettext as _
class AIECXFixes(cxaiebase.AIETask):
    def __init__(self, engine):
        # globals: cxaiebase, _
        # attributes: AIETask, __init__
        # strings: 'Preparing the system for this application'
        ...

    def __unicode__(self):
        # attributes: __class__, __name__, scheduler, installtask, bottlename
        # strings: '(', ')'
        ...

    def main(self):
        # attributes: scheduler, clear_errors, installtask, get_cxdiag_messages, items, add_error, title, level, fix_errors, has_errors, markup_error_message, get_error_message, error, ismarkuperror
        # strings: 'required'
        ...


class AIECreateBottle(cxaiebase.AIETask):
    def __init__(self, engine):
        # globals: cxaiebase, _
        # attributes: AIETask, __init__, installtask, bottlename
        # strings: 'Creating the %s bottle'
        ...

    def __unicode__(self):
        # attributes: __class__, __name__, scheduler, installtask, bottlename
        # strings: '(', ')'
        ...

    def main(self):
        # globals: bottlemanagement
        # attributes: scheduler, create_bottle, installtask, bottlename, target_template, state, profile, appid, error
        # strings: 'environ'
        ...


class AIEPreAssoc(cxaiebase.AIETask):
    """This task ensures that cxassoc.conf is up to date before we start
installing applications.

The reason is that if it is out of date, then we may think that
pre-existing associations were created by the installer and then try to
export them to the desktop environment.
"""
    def __init__(self, engine):
        # globals: cxaiebase
        # attributes: AIETask, __init__
        # strings: ''
        ...

    def __unicode__(self):
        # attributes: __class__, __name__
        # strings: '()'
        ...

    def main(self):
        # globals: os, cxutils
        # attributes: scheduler, state, path, join, CX_ROOT, installtask, bottlename, run, GRAB, error
        # strings: 'skipassoc', 'bin', 'cxassoc', '--bottle', '--sync', 'environ'
        ...


def get_bottle_init_task(engine):
    """Returns a task (or task group) with all that needs to be done before we
can start installation tasks that use the bottle.
"""
    # globals: AIECreateBottle, cxaiebase, AIEPreAssoc, AIECXFixes
    # attributes: installtask, GetCreateNewBottle, AIETaskGroup, insert, get_apply_cxfixes, add, add_dependency
    # strings: 'PreInstall'
    ...

class AIESyncMenu(cxaiebase.AIETask):
    def __init__(self, engine):
        # globals: cxaiebase, _
        # attributes: AIETask, __init__
        # strings: 'Refreshing the menus'
        ...

    def __unicode__(self):
        # attributes: __class__, __name__
        # strings: '()'
        ...

    def main(self):
        """Refreshes the desktop environment's menus to reflect the changes
that occurred in the bottle.
Do this scan because winemenubuilder can miss some menu creations,
particularly .url files which are very easy to create manually.
"""
        # globals: os, cxutils
        # attributes: scheduler, path, join, CX_ROOT, installtask, bottlename, state, append, run, GRAB, error
        # strings: 'bin', 'cxmenu', '--bottle', '--sync', '--mode', 'install', 'mainmenu_never', '--mmenu-never', ':', 'environ'
        ...


class AIESyncAssoc(cxaiebase.AIETask):
    def __init__(self, engine):
        # globals: cxaiebase, _
        # attributes: AIETask, __init__
        # strings: 'Refreshing the associations'
        ...

    def __unicode__(self):
        # attributes: __class__, __name__
        # strings: '()'
        ...

    def main(self):
        """Refreshes the desktop environment's associations to reflect the
changes that occurred in the bottle.
"""
        # globals: distversion, os, cxutils, re
        # attributes: scheduler, IS_MACOSX, state, append, join, path, CX_ROOT, installtask, bottlename, run, GRAB, error, escape
        # strings: 'alternative', 'mime', 'defaulteassocs', 'default=', ':', 'alteassocs', 'alternative=', 'bin', 'cxassoc', '--bottle', '--sync', '--sync-mode', '--mode', ';', 'environ'
        ...


def get_postinstall_task(engine):
    """Returns a task (or task group) with all that needs to be done after the
application and all its dependencies have been installed.
"""
    # globals: cxaiebase, AIESyncAssoc, AIESyncMenu
    # attributes: AIETaskGroup, state, insert
    # strings: 'PostInstall', 'skipassoc', 'skipmenu'
    ...
