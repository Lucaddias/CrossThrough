// helperServer — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100037268
// -[helperServer init]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_30 = self;
    r0 = [[&var_30 super] init];
    r19 = r0;
    if (r0 != 0x0) {
            r20 = [[NSPort port] retain];
            r0 = [NSConnection alloc];
            r0 = [r0 initWithReceivePort:r20 sendPort:r20];
            r8 = r19[0x2];
            r19[0x2] = r0;
            [r8 release];
            r21 = r19[0x2];
            r22 = [[NSProtocolChecker protocolCheckerWithTarget:r19 protocol:@protocol()] retain];
            [r21 setRootObject:r22];
            [r22 release];
            if (([r19[0x2] registerName:@"com.codeweavers.CrossOver.HelperServer"] & 0x1) == 0x0) {
                    NSLog(@"Failed to register our helper server.  What do we do now?\n");
            }
            r19[0x8] = 0x0;
            [r20 release];
    }
    r0 = r19;
    return r0;


// 0x100037360
// -[helperServer getEnvironmentForXConnection]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (self[0x8] != 0x0) {
            r0 = [NSProcessInfo processInfo];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 environment];
            r0 = [r0 retain];
            r21 = r0;
            r19 = [r0 mutableCopy];
            [r21 release];
            [r20 release];
            r20 = [[**_NSApp crossOverRoot] retain];
            [r19 setObject:r20 forKey:@"CX_ROOT"];
            [r20 release];
    }
    else {
            r19 = 0x0;
    }
    r0 = [r19 autorelease];
    return r0;


// 0x10003740c
// +[helperServer defaultHelperServer]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = objc_opt_class(@class(helperServer));
    r0 = [r0 retain];
    r19 = r0;
    objc_sync_enter(r0);
    if (*_singleton == 0x0) {
            r0 = [[helperServer alloc] init];
            r8 = *_singleton;
            *_singleton = r0;
            [r8 release];
    }
    objc_sync_exit(r19);
    [r19 release];
    r0 = *_singleton;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100037494
// -[helperServer setIsReady]
    self[0x8] = 0x1;
    return;


// 0x1000374a0
// -[helperServer isServerReady]
    r0 = self[0x8];
    return r0;


// 0x1000374a8
// -[helperServer isServerReadyForBottle:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    if (self[0x8] != 0x0) {
            r0 = [CXSetupLib bottleCollectionClass];
            r0 = [r0 sharedCollection];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 bottleWithName:r19] retain];
            [r21 release];
            if (r20 != 0x0) {
                    if ([r20 isIsDisabled] != 0x0) {
                            r20 = [[r20 name] retain];
                            r19 = [[NSString stringWithFormat:@"Bottle \"%@\" is disabled.", r3] retain];
                            [r20 release];
                            r0 = [NSException exceptionWithName:@"HelperServerException" reason:r19 userInfo:0x0];
                            r0 = [r0 retain];
                            r0 = objc_retainAutorelease(r0);
                            objc_exception_throw(r0);
                    }
                    r21 = [r20 isCanRunCommands];
                    [r20 release];
                    [r19 release];
                    r0 = r21;
            }
            else {
                    [r19 release];
                    r0 = 0x0;
            }
    }
    else {
            [r19 release];
            r0 = 0x0;
    }
    return r0;


// 0x1000375c8
// -[helperServer raiseWindowsWithTag:]
    [**_NSApp arrangeInFront:0x0];
    return;


// 0x1000375dc
// -[helperServer theConnection]
    r0 = objc_getProperty(self, _cmd, 0x10, 0x1);
    return r0;


// 0x1000375e8
// -[helperServer setTheConnection:]
    objc_setProperty_atomic();
    return;


// 0x1000375f0
// -[helperServer .cxx_destruct]
    objc_storeStrong(self + 0x10, 0x0);
    return;


