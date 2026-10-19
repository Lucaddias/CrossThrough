// CXServerCrossOver — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10004719c
// -[CXServerCrossOver init]
    r31 = r31 - 0x100;
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
    var_68 = self;
    r0 = [[&var_68 super] init];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = objc_opt_class(r19);
            r0 = [r0 getDefaultProgramsFolder];
            r0 = [r0 retain];
            var_70 = r0;
            r23 = [[NSDate distantPast] retain];
            r24 = [[NSDictionary dictionary] retain];
            r25 = [[NSDictionary dictionary] retain];
            r26 = [@(0x0) retain];
            r27 = [@(YES) retain];
            r28 = [@(YES) retain];
            r20 = [@(NO) retain];
            r21 = [[NSDictionary dictionaryWithObjectsAndKeys:r23] retain];
            [r20 release];
            [r28 release];
            [r27 release];
            [r26 release];
            [r25 release];
            [r24 release];
            [r23 release];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r20 = r0;
            [r0 registerDefaults:r21];
            [r20 release];
            r0 = [[NSUserDefaults alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(dockPrefs));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            r0 = [NSDate distantPast];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(programsMenuUpdateDate));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            r0 = [[NSObject alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(associationsLock));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 dictionaryForKey:@"DocTypeToMenuPathMap"];
            r0 = [r0 retain];
            r22 = sign_extend_64(*(int32_t *)ivar_offset(relateDocTypesToMenus));
            r8 = *(r19 + r22);
            *(r19 + r22) = r0;
            [r8 release];
            [r20 release];
            r0 = CFPropertyListCreateDeepCopy(0x0, *(r19 + r22), 0x1);
            r8 = *(r19 + r22);
            *(r19 + r22) = r0;
            [r8 release];
            r22 = [[NSURLSessionConfiguration defaultSessionConfiguration] retain];
            r23 = [[NSOperationQueue mainQueue] retain];
            r0 = [NSURLSession sessionWithConfiguration:r22 delegate:0x0 delegateQueue:r23];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(session));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            [r23 release];
            [r22 release];
            r0 = [CXUpdater sharedUpdater];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setDelegate:r19];
            [r20 release];
            [r21 release];
            [var_70 release];
    }
    r0 = r19;
    return r0;


// 0x100047530
// -[CXServerCrossOver preferencesController]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(preferencesController));
    r0 = *(self + r20);
    if (r0 == 0x0) {
            r0 = [[PreferencesController alloc] init];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
            r0 = *(r19 + r20);
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10004757c
// -[CXServerCrossOver mainWindowController]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(mainWindowController));
    r0 = *(self + r20);
    if (r0 == 0x0) {
            r0 = [[MainWindowController alloc] init];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
            r0 = *(r19 + r20);
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000475c8
// -[CXServerCrossOver applicationWillFinishLaunching:]
    r19 = [arg2 retain];
    r0 = [[AskUpdateBottlesOp alloc] init];
    r23 = sign_extend_64(*(int32_t *)ivar_offset(updateCheckOp));
    r8 = *(self + r23);
    *(self + r23) = r0;
    [r8 release];
    r21 = *(self + r23);
    r22 = [[self startAppOp] retain];
    [r21 addDependency:r22];
    [r22 release];
    r0 = [NSOperationQueue mainQueue];
    r0 = [r0 retain];
    r21 = r0;
    [r0 addOperation:*(self + r23)];
    [r21 release];
    var_40 = self;
    [[&var_40 super] applicationWillFinishLaunching:r19];
    [r19 release];
    return;


// 0x1000476ac
// -[CXServerCrossOver applicationDidFinishLaunching:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_30 = self;
    [[&var_30 super] applicationDidFinishLaunching:arg2];
    if ([@"1" isEqualToString:@"0"] != 0x0) {
            r0 = [r19 publishBottleMenuItem];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 menu] retain];
            r22 = [[r19 publishBottleMenuItem] retain];
            [r21 removeItem:r22];
            [r22 release];
            [r21 release];
            [r20 release];
            [r19 setPublishBottleMenuItem:0x0];
            r0 = [r19 updateBottleMenuItem];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 menu] retain];
            r22 = [[r19 updateBottleMenuItem] retain];
            [r21 removeItem:r22];
            [r22 release];
            [r21 release];
            [r20 release];
            [r19 setUpdateBottleMenuItem:0x0];
    }
    return;


// 0x1000477dc
// -[CXServerCrossOver startedAppGateOp]
    r0 = self->updateCheckOp;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000477ec
// -[CXServerCrossOver openAutoPlayInstallerForC4P:inBottle:]
    r21 = [arg3 retain];
    r19 = [arg2 retain];
    r0 = [self mainWindowController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 showWindow:self];
    [r22 release];
    r0 = [self mainWindowController];
    r0 = [r0 retain];
    r20 = r0;
    [r0 autoPlayWithAutorunFile:r19 inBottle:r21];
    [r21 release];
    [r19 release];
    [r20 release];
    return;


// 0x100047884
// -[CXServerCrossOver openAutoPlayInstallerForVolume:inBottle:]
    r21 = [arg3 retain];
    r19 = [arg2 retain];
    r0 = [self mainWindowController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 showWindow:self];
    [r22 release];
    r0 = [self mainWindowController];
    r0 = [r0 retain];
    r20 = r0;
    [r0 autoPlay:r19 inBottle:r21];
    [r21 release];
    [r19 release];
    [r20 release];
    return;


// 0x10004791c
// -[CXServerCrossOver launchFeedbackDrawInfoForImageSize:]
    {r2:r3} = arg2;
    r31 = r31 - 0x80;
    var_40 = d9;
    decomp_var_38 = d8;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    d8 = d1;
    d9 = d0;
    r0 = self->dockPrefs;
    r0 = [r0 persistentDomainForName:@"com.apple.dock"];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [r19 objectForKey:@"launchanim"];
            r0 = [r0 retain];
            r22 = r0;
            if (r0 != 0x0) {
                    r21 = [r22 boolValue];
            }
            else {
                    r21 = 0x1;
            }
            r0 = [r19 objectForKey:@"orientation"];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0) {
                    r20 = [r23 retain];
            }
            else {
                    r20 = @"bottom";
            }
            [r23 release];
            [r22 release];
    }
    else {
            r21 = 0x1;
            r20 = @"bottom";
    }
    r23 = [[NSValue valueWithSize:@"com.apple.dock"] retain];
    r21 = [[NSNumber numberWithBool:r21] retain];
    r22 = [[NSMutableDictionary dictionaryWithObjectsAndKeys:r23] retain];
    [r21 release];
    [r23 release];
    [r19 release];
    [r20 release];
    r0 = [r22 autorelease];
    return r0;


// 0x100047ab4
// -[CXServerCrossOver drawLaunchFeedback:position:info:]
    r4 = arg4;
    r3 = arg3;
    var_60 = d13;
    decomp_var_58 = d12;
    r31 = r31 + 0xffffffffffffff90;
    var_50 = d11;
    decomp_var_48 = d10;
    var_40 = d9;
    decomp_var_38 = d8;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = r4;
    r23 = r3;
    r19 = [arg2 retain];
    r22 = [r20 retain];
    r0 = [r19 badgeIcon];
    r0 = [r0 retain];
    r20 = r0;
    [r0 size];
    d8 = d0;
    d9 = d1;
    r0 = [r22 objectForKey:@"imageSize"];
    r0 = [r0 retain];
    r21 = r0;
    [r0 sizeValue];
    d11 = d0;
    d12 = d1;
    [r21 release];
    r0 = [r22 objectForKey:@"orientation"];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 isEqualToString:@"bottom"];
    d0 = r23;
    d2 = d9 + 0x4014000000000000;
    asm { fmsub      d2, d0, d2, d12 };
    d3 = 0x0;
    asm { fmadd      d0, d0, d1, d3 };
    bool_5 = r0 == 0x0;
    if (r0 != 0x0) {
            d13 = d12;
    }
    else {
            d13 = d2;
    }
    if (!bool_5) {
            d10 = d0;
    }
    else {
            d10 = d3;
    }
    r23 = [[r22 objectForKey:@"bounce"] retain];
    [r22 release];
    [r23 release];
    if (r23 != 0x0) {
            if ([r21 isEqualToString:@"right"] != 0x0) {
                    d12 = d13 - d9;
                    s0 = [r19 lifeCounter] / 0x4008000000000000;
                    asm { fcvt       d0, s0 };
                    sin(s0);
                    d10 = 0x4018000000000000 - Abs(d0 * 0x4018000000000000);
            }
            else {
                    if ([r21 isEqualToString:@"left"] != 0x0) {
                            d12 = d13 - d9;
                            s0 = [r19 lifeCounter] / 0x4008000000000000;
                            asm { fcvt       d0, s0 };
                            sin(s0);
                            d10 = (d10 - 0x4018000000000000) + Abs(d0 * 0x4018000000000000);
                    }
                    else {
                            s0 = [r19 lifeCounter] / 0x4008000000000000;
                            asm { fcvt       d0, s0 };
                            sin(s0);
                            d12 = (d11 - 0x4018000000000000) + Abs(d0 * 0x4018000000000000);
                    }
            }
    }
    else {
            if ([r21 isEqualToString:@"bottom"] != 0x0) {
                    d12 = d12 - d9;
            }
            else {
                    r0 = [r21 isEqualToString:@"left"];
                    d12 = d13 - d9;
                    d0 = d11 - d8;
                    d1 = 0x0;
                    if (r0 == 0x0) {
                            d10 = d1;
                    }
                    else {
                            d10 = d0;
                    }
            }
    }
    [r20 drawAtPoint:0x2 fromRect:r3 operation:r4 fraction:r5];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x100047d30
// -[CXServerCrossOver startLaunchNotify:]
    r20 = self->dockPrefs;
    r21 = [arg2 retain];
    [r20 synchronize];
    var_30 = self;
    r0 = [[&var_30 super] startLaunchNotify:r21];
    r19 = [r0 retain];
    [r21 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100047db4
// -[CXServerCrossOver forkExecCommand:withArgs:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    if ([**_NSApp isDemo] != 0x0) {
            r22 = sign_extend_64(*(int32_t *)ivar_offset(lastDemoNagTime));
            [*(r21 + r22) timeIntervalSinceNow];
            if (0x0 - d0 <= *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xd00)) {
                    var_30 = r21;
                    [[&var_30 super] forkExecCommand:r19 withArgs:r20];
            }
            else {
                    r0 = [NSDate date];
                    r0 = [r0 retain];
                    r8 = *(r21 + r22);
                    *(r21 + r22) = r0;
                    [r8 release];
                    [r21 doPeriodicDemoNagForCommand:r19 withArgs:r20];
            }
    }
    else {
            var_30 = r21;
            [[&var_30 super] forkExecCommand:r19 withArgs:r20];
    }
    [r20 release];
    [r19 release];
    return;


// 0x100047ea8
// -[CXServerCrossOver runClient:inBottle:]
    [self runClient:arg2 inBottle:arg3 withDialog:0x0];
    return;


// 0x100047eb0
// -[CXServerCrossOver runClient:inBottle:withDialog:]
    r4 = arg4;
    r3 = arg3;
    r1 = _cmd;
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
    r31 = r31 + 0xffffffffffffffa0 - 0x200;
    var_200 = r4;
    r20 = r3;
    var_1F8 = self;
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r20 = [r20 retain];
    r22 = [[NSURL fileURLWithPath:r19] retain];
    r24 = [[CXBundle bundleWithURL:r22] retain];
    [r22 release];
    r23 = [[r19 pathExtension] retain];
    r28 = [[r19 lastPathComponent] retain];
    if (r20 != 0x0) {
            r26 = [[r20 stringQuotedForBash] retain];
            r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
            [r26 release];
            r0 = [CXSetupLib bottleCollectionClass];
            r0 = [r0 sharedCollection];
            r0 = [r0 retain];
            r27 = r0;
            r26 = [[r0 bottleWithName:r20] retain];
            [r27 release];
    }
    else {
            var_210 = r23;
            var_208 = r28;
            r23 = r24;
            r0 = [CXSetupLib bottleCollectionClass];
            r0 = [r0 sharedCollection];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 bottleList] retain];
            [r25 release];
            var_1A0 = q0;
            var_190 = q0;
            r0 = [r26 retain];
            r26 = r0;
            r3 = &decomp_var_e0;
            r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:r3 count:0x10];
            if (r0 != 0x0) {
                    r25 = r0;
                    r22 = *var_190;
                    while (true) {
                            r24 = 0x0;
                            while (true) {
                                    if (*var_190 != r22) {
                                            objc_enumerationMutation(r26);
                                    }
                                    r28 = *(var_198 + r24 * 0x8);
                                    if ([r28 isCanRunCommands] == 0x0) {
                                            r24 = r24 + 0x1;
                                            if (r25 != r24) {
                                                    continue;
                                            }
                                            temp_0 = 0x0;
                                            break;
                                    }
                                    r0 = [r28 fileIsInBottle:r19];
                                    r0 = [r0 retain];
                                    r27 = r0;
                                    r21 = [r0 boolValue];
                                    [r27 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            r0 = [r28 name];
                                            r0 = [r0 retain];
                                            r27 = r0;
                                            r28 = [[r0 stringQuotedForBash] retain];
                                            r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                            [r28 release];
                                            [r27 release];
                                            [r26 release];
                                            r24 = r23;
                                            r23 = var_210;
                                            if (r25 == 0x0) {
                                                    temp_0 = 0x1;
                                            }
                                            else {
                                                    temp_0 = 0x2;
                                            }
                                            break;
                                    }
                                    r24 = r24 + 0x1;
                                    if (r25 != r24) {
                                            continue;
                                    }
                                    temp_0 = 0x0;
                                    break;
                            }
                            if (temp_0 == 0x0) {
                                    r3 = &decomp_var_e0;
                                    r0 = [r26 countByEnumeratingWithState:&var_1A0 objects:r3 count:0x10];
                                    r25 = r0;
                                    if (r0 != 0x0) {
                                            continue;
                                    }
                                    temp_2 = 0x0;
                                    break;
                            }
                            if (temp_0 != 0x1) {
                                    temp_2 = 0x2;
                            }
                            else {
                                    temp_2 = 0x1;
                            }
                            break;
                    }
                    if (temp_2 != 0x0) {
                            if (temp_2 == 0x1) {
                                    r0 = [NSUserDefaults standardUserDefaults];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r25 = [r0 boolForKey:@"InstallExeFiles"];
                                    [r21 release];
                                    if ((r25 & 0x1) == 0x0) {
                                            var_1E0 = q0;
                                            var_1D0 = q0;
                                            r0 = [r26 retain];
                                            r28 = r0;
                                            r3 = &decomp_var_160;
                                            r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:r3 count:0x10];
                                            if (r0 != 0x0) {
                                                    r25 = r0;
                                                    r21 = *var_1D0;
                                                    while (true) {
                                                            r22 = 0x0;
                                                            while (true) {
                                                                    if (*var_1D0 != r21) {
                                                                            objc_enumerationMutation(r28);
                                                                    }
                                                                    r27 = *(var_1D8 + r22 * 0x8);
                                                                    if ([r27 isIsDefault] == 0x0) {
                                                                            r22 = r22 + 0x1;
                                                                            if (r25 != r22) {
                                                                                    continue;
                                                                            }
                                                                            temp_1 = 0x1;
                                                                            break;
                                                                    }
                                                                    if (([r27 isCanRunCommands] & 0x1) != 0x0) {
                                                                            r21 = @class(NSString);
                                                                            r0 = [r27 name];
                                                                            r0 = [r0 retain];
                                                                            r27 = r0;
                                                                            r22 = [[r0 stringQuotedForBash] retain];
                                                                            r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                                            [r22 release];
                                                                            [r27 release];
                                                                            [r28 release];
                                                                            if (r25 == 0x0) {
                                                                                    temp_1 = 0x2;
                                                                            }
                                                                            else {
                                                                                    temp_1 = 0x0;
                                                                            }
                                                                            break;
                                                                    }
                                                                    r22 = r22 + 0x1;
                                                                    if (r25 != r22) {
                                                                            continue;
                                                                    }
                                                                    temp_1 = 0x1;
                                                                    break;
                                                            }
                                                            if (temp_1 == 0x0) {
                                                                    temp_3 = 0x0;
                                                                    break;
                                                            }
                                                            if (temp_1 == 0x1) {
                                                                    r3 = &decomp_var_160;
                                                                    r0 = [r28 countByEnumeratingWithState:&var_1E0 objects:r3 count:0x10];
                                                                    r25 = r0;
                                                                    if (r0 != 0x0) {
                                                                            continue;
                                                                    }
                                                                    temp_3 = 0x1;
                                                                    break;
                                                            }
                                                            temp_3 = 0x2;
                                                            break;
                                                    }
                                                    if (temp_3 != 0x0) {
                                                            if (temp_3 == 0x1) {
                                                                    [r28 release];
                                                            }
                                                            if ([r28 count] == 0x1) {
                                                                    r25 = 0x0;
                                                                    if ([0x0 isCanRunCommands] != 0x0) {
                                                                            r0 = [r28 objectAtIndex:0x0];
                                                                            r0 = [r0 retain];
                                                                            r22 = r0;
                                                                            r0 = [r0 name];
                                                                            r0 = [r0 retain];
                                                                            r27 = r0;
                                                                            r28 = [[r0 stringQuotedForBash] retain];
                                                                            r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                                            [r28 release];
                                                                            [r27 release];
                                                                            [r22 release];
                                                                    }
                                                            }
                                                            else {
                                                                    r25 = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [r28 release];
                                                    if ([r28 count] == 0x1) {
                                                            r25 = 0x0;
                                                            if ([0x0 isCanRunCommands] != 0x0) {
                                                                    r0 = [r28 objectAtIndex:0x0];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    r0 = [r0 name];
                                                                    r0 = [r0 retain];
                                                                    r27 = r0;
                                                                    r28 = [[r0 stringQuotedForBash] retain];
                                                                    r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                                    [r28 release];
                                                                    [r27 release];
                                                                    [r22 release];
                                                            }
                                                    }
                                                    else {
                                                            r25 = 0x0;
                                                    }
                                            }
                                    }
                                    else {
                                            r25 = 0x0;
                                    }
                            }
                    }
                    else {
                            [r26 release];
                            r24 = r23;
                            r23 = var_210;
                            r0 = [NSUserDefaults standardUserDefaults];
                            r0 = [r0 retain];
                            r21 = r0;
                            r25 = [r0 boolForKey:@"InstallExeFiles"];
                            [r21 release];
                            if ((r25 & 0x1) == 0x0) {
                                    var_1E0 = q0;
                                    var_1D0 = q0;
                                    r0 = [r26 retain];
                                    r28 = r0;
                                    r3 = &decomp_var_160;
                                    r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:r3 count:0x10];
                                    if (r0 != 0x0) {
                                            r25 = r0;
                                            r21 = *var_1D0;
                                            while (true) {
                                                    r22 = 0x0;
                                                    while (true) {
                                                            if (*var_1D0 != r21) {
                                                                    objc_enumerationMutation(r28);
                                                            }
                                                            r27 = *(var_1D8 + r22 * 0x8);
                                                            if ([r27 isIsDefault] == 0x0) {
                                                                    r22 = r22 + 0x1;
                                                                    if (r25 != r22) {
                                                                            continue;
                                                                    }
                                                                    temp_1 = 0x1;
                                                                    break;
                                                            }
                                                            if (([r27 isCanRunCommands] & 0x1) != 0x0) {
                                                                    r21 = @class(NSString);
                                                                    r0 = [r27 name];
                                                                    r0 = [r0 retain];
                                                                    r27 = r0;
                                                                    r22 = [[r0 stringQuotedForBash] retain];
                                                                    r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                                    [r22 release];
                                                                    [r27 release];
                                                                    [r28 release];
                                                                    if (r25 == 0x0) {
                                                                            temp_1 = 0x2;
                                                                    }
                                                                    else {
                                                                            temp_1 = 0x0;
                                                                    }
                                                                    break;
                                                            }
                                                            r22 = r22 + 0x1;
                                                            if (r25 != r22) {
                                                                    continue;
                                                            }
                                                            temp_1 = 0x1;
                                                            break;
                                                    }
                                                    if (temp_1 == 0x0) {
                                                            temp_3 = 0x0;
                                                            break;
                                                    }
                                                    if (temp_1 == 0x1) {
                                                            r3 = &decomp_var_160;
                                                            r0 = [r28 countByEnumeratingWithState:&var_1E0 objects:r3 count:0x10];
                                                            r25 = r0;
                                                            if (r0 != 0x0) {
                                                                    continue;
                                                            }
                                                            temp_3 = 0x1;
                                                            break;
                                                    }
                                                    temp_3 = 0x2;
                                                    break;
                                            }
                                            if (temp_3 != 0x0) {
                                                    if (temp_3 == 0x1) {
                                                            [r28 release];
                                                    }
                                                    if ([r28 count] == 0x1) {
                                                            r25 = 0x0;
                                                            if ([0x0 isCanRunCommands] != 0x0) {
                                                                    r0 = [r28 objectAtIndex:0x0];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    r0 = [r0 name];
                                                                    r0 = [r0 retain];
                                                                    r27 = r0;
                                                                    r28 = [[r0 stringQuotedForBash] retain];
                                                                    r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                                    [r28 release];
                                                                    [r27 release];
                                                                    [r22 release];
                                                            }
                                                    }
                                                    else {
                                                            r25 = 0x0;
                                                    }
                                            }
                                    }
                                    else {
                                            [r28 release];
                                            if ([r28 count] == 0x1) {
                                                    r25 = 0x0;
                                                    if ([0x0 isCanRunCommands] != 0x0) {
                                                            r0 = [r28 objectAtIndex:0x0];
                                                            r0 = [r0 retain];
                                                            r22 = r0;
                                                            r0 = [r0 name];
                                                            r0 = [r0 retain];
                                                            r27 = r0;
                                                            r28 = [[r0 stringQuotedForBash] retain];
                                                            r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                            [r28 release];
                                                            [r27 release];
                                                            [r22 release];
                                                    }
                                            }
                                            else {
                                                    r25 = 0x0;
                                            }
                                    }
                            }
                            else {
                                    r25 = 0x0;
                            }
                    }
            }
            else {
                    [r26 release];
                    r24 = r23;
                    r23 = var_210;
                    r0 = [NSUserDefaults standardUserDefaults];
                    r0 = [r0 retain];
                    r21 = r0;
                    r25 = [r0 boolForKey:@"InstallExeFiles"];
                    [r21 release];
                    if ((r25 & 0x1) == 0x0) {
                            var_1E0 = q0;
                            var_1D0 = q0;
                            r0 = [r26 retain];
                            r28 = r0;
                            r3 = &decomp_var_160;
                            r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:r3 count:0x10];
                            if (r0 != 0x0) {
                                    r25 = r0;
                                    r21 = *var_1D0;
                                    while (true) {
                                            r22 = 0x0;
                                            while (true) {
                                                    if (*var_1D0 != r21) {
                                                            objc_enumerationMutation(r28);
                                                    }
                                                    r27 = *(var_1D8 + r22 * 0x8);
                                                    if ([r27 isIsDefault] == 0x0) {
                                                            r22 = r22 + 0x1;
                                                            if (r25 != r22) {
                                                                    continue;
                                                            }
                                                            temp_1 = 0x1;
                                                            break;
                                                    }
                                                    if (([r27 isCanRunCommands] & 0x1) != 0x0) {
                                                            r21 = @class(NSString);
                                                            r0 = [r27 name];
                                                            r0 = [r0 retain];
                                                            r27 = r0;
                                                            r22 = [[r0 stringQuotedForBash] retain];
                                                            r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                            [r22 release];
                                                            [r27 release];
                                                            [r28 release];
                                                            if (r25 == 0x0) {
                                                                    temp_1 = 0x2;
                                                            }
                                                            else {
                                                                    temp_1 = 0x0;
                                                            }
                                                            break;
                                                    }
                                                    r22 = r22 + 0x1;
                                                    if (r25 != r22) {
                                                            continue;
                                                    }
                                                    temp_1 = 0x1;
                                                    break;
                                            }
                                            if (temp_1 == 0x0) {
                                                    temp_3 = 0x0;
                                                    break;
                                            }
                                            if (temp_1 == 0x1) {
                                                    r3 = &decomp_var_160;
                                                    r0 = [r28 countByEnumeratingWithState:&var_1E0 objects:r3 count:0x10];
                                                    r25 = r0;
                                                    if (r0 != 0x0) {
                                                            continue;
                                                    }
                                                    temp_3 = 0x1;
                                                    break;
                                            }
                                            temp_3 = 0x2;
                                            break;
                                    }
                                    if (temp_3 != 0x0) {
                                            if (temp_3 == 0x1) {
                                                    [r28 release];
                                            }
                                            if ([r28 count] == 0x1) {
                                                    r25 = 0x0;
                                                    if ([0x0 isCanRunCommands] != 0x0) {
                                                            r0 = [r28 objectAtIndex:0x0];
                                                            r0 = [r0 retain];
                                                            r22 = r0;
                                                            r0 = [r0 name];
                                                            r0 = [r0 retain];
                                                            r27 = r0;
                                                            r28 = [[r0 stringQuotedForBash] retain];
                                                            r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                            [r28 release];
                                                            [r27 release];
                                                            [r22 release];
                                                    }
                                            }
                                            else {
                                                    r25 = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [r28 release];
                                    if ([r28 count] == 0x1) {
                                            r25 = 0x0;
                                            if ([0x0 isCanRunCommands] != 0x0) {
                                                    r0 = [r28 objectAtIndex:0x0];
                                                    r0 = [r0 retain];
                                                    r22 = r0;
                                                    r0 = [r0 name];
                                                    r0 = [r0 retain];
                                                    r27 = r0;
                                                    r28 = [[r0 stringQuotedForBash] retain];
                                                    r25 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                                                    [r28 release];
                                                    [r27 release];
                                                    [r22 release];
                                            }
                                    }
                                    else {
                                            r25 = 0x0;
                                    }
                            }
                    }
                    else {
                            r25 = 0x0;
                    }
            }
            r4 = 0x10;
            [r26 release];
            r26 = 0x0;
            r28 = var_208;
    }
    r0 = [CXSetupLib c4ProfilesClass];
    r0 = [r0 getMatchingProfiles:r19];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 count];
    [r21 release];
    if (r22 == 0x1) {
            r22 = var_1F8;
            [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
            [r22 addToRecentItems:r19 bottle:r20];
            [r25 release];
            [r26 release];
            [r28 release];
            [r23 release];
            [r24 release];
            [r20 release];
            [r19 release];
            if (**___stack_chk_guard != var_60) {
                    __stack_chk_fail();
            }
    }
    else {
            r22 = var_1F8;
            if ([r28 caseInsensitiveCompare:@"setup.exe"] != 0x0) {
                    if ([r28 caseInsensitiveCompare:@"setuppls.exe"] != 0x0) {
                            if ([r28 caseInsensitiveCompare:@"setupse.exe"] != 0x0) {
                                    if ([r28 caseInsensitiveCompare:@"autorun.inf"] != 0x0) {
                                            if ([r23 caseInsensitiveCompare:@"msi"] != 0x0) {
                                                    if ([r23 caseInsensitiveCompare:@"lnk"] != 0x0) {
                                                            if ([r23 caseInsensitiveCompare:@"exe"] != 0x0) {
                                                                    if ([r23 caseInsensitiveCompare:@"cxarchive"] != 0x0) {
                                                                            if ([r23 caseInsensitiveCompare:@"c4p"] != 0x0) {
                                                                                    if ([r23 caseInsensitiveCompare:@"tie"] != 0x0) {
                                                                                            if ([r23 caseInsensitiveCompare:@"tie-CrossOver"] != 0x0) {
                                                                                                    if (r24 != 0x0) {
                                                                                                            r0 = [r24 objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"];
                                                                                                            r0 = [r0 retain];
                                                                                                            if (r0 != 0x0) {
                                                                                                                    r27 = r0;
                                                                                                                    if (r20 != 0x0) {
                                                                                                                            var_210 = r23;
                                                                                                                            var_208 = r28;
                                                                                                                            r23 = r24;
                                                                                                                            r0 = [CXSetupLib bottleCollectionClass];
                                                                                                                            r0 = [r0 sharedCollection];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r21 = r0;
                                                                                                                            r28 = [[r0 bottleWithName:r20] retain];
                                                                                                                            [r21 release];
                                                                                                                            r0 = [r22 mainWindowController];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r21 = r0;
                                                                                                                            r24 = r22;
                                                                                                                            r22 = [r0 isWindowLoaded];
                                                                                                                            [r21 release];
                                                                                                                            if (r22 != 0x0) {
                                                                                                                                    r0 = [r24 mainWindowController];
                                                                                                                                    r0 = [r0 retain];
                                                                                                                                    r21 = r0;
                                                                                                                                    r24 = [[r0 window] retain];
                                                                                                                                    [r21 release];
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    r24 = 0x0;
                                                                                                                            }
                                                                                                                            [BottleMenuHandler rateBottle:r28 withWindow:r24 isDeleting:0x0];
                                                                                                                            [r24 release];
                                                                                                                            [r28 release];
                                                                                                                            r24 = r23;
                                                                                                                            r23 = var_210;
                                                                                                                            r28 = var_208;
                                                                                                                    }
                                                                                                                    [r27 release];
                                                                                                            }
                                                                                                            else {
                                                                                                                    r0 = [r24 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r27 = r0;
                                                                                                                    if (r0 != 0x0) {
                                                                                                                            r0 = [NSWorkspace sharedWorkspace];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r21 = r0;
                                                                                                                            r0 = [r0 iconForFile:r19];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r22 = r0;
                                                                                                                            var_200 = r0;
                                                                                                                            [r21 release];
                                                                                                                            r0 = [NSArray arrayWithObjects:r22];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            var_208 = r28;
                                                                                                                            r28 = r0;
                                                                                                                            r22 = [[NSArray arrayWithObjects:@"icon"] retain];
                                                                                                                            r21 = [[NSDictionary dictionaryWithObjects:r28 forKeys:r22] retain];
                                                                                                                            [var_1F8 forkExecCommand:r27 withArgs:r21];
                                                                                                                            [r21 release];
                                                                                                                            r0 = r22;
                                                                                                                            r22 = var_1F8;
                                                                                                                            [r0 release];
                                                                                                                            r0 = r28;
                                                                                                                            r28 = var_208;
                                                                                                                            [r0 release];
                                                                                                                            [var_200 release];
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            NSLog(@"CrossOver got non-CrossOver bundle as document: %@\n", r1);
                                                                                                                    }
                                                                                                                    r0 = r27;
                                                                                                                    [r0 release];
                                                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            if ([CDTools isValidInstallerVolume:r19] != 0x0) {
                                                                                                                    [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                                                                                                            }
                                                                                                            else {
                                                                                                                    var_1F0 = r22;
                                                                                                                    [[&var_1F0 super] runClient:r19 inBottle:r20];
                                                                                                            }
                                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    [r22 openAutoPlayInstallerForC4P:r19 inBottle:r26];
                                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            [r22 openAutoPlayInstallerForC4P:r19 inBottle:r26];
                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    [r22 openAutoPlayInstallerForC4P:r19 inBottle:r26];
                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                            }
                                                                    }
                                                                    else {
                                                                            r0 = [r22 mainWindowController];
                                                                            r0 = [r0 retain];
                                                                            r21 = r0;
                                                                            [r0 showWindow:r22];
                                                                            [r21 release];
                                                                            r21 = [[r22 mainWindowController] retain];
                                                                            r22 = [[NSURL fileURLWithPath:r19] retain];
                                                                            [r21 importBottleArchiveFromURL:r22];
                                                                            r0 = r22;
                                                                            r22 = var_1F8;
                                                                            [r0 release];
                                                                            r0 = r21;
                                                                            [r0 release];
                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                    }
                                                                    [r25 release];
                                                                    [r26 release];
                                                                    [r28 release];
                                                                    [r23 release];
                                                                    [r24 release];
                                                                    [r20 release];
                                                                    [r19 release];
                                                                    if (**___stack_chk_guard != var_60) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (r25 != 0x0) {
                                                                            if (var_200 == 0x0) {
                                                                                    r0 = [r23 caseInsensitiveCompare:@"lnk"];
                                                                                    var_210 = r23;
                                                                                    r23 = r24;
                                                                                    if (r0 != 0x0) {
                                                                                            r24 = @"--";
                                                                                    }
                                                                                    else {
                                                                                            r24 = @"--start";
                                                                                    }
                                                                                    r0 = **_NSApp;
                                                                                    r0 = [r0 crossOverRoot];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r0 = [r0 stringByAppendingPathComponent:@"bin"];
                                                                                    r0 = [r0 retain];
                                                                                    r22 = r0;
                                                                                    r0 = [r0 stringByAppendingPathComponent:@"wine"];
                                                                                    r0 = [r0 retain];
                                                                                    r27 = r0;
                                                                                    var_218 = r0;
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    r22 = [[r27 stringQuotedForBash] retain];
                                                                                    r27 = [[r19 stringQuotedForBash] retain];
                                                                                    var_200 = [[NSString stringWithFormat:@"%@ %@ %@ %@", r3, r4, r5, r6] retain];
                                                                                    [r27 release];
                                                                                    [r22 release];
                                                                                    r0 = [NSWorkspace sharedWorkspace];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r0 = [r0 iconForFile:r19];
                                                                                    r0 = [r0 retain];
                                                                                    r27 = r0;
                                                                                    var_220 = r0;
                                                                                    [r21 release];
                                                                                    var_228 = [[r19 stringByDeletingLastPathComponent] retain];
                                                                                    r0 = [NSArray arrayWithObjects:r27];
                                                                                    r0 = [r0 retain];
                                                                                    var_208 = r28;
                                                                                    r28 = r0;
                                                                                    r24 = r23;
                                                                                    r23 = var_210;
                                                                                    r27 = [[NSArray arrayWithObjects:@"icon"] retain];
                                                                                    r21 = [[NSDictionary dictionaryWithObjects:r28 forKeys:r27] retain];
                                                                                    r22 = var_1F8;
                                                                                    [r22 forkExecCommand:var_200 withArgs:r21];
                                                                                    [r21 release];
                                                                                    [r27 release];
                                                                                    r0 = r28;
                                                                                    r28 = var_208;
                                                                                    [r0 release];
                                                                                    [var_228 release];
                                                                                    [var_220 release];
                                                                                    [var_200 release];
                                                                                    r0 = var_218;
                                                                                    [r0 release];
                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                    [r25 release];
                                                                                    [r26 release];
                                                                                    [r28 release];
                                                                                    [r23 release];
                                                                                    [r24 release];
                                                                                    [r20 release];
                                                                                    [r19 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    if ([r23 caseInsensitiveCompare:@"exe"] != 0x0) {
                                                                                            r0 = [CXSetupLib bottleCollectionClass];
                                                                                            r0 = [r0 sharedCollection];
                                                                                            r0 = [r0 retain];
                                                                                            r21 = r0;
                                                                                            r0 = [r0 bottleList];
                                                                                            r0 = [r0 retain];
                                                                                            r22 = r0;
                                                                                            r27 = [r0 count];
                                                                                            [r22 release];
                                                                                            [r21 release];
                                                                                            if (r27 != 0x0) {
                                                                                                    r0 = [RunCommandController alloc];
                                                                                                    r0 = [r0 initWithFileToRun:r19];
                                                                                                    r27 = r0;
                                                                                                    objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                                    r22 = var_1F8;
                                                                                                    if (r26 != 0x0) {
                                                                                                            [r27 setSelectedBottle:r26];
                                                                                                    }
                                                                                                    [r27 showWindow:r22];
                                                                                                    r0 = r27;
                                                                                            }
                                                                                            else {
                                                                                                    r0 = [NoBottleController alloc];
                                                                                                    r0 = [r0 initWithFileToLaunch:r19];
                                                                                                    r21 = r0;
                                                                                                    r22 = var_1F8;
                                                                                                    [r0 showWindow:r22];
                                                                                                    r0 = r21;
                                                                                            }
                                                                                            [r0 release];
                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                            [r25 release];
                                                                                            [r26 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r24 release];
                                                                                            [r20 release];
                                                                                            [r19 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r0 = [NSUserDefaults standardUserDefaults];
                                                                                            r0 = [r0 retain];
                                                                                            r21 = r0;
                                                                                            r22 = [r0 boolForKey:@"InstallExeFiles"];
                                                                                            [r21 release];
                                                                                            if (r22 != 0x0) {
                                                                                                    if (var_200 != 0x0) {
                                                                                                            r0 = [CXSetupLib bottleCollectionClass];
                                                                                                            r0 = [r0 sharedCollection];
                                                                                                            r0 = [r0 retain];
                                                                                                            r21 = r0;
                                                                                                            r0 = [r0 bottleList];
                                                                                                            r0 = [r0 retain];
                                                                                                            r22 = r0;
                                                                                                            r27 = [r0 count];
                                                                                                            [r22 release];
                                                                                                            [r21 release];
                                                                                                            if (r27 != 0x0) {
                                                                                                                    r0 = [RunCommandController alloc];
                                                                                                                    r0 = [r0 initWithFileToRun:r19];
                                                                                                                    r27 = r0;
                                                                                                                    objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                                                    r22 = var_1F8;
                                                                                                                    if (r26 != 0x0) {
                                                                                                                            [r27 setSelectedBottle:r26];
                                                                                                                    }
                                                                                                                    [r27 showWindow:r22];
                                                                                                                    r0 = r27;
                                                                                                            }
                                                                                                            else {
                                                                                                                    r0 = [NoBottleController alloc];
                                                                                                                    r0 = [r0 initWithFileToLaunch:r19];
                                                                                                                    r21 = r0;
                                                                                                                    r22 = var_1F8;
                                                                                                                    [r0 showWindow:r22];
                                                                                                                    r0 = r21;
                                                                                                            }
                                                                                                            [r0 release];
                                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                                            [r25 release];
                                                                                                            [r26 release];
                                                                                                            [r28 release];
                                                                                                            [r23 release];
                                                                                                            [r24 release];
                                                                                                            [r20 release];
                                                                                                            [r19 release];
                                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                                    __stack_chk_fail();
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r22 = var_1F8;
                                                                                                            [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                                            [r25 release];
                                                                                                            [r26 release];
                                                                                                            [r28 release];
                                                                                                            [r23 release];
                                                                                                            [r24 release];
                                                                                                            [r20 release];
                                                                                                            [r19 release];
                                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                                    __stack_chk_fail();
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    r0 = [CXSetupLib bottleCollectionClass];
                                                                                                    r0 = [r0 sharedCollection];
                                                                                                    r0 = [r0 retain];
                                                                                                    r21 = r0;
                                                                                                    r0 = [r0 bottleList];
                                                                                                    r0 = [r0 retain];
                                                                                                    r22 = r0;
                                                                                                    r27 = [r0 count];
                                                                                                    [r22 release];
                                                                                                    [r21 release];
                                                                                                    if (r27 != 0x0) {
                                                                                                            r0 = [RunCommandController alloc];
                                                                                                            r0 = [r0 initWithFileToRun:r19];
                                                                                                            r27 = r0;
                                                                                                            objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                                            r22 = var_1F8;
                                                                                                            if (r26 != 0x0) {
                                                                                                                    [r27 setSelectedBottle:r26];
                                                                                                            }
                                                                                                            [r27 showWindow:r22];
                                                                                                            r0 = r27;
                                                                                                    }
                                                                                                    else {
                                                                                                            r0 = [NoBottleController alloc];
                                                                                                            r0 = [r0 initWithFileToLaunch:r19];
                                                                                                            r21 = r0;
                                                                                                            r22 = var_1F8;
                                                                                                            [r0 showWindow:r22];
                                                                                                            r0 = r21;
                                                                                                    }
                                                                                                    [r0 release];
                                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                                    [r25 release];
                                                                                                    [r26 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r24 release];
                                                                                                    [r20 release];
                                                                                                    [r19 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            if ([r23 caseInsensitiveCompare:@"exe"] != 0x0) {
                                                                                    r0 = [CXSetupLib bottleCollectionClass];
                                                                                    r0 = [r0 sharedCollection];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r0 = [r0 bottleList];
                                                                                    r0 = [r0 retain];
                                                                                    r22 = r0;
                                                                                    r27 = [r0 count];
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    if (r27 != 0x0) {
                                                                                            r0 = [RunCommandController alloc];
                                                                                            r0 = [r0 initWithFileToRun:r19];
                                                                                            r27 = r0;
                                                                                            objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                            r22 = var_1F8;
                                                                                            if (r26 != 0x0) {
                                                                                                    [r27 setSelectedBottle:r26];
                                                                                            }
                                                                                            [r27 showWindow:r22];
                                                                                            r0 = r27;
                                                                                    }
                                                                                    else {
                                                                                            r0 = [NoBottleController alloc];
                                                                                            r0 = [r0 initWithFileToLaunch:r19];
                                                                                            r21 = r0;
                                                                                            r22 = var_1F8;
                                                                                            [r0 showWindow:r22];
                                                                                            r0 = r21;
                                                                                    }
                                                                                    [r0 release];
                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                    [r25 release];
                                                                                    [r26 release];
                                                                                    [r28 release];
                                                                                    [r23 release];
                                                                                    [r24 release];
                                                                                    [r20 release];
                                                                                    [r19 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r0 = [NSUserDefaults standardUserDefaults];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r22 = [r0 boolForKey:@"InstallExeFiles"];
                                                                                    [r21 release];
                                                                                    if (r22 != 0x0) {
                                                                                            if (var_200 != 0x0) {
                                                                                                    r0 = [CXSetupLib bottleCollectionClass];
                                                                                                    r0 = [r0 sharedCollection];
                                                                                                    r0 = [r0 retain];
                                                                                                    r21 = r0;
                                                                                                    r0 = [r0 bottleList];
                                                                                                    r0 = [r0 retain];
                                                                                                    r22 = r0;
                                                                                                    r27 = [r0 count];
                                                                                                    [r22 release];
                                                                                                    [r21 release];
                                                                                                    if (r27 != 0x0) {
                                                                                                            r0 = [RunCommandController alloc];
                                                                                                            r0 = [r0 initWithFileToRun:r19];
                                                                                                            r27 = r0;
                                                                                                            objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                                            r22 = var_1F8;
                                                                                                            if (r26 != 0x0) {
                                                                                                                    [r27 setSelectedBottle:r26];
                                                                                                            }
                                                                                                            [r27 showWindow:r22];
                                                                                                            r0 = r27;
                                                                                                    }
                                                                                                    else {
                                                                                                            r0 = [NoBottleController alloc];
                                                                                                            r0 = [r0 initWithFileToLaunch:r19];
                                                                                                            r21 = r0;
                                                                                                            r22 = var_1F8;
                                                                                                            [r0 showWindow:r22];
                                                                                                            r0 = r21;
                                                                                                    }
                                                                                                    [r0 release];
                                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                                    [r25 release];
                                                                                                    [r26 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r24 release];
                                                                                                    [r20 release];
                                                                                                    [r19 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    r22 = var_1F8;
                                                                                                    [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                                    [r25 release];
                                                                                                    [r26 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r24 release];
                                                                                                    [r20 release];
                                                                                                    [r19 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r0 = [CXSetupLib bottleCollectionClass];
                                                                                            r0 = [r0 sharedCollection];
                                                                                            r0 = [r0 retain];
                                                                                            r21 = r0;
                                                                                            r0 = [r0 bottleList];
                                                                                            r0 = [r0 retain];
                                                                                            r22 = r0;
                                                                                            r27 = [r0 count];
                                                                                            [r22 release];
                                                                                            [r21 release];
                                                                                            if (r27 != 0x0) {
                                                                                                    r0 = [RunCommandController alloc];
                                                                                                    r0 = [r0 initWithFileToRun:r19];
                                                                                                    r27 = r0;
                                                                                                    objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                                    r22 = var_1F8;
                                                                                                    if (r26 != 0x0) {
                                                                                                            [r27 setSelectedBottle:r26];
                                                                                                    }
                                                                                                    [r27 showWindow:r22];
                                                                                                    r0 = r27;
                                                                                            }
                                                                                            else {
                                                                                                    r0 = [NoBottleController alloc];
                                                                                                    r0 = [r0 initWithFileToLaunch:r19];
                                                                                                    r21 = r0;
                                                                                                    r22 = var_1F8;
                                                                                                    [r0 showWindow:r22];
                                                                                                    r0 = r21;
                                                                                            }
                                                                                            [r0 release];
                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                            [r25 release];
                                                                                            [r26 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r24 release];
                                                                                            [r20 release];
                                                                                            [r19 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                            }
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            if (r25 != 0x0) {
                                                                    if (var_200 == 0x0) {
                                                                            r0 = [r23 caseInsensitiveCompare:@"lnk"];
                                                                            var_210 = r23;
                                                                            r23 = r24;
                                                                            if (r0 != 0x0) {
                                                                                    r24 = @"--";
                                                                            }
                                                                            else {
                                                                                    r24 = @"--start";
                                                                            }
                                                                            r0 = **_NSApp;
                                                                            r0 = [r0 crossOverRoot];
                                                                            r0 = [r0 retain];
                                                                            r21 = r0;
                                                                            r0 = [r0 stringByAppendingPathComponent:@"bin"];
                                                                            r0 = [r0 retain];
                                                                            r22 = r0;
                                                                            r0 = [r0 stringByAppendingPathComponent:@"wine"];
                                                                            r0 = [r0 retain];
                                                                            r27 = r0;
                                                                            var_218 = r0;
                                                                            [r22 release];
                                                                            [r21 release];
                                                                            r22 = [[r27 stringQuotedForBash] retain];
                                                                            r27 = [[r19 stringQuotedForBash] retain];
                                                                            var_200 = [[NSString stringWithFormat:@"%@ %@ %@ %@", r3, r4, r5, r6] retain];
                                                                            [r27 release];
                                                                            [r22 release];
                                                                            r0 = [NSWorkspace sharedWorkspace];
                                                                            r0 = [r0 retain];
                                                                            r21 = r0;
                                                                            r0 = [r0 iconForFile:r19];
                                                                            r0 = [r0 retain];
                                                                            r27 = r0;
                                                                            var_220 = r0;
                                                                            [r21 release];
                                                                            var_228 = [[r19 stringByDeletingLastPathComponent] retain];
                                                                            r0 = [NSArray arrayWithObjects:r27];
                                                                            r0 = [r0 retain];
                                                                            var_208 = r28;
                                                                            r28 = r0;
                                                                            r24 = r23;
                                                                            r23 = var_210;
                                                                            r27 = [[NSArray arrayWithObjects:@"icon"] retain];
                                                                            r21 = [[NSDictionary dictionaryWithObjects:r28 forKeys:r27] retain];
                                                                            r22 = var_1F8;
                                                                            [r22 forkExecCommand:var_200 withArgs:r21];
                                                                            [r21 release];
                                                                            [r27 release];
                                                                            r0 = r28;
                                                                            r28 = var_208;
                                                                            [r0 release];
                                                                            [var_228 release];
                                                                            [var_220 release];
                                                                            [var_200 release];
                                                                            r0 = var_218;
                                                                            [r0 release];
                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                            [r25 release];
                                                                            [r26 release];
                                                                            [r28 release];
                                                                            [r23 release];
                                                                            [r24 release];
                                                                            [r20 release];
                                                                            [r19 release];
                                                                            if (**___stack_chk_guard != var_60) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                                    else {
                                                                            if ([r23 caseInsensitiveCompare:@"exe"] != 0x0) {
                                                                                    r0 = [CXSetupLib bottleCollectionClass];
                                                                                    r0 = [r0 sharedCollection];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r0 = [r0 bottleList];
                                                                                    r0 = [r0 retain];
                                                                                    r22 = r0;
                                                                                    r27 = [r0 count];
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    if (r27 != 0x0) {
                                                                                            r0 = [RunCommandController alloc];
                                                                                            r0 = [r0 initWithFileToRun:r19];
                                                                                            r27 = r0;
                                                                                            objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                            r22 = var_1F8;
                                                                                            if (r26 != 0x0) {
                                                                                                    [r27 setSelectedBottle:r26];
                                                                                            }
                                                                                            [r27 showWindow:r22];
                                                                                            r0 = r27;
                                                                                    }
                                                                                    else {
                                                                                            r0 = [NoBottleController alloc];
                                                                                            r0 = [r0 initWithFileToLaunch:r19];
                                                                                            r21 = r0;
                                                                                            r22 = var_1F8;
                                                                                            [r0 showWindow:r22];
                                                                                            r0 = r21;
                                                                                    }
                                                                                    [r0 release];
                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                    [r25 release];
                                                                                    [r26 release];
                                                                                    [r28 release];
                                                                                    [r23 release];
                                                                                    [r24 release];
                                                                                    [r20 release];
                                                                                    [r19 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r0 = [NSUserDefaults standardUserDefaults];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r22 = [r0 boolForKey:@"InstallExeFiles"];
                                                                                    [r21 release];
                                                                                    if (r22 != 0x0) {
                                                                                            if (var_200 != 0x0) {
                                                                                                    r0 = [CXSetupLib bottleCollectionClass];
                                                                                                    r0 = [r0 sharedCollection];
                                                                                                    r0 = [r0 retain];
                                                                                                    r21 = r0;
                                                                                                    r0 = [r0 bottleList];
                                                                                                    r0 = [r0 retain];
                                                                                                    r22 = r0;
                                                                                                    r27 = [r0 count];
                                                                                                    [r22 release];
                                                                                                    [r21 release];
                                                                                                    if (r27 != 0x0) {
                                                                                                            r0 = [RunCommandController alloc];
                                                                                                            r0 = [r0 initWithFileToRun:r19];
                                                                                                            r27 = r0;
                                                                                                            objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                                            r22 = var_1F8;
                                                                                                            if (r26 != 0x0) {
                                                                                                                    [r27 setSelectedBottle:r26];
                                                                                                            }
                                                                                                            [r27 showWindow:r22];
                                                                                                            r0 = r27;
                                                                                                    }
                                                                                                    else {
                                                                                                            r0 = [NoBottleController alloc];
                                                                                                            r0 = [r0 initWithFileToLaunch:r19];
                                                                                                            r21 = r0;
                                                                                                            r22 = var_1F8;
                                                                                                            [r0 showWindow:r22];
                                                                                                            r0 = r21;
                                                                                                    }
                                                                                                    [r0 release];
                                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                                    [r25 release];
                                                                                                    [r26 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r24 release];
                                                                                                    [r20 release];
                                                                                                    [r19 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    r22 = var_1F8;
                                                                                                    [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                                    [r25 release];
                                                                                                    [r26 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r24 release];
                                                                                                    [r20 release];
                                                                                                    [r19 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r0 = [CXSetupLib bottleCollectionClass];
                                                                                            r0 = [r0 sharedCollection];
                                                                                            r0 = [r0 retain];
                                                                                            r21 = r0;
                                                                                            r0 = [r0 bottleList];
                                                                                            r0 = [r0 retain];
                                                                                            r22 = r0;
                                                                                            r27 = [r0 count];
                                                                                            [r22 release];
                                                                                            [r21 release];
                                                                                            if (r27 != 0x0) {
                                                                                                    r0 = [RunCommandController alloc];
                                                                                                    r0 = [r0 initWithFileToRun:r19];
                                                                                                    r27 = r0;
                                                                                                    objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                                    r22 = var_1F8;
                                                                                                    if (r26 != 0x0) {
                                                                                                            [r27 setSelectedBottle:r26];
                                                                                                    }
                                                                                                    [r27 showWindow:r22];
                                                                                                    r0 = r27;
                                                                                            }
                                                                                            else {
                                                                                                    r0 = [NoBottleController alloc];
                                                                                                    r0 = [r0 initWithFileToLaunch:r19];
                                                                                                    r21 = r0;
                                                                                                    r22 = var_1F8;
                                                                                                    [r0 showWindow:r22];
                                                                                                    r0 = r21;
                                                                                            }
                                                                                            [r0 release];
                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                            [r25 release];
                                                                                            [r26 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r24 release];
                                                                                            [r20 release];
                                                                                            [r19 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    if ([r23 caseInsensitiveCompare:@"exe"] != 0x0) {
                                                                            r0 = [CXSetupLib bottleCollectionClass];
                                                                            r0 = [r0 sharedCollection];
                                                                            r0 = [r0 retain];
                                                                            r21 = r0;
                                                                            r0 = [r0 bottleList];
                                                                            r0 = [r0 retain];
                                                                            r22 = r0;
                                                                            r27 = [r0 count];
                                                                            [r22 release];
                                                                            [r21 release];
                                                                            if (r27 != 0x0) {
                                                                                    r0 = [RunCommandController alloc];
                                                                                    r0 = [r0 initWithFileToRun:r19];
                                                                                    r27 = r0;
                                                                                    objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                    r22 = var_1F8;
                                                                                    if (r26 != 0x0) {
                                                                                            [r27 setSelectedBottle:r26];
                                                                                    }
                                                                                    [r27 showWindow:r22];
                                                                                    r0 = r27;
                                                                            }
                                                                            else {
                                                                                    r0 = [NoBottleController alloc];
                                                                                    r0 = [r0 initWithFileToLaunch:r19];
                                                                                    r21 = r0;
                                                                                    r22 = var_1F8;
                                                                                    [r0 showWindow:r22];
                                                                                    r0 = r21;
                                                                            }
                                                                            [r0 release];
                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                            [r25 release];
                                                                            [r26 release];
                                                                            [r28 release];
                                                                            [r23 release];
                                                                            [r24 release];
                                                                            [r20 release];
                                                                            [r19 release];
                                                                            if (**___stack_chk_guard != var_60) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                                    else {
                                                                            r0 = [NSUserDefaults standardUserDefaults];
                                                                            r0 = [r0 retain];
                                                                            r21 = r0;
                                                                            r22 = [r0 boolForKey:@"InstallExeFiles"];
                                                                            [r21 release];
                                                                            if (r22 != 0x0) {
                                                                                    if (var_200 != 0x0) {
                                                                                            r0 = [CXSetupLib bottleCollectionClass];
                                                                                            r0 = [r0 sharedCollection];
                                                                                            r0 = [r0 retain];
                                                                                            r21 = r0;
                                                                                            r0 = [r0 bottleList];
                                                                                            r0 = [r0 retain];
                                                                                            r22 = r0;
                                                                                            r27 = [r0 count];
                                                                                            [r22 release];
                                                                                            [r21 release];
                                                                                            if (r27 != 0x0) {
                                                                                                    r0 = [RunCommandController alloc];
                                                                                                    r0 = [r0 initWithFileToRun:r19];
                                                                                                    r27 = r0;
                                                                                                    objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                                    r22 = var_1F8;
                                                                                                    if (r26 != 0x0) {
                                                                                                            [r27 setSelectedBottle:r26];
                                                                                                    }
                                                                                                    [r27 showWindow:r22];
                                                                                                    r0 = r27;
                                                                                            }
                                                                                            else {
                                                                                                    r0 = [NoBottleController alloc];
                                                                                                    r0 = [r0 initWithFileToLaunch:r19];
                                                                                                    r21 = r0;
                                                                                                    r22 = var_1F8;
                                                                                                    [r0 showWindow:r22];
                                                                                                    r0 = r21;
                                                                                            }
                                                                                            [r0 release];
                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                            [r25 release];
                                                                                            [r26 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r24 release];
                                                                                            [r20 release];
                                                                                            [r19 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r22 = var_1F8;
                                                                                            [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                                                                                            [r22 addToRecentItems:r19 bottle:r20];
                                                                                            [r25 release];
                                                                                            [r26 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r24 release];
                                                                                            [r20 release];
                                                                                            [r19 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r0 = [CXSetupLib bottleCollectionClass];
                                                                                    r0 = [r0 sharedCollection];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r0 = [r0 bottleList];
                                                                                    r0 = [r0 retain];
                                                                                    r22 = r0;
                                                                                    r27 = [r0 count];
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    if (r27 != 0x0) {
                                                                                            r0 = [RunCommandController alloc];
                                                                                            r0 = [r0 initWithFileToRun:r19];
                                                                                            r27 = r0;
                                                                                            objc_unsafeClaimAutoreleasedReturnValue([r0 window]);
                                                                                            r22 = var_1F8;
                                                                                            if (r26 != 0x0) {
                                                                                                    [r27 setSelectedBottle:r26];
                                                                                            }
                                                                                            [r27 showWindow:r22];
                                                                                            r0 = r27;
                                                                                    }
                                                                                    else {
                                                                                            r0 = [NoBottleController alloc];
                                                                                            r0 = [r0 initWithFileToLaunch:r19];
                                                                                            r21 = r0;
                                                                                            r22 = var_1F8;
                                                                                            [r0 showWindow:r22];
                                                                                            r0 = r21;
                                                                                    }
                                                                                    [r0 release];
                                                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                                                    [r25 release];
                                                                                    [r26 release];
                                                                                    [r28 release];
                                                                                    [r23 release];
                                                                                    [r24 release];
                                                                                    [r20 release];
                                                                                    [r19 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                                                    [r22 addToRecentItems:r19 bottle:r20];
                                                    [r25 release];
                                                    [r26 release];
                                                    [r28 release];
                                                    [r23 release];
                                                    [r24 release];
                                                    [r20 release];
                                                    [r19 release];
                                                    if (**___stack_chk_guard != var_60) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                                            [r22 addToRecentItems:r19 bottle:r20];
                                            [r25 release];
                                            [r26 release];
                                            [r28 release];
                                            [r23 release];
                                            [r24 release];
                                            [r20 release];
                                            [r19 release];
                                            if (**___stack_chk_guard != var_60) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                            else {
                                    [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                                    [r22 addToRecentItems:r19 bottle:r20];
                                    [r25 release];
                                    [r26 release];
                                    [r28 release];
                                    [r23 release];
                                    [r24 release];
                                    [r20 release];
                                    [r19 release];
                                    if (**___stack_chk_guard != var_60) {
                                            __stack_chk_fail();
                                    }
                            }
                    }
                    else {
                            [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                            [r22 addToRecentItems:r19 bottle:r20];
                            [r25 release];
                            [r26 release];
                            [r28 release];
                            [r23 release];
                            [r24 release];
                            [r20 release];
                            [r19 release];
                            if (**___stack_chk_guard != var_60) {
                                    __stack_chk_fail();
                            }
                    }
            }
            else {
                    [r22 openAutoPlayInstallerForVolume:r19 inBottle:r26];
                    [r22 addToRecentItems:r19 bottle:r20];
                    [r25 release];
                    [r26 release];
                    [r28 release];
                    [r23 release];
                    [r24 release];
                    [r20 release];
                    [r19 release];
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
            }
    }
    return;


// 0x100048b34
// -[CXServerCrossOver continueFromDemoCheck]
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r20 = r0;
    [r0 addChangeDelegate:self];
    [r20 release];
    [self watchMenuPLists];
    [self refreshPrograms:0x0];
    var_20 = self;
    [[&var_20 super] continueFromDemoCheck];
    r0 = [NSDate date];
    r0 = [r0 retain];
    r8 = self->lastDemoNagTime;
    self->lastDemoNagTime = r0;
    [r8 release];
    [CDTools removeCDHelperAndPrefsForAllInstalls];
    return;


// 0x100048bf0
// -[CXServerCrossOver handleGetURLEvent:withReplyEvent:]
    r31 = r31 - 0x90;
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
    r24 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r0 = [r19 paramDescriptorForKeyword:0x2d2d2d2d];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 stringValue];
    r0 = [r0 retain];
    r22 = r0;
    if ([r0 length] != 0x0) {
            r0 = [NSURL URLWithString:r22];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0) {
                    r0 = [r23 scheme];
                    r0 = [r0 retain];
                    r25 = r0;
                    r26 = [r0 caseInsensitiveCompare:@"com-codeweavers-crossover-crosstie"];
                    [r25 release];
                    if (r26 == 0x0) {
                            var_70 = *__NSConcreteStackBlock;
                            r0 = [r23 retain];
                            r23 = r0;
                            var_48 = r0;
                            r0 = [NSBlockOperation blockOperationWithBlock:&var_70];
                            r25 = [r0 retain];
                            r24 = [[r24 startedAppGateOp] retain];
                            [r25 addDependency:r24];
                            [r24 release];
                            r0 = [NSOperationQueue mainQueue];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 addOperation:r25];
                            [r24 release];
                            [r25 release];
                            [var_48 release];
                            r24 = 0x0;
                    }
                    else {
                            var_80 = r24;
                            r0 = [[&var_80 super] handleGetURLEvent:r19 withReplyEvent:r20];
                            r24 = r0;
                    }
            }
            else {
                    var_80 = r24;
                    r0 = [[&var_80 super] handleGetURLEvent:r19 withReplyEvent:r20];
                    r24 = r0;
            }
    }
    else {
            r23 = 0x0;
            var_80 = r24;
            r0 = [[&var_80 super] handleGetURLEvent:r19 withReplyEvent:r20];
            r24 = r0;
    }
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = r24;
    return r0;


// 0x100048e00
// -[CXServerCrossOver handleCrossTieURL:]
    r21 = [arg2 retain];
    r20 = [[CrossTieURLHandler alloc] init];
    [self setUrlHandler:r20];
    [r20 release];
    r0 = [self urlHandler];
    r0 = [r0 retain];
    r19 = r0;
    [r0 handleCrossTieURL:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100048e80
// -[CXServerCrossOver openScreenSharingHelpPage:]
    r19 = [[NSWorkspace sharedWorkspace] retain];
    r20 = [[NSURL URLWithString:@"http://crossover.codeweavers.com/redirect/teamviewer"] retain];
    [r19 openURL:r20];
    [r20 release];
    [r19 release];
    return;


// 0x100048ee8
// -[CXServerCrossOver openHelpInBrowser:]
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 localizedStringForKey:@"https://support.codeweavers.com/user-guides/crossover-mac-user-guide" value:@"" table:@"Vendor"] retain];
    r19 = [[NSString stringWithFormat:r21] retain];
    [r21 release];
    [r20 release];
    r20 = [[NSWorkspace sharedWorkspace] retain];
    r21 = [[NSURL URLWithString:r19] retain];
    [r20 openURL:r21];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x100048fe0
// -[CXServerCrossOver showMainWindow:]
    r20 = [arg2 retain];
    r0 = [self mainWindowController];
    r0 = [r0 retain];
    r19 = r0;
    [r0 showWindow:r20];
    [r20 release];
    [r19 release];
    return;


// 0x100049030
// -[CXServerCrossOver showPreferencesWindow:]
    r20 = [arg2 retain];
    r0 = [self preferencesController];
    r0 = [r0 retain];
    r19 = r0;
    [r0 showWindow:r20];
    [r20 release];
    [r19 release];
    return;


// 0x100049080
// +[CXServerCrossOver getDefaultProgramsFolder]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = NSSearchPathForDirectoriesInDomains(0x1, 0x1, 0x1);
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 objectAtIndex:0x0] retain];
    [r21 release];
    if (r20 == 0x0) {
            r20 = [[@"~/Applications" stringByExpandingTildeInPath] retain];
    }
    r19 = [[r19 getCellarID] retain];
    r21 = [[r20 stringByAppendingPathComponent:r19] retain];
    [r19 release];
    [r20 release];
    r0 = [r21 autorelease];
    return r0;


// 0x100049138
// +[CXServerCrossOver getProgramsFolder]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [[NSUserDefaults standardUserDefaults] retain];
    r20 = [[NSFileManager defaultManager] retain];
    r0 = [r19 dataForKey:@"ProgramsFolderBookmark"];
    r0 = [r0 retain];
    r23 = r0;
    if (r0 != 0x0) {
            r0 = [r20 pathFromBookmarkData:r23 stale:&var_31];
            r21 = [r0 retain];
            asm { ccmp       w8, #0x0, #0x4, ne };
            if (!asm { ccmp       w8, #0x0, #0x4, ne }) {
                    if (r21 != 0x0) {
                            r22 = r23;
                            r0 = [r19 stringForKey:@"ProgramsFolderPath"];
                            r0 = [r0 retain];
                            r23 = r0;
                            if (([r0 isEqualToString:r21] & 0x1) == 0x0) {
                                    [r19 setObject:r21 forKey:@"ProgramsFolderPath"];
                            }
                            [r23 release];
                            [r22 release];
                            [r20 release];
                            [r19 release];
                            r0 = [r21 autorelease];
                    }
                    else {
                            r21 = [[r19 stringForKey:@"ProgramsFolderPath"] retain];
                            r22 = [[r20 bookmarkDataFromPath:r21] retain];
                            [r23 release];
                            if (r22 != 0x0) {
                                    [r19 setObject:r22 forKey:@"ProgramsFolderBookmark"];
                                    [r22 release];
                            }
                            else {
                                    [r19 removeObjectForKey:@"ProgramsFolderBookmark"];
                            }
                            [r20 release];
                            [r19 release];
                            r0 = [r21 autorelease];
                    }
            }
            else {
                    r22 = [[r20 bookmarkDataFromPath:r21] retain];
                    [r23 release];
                    if (r22 != 0x0) {
                            [r19 setObject:r22 forKey:@"ProgramsFolderBookmark"];
                    }
                    r0 = [r19 stringForKey:@"ProgramsFolderPath"];
                    r0 = [r0 retain];
                    r23 = r0;
                    if (([r0 isEqualToString:r21] & 0x1) == 0x0) {
                            [r19 setObject:r21 forKey:@"ProgramsFolderPath"];
                    }
                    [r23 release];
                    [r22 release];
                    [r20 release];
                    [r19 release];
                    r0 = [r21 autorelease];
            }
    }
    else {
            r21 = [[r19 stringForKey:@"ProgramsFolderPath"] retain];
            r22 = [[r20 bookmarkDataFromPath:r21] retain];
            [r23 release];
            if (r22 != 0x0) {
                    [r19 setObject:r22 forKey:@"ProgramsFolderBookmark"];
                    [r22 release];
            }
            else {
                    [r19 removeObjectForKey:@"ProgramsFolderBookmark"];
            }
            [r20 release];
            [r19 release];
            r0 = [r21 autorelease];
    }
    return r0;


// 0x1000492f4
// -[CXServerCrossOver bottleCollectionChanged]
    *(int8_t *)(int64_t *)&self->refreshProgramsCreateIsForced = 0x1;
    [self performSelectorOnMainThread:@selector(queueRefreshPrograms:) withObject:0x0 waitUntilDone:0x1];
    [self watchMenuPLists];
    return;


// 0x100049338
// -[CXServerCrossOver runCommand:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r23 = sign_extend_64(*(int32_t *)ivar_offset(mainWindowController));
    r0 = *(r20 + r23);
    r0 = [r0 window];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 isVisible];
    [r21 release];
    if (r22 != 0x0) {
            [*(r20 + r23) showWindow:r19];
    }
    var_40 = r20;
    [[&var_40 super] runCommand:r19];
    [r19 release];
    return;


// 0x1000493dc
// -[CXServerCrossOver rebuildMenus:]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x1e0;
    var_1F8 = self;
    var_60 = **___stack_chk_guard;
    var_208 = [arg2 retain];
    var_1E8 = [[NSFileManager defaultManager] retain];
    r0 = var_1F8->associationsLock;
    r0 = [r0 retain];
    var_200 = r0;
    objc_sync_enter(r0);
    var_1F0 = [[NSAlert alloc] init];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 localizedStringForKey:@"Rebuild Programs" value:@"" table:0x0] retain];
    [var_1F0 setMessageText:r19];
    [r19 release];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r24 = [[r0 localizedStringForKey:@"This action will rebuild the %1$@ Applications folder and the program launchers it contains from scratch. This will result in the deletion of the %2$@ folder and any changes that you might have made to its contents. Are you sure you want to do this?" value:@"" table:0x0] retain];
    r26 = [[objc_opt_class(var_1F8) getProgramsFolder] retain];
    r27 = [[var_1E8 getDisplayStringForPath:r26] retain];
    r19 = [[NSString stringWithFormat:r24] retain];
    [var_1F0 setInformativeText:r19];
    [r19 release];
    [r27 release];
    [r26 release];
    [r24 release];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 localizedStringForKey:@"Cancel" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([var_1F0 addButtonWithTitle:r19]);
    [r19 release];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 localizedStringForKey:@"Rebuild" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([var_1F0 addButtonWithTitle:r19]);
    [r19 release];
    [r20 release];
    if ([var_1F0 runModal] == 0x3e9) {
            var_210 = [[NSMenu alloc] initWithTitle:@""];
            r24 = [NSMenuItem alloc];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r25 = [[r0 localizedStringForKey:@"Loading…" value:@"" table:0x0] retain];
            var_218 = [r24 initWithTitle:r25 action:0x0 keyEquivalent:@""];
            [r25 release];
            [r20 release];
            [var_218 setEnabled:0x0];
            [var_210 addItem:var_218];
            [var_1F8 createProgramsMenuFromSubmenu:var_210 hasPrograms:0x0];
            [var_1F8 setLaunchers:0x0];
            r26 = [[objc_opt_class(var_1F8) getProgramsFolder] retain];
            r0 = [var_1E8 enumeratorAtPath:r26];
            r0 = [r0 retain];
            var_1A0 = q0;
            var_190 = q0;
            r0 = [r0 retain];
            r27 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
            r28 = r0;
            if (r0 != 0x0) {
                    r23 = *var_190;
                    do {
                            r20 = 0x0;
                            do {
                                    if (*var_190 != r23) {
                                            objc_enumerationMutation(r27);
                                    }
                                    r24 = [[r26 stringByAppendingPathComponent:*(var_198 + r20 * 0x8)] retain];
                                    r19 = [[NSURL fileURLWithPath:r24] retain];
                                    r25 = [[CXBundle bundleWithURL:r19] retain];
                                    [r19 release];
                                    if (r25 != 0x0) {
                                            r0 = [r25 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                            r0 = [r0 retain];
                                            if (r0 == 0x0) {
                                                    r19 = 0x1;
                                            }
                                            [r0 release];
                                            if ((r19 & 0x1) == 0x0) {
                                                    [var_1E8 removeItemAtPath:r24 error:0x0];
                                            }
                                            [r27 skipDescendants];
                                    }
                                    [r25 release];
                                    [r24 release];
                                    r20 = r20 + 0x1;
                            } while (r28 != r20);
                            r0 = [r27 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
                            r28 = r0;
                    } while (r0 != 0x0);
            }
            [r27 release];
            r20 = [[var_1E8 enumeratorAtPath:r26] retain];
            [r27 release];
            var_1E0 = q0;
            var_1D0 = q0;
            r0 = [r20 retain];
            r27 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
            r20 = r0;
            if (r0 != 0x0) {
                    r21 = *var_1D0;
                    do {
                            r22 = 0x0;
                            do {
                                    if (*var_1D0 != r21) {
                                            objc_enumerationMutation(r27);
                                    }
                                    r19 = [[r26 stringByAppendingPathComponent:*(var_1D8 + r22 * 0x8)] retain];
                                    [var_1E8 removeFolderIfEmpty:r19 upTo:r26];
                                    [r19 release];
                                    r22 = r22 + 0x1;
                            } while (r20 != r22);
                            r0 = [r27 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
                            r20 = r0;
                    } while (r0 != 0x0);
            }
            [r27 release];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r19 = r0;
            [r0 removeObjectForKey:@"MostRecentCXFBMenuPlist"];
            [r19 release];
            r20 = [@(YES) retain];
            [var_1F8 performSelectorOnMainThread:@selector(queueRefreshPrograms:) withObject:r20 waitUntilDone:0x1];
            [r20 release];
            [r27 release];
            [r26 release];
            [var_218 release];
            [var_210 release];
    }
    [var_1F0 release];
    objc_sync_exit(var_200);
    [var_200 release];
    [var_1E8 release];
    [var_208 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x100049a80
// -[CXServerCrossOver validateMenuItem:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r0 = **_NSApp;
    r0 = [r0 modalWindow];
    r0 = [r0 retain];
    r21 = r0;
    if (r0 != 0x0) {
            r23 = 0x1;
    }
    else {
            r0 = r20->mainWindowController;
            r0 = [r0 window];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 attachedSheet];
            r0 = [r0 retain];
            if (r0 != 0x0) {
                    r23 = 0x1;
            }
            [r0 release];
            [r22 release];
    }
    [r21 release];
    if ([r20 menusEnabled] != 0x0) {
            if ((r23 & 0x1) == 0x0) {
                    if ([r19 action] != @selector(rebuildMenus:)) {
                            if ([r19 action] != @selector(refreshPrograms:)) {
                                    if ([r19 action] != @selector(repairBottles:)) {
                                            if ([r19 action] == @selector(repairBottlesDialog:)) {
                                                    r0 = [CXSetupLib bottleCollectionClass];
                                                    r0 = [r0 sharedCollection];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    r0 = [r0 bottleList];
                                                    r0 = [r0 retain];
                                                    r22 = r0;
                                                    if ([r0 count] != 0x0) {
                                                            r21 = 0x1;
                                                    }
                                                    [r22 release];
                                                    [r20 release];
                                                    [r19 release];
                                                    r0 = r21;
                                            }
                                            else {
                                                    [r19 release];
                                                    r0 = 0x1;
                                            }
                                    }
                                    else {
                                            r0 = [CXSetupLib bottleCollectionClass];
                                            r0 = [r0 sharedCollection];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            r0 = [r0 bottleList];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            if ([r0 count] != 0x0) {
                                                    r21 = 0x1;
                                            }
                                            [r22 release];
                                            [r20 release];
                                            [r19 release];
                                            r0 = r21;
                                    }
                            }
                            else {
                                    if (*(int8_t *)(r20 + sign_extend_64(*(int32_t *)ivar_offset(rebuildingPrograms))) == 0x0) {
                                            r21 = 0x1;
                                    }
                                    [r19 release];
                                    r0 = r21;
                            }
                    }
                    else {
                            r21 = *(int8_t *)(int64_t *)&r20->rebuildingPrograms;
                            r20 = [[NSBundle mainBundle] retain];
                            if (r21 != 0x0) {
                                    r21 = [[r20 localizedStringForKey:@"Rebuilding Programs…" value:@"" table:0x0] retain];
                                    [r19 setTitle:r21];
                                    [r21 release];
                                    [r20 release];
                                    r21 = 0x0;
                            }
                            else {
                                    r21 = [[r20 localizedStringForKey:@"Clear and Rebuild Programs…" value:@"" table:0x0] retain];
                                    [r19 setTitle:r21];
                                    [r21 release];
                                    [r20 release];
                                    r21 = 0x1;
                            }
                            [r19 release];
                            r0 = r21;
                    }
            }
            else {
                    r0 = [r19 menu];
                    r0 = [r0 retain];
                    r21 = r0;
                    r20 = [[r0 title] retain];
                    [r21 release];
                    if ([r20 compare:@"Help"] != 0x0) {
                            if ([r20 compare:@"Edit"] != 0x0) {
                                    r21 = 0x0;
                            }
                            else {
                                    if ([r19 action] != @selector(showMainWindow:)) {
                                            r21 = 0x1;
                                    }
                            }
                    }
                    else {
                            if ([r19 action] != @selector(showMainWindow:)) {
                                    r21 = 0x1;
                            }
                    }
                    [r20 release];
                    [r19 release];
                    r0 = r21;
            }
    }
    else {
            r0 = [r19 menu];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 title] retain];
            [r21 release];
            if ([r20 compare:@"Help"] != 0x0) {
                    if ([r20 compare:@"Edit"] != 0x0) {
                            r21 = 0x0;
                    }
                    else {
                            if ([r19 action] != @selector(showMainWindow:)) {
                                    r21 = 0x1;
                            }
                    }
            }
            else {
                    if ([r19 action] != @selector(showMainWindow:)) {
                            r21 = 0x1;
                    }
            }
            [r20 release];
            [r19 release];
            r0 = r21;
    }
    return r0;


// 0x100049d38
// -[CXServerCrossOver refreshProgramsAndAssociationsInBackground:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r20 = objc_autoreleasePoolPush();
    r0 = [r19 objectAtIndex:0x0];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [r0 boolValue];
    [r23 release];
    r0 = [r19 objectAtIndex:0x1];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [r0 boolValue];
    [r23 release];
    r0 = self->associationsLock;
    r0 = [r0 retain];
    r23 = r0;
    objc_sync_enter(r0);
    r24 = [[NSNumber numberWithBool:[self updateApplicationFolder:r22] | r24] retain];
    [self performSelectorOnMainThread:@selector(createProgramsMenu:) withObject:r24 waitUntilDone:0x1];
    [r24 release];
    [self refreshAssociations:r22];
    objc_sync_exit(r23);
    [r23 release];
    r22 = [@(NO) retain];
    [self performSelectorOnMainThread:@selector(setRebuildingPrograms:) withObject:r22 waitUntilDone:0x0];
    [r22 release];
    if (0x0 != 0x0) {
            objc_exception_rethrow();
    }
    objc_autoreleasePoolPop(r20);
    [r19 release];
    return;


// 0x100049ee8
// -[CXServerCrossOver setRebuildingPrograms:]
    r31 = r31 - 0x110;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_38 = **___stack_chk_guard;
    *(int8_t *)(int64_t *)&self->rebuildingPrograms = [arg2 boolValue];
    r20 = *_NSApp;
    r0 = *r20;
    r0 = [r0 mainMenu];
    r0 = [r0 retain];
    r19 = r0;
    [r0 update];
    [r19 release];
    var_100 = q0;
    var_F0 = q0;
    r0 = *r20;
    r0 = [r0 mainMenu];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 itemArray] retain];
    [r20 release];
    r0 = [r19 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
    if (r0 != 0x0) {
            r20 = r0;
            r22 = *var_F0;
            do {
                    r23 = 0x0;
                    do {
                            if (*var_F0 != r22) {
                                    objc_enumerationMutation(r19);
                            }
                            r0 = *(var_F8 + r23 * 0x8);
                            r0 = [r0 submenu];
                            r0 = [r0 retain];
                            r21 = r0;
                            [r0 update];
                            [r21 release];
                            r23 = r23 + 0x1;
                    } while (r20 != r23);
                    r0 = [r19 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                    r20 = r0;
            } while (r0 != 0x0);
    }
    [r19 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x10004a050
// -[CXServerCrossOver refreshPrograms:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r21 = [@(YES) retain];
    [r19 setRebuildingPrograms:r21];
    [r21 release];
    r24 = sign_extend_64(*(int32_t *)ivar_offset(refreshProgramsUpdateIsForced));
    r2 = *(int8_t *)(r19 + r24);
    r22 = [[NSNumber numberWithBool:r2] retain];
    r23 = sign_extend_64(*(int32_t *)ivar_offset(refreshProgramsCreateIsForced));
    asm { ccmp       w8, #0x0, #0x0, eq };
    if (asm { ccmp       w8, #0x0, #0x0, eq }) {
            r2 = 0x1;
    }
    r20 = [[NSNumber numberWithBool:r2] retain];
    r21 = [[NSArray arrayWithObjects:r22] retain];
    [r20 release];
    [r22 release];
    *(int8_t *)(r19 + r24) = 0x0;
    *(int8_t *)(r19 + r23) = 0x0;
    [NSThread detachNewThreadSelector:@selector(refreshProgramsAndAssociationsInBackground:) toTarget:r19 withObject:r21];
    [r21 release];
    return;


// 0x10004a160
// -[CXServerCrossOver queueRefreshPrograms:]
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
    r20 = [arg2 retain];
    [NSObject cancelPreviousPerformRequestsWithTarget:r19 selector:@selector(refreshPrograms:) object:0x0];
    r22 = [@(YES) retain];
    [r19 setRebuildingPrograms:r22];
    [r22 release];
    if (r20 != 0x0) {
            *(int8_t *)(int64_t *)&r19->refreshProgramsCreateIsForced = 0x1;
            objc_opt_class(@class(NSNumber));
            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                    if ([r20 boolValue] != 0x0) {
                            *(int8_t *)(int64_t *)&r19->refreshProgramsUpdateIsForced = 0x1;
                    }
            }
    }
    [r19 performSelector:@selector(refreshPrograms:) withObject:0x0 afterDelay:s0];
    [r20 release];
    return;


// 0x10004a248
// -[CXServerCrossOver watchMenuPLists]
    r31 = r31 - 0x1f0;
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
    var_58 = **___stack_chk_guard;
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 bottleList] retain];
    [r21 release];
    r0 = [r19 observedBottles];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    if (r21 != 0x0) {
            var_1A0 = q0;
            var_190 = q0;
            r0 = [r19 observedBottles];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [r0 copy];
            [r22 release];
            r0 = [r21 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_d8 count:0x10];
            if (r0 != 0x0) {
                    r22 = r0;
                    r26 = *var_190;
                    do {
                            r27 = 0x0;
                            do {
                                    if (*var_190 != r26) {
                                            objc_enumerationMutation(r21);
                                    }
                                    r24 = *(var_198 + r27 * 0x8);
                                    if (([r20 containsObject:r24] & 0x1) == 0x0) {
                                            [r24 removeObserver:r19 forKeyPath:@"menuChangedTime"];
                                            r0 = [r19 observedBottles];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            [r0 removeObject:r24];
                                            [r25 release];
                                    }
                                    r27 = r27 + 0x1;
                            } while (r22 != r27);
                            r0 = [r21 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_d8 count:0x10];
                            r22 = r0;
                    } while (r0 != 0x0);
            }
    }
    else {
            r21 = [[NSMutableArray array] retain];
            [r19 setObservedBottles:r21];
    }
    [r21 release];
    var_1E0 = q0;
    var_1D0 = q0;
    r0 = [r20 retain];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_158 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r26 = *var_1D0;
            do {
                    r27 = 0x0;
                    do {
                            if (*var_1D0 != r26) {
                                    objc_enumerationMutation(r20);
                            }
                            r23 = *(var_1D8 + r27 * 0x8);
                            r0 = [r19 observedBottles];
                            r0 = [r0 retain];
                            r24 = r0;
                            r25 = [r0 containsObject:r23];
                            [r24 release];
                            if ((r25 & 0x1) == 0x0) {
                                    r0 = [r19 observedBottles];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    [r0 addObject:r23];
                                    [r24 release];
                                    [r23 addObserver:r19 forKeyPath:@"menuChangedTime" options:0x0 context:0x0];
                            }
                            r27 = r27 + 0x1;
                    } while (r21 != r27);
                    r0 = [r20 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_158 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x10004a528
// -[CXServerCrossOver observeValueForKeyPath:ofObject:change:context:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg5;
    r23 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r22 = [arg4 retain];
    if ([r19 isEqualToString:@"menuChangedTime"] != 0x0) {
            [r23 performSelectorOnMainThread:@selector(queueRefreshPrograms:) withObject:0x0 waitUntilDone:0x1];
    }
    else {
            var_40 = r23;
            [[&var_40 super] observeValueForKeyPath:r19 ofObject:r20 change:r22 context:r21];
    }
    [r22 release];
    [r20 release];
    [r19 release];
    return;


// 0x10004a600
// -[CXServerCrossOver getMenuPList]
    r31 = r31 - 0x150;
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
    var_60 = **___stack_chk_guard;
    r20 = [[NSFileManager defaultManager] retain];
    var_130 = [[NSMutableDictionary dictionary] retain];
    r22 = [[NSMutableArray array] retain];
    [self performSelectorOnMainThread:@selector(duplicateBottleList:) withObject:r22 waitUntilDone:0x1];
    var_120 = q0;
    var_110 = q0;
    r0 = [r22 retain];
    r19 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r27 = r0;
            r21 = *var_110;
            var_138 = r19;
            do {
                    r22 = 0x0;
                    var_128 = r27;
                    do {
                            if (*var_110 != r21) {
                                    objc_enumerationMutation(r19);
                            }
                            r26 = [[*(var_118 + r22 * 0x8) winePrefix] retain];
                            r25 = [[NSString stringWithFormat:@"%@/desktopdata/cxmenu/cxmenu_macosx.plist", r3] retain];
                            [r26 release];
                            if ([r20 fileExistsAtPath:r25] != 0x0) {
                                    r24 = [[r25 stringByResolvingSymlink] retain];
                                    r26 = [[r20 attributesOfItemAtPath:r24 error:0x0] retain];
                                    [r24 release];
                                    r27 = [[r26 fileModificationDate] retain];
                                    r28 = [[NSData dataWithContentsOfFile:r25] retain];
                                    r3 = 0x1;
                                    r24 = [[NSPropertyListSerialization propertyListWithData:r28 options:0x1 format:0x0 error:0x0] retain];
                                    objc_opt_class(@class(NSDictionary));
                                    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                            r0 = [r24 allKeys];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            r23 = r20;
                                            r20 = r21;
                                            r21 = [[r0 objectAtIndex:0x0] retain];
                                            [r19 release];
                                            r0 = [r24 objectForKey:r21];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            r3 = @"moddate";
                                            [r0 setObject:r27 forKey:@"moddate"];
                                            [var_130 addEntriesFromDictionary:r24];
                                            r0 = r19;
                                            r19 = var_138;
                                            [r0 release];
                                            r0 = r21;
                                            r21 = r20;
                                            r20 = r23;
                                            [r0 release];
                                    }
                                    [r24 release];
                                    [r28 release];
                                    [r27 release];
                                    [r26 release];
                                    r27 = var_128;
                            }
                            [r25 release];
                            r22 = r22 + 0x1;
                    } while (r27 != r22);
                    r0 = [r19 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r27 = r0;
            } while (r0 != 0x0);
    }
    [r19 release];
    [r19 release];
    r0 = [r20 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [var_130 autorelease];
    return r0;


// 0x10004a938
// -[CXServerCrossOver addProgramsFromMenuPlist:bottle:toDictionary:atPath:]
    r23 = [arg3 retain];
    r20 = [arg4 retain];
    r0 = [arg5 retain];
    var_70 = *__NSConcreteStackBlock;
    var_40 = r20;
    var_38 = r0;
    r19 = [r0 retain];
    r20 = [r20 retain];
    r22 = [r23 retain];
    [arg2 enumerateKeysAndObjectsUsingBlock:&var_70];
    [var_38 release];
    [var_40 release];
    [r23 release];
    [r19 release];
    [r20 release];
    [r22 release];
    return;


// 0x10004ab68
// -[CXServerCrossOver addProgramsFromMenuPlist:bottle:toDictionary:]
    [self addProgramsFromMenuPlist:arg2 bottle:arg3 toDictionary:arg4 atPath:**___NSArray0__];
    return;


// 0x10004ab78
// -[CXServerCrossOver updateApplicationFolder:]
    r2 = arg2;
    r0 = self;
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
    r31 = r31 + 0xffffffffffffffa0 - 0x850;
    var_60 = **___stack_chk_guard;
    r9 = sign_extend_64(*(int32_t *)ivar_offset(inUpdateApplicationFolder));
    if (*(int8_t *)(r0 + r9) != 0x0) {
            r26 = 0x0;
    }
    else {
            r25 = r0;
            var_7FC = r2;
            var_880 = r9;
            *(int8_t *)(r0 + r9) = 0x1;
            var_888 = objc_autoreleasePoolPush();
            r23 = [[r25 getMenuPList] retain];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 objectForKey:@"MostRecentCXFBMenuPlist"] retain];
            [r19 release];
            r24 = CFPropertyListCreateDeepCopy(0x0, r21, 0x1);
            [r21 release];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r19 = r0;
            [r0 setObject:r23 forKey:@"MostRecentCXFBMenuPlist"];
            [r19 release];
            var_828 = [[NSMutableDictionary dictionary] retain];
            var_830 = [[NSMutableDictionary dictionary] retain];
            var_7E8 = [[NSMutableDictionary dictionary] retain];
            var_858 = r23;
            r20 = [[r23 allKeys] retain];
            r19 = [[NSMutableSet setWithArray:r20] retain];
            [r20 release];
            var_860 = r24;
            r20 = [[r24 allKeys] retain];
            [r19 addObjectsFromArray:r20];
            [r20 release];
            var_4F0 = q0;
            var_4E0 = q0;
            r0 = [r19 retain];
            var_870 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_4F0 objects:&decomp_var_e0 count:0x10];
            var_738 = r25;
            var_6F8 = r0;
            if (r0 != 0x0) {
                    var_700 = *var_4E0;
                    r26 = var_830;
                    do {
                            r20 = 0x0;
                            do {
                                    if (*var_4E0 != var_700) {
                                            objc_enumerationMutation(var_870);
                                    }
                                    r23 = *(var_4E8 + r20 * 0x8);
                                    r0 = [var_860 objectForKey:r23];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    if (r0 != 0x0) {
                                            r27 = [[r19 valueForKeyPath:@"Children.StartMenu/.Children"] retain];
                                            r28 = [[r19 objectForKey:@"Description"] retain];
                                    }
                                    else {
                                            r27 = [[NSMutableDictionary dictionary] retain];
                                            r28 = 0x0;
                                    }
                                    r21 = [[var_858 objectForKey:r23] retain];
                                    [r19 release];
                                    var_6F0 = r21;
                                    var_6E8 = r20;
                                    if (r21 != 0x0) {
                                            r19 = [[r21 valueForKeyPath:@"Children.StartMenu/.Children"] retain];
                                            r21 = [[r21 objectForKey:@"Description"] retain];
                                            [r28 release];
                                            [var_7E8 setObject:r23 forKey:r21];
                                            r28 = r21;
                                    }
                                    else {
                                            r19 = [[NSMutableDictionary dictionary] retain];
                                    }
                                    r21 = [[r19 valueForKeyPath:@"Programs/.Children"] retain];
                                    r0 = [r27 valueForKeyPath:@"Programs/.Children"];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    [r0 removeObjectForKey:@"StartUp/"];
                                    [r21 removeObjectForKey:@"StartUp/"];
                                    [r25 addProgramsFromMenuPlist:r21 bottle:r28 toDictionary:var_828];
                                    [r25 addProgramsFromMenuPlist:r23 bottle:r28 toDictionary:r26];
                                    [r27 removeObjectForKey:@"Programs/"];
                                    [r19 removeObjectForKey:@"Programs/"];
                                    r25 = [[r19 valueForKeyPath:@"Windows Applications/.Children.Programs/.Children"] retain];
                                    [r21 release];
                                    r21 = [[r27 valueForKeyPath:@"Windows Applications/.Children.Programs/.Children"] retain];
                                    [r23 release];
                                    [r21 removeObjectForKey:@"StartUp/"];
                                    [r25 removeObjectForKey:@"StartUp/"];
                                    [var_738 addProgramsFromMenuPlist:r25 bottle:r28 toDictionary:var_828];
                                    [var_738 addProgramsFromMenuPlist:r21 bottle:r28 toDictionary:r26];
                                    r0 = [r27 valueForKeyPath:@"Windows Applications/.Children"];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    [r0 removeObjectForKey:@"Programs/"];
                                    r24 = [[r19 valueForKeyPath:@"Windows Applications/.Children"] retain];
                                    [r22 release];
                                    [r24 removeObjectForKey:@"Programs/"];
                                    r22 = [[r19 valueForKeyPath:@"Windows Applications/.Children"] retain];
                                    [r25 release];
                                    r25 = [[r27 valueForKeyPath:@"Windows Applications/.Children"] retain];
                                    [r21 release];
                                    [r25 removeObjectForKey:@"StartUp/"];
                                    [r22 removeObjectForKey:@"StartUp/"];
                                    [var_738 addProgramsFromMenuPlist:r22 bottle:r28 toDictionary:var_828];
                                    [var_738 addProgramsFromMenuPlist:r25 bottle:r28 toDictionary:r26];
                                    [r27 removeObjectForKey:@"Windows Applications/"];
                                    [r19 removeObjectForKey:@"Windows Applications/"];
                                    r19 = [r19 retain];
                                    [r22 release];
                                    r21 = [r27 retain];
                                    r0 = r25;
                                    r25 = var_738;
                                    [r0 release];
                                    [r25 addProgramsFromMenuPlist:r19 bottle:r28 toDictionary:var_828];
                                    [r19 release];
                                    [r25 addProgramsFromMenuPlist:r21 bottle:r28 toDictionary:r26];
                                    [r21 release];
                                    [r24 release];
                                    [r19 release];
                                    [r21 release];
                                    [var_6F0 release];
                                    [r28 release];
                                    r20 = var_6E8 + 0x1;
                            } while (var_6F8 != r20);
                            r0 = [var_870 countByEnumeratingWithState:&var_4F0 objects:&decomp_var_e0 count:0x10];
                            var_6F8 = r0;
                    } while (r0 != 0x0);
            }
            [var_870 release];
            var_7C8 = [[NSMutableDictionary dictionary] retain];
            var_7D8 = [[NSMutableSet set] retain];
            r22 = [[NSFileManager defaultManager] retain];
            r0 = objc_opt_class(r25);
            r0 = [r0 getProgramsFolder];
            r0 = [r0 retain];
            var_838 = r0;
            r20 = [[NSURL fileURLWithPath:r0] retain];
            var_E8 = **_NSURLIsPackageKey;
            r0 = [NSArray arrayWithObjects:&var_E8 count:0x1];
            r21 = [r0 retain];
            var_750 = r22;
            r22 = [[r22 enumeratorAtURL:r20 includingPropertiesForKeys:r21 options:0x2 errorHandler:0x0] retain];
            [r21 release];
            [r20 release];
            var_530 = q0;
            var_520 = q0;
            r0 = [r22 retain];
            r27 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_530 objects:&decomp_var_168 count:0x10];
            if (r0 != 0x0) {
                    r20 = r0;
                    r28 = *var_520;
                    do {
                            r21 = 0x0;
                            do {
                                    if (*var_520 != r28) {
                                            objc_enumerationMutation(r27);
                                    }
                                    r19 = **_NSURLIsPackageKey;
                                    r23 = *(var_528 + r21 * 0x8);
                                    var_538 = 0x0;
                                    r0 = [r23 getResourceValue:&var_538 forKey:r19 error:0x0];
                                    r24 = r0;
                                    r22 = [var_538 retain];
                                    if (r24 != 0x0 && [r22 boolValue] != 0x0) {
                                            r0 = [CXBundle bundleWithURL:r23];
                                            r0 = [r0 retain];
                                            r24 = r0;
                                            r0 = [r0 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            [r0 release];
                                            if (r25 != 0x0) {
                                                    r25 = [[r24 bundleIdentifier] retain];
                                                    r0 = [var_7C8 objectForKey:r25];
                                                    r0 = [r0 retain];
                                                    r26 = r0;
                                                    if (r0 == 0x0) {
                                                            r26 = [[NSMutableSet set] retain];
                                                            [var_7C8 setObject:r26 forKey:r25];
                                                    }
                                                    [r26 addObject:r23];
                                                    [var_7D8 addObject:r23];
                                                    [r26 release];
                                                    [r25 release];
                                            }
                                            [r24 release];
                                    }
                                    [r22 release];
                                    r21 = r21 + 0x1;
                            } while (r20 != r21);
                            r0 = [r27 countByEnumeratingWithState:&var_530 objects:&decomp_var_168 count:0x10];
                            r20 = r0;
                    } while (r0 != 0x0);
            }
            var_890 = r27;
            [r27 release];
            var_580 = q0;
            var_570 = q0;
            r0 = LSCopyAllRoleHandlersForContentType(@"com.codeweavers.CrossOverHelper.AppDummyType", 0xffffffff);
            r19 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_580 objects:&decomp_var_1e8 count:0x10];
            if (r0 != 0x0) {
                    r21 = r0;
                    r26 = *var_570;
                    do {
                            r27 = 0x0;
                            do {
                                    if (*var_570 != r26) {
                                            objc_enumerationMutation(r19);
                                    }
                                    r23 = *(var_578 + r27 * 0x8);
                                    r0 = [NSWorkspace sharedWorkspace];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    r22 = [[r0 URLForApplicationWithBundleIdentifier:r23] retain];
                                    [r24 release];
                                    r0 = [CXBundle bundleWithURL:r22];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    r0 = [r0 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    [r0 release];
                                    if (r25 != 0x0) {
                                            r0 = [var_7C8 objectForKey:r23];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            if (r0 == 0x0) {
                                                    r25 = [[NSMutableSet set] retain];
                                                    [var_7C8 setObject:r25 forKey:r23];
                                            }
                                            [r25 addObject:r22];
                                            [r25 release];
                                    }
                                    [r24 release];
                                    [r22 release];
                                    r27 = r27 + 0x1;
                            } while (r21 != r27);
                            r0 = [r19 countByEnumeratingWithState:&var_580 objects:&decomp_var_1e8 count:0x10];
                            r21 = r0;
                    } while (r0 != 0x0);
            }
            [r19 release];
            var_820 = [[NSMutableSet set] retain];
            r20 = [[var_828 allKeys] retain];
            r19 = [[NSMutableSet setWithArray:r20] retain];
            [r20 release];
            r20 = [[var_830 allKeys] retain];
            [r19 addObjectsFromArray:r20];
            [r20 release];
            var_5C0 = q0;
            var_5B0 = q0;
            r0 = [r19 retain];
            var_878 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_5C0 objects:&decomp_var_268 count:0x10];
            var_850 = r0;
            r23 = 0x0;
            if (r0 != 0x0) {
                    r8 = *_kCFBundleNameKey;
                    var_868 = *var_5B0;
                    var_748 = *r8;
                    r24 = var_738;
                    do {
                            r10 = 0x0;
                            do {
                                    r9 = var_868;
                                    if (*var_5B0 != r9) {
                                            objc_enumerationMutation(var_878);
                                            r10 = r10;
                                    }
                                    var_840 = r10;
                                    r25 = *(var_5B8 + r10 * 0x8);
                                    var_848 = objc_autoreleasePoolPush();
                                    [r25 count] - 0x1;
                                    r21 = [[r25 subarrayWithRange:0x0] retain];
                                    var_270 = var_838;
                                    r0 = [NSArray arrayWithObjects:&var_270 count:0x1];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    var_7E0 = r21;
                                    r21 = [[r0 arrayByAddingObjectsFromArray:r21] retain];
                                    var_808 = [[NSURL fileURLWithPathComponents:r21] retain];
                                    [r21 release];
                                    [r20 release];
                                    r21 = [[var_828 objectForKey:r25] retain];
                                    r22 = [[var_830 objectForKey:r25] retain];
                                    r26 = [r21 count];
                                    r19 = [r22 count];
                                    r8 = &@selector(keyPathsForValuesAffectingCanRegister);
                                    var_7B8 = r21;
                                    r21 = [[r21 allKeys] retain];
                                    r20 = [[NSMutableSet setWithArray:r21] retain];
                                    [r21 release];
                                    var_7C0 = r22;
                                    r21 = [[r22 allKeys] retain];
                                    [r20 addObjectsFromArray:r21];
                                    [r21 release];
                                    var_600 = q0;
                                    var_5F0 = q0;
                                    r0 = [r20 retain];
                                    r3 = &decomp_var_2f0;
                                    var_810 = r0;
                                    r4 = 0x10;
                                    r0 = [r0 countByEnumeratingWithState:&var_600 objects:r3 count:0x10];
                                    var_7B0 = r0;
                                    if (r0 != 0x0) {
                                            var_7F8 = r26;
                                            var_7F0 = r25;
                                            if (r26 > 0x1) {
                                                    r8 = 0x1;
                                            }
                                            if (r19 < 0x2) {
                                                    r9 = 0x1;
                                            }
                                            var_7D0 = *var_5F0;
                                            var_814 = r8 ^ r9;
                                            do {
                                                    r10 = 0x0;
                                                    do {
                                                            if (*var_5F0 != var_7D0) {
                                                                    objc_enumerationMutation(var_810);
                                                                    r10 = r10;
                                                            }
                                                            var_778 = r10;
                                                            r19 = *(var_5F8 + r10 * 0x8);
                                                            r21 = [[r25 componentsJoinedByString:@"."] retain];
                                                            r22 = [[NSString stringWithFormat:@"com.codeweavers.CrossOverHelper.%@.%@", r3, r4] retain];
                                                            [r21 release];
                                                            r21 = [[r22 stringByAppendingFormat:@" (%@)", r3] retain];
                                                            r26 = [[r24 shortenedBundleID:r22] retain];
                                                            r27 = [[r24 shortenedBundleID:r21] retain];
                                                            var_780 = r22;
                                                            r22 = [[var_7C8 objectForKey:r22] retain];
                                                            var_788 = r21;
                                                            r21 = [[var_7C8 objectForKey:r21] retain];
                                                            var_790 = r26;
                                                            var_760 = [[var_7C8 objectForKey:r26] retain];
                                                            r20 = r22;
                                                            var_798 = r27;
                                                            r27 = [[var_7C8 objectForKey:r27] retain];
                                                            r0 = [NSMutableSet set];
                                                            r0 = [r0 retain];
                                                            var_758 = r0;
                                                            if (r22 != 0x0) {
                                                                    [r0 unionSet:r20];
                                                                    r0 = var_758;
                                                            }
                                                            if (r21 != 0x0) {
                                                                    [r0 unionSet:r21];
                                                                    r0 = var_758;
                                                            }
                                                            r2 = var_760;
                                                            if (r2 != 0x0) {
                                                                    [r0 unionSet:r2];
                                                            }
                                                            if (r27 != 0x0) {
                                                                    [var_758 unionSet:r27];
                                                            }
                                                            r22 = [[var_7B8 objectForKey:r19] retain];
                                                            r0 = [var_7C0 objectForKey:r19];
                                                            r0 = [r0 retain];
                                                            var_770 = r22;
                                                            var_768 = r0;
                                                            if (r22 != 0x0) {
                                                                    var_7A8 = r21;
                                                                    decomp_var_7a0 = r20;
                                                                    [var_7D8 minusSet:var_758];
                                                                    r26 = [r22 mutableCopy];
                                                                    var_330 = @"namepath";
                                                                    var_310 = var_7E0;
                                                                    r20 = [[var_7E8 objectForKey:r19] retain];
                                                                    r21 = [[r25 lastObject] retain];
                                                                    r0 = [NSDictionary dictionaryWithObjects:&var_310 forKeys:&var_330 count:0x4];
                                                                    r22 = [r0 retain];
                                                                    var_730 = r26;
                                                                    [r26 addEntriesFromDictionary:r22];
                                                                    [r22 release];
                                                                    [r21 release];
                                                                    [r20 release];
                                                                    r20 = [[r25 lastObject] retain];
                                                                    if (var_7F8 >= 0x2) {
                                                                            r19 = [[r24 makeBottleTaggedName:r20 withBottleName:r19] retain];
                                                                            [r20 release];
                                                                            var_6F8 = r19;
                                                                    }
                                                                    else {
                                                                            var_6F8 = r20;
                                                                    }
                                                                    r8 = var_7FC;
                                                                    r0 = var_770;
                                                                    r9 = var_768;
                                                                    if (r9 == 0x0) {
                                                                            r19 = 0x1;
                                                                    }
                                                                    r20 = 0x1;
                                                                    if ((r8 & 0x1) == 0x0 && r9 != 0x0) {
                                                                            r20 = [r0 isEqualToDictionary:var_768] ^ 0x1;
                                                                    }
                                                                    var_73C = r20 | r23;
                                                                    var_640 = q0;
                                                                    var_630 = q0;
                                                                    r0 = [var_758 retain];
                                                                    r3 = &decomp_var_3b0;
                                                                    var_728 = r0;
                                                                    r0 = [r0 countByEnumeratingWithState:&var_640 objects:r3 count:0x10];
                                                                    var_700 = r0;
                                                                    var_6F0 = r19;
                                                                    if (r0 != 0x0) {
                                                                            var_710 = *var_630;
                                                                            var_704 = r20;
                                                                            var_714 = var_814 & !r20;
                                                                            var_720 = r27;
                                                                            do {
                                                                                    r20 = 0x0;
                                                                                    while (true) {
                                                                                            if (*var_630 != var_710) {
                                                                                                    objc_enumerationMutation(var_728);
                                                                                            }
                                                                                            r19 = *(var_638 + r20 * 0x8);
                                                                                            var_648 = 0x64;
                                                                                            r0 = [r19 lastPathComponent];
                                                                                            r0 = [r0 retain];
                                                                                            r21 = r0;
                                                                                            r28 = [[r0 stringByDeletingPathExtension] retain];
                                                                                            [r21 release];
                                                                                            if ((var_714 & 0x1) != 0x0) {
                                                                                                    var_6F0 = 0x0;
                                                                                                    if (var_704 != 0x0) {
                                                                                                            var_6E8 = 0x0;
                                                                                                            r0 = [r19 URLByDeletingLastPathComponent];
                                                                                                            r0 = [r0 retain];
                                                                                                            r22 = r0;
                                                                                                            r23 = [[r0 path] retain];
                                                                                                            r27 = [var_738 exportProgram:r28 bundleName:var_6F8 withDictionary:var_730 toFolder:r23];
                                                                                                            [r23 release];
                                                                                                            [r22 release];
                                                                                                            var_6F0 = (r27 ^ 0x1) & var_6F0;
                                                                                                            r27 = var_720;
                                                                                                            if ((0x1 & 0x1) == 0x0) {
                                                                                                                    r21 = r28;
                                                                                                                    r23 = var_6F8;
                                                                                                                    if ([r28 compare:r23] != 0x0) {
                                                                                                                            r0 = [r19 URLByDeletingLastPathComponent];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r22 = r0;
                                                                                                                            r0 = [r0 URLByAppendingPathComponent:r23];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r23 = r0;
                                                                                                                            r28 = [[r0 URLByAppendingPathExtension:@"app"] retain];
                                                                                                                            [r23 release];
                                                                                                                            [r22 release];
                                                                                                                            var_73C = [var_750 moveItemAtURL:r19 toURL:r28 error:0x0] | var_73C;
                                                                                                                            r27 = var_720;
                                                                                                                            [r28 release];
                                                                                                                    }
                                                                                                                    r28 = r21;
                                                                                                            }
                                                                                                            [r28 release];
                                                                                                            [0x0 release];
                                                                                                            [0x0 release];
                                                                                                            [var_6E8 release];
                                                                                                            [0x0 release];
                                                                                                            r20 = r20 + 0x1;
                                                                                                            if (var_700 != r20) {
                                                                                                                    continue;
                                                                                                            }
                                                                                                            break;
                                                                                                    }
                                                                                                    else {
                                                                                                            var_6E8 = 0x0;
                                                                                                            [r28 release];
                                                                                                            [0x0 release];
                                                                                                            [0x0 release];
                                                                                                            [var_6E8 release];
                                                                                                            [0x0 release];
                                                                                                            r20 = r20 + 0x1;
                                                                                                            if (var_700 != r20) {
                                                                                                                    continue;
                                                                                                            }
                                                                                                            break;
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    r0 = [r19 URLByAppendingPathComponent:@"Contents"];
                                                                                                    r0 = [r0 retain];
                                                                                                    r22 = r0;
                                                                                                    r21 = [[r0 URLByAppendingPathComponent:@"Info.plist"] retain];
                                                                                                    [r22 release];
                                                                                                    r0 = [NSData dataWithContentsOfURL:r21 options:0x0 error:0x0];
                                                                                                    r0 = [r0 retain];
                                                                                                    r23 = r0;
                                                                                                    if (r0 != 0x0) {
                                                                                                            var_650 = 0x0;
                                                                                                            r2 = r23;
                                                                                                            r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_648 error:&var_650];
                                                                                                            r24 = [r0 retain];
                                                                                                            r25 = [var_650 retain];
                                                                                                            if (r24 != 0x0) {
                                                                                                                    r0 = [r24 objectForKey:var_748];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r26 = r0;
                                                                                                                    if ([r0 compare:r28] != 0x0) {
                                                                                                                            r22 = 0x1;
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    NSLog(@"Failed to parse %@: %@\n", 0xffffffff, r2);
                                                                                                                    r26 = 0x0;
                                                                                                                    r22 = 0x1;
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r24 = 0x0;
                                                                                                            r25 = 0x0;
                                                                                                            r26 = 0x0;
                                                                                                            r22 = 0x1;
                                                                                                    }
                                                                                                    [r23 release];
                                                                                                    var_6E8 = r24;
                                                                                                    if ((var_704 & 0x1) != 0x0) {
                                                                                                            r24 = r21;
                                                                                                            r21 = r22;
                                                                                                            r0 = [r19 URLByDeletingLastPathComponent];
                                                                                                            r0 = [r0 retain];
                                                                                                            r22 = r0;
                                                                                                            r23 = [[r0 path] retain];
                                                                                                            r27 = [var_738 exportProgram:r28 bundleName:var_6F8 withDictionary:var_730 toFolder:r23];
                                                                                                            [r23 release];
                                                                                                            [r22 release];
                                                                                                            var_6F0 = (r27 ^ 0x1) & var_6F0;
                                                                                                            r27 = var_720;
                                                                                                            if ((r21 & 0x1) == 0x0) {
                                                                                                                    r21 = r28;
                                                                                                                    r23 = var_6F8;
                                                                                                                    if ([r28 compare:r23] != 0x0) {
                                                                                                                            r0 = [r19 URLByDeletingLastPathComponent];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r22 = r0;
                                                                                                                            r0 = [r0 URLByAppendingPathComponent:r23];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r23 = r0;
                                                                                                                            r28 = [[r0 URLByAppendingPathExtension:@"app"] retain];
                                                                                                                            [r23 release];
                                                                                                                            [r22 release];
                                                                                                                            var_73C = [var_750 moveItemAtURL:r19 toURL:r28 error:0x0] | var_73C;
                                                                                                                            r27 = var_720;
                                                                                                                            [r28 release];
                                                                                                                    }
                                                                                                                    r28 = r21;
                                                                                                            }
                                                                                                            [r28 release];
                                                                                                            [r26 release];
                                                                                                            [r25 release];
                                                                                                            [var_6E8 release];
                                                                                                            [r24 release];
                                                                                                            r20 = r20 + 0x1;
                                                                                                            if (var_700 != r20) {
                                                                                                                    continue;
                                                                                                            }
                                                                                                            break;
                                                                                                    }
                                                                                                    else {
                                                                                                            if (r24 != 0x0) {
                                                                                                                    var_740 = r22;
                                                                                                                    r22 = var_6F8;
                                                                                                                    if (([r26 isEqualToString:r22] & 0x1) != 0x0) {
                                                                                                                            r24 = r21;
                                                                                                                            var_6F0 = 0x0;
                                                                                                                            r22 = var_740;
                                                                                                                            if ((r22 & 0x1) != 0x0) {
                                                                                                                                    [r28 release];
                                                                                                                                    [r26 release];
                                                                                                                                    [r25 release];
                                                                                                                                    [var_6E8 release];
                                                                                                                                    [r24 release];
                                                                                                                                    r20 = r20 + 0x1;
                                                                                                                                    if (var_700 != r20) {
                                                                                                                                            continue;
                                                                                                                                    }
                                                                                                                                    break;
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    r21 = r28;
                                                                                                                                    r23 = var_6F8;
                                                                                                                                    if ([r28 compare:r23] != 0x0) {
                                                                                                                                            r0 = [r19 URLByDeletingLastPathComponent];
                                                                                                                                            r0 = [r0 retain];
                                                                                                                                            r22 = r0;
                                                                                                                                            r0 = [r0 URLByAppendingPathComponent:r23];
                                                                                                                                            r0 = [r0 retain];
                                                                                                                                            r23 = r0;
                                                                                                                                            r28 = [[r0 URLByAppendingPathExtension:@"app"] retain];
                                                                                                                                            [r23 release];
                                                                                                                                            [r22 release];
                                                                                                                                            var_73C = [var_750 moveItemAtURL:r19 toURL:r28 error:0x0] | var_73C;
                                                                                                                                            r27 = var_720;
                                                                                                                                            [r28 release];
                                                                                                                                    }
                                                                                                                                    r28 = r21;
                                                                                                                                    [r28 release];
                                                                                                                                    [r26 release];
                                                                                                                                    [r25 release];
                                                                                                                                    [var_6E8 release];
                                                                                                                                    [r24 release];
                                                                                                                                    r20 = r20 + 0x1;
                                                                                                                                    if (var_700 != r20) {
                                                                                                                                            continue;
                                                                                                                                    }
                                                                                                                                    break;
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            [r24 setObject:r22 forKey:var_748];
                                                                                                                            var_658 = 0x0;
                                                                                                                            r2 = r24;
                                                                                                                            r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_648 options:0x0 error:&var_658];
                                                                                                                            r23 = [r0 retain];
                                                                                                                            r22 = [var_658 retain];
                                                                                                                            [r25 release];
                                                                                                                            if (r23 != 0x0) {
                                                                                                                                    var_660 = r22;
                                                                                                                                    r2 = r21;
                                                                                                                                    r0 = [r23 writeToURL:r2 options:0x1 error:&var_660];
                                                                                                                                    r25 = r0;
                                                                                                                                    r24 = [var_660 retain];
                                                                                                                                    [r22 release];
                                                                                                                                    if ((r25 & 0x1) != 0x0) {
                                                                                                                                            r25 = r24;
                                                                                                                                            r24 = r21;
                                                                                                                                            var_6F0 = 0x0;
                                                                                                                                            var_73C = 0x1;
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            r25 = r24;
                                                                                                                                            r24 = r21;
                                                                                                                                            NSLog(@"Failed to write %@: %@", 0xffffffff, r2);
                                                                                                                                    }
                                                                                                                                    r27 = var_720;
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    r24 = r21;
                                                                                                                                    NSLog(@"Failed to serialize %@: %@", 0xffffffff, r2);
                                                                                                                                    r25 = r22;
                                                                                                                            }
                                                                                                                            [r23 release];
                                                                                                                            if ((var_740 & 0x1) == 0x0) {
                                                                                                                                    r21 = r28;
                                                                                                                                    r23 = var_6F8;
                                                                                                                                    if ([r28 compare:r23] != 0x0) {
                                                                                                                                            r0 = [r19 URLByDeletingLastPathComponent];
                                                                                                                                            r0 = [r0 retain];
                                                                                                                                            r22 = r0;
                                                                                                                                            r0 = [r0 URLByAppendingPathComponent:r23];
                                                                                                                                            r0 = [r0 retain];
                                                                                                                                            r23 = r0;
                                                                                                                                            r28 = [[r0 URLByAppendingPathExtension:@"app"] retain];
                                                                                                                                            [r23 release];
                                                                                                                                            [r22 release];
                                                                                                                                            var_73C = [var_750 moveItemAtURL:r19 toURL:r28 error:0x0] | var_73C;
                                                                                                                                            r27 = var_720;
                                                                                                                                            [r28 release];
                                                                                                                                    }
                                                                                                                                    r28 = r21;
                                                                                                                                    [r28 release];
                                                                                                                                    [r26 release];
                                                                                                                                    [r25 release];
                                                                                                                                    [var_6E8 release];
                                                                                                                                    [r24 release];
                                                                                                                                    r20 = r20 + 0x1;
                                                                                                                                    if (var_700 != r20) {
                                                                                                                                            continue;
                                                                                                                                    }
                                                                                                                                    break;
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    [r28 release];
                                                                                                                                    [r26 release];
                                                                                                                                    [r25 release];
                                                                                                                                    [var_6E8 release];
                                                                                                                                    [r24 release];
                                                                                                                                    r20 = r20 + 0x1;
                                                                                                                                    if (var_700 != r20) {
                                                                                                                                            continue;
                                                                                                                                    }
                                                                                                                                    break;
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r24 = r21;
                                                                                                                    if ((r22 & 0x1) != 0x0) {
                                                                                                                            [r28 release];
                                                                                                                            [r26 release];
                                                                                                                            [r25 release];
                                                                                                                            [var_6E8 release];
                                                                                                                            [r24 release];
                                                                                                                            r20 = r20 + 0x1;
                                                                                                                            if (var_700 != r20) {
                                                                                                                                    continue;
                                                                                                                            }
                                                                                                                            break;
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            r21 = r28;
                                                                                                                            r23 = var_6F8;
                                                                                                                            if ([r28 compare:r23] != 0x0) {
                                                                                                                                    r0 = [r19 URLByDeletingLastPathComponent];
                                                                                                                                    r0 = [r0 retain];
                                                                                                                                    r22 = r0;
                                                                                                                                    r0 = [r0 URLByAppendingPathComponent:r23];
                                                                                                                                    r0 = [r0 retain];
                                                                                                                                    r23 = r0;
                                                                                                                                    r28 = [[r0 URLByAppendingPathExtension:@"app"] retain];
                                                                                                                                    [r23 release];
                                                                                                                                    [r22 release];
                                                                                                                                    var_73C = [var_750 moveItemAtURL:r19 toURL:r28 error:0x0] | var_73C;
                                                                                                                                    r27 = var_720;
                                                                                                                                    [r28 release];
                                                                                                                            }
                                                                                                                            r28 = r21;
                                                                                                                            [r28 release];
                                                                                                                            [r26 release];
                                                                                                                            [r25 release];
                                                                                                                            [var_6E8 release];
                                                                                                                            [r24 release];
                                                                                                                            r20 = r20 + 0x1;
                                                                                                                            if (var_700 != r20) {
                                                                                                                                    continue;
                                                                                                                            }
                                                                                                                            break;
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                    r3 = &decomp_var_3b0;
                                                                                    r0 = [var_728 countByEnumeratingWithState:&var_640 objects:r3 count:0x10];
                                                                                    var_700 = r0;
                                                                            } while (r0 != 0x0);
                                                                    }
                                                                    r4 = 0x10;
                                                                    [var_728 release];
                                                                    r24 = var_738;
                                                                    r23 = var_73C;
                                                                    if ((var_6F0 & 0x1) != 0x0) {
                                                                            r19 = [[var_808 path] retain];
                                                                            r4 = var_730;
                                                                            [r24 exportProgram:var_6F8 bundleName:0x0 withDictionary:r4 toFolder:r19];
                                                                            [r19 release];
                                                                            r0 = [var_808 path];
                                                                            r0 = [r0 retain];
                                                                            r19 = r0;
                                                                            r0 = [r0 stringByAppendingPathComponent:var_6F8];
                                                                            r0 = [r0 retain];
                                                                            r20 = r0;
                                                                            r21 = [[r0 stringByAppendingPathExtension:@"app"] retain];
                                                                            [r20 release];
                                                                            [r19 release];
                                                                            r23 = 0x1;
                                                                            r3 = 0x1;
                                                                            r19 = [[NSURL fileURLWithPath:r21 isDirectory:0x1] retain];
                                                                            [var_7D8 removeObject:r19];
                                                                            [r19 release];
                                                                            [r21 release];
                                                                    }
                                                                    [var_6F8 release];
                                                                    [var_730 release];
                                                                    r25 = var_7F0;
                                                                    r21 = var_7A8;
                                                                    r20 = decomp_var_7a0;
                                                                    r0 = var_768;
                                                                    r19 = var_760;
                                                            }
                                                            else {
                                                                    if (r0 != 0x0) {
                                                                            [var_820 addObject:var_808];
                                                                            r0 = var_768;
                                                                    }
                                                                    r19 = var_760;
                                                            }
                                                            [r0 release];
                                                            [var_770 release];
                                                            [var_758 release];
                                                            [r27 release];
                                                            [r19 release];
                                                            [r21 release];
                                                            [r20 release];
                                                            [var_798 release];
                                                            [var_790 release];
                                                            [var_788 release];
                                                            [var_780 release];
                                                            r10 = var_778 + 0x1;
                                                    } while (r10 != var_7B0);
                                                    r3 = &decomp_var_2f0;
                                                    r4 = 0x10;
                                                    r0 = [var_810 countByEnumeratingWithState:&var_600 objects:r3 count:0x10];
                                                    var_7B0 = r0;
                                            } while (r0 != 0x0);
                                    }
                                    [var_810 release];
                                    [var_810 release];
                                    [var_7C0 release];
                                    [var_7B8 release];
                                    [var_808 release];
                                    [var_7E0 release];
                                    objc_autoreleasePoolPop(var_848);
                                    r10 = var_840 + 0x1;
                            } while (r10 != var_850);
                            r0 = [var_878 countByEnumeratingWithState:&var_5C0 objects:&decomp_var_268 count:0x10];
                            var_850 = r0;
                    } while (r0 != 0x0);
            }
            else {
                    r24 = var_738;
            }
            r26 = r23;
            [var_878 release];
            r25 = var_890;
            if ([var_7D8 count] != 0x0) {
                    var_6A0 = q0;
                    var_690 = q0;
                    r0 = [var_7D8 retain];
                    r19 = r0;
                    r0 = [r0 countByEnumeratingWithState:&var_6A0 objects:&decomp_var_430 count:0x10];
                    if (r0 != 0x0) {
                            r20 = r0;
                            r22 = *var_690;
                            do {
                                    r23 = 0x0;
                                    do {
                                            if (*var_690 != r22) {
                                                    objc_enumerationMutation(r19);
                                            }
                                            r21 = *(var_698 + r23 * 0x8);
                                            if ([var_750 removeItemAtURL:r21 error:0x0] != 0x0) {
                                                    r21 = [[r21 URLByDeletingLastPathComponent] retain];
                                                    [var_820 addObject:r21];
                                                    [r21 release];
                                            }
                                            r23 = r23 + 0x1;
                                    } while (r20 != r23);
                                    r0 = [r19 countByEnumeratingWithState:&var_6A0 objects:&decomp_var_430 count:0x10];
                                    r20 = r0;
                            } while (r0 != 0x0);
                    }
                    [r19 release];
                    r26 = 0x1;
            }
            var_6E0 = q0;
            var_6D0 = q0;
            r0 = [var_820 retain];
            r19 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_6E0 objects:&decomp_var_4b0 count:0x10];
            if (r0 != 0x0) {
                    r20 = r0;
                    r22 = *var_6D0;
                    do {
                            r23 = 0x0;
                            do {
                                    if (*var_6D0 != r22) {
                                            objc_enumerationMutation(r19);
                                    }
                                    r21 = [[*(var_6D8 + r23 * 0x8) path] retain];
                                    [var_750 removeFolderIfEmpty:r21 upTo:var_838];
                                    [r21 release];
                                    r23 = r23 + 0x1;
                            } while (r20 != r23);
                            r0 = [r19 countByEnumeratingWithState:&var_6E0 objects:&decomp_var_4b0 count:0x10];
                            r20 = r0;
                    } while (r0 != 0x0);
            }
            [r19 release];
            objc_unsafeClaimAutoreleasedReturnValue([objc_opt_class(r24) getProgramsFolder]);
            [var_878 release];
            [r19 release];
            [r25 release];
            [var_838 release];
            [var_750 release];
            [var_7D8 release];
            [var_7C8 release];
            [var_870 release];
            [var_7E8 release];
            [var_830 release];
            [var_828 release];
            [var_860 release];
            [var_858 release];
            r0 = objc_autoreleasePoolPop(var_888);
            *(int8_t *)(r24 + var_880) = 0x0;
    }
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = r26 & 0x1;
    return r0;


// 0x10004c424
// -[CXServerCrossOver shortenedBundleID:]
    r31 = r31 - 0xa0;
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
    r0 = [arg2 retain];
    r20 = r0;
    r0 = [r0 componentsSeparatedByString:@"."];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 count] >= 0x5) {
            r0 = [r19 objectAtIndex:0x3];
            r0 = [r0 retain];
            r21 = r0;
            var_60 = r0;
            r3 = [r19 count] - 0x4;
            r0 = [r19 subarrayWithRange:0x4];
            r0 = [r0 retain];
            var_58 = r0;
            r23 = [[r0 componentsJoinedByString:@"."] retain];
            r24 = [[r19 objectAtIndex:0x0] retain];
            r25 = [[r19 objectAtIndex:0x1] retain];
            r28 = [[r19 objectAtIndex:0x2] retain];
            r26 = [[r21 MD5] retain];
            r21 = [[r23 MD5] retain];
            r0 = [NSArray arrayWithObjects:r24];
            r0 = [r0 retain];
            r27 = r0;
            r22 = [[r0 componentsJoinedByString:@"."] retain];
            [r20 release];
            [r27 release];
            [r21 release];
            [r26 release];
            [r28 release];
            [r25 release];
            [r24 release];
            [r23 release];
            [var_58 release];
            [var_60 release];
            r20 = r22;
    }
    if ([r20 length] >= 0x71) {
            r21 = [[r20 substringToIndex:0x38] retain];
            r22 = [[r20 substringFromIndex:[r20 length] - 0x37] retain];
            r23 = [[NSString stringWithFormat:@"%@-%@", r3, r4] retain];
            [r20 release];
            [r22 release];
            [r21 release];
            r20 = r23;
    }
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10004c688
// -[CXServerCrossOver createProgramsMenuFromSubmenu:hasPrograms:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg3;
    r19 = self;
    r20 = [arg2 retain];
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 bottleList];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [r0 count];
    [r23 release];
    [r22 release];
    if (r24 != 0x0) {
            if (r21 != 0x0) {
                    r21 = [[NSMenuItem separatorItem] retain];
                    [r20 addItem:r21];
                    [r21 release];
            }
            r21 = [NSMenuItem alloc];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r24 = [[r0 localizedStringForKey:@"Run Command…" value:@"" table:0x0] retain];
            r21 = [r21 initWithTitle:r24 action:@selector(runCommand:) keyEquivalent:@""];
            [r24 release];
            [r22 release];
    }
    else {
            r21 = [NSMenuItem alloc];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r24 = [[r0 localizedStringForKey:@"No Software is Installed" value:@"" table:0x0] retain];
            r21 = [r21 initWithTitle:r24 action:0x0 keyEquivalent:@""];
            [r24 release];
            [r22 release];
            [r21 setEnabled:0x0];
    }
    [r20 addItem:r21];
    [r21 release];
    [r19 setProgramsMenu:r20];
    [r20 release];
    return;


// 0x10004c860
// -[CXServerCrossOver createProgramsMenu:]
    var_40 = r26;
    decomp_var_38 = r25;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [arg2 retain];
    r20 = [[NSMenu alloc] initWithTitle:@""];
    r22 = [[objc_opt_class(r21) getProgramsFolder] retain];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r23 = r0;
    if ([r0 fileExistsAtPath:r22] != 0x0) {
            r25 = [[r22 stringByResolvingSymlink] retain];
            r24 = [[r23 attributesOfItemAtPath:r25 error:0x0] retain];
            [r25 release];
            if (r24 != 0x0) {
                    r0 = [r24 fileModificationDate];
                    r0 = [r0 retain];
                    r25 = r0;
                    if (([r0 isEqualToDate:r21->programsMenuUpdateDate] & 0x1) != 0x0) {
                            r26 = [r19 boolValue];
                            [r25 release];
                            if (r26 == 0x0) {
                                    [r24 release];
                                    [r23 release];
                                    [r22 release];
                                    [r20 release];
                                    [r19 release];
                            }
                            else {
                                    r0 = [r24 fileModificationDate];
                                    r0 = [r0 retain];
                                    r9 = sign_extend_64(*(int32_t *)ivar_offset(programsMenuUpdateDate));
                                    r8 = *(r21 + r9);
                                    *(r21 + r9) = r0;
                                    [r8 release];
                                    r25 = [[LauncherFolder alloc] initWithName:0x0];
                                    [r21 addLaunchersInDir:r22 toFolder:r25];
                                    r26 = [[r25 items] retain];
                                    r3 = r20;
                                    [r21 addLauncherItems:r26 toMenu:r3];
                                    [r26 release];
                                    r26 = [[r25 items] retain];
                                    [r21 setLaunchers:r26];
                                    [r26 release];
                                    [r25 release];
                                    [r24 release];
                                    if ([r20 numberOfItems] > 0x0) {
                                            r3 = 0x1;
                                    }
                                    [r21 createProgramsMenuFromSubmenu:r20 hasPrograms:r3];
                                    [r23 release];
                                    [r22 release];
                                    [r20 release];
                                    [r19 release];
                            }
                    }
                    else {
                            [r25 release];
                            r0 = [r24 fileModificationDate];
                            r0 = [r0 retain];
                            r9 = sign_extend_64(*(int32_t *)ivar_offset(programsMenuUpdateDate));
                            r8 = *(r21 + r9);
                            *(r21 + r9) = r0;
                            [r8 release];
                            r25 = [[LauncherFolder alloc] initWithName:0x0];
                            [r21 addLaunchersInDir:r22 toFolder:r25];
                            r26 = [[r25 items] retain];
                            r3 = r20;
                            [r21 addLauncherItems:r26 toMenu:r3];
                            [r26 release];
                            r26 = [[r25 items] retain];
                            [r21 setLaunchers:r26];
                            [r26 release];
                            [r25 release];
                            [r24 release];
                            if ([r20 numberOfItems] > 0x0) {
                                    r3 = 0x1;
                            }
                            [r21 createProgramsMenuFromSubmenu:r20 hasPrograms:r3];
                            [r23 release];
                            [r22 release];
                            [r20 release];
                            [r19 release];
                    }
            }
            else {
                    r0 = [r24 fileModificationDate];
                    r0 = [r0 retain];
                    r9 = sign_extend_64(*(int32_t *)ivar_offset(programsMenuUpdateDate));
                    r8 = *(r21 + r9);
                    *(r21 + r9) = r0;
                    [r8 release];
                    r25 = [[LauncherFolder alloc] initWithName:0x0];
                    [r21 addLaunchersInDir:r22 toFolder:r25];
                    r26 = [[r25 items] retain];
                    r3 = r20;
                    [r21 addLauncherItems:r26 toMenu:r3];
                    [r26 release];
                    r26 = [[r25 items] retain];
                    [r21 setLaunchers:r26];
                    [r26 release];
                    [r25 release];
                    [r24 release];
                    if ([r20 numberOfItems] > 0x0) {
                            r3 = 0x1;
                    }
                    [r21 createProgramsMenuFromSubmenu:r20 hasPrograms:r3];
                    [r23 release];
                    [r22 release];
                    [r20 release];
                    [r19 release];
            }
    }
    else {
            r0 = [NSDate distantPast];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(programsMenuUpdateDate));
            r8 = *(r21 + r9);
            *(r21 + r9) = r0;
            [r8 release];
            [r21 setLaunchers:**___NSArray0__];
            if ([r20 numberOfItems] > 0x0) {
                    r3 = 0x1;
            }
            [r21 createProgramsMenuFromSubmenu:r20 hasPrograms:r3];
            [r23 release];
            [r22 release];
            [r20 release];
            [r19 release];
    }
    return;


// 0x10004cab8
// -[CXServerCrossOver addLaunchersInDir:toFolder:skippingFiles:]
    r31 = r31 - 0x1c0;
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
    var_1A0 = self;
    var_60 = **___stack_chk_guard;
    r24 = [arg2 retain];
    var_198 = [arg3 retain];
    r26 = [arg4 retain];
    var_140 = q0;
    var_130 = q0;
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 contentsOfDirectoryAtPath:r24 error:0x0] retain];
    [r19 release];
    var_188 = r20;
    r0 = [r20 countByEnumeratingWithState:&var_140 objects:&decomp_var_e0 count:0x10];
    var_170 = r0;
    if (r0 != 0x0) {
            var_178 = *var_130;
            var_160 = **_NSURLFileResourceIdentifierKey;
            var_150 = **_NSURLIsSymbolicLinkKey;
            var_158 = **_NSURLIsDirectoryKey;
            var_168 = **_NSURLIsPackageKey;
            var_190 = r24;
            var_180 = r26;
            do {
                    r21 = 0x0;
                    while (true) {
                            if (*var_130 != var_178) {
                                    objc_enumerationMutation(var_188);
                            }
                            r19 = *(var_138 + r21 * 0x8);
                            r27 = objc_autoreleasePoolPush();
                            r20 = [[r24 stringByAppendingPathComponent:r19] retain];
                            r23 = [[NSURL fileURLWithPath:r20] retain];
                            var_100 = var_160;
                            r0 = [NSArray arrayWithObjects:&var_100 count:0x4];
                            r19 = [r0 retain];
                            r0 = [r23 resourceValuesForKeys:r19 error:0x0];
                            r0 = [r0 retain];
                            r25 = r0;
                            r0 = [r0 objectForKey:var_160];
                            r0 = [r0 retain];
                            r28 = r0;
                            var_148 = r27;
                            if (r0 != 0x0) {
                                    if (([r26 containsObject:r28] & 0x1) != 0x0) {
                                            r22 = r28;
                                            r27 = r25;
                                            [r22 release];
                                            [r27 release];
                                            [r19 release];
                                            [r23 release];
                                            [r20 release];
                                            objc_autoreleasePoolPop(var_148);
                                            r21 = r21 + 0x1;
                                            if (var_170 != r21) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    else {
                                            [r26 addObject:r28];
                                            r0 = [r25 objectForKey:var_150];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            r26 = [r0 boolValue];
                                            [r22 release];
                                            if (r26 != 0x0) {
                                                    r0 = [r23 URLByResolvingSymlinksInPath];
                                                    r0 = [r0 retain];
                                                    r22 = r0;
                                                    r27 = [[r0 resourceValuesForKeys:r19 error:0x0] retain];
                                                    [r25 release];
                                                    [r22 release];
                                                    r22 = [[r27 objectForKey:var_160] retain];
                                                    [r28 release];
                                                    if (r22 != 0x0) {
                                                            r26 = var_180;
                                                            if (([r26 containsObject:r22] & 0x1) == 0x0) {
                                                                    [r26 addObject:r22];
                                                                    r0 = [r27 objectForKey:var_158];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    r26 = [r0 boolValue];
                                                                    [r25 release];
                                                                    if (r26 != 0x0) {
                                                                            r0 = [r27 objectForKey:var_168];
                                                                            r0 = [r0 retain];
                                                                            r25 = r0;
                                                                            r26 = [r0 boolValue];
                                                                            [r25 release];
                                                                            if (r26 != 0x0) {
                                                                                    r0 = [CXBundle bundleWithURL:r23];
                                                                                    r0 = [r0 retain];
                                                                                    r28 = r0;
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"];
                                                                                            r0 = [r0 retain];
                                                                                            r25 = r0;
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
                                                                                                    r0 = [r0 retain];
                                                                                                    if (r0 != 0x0) {
                                                                                                            var_1A8 = r0;
                                                                                                            [r0 release];
                                                                                                            [r25 release];
                                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                            [r28 release];
                                                                                                            [var_198 addLauncherItem:r25];
                                                                                                            r28 = r25;
                                                                                                            [r28 release];
                                                                                                            r24 = var_190;
                                                                                                            r26 = var_180;
                                                                                                            [r22 release];
                                                                                                            [r27 release];
                                                                                                            [r19 release];
                                                                                                            [r23 release];
                                                                                                            [r20 release];
                                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                                            r21 = r21 + 0x1;
                                                                                                            if (var_170 != r21) {
                                                                                                                    continue;
                                                                                                            }
                                                                                                            break;
                                                                                                    }
                                                                                                    else {
                                                                                                            var_1A8 = 0x0;
                                                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                                            r0 = [r0 retain];
                                                                                                            r26 = r0;
                                                                                                            [r0 release];
                                                                                                            if (r25 != 0x0) {
                                                                                                                    [var_1A8 release];
                                                                                                                    [r25 release];
                                                                                                            }
                                                                                                            if (r26 != 0x0) {
                                                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                                    [r28 release];
                                                                                                                    [var_198 addLauncherItem:r25];
                                                                                                                    r28 = r25;
                                                                                                            }
                                                                                                            [r28 release];
                                                                                                            r24 = var_190;
                                                                                                            r26 = var_180;
                                                                                                            [r22 release];
                                                                                                            [r27 release];
                                                                                                            [r19 release];
                                                                                                            [r23 release];
                                                                                                            [r20 release];
                                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                                            r21 = r21 + 0x1;
                                                                                                            if (var_170 != r21) {
                                                                                                                    continue;
                                                                                                            }
                                                                                                            break;
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                                    r0 = [r0 retain];
                                                                                                    r26 = r0;
                                                                                                    [r0 release];
                                                                                                    if (r25 != 0x0) {
                                                                                                            [var_1A8 release];
                                                                                                            [r25 release];
                                                                                                    }
                                                                                                    if (r26 != 0x0) {
                                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                            [r28 release];
                                                                                                            [var_198 addLauncherItem:r25];
                                                                                                            r28 = r25;
                                                                                                    }
                                                                                                    [r28 release];
                                                                                                    r24 = var_190;
                                                                                                    r26 = var_180;
                                                                                                    [r22 release];
                                                                                                    [r27 release];
                                                                                                    [r19 release];
                                                                                                    [r23 release];
                                                                                                    [r20 release];
                                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                                    r21 = r21 + 0x1;
                                                                                                    if (var_170 != r21) {
                                                                                                            continue;
                                                                                                    }
                                                                                                    break;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            [r28 release];
                                                                                            r24 = var_190;
                                                                                            r26 = var_180;
                                                                                            [r22 release];
                                                                                            [r27 release];
                                                                                            [r19 release];
                                                                                            [r23 release];
                                                                                            [r20 release];
                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                            r21 = r21 + 0x1;
                                                                                            if (var_170 != r21) {
                                                                                                    continue;
                                                                                            }
                                                                                            break;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r25 = [[LauncherDiskFolder launcherWithFolderURL:r23] retain];
                                                                                    [var_1A0 addLaunchersInDir:r20 toFolder:r25 skippingFiles:var_180];
                                                                                    r0 = [r25 items];
                                                                                    r0 = [r0 retain];
                                                                                    r26 = r0;
                                                                                    r24 = [r0 count];
                                                                                    [r26 release];
                                                                                    r28 = r25;
                                                                                    if (r24 != 0x0) {
                                                                                            [var_198 addLauncherItem:r25];
                                                                                            r28 = r25;
                                                                                    }
                                                                                    [r28 release];
                                                                                    r24 = var_190;
                                                                                    r26 = var_180;
                                                                                    [r22 release];
                                                                                    [r27 release];
                                                                                    [r19 release];
                                                                                    [r23 release];
                                                                                    [r20 release];
                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                    r21 = r21 + 0x1;
                                                                                    if (var_170 != r21) {
                                                                                            continue;
                                                                                    }
                                                                                    break;
                                                                            }
                                                                    }
                                                                    else {
                                                                            r26 = var_180;
                                                                            [r22 release];
                                                                            [r27 release];
                                                                            [r19 release];
                                                                            [r23 release];
                                                                            [r20 release];
                                                                            objc_autoreleasePoolPop(var_148);
                                                                            r21 = r21 + 0x1;
                                                                            if (var_170 != r21) {
                                                                                    continue;
                                                                            }
                                                                            break;
                                                                    }
                                                            }
                                                            else {
                                                                    [r22 release];
                                                                    [r27 release];
                                                                    [r19 release];
                                                                    [r23 release];
                                                                    [r20 release];
                                                                    objc_autoreleasePoolPop(var_148);
                                                                    r21 = r21 + 0x1;
                                                                    if (var_170 != r21) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            r0 = [r27 objectForKey:var_158];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [r0 boolValue];
                                                            [r25 release];
                                                            if (r26 != 0x0) {
                                                                    r0 = [r27 objectForKey:var_168];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    r26 = [r0 boolValue];
                                                                    [r25 release];
                                                                    if (r26 != 0x0) {
                                                                            r0 = [CXBundle bundleWithURL:r23];
                                                                            r0 = [r0 retain];
                                                                            r28 = r0;
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"];
                                                                                    r0 = [r0 retain];
                                                                                    r25 = r0;
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
                                                                                            r0 = [r0 retain];
                                                                                            if (r0 != 0x0) {
                                                                                                    var_1A8 = r0;
                                                                                                    [r0 release];
                                                                                                    [r25 release];
                                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                    [r28 release];
                                                                                                    [var_198 addLauncherItem:r25];
                                                                                                    r28 = r25;
                                                                                                    [r28 release];
                                                                                                    r24 = var_190;
                                                                                                    r26 = var_180;
                                                                                                    [r22 release];
                                                                                                    [r27 release];
                                                                                                    [r19 release];
                                                                                                    [r23 release];
                                                                                                    [r20 release];
                                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                                    r21 = r21 + 0x1;
                                                                                                    if (var_170 != r21) {
                                                                                                            continue;
                                                                                                    }
                                                                                                    break;
                                                                                            }
                                                                                            else {
                                                                                                    var_1A8 = 0x0;
                                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                                    r0 = [r0 retain];
                                                                                                    r26 = r0;
                                                                                                    [r0 release];
                                                                                                    if (r25 != 0x0) {
                                                                                                            [var_1A8 release];
                                                                                                            [r25 release];
                                                                                                    }
                                                                                                    if (r26 != 0x0) {
                                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                            [r28 release];
                                                                                                            [var_198 addLauncherItem:r25];
                                                                                                            r28 = r25;
                                                                                                    }
                                                                                                    [r28 release];
                                                                                                    r24 = var_190;
                                                                                                    r26 = var_180;
                                                                                                    [r22 release];
                                                                                                    [r27 release];
                                                                                                    [r19 release];
                                                                                                    [r23 release];
                                                                                                    [r20 release];
                                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                                    r21 = r21 + 0x1;
                                                                                                    if (var_170 != r21) {
                                                                                                            continue;
                                                                                                    }
                                                                                                    break;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                            r0 = [r0 retain];
                                                                                            r26 = r0;
                                                                                            [r0 release];
                                                                                            if (r25 != 0x0) {
                                                                                                    [var_1A8 release];
                                                                                                    [r25 release];
                                                                                            }
                                                                                            if (r26 != 0x0) {
                                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                    [r28 release];
                                                                                                    [var_198 addLauncherItem:r25];
                                                                                                    r28 = r25;
                                                                                            }
                                                                                            [r28 release];
                                                                                            r24 = var_190;
                                                                                            r26 = var_180;
                                                                                            [r22 release];
                                                                                            [r27 release];
                                                                                            [r19 release];
                                                                                            [r23 release];
                                                                                            [r20 release];
                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                            r21 = r21 + 0x1;
                                                                                            if (var_170 != r21) {
                                                                                                    continue;
                                                                                            }
                                                                                            break;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    [r28 release];
                                                                                    r24 = var_190;
                                                                                    r26 = var_180;
                                                                                    [r22 release];
                                                                                    [r27 release];
                                                                                    [r19 release];
                                                                                    [r23 release];
                                                                                    [r20 release];
                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                    r21 = r21 + 0x1;
                                                                                    if (var_170 != r21) {
                                                                                            continue;
                                                                                    }
                                                                                    break;
                                                                            }
                                                                    }
                                                                    else {
                                                                            r25 = [[LauncherDiskFolder launcherWithFolderURL:r23] retain];
                                                                            [var_1A0 addLaunchersInDir:r20 toFolder:r25 skippingFiles:var_180];
                                                                            r0 = [r25 items];
                                                                            r0 = [r0 retain];
                                                                            r26 = r0;
                                                                            r24 = [r0 count];
                                                                            [r26 release];
                                                                            r28 = r25;
                                                                            if (r24 != 0x0) {
                                                                                    [var_198 addLauncherItem:r25];
                                                                                    r28 = r25;
                                                                            }
                                                                            [r28 release];
                                                                            r24 = var_190;
                                                                            r26 = var_180;
                                                                            [r22 release];
                                                                            [r27 release];
                                                                            [r19 release];
                                                                            [r23 release];
                                                                            [r20 release];
                                                                            objc_autoreleasePoolPop(var_148);
                                                                            r21 = r21 + 0x1;
                                                                            if (var_170 != r21) {
                                                                                    continue;
                                                                            }
                                                                            break;
                                                                    }
                                                            }
                                                            else {
                                                                    r26 = var_180;
                                                                    [r22 release];
                                                                    [r27 release];
                                                                    [r19 release];
                                                                    [r23 release];
                                                                    [r20 release];
                                                                    objc_autoreleasePoolPop(var_148);
                                                                    r21 = r21 + 0x1;
                                                                    if (var_170 != r21) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                    }
                                            }
                                            else {
                                                    r22 = r28;
                                                    r27 = r25;
                                                    r0 = [r27 objectForKey:var_158];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [r0 boolValue];
                                                    [r25 release];
                                                    if (r26 != 0x0) {
                                                            r0 = [r27 objectForKey:var_168];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [r0 boolValue];
                                                            [r25 release];
                                                            if (r26 != 0x0) {
                                                                    r0 = [CXBundle bundleWithURL:r23];
                                                                    r0 = [r0 retain];
                                                                    r28 = r0;
                                                                    if (r0 != 0x0) {
                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"];
                                                                            r0 = [r0 retain];
                                                                            r25 = r0;
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
                                                                                    r0 = [r0 retain];
                                                                                    if (r0 != 0x0) {
                                                                                            var_1A8 = r0;
                                                                                            [r0 release];
                                                                                            [r25 release];
                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                            [r28 release];
                                                                                            [var_198 addLauncherItem:r25];
                                                                                            r28 = r25;
                                                                                            [r28 release];
                                                                                            r24 = var_190;
                                                                                            r26 = var_180;
                                                                                            [r22 release];
                                                                                            [r27 release];
                                                                                            [r19 release];
                                                                                            [r23 release];
                                                                                            [r20 release];
                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                            r21 = r21 + 0x1;
                                                                                            if (var_170 != r21) {
                                                                                                    continue;
                                                                                            }
                                                                                            break;
                                                                                    }
                                                                                    else {
                                                                                            var_1A8 = 0x0;
                                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                            r0 = [r0 retain];
                                                                                            r26 = r0;
                                                                                            [r0 release];
                                                                                            if (r25 != 0x0) {
                                                                                                    [var_1A8 release];
                                                                                                    [r25 release];
                                                                                            }
                                                                                            if (r26 != 0x0) {
                                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                    [r28 release];
                                                                                                    [var_198 addLauncherItem:r25];
                                                                                                    r28 = r25;
                                                                                            }
                                                                                            [r28 release];
                                                                                            r24 = var_190;
                                                                                            r26 = var_180;
                                                                                            [r22 release];
                                                                                            [r27 release];
                                                                                            [r19 release];
                                                                                            [r23 release];
                                                                                            [r20 release];
                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                            r21 = r21 + 0x1;
                                                                                            if (var_170 != r21) {
                                                                                                    continue;
                                                                                            }
                                                                                            break;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                    r0 = [r0 retain];
                                                                                    r26 = r0;
                                                                                    [r0 release];
                                                                                    if (r25 != 0x0) {
                                                                                            [var_1A8 release];
                                                                                            [r25 release];
                                                                                    }
                                                                                    if (r26 != 0x0) {
                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                            [r28 release];
                                                                                            [var_198 addLauncherItem:r25];
                                                                                            r28 = r25;
                                                                                    }
                                                                                    [r28 release];
                                                                                    r24 = var_190;
                                                                                    r26 = var_180;
                                                                                    [r22 release];
                                                                                    [r27 release];
                                                                                    [r19 release];
                                                                                    [r23 release];
                                                                                    [r20 release];
                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                    r21 = r21 + 0x1;
                                                                                    if (var_170 != r21) {
                                                                                            continue;
                                                                                    }
                                                                                    break;
                                                                            }
                                                                    }
                                                                    else {
                                                                            [r28 release];
                                                                            r24 = var_190;
                                                                            r26 = var_180;
                                                                            [r22 release];
                                                                            [r27 release];
                                                                            [r19 release];
                                                                            [r23 release];
                                                                            [r20 release];
                                                                            objc_autoreleasePoolPop(var_148);
                                                                            r21 = r21 + 0x1;
                                                                            if (var_170 != r21) {
                                                                                    continue;
                                                                            }
                                                                            break;
                                                                    }
                                                            }
                                                            else {
                                                                    r25 = [[LauncherDiskFolder launcherWithFolderURL:r23] retain];
                                                                    [var_1A0 addLaunchersInDir:r20 toFolder:r25 skippingFiles:var_180];
                                                                    r0 = [r25 items];
                                                                    r0 = [r0 retain];
                                                                    r26 = r0;
                                                                    r24 = [r0 count];
                                                                    [r26 release];
                                                                    r28 = r25;
                                                                    if (r24 != 0x0) {
                                                                            [var_198 addLauncherItem:r25];
                                                                            r28 = r25;
                                                                    }
                                                                    [r28 release];
                                                                    r24 = var_190;
                                                                    r26 = var_180;
                                                                    [r22 release];
                                                                    [r27 release];
                                                                    [r19 release];
                                                                    [r23 release];
                                                                    [r20 release];
                                                                    objc_autoreleasePoolPop(var_148);
                                                                    r21 = r21 + 0x1;
                                                                    if (var_170 != r21) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            r26 = var_180;
                                                            [r22 release];
                                                            [r27 release];
                                                            [r19 release];
                                                            [r23 release];
                                                            [r20 release];
                                                            objc_autoreleasePoolPop(var_148);
                                                            r21 = r21 + 0x1;
                                                            if (var_170 != r21) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                    }
                            }
                            else {
                                    r0 = [r25 objectForKey:var_150];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    r26 = [r0 boolValue];
                                    [r22 release];
                                    if (r26 != 0x0) {
                                            r0 = [r23 URLByResolvingSymlinksInPath];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            r27 = [[r0 resourceValuesForKeys:r19 error:0x0] retain];
                                            [r25 release];
                                            [r22 release];
                                            r22 = [[r27 objectForKey:var_160] retain];
                                            [r28 release];
                                            if (r22 != 0x0) {
                                                    r26 = var_180;
                                                    if (([r26 containsObject:r22] & 0x1) == 0x0) {
                                                            [r26 addObject:r22];
                                                            r0 = [r27 objectForKey:var_158];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [r0 boolValue];
                                                            [r25 release];
                                                            if (r26 != 0x0) {
                                                                    r0 = [r27 objectForKey:var_168];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    r26 = [r0 boolValue];
                                                                    [r25 release];
                                                                    if (r26 != 0x0) {
                                                                            r0 = [CXBundle bundleWithURL:r23];
                                                                            r0 = [r0 retain];
                                                                            r28 = r0;
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"];
                                                                                    r0 = [r0 retain];
                                                                                    r25 = r0;
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
                                                                                            r0 = [r0 retain];
                                                                                            if (r0 != 0x0) {
                                                                                                    var_1A8 = r0;
                                                                                                    [r0 release];
                                                                                                    [r25 release];
                                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                    [r28 release];
                                                                                                    [var_198 addLauncherItem:r25];
                                                                                                    r28 = r25;
                                                                                                    [r28 release];
                                                                                                    r24 = var_190;
                                                                                                    r26 = var_180;
                                                                                                    [r22 release];
                                                                                                    [r27 release];
                                                                                                    [r19 release];
                                                                                                    [r23 release];
                                                                                                    [r20 release];
                                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                                    r21 = r21 + 0x1;
                                                                                                    if (var_170 != r21) {
                                                                                                            continue;
                                                                                                    }
                                                                                                    break;
                                                                                            }
                                                                                            else {
                                                                                                    var_1A8 = 0x0;
                                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                                    r0 = [r0 retain];
                                                                                                    r26 = r0;
                                                                                                    [r0 release];
                                                                                                    if (r25 != 0x0) {
                                                                                                            [var_1A8 release];
                                                                                                            [r25 release];
                                                                                                    }
                                                                                                    if (r26 != 0x0) {
                                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                            [r28 release];
                                                                                                            [var_198 addLauncherItem:r25];
                                                                                                            r28 = r25;
                                                                                                    }
                                                                                                    [r28 release];
                                                                                                    r24 = var_190;
                                                                                                    r26 = var_180;
                                                                                                    [r22 release];
                                                                                                    [r27 release];
                                                                                                    [r19 release];
                                                                                                    [r23 release];
                                                                                                    [r20 release];
                                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                                    r21 = r21 + 0x1;
                                                                                                    if (var_170 != r21) {
                                                                                                            continue;
                                                                                                    }
                                                                                                    break;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                            r0 = [r0 retain];
                                                                                            r26 = r0;
                                                                                            [r0 release];
                                                                                            if (r25 != 0x0) {
                                                                                                    [var_1A8 release];
                                                                                                    [r25 release];
                                                                                            }
                                                                                            if (r26 != 0x0) {
                                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                    [r28 release];
                                                                                                    [var_198 addLauncherItem:r25];
                                                                                                    r28 = r25;
                                                                                            }
                                                                                            [r28 release];
                                                                                            r24 = var_190;
                                                                                            r26 = var_180;
                                                                                            [r22 release];
                                                                                            [r27 release];
                                                                                            [r19 release];
                                                                                            [r23 release];
                                                                                            [r20 release];
                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                            r21 = r21 + 0x1;
                                                                                            if (var_170 != r21) {
                                                                                                    continue;
                                                                                            }
                                                                                            break;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    [r28 release];
                                                                                    r24 = var_190;
                                                                                    r26 = var_180;
                                                                                    [r22 release];
                                                                                    [r27 release];
                                                                                    [r19 release];
                                                                                    [r23 release];
                                                                                    [r20 release];
                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                    r21 = r21 + 0x1;
                                                                                    if (var_170 != r21) {
                                                                                            continue;
                                                                                    }
                                                                                    break;
                                                                            }
                                                                    }
                                                                    else {
                                                                            r25 = [[LauncherDiskFolder launcherWithFolderURL:r23] retain];
                                                                            [var_1A0 addLaunchersInDir:r20 toFolder:r25 skippingFiles:var_180];
                                                                            r0 = [r25 items];
                                                                            r0 = [r0 retain];
                                                                            r26 = r0;
                                                                            r24 = [r0 count];
                                                                            [r26 release];
                                                                            r28 = r25;
                                                                            if (r24 != 0x0) {
                                                                                    [var_198 addLauncherItem:r25];
                                                                                    r28 = r25;
                                                                            }
                                                                            [r28 release];
                                                                            r24 = var_190;
                                                                            r26 = var_180;
                                                                            [r22 release];
                                                                            [r27 release];
                                                                            [r19 release];
                                                                            [r23 release];
                                                                            [r20 release];
                                                                            objc_autoreleasePoolPop(var_148);
                                                                            r21 = r21 + 0x1;
                                                                            if (var_170 != r21) {
                                                                                    continue;
                                                                            }
                                                                            break;
                                                                    }
                                                            }
                                                            else {
                                                                    r26 = var_180;
                                                                    [r22 release];
                                                                    [r27 release];
                                                                    [r19 release];
                                                                    [r23 release];
                                                                    [r20 release];
                                                                    objc_autoreleasePoolPop(var_148);
                                                                    r21 = r21 + 0x1;
                                                                    if (var_170 != r21) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            [r22 release];
                                                            [r27 release];
                                                            [r19 release];
                                                            [r23 release];
                                                            [r20 release];
                                                            objc_autoreleasePoolPop(var_148);
                                                            r21 = r21 + 0x1;
                                                            if (var_170 != r21) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                            else {
                                                    r0 = [r27 objectForKey:var_158];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [r0 boolValue];
                                                    [r25 release];
                                                    if (r26 != 0x0) {
                                                            r0 = [r27 objectForKey:var_168];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [r0 boolValue];
                                                            [r25 release];
                                                            if (r26 != 0x0) {
                                                                    r0 = [CXBundle bundleWithURL:r23];
                                                                    r0 = [r0 retain];
                                                                    r28 = r0;
                                                                    if (r0 != 0x0) {
                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"];
                                                                            r0 = [r0 retain];
                                                                            r25 = r0;
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
                                                                                    r0 = [r0 retain];
                                                                                    if (r0 != 0x0) {
                                                                                            var_1A8 = r0;
                                                                                            [r0 release];
                                                                                            [r25 release];
                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                            [r28 release];
                                                                                            [var_198 addLauncherItem:r25];
                                                                                            r28 = r25;
                                                                                            [r28 release];
                                                                                            r24 = var_190;
                                                                                            r26 = var_180;
                                                                                            [r22 release];
                                                                                            [r27 release];
                                                                                            [r19 release];
                                                                                            [r23 release];
                                                                                            [r20 release];
                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                            r21 = r21 + 0x1;
                                                                                            if (var_170 != r21) {
                                                                                                    continue;
                                                                                            }
                                                                                            break;
                                                                                    }
                                                                                    else {
                                                                                            var_1A8 = 0x0;
                                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                            r0 = [r0 retain];
                                                                                            r26 = r0;
                                                                                            [r0 release];
                                                                                            if (r25 != 0x0) {
                                                                                                    [var_1A8 release];
                                                                                                    [r25 release];
                                                                                            }
                                                                                            if (r26 != 0x0) {
                                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                                    [r28 release];
                                                                                                    [var_198 addLauncherItem:r25];
                                                                                                    r28 = r25;
                                                                                            }
                                                                                            [r28 release];
                                                                                            r24 = var_190;
                                                                                            r26 = var_180;
                                                                                            [r22 release];
                                                                                            [r27 release];
                                                                                            [r19 release];
                                                                                            [r23 release];
                                                                                            [r20 release];
                                                                                            objc_autoreleasePoolPop(var_148);
                                                                                            r21 = r21 + 0x1;
                                                                                            if (var_170 != r21) {
                                                                                                    continue;
                                                                                            }
                                                                                            break;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                    r0 = [r0 retain];
                                                                                    r26 = r0;
                                                                                    [r0 release];
                                                                                    if (r25 != 0x0) {
                                                                                            [var_1A8 release];
                                                                                            [r25 release];
                                                                                    }
                                                                                    if (r26 != 0x0) {
                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                            [r28 release];
                                                                                            [var_198 addLauncherItem:r25];
                                                                                            r28 = r25;
                                                                                    }
                                                                                    [r28 release];
                                                                                    r24 = var_190;
                                                                                    r26 = var_180;
                                                                                    [r22 release];
                                                                                    [r27 release];
                                                                                    [r19 release];
                                                                                    [r23 release];
                                                                                    [r20 release];
                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                    r21 = r21 + 0x1;
                                                                                    if (var_170 != r21) {
                                                                                            continue;
                                                                                    }
                                                                                    break;
                                                                            }
                                                                    }
                                                                    else {
                                                                            [r28 release];
                                                                            r24 = var_190;
                                                                            r26 = var_180;
                                                                            [r22 release];
                                                                            [r27 release];
                                                                            [r19 release];
                                                                            [r23 release];
                                                                            [r20 release];
                                                                            objc_autoreleasePoolPop(var_148);
                                                                            r21 = r21 + 0x1;
                                                                            if (var_170 != r21) {
                                                                                    continue;
                                                                            }
                                                                            break;
                                                                    }
                                                            }
                                                            else {
                                                                    r25 = [[LauncherDiskFolder launcherWithFolderURL:r23] retain];
                                                                    [var_1A0 addLaunchersInDir:r20 toFolder:r25 skippingFiles:var_180];
                                                                    r0 = [r25 items];
                                                                    r0 = [r0 retain];
                                                                    r26 = r0;
                                                                    r24 = [r0 count];
                                                                    [r26 release];
                                                                    r28 = r25;
                                                                    if (r24 != 0x0) {
                                                                            [var_198 addLauncherItem:r25];
                                                                            r28 = r25;
                                                                    }
                                                                    [r28 release];
                                                                    r24 = var_190;
                                                                    r26 = var_180;
                                                                    [r22 release];
                                                                    [r27 release];
                                                                    [r19 release];
                                                                    [r23 release];
                                                                    [r20 release];
                                                                    objc_autoreleasePoolPop(var_148);
                                                                    r21 = r21 + 0x1;
                                                                    if (var_170 != r21) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            r26 = var_180;
                                                            [r22 release];
                                                            [r27 release];
                                                            [r19 release];
                                                            [r23 release];
                                                            [r20 release];
                                                            objc_autoreleasePoolPop(var_148);
                                                            r21 = r21 + 0x1;
                                                            if (var_170 != r21) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                    }
                                    else {
                                            r22 = r28;
                                            r27 = r25;
                                            r0 = [r27 objectForKey:var_158];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [r0 boolValue];
                                            [r25 release];
                                            if (r26 != 0x0) {
                                                    r0 = [r27 objectForKey:var_168];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [r0 boolValue];
                                                    [r25 release];
                                                    if (r26 != 0x0) {
                                                            r0 = [CXBundle bundleWithURL:r23];
                                                            r0 = [r0 retain];
                                                            r28 = r0;
                                                            if (r0 != 0x0) {
                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    if (r0 != 0x0) {
                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
                                                                            r0 = [r0 retain];
                                                                            if (r0 != 0x0) {
                                                                                    var_1A8 = r0;
                                                                                    [r0 release];
                                                                                    [r25 release];
                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                    [r28 release];
                                                                                    [var_198 addLauncherItem:r25];
                                                                                    r28 = r25;
                                                                                    [r28 release];
                                                                                    r24 = var_190;
                                                                                    r26 = var_180;
                                                                                    [r22 release];
                                                                                    [r27 release];
                                                                                    [r19 release];
                                                                                    [r23 release];
                                                                                    [r20 release];
                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                    r21 = r21 + 0x1;
                                                                                    if (var_170 != r21) {
                                                                                            continue;
                                                                                    }
                                                                                    break;
                                                                            }
                                                                            else {
                                                                                    var_1A8 = 0x0;
                                                                                    r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                                    r0 = [r0 retain];
                                                                                    r26 = r0;
                                                                                    [r0 release];
                                                                                    if (r25 != 0x0) {
                                                                                            [var_1A8 release];
                                                                                            [r25 release];
                                                                                    }
                                                                                    if (r26 != 0x0) {
                                                                                            r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                            [r28 release];
                                                                                            [var_198 addLauncherItem:r25];
                                                                                            r28 = r25;
                                                                                    }
                                                                                    [r28 release];
                                                                                    r24 = var_190;
                                                                                    r26 = var_180;
                                                                                    [r22 release];
                                                                                    [r27 release];
                                                                                    [r19 release];
                                                                                    [r23 release];
                                                                                    [r20 release];
                                                                                    objc_autoreleasePoolPop(var_148);
                                                                                    r21 = r21 + 0x1;
                                                                                    if (var_170 != r21) {
                                                                                            continue;
                                                                                    }
                                                                                    break;
                                                                            }
                                                                    }
                                                                    else {
                                                                            r0 = [r28 objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
                                                                            r0 = [r0 retain];
                                                                            r26 = r0;
                                                                            [r0 release];
                                                                            if (r25 != 0x0) {
                                                                                    [var_1A8 release];
                                                                                    [r25 release];
                                                                            }
                                                                            if (r26 != 0x0) {
                                                                                    r25 = [[LauncherApp launcherWithURL:r23] retain];
                                                                                    [r28 release];
                                                                                    [var_198 addLauncherItem:r25];
                                                                                    r28 = r25;
                                                                            }
                                                                            [r28 release];
                                                                            r24 = var_190;
                                                                            r26 = var_180;
                                                                            [r22 release];
                                                                            [r27 release];
                                                                            [r19 release];
                                                                            [r23 release];
                                                                            [r20 release];
                                                                            objc_autoreleasePoolPop(var_148);
                                                                            r21 = r21 + 0x1;
                                                                            if (var_170 != r21) {
                                                                                    continue;
                                                                            }
                                                                            break;
                                                                    }
                                                            }
                                                            else {
                                                                    [r28 release];
                                                                    r24 = var_190;
                                                                    r26 = var_180;
                                                                    [r22 release];
                                                                    [r27 release];
                                                                    [r19 release];
                                                                    [r23 release];
                                                                    [r20 release];
                                                                    objc_autoreleasePoolPop(var_148);
                                                                    r21 = r21 + 0x1;
                                                                    if (var_170 != r21) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            r25 = [[LauncherDiskFolder launcherWithFolderURL:r23] retain];
                                                            [var_1A0 addLaunchersInDir:r20 toFolder:r25 skippingFiles:var_180];
                                                            r0 = [r25 items];
                                                            r0 = [r0 retain];
                                                            r26 = r0;
                                                            r24 = [r0 count];
                                                            [r26 release];
                                                            r28 = r25;
                                                            if (r24 != 0x0) {
                                                                    [var_198 addLauncherItem:r25];
                                                                    r28 = r25;
                                                            }
                                                            [r28 release];
                                                            r24 = var_190;
                                                            r26 = var_180;
                                                            [r22 release];
                                                            [r27 release];
                                                            [r19 release];
                                                            [r23 release];
                                                            [r20 release];
                                                            objc_autoreleasePoolPop(var_148);
                                                            r21 = r21 + 0x1;
                                                            if (var_170 != r21) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                            else {
                                                    r26 = var_180;
                                                    [r22 release];
                                                    [r27 release];
                                                    [r19 release];
                                                    [r23 release];
                                                    [r20 release];
                                                    objc_autoreleasePoolPop(var_148);
                                                    r21 = r21 + 0x1;
                                                    if (var_170 != r21) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                            }
                    }
                    r0 = [var_188 countByEnumeratingWithState:&var_140 objects:&decomp_var_e0 count:0x10];
                    var_170 = r0;
            } while (r0 != 0x0);
    }
    [var_188 release];
    [r26 release];
    [var_198 release];
    [r24 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10004cfe4
// -[CXServerCrossOver addLaunchersInDir:toFolder:]
    r22 = [arg3 retain];
    r19 = [arg2 retain];
    r21 = [[NSMutableSet set] retain];
    [self addLaunchersInDir:r19 toFolder:r22 skippingFiles:r21];
    [r22 release];
    [r19 release];
    [r21 release];
    return;


// 0x10004d068
// -[CXServerCrossOver addLauncherItems:toMenu:]
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
    var_150 = self;
    var_70 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r28 = [arg3 retain];
    var_140 = q0;
    var_130 = q0;
    r2 = &var_140;
    var_158 = r19;
    r0 = [r19 countByEnumeratingWithState:r2 objects:&decomp_var_f0 count:0x10];
    var_148 = r0;
    if (r0 != 0x0) {
            r19 = *var_130;
            d8 = 0x4030000000000000;
            do {
                    r21 = 0x0;
                    var_160 = @selector(launchHelper:);
                    do {
                            if (*var_130 != r19) {
                                    objc_enumerationMutation(var_158);
                            }
                            r25 = *(var_138 + r21 * 0x8);
                            r24 = [[NSMenuItem alloc] init];
                            r27 = [r25 isLeaf];
                            r0 = [r25 retain];
                            r26 = r0;
                            r25 = [[r0 url] retain];
                            if (r27 != 0x0) {
                                    r22 = r19;
                                    r19 = r28;
                                    r0 = [r26 icon];
                                    r0 = [r0 retain];
                                    r28 = r0;
                                    r27 = [r0 copy];
                                    [r28 release];
                                    [r27 size];
                                    if (d0 <= d8) {
                                            if (d0 != 0x0) {
                                                    asm { fccmp      d1, d8, #0x0, ne };
                                                    if (!asm { fccmp      d1, d8, #0x0, ne }) {
                                                            d0 = 0x4030000000000000;
                                                            [r27 setSize:r2];
                                                    }
                                            }
                                            else {
                                                    d0 = 0x4030000000000000;
                                                    [r27 setSize:r2];
                                            }
                                    }
                                    else {
                                            d0 = 0x4030000000000000;
                                            [r27 setSize:r2];
                                    }
                                    [r24 setImage:r27];
                                    [r24 setTarget:var_150];
                                    [r24 setAction:var_160];
                                    var_100 = @"Helper";
                                    r0 = [r26 url];
                                    r0 = [r0 retain];
                                    r28 = r0;
                                    r0 = [r0 path];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    var_F8 = r0;
                                    r0 = [NSDictionary dictionaryWithObjects:&var_F8 forKeys:&var_100 count:0x1];
                                    r23 = [r0 retain];
                                    [r20 release];
                                    [r28 release];
                                    [r24 setRepresentedObject:r23];
                                    [r23 release];
                                    [r27 release];
                                    r28 = r19;
                                    r19 = r22;
                            }
                            else {
                                    r20 = [[NSMenu alloc] init];
                                    r23 = [[r26 items] retain];
                                    [r26 release];
                                    [var_150 addLauncherItems:r23 toMenu:r20];
                                    [r23 release];
                                    [r24 setSubmenu:r20];
                                    r26 = r20;
                            }
                            [r26 release];
                            r0 = [r25 lastPathComponent];
                            r0 = [r0 retain];
                            r20 = r0;
                            r23 = [[r0 stringByDeletingPathExtension] retain];
                            [r24 setTitle:r23];
                            [r23 release];
                            [r20 release];
                            r2 = r24;
                            [r28 addItem:r2];
                            [r25 release];
                            [r24 release];
                            r21 = r21 + 0x1;
                    } while (var_148 != r21);
                    r2 = &var_140;
                    r0 = [var_158 countByEnumeratingWithState:r2 objects:&decomp_var_f0 count:0x10];
                    var_148 = r0;
            } while (r0 != 0x0);
    }
    [r28 release];
    [var_158 release];
    if (**___stack_chk_guard != var_70) {
            __stack_chk_fail();
    }
    return;


// 0x10004d3ac
// -[CXServerCrossOver duplicateBottleList:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = _cmd;
    r20 = self;
    r19 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r20 file:@"CXServerCrossOver.m" lineNumber:0x5a0 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 bottleList] retain];
    [r19 setArray:r21];
    [r19 release];
    [r21 release];
    [r20 release];
    return;


// 0x10004d484
// -[CXServerCrossOver combinedAssociationsPropertyListLatestDate:]
    r1 = _cmd;
    r31 = r31 - 0x180;
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
    r19 = arg2;
    r20 = self;
    var_60 = **___stack_chk_guard;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(associationPlist));
    if (*(self + r21) != 0x0) {
            r8 = sign_extend_64(*(int32_t *)ivar_offset(associationPlistDate));
            if (*(r20 + r8) == 0x0) {
                    var_158 = r21;
                    var_150 = r19;
                    var_140 = [[NSMutableDictionary alloc] init];
                    r22 = [[NSDate distantPast] retain];
                    r19 = [[NSMutableArray array] retain];
                    var_148 = r20;
                    [r20 performSelectorOnMainThread:@selector(duplicateBottleList:) withObject:r19 waitUntilDone:0x1];
                    var_120 = q0;
                    var_110 = q0;
                    r0 = [r19 retain];
                    var_138 = r0;
                    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    var_130 = r0;
                    if (r0 != 0x0) {
                            r21 = &@selector(keyPathsForValuesAffectingCanRegister);
                            r23 = *var_110;
                            do {
                                    r24 = 0x0;
                                    do {
                                            if (*var_110 != r23) {
                                                    objc_enumerationMutation(var_138);
                                            }
                                            r0 = *(var_118 + r24 * 0x8);
                                            r19 = r21[0x19d];
                                            r20 = [[r0 winePrefix] retain];
                                            r27 = [[r19 stringWithFormat:@"%@/desktopdata/cxassoc/cxassoc_macosx.plist", r3] retain];
                                            [r20 release];
                                            r19 = [[NSFileManager defaultManager] retain];
                                            r20 = [[r27 stringByResolvingSymlink] retain];
                                            r28 = [[r19 attributesOfItemAtPath:r20 error:0x0] retain];
                                            [r20 release];
                                            [r19 release];
                                            if (r28 != 0x0) {
                                                    r0 = [r28 fileModificationDate];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    if ([r0 isGreaterThan:r22] != 0x0) {
                                                            r19 = [r20 copy];
                                                            [r22 release];
                                                            r22 = r19;
                                                    }
                                                    r0 = [NSData dataWithContentsOfFile:r27];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    if (r0 != 0x0) {
                                                            r25 = r23;
                                                            r23 = r22;
                                                            r22 = r21;
                                                            var_128 = 0x0;
                                                            r2 = r19;
                                                            r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x0 format:0x0 error:&var_128];
                                                            r26 = [r0 retain];
                                                            r21 = [var_128 retain];
                                                            if (r26 != 0x0) {
                                                                    r1 = objc_opt_class(@class(NSDictionary));
                                                                    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                                                            [var_140 addEntriesFromDictionary:r26];
                                                                    }
                                                            }
                                                            else {
                                                                    NSLog(@"Failed to parse cxassoc plist %@: %@\n", r1, r2);
                                                            }
                                                            [r26 release];
                                                            [r21 release];
                                                            r21 = r22;
                                                            r22 = r23;
                                                            r23 = r25;
                                                    }
                                                    [r19 release];
                                                    [r20 release];
                                            }
                                            r3 = 0x0;
                                            [r28 release];
                                            [r27 release];
                                            r24 = r24 + 0x1;
                                    } while (var_130 != r24);
                                    r3 = 0x0;
                                    r0 = [var_138 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                                    var_130 = r0;
                            } while (r0 != 0x0);
                    }
                    [var_138 release];
                    r0 = [var_140 copy];
                    r20 = var_148;
                    r21 = var_158;
                    r8 = *(r20 + r21);
                    *(r20 + r21) = r0;
                    [r8 release];
                    r0 = [r22 copy];
                    r19 = sign_extend_64(*(int32_t *)ivar_offset(associationPlistDate));
                    r8 = *(r20 + r19);
                    *(r20 + r19) = r0;
                    [r8 release];
                    [var_138 release];
                    [r22 release];
                    [var_140 release];
                    r8 = r19;
                    r19 = var_150;
                    if (r19 != 0x0) {
                            *r19 = objc_retainAutorelease(*(r20 + (r8 << r64)));
                    }
                    r0 = *(r20 + r21);
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = objc_retainAutoreleaseReturnValue(r0);
            }
            else {
                    if (r19 != 0x0) {
                            *r19 = objc_retainAutorelease(*(r20 + (r8 << r64)));
                    }
                    r0 = *(r20 + r21);
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = objc_retainAutoreleaseReturnValue(r0);
            }
    }
    else {
            var_158 = r21;
            var_150 = r19;
            var_140 = [[NSMutableDictionary alloc] init];
            r22 = [[NSDate distantPast] retain];
            r19 = [[NSMutableArray array] retain];
            var_148 = r20;
            [r20 performSelectorOnMainThread:@selector(duplicateBottleList:) withObject:r19 waitUntilDone:0x1];
            var_120 = q0;
            var_110 = q0;
            r0 = [r19 retain];
            var_138 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
            var_130 = r0;
            if (r0 != 0x0) {
                    r21 = &@selector(keyPathsForValuesAffectingCanRegister);
                    r23 = *var_110;
                    do {
                            r24 = 0x0;
                            do {
                                    if (*var_110 != r23) {
                                            objc_enumerationMutation(var_138);
                                    }
                                    r0 = *(var_118 + r24 * 0x8);
                                    r19 = r21[0x19d];
                                    r20 = [[r0 winePrefix] retain];
                                    r27 = [[r19 stringWithFormat:@"%@/desktopdata/cxassoc/cxassoc_macosx.plist", r3] retain];
                                    [r20 release];
                                    r19 = [[NSFileManager defaultManager] retain];
                                    r20 = [[r27 stringByResolvingSymlink] retain];
                                    r28 = [[r19 attributesOfItemAtPath:r20 error:0x0] retain];
                                    [r20 release];
                                    [r19 release];
                                    if (r28 != 0x0) {
                                            r0 = [r28 fileModificationDate];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            if ([r0 isGreaterThan:r22] != 0x0) {
                                                    r19 = [r20 copy];
                                                    [r22 release];
                                                    r22 = r19;
                                            }
                                            r0 = [NSData dataWithContentsOfFile:r27];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            if (r0 != 0x0) {
                                                    r25 = r23;
                                                    r23 = r22;
                                                    r22 = r21;
                                                    var_128 = 0x0;
                                                    r2 = r19;
                                                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x0 format:0x0 error:&var_128];
                                                    r26 = [r0 retain];
                                                    r21 = [var_128 retain];
                                                    if (r26 != 0x0) {
                                                            r1 = objc_opt_class(@class(NSDictionary));
                                                            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                                                    [var_140 addEntriesFromDictionary:r26];
                                                            }
                                                    }
                                                    else {
                                                            NSLog(@"Failed to parse cxassoc plist %@: %@\n", r1, r2);
                                                    }
                                                    [r26 release];
                                                    [r21 release];
                                                    r21 = r22;
                                                    r22 = r23;
                                                    r23 = r25;
                                            }
                                            [r19 release];
                                            [r20 release];
                                    }
                                    r3 = 0x0;
                                    [r28 release];
                                    [r27 release];
                                    r24 = r24 + 0x1;
                            } while (var_130 != r24);
                            r3 = 0x0;
                            r0 = [var_138 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                            var_130 = r0;
                    } while (r0 != 0x0);
            }
            [var_138 release];
            r0 = [var_140 copy];
            r20 = var_148;
            r21 = var_158;
            r8 = *(r20 + r21);
            *(r20 + r21) = r0;
            [r8 release];
            r0 = [r22 copy];
            r19 = sign_extend_64(*(int32_t *)ivar_offset(associationPlistDate));
            r8 = *(r20 + r19);
            *(r20 + r19) = r0;
            [r8 release];
            [var_138 release];
            [r22 release];
            [var_140 release];
            r8 = r19;
            r19 = var_150;
            if (r19 != 0x0) {
                    *r19 = objc_retainAutorelease(*(r20 + (r8 << r64)));
            }
            r0 = *(r20 + r21);
            if (**___stack_chk_guard != var_60) {
                    __stack_chk_fail();
            }
            r0 = objc_retainAutoreleaseReturnValue(r0);
    }
    return r0;


// 0x10004d848
// -[CXServerCrossOver addDocumentTypeDictionary:forBottle:toBundleArray:andResourcesDir:]
    r31 = r31 - 0x80;
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
    r25 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    r24 = [arg5 retain];
    r0 = [[NSFileManager alloc] init];
    r22 = r0;
    [r0 setDelegate:r25];
    r0 = [r19 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r26 = r0;
    r23 = [[r0 objectAtIndex:0x0] retain];
    [r26 release];
    r26 = [[r24 stringByAppendingPathComponent:r23] retain];
    [r24 release];
    r24 = [[r26 stringByAppendingPathExtension:@"icns"] retain];
    [r26 release];
    r0 = [r19 objectForKey:@"RobustIconSourceFile"];
    r0 = [r0 retain];
    var_60 = r20;
    if (r0 != 0x0) {
            r27 = r0;
            if (r20 != 0x0) {
                    r0 = [CXSetupLib bottleCollectionClass];
                    r0 = [r0 sharedCollection];
                    r0 = [r0 retain];
                    r26 = r0;
                    r0 = [r0 bottleWithName:r20];
                    r0 = [r0 retain];
                    var_68 = r22;
                    r22 = r19;
                    r19 = r24;
                    r24 = r23;
                    r23 = r25;
                    r25 = r21;
                    r21 = r0;
                    [r26 release];
                    r28 = [[r21 winePrefix] retain];
                    r0 = r21;
                    r21 = r25;
                    r25 = r23;
                    r23 = r24;
                    r24 = r19;
                    r19 = r22;
                    r22 = var_68;
                    [r0 release];
                    if (r28 != 0x0) {
                            [r27 length];
                            r26 = [[r27 stringByReplacingOccurrencesOfString:@"%WINEPREFIX%" withString:r28 options:0x8 range:0x0] retain];
                            [r27 release];
                            r27 = r26;
                    }
                    else {
                            r28 = 0x0;
                            if ([r27 hasPrefix:@"%WINEPREFIX%"] != 0x0) {
                                    [r27 release];
                                    r27 = 0x0;
                            }
                    }
            }
            else {
                    r28 = 0x0;
                    if ([r27 hasPrefix:@"%WINEPREFIX%"] != 0x0) {
                            [r27 release];
                            r27 = 0x0;
                    }
            }
            r20 = [[**_NSApp crossOverRoot] retain];
            [r27 length];
            r26 = [[r27 stringByReplacingOccurrencesOfString:@"%CX_ROOT%" withString:r20 options:0x8 range:0x0] retain];
            [r27 release];
            [r20 release];
            [r28 release];
            if (r26 != 0x0) {
                    if ([r22 fileExistsAtPath:r26] != 0x0) {
                            r20 = [[NSURL fileURLWithPath:r24] retain];
                            r27 = [[NSURL fileURLWithPath:r26] retain];
                            r28 = [r25 createIcnsFile:r20 fromImageFile:r27 forApp:0x0];
                            [r27 release];
                            [r20 release];
                            if ((r28 & 0x1) == 0x0) {
                                    r20 = r26;
                                    r26 = [[r19 objectForKey:@"IconSourceFile"] retain];
                                    [r20 release];
                                    if (r26 != 0x0) {
                                            if ([r22 fileExistsAtPath:r26] != 0x0) {
                                                    r20 = [[NSURL fileURLWithPath:r24] retain];
                                                    r27 = [[NSURL fileURLWithPath:r26] retain];
                                                    r25 = [r25 createIcnsFile:r20 fromImageFile:r27 forApp:0x0];
                                                    [r27 release];
                                                    [r20 release];
                                                    if ((r25 & 0x1) == 0x0) {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r20 = r0;
                                                            r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                                            [r20 release];
                                                            if (r25 != 0x0) {
                                                                    r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                                                    if (r0 != 0x0 && var_51 == 0x0) {
                                                                            [r22 removeItemAtPath:r24 error:0x0];
                                                                    }
                                                                    [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                                                    [r22 makeWritableAtPath:r24 recursively:0x0];
                                                            }
                                                            [r25 release];
                                                            [r21 addObject:r19];
                                                            [r26 release];
                                                            [r24 release];
                                                            [r23 release];
                                                            [r22 release];
                                                            [r21 release];
                                                            [var_60 release];
                                                            [r19 release];
                                                    }
                                                    else {
                                                            [r21 addObject:r19];
                                                            [r26 release];
                                                            [r24 release];
                                                            [r23 release];
                                                            [r22 release];
                                                            [r21 release];
                                                            [var_60 release];
                                                            [r19 release];
                                                    }
                                            }
                                            else {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                                    [r20 release];
                                                    if (r25 != 0x0) {
                                                            r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                                            if (r0 != 0x0 && var_51 == 0x0) {
                                                                    [r22 removeItemAtPath:r24 error:0x0];
                                                            }
                                                            [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                                            [r22 makeWritableAtPath:r24 recursively:0x0];
                                                    }
                                                    [r25 release];
                                                    [r21 addObject:r19];
                                                    [r26 release];
                                                    [r24 release];
                                                    [r23 release];
                                                    [r22 release];
                                                    [r21 release];
                                                    [var_60 release];
                                                    [r19 release];
                                            }
                                    }
                                    else {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                            [r20 release];
                                            if (r25 != 0x0) {
                                                    r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                                    if (r0 != 0x0 && var_51 == 0x0) {
                                                            [r22 removeItemAtPath:r24 error:0x0];
                                                    }
                                                    [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                                    [r22 makeWritableAtPath:r24 recursively:0x0];
                                            }
                                            [r25 release];
                                            [r21 addObject:r19];
                                            [r26 release];
                                            [r24 release];
                                            [r23 release];
                                            [r22 release];
                                            [r21 release];
                                            [var_60 release];
                                            [r19 release];
                                    }
                            }
                            else {
                                    [r21 addObject:r19];
                                    [r26 release];
                                    [r24 release];
                                    [r23 release];
                                    [r22 release];
                                    [r21 release];
                                    [var_60 release];
                                    [r19 release];
                            }
                    }
                    else {
                            r20 = r26;
                            r26 = [[r19 objectForKey:@"IconSourceFile"] retain];
                            [r20 release];
                            if (r26 != 0x0) {
                                    if ([r22 fileExistsAtPath:r26] != 0x0) {
                                            r20 = [[NSURL fileURLWithPath:r24] retain];
                                            r27 = [[NSURL fileURLWithPath:r26] retain];
                                            r25 = [r25 createIcnsFile:r20 fromImageFile:r27 forApp:0x0];
                                            [r27 release];
                                            [r20 release];
                                            if ((r25 & 0x1) == 0x0) {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                                    [r20 release];
                                                    if (r25 != 0x0) {
                                                            r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                                            if (r0 != 0x0 && var_51 == 0x0) {
                                                                    [r22 removeItemAtPath:r24 error:0x0];
                                                            }
                                                            [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                                            [r22 makeWritableAtPath:r24 recursively:0x0];
                                                    }
                                                    [r25 release];
                                                    [r21 addObject:r19];
                                                    [r26 release];
                                                    [r24 release];
                                                    [r23 release];
                                                    [r22 release];
                                                    [r21 release];
                                                    [var_60 release];
                                                    [r19 release];
                                            }
                                            else {
                                                    [r21 addObject:r19];
                                                    [r26 release];
                                                    [r24 release];
                                                    [r23 release];
                                                    [r22 release];
                                                    [r21 release];
                                                    [var_60 release];
                                                    [r19 release];
                                            }
                                    }
                                    else {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                            [r20 release];
                                            if (r25 != 0x0) {
                                                    r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                                    if (r0 != 0x0 && var_51 == 0x0) {
                                                            [r22 removeItemAtPath:r24 error:0x0];
                                                    }
                                                    [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                                    [r22 makeWritableAtPath:r24 recursively:0x0];
                                            }
                                            [r25 release];
                                            [r21 addObject:r19];
                                            [r26 release];
                                            [r24 release];
                                            [r23 release];
                                            [r22 release];
                                            [r21 release];
                                            [var_60 release];
                                            [r19 release];
                                    }
                            }
                            else {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                    [r20 release];
                                    if (r25 != 0x0) {
                                            r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                            if (r0 != 0x0 && var_51 == 0x0) {
                                                    [r22 removeItemAtPath:r24 error:0x0];
                                            }
                                            [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                            [r22 makeWritableAtPath:r24 recursively:0x0];
                                    }
                                    [r25 release];
                                    [r21 addObject:r19];
                                    [r26 release];
                                    [r24 release];
                                    [r23 release];
                                    [r22 release];
                                    [r21 release];
                                    [var_60 release];
                                    [r19 release];
                            }
                    }
            }
            else {
                    r20 = r26;
                    r26 = [[r19 objectForKey:@"IconSourceFile"] retain];
                    [r20 release];
                    if (r26 != 0x0) {
                            if ([r22 fileExistsAtPath:r26] != 0x0) {
                                    r20 = [[NSURL fileURLWithPath:r24] retain];
                                    r27 = [[NSURL fileURLWithPath:r26] retain];
                                    r25 = [r25 createIcnsFile:r20 fromImageFile:r27 forApp:0x0];
                                    [r27 release];
                                    [r20 release];
                                    if ((r25 & 0x1) == 0x0) {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                            [r20 release];
                                            if (r25 != 0x0) {
                                                    r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                                    if (r0 != 0x0 && var_51 == 0x0) {
                                                            [r22 removeItemAtPath:r24 error:0x0];
                                                    }
                                                    [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                                    [r22 makeWritableAtPath:r24 recursively:0x0];
                                            }
                                            [r25 release];
                                            [r21 addObject:r19];
                                            [r26 release];
                                            [r24 release];
                                            [r23 release];
                                            [r22 release];
                                            [r21 release];
                                            [var_60 release];
                                            [r19 release];
                                    }
                                    else {
                                            [r21 addObject:r19];
                                            [r26 release];
                                            [r24 release];
                                            [r23 release];
                                            [r22 release];
                                            [r21 release];
                                            [var_60 release];
                                            [r19 release];
                                    }
                            }
                            else {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                    [r20 release];
                                    if (r25 != 0x0) {
                                            r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                            if (r0 != 0x0 && var_51 == 0x0) {
                                                    [r22 removeItemAtPath:r24 error:0x0];
                                            }
                                            [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                            [r22 makeWritableAtPath:r24 recursively:0x0];
                                    }
                                    [r25 release];
                                    [r21 addObject:r19];
                                    [r26 release];
                                    [r24 release];
                                    [r23 release];
                                    [r22 release];
                                    [r21 release];
                                    [var_60 release];
                                    [r19 release];
                            }
                    }
                    else {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                            [r20 release];
                            if (r25 != 0x0) {
                                    r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                    if (r0 != 0x0 && var_51 == 0x0) {
                                            [r22 removeItemAtPath:r24 error:0x0];
                                    }
                                    [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                    [r22 makeWritableAtPath:r24 recursively:0x0];
                            }
                            [r25 release];
                            [r21 addObject:r19];
                            [r26 release];
                            [r24 release];
                            [r23 release];
                            [r22 release];
                            [r21 release];
                            [var_60 release];
                            [r19 release];
                    }
            }
    }
    else {
            r26 = [[r19 objectForKey:@"IconSourceFile"] retain];
            [0x0 release];
            if (r26 != 0x0) {
                    if ([r22 fileExistsAtPath:r26] != 0x0) {
                            r20 = [[NSURL fileURLWithPath:r24] retain];
                            r27 = [[NSURL fileURLWithPath:r26] retain];
                            r25 = [r25 createIcnsFile:r20 fromImageFile:r27 forApp:0x0];
                            [r27 release];
                            [r20 release];
                            if ((r25 & 0x1) == 0x0) {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                                    [r20 release];
                                    if (r25 != 0x0) {
                                            r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                            if (r0 != 0x0 && var_51 == 0x0) {
                                                    [r22 removeItemAtPath:r24 error:0x0];
                                            }
                                            [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                            [r22 makeWritableAtPath:r24 recursively:0x0];
                                    }
                                    [r25 release];
                                    [r21 addObject:r19];
                                    [r26 release];
                                    [r24 release];
                                    [r23 release];
                                    [r22 release];
                                    [r21 release];
                                    [var_60 release];
                                    [r19 release];
                            }
                            else {
                                    [r21 addObject:r19];
                                    [r26 release];
                                    [r24 release];
                                    [r23 release];
                                    [r22 release];
                                    [r21 release];
                                    [var_60 release];
                                    [r19 release];
                            }
                    }
                    else {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                            [r20 release];
                            if (r25 != 0x0) {
                                    r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                                    if (r0 != 0x0 && var_51 == 0x0) {
                                            [r22 removeItemAtPath:r24 error:0x0];
                                    }
                                    [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                                    [r22 makeWritableAtPath:r24 recursively:0x0];
                            }
                            [r25 release];
                            [r21 addObject:r19];
                            [r26 release];
                            [r24 release];
                            [r23 release];
                            [r22 release];
                            [r21 release];
                            [var_60 release];
                            [r19 release];
                    }
            }
            else {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r25 = [[r0 pathForResource:@"genericDocumentIcon" ofType:@"icns"] retain];
                    [r20 release];
                    if (r25 != 0x0) {
                            r0 = [r22 fileExistsAtPath:r24 isDirectory:&var_51];
                            if (r0 != 0x0 && var_51 == 0x0) {
                                    [r22 removeItemAtPath:r24 error:0x0];
                            }
                            [r22 copyItemAtPath:r25 toPath:r24 error:0x0];
                            [r22 makeWritableAtPath:r24 recursively:0x0];
                    }
                    [r25 release];
                    [r21 addObject:r19];
                    [r26 release];
                    [r24 release];
                    [r23 release];
                    [r22 release];
                    [r21 release];
                    [var_60 release];
                    [r19 release];
            }
    }
    return;


// 0x10004dcd0
// -[CXServerCrossOver informSystemOfUpdatedApp:]
    r19 = [arg2 retain];
    r20 = [[NSFileManager defaultManager] retain];
    r22 = [[NSDate date] retain];
    r21 = [[NSDictionary dictionaryWithObject:r22 forKey:**_NSFileModificationDate] retain];
    [r20 setAttributes:r21 ofItemAtPath:r19 error:0x0];
    [r21 release];
    [r22 release];
    [r20 release];
    r0 = [NSWorkspace sharedWorkspace];
    r0 = [r0 retain];
    r20 = r0;
    [r0 noteFileSystemChanged:r19];
    [r20 release];
    r20 = [NSURL fileURLWithPath:r19];
    [r19 release];
    LSRegisterURL(r20, 0x1);
    return;


// 0x10004ddd4
// -[CXServerCrossOver adjustProgramHelpersForChangedAssociations:]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x540;
    r25 = self;
    var_60 = **___stack_chk_guard;
    var_520 = [arg2 retain];
    r19 = [[NSFileManager defaultManager] retain];
    r20 = [[objc_opt_class(r25) getProgramsFolder] retain];
    var_510 = [[NSMutableDictionary dictionary] retain];
    var_518 = [[NSMutableDictionary dictionary] retain];
    var_4A8 = r19;
    var_528 = r20;
    r0 = [r19 enumeratorAtPath:r20];
    r0 = [r0 retain];
    var_320 = q0;
    var_310 = q0;
    var_538 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_320 objects:&decomp_var_e0 count:0x10];
    var_4D0 = r25;
    if (r0 == 0x0) goto loc_10004e188;
    goto loc_10004deb4;

loc_10004e188:
    r0 = [r25 findMenusForAssociations:var_520];
    r0 = [r0 retain];
    var_540 = r0;
    r20 = [[r0 allKeys] retain];
    r19 = [[NSMutableSet setWithArray:r20] retain];
    [r20 release];
    r8 = sign_extend_64(*(int32_t *)ivar_offset(relateDocTypesToMenus));
    var_548 = r8;
    r20 = [[*(r25 + r8) allKeys] retain];
    [r19 addObjectsFromArray:r20];
    [r20 release];
    var_370 = q0;
    var_360 = q0;
    r0 = [r19 retain];
    var_550 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_370 objects:&decomp_var_160 count:0x10];
    var_508 = r0;
    if (r0 == 0x0) goto loc_10004ec7c;
    goto loc_10004e23c;

loc_10004deb4:
    r19 = r0;
    r23 = *var_310;
    goto loc_10004ded0;

loc_10004ec7c:
    [var_550 release];
    r19 = *(r25 + var_548);
    *(r25 + var_548) = var_540;
    r20 = [var_540 retain];
    [r19 release];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setObject:*(r25 + var_548) forKey:@"DocTypeToMenuPathMap"];
    [r20 release];
    [r19 release];
    [var_550 release];
    [var_538 release];
    [var_518 release];
    [var_510 release];
    [var_528 release];
    [var_4A8 release];
    [var_520 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;

loc_10004e23c:
    var_530 = *var_360;
    goto loc_10004e248;

loc_10004ded0:
    r20 = 0x0;
    goto loc_10004ded4;

loc_10004e248:
    r19 = 0x0;
    goto loc_10004e24c;

loc_10004ded4:
    if (*var_310 != r23) {
            objc_enumerationMutation(var_538);
    }
    r0 = [var_528 stringByAppendingPathComponent:*(var_318 + r20 * 0x8)];
    r0 = [r0 retain];
    r26 = r0;
    r0 = [r0 stringByAppendingPathComponent:@"Contents"];
    r0 = [r0 retain];
    r27 = r0;
    r28 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
    r0 = [var_4A8 fileExistsAtPath:r28 isDirectory:&var_321];
    asm { ccmp       w8, #0x0, #0x0, ne };
    if (!asm { ccmp       w8, #0x0, #0x0, ne } && [var_4A8 isReadableFileAtPath:r28] != 0x0 && [var_4A8 isWritableFileAtPath:r28] != 0x0) {
            [var_538 skipDescendants];
            r0 = [NSData dataWithContentsOfFile:r28];
            r0 = [r0 retain];
            r25 = r0;
            if (r0 != 0x0) {
                    r0 = [NSPropertyListSerialization propertyListWithData:r25 options:0x1 format:&var_330 error:0x0];
                    r0 = [r0 retain];
                    r24 = r0;
                    if (r0 != 0x0) {
                            r0 = [r24 objectForKey:@"CrossOverHelperMenuPath"];
                            r0 = [r0 retain];
                            if (r0 != 0x0) {
                                    var_438 = r0;
                                    r0 = [r24 objectForKey:@"CXHelperAppBottleTag"];
                                    r0 = [r0 retain];
                                    var_440 = r0;
                                    if (r0 != 0x0) {
                                            r0 = [r24 objectForKey:@"CXHelperAppBottleName"];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            if (r0 != 0x0) {
                                                    [var_518 setObject:r22 forKey:var_440];
                                            }
                                            var_450 = r22;
                                            r0 = [var_510 objectForKey:var_440];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            if (r0 == 0x0) {
                                                    r22 = [[NSMutableDictionary alloc] init];
                                                    [var_510 setObject:r22 forKey:var_440];
                                            }
                                            var_448 = r22;
                                            var_460 = [[NSNumber numberWithUnsignedInteger:var_330] retain];
                                            r22 = [[NSDictionary dictionaryWithObjectsAndKeys:r24] retain];
                                            [var_460 release];
                                            [var_448 setObject:r22 forKey:var_438];
                                            [r22 release];
                                            [var_448 release];
                                            [var_450 release];
                                    }
                                    [var_440 release];
                                    r0 = var_438;
                            }
                            [r0 release];
                    }
                    [r24 release];
            }
            [r25 release];
            r25 = var_4D0;
    }
    [r28 release];
    [r27 release];
    [r26 release];
    r20 = r20 + 0x1;
    if (r19 != r20) {
            continue;
    }
    break;

loc_10004e24c:
    if (*var_360 != var_530) {
            objc_enumerationMutation(var_550);
    }
    r20 = *(var_368 + r19 * 0x8);
    var_448 = [[var_518 objectForKey:r20] retain];
    r0 = [var_520 objectForKey:r20];
    r0 = [r0 retain];
    var_4F8 = r0;
    r0 = [r0 objectForKey:@"Extension Associations/"];
    r0 = [r0 retain];
    var_438 = r0;
    if (r0 == 0x0) {
            var_438 = [[NSDictionary dictionary] retain];
    }
    r0 = [var_510 objectForKey:r20];
    r0 = [r0 retain];
    var_4B0 = r0;
    if (r0 == 0x0) goto loc_10004ec30;
    goto loc_10004e2f0;
    r0 = [var_538 countByEnumeratingWithState:&var_320 objects:&decomp_var_e0 count:0x10];
    r19 = r0;
    if (r0 != 0x0) {
            continue;
    }
    break;

loc_10004ec30:
    [var_4B0 release];
    [var_438 release];
    [var_4F8 release];
    [var_448 release];
    r19 = r19 + 0x1;
    if (r19 != var_508) {
            continue;
    }
    break;

loc_10004e2f0:
    r0 = *(r25 + var_548);
    r0 = [r0 objectForKey:r20];
    r0 = [r0 retain];
    r22 = r0;
    if (r0 == 0x0) {
            r22 = [[NSDictionary dictionary] retain];
    }
    var_500 = r19;
    r0 = [var_540 objectForKey:r20];
    r0 = [r0 retain];
    r26 = r0;
    if (r0 == 0x0) {
            r26 = [[NSDictionary dictionary] retain];
    }
    r23 = [[r22 allKeys] retain];
    r27 = [[NSMutableSet setWithArray:r23] retain];
    [r23 release];
    r23 = [[r26 allKeys] retain];
    r28 = [[NSMutableSet setWithArray:r23] retain];
    [r23 release];
    r0 = [r28 mutableCopy];
    r20 = r0;
    [r0 intersectSet:r27];
    [r27 minusSet:r20];
    [r28 minusSet:r20];
    var_3B0 = q0;
    var_3A0 = q0;
    r0 = [r20 retain];
    var_450 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3B0 objects:&decomp_var_1e0 count:0x10];
    if (r0 != 0x0) {
            r20 = r0;
            r19 = *var_3A0;
            do {
                    r21 = 0x0;
                    do {
                            if (*var_3A0 != r19) {
                                    objc_enumerationMutation(var_450);
                            }
                            r24 = *(var_3A8 + r21 * 0x8);
                            r23 = [[r22 objectForKey:r24] retain];
                            r25 = [[r26 objectForKey:r24] retain];
                            if (([r23 isEqualToString:r25] & 0x1) == 0x0) {
                                    [r27 addObject:r24];
                                    [r28 addObject:r24];
                            }
                            [r25 release];
                            [r23 release];
                            r21 = r21 + 0x1;
                    } while (r20 != r21);
                    r0 = [var_450 countByEnumeratingWithState:&var_3B0 objects:&decomp_var_1e0 count:0x10];
                    r20 = r0;
            } while (r0 != 0x0);
    }
    [var_450 release];
    r20 = [[r27 allObjects] retain];
    r19 = [[r22 dictionaryWithValuesForKeys:r20] retain];
    [r20 release];
    r20 = [[r28 allObjects] retain];
    var_4B8 = [[r26 dictionaryWithValuesForKeys:r20] retain];
    [r20 release];
    var_4C0 = r19;
    r25 = var_4D0;
    if ([r19 count] != 0x0) goto loc_10004e57c;
    goto loc_10004e570;
    r0 = [var_550 countByEnumeratingWithState:&var_370 objects:&decomp_var_160 count:0x10];
    var_508 = r0;
    if (r0 != 0x0) {
            continue;
    }
    break;

loc_10004e57c:
    r0 = [var_4B0 keyEnumerator];
    r0 = [r0 retain];
    var_4C8 = r0;
    r0 = [r0 nextObject];
    r0 = [r0 retain];
    if (r0 == 0x0) goto .l2;
    goto .l4;

loc_10004e570:
    if ([var_4B8 count] == 0x0) goto loc_10004ebf4;
    goto .l5;

.l2:
    [var_4C8 release];
    [var_4B8 release];
    [var_4C0 release];
    [var_450 release];
    [r28 release];
    [r27 release];
    [r26 release];
    [r22 release];
    r19 = var_500;
    [var_4B0 release];
    [var_438 release];
    [var_4F8 release];
    [var_448 release];
    r19 = r19 + 0x1;
    if (r19 != var_508) {
            continue;
    }
    break;

.l4:
    r21 = r0;
    var_4E0 = r26;
    decomp_var_4d8 = r22;
    var_4F0 = r28;
    var_4E8 = r27;
    goto loc_10004e5ac;

loc_10004ebf4:
    [var_4B8 release];
    [var_4C0 release];
    [var_450 release];
    [r28 release];
    [r27 release];
    [r26 release];
    [r22 release];
    r19 = var_500;
    [var_4B0 release];
    [var_438 release];
    [var_4F8 release];
    [var_448 release];
    r19 = r19 + 0x1;
    if (r19 != var_508) {
            continue;
    }
    break;

.l5:
    r0 = [var_4B0 keyEnumerator];
    r0 = [r0 retain];
    var_4C8 = r0;
    r0 = [r0 nextObject];
    r0 = [r0 retain];
    if (r0 == 0x0) goto loc_10004ebec;
    goto loc_10004e5a0;

loc_10004e5ac:
    r0 = [var_4B0 objectForKey:r21];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 objectForKey:@"fullPath"];
    r0 = [r0 retain];
    var_468 = r0;
    r0 = [r0 stringByAppendingPathComponent:@"Contents"];
    r0 = [r0 retain];
    r23 = r0;
    var_440 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
    var_480 = [[r23 stringByAppendingPathComponent:@"Info.plist"] retain];
    var_460 = [[r19 objectForKey:@"plist"] retain];
    r0 = [r19 objectForKey:@"plistFormat"];
    r0 = [r0 retain];
    r20 = r0;
    var_4A0 = [r0 intValue];
    [r20 release];
    r20 = [[var_4C0 allKeysForObject:r21] retain];
    r24 = [[var_4B8 allKeysForObject:r21] retain];
    var_470 = r20;
    if ([r20 count] != 0x0) goto .l20;
    goto loc_10004e6b0;

loc_10004ebec:
    [var_4C8 release];
    [var_4B8 release];
    [var_4C0 release];
    [var_450 release];
    [r28 release];
    [r27 release];
    [r26 release];
    [r22 release];
    r19 = var_500;
    [var_4B0 release];
    [var_438 release];
    [var_4F8 release];
    [var_448 release];
    r19 = r19 + 0x1;
    if (r19 != var_508) {
            continue;
    }
    break;

loc_10004e5a0:
    r21 = r0;
    var_4E0 = r26;
    decomp_var_4d8 = r22;
    var_4F0 = r28;
    var_4E8 = r27;
    goto .l35;

.l20:
    var_478 = r24;
    r0 = [var_460 objectForKey:@"CFBundleDocumentTypes"];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0) goto .l10;
    goto .l17;

loc_10004e6b0:
    if ([r24 count] == 0x0) goto .l22;
    goto loc_10004e6bc;

.l35:
    r0 = [var_4B0 objectForKey:r21];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 objectForKey:@"fullPath"];
    r0 = [r0 retain];
    var_468 = r0;
    r0 = [r0 stringByAppendingPathComponent:@"Contents"];
    r0 = [r0 retain];
    r23 = r0;
    var_440 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
    var_480 = [[r23 stringByAppendingPathComponent:@"Info.plist"] retain];
    var_460 = [[r19 objectForKey:@"plist"] retain];
    r0 = [r19 objectForKey:@"plistFormat"];
    r0 = [r0 retain];
    r20 = r0;
    var_4A0 = [r0 intValue];
    [r20 release];
    r20 = [[var_4C0 allKeysForObject:r21] retain];
    r24 = [[var_4B8 allKeysForObject:r21] retain];
    var_470 = r20;
    if ([r20 count] != 0x0) goto .l61;
    goto .l55;

.l10:
    var_498 = r23;
    var_490 = r19;
    var_488 = r21;
    r19 = var_470;
    r28 = [[NSMutableSet setWithCapacity:[r19 count]] retain];
    var_3F0 = q0;
    var_3E0 = q0;
    r0 = [r19 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r25 = *var_3E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_3E0 != r25) {
                                    objc_enumerationMutation(r24);
                            }
                            r0 = *(var_3E8 + r22 * 0x8);
                            r0 = [r0 componentsSeparatedByString:@"/"];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 count] != 0x0) {
                                    r0 = [r27 objectAtIndex:0x0];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 substringFromIndex:0x1];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [[r0 lowercaseString] retain];
                                    [r19 release];
                                    [r26 release];
                                    [r28 addObject:r21];
                                    [r21 release];
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [r24 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r24 release];
    if ([r28 count] == 0x0) goto .l13;
    goto .l25;

.l17:
    r24 = var_478;
    if ([r24 count] == 0x0) goto .l6;
    goto loc_10004e6f0;

.l22:
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

loc_10004e6bc:
    var_478 = r24;
    r0 = [var_460 objectForKey:@"CFBundleDocumentTypes"];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0) goto loc_10004e72c;
    goto loc_10004e6e0;

.l61:
    var_478 = r24;
    r0 = [var_460 objectForKey:@"CFBundleDocumentTypes"];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0) goto .l46;
    goto .l48;

.l55:
    if ([r24 count] == 0x0) goto .l59;
    goto .l47;

.l13:
    r19 = 0x0;
    r25 = var_4D0;
    r21 = var_478;
    goto .l7;

.l25:
    var_458 = [[NSMutableIndexSet indexSet] retain];
    r25 = @"CFBundleTypeIconFile";
    if ([r20 count] == 0x0) goto loc_10004e9f8;
    goto loc_10004e8b4;

.l6:
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

loc_10004e6f0:
    r20 = [[NSMutableArray arrayWithCapacity:[r24 count]] retain];
    [var_460 setObject:r20 forKey:@"CFBundleDocumentTypes"];
    var_498 = r23;
    var_490 = r19;
    var_488 = r21;
    r19 = var_470;
    r28 = [[NSMutableSet setWithCapacity:[r19 count]] retain];
    var_3F0 = q0;
    var_3E0 = q0;
    r0 = [r19 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r25 = *var_3E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_3E0 != r25) {
                                    objc_enumerationMutation(r24);
                            }
                            r0 = *(var_3E8 + r22 * 0x8);
                            r0 = [r0 componentsSeparatedByString:@"/"];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 count] != 0x0) {
                                    r0 = [r27 objectAtIndex:0x0];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 substringFromIndex:0x1];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [[r0 lowercaseString] retain];
                                    [r19 release];
                                    [r26 release];
                                    [r28 addObject:r21];
                                    [r21 release];
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [r24 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r24 release];
    if ([r28 count] == 0x0) goto .l24;
    goto .l9;

loc_10004e72c:
    var_498 = r23;
    var_490 = r19;
    var_488 = r21;
    r19 = var_470;
    r28 = [[NSMutableSet setWithCapacity:[r19 count]] retain];
    var_3F0 = q0;
    var_3E0 = q0;
    r0 = [r19 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r25 = *var_3E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_3E0 != r25) {
                                    objc_enumerationMutation(r24);
                            }
                            r0 = *(var_3E8 + r22 * 0x8);
                            r0 = [r0 componentsSeparatedByString:@"/"];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 count] != 0x0) {
                                    r0 = [r27 objectAtIndex:0x0];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 substringFromIndex:0x1];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [[r0 lowercaseString] retain];
                                    [r19 release];
                                    [r26 release];
                                    [r28 addObject:r21];
                                    [r21 release];
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [r24 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r24 release];
    if ([r28 count] == 0x0) goto loc_10004ea2c;
    goto loc_10004e880;

loc_10004e6e0:
    r24 = var_478;
    if ([r24 count] == 0x0) goto .l11;
    goto .l16;

.l46:
    var_498 = r23;
    var_490 = r19;
    var_488 = r21;
    r19 = var_470;
    r28 = [[NSMutableSet setWithCapacity:[r19 count]] retain];
    var_3F0 = q0;
    var_3E0 = q0;
    r0 = [r19 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r25 = *var_3E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_3E0 != r25) {
                                    objc_enumerationMutation(r24);
                            }
                            r0 = *(var_3E8 + r22 * 0x8);
                            r0 = [r0 componentsSeparatedByString:@"/"];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 count] != 0x0) {
                                    r0 = [r27 objectAtIndex:0x0];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 substringFromIndex:0x1];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [[r0 lowercaseString] retain];
                                    [r19 release];
                                    [r26 release];
                                    [r28 addObject:r21];
                                    [r21 release];
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [r24 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r24 release];
    if ([r28 count] == 0x0) goto .l57;
    goto .l56;

.l48:
    r24 = var_478;
    if ([r24 count] == 0x0) goto .l53;
    goto .l51;

.l59:
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l47:
    var_478 = r24;
    r0 = [var_460 objectForKey:@"CFBundleDocumentTypes"];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0) goto .l52;
    goto .l60;

.l7:
    var_430 = q0;
    var_420 = q0;
    r0 = [r21 retain];
    r23 = r0;
    r3 = &decomp_var_2e0;
    r0 = [r0 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r21 = *var_420;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_420 != r21) {
                                    objc_enumerationMutation(r23);
                            }
                            r0 = [r25 getAssociationDictionaryForKey:*(var_428 + r22 * 0x8) withExtensionAssociations:var_438];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 != 0x0) {
                                    [r25 addDocumentTypeDictionary:r27 forBottle:var_448 toBundleArray:r20 andResourcesDir:var_440];
                                    r19 = 0x1;
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r24 != r22);
                    r3 = &decomp_var_2e0;
                    r0 = [r23 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r23 release];
    r26 = var_4E0;
    r22 = decomp_var_4d8;
    r27 = var_4E8;
    r21 = var_468;
    if ((r19 & 0x1) != 0x0) {
            asm { sxtw       x3, w8 };
            r0 = [NSPropertyListSerialization dataWithPropertyList:var_460 format:r3 options:0x0 error:0x0];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0 && [r23 writeToFile:var_480 atomically:0x1] != 0x0) {
                    [r25 informSystemOfUpdatedApp:r21];
            }
            [r23 release];
    }
    [r28 release];
    [r20 release];
    r28 = var_4F0;
    r19 = var_490;
    r21 = var_488;
    r23 = var_498;
    r24 = var_478;
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

loc_10004e9f8:
    r0 = [var_458 count];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    r25 = var_4D0;
    r21 = var_478;
    if (r0 != 0x0) {
            [r20 removeObjectsAtIndexes:var_458];
    }
    [var_458 release];
    goto .l7;

loc_10004e8b4:
    r24 = 0x0;
    goto loc_10004e8b8;

.l24:
    r19 = 0x0;
    r25 = var_4D0;
    r21 = var_478;
    goto loc_10004ea38;

.l9:
    var_458 = [[NSMutableIndexSet indexSet] retain];
    r25 = @"CFBundleTypeIconFile";
    if ([r20 count] == 0x0) goto .l14;
    goto .l18;

loc_10004ea2c:
    r19 = 0x0;
    r25 = var_4D0;
    r21 = var_478;
    goto .l27;

loc_10004e880:
    var_458 = [[NSMutableIndexSet indexSet] retain];
    r25 = @"CFBundleTypeIconFile";
    if ([r20 count] == 0x0) goto .l19;
    goto .l26;

.l11:
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l16:
    r20 = [[NSMutableArray arrayWithCapacity:[r24 count]] retain];
    [var_460 setObject:r20 forKey:@"CFBundleDocumentTypes"];
    var_498 = r23;
    var_490 = r19;
    var_488 = r21;
    r19 = var_470;
    r28 = [[NSMutableSet setWithCapacity:[r19 count]] retain];
    var_3F0 = q0;
    var_3E0 = q0;
    r0 = [r19 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r25 = *var_3E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_3E0 != r25) {
                                    objc_enumerationMutation(r24);
                            }
                            r0 = *(var_3E8 + r22 * 0x8);
                            r0 = [r0 componentsSeparatedByString:@"/"];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 count] != 0x0) {
                                    r0 = [r27 objectAtIndex:0x0];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 substringFromIndex:0x1];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [[r0 lowercaseString] retain];
                                    [r19 release];
                                    [r26 release];
                                    [r28 addObject:r21];
                                    [r21 release];
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [r24 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r24 release];
    if ([r28 count] == 0x0) goto .l12;
    goto .l21;

.l57:
    r19 = 0x0;
    r25 = var_4D0;
    r21 = var_478;
    goto .l43;

.l56:
    var_458 = [[NSMutableIndexSet indexSet] retain];
    r25 = @"CFBundleTypeIconFile";
    if ([r20 count] == 0x0) goto .l40;
    goto .l63;

.l53:
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l51:
    r20 = [[NSMutableArray arrayWithCapacity:[r24 count]] retain];
    [var_460 setObject:r20 forKey:@"CFBundleDocumentTypes"];
    var_498 = r23;
    var_490 = r19;
    var_488 = r21;
    r19 = var_470;
    r28 = [[NSMutableSet setWithCapacity:[r19 count]] retain];
    var_3F0 = q0;
    var_3E0 = q0;
    r0 = [r19 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r25 = *var_3E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_3E0 != r25) {
                                    objc_enumerationMutation(r24);
                            }
                            r0 = *(var_3E8 + r22 * 0x8);
                            r0 = [r0 componentsSeparatedByString:@"/"];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 count] != 0x0) {
                                    r0 = [r27 objectAtIndex:0x0];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 substringFromIndex:0x1];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [[r0 lowercaseString] retain];
                                    [r19 release];
                                    [r26 release];
                                    [r28 addObject:r21];
                                    [r21 release];
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [r24 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r24 release];
    if ([r28 count] == 0x0) goto .l50;
    goto .l45;

.l52:
    var_498 = r23;
    var_490 = r19;
    var_488 = r21;
    r19 = var_470;
    r28 = [[NSMutableSet setWithCapacity:[r19 count]] retain];
    var_3F0 = q0;
    var_3E0 = q0;
    r0 = [r19 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r25 = *var_3E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_3E0 != r25) {
                                    objc_enumerationMutation(r24);
                            }
                            r0 = *(var_3E8 + r22 * 0x8);
                            r0 = [r0 componentsSeparatedByString:@"/"];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 count] != 0x0) {
                                    r0 = [r27 objectAtIndex:0x0];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 substringFromIndex:0x1];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [[r0 lowercaseString] retain];
                                    [r19 release];
                                    [r26 release];
                                    [r28 addObject:r21];
                                    [r21 release];
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [r24 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r24 release];
    if ([r28 count] == 0x0) goto .l62;
    goto .l32;

.l60:
    r24 = var_478;
    if ([r24 count] == 0x0) goto .l33;
    goto .l31;

loc_10004e8b8:
    r0 = [r20 objectAtIndex:r24];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0 && [r27 count] != 0x0) {
            r0 = [r27 objectAtIndex:0x0];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 lowercaseString] retain];
            [r19 release];
            if ([r28 containsObject:r21] != 0x0) {
                    [var_458 addIndex:r24];
                    r0 = [r23 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            r0 = [var_440 stringByAppendingPathComponent:r26];
                            r0 = [r0 retain];
                            r19 = r0;
                            r22 = r25;
                            r25 = r21;
                            r21 = [[r0 stringByAppendingPathExtension:@"icns"] retain];
                            [r19 release];
                            [var_4A8 removeItemAtPath:r21 error:0x0];
                            r0 = r21;
                            r21 = r25;
                            r25 = r22;
                            [r0 release];
                    }
                    [r26 release];
            }
            [r21 release];
    }
    [r27 release];
    [r23 release];
    r24 = r24 + 0x1;
    if ([r20 count] > r24) {
            continue;
    }
    break;

loc_10004ea38:
    var_430 = q0;
    var_420 = q0;
    r0 = [r21 retain];
    r23 = r0;
    r3 = &decomp_var_2e0;
    r0 = [r0 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r21 = *var_420;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_420 != r21) {
                                    objc_enumerationMutation(r23);
                            }
                            r0 = [r25 getAssociationDictionaryForKey:*(var_428 + r22 * 0x8) withExtensionAssociations:var_438];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 != 0x0) {
                                    [r25 addDocumentTypeDictionary:r27 forBottle:var_448 toBundleArray:r20 andResourcesDir:var_440];
                                    r19 = 0x1;
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r24 != r22);
                    r3 = &decomp_var_2e0;
                    r0 = [r23 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r23 release];
    r26 = var_4E0;
    r22 = decomp_var_4d8;
    r27 = var_4E8;
    r21 = var_468;
    if ((r19 & 0x1) != 0x0) {
            asm { sxtw       x3, w8 };
            r0 = [NSPropertyListSerialization dataWithPropertyList:var_460 format:r3 options:0x0 error:0x0];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0 && [r23 writeToFile:var_480 atomically:0x1] != 0x0) {
                    [r25 informSystemOfUpdatedApp:r21];
            }
            [r23 release];
    }
    [r28 release];
    [r20 release];
    r28 = var_4F0;
    r19 = var_490;
    r21 = var_488;
    r23 = var_498;
    r24 = var_478;
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l14:
    r0 = [var_458 count];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    r25 = var_4D0;
    r21 = var_478;
    if (r0 != 0x0) {
            [r20 removeObjectsAtIndexes:var_458];
    }
    [var_458 release];
    goto loc_10004ea38;

.l18:
    r24 = 0x0;
    goto .l30;

.l27:
    var_430 = q0;
    var_420 = q0;
    r0 = [r21 retain];
    r23 = r0;
    r3 = &decomp_var_2e0;
    r0 = [r0 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r21 = *var_420;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_420 != r21) {
                                    objc_enumerationMutation(r23);
                            }
                            r0 = [r25 getAssociationDictionaryForKey:*(var_428 + r22 * 0x8) withExtensionAssociations:var_438];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 != 0x0) {
                                    [r25 addDocumentTypeDictionary:r27 forBottle:var_448 toBundleArray:r20 andResourcesDir:var_440];
                                    r19 = 0x1;
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r24 != r22);
                    r3 = &decomp_var_2e0;
                    r0 = [r23 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r23 release];
    r26 = var_4E0;
    r22 = decomp_var_4d8;
    r27 = var_4E8;
    r21 = var_468;
    if ((r19 & 0x1) != 0x0) {
            asm { sxtw       x3, w8 };
            r0 = [NSPropertyListSerialization dataWithPropertyList:var_460 format:r3 options:0x0 error:0x0];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0 && [r23 writeToFile:var_480 atomically:0x1] != 0x0) {
                    [r25 informSystemOfUpdatedApp:r21];
            }
            [r23 release];
    }
    [r28 release];
    [r20 release];
    r28 = var_4F0;
    r19 = var_490;
    r21 = var_488;
    r23 = var_498;
    r24 = var_478;
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l19:
    r0 = [var_458 count];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    r25 = var_4D0;
    r21 = var_478;
    if (r0 != 0x0) {
            [r20 removeObjectsAtIndexes:var_458];
    }
    [var_458 release];
    goto .l27;

.l26:
    r24 = 0x0;
    goto .l28;

.l12:
    r19 = 0x0;
    r25 = var_4D0;
    r21 = var_478;
    goto .l8;

.l21:
    var_458 = [[NSMutableIndexSet indexSet] retain];
    r25 = @"CFBundleTypeIconFile";
    if ([r20 count] == 0x0) goto .l23;
    goto .l15;

.l43:
    var_430 = q0;
    var_420 = q0;
    r0 = [r21 retain];
    r23 = r0;
    r3 = &decomp_var_2e0;
    r0 = [r0 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r21 = *var_420;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_420 != r21) {
                                    objc_enumerationMutation(r23);
                            }
                            r0 = [r25 getAssociationDictionaryForKey:*(var_428 + r22 * 0x8) withExtensionAssociations:var_438];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 != 0x0) {
                                    [r25 addDocumentTypeDictionary:r27 forBottle:var_448 toBundleArray:r20 andResourcesDir:var_440];
                                    r19 = 0x1;
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r24 != r22);
                    r3 = &decomp_var_2e0;
                    r0 = [r23 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r23 release];
    r26 = var_4E0;
    r22 = decomp_var_4d8;
    r27 = var_4E8;
    r21 = var_468;
    if ((r19 & 0x1) != 0x0) {
            asm { sxtw       x3, w8 };
            r0 = [NSPropertyListSerialization dataWithPropertyList:var_460 format:r3 options:0x0 error:0x0];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0 && [r23 writeToFile:var_480 atomically:0x1] != 0x0) {
                    [r25 informSystemOfUpdatedApp:r21];
            }
            [r23 release];
    }
    [r28 release];
    [r20 release];
    r28 = var_4F0;
    r19 = var_490;
    r21 = var_488;
    r23 = var_498;
    r24 = var_478;
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l40:
    r0 = [var_458 count];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    r25 = var_4D0;
    r21 = var_478;
    if (r0 != 0x0) {
            [r20 removeObjectsAtIndexes:var_458];
    }
    [var_458 release];
    goto .l43;

.l63:
    r24 = 0x0;
    goto .l64;

.l50:
    r19 = 0x0;
    r25 = var_4D0;
    r21 = var_478;
    goto .l58;

.l45:
    var_458 = [[NSMutableIndexSet indexSet] retain];
    r25 = @"CFBundleTypeIconFile";
    if ([r20 count] == 0x0) goto .l39;
    goto .l36;

.l62:
    r19 = 0x0;
    r25 = var_4D0;
    r21 = var_478;
    goto .l37;

.l32:
    var_458 = [[NSMutableIndexSet indexSet] retain];
    r25 = @"CFBundleTypeIconFile";
    if ([r20 count] == 0x0) goto .l38;
    goto .l54;

.l33:
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l31:
    r20 = [[NSMutableArray arrayWithCapacity:[r24 count]] retain];
    [var_460 setObject:r20 forKey:@"CFBundleDocumentTypes"];
    var_498 = r23;
    var_490 = r19;
    var_488 = r21;
    r19 = var_470;
    r28 = [[NSMutableSet setWithCapacity:[r19 count]] retain];
    var_3F0 = q0;
    var_3E0 = q0;
    r0 = [r19 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r25 = *var_3E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_3E0 != r25) {
                                    objc_enumerationMutation(r24);
                            }
                            r0 = *(var_3E8 + r22 * 0x8);
                            r0 = [r0 componentsSeparatedByString:@"/"];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 count] != 0x0) {
                                    r0 = [r27 objectAtIndex:0x0];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 substringFromIndex:0x1];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [[r0 lowercaseString] retain];
                                    [r19 release];
                                    [r26 release];
                                    [r28 addObject:r21];
                                    [r21 release];
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [r24 countByEnumeratingWithState:&var_3F0 objects:&decomp_var_260 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r24 release];
    if ([r28 count] == 0x0) goto .l44;
    goto .l34;

.l30:
    r0 = [r20 objectAtIndex:r24];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0 && [r27 count] != 0x0) {
            r0 = [r27 objectAtIndex:0x0];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 lowercaseString] retain];
            [r19 release];
            if ([r28 containsObject:r21] != 0x0) {
                    [var_458 addIndex:r24];
                    r0 = [r23 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            r0 = [var_440 stringByAppendingPathComponent:r26];
                            r0 = [r0 retain];
                            r19 = r0;
                            r22 = r25;
                            r25 = r21;
                            r21 = [[r0 stringByAppendingPathExtension:@"icns"] retain];
                            [r19 release];
                            [var_4A8 removeItemAtPath:r21 error:0x0];
                            r0 = r21;
                            r21 = r25;
                            r25 = r22;
                            [r0 release];
                    }
                    [r26 release];
            }
            [r21 release];
    }
    [r27 release];
    [r23 release];
    r24 = r24 + 0x1;
    if ([r20 count] > r24) {
            continue;
    }
    break;

.l28:
    r0 = [r20 objectAtIndex:r24];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0 && [r27 count] != 0x0) {
            r0 = [r27 objectAtIndex:0x0];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 lowercaseString] retain];
            [r19 release];
            if ([r28 containsObject:r21] != 0x0) {
                    [var_458 addIndex:r24];
                    r0 = [r23 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            r0 = [var_440 stringByAppendingPathComponent:r26];
                            r0 = [r0 retain];
                            r19 = r0;
                            r22 = r25;
                            r25 = r21;
                            r21 = [[r0 stringByAppendingPathExtension:@"icns"] retain];
                            [r19 release];
                            [var_4A8 removeItemAtPath:r21 error:0x0];
                            r0 = r21;
                            r21 = r25;
                            r25 = r22;
                            [r0 release];
                    }
                    [r26 release];
            }
            [r21 release];
    }
    [r27 release];
    [r23 release];
    r24 = r24 + 0x1;
    if ([r20 count] > r24) {
            continue;
    }
    break;

.l8:
    var_430 = q0;
    var_420 = q0;
    r0 = [r21 retain];
    r23 = r0;
    r3 = &decomp_var_2e0;
    r0 = [r0 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r21 = *var_420;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_420 != r21) {
                                    objc_enumerationMutation(r23);
                            }
                            r0 = [r25 getAssociationDictionaryForKey:*(var_428 + r22 * 0x8) withExtensionAssociations:var_438];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 != 0x0) {
                                    [r25 addDocumentTypeDictionary:r27 forBottle:var_448 toBundleArray:r20 andResourcesDir:var_440];
                                    r19 = 0x1;
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r24 != r22);
                    r3 = &decomp_var_2e0;
                    r0 = [r23 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r23 release];
    r26 = var_4E0;
    r22 = decomp_var_4d8;
    r27 = var_4E8;
    r21 = var_468;
    if ((r19 & 0x1) != 0x0) {
            asm { sxtw       x3, w8 };
            r0 = [NSPropertyListSerialization dataWithPropertyList:var_460 format:r3 options:0x0 error:0x0];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0 && [r23 writeToFile:var_480 atomically:0x1] != 0x0) {
                    [r25 informSystemOfUpdatedApp:r21];
            }
            [r23 release];
    }
    [r28 release];
    [r20 release];
    r28 = var_4F0;
    r19 = var_490;
    r21 = var_488;
    r23 = var_498;
    r24 = var_478;
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l23:
    r0 = [var_458 count];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    r25 = var_4D0;
    r21 = var_478;
    if (r0 != 0x0) {
            [r20 removeObjectsAtIndexes:var_458];
    }
    [var_458 release];
    goto .l8;

.l15:
    r24 = 0x0;
    goto .l29;

.l64:
    r0 = [r20 objectAtIndex:r24];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0 && [r27 count] != 0x0) {
            r0 = [r27 objectAtIndex:0x0];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 lowercaseString] retain];
            [r19 release];
            if ([r28 containsObject:r21] != 0x0) {
                    [var_458 addIndex:r24];
                    r0 = [r23 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            r0 = [var_440 stringByAppendingPathComponent:r26];
                            r0 = [r0 retain];
                            r19 = r0;
                            r22 = r25;
                            r25 = r21;
                            r21 = [[r0 stringByAppendingPathExtension:@"icns"] retain];
                            [r19 release];
                            [var_4A8 removeItemAtPath:r21 error:0x0];
                            r0 = r21;
                            r21 = r25;
                            r25 = r22;
                            [r0 release];
                    }
                    [r26 release];
            }
            [r21 release];
    }
    [r27 release];
    [r23 release];
    r24 = r24 + 0x1;
    if ([r20 count] > r24) {
            continue;
    }
    break;

.l58:
    var_430 = q0;
    var_420 = q0;
    r0 = [r21 retain];
    r23 = r0;
    r3 = &decomp_var_2e0;
    r0 = [r0 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r21 = *var_420;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_420 != r21) {
                                    objc_enumerationMutation(r23);
                            }
                            r0 = [r25 getAssociationDictionaryForKey:*(var_428 + r22 * 0x8) withExtensionAssociations:var_438];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 != 0x0) {
                                    [r25 addDocumentTypeDictionary:r27 forBottle:var_448 toBundleArray:r20 andResourcesDir:var_440];
                                    r19 = 0x1;
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r24 != r22);
                    r3 = &decomp_var_2e0;
                    r0 = [r23 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r23 release];
    r26 = var_4E0;
    r22 = decomp_var_4d8;
    r27 = var_4E8;
    r21 = var_468;
    if ((r19 & 0x1) != 0x0) {
            asm { sxtw       x3, w8 };
            r0 = [NSPropertyListSerialization dataWithPropertyList:var_460 format:r3 options:0x0 error:0x0];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0 && [r23 writeToFile:var_480 atomically:0x1] != 0x0) {
                    [r25 informSystemOfUpdatedApp:r21];
            }
            [r23 release];
    }
    [r28 release];
    [r20 release];
    r28 = var_4F0;
    r19 = var_490;
    r21 = var_488;
    r23 = var_498;
    r24 = var_478;
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l39:
    r0 = [var_458 count];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    r25 = var_4D0;
    r21 = var_478;
    if (r0 != 0x0) {
            [r20 removeObjectsAtIndexes:var_458];
    }
    [var_458 release];
    goto .l58;

.l36:
    r24 = 0x0;
    goto .l67;

.l37:
    var_430 = q0;
    var_420 = q0;
    r0 = [r21 retain];
    r23 = r0;
    r3 = &decomp_var_2e0;
    r0 = [r0 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r21 = *var_420;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_420 != r21) {
                                    objc_enumerationMutation(r23);
                            }
                            r0 = [r25 getAssociationDictionaryForKey:*(var_428 + r22 * 0x8) withExtensionAssociations:var_438];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 != 0x0) {
                                    [r25 addDocumentTypeDictionary:r27 forBottle:var_448 toBundleArray:r20 andResourcesDir:var_440];
                                    r19 = 0x1;
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r24 != r22);
                    r3 = &decomp_var_2e0;
                    r0 = [r23 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r23 release];
    r26 = var_4E0;
    r22 = decomp_var_4d8;
    r27 = var_4E8;
    r21 = var_468;
    if ((r19 & 0x1) != 0x0) {
            asm { sxtw       x3, w8 };
            r0 = [NSPropertyListSerialization dataWithPropertyList:var_460 format:r3 options:0x0 error:0x0];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0 && [r23 writeToFile:var_480 atomically:0x1] != 0x0) {
                    [r25 informSystemOfUpdatedApp:r21];
            }
            [r23 release];
    }
    [r28 release];
    [r20 release];
    r28 = var_4F0;
    r19 = var_490;
    r21 = var_488;
    r23 = var_498;
    r24 = var_478;
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l38:
    r0 = [var_458 count];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    r25 = var_4D0;
    r21 = var_478;
    if (r0 != 0x0) {
            [r20 removeObjectsAtIndexes:var_458];
    }
    [var_458 release];
    goto .l37;

.l54:
    r24 = 0x0;
    goto .l65;

.l44:
    r19 = 0x0;
    r25 = var_4D0;
    r21 = var_478;
    goto .l41;

.l34:
    var_458 = [[NSMutableIndexSet indexSet] retain];
    r25 = @"CFBundleTypeIconFile";
    if ([r20 count] == 0x0) goto .l49;
    goto .l42;

.l29:
    r0 = [r20 objectAtIndex:r24];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0 && [r27 count] != 0x0) {
            r0 = [r27 objectAtIndex:0x0];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 lowercaseString] retain];
            [r19 release];
            if ([r28 containsObject:r21] != 0x0) {
                    [var_458 addIndex:r24];
                    r0 = [r23 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            r0 = [var_440 stringByAppendingPathComponent:r26];
                            r0 = [r0 retain];
                            r19 = r0;
                            r22 = r25;
                            r25 = r21;
                            r21 = [[r0 stringByAppendingPathExtension:@"icns"] retain];
                            [r19 release];
                            [var_4A8 removeItemAtPath:r21 error:0x0];
                            r0 = r21;
                            r21 = r25;
                            r25 = r22;
                            [r0 release];
                    }
                    [r26 release];
            }
            [r21 release];
    }
    [r27 release];
    [r23 release];
    r24 = r24 + 0x1;
    if ([r20 count] > r24) {
            continue;
    }
    break;

.l67:
    r0 = [r20 objectAtIndex:r24];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0 && [r27 count] != 0x0) {
            r0 = [r27 objectAtIndex:0x0];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 lowercaseString] retain];
            [r19 release];
            if ([r28 containsObject:r21] != 0x0) {
                    [var_458 addIndex:r24];
                    r0 = [r23 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            r0 = [var_440 stringByAppendingPathComponent:r26];
                            r0 = [r0 retain];
                            r19 = r0;
                            r22 = r25;
                            r25 = r21;
                            r21 = [[r0 stringByAppendingPathExtension:@"icns"] retain];
                            [r19 release];
                            [var_4A8 removeItemAtPath:r21 error:0x0];
                            r0 = r21;
                            r21 = r25;
                            r25 = r22;
                            [r0 release];
                    }
                    [r26 release];
            }
            [r21 release];
    }
    [r27 release];
    [r23 release];
    r24 = r24 + 0x1;
    if ([r20 count] > r24) {
            continue;
    }
    break;

.l65:
    r0 = [r20 objectAtIndex:r24];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0 && [r27 count] != 0x0) {
            r0 = [r27 objectAtIndex:0x0];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 lowercaseString] retain];
            [r19 release];
            if ([r28 containsObject:r21] != 0x0) {
                    [var_458 addIndex:r24];
                    r0 = [r23 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            r0 = [var_440 stringByAppendingPathComponent:r26];
                            r0 = [r0 retain];
                            r19 = r0;
                            r22 = r25;
                            r25 = r21;
                            r21 = [[r0 stringByAppendingPathExtension:@"icns"] retain];
                            [r19 release];
                            [var_4A8 removeItemAtPath:r21 error:0x0];
                            r0 = r21;
                            r21 = r25;
                            r25 = r22;
                            [r0 release];
                    }
                    [r26 release];
            }
            [r21 release];
    }
    [r27 release];
    [r23 release];
    r24 = r24 + 0x1;
    if ([r20 count] > r24) {
            continue;
    }
    break;

.l41:
    var_430 = q0;
    var_420 = q0;
    r0 = [r21 retain];
    r23 = r0;
    r3 = &decomp_var_2e0;
    r0 = [r0 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r21 = *var_420;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_420 != r21) {
                                    objc_enumerationMutation(r23);
                            }
                            r0 = [r25 getAssociationDictionaryForKey:*(var_428 + r22 * 0x8) withExtensionAssociations:var_438];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 != 0x0) {
                                    [r25 addDocumentTypeDictionary:r27 forBottle:var_448 toBundleArray:r20 andResourcesDir:var_440];
                                    r19 = 0x1;
                            }
                            [r27 release];
                            r22 = r22 + 0x1;
                    } while (r24 != r22);
                    r3 = &decomp_var_2e0;
                    r0 = [r23 countByEnumeratingWithState:&var_430 objects:r3 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r23 release];
    r26 = var_4E0;
    r22 = decomp_var_4d8;
    r27 = var_4E8;
    r21 = var_468;
    if ((r19 & 0x1) != 0x0) {
            asm { sxtw       x3, w8 };
            r0 = [NSPropertyListSerialization dataWithPropertyList:var_460 format:r3 options:0x0 error:0x0];
            r0 = [r0 retain];
            r23 = r0;
            if (r0 != 0x0 && [r23 writeToFile:var_480 atomically:0x1] != 0x0) {
                    [r25 informSystemOfUpdatedApp:r21];
            }
            [r23 release];
    }
    [r28 release];
    [r20 release];
    r28 = var_4F0;
    r19 = var_490;
    r21 = var_488;
    r23 = var_498;
    r24 = var_478;
    [r24 release];
    [var_470 release];
    [var_460 release];
    [var_480 release];
    [var_440 release];
    [r23 release];
    [var_468 release];
    [r19 release];
    r19 = [[var_4C8 nextObject] retain];
    [r21 release];
    r21 = r19;
    if (r19 != 0x0) {
            continue;
    }
    break;

.l49:
    r0 = [var_458 count];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    r25 = var_4D0;
    r21 = var_478;
    if (r0 != 0x0) {
            [r20 removeObjectsAtIndexes:var_458];
    }
    [var_458 release];
    goto .l41;

.l42:
    r24 = 0x0;
    goto .l66;

.l66:
    r0 = [r20 objectAtIndex:r24];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 objectForKey:@"CFBundleTypeExtensions"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0 && [r27 count] != 0x0) {
            r0 = [r27 objectAtIndex:0x0];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 lowercaseString] retain];
            [r19 release];
            if ([r28 containsObject:r21] != 0x0) {
                    [var_458 addIndex:r24];
                    r0 = [r23 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            r0 = [var_440 stringByAppendingPathComponent:r26];
                            r0 = [r0 retain];
                            r19 = r0;
                            r22 = r25;
                            r25 = r21;
                            r21 = [[r0 stringByAppendingPathExtension:@"icns"] retain];
                            [r19 release];
                            [var_4A8 removeItemAtPath:r21 error:0x0];
                            r0 = r21;
                            r21 = r25;
                            r25 = r22;
                            [r0 release];
                    }
                    [r26 release];
            }
            [r21 release];
    }
    [r27 release];
    [r23 release];
    r24 = r24 + 0x1;
    if ([r20 count] > r24) {
            continue;
    }
    break;


// 0x10004ed50
// -[CXServerCrossOver refreshAssociations:]
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
    var_60 = **___stack_chk_guard;
    r21 = objc_autoreleasePoolPush();
    r0 = [[NSFileManager alloc] init];
    r26 = r0;
    [r0 setDelegate:self];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r22 = r0;
    r24 = [[r0 objectForKey:@"LastUpdatedAssociations_v2"] retain];
    [r22 release];
    r8 = sign_extend_64(*(int32_t *)ivar_offset(associationPlist));
    r0 = *(self + r8);
    *(self + r8) = 0x0;
    [r0 release];
    var_E8 = 0x0;
    r0 = [self combinedAssociationsPropertyListLatestDate:&var_E8];
    r28 = [r0 retain];
    r22 = [var_E8 retain];
    var_160 = self;
    [self adjustProgramHelpersForChangedAssociations:r28];
    if ((arg2 & 0x1) == 0x0) {
            if (([r22 isEqualToDate:r24] & 0x1) == 0x0) {
                    var_168 = r21;
                    var_180 = r22;
                    if (r28 != 0x0) {
                            if ([r28 count] != 0x0) {
                                    if (r22 != 0x0) {
                                            r0 = [NSUserDefaults standardUserDefaults];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            [r0 setObject:r22 forKey:@"LastUpdatedAssociations_v2"];
                                    }
                                    else {
                                            r0 = [NSUserDefaults standardUserDefaults];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            [r0 removeObjectForKey:@"LastUpdatedAssociations_v2"];
                                    }
                            }
                            else {
                                    r0 = [NSUserDefaults standardUserDefaults];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    [r0 removeObjectForKey:@"LastUpdatedAssociations_v2"];
                            }
                    }
                    else {
                            r0 = [NSUserDefaults standardUserDefaults];
                            r0 = [r0 retain];
                            r19 = r0;
                            [r0 removeObjectForKey:@"LastUpdatedAssociations_v2"];
                    }
                    var_170 = r24;
                    [r19 release];
                    r19 = LSCopyAllRoleHandlersForContentType(@"com.codeweavers.CrossOverHelper.AppDummyType", 0xffffffff);
                    r0 = [NSMutableSet alloc];
                    var_188 = r19;
                    r0 = [r0 initWithArray:r19];
                    r9 = sign_extend_64(*(int32_t *)ivar_offset(helpersToDelete));
                    r20 = var_160;
                    r8 = *(r20 + r9);
                    var_158 = r9;
                    *(r20 + r9) = r0;
                    [r8 release];
                    var_140 = r26;
                    if (r28 != 0x0) {
                            r0 = [r28 keyEnumerator];
                            r0 = [r0 retain];
                            r19 = r0;
                            r0 = [r0 nextObject];
                            r0 = [r0 retain];
                            if (r0 != 0x0) {
                                    r22 = r0;
                                    do {
                                            r0 = [r28 objectForKey:r22];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r26 = [[r0 objectForKey:@"Description"] retain];
                                            r27 = [[r23 objectForKey:@"Extension Associations/"] retain];
                                            [r20 setupHelperAppForBottleWithTag:r22 andName:r26 andExtensions:r27];
                                            [r27 release];
                                            [r26 release];
                                            [r23 release];
                                            r23 = [[r19 nextObject] retain];
                                            [r22 release];
                                            r22 = r23;
                                    } while (r23 != 0x0);
                            }
                            [r19 release];
                            r26 = var_140;
                    }
                    var_178 = r28;
                    r0 = NSHomeDirectory();
                    r0 = [r0 retain];
                    r19 = r0;
                    r21 = [[r0 stringByStandardizingPath] retain];
                    [r19 release];
                    var_190 = r21;
                    r0 = [r21 pathComponents];
                    r0 = [r0 retain];
                    r21 = r0;
                    r28 = [r0 count];
                    if ([*(r20 + var_158) count] != 0x0) {
                            r19 = &@selector(keyPathsForValuesAffectingCanRegister);
                            do {
                                    var_130 = q0;
                                    var_120 = q0;
                                    r0 = *(r20 + var_158);
                                    r0 = [r0 retain];
                                    r27 = r0;
                                    r0 = [r0 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                                    var_138 = r0;
                                    if (r0 == 0x0) {
                                            [r27 release];
                                            break;
                                    }
                                    var_144 = 0x0;
                                    r22 = *var_120;
                                    var_150 = r27;
                                    do {
                                            r20 = 0x0;
                                            do {
                                                    if (*var_120 != r22) {
                                                            objc_enumerationMutation(r27);
                                                    }
                                                    r23 = *(var_128 + r20 * 0x8);
                                                    r25 = objc_autoreleasePoolPush();
                                                    r0 = r19[0x19f];
                                                    r0 = [r0 sharedWorkspace];
                                                    r0 = [r0 retain];
                                                    r24 = r0;
                                                    r23 = [[r0 absolutePathForAppBundleWithIdentifier:r23] retain];
                                                    [r24 release];
                                                    if (r23 != 0x0) {
                                                            if ([r26 fileExistsAtPath:r23] != 0x0) {
                                                                    r24 = [[r23 stringByStandardizingPath] retain];
                                                                    [r23 release];
                                                                    r0 = [r24 pathComponents];
                                                                    r0 = [r0 retain];
                                                                    r26 = r0;
                                                                    r0 = [r0 count];
                                                                    r0 = [r26 subarrayWithRange:0x0];
                                                                    r0 = [r0 retain];
                                                                    r23 = r0;
                                                                    if ([r0 isEqualToArray:r21] != 0x0) {
                                                                            r27 = r28;
                                                                            r28 = r19;
                                                                            r19 = r21;
                                                                            r21 = var_140;
                                                                            if ([r21 isDeletableFileAtPath:r24] != 0x0) {
                                                                                    r0 = [r21 removeItemAtPath:r24 error:0x0];
                                                                                    r8 = var_144;
                                                                                    if (r0 != 0x0) {
                                                                                            r8 = 0x1;
                                                                                    }
                                                                                    var_144 = r8;
                                                                            }
                                                                            r21 = r19;
                                                                            r19 = r28;
                                                                            r28 = r27;
                                                                            r27 = var_150;
                                                                    }
                                                                    [r23 release];
                                                                    [r26 release];
                                                                    r26 = var_140;
                                                            }
                                                            else {
                                                                    r24 = r23;
                                                            }
                                                    }
                                                    else {
                                                            r24 = 0x0;
                                                    }
                                                    [r24 release];
                                                    objc_autoreleasePoolPop(r25);
                                                    r20 = r20 + 0x1;
                                            } while (var_138 != r20);
                                            r0 = [r27 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                                            var_138 = r0;
                                    } while (r0 != 0x0);
                                    [r27 release];
                                    r20 = var_160;
                            } while ((var_144 & 0x1) != 0x0);
                    }
                    r0 = *(r20 + var_158);
                    *(r20 + var_158) = 0x0;
                    [r0 release];
                    [r21 release];
                    [var_190 release];
                    [var_188 release];
                    r24 = var_170;
                    r21 = var_168;
                    r22 = var_180;
                    r28 = var_178;
                    [r28 release];
                    [r22 release];
                    [r24 release];
                    [r26 release];
                    objc_autoreleasePoolPop(r21);
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
            }
            else {
                    [r28 release];
                    [r22 release];
                    [r24 release];
                    [r26 release];
                    objc_autoreleasePoolPop(r21);
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
            }
    }
    else {
            var_168 = r21;
            var_180 = r22;
            if (r28 != 0x0) {
                    if ([r28 count] != 0x0) {
                            if (r22 != 0x0) {
                                    r0 = [NSUserDefaults standardUserDefaults];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    [r0 setObject:r22 forKey:@"LastUpdatedAssociations_v2"];
                            }
                            else {
                                    r0 = [NSUserDefaults standardUserDefaults];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    [r0 removeObjectForKey:@"LastUpdatedAssociations_v2"];
                            }
                    }
                    else {
                            r0 = [NSUserDefaults standardUserDefaults];
                            r0 = [r0 retain];
                            r19 = r0;
                            [r0 removeObjectForKey:@"LastUpdatedAssociations_v2"];
                    }
            }
            else {
                    r0 = [NSUserDefaults standardUserDefaults];
                    r0 = [r0 retain];
                    r19 = r0;
                    [r0 removeObjectForKey:@"LastUpdatedAssociations_v2"];
            }
            var_170 = r24;
            [r19 release];
            r19 = LSCopyAllRoleHandlersForContentType(@"com.codeweavers.CrossOverHelper.AppDummyType", 0xffffffff);
            r0 = [NSMutableSet alloc];
            var_188 = r19;
            r0 = [r0 initWithArray:r19];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(helpersToDelete));
            r20 = var_160;
            r8 = *(r20 + r9);
            var_158 = r9;
            *(r20 + r9) = r0;
            [r8 release];
            var_140 = r26;
            if (r28 != 0x0) {
                    r0 = [r28 keyEnumerator];
                    r0 = [r0 retain];
                    r19 = r0;
                    r0 = [r0 nextObject];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r22 = r0;
                            do {
                                    r0 = [r28 objectForKey:r22];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r26 = [[r0 objectForKey:@"Description"] retain];
                                    r27 = [[r23 objectForKey:@"Extension Associations/"] retain];
                                    [r20 setupHelperAppForBottleWithTag:r22 andName:r26 andExtensions:r27];
                                    [r27 release];
                                    [r26 release];
                                    [r23 release];
                                    r23 = [[r19 nextObject] retain];
                                    [r22 release];
                                    r22 = r23;
                            } while (r23 != 0x0);
                    }
                    [r19 release];
                    r26 = var_140;
            }
            var_178 = r28;
            r0 = NSHomeDirectory();
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 stringByStandardizingPath] retain];
            [r19 release];
            var_190 = r21;
            r0 = [r21 pathComponents];
            r0 = [r0 retain];
            r21 = r0;
            r28 = [r0 count];
            if ([*(r20 + var_158) count] != 0x0) {
                    r19 = &@selector(keyPathsForValuesAffectingCanRegister);
                    do {
                            var_130 = q0;
                            var_120 = q0;
                            r0 = *(r20 + var_158);
                            r0 = [r0 retain];
                            r27 = r0;
                            r0 = [r0 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                            var_138 = r0;
                            if (r0 == 0x0) {
                                    [r27 release];
                                    break;
                            }
                            var_144 = 0x0;
                            r22 = *var_120;
                            var_150 = r27;
                            do {
                                    r20 = 0x0;
                                    do {
                                            if (*var_120 != r22) {
                                                    objc_enumerationMutation(r27);
                                            }
                                            r23 = *(var_128 + r20 * 0x8);
                                            r25 = objc_autoreleasePoolPush();
                                            r0 = r19[0x19f];
                                            r0 = [r0 sharedWorkspace];
                                            r0 = [r0 retain];
                                            r24 = r0;
                                            r23 = [[r0 absolutePathForAppBundleWithIdentifier:r23] retain];
                                            [r24 release];
                                            if (r23 != 0x0) {
                                                    if ([r26 fileExistsAtPath:r23] != 0x0) {
                                                            r24 = [[r23 stringByStandardizingPath] retain];
                                                            [r23 release];
                                                            r0 = [r24 pathComponents];
                                                            r0 = [r0 retain];
                                                            r26 = r0;
                                                            r0 = [r0 count];
                                                            r0 = [r26 subarrayWithRange:0x0];
                                                            r0 = [r0 retain];
                                                            r23 = r0;
                                                            if ([r0 isEqualToArray:r21] != 0x0) {
                                                                    r27 = r28;
                                                                    r28 = r19;
                                                                    r19 = r21;
                                                                    r21 = var_140;
                                                                    if ([r21 isDeletableFileAtPath:r24] != 0x0) {
                                                                            r0 = [r21 removeItemAtPath:r24 error:0x0];
                                                                            r8 = var_144;
                                                                            if (r0 != 0x0) {
                                                                                    r8 = 0x1;
                                                                            }
                                                                            var_144 = r8;
                                                                    }
                                                                    r21 = r19;
                                                                    r19 = r28;
                                                                    r28 = r27;
                                                                    r27 = var_150;
                                                            }
                                                            [r23 release];
                                                            [r26 release];
                                                            r26 = var_140;
                                                    }
                                                    else {
                                                            r24 = r23;
                                                    }
                                            }
                                            else {
                                                    r24 = 0x0;
                                            }
                                            [r24 release];
                                            objc_autoreleasePoolPop(r25);
                                            r20 = r20 + 0x1;
                                    } while (var_138 != r20);
                                    r0 = [r27 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                                    var_138 = r0;
                            } while (r0 != 0x0);
                            [r27 release];
                            r20 = var_160;
                    } while ((var_144 & 0x1) != 0x0);
            }
            r0 = *(r20 + var_158);
            *(r20 + var_158) = 0x0;
            [r0 release];
            [r21 release];
            [var_190 release];
            [var_188 release];
            r24 = var_170;
            r21 = var_168;
            r22 = var_180;
            r28 = var_178;
            [r28 release];
            [r22 release];
            [r24 release];
            [r26 release];
            objc_autoreleasePoolPop(r21);
            if (**___stack_chk_guard != var_60) {
                    __stack_chk_fail();
            }
    }
    return;


// 0x10004f2b4
// -[CXServerCrossOver getAssociationDictionaryForKey:withExtensionAssociations:]
    var_40 = r26;
    decomp_var_38 = r25;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r0 = [r19 componentsSeparatedByString:@"/"];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 count] >= 0x2) {
            r23 = 0x1;
            while (true) {
                    r0 = [r21 objectAtIndex:r23];
                    r0 = [r0 retain];
                    r22 = r0;
                    r25 = [r0 length];
                    [r22 release];
                    if (r25 == 0x0) {
                            r23 = r23 + 0x1;
                            if ([r21 count] > r23) {
                                    continue;
                            }
                            temp_0 = 0x0;
                            break;
                    }
                    if (r23 != 0x2) {
                            temp_0 = 0x2;
                            break;
                    }
                    r0 = [r21 objectAtIndex:0x2];
                    r0 = [r0 retain];
                    r22 = r0;
                    if ([r0 caseInsensitiveCompare:@"open"] != 0x0) {
                            r23 = 0x0;
                            temp_0 = 0x1;
                            break;
                    }
                    r25 = [[r21 objectAtIndex:0x0] retain];
                    r0 = [r20 objectForKey:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    [r0 release];
                    [r25 release];
                    [r22 release];
                    if (r26 != 0x0) {
                            temp_0 = 0x2;
                            break;
                    }
                    r23 = r23 + 0x1;
                    if ([r21 count] > r23) {
                            continue;
                    }
                    temp_0 = 0x0;
                    break;
            }
            if (temp_0 != 0x0) {
                    if (temp_0 != 0x1) {
                            r23 = 0x0;
                    }
                    else {
                            [r22 release];
                    }
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    r0 = [r23 autorelease];
            }
            else {
                    r0 = [r20 objectForKey:r19];
                    r0 = [r0 retain];
                    r22 = r0;
                    r0 = [r0 objectForKey:@"Extension"];
                    r0 = [r0 retain];
                    r24 = r0;
                    if (r0 == 0x0) {
                            r0 = [r21 objectAtIndex:0x0];
                            r0 = [r0 retain];
                            r23 = r0;
                            r24 = [[r0 substringFromIndex:0x1] retain];
                            [r23 release];
                    }
                    r23 = [[NSMutableDictionary dictionaryWithCapacity:0xa] retain];
                    if (r24 != 0x0) {
                            r25 = [[NSArray arrayWithObject:r24] retain];
                            [r23 setObject:r25 forKey:@"CFBundleTypeExtensions"];
                            [r25 release];
                            [r23 setObject:r24 forKey:@"CFBundleTypeIconFile"];
                            r0 = [r22 objectForKey:@"Icon"];
                            r0 = [r0 retain];
                            r25 = r0;
                            if (r0 != 0x0) {
                                    [r23 setObject:r25 forKey:@"IconSourceFile"];
                            }
                            r0 = [r22 objectForKey:@"RobustIcon"];
                            r0 = [r0 retain];
                            r26 = r0;
                            if (r0 != 0x0) {
                                    [r23 setObject:r26 forKey:@"RobustIconSourceFile"];
                            }
                            [r26 release];
                            [r25 release];
                    }
                    r0 = [r22 objectForKey:@"Description"];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            [r23 setObject:r26 forKey:@"CFBundleTypeName"];
                    }
                    r25 = [[r22 objectForKey:@"Application ID"] retain];
                    [r26 release];
                    if (r25 != 0x0) {
                            [r23 setObject:r25 forKey:@"CXAssocationAppID"];
                    }
                    r26 = [[r22 objectForKey:@"Application Name"] retain];
                    [r25 release];
                    if (r26 != 0x0) {
                            [r23 setObject:r26 forKey:@"CXAssocationAppName"];
                    }
                    r25 = [[r22 objectForKey:@"Command"] retain];
                    [r26 release];
                    if (r25 != 0x0) {
                            [r23 setObject:r25 forKey:@"CXAssocationCommand"];
                    }
                    r26 = [[r22 objectForKey:@"Verb"] retain];
                    [r25 release];
                    if (r26 != 0x0) {
                            [r23 setObject:r26 forKey:@"CXAssocationVerb"];
                    }
                    r25 = [[r22 objectForKey:@"Verb Name"] retain];
                    [r26 release];
                    if (r25 != 0x0) {
                            [r23 setObject:r25 forKey:@"CXAssocationVerbName"];
                    }
                    [r23 setObject:@"Editor" forKey:@"CFBundleTypeRole"];
                    [r25 release];
                    [r24 release];
                    [r22 release];
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    r0 = [r23 autorelease];
            }
    }
    else {
            r0 = [r20 objectForKey:r19];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 objectForKey:@"Extension"];
            r0 = [r0 retain];
            r24 = r0;
            if (r0 == 0x0) {
                    r0 = [r21 objectAtIndex:0x0];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [[r0 substringFromIndex:0x1] retain];
                    [r23 release];
            }
            r23 = [[NSMutableDictionary dictionaryWithCapacity:0xa] retain];
            if (r24 != 0x0) {
                    r25 = [[NSArray arrayWithObject:r24] retain];
                    [r23 setObject:r25 forKey:@"CFBundleTypeExtensions"];
                    [r25 release];
                    [r23 setObject:r24 forKey:@"CFBundleTypeIconFile"];
                    r0 = [r22 objectForKey:@"Icon"];
                    r0 = [r0 retain];
                    r25 = r0;
                    if (r0 != 0x0) {
                            [r23 setObject:r25 forKey:@"IconSourceFile"];
                    }
                    r0 = [r22 objectForKey:@"RobustIcon"];
                    r0 = [r0 retain];
                    r26 = r0;
                    if (r0 != 0x0) {
                            [r23 setObject:r26 forKey:@"RobustIconSourceFile"];
                    }
                    [r26 release];
                    [r25 release];
            }
            r0 = [r22 objectForKey:@"Description"];
            r0 = [r0 retain];
            r26 = r0;
            if (r0 != 0x0) {
                    [r23 setObject:r26 forKey:@"CFBundleTypeName"];
            }
            r25 = [[r22 objectForKey:@"Application ID"] retain];
            [r26 release];
            if (r25 != 0x0) {
                    [r23 setObject:r25 forKey:@"CXAssocationAppID"];
            }
            r26 = [[r22 objectForKey:@"Application Name"] retain];
            [r25 release];
            if (r26 != 0x0) {
                    [r23 setObject:r26 forKey:@"CXAssocationAppName"];
            }
            r25 = [[r22 objectForKey:@"Command"] retain];
            [r26 release];
            if (r25 != 0x0) {
                    [r23 setObject:r25 forKey:@"CXAssocationCommand"];
            }
            r26 = [[r22 objectForKey:@"Verb"] retain];
            [r25 release];
            if (r26 != 0x0) {
                    [r23 setObject:r26 forKey:@"CXAssocationVerb"];
            }
            r25 = [[r22 objectForKey:@"Verb Name"] retain];
            [r26 release];
            if (r25 != 0x0) {
                    [r23 setObject:r25 forKey:@"CXAssocationVerbName"];
            }
            [r23 setObject:@"Editor" forKey:@"CFBundleTypeRole"];
            [r25 release];
            [r24 release];
            [r22 release];
            [r21 release];
            [r20 release];
            [r19 release];
            r0 = [r23 autorelease];
    }
    return r0;


// 0x10004f6f0
// -[CXServerCrossOver setupHelperAppForBottleWithTag:andName:andExtensions:]
    r0 = [self setupHelperAppForBottleWithTag:arg2 andName:arg3 andExtensions:arg4 usingExistingHelper:0x0];
    return r0;


// 0x10004f6f8
// -[CXServerCrossOver findBestApplicationForDocType:withProgramsDict:]
    r31 = r31 - 0xd0;
    var_70 = d11;
    decomp_var_68 = d10;
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
    var_98 = self;
    r24 = [arg2 retain];
    r23 = [arg3 retain];
    r21 = [@(0x0) retain];
    r20 = [[NSArray arrayWithObjects:r21] retain];
    r22 = [[NSArray arrayWithObjects:@"rank"] retain];
    r25 = [[NSDictionary dictionaryWithObjects:r20 forKeys:r22] retain];
    [r22 release];
    [r20 release];
    [r21 release];
    var_90 = r24;
    r0 = [r24 objectForKey:@"CXAssocationAppName"];
    r0 = [r0 retain];
    r27 = r0;
    if (r0 != 0x0) {
            r0 = [r23 keyEnumerator];
            r0 = [r0 retain];
            var_80 = r0;
            r0 = [r0 nextObject];
            r0 = [r0 retain];
            r21 = r23;
            if (r0 != 0x0) {
                    r24 = r0;
                    var_88 = r21;
                    var_78 = r27;
                    while (true) {
                            r0 = [r21 objectForKey:r24];
                            r0 = [r0 retain];
                            r26 = r0;
                            r0 = [r0 objectForKey:@"Children"];
                            r0 = [r0 retain];
                            r19 = r0;
                            [r0 release];
                            r0 = r26;
                            if (r19 != 0x0) {
                                    r19 = [[r0 objectForKey:@"Children"] retain];
                                    r22 = [[var_98 findBestApplicationForDocType:var_90 withProgramsDict:r19] retain];
                                    [r19 release];
                                    r0 = [r22 objectForKey:@"rank"];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r20 = [r0 intValue];
                                    r0 = [r25 objectForKey:@"rank"];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r27 = [r0 intValue];
                                    [r23 release];
                                    [r19 release];
                                    if (r20 > r27) {
                                            r0 = [r22 retain];
                                            r22 = r0;
                                            r19 = r0;
                                            r27 = var_78;
                                            [r25 release];
                                            r25 = r19;
                                    }
                                    else {
                                            r27 = var_78;
                                    }
                                    [r22 release];
                                    [r26 release];
                                    r19 = [[var_80 nextObject] retain];
                                    [r24 release];
                                    r24 = r19;
                                    if (r19 != 0x0) {
                                            continue;
                                    }
                                    temp_0 = 0x0;
                                    break;
                            }
                            else {
                                    r22 = [[r0 objectForKey:@"RawPath"] retain];
                                    if ([r27 compare:r24 options:0x1] != 0x0) {
                                            if ([r27 rangeOfString:r24 options:0x1] != 0x7fffffffffffffff) {
                                                    r28 = @"rank";
                                                    r19 = [r27 retain];
                                                    [r24 length];
                                                    [r19 length];
                                                    [r19 release];
                                                    asm { fcvt       d0, s0 };
                                                    asm { fmadd      d0, d0, d9, d8 };
                                                    asm { fcvtzs     w8, d0 };
                                                    r2 = r28;
                                                    r0 = [r25 objectForKey:r2];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    r20 = [r0 integerValue];
                                                    [r19 release];
                                                    if (r20 < sign_extend_64(r8 + 0x5d)) {
                                                            r28 = @"rank";
                                                            asm { sxtw       x2, w21 };
                                                            r23 = [[NSNumber numberWithInteger:r2] retain];
                                                            r20 = [[NSArray arrayWithObjects:r23] retain];
                                                            r27 = [[NSArray arrayWithObjects:r28] retain];
                                                            r19 = [[NSDictionary dictionaryWithObjects:r20 forKeys:r27] retain];
                                                            [r25 release];
                                                            r0 = r27;
                                                            r27 = var_78;
                                                            [r0 release];
                                                            [r20 release];
                                                            [r23 release];
                                                            r25 = r19;
                                                    }
                                                    r21 = var_88;
                                            }
                                            if ([r24 rangeOfString:r27 options:0x1] == 0x7fffffffffffffff) {
                                                    r19 = r25;
                                            }
                                            else {
                                                    r19 = [r24 retain];
                                                    [r27 length];
                                                    [r19 length];
                                                    [r19 release];
                                                    asm { fcvt       d0, s0 };
                                                    asm { fmadd      d0, d0, d9, d8 };
                                                    asm { fcvtzs     w8, d0 };
                                                    r0 = [r25 objectForKey:@"rank"];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    r20 = [r0 integerValue];
                                                    [r19 release];
                                                    if (r20 < sign_extend_64(r8 + 0x5e)) {
                                                            r28 = @"rank";
                                                            r2 = @"rank";
                                                            asm { sxtw       x2, w21 };
                                                            r23 = [[NSNumber numberWithInteger:r2] retain];
                                                            r20 = [[NSArray arrayWithObjects:r23] retain];
                                                            r27 = [[NSArray arrayWithObjects:r28] retain];
                                                            r19 = [[NSDictionary dictionaryWithObjects:r20 forKeys:r27] retain];
                                                            [r25 release];
                                                            r0 = r27;
                                                            r27 = var_78;
                                                            [r0 release];
                                                            [r20 release];
                                                            [r23 release];
                                                    }
                                                    else {
                                                            r19 = r25;
                                                    }
                                                    r21 = var_88;
                                            }
                                            r20 = [[NSCharacterSet decimalDigitCharacterSet] retain];
                                            r23 = [[r24 stringByTrimmingCharactersInSet:r20] retain];
                                            [r20 release];
                                            r20 = [[NSCharacterSet whitespaceCharacterSet] retain];
                                            r25 = [[r23 stringByTrimmingCharactersInSet:r20] retain];
                                            [r23 release];
                                            [r20 release];
                                            if ([r27 compare:r25 options:0x1] == 0x0) {
                                                    r0 = [r19 objectForKey:@"rank"];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    r23 = [r0 integerValue];
                                                    [r20 release];
                                                    if (r23 <= 0x59) {
                                                            r27 = [@(0x5a) retain];
                                                            r23 = [[NSArray arrayWithObjects:r27] retain];
                                                            r28 = [[NSArray arrayWithObjects:@"rank"] retain];
                                                            r20 = [[NSDictionary dictionaryWithObjects:r23 forKeys:r28] retain];
                                                            [r19 release];
                                                            [r28 release];
                                                            [r23 release];
                                                            r0 = r27;
                                                            r27 = var_78;
                                                            [r0 release];
                                                            r19 = r20;
                                                    }
                                            }
                                            if ([r27 rangeOfString:r25 options:0x1] != 0x7fffffffffffffff) {
                                                    r20 = [r27 retain];
                                                    [r25 length];
                                                    [r20 length];
                                                    [r20 release];
                                                    asm { fcvt       d0, s0 };
                                                    asm { fmadd      d0, d0, d9, d8 };
                                                    asm { fcvtzs     w8, d0 };
                                                    r0 = [r19 objectForKey:@"rank"];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    r23 = [r0 integerValue];
                                                    [r20 release];
                                                    if (r23 < sign_extend_64(r8 + 0x54)) {
                                                            r28 = @"rank";
                                                            r2 = @"rank";
                                                            asm { sxtw       x2, w21 };
                                                            r27 = [[NSNumber numberWithInteger:r2] retain];
                                                            r23 = [[NSArray arrayWithObjects:r27] retain];
                                                            r28 = [[NSArray arrayWithObjects:r28] retain];
                                                            r20 = [[NSDictionary dictionaryWithObjects:r23 forKeys:r28] retain];
                                                            [r19 release];
                                                            [r28 release];
                                                            [r23 release];
                                                            r0 = r27;
                                                            r27 = var_78;
                                                            [r0 release];
                                                            r19 = r20;
                                                    }
                                                    r21 = var_88;
                                            }
                                            if ([r25 rangeOfString:r27 options:0x1] != 0x7fffffffffffffff) {
                                                    r20 = [r25 retain];
                                                    [r27 length];
                                                    [r20 length];
                                                    [r20 release];
                                                    asm { fcvt       d0, s0 };
                                                    asm { fmadd      d0, d0, d9, d8 };
                                                    asm { fcvtzs     w8, d0 };
                                                    r0 = [r19 objectForKey:@"rank"];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    r23 = [r0 integerValue];
                                                    [r20 release];
                                                    if (r23 < sign_extend_64(r8 + 0x53)) {
                                                            r28 = @"rank";
                                                            r2 = @"rank";
                                                            asm { sxtw       x2, w21 };
                                                            r27 = [[NSNumber numberWithInteger:r2] retain];
                                                            r23 = [[NSArray arrayWithObjects:r27] retain];
                                                            r28 = [[NSArray arrayWithObjects:r28] retain];
                                                            r20 = [[NSDictionary dictionaryWithObjects:r23 forKeys:r28] retain];
                                                            [r19 release];
                                                            [r28 release];
                                                            [r23 release];
                                                            r0 = r27;
                                                            r27 = var_78;
                                                            [r0 release];
                                                            r19 = r20;
                                                    }
                                                    r21 = var_88;
                                            }
                                            r23 = [[r27 componentsSeparatedByString:@" "] retain];
                                            r27 = [[NSSet setWithArray:r23] retain];
                                            [r23 release];
                                            r23 = [[r24 componentsSeparatedByString:@" "] retain];
                                            r20 = [[NSMutableSet setWithArray:r23] retain];
                                            [r23 release];
                                            [r20 intersectSet:r27];
                                            r0 = [r20 count];
                                            if (r0 >= 0x2) {
                                                    r23 = r0;
                                                    if (r23 >= [r27 count] - 0x2) {
                                                            r0 = [r19 objectForKey:@"rank"];
                                                            r0 = [r0 retain];
                                                            r28 = r0;
                                                            r21 = [r0 integerValue];
                                                            [r28 release];
                                                            if (r23 > r21) {
                                                                    r0 = [NSNumber numberWithInteger:r23];
                                                                    r0 = [r0 retain];
                                                                    var_A0 = r0;
                                                                    r28 = [[NSArray arrayWithObjects:r0] retain];
                                                                    r21 = [[NSArray arrayWithObjects:@"rank"] retain];
                                                                    r23 = [[NSDictionary dictionaryWithObjects:r28 forKeys:r21] retain];
                                                                    [r19 release];
                                                                    [r21 release];
                                                                    [r28 release];
                                                                    [var_A0 release];
                                                                    r19 = r23;
                                                            }
                                                            r21 = var_88;
                                                    }
                                            }
                                            [r20 release];
                                            [r27 release];
                                            r27 = var_78;
                                            [r25 release];
                                            r25 = r19;
                                            [r22 release];
                                            [r26 release];
                                            r19 = [[var_80 nextObject] retain];
                                            [r24 release];
                                            r24 = r19;
                                            if (r19 != 0x0) {
                                                    continue;
                                            }
                                            temp_0 = 0x0;
                                            break;
                                    }
                                    else {
                                            r23 = [@(0x64) retain];
                                            r20 = [[NSArray arrayWithObjects:r23] retain];
                                            r27 = [[NSArray arrayWithObjects:@"rank"] retain];
                                            r19 = [[NSDictionary dictionaryWithObjects:r20 forKeys:r27] retain];
                                            [r25 release];
                                            r0 = r27;
                                            r27 = var_78;
                                            [r0 release];
                                            [r20 release];
                                            [r23 release];
                                            [r22 release];
                                            [r26 release];
                                            [r24 release];
                                            r25 = r19;
                                            temp_0 = 0x1;
                                            break;
                                    }
                            }
                    }
            }
            r19 = [r25 retain];
            [var_80 release];
    }
    else {
            r19 = [r25 retain];
            r21 = r23;
    }
    [r27 release];
    [r19 release];
    [r21 release];
    [var_90 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100050370
// -[CXServerCrossOver findBestApplicationForDocType:forBottle:]
    var_50 = r28;
    decomp_var_48 = r27;
    r31 = r31 + 0xffffffffffffffa0;
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
    r21 = [arg3 retain];
    r23 = [arg2 retain];
    r19 = [[NSUserDefaults standardUserDefaults] retain];
    r20 = [[r19 dictionaryForKey:@"MostRecentCXFBMenuPlist"] retain];
    [r19 release];
    r19 = CFPropertyListCreateDeepCopy(0x0, r20, 0x0);
    [r20 release];
    r20 = [[r19 objectForKey:r21] retain];
    [r21 release];
    r0 = [r20 valueForKeyPath:@"Children.StartMenu/.Children"];
    r0 = [r0 retain];
    r21 = r0;
    r26 = [[r0 valueForKeyPath:@"Programs/.Children"] retain];
    r24 = [[self findBestApplicationForDocType:r23 withProgramsDict:r26] retain];
    r25 = [[r21 valueForKeyPath:@"Windows Applications/.Children"] retain];
    [r26 release];
    r22 = [[self findBestApplicationForDocType:r23 withProgramsDict:r25] retain];
    [r23 release];
    r0 = [r24 objectForKey:@"rank"];
    r0 = [r0 retain];
    r26 = r0;
    r27 = [r0 intValue];
    r0 = [r22 objectForKey:@"rank"];
    r0 = [r0 retain];
    r23 = r0;
    r28 = [r0 intValue];
    [r23 release];
    [r26 release];
    if (r27 <= r28) {
            r0 = r22;
    }
    else {
            r0 = r24;
    }
    r23 = [[r0 objectForKey:@"menuPath"] retain];
    [r22 release];
    [r24 release];
    [r25 release];
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = [r23 autorelease];
    return r0;


// 0x100050588
// -[CXServerCrossOver findMenusForAssociations:]
    r31 = r31 - 0x160;
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
    var_128 = [[NSMutableDictionary dictionary] retain];
    var_150 = objc_autoreleasePoolPush();
    var_140 = r19;
    r0 = [r19 keyEnumerator];
    r0 = [r0 retain];
    var_148 = r0;
    r0 = [r0 nextObject];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r24 = r0;
            do {
                    r0 = [var_140 objectForKey:r24];
                    r0 = [r0 retain];
                    var_138 = r0;
                    r0 = [r0 objectForKey:@"Extension Associations/"];
                    r0 = [r0 retain];
                    r27 = r0;
                    var_120 = q0;
                    var_110 = q0;
                    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    if (r0 != 0x0) {
                            r28 = r0;
                            r26 = *var_110;
                            var_130 = r27;
                            do {
                                    r22 = 0x0;
                                    do {
                                            if (*var_110 != r26) {
                                                    objc_enumerationMutation(r27);
                                            }
                                            r25 = *(var_118 + r22 * 0x8);
                                            r0 = [r20 getAssociationDictionaryForKey:r25 withExtensionAssociations:r27];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            if (r0 != 0x0) {
                                                    r19 = [[r20 findBestApplicationForDocType:r21 forBottle:r24] retain];
                                                    r0 = [var_128 objectForKey:r24];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    if (r0 == 0x0) {
                                                            r23 = [[NSMutableDictionary dictionary] retain];
                                                            [var_128 setObject:r23 forKey:r24];
                                                            [r23 release];
                                                            r20 = r20;
                                                            r26 = r26;
                                                            r28 = r28;
                                                            r27 = var_130;
                                                            r23 = [[var_128 objectForKey:r24] retain];
                                                    }
                                                    [r23 setObject:r19 forKey:r25];
                                                    [r23 release];
                                                    [r19 release];
                                            }
                                            [r21 release];
                                            r22 = r22 + 0x1;
                                    } while (r28 != r22);
                                    r0 = [r27 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                                    r28 = r0;
                            } while (r0 != 0x0);
                    }
                    [r27 release];
                    [var_138 release];
                    r19 = [[var_148 nextObject] retain];
                    [r24 release];
                    r24 = r19;
            } while (r19 != 0x0);
    }
    r19 = [var_128 retain];
    [var_148 release];
    objc_autoreleasePoolPop(var_150);
    [r19 release];
    r0 = [var_140 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x100050848
// -[CXServerCrossOver setupHelperAppForBottleWithTag:andName:andExtensions:usingExistingHelper:]
    r3 = arg3;
    r1 = _cmd;
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
    r31 = r31 + 0xffffffffffffffa0 - 0x1c0;
    r22 = r3;
    r27 = self;
    var_60 = **___stack_chk_guard;
    r24 = [arg2 retain];
    var_178 = [r22 retain];
    r26 = [arg4 retain];
    r21 = [arg5 retain];
    r0 = [[NSFileManager alloc] init];
    r28 = r0;
    [r0 setDelegate:r27];
    r23 = [r21 retain];
    var_170 = r27;
    if (r21 != 0x0) {
            if (([r28 isWritableFileAtPath:r23] & 0x1) != 0x0) {
                    var_1B4 = 0x0;
                    r19 = r23;
                    r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                    r0 = [r0 retain];
                    r20 = r0;
                    r8 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                    r0 = r20;
                    r20 = r8;
                    [r0 release];
                    r2 = [[NSData dataWithContentsOfFile:r20] retain];
                    var_118 = 0x0;
                    var_1B0 = r2;
                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                    r22 = [r0 retain];
                    r0 = [var_118 retain];
                    var_190 = r22;
                    var_1A8 = 0x0;
                    var_1A0 = 0x0;
                    if (r22 != 0x0) {
                            var_1D0 = r0;
                            var_1E0 = r20;
                            [r22 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                            [r22 setObject:r24 forKey:@"CXHelperAppBottleTag"];
                            r20 = [@(0x2b) retain];
                            [r22 setObject:r20 forKey:@"CXHelperAppVersion"];
                            [r20 release];
                            var_1C8 = r28;
                            var_1C0 = r23;
                            var_198 = r21;
                            if (r21 != 0x0) {
                                    r0 = [r22 valueForKey:**_kCFBundleIdentifierKey];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 release];
                                    if (r21 == 0x0) {
                                            r20 = **_kCFBundleIdentifierKey;
                                            r21 = [[var_170 shortenedBundleID:0x0] retain];
                                            [r22 setObject:r21 forKey:r20];
                                            [r21 release];
                                    }
                                    r0 = [r22 valueForKey:**_kCFBundleNameKey];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 release];
                                    if (r21 == 0x0) {
                                            [r22 setObject:0x0 forKey:**_kCFBundleNameKey];
                                    }
                            }
                            else {
                                    r20 = [[var_170 shortenedBundleID:0x0] retain];
                                    [r22 setObject:r20 forKey:**_kCFBundleIdentifierKey];
                                    [r20 release];
                                    [r22 setObject:0x0 forKey:**_kCFBundleNameKey];
                                    r0 = [r22 valueForKey:**_kUTImportedTypeDeclarationsKey];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 release];
                                    if (r21 == 0x0) {
                                            r20 = **_kUTImportedTypeDeclarationsKey;
                                            r21 = [[NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:**_kUTTypeIdentifierKey] retain];
                                            r22 = [[NSArray arrayWithObject:r21] retain];
                                            [var_190 setObject:r22 forKey:r20];
                                            r0 = r22;
                                            r22 = var_190;
                                            [r0 release];
                                            [r21 release];
                                    }
                            }
                            var_1D8 = r19;
                            r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                            r0 = [r0 retain];
                            r20 = r0;
                            var_188 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
                            [r20 release];
                            r21 = [[r22 objectForKey:@"CrossOverHelperMenuPath"] retain];
                            var_180 = [[NSMutableArray arrayWithCapacity:[r26 count] + 0x1] retain];
                            var_160 = q0;
                            var_150 = q0;
                            var_1E8 = r26;
                            r0 = [r26 retain];
                            r22 = r0;
                            r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                            r26 = var_170;
                            if (r0 != 0x0) {
                                    r25 = r0;
                                    r23 = *var_150;
                                    do {
                                            r19 = 0x0;
                                            do {
                                                    if (*var_150 != r23) {
                                                            objc_enumerationMutation(r22);
                                                    }
                                                    r20 = *(var_158 + r19 * 0x8);
                                                    r0 = [r26 getAssociationDictionaryForKey:r20 withExtensionAssociations:r22];
                                                    r0 = [r0 retain];
                                                    r27 = r0;
                                                    if (r0 != 0x0) {
                                                            r0 = r26->relateDocTypesToMenus;
                                                            r26 = r24;
                                                            r0 = [r0 objectForKey:r24];
                                                            r0 = [r0 retain];
                                                            r24 = r0;
                                                            r20 = [[r0 objectForKey:r20] retain];
                                                            if (r21 != 0x0) {
                                                                    if (r20 != 0x0 && [r20 length] != 0x0) {
                                                                            if ([r20 compare:r21 options:0x1] == 0x0) {
                                                                                    [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    if ([r20 length] == 0x0) {
                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                    }
                                                            }
                                                            [r20 release];
                                                            [r24 release];
                                                            r24 = r26;
                                                            r26 = var_170;
                                                    }
                                                    [r27 release];
                                                    r19 = r19 + 0x1;
                                            } while (r25 != r19);
                                            r0 = [r22 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                            r25 = r0;
                                    } while (r0 != 0x0);
                            }
                            [r22 release];
                            if (var_198 == 0x0) {
                                    r22 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType"] retain];
                                    r20 = [[NSDictionary dictionaryWithObjectsAndKeys:r22] retain];
                                    [var_180 addObject:r20];
                                    [r20 release];
                                    [r22 release];
                            }
                            [var_190 setObject:var_180 forKey:@"CFBundleDocumentTypes"];
                            r22 = [[NSArray arrayWithObject:@"mailto"] retain];
                            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Email Address URL"] retain];
                            [r22 release];
                            var_170 = r20;
                            r20 = [[NSArray arrayWithObject:r20] retain];
                            [var_190 setObject:r20 forKey:@"CFBundleURLTypes"];
                            [r20 release];
                            var_168 = 0x0;
                            r2 = var_190;
                            r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_168];
                            r27 = [r0 retain];
                            r25 = [var_168 retain];
                            [var_1D0 release];
                            [var_1B0 release];
                            r28 = var_1C8;
                            r23 = var_1C0;
                            if (r27 != 0x0) {
                                    r20 = var_1E0;
                                    r19 = var_1D8;
                                    if (([r27 writeToFile:r20 atomically:0x1] & 0x1) != 0x0) {
                                            [r26 informSystemOfUpdatedApp:r19];
                                            r22 = 0x1;
                                            r26 = var_1E8;
                                    }
                                    else {
                                            NSLog(@"Failed to write %@\n", r1);
                                            r26 = var_1E8;
                                            if (var_1B4 != 0x0) {
                                                    [r28 removeItemAtPath:r19 error:0x0];
                                            }
                                            r22 = 0x0;
                                    }
                            }
                            else {
                                    r20 = var_1E0;
                                    NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                    r19 = var_1D8;
                                    if (var_1B4 != 0x0) {
                                            [r28 removeItemAtPath:r19 error:0x0];
                                    }
                                    r22 = 0x0;
                                    r26 = var_1E8;
                            }
                            [var_170 release];
                            [var_180 release];
                            [r21 release];
                            [var_188 release];
                    }
                    else {
                            r25 = r0;
                            NSLog(@"Couldn't parse %@: %@\n", r1, r2);
                            if (var_1B4 != 0x0) {
                                    [r28 removeItemAtPath:r19 error:0x0];
                            }
                            r22 = 0x0;
                            r27 = var_1B0;
                    }
                    [var_190 release];
                    [r25 release];
                    [r27 release];
                    [r20 release];
                    [var_1A0 release];
                    [var_1A8 release];
                    [r19 release];
                    [r28 release];
                    [r23 release];
                    [r26 release];
                    [var_178 release];
                    r0 = [r24 release];
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = r22;
            }
            else {
                    NSLog(@"Specified helper app %@ is not writable.\n", r1);
                    r19 = r23;
                    [r19 release];
                    [r28 release];
                    [r23 release];
                    [r26 release];
                    [var_178 release];
                    r0 = [r24 release];
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = 0x0;
            }
    }
    else {
            var_198 = r21;
            r25 = [[NSString stringWithFormat:@"com.codeweavers.CrossOverHelper.%@", r3] retain];
            [r27->helpersToDelete removeObject:r25];
            r0 = [NSWorkspace sharedWorkspace];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 absolutePathForAppBundleWithIdentifier:r25] retain];
            [r21 release];
            if (r20 != 0x0 && ([r28 isWritableFileAtPath:r20] & 0x1) == 0x0) {
                    [r20 release];
                    r20 = 0x0;
            }
            r19 = [[NSString stringWithFormat:@"CrossOver Helper (%@).app", r3] retain];
            if (r20 != 0x0) {
                    var_1B4 = 0x0;
                    r27 = r19;
                    r19 = r20;
                    r21 = var_198;
                    r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                    r0 = [r0 retain];
                    r20 = r0;
                    r8 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                    r0 = r20;
                    r20 = r8;
                    [r0 release];
                    r2 = [[NSData dataWithContentsOfFile:r20] retain];
                    var_118 = 0x0;
                    var_1B0 = r2;
                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                    r22 = [r0 retain];
                    r0 = [var_118 retain];
                    var_190 = r22;
                    var_1A8 = r27;
                    var_1A0 = r25;
                    if (r22 != 0x0) {
                            var_1D0 = r0;
                            var_1E0 = r20;
                            [r22 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                            [r22 setObject:r24 forKey:@"CXHelperAppBottleTag"];
                            r20 = [@(0x2b) retain];
                            [r22 setObject:r20 forKey:@"CXHelperAppVersion"];
                            [r20 release];
                            var_1C8 = r28;
                            var_1C0 = r23;
                            var_198 = r21;
                            if (r21 != 0x0) {
                                    r0 = [r22 valueForKey:**_kCFBundleIdentifierKey];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 release];
                                    if (r21 == 0x0) {
                                            r20 = **_kCFBundleIdentifierKey;
                                            r21 = [[var_170 shortenedBundleID:r25] retain];
                                            [r22 setObject:r21 forKey:r20];
                                            [r21 release];
                                    }
                                    r0 = [r22 valueForKey:**_kCFBundleNameKey];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 release];
                                    if (r21 == 0x0) {
                                            [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                    }
                            }
                            else {
                                    r20 = [[var_170 shortenedBundleID:r25] retain];
                                    [r22 setObject:r20 forKey:**_kCFBundleIdentifierKey];
                                    [r20 release];
                                    [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                    r0 = [r22 valueForKey:**_kUTImportedTypeDeclarationsKey];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 release];
                                    if (r21 == 0x0) {
                                            r20 = **_kUTImportedTypeDeclarationsKey;
                                            r21 = [[NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:**_kUTTypeIdentifierKey] retain];
                                            r22 = [[NSArray arrayWithObject:r21] retain];
                                            [var_190 setObject:r22 forKey:r20];
                                            r0 = r22;
                                            r22 = var_190;
                                            [r0 release];
                                            [r21 release];
                                    }
                            }
                            var_1D8 = r19;
                            r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                            r0 = [r0 retain];
                            r20 = r0;
                            var_188 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
                            [r20 release];
                            r21 = [[r22 objectForKey:@"CrossOverHelperMenuPath"] retain];
                            var_180 = [[NSMutableArray arrayWithCapacity:[r26 count] + 0x1] retain];
                            var_160 = q0;
                            var_150 = q0;
                            var_1E8 = r26;
                            r0 = [r26 retain];
                            r22 = r0;
                            r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                            r26 = var_170;
                            if (r0 != 0x0) {
                                    r25 = r0;
                                    r23 = *var_150;
                                    do {
                                            r19 = 0x0;
                                            do {
                                                    if (*var_150 != r23) {
                                                            objc_enumerationMutation(r22);
                                                    }
                                                    r20 = *(var_158 + r19 * 0x8);
                                                    r0 = [r26 getAssociationDictionaryForKey:r20 withExtensionAssociations:r22];
                                                    r0 = [r0 retain];
                                                    r27 = r0;
                                                    if (r0 != 0x0) {
                                                            r0 = r26->relateDocTypesToMenus;
                                                            r26 = r24;
                                                            r0 = [r0 objectForKey:r24];
                                                            r0 = [r0 retain];
                                                            r24 = r0;
                                                            r20 = [[r0 objectForKey:r20] retain];
                                                            if (r21 != 0x0) {
                                                                    if (r20 != 0x0 && [r20 length] != 0x0) {
                                                                            if ([r20 compare:r21 options:0x1] == 0x0) {
                                                                                    [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    if ([r20 length] == 0x0) {
                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                    }
                                                            }
                                                            [r20 release];
                                                            [r24 release];
                                                            r24 = r26;
                                                            r26 = var_170;
                                                    }
                                                    [r27 release];
                                                    r19 = r19 + 0x1;
                                            } while (r25 != r19);
                                            r0 = [r22 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                            r25 = r0;
                                    } while (r0 != 0x0);
                            }
                            [r22 release];
                            if (var_198 == 0x0) {
                                    r22 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType"] retain];
                                    r20 = [[NSDictionary dictionaryWithObjectsAndKeys:r22] retain];
                                    [var_180 addObject:r20];
                                    [r20 release];
                                    [r22 release];
                            }
                            [var_190 setObject:var_180 forKey:@"CFBundleDocumentTypes"];
                            r22 = [[NSArray arrayWithObject:@"mailto"] retain];
                            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Email Address URL"] retain];
                            [r22 release];
                            var_170 = r20;
                            r20 = [[NSArray arrayWithObject:r20] retain];
                            [var_190 setObject:r20 forKey:@"CFBundleURLTypes"];
                            [r20 release];
                            var_168 = 0x0;
                            r2 = var_190;
                            r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_168];
                            r27 = [r0 retain];
                            r25 = [var_168 retain];
                            [var_1D0 release];
                            [var_1B0 release];
                            r28 = var_1C8;
                            r23 = var_1C0;
                            if (r27 != 0x0) {
                                    r20 = var_1E0;
                                    r19 = var_1D8;
                                    if (([r27 writeToFile:r20 atomically:0x1] & 0x1) != 0x0) {
                                            [r26 informSystemOfUpdatedApp:r19];
                                            r22 = 0x1;
                                            r26 = var_1E8;
                                    }
                                    else {
                                            NSLog(@"Failed to write %@\n", r1);
                                            r26 = var_1E8;
                                            if (var_1B4 != 0x0) {
                                                    [r28 removeItemAtPath:r19 error:0x0];
                                            }
                                            r22 = 0x0;
                                    }
                            }
                            else {
                                    r20 = var_1E0;
                                    NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                    r19 = var_1D8;
                                    if (var_1B4 != 0x0) {
                                            [r28 removeItemAtPath:r19 error:0x0];
                                    }
                                    r22 = 0x0;
                                    r26 = var_1E8;
                            }
                            [var_170 release];
                            [var_180 release];
                            [r21 release];
                            [var_188 release];
                    }
                    else {
                            r25 = r0;
                            NSLog(@"Couldn't parse %@: %@\n", r1, r2);
                            if (var_1B4 != 0x0) {
                                    [r28 removeItemAtPath:r19 error:0x0];
                            }
                            r22 = 0x0;
                            r27 = var_1B0;
                    }
                    [var_190 release];
                    [r25 release];
                    [r27 release];
                    [r20 release];
                    [var_1A0 release];
                    [var_1A8 release];
                    [r19 release];
                    [r28 release];
                    [r23 release];
                    [r26 release];
                    [var_178 release];
                    r0 = [r24 release];
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = r22;
            }
            else {
                    r0 = objc_opt_class(var_170);
                    r0 = [r0 getAppSupportDir];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 stringByAppendingPathComponent:@"Helpers"] retain];
                    [r20 release];
                    if (r21 != 0x0) {
                            r0 = [r28 fileExistsAtPath:r21 isDirectory:&var_110];
                            if (r0 != 0x0) {
                                    if (var_110 == 0x0) {
                                            NSLog(@"There's a file in the way; can't create directory %@\n", r1);
                                            [r21 release];
                                            [r25 release];
                                            [r19 release];
                                            [r28 release];
                                            [r23 release];
                                            [r26 release];
                                            [var_178 release];
                                            r0 = [r24 release];
                                            if (**___stack_chk_guard != var_60) {
                                                    __stack_chk_fail();
                                            }
                                            r0 = 0x0;
                                    }
                                    else {
                                            var_1C0 = r23;
                                            r0 = [r21 stringByAppendingPathComponent:r19];
                                            r0 = [r0 retain];
                                            if (r0 != 0x0) {
                                                    r23 = r0;
                                                    var_180 = r24;
                                                    r0 = [r28 fileExistsAtPath:r23];
                                                    r24 = r0;
                                                    if (r0 != 0x0) {
                                                            r0 = [NSWorkspace sharedWorkspace];
                                                            r0 = [r0 retain];
                                                            r20 = r0;
                                                            r22 = [r0 isFilePackageAtPath:r23];
                                                            [r20 release];
                                                            if (r22 != 0x0) {
                                                                    var_1B4 = r24 ^ 0x1;
                                                                    [r21 release];
                                                                    r27 = r19;
                                                                    r19 = r23;
                                                                    r24 = var_180;
                                                                    r23 = var_1C0;
                                                                    r21 = var_198;
                                                                    r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                    r0 = [r0 retain];
                                                                    r20 = r0;
                                                                    r8 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                                                                    r0 = r20;
                                                                    r20 = r8;
                                                                    [r0 release];
                                                                    r2 = [[NSData dataWithContentsOfFile:r20] retain];
                                                                    var_118 = 0x0;
                                                                    var_1B0 = r2;
                                                                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                                                                    r22 = [r0 retain];
                                                                    r0 = [var_118 retain];
                                                                    var_190 = r22;
                                                                    var_1A8 = r27;
                                                                    var_1A0 = r25;
                                                                    if (r22 != 0x0) {
                                                                            var_1D0 = r0;
                                                                            var_1E0 = r20;
                                                                            [r22 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                                                                            [r22 setObject:r24 forKey:@"CXHelperAppBottleTag"];
                                                                            r20 = [@(0x2b) retain];
                                                                            [r22 setObject:r20 forKey:@"CXHelperAppVersion"];
                                                                            [r20 release];
                                                                            var_1C8 = r28;
                                                                            var_1C0 = r23;
                                                                            var_198 = r21;
                                                                            if (r21 != 0x0) {
                                                                                    r0 = [r22 valueForKey:**_kCFBundleIdentifierKey];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    [r0 release];
                                                                                    if (r21 == 0x0) {
                                                                                            r20 = **_kCFBundleIdentifierKey;
                                                                                            r21 = [[var_170 shortenedBundleID:r25] retain];
                                                                                            [r22 setObject:r21 forKey:r20];
                                                                                            [r21 release];
                                                                                    }
                                                                                    r0 = [r22 valueForKey:**_kCFBundleNameKey];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    [r0 release];
                                                                                    if (r21 == 0x0) {
                                                                                            [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r20 = [[var_170 shortenedBundleID:r25] retain];
                                                                                    [r22 setObject:r20 forKey:**_kCFBundleIdentifierKey];
                                                                                    [r20 release];
                                                                                    [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                    r0 = [r22 valueForKey:**_kUTImportedTypeDeclarationsKey];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    [r0 release];
                                                                                    if (r21 == 0x0) {
                                                                                            r20 = **_kUTImportedTypeDeclarationsKey;
                                                                                            r21 = [[NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:**_kUTTypeIdentifierKey] retain];
                                                                                            r22 = [[NSArray arrayWithObject:r21] retain];
                                                                                            [var_190 setObject:r22 forKey:r20];
                                                                                            r0 = r22;
                                                                                            r22 = var_190;
                                                                                            [r0 release];
                                                                                            [r21 release];
                                                                                    }
                                                                            }
                                                                            var_1D8 = r19;
                                                                            r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                            r0 = [r0 retain];
                                                                            r20 = r0;
                                                                            var_188 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
                                                                            [r20 release];
                                                                            r21 = [[r22 objectForKey:@"CrossOverHelperMenuPath"] retain];
                                                                            var_180 = [[NSMutableArray arrayWithCapacity:[r26 count] + 0x1] retain];
                                                                            var_160 = q0;
                                                                            var_150 = q0;
                                                                            var_1E8 = r26;
                                                                            r0 = [r26 retain];
                                                                            r22 = r0;
                                                                            r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                            r26 = var_170;
                                                                            if (r0 != 0x0) {
                                                                                    r25 = r0;
                                                                                    r23 = *var_150;
                                                                                    do {
                                                                                            r19 = 0x0;
                                                                                            do {
                                                                                                    if (*var_150 != r23) {
                                                                                                            objc_enumerationMutation(r22);
                                                                                                    }
                                                                                                    r20 = *(var_158 + r19 * 0x8);
                                                                                                    r0 = [r26 getAssociationDictionaryForKey:r20 withExtensionAssociations:r22];
                                                                                                    r0 = [r0 retain];
                                                                                                    r27 = r0;
                                                                                                    if (r0 != 0x0) {
                                                                                                            r0 = r26->relateDocTypesToMenus;
                                                                                                            r26 = r24;
                                                                                                            r0 = [r0 objectForKey:r24];
                                                                                                            r0 = [r0 retain];
                                                                                                            r24 = r0;
                                                                                                            r20 = [[r0 objectForKey:r20] retain];
                                                                                                            if (r21 != 0x0) {
                                                                                                                    if (r20 != 0x0 && [r20 length] != 0x0) {
                                                                                                                            if ([r20 compare:r21 options:0x1] == 0x0) {
                                                                                                                                    [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    if ([r20 length] == 0x0) {
                                                                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                    }
                                                                                                            }
                                                                                                            [r20 release];
                                                                                                            [r24 release];
                                                                                                            r24 = r26;
                                                                                                            r26 = var_170;
                                                                                                    }
                                                                                                    [r27 release];
                                                                                                    r19 = r19 + 0x1;
                                                                                            } while (r25 != r19);
                                                                                            r0 = [r22 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                            r25 = r0;
                                                                                    } while (r0 != 0x0);
                                                                            }
                                                                            [r22 release];
                                                                            if (var_198 == 0x0) {
                                                                                    r22 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType"] retain];
                                                                                    r20 = [[NSDictionary dictionaryWithObjectsAndKeys:r22] retain];
                                                                                    [var_180 addObject:r20];
                                                                                    [r20 release];
                                                                                    [r22 release];
                                                                            }
                                                                            [var_190 setObject:var_180 forKey:@"CFBundleDocumentTypes"];
                                                                            r22 = [[NSArray arrayWithObject:@"mailto"] retain];
                                                                            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Email Address URL"] retain];
                                                                            [r22 release];
                                                                            var_170 = r20;
                                                                            r20 = [[NSArray arrayWithObject:r20] retain];
                                                                            [var_190 setObject:r20 forKey:@"CFBundleURLTypes"];
                                                                            [r20 release];
                                                                            var_168 = 0x0;
                                                                            r2 = var_190;
                                                                            r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_168];
                                                                            r27 = [r0 retain];
                                                                            r25 = [var_168 retain];
                                                                            [var_1D0 release];
                                                                            [var_1B0 release];
                                                                            r28 = var_1C8;
                                                                            r23 = var_1C0;
                                                                            if (r27 != 0x0) {
                                                                                    r20 = var_1E0;
                                                                                    r19 = var_1D8;
                                                                                    if (([r27 writeToFile:r20 atomically:0x1] & 0x1) != 0x0) {
                                                                                            [r26 informSystemOfUpdatedApp:r19];
                                                                                            r22 = 0x1;
                                                                                            r26 = var_1E8;
                                                                                    }
                                                                                    else {
                                                                                            NSLog(@"Failed to write %@\n", r1);
                                                                                            r26 = var_1E8;
                                                                                            if (var_1B4 != 0x0) {
                                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                                            }
                                                                                            r22 = 0x0;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r20 = var_1E0;
                                                                                    NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                                                                    r19 = var_1D8;
                                                                                    if (var_1B4 != 0x0) {
                                                                                            [r28 removeItemAtPath:r19 error:0x0];
                                                                                    }
                                                                                    r22 = 0x0;
                                                                                    r26 = var_1E8;
                                                                            }
                                                                            [var_170 release];
                                                                            [var_180 release];
                                                                            [r21 release];
                                                                            [var_188 release];
                                                                    }
                                                                    else {
                                                                            r25 = r0;
                                                                            NSLog(@"Couldn't parse %@: %@\n", r1, r2);
                                                                            if (var_1B4 != 0x0) {
                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                            }
                                                                            r22 = 0x0;
                                                                            r27 = var_1B0;
                                                                    }
                                                                    [var_190 release];
                                                                    [r25 release];
                                                                    [r27 release];
                                                                    [r20 release];
                                                                    [var_1A0 release];
                                                                    [var_1A8 release];
                                                                    [r19 release];
                                                                    [r28 release];
                                                                    [r23 release];
                                                                    [r26 release];
                                                                    [var_178 release];
                                                                    r0 = [r24 release];
                                                                    if (**___stack_chk_guard != var_60) {
                                                                            __stack_chk_fail();
                                                                    }
                                                                    r0 = r22;
                                                            }
                                                            else {
                                                                    NSLog(@"There's a file or non-package directory in the way; can't create helper app %@\n", r1);
                                                                    [r23 release];
                                                                    r24 = var_180;
                                                                    r23 = var_1C0;
                                                                    [r21 release];
                                                                    [r25 release];
                                                                    [r19 release];
                                                                    [r28 release];
                                                                    [r23 release];
                                                                    [r26 release];
                                                                    [var_178 release];
                                                                    r0 = [r24 release];
                                                                    if (**___stack_chk_guard != var_60) {
                                                                            __stack_chk_fail();
                                                                    }
                                                                    r0 = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [r21 release];
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r20 = r0;
                                                            r21 = [[r0 pathForResource:@"Bottle Helper" ofType:@"cpbz2"] retain];
                                                            [r20 release];
                                                            if (r21 != 0x0) {
                                                                    r22 = [[r23 stringByAppendingPathComponent:@"Contents"] retain];
                                                                    if (([r28 removeItemAtPath:r22 error:0x0] & 0x1) == 0x0) {
                                                                            if (([r28 createDirectoryAtPath:r23 attributes:0x0 recursively:0x1] & 0x1) != 0x0) {
                                                                                    var_1A0 = r25;
                                                                                    var_88 = @"-x";
                                                                                    r0 = [NSArray arrayWithObjects:&var_88 count:0x5];
                                                                                    r27 = [r0 retain];
                                                                                    r25 = [[CXTask launchedTaskWithLaunchPath:@"/usr/bin/ditto" arguments:r27] retain];
                                                                                    [r27 release];
                                                                                    [r25 waitUntilExit];
                                                                                    if ([r25 terminationReason] == 0x1) {
                                                                                            if ([r25 terminationStatus] != 0x0) {
                                                                                                    NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", r1, @"/usr/bin/ditto");
                                                                                                    [r25 release];
                                                                                                    [r22 release];
                                                                                                    [r21 release];
                                                                                                    r0 = var_1A0;
                                                                                                    [r0 release];
                                                                                                    [r19 release];
                                                                                                    r19 = r23;
                                                                                                    r24 = var_180;
                                                                                                    r23 = var_1C0;
                                                                                                    [r19 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r26 release];
                                                                                                    [var_178 release];
                                                                                                    r0 = [r24 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                                    r0 = 0x0;
                                                                                            }
                                                                                            else {
                                                                                                    [r28 makeWritableAtPath:r23 recursively:0x1];
                                                                                                    [r25 release];
                                                                                                    [r22 release];
                                                                                                    r25 = var_1A0;
                                                                                                    var_1B4 = r24 ^ 0x1;
                                                                                                    [r21 release];
                                                                                                    r27 = r19;
                                                                                                    r19 = r23;
                                                                                                    r24 = var_180;
                                                                                                    r23 = var_1C0;
                                                                                                    r21 = var_198;
                                                                                                    r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                                                    r0 = [r0 retain];
                                                                                                    r20 = r0;
                                                                                                    r8 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                                                                                                    r0 = r20;
                                                                                                    r20 = r8;
                                                                                                    [r0 release];
                                                                                                    r2 = [[NSData dataWithContentsOfFile:r20] retain];
                                                                                                    var_118 = 0x0;
                                                                                                    var_1B0 = r2;
                                                                                                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                                                                                                    r22 = [r0 retain];
                                                                                                    r0 = [var_118 retain];
                                                                                                    var_190 = r22;
                                                                                                    var_1A8 = r27;
                                                                                                    var_1A0 = r25;
                                                                                                    if (r22 != 0x0) {
                                                                                                            var_1D0 = r0;
                                                                                                            var_1E0 = r20;
                                                                                                            [r22 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                                                                                                            [r22 setObject:r24 forKey:@"CXHelperAppBottleTag"];
                                                                                                            r20 = [@(0x2b) retain];
                                                                                                            [r22 setObject:r20 forKey:@"CXHelperAppVersion"];
                                                                                                            [r20 release];
                                                                                                            var_1C8 = r28;
                                                                                                            var_1C0 = r23;
                                                                                                            var_198 = r21;
                                                                                                            if (r21 != 0x0) {
                                                                                                                    r0 = [r22 valueForKey:**_kCFBundleIdentifierKey];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r21 = r0;
                                                                                                                    [r0 release];
                                                                                                                    if (r21 == 0x0) {
                                                                                                                            r20 = **_kCFBundleIdentifierKey;
                                                                                                                            r21 = [[var_170 shortenedBundleID:r25] retain];
                                                                                                                            [r22 setObject:r21 forKey:r20];
                                                                                                                            [r21 release];
                                                                                                                    }
                                                                                                                    r0 = [r22 valueForKey:**_kCFBundleNameKey];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r21 = r0;
                                                                                                                    [r0 release];
                                                                                                                    if (r21 == 0x0) {
                                                                                                                            [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r20 = [[var_170 shortenedBundleID:r25] retain];
                                                                                                                    [r22 setObject:r20 forKey:**_kCFBundleIdentifierKey];
                                                                                                                    [r20 release];
                                                                                                                    [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                                                    r0 = [r22 valueForKey:**_kUTImportedTypeDeclarationsKey];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r21 = r0;
                                                                                                                    [r0 release];
                                                                                                                    if (r21 == 0x0) {
                                                                                                                            r20 = **_kUTImportedTypeDeclarationsKey;
                                                                                                                            r21 = [[NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:**_kUTTypeIdentifierKey] retain];
                                                                                                                            r22 = [[NSArray arrayWithObject:r21] retain];
                                                                                                                            [var_190 setObject:r22 forKey:r20];
                                                                                                                            r0 = r22;
                                                                                                                            r22 = var_190;
                                                                                                                            [r0 release];
                                                                                                                            [r21 release];
                                                                                                                    }
                                                                                                            }
                                                                                                            var_1D8 = r19;
                                                                                                            r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                                                            r0 = [r0 retain];
                                                                                                            r20 = r0;
                                                                                                            var_188 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
                                                                                                            [r20 release];
                                                                                                            r21 = [[r22 objectForKey:@"CrossOverHelperMenuPath"] retain];
                                                                                                            var_180 = [[NSMutableArray arrayWithCapacity:[r26 count] + 0x1] retain];
                                                                                                            var_160 = q0;
                                                                                                            var_150 = q0;
                                                                                                            var_1E8 = r26;
                                                                                                            r0 = [r26 retain];
                                                                                                            r22 = r0;
                                                                                                            r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                                            r26 = var_170;
                                                                                                            if (r0 != 0x0) {
                                                                                                                    r25 = r0;
                                                                                                                    r23 = *var_150;
                                                                                                                    do {
                                                                                                                            r19 = 0x0;
                                                                                                                            do {
                                                                                                                                    if (*var_150 != r23) {
                                                                                                                                            objc_enumerationMutation(r22);
                                                                                                                                    }
                                                                                                                                    r20 = *(var_158 + r19 * 0x8);
                                                                                                                                    r0 = [r26 getAssociationDictionaryForKey:r20 withExtensionAssociations:r22];
                                                                                                                                    r0 = [r0 retain];
                                                                                                                                    r27 = r0;
                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                            r0 = r26->relateDocTypesToMenus;
                                                                                                                                            r26 = r24;
                                                                                                                                            r0 = [r0 objectForKey:r24];
                                                                                                                                            r0 = [r0 retain];
                                                                                                                                            r24 = r0;
                                                                                                                                            r20 = [[r0 objectForKey:r20] retain];
                                                                                                                                            if (r21 != 0x0) {
                                                                                                                                                    if (r20 != 0x0 && [r20 length] != 0x0) {
                                                                                                                                                            if ([r20 compare:r21 options:0x1] == 0x0) {
                                                                                                                                                                    [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    if ([r20 length] == 0x0) {
                                                                                                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            [r20 release];
                                                                                                                                            [r24 release];
                                                                                                                                            r24 = r26;
                                                                                                                                            r26 = var_170;
                                                                                                                                    }
                                                                                                                                    [r27 release];
                                                                                                                                    r19 = r19 + 0x1;
                                                                                                                            } while (r25 != r19);
                                                                                                                            r0 = [r22 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                                                            r25 = r0;
                                                                                                                    } while (r0 != 0x0);
                                                                                                            }
                                                                                                            [r22 release];
                                                                                                            if (var_198 == 0x0) {
                                                                                                                    r22 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType"] retain];
                                                                                                                    r20 = [[NSDictionary dictionaryWithObjectsAndKeys:r22] retain];
                                                                                                                    [var_180 addObject:r20];
                                                                                                                    [r20 release];
                                                                                                                    [r22 release];
                                                                                                            }
                                                                                                            [var_190 setObject:var_180 forKey:@"CFBundleDocumentTypes"];
                                                                                                            r22 = [[NSArray arrayWithObject:@"mailto"] retain];
                                                                                                            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Email Address URL"] retain];
                                                                                                            [r22 release];
                                                                                                            var_170 = r20;
                                                                                                            r20 = [[NSArray arrayWithObject:r20] retain];
                                                                                                            [var_190 setObject:r20 forKey:@"CFBundleURLTypes"];
                                                                                                            [r20 release];
                                                                                                            var_168 = 0x0;
                                                                                                            r2 = var_190;
                                                                                                            r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_168];
                                                                                                            r27 = [r0 retain];
                                                                                                            r25 = [var_168 retain];
                                                                                                            [var_1D0 release];
                                                                                                            [var_1B0 release];
                                                                                                            r28 = var_1C8;
                                                                                                            r23 = var_1C0;
                                                                                                            if (r27 != 0x0) {
                                                                                                                    r20 = var_1E0;
                                                                                                                    r19 = var_1D8;
                                                                                                                    if (([r27 writeToFile:r20 atomically:0x1] & 0x1) != 0x0) {
                                                                                                                            [r26 informSystemOfUpdatedApp:r19];
                                                                                                                            r22 = 0x1;
                                                                                                                            r26 = var_1E8;
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            NSLog(@"Failed to write %@\n", r1);
                                                                                                                            r26 = var_1E8;
                                                                                                                            if (var_1B4 != 0x0) {
                                                                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                                                                            }
                                                                                                                            r22 = 0x0;
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r20 = var_1E0;
                                                                                                                    NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                                                                                                    r19 = var_1D8;
                                                                                                                    if (var_1B4 != 0x0) {
                                                                                                                            [r28 removeItemAtPath:r19 error:0x0];
                                                                                                                    }
                                                                                                                    r22 = 0x0;
                                                                                                                    r26 = var_1E8;
                                                                                                            }
                                                                                                            [var_170 release];
                                                                                                            [var_180 release];
                                                                                                            [r21 release];
                                                                                                            [var_188 release];
                                                                                                    }
                                                                                                    else {
                                                                                                            r25 = r0;
                                                                                                            NSLog(@"Couldn't parse %@: %@\n", r1, r2);
                                                                                                            if (var_1B4 != 0x0) {
                                                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                                                            }
                                                                                                            r22 = 0x0;
                                                                                                            r27 = var_1B0;
                                                                                                    }
                                                                                                    [var_190 release];
                                                                                                    [r25 release];
                                                                                                    [r27 release];
                                                                                                    [r20 release];
                                                                                                    [var_1A0 release];
                                                                                                    [var_1A8 release];
                                                                                                    [r19 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r26 release];
                                                                                                    [var_178 release];
                                                                                                    r0 = [r24 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                                    r0 = r22;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", r1, @"/usr/bin/ditto");
                                                                                            [r25 release];
                                                                                            [r22 release];
                                                                                            [r21 release];
                                                                                            r0 = var_1A0;
                                                                                            [r0 release];
                                                                                            [r19 release];
                                                                                            r19 = r23;
                                                                                            r24 = var_180;
                                                                                            r23 = var_1C0;
                                                                                            [r19 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r26 release];
                                                                                            [var_178 release];
                                                                                            r0 = [r24 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                            r0 = 0x0;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    NSLog(@"Failed to create the associations helper app bundle dir '%@'\n", r1);
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    r0 = r25;
                                                                                    [r0 release];
                                                                                    [r19 release];
                                                                                    r19 = r23;
                                                                                    r24 = var_180;
                                                                                    r23 = var_1C0;
                                                                                    [r19 release];
                                                                                    [r28 release];
                                                                                    [r23 release];
                                                                                    [r26 release];
                                                                                    [var_178 release];
                                                                                    r0 = [r24 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                                    r0 = 0x0;
                                                                            }
                                                                    }
                                                                    else {
                                                                            var_1A0 = r25;
                                                                            var_88 = @"-x";
                                                                            r0 = [NSArray arrayWithObjects:&var_88 count:0x5];
                                                                            r27 = [r0 retain];
                                                                            r25 = [[CXTask launchedTaskWithLaunchPath:@"/usr/bin/ditto" arguments:r27] retain];
                                                                            [r27 release];
                                                                            [r25 waitUntilExit];
                                                                            if ([r25 terminationReason] == 0x1) {
                                                                                    if ([r25 terminationStatus] != 0x0) {
                                                                                            NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", r1, @"/usr/bin/ditto");
                                                                                            [r25 release];
                                                                                            [r22 release];
                                                                                            [r21 release];
                                                                                            r0 = var_1A0;
                                                                                            [r0 release];
                                                                                            [r19 release];
                                                                                            r19 = r23;
                                                                                            r24 = var_180;
                                                                                            r23 = var_1C0;
                                                                                            [r19 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r26 release];
                                                                                            [var_178 release];
                                                                                            r0 = [r24 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                            r0 = 0x0;
                                                                                    }
                                                                                    else {
                                                                                            [r28 makeWritableAtPath:r23 recursively:0x1];
                                                                                            [r25 release];
                                                                                            [r22 release];
                                                                                            r25 = var_1A0;
                                                                                            var_1B4 = r24 ^ 0x1;
                                                                                            [r21 release];
                                                                                            r27 = r19;
                                                                                            r19 = r23;
                                                                                            r24 = var_180;
                                                                                            r23 = var_1C0;
                                                                                            r21 = var_198;
                                                                                            r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                                            r0 = [r0 retain];
                                                                                            r20 = r0;
                                                                                            r8 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                                                                                            r0 = r20;
                                                                                            r20 = r8;
                                                                                            [r0 release];
                                                                                            r2 = [[NSData dataWithContentsOfFile:r20] retain];
                                                                                            var_118 = 0x0;
                                                                                            var_1B0 = r2;
                                                                                            r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                                                                                            r22 = [r0 retain];
                                                                                            r0 = [var_118 retain];
                                                                                            var_190 = r22;
                                                                                            var_1A8 = r27;
                                                                                            var_1A0 = r25;
                                                                                            if (r22 != 0x0) {
                                                                                                    var_1D0 = r0;
                                                                                                    var_1E0 = r20;
                                                                                                    [r22 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                                                                                                    [r22 setObject:r24 forKey:@"CXHelperAppBottleTag"];
                                                                                                    r20 = [@(0x2b) retain];
                                                                                                    [r22 setObject:r20 forKey:@"CXHelperAppVersion"];
                                                                                                    [r20 release];
                                                                                                    var_1C8 = r28;
                                                                                                    var_1C0 = r23;
                                                                                                    var_198 = r21;
                                                                                                    if (r21 != 0x0) {
                                                                                                            r0 = [r22 valueForKey:**_kCFBundleIdentifierKey];
                                                                                                            r0 = [r0 retain];
                                                                                                            r21 = r0;
                                                                                                            [r0 release];
                                                                                                            if (r21 == 0x0) {
                                                                                                                    r20 = **_kCFBundleIdentifierKey;
                                                                                                                    r21 = [[var_170 shortenedBundleID:r25] retain];
                                                                                                                    [r22 setObject:r21 forKey:r20];
                                                                                                                    [r21 release];
                                                                                                            }
                                                                                                            r0 = [r22 valueForKey:**_kCFBundleNameKey];
                                                                                                            r0 = [r0 retain];
                                                                                                            r21 = r0;
                                                                                                            [r0 release];
                                                                                                            if (r21 == 0x0) {
                                                                                                                    [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r20 = [[var_170 shortenedBundleID:r25] retain];
                                                                                                            [r22 setObject:r20 forKey:**_kCFBundleIdentifierKey];
                                                                                                            [r20 release];
                                                                                                            [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                                            r0 = [r22 valueForKey:**_kUTImportedTypeDeclarationsKey];
                                                                                                            r0 = [r0 retain];
                                                                                                            r21 = r0;
                                                                                                            [r0 release];
                                                                                                            if (r21 == 0x0) {
                                                                                                                    r20 = **_kUTImportedTypeDeclarationsKey;
                                                                                                                    r21 = [[NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:**_kUTTypeIdentifierKey] retain];
                                                                                                                    r22 = [[NSArray arrayWithObject:r21] retain];
                                                                                                                    [var_190 setObject:r22 forKey:r20];
                                                                                                                    r0 = r22;
                                                                                                                    r22 = var_190;
                                                                                                                    [r0 release];
                                                                                                                    [r21 release];
                                                                                                            }
                                                                                                    }
                                                                                                    var_1D8 = r19;
                                                                                                    r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                                                    r0 = [r0 retain];
                                                                                                    r20 = r0;
                                                                                                    var_188 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
                                                                                                    [r20 release];
                                                                                                    r21 = [[r22 objectForKey:@"CrossOverHelperMenuPath"] retain];
                                                                                                    var_180 = [[NSMutableArray arrayWithCapacity:[r26 count] + 0x1] retain];
                                                                                                    var_160 = q0;
                                                                                                    var_150 = q0;
                                                                                                    var_1E8 = r26;
                                                                                                    r0 = [r26 retain];
                                                                                                    r22 = r0;
                                                                                                    r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                                    r26 = var_170;
                                                                                                    if (r0 != 0x0) {
                                                                                                            r25 = r0;
                                                                                                            r23 = *var_150;
                                                                                                            do {
                                                                                                                    r19 = 0x0;
                                                                                                                    do {
                                                                                                                            if (*var_150 != r23) {
                                                                                                                                    objc_enumerationMutation(r22);
                                                                                                                            }
                                                                                                                            r20 = *(var_158 + r19 * 0x8);
                                                                                                                            r0 = [r26 getAssociationDictionaryForKey:r20 withExtensionAssociations:r22];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r27 = r0;
                                                                                                                            if (r0 != 0x0) {
                                                                                                                                    r0 = r26->relateDocTypesToMenus;
                                                                                                                                    r26 = r24;
                                                                                                                                    r0 = [r0 objectForKey:r24];
                                                                                                                                    r0 = [r0 retain];
                                                                                                                                    r24 = r0;
                                                                                                                                    r20 = [[r0 objectForKey:r20] retain];
                                                                                                                                    if (r21 != 0x0) {
                                                                                                                                            if (r20 != 0x0 && [r20 length] != 0x0) {
                                                                                                                                                    if ([r20 compare:r21 options:0x1] == 0x0) {
                                                                                                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            if ([r20 length] == 0x0) {
                                                                                                                                                    [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    [r20 release];
                                                                                                                                    [r24 release];
                                                                                                                                    r24 = r26;
                                                                                                                                    r26 = var_170;
                                                                                                                            }
                                                                                                                            [r27 release];
                                                                                                                            r19 = r19 + 0x1;
                                                                                                                    } while (r25 != r19);
                                                                                                                    r0 = [r22 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                                                    r25 = r0;
                                                                                                            } while (r0 != 0x0);
                                                                                                    }
                                                                                                    [r22 release];
                                                                                                    if (var_198 == 0x0) {
                                                                                                            r22 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType"] retain];
                                                                                                            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:r22] retain];
                                                                                                            [var_180 addObject:r20];
                                                                                                            [r20 release];
                                                                                                            [r22 release];
                                                                                                    }
                                                                                                    [var_190 setObject:var_180 forKey:@"CFBundleDocumentTypes"];
                                                                                                    r22 = [[NSArray arrayWithObject:@"mailto"] retain];
                                                                                                    r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Email Address URL"] retain];
                                                                                                    [r22 release];
                                                                                                    var_170 = r20;
                                                                                                    r20 = [[NSArray arrayWithObject:r20] retain];
                                                                                                    [var_190 setObject:r20 forKey:@"CFBundleURLTypes"];
                                                                                                    [r20 release];
                                                                                                    var_168 = 0x0;
                                                                                                    r2 = var_190;
                                                                                                    r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_168];
                                                                                                    r27 = [r0 retain];
                                                                                                    r25 = [var_168 retain];
                                                                                                    [var_1D0 release];
                                                                                                    [var_1B0 release];
                                                                                                    r28 = var_1C8;
                                                                                                    r23 = var_1C0;
                                                                                                    if (r27 != 0x0) {
                                                                                                            r20 = var_1E0;
                                                                                                            r19 = var_1D8;
                                                                                                            if (([r27 writeToFile:r20 atomically:0x1] & 0x1) != 0x0) {
                                                                                                                    [r26 informSystemOfUpdatedApp:r19];
                                                                                                                    r22 = 0x1;
                                                                                                                    r26 = var_1E8;
                                                                                                            }
                                                                                                            else {
                                                                                                                    NSLog(@"Failed to write %@\n", r1);
                                                                                                                    r26 = var_1E8;
                                                                                                                    if (var_1B4 != 0x0) {
                                                                                                                            [r28 removeItemAtPath:r19 error:0x0];
                                                                                                                    }
                                                                                                                    r22 = 0x0;
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r20 = var_1E0;
                                                                                                            NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                                                                                            r19 = var_1D8;
                                                                                                            if (var_1B4 != 0x0) {
                                                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                                                            }
                                                                                                            r22 = 0x0;
                                                                                                            r26 = var_1E8;
                                                                                                    }
                                                                                                    [var_170 release];
                                                                                                    [var_180 release];
                                                                                                    [r21 release];
                                                                                                    [var_188 release];
                                                                                            }
                                                                                            else {
                                                                                                    r25 = r0;
                                                                                                    NSLog(@"Couldn't parse %@: %@\n", r1, r2);
                                                                                                    if (var_1B4 != 0x0) {
                                                                                                            [r28 removeItemAtPath:r19 error:0x0];
                                                                                                    }
                                                                                                    r22 = 0x0;
                                                                                                    r27 = var_1B0;
                                                                                            }
                                                                                            [var_190 release];
                                                                                            [r25 release];
                                                                                            [r27 release];
                                                                                            [r20 release];
                                                                                            [var_1A0 release];
                                                                                            [var_1A8 release];
                                                                                            [r19 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r26 release];
                                                                                            [var_178 release];
                                                                                            r0 = [r24 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                            r0 = r22;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", r1, @"/usr/bin/ditto");
                                                                                    [r25 release];
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    r0 = var_1A0;
                                                                                    [r0 release];
                                                                                    [r19 release];
                                                                                    r19 = r23;
                                                                                    r24 = var_180;
                                                                                    r23 = var_1C0;
                                                                                    [r19 release];
                                                                                    [r28 release];
                                                                                    [r23 release];
                                                                                    [r26 release];
                                                                                    [var_178 release];
                                                                                    r0 = [r24 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                                    r0 = 0x0;
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    NSLog(@"Unable to determine helperAppContentsArchive.\n");
                                                                    r0 = r25;
                                                                    [r0 release];
                                                                    [r19 release];
                                                                    r19 = r23;
                                                                    r24 = var_180;
                                                                    r23 = var_1C0;
                                                                    [r19 release];
                                                                    [r28 release];
                                                                    [r23 release];
                                                                    [r26 release];
                                                                    [var_178 release];
                                                                    r0 = [r24 release];
                                                                    if (**___stack_chk_guard != var_60) {
                                                                            __stack_chk_fail();
                                                                    }
                                                                    r0 = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    NSLog(@"Unable to determine location of helper app.\n");
                                                    r23 = var_1C0;
                                                    [r21 release];
                                                    [r25 release];
                                                    [r19 release];
                                                    [r28 release];
                                                    [r23 release];
                                                    [r26 release];
                                                    [var_178 release];
                                                    r0 = [r24 release];
                                                    if (**___stack_chk_guard != var_60) {
                                                            __stack_chk_fail();
                                                    }
                                                    r0 = 0x0;
                                            }
                                    }
                            }
                            else {
                                    if (([r28 createDirectoryAtPath:r21 attributes:0x0 recursively:0x1] & 0x1) != 0x0) {
                                            var_1C0 = r23;
                                            r0 = [r21 stringByAppendingPathComponent:r19];
                                            r0 = [r0 retain];
                                            if (r0 != 0x0) {
                                                    r23 = r0;
                                                    var_180 = r24;
                                                    r0 = [r28 fileExistsAtPath:r23];
                                                    r24 = r0;
                                                    if (r0 != 0x0) {
                                                            r0 = [NSWorkspace sharedWorkspace];
                                                            r0 = [r0 retain];
                                                            r20 = r0;
                                                            r22 = [r0 isFilePackageAtPath:r23];
                                                            [r20 release];
                                                            if (r22 != 0x0) {
                                                                    var_1B4 = r24 ^ 0x1;
                                                                    [r21 release];
                                                                    r27 = r19;
                                                                    r19 = r23;
                                                                    r24 = var_180;
                                                                    r23 = var_1C0;
                                                                    r21 = var_198;
                                                                    r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                    r0 = [r0 retain];
                                                                    r20 = r0;
                                                                    r8 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                                                                    r0 = r20;
                                                                    r20 = r8;
                                                                    [r0 release];
                                                                    r2 = [[NSData dataWithContentsOfFile:r20] retain];
                                                                    var_118 = 0x0;
                                                                    var_1B0 = r2;
                                                                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                                                                    r22 = [r0 retain];
                                                                    r0 = [var_118 retain];
                                                                    var_190 = r22;
                                                                    var_1A8 = r27;
                                                                    var_1A0 = r25;
                                                                    if (r22 != 0x0) {
                                                                            var_1D0 = r0;
                                                                            var_1E0 = r20;
                                                                            [r22 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                                                                            [r22 setObject:r24 forKey:@"CXHelperAppBottleTag"];
                                                                            r20 = [@(0x2b) retain];
                                                                            [r22 setObject:r20 forKey:@"CXHelperAppVersion"];
                                                                            [r20 release];
                                                                            var_1C8 = r28;
                                                                            var_1C0 = r23;
                                                                            var_198 = r21;
                                                                            if (r21 != 0x0) {
                                                                                    r0 = [r22 valueForKey:**_kCFBundleIdentifierKey];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    [r0 release];
                                                                                    if (r21 == 0x0) {
                                                                                            r20 = **_kCFBundleIdentifierKey;
                                                                                            r21 = [[var_170 shortenedBundleID:r25] retain];
                                                                                            [r22 setObject:r21 forKey:r20];
                                                                                            [r21 release];
                                                                                    }
                                                                                    r0 = [r22 valueForKey:**_kCFBundleNameKey];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    [r0 release];
                                                                                    if (r21 == 0x0) {
                                                                                            [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r20 = [[var_170 shortenedBundleID:r25] retain];
                                                                                    [r22 setObject:r20 forKey:**_kCFBundleIdentifierKey];
                                                                                    [r20 release];
                                                                                    [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                    r0 = [r22 valueForKey:**_kUTImportedTypeDeclarationsKey];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    [r0 release];
                                                                                    if (r21 == 0x0) {
                                                                                            r20 = **_kUTImportedTypeDeclarationsKey;
                                                                                            r21 = [[NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:**_kUTTypeIdentifierKey] retain];
                                                                                            r22 = [[NSArray arrayWithObject:r21] retain];
                                                                                            [var_190 setObject:r22 forKey:r20];
                                                                                            r0 = r22;
                                                                                            r22 = var_190;
                                                                                            [r0 release];
                                                                                            [r21 release];
                                                                                    }
                                                                            }
                                                                            var_1D8 = r19;
                                                                            r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                            r0 = [r0 retain];
                                                                            r20 = r0;
                                                                            var_188 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
                                                                            [r20 release];
                                                                            r21 = [[r22 objectForKey:@"CrossOverHelperMenuPath"] retain];
                                                                            var_180 = [[NSMutableArray arrayWithCapacity:[r26 count] + 0x1] retain];
                                                                            var_160 = q0;
                                                                            var_150 = q0;
                                                                            var_1E8 = r26;
                                                                            r0 = [r26 retain];
                                                                            r22 = r0;
                                                                            r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                            r26 = var_170;
                                                                            if (r0 != 0x0) {
                                                                                    r25 = r0;
                                                                                    r23 = *var_150;
                                                                                    do {
                                                                                            r19 = 0x0;
                                                                                            do {
                                                                                                    if (*var_150 != r23) {
                                                                                                            objc_enumerationMutation(r22);
                                                                                                    }
                                                                                                    r20 = *(var_158 + r19 * 0x8);
                                                                                                    r0 = [r26 getAssociationDictionaryForKey:r20 withExtensionAssociations:r22];
                                                                                                    r0 = [r0 retain];
                                                                                                    r27 = r0;
                                                                                                    if (r0 != 0x0) {
                                                                                                            r0 = r26->relateDocTypesToMenus;
                                                                                                            r26 = r24;
                                                                                                            r0 = [r0 objectForKey:r24];
                                                                                                            r0 = [r0 retain];
                                                                                                            r24 = r0;
                                                                                                            r20 = [[r0 objectForKey:r20] retain];
                                                                                                            if (r21 != 0x0) {
                                                                                                                    if (r20 != 0x0 && [r20 length] != 0x0 && [r20 compare:r21 options:0x1] == 0x0) {
                                                                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    if ([r20 length] == 0x0) {
                                                                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                    }
                                                                                                            }
                                                                                                            [r20 release];
                                                                                                            [r24 release];
                                                                                                            r24 = r26;
                                                                                                            r26 = var_170;
                                                                                                    }
                                                                                                    [r27 release];
                                                                                                    r19 = r19 + 0x1;
                                                                                            } while (r25 != r19);
                                                                                            r0 = [r22 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                            r25 = r0;
                                                                                    } while (r0 != 0x0);
                                                                            }
                                                                            [r22 release];
                                                                            if (var_198 == 0x0) {
                                                                                    r22 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType"] retain];
                                                                                    r20 = [[NSDictionary dictionaryWithObjectsAndKeys:r22] retain];
                                                                                    [var_180 addObject:r20];
                                                                                    [r20 release];
                                                                                    [r22 release];
                                                                            }
                                                                            [var_190 setObject:var_180 forKey:@"CFBundleDocumentTypes"];
                                                                            r22 = [[NSArray arrayWithObject:@"mailto"] retain];
                                                                            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Email Address URL"] retain];
                                                                            [r22 release];
                                                                            var_170 = r20;
                                                                            r20 = [[NSArray arrayWithObject:r20] retain];
                                                                            [var_190 setObject:r20 forKey:@"CFBundleURLTypes"];
                                                                            [r20 release];
                                                                            var_168 = 0x0;
                                                                            r2 = var_190;
                                                                            r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_168];
                                                                            r27 = [r0 retain];
                                                                            r25 = [var_168 retain];
                                                                            [var_1D0 release];
                                                                            [var_1B0 release];
                                                                            r28 = var_1C8;
                                                                            r23 = var_1C0;
                                                                            if (r27 != 0x0) {
                                                                                    r20 = var_1E0;
                                                                                    r19 = var_1D8;
                                                                                    if (([r27 writeToFile:r20 atomically:0x1] & 0x1) != 0x0) {
                                                                                            [r26 informSystemOfUpdatedApp:r19];
                                                                                            r22 = 0x1;
                                                                                            r26 = var_1E8;
                                                                                    }
                                                                                    else {
                                                                                            NSLog(@"Failed to write %@\n", r1);
                                                                                            r26 = var_1E8;
                                                                                            if (var_1B4 != 0x0) {
                                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                                            }
                                                                                            r22 = 0x0;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r20 = var_1E0;
                                                                                    NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                                                                    r19 = var_1D8;
                                                                                    if (var_1B4 != 0x0) {
                                                                                            [r28 removeItemAtPath:r19 error:0x0];
                                                                                    }
                                                                                    r22 = 0x0;
                                                                                    r26 = var_1E8;
                                                                            }
                                                                            [var_170 release];
                                                                            [var_180 release];
                                                                            [r21 release];
                                                                            [var_188 release];
                                                                    }
                                                                    else {
                                                                            r25 = r0;
                                                                            NSLog(@"Couldn't parse %@: %@\n", r1, r2);
                                                                            if (var_1B4 != 0x0) {
                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                            }
                                                                            r22 = 0x0;
                                                                            r27 = var_1B0;
                                                                    }
                                                                    [var_190 release];
                                                                    [r25 release];
                                                                    [r27 release];
                                                                    [r20 release];
                                                                    [var_1A0 release];
                                                                    [var_1A8 release];
                                                                    [r19 release];
                                                                    [r28 release];
                                                                    [r23 release];
                                                                    [r26 release];
                                                                    [var_178 release];
                                                                    r0 = [r24 release];
                                                                    if (**___stack_chk_guard != var_60) {
                                                                            __stack_chk_fail();
                                                                    }
                                                                    r0 = r22;
                                                            }
                                                            else {
                                                                    NSLog(@"There's a file or non-package directory in the way; can't create helper app %@\n", r1);
                                                                    [r23 release];
                                                                    r24 = var_180;
                                                                    r23 = var_1C0;
                                                                    [r21 release];
                                                                    [r25 release];
                                                                    [r19 release];
                                                                    [r28 release];
                                                                    [r23 release];
                                                                    [r26 release];
                                                                    [var_178 release];
                                                                    r0 = [r24 release];
                                                                    if (**___stack_chk_guard != var_60) {
                                                                            __stack_chk_fail();
                                                                    }
                                                                    r0 = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [r21 release];
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r20 = r0;
                                                            r21 = [[r0 pathForResource:@"Bottle Helper" ofType:@"cpbz2"] retain];
                                                            [r20 release];
                                                            if (r21 != 0x0) {
                                                                    r22 = [[r23 stringByAppendingPathComponent:@"Contents"] retain];
                                                                    if (([r28 removeItemAtPath:r22 error:0x0] & 0x1) == 0x0) {
                                                                            if (([r28 createDirectoryAtPath:r23 attributes:0x0 recursively:0x1] & 0x1) != 0x0) {
                                                                                    var_1A0 = r25;
                                                                                    var_88 = @"-x";
                                                                                    r0 = [NSArray arrayWithObjects:&var_88 count:0x5];
                                                                                    r27 = [r0 retain];
                                                                                    r25 = [[CXTask launchedTaskWithLaunchPath:@"/usr/bin/ditto" arguments:r27] retain];
                                                                                    [r27 release];
                                                                                    [r25 waitUntilExit];
                                                                                    if ([r25 terminationReason] == 0x1) {
                                                                                            if ([r25 terminationStatus] != 0x0) {
                                                                                                    NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", r1, @"/usr/bin/ditto");
                                                                                                    [r25 release];
                                                                                                    [r22 release];
                                                                                                    [r21 release];
                                                                                                    r0 = var_1A0;
                                                                                                    [r0 release];
                                                                                                    [r19 release];
                                                                                                    r19 = r23;
                                                                                                    r24 = var_180;
                                                                                                    r23 = var_1C0;
                                                                                                    [r19 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r26 release];
                                                                                                    [var_178 release];
                                                                                                    r0 = [r24 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                                    r0 = 0x0;
                                                                                            }
                                                                                            else {
                                                                                                    [r28 makeWritableAtPath:r23 recursively:0x1];
                                                                                                    [r25 release];
                                                                                                    [r22 release];
                                                                                                    r25 = var_1A0;
                                                                                                    var_1B4 = r24 ^ 0x1;
                                                                                                    [r21 release];
                                                                                                    r27 = r19;
                                                                                                    r19 = r23;
                                                                                                    r24 = var_180;
                                                                                                    r23 = var_1C0;
                                                                                                    r21 = var_198;
                                                                                                    r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                                                    r0 = [r0 retain];
                                                                                                    r20 = r0;
                                                                                                    r8 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                                                                                                    r0 = r20;
                                                                                                    r20 = r8;
                                                                                                    [r0 release];
                                                                                                    r2 = [[NSData dataWithContentsOfFile:r20] retain];
                                                                                                    var_118 = 0x0;
                                                                                                    var_1B0 = r2;
                                                                                                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                                                                                                    r22 = [r0 retain];
                                                                                                    r0 = [var_118 retain];
                                                                                                    var_190 = r22;
                                                                                                    var_1A8 = r27;
                                                                                                    var_1A0 = r25;
                                                                                                    if (r22 != 0x0) {
                                                                                                            var_1D0 = r0;
                                                                                                            var_1E0 = r20;
                                                                                                            [r22 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                                                                                                            [r22 setObject:r24 forKey:@"CXHelperAppBottleTag"];
                                                                                                            r20 = [@(0x2b) retain];
                                                                                                            [r22 setObject:r20 forKey:@"CXHelperAppVersion"];
                                                                                                            [r20 release];
                                                                                                            var_1C8 = r28;
                                                                                                            var_1C0 = r23;
                                                                                                            var_198 = r21;
                                                                                                            if (r21 != 0x0) {
                                                                                                                    r0 = [r22 valueForKey:**_kCFBundleIdentifierKey];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r21 = r0;
                                                                                                                    [r0 release];
                                                                                                                    if (r21 == 0x0) {
                                                                                                                            r20 = **_kCFBundleIdentifierKey;
                                                                                                                            r21 = [[var_170 shortenedBundleID:r25] retain];
                                                                                                                            [r22 setObject:r21 forKey:r20];
                                                                                                                            [r21 release];
                                                                                                                    }
                                                                                                                    r0 = [r22 valueForKey:**_kCFBundleNameKey];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r21 = r0;
                                                                                                                    [r0 release];
                                                                                                                    if (r21 == 0x0) {
                                                                                                                            [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r20 = [[var_170 shortenedBundleID:r25] retain];
                                                                                                                    [r22 setObject:r20 forKey:**_kCFBundleIdentifierKey];
                                                                                                                    [r20 release];
                                                                                                                    [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                                                    r0 = [r22 valueForKey:**_kUTImportedTypeDeclarationsKey];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r21 = r0;
                                                                                                                    [r0 release];
                                                                                                                    if (r21 == 0x0) {
                                                                                                                            r20 = **_kUTImportedTypeDeclarationsKey;
                                                                                                                            r21 = [[NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:**_kUTTypeIdentifierKey] retain];
                                                                                                                            r22 = [[NSArray arrayWithObject:r21] retain];
                                                                                                                            [var_190 setObject:r22 forKey:r20];
                                                                                                                            r0 = r22;
                                                                                                                            r22 = var_190;
                                                                                                                            [r0 release];
                                                                                                                            [r21 release];
                                                                                                                    }
                                                                                                            }
                                                                                                            var_1D8 = r19;
                                                                                                            r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                                                            r0 = [r0 retain];
                                                                                                            r20 = r0;
                                                                                                            var_188 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
                                                                                                            [r20 release];
                                                                                                            r21 = [[r22 objectForKey:@"CrossOverHelperMenuPath"] retain];
                                                                                                            var_180 = [[NSMutableArray arrayWithCapacity:[r26 count] + 0x1] retain];
                                                                                                            var_160 = q0;
                                                                                                            var_150 = q0;
                                                                                                            var_1E8 = r26;
                                                                                                            r0 = [r26 retain];
                                                                                                            r22 = r0;
                                                                                                            r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                                            r26 = var_170;
                                                                                                            if (r0 != 0x0) {
                                                                                                                    r25 = r0;
                                                                                                                    r23 = *var_150;
                                                                                                                    do {
                                                                                                                            r19 = 0x0;
                                                                                                                            do {
                                                                                                                                    if (*var_150 != r23) {
                                                                                                                                            objc_enumerationMutation(r22);
                                                                                                                                    }
                                                                                                                                    r20 = *(var_158 + r19 * 0x8);
                                                                                                                                    r0 = [r26 getAssociationDictionaryForKey:r20 withExtensionAssociations:r22];
                                                                                                                                    r0 = [r0 retain];
                                                                                                                                    r27 = r0;
                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                            r0 = r26->relateDocTypesToMenus;
                                                                                                                                            r26 = r24;
                                                                                                                                            r0 = [r0 objectForKey:r24];
                                                                                                                                            r0 = [r0 retain];
                                                                                                                                            r24 = r0;
                                                                                                                                            r20 = [[r0 objectForKey:r20] retain];
                                                                                                                                            if (r21 != 0x0) {
                                                                                                                                                    if (r20 != 0x0 && [r20 length] != 0x0) {
                                                                                                                                                            if ([r20 compare:r21 options:0x1] == 0x0) {
                                                                                                                                                                    [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    if ([r20 length] == 0x0) {
                                                                                                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            [r20 release];
                                                                                                                                            [r24 release];
                                                                                                                                            r24 = r26;
                                                                                                                                            r26 = var_170;
                                                                                                                                    }
                                                                                                                                    [r27 release];
                                                                                                                                    r19 = r19 + 0x1;
                                                                                                                            } while (r25 != r19);
                                                                                                                            r0 = [r22 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                                                            r25 = r0;
                                                                                                                    } while (r0 != 0x0);
                                                                                                            }
                                                                                                            [r22 release];
                                                                                                            if (var_198 == 0x0) {
                                                                                                                    r22 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType"] retain];
                                                                                                                    r20 = [[NSDictionary dictionaryWithObjectsAndKeys:r22] retain];
                                                                                                                    [var_180 addObject:r20];
                                                                                                                    [r20 release];
                                                                                                                    [r22 release];
                                                                                                            }
                                                                                                            [var_190 setObject:var_180 forKey:@"CFBundleDocumentTypes"];
                                                                                                            r22 = [[NSArray arrayWithObject:@"mailto"] retain];
                                                                                                            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Email Address URL"] retain];
                                                                                                            [r22 release];
                                                                                                            var_170 = r20;
                                                                                                            r20 = [[NSArray arrayWithObject:r20] retain];
                                                                                                            [var_190 setObject:r20 forKey:@"CFBundleURLTypes"];
                                                                                                            [r20 release];
                                                                                                            var_168 = 0x0;
                                                                                                            r2 = var_190;
                                                                                                            r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_168];
                                                                                                            r27 = [r0 retain];
                                                                                                            r25 = [var_168 retain];
                                                                                                            [var_1D0 release];
                                                                                                            [var_1B0 release];
                                                                                                            r28 = var_1C8;
                                                                                                            r23 = var_1C0;
                                                                                                            if (r27 != 0x0) {
                                                                                                                    r20 = var_1E0;
                                                                                                                    r19 = var_1D8;
                                                                                                                    if (([r27 writeToFile:r20 atomically:0x1] & 0x1) != 0x0) {
                                                                                                                            [r26 informSystemOfUpdatedApp:r19];
                                                                                                                            r22 = 0x1;
                                                                                                                            r26 = var_1E8;
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            NSLog(@"Failed to write %@\n", r1);
                                                                                                                            r26 = var_1E8;
                                                                                                                            if (var_1B4 != 0x0) {
                                                                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                                                                            }
                                                                                                                            r22 = 0x0;
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r20 = var_1E0;
                                                                                                                    NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                                                                                                    r19 = var_1D8;
                                                                                                                    if (var_1B4 != 0x0) {
                                                                                                                            [r28 removeItemAtPath:r19 error:0x0];
                                                                                                                    }
                                                                                                                    r22 = 0x0;
                                                                                                                    r26 = var_1E8;
                                                                                                            }
                                                                                                            [var_170 release];
                                                                                                            [var_180 release];
                                                                                                            [r21 release];
                                                                                                            [var_188 release];
                                                                                                    }
                                                                                                    else {
                                                                                                            r25 = r0;
                                                                                                            NSLog(@"Couldn't parse %@: %@\n", r1, r2);
                                                                                                            if (var_1B4 != 0x0) {
                                                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                                                            }
                                                                                                            r22 = 0x0;
                                                                                                            r27 = var_1B0;
                                                                                                    }
                                                                                                    [var_190 release];
                                                                                                    [r25 release];
                                                                                                    [r27 release];
                                                                                                    [r20 release];
                                                                                                    [var_1A0 release];
                                                                                                    [var_1A8 release];
                                                                                                    [r19 release];
                                                                                                    [r28 release];
                                                                                                    [r23 release];
                                                                                                    [r26 release];
                                                                                                    [var_178 release];
                                                                                                    r0 = [r24 release];
                                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                                    r0 = r22;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", r1, @"/usr/bin/ditto");
                                                                                            [r25 release];
                                                                                            [r22 release];
                                                                                            [r21 release];
                                                                                            r0 = var_1A0;
                                                                                            [r0 release];
                                                                                            [r19 release];
                                                                                            r19 = r23;
                                                                                            r24 = var_180;
                                                                                            r23 = var_1C0;
                                                                                            [r19 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r26 release];
                                                                                            [var_178 release];
                                                                                            r0 = [r24 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                            r0 = 0x0;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    NSLog(@"Failed to create the associations helper app bundle dir '%@'\n", r1);
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    r0 = r25;
                                                                                    [r0 release];
                                                                                    [r19 release];
                                                                                    r19 = r23;
                                                                                    r24 = var_180;
                                                                                    r23 = var_1C0;
                                                                                    [r19 release];
                                                                                    [r28 release];
                                                                                    [r23 release];
                                                                                    [r26 release];
                                                                                    [var_178 release];
                                                                                    r0 = [r24 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                                    r0 = 0x0;
                                                                            }
                                                                    }
                                                                    else {
                                                                            var_1A0 = r25;
                                                                            var_88 = @"-x";
                                                                            r0 = [NSArray arrayWithObjects:&var_88 count:0x5];
                                                                            r27 = [r0 retain];
                                                                            r25 = [[CXTask launchedTaskWithLaunchPath:@"/usr/bin/ditto" arguments:r27] retain];
                                                                            [r27 release];
                                                                            [r25 waitUntilExit];
                                                                            if ([r25 terminationReason] == 0x1) {
                                                                                    if ([r25 terminationStatus] != 0x0) {
                                                                                            NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", r1, @"/usr/bin/ditto");
                                                                                            [r25 release];
                                                                                            [r22 release];
                                                                                            [r21 release];
                                                                                            r0 = var_1A0;
                                                                                            [r0 release];
                                                                                            [r19 release];
                                                                                            r19 = r23;
                                                                                            r24 = var_180;
                                                                                            r23 = var_1C0;
                                                                                            [r19 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r26 release];
                                                                                            [var_178 release];
                                                                                            r0 = [r24 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                            r0 = 0x0;
                                                                                    }
                                                                                    else {
                                                                                            [r28 makeWritableAtPath:r23 recursively:0x1];
                                                                                            [r25 release];
                                                                                            [r22 release];
                                                                                            r25 = var_1A0;
                                                                                            var_1B4 = r24 ^ 0x1;
                                                                                            [r21 release];
                                                                                            r27 = r19;
                                                                                            r19 = r23;
                                                                                            r24 = var_180;
                                                                                            r23 = var_1C0;
                                                                                            r21 = var_198;
                                                                                            r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                                            r0 = [r0 retain];
                                                                                            r20 = r0;
                                                                                            r8 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                                                                                            r0 = r20;
                                                                                            r20 = r8;
                                                                                            [r0 release];
                                                                                            r2 = [[NSData dataWithContentsOfFile:r20] retain];
                                                                                            var_118 = 0x0;
                                                                                            var_1B0 = r2;
                                                                                            r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                                                                                            r22 = [r0 retain];
                                                                                            r0 = [var_118 retain];
                                                                                            var_190 = r22;
                                                                                            var_1A8 = r27;
                                                                                            var_1A0 = r25;
                                                                                            if (r22 != 0x0) {
                                                                                                    var_1D0 = r0;
                                                                                                    var_1E0 = r20;
                                                                                                    [r22 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                                                                                                    [r22 setObject:r24 forKey:@"CXHelperAppBottleTag"];
                                                                                                    r20 = [@(0x2b) retain];
                                                                                                    [r22 setObject:r20 forKey:@"CXHelperAppVersion"];
                                                                                                    [r20 release];
                                                                                                    var_1C8 = r28;
                                                                                                    var_1C0 = r23;
                                                                                                    var_198 = r21;
                                                                                                    if (r21 != 0x0) {
                                                                                                            r0 = [r22 valueForKey:**_kCFBundleIdentifierKey];
                                                                                                            r0 = [r0 retain];
                                                                                                            r21 = r0;
                                                                                                            [r0 release];
                                                                                                            if (r21 == 0x0) {
                                                                                                                    r20 = **_kCFBundleIdentifierKey;
                                                                                                                    r21 = [[var_170 shortenedBundleID:r25] retain];
                                                                                                                    [r22 setObject:r21 forKey:r20];
                                                                                                                    [r21 release];
                                                                                                            }
                                                                                                            r0 = [r22 valueForKey:**_kCFBundleNameKey];
                                                                                                            r0 = [r0 retain];
                                                                                                            r21 = r0;
                                                                                                            [r0 release];
                                                                                                            if (r21 == 0x0) {
                                                                                                                    [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r20 = [[var_170 shortenedBundleID:r25] retain];
                                                                                                            [r22 setObject:r20 forKey:**_kCFBundleIdentifierKey];
                                                                                                            [r20 release];
                                                                                                            [r22 setObject:r27 forKey:**_kCFBundleNameKey];
                                                                                                            r0 = [r22 valueForKey:**_kUTImportedTypeDeclarationsKey];
                                                                                                            r0 = [r0 retain];
                                                                                                            r21 = r0;
                                                                                                            [r0 release];
                                                                                                            if (r21 == 0x0) {
                                                                                                                    r20 = **_kUTImportedTypeDeclarationsKey;
                                                                                                                    r21 = [[NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:**_kUTTypeIdentifierKey] retain];
                                                                                                                    r22 = [[NSArray arrayWithObject:r21] retain];
                                                                                                                    [var_190 setObject:r22 forKey:r20];
                                                                                                                    r0 = r22;
                                                                                                                    r22 = var_190;
                                                                                                                    [r0 release];
                                                                                                                    [r21 release];
                                                                                                            }
                                                                                                    }
                                                                                                    var_1D8 = r19;
                                                                                                    r0 = [r19 stringByAppendingPathComponent:@"Contents"];
                                                                                                    r0 = [r0 retain];
                                                                                                    r20 = r0;
                                                                                                    var_188 = [[r0 stringByAppendingPathComponent:@"Resources"] retain];
                                                                                                    [r20 release];
                                                                                                    r21 = [[r22 objectForKey:@"CrossOverHelperMenuPath"] retain];
                                                                                                    var_180 = [[NSMutableArray arrayWithCapacity:[r26 count] + 0x1] retain];
                                                                                                    var_160 = q0;
                                                                                                    var_150 = q0;
                                                                                                    var_1E8 = r26;
                                                                                                    r0 = [r26 retain];
                                                                                                    r22 = r0;
                                                                                                    r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                                    r26 = var_170;
                                                                                                    if (r0 != 0x0) {
                                                                                                            r25 = r0;
                                                                                                            r23 = *var_150;
                                                                                                            do {
                                                                                                                    r19 = 0x0;
                                                                                                                    do {
                                                                                                                            if (*var_150 != r23) {
                                                                                                                                    objc_enumerationMutation(r22);
                                                                                                                            }
                                                                                                                            r20 = *(var_158 + r19 * 0x8);
                                                                                                                            r0 = [r26 getAssociationDictionaryForKey:r20 withExtensionAssociations:r22];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r27 = r0;
                                                                                                                            if (r0 != 0x0) {
                                                                                                                                    r0 = r26->relateDocTypesToMenus;
                                                                                                                                    r26 = r24;
                                                                                                                                    r0 = [r0 objectForKey:r24];
                                                                                                                                    r0 = [r0 retain];
                                                                                                                                    r24 = r0;
                                                                                                                                    r20 = [[r0 objectForKey:r20] retain];
                                                                                                                                    if (r21 != 0x0) {
                                                                                                                                            if (r20 != 0x0 && [r20 length] != 0x0) {
                                                                                                                                                    if ([r20 compare:r21 options:0x1] == 0x0) {
                                                                                                                                                            [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            if ([r20 length] == 0x0) {
                                                                                                                                                    [var_170 addDocumentTypeDictionary:r27 forBottle:var_178 toBundleArray:var_180 andResourcesDir:var_188];
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    [r20 release];
                                                                                                                                    [r24 release];
                                                                                                                                    r24 = r26;
                                                                                                                                    r26 = var_170;
                                                                                                                            }
                                                                                                                            [r27 release];
                                                                                                                            r19 = r19 + 0x1;
                                                                                                                    } while (r25 != r19);
                                                                                                                    r0 = [r22 countByEnumeratingWithState:&var_160 objects:&decomp_var_108 count:0x10];
                                                                                                                    r25 = r0;
                                                                                                            } while (r0 != 0x0);
                                                                                                    }
                                                                                                    [r22 release];
                                                                                                    if (var_198 == 0x0) {
                                                                                                            r22 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType"] retain];
                                                                                                            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:r22] retain];
                                                                                                            [var_180 addObject:r20];
                                                                                                            [r20 release];
                                                                                                            [r22 release];
                                                                                                    }
                                                                                                    [var_190 setObject:var_180 forKey:@"CFBundleDocumentTypes"];
                                                                                                    r22 = [[NSArray arrayWithObject:@"mailto"] retain];
                                                                                                    r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Email Address URL"] retain];
                                                                                                    [r22 release];
                                                                                                    var_170 = r20;
                                                                                                    r20 = [[NSArray arrayWithObject:r20] retain];
                                                                                                    [var_190 setObject:r20 forKey:@"CFBundleURLTypes"];
                                                                                                    [r20 release];
                                                                                                    var_168 = 0x0;
                                                                                                    r2 = var_190;
                                                                                                    r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_168];
                                                                                                    r27 = [r0 retain];
                                                                                                    r25 = [var_168 retain];
                                                                                                    [var_1D0 release];
                                                                                                    [var_1B0 release];
                                                                                                    r28 = var_1C8;
                                                                                                    r23 = var_1C0;
                                                                                                    if (r27 != 0x0) {
                                                                                                            r20 = var_1E0;
                                                                                                            r19 = var_1D8;
                                                                                                            if (([r27 writeToFile:r20 atomically:0x1] & 0x1) != 0x0) {
                                                                                                                    [r26 informSystemOfUpdatedApp:r19];
                                                                                                                    r22 = 0x1;
                                                                                                                    r26 = var_1E8;
                                                                                                            }
                                                                                                            else {
                                                                                                                    NSLog(@"Failed to write %@\n", r1);
                                                                                                                    r26 = var_1E8;
                                                                                                                    if (var_1B4 != 0x0) {
                                                                                                                            [r28 removeItemAtPath:r19 error:0x0];
                                                                                                                    }
                                                                                                                    r22 = 0x0;
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r20 = var_1E0;
                                                                                                            NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                                                                                            r19 = var_1D8;
                                                                                                            if (var_1B4 != 0x0) {
                                                                                                                    [r28 removeItemAtPath:r19 error:0x0];
                                                                                                            }
                                                                                                            r22 = 0x0;
                                                                                                            r26 = var_1E8;
                                                                                                    }
                                                                                                    [var_170 release];
                                                                                                    [var_180 release];
                                                                                                    [r21 release];
                                                                                                    [var_188 release];
                                                                                            }
                                                                                            else {
                                                                                                    r25 = r0;
                                                                                                    NSLog(@"Couldn't parse %@: %@\n", r1, r2);
                                                                                                    if (var_1B4 != 0x0) {
                                                                                                            [r28 removeItemAtPath:r19 error:0x0];
                                                                                                    }
                                                                                                    r22 = 0x0;
                                                                                                    r27 = var_1B0;
                                                                                            }
                                                                                            [var_190 release];
                                                                                            [r25 release];
                                                                                            [r27 release];
                                                                                            [r20 release];
                                                                                            [var_1A0 release];
                                                                                            [var_1A8 release];
                                                                                            [r19 release];
                                                                                            [r28 release];
                                                                                            [r23 release];
                                                                                            [r26 release];
                                                                                            [var_178 release];
                                                                                            r0 = [r24 release];
                                                                                            if (**___stack_chk_guard != var_60) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                            r0 = r22;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", r1, @"/usr/bin/ditto");
                                                                                    [r25 release];
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    r0 = var_1A0;
                                                                                    [r0 release];
                                                                                    [r19 release];
                                                                                    r19 = r23;
                                                                                    r24 = var_180;
                                                                                    r23 = var_1C0;
                                                                                    [r19 release];
                                                                                    [r28 release];
                                                                                    [r23 release];
                                                                                    [r26 release];
                                                                                    [var_178 release];
                                                                                    r0 = [r24 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                                    r0 = 0x0;
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    NSLog(@"Unable to determine helperAppContentsArchive.\n");
                                                                    r0 = r25;
                                                                    [r0 release];
                                                                    [r19 release];
                                                                    r19 = r23;
                                                                    r24 = var_180;
                                                                    r23 = var_1C0;
                                                                    [r19 release];
                                                                    [r28 release];
                                                                    [r23 release];
                                                                    [r26 release];
                                                                    [var_178 release];
                                                                    r0 = [r24 release];
                                                                    if (**___stack_chk_guard != var_60) {
                                                                            __stack_chk_fail();
                                                                    }
                                                                    r0 = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    NSLog(@"Unable to determine location of helper app.\n");
                                                    r23 = var_1C0;
                                                    [r21 release];
                                                    [r25 release];
                                                    [r19 release];
                                                    [r28 release];
                                                    [r23 release];
                                                    [r26 release];
                                                    [var_178 release];
                                                    r0 = [r24 release];
                                                    if (**___stack_chk_guard != var_60) {
                                                            __stack_chk_fail();
                                                    }
                                                    r0 = 0x0;
                                            }
                                    }
                                    else {
                                            NSLog(@"Couldn't create %@\n", r1);
                                            [r21 release];
                                            [r25 release];
                                            [r19 release];
                                            [r28 release];
                                            [r23 release];
                                            [r26 release];
                                            [var_178 release];
                                            r0 = [r24 release];
                                            if (**___stack_chk_guard != var_60) {
                                                    __stack_chk_fail();
                                            }
                                            r0 = 0x0;
                                    }
                            }
                    }
                    else {
                            NSLog(@"Unable to determine directory for helpers.\n");
                            [r25 release];
                            [r19 release];
                            [r28 release];
                            [r23 release];
                            [r26 release];
                            [var_178 release];
                            r0 = [r24 release];
                            if (**___stack_chk_guard != var_60) {
                                    __stack_chk_fail();
                            }
                            r0 = 0x0;
                    }
            }
    }
    return r0;


// 0x1000514bc
// -[CXServerCrossOver launchHelper:]
    r0 = [arg2 representedObject];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 objectForKey:@"Helper"] retain];
    r0 = [NSWorkspace sharedWorkspace];
    r0 = [r0 retain];
    r21 = r0;
    [r0 launchApplication:r20];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x10005153c
// -[CXServerCrossOver exportProgram:bundleName:withDictionary:toFolder:]
    r4 = arg4;
    r3 = arg3;
    r1 = _cmd;
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
    r31 = r31 + 0xffffffffffffffa0 - 0x220;
    r21 = r4;
    r20 = r3;
    var_60 = **___stack_chk_guard;
    r25 = [arg2 retain];
    r24 = [r20 retain];
    r21 = [r21 retain];
    r27 = [arg5 retain];
    r0 = [[NSFileManager alloc] init];
    r23 = r0;
    var_1B8 = self;
    [r0 setDelegate:self];
    if (r24 == 0x0) {
            r24 = [r25 retain];
    }
    var_180 = r25;
    r0 = [r27 stringByAppendingPathComponent:r25];
    r0 = [r0 retain];
    r22 = r0;
    r19 = [[r0 stringByAppendingPathExtension:@"app"] retain];
    [r22 release];
    r28 = [[r19 stringByAppendingPathComponent:@"Contents"] retain];
    r25 = [[r21 objectForKey:@"namepath"] retain];
    r20 = [[r21 objectForKey:@"bottlename"] retain];
    var_188 = [[r21 objectForKey:@"bottletag"] retain];
    r0 = [r21 objectForKey:@"origname"];
    r0 = [r0 retain];
    var_1A0 = r25;
    var_198 = r0;
    r0 = [r25 arrayByAddingObject:r0];
    r0 = [r0 retain];
    r25 = r0;
    r26 = [[r0 componentsJoinedByString:@"."] retain];
    var_178 = r20;
    r22 = [[NSString stringWithFormat:@"com.codeweavers.CrossOverHelper.%@.%@", r3, r4] retain];
    [r26 release];
    r0 = r25;
    r25 = r19;
    [r0 release];
    r0 = [r23 removeItemAtPath:r28 error:0x0];
    var_190 = r24;
    if ((r0 & 0x1) == 0x0) {
            if ([r23 createDirectoryAtPath:r25 attributes:0x0 recursively:0x1] != 0x0) {
                    var_1B0 = r22;
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r22 = r0;
                    r19 = [[r0 pathForResource:@"Menu Helper" ofType:@"cpbz2"] retain];
                    [r22 release];
                    var_88 = @"-x";
                    var_1A8 = r25;
                    r0 = [NSArray arrayWithObjects:&var_88 count:0x5];
                    r25 = [r0 retain];
                    r20 = [[NSTask launchedTaskWithLaunchPath:@"/usr/bin/ditto" arguments:r25] retain];
                    [r25 release];
                    [r20 waitUntilExit];
                    if ([r20 terminationReason] == 0x1 && [r20 terminationStatus] == 0x0) {
                            var_200 = r27;
                            [r23 makeWritableAtPath:var_1A8 recursively:0x1];
                            r0 = [r28 stringByAppendingPathComponent:@"Resources"];
                            r0 = [r0 retain];
                            var_1D8 = r0;
                            var_1D0 = [[r0 stringByAppendingPathComponent:@"CrossOverHelper.icns"] retain];
                            r0 = [r21 objectForKey:@"RobustIcon"];
                            r0 = [r0 retain];
                            var_1F0 = r28;
                            var_1E8 = r19;
                            if (r0 != 0x0) {
                                    r26 = r0;
                                    r0 = [CXSetupLib bottleCollectionClass];
                                    r0 = [r0 sharedCollection];
                                    r0 = [r0 retain];
                                    r27 = r0;
                                    r25 = [[r0 bottleWithName:var_178] retain];
                                    [r27 release];
                                    r27 = [[r25 winePrefix] retain];
                                    [r26 length];
                                    r28 = [[r26 stringByReplacingOccurrencesOfString:@"%WINEPREFIX%" withString:r27 options:0x8 range:0x0] retain];
                                    [r26 release];
                                    [r27 release];
                                    r26 = [[**_NSApp crossOverRoot] retain];
                                    [r28 length];
                                    r27 = [[r28 stringByReplacingOccurrencesOfString:@"%CX_ROOT%" withString:r26 options:0x8 range:0x0] retain];
                                    [r28 release];
                                    [r26 release];
                                    [r25 release];
                                    if (r27 != 0x0) {
                                            r0 = [r23 fileExistsAtPath:r27];
                                            var_1C0 = r27;
                                            if (r0 != 0x0) {
                                                    r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                                    r19 = var_1E8;
                                                    r26 = [[NSURL fileURLWithPath:r27] retain];
                                                    r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                                    [r26 release];
                                                    [r25 release];
                                                    r28 = var_1F0;
                                                    if ((r27 & 0x1) == 0x0) {
                                                            r24 = [[r21 objectForKey:@"Icon"] retain];
                                                            [var_1C0 release];
                                                            var_1C0 = r24;
                                                            if (r24 != 0x0) {
                                                                    if ([r23 fileExistsAtPath:r24] != 0x0) {
                                                                            r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                                                            r19 = var_1E8;
                                                                            r26 = [[NSURL fileURLWithPath:r24] retain];
                                                                            r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                                                            [r26 release];
                                                                            [r25 release];
                                                                            if ((r27 & 0x1) == 0x0) {
                                                                                    r0 = [NSBundle mainBundle];
                                                                                    r0 = [r0 retain];
                                                                                    r25 = r0;
                                                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                                    [r25 release];
                                                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                                    [r26 release];
                                                                            }
                                                                    }
                                                                    else {
                                                                            r0 = [NSBundle mainBundle];
                                                                            r0 = [r0 retain];
                                                                            r25 = r0;
                                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                            [r25 release];
                                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                            [r26 release];
                                                                    }
                                                            }
                                                            else {
                                                                    r0 = [NSBundle mainBundle];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                    [r25 release];
                                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                    [r26 release];
                                                            }
                                                    }
                                            }
                                            else {
                                                    r28 = var_1F0;
                                                    r24 = [[r21 objectForKey:@"Icon"] retain];
                                                    [var_1C0 release];
                                                    var_1C0 = r24;
                                                    if (r24 != 0x0) {
                                                            if ([r23 fileExistsAtPath:r24] != 0x0) {
                                                                    r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                                                    r19 = var_1E8;
                                                                    r26 = [[NSURL fileURLWithPath:r24] retain];
                                                                    r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                                                    [r26 release];
                                                                    [r25 release];
                                                                    if ((r27 & 0x1) == 0x0) {
                                                                            r0 = [NSBundle mainBundle];
                                                                            r0 = [r0 retain];
                                                                            r25 = r0;
                                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                            [r25 release];
                                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                            [r26 release];
                                                                    }
                                                            }
                                                            else {
                                                                    r0 = [NSBundle mainBundle];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                    [r25 release];
                                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                    [r26 release];
                                                            }
                                                    }
                                                    else {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                            [r25 release];
                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                            [r26 release];
                                                    }
                                            }
                                    }
                                    else {
                                            var_1C0 = 0x0;
                                            r28 = var_1F0;
                                            r24 = [[r21 objectForKey:@"Icon"] retain];
                                            [var_1C0 release];
                                            var_1C0 = r24;
                                            if (r24 != 0x0) {
                                                    if ([r23 fileExistsAtPath:r24] != 0x0) {
                                                            r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                                            r19 = var_1E8;
                                                            r26 = [[NSURL fileURLWithPath:r24] retain];
                                                            r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                                            [r26 release];
                                                            [r25 release];
                                                            if ((r27 & 0x1) == 0x0) {
                                                                    r0 = [NSBundle mainBundle];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                    [r25 release];
                                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                    [r26 release];
                                                            }
                                                    }
                                                    else {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                            [r25 release];
                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                            [r26 release];
                                                    }
                                            }
                                            else {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                    [r25 release];
                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                    [r26 release];
                                            }
                                    }
                            }
                            else {
                                    var_1C0 = 0x0;
                                    r24 = [[r21 objectForKey:@"Icon"] retain];
                                    [var_1C0 release];
                                    var_1C0 = r24;
                                    if (r24 != 0x0) {
                                            if ([r23 fileExistsAtPath:r24] != 0x0) {
                                                    r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                                    r19 = var_1E8;
                                                    r26 = [[NSURL fileURLWithPath:r24] retain];
                                                    r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                                    [r26 release];
                                                    [r25 release];
                                                    if ((r27 & 0x1) == 0x0) {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                            [r25 release];
                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                            [r26 release];
                                                    }
                                            }
                                            else {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                    [r25 release];
                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                    [r26 release];
                                            }
                                    }
                                    else {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                            [r25 release];
                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                            [r26 release];
                                    }
                            }
                            r0 = [var_1D8 stringByDeletingLastPathComponent];
                            r0 = [r0 retain];
                            r25 = r0;
                            r26 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                            [r25 release];
                            r27 = [[NSData dataWithContentsOfFile:r26] retain];
                            var_118 = 0x0;
                            r2 = r27;
                            r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                            r24 = [r0 retain];
                            r0 = [var_118 retain];
                            var_1C8 = r24;
                            var_208 = r20;
                            if (r24 != 0x0) {
                                    var_238 = r0;
                                    var_230 = r27;
                                    var_210 = r26;
                                    r25 = [[var_1B8 shortenedBundleID:var_1B0] retain];
                                    [r24 setObject:r25 forKey:@"CFBundleIdentifier"];
                                    [r25 release];
                                    r25 = [[r21 objectForKey:@"Command"] retain];
                                    [r24 setObject:r25 forKey:@"CrossOverHelperCommand"];
                                    [r25 release];
                                    [r24 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                                    r25 = [@(0x2b) retain];
                                    [r24 setObject:r25 forKey:@"CXHelperAppVersion"];
                                    [r25 release];
                                    [r24 setObject:var_188 forKey:@"CXHelperAppBottleTag"];
                                    [r24 setObject:var_198 forKey:@"CXOriginalMenuName"];
                                    [r24 setObject:var_190 forKey:**_kCFBundleNameKey];
                                    r0 = [r21 objectForKey:@"RawPath"];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    if (r0 != 0x0) {
                                            [r24 setObject:r19 forKey:@"CrossOverHelperMenuPath"];
                                    }
                                    var_1E0 = r19;
                                    r0 = [NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.MenuDummyType" forKey:**_kUTTypeIdentifierKey];
                                    r0 = [r0 retain];
                                    var_218 = r0;
                                    r0 = [NSArray arrayWithObject:r0];
                                    r0 = [r0 retain];
                                    var_220 = r0;
                                    [var_1C8 setObject:r0 forKey:**_kUTImportedTypeDeclarationsKey];
                                    r27 = [[NSMutableArray array] retain];
                                    r24 = var_1C8;
                                    r25 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.MenuDummyType"] retain];
                                    r26 = [[NSDictionary dictionaryWithObjectsAndKeys:r25] retain];
                                    [r27 addObject:r26];
                                    [r26 release];
                                    r0 = r25;
                                    r25 = var_1E0;
                                    [r0 release];
                                    var_228 = r27;
                                    [r24 setObject:r27 forKey:@"CFBundleDocumentTypes"];
                                    var_1F8 = [[NSMutableArray arrayWithCapacity:0x2] retain];
                                    r19 = var_180;
                                    r0 = [r19 caseInsensitiveCompare:@"BIZTEL"];
                                    if (r25 != 0x0) {
                                            if (r0 != 0x0) {
                                                    r0 = [r25 lastPathComponent];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [r0 caseInsensitiveCompare:@"BIZTEL"];
                                                    r0 = r25;
                                                    r25 = var_1E0;
                                                    r19 = var_180;
                                                    [r0 release];
                                                    if (r26 == 0x0) {
                                                            r26 = [[NSArray arrayWithObject:@"callto"] retain];
                                                            r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Call Phone Number URL"] retain];
                                                            [r26 release];
                                                            [var_1F8 addObject:r25];
                                                            r0 = r25;
                                                            r25 = var_1E0;
                                                            r19 = var_180;
                                                            [r0 release];
                                                    }
                                            }
                                            else {
                                                    if (r0 == 0x0) {
                                                            r26 = [[NSArray arrayWithObject:@"callto"] retain];
                                                            r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Call Phone Number URL"] retain];
                                                            [r26 release];
                                                            [var_1F8 addObject:r25];
                                                            r0 = r25;
                                                            r25 = var_1E0;
                                                            r19 = var_180;
                                                            [r0 release];
                                                    }
                                            }
                                    }
                                    else {
                                            if (r0 == 0x0) {
                                                    r26 = [[NSArray arrayWithObject:@"callto"] retain];
                                                    r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Call Phone Number URL"] retain];
                                                    [r26 release];
                                                    [var_1F8 addObject:r25];
                                                    r0 = r25;
                                                    r25 = var_1E0;
                                                    r19 = var_180;
                                                    [r0 release];
                                            }
                                    }
                                    r0 = [r19 caseInsensitiveCompare:@"Steam"];
                                    r19 = var_1E8;
                                    r27 = var_230;
                                    if (r25 != 0x0) {
                                            if (r0 != 0x0) {
                                                    r0 = [r25 lastPathComponent];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [r0 caseInsensitiveCompare:@"Steam"];
                                                    [r25 release];
                                                    if (r26 == 0x0) {
                                                            r26 = [[NSArray arrayWithObject:@"steam"] retain];
                                                            r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Steam URL"] retain];
                                                            [r26 release];
                                                            [var_1F8 addObject:r25];
                                                            [r25 release];
                                                    }
                                            }
                                            else {
                                                    if (r0 == 0x0) {
                                                            r26 = [[NSArray arrayWithObject:@"steam"] retain];
                                                            r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Steam URL"] retain];
                                                            [r26 release];
                                                            [var_1F8 addObject:r25];
                                                            [r25 release];
                                                    }
                                            }
                                    }
                                    else {
                                            if (r0 == 0x0) {
                                                    r26 = [[NSArray arrayWithObject:@"steam"] retain];
                                                    r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Steam URL"] retain];
                                                    [r26 release];
                                                    [var_1F8 addObject:r25];
                                                    [r25 release];
                                            }
                                    }
                                    r25 = var_1F8;
                                    if ([r25 count] != 0x0) {
                                            [r24 setObject:r25 forKey:@"CFBundleURLTypes"];
                                    }
                                    var_120 = 0x0;
                                    r2 = r24;
                                    r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_120];
                                    r25 = [r0 retain];
                                    r20 = [var_120 retain];
                                    [var_238 release];
                                    [r27 release];
                                    r27 = var_200;
                                    r28 = var_1F0;
                                    r24 = var_210;
                                    var_240 = r25;
                                    if (r25 != 0x0) {
                                            var_128 = 0x0;
                                            r2 = r24;
                                            r0 = [r25 writeToFile:r2 options:0x1 error:&var_128];
                                            r26 = r0;
                                            r25 = [var_128 retain];
                                            r22 = r20;
                                            if ((r26 & 0x1) != 0x0) {
                                                    [r25 release];
                                                    r24 = sign_extend_64(*(int32_t *)ivar_offset(relateDocTypesToMenus));
                                                    r0 = *(var_1B8 + r24);
                                                    r0 = [r0 objectForKey:var_188];
                                                    r0 = [r0 retain];
                                                    r26 = r0;
                                                    r0 = [r0 allKeysForObject:var_1E0];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    var_170 = q0;
                                                    var_160 = q0;
                                                    r0 = [r0 countByEnumeratingWithState:&var_170 objects:&decomp_var_108 count:0x10];
                                                    if (r0 != 0x0) {
                                                            r27 = r0;
                                                            r20 = *var_160;
                                                            do {
                                                                    r19 = 0x0;
                                                                    do {
                                                                            if (*var_160 != r20) {
                                                                                    objc_enumerationMutation(r25);
                                                                            }
                                                                            [r26 setObject:@"" forKey:*(var_168 + r19 * 0x8)];
                                                                            r19 = r19 + 0x1;
                                                                    } while (r27 != r19);
                                                                    r0 = [r25 countByEnumeratingWithState:&var_170 objects:&decomp_var_108 count:0x10];
                                                                    r27 = r0;
                                                            } while (r0 != 0x0);
                                                    }
                                                    r0 = [NSUserDefaults standardUserDefaults];
                                                    r0 = [r0 retain];
                                                    r27 = r0;
                                                    [r0 setObject:*(var_1B8 + r24) forKey:@"DocTypeToMenuPathMap"];
                                                    [r27 release];
                                                    [var_1B8 informSystemOfUpdatedApp:var_1A8];
                                                    r0 = r25;
                                                    r25 = var_1A8;
                                                    [r0 release];
                                                    [r26 release];
                                                    r26 = 0x1;
                                                    r27 = var_200;
                                                    r28 = var_1F0;
                                                    r19 = var_1E8;
                                            }
                                            else {
                                                    NSLog(@"Failed to write %@\n    %@\n", r1, r2);
                                                    [r23 removeItemAtPath:var_1A8 error:0x0];
                                                    r0 = r25;
                                                    r25 = var_1A8;
                                                    r19 = var_1E8;
                                                    [r0 release];
                                                    r26 = 0x0;
                                            }
                                    }
                                    else {
                                            r22 = r20;
                                            NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                            r25 = var_1A8;
                                            [r23 removeItemAtPath:r25 error:0x0];
                                            r26 = 0x0;
                                    }
                                    [var_1F8 release];
                                    [var_228 release];
                                    [var_220 release];
                                    [var_218 release];
                                    [var_1E0 release];
                                    r24 = var_210;
                                    r20 = var_240;
                            }
                            else {
                                    r22 = r0;
                                    NSLog(@"Failed to load %@: %@\n", r1, r2);
                                    r25 = var_1A8;
                                    [r23 removeItemAtPath:r25 error:0x0];
                                    r24 = r26;
                                    r26 = 0x0;
                                    r20 = r27;
                                    r27 = var_200;
                            }
                            [var_1C8 release];
                            [r22 release];
                            [r20 release];
                            [r24 release];
                            [var_1C0 release];
                            [var_1D0 release];
                            [var_1D8 release];
                            r20 = var_208;
                    }
                    else {
                            r26 = 0x0;
                            r25 = var_1A8;
                    }
                    [r20 release];
                    [r19 release];
                    r22 = var_1B0;
                    [r22 release];
                    [var_198 release];
                    [var_188 release];
                    [var_178 release];
                    [var_1A0 release];
                    [r28 release];
                    [r25 release];
                    [r23 release];
                    [r27 release];
                    [r21 release];
                    [var_190 release];
                    r0 = [var_180 release];
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = r26;
            }
            else {
                    [r22 release];
                    [var_198 release];
                    [var_188 release];
                    [var_178 release];
                    [var_1A0 release];
                    [r28 release];
                    [r25 release];
                    [r23 release];
                    [r27 release];
                    [r21 release];
                    [var_190 release];
                    r0 = [var_180 release];
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = 0x0;
            }
    }
    else {
            var_1B0 = r22;
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r19 = [[r0 pathForResource:@"Menu Helper" ofType:@"cpbz2"] retain];
            [r22 release];
            var_88 = @"-x";
            var_1A8 = r25;
            r0 = [NSArray arrayWithObjects:&var_88 count:0x5];
            r25 = [r0 retain];
            r20 = [[NSTask launchedTaskWithLaunchPath:@"/usr/bin/ditto" arguments:r25] retain];
            [r25 release];
            [r20 waitUntilExit];
            if ([r20 terminationReason] == 0x1 && [r20 terminationStatus] == 0x0) {
                    var_200 = r27;
                    [r23 makeWritableAtPath:var_1A8 recursively:0x1];
                    r0 = [r28 stringByAppendingPathComponent:@"Resources"];
                    r0 = [r0 retain];
                    var_1D8 = r0;
                    var_1D0 = [[r0 stringByAppendingPathComponent:@"CrossOverHelper.icns"] retain];
                    r0 = [r21 objectForKey:@"RobustIcon"];
                    r0 = [r0 retain];
                    var_1F0 = r28;
                    var_1E8 = r19;
                    if (r0 != 0x0) {
                            r26 = r0;
                            r0 = [CXSetupLib bottleCollectionClass];
                            r0 = [r0 sharedCollection];
                            r0 = [r0 retain];
                            r27 = r0;
                            r25 = [[r0 bottleWithName:var_178] retain];
                            [r27 release];
                            r27 = [[r25 winePrefix] retain];
                            [r26 length];
                            r28 = [[r26 stringByReplacingOccurrencesOfString:@"%WINEPREFIX%" withString:r27 options:0x8 range:0x0] retain];
                            [r26 release];
                            [r27 release];
                            r26 = [[**_NSApp crossOverRoot] retain];
                            [r28 length];
                            r27 = [[r28 stringByReplacingOccurrencesOfString:@"%CX_ROOT%" withString:r26 options:0x8 range:0x0] retain];
                            [r28 release];
                            [r26 release];
                            [r25 release];
                            if (r27 != 0x0) {
                                    r0 = [r23 fileExistsAtPath:r27];
                                    var_1C0 = r27;
                                    if (r0 != 0x0) {
                                            r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                            r19 = var_1E8;
                                            r26 = [[NSURL fileURLWithPath:r27] retain];
                                            r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                            [r26 release];
                                            [r25 release];
                                            r28 = var_1F0;
                                            if ((r27 & 0x1) == 0x0) {
                                                    r24 = [[r21 objectForKey:@"Icon"] retain];
                                                    [var_1C0 release];
                                                    var_1C0 = r24;
                                                    if (r24 != 0x0) {
                                                            if ([r23 fileExistsAtPath:r24] != 0x0) {
                                                                    r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                                                    r19 = var_1E8;
                                                                    r26 = [[NSURL fileURLWithPath:r24] retain];
                                                                    r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                                                    [r26 release];
                                                                    [r25 release];
                                                                    if ((r27 & 0x1) == 0x0) {
                                                                            r0 = [NSBundle mainBundle];
                                                                            r0 = [r0 retain];
                                                                            r25 = r0;
                                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                            [r25 release];
                                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                            [r26 release];
                                                                    }
                                                            }
                                                            else {
                                                                    r0 = [NSBundle mainBundle];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                    [r25 release];
                                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                    [r26 release];
                                                            }
                                                    }
                                                    else {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                            [r25 release];
                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                            [r26 release];
                                                    }
                                            }
                                    }
                                    else {
                                            r28 = var_1F0;
                                            r24 = [[r21 objectForKey:@"Icon"] retain];
                                            [var_1C0 release];
                                            var_1C0 = r24;
                                            if (r24 != 0x0) {
                                                    if ([r23 fileExistsAtPath:r24] != 0x0) {
                                                            r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                                            r19 = var_1E8;
                                                            r26 = [[NSURL fileURLWithPath:r24] retain];
                                                            r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                                            [r26 release];
                                                            [r25 release];
                                                            if ((r27 & 0x1) == 0x0) {
                                                                    r0 = [NSBundle mainBundle];
                                                                    r0 = [r0 retain];
                                                                    r25 = r0;
                                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                                    [r25 release];
                                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                                    [r26 release];
                                                            }
                                                    }
                                                    else {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                            [r25 release];
                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                            [r26 release];
                                                    }
                                            }
                                            else {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                    [r25 release];
                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                    [r26 release];
                                            }
                                    }
                            }
                            else {
                                    var_1C0 = 0x0;
                                    r28 = var_1F0;
                                    r24 = [[r21 objectForKey:@"Icon"] retain];
                                    [var_1C0 release];
                                    var_1C0 = r24;
                                    if (r24 != 0x0) {
                                            if ([r23 fileExistsAtPath:r24] != 0x0) {
                                                    r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                                    r19 = var_1E8;
                                                    r26 = [[NSURL fileURLWithPath:r24] retain];
                                                    r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                                    [r26 release];
                                                    [r25 release];
                                                    if ((r27 & 0x1) == 0x0) {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                            [r25 release];
                                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                            [r26 release];
                                                    }
                                            }
                                            else {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                    [r25 release];
                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                    [r26 release];
                                            }
                                    }
                                    else {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                            [r25 release];
                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                            [r26 release];
                                    }
                            }
                    }
                    else {
                            var_1C0 = 0x0;
                            r24 = [[r21 objectForKey:@"Icon"] retain];
                            [var_1C0 release];
                            var_1C0 = r24;
                            if (r24 != 0x0) {
                                    if ([r23 fileExistsAtPath:r24] != 0x0) {
                                            r25 = [[NSURL fileURLWithPath:var_1D0] retain];
                                            r19 = var_1E8;
                                            r26 = [[NSURL fileURLWithPath:r24] retain];
                                            r27 = [var_1B8 createIcnsFile:r25 fromImageFile:r26 forApp:0x1];
                                            [r26 release];
                                            [r25 release];
                                            if ((r27 & 0x1) == 0x0) {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                                    [r25 release];
                                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                                    [r26 release];
                                            }
                                    }
                                    else {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                            [r25 release];
                                            [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                            [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                            [r26 release];
                                    }
                            }
                            else {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r26 = [[r0 pathForResource:@"exeIcon" ofType:@"icns"] retain];
                                    [r25 release];
                                    [r23 copyItemAtPath:r26 toPath:var_1D0 error:0x0];
                                    [r23 makeWritableAtPath:var_1D0 recursively:0x0];
                                    [r26 release];
                            }
                    }
                    r0 = [var_1D8 stringByDeletingLastPathComponent];
                    r0 = [r0 retain];
                    r25 = r0;
                    r26 = [[r0 stringByAppendingPathComponent:@"Info.plist"] retain];
                    [r25 release];
                    r27 = [[NSData dataWithContentsOfFile:r26] retain];
                    var_118 = 0x0;
                    r2 = r27;
                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x1 format:&var_110 error:&var_118];
                    r24 = [r0 retain];
                    r0 = [var_118 retain];
                    var_1C8 = r24;
                    var_208 = r20;
                    if (r24 != 0x0) {
                            var_238 = r0;
                            var_230 = r27;
                            var_210 = r26;
                            r25 = [[var_1B8 shortenedBundleID:var_1B0] retain];
                            [r24 setObject:r25 forKey:@"CFBundleIdentifier"];
                            [r25 release];
                            r25 = [[r21 objectForKey:@"Command"] retain];
                            [r24 setObject:r25 forKey:@"CrossOverHelperCommand"];
                            [r25 release];
                            [r24 setObject:var_178 forKey:@"CXHelperAppBottleName"];
                            r25 = [@(0x2b) retain];
                            [r24 setObject:r25 forKey:@"CXHelperAppVersion"];
                            [r25 release];
                            [r24 setObject:var_188 forKey:@"CXHelperAppBottleTag"];
                            [r24 setObject:var_198 forKey:@"CXOriginalMenuName"];
                            [r24 setObject:var_190 forKey:**_kCFBundleNameKey];
                            r0 = [r21 objectForKey:@"RawPath"];
                            r0 = [r0 retain];
                            r19 = r0;
                            if (r0 != 0x0) {
                                    [r24 setObject:r19 forKey:@"CrossOverHelperMenuPath"];
                            }
                            var_1E0 = r19;
                            r0 = [NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.MenuDummyType" forKey:**_kUTTypeIdentifierKey];
                            r0 = [r0 retain];
                            var_218 = r0;
                            r0 = [NSArray arrayWithObject:r0];
                            r0 = [r0 retain];
                            var_220 = r0;
                            [var_1C8 setObject:r0 forKey:**_kUTImportedTypeDeclarationsKey];
                            r27 = [[NSMutableArray array] retain];
                            r24 = var_1C8;
                            r25 = [[NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.MenuDummyType"] retain];
                            r26 = [[NSDictionary dictionaryWithObjectsAndKeys:r25] retain];
                            [r27 addObject:r26];
                            [r26 release];
                            r0 = r25;
                            r25 = var_1E0;
                            [r0 release];
                            var_228 = r27;
                            [r24 setObject:r27 forKey:@"CFBundleDocumentTypes"];
                            var_1F8 = [[NSMutableArray arrayWithCapacity:0x2] retain];
                            r19 = var_180;
                            r0 = [r19 caseInsensitiveCompare:@"BIZTEL"];
                            if (r25 != 0x0) {
                                    if (r0 != 0x0) {
                                            r0 = [r25 lastPathComponent];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [r0 caseInsensitiveCompare:@"BIZTEL"];
                                            r0 = r25;
                                            r25 = var_1E0;
                                            r19 = var_180;
                                            [r0 release];
                                            if (r26 == 0x0) {
                                                    r26 = [[NSArray arrayWithObject:@"callto"] retain];
                                                    r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Call Phone Number URL"] retain];
                                                    [r26 release];
                                                    [var_1F8 addObject:r25];
                                                    r0 = r25;
                                                    r25 = var_1E0;
                                                    r19 = var_180;
                                                    [r0 release];
                                            }
                                    }
                                    else {
                                            if (r0 == 0x0) {
                                                    r26 = [[NSArray arrayWithObject:@"callto"] retain];
                                                    r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Call Phone Number URL"] retain];
                                                    [r26 release];
                                                    [var_1F8 addObject:r25];
                                                    r0 = r25;
                                                    r25 = var_1E0;
                                                    r19 = var_180;
                                                    [r0 release];
                                            }
                                    }
                            }
                            else {
                                    if (r0 == 0x0) {
                                            r26 = [[NSArray arrayWithObject:@"callto"] retain];
                                            r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Call Phone Number URL"] retain];
                                            [r26 release];
                                            [var_1F8 addObject:r25];
                                            r0 = r25;
                                            r25 = var_1E0;
                                            r19 = var_180;
                                            [r0 release];
                                    }
                            }
                            r0 = [r19 caseInsensitiveCompare:@"Steam"];
                            r19 = var_1E8;
                            r27 = var_230;
                            if (r25 != 0x0) {
                                    if (r0 != 0x0) {
                                            r0 = [r25 lastPathComponent];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [r0 caseInsensitiveCompare:@"Steam"];
                                            [r25 release];
                                            if (r26 == 0x0) {
                                                    r26 = [[NSArray arrayWithObject:@"steam"] retain];
                                                    r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Steam URL"] retain];
                                                    [r26 release];
                                                    [var_1F8 addObject:r25];
                                                    [r25 release];
                                            }
                                    }
                                    else {
                                            if (r0 == 0x0) {
                                                    r26 = [[NSArray arrayWithObject:@"steam"] retain];
                                                    r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Steam URL"] retain];
                                                    [r26 release];
                                                    [var_1F8 addObject:r25];
                                                    [r25 release];
                                            }
                                    }
                            }
                            else {
                                    if (r0 == 0x0) {
                                            r26 = [[NSArray arrayWithObject:@"steam"] retain];
                                            r25 = [[NSDictionary dictionaryWithObjectsAndKeys:@"Steam URL"] retain];
                                            [r26 release];
                                            [var_1F8 addObject:r25];
                                            [r25 release];
                                    }
                            }
                            r25 = var_1F8;
                            if ([r25 count] != 0x0) {
                                    [r24 setObject:r25 forKey:@"CFBundleURLTypes"];
                            }
                            var_120 = 0x0;
                            r2 = r24;
                            r0 = [NSPropertyListSerialization dataWithPropertyList:r2 format:var_110 options:0x0 error:&var_120];
                            r25 = [r0 retain];
                            r20 = [var_120 retain];
                            [var_238 release];
                            [r27 release];
                            r27 = var_200;
                            r28 = var_1F0;
                            r24 = var_210;
                            var_240 = r25;
                            if (r25 != 0x0) {
                                    var_128 = 0x0;
                                    r2 = r24;
                                    r0 = [r25 writeToFile:r2 options:0x1 error:&var_128];
                                    r26 = r0;
                                    r25 = [var_128 retain];
                                    r22 = r20;
                                    if ((r26 & 0x1) != 0x0) {
                                            [r25 release];
                                            r24 = sign_extend_64(*(int32_t *)ivar_offset(relateDocTypesToMenus));
                                            r0 = *(var_1B8 + r24);
                                            r0 = [r0 objectForKey:var_188];
                                            r0 = [r0 retain];
                                            r26 = r0;
                                            r0 = [r0 allKeysForObject:var_1E0];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            var_170 = q0;
                                            var_160 = q0;
                                            r0 = [r0 countByEnumeratingWithState:&var_170 objects:&decomp_var_108 count:0x10];
                                            if (r0 != 0x0) {
                                                    r27 = r0;
                                                    r20 = *var_160;
                                                    do {
                                                            r19 = 0x0;
                                                            do {
                                                                    if (*var_160 != r20) {
                                                                            objc_enumerationMutation(r25);
                                                                    }
                                                                    [r26 setObject:@"" forKey:*(var_168 + r19 * 0x8)];
                                                                    r19 = r19 + 0x1;
                                                            } while (r27 != r19);
                                                            r0 = [r25 countByEnumeratingWithState:&var_170 objects:&decomp_var_108 count:0x10];
                                                            r27 = r0;
                                                    } while (r0 != 0x0);
                                            }
                                            r0 = [NSUserDefaults standardUserDefaults];
                                            r0 = [r0 retain];
                                            r27 = r0;
                                            [r0 setObject:*(var_1B8 + r24) forKey:@"DocTypeToMenuPathMap"];
                                            [r27 release];
                                            [var_1B8 informSystemOfUpdatedApp:var_1A8];
                                            r0 = r25;
                                            r25 = var_1A8;
                                            [r0 release];
                                            [r26 release];
                                            r26 = 0x1;
                                            r27 = var_200;
                                            r28 = var_1F0;
                                            r19 = var_1E8;
                                    }
                                    else {
                                            NSLog(@"Failed to write %@\n    %@\n", r1, r2);
                                            [r23 removeItemAtPath:var_1A8 error:0x0];
                                            r0 = r25;
                                            r25 = var_1A8;
                                            r19 = var_1E8;
                                            [r0 release];
                                            r26 = 0x0;
                                    }
                            }
                            else {
                                    r22 = r20;
                                    NSLog(@"Failed to serialize %@: %@\n", r1, r2);
                                    r25 = var_1A8;
                                    [r23 removeItemAtPath:r25 error:0x0];
                                    r26 = 0x0;
                            }
                            [var_1F8 release];
                            [var_228 release];
                            [var_220 release];
                            [var_218 release];
                            [var_1E0 release];
                            r24 = var_210;
                            r20 = var_240;
                    }
                    else {
                            r22 = r0;
                            NSLog(@"Failed to load %@: %@\n", r1, r2);
                            r25 = var_1A8;
                            [r23 removeItemAtPath:r25 error:0x0];
                            r24 = r26;
                            r26 = 0x0;
                            r20 = r27;
                            r27 = var_200;
                    }
                    [var_1C8 release];
                    [r22 release];
                    [r20 release];
                    [r24 release];
                    [var_1C0 release];
                    [var_1D0 release];
                    [var_1D8 release];
                    r20 = var_208;
            }
            else {
                    r26 = 0x0;
                    r25 = var_1A8;
            }
            [r20 release];
            [r19 release];
            r22 = var_1B0;
            [r22 release];
            [var_198 release];
            [var_188 release];
            [var_178 release];
            [var_1A0 release];
            [r28 release];
            [r25 release];
            [r23 release];
            [r27 release];
            [r21 release];
            [var_190 release];
            r0 = [var_180 release];
            if (**___stack_chk_guard != var_60) {
                    __stack_chk_fail();
            }
            r0 = r26;
    }
    return r0;


// 0x100052390
// -[CXServerCrossOver createIcnsFile:fromImageFile:forApp:]
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
    r22 = arg4;
    r19 = [arg2 retain];
    r0 = [arg3 retain];
    r20 = r0;
    r0 = CGImageSourceCreateWithURL(r0, 0x0);
    if (r0 != 0x0) {
            r21 = [CGImageSourceGetType(r0) retain];
            CFRelease(r0);
            r0 = [NSWorkspace sharedWorkspace];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [r0 type:r21 conformsToType:**_kUTTypeAppleICNS];
            [r23 release];
            if (r24 != 0x0) {
                    r22 = [[NSFileManager defaultManager] retain];
                    var_48 = 0x0;
                    r0 = [r19 getResourceValue:&var_48 forKey:**_NSURLIsDirectoryKey error:0x0];
                    r24 = r0;
                    r23 = [var_48 retain];
                    r25 = 0x0;
                    if (r24 != 0x0) {
                            if (([r23 boolValue] & 0x1) != 0x0) {
                                    r25 = 0x0;
                            }
                            else {
                                    var_50 = 0x0;
                                    r2 = r19;
                                    r0 = [r22 removeItemAtURL:r2 error:&var_50];
                                    r24 = r0;
                                    r25 = [var_50 retain];
                                    if ((r24 & 0x1) == 0x0) {
                                            NSLog(@"Failed to remove old icns file '%@': %@\n", 0x0, r2);
                                    }
                            }
                    }
                    var_58 = r25;
                    r2 = r20;
                    r3 = r19;
                    r0 = [r22 copyItemAtURL:r2 toURL:r3 error:&var_58];
                    r24 = r0;
                    r26 = [var_58 retain];
                    [r25 release];
                    if ((r24 & 0x1) == 0x0) {
                            NSLog(@"Failed to copy icns file '%@' to final location '%@': %@\n", 0x0, r2, r3);
                    }
                    [r23 release];
                    [r26 release];
                    r0 = r22;
            }
            else {
                    r0 = [LauncherIconUtils imageRepsForCXMenuIconsFromURL:r20];
                    r0 = [r0 retain];
                    r23 = r0;
                    if ([r0 count] != 0x0) {
                            r24 = [LauncherIconUtils createIcnsFileAtURL:r19 fromImageReps:r23 forApp:r22];
                    }
                    else {
                            NSLog(@"Couldn't load image from %@\n", 0x0);
                            r24 = 0x0;
                    }
                    r0 = r23;
            }
            [r0 release];
            [r21 release];
    }
    else {
            r24 = 0x0;
    }
    [r20 release];
    [r19 release];
    r0 = r24;
    return r0;


// 0x1000525c8
// -[CXServerCrossOver applicationOpenUntitledFile:]
    var_48 = *__NSConcreteStackBlock;
    r21 = [arg2 retain];
    r0 = [NSBlockOperation blockOperationWithBlock:&var_48];
    r0 = [r0 retain];
    r20 = r0;
    [r0 addDependency:self->updateCheckOp];
    [r20 setQueuePriority:0x4];
    r0 = [NSOperationQueue mainQueue];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addOperation:r20];
    [r22 release];
    var_58 = self;
    r0 = [[&var_58 super] applicationOpenUntitledFile:r21];
    r19 = r0;
    [r21 release];
    [r20 release];
    r0 = r19;
    return r0;


// 0x100052704
// -[CXServerCrossOver runCXUpgrade]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = **_NSApp;
    r0 = [r0 crossOverRoot];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 stringByAppendingPathComponent:@"lib"];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 stringByAppendingPathComponent:@"cxupgrade"] retain];
    [r21 release];
    [r20 release];
    r20 = [[NSMutableArray arrayWithObjects:@"--productid"] retain];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 stringForKey:@"FirstRunVersion"] retain];
    [r22 release];
    if ([r21 length] != 0x0) {
            [r20 addObject:@"--old-version"];
            [r20 addObject:r21];
    }
    r0 = [NSTask launchedTaskWithLaunchPath:r19 arguments:r20];
    r0 = [r0 retain];
    r22 = r0;
    [r0 waitUntilExit];
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x100052854
// -[CXServerCrossOver checkForHelperUpdate]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 integerForKey:@"LastHelperVersion"] != 0x2b) {
            *(int8_t *)(int64_t *)&r20->refreshProgramsUpdateIsForced = 0x1;
            [r19 setInteger:0x2b forKey:@"LastHelperVersion"];
    }
    var_20 = r20;
    [[&var_20 super] checkForHelperUpdate];
    [r19 release];
    return;


// 0x1000528ec
// -[CXServerCrossOver processFirstRun:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [[NSUserDefaults standardUserDefaults] retain];
    r22 = [[NSDate date] retain];
    [r19 setObject:r22 forKey:@"FirstRunDate"];
    [r22 release];
    var_30 = r20;
    [[&var_30 super] processFirstRun:arg2];
    if (arg2 != 0x0) {
            [r20 runCXUpgrade];
    }
    r0 = [r19 objectForKey:@"MostRecentCXMenuPlist"];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            [r0 release];
            [r19 removeObjectForKey:@"MostRecentCXFBMenuPlist"];
            [r19 removeObjectForKey:@"LastUpdatedAssociations_v2"];
            *(int8_t *)(int64_t *)&r20->refreshProgramsUpdateIsForced = 0x1;
            [r19 removeObjectForKey:@"MostRecentCXMenuPlist"];
            [r19 removeObjectForKey:@"LastUpdatedAssociations"];
    }
    else {
            r0 = [r19 objectForKey:@"LastUpdatedAssociations"];
            r0 = [r0 retain];
            r21 = r0;
            [r0 release];
            if (r21 != 0x0) {
                    [r19 removeObjectForKey:@"MostRecentCXFBMenuPlist"];
                    [r19 removeObjectForKey:@"LastUpdatedAssociations_v2"];
                    *(int8_t *)(int64_t *)&r20->refreshProgramsUpdateIsForced = 0x1;
                    [r19 removeObjectForKey:@"MostRecentCXMenuPlist"];
                    [r19 removeObjectForKey:@"LastUpdatedAssociations"];
            }
    }
    r0 = [NSApplication sharedApplication];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDaysLeft];
    [r20 release];
    [r19 release];
    return;


// 0x100052a58
// -[CXServerCrossOver applicationDockMenu:]
    r0 = [self programsMenu];
    return r0;


// 0x100052a5c
// -[CXServerCrossOver bestValidUpdateInAppcast:forUpdater:]
    r31 = r31 - 0x1c0;
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
    r22 = self;
    var_60 = **___stack_chk_guard;
    r20 = [arg2 retain];
    r23 = [arg3 retain];
    r24 = (int64_t *)&r22->nextUpdateItem;
    r0 = *r24;
    *r24 = 0x0;
    [r0 release];
    r0 = [NSApplication sharedApplication];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 licenseExpirationDate] retain];
    [r19 release];
    var_120 = q0;
    var_110 = q0;
    r0 = [r20 items];
    r0 = [r0 retain];
    r25 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r27 = r0;
            var_188 = r23;
            var_180 = r24;
            var_170 = r25;
            var_168 = r21;
            var_198 = r22;
            var_190 = r20;
            var_178 = 0x0;
            var_160 = 0x0;
            var_158 = *var_110;
            r25 = @"26.3.0.39832";
            do {
                    r23 = 0x0;
                    while (true) {
                            if (*var_110 != var_158) {
                                    objc_enumerationMutation(var_170);
                            }
                            r20 = *(var_118 + r23 * 0x8);
                            r26 = [[SUStandardVersionComparator defaultComparator] retain];
                            r19 = [[r20 versionString] retain];
                            if ([r26 compareVersion:r19 toVersion:r25] == -0x1) {
                                    [r19 release];
                                    [r26 release];
                                    r23 = r23 + 0x1;
                                    if (r27 != r23) {
                                            continue;
                                    }
                                    break;
                            }
                            r24 = [[SUStandardVersionComparator defaultComparator] retain];
                            r21 = [[r20 versionString] retain];
                            r22 = r25;
                            r25 = [r24 compareVersion:r21 toVersion:r25];
                            [r21 release];
                            [r24 release];
                            [r19 release];
                            [r26 release];
                            if (r25 == 0x0) {
                                    r25 = r22;
                                    r23 = r23 + 0x1;
                                    if (r27 != r23) {
                                            continue;
                                    }
                                    break;
                            }
                            r26 = var_160;
                            if (r26 != 0x0) {
                                    r19 = [[SUStandardVersionComparator defaultComparator] retain];
                                    r21 = [[r20 versionString] retain];
                                    r24 = [[r26 versionString] retain];
                                    r25 = [r19 compareVersion:r21 toVersion:r24];
                                    [r24 release];
                                    [r21 release];
                                    [r19 release];
                                    if (r25 == 0x1) {
                                            r19 = [r20 retain];
                                            [r26 release];
                                            var_160 = r19;
                                    }
                            }
                            else {
                                    r19 = [r20 retain];
                                    [r26 release];
                                    var_160 = r19;
                            }
                            r26 = var_180;
                            if (*r26 != 0x0) {
                                    r19 = [[SUStandardVersionComparator defaultComparator] retain];
                                    r21 = [[r20 versionString] retain];
                                    r24 = [[*r26 versionString] retain];
                                    r25 = [r19 compareVersion:r21 toVersion:r24];
                                    [r24 release];
                                    [r21 release];
                                    [r19 release];
                                    if (r25 == -0x1) {
                                            objc_storeStrong(r26, r20);
                                    }
                            }
                            else {
                                    objc_storeStrong(r26, r20);
                            }
                            r25 = r22;
                            if (var_168 != 0x0) {
                                    r0 = [r20 date];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r24 = var_168;
                                    if ([r0 compare:r24] != 0x0) {
                                            r0 = [r20 date];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r24 = [r0 compare:r24];
                                            [r21 release];
                                            [r19 release];
                                            if (r24 == -0x1) {
                                                    r26 = var_178;
                                                    if (r26 != 0x0) {
                                                            r19 = [[SUStandardVersionComparator defaultComparator] retain];
                                                            r21 = [[r20 versionString] retain];
                                                            r24 = [[r26 versionString] retain];
                                                            r25 = [r19 compareVersion:r21 toVersion:r24];
                                                            [r24 release];
                                                            [r21 release];
                                                            [r19 release];
                                                            bool_32 = r25 != 0x1;
                                                            r25 = r22;
                                                            if (!bool_32) {
                                                                    var_178 = [r20 retain];
                                                                    [r26 release];
                                                                    r23 = r23 + 0x1;
                                                                    if (r27 != r23) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                            else {
                                                                    r23 = r23 + 0x1;
                                                                    if (r27 != r23) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            var_178 = [r20 retain];
                                                            [r26 release];
                                                            r23 = r23 + 0x1;
                                                            if (r27 != r23) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                            else {
                                                    r23 = r23 + 0x1;
                                                    if (r27 != r23) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                                    else {
                                            [r19 release];
                                            r26 = var_178;
                                            if (r26 != 0x0) {
                                                    r19 = [[SUStandardVersionComparator defaultComparator] retain];
                                                    r21 = [[r20 versionString] retain];
                                                    r24 = [[r26 versionString] retain];
                                                    r25 = [r19 compareVersion:r21 toVersion:r24];
                                                    [r24 release];
                                                    [r21 release];
                                                    [r19 release];
                                                    bool_24 = r25 != 0x1;
                                                    r25 = r22;
                                                    if (!bool_24) {
                                                            var_178 = [r20 retain];
                                                            [r26 release];
                                                            r23 = r23 + 0x1;
                                                            if (r27 != r23) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                                    else {
                                                            r23 = r23 + 0x1;
                                                            if (r27 != r23) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                            else {
                                                    var_178 = [r20 retain];
                                                    [r26 release];
                                                    r23 = r23 + 0x1;
                                                    if (r27 != r23) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                            }
                            else {
                                    r26 = var_178;
                                    if (r26 != 0x0) {
                                            r19 = [[SUStandardVersionComparator defaultComparator] retain];
                                            r21 = [[r20 versionString] retain];
                                            r24 = [[r26 versionString] retain];
                                            r25 = [r19 compareVersion:r21 toVersion:r24];
                                            [r24 release];
                                            [r21 release];
                                            [r19 release];
                                            bool_15 = r25 != 0x1;
                                            r25 = r22;
                                            if (!bool_15) {
                                                    var_178 = [r20 retain];
                                                    [r26 release];
                                                    r23 = r23 + 0x1;
                                                    if (r27 != r23) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                            else {
                                                    r23 = r23 + 0x1;
                                                    if (r27 != r23) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                                    else {
                                            var_178 = [r20 retain];
                                            [r26 release];
                                            r23 = r23 + 0x1;
                                            if (r27 != r23) {
                                                    continue;
                                            }
                                            break;
                                    }
                            }
                    }
                    r3 = &decomp_var_e0;
                    r0 = [var_170 countByEnumeratingWithState:&var_120 objects:r3 count:0x10];
                    r27 = r0;
            } while (r0 != 0x0);
            [var_170 release];
            r24 = var_160;
            if (r24 != 0x0) {
                    r23 = var_188;
                    r19 = var_178;
                    if (r19 == 0x0) {
                            [r23 setNotLicensed:0x1];
                            r0 = [NSApplication sharedApplication];
                            r0 = [r0 retain];
                            r21 = r0;
                            r22 = [[r0 licenseID] retain];
                            r20 = [[NSString stringWithFormat:@"https://www.codeweavers.com/bin/query/supportperiod/%@/%@", r3, r4] retain];
                            r25 = [[NSURL URLWithString:r20] retain];
                            [r20 release];
                            [r22 release];
                            [r21 release];
                            r19 = var_198->session;
                            r20 = [[NSURLRequest requestWithURL:r25] retain];
                            var_150 = *__NSConcreteStackBlock;
                            var_128 = [r23 retain];
                            r0 = [r19 dataTaskWithRequest:r20 completionHandler:&var_150];
                            r19 = [r0 retain];
                            [r20 release];
                            [r19 resume];
                            [r19 release];
                            [var_128 release];
                            r20 = var_190;
                            r21 = var_168;
                            [r25 release];
                            r19 = 0x0;
                    }
                    else {
                            r20 = var_190;
                            r21 = var_168;
                    }
            }
            else {
                    r20 = var_190;
                    r23 = var_188;
                    r21 = var_168;
                    r19 = var_178;
            }
    }
    else {
            r24 = 0x0;
            [r25 release];
            r19 = 0x0;
    }
    [r21 release];
    [r24 release];
    [r23 release];
    r0 = [r20 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x100053368
// +[CXServerCrossOver crossTieModDateString]
    r31 = r31 - 0x70;
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
    r19 = [[NSFileManager defaultManager] retain];
    r20 = [[[CXSetupLib c4ProfilesClass] getOnlineFilePath] retain];
    if ([r19 fileExistsAtPath:r20] != 0x0) {
            r22 = [[r20 stringByResolvingSymlink] retain];
            r21 = [[r19 attributesOfItemAtPath:r22 error:0x0] retain];
            [r22 release];
            r22 = [[r21 objectForKey:**_NSFileModificationDate] retain];
            r0 = [[NSDateFormatter alloc] init];
            r23 = r0;
            [r0 setDateStyle:0x4];
            [r23 setTimeStyle:0x1];
            r25 = [[r23 stringFromDate:r22] retain];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r27 = [[r0 localizedStringForKey:@"Installation recipes were last updated on %@." value:@"" table:0x0] retain];
            r24 = [[NSString stringWithFormat:r27] retain];
            [r27 release];
            [r26 release];
            [r25 release];
            [r23 release];
            [r22 release];
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r24 = [[r0 localizedStringForKey:@"Installation recipes have never been updated." value:@"" table:0x0] retain];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = [r24 autorelease];
    return r0;


// 0x100053564
// -[CXServerCrossOver sparkleUpdater]
    r0 = [CXUpdater sharedUpdater];
    return r0;


// 0x100053570
// -[CXServerCrossOver repairBottles:]
    r31 = r31 - 0x1a0;
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
    var_70 = **___stack_chk_guard;
    r0 = **_NSApp;
    r0 = [r0 crossOverRoot];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 stringByAppendingPathComponent:@"bin"];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 stringByAppendingPathComponent:@"wine"] retain];
    [r21 release];
    [r20 release];
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 bottleList] retain];
    [r20 release];
    var_160 = q0;
    var_150 = q0;
    r0 = [r21 retain];
    var_190 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_160 objects:&decomp_var_f0 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r28 = *var_150;
            d8 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbf0);
            do {
                    r27 = 0x0;
                    do {
                            if (*var_150 != r28) {
                                    objc_enumerationMutation(var_190);
                            }
                            r23 = *(var_158 + r27 * 0x8);
                            r24 = [[[CXSetupLib cxSetupClass] bottleStatus:@"REPAIRING"] retain];
                            [r23 addStatusOverride:r24];
                            [r24 release];
                            r24 = [[r23 name] retain];
                            var_118 = @"--bottle";
                            r0 = [NSArray arrayWithObjects:&var_118 count:0x5];
                            r26 = [r0 retain];
                            r25 = [[CXTask launchedTaskWithLaunchPath:r19 arguments:r26] retain];
                            [r26 release];
                            var_188 = *__NSConcreteStackBlock;
                            [r25 setTerminationHandler:&var_188];
                            [r25 release];
                            [r24 release];
                            r27 = r27 + 0x1;
                    } while (r22 != r27);
                    r0 = [var_190 countByEnumeratingWithState:&var_160 objects:&decomp_var_f0 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [var_190 release];
    [var_190 release];
    [r19 release];
    if (**___stack_chk_guard != var_70) {
            __stack_chk_fail();
    }
    return;


// 0x1000538d0
// -[CXServerCrossOver repairBottlesDialog:]
    var_40 = r26;
    decomp_var_38 = r25;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [arg2 retain];
    r0 = [[NSAlert alloc] init];
    r20 = r0;
    [r0 setAlertStyle:0x1];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"Repair Bottles?" value:@"" table:0x0] retain];
    [r20 setMessageText:r24];
    [r24 release];
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"CrossOver will attempt to repair bottles that may have been damaged by anti-virus software. Such anti-virus software may have incorrectly deleted or \"quarantined\" certain critical files needed for CrossOver to work. CrossOver's files do not contain viruses…" value:@"" table:0x0] retain];
    [r20 setInformativeText:r24];
    [r24 release];
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"Repair" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r20 addButtonWithTitle:r24]);
    [r24 release];
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"Cancel" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r20 addButtonWithTitle:r24]);
    [r24 release];
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [[r0 localizedStringForKey:@"Learn More" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r20 addButtonWithTitle:r22]);
    [r22 release];
    [r23 release];
    r0 = [r20 runModal];
    if (r0 != 0x3ea) {
            if (r0 == 0x3e8) {
                    [r21 repairBottles:r19];
            }
    }
    else {
            r21 = [[NSURL URLWithString:@"https://support.codeweavers.com/troubleshooting/antivirus-software-eg-bitdefender-avast-and-avg-and-crossover"] retain];
            r0 = [NSWorkspace sharedWorkspace];
            r0 = [r0 retain];
            r22 = r0;
            [r0 openURL:r21];
            [r22 release];
            [r21 release];
    }
    [r20 release];
    [r19 release];
    return;


// 0x100053b60
// -[CXServerCrossOver programsMenu]
    r0 = self->_programsMenu;
    return r0;


// 0x100053b70
// -[CXServerCrossOver setProgramsMenu:]
    objc_storeStrong((int64_t *)&self->_programsMenu, arg2);
    return;


// 0x100053b84
// -[CXServerCrossOver publishBottleMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_publishBottleMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x100053ba4
// -[CXServerCrossOver setPublishBottleMenuItem:]
    objc_storeWeak((int64_t *)&self->_publishBottleMenuItem, arg2);
    return;


// 0x100053bb8
// -[CXServerCrossOver updateBottleMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_updateBottleMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x100053bd8
// -[CXServerCrossOver setUpdateBottleMenuItem:]
    objc_storeWeak((int64_t *)&self->_updateBottleMenuItem, arg2);
    return;


// 0x100053bec
// -[CXServerCrossOver launchers]
    r0 = self->_launchers;
    return r0;


// 0x100053bfc
// -[CXServerCrossOver setLaunchers:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100053c08
// -[CXServerCrossOver urlHandler]
    r0 = self->_urlHandler;
    return r0;


// 0x100053c18
// -[CXServerCrossOver setUrlHandler:]
    objc_storeStrong((int64_t *)&self->_urlHandler, arg2);
    return;


// 0x100053c2c
// -[CXServerCrossOver observedBottles]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_observedBottles)), 0x1);
    return r0;


// 0x100053c3c
// -[CXServerCrossOver setObservedBottles:]
    objc_setProperty_atomic();
    return;


// 0x100053c48
// -[CXServerCrossOver .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_observedBottles, 0x0);
    objc_storeStrong((int64_t *)&self->_urlHandler, 0x0);
    objc_storeStrong((int64_t *)&self->_launchers, 0x0);
    objc_destroyWeak((int64_t *)&self->_updateBottleMenuItem);
    objc_destroyWeak((int64_t *)&self->_publishBottleMenuItem);
    objc_storeStrong((int64_t *)&self->_programsMenu, 0x0);
    objc_storeStrong((int64_t *)&self->nextUpdateItem, 0x0);
    objc_storeStrong((int64_t *)&self->session, 0x0);
    objc_storeStrong((int64_t *)&self->updateCheckOp, 0x0);
    objc_storeStrong((int64_t *)&self->relateDocTypesToMenus, 0x0);
    objc_storeStrong((int64_t *)&self->associationPlistDate, 0x0);
    objc_storeStrong((int64_t *)&self->associationPlist, 0x0);
    objc_storeStrong((int64_t *)&self->helpersToDelete, 0x0);
    objc_storeStrong((int64_t *)&self->associationsLock, 0x0);
    objc_storeStrong((int64_t *)&self->programsMenuUpdateDate, 0x0);
    objc_storeStrong((int64_t *)&self->preferencesController, 0x0);
    objc_storeStrong((int64_t *)&self->mainWindowController, 0x0);
    objc_storeStrong((int64_t *)&self->dockPrefs, 0x0);
    return;


