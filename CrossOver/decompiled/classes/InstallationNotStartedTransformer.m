// InstallationNotStartedTransformer — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100008514
// +[InstallationNotStartedTransformer allowsReverseTransformation]
    return 0x0;


// 0x10000851c
// +[InstallationNotStartedTransformer transformedValueClass]
    r0 = objc_opt_class(@class(NSNumber));
    return r0;


// 0x100008528
// -[InstallationNotStartedTransformer transformedValue:]
    r2 = arg2;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if ([r2 intValue] != 0x1) {
            r2 = 0x1;
    }
    r0 = [NSNumber numberWithBool:r2];
    return r0;


