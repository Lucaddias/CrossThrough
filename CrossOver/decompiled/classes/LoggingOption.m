// LoggingOption — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100034128
// +[LoggingOption loggingOptionWithName:channels:environment:]
    r22 = [arg4 retain];
    r19 = [arg3 retain];
    r20 = [arg2 retain];
    r21 = [[self alloc] initWithName:r20 channels:r19 environment:r22];
    [r22 release];
    [r19 release];
    [r20 release];
    r0 = [r21 autorelease];
    return r0;


// 0x1000341b0
// +[LoggingOption loggingOptionWithName:channels:]
    r21 = [arg3 retain];
    r19 = [arg2 retain];
    r20 = [[self alloc] initWithName:r19 channels:r21 environment:**___NSArray0__];
    [r21 release];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100034228
// +[LoggingOption commonPresets]
    r31 = r31 - 0x40;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_28 = *__NSConcreteStackBlock;
    if (*_commonPresets.onceToken != -0x1) {
            dispatch_once(_commonPresets.onceToken, &var_28);
    }
    r0 = *_commonPresets.presets;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100034480
// -[LoggingOption initWithName:channels:environment:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    var_30 = self;
    r0 = [[&var_30 super] init];
    r22 = r0;
    if (r0 != 0x0) {
            r0 = [r19 copy];
            r8 = r22[0x1];
            r22[0x1] = r0;
            [r8 release];
            r0 = [r20 copy];
            r8 = r22[0x2];
            r22[0x2] = r0;
            [r8 release];
            r0 = [r21 copy];
            r8 = r22[0x3];
            r22[0x3] = r0;
            [r8 release];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = r22;
    return r0;


// 0x100034560
// -[LoggingOption name]
    r0 = self[0x1];
    return r0;


// 0x100034568
// -[LoggingOption setName:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100034570
// -[LoggingOption logChannels]
    r0 = self[0x2];
    return r0;


// 0x100034578
// -[LoggingOption setLogChannels:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100034580
// -[LoggingOption logEnvironment]
    r0 = self[0x3];
    return r0;


// 0x100034588
// -[LoggingOption setLogEnvironment:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100034590
// -[LoggingOption .cxx_destruct]
    objc_storeStrong(self + 0x18, 0x0);
    objc_storeStrong(self + 0x10, 0x0);
    objc_storeStrong(self + 0x8, 0x0);
    return;


// === Block Invocations for LoggingOption ===

// 0x10003429c
// ___30+[LoggingOption commonPresets]_block_invoke
    r31 = r31 - 0x140;
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
    r19 = arg0;
    var_60 = **___stack_chk_guard;
    r0 = [NSMutableArray array];
    r0 = [r0 retain];
    r8 = *_commonPresets.presets;
    *_commonPresets.presets = r0;
    [r8 release];
    var_120 = q0;
    var_110 = q0;
    r0 = [CXSetupLib cxUtilsClass];
    r0 = [r0 loggingPresets];
    r0 = [r0 retain];
    var_128 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r21 = *var_110;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_110 != r21) {
                                    objc_enumerationMutation(var_128);
                            }
                            r25 = *(var_118 + r22 * 0x8);
                            r26 = *_commonPresets.presets;
                            r27 = r19[0x4];
                            r28 = [[r25 valueForKey:@"label"] retain];
                            r20 = [[r25 valueForKey:@"channels"] retain];
                            r25 = [[r25 valueForKey:@"environment"] retain];
                            r27 = [[r27 loggingOptionWithName:r28 channels:r20 environment:r25] retain];
                            [r26 addObject:r27];
                            [r27 release];
                            [r25 release];
                            [r20 release];
                            [r28 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [var_128 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    r0 = [var_128 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return r0;


