#!/usr/bin/env python3
"""
Generate robust Objective-C .h header files for all 88 classes and 6 categories,
plus umbrella header and forward declarations.
"""
import json
import os
import re

HERE = os.path.dirname(os.path.abspath(__file__))
META_PATH = os.path.join(HERE, 'metadata.json')
SRC_DIR = os.path.join(os.path.dirname(HERE), 'src')
HEADERS_DIR = os.path.join(SRC_DIR, 'Headers')
INCLUDE_DIR = os.path.join(SRC_DIR, 'include')

def decode_objc_type(t):
    if not t: return 'void'
    t = re.sub(r'^\d+', '', t)
    if t.startswith('@"<') and t.endswith('>"'):
        proto = t[3:-2]
        return f'id<{proto}> '
    if t.startswith('@"') and t.endswith('"'):
        cls = t[2:-1]
        return f'{cls} *'
    if t.startswith('@?<') or t.startswith('@?'):
        return 'id /* block */ '
    if t.startswith('@'): return 'id '
    if t.startswith('v'): return 'void '
    if t.startswith('c') or t.startswith('B'): return 'BOOL '
    if t.startswith('C'): return 'unsigned char '
    if t.startswith('s'): return 'short '
    if t.startswith('S'): return 'unsigned short '
    if t.startswith('i') or t.startswith('q'): return 'NSInteger '
    if t.startswith('I') or t.startswith('Q'): return 'NSUInteger '
    if t.startswith('d'): return 'CGFloat '
    if t.startswith('f'): return 'float '
    if t.startswith(':'): return 'SEL '
    if t.startswith('#'): return 'Class '
    if t.startswith('*'): return 'char *'
    if t.startswith('^v'): return 'void *'
    if t.startswith('^'):
        sub = decode_objc_type(t[1:])
        return f'{sub.strip()} *'
    if '{CGRect' in t: return 'NSRect '
    if '{CGSize' in t: return 'NSSize '
    if '{CGPoint' in t: return 'NSPoint '
    if '{_NSRange' in t: return 'NSRange '
    return 'id '

def build_method_decl(is_class_method, selector, ret_type, arg_types):
    if selector.startswith('.cxx_'):
        return None
    prefix = '+' if is_class_method else '-'
    if not selector.endswith(':'):
        return f'{prefix} ({ret_type.strip()}){selector};'
    parts = selector.split(':')[:-1]
    res = []
    for i, p in enumerate(parts):
        arg_t = arg_types[i].strip() if i < len(arg_types) else 'id'
        res.append(f'{p}:({arg_t})arg{i+1}')
    return f'{prefix} ({ret_type.strip()})' + ' '.join(res) + ';'

def decode_property_attributes(name, attr_str):
    parts = attr_str.split(',')
    type_code = parts[0]
    objc_type = 'id '
    if type_code.startswith('T@"<') and type_code.endswith('>"'):
        proto = type_code[4:-2]
        objc_type = f'id<{proto}> '
    elif type_code.startswith('T@"'):
        cls = type_code[3:-1]
        objc_type = f'{cls} *'
    elif type_code.startswith('T@'):
        objc_type = 'id '
    elif type_code.startswith('Tc') or type_code.startswith('TB'):
        objc_type = 'BOOL '
    elif type_code.startswith('Ti') or type_code.startswith('Tq'):
        objc_type = 'NSInteger '
    elif type_code.startswith('TI') or type_code.startswith('TQ'):
        objc_type = 'NSUInteger '
    elif type_code.startswith('Td'):
        objc_type = 'CGFloat '
    elif type_code.startswith('Tf'):
        objc_type = 'float '
    elif '{CGRect' in type_code:
        objc_type = 'NSRect '
    elif '{CGSize' in type_code:
        objc_type = 'NSSize '
    elif '{CGPoint' in type_code:
        objc_type = 'NSPoint '
    elif '{_NSRange' in type_code:
        objc_type = 'NSRange '

    attrs = []
    for p in parts[1:]:
        if p == 'N': attrs.append('nonatomic')
        elif p == '&': attrs.append('strong')
        elif p == 'C': attrs.append('copy')
        elif p == 'W': attrs.append('weak')
        elif p == 'R': attrs.append('readonly')
        elif p.startswith('G'): attrs.append(f'getter={p[1:]}')
        elif p.startswith('S'): attrs.append(f'setter={p[1:]}')

    attr_desc = f"({', '.join(attrs)}) " if attrs else ""
    return f"@property {attr_desc}{objc_type.strip()} {name};"

