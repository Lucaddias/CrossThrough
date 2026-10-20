#!/usr/bin/env python3
"""Static reader for CPython 3.13 .pyc files (CrossOver ships only bytecode).

No host interpreter of the same version is needed and nothing from the .pyc is
executed: the marshal stream is parsed here, and the 3.13 opcode table is
recovered from the bundled `_opcode_metadata.pyc` by interpreting only its
module-level constant-building instructions.

Provides:
  load_pyc(path)                -> (header, Code)
  opcode_table(metadata_pyc)    -> {opcode: name}
  disassemble(code, opnames)    -> text listing (dis-like)
  outline(code, opnames)        -> reconstructed module/class/def outline
"""
import struct

MAGIC_313 = 3571

# ------------------------------------------------------------- marshal -----


class Code:
    __slots__ = ('argcount', 'posonlyargcount', 'kwonlyargcount', 'stacksize', 'flags',
                 'code', 'consts', 'names', 'localsplusnames', 'localspluskinds',
                 'filename', 'name', 'qualname', 'firstlineno', 'linetable',
                 'exceptiontable')

    def __repr__(self):
        return '<code %s line %d>' % (self.qualname, self.firstlineno)

    # CO_FAST_* kinds (Include/internal/pycore_code.h)
    def varnames(self):
        return [n for n, k in zip(self.localsplusnames, self.localspluskinds) if k & 0x20]

    def argnames(self):
        n = self.argcount + self.kwonlyargcount
        n += bool(self.flags & 0x04) + bool(self.flags & 0x08)
        return list(self.localsplusnames[:n])


class _Reader:
    def __init__(self, data):
        self.d, self.p, self.refs = data, 0, []

    def byte(self):
        b = self.d[self.p]; self.p += 1
        return b

    def i32(self):
        v = struct.unpack_from('<i', self.d, self.p)[0]; self.p += 4
        return v

    def raw(self, n):
        v = self.d[self.p:self.p + n]; self.p += n
        return v

    def obj(self):
        code = self.byte()
        flag, t = code & 0x80, chr(code & 0x7f)
        idx = None
        if flag:
            idx = len(self.refs); self.refs.append(None)

        def keep(v):
            if idx is not None:
                self.refs[idx] = v
            return v

        if t == 'N': return keep(None)
        if t == 'F': return keep(False)
        if t == 'T': return keep(True)
        if t == '.': return keep(Ellipsis)
        if t == 'S': return keep(StopIteration)
        if t == 'i': return keep(self.i32())
        if t == 'l':
            n = self.i32(); v = 0
            for k in range(abs(n)):
                v |= struct.unpack_from('<H', self.d, self.p)[0] << (15 * k); self.p += 2
            return keep(-v if n < 0 else v)
        if t == 'g': return keep(struct.unpack('<d', self.raw(8))[0])
        if t == 'y': return keep(complex(*struct.unpack('<dd', self.raw(16))))
        if t == 's': return keep(self.raw(self.i32()))
        if t in 'tua':
            return keep(self.raw(self.i32()).decode('utf-8', 'surrogatepass'))
        if t == 'A': return keep(self.raw(self.i32()).decode('latin-1'))
        if t in 'zZ': return keep(self.raw(self.byte()).decode('latin-1'))
        if t in ')(':
            n = self.byte() if t == ')' else self.i32()
            if idx is not None:  # tuples may be referenced while being built
                lst = []; self.refs[idx] = lst
                for _ in range(n): lst.append(self.obj())
                return keep(tuple(lst))
            return tuple(self.obj() for _ in range(n))
        if t == '[':
            lst = keep([])
            for _ in range(self.i32()): lst.append(self.obj())
            return lst
        if t in '<>':
            items = [self.obj() for _ in range(self.i32())]
            return keep(frozenset(items) if t == '>' else set(items))
        if t == '{':
            dct = keep({})
            while True:
                k = self.obj()
                if k is _NULL: return dct
                dct[k] = self.obj()
        if t == '0': return _NULL
        if t == 'r': return self.refs[self.i32()]
        if t == 'c':
            c = keep(Code())
            (c.argcount, c.posonlyargcount, c.kwonlyargcount, c.stacksize,
             c.flags) = (self.i32() for _ in range(5))
            c.code = self.obj(); c.consts = self.obj(); c.names = self.obj()
            c.localsplusnames = self.obj(); c.localspluskinds = self.obj()
            c.filename = self.obj(); c.name = self.obj(); c.qualname = self.obj()
            c.firstlineno = self.i32()
            c.linetable = self.obj(); c.exceptiontable = self.obj()
            return c
        raise ValueError('unsupported marshal type %r at %d' % (t, self.p - 1))


