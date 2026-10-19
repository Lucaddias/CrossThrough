// BooleanToLabelColorTransformer — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000100e4
// +[BooleanToLabelColorTransformer allowsReverseTransformation]
    return 0x0;


// 0x1000100ec
// +[BooleanToLabelColorTransformer transformedValueClass]
    r0 = objc_opt_class(@class(NSColor));
    return r0;


// 0x1000100f8
// -[BooleanToLabelColorTransformer transformedValue:]
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    if (([arg2 boolValue] & 0x1) != 0x0) {
            r0 = [NSColor controlTextColor];
            r0 = [r0 retain];
    }
    else {
            r0 = [NSColor disabledControlTextColor];
            r0 = [r0 retain];
    }
    r0 = [r0 autorelease];
    return r0;


