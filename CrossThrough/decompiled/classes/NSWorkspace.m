// NSWorkspace — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000369d4
// -[NSWorkspace CX_findRunningAppBundleWithIdentifier:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [NSRunningApplication runningApplicationsWithBundleIdentifier:arg2];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 count] != 0x0) {
            r0 = [r19 objectAtIndex:0x0];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 bundleURL];
            r0 = [r0 retain];
            r22 = r0;
            r20 = [[r0 path] retain];
            [r22 release];
            [r21 release];
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100036a70
// -[NSWorkspace CX_absolutePathForAppBundleWithIdentifier:orIdentifyingURLScheme:]
    r3 = arg3;
    r31 = r31 - 0x1a0;
    var_50 = r28;
    decomp_var_48 = r27;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = r3;
    r20 = _cmd;
    r19 = self;
    var_60 = **___stack_chk_guard;
    r26 = [arg2 retain];
    r22 = [r21 retain];
    if (r26 == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r21 = r0;
            r3 = r19;
            [r0 handleFailureInMethod:r20 object:r3 file:@"NSWorkspace+CrossOverAdditions.m" lineNumber:0x22 description:@"Invalid parameter not satisfying: %@"];
            [r21 release];
    }
    r20 = [[r19 CX_findRunningAppBundleWithIdentifier:r26] retain];
    if (r22 != 0x0 && r20 == 0x0) {
            var_130 = [[NSFileManager defaultManager] retain];
            r21 = [[NSString stringWithFormat:@"%@:fake", r3] retain];
            r23 = [[NSURL URLWithString:r21] retain];
            [r21 release];
            r20 = LSCopyApplicationURLsForURL(r23, 0xffffffff);
            r24 = [[NSDate distantPast] retain];
            var_120 = q0;
            var_110 = q0;
            r0 = [r20 retain];
            r21 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
            if (r0 != 0x0) {
                    r28 = r0;
                    var_150 = r24;
                    var_188 = r23;
                    var_180 = r22;
                    var_178 = r19;
                    var_168 = 0x0;
                    r22 = *var_110;
                    var_140 = **_kCFBundleVersionKey;
                    var_138 = r21;
                    var_16C = 0xffffffff;
                    var_15C = 0xffffffff;
                    r19 = r21;
                    do {
                            r24 = 0x0;
                            do {
                                    if (*var_110 != r22) {
                                            objc_enumerationMutation(r19);
                                    }
                                    r23 = *(var_118 + r24 * 0x8);
                                    r20 = objc_autoreleasePoolPush();
                                    r0 = [CXBundle bundleWithURL:r23];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    if (r0 == 0x0) {
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    r0 = [r21 bundleIdentifier];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    if ([r0 caseInsensitiveCompare:r26] != 0x0) {
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    r19 = r26;
                                    r26 = [[r21 executablePath] retain];
                                    r27 = [var_130 isExecutableFileAtPath:r26];
                                    [r26 release];
                                    [r25 release];
                                    if (r27 == 0x0) {
                                            r26 = r19;
                                            r19 = var_138;
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    r25 = [[r21 objectForInfoDictionaryKey:var_140] retain];
                                    r0 = [NSScanner scannerWithString:r25];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 scanInt:&var_124];
                                    if (r0 == 0x0) {
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    if ([r26 scanString:@"." intoString:0x0] == 0x0) {
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    r0 = [r26 scanInt:&var_128];
                                    if (r0 == 0x0) {
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    if ([r26 scanString:@"." intoString:0x0] == 0x0) {
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    if (var_124 < 0x1) {
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    if ((var_128 & 0xffffffff80000000) != 0x0) {
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    r0 = [r23 URLByResolvingSymlinksInPath];
                                    r0 = [r0 retain];
                                    var_158 = r0;
                                    r27 = [[r0 path] retain];
                                    var_148 = [[var_130 attributesOfItemAtPath:r27 error:0x0] retain];
                                    [r27 release];
                                    [var_158 release];
                                    r27 = [[var_148 fileModificationDate] retain];
                                    r8 = var_124;
                                    r11 = var_15C;
                                    bool_35 = r8 != r11;
                                    if (r8 > r11) {
                                            var_158 = [r23 retain];
                                            [var_168 release];
                                            var_15C = var_124;
                                            var_16C = var_128;
                                            r23 = [r27 copy];
                                            [var_150 release];
                                            var_150 = r23;
                                            var_168 = var_158;
                                            [r27 release];
                                            [var_148 release];
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    r9 = var_128;
                                    if (bool_35) {
                                            if (r8 == r11 && r9 == var_16C) {
                                                    if ([r27 compare:var_150] == 0x1) {
                                                            var_158 = [r23 retain];
                                                            [var_168 release];
                                                            var_15C = var_124;
                                                            var_16C = var_128;
                                                            r23 = [r27 copy];
                                                            [var_150 release];
                                                            var_150 = r23;
                                                            var_168 = var_158;
                                                    }
                                            }
                                            [r27 release];
                                            [var_148 release];
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    if (r9 > var_16C) {
                                            var_158 = [r23 retain];
                                            [var_168 release];
                                            var_15C = var_124;
                                            var_16C = var_128;
                                            r23 = [r27 copy];
                                            [var_150 release];
                                            var_150 = r23;
                                            var_168 = var_158;
                                            [r27 release];
                                            [var_148 release];
                                            [r26 release];
                                            r26 = r19;
                                            r19 = var_138;
                                            [r25 release];
                                            [r21 release];
                                            objc_autoreleasePoolPop(r20);
                                            r24 = r24 + 0x1;
                                            if (r28 != r24) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    if (r8 == r11 && r9 == var_16C) {
                                            if ([r27 compare:var_150] == 0x1) {
                                                    var_158 = [r23 retain];
                                                    [var_168 release];
                                                    var_15C = var_124;
                                                    var_16C = var_128;
                                                    r23 = [r27 copy];
                                                    [var_150 release];
                                                    var_150 = r23;
                                                    var_168 = var_158;
                                            }
                                    }
                                    [r27 release];
                                    [var_148 release];
                                    [r26 release];
                                    r26 = r19;
                                    r19 = var_138;
                                    [r25 release];
                                    [r21 release];
                                    objc_autoreleasePoolPop(r20);
                                    r24 = r24 + 0x1;
                            } while (r28 != r24);
                            r0 = [r19 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                            r28 = r0;
                    } while (r0 != 0x0);
                    [r19 release];
                    r25 = var_168;
                    if (r25 != 0x0) {
                            r20 = [[r25 path] retain];
                    }
                    else {
                            r20 = 0x0;
                    }
                    r22 = var_180;
                    r19 = var_178;
                    r23 = var_188;
                    r21 = var_138;
                    r24 = var_150;
            }
            else {
                    [r21 release];
                    r25 = 0x0;
                    r20 = 0x0;
            }
            [r24 release];
            [r25 release];
            [r21 release];
            [r23 release];
            [var_130 release];
    }
    if (r20 == 0x0) {
            r20 = [[r19 absolutePathForAppBundleWithIdentifier:r26] retain];
    }
    [r22 release];
    r0 = [r26 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r20 autorelease];
    return r0;


// 0x100036fbc
// -[NSWorkspace CX_launchAppWithBundleIdentifier:orIdentifyingURLScheme:options:additionalEventParamDescriptor:]
    r31 = r31 - 0x60;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg4;
    r24 = _cmd;
    r23 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r22 = [arg5 retain];
    if (r19 == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r25 = r0;
            [r0 handleFailureInMethod:r24 object:r23 file:@"NSWorkspace+CrossOverAdditions.m" lineNumber:0x77 description:@"Invalid parameter not satisfying: %@"];
            [r25 release];
    }
    r0 = [r23 CX_findRunningAppBundleWithIdentifier:r19];
    r0 = [r0 retain];
    r24 = r0;
    [r0 release];
    if (r24 != 0x0) {
            r21 = 0x1;
    }
    else {
            r21 = [r23 CX_openURLs:0x0 withAppBundleIdentifier:r19 orIdentifyingURLScheme:r20 options:r21 additionalEventParamDescriptor:r22];
    }
    [r22 release];
    [r20 release];
    [r19 release];
    r0 = r21;
    return r0;


// 0x1000370e4
// -[NSWorkspace CX_openURLs:withAppBundleIdentifier:orIdentifyingURLScheme:options:additionalEventParamDescriptor:]
    r31 = r31 - 0x80;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = arg5;
    r25 = _cmd;
    r24 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    r23 = [arg6 retain];
    if (r20 != 0x0) {
            r0 = [r24 CX_absolutePathForAppBundleWithIdentifier:r20 orIdentifyingURLScheme:r21];
            r0 = [r0 retain];
            if (r0 != 0x0) {
                    r24 = [[NSURL fileURLWithPath:r0] retain];
                    [r0 release];
                    [r24 release];
                    var_68 = r24;
                    [objc_retainAutorelease(r23) aeDesc];
                    r0 = LSOpenFromURLSpec(&var_68, 0x0);
                    if (r0 == 0x0) {
                            r22 = 0x1;
                    }
            }
            else {
                    r22 = 0x0;
            }
            [r23 release];
            [r21 release];
            [r20 release];
            [r19 release];
            r0 = r22;
    }
    else {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r26 = r0;
            [r0 handleFailureInMethod:r25 object:r24 file:@"NSWorkspace+CrossOverAdditions.m" lineNumber:0x96 description:@"Invalid parameter not satisfying: %@"];
            [r26 release];
            if (r21 == 0x0) {
                    var_68 = 0x0;
                    [objc_retainAutorelease(r23) aeDesc];
                    r0 = LSOpenFromURLSpec(&var_68, 0x0);
                    if (r0 == 0x0) {
                            r22 = 0x1;
                    }
                    [r23 release];
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    r0 = r22;
            }
            else {
                    r0 = [r24 CX_absolutePathForAppBundleWithIdentifier:r20 orIdentifyingURLScheme:r21];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r24 = [[NSURL fileURLWithPath:r0] retain];
                            [r0 release];
                            [r24 release];
                            var_68 = r24;
                            [objc_retainAutorelease(r23) aeDesc];
                            r0 = LSOpenFromURLSpec(&var_68, 0x0);
                            if (r0 == 0x0) {
                                    r22 = 0x1;
                            }
                    }
                    else {
                            r22 = 0x0;
                    }
                    [r23 release];
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    r0 = r22;
            }
    }
    return r0;