_NULL = object()


def load_pyc(path):
    data = open(path, 'rb').read()
    magic, flags = struct.unpack_from('<HxxI', data, 0)
    if magic != MAGIC_313 or data[2:4] != b'\r\n':
        raise ValueError('%s: not a CPython 3.13 pyc (magic %d)' % (path, magic))
    header = {'magic': magic, 'flags': flags}
    if flags & 1:
        header['source_hash'] = data[8:16].hex()
        header['check_source'] = bool(flags & 2)
    else:
        header['mtime'], header['source_size'] = struct.unpack_from('<II', data, 8)
    r = _Reader(data[16:])
    code = r.obj()
    assert isinstance(code, Code)
    return header, code


def walk(code):
    yield code
    for c in code.consts:
        if isinstance(c, Code):
            yield from walk(c)


# ------------------------------------------------------- opcode table ------

def opcode_table(metadata_pyc):
    """Recover CPython 3.13 `opmap` from the shipped _opcode_metadata.pyc."""
    _, c = load_pyc(metadata_pyc)
    cs = c.consts
    # Bootstrap names for the handful of opcodes the module body uses, from the
    # ('NAME', number) pairs the compiler left in co_consts.
    prov = {}
    i = 0
    while i < len(cs) - 1:
        if isinstance(cs[i], str) and type(cs[i + 1]) is int:
            prov.setdefault(cs[i + 1], cs[i]); i += 2
        else:
            i += 1
    env, stack, ext = {}, [], 0
    code = c.code
    for k in range(0, len(code), 2):
        op, arg = code[k], code[k + 1] | ext
        ext = 0
        name = prov.get(op)
        if name == 'CACHE' or (op == 0 and arg == 0):
            continue
        if name == 'EXTENDED_ARG':
            ext = arg << 8
        elif name == 'RESUME' or name == 'NOP':
            pass
        elif name == 'LOAD_CONST':
            stack.append(cs[arg])
        elif name == 'LOAD_NAME':
            stack.append(env[c.names[arg]])
        elif name == 'STORE_NAME':
            env[c.names[arg]] = stack.pop()
        elif name == 'BUILD_MAP':
            items = stack[len(stack) - 2 * arg:]; del stack[len(stack) - 2 * arg:]
            stack.append(dict(zip(items[::2], items[1::2])))
        elif name == 'BUILD_CONST_KEY_MAP':
            keys = stack.pop(); vals = stack[len(stack) - arg:]; del stack[len(stack) - arg:]
            stack.append(dict(zip(keys, vals)))
        elif name == 'MAP_ADD':
            v = stack.pop(); key = stack.pop(); stack[-arg][key] = v
        elif name == 'DICT_UPDATE':
            v = stack.pop(); stack[-arg].update(v)
        elif name == 'BUILD_LIST':
            items = stack[len(stack) - arg:]; del stack[len(stack) - arg:]
            stack.append(list(items))
        elif name == 'LIST_EXTEND':
            v = stack.pop(); stack[-arg].extend(v)
        elif name in ('RETURN_VALUE', 'RETURN_CONST'):
            break
        else:
            raise ValueError('unexpected opcode %r (%d) in _opcode_metadata' % (name, op))
    opmap = dict(env['opmap'])
    names = {v: k for k, v in opmap.items()}
    assert names.get(83) == 'LOAD_CONST' and len(names) == len(opmap)
    return names


# ---------------------------------------------------------- decoding -------

CMP_OPS = ('<', '<=', '==', '!=', '>', '>=')
NB_OPS = ('+', '&', '//', '<<', '@', '*', '%', '|', '**', '>>', '-', '/', '^',
          '+=', '&=', '//=', '<<=', '@=', '*=', '%=', '|=', '**=', '>>=', '-=', '/=', '^=')
