#!/usr/bin/env python3
"""
Transpile decompiled classes into compilable Objective-C implementation files.
"""
import json
import os
import re
import glob

HERE = os.path.dirname(os.path.abspath(__file__))
META_PATH = os.path.join(HERE, 'metadata.json')
SRC_DIR = os.path.join(os.path.dirname(HERE), 'src')
CLASSES_OUT_DIR = os.path.join(SRC_DIR, 'classes')
DECOMP_DIR = os.path.join(os.path.dirname(HERE), 'decompiled', 'classes')

def build_method_header(is_class_method, selector, ret_type, arg_types):
    if selector.startswith('.cxx_'):
        return None
    prefix = '+' if is_class_method else '-'
    if not selector.endswith(':'):
        return f'{prefix} ({ret_type.strip()}){selector}'
    parts = selector.split(':')[:-1]
    res = []
    for i, p in enumerate(parts):
        arg_t = arg_types[i].strip() if i < len(arg_types) else 'id'
        res.append(f'{p}:({arg_t})arg{i+1}')
    return f'{prefix} ({ret_type.strip()})' + ' '.join(res)

def lift_method_body(selector, ret_type, raw_body, ivars, superclass):
    lines = [l.strip() for l in raw_body.strip().split('\n') if l.strip()]
    ret_clean = ret_type.strip()
    
    # If method returns void, it must never return any value
    if ret_clean == 'void':
        # Check for simple setter
        m_set = re.search(r'objc_storeStrong\([^,]+,\s*arg2\);', raw_body)
        if m_set:
            m_ivar = re.search(r'self->(_?\w+)', raw_body)
            if m_ivar and m_ivar.group(1) in ivars:
                return f'    self->{m_ivar.group(1)} = arg1;'

        m_bset = re.search(r'\*\(int8_t \*\)[^=]*self->(_?\w+)\s*=\s*arg2;', raw_body)
        if m_bset:
            m_ivar = m_bset.group(1)
            if m_ivar in ivars:
                return f'    self->{m_ivar} = arg1;'
            
        return '    return;'

    # Check for simple return of constant
    if len(lines) == 1 and lines[0] == 'return 0x1;':
        if ret_clean == 'BOOL': return '    return YES;'
        if ret_clean in ('NSInteger', 'NSUInteger', 'int', 'unsigned int', 'long', 'unsigned long', 'short'): return '    return 1;'
        return '    return (id)1;'
    if len(lines) == 1 and lines[0] == 'return 0x0;':
        if ret_clean == 'BOOL': return '    return NO;'
        if ret_clean in ('NSInteger', 'NSUInteger', 'int', 'unsigned int', 'long', 'unsigned long', 'short'): return '    return 0;'
        return '    return nil;'

    # Check for simple getter
    m_get = re.search(r'r0\s*=\s*self->(_?\w+);', raw_body)
    if m_get and any(l.startswith('return') for l in lines):
        ivar_name = m_get.group(1)
        if ivar_name in ivars:
            return f'    return self->{ivar_name};'

    # Check for bool getter
    m_bget = re.search(r'r0\s*=\s*\*\(int8_t \*\)[^=]*self->(_?\w+)', raw_body)
    if m_bget and any('return' in l for l in lines):
        ivar_name = m_bget.group(1)
        if ivar_name in ivars:
            return f'    return self->{ivar_name};'

    # Check for super call init
    if selector.startswith('init'):
        if selector == 'init':
            super_init_call = '[super init]'
        elif selector == 'initWithFrame:':
            super_init_call = '[super initWithFrame:arg1]'
        elif selector == 'initWithCoder:':
            super_init_call = '[super initWithCoder:arg1]'
        elif selector == 'initWithNibName:bundle:':
            super_init_call = '[super initWithNibName:arg1 bundle:arg2]'
        elif selector == 'initWithWindow:':
            super_init_call = '[super initWithWindow:arg1]'
        elif selector == 'initWithWindowNibName:':
            super_init_call = '[super initWithWindowNibName:arg1]'
        else:
            super_init_call = '[super init]'
        return f"""    self = {super_init_call};
    if (self) {{
        // Initialized
    }}
    return self;"""

    # For general methods: produce clean compilable stub with original pseudocode preserved in comments
    body_lines = ["    /*"]
    body_lines.append("     * Decompiled from CrossOver 26.3:")
    for l in lines[:25]:
        body_lines.append(f"     *   {l}")
    if len(lines) > 25:
        body_lines.append(f"     *   ... ({len(lines) - 25} more lines)")
    body_lines.append("     */")

    # Add default return based on return type
    ret_clean = ret_type.strip()
    if ret_clean == 'void':
        body_lines.append("    return;")
    elif ret_clean == 'BOOL':
        body_lines.append("    return NO;")
    elif ret_clean in ('NSInteger', 'NSUInteger', 'int', 'unsigned int', 'long', 'unsigned long', 'short'):
        body_lines.append("    return 0;")
    elif ret_clean in ('CGFloat', 'float', 'double'):
        body_lines.append("    return 0.0;")
    elif ret_clean == 'NSRect':
        body_lines.append("    return NSZeroRect;")
    elif ret_clean == 'NSSize':
        body_lines.append("    return NSZeroSize;")
    elif ret_clean == 'NSPoint':
        body_lines.append("    return NSZeroPoint;")
    elif ret_clean == 'NSRange':
        body_lines.append("    return NSMakeRange(0, 0);")
    else:
        body_lines.append("    return nil;")

    return '\n'.join(body_lines)

