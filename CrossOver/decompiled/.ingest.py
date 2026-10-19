#!/usr/bin/env python3
"""Ingest REA batch_decompile output files into per-class pseudocode files."""
import json, re, sys, os, collections

HERE = os.path.dirname(os.path.abspath(__file__))
by = json.load(open(os.path.join(HERE, 'objc_methods.json')))
addr2 = {a: (c, v) for c, items in by.items() for a, v in items}
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

os.makedirs(os.path.join(HERE, 'classes'), exist_ok=True)
for c, items in by.items():
    done = [(a, v) for a, v in items if a in store]
    if not done: continue
    with open(os.path.join(HERE, 'classes', re.sub(r'[^\w.]', '_', c) + '.m'), 'w') as f:
        f.write(f'// {c} — CrossOver 26.3 arm64, Hopper pseudocode via REA\n\n')
        for a, v in items:
            if a in store: f.write(f'// {a}\n// {v}\n{store[a]}\n\n')
print(f'ok={ok} err={err} total_stored={len(store)}/{len(addr2)}')
