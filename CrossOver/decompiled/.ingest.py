#!/usr/bin/env python3
"""Ingest REA batch_decompile output files into per-class and standalone pseudocode files."""
import json, re, sys, os, collections

HERE = os.path.dirname(os.path.abspath(__file__))
PROC_LIST = '/Users/lucadias/.gemini/antigravity/brain/f1269358-bf65-4c5d-a05a-5c449d0f506d/.system_generated/steps/39/output.txt'

by = json.load(open(os.path.join(HERE, 'objc_methods.json')))
store_p = os.path.join(HERE, '.store.json')
store = json.load(open(store_p)) if os.path.exists(store_p) else {}

def items_of(d):
    r = d.get('normalized_result', d)
    if isinstance(r, dict):
        for k in ('results', 'items', 'functions'):
            if k in r: return r[k]
    return r

if len(sys.argv) > 1 and sys.argv[1] == '--probe':
    d = json.load(open(sys.argv[2])); it = items_of(d)
    print(type(it), len(it)); print(json.dumps(it[0], indent=1)[:1500]); sys.exit()

ok = err = 0
for p in sys.argv[1:]:
    for it in items_of(json.load(open(p))):
        a = it.get('address')
        code = (it.get('pseudocode') or it.get('pseudo_code') or
                (it.get('result') or {}).get('pseudocode') or
                (it.get('result') or {}).get('pseudo_code'))
        if code: store[a] = code; ok += 1
        else: store.setdefault(a, '/* decompile error: %s */' % json.dumps(it.get('error'))[:300]); err += 1
json.dump(store, open(store_p, 'w'))

all_procs = json.load(open(PROC_LIST))['normalized_result'] if os.path.exists(PROC_LIST) else []
blocks_by_class = collections.defaultdict(list)
c_funcs = []

for x in all_procs:
    a, v = x['address'], x['value']
    if int(a, 16) >= 0x100065088:
        continue
    if re.match(r'^[-+]\[', v):
        # Also catch any ObjC method with category that wasn't in by
        m = re.match(r'^([-+])\[(\S+?)(\(\S+\))? (.+)\]$', v)
        if m:
            c = m.group(2)
            if (a, v) not in [tuple(t) for t in by.get(c, [])]:
                by.setdefault(c, []).append([a, v])
        continue
    bm = re.search(r'[-+]\[([A-Za-z0-9_]+)(\([A-Za-z0-9_]+\))?\s+[^\]]+\]_block_invoke', v)
    if bm:
        blocks_by_class[bm.group(1)].append((a, v))
    else:
        c_funcs.append((a, v))

os.makedirs(os.path.join(HERE, 'classes'), exist_ok=True)
for c in sorted(set(list(by.keys()) + list(blocks_by_class.keys()))):
    items = by.get(c, [])
    b_items = blocks_by_class.get(c, [])
    done = [(a, v) for a, v in items if a in store] + [(a, v) for a, v in b_items if a in store]
    if not done: continue
    with open(os.path.join(HERE, 'classes', re.sub(r'[^\w.]', '_', c) + '.m'), 'w') as f:
        f.write(f'// {c} — CrossOver 26.3 arm64, Hopper pseudocode via REA\n\n')
        for a, v in items:
            if a in store: f.write(f'// {a}\n// {v}\n{store[a]}\n\n')
        if any(a in store for a, _ in b_items):
            f.write(f'// === Block Invocations for {c} ===\n\n')
            for a, v in b_items:
                if a in store: f.write(f'// {a}\n// {v}\n{store[a]}\n\n')

if any(a in store for a, _ in c_funcs):
    with open(os.path.join(HERE, 'c_functions.c'), 'w') as f:
        f.write('// Standalone C functions, callbacks, and helpers — CrossOver 26.3 arm64\n\n')
        for a, v in c_funcs:
            if a in store: f.write(f'// {a}\n// {v}\n{store[a]}\n\n')

print(f'ok={ok} err={err} total_stored={len(store)} c_funcs={len(c_funcs)} blocks={sum(len(v) for v in blocks_by_class.values())}')
