# cxopt — reconstructed outline of CrossOver 26.3 lib/python/cxopt.pyc
# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,
# module-level assignments, classes, signatures, docstrings and the names
# each function references. Function bodies are NOT decompiled (see ../dis).

import optparse
import sys
class Parser(optparse.OptionParser):
    def __init__(self, *args, **kwargs):
        # globals: hasattr, optparse
        # attributes: get, OptionParser, __init__
        # strings: 'epilog', 'format_epilog', 'description', '', ' '
        ...

    def error(self, msg):
        # globals: sys
        # attributes: get_prog_name, stderr, write, exit
        # strings: ':error: ', '\n', ":error: try '", " --help' for more information\n"
        ...
