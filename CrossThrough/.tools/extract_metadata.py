#!/usr/bin/env python3
"""
Extract all Objective-C metadata from otool output into a clean JSON structure.
"""
import subprocess
import re
import json
import os
import sys

BINARY = '/Applications/CrossOver.app/Contents/MacOS/CrossOver'

def decode_objc_type(t):
    if not t: return 'void'
    # Strip leading digits
    t = re.sub(r'^\d+', '', t)
    if t.startswith('@"'):
        cls = t[2:t.index('"', 2)]
        return f'{cls} *'
    if t.startswith('@?<'):
        return 'id /* block */'
    if t.startswith('@?'):
        return 'void (^)(void)'
    if t.startswith('@'): return 'id'
    if t.startswith('v'): return 'void'
    if t.startswith('c') or t.startswith('B'): return 'BOOL'
    if t.startswith('C'): return 'unsigned char'
    if t.startswith('s'): return 'short'
    if t.startswith('S'): return 'unsigned short'
    if t.startswith('i') or t.startswith('q'): return 'NSInteger'
    if t.startswith('I') or t.startswith('Q'): return 'NSUInteger'
    if t.startswith('d'): return 'CGFloat'
    if t.startswith('f'): return 'float'
    if t.startswith(':'): return 'SEL'
    if t.startswith('#'): return 'Class'
    if t.startswith('*'): return 'char *'
    if t.startswith('^v'): return 'void *'
    if t.startswith('^'):
        sub = decode_objc_type(t[1:])
        return f'{sub} *'
    if '{CGRect' in t: return 'NSRect'
    if '{CGSize' in t: return 'NSSize'
    if '{CGPoint' in t: return 'NSPoint'
    if '{_NSRange' in t: return 'NSRange'
    return 'id'

def parse_method_type_encoding(types_str):
    m = re.match(r'^(.*?)\d+@0:8(.*)$', types_str)
    if not m:
        m = re.match(r'^(.*?)@:(.*)$', types_str)
        if not m:
            return 'id', []
    ret_raw = m.group(1)
    args_raw = m.group(2)
    
    tokens = []
    i = 0
    while i < len(args_raw):
        if args_raw[i] == '{':
            depth = 1
            j = i + 1
            while j < len(args_raw) and depth > 0:
                if args_raw[j] == '{': depth += 1
                elif args_raw[j] == '}': depth -= 1
                j += 1
            while j < len(args_raw) and args_raw[j].isdigit(): j += 1
            tokens.append(args_raw[i:j])
            i = j
        elif args_raw[i] == '@' and i + 1 < len(args_raw) and args_raw[i+1] == '"':
            try:
                j = args_raw.index('"', i + 2) + 1
            except ValueError:
                j = len(args_raw)
            while j < len(args_raw) and args_raw[j].isdigit(): j += 1
            tokens.append(args_raw[i:j])
            i = j
        elif args_raw[i] == '^':
            j = i + 1
            if j < len(args_raw) and args_raw[j] in 'v@#icBfd':
                j += 1
            while j < len(args_raw) and args_raw[j].isdigit(): j += 1
            tokens.append(args_raw[i:j])
            i = j
        else:
            j = i + 1
            while j < len(args_raw) and args_raw[j].isdigit(): j += 1
            tokens.append(args_raw[i:j])
            i = j
            
    ret_type = decode_objc_type(ret_raw)
    arg_types = [decode_objc_type(t) for t in tokens]
    return ret_type, arg_types

