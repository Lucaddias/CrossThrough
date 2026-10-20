// UpdateController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100016d4c
// -[UpdateController initWithManagedBottles:]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    var_20 = self;
    r0 = [[&var_20 super] initWithWindowNibName:@"Update"];
    r20 = r0;
    if (r0 != 0x0) {
            if (r19 != 0x0 && [r19 count] != 0x0) {
                    r0 = r20;
                    r2 = r19;
            }
            else {
                    r0 = r20;
                    r2 = 0x0;
            }
            [r0 setManagedBottlesToUpgrade:r2];
            [r20 setUpgradeInProgress:0x0];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100016de8
// -[UpdateController windowDidLoad]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_30 = self;
    [[&var_30 super] windowDidLoad];
    r20 = [[NSMutableArray array] retain];
    r0 = [r19 messageTextField];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 isHiddenOrHasHiddenAncestor];
    [r21 release];
    if (r22 != 0x0) {
            r21 = [[r19 messageToTableSpacing] retain];
            [r20 addObject:r21];
            [r21 release];
    }
    r0 = [r19 bottleTableScrollView];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 isHiddenOrHasHiddenAncestor];
    [r21 release];
    if (r22 != 0x0) {
            r21 = [[r19 tableToUpgradingSpacing] retain];
            [r20 addObject:r21];
            [r21 release];
    }
    if ([r20 count] != 0x0) {
            r0 = [r19 window];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 contentView];
            r0 = [r0 retain];
            r22 = r0;
            [r0 removeConstraints:r20];
            [r22 release];
            [r21 release];
    }
    r0 = [r19 managedBottlesToUpgrade];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    if (r21 == 0x0) {
            [r19 finish];
    }
    [r20 release];
    return;


// 0x100016f5c
// -[UpdateController finish]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [[**_NSApp modalWindow] retain];
    r0 = [r19 window];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    [r20 release];
    if (r20 == r21) {
            [**_NSApp abortModal];
    }
    [r19 close];
    return;


// 0x100016fd0
// -[UpdateController updatePressed:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    [self setUpgradeInProgress:0x1];
    r0 = [SFAuthorization authorization];
    r0 = [r0 retain];
    r20 = r0;
    if (([r0 obtainWithRight:"system.privilege.admin" flags:0x13 error:0x0] & 0x1) != 0x0) {
            [NSThread detachNewThreadSelector:@selector(doUpdateWithAuthorization:) toTarget:r19 withObject:r20];
    }
    else {
            [r19 setUpgradeInProgress:0x0];
    }
    [r20 release];
    return;


