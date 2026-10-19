// ShutdownController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001a858
// -[ShutdownController init]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] initWithWindowNibName:@"ShutdownProgress"];
    r19 = r0;
    if (r0 != 0x0) {
            r20 = dispatch_semaphore_create(0x1);
            [r19 setQuitBottleSemaphore:r20];
            [r20 release];
            [r19 setCancelingShutdown:0x0];
            [r19 setForcingShutdown:0x0];
    }
    r0 = r19;
    return r0;


// 0x10001a8e0
// -[ShutdownController bottleCollection]
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    return r0;


// 0x10001a8fc
// -[ShutdownController cancelShutdown:]
    [self setCancelingShutdown:0x1];
    [self setForcingShutdown:0x0];
    return;


// 0x10001a928
// -[ShutdownController forceShutdown:]
    [self setCancelingShutdown:0x0];
    [self setForcingShutdown:0x1];
    return;


// 0x10001a954
// -[ShutdownController shutdownAllBottles]
    r31 = r31 - 0x110;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_38 = **___stack_chk_guard;
    _CXLog();
    var_100 = q0;
    var_F0 = q0;
    r0 = [r19 bottleCollection];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 bottleList] retain];
    [r21 release];
    r0 = [r20 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r22 = *var_F0;
            do {
                    r23 = 0x0;
                    do {
                            if (*var_F0 != r22) {
                                    objc_enumerationMutation(r20);
                            }
                            [*(var_F8 + r23 * 0x8) suspend];
                            r23 = r23 + 0x1;
                    } while (r21 != r23);
                    r0 = [r20 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    [NSThread detachNewThreadSelector:@selector(shutdownAllBottlesBackground) toTarget:r19 withObject:0x0];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x10001aa90
// -[ShutdownController shutdownAllBottlesBackground]
    var_60 = d9;
    decomp_var_58 = d8;
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
    r31 = r31 + 0xffffffffffffff90 - 0x1d0;
    r20 = self;
    var_70 = **___stack_chk_guard;
    r25 = objc_autoreleasePoolPush();
    var_1B0 = q0;
    var_1A0 = q0;
    r0 = [r20 bottleCollection];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 bottleList] retain];
    [r22 release];
    r0 = [r21 countByEnumeratingWithState:&var_1B0 objects:&decomp_var_f0 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r19 = *var_1A0;
            d8 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbf0);
            var_230 = r25;
            while (true) {
                    r23 = 0x0;
                    var_228 = @selector(setCancelingShutdown:);
                    while (true) {
                            if (*var_1A0 != r19) {
                                    objc_enumerationMutation(r21);
                            }
                            r25 = *(var_1A8 + r23 * 0x8);
                            r26 = [[r20 quitBottleSemaphore] retain];
                            if (dispatch_semaphore_wait(r26, dispatch_time(0x0, 0xdf8475800)) != 0x0) {
                                    r27 = [r20 forcingShutdown];
                                    [r26 release];
                                    if ((r27 & 0x1) == 0x0) {
                                            r26 = [@(0x1) retain];
                                            [r20 performSelectorOnMainThread:var_228 withObject:r26 waitUntilDone:0x1];
                                            [r26 release];
                                    }
                            }
                            else {
                                    [r26 release];
                            }
                            if (([r20 cancelingShutdown] & 0x1) != 0x0) {
                                    temp_0 = 0x1;
                                    break;
                            }
                            if ([r20 forcingShutdown] != 0x0) {
                                    temp_0 = 0x1;
                                    break;
                            }
                            var_1D8 = *__NSConcreteStackBlock;
                            r0 = objc_retainBlock(&var_1D8);
                            r26 = r0;
                            [r25 performSelectorOnMainThread:@selector(quit:) withObject:r26 waitUntilDone:0x0];
                            [r26 release];
                            r23 = r23 + 0x1;
                            if (r22 != r23) {
                                    continue;
                            }
                            temp_0 = 0x0;
                            break;
                    }
                    if (temp_0 == 0x0) {
                            r0 = [r21 countByEnumeratingWithState:&var_1B0 objects:&decomp_var_f0 count:0x10];
                            r22 = r0;
                            r25 = var_230;
                            if (r0 != 0x0) {
                                    continue;
                            }
                            temp_1 = 0x1;
                            break;
                    }
                    if ([r20 forcingShutdown] == 0x0) {
                            temp_1 = 0x0;
                    }
                    else {
                            temp_1 = 0x0;
                    }
                    break;
            }
            if (temp_1 == 0x0) {
                    _CXLog();
                    r0 = [r20 quitBottleSemaphore];
                    r0 = [r0 retain];
                    r22 = r0;
                    dispatch_semaphore_signal(r0);
                    [r22 release];
                    r25 = var_230;
            }
    }
    [r21 release];
    if ([r20 forcingShutdown] != 0x0 && ([r20 cancelingShutdown] & 0x1) == 0x0) {
            [r20 killAllBottles];
    }
    r21 = [[**_NSApp CXServer] retain];
    r23 = [[NSNumber numberWithBool:[r20 cancelingShutdown] ^ 0x1] retain];
    [r21 performSelectorOnMainThread:@selector(replyToApplicationShouldTerminateTrampoline:) withObject:r23 waitUntilDone:0x0];
    [r23 release];
    [r21 release];
    if ([r20 cancelingShutdown] != 0x0) {
            var_220 = q0;
            var_210 = q0;
            r0 = [r20 bottleCollection];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 bottleList] retain];
            [r21 release];
            r0 = [r20 countByEnumeratingWithState:&var_220 objects:&decomp_var_170 count:0x10];
            if (r0 != 0x0) {
                    r21 = r0;
                    r19 = *var_210;
                    do {
                            r24 = 0x0;
                            do {
                                    if (*var_210 != r19) {
                                            objc_enumerationMutation(r20);
                                    }
                                    [*(var_218 + r24 * 0x8) performSelectorOnMainThread:@selector(resume) withObject:0x0 waitUntilDone:0x0];
                                    r24 = r24 + 0x1;
                            } while (r21 != r24);
                            r0 = [r20 countByEnumeratingWithState:&var_220 objects:&decomp_var_170 count:0x10];
                            r21 = r0;
                    } while (r0 != 0x0);
            }
            [r20 release];
    }
    objc_autoreleasePoolPop(r25);
    if (**___stack_chk_guard != var_70) {
            __stack_chk_fail();
    }
    return;


