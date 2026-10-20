#!/usr/bin/env python3
"""Map the Objective-C surface of the PyObjC classes and where the GUI uses it.

usage: bridge.py <CrossOver.app> <sharedsupport-dir> <decompiled-dir>

Reads python/outline/*.py (from analyze_python.py) for classes derived from
cxobjc.Proxy / CXMacObject / NSObject and collects their Objective-C names:
cxobjc.object_property/array_property attributes, @cxobjc.namedSelector and
@cxobjc.method selectors, and plain methods that PyObjC exports implicitly
(name with '_' -> ':', minus @python_method). Each name is then looked up in the
GUI: the arm64 __objc_methname strings of Contents/MacOS/CrossOver and the
message sends in the decompiled pseudocode. Writes python/bridge.json and
python/BRIDGE.md.
"""
import glob, json, os, re, struct, sys
from collections import defaultdict

BRIDGED_BASES = ('cxobjc.Proxy', 'cxobjc.CXMacObject', 'Foundation.NSObject', 'CXMacObject', 'Proxy')
CPU_ARM64 = 0x0100000c


def methnames(binary):
    """C strings of __TEXT,__objc_methname in the arm64 slice."""
    b = open(binary, 'rb').read()
    base = 0
    if struct.unpack_from('>I', b, 0)[0] == 0xcafebabe:
        for k in range(struct.unpack_from('>I', b, 4)[0]):
            cpu, _, off, size, _ = struct.unpack_from('>iiIII', b, 8 + 20 * k)
            if cpu == CPU_ARM64:
                base = off
    ncmds = struct.unpack_from('<I', b, base + 16)[0]
    p = base + 32
    for _ in range(ncmds):
        cmd, size = struct.unpack_from('<II', b, p)
        if cmd == 0x19:  # LC_SEGMENT_64
            nsects = struct.unpack_from('<I', b, p + 64)[0]
            for s in range(nsects):
                q = p + 72 + 80 * s
                sect = b[q:q + 16].rstrip(b'\0').decode()
                if sect == '__objc_methname':
                    size_, off = struct.unpack_from('<QI', b, q + 40)[0], struct.unpack_from('<I', b, q + 48)[0]
                    return set(b[base + off:base + off + size_].decode('utf-8', 'replace').split('\0')) - {''}
        p += size
    return set()


def pyobjc_selector(name):
    return name.replace('_', ':')


def bridged_classes(outline_dir):
    """{class: {'module', 'bases', 'properties': [...], 'selectors': [...]}} from the outlines."""
    out = {}
    for path in sorted(glob.glob(os.path.join(outline_dir, '*.py'))):
        mod = os.path.basename(path)[:-3]
        cls, deco, in_doc, code_lines = None, [], False, []
        for line in open(path, encoding='utf-8'):
            s = line.rstrip('\n')
            if s.count('"""') % 2 == 1:  # docstring boundary (outline keeps docstrings verbatim)
                in_doc = not in_doc
                continue
            if in_doc or s.lstrip().startswith('"""'):
                continue
            code_lines.append(s)
            m = re.match(r'class (\w+)\((.*)\):$', s)
            if m:
                bases = [x.strip() for x in m.group(2).split(',')]
                cls = m.group(1)
                out.setdefault(cls, {'module': mod, 'bases': bases, 'properties': [], 'selectors': []})
                deco = []
                continue
            if s and not s.startswith(' '):
                cls, deco = None, []
                continue
            if cls is None:
                continue
            m = re.match(r'    (\w+) = cxobjc\.(object|array|dict)_property\((.*)\)$', s)
            if m:
                kw = dict(re.findall(r"(\w+)=('[^']*'|\[[^]]*\]|[\w.]+)", m.group(3)))
                out[cls]['properties'].append({
                    'objc': m.group(1), 'kind': m.group(2),
                    'python': kw.get('python_name', "'%s'" % m.group(1)).strip("'"),
                    'type': kw.get('typestr', 'id').replace('cxobjc.', ''),
                    'read_only': kw.get('read_only') == 'True',
                    'depends_on': kw.get('depends_on')})
                continue
            m = re.match(r'    @(.*)$', s)
            if m:
                deco.append(m.group(1))
                continue
            m = re.match(r'    (?:async )?def (\w+)\((.*)\):$', s)
            if m:
                name = m.group(1)
                params = [x for x in m.group(2).split(', ') if x and x not in ('/', '*')]
                nargs = len(params) - 1  # self or cls
                named = [re.search(r"b'([^']+)'", d).group(1) for d in deco if d.startswith('cxobjc.namedSelector')]
                hidden = any(d.endswith('python_method') or d in ('property', 'staticmethod') for d in deco)
                if named:
                    out[cls]['selectors'].append({'objc': named[0], 'python': name, 'how': 'namedSelector'})
                elif not hidden and not name.startswith('_') and name.count('_') == nargs:
                    # PyObjC derives a selector only when every argument has a colon
                    out[cls]['selectors'].append({'objc': pyobjc_selector(name), 'python': name,
                                                  'how': 'classmethod' if 'classmethod' in deco else 'implicit'})
                deco = []
            elif not s.startswith('        '):
                deco = []
        # @cxobjc.method(Class, 'sel_') on module-level functions
        text = '\n'.join(code_lines) + '\n'
        for c, sel, fn in re.findall(r"^@cxobjc\.method\((\w+), '([^']+)'\)\n(?:@.*\n)*def (\w+)\(", text, re.M):
            out.setdefault(c, {'module': mod, 'bases': [], 'properties': [], 'selectors': []})
            out[c]['selectors'].append({'objc': pyobjc_selector(sel), 'python': fn, 'how': 'cxobjc.method'})
    # keep classes that reach NSObject through cxobjc (e.g. Engine -> AIEScheduler -> Proxy)
    bridged = {c for c, v in out.items() if any(b in BRIDGED_BASES for b in v['bases'])}
    while True:
        more = {c for c, v in out.items() if c not in bridged
                and any(b.split('.')[-1] in bridged for b in v['bases'])}
        if not more:
            break
        bridged |= more
    return {c: v for c, v in out.items() if c in bridged}


