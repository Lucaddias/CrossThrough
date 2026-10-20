# cxfixesdialog — reconstructed outline of CrossOver 26.3 lib/python/cxfixesdialog.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

from gi.repository import GLib
from gi.repository import Gtk
from gi.repository import Vte
from cxutils import cxgettext as _
class FixDialog:
    def __init__(self, title, text, prompt, command, callback):
        # globals: Gtk, _, Vte
        # attributes: retcode, command, callback, finished, Dialog, dialog, set_title, set_resizable, connect, dialog_response, add_button, STOCK_NO, no, STOCK_YES, yes, grab_default, Label, label, set_text, set_property, set_halign, Align, START, get_content_area, set_size_request, add, show_all, ok, hide, ProgressBar, progress, Terminal, term, set_input_enabled, set_size, Expander, expander, set_label
        # strings: 'response', '\n\n', 'margin', 'Continue', 'Details'
        ...

    def destroy(self):
        # attributes: dialog, destroy, callback
        ...

    def dialog_response(self, _dialog, response):
        # attributes: retcode, run_command, destroy
        ...

    def update_pulse(self):
        # attributes: finished, progress, pulse
        ...

    def run_response(self, _vte, retcode):
        # globals: _
        # attributes: retcode, finished, ok, set_sensitive, progress, set_fraction, label, set_text
        # strings: 'Failed to install missing packages.', 'Finished installing missing packages.'
        ...

    def spawn_cb(self, *args):
        ...

    def run_command(self):
        # globals: _, GLib, Vte, AttributeError
        # attributes: yes, hide, no, ok, show, expander, progress, set_sensitive, label, set_text, timeout_add, update_pulse, term, connect, run_response, spawn_async, PtyFlags, DEFAULT, command, SpawnFlags, spawn_cb, spawn_sync
        # strings: 'Installing…', 'child-exited'
        ...