// 0x10001aec8
// -[ShutdownController killAllBottles]
    r31 = r31 - 0x170;
    var_60 = d9;
    decomp_var_58 = d8;
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
    r19 = self;
    var_70 = **___stack_chk_guard;
    var_130 = q0;
    var_120 = q0;
    r0 = [self bottleCollection];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 bottleList] retain];
    [r21 release];
    r0 = [r20 countByEnumeratingWithState:&var_130 objects:&decomp_var_f0 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r27 = *var_120;
            d8 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbf0);
            while (true) {
                    r28 = 0x0;
                    while (true) {
                            if (*var_120 != r27) {
                                    objc_enumerationMutation(r20);
                            }
                            r24 = *(var_128 + r28 * 0x8);
                            r25 = [[r19 quitBottleSemaphore] retain];
                            r26 = dispatch_semaphore_wait(r25, dispatch_time(0x0, 0xdf8475800));
                            [r25 release];
                            if (r26 != 0x0) {
                                    r25 = [@(0x1) retain];
                                    [r19 performSelectorOnMainThread:@selector(setCancelingShutdown:) withObject:r25 waitUntilDone:0x1];
                                    [r25 release];
                            }
                            if ([r19 cancelingShutdown] != 0x0) {
                                    r0 = [r19 quitBottleSemaphore];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    dispatch_semaphore_signal(r0);
                                    [r19 release];
                                    temp_0 = 0x1;
                                    break;
                            }
                            var_158 = *__NSConcreteStackBlock;
                            r0 = objc_retainBlock(&var_158);
                            r25 = r0;
                            [r24 performSelectorOnMainThread:@selector(forceQuit:) withObject:r25 waitUntilDone:0x0];
                            [r25 release];
                            r28 = r28 + 0x1;
                            if (r21 != r28) {
                                    continue;
                            }
                            temp_0 = 0x0;
                            break;
                    }
                    if (temp_0 == 0x0) {
                            r0 = [r20 countByEnumeratingWithState:&var_130 objects:&decomp_var_f0 count:0x10];
                            r21 = r0;
                            if (r0 != 0x0) {
                                    continue;
                            }
                            temp_1 = 0x0;
                            break;
                    }
                    temp_1 = 0x1;
                    break;
            }
    }
    [r20 release];
    if (**___stack_chk_guard != var_70) {
            __stack_chk_fail();
    }
    return;