INTRINSIC_1 = {1: 'INTRINSIC_PRINT', 2: 'INTRINSIC_IMPORT_STAR', 3: 'INTRINSIC_STOPITERATION_ERROR',
               4: 'INTRINSIC_ASYNC_GEN_WRAP', 5: 'INTRINSIC_UNARY_POSITIVE', 6: 'INTRINSIC_LIST_TO_TUPLE',
               7: 'INTRINSIC_TYPEVAR', 8: 'INTRINSIC_PARAMSPEC', 9: 'INTRINSIC_TYPEVARTUPLE',
               10: 'INTRINSIC_SUBSCRIPT_GENERIC', 11: 'INTRINSIC_TYPEALIAS'}
FWD_JUMPS = {'JUMP_FORWARD', 'POP_JUMP_IF_FALSE', 'POP_JUMP_IF_TRUE', 'POP_JUMP_IF_NONE',
             'POP_JUMP_IF_NOT_NONE', 'FOR_ITER', 'SEND'}
BACK_JUMPS = {'JUMP_BACKWARD', 'JUMP_BACKWARD_NO_INTERRUPT'}
NAME_OPS = {'LOAD_NAME', 'STORE_NAME', 'DELETE_NAME', 'IMPORT_NAME', 'IMPORT_FROM', 'STORE_ATTR',
            'DELETE_ATTR', 'STORE_GLOBAL', 'DELETE_GLOBAL', 'LOAD_FROM_DICT_OR_GLOBALS'}
LOCAL_OPS = {'LOAD_FAST', 'STORE_FAST', 'DELETE_FAST', 'LOAD_FAST_CHECK', 'LOAD_FAST_AND_CLEAR',
             'LOAD_DEREF', 'STORE_DEREF', 'DELETE_DEREF', 'LOAD_FROM_DICT_OR_DEREF', 'MAKE_CELL',
             'LOAD_CLOSURE'}


class Ins:
    __slots__ = ('offset', 'op', 'name', 'arg', 'argval', 'argrepr', 'next', 'line', 'target')


def _varint(it):
    b = next(it); v = b & 63
    while b & 64:
        b = next(it); v = (v << 6) | (b & 63)
    return v


def exception_table(code):
    out, it = [], iter(code.exceptiontable)
    try:
        while True:
            start = _varint(it) * 2
            length = _varint(it) * 2
            target = _varint(it) * 2
            dl = _varint(it)
            out.append((start, start + length, target, dl >> 1, bool(dl & 1)))
    except StopIteration:
        return out


def line_starts(code):
    """Map instruction offset -> source line from the 3.11+ location table."""
    lt, p, off, line, out, prev = code.linetable, 0, 0, code.firstlineno, {}, None

    def uv():
        nonlocal p
        b = lt[p]; p += 1; v = b & 63; s = 6
        while b & 64:
            b = lt[p]; p += 1; v |= (b & 63) << s; s += 6
        return v

    def sv():
        v = uv()
        return -(v >> 1) if v & 1 else v >> 1

    while p < len(lt):
        b = lt[p]; p += 1
        kind, length = (b >> 3) & 15, (b & 7) + 1
        if kind == 15:
            ln = None
        elif kind == 14:
            line += sv(); ln = line; uv(); uv(); uv()
        elif kind == 13:
            line += sv(); ln = line
        elif kind in (10, 11, 12):
            line += kind - 10; ln = line; p += 2
        else:
            ln = line; p += 1
        if ln is not None and ln != prev:
            out[off] = prev = ln
        off += 2 * length
    return out


