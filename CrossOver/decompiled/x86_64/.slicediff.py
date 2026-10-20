#!/usr/bin/env python3
"""Map and compare the x86_64 and arm64 slices of CrossOver.app/Contents/MacOS/CrossOver.

Inputs are REA evidence (inspect_with_objdump `symbols` + `disassemble` for each
thin slice, exported with export_evidence_bundle) plus the thin slices produced by
`lipo -thin`. The Mach-O reader below only resolves addresses that the objdump
text leaves unsymbolized (selector refs, stubs/GOT, C strings, CFStrings, class
refs); it never executes the target.

usage: .slicediff.py <rea-bundle.json> <thin-x86_64> <thin-arm64> <out-dir>
"""
import collections, hashlib, json, os, re, struct, sys

# ---------------------------------------------------------------- Mach-O ---

S_TYPE = {0x6: 'nl_ptr', 0x7: 'la_ptr', 0x8: 'stubs'}
M64 = (1 << 64) - 1


class MachO:
    def __init__(self, path):
        self.path = path
        self.b = b = open(path, 'rb').read()
        self.sha256 = hashlib.sha256(b).hexdigest()
        magic, self.cpu, _, _, ncmds, _, _, _ = struct.unpack_from('<IiiIIIII', b, 0)
        assert magic == 0xfeedfacf, 'thin 64-bit Mach-O expected'
        self.sections, self.segments = [], []
        self.syms, self.indirect = [], []
        bind = None
        off = 32
        for _ in range(ncmds):
            cmd, cs = struct.unpack_from('<II', b, off)
            if cmd == 0x19:  # LC_SEGMENT_64
                seg = b[off + 8:off + 24].rstrip(b'\0').decode()
                vm, vms, fo, fs = struct.unpack_from('<QQQQ', b, off + 24)
                nsect = struct.unpack_from('<I', b, off + 64)[0]
                self.segments.append((seg, vm, vms, fo))
                so = off + 72
                for _ in range(nsect):
                    name = b[so:so + 16].rstrip(b'\0').decode()
                    addr, size, foff = struct.unpack_from('<QQI', b, so + 32)
                    flags, r1, r2 = struct.unpack_from('<III', b, so + 64)
                    self.sections.append(dict(seg=seg, name=name, addr=addr, size=size,
                                              off=foff, type=flags & 0xff, r1=r1, r2=r2))
                    so += 80
            elif cmd == 0x2:  # LC_SYMTAB
                symoff, nsyms, stroff, _ = struct.unpack_from('<IIII', b, off + 8)
                for i in range(nsyms):
                    strx, ntype, nsect, _, val = struct.unpack_from('<IBBHQ', b, symoff + 16 * i)
                    e = b.index(b'\0', stroff + strx)
                    self.syms.append((b[stroff + strx:e].decode('utf-8', 'replace'), ntype, nsect, val))
            elif cmd == 0xb:  # LC_DYSYMTAB
                ioff, n = struct.unpack_from('<II', b, off + 56)
                self.indirect = list(struct.unpack_from('<%dI' % n, b, ioff))
            elif cmd in (0x22, 0x80000022):  # LC_DYLD_INFO(_ONLY)
                bind = struct.unpack_from('<II', b, off + 16)
            off += cs
        self.imports = {}  # stub / symbol-pointer address -> imported symbol
        self.bound = {}    # any other address bound by dyld (class refs, CFString isa, ...)
        for s in self.sections:
            kind = S_TYPE.get(s['type'])
            if not kind:
                continue
            step = s['r2'] if kind == 'stubs' else 8
            for i in range(s['size'] // step):
                idx = self.indirect[s['r1'] + i]
                if idx & 0xC0000000:
                    continue  # INDIRECT_SYMBOL_LOCAL / ABS
                self.imports[s['addr'] + i * step] = self.syms[idx][0]
        if bind:
            self._binds(*bind)
        self.local = {}
        for name, ntype, nsect, val in self.syms:
            if nsect and not ntype & 0xe0:  # defined, not a stab
                self.local.setdefault(val, name)

    def _binds(self, off, size):
        """Decode classic bind opcodes so external class refs resolve to names."""
        b, p, end = self.b, off, off + size
        seg = sym = None
        addr = 0

        def uleb():
            nonlocal p
            r = s = 0
            while True:
                x = b[p]; p += 1
                r |= (x & 0x7f) << s; s += 7
                if x < 0x80:
                    return r

        while p < end:
            op, imm = b[p] & 0xf0, b[p] & 0x0f
            p += 1
            if op == 0x00:
                if imm == 0: break
            elif op in (0x10, 0x30, 0x50): pass
            elif op == 0x20: uleb()
            elif op == 0x40:
                e = b.index(b'\0', p); sym = b[p:e].decode(); p = e + 1
            elif op == 0x60: uleb()
            elif op == 0x70:
                seg = self.segments[imm]; addr = seg[1] + uleb()
            elif op == 0x80: addr = (addr + uleb()) & M64
            elif op == 0x90:
                self.bound[addr] = sym; addr += 8
            elif op == 0xa0:
                self.bound[addr] = sym; addr = (addr + 8 + uleb()) & M64
            elif op == 0xb0:
                self.bound[addr] = sym; addr += 8 + imm * 8
            elif op == 0xc0:
                cnt, skip = uleb(), uleb()
                for _ in range(cnt):
                    self.bound[addr] = sym; addr = (addr + 8 + skip) & M64

    def section_at(self, a):
        for s in self.sections:
            if s['addr'] <= a < s['addr'] + s['size']:
                return s
        return None

    def read(self, a, n):
        s = self.section_at(a)
        if not s or s['type'] == 0x1:  # zerofill
            return None
        o = s['off'] + a - s['addr']
        return self.b[o:o + n]

    def u64(self, a):
        r = self.read(a, 8)
        return struct.unpack('<Q', r)[0] if r and len(r) == 8 else None

    def cstr(self, a):
        s = self.section_at(a)
        if not s:
            return None
        o = s['off'] + a - s['addr']
        e = self.b.find(b'\0', o, s['off'] + s['size'])
        return self.b[o:e if e >= 0 else s['off'] + s['size']].decode('utf-8', 'replace')

    def cfstring(self, a):
        flags, ptr, ln = struct.unpack('<QQQ', self.read(a + 8, 24))
        if flags & 0x10:  # UTF-16 literal in __ustring
            return self.read(ptr, 2 * ln).decode('utf-16-le', 'replace')
        return self.cstr(ptr)

    def class_name(self, a):
        """class_t -> class_ro_t -> name."""
        ro = self.u64(a + 32)
        if ro is None:
            return None
        nm = self.u64((ro & ~7) + 24)
        return self.cstr(nm) if nm else None

    def strings(self, sect):
        out = []
        for s in self.sections:
            if s['name'] == sect:
                data = self.b[s['off']:s['off'] + s['size']]
                out += [x.decode('utf-8', 'replace') for x in data.split(b'\0') if x]
        return out

    def cfstrings(self):
        out = []
        for s in self.sections:
            if s['name'] == '__cfstring':
                out += [self.cfstring(s['addr'] + i) for i in range(0, s['size'], 32)]
        return out

    def classify(self, a):
        """Return (kind, value) for a referenced address, or None."""
        s = self.section_at(a)
        if not s:
            return None
        n = s['name']
        if a in self.imports:
            return 'import', self.imports[a]
        if n == '__text':
            return ('call', self.local.get(a)) if a in self.local else None
        if n == '__objc_selrefs':
            return 'sel', self.cstr(self.u64(a))
        if n in ('__objc_classrefs', '__objc_superrefs'):
            p = self.u64(a)
            if p:
                return 'class', self.class_name(p) or self.local.get(p)
            nm = self.bound.get(a)
            return 'class', nm and nm.replace('_OBJC_CLASS_$_', '')
        if n == '__cstring':
            return 'str', self.cstr(a)
        if n == '__cfstring':
            return 'cfstr', self.cfstring(a - (a - s['addr']) % 32)
        if n == '__objc_methname':
            return 'sel', self.cstr(a)
        if n == '__objc_data':
            nm = self.local.get(a)
            return ('class', nm.replace('_OBJC_CLASS_$_', '')) if nm else None
        if n == '__objc_ivar':
            nm = self.local.get(a)
            return ('ivar', nm.replace('_OBJC_IVAR_$_', '')) if nm else None
        if a in self.bound:
            return 'import', self.bound[a]
        nm = self.local.get(a)
        return ('data', nm) if nm else None


# ------------------------------------------------------------ evidence -----

def evidence(bundle, subject_suffix, op):
    for r in bundle['records']:
        e = r.get('evidence', r)
        if (e['operation'] == 'inspect_with_objdump' and e['parameters'].get('operation') == op
                and e['subject']['name'].endswith(subject_suffix)):
            assert not e['raw_result']['output_truncated']
            return e
    raise SystemExit('missing %s %s evidence' % (subject_suffix, op))


def text_symbols(ev):
    rows = []
    for l in ev['raw_result']['stdout'].splitlines():
        m = re.match(r'^([0-9a-f]{16}) .{7} __TEXT,__text\s+(?:\.hidden )?(.*)$', l)
        if m and m.group(2) != '__mh_execute_header':  # header symbol, not code
            rows.append((int(m.group(1), 16), m.group(2)))
    return sorted(rows)


FUNC = re.compile(r'^([0-9a-f]{16}) <(.*)>:$')
INS = re.compile(r'^\s*([0-9a-f]+):\s+(?:[0-9a-f]{2} )*[0-9a-f]*\s+(\S+)\s*(.*)$')
NOISE = re.compile(r'^_objc_(retain|release|autorelease|storeStrong|msgSend|msgSendSuper2|'
                   r'loadWeakRetained|initWeak|destroyWeak|storeWeak|copyWeak|moveWeak|'
                   r'unsafeClaimAutoreleasedReturnValue|retainAutoreleasedReturnValue|'
                   r'claimAutoreleasedReturnValue|retainBlock|autoreleaseReturnValue|'
                   r'retainAutorelease|getProperty|setProperty|alloc|opt_class|opt_self)'
                   r'|^__Block_object_|^_objc_msgSend|^___stack_chk')
BLOCKSUF = re.compile(r'(_block_invoke(?:_\d+)?)\.\d+$')


def norm_name(n):
    return BLOCKSUF.sub(r'\1', n) if n else n


def fingerprints(macho, disasm, arm, strict=False):
    """Per-function multisets of referenced selectors, strings, imports, classes, calls.

    x86_64 references are exact (objdump prints RIP-relative targets). arm64
    targets come from adrp+add/ldr pairs: strict=True trusts a page register only
    within one basic block (may miss hoisted adrp), strict=False keeps it across
    the linear listing (may pick up a stale page)."""
    fps, cur, regs, fname = {}, None, {}, None
    # Basic-block leaders: adrp state is only trusted inside one straight-line block.
    leaders = {int(t, 16) for t in re.findall(
        r'\t(?:b|b\.\w+|cbn?z|tbn?z)\t[^\n]*?(0x[0-9a-f]+) <', disasm)} if arm and strict else set()
    for line in disasm.splitlines():
        m = FUNC.match(line)
        if m:
            cur = fps.setdefault(int(m.group(1), 16), collections.defaultdict(collections.Counter))
            regs, fname = {}, m.group(2)
            continue
        if cur is None:
            continue
        m = INS.match(line)
        if not m:
            continue
        mn, ops = m.group(2), m.group(3)
        targets = []
        if arm and int(m.group(1), 16) in leaders:
            regs = {}
        if arm:
            # Track adrp pages per register; any other write invalidates them.
            ops_n = re.sub(r'\bw(\d+)\b', r'x\1', ops)
            dst = re.match(r'(x\d+|sp)\b', ops_n)
            dst = dst.group(1) if dst else None
            om = re.match(r'(x\d+), (0x[0-9a-f]+)', ops_n)
            if mn == 'adrp' and om:
                regs[om.group(1)] = int(om.group(2), 16)
                continue
            newval = None
            am = re.match(r'(x\d+), (x\d+), #(0x[0-9a-f]+)$', ops_n)
            if mn == 'add' and am and am.group(2) in regs:
                newval = regs[am.group(2)] + int(am.group(3), 16)
                targets.append(newval)
            lm = re.match(r'(x\d+), \[(x\d+)(?:, #(0x[0-9a-f]+))?\]$', ops_n)
            if mn.startswith('ldr') and lm and lm.group(2) in regs:
                targets.append(regs[lm.group(2)] + int(lm.group(3) or '0', 16))
            if dst and not mn.startswith(('st', 'cmp', 'cmn', 'tst', 'cb', 'tb', 'b', 'ret', 'ccmp')):
                if newval is not None:
                    regs[dst] = newval
                else:
                    regs.pop(dst, None)
            if mn in ('bl', 'blr'):
                for r in range(0, 19):  # caller-saved registers are clobbered
                    regs.pop('x%d' % r, None)
            elif strict and (mn in ('b', 'br', 'ret') or mn.startswith(('b.', 'cb', 'tb'))):
                regs = {}  # block ends
            bm = re.match(r'(0x[0-9a-f]+)(?: <(.*)>)?', ops)
            if mn in ('bl', 'b') and bm:
                name = bm.group(2) or ''
                if name.startswith('_objc_msgSend$'):
                    cur['sel'][name[len('_objc_msgSend$'):]] += 1
                    continue
                if mn == 'b' and name.startswith(fname + '+'):
                    continue  # intra-function branch
                targets.append(int(bm.group(1), 16))
        else:
            for t in re.findall(r'## (0x[0-9a-f]+)', ops):
                targets.append(int(t, 16))
            bm = re.match(r'(0x[0-9a-f]+)(?: <(.*)>)?', ops)
            if mn in ('callq', 'jmp') and bm:
                name = bm.group(2) or ''
                if mn == 'jmp' and name.startswith(fname + '+'):
                    continue  # intra-function branch
                targets.append(int(bm.group(1), 16))
        for t in targets:
            c = macho.classify(t)
            if c and c[1] is not None:
                k, v = c
                if k == 'import' and v.startswith('_OBJC_CLASS_$_'):
                    k, v = 'class', v[len('_OBJC_CLASS_$_'):]
                elif k == 'import':
                    v = re.sub(r'_x\d+$', '', v)
                if k == 'call':
                    v = norm_name(v)
                cur[k][v] += 1
    return fps


def facets(fp):
    """Architecture-neutral view: sets, with ABI noise removed."""
    return {
        'sel': set(fp.get('sel', ())),
        'str': set(fp.get('str', ())) | set('@' + x for x in fp.get('cfstr', ())),
        'class': set(fp.get('class', ())),
        'import': {x for x in fp.get('import', ()) if not NOISE.search(x)},
        'call': {x for x in fp.get('call', ())},
        'ivar': set(fp.get('ivar', ())),
    }


def annotate(macho, disasm, addrs, arm):
    """Return the objdump listing of the selected functions with resolved references."""
    out, keep, regs = [], False, {}
    for line in disasm.splitlines():
        m = FUNC.match(line)
        if m:
            keep, regs = int(m.group(1), 16) in addrs, {}
            if keep:
                out.append('')
        if not keep:
            continue
        note = []
        im = INS.match(line)
        if im and not m:
            mn, ops = im.group(2), im.group(3)
            ts = [int(t, 16) for t in re.findall(r'## (0x[0-9a-f]+)', ops)]
            bm = re.match(r'(0x[0-9a-f]+)', ops)
            if bm and mn in ('callq', 'jmp', 'bl', 'b'):
                ts.append(int(bm.group(1), 16))
            if arm:
                ops_n = re.sub(r'\bw(\d+)\b', r'x\1', ops)
                om = re.match(r'(x\d+), (0x[0-9a-f]+)', ops_n)
                if mn == 'adrp' and om:
                    regs[om.group(1)] = int(om.group(2), 16)
                lm = re.match(r'(x\d+), \[?(x\d+), #(0x[0-9a-f]+)', ops_n)
                if lm and lm.group(2) in regs and (mn == 'add' or mn.startswith('ldr')):
                    ts.append(regs[lm.group(2)] + int(lm.group(3), 16))
            for t in ts:
                c = macho.classify(t)
                if c and c[1] is not None:
                    note.append('%s %s' % (c[0], json.dumps(c[1])))
        line = re.sub(r' <dyld_stub_binder\+0x[0-9a-f]+>', '', line)
        out.append(line + ('    ; ' + ', '.join(note) if note else ''))
    return '\n'.join(out)


# ----------------------------------------------------------------- main ----

def main():
    bundle_p, x_p, a_p, out = sys.argv[1:5]
    bundle = json.load(open(bundle_p))
    X, A = MachO(x_p), MachO(a_p)
    evs = {k: evidence(bundle, k, op) for k, op in
           [('x86_64', 'symbols'), ('arm64', 'symbols')]}
    dis = {k: evidence(bundle, k, 'disassemble') for k in ('x86_64', 'arm64')}
    sx, sa = text_symbols(evs['x86_64']), text_symbols(evs['arm64'])

    def sized(rows, text_end):
        return [(a, n, (rows[i + 1][0] if i + 1 < len(rows) else text_end) - a)
                for i, (a, n) in enumerate(rows)]

    tx = next(s for s in X.sections if s['name'] == '__text')
    ta = next(s for s in A.sections if s['name'] == '__text')
    sx, sa = sized(sx, tx['addr'] + tx['size']), sized(sa, ta['addr'] + ta['size'])

    # Pair by normalized name + occurrence order (same link order in both slices).
    def keyed(rows):
        seen, out = collections.Counter(), {}
        for a, n, sz in rows:
            k = norm_name(n)
            out[(k, seen[k])] = (a, n, sz)
            seen[k] += 1
        return out

    kx, ka = keyed(sx), keyed(sa)
    fx = fingerprints(X, dis['x86_64']['raw_result']['stdout'], arm=False)
    fa = fingerprints(A, dis['arm64']['raw_result']['stdout'], arm=True)
    fs = fingerprints(A, dis['arm64']['raw_result']['stdout'], arm=True, strict=True)

    rows, diffs = [], []
    for key in sorted(set(kx) | set(ka), key=lambda k: (ka.get(k) or kx.get(k))[0]):
        x, a = kx.get(key), ka.get(key)
        row = dict(name=key[0], arm64=a and hex(a[0]), x86_64=x and hex(x[0]),
                   arm64_size=a and a[2], x86_64_size=x and x[2])
        if x and a:
            # Report a fact as x86_64-only only if even the loose arm64 view lacks it,
            # and as arm64-only only if the strict arm64 view has it.
            Fx, Fa, Fs = (facets(f.get(i, {})) for f, i in ((fx, x[0]), (fa, a[0]), (fs, a[0])))
            d = {}
            for k in Fx:
                xo, ao = sorted(Fx[k] - Fa[k]), sorted(Fs[k] - Fx[k])
                if xo or ao:
                    d[k] = {'x86_64_only': xo, 'arm64_only': ao}
            row['same_references'] = not d
            if d:
                diffs.append((key[0], row, d))
        else:
            row['same_references'] = None
        rows.append(row)

    os.makedirs(out, exist_ok=True)
    meta = dict(
        universal_sha256='1d245f2f9f52bd56a120616fede8b1eb9cca9fa228319de04a2cbeabd8de7174',
        x86_64=dict(sha256=X.sha256, symbols_evidence=evs['x86_64']['evidence_id'],
                    disassembly_evidence=dis['x86_64']['evidence_id']),
        arm64=dict(sha256=A.sha256, symbols_evidence=evs['arm64']['evidence_id'],
                   disassembly_evidence=dis['arm64']['evidence_id']))
    json.dump(dict(meta=meta, functions=rows), open(os.path.join(out, 'map.json'), 'w'), indent=1)
    json.dump([dict(name=n, x86_64=r['x86_64'], arm64=r['arm64'], delta=d) for n, r, d in diffs],
              open(os.path.join(out, 'reference_diffs.json'), 'w'), indent=1)

    # Annotated listings of every function that is unpaired or whose references differ.
    sel_x = {int(r['x86_64'], 16) for r in rows if r['x86_64'] and r['same_references'] is not True}
    sel_a = {int(r['arm64'], 16) for r in rows if r['arm64'] and r['same_references'] is not True}
    with open(os.path.join(out, 'diff_functions.asm'), 'w') as f:
        f.write('; CrossOver 26.3 — functions whose references differ between slices\n'
                '; objdump listings from REA evidence %s (x86_64) and %s (arm64),\n'
                '; annotated by .slicediff.py with resolved selectors/imports/strings.\n'
                '; arm64 notes follow adrp pages linearly; a page carried across basic\n'
                '; blocks can be mislabelled (reference_diffs.json uses the strict view).\n'
                % (dis['x86_64']['evidence_id'], dis['arm64']['evidence_id']))
        f.write('\n; ===== x86_64 =====\n')
        f.write(annotate(X, dis['x86_64']['raw_result']['stdout'], sel_x, arm=False))
        f.write('\n\n; ===== arm64 =====\n')
        f.write(annotate(A, dis['arm64']['raw_result']['stdout'], sel_a, arm=True))
        f.write('\n')

    # Data-level inventories.
    inv = {}
    for label, f in [('cstring', lambda m: m.strings('__cstring')),
                     ('cfstring', lambda m: m.cfstrings()),
                     ('objc_methname', lambda m: m.strings('__objc_methname')),
                     ('objc_classname', lambda m: m.strings('__objc_classname')),
                     ('objc_methtype', lambda m: m.strings('__objc_methtype'))]:
        cx, ca = collections.Counter(f(X)), collections.Counter(f(A))
        inv[label] = dict(x86_64_total=sum(cx.values()), arm64_total=sum(ca.values()),
                          x86_64_only=sorted((cx - ca).elements()),
                          arm64_only=sorted((ca - cx).elements()))
    imp = lambda m: sorted({v for v in m.imports.values()})
    ix, ia = set(imp(X)), set(imp(A))
    inv['imports'] = dict(x86_64_total=len(ix), arm64_total=len(ia),
                          x86_64_only=sorted(ix - ia), arm64_only=sorted(ia - ix))
    inv['sections'] = {m_l: [dict(seg=s['seg'], name=s['name'], addr=hex(s['addr']), size=s['size'])
                             for s in m.sections] for m_l, m in (('x86_64', X), ('arm64', A))}
    json.dump(inv, open(os.path.join(out, 'data_diffs.json'), 'w'), indent=1)

    only_x = [r for r in rows if r['arm64'] is None]
    only_a = [r for r in rows if r['x86_64'] is None]
    print(json.dumps(dict(paired=sum(1 for r in rows if r['arm64'] and r['x86_64']),
                          x86_64_only=[r['name'] for r in only_x],
                          arm64_only=[r['name'] for r in only_a],
                          reference_diffs=len(diffs),
                          coverage=dict(x86_64=sum(1 for a in fx if fx[a]), arm64=sum(1 for a in fa if fa[a]))),
                     indent=1))


if __name__ == '__main__':
    main()
