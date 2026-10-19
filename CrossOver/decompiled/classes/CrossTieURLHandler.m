// CrossTieURLHandler — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100058f3c
// -[CrossTieURLHandler dealloc]
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x100058fa4
// -[CrossTieURLHandler downloadWindowWillClose:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self downloadProgress];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 path];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    [r20 release];
    if (r21 != 0x0) {
            r21 = *_NSApp;
            r20 = [[*r21 delegate] retain];
            r21 = *r21;
            r0 = [r19 downloadProgress];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 path] retain];
            [r20 application:r21 openFile:r23];
            [r23 release];
            [r22 release];
            [r20 release];
    }
    r20 = [[r19 delegate] retain];
    r21 = objc_opt_respondsToSelector();
    [r20 release];
    if ((r21 & 0x1) != 0x0) {
            r0 = [r19 delegate];
            r0 = [r0 retain];
            r20 = r0;
            [r0 crossTieURLDidFinish:r19];
            [r20 release];
    }
    return;


// 0x1000590d0
// -[CrossTieURLHandler doInstallWithParameters:]
    r1 = _cmd;
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
    r21 = self;
    r0 = [arg2 objectForKey:@"crosstie"];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 length] != 0x0) {
            r0 = [NSURL URLWithString:r19];
            r0 = [r0 retain];
            r20 = r0;
            if (r0 != 0x0) {
                    r22 = [[DownloadProgressController alloc] initWithURL:r20];
                    [r21 setDownloadProgress:r22];
                    [r22 release];
                    r0 = [r21 downloadProgress];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 showWindow:r21];
                    [r22 release];
                    r0 = [r21 downloadProgress];
                    r0 = [r0 retain];
                    r22 = r0;
                    r0 = [r0 window];
                    r0 = [r0 retain];
                    r23 = r0;
                    [r0 makeFirstResponder:0x0];
                    [r23 release];
                    [r22 release];
                    r22 = [[NSNotificationCenter defaultCenter] retain];
                    r24 = **_NSWindowWillCloseNotification;
                    r0 = [r21 downloadProgress];
                    r0 = [r0 retain];
                    r25 = r0;
                    r26 = [[r0 window] retain];
                    [r22 addObserver:r21 selector:@selector(downloadWindowWillClose:) name:r24 object:r26];
                    [r26 release];
                    [r25 release];
                    [r22 release];
            }
            else {
                    NSLog(@"CrossTie install URL has invalid 'crosstie' parameter: %@\n", r1);
            }
            [r20 release];
    }
    else {
            NSLog(@"CrossTie install URL has no 'crosstie' parameter.");
    }
    [r19 release];
    return;


// 0x100059290
// -[CrossTieURLHandler handleCrossTieURL:]
    r1 = _cmd;
    r31 = r31 - 0x170;
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
    var_150 = self;
    var_60 = **___stack_chk_guard;
    r0 = [arg2 retain];
    r19 = r0;
    r0 = [r0 resourceSpecifier];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 rangeOfString:@"?"];
    var_138 = r20;
    var_130 = r19;
    if (r0 == 0x7fffffffffffffff) {
            r21 = [r20 retain];
            r19 = @"";
    }
    else {
            r21 = [[r20 substringToIndex:r0] retain];
            r19 = [[r20 substringFromIndex:r0 + 0x1] retain];
    }
    var_148 = [[r21 stringByRemovingPercentEncoding] retain];
    [r21 release];
    r24 = [[NSMutableDictionary dictionary] retain];
    var_120 = q0;
    var_110 = q0;
    var_140 = r19;
    r0 = [r19 componentsSeparatedByString:@"&"];
    r0 = [r0 retain];
    var_128 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r27 = r0;
            r23 = *var_110;
            do {
                    r25 = 0x0;
                    do {
                            if (*var_110 != r23) {
                                    objc_enumerationMutation(var_128);
                            }
                            r28 = *(var_118 + r25 * 0x8);
                            r0 = [r28 rangeOfString:@"="];
                            if (r0 == 0x7fffffffffffffff) {
                                    r21 = [r28 retain];
                                    r28 = @"";
                            }
                            else {
                                    r21 = [[r28 substringToIndex:r0] retain];
                                    r28 = [[r28 substringFromIndex:r0 + 0x1] retain];
                            }
                            r0 = [r21 stringByRemovingPercentEncoding];
                            r0 = [r0 retain];
                            r22 = r0;
                            r19 = [[r0 lowercaseString] retain];
                            [r21 release];
                            [r22 release];
                            r21 = [[r28 stringByRemovingPercentEncoding] retain];
                            [r28 release];
                            [r24 setObject:r21 forKey:r19];
                            [r21 release];
                            [r19 release];
                            r25 = r25 + 0x1;
                    } while (r27 != r25);
                    r0 = [var_128 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r27 = r0;
            } while (r0 != 0x0);
    }
    [var_128 release];
    r21 = var_148;
    if ([r21 caseInsensitiveCompare:@"install"] != 0x0) {
            r19 = var_130;
            NSLog(@"Unknown verb '%@' in CrossTie URL %@\n", r1, @"install");
    }
    else {
            [var_150 doInstallWithParameters:r24];
            r19 = var_130;
    }
    [r24 release];
    [var_140 release];
    [r21 release];
    [var_138 release];
    [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x1000595a0
// -[CrossTieURLHandler delegate]
    r0 = objc_loadWeakRetained(self + 0x8);
    r0 = [r0 autorelease];
    return r0;


// 0x1000595b8
// -[CrossTieURLHandler setDelegate:]
    objc_storeWeak(self + 0x8, arg2);
    return;


// 0x1000595c4
// -[CrossTieURLHandler downloadProgress]
    r0 = objc_getProperty(self, _cmd, 0x10, 0x1);
    return r0;


// 0x1000595d0
// -[CrossTieURLHandler setDownloadProgress:]
    objc_setProperty_atomic();
    return;


// 0x1000595d8
// -[CrossTieURLHandler .cxx_destruct]
    objc_storeStrong(self + 0x10, 0x0);
    objc_destroyWeak(self + 0x8);
    return;