def decode(code, opnames):
    raw, ins, k, ext, start = code.code, [], 0, 0, None
    lines = line_starts(code)
    localsplus = code.localsplusnames
    while k < len(raw):
        op, arg = raw[k], raw[k + 1]
        name = opnames.get(op, '<%d>' % op)
        if start is None:
            start = k
        k += 2
        if name == 'CACHE':
            start = None
            continue
        arg |= ext
        if name == 'EXTENDED_ARG':
            ext = arg << 8
            continue
        ext = 0
        while k < len(raw) and raw[k] == 0 and raw[k + 1] == 0:
            k += 2  # inline cache entries (zeroed in marshalled code)
        i = Ins()
        i.offset, i.op, i.name, i.arg, i.next = start, op, name, arg, k
        i.line, i.target, i.argval, i.argrepr = lines.get(start), None, arg, ''
        start = None
        if name in ('LOAD_CONST', 'RETURN_CONST'):
            i.argval = code.consts[arg]; i.argrepr = _crepr(i.argval)
        elif name in ('LOAD_GLOBAL',):
            i.argval = code.names[arg >> 1]; i.argrepr = i.argval + (' + NULL' if arg & 1 else '')
        elif name == 'LOAD_ATTR':
            i.argval = code.names[arg >> 1]; i.argrepr = i.argval + (' + NULL|self' if arg & 1 else '')
        elif name == 'LOAD_SUPER_ATTR':
            i.argval = code.names[arg >> 2]; i.argrepr = i.argval
        elif name in NAME_OPS:
            i.argval = code.names[arg]; i.argrepr = i.argval
        elif name in LOCAL_OPS:
            i.argval = localsplus[arg]; i.argrepr = i.argval
        elif name in ('LOAD_FAST_LOAD_FAST', 'STORE_FAST_LOAD_FAST', 'STORE_FAST_STORE_FAST'):
            i.argval = (localsplus[arg >> 4], localsplus[arg & 15]); i.argrepr = ', '.join(i.argval)
        elif name == 'COMPARE_OP':
            i.argval = CMP_OPS[arg >> 5]; i.argrepr = i.argval + (' bool' if arg & 16 else '')
        elif name == 'BINARY_OP':
            i.argval = NB_OPS[arg] if arg < len(NB_OPS) else arg; i.argrepr = str(i.argval)
        elif name in ('CONTAINS_OP', 'IS_OP'):
            i.argrepr = ('not ' if arg else '') + ('in' if name == 'CONTAINS_OP' else 'is')
        elif name == 'CALL_INTRINSIC_1':
            i.argrepr = INTRINSIC_1.get(arg, str(arg))
        elif name == 'CONVERT_VALUE':
            i.argrepr = {1: 'str', 2: 'repr', 3: 'ascii'}.get(arg, str(arg))
        elif name == 'SET_FUNCTION_ATTRIBUTE':
            i.argrepr = '|'.join(n for b, n in ((1, 'defaults'), (2, 'kwdefaults'),
                                                (4, 'annotations'), (8, 'closure')) if arg & b)
        if name in FWD_JUMPS:
            i.target = i.next + 2 * arg
        elif name in BACK_JUMPS:
            i.target = i.next - 2 * arg
        if i.target is not None:
            i.argrepr = 'to %d' % i.target
        ins.append(i)
    return ins


def _crepr(v):
    if isinstance(v, Code):
        return '<code %s, line %d>' % (v.qualname, v.firstlineno)
    r = repr(v)
    return r if len(r) <= 200 else r[:197] + '...'


def disassemble(code, opnames, depth=0):
    out = []
    flags = [n for b, n in ((1, 'OPTIMIZED'), (2, 'NEWLOCALS'), (4, 'VARARGS'), (8, 'VARKEYWORDS'),
                            (16, 'NESTED'), (32, 'GENERATOR'), (128, 'COROUTINE'),
                            (512, 'ASYNC_GENERATOR')) if code.flags & b]
    out.append('Disassembly of <code %s> (line %d, args=%d posonly=%d kwonly=%d, flags=%s):'
               % (code.qualname, code.firstlineno, code.argcount, code.posonlyargcount,
                  code.kwonlyargcount, '|'.join(flags) or '0'))
    if code.localsplusnames:
        out.append('  locals+cells+free: ' + ', '.join(code.localsplusnames))
    ins = decode(code, opnames)
    targets = {i.target for i in ins if i.target is not None}
    targets |= {t for _, _, t, _, _ in exception_table(code)}
    for i in ins:
        ln = '%4d' % i.line if i.line is not None else '    '
        mark = '>>' if i.offset in targets else '  '
        argstr = ('%d' % i.arg) if i.op >= 44 else ''
        out.append(('%s %s %5d %-28s %5s %s' % (ln, mark, i.offset, i.name, argstr,
                                                ('(%s)' % i.argrepr) if i.argrepr else '')).rstrip())
    et = exception_table(code)
    if et:
        out.append('  ExceptionTable:')
        for s, e, t, d, lasti in et:
            out.append('    %d to %d -> %d [%d]%s' % (s, e, t, d, ' lasti' if lasti else ''))
    out.append('')
    for c in code.consts:
        if isinstance(c, Code):
            out.append(disassemble(c, opnames, depth + 1))
    return '\n'.join(out)