def generate_all_headers():
    os.makedirs(HEADERS_DIR, exist_ok=True)
    os.makedirs(INCLUDE_DIR, exist_ok=True)
    meta = json.load(open(META_PATH))
    classes = meta['classes']
    categories = meta['categories']

    custom_class_names = set(classes.keys())
    
    # Collect all custom protocols
    custom_protocols = {
        'BottleCollectionDelegate',
        'CXDragViewDelegate',
        'CXUpdaterDelegate',
        'CrossTieURLHandlerDelegate',
        'HelperServer',
        'IconCollectionViewControllerDelegate',
        'InstallConfigurationDelegate',
        'PackageInstallerDelegate',
        'PackageViewDelegate',
    }
    for cinfo in classes.values():
        for p in cinfo.get('protocols', []):
            if not p.startswith('NS') and not p.startswith('SPU') and not p.startswith('Web'):
                custom_protocols.add(p)

    # 1. Protocols header
    proto_lines = [
        "// CrossThroughProtocols.h — Custom Protocols",
        "#ifndef CrossThroughProtocols_h",
        "#define CrossThroughProtocols_h",
        "",
        "#import <Cocoa/Cocoa.h>",
        ""
    ]
    for p in sorted(custom_protocols):
        proto_lines.append(f"@protocol {p};")
    proto_lines.append("")
    for p in sorted(custom_protocols):
        proto_lines.append(f"@protocol {p} <NSObject>")
        proto_lines.append("@optional")
        proto_lines.append("@end")
        proto_lines.append("")
    proto_lines.append("#endif /* CrossThroughProtocols_h */")
    with open(os.path.join(HEADERS_DIR, "CrossThroughProtocols.h"), 'w') as f:
        f.write('\n'.join(proto_lines))

    # 2. Generate class headers
    for cname, cinfo in classes.items():
        superclass = cinfo['superclass']
        protocols = cinfo['protocols']
        ivars = cinfo['ivars']
        properties = cinfo['properties']
        inst_methods = cinfo['instance_methods']
        cls_methods = cinfo['class_methods']

        lines = [
            f"// {cname}.h — CrossThrough",
            f"#ifndef {cname}_h",
            f"#define {cname}_h",
            "",
            "#import <Cocoa/Cocoa.h>",
            "#import <WebKit/WebKit.h>",
            '#import "CrossThroughProtocols.h"',
            '#import "SparkleShim.h"',
            '#import "PythonShim.h"',
            ""
        ]

        if superclass in custom_class_names:
            lines.append(f'#import "{superclass}.h"')
        lines.append("")

        # Forward declare other custom classes referenced
        lines.append(f"@class {cname};")
        for iv in ivars:
            m = re.match(r'(\w+)\s*\*?', iv['type'])
            if m and m.group(1) in custom_class_names and m.group(1) != cname and m.group(1) != superclass:
                lines.append(f"@class {m.group(1)};")
        for prop in properties:
            m = re.search(r'T@"(\w+)"', prop['attributes'])
            if m and m.group(1) in custom_class_names and m.group(1) != cname and m.group(1) != superclass:
                lines.append(f"@class {m.group(1)};")

        lines.append("")
        proto_str = f" <{', '.join(protocols)}>" if protocols else ""
        lines.append(f"@interface {cname} : {superclass}{proto_str}")

        # ivars
        if ivars:
            lines.append("{")
            for iv in ivars:
                iname = iv['name']
                itype = decode_objc_type(iv['raw_type']).strip()
                if itype.endswith('*'):
                    lines.append(f"    {itype} {iname};")
                else:
                    lines.append(f"    {itype} {iname};")
            lines.append("}")

        # properties
        if properties:
            lines.append("")
            for prop in properties:
                lines.append(decode_property_attributes(prop['name'], prop['attributes']))

        # class methods
        cdecls = []
        for m in cls_methods:
            d = build_method_decl(True, m['selector'], m['ret_type'], m['arg_types'])
            if d: cdecls.append(d)
        if cdecls:
            lines.append("")
            lines.append("// Class Methods")
            lines.extend(cdecls)

        # instance methods
        idecls = []
        for m in inst_methods:
            d = build_method_decl(False, m['selector'], m['ret_type'], m['arg_types'])
            if d: idecls.append(d)
        if idecls:
            lines.append("")
            lines.append("// Instance Methods")
            lines.extend(idecls)

        lines.append("")
        lines.append("@end")
        lines.append("")
        lines.append(f"#endif /* {cname}_h */")
        lines.append("")

        out_path = os.path.join(HEADERS_DIR, f"{cname}.h")
        with open(out_path, 'w') as f:
            f.write('\n'.join(lines))

    # 3. Generate category headers
    for catkey, catinfo in categories.items():
        cname = catinfo['class_name']
        catname = catinfo['category_name']
        inst_methods = catinfo['instance_methods']
        cls_methods = catinfo['class_methods']

        guard = f"{cname}_{catname}_h"
        lines = [
            f"// {cname}+{catname}.h — CrossThrough",
            f"#ifndef {guard}",
            f"#define {guard}",
            "",
            "#import <Cocoa/Cocoa.h>",
            '#import "CrossThroughProtocols.h"',
            '#import "SparkleShim.h"',
            '#import "PythonShim.h"',
            ""
        ]

        if cname in custom_class_names:
            lines.append(f'#import "{cname}.h"')
        lines.append("")

        lines.append(f"@interface {cname} ({catname})")
        lines.append("")

        cdecls = []
        for m in cls_methods:
            d = build_method_decl(True, m['selector'], m['ret_type'], m['arg_types'])
            if d: cdecls.append(d)
        if cdecls:
            lines.append("// Class Methods")
            lines.extend(cdecls)
            lines.append("")

        idecls = []
        for m in inst_methods:
            d = build_method_decl(False, m['selector'], m['ret_type'], m['arg_types'])
            if d: idecls.append(d)
        if idecls:
            lines.append("// Instance Methods")
            lines.extend(idecls)
            lines.append("")

        lines.append("@end")
        lines.append("")
        lines.append(f"#endif /* {guard} */")
        lines.append("")

        out_path = os.path.join(HEADERS_DIR, f"{cname}+{catname}.h")
        with open(out_path, 'w') as f:
            f.write('\n'.join(lines))

    # 4. Generate Master Umbrella Header: CrossThrough.h
    umb_lines = [
        "// CrossThrough.h — Umbrella header for CrossThrough",
        "#ifndef CrossThrough_h",
        "#define CrossThrough_h",
        "",
        "#import <Cocoa/Cocoa.h>",
        "#import <WebKit/WebKit.h>",
        '#import "CrossThroughProtocols.h"',
        '#import "SparkleShim.h"',
        '#import "PythonShim.h"',
        ""
    ]
    # Forward declarations of all classes
    umb_lines.append("// Forward declarations")
    for cname in sorted(custom_class_names):
        umb_lines.append(f"@class {cname};")
    umb_lines.append("")

    # Import categories first
    for catkey in sorted(categories.keys()):
        cname, catname = catkey.split('+')
        umb_lines.append(f'#import "{cname}+{catname}.h"')

    # Import classes with inheritance order
    # Simple dependency order
    imported = set()
    def import_class(c):
        if c in imported or c not in classes: return
        sc = classes[c]['superclass']
        if sc in classes:
            import_class(sc)
        umb_lines.append(f'#import "{c}.h"')
        imported.add(c)

    for cname in sorted(custom_class_names):
        import_class(cname)

    umb_lines.append("")
    umb_lines.append("#endif /* CrossThrough_h */")
    umb_lines.append("")

    with open(os.path.join(INCLUDE_DIR, "CrossThrough.h"), 'w') as f:
        f.write('\n'.join(umb_lines))

    print(f"Generated {len(classes)} class headers, {len(categories)} category headers, protocols, and CrossThrough.h")

if __name__ == '__main__':
    generate_all_headers()
