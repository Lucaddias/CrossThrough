#!/usr/bin/env python3
"""Recover structure from CrossOver's Python 3.13 bytecode modules.

usage: analyze_python.py <CrossOver.app> <out-dir>

Writes <out-dir>/outline/<module>.py (reconstructed module/class/def outline),
<out-dir>/dis/<module>.dis (complete 3.13 bytecode listing) and
<out-dir>/modules.json (per-module facts used by INDEX.md).
"""
import ast, hashlib, json, os, sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pyc313  # noqa: E402


def main():
    app, out = sys.argv[1:3]
    stdlib = os.path.join(app, 'Contents/Frameworks/Python.framework/Versions/3.13/lib/python3.13')
    pydir = os.path.join(app, 'Contents/SharedSupport/CrossOver/lib/python')
    resources = os.path.join(app, 'Contents/Resources')
    opnames = pyc313.opcode_table(os.path.join(stdlib, '_opcode_metadata.pyc'))
    stdlib_mods = {f.split('.')[0] for f in os.listdir(stdlib)}
    stdlib_mods |= {'sys', 'time', 'marshal', 'posix', 'errno', 'math', 'select', 'fcntl',
                    'pwd', 'grp', 'zlib', 'binascii', '_thread', 'itertools', 'atexit', 'gc',
                    'array', 'unicodedata', 'termios', 'resource', '_socket', 'mmap'}
    for d in ('outline', 'dis'):
        os.makedirs(os.path.join(out, d), exist_ok=True)

    mods = {}
    for fn in sorted(os.listdir(pydir)):
        if not fn.endswith('.pyc'):
            continue
        path = os.path.join(pydir, fn)
        name = fn[:-4]
        header, code = pyc313.load_pyc(path)
        unknown = sorted({i.name for c in pyc313.walk(code) for i in pyc313.decode(c, opnames)
                          if i.name.startswith('<')})
        assert not unknown, (fn, unknown)
        outline = pyc313.outline(code, opnames)
        ins_count = sum(len(pyc313.decode(c, opnames)) for c in pyc313.walk(code))
        with open(os.path.join(out, 'outline', name + '.py'), 'w') as f:
            f.write('# %s — reconstructed outline of CrossOver 26.3 lib/python/%s\n' % (name, fn))
            f.write('# Recovered from CPython 3.13 bytecode by .tools/pyc313.py: imports,\n'
                    '# module-level assignments, classes, signatures, docstrings and the names\n'
                    '# each function references. Function bodies are NOT decompiled (see ../dis).\n\n')
            f.write('\n'.join(outline).rstrip() + '\n')
        with open(os.path.join(out, 'dis', name + '.dis'), 'w') as f:
            f.write('# %s — CPython 3.13 bytecode listing of lib/python/%s\n' % (name, fn))
            f.write('# sha256 %s, pyc flags %d, co_filename %s\n\n'
                    % (hashlib.sha256(open(path, 'rb').read()).hexdigest(), header['flags'],
                       code.filename))
            f.write(pyc313.disassemble(code, opnames))
        mods[name] = facts(name, path, header, code, outline, opnames, ins_count)

    # Plain Python sources shipped next to the GUI (structure only, via ast).
    sources = {}
    for fn in sorted(os.listdir(resources)):
        if fn.endswith('.py'):
            p = os.path.join(resources, fn)
            sources[fn[:-3]] = source_facts(fn[:-3], p)

    internal = set(mods) | set(sources)
    for m in list(mods.values()) + list(sources.values()):
        m['imports_internal'] = sorted({i.split('.')[0] for i in m['imports'] if i.split('.')[0] in internal})
        m['imports_stdlib'] = sorted({i.split('.')[0] for i in m['imports']
                                      if i.split('.')[0] in stdlib_mods and i.split('.')[0] not in internal})
        m['imports_other'] = sorted({i.split('.')[0] for i in m['imports']
                                     if i.split('.')[0] not in internal | stdlib_mods and not i.startswith('.')})
    for m in list(mods.values()) + list(sources.values()):
        m['imported_by'] = sorted(n for n, o in list(mods.items()) + list(sources.items())
                                  if m['module'] in o['imports_internal'] and n != m['module'])
    json.dump({'opcode_table_source': '_opcode_metadata.pyc', 'opcodes': len(opnames),
               'bytecode': mods, 'sources': sources},
              open(os.path.join(out, 'modules.json'), 'w'), indent=1, sort_keys=True)
    print(json.dumps({'modules': len(mods), 'sources': list(sources),
                      'code_objects': sum(m['code_objects'] for m in mods.values()),
                      'instructions': sum(m['instructions'] for m in mods.values())}))


def facts(name, path, header, code, outline, opnames, ins_count):
    data = open(path, 'rb').read()
    imports, classes, funcs = [], [], []
    for line in outline:
        s = line.strip()
        if line.startswith(('import ', 'from ')):
            imports.append(s.split()[1])
        elif line.startswith('class '):
            classes.append(s[6:].split('(')[0].split(':')[0])
        elif line.startswith(('def ', 'async def ')):
            funcs.append(s.split('def ', 1)[1].split('(')[0])
    # also imports done inside functions
    for c in pyc313.walk(code):
        for i in pyc313.decode(c, opnames):
            if i.name == 'IMPORT_NAME' and i.argval not in imports:
                imports.append(i.argval)
    head = pyc313.decode(code, opnames)[:3]
    doc = (head[1].argval if len(head) == 3 and head[1].name == 'LOAD_CONST'
           and head[2].name == 'STORE_NAME' and head[2].argval == '__doc__' else None)
    return {
        'module': name, 'file': 'lib/python/' + os.path.basename(path), 'bytes': len(data),
        'sha256': hashlib.sha256(data).hexdigest(), 'pyc_flags': header['flags'],
        'source_hash': header.get('source_hash'), 'co_filename': code.filename,
        'doc': doc.strip().splitlines()[0] if doc and doc.strip() else None,
        'imports': imports, 'classes': classes, 'functions': funcs,
        'code_objects': sum(1 for _ in pyc313.walk(code)), 'instructions': ins_count,
    }


def source_facts(name, path):
    src = open(path, encoding='utf-8', errors='replace').read()
    tree = ast.parse(src)
    imports, classes, funcs = [], [], []
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            imports += [a.name for a in node.names]
        elif isinstance(node, ast.ImportFrom) and node.module:
            imports.append('.' * node.level + node.module)
    for node in tree.body:
        if isinstance(node, ast.ClassDef):
            classes.append(node.name)
        elif isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef)):
            funcs.append(node.name)
    doc = ast.get_docstring(tree)
    return {'module': name, 'file': 'Contents/Resources/' + os.path.basename(path),
            'bytes': len(open(path, 'rb').read()),
            'sha256': hashlib.sha256(open(path, 'rb').read()).hexdigest(),
            'lines': src.count('\n'), 'doc': doc.splitlines()[0] if doc else None,
            'imports': imports, 'classes': classes, 'functions': funcs}


if __name__ == '__main__':
    main()