# ------------------------------------------------------------ outline ------

class _Sym:
    """Symbolic stack value used to rebuild module/class-level statements."""
    __slots__ = ('text', 'code', 'deco', 'meta')

    def __init__(self, text, code=None, meta=None):
        self.text, self.code, self.deco, self.meta = text, code, [], meta or {}

    def __repr__(self):
        return self.text


def _lit(v):
    if isinstance(v, Code):
        return '<code %s>' % v.qualname
    r = repr(v)
    return r if len(r) <= 120 else r[:117] + '...'


def signature(code, defaults=(), kwdefaults=None):
    names = code.localsplusnames
    pos = list(names[:code.argcount])
    kwonly = list(names[code.argcount:code.argcount + code.kwonlyargcount])
    rest = code.argcount + code.kwonlyargcount
    varargs = names[rest] if code.flags & 0x04 else None
    rest += bool(varargs)
    varkw = names[rest] if code.flags & 0x08 else None
    defaults = list(defaults or ())
    parts = []
    for k, n in enumerate(pos):
        d = k - (len(pos) - len(defaults))
        parts.append(n + ('=' + defaults[d] if d >= 0 else ''))
        if code.posonlyargcount and k == code.posonlyargcount - 1:
            parts.append('/')
    if varargs:
        parts.append('*' + varargs)
    elif kwonly:
        parts.append('*')
    for n in kwonly:
        dv = (kwdefaults or {}).get(n)
        parts.append(n + ('=' + dv if dv else ''))
    if varkw:
        parts.append('**' + varkw)
    return '(%s)' % ', '.join(parts)


def docstring(code, is_function=True):
    if is_function and code.consts and isinstance(code.consts[0], str) and code.name != '<lambda>':
        return code.consts[0]
    return None


def references(code, opnames):
    """Globals, attributes, string constants and nested code used by a function body."""
    g, attrs, strs = [], [], []
    doc = docstring(code)
    for i in decode(code, opnames):
        if i.name in ('LOAD_GLOBAL', 'LOAD_NAME') and i.argval not in g:
            g.append(i.argval)
        elif i.name in ('LOAD_ATTR', 'STORE_ATTR', 'LOAD_SUPER_ATTR') and i.argval not in attrs:
            attrs.append(i.argval)
        elif (i.name in ('LOAD_CONST', 'RETURN_CONST') and isinstance(i.argval, str)
              and i.argval != doc and i.argval not in strs):
            strs.append(i.argval)
    nested = [c for c in code.consts if isinstance(c, Code)]
    for c in nested:
        if c.name.startswith('<'):  # comprehensions/lambdas/genexprs are inlined here
            g2, a2, s2, _ = references(c, opnames)
            g += [x for x in g2 if x not in g]
            attrs += [x for x in a2 if x not in attrs]
            strs += [x for x in s2 if x not in strs]
    return g, attrs, strs, [c for c in nested if not c.name.startswith('<')]


