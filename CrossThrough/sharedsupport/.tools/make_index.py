#!/usr/bin/env python3
"""Render TOOLS.md and python/INDEX.md from tools.json and python/modules.json.

usage: make_index.py <sharedsupport-dir>
"""
import json, os, sys


def code(xs, limit=None):
    xs = list(xs)
    more = ''
    if limit and len(xs) > limit:
        more, xs = ' … (+%d)' % (len(xs) - limit), xs[:limit]
    return ', '.join('`%s`' % x for x in xs) + more if xs else '—'


def tools_md(root):
    d = json.load(open(os.path.join(root, 'tools.json')))
    files = d['files']
    out = ['# Ferramentas e módulos Perl de `SharedSupport/CrossOver`', '',
           'Gerado por `.tools/make_index.py` a partir de [`tools.json`](tools.json). '
           'Os fatos (dependências, subs, opções, variáveis de ambiente, executáveis chamados) '
           'foram extraídos estaticamente; nenhum script foi executado.', '',
           '## `bin/` (`CrossOver-Hosted Application`)', '',
           '| Arquivo | Tipo | Linhas | Usa | Opções | Variáveis de ambiente | Chama |',
           '|---|---|---|---|---|---|---|']
    for e in files:
        if not e['path'].startswith('bin/'):
            continue
        name = '`%s`' % e['path'][4:]
        if e['kind'] == 'symlink':
            out.append('| %s | symlink → `%s` | | | | | |' % (name, e['target']))
        elif e['kind'] == 'mach-o':
            out.append('| %s | Mach-O %s | | | | | |' % (name, '/'.join(e['architectures'])))
        else:
            out.append('| %s | %s | %d | %s | %s | %s | %s |' % (
                name, e['kind'], e['lines'], code(e.get('internal_uses', [])),
                code(e.get('options', []), 12), code(e.get('env', []), 10),
                code(e.get('invokes', []))))
    out += ['', '## `lib/perl/` (módulos CodeWeavers)', '',
            '| Módulo | Linhas | Pacotes | Usa | Usado por | Subs | Exporta | Variáveis de ambiente |',
            '|---|---|---|---|---|---|---|---|']
    third = []
    for e in files:
        if not e['path'].startswith('lib/perl/'):
            continue
        if e['path'].startswith('lib/perl/XML/'):
            third.append(e)
            continue
        out.append('| `%s` | %d | %s | %s | %s | %d | %s | %s |' % (
            e['path'][9:], e['lines'], code(e.get('package', [])),
            code(e.get('internal_uses', [])),
            code(os.path.basename(p) for p in e.get('used_by', [])),
            len(e.get('subs', [])), code(e.get('exports', []), 12), code(e.get('env', []))))
    out += ['', '### Subs por módulo', '']
    for e in files:
        if e['path'].startswith('lib/perl/CX') or (e['path'].startswith('bin/') and e.get('subs')):
            out.append('- **`%s`**: %s' % (e['path'], code(e.get('subs', []))))
    out += ['', '## `lib/perl/XML/` (terceiros)', '',
            'Cópias embarcadas de `XML::DOM`, `XML::SAX`, `XML::NamespaceSupport` e `XML::RegExp` '
            '(módulos CPAN). Só o inventário:', '',
            '| Arquivo | Linhas | SHA-256 |', '|---|---|---|']
    for e in third:
        out.append('| `%s` | %d | `%s` |' % (e['path'][9:], e['lines'], e['sha256'][:16]))
    out += ['', '## Integridade', '', '| Arquivo | Bytes | SHA-256 |', '|---|---|---|']
    for e in files:
        if e.get('sha256') and not e['path'].startswith('lib/perl/XML/'):
            out.append('| `%s` | %d | `%s` |' % (e['path'], e['bytes'], e['sha256']))
    open(os.path.join(root, 'TOOLS.md'), 'w').write('\n'.join(out) + '\n')


def python_md(root):
    d = json.load(open(os.path.join(root, 'python', 'modules.json')))
    mods, srcs = d['bytecode'], d['sources']
    out = ['# Módulos Python de `SharedSupport/CrossOver/lib/python`', '',
           'Os %d módulos vêm só como bytecode CPython 3.13 (`.pyc` hash-based, flags 3). '
           'Para cada um há um esboço reconstruído em [`outline/`](outline) e a desmontagem '
           'completa em [`dis/`](dis). Gerado por `.tools/make_index.py` a partir de '
           '[`modules.json`](modules.json).' % len(mods), '',
           '| Módulo | Docstring | Classes | Funções | Code objects | Instruções | Importa (internos) | Importa (externos) |',
           '|---|---|---|---|---|---|---|---|']
    for n, m in sorted(mods.items()):
        out.append('| [`%s`](outline/%s.py) | %s | %s | %d | %d | %d | %s | %s |' % (
            n, n, (m['doc'] or '—').replace('|', '\\|'), code(m['classes'], 8), len(m['functions']),
            m['code_objects'], m['instructions'], code(m['imports_internal']),
            code(m['imports_other'])))
    out += ['', '## Quem importa quem', '']
    for n, m in sorted(mods.items()):
        out.append('- `%s` ← %s' % (n, code(m['imported_by'])))
    out += ['', '## Fontes `.py` em `Contents/Resources`', '',
            '| Arquivo | Linhas | Classes | Funções | Importa (internos) | Importa (externos) |',
            '|---|---|---|---|---|---|']
    for n, m in sorted(srcs.items()):
        out.append('| `%s` | %d | %s | %s | %s | %s |' % (
            m['file'], m['lines'], code(m['classes']), code(m['functions']),
            code(m['imports_internal']), code(m['imports_other'])))
    out += ['', '## Integridade', '', '| Arquivo | Bytes | SHA-256 | `co_filename` |', '|---|---|---|---|']
    for n, m in sorted(mods.items()):
        out.append('| `%s` | %d | `%s` | `%s` |' % (m['file'], m['bytes'], m['sha256'],
                                                    m['co_filename'].split('/Contents/')[-1]))
    for n, m in sorted(srcs.items()):
        out.append('| `%s` | %d | `%s` | — |' % (m['file'], m['bytes'], m['sha256']))
    open(os.path.join(root, 'python', 'INDEX.md'), 'w').write('\n'.join(out) + '\n')


if __name__ == '__main__':
    tools_md(sys.argv[1])
    python_md(sys.argv[1])