def gui_uses(decompiled_dir, names):
    """For each Objective-C name, the decompiled GUI files that send it as a message."""
    files = sorted(glob.glob(os.path.join(decompiled_dir, 'classes', '*.m'))) + \
        [os.path.join(decompiled_dir, 'c_functions.c')]
    bodies = {os.path.basename(f).rsplit('.', 1)[0]:
              '\n'.join(l for l in open(f, encoding='utf-8') if not l.startswith('//')) for f in files}
    uses = defaultdict(list)
    for n in names:
        first = n.split(':')[0]
        # receiver may itself be a message send one level deep: [[CXSetupLib fooClass] sel]
        pat = re.compile(r'\[(?:[^\[\]\n]|\[[^\[\]\n]*\])*? %s%s' % (re.escape(first), ':' if ':' in n else r'\]'))
        key = re.compile(r'@"%s"' % re.escape(first))
        for f, body in bodies.items():
            if pat.search(body) or key.search(body):
                uses[n].append(f)
    return uses


def main():
    app, root, decompiled = sys.argv[1:4]
    classes = bridged_classes(os.path.join(root, 'python', 'outline'))
    gui_names = methnames(os.path.join(app, 'Contents/MacOS/CrossOver'))
    names = {x['objc'] for c in classes.values() for k in ('properties', 'selectors') for x in c[k]}
    uses = gui_uses(decompiled, names)
    for c in classes.values():
        for k in ('properties', 'selectors'):
            for x in c[k]:
                x['in_gui_methname'] = x['objc'] in gui_names
                x['gui_files'] = uses.get(x['objc'], [])
    json.dump({'source': 'python/outline + Contents/MacOS/CrossOver (arm64 __objc_methname) + decompiled pseudocode',
               'classes': classes}, open(os.path.join(root, 'python', 'bridge.json'), 'w'), indent=1, sort_keys=True)

    md = ['# Ponte Objective-C ↔ Python', '',
          'Gerado por `.tools/bridge.py`. Para cada classe Python visível ao Objective-C: as propriedades '
          'KVC/KVO (`cxobjc.*_property`) e os seletores (`@cxobjc.namedSelector`, `@cxobjc.method`, '
          'ou métodos exportados implicitamente pelo PyObjC, `_` → `:`). '
          '**GUI** marca os nomes que existem em `__objc_methname` da slice arm64 da GUI; '
          '**Usado em** lista os arquivos de pseudocódigo que enviam a mensagem (`[x nome…]`) ou usam o nome como chave (`@"nome"`).', '',
          'A coluna "Usado em" é uma busca textual no pseudocódigo: pode faltar uso indireto '
          '(bindings de nib, `valueForKeyPath:` composto, `performSelector:`) e pode incluir um homônimo de outra classe.', '']
    total = {'props': 0, 'sels': 0, 'props_gui': 0, 'sels_gui': 0}
    for name in sorted(classes, key=lambda n: (classes[n]['module'], n)):
        c = classes[name]
        if not c['properties'] and not c['selectors']:
            continue
        md += ['## `%s` (`%s`)' % (name, c['module']), '']
        if c['properties']:
            md += ['| Propriedade ObjC | Atributo Python | Tipo | Só leitura | GUI | Usado em |', '|---|---|---|---|---|---|']
            for p in c['properties']:
                total['props'] += 1; total['props_gui'] += p['in_gui_methname']
                md.append('| `%s` | `%s` | %s | %s | %s | %s |' % (
                    p['objc'], p['python'], p['type'], 'sim' if p['read_only'] else '',
                    '✓' if p['in_gui_methname'] else '', ', '.join(p['gui_files'][:6]) +
                    (' …' if len(p['gui_files']) > 6 else '')))
            md.append('')
        if c['selectors']:
            md += ['| Seletor ObjC | Função Python | Origem | GUI | Usado em |', '|---|---|---|---|---|']
            for s in c['selectors']:
                total['sels'] += 1; total['sels_gui'] += s['in_gui_methname']
                md.append('| `%s` | `%s` | %s | %s | %s |' % (
                    s['objc'], s['python'], s['how'], '✓' if s['in_gui_methname'] else '',
                    ', '.join(s['gui_files'][:6]) + (' …' if len(s['gui_files']) > 6 else '')))
            md.append('')
    md[1:1] = ['', '%d classes, %d propriedades (%d presentes na GUI), %d seletores (%d presentes na GUI).' % (
        sum(1 for c in classes.values() if c['properties'] or c['selectors']),
        total['props'], total['props_gui'], total['sels'], total['sels_gui'])]
    open(os.path.join(root, 'python', 'BRIDGE.md'), 'w').write('\n'.join(md) + '\n')
    print(json.dumps(total))


if __name__ == '__main__':
    main()