// 0x100017054
// -[UpdateController doUpdateWithAuthorization:]
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
    r20 = self;
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r21 = objc_autoreleasePoolPush();
    var_120 = q0;
    var_110 = q0;
    r0 = [r20 managedBottlesToUpgrade];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r27 = *var_110;
            do {
                    r28 = 0x0;
                    do {
                            if (*var_110 != r27) {
                                    objc_enumerationMutation(r22);
                            }
                            r25 = *(var_118 + r28 * 0x8);
                            r26 = [[r25 name] retain];
                            _CXLog();
                            [r26 release];
                            [r20 updateBottle:r25 WithAuthorization:r19];
                            r28 = r28 + 0x1;
                    } while (r24 != r28);
                    r0 = [r22 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r22 release];
    [r20 performSelectorOnMainThread:@selector(finish) withObject:0x0 waitUntilDone:0x0];
    objc_autoreleasePoolPop(r21);
    [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x1000171d4
// -[UpdateController updateBottle:WithAuthorization:]
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
    r31 = r31 + 0xffffffffffffffb0 - 0x470;
    var_48 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    if (([r19 isIsManaged] & 0x1) != 0x0) {
            if (r20 != 0x0) {
                    r0 = **_NSApp;
                    r0 = [r0 crossOverRoot];
                    r0 = [r0 retain];
                    r21 = r0;
                    r0 = [r0 stringByAppendingPathComponent:@"bin"];
                    r0 = [r0 retain];
                    r22 = r0;
                    r23 = [[r0 stringByAppendingPathComponent:@"cxbounce"] retain];
                    [r22 release];
                    [r21 release];
                    var_488 = "wine";
                    r0 = [r19 name];
                    r0 = [r0 retain];
                    r0 = objc_retainAutorelease(r0);
                    r21 = r0;
                    [r0 UTF8String];
                    [r21 release];
                    var_490 = 0x0;
                    r22 = [r20 authorizationRef];
                    r0 = objc_retainAutorelease(r23);
                    r21 = r0;
                    r1 = [r0 fileSystemRepresentation];
                    r0 = AuthorizationExecuteWithPrivileges(r22, r1, 0x0, &var_488, &var_490);
                    if (r0 != 0x0) {
                            r22 = [[r19 name] retain];
                            NSLog(@"Update of %@ failed.\n", r1);
                            [r22 release];
                            r22 = @"";
                    }
                    else {
                            r0 = var_490;
                            if (r0 != 0x0) {
                                    r0 = fileno(r0);
                                    r25 = &decomp_var_448;
                                    r1 = &decomp_var_448;
                                    r0 = read(r0, r1, 0x400);
                                    if (r0 >= 0x1) {
                                            r24 = @"";
                                            do {
                                                    *(int8_t *)(r25 + r0) = 0x0;
                                                    r22 = [[r24 stringByAppendingFormat:@"%s", r3] retain];
                                                    [r24 release];
                                                    r0 = fileno(var_490);
                                                    r1 = &decomp_var_448;
                                                    r0 = read(r0, r1, 0x400);
                                                    r24 = r22;
                                            } while (r0 > 0x0);
                                    }
                                    else {
                                            r22 = @"";
                                    }
                            }
                            else {
                                    r22 = @"";
                            }
                            if ([r22 length] != 0x0) {
                                    NSLog(@"Output from update: %@\n", r1);
                            }
                            fclose(var_490);
                    }
                    [r21 release];
                    r0 = r22;
                    [r0 release];
                    [r19 performSelectorOnMainThread:@selector(refreshUpToDate) withObject:0x0 waitUntilDone:0x1];
            }
            else {
                    NSLog(@"We're trying to update a mananged bottle but we aren't authorized.\n");
            }
    }
    else {
            r0 = **_NSApp;
            r0 = [r0 crossOverRoot];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 stringByAppendingPathComponent:@"bin"];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 stringByAppendingPathComponent:@"wine"] retain];
            [r22 release];
            [r21 release];
            r22 = [[r19 name] retain];
            r21 = [[NSArray arrayWithObjects:@"--bottle"] retain];
            [r22 release];
            r0 = [CXTask launchedTaskWithLaunchPath:r23 arguments:r21];
            r0 = [r0 retain];
            r22 = r0;
            [r0 waitUntilExit];
            [r22 release];
            [r21 release];
            r0 = r23;
            [r0 release];
            [r19 performSelectorOnMainThread:@selector(refreshUpToDate) withObject:0x0 waitUntilDone:0x1];
    }
    [r20 release];
    [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x10001757c
// -[UpdateController updateLaterPressed:]
    [self finish];
    return;


// 0x100017580
// -[UpdateController messageTextField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_messageTextField);
    r0 = [r0 autorelease];
    return r0;


// 0x1000175a0
// -[UpdateController setMessageTextField:]
    objc_storeWeak((int64_t *)&self->_messageTextField, arg2);
    return;


// 0x1000175b4
// -[UpdateController bottleTableScrollView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleTableScrollView);
    r0 = [r0 autorelease];
    return r0;


// 0x1000175d4
// -[UpdateController setBottleTableScrollView:]
    objc_storeWeak((int64_t *)&self->_bottleTableScrollView, arg2);
    return;


// 0x1000175e8
// -[UpdateController messageToTableSpacing]
    r0 = objc_loadWeakRetained((int64_t *)&self->_messageToTableSpacing);
    r0 = [r0 autorelease];
    return r0;


// 0x100017608
// -[UpdateController setMessageToTableSpacing:]
    objc_storeWeak((int64_t *)&self->_messageToTableSpacing, arg2);
    return;


// 0x10001761c
// -[UpdateController tableToUpgradingSpacing]
    r0 = objc_loadWeakRetained((int64_t *)&self->_tableToUpgradingSpacing);
    r0 = [r0 autorelease];
    return r0;


// 0x10001763c
// -[UpdateController setTableToUpgradingSpacing:]
    objc_storeWeak((int64_t *)&self->_tableToUpgradingSpacing, arg2);
    return;


// 0x100017650
// -[UpdateController managedBottlesToUpgrade]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_managedBottlesToUpgrade)), 0x1);
    return r0;


// 0x100017660
// -[UpdateController setManagedBottlesToUpgrade:]
    objc_setProperty_atomic();
    return;


// 0x10001766c
// -[UpdateController upgradeInProgress]
    r0 = *(int8_t *)(int64_t *)&self->_upgradeInProgress & 0x1;
    return r0;


// 0x100017680
// -[UpdateController setUpgradeInProgress:]
    *(int8_t *)(int64_t *)&self->_upgradeInProgress = arg2;
    return;


// 0x100017690
// -[UpdateController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_managedBottlesToUpgrade, 0x0);
    objc_destroyWeak((int64_t *)&self->_tableToUpgradingSpacing);
    objc_destroyWeak((int64_t *)&self->_messageToTableSpacing);
    objc_destroyWeak((int64_t *)&self->_bottleTableScrollView);
    objc_destroyWeak((int64_t *)&self->_messageTextField);
    return;