def transpile_all():
    os.makedirs(CLASSES_OUT_DIR, exist_ok=True)
    meta = json.load(open(META_PATH))
    classes = meta['classes']
    categories = meta['categories']

    # Load all raw decompiled class files
    decomp_map = {}
    for f in glob.glob(os.path.join(DECOMP_DIR, '*.m')):
        basename = os.path.basename(f)[:-2]
        decomp_map[basename] = open(f).read()

    # 1. Transpile Classes
    for cname, cinfo in classes.items():
        superclass = cinfo['superclass']
        ivars = [iv['name'] for iv in cinfo.get('ivars', [])]
        inst_methods = cinfo['instance_methods']
        cls_methods = cinfo['class_methods']

        decomp_text = decomp_map.get(cname, '')

        # Extract method blocks from decomp_text
        raw_meth_map = {}
        for m in re.finditer(r'// (0x[0-9a-fA-F]+)\n// ([-+])\[([A-Za-z0-9_]+)\s+(.+?)\]\n(.*?)(?=\n// 0x|\n// ===|\Z)', decomp_text, re.DOTALL):
            sign = m.group(2)
            sel = m.group(4)
            raw_meth_map[(sign, sel)] = m.group(5)

        lines = [
            f"// {cname}.m — CrossThrough",
            f'#import "{cname}.h"',
            '#import "CrossThrough.h"',
            '#import "HopperCompat.h"',
            "",
            f"@implementation {cname}",
            ""
        ]

        # Class methods
        for m in cls_methods:
            hdr = build_method_header(True, m['selector'], m['ret_type'], m['arg_types'])
            if not hdr: continue
            raw_b = raw_meth_map.get(('+', m['selector']), '')
            body = lift_method_body(m['selector'], m['ret_type'], raw_b, ivars, superclass)
            lines.append(f"{hdr} {{\n{body}\n}}\n")

        # Instance methods
        for m in inst_methods:
            hdr = build_method_header(False, m['selector'], m['ret_type'], m['arg_types'])
            if not hdr: continue
            raw_b = raw_meth_map.get(('-', m['selector']), '')
            body = lift_method_body(m['selector'], m['ret_type'], raw_b, ivars, superclass)
            lines.append(f"{hdr} {{\n{body}\n}}\n")

        lines.append("@end\n")

        out_path = os.path.join(CLASSES_OUT_DIR, f"{cname}.m")
        with open(out_path, 'w') as f:
            f.write('\n'.join(lines))

    # 2. Transpile Categories
    for catkey, catinfo in categories.items():
        cname = catinfo['class_name']
        catname = catinfo['category_name']
        inst_methods = catinfo['instance_methods']
        cls_methods = catinfo['class_methods']

        decomp_text = decomp_map.get(cname, '')

        raw_meth_map = {}
        for m in re.finditer(r'// (0x[0-9a-fA-F]+)\n// ([-+])\[([A-Za-z0-9_]+)(?:\(\w+\))?\s+(.+?)\]\n(.*?)(?=\n// 0x|\n// ===|\Z)', decomp_text, re.DOTALL):
            sign = m.group(2)
            sel = m.group(4)
            raw_meth_map[(sign, sel)] = m.group(5)

        lines = [
            f"// {cname}+{catname}.m — CrossThrough",
            f'#import "{cname}+{catname}.h"',
            '#import "CrossThrough.h"',
            '#import "HopperCompat.h"',
            "",
            f"@implementation {cname} ({catname})",
            ""
        ]

        for m in cls_methods:
            hdr = build_method_header(True, m['selector'], m['ret_type'], m['arg_types'])
            if not hdr: continue
            raw_b = raw_meth_map.get(('+', m['selector']), '')
            body = lift_method_body(m['selector'], m['ret_type'], raw_b, [], 'NSObject')
            lines.append(f"{hdr} {{\n{body}\n}}\n")

        for m in inst_methods:
            hdr = build_method_header(False, m['selector'], m['ret_type'], m['arg_types'])
            if not hdr: continue
            raw_b = raw_meth_map.get(('-', m['selector']), '')
            body = lift_method_body(m['selector'], m['ret_type'], raw_b, [], 'NSObject')
            lines.append(f"{hdr} {{\n{body}\n}}\n")

        lines.append("@end\n")

        out_path = os.path.join(CLASSES_OUT_DIR, f"{cname}+{catname}.m")
        with open(out_path, 'w') as f:
            f.write('\n'.join(lines))

    print(f"Transpiled {len(classes)} classes and {len(categories)} categories into {CLASSES_OUT_DIR}")

if __name__ == '__main__':
    transpile_all()
