// CXTask — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100039774
// -[CXTask initWithTask:]
    objc_storeStrong((int64_t *)&self->realTask, arg2);
    r19 = [arg2 retain];
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addObserver:self selector:@selector(cxtaskObserveRealTaskTermination:) name:**_NSTaskDidTerminateNotification object:self->realTask];
    [r19 release];
    [r22 release];
    r0 = self;
    return r0;


// 0x10003980c
// -[CXTask init]
    r20 = [[NSTask alloc] init];
    r19 = [self initWithTask:r20];
    [r20 release];
    r0 = r19;
    return r0;


// 0x100039854
// -[CXTask dealloc]
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x1000398bc
// -[CXTask cxtaskObserveRealTaskTermination:]
    r21 = [arg2 retain];
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self];
    r22 = [[r21 name] retain];
    [r21 release];
    [r20 postNotificationName:r22 object:self];
    [r22 release];
    [r20 release];
    return;


// 0x100039948
// +[CXTask argumentsWithStringsReplacedBySpecialStrings:]
    r31 = r31 - 0x130;
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
    var_58 = **___stack_chk_guard;
    r0 = [arg2 retain];
    r20 = r0;
    r19 = [[NSMutableArray arrayWithCapacity:[r0 count]] retain];
    var_120 = q0;
    var_110 = q0;
    r0 = [r20 retain];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r24 = *var_110;
            do {
                    r27 = 0x0;
                    do {
                            if (*var_110 != r24) {
                                    objc_enumerationMutation(r20);
                            }
                            r22 = [*(var_118 + r27 * 0x8) retain];
                            objc_opt_class(@class(NSString));
                            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                    r23 = [[CXTaskSpecialString alloc] initWithString:r22];
                                    [r22 release];
                                    r22 = r23;
                            }
                            [r19 addObject:r22];
                            [r22 release];
                            r27 = r27 + 0x1;
                    } while (r21 != r27);
                    r0 = [r20 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    r0 = [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x100039ad8
// +[CXTask launchedTaskWithLaunchPath:arguments:]
    r21 = [arg2 retain];
    r19 = [[self argumentsWithStringsReplacedBySpecialStrings:arg3] retain];
    r22 = [[NSTask launchedTaskWithLaunchPath:r21 arguments:r19] retain];
    [r21 release];
    r20 = [[objc_opt_class(self) alloc] initWithTask:r22];
    [r22 release];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100039b78
// -[CXTask setArguments:]
    r20 = [arg2 retain];
    r21 = [[objc_opt_class(self) argumentsWithStringsReplacedBySpecialStrings:r20] retain];
    [r20 release];
    [self->realTask setArguments:r21];
    [r21 release];
    return;


// 0x100039be4
// -[CXTask forwardingTargetForSelector:]
    r0 = self->realTask;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100039bf4
// -[CXTask .cxx_destruct]
    objc_storeStrong((int64_t *)&self->realTask, 0x0);
    return;


