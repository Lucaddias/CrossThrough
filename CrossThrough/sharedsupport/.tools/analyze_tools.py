#!/usr/bin/env python3
"""Inventory CrossOver's SharedSupport tools and Perl modules (static, read-only).

usage: analyze_tools.py <CrossOver.app> <out-dir>

Writes <out-dir>/tools.json with, for each file in bin/ and lib/perl/: kind,
size, SHA-256, copyright line, package, module dependencies, defined subs,
exports, command-line options, environment variables and the CrossOver
executables it invokes. Nothing is executed and no source text is copied.
"""
import hashlib, json, os, re, struct, sys

CPU = {7: 'i386', 0x01000007: 'x86_64', 12: 'arm', 0x0100000c: 'arm64'}
PRAGMAS = {'strict', 'warnings', 'vars', 'integer', 'bytes', 'utf8', 'lib', 'constant',
           'overload', 'bigint', 'locale', 'open', 'subs', 'fields', 'base', 'parent'}


def macho_archs(b):
    magic = struct.unpack_from('>I', b, 0)[0]
    if magic in (0xcafebabe, 0xcafebabf):
        n = struct.unpack_from('>I', b, 4)[0]
        return [CPU.get(struct.unpack_from('>i', b, 8 + 20 * i)[0], '?') for i in range(n)]
    if struct.unpack_from('<I', b, 0)[0] in (0xfeedfacf, 0xfeedface):
        return [CPU.get(struct.unpack_from('<i', b, 4)[0], '?')]
    return None


def kind_of(path, b):
    if os.path.islink(path):
        return 'symlink'
    if macho_archs(b):
        return 'mach-o'
    first = b.split(b'\n', 1)[0]
    if first.startswith(b'#!') and b'perl' in first:
        return 'perl'
    if first.startswith(b'#!') and (b'/sh' in first or b'bash' in first):
        return 'shell'
    if path.endswith('.pm'):
        return 'perl-module'
    return 'data'


def uniq(seq):
    out = []
    for x in seq:
        if x not in out:
            out.append(x)
    return out


def invoked(code, pattern):
    """CrossOver executables referenced by path, minus plain existence tests (-x/-f)."""
    out = []
    for m in re.finditer(pattern, code):
        before = code[max(0, m.start() - 40):m.start()]
        if re.search(r'-[xfedr]\s+["\']?\$?\{?[\w{}]*$', before) or m.group(1) in out:
            continue
        out.append(m.group(1))
    return out


def perl_facts(text, stem=None):
    code = '\n'.join(l for l in text.splitlines() if not l.lstrip().startswith('#'))
    packages, subs, pkg = [], [], None
    primary = stem if stem and re.search(r'^\s*package\s+%s\s*;' % re.escape(stem), code, re.M) else None
    saved = []
    for line in code.splitlines():
        # `{ package X; ... }` blocks at column 0 scope the package declaration
        if line.rstrip() == '{':
            saved.append(pkg)
        elif line.rstrip() == '}' and saved:
            pkg = saved.pop()
        m = re.match(r'\s*package\s+([\w:]+)\s*;', line)
        if m:
            pkg = m.group(1)
            packages.append(pkg)
            continue
        m = re.match(r'\s*sub\s+(\w+)', line)
        if m:  # qualify subs that live in a secondary package of the file
            main = primary  # None for scripts: subs outside any package belong to main
            subs.append(m.group(1) if pkg is None or pkg == main else '%s::%s' % (pkg, m.group(1)))
    f = {
        'package': uniq(packages),
        'uses': uniq(m for m in re.findall(r'^\s*(?:use|require)\s+([A-Za-z][\w:]*)', code, re.M)
                     if m not in PRAGMAS),
        'subs': uniq(subs),
        'exports': uniq(sum((m.split() for m in re.findall(r'@EXPORT(?:_OK)?\s*=\s*qw\(([^)]*)\)', code)), [])),
        'env': uniq(re.findall(r'\$ENV\{\s*["\']?(\w+)["\']?\s*\}', code)),
        'invokes': invoked(code, r'\{CX_ROOT\}/bin/([\w.-]+)'),
    }
    opts = []
    for block in re.findall(r'add_options\(\s*\[(.*?)\]\s*\)', code, re.S):
        for name, spec in re.findall(r'"([\w-]+)([!=:][^"]*)?"\s*=>', block):
            opts.append('--' + name + (spec or ''))
    f['options'] = uniq(opts)
    return f


def shell_facts(text):
    code = '\n'.join(l for l in text.splitlines() if not l.lstrip().startswith('#'))
    return {
        'functions': uniq(re.findall(r'^\s*(\w+)\s*\(\)\s*\{?', code, re.M)),
        'env': uniq(v for v in re.findall(r'\$\{?([A-Z_][A-Z0-9_]*)', code)),
        'invokes': invoked(code, r'(?:CX_ROOT\}?/bin|bindir\}?|BINDIR\}?)/([\w.-]+)'),
    }


def describe(path, rel):
    b = open(path, 'rb').read() if not os.path.islink(path) else b''
    k = kind_of(path, b)
    e = {'path': rel, 'kind': k}
    if k == 'symlink':
        e['target'] = os.readlink(path)
        return e
    e['bytes'] = len(b)
    e['sha256'] = hashlib.sha256(b).hexdigest()
    if k == 'mach-o':
        e['architectures'] = macho_archs(b)
        return e
    text = b.decode('utf-8', 'replace')
    e['lines'] = text.count('\n')
    m = re.search(r'^#\s*\(c\)\s*Copyright\s+(.*?)\.?\s*$', text, re.M | re.I)
    if m:
        e['copyright'] = m.group(1)
    if k in ('perl', 'perl-module'):
        e.update(perl_facts(text, os.path.basename(path).rsplit('.', 1)[0]))
    elif k == 'shell':
        e.update(shell_facts(text))
    return e


def main():
    app, out = sys.argv[1:3]
    root = os.path.join(app, 'Contents/SharedSupport/CrossOver')
    entries = []
    bindir = os.path.join(root, 'bin')
    for fn in sorted(os.listdir(bindir)):
        entries.append(describe(os.path.join(bindir, fn), 'bin/' + fn))
    perldir = os.path.join(root, 'lib/perl')
    for dp, dns, fns in os.walk(perldir):
        dns.sort()
        for fn in sorted(fns):
            p = os.path.join(dp, fn)
            entries.append(describe(p, os.path.relpath(p, root)))
    for e in entries:
        if e.get('kind') in ('perl', 'perl-module'):
            e['internal_uses'] = [u for u in e['uses'] if u.startswith(('CX', 'XML::'))]
    mods = {e['package'][0]: e['path'] for e in entries if e.get('package')}
    for e in entries:
        if e.get('package'):
            name = e['package'][0]
            e['used_by'] = [x['path'] for x in entries if name in x.get('uses', ()) and x is not e]
    os.makedirs(out, exist_ok=True)
    json.dump({'root': 'Contents/SharedSupport/CrossOver', 'perl_packages': mods, 'files': entries},
              open(os.path.join(out, 'tools.json'), 'w'), indent=1)
    from collections import Counter
    print(json.dumps(Counter(e['kind'] for e in entries)))


if __name__ == '__main__':
    main()