// 0x10001b13c
// -[ShutdownController windowDidLoad]
    var_20 = self;
    [[&var_20 super] windowDidLoad];
    r0 = [self window];
    r0 = [r0 retain];
    r19 = r0;
    [r0 recalculateKeyViewLoop];
    [r19 release];
    return;


// 0x10001b19c
// -[ShutdownController quitBottleSemaphore]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_quitBottleSemaphore)), 0x1);
    return r0;


// 0x10001b1ac
// -[ShutdownController setQuitBottleSemaphore:]
    objc_setProperty_atomic();
    return;


// 0x10001b1b8
// -[ShutdownController cancelingShutdown]
    r0 = *(int8_t *)(int64_t *)&self->_cancelingShutdown & 0x1;
    return r0;


// 0x10001b1cc
// -[ShutdownController setCancelingShutdown:]
    *(int8_t *)(int64_t *)&self->_cancelingShutdown = arg2;
    return;


// 0x10001b1dc
// -[ShutdownController forcingShutdown]
    r0 = *(int8_t *)(int64_t *)&self->_forcingShutdown & 0x1;
    return r0;


// 0x10001b1f0
// -[ShutdownController setForcingShutdown:]
    *(int8_t *)(int64_t *)&self->_forcingShutdown = arg2;
    return;


// 0x10001b200
// -[ShutdownController bottleList]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleList)), 0x1);
    return r0;


// 0x10001b210
// -[ShutdownController setBottleList:]
    objc_setProperty_atomic();
    return;


// 0x10001b21c
// -[ShutdownController canRunFilterPredicate]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_canRunFilterPredicate)), 0x1);
    return r0;


// 0x10001b22c
// -[ShutdownController setCanRunFilterPredicate:]
    objc_setProperty_atomic();
    return;


// 0x10001b238
// -[ShutdownController shutdownCallbackObject]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_shutdownCallbackObject)), 0x1);
    return r0;


// 0x10001b248
// -[ShutdownController setShutdownCallbackObject:]
    objc_setProperty_atomic();
    return;


// 0x10001b254
// -[ShutdownController shutdownCallbackSelector]
    r0 = self->_shutdownCallbackSelector;
    return r0;


// 0x10001b264
// -[ShutdownController setShutdownCallbackSelector:]
    self->_shutdownCallbackSelector = arg2;
    return;


// 0x10001b274
// -[ShutdownController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_shutdownCallbackObject, 0x0);
    objc_storeStrong((int64_t *)&self->_canRunFilterPredicate, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleList, 0x0);
    objc_storeStrong((int64_t *)&self->_quitBottleSemaphore, 0x0);
    objc_storeStrong((int64_t *)&self->bottleArray, 0x0);
    return;


// === Block Invocations for ShutdownController ===

// 0x10001ae94
// ___50-[ShutdownController shutdownAllBottlesBackground]_block_invoke
    r0 = arg0[0x4];
    r0 = [r0 quitBottleSemaphore];
    r0 = [r0 retain];
    r19 = r0;
    dispatch_semaphore_signal(r0);
    r0 = [r19 release];
    return r0;


// 0x10001b108
// ___36-[ShutdownController killAllBottles]_block_invoke
    r0 = arg0[0x4];
    r0 = [r0 quitBottleSemaphore];
    r0 = [r0 retain];
    r19 = r0;
    dispatch_semaphore_signal(r0);
    r0 = [r19 release];
    return r0;