def outline(code, opnames, indent='', in_class=False):
    """Rebuild the statements of a module or class body as Python-like text."""
    out, stack = [], []
    ins = decode(code, opnames)
    skip_names = {'__module__', '__qualname__', '__firstlineno__', '__static_attributes__',
                  '__classcell__'}
    cond_depth = 0
    pending_from = None

    def pop(n=1):
        vals = stack[len(stack) - n:] if n else []
        del stack[len(stack) - n:]
        return vals

    def emit(s):
        out.append(indent + ('    ' * cond_depth if False else '') + s)

    for i in ins:
        n = i.name
        try:
            if n in ('RESUME', 'NOP', 'EXTENDED_ARG', 'COPY_FREE_VARS', 'MAKE_CELL'):
                continue
            if n == 'LOAD_CONST':
                stack.append(_Sym(_lit(i.argval), i.argval if isinstance(i.argval, Code) else None,
                                  {'const': i.argval}))
            elif n in ('LOAD_NAME', 'LOAD_GLOBAL', 'LOAD_DEREF', 'LOAD_FROM_DICT_OR_DEREF',
                       'LOAD_FAST', 'LOAD_CLOSURE', 'LOAD_FROM_DICT_OR_GLOBALS'):
                if n == 'LOAD_GLOBAL' and i.arg & 1:
                    stack.append(_Sym('NULL'))
                stack.append(_Sym(str(i.argval)))
            elif n == 'LOAD_LOCALS':
                stack.append(_Sym('locals()'))
            elif n == 'PUSH_NULL':
                stack.append(_Sym('NULL'))
            elif n == 'LOAD_ATTR':
                o = pop()[0]
                if i.arg & 1:
                    stack.append(_Sym('NULL'))
                stack.append(_Sym('%s.%s' % (o.text, i.argval)))
            elif n == 'LOAD_BUILD_CLASS':
                stack.append(_Sym('__build_class__'))
            elif n == 'MAKE_FUNCTION':
                f = pop()[0]
                stack.append(_Sym('<function %s>' % (f.code.qualname if f.code else '?'), f.code,
                                  {'defaults': (), 'kwdefaults': {}}))
            elif n == 'SET_FUNCTION_ATTRIBUTE':
                f, v = stack.pop(), stack.pop()
                if i.arg & 1:
                    c = v.meta.get('const')
                    f.meta['defaults'] = ([_lit(x) for x in c] if isinstance(c, tuple)
                                          else v.meta.get('items', [v.text]))
                elif i.arg & 2:
                    f.meta['kwdefaults'] = v.meta.get('dict', {})
                stack.append(f)
            elif n in ('BUILD_TUPLE', 'BUILD_LIST', 'BUILD_SET'):
                items = pop(i.arg)
                o, c = {'BUILD_TUPLE': '()', 'BUILD_LIST': '[]', 'BUILD_SET': '{}'}[n]
                txt = ', '.join(x.text for x in items)
                if n == 'BUILD_TUPLE' and len(items) == 1:
                    txt += ','
                stack.append(_Sym(o + txt + c, meta={'items': [x.text for x in items]}))
            elif n in ('LIST_EXTEND', 'SET_UPDATE'):
                v = stack.pop(); t = stack[-i.arg]
                c = v.meta.get('const')
                more = [_lit(x) for x in c] if isinstance(c, (tuple, frozenset)) else ['*' + v.text]
                items = t.meta.get('items', []) + more
                o, cl = ('[', ']') if n == 'LIST_EXTEND' else ('{', '}')
                stack[-i.arg] = _Sym(o + ', '.join(items) + cl, meta={'items': items})
            elif n == 'BUILD_MAP':
                items = pop(2 * i.arg)
                d = {k.text: v.text for k, v in zip(items[::2], items[1::2])}
                stack.append(_Sym('{%s}' % ', '.join('%s: %s' % kv for kv in d.items()),
                                  meta={'dict': d}))
            elif n == 'BUILD_CONST_KEY_MAP':
                keys = stack.pop().meta.get('const', ()); vals = pop(i.arg)
                d = {_lit(k): v.text for k, v in zip(keys, vals)}
                stack.append(_Sym('{%s}' % ', '.join('%s: %s' % kv for kv in d.items()),
                                  meta={'dict': {str(k): v.text for k, v in zip(keys, vals)}}))
            elif n in ('DICT_UPDATE', 'DICT_MERGE'):
                v = stack.pop(); t = stack[-i.arg]
                stack[-i.arg] = _Sym(t.text[:-1] + (', ' if len(t.text) > 2 else '') + '**' + v.text + '}')
            elif n == 'MAP_ADD':
                v, k = stack.pop(), stack.pop(); t = stack[-i.arg]
                stack[-i.arg] = _Sym(t.text[:-1] + (', ' if len(t.text) > 2 else '') +
                                     '%s: %s}' % (k.text, v.text))
            elif n in ('CALL', 'CALL_KW'):
                kwn = ()
                if n == 'CALL_KW':
                    kwn = stack.pop().meta.get('const', ())
                args = pop(i.arg)
                self_or_null, fn = pop(2)
                if fn.text == 'NULL':  # [callable, NULL] order from LOAD_GLOBAL/LOAD_ATTR
                    fn, self_or_null = self_or_null, fn
                if self_or_null.text not in ('NULL',) and not fn.text.endswith(')'):
                    pass
                pos = args[:len(args) - len(kwn)]
                kws = args[len(args) - len(kwn):]
                if fn.text == '__build_class__':
                    body, cname, bases = pos[0], pos[1], pos[2:]
                    stack.append(_Sym('<class>', body.code,
                                      {'class': cname.meta.get('const', cname.text),
                                       'bases': [b.text for b in bases] +
                                       ['%s=%s' % (k, v.text) for k, v in zip(kwn, kws)]}))
                elif len(pos) == 1 and pos[0].code is not None and not kws:
                    # decorator application
                    pos[0].deco.append(fn.text); stack.append(pos[0])
                else:
                    txt = '%s(%s)' % (fn.text, ', '.join([a.text for a in pos] +
                                                          ['%s=%s' % (k, v.text) for k, v in zip(kwn, kws)]))
                    stack.append(_Sym(txt))
            elif n == 'CALL_FUNCTION_EX':
                kw = stack.pop() if i.arg & 1 else None
                a = stack.pop(); f = pop(2)
                fn = f[0] if f[0].text != 'NULL' else f[1]
                stack.append(_Sym('%s(*%s%s)' % (fn.text, a.text, ', **' + kw.text if kw else '')))
            elif n == 'BINARY_OP':
                b, a = stack.pop(), stack.pop()
                stack.append(_Sym('(%s %s %s)' % (a.text, i.argval, b.text)))
            elif n == 'UNPACK_SEQUENCE':
                seq = stack.pop()
                for k in reversed(range(i.arg)):
                    stack.append(_Sym('%s[%d]' % (seq.text, k)))
            elif n == 'BINARY_SUBSCR':
                b, a = stack.pop(), stack.pop()
                stack.append(_Sym('%s[%s]' % (a.text, b.text)))
            elif n == 'COMPARE_OP':
                b, a = stack.pop(), stack.pop()
                stack.append(_Sym('%s %s %s' % (a.text, i.argval, b.text)))
            elif n in ('IS_OP', 'CONTAINS_OP'):
                b, a = stack.pop(), stack.pop()
                stack.append(_Sym('%s %s %s' % (a.text, i.argrepr, b.text)))
            elif n in ('UNARY_NOT', 'UNARY_NEGATIVE', 'UNARY_INVERT', 'TO_BOOL'):
                if n != 'TO_BOOL':
                    a = stack.pop()
                    stack.append(_Sym({'UNARY_NOT': 'not ', 'UNARY_NEGATIVE': '-',
                                       'UNARY_INVERT': '~'}[n] + a.text))
            elif n in ('FORMAT_SIMPLE', 'CONVERT_VALUE', 'FORMAT_WITH_SPEC'):
                if n == 'FORMAT_WITH_SPEC':
                    stack.pop()
            elif n == 'BUILD_STRING':
                items = pop(i.arg)
                stack.append(_Sym('f"%s"' % ''.join('{%s}' % x.text if not x.text.startswith("'")
                                                    else x.text.strip("'") for x in items)))
            elif n == 'IMPORT_NAME':
                level, fromlist = pop(2)
                lv = level.meta.get('const', 0) or 0
                fl = fromlist.meta.get('const')
                stack.append(_Sym(i.argval, meta={'module': '.' * lv + i.argval, 'fromlist': fl}))
            elif n == 'IMPORT_FROM':
                m = stack[-1]
                stack.append(_Sym(i.argval, meta={'from': m.meta.get('module'), 'name': i.argval}))
            elif n == 'CALL_INTRINSIC_1' and i.arg == 2:
                m = stack.pop(); emit('from %s import *' % m.meta.get('module'))
            elif n in ('STORE_NAME', 'STORE_GLOBAL', 'STORE_FAST', 'STORE_DEREF'):
                v = stack.pop(); name = i.argval
                if name in skip_names:
                    continue
                if name == '__doc__':
                    emit('"""%s"""' % str(v.meta.get('const', v.text)).replace('"""', '\\"\\"\\"'))
                elif 'from' in v.meta:
                    nm = v.meta['name']
                    emit('from %s import %s' % (v.meta['from'], nm if nm == name else '%s as %s' % (nm, name)))
                elif 'module' in v.meta:
                    mod = v.meta['module']
                    emit('import %s' % (mod if mod.split('.')[0] == name else '%s as %s' % (mod, name)))
                elif 'class' in v.meta:
                    for d in reversed(v.deco):
                        emit('@' + d)
                    bases = v.meta['bases']
                    emit('class %s%s:' % (name, '(%s)' % ', '.join(bases) if bases else ''))
                    out.extend(outline(v.code, opnames, indent + '    ', in_class=True) or
                               [indent + '    pass'])
                    emit('')
                elif v.code is not None and v.code.name != '<lambda>' and v.text.startswith('<function'):
                    out.extend(function_stub(v.code, opnames, indent, v.deco, name,
                                             v.meta.get('defaults'), v.meta.get('kwdefaults')))
                else:
                    emit('%s = %s' % (name, v.text))
            elif n == 'STORE_ATTR':
                o, v = stack.pop(), stack.pop()
                emit('%s.%s = %s' % (o.text, i.argval, v.text))
            elif n == 'STORE_SUBSCR':
                k, o, v = stack.pop(), stack.pop(), stack.pop()
                emit('%s[%s] = %s' % (o.text, k.text, v.text))
            elif n == 'POP_TOP':
                v = stack.pop() if stack else _Sym('?')
                if v.text.endswith(')') and v.text != '()':
                    emit(v.text)
            elif n == 'COPY':
                stack.append(stack[-i.arg] if len(stack) >= i.arg else _Sym('?'))
            elif n == 'SWAP':
                if len(stack) >= i.arg:
                    stack[-1], stack[-i.arg] = stack[-i.arg], stack[-1]
            elif n == 'PUSH_EXC_INFO':
                stack[:] = [_Sym('<prev_exc>'), _Sym('<exc>')]
            elif n == 'CHECK_EXC_MATCH':
                t = stack.pop()
                stack.append(_Sym('<exc matches %s>' % t.text, meta={'except': t.text}))
            elif n in ('POP_JUMP_IF_FALSE', 'POP_JUMP_IF_TRUE', 'POP_JUMP_IF_NONE',
                       'POP_JUMP_IF_NOT_NONE'):
                c = stack.pop() if stack else _Sym('?')
                if 'except' in c.meta:
                    emit('# except %s:  (handler offset %d)' % (c.meta['except'], i.next))
                else:
                    emit('# if %s%s ... (offset %d-%d)' % ('not ' if n.endswith('FALSE') else '',
                                                        c.text, i.next, i.target))
            elif n in ('RETURN_CONST', 'RETURN_VALUE', 'JUMP_FORWARD', 'JUMP_BACKWARD',
                       'JUMP_BACKWARD_NO_INTERRUPT', 'RERAISE', 'POP_EXCEPT', 'RAISE_VARARGS',
                       'END_FOR', 'GET_ITER', 'FOR_ITER', 'CLEANUP_THROW', 'WITH_EXCEPT_START',
                       'BEFORE_WITH'):
                if n == 'POP_EXCEPT':
                    continue  # leaves the saved exception for the cleanup path
                stack.clear()
            else:
                emit('# <%s %s>' % (n, i.argrepr))
                stack.clear()
        except (IndexError, KeyError, AttributeError, TypeError, ValueError):
            emit('# <unparsed %s at offset %d>' % (n, i.offset))
            stack.clear()
    return out


def function_stub(code, opnames, indent, decorators, name, defaults=(), kwdefaults=None):
    out = [indent + '@' + d for d in reversed(decorators or [])]
    kw = 'async def' if code.flags & 0x80 else 'def'
    out.append('%s%s %s%s:' % (indent, kw, name, signature(code, defaults, kwdefaults)))
    inner = indent + '    '
    doc = docstring(code)
    if doc:
        out.append('%s"""%s"""' % (inner, doc.replace('"""', '\\"\\"\\"')))
    g, attrs, strs, nested = references(code, opnames)
    if g:
        out.append('%s# globals: %s' % (inner, ', '.join(g)))
    if attrs:
        out.append('%s# attributes: %s' % (inner, ', '.join(attrs)))
    if strs:
        out.append('%s# strings: %s' % (inner, ', '.join(_lit(s) for s in strs[:40]) +
                                       (' ...(+%d)' % (len(strs) - 40) if len(strs) > 40 else '')))
    for c in nested:
        out.extend(function_stub(c, opnames, inner, [], c.name))
    out.append(inner + '...')
    out.append('')
    return out