def parse_metadata():
    cmd = ['otool', '-arch', 'arm64', '-oV', BINARY]
    raw = subprocess.check_output(cmd, text=True)

    sections = re.split(r'Contents of \((.*?)\) section\n', raw)
    sec_map = {sections[i]: sections[i+1] for i in range(1, len(sections), 2)}

    classlist_raw = sec_map.get('__DATA_CONST,__objc_classlist', '')
    catlist_raw = sec_map.get('__DATA_CONST,__objc_catlist', '')
    protolist_raw = sec_map.get('__DATA_CONST,__objc_protolist', '')

    # Parse classlist
    # Each class entry starts at a line beginning with hex address then 0x... _OBJC_CLASS_$_<name>
    class_entries = re.split(r'\n(?=[0-9a-fA-F]{16}\s+0x[0-9a-fA-F]+\s+_OBJC_CLASS_\$_)', classlist_raw)
    
    classes_dict = {}
    for entry in class_entries:
        m = re.match(r'^[0-9a-fA-F]{16}\s+0x[0-9a-fA-F]+\s+_OBJC_CLASS_\$_(\w+)', entry)
        if not m:
            continue
        cname = m.group(1)
        
        # superclass
        super_m = re.search(r'^\s+superclass\s+0x[0-9a-fA-F]+\s+_OBJC_CLASS_\$_(\w+)', entry, re.M)
        superclass = super_m.group(1) if super_m else 'NSObject'
        
        # Split Instance Class vs Meta Class
        meta_split = re.split(r'\nMeta Class\n', entry)
        instance_part = meta_split[0]
        meta_part = meta_split[1] if len(meta_split) > 1 else ''
        
        # protocols
        protocols = []
        proto_sec = re.search(r'baseProtocols\s+0x[0-9a-fA-F]+(.*?)ivars', instance_part, re.DOTALL)
        if proto_sec:
            protocols = re.findall(r'__OBJC_PROTOCOL_\$_(\w+)', proto_sec.group(1))
            protocols = list(dict.fromkeys(protocols)) # deduplicate
            
        # ivars
        ivars = []
        ivar_sec = re.search(r'ivars\s+0x[0-9a-fA-F]+\s+__OBJC_\$_INSTANCE_VARIABLES_\w+(.*?)baseProperties', instance_part, re.DOTALL)
        if ivar_sec:
            # parse each ivar entry
            ivar_matches = re.finditer(r'name\s+0x[0-9a-fA-F]+\s+(\S+)\n\s+type\s+0x[0-9a-fA-F]+\s+(\S+)', ivar_sec.group(1))
            for im in ivar_matches:
                ivars.append({
                    'name': im.group(1),
                    'raw_type': im.group(2),
                    'type': decode_objc_type(im.group(2))
                })
                
        # properties
        properties = []
        prop_sec = re.search(r'baseProperties\s+0x[0-9a-fA-F]+\s+__OBJC_\$_PROP_LIST_\w+(.*?)(?=\n\s+\w|\Z)', instance_part, re.DOTALL)
        if prop_sec:
            prop_matches = re.finditer(r'name\s+0x[0-9a-fA-F]+\s+(\S+)\n\s+attributes\s+0x[0-9a-fA-F]+\s+(\S+)', prop_sec.group(1))
            for pm in prop_matches:
                properties.append({
                    'name': pm.group(1),
                    'attributes': pm.group(2)
                })
                
        # instance methods
        instance_methods = []
        inst_meth_sec = re.search(r'baseMethods\s+0x[0-9a-fA-F]+\s+__OBJC_\$_INSTANCE_METHODS_\w+(.*?)(?=baseProtocols|ivars|baseProperties|\Z)', instance_part, re.DOTALL)
        if inst_meth_sec:
            meth_matches = re.finditer(r'name\s+0x[0-9a-fA-F]+\s+\(0x[0-9a-fA-F]+\)\s+(\S+)\n\s+types\s+0x[0-9a-fA-F]+\s+\(0x[0-9a-fA-F]+\)\s+(\S+)\n\s+imp\s+0x[0-9a-fA-F]+\s+\((0x[0-9a-fA-F]+)\)\s+-\[(\w+)\s+(.+?)\]', inst_meth_sec.group(1))
            for mm in meth_matches:
                ret_t, arg_ts = parse_method_type_encoding(mm.group(2))
                instance_methods.append({
                    'selector': mm.group(1),
                    'types_raw': mm.group(2),
                    'ret_type': ret_t,
                    'arg_types': arg_ts,
                    'imp': mm.group(3)
                })
                
        # class methods
        class_methods = []
        if meta_part:
            cls_meth_sec = re.search(r'baseMethods\s+0x[0-9a-fA-F]+\s+__OBJC_\$_CLASS_METHODS_\w+(.*?)(?=baseProtocols|ivars|baseProperties|\Z)', meta_part, re.DOTALL)
            if cls_meth_sec:
                meth_matches = re.finditer(r'name\s+0x[0-9a-fA-F]+\s+\(0x[0-9a-fA-F]+\)\s+(\S+)\n\s+types\s+0x[0-9a-fA-F]+\s+\(0x[0-9a-fA-F]+\)\s+(\S+)\n\s+imp\s+0x[0-9a-fA-F]+\s+\((0x[0-9a-fA-F]+)\)\s+\+\[(\w+)\s+(.+?)\]', cls_meth_sec.group(1))
                for mm in meth_matches:
                    ret_t, arg_ts = parse_method_type_encoding(mm.group(2))
                    class_methods.append({
                        'selector': mm.group(1),
                        'types_raw': mm.group(2),
                        'ret_type': ret_t,
                        'arg_types': arg_ts,
                        'imp': mm.group(3)
                    })
                    
        classes_dict[cname] = {
            'name': cname,
            'superclass': superclass,
            'protocols': protocols,
            'ivars': ivars,
            'properties': properties,
            'instance_methods': instance_methods,
            'class_methods': class_methods
        }

    # Parse categories
    cat_entries = re.split(r'\n(?=[0-9a-fA-F]{16}\s+0x[0-9a-fA-F]+\s+__OBJC_\$_CATEGORY_)', catlist_raw)
    categories_dict = {}
    for entry in cat_entries:
        m = re.match(r'^[0-9a-fA-F]{16}\s+0x[0-9a-fA-F]+\s+__OBJC_\$_CATEGORY_([A-Za-z0-9_]+)_\$_([A-Za-z0-9_]+)', entry)
        if not m:
            continue
        cname, catname = m.group(1), m.group(2)
        
        # instance methods
        inst_methods = []
        inst_sec = re.search(r'instanceMethods\s+0x[0-9a-fA-F]+\s+__OBJC_\$_CATEGORY_INSTANCE_METHODS_\w+(.*?)(?=classMethods|\Z)', entry, re.DOTALL)
        if inst_sec:
            meth_matches = re.finditer(r'name\s+0x[0-9a-fA-F]+\s+\(0x[0-9a-fA-F]+\)\s+(\S+)\n\s+types\s+0x[0-9a-fA-F]+\s+\(0x[0-9a-fA-F]+\)\s+(\S+)\n\s+imp\s+0x[0-9a-fA-F]+\s+\((0x[0-9a-fA-F]+)\)\s+-\[(\w+)\(\w+\)\s+(.+?)\]', inst_sec.group(1))
            for mm in meth_matches:
                ret_t, arg_ts = parse_method_type_encoding(mm.group(2))
                inst_methods.append({
                    'selector': mm.group(1),
                    'types_raw': mm.group(2),
                    'ret_type': ret_t,
                    'arg_types': arg_ts,
                    'imp': mm.group(3)
                })
                
        # class methods
        cls_methods = []
        cls_sec = re.search(r'classMethods\s+0x[0-9a-fA-F]+\s+__OBJC_\$_CATEGORY_CLASS_METHODS_\w+(.*?)(?=\Z)', entry, re.DOTALL)
        if cls_sec:
            meth_matches = re.finditer(r'name\s+0x[0-9a-fA-F]+\s+\(0x[0-9a-fA-F]+\)\s+(\S+)\n\s+types\s+0x[0-9a-fA-F]+\s+\(0x[0-9a-fA-F]+\)\s+(\S+)\n\s+imp\s+0x[0-9a-fA-F]+\s+\((0x[0-9a-fA-F]+)\)\s+\+\[(\w+)\(\w+\)\s+(.+?)\]', cls_sec.group(1))
            for mm in meth_matches:
                ret_t, arg_ts = parse_method_type_encoding(mm.group(2))
                cls_methods.append({
                    'selector': mm.group(1),
                    'types_raw': mm.group(2),
                    'ret_type': ret_t,
                    'arg_types': arg_ts,
                    'imp': mm.group(3)
                })
                
        key = f'{cname}+{catname}'
        categories_dict[key] = {
            'class_name': cname,
            'category_name': catname,
            'instance_methods': inst_methods,
            'class_methods': cls_methods
        }

    out_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'metadata.json')
    result = {
        'classes': classes_dict,
        'categories': categories_dict
    }
    with open(out_file, 'w') as f:
        json.dump(result, f, indent=2)
    print(f'Successfully wrote metadata for {len(classes_dict)} classes and {len(categories_dict)} categories to {out_file}')
    return result

if __name__ == '__main__':
    parse_metadata()
