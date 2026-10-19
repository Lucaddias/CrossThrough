// CXServer — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100012780
// -[CXServer init]
    r31 = r31 - 0xe0;
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
    var_50 = self;
    r0 = [[&var_50 super] init];
    r19 = r0;
    if (r0 != 0x0) {
            r21 = [@(0xa) retain];
            r22 = [[CXServer getDefaultBottleDir] retain];
            r23 = [[NSArray array] retain];
            r24 = [[NSArray array] retain];
            r25 = [@(YES) retain];
            r26 = [@(YES) retain];
            r20 = [[NSDictionary dictionaryWithObjectsAndKeys:@""] retain];
            [r26 release];
            [r25 release];
            [r24 release];
            [r23 release];
            [r22 release];
            [r21 release];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r21 = r0;
            [r0 registerDefaults:r20];
            [r21 release];
            r0 = [NSMutableArray alloc];
            r0 = [r0 initWithCapacity:0x3];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(pendingAppLaunches));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            r0 = [NSMutableDictionary alloc];
            r0 = [r0 initWithCapacity:0x3];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(tasksInProgress));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            objc_unsafeClaimAutoreleasedReturnValue([helperServer defaultHelperServer]);
            r0 = [[NSOperationQueue alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(backgroundQueue));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            [r20 release];
    }
    r0 = r19;
    return r0;


// 0x1000129ec
// -[CXServer dealloc]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [NSWorkspace sharedWorkspace];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 notificationCenter];
    r0 = [r0 retain];
    r21 = r0;
    [r0 removeObserver:r19];
    [r21 release];
    [r20 release];
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:r19];
    [r20 release];
    r21 = sign_extend_64(*(int32_t *)ivar_offset(systemDynamicStore));
    r1 = *(r19 + r21);
    if (r1 != 0x0) {
            r0 = SCDynamicStoreCreateRunLoopSource(0x0, r1, 0x0);
            r20 = r0;
            CFRunLoopSourceInvalidate(r0);
            CFRelease(r20);
            CFRelease(*(r19 + r21));
    }
    var_30 = r19;
    [[&var_30 super] dealloc];
    return;


// 0x100012ad0
// -[CXServer demoRegisterController]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(demoRegisterController));
    r0 = *(self + r20);
    if (r0 == 0x0) {
            r0 = [[DemoRegisterController alloc] init];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
            r0 = *(r19 + r20);
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100012b1c
// -[CXServer shutdownController]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(shutdownController));
    r0 = *(self + r20);
    if (r0 == 0x0) {
            r0 = [[ShutdownController alloc] init];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
            r0 = *(r19 + r20);
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100012b68
// -[CXServer doPeriodicDemoNagForCommand:withArgs:]
    r21 = [arg2 retain];
    r19 = [arg3 retain];
    [self setMenusEnabled:0x0];
    r22 = [[DemoNagController alloc] init];
    var_58 = *__NSConcreteStackBlock;
    var_28 = r19;
    r19 = [r19 retain];
    r20 = [r21 retain];
    [r22 beginWindowWithCompletionHandler:&var_58];
    [var_28 release];
    [r21 release];
    [r19 release];
    [r20 release];
    [r22 release];
    return;


// 0x100012c7c
// -[CXServer demoCheck]
    r31 = r31 - 0x50;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([**_NSApp isDemo] != 0x0) {
            r0 = [[DemoNagController alloc] init];
            r20 = r0;
            var_38 = *__NSConcreteStackBlock;
            [r0 beginWindowWithCompletionHandler:&var_38];
            [r20 release];
    }
    else {
            [r19 continueFromDemoCheck];
    }
    return;


// 0x100012d20
// -[CXServer registerDemo:]
    r20 = [arg2 retain];
    r0 = [self demoRegisterController];
    r0 = [r0 retain];
    r19 = r0;
    [r0 showWindow:r20];
    [r20 release];
    [r19 release];
    return;


// 0x100012d70
// -[CXServer menusEnabled]
    r0 = *(int8_t *)(int64_t *)&self->menusEnabled;
    return r0;


// 0x100012d80
// -[CXServer setMenusEnabled:]
    *(int8_t *)(int64_t *)&self->menusEnabled = arg2;
    return;


// 0x100012d90
// -[CXServer continueFromDemoCheck]
    var_38 = *__NSConcreteStackBlock;
    dispatch_async(*__dispatch_main_q, &var_38);
    [self updateRecentItemsMenu];
    [self setMenusEnabled:0x1];
    return;


// 0x100012e64
// -[CXServer startAppOp]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self retain];
    r19 = r0;
    objc_sync_enter(r0);
    r20 = sign_extend_64(*(int32_t *)ivar_offset(startAppOp));
    if (*(r19 + r20) == 0x0) {
            r0 = [[NSOperation alloc] init];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
    }
    objc_sync_exit(r19);
    [r19 release];
    r0 = *(r19 + r20);
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100012edc
// -[CXServer rosettaCheck]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (___isPlatformVersionAtLeast(0x1, 0xb, 0x0, 0x0) != 0x0) {
            r0 = CFBundleIsArchitectureLoadable();
            r19 = r0;
            r8 = "installed";
            if (r0 == 0x0) {
                    r8 = "not installed";
            }
            _CXLog();
            if (r19 == 0x0) {
                    r0 = [[RosettaInstallationController alloc] init];
                    r19 = r0;
                    r20 = **_NSApp;
                    r21 = [[r0 window] retain];
                    [r20 runModalForWindow:r21];
                    [r21 release];
                    [r19 release];
            }
    }
    return;


// 0x100012fb0
// -[CXServer applicationWillFinishLaunching:]
    [self rosettaCheck];
    _PFMoveToApplicationsFolderIfNecessary();
    r0 = [NSAppleEventManager sharedAppleEventManager];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEventHandler:self andSelector:@selector(handleGetURLEvent:withReplyEvent:) forEventClass:0x4755524c andEventID:0x4755524c];
    r0 = [CXApplication sharedApplication];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setDaysLeft];
    [r19 release];
    r0 = [CXApplication sharedApplication];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setIsDemo];
    [r19 release];
    [r20 release];
    return;


// 0x10001305c
// -[CXServer applicationDidFinishLaunching:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if (*(int8_t *)(r20 + sign_extend_64(*(int32_t *)ivar_offset(gotLaunchEvent))) == 0x0) {
            r21 = [[r19 object] retain];
            [r20 applicationOpenUntitledFile:r21];
            [r21 release];
    }
    [r20 setMenusEnabled:0x0];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 stringForKey:@"FirstRunVersion"] retain];
    [r22 release];
    if ([r21 caseInsensitiveCompare:@"26.3.0.39832"] != 0x0) {
            [r21 length] != 0x0;
            [r20 processFirstRun:0x1];
    }
    [r20 checkForHelperUpdate];
    [r20 setEnvironmentVariables];
    [r20 demoCheck];
    [r20 registerForCooperativeActivation];
    [r21 release];
    [r19 release];
    return;


// 0x100013160
// -[CXServer checkForHelperUpdate]
    return;


// 0x100013164
// -[CXServer registerForCooperativeActivation]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if (___isPlatformVersionAtLeast(0x1, 0xe, 0x0, 0x0) != 0x0) {
            r0 = [NSDistributedNotificationCenter defaultCenter];
            r0 = [r0 retain];
            r20 = r0;
            [r0 addObserver:r19 selector:@selector(otherWineAppWillActivate:) name:@"WineAppWillActivateNotification" object:0x0 suspensionBehavior:0x4];
            [r20 release];
    }
    return;


// 0x1000131e0
// -[CXServer otherWineAppWillActivate:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    if ([**_NSApp isActive] != 0x0) {
            r0 = [r19 userInfo];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 objectForKeyedSubscript:@"ActivatingAppPID"];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 intValue];
            [r21 release];
            [r20 release];
            r0 = [NSRunningApplication runningApplicationWithProcessIdentifier:r22];
            r0 = [r0 retain];
            r20 = r0;
            if (r0 != 0x0 && ___isPlatformVersionAtLeast(0x1, 0xe, 0x0, 0x0) != 0x0) {
                    r23 = *_NSApp;
                    NSLog(@"yielding activation to %@", 0xe);
                    [*r23 yieldActivationToApplication:r20];
                    r21 = [[NSRunningApplication currentApplication] retain];
                    [r20 activateFromApplication:r21 options:0x0];
                    [r21 release];
            }
            [r20 release];
    }
    [r19 release];
    return;


// 0x100013300
// -[CXServer launchFeedbackDrawInfoForImageSize:]
    {r2:r3} = arg2;
    return 0x0;


// 0x100013308
// -[CXServer drawLaunchFeedback:position:info:]
    return;


// 0x10001330c
// -[CXServer finishedLaunches]
    return;


// 0x100013310
// -[CXServer updateLaunchNotify]
    var_60 = d9;
    decomp_var_58 = d8;
    r31 = r31 + 0xffffffffffffff90;
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
    r0 = [self applicationIcon];
    r0 = [r0 retain];
    r19 = r0;
    [r0 size];
    d8 = d0;
    d9 = d1;
    r28 = sign_extend_64(*(int32_t *)ivar_offset(pendingAppLaunches));
    if ([*(r20 + r28) count] == 0x0) goto loc_1000134d0;
    goto loc_100013364;

loc_1000134d0:
    r21 = r20->launchFeedbackTimer;
    r22 = [[NSDate distantFuture] retain];
    [r21 setFireDate:r22];
    [r22 release];
    [r20 finishedLaunches];
    goto loc_100013510;

loc_100013364:
    r0 = [NSImage alloc];
    r0 = [r0 initWithSize:r2];
    r21 = r0;
    [r0 lockFocus];
    [r19 drawAtPoint:0x2 fromRect:r3 operation:r4 fraction:r5];
    r22 = [[r20 launchFeedbackDrawInfoForImageSize:r2] retain];
    r23 = [[NSMutableIndexSet indexSet] retain];
    if ([*(r20 + r28) count] == 0x0) goto loc_100013478;
    goto loc_1000133ec;

loc_100013510:
    [r19 release];
    return;

loc_100013478:
    [*(r20 + r28) removeObjectsAtIndexes:r23];
    [r21 unlockFocus];
    r0 = [NSApplication sharedApplication];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setApplicationIconImage:r21];
    [r20 release];
    [r23 release];
    [r22 release];
    [r21 release];
    goto loc_100013510;

loc_1000133ec:
    r24 = 0x0;
    r25 = 0x0;
    goto loc_1000133f4;

loc_1000133f4:
    r0 = *(r20 + r28);
    r0 = [r0 objectAtIndex:r24];
    r0 = [r0 retain];
    r26 = r0;
    r27 = [r0 lifeCounter];
    if (([r26 notified] & 0x1) == 0x0 && r27 < 0x321) {
            [r20 drawLaunchFeedback:r26 position:r25 info:r22];
            r25 = r25 + 0x1;
    }
    else {
            [r23 addIndex:r24];
    }
    [r26 setLifeCounter:r27 + 0x1];
    [r26 release];
    r24 = r24 + 0x1;
    if ([*(r20 + r28) count] > r24) {
            continue;
    }
    break;


// 0x100013534
// -[CXServer startLaunchNotify:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r21 = [arg2 retain];
    r19 = [[LaunchFeedbackInfo alloc] initWithIcon:r21];
    [r21 release];
    if (r19 != 0x0) {
            [r20->pendingAppLaunches addObject:r19];
            r22 = sign_extend_64(*(int32_t *)ivar_offset(launchFeedbackTimer));
            r21 = *(r20 + r22);
            if (r21 == 0x0) {
                    r0 = [NSTimer scheduledTimerWithTimeInterval:s0 target:r20 selector:@selector(updateLaunchNotify) userInfo:0x0 repeats:0x1];
                    r0 = [r0 retain];
                    r8 = *(r20 + r22);
                    *(r20 + r22) = r0;
                    [r8 release];
                    r21 = *(r20 + r22);
            }
            r20 = [[NSDate date] retain];
            [r21 setFireDate:r20];
            [r20 release];
            [r19 retain];
    }
    [r19 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100013634
// -[CXServer noteTask:forCommand:args:]
    return;


// 0x100013638
// -[CXServer modifyEnvironmentForCommandTask:]
    return;


// 0x10001363c
// -[CXServer forkExecCommand:]
    r21 = [arg2 retain];
    r20 = [[NSDictionary dictionary] retain];
    [self forkExecCommand:r21 withArgs:r20];
    [r21 release];
    [r20 release];
    return;


// 0x1000136a4
// -[CXServer forkExecCommand:withArgs:]
    r31 = r31 - 0xb0;
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
    r24 = self;
    r20 = [arg2 retain];
    r0 = [arg3 retain];
    r22 = r0;
    r23 = [[r0 objectForKey:@"icon"] retain];
    r0 = [r22 objectForKey:@"workdir"];
    r0 = [r0 retain];
    r25 = r0;
    if (r0 != 0x0) {
            if (r23 != 0x0) {
                    r27 = [[r24 startLaunchNotify:r23] retain];
            }
            else {
                    r27 = 0x0;
            }
    }
    else {
            r25 = [NSHomeDirectory() retain];
            if (r23 == 0x0) {
                    r27 = 0x0;
            }
            else {
                    r27 = [[r24 startLaunchNotify:r23] retain];
            }
    }
    var_68 = [[NSNotificationCenter defaultCenter] retain];
    r0 = [[CXTask alloc] init];
    r26 = r0;
    [r0 setLaunchPath:@"/bin/sh"];
    r19 = [[NSArray arrayWithObjects:@"-c"] retain];
    [r26 setArguments:r19];
    [r19 release];
    [r26 setCurrentDirectoryPath:r25];
    r19 = [[NSFileHandle fileHandleWithNullDevice] retain];
    [r26 setStandardInput:r19];
    [r19 release];
    r19 = [[NSFileHandle fileHandleWithNullDevice] retain];
    [r26 setStandardOutput:r19];
    [r19 release];
    r0 = [NSPipe pipe];
    r0 = [r0 retain];
    r28 = r0;
    r0 = [r0 fileHandleForReading];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [r0 fileDescriptor];
    [r19 release];
    fcntl(r21, 0x3) | 0x4;
    fcntl(r21, 0x4);
    var_60 = r28;
    [r26 setStandardError:r28];
    r0 = [helperServer defaultHelperServer];
    r0 = [r0 retain];
    r19 = r0;
    r28 = [[r0 getEnvironmentForXConnection] retain];
    [r19 release];
    if (r27 != 0x0) {
            r19 = [[r27 socketPath] retain];
            [r28 setObject:r19 forKey:@"CX_LAUNCH_NOTIFY_SOCKET"];
            [r19 release];
    }
    var_58 = r27;
    [r24 modifyEnvironmentForCommandTask:r28];
    [r26 setEnvironment:r28];
    r27 = var_68;
    [r27 addObserver:r24 selector:@selector(observeTaskTermination:) name:**_NSTaskDidTerminateNotification object:r26];
    var_78 = r22;
    var_70 = r20;
    var_88 = r25;
    var_80 = r23;
    [r26 launch];
    [r24 noteTask:r26 forCommand:r20 args:r22];
    r21 = [[var_60 fileHandleForReading] retain];
    [r27 addObserver:r24 selector:@selector(observeTaskErrorOutput:) name:**_NSFileHandleReadToEndOfFileCompletionNotification object:r21];
    [r21 readToEndOfFileInBackgroundAndNotify];
    r0 = [NSMutableDictionary dictionaryWithObject:r26 forKey:@"task"];
    r0 = [r0 retain];
    r19 = r0;
    [r0 addEntriesFromDictionary:r22];
    r2 = var_58;
    if (r2 != 0x0) {
            [r19 setObject:r2 forKey:@"launchFeedbackInfo"];
    }
    r23 = sign_extend_64(*(int32_t *)ivar_offset(tasksInProgress));
    r25 = *(r24 + r23);
    r22 = [[NSValue valueWithNonretainedObject:r26] retain];
    [r25 setObject:r19 forKey:r22];
    [r22 release];
    r22 = *(r24 + r23);
    r24 = [[NSValue valueWithNonretainedObject:r21] retain];
    [r22 setObject:r19 forKey:r24];
    [r24 release];
    [r19 release];
    [r21 release];
    [r28 release];
    [var_60 release];
    [r26 release];
    [r27 release];
    [var_58 release];
    [var_88 release];
    [var_80 release];
    [var_78 release];
    [var_70 release];
    return;


// 0x100013c90
// -[CXServer observeTaskTermination:]
    r20 = [[arg2 object] retain];
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r21 = r0;
    [r0 removeObserver:self name:0x0 object:r20];
    [r21 release];
    r19 = self->tasksInProgress;
    r21 = [[NSValue valueWithNonretainedObject:r20] retain];
    [r19 removeObjectForKey:r21];
    [r21 release];
    [r20 release];
    return;


// 0x100013d38
// -[CXServer observeTaskErrorOutput:]
    r1 = _cmd;
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
    r21 = self;
    r0 = [arg2 retain];
    r22 = r0;
    r19 = [[r0 object] retain];
    r28 = sign_extend_64(*(int32_t *)ivar_offset(tasksInProgress));
    r20 = *(r21 + r28);
    r23 = [[NSValue valueWithNonretainedObject:r19] retain];
    r20 = [[r20 objectForKey:r23] retain];
    [r23 release];
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r23 = r0;
    [r0 removeObserver:r21 name:0x0 object:r19];
    [r23 release];
    r23 = [[r22 userInfo] retain];
    [r22 release];
    r26 = [[r23 objectForKey:**_NSFileHandleNotificationDataItem] retain];
    [r23 release];
    r0 = [NSString alloc];
    r0 = [r0 initWithData:r26 encoding:0x4];
    r23 = r0;
    if ([r0 length] != 0x0) {
            NSLog(@"Task error output: %@\n", r1);
    }
    if ([r23 rangeOfString:@"(error 31)"] == 0x7fffffffffffffff) {
            if ([r23 rangeOfString:@"No such file or directory"] != 0x7fffffffffffffff) {
                    var_60 = r26;
                    var_58 = r28;
                    r24 = [[NSAlert alloc] init];
                    r0 = [r20 objectForKey:@"doc"];
                    r0 = [r0 retain];
                    r26 = r0;
                    [r0 release];
                    r25 = [[NSBundle mainBundle] retain];
                    if (r26 != 0x0) {
                            r26 = [[r25 localizedStringForKey:@"%1$@ was unable to start %2$@." value:@"" table:0x0] retain];
                            r28 = [[r20 objectForKey:@"doc"] retain];
                            r27 = [[NSString stringWithFormat:r26] retain];
                            [r24 setMessageText:r27];
                            [r27 release];
                    }
                    else {
                            r26 = [[r25 localizedStringForKey:@"%@ was unable to start this application." value:@"" table:0x0] retain];
                            r28 = [[NSString stringWithFormat:r26] retain];
                            [r24 setMessageText:r28];
                    }
                    [r28 release];
                    [r26 release];
                    [r25 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r25 = r0;
                    r27 = [[r0 localizedStringForKey:@"Probably it has been uninstalled or its bottle has been deleted.\n" value:@"" table:0x0] retain];
                    [r24 setInformativeText:r27];
                    [r27 release];
                    [r25 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r25 = r0;
                    r26 = [[r0 localizedStringForKey:@"OK" value:@"" table:0x0] retain];
                    objc_unsafeClaimAutoreleasedReturnValue([r24 addButtonWithTitle:r26]);
                    [r26 release];
                    [r25 release];
                    r0 = [r20 objectForKey:@"icon"];
                    r0 = [r0 retain];
                    r25 = r0;
                    [r0 release];
                    if (r25 != 0x0) {
                            r25 = [[r20 objectForKey:@"icon"] retain];
                            [r24 setIcon:r25];
                            r26 = var_60;
                            r28 = var_58;
                            [r25 release];
                    }
                    else {
                            r26 = var_60;
                            r28 = var_58;
                    }
                    [r24 runModal];
                    [r24 release];
                    r0 = [r20 objectForKey:@"launchFeedbackInfo"];
                    r0 = [r0 retain];
                    r24 = r0;
                    if (r0 != 0x0) {
                            [r24 setLifeCounter:0x7fffffff];
                    }
                    r21 = *(r21 + r28);
                    r25 = [[NSValue valueWithNonretainedObject:r19] retain];
                    [r21 removeObjectForKey:r25];
                    [r25 release];
                    [r24 release];
                    [r23 release];
                    [r26 release];
                    [r20 release];
                    [r19 release];
            }
            else {
                    r0 = [r20 objectForKey:@"launchFeedbackInfo"];
                    r0 = [r0 retain];
                    r24 = r0;
                    if (r0 != 0x0) {
                            [r24 setLifeCounter:0x7fffffff];
                    }
                    r21 = *(r21 + r28);
                    r25 = [[NSValue valueWithNonretainedObject:r19] retain];
                    [r21 removeObjectForKey:r25];
                    [r25 release];
                    [r24 release];
                    [r23 release];
                    [r26 release];
                    [r20 release];
                    [r19 release];
            }
    }
    else {
            var_60 = r26;
            r24 = [[NSAlert alloc] init];
            r0 = [r20 objectForKey:@"doc"];
            r0 = [r0 retain];
            r26 = r0;
            [r0 release];
            r25 = [[NSBundle mainBundle] retain];
            var_58 = r28;
            if (r26 != 0x0) {
                    r26 = [[r25 localizedStringForKey:@"%1$@ was unable to open %2$@." value:@"" table:0x0] retain];
                    r28 = [[r20 objectForKey:@"doc"] retain];
                    r27 = [[NSString stringWithFormat:r26] retain];
                    [r24 setMessageText:r27];
                    [r27 release];
            }
            else {
                    r26 = [[r25 localizedStringForKey:@"%@ was unable to open this document." value:@"" table:0x0] retain];
                    r28 = [[NSString stringWithFormat:r26] retain];
                    [r24 setMessageText:r28];
            }
            [r28 release];
            [r26 release];
            [r25 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r27 = [[r0 localizedStringForKey:@"Possible reasons for this error are:\n\n• The application associated with this document has been deleted\n• The application associated with this document is not in the default bottle\n" value:@"" table:0x0] retain];
            [r24 setInformativeText:r27];
            [r27 release];
            [r25 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 localizedStringForKey:@"OK" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r24 addButtonWithTitle:r26]);
            [r26 release];
            [r25 release];
            r0 = [r20 objectForKey:@"icon"];
            r0 = [r0 retain];
            r25 = r0;
            [r0 release];
            if (r25 != 0x0) {
                    r25 = [[r20 objectForKey:@"icon"] retain];
                    [r24 setIcon:r25];
                    r26 = var_60;
                    r28 = var_58;
                    [r25 release];
            }
            else {
                    r26 = var_60;
                    r28 = var_58;
            }
            [r24 runModal];
            [r24 release];
            r0 = [r20 objectForKey:@"launchFeedbackInfo"];
            r0 = [r0 retain];
            r24 = r0;
            if (r0 != 0x0) {
                    [r24 setLifeCounter:0x7fffffff];
            }
            r21 = *(r21 + r28);
            r25 = [[NSValue valueWithNonretainedObject:r19] retain];
            [r21 removeObjectForKey:r25];
            [r25 release];
            [r24 release];
            [r23 release];
            [r26 release];
            [r20 release];
            [r19 release];
    }
    return;


// 0x10001430c
// -[CXServer runClient:inBottle:]
    r3 = arg3;
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
    r20 = r3;
    r21 = self;
    r19 = [arg2 retain];
    r0 = [r20 retain];
    r20 = r0;
    if (r0 != 0x0) {
            r23 = [[r20 stringQuotedForBash] retain];
            r22 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
            [r23 release];
    }
    else {
            r22 = @"--bottle default";
    }
    r0 = **_NSApp;
    r0 = [r0 crossOverRoot];
    r0 = [r0 retain];
    r24 = r0;
    r0 = [r0 stringByAppendingPathComponent:@"bin"];
    r0 = [r0 retain];
    r25 = r0;
    r23 = [[r0 stringByAppendingPathComponent:@"cxstart"] retain];
    [r25 release];
    [r24 release];
    r25 = [[r23 stringQuotedForBash] retain];
    r26 = [[r19 stringQuotedForBash] retain];
    r24 = [[NSString stringWithFormat:@"%@ %@ --wait-children --enable-alt-loader macdrv --untrusted %@", r3, r4, r5] retain];
    [r26 release];
    [r25 release];
    r0 = [NSWorkspace sharedWorkspace];
    r0 = [r0 retain];
    r26 = r0;
    r25 = [[r0 iconForFile:r19] retain];
    [r26 release];
    r27 = [[NSArray arrayWithObjects:r25] retain];
    r28 = [[NSArray arrayWithObjects:@"icon"] retain];
    r26 = [[NSDictionary dictionaryWithObjects:r27 forKeys:r28] retain];
    [r21 forkExecCommand:r24 withArgs:r26];
    [r26 release];
    [r28 release];
    [r27 release];
    [r21 addToRecentItems:r19 bottle:r20];
    [r25 release];
    [r24 release];
    [r23 release];
    [r22 release];
    [r20 release];
    [r19 release];
    return;


// 0x100014580
// -[CXServer showLicense:]
    r19 = [[NSWorkspace sharedWorkspace] retain];
    r0 = **_NSApp;
    r0 = [r0 crossOverRoot];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 stringByAppendingPathComponent:@"license.txt"] retain];
    [r19 openFile:r21];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x10001460c
// +[CXServer getCellarID]
    return @"CrossOver";


// 0x100014618
// +[CXServer getAppSupportDir]
    r0 = NSSearchPathForDirectoriesInDomains(0xe, 0x1, 0x1);
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 objectAtIndex:0x0] retain];
    [r20 release];
    r19 = [[self getCellarID] retain];
    r20 = [[r21 stringByAppendingPathComponent:r19] retain];
    [r19 release];
    [r21 release];
    r0 = [r20 autorelease];
    return r0;


// 0x1000146b4
// +[CXServer getCachesDir]
    r0 = NSSearchPathForDirectoriesInDomains(0xd, 0x1, 0x1);
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 objectAtIndex:0x0] retain];
    [r19 release];
    r19 = [[r20 stringByAppendingPathComponent:@"com.codeweavers.CrossOver"] retain];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x10001472c
// +[CXServer getDefaultBottleDir]
    r0 = [CXServer getAppSupportDir];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 stringByAppendingPathComponent:@"Bottles"] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100014780
// +[CXServer getBottleDir]
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 stringForKey:@"BottleDir"] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x1000147d4
// -[CXServer setEnvValue:forKey:]
    r21 = [arg3 retain];
    r19 = [arg2 retain];
    [[CXSetupLib cxSetupClass] setEnvValue:r19 forKey:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100014838
// -[CXServer unsetEnvValueForKey:]
    r20 = [arg2 retain];
    [[CXSetupLib cxSetupClass] unsetEnvValueForKey:r20];
    [r20 release];
    return;


// 0x100014878
// -[CXServer setHttpProxyEnvironmentVariableFromSystemConfiguration]
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
    r0 = self->systemDynamicStore;
    r0 = SCDynamicStoreCopyProxies(r0);
    r19 = r0;
    r0 = [r0 objectForKey:**_kSCPropNetProxiesHTTPEnable];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 boolValue];
    [r21 release];
    if (r22 != 0x0) {
            r21 = [[r19 objectForKey:**_kSCPropNetProxiesHTTPProxy] retain];
            r22 = [[r19 objectForKey:**_kSCPropNetProxiesHTTPPort] retain];
            if ([r21 length] != 0x0) {
                    r23 = [[NSString stringWithFormat:@"http://%@:%@/", r3, r4] retain];
                    [r22 release];
                    [r21 release];
                    if (r23 != 0x0) {
                            [r20 setEnvValue:r23 forKey:@"http_proxy"];
                            [r23 release];
                    }
                    else {
                            [r20 unsetEnvValueForKey:@"http_proxy"];
                    }
            }
            else {
                    [r22 release];
                    [r21 release];
                    [r20 unsetEnvValueForKey:@"http_proxy"];
            }
    }
    else {
            [r20 unsetEnvValueForKey:@"http_proxy"];
    }
    [r19 release];
    return;


// 0x1000149b8
// -[CXServer beginMonitoringSystemConfigurationProxy]
    var_50 = q0;
    r0 = SCDynamicStoreCreate(0x0, @"CrossOver", _observeProxyChange, &var_50);
    r22 = sign_extend_64(*(int32_t *)ivar_offset(systemDynamicStore));
    *(self + r22) = r0;
    r20 = SCDynamicStoreKeyCreateProxies(0x0);
    r21 = [[NSArray arrayWithObject:r20] retain];
    SCDynamicStoreSetNotificationKeys(*(self + r22), r21, 0x0);
    r22 = SCDynamicStoreCreateRunLoopSource(0x0, *(self + r22), 0x0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), r22, **_kCFRunLoopCommonModes);
    CFRelease(r22);
    [self setHttpProxyEnvironmentVariableFromSystemConfiguration];
    [r21 release];
    [r20 release];
    return;


// 0x100014b40
// -[CXServer managedBottlePath]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [NSProcessInfo processInfo];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 environment];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 objectForKey:@"CX_MANAGED_BOTTLE_PATH"] retain];
    [r21 release];
    [r19 release];
    if (r20 == 0x0) {
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r20 = r0;
            r19 = [[r0 objectForKey:@"ManagedBottleDirs"] retain];
            [r20 release];
            objc_opt_class(@class(NSArray));
            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                    r20 = [[r19 componentsJoinedByString:@":"] retain];
                    [r19 release];
                    r19 = r20;
            }
            objc_opt_class(@class(NSString));
            if ((objc_opt_isKindOfClass() & 0x1) != 0x0 && [r19 length] != 0x0) {
                    r20 = [r19 retain];
            }
            else {
                    r20 = 0x0;
            }
            [r19 release];
    }
    r0 = [r20 autorelease];
    return r0;


// 0x100014c78
// -[CXServer setEnvironmentVariables]
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
    r0 = [NSProcessInfo processInfo];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 environment];
    r0 = [r0 retain];
    r22 = r0;
    r20 = [[r0 objectForKey:@"HOME"] retain];
    [r22 release];
    [r21 release];
    if ([r20 length] != 0x0) {
            r0 = [NSFileManager defaultManager];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 fileExistsAtPath:r20 isDirectory:&var_31];
            if ((r0 & 0x1) != 0x0) {
                    [r21 release];
                    if (var_31 == 0x0) {
                            r21 = [NSHomeDirectory() retain];
                            [r20 release];
                            _CXLog();
                            [r19 setEnvValue:r21 forKey:@"HOME"];
                            r20 = r21;
                    }
            }
            else {
                    [r21 release];
                    r21 = [NSHomeDirectory() retain];
                    [r20 release];
                    _CXLog();
                    [r19 setEnvValue:r21 forKey:@"HOME"];
                    r20 = r21;
            }
    }
    else {
            r21 = [NSHomeDirectory() retain];
            [r20 release];
            _CXLog();
            [r19 setEnvValue:r21 forKey:@"HOME"];
            r20 = r21;
    }
    r0 = [CXServer getBottleDir];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 stringInFileSystemRepresentationForm] retain];
    [r19 setEnvValue:r22 forKey:@"CX_BOTTLE_PATH"];
    [r22 release];
    [r21 release];
    r0 = [r19 managedBottlePath];
    r0 = [r0 retain];
    r21 = r0;
    if (r0 != 0x0) {
            [r19 setEnvValue:r21 forKey:@"CX_MANAGED_BOTTLE_PATH"];
    }
    [r19 beginMonitoringSystemConfigurationProxy];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 bundlePath] retain];
    [r19 setEnvValue:r23 forKey:@"CX_APP_BUNDLE_PATH"];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x100014e68
// -[CXServer validateMenuItem:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 menu];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 title] retain];
    [r21 release];
    if (([r20 menusEnabled] & 0x1) != 0x0) {
            r20 = 0x1;
    }
    else {
            if ([r19 compare:@"Help"] == 0x0) {
                    r20 = 0x1;
            }
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100014ef0
// -[CXServer runCommand:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = *_NSApp;
    r8 = objc_opt_respondsToSelector();
    r0 = *r20;
    if ((r8 & 0x1) != 0x0) {
            [r0 activate];
    }
    else {
            [r0 activateIgnoringOtherApps:0x1];
    }
    r0 = [[RunCommandController alloc] init];
    r20 = r0;
    [r0 showWindow:r19];
    [r20 release];
    return;


// 0x100014f5c
// +[CXServer fileTypesForBottle:]
    r1 = _cmd;
    r31 = r31 - 0x1b0;
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
    r21 = [arg2 retain];
    r20 = [[NSMutableArray arrayWithCapacity:0x4] retain];
    var_138 = r21;
    r21 = [[r21 winePrefix] retain];
    r23 = [[NSString stringWithFormat:@"%@/desktopdata/cxassoc/cxassoc_macosx.plist", r3] retain];
    [r21 release];
    r19 = [[NSFileManager defaultManager] retain];
    r21 = [[r23 stringByResolvingSymlink] retain];
    r24 = [[r19 attributesOfItemAtPath:r21 error:0x0] retain];
    [r21 release];
    [r19 release];
    if (r24 != 0x0) {
            r0 = [NSData dataWithContentsOfFile:r23];
            r0 = [r0 retain];
            r19 = r0;
            if (r0 != 0x0) {
                    var_E8 = 0x0;
                    r2 = r19;
                    r0 = [NSPropertyListSerialization propertyListWithData:r2 options:0x0 format:0x0 error:&var_E8];
                    r21 = [r0 retain];
                    r0 = [var_E8 retain];
                    var_170 = r0;
                    if (r21 != 0x0) {
                            objc_opt_class(@class(NSDictionary));
                            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                    var_188 = r19;
                                    var_180 = r24;
                                    var_178 = r23;
                                    var_190 = r21;
                                    r0 = [r21 retain];
                                    var_140 = r0;
                                    r0 = [r0 keyEnumerator];
                                    r0 = [r0 retain];
                                    var_148 = r0;
                                    r0 = [r0 nextObject];
                                    r0 = [r0 retain];
                                    if (r0 != 0x0) {
                                            r26 = r0;
                                            do {
                                                    r0 = [var_140 objectForKey:r26];
                                                    r0 = [r0 retain];
                                                    r22 = r0;
                                                    r23 = [[r0 objectForKey:@"Description"] retain];
                                                    r25 = [[r22 objectForKey:@"Extension Associations/"] retain];
                                                    r19 = [[var_138 name] retain];
                                                    r21 = [r23 caseInsensitiveCompare:r19];
                                                    [r19 release];
                                                    if (r21 == 0x0) {
                                                            var_160 = r23;
                                                            var_158 = r22;
                                                            var_150 = r26;
                                                            var_130 = q0;
                                                            var_120 = q0;
                                                            var_168 = r25;
                                                            r0 = [r25 retain];
                                                            r26 = r0;
                                                            r0 = [r0 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                                                            if (r0 != 0x0) {
                                                                    r27 = r0;
                                                                    r28 = *var_120;
                                                                    do {
                                                                            r25 = 0x0;
                                                                            do {
                                                                                    if (*var_120 != r28) {
                                                                                            objc_enumerationMutation(r26);
                                                                                    }
                                                                                    r21 = *(var_128 + r25 * 0x8);
                                                                                    r19 = [[r21 componentsSeparatedByString:@"/"] retain];
                                                                                    r0 = [r26 objectForKey:r21];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r0 = [r0 objectForKey:@"Extension"];
                                                                                    r0 = [r0 retain];
                                                                                    r22 = r0;
                                                                                    if (r0 == 0x0) {
                                                                                            r0 = [r19 objectAtIndex:0x0];
                                                                                            r0 = [r0 retain];
                                                                                            r23 = r0;
                                                                                            r22 = [[r0 substringFromIndex:0x1] retain];
                                                                                            [r23 release];
                                                                                    }
                                                                                    [r20 addObject:r22];
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    [r19 release];
                                                                                    r25 = r25 + 0x1;
                                                                            } while (r27 != r25);
                                                                            r0 = [r26 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                                                                            r27 = r0;
                                                                    } while (r0 != 0x0);
                                                            }
                                                            [r26 release];
                                                            r22 = var_158;
                                                            r26 = var_150;
                                                            r25 = var_168;
                                                            r23 = var_160;
                                                    }
                                                    [r25 release];
                                                    [r23 release];
                                                    [r22 release];
                                                    r19 = [[var_148 nextObject] retain];
                                                    [r26 release];
                                                    r26 = r19;
                                            } while (r19 != 0x0);
                                    }
                                    [var_148 release];
                                    [var_140 release];
                                    r24 = var_180;
                                    r23 = var_178;
                                    r21 = var_190;
                                    r19 = var_188;
                            }
                    }
                    else {
                            NSLog(@"Failed to parse cxassoc plist %@: %@\n", r1, r2);
                    }
                    [r20 retain];
                    [r21 release];
                    [var_170 release];
            }
            else {
                    [r20 retain];
            }
            [r19 release];
    }
    else {
            [r20 retain];
    }
    [r24 release];
    [r23 release];
    [r20 release];
    r0 = [var_138 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r20 autorelease];
    return r0;


// 0x1000153f8
// -[CXServer fileManager:shouldProceedAfterError:copyingItemAtURL:toURL:]
    NSLog(@"Error copying %@ to %@: %@", _cmd, arg2, r3);
    return 0x0;


// 0x100015428
// -[CXServer fileManager:shouldProceedAfterError:linkingItemAtURL:toURL:]
    NSLog(@"Error linking %@ to %@: %@", _cmd, arg2, r3);
    return 0x0;


// 0x100015458
// -[CXServer fileManager:shouldProceedAfterError:movingItemAtURL:toURL:]
    NSLog(@"Error moving %@ to %@: %@", _cmd, arg2, r3);
    return 0x0;


// 0x100015488
// -[CXServer fileManager:shouldProceedAfterError:removingItemAtURL:]
    NSLog(@"Error removing %@: %@", _cmd, arg2);
    return 0x0;


// 0x1000154b4
// -[CXServer replyToApplicationShouldTerminateTrampoline:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = [arg2 retain];
    r21 = [[NSApplication sharedApplication] retain];
    [r21 replyToApplicationShouldTerminate:[r20 boolValue]];
    [r21 release];
    r0 = [self shutdownController];
    r0 = [r0 retain];
    r21 = r0;
    [r0 close];
    [r21 release];
    r8 = sign_extend_64(*(int32_t *)ivar_offset(shutdownController));
    r0 = *(self + r8);
    *(self + r8) = 0x0;
    [r0 release];
    *(int8_t *)(int64_t *)&self->quitting = 0x0;
    if (0x0 != 0x0) {
            objc_exception_rethrow();
    }
    [r20 release];
    return;


// 0x100015598
// -[CXServer applicationShouldTerminate:]
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
    r20 = **_NSApp;
    r21 = [arg2 retain];
    r20 = [[r20 wineController] retain];
    r22 = objc_opt_respondsToSelector();
    [r20 release];
    if ((r22 & 0x1) != 0x0) {
            r0 = **_NSApp;
            r0 = [r0 wineController];
            r0 = [r0 retain];
            r19 = r0;
            r20 = [r0 applicationShouldTerminate:r21];
            [r21 release];
            [r19 release];
    }
    else {
            r0 = [r19 shutdownController];
            r0 = [r0 retain];
            r20 = r0;
            [r0 showWindow:r21];
            [r21 release];
            [r20 release];
            r8 = sign_extend_64(*(int32_t *)ivar_offset(quitting));
            if (*(int8_t *)(r19 + r8) != 0x0) {
                    r20 = 0x2;
            }
            else {
                    r20 = 0x1;
                    *(int8_t *)(r19 + r8) = 0x1;
                    r0 = [CXSetupLib bottleCollectionClass];
                    r0 = [r0 sharedCollection];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 release];
                    if (r21 != 0x0) {
                            r0 = [r19 shutdownController];
                            r0 = [r0 retain];
                            r19 = r0;
                            [r0 shutdownAllBottles];
                            r20 = 0x2;
                            [r19 release];
                    }
            }
    }
    r0 = r20;
    return r0;


// 0x1000156d0
// -[CXServer applicationIcon]
    r19 = [[NSWorkspace sharedWorkspace] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 bundlePath] retain];
    r0 = [r19 iconForFile:r21];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 copy];
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    [r23 setSize:r2];
    r0 = [r23 autorelease];
    return r0;


// 0x100015790
// -[CXServer startedAppGateOp]
    r0 = [self startAppOp];
    return r0;


// 0x100015794
// -[CXServer application:openFile:]
    r22 = [arg3 retain];
    *(int8_t *)(int64_t *)&self->gotLaunchEvent = 0x1;
    r0 = [NSAppleEventManager sharedAppleEventManager];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 currentAppleEvent] retain];
    [r20 release];
    r0 = [r19 paramDescriptorForKeyword:0x70726474];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 descriptorForKeyword:0x42744e6d];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 stringValue] retain];
    [r23 release];
    var_68 = *__NSConcreteStackBlock;
    var_40 = r22;
    var_38 = r24;
    r24 = [r24 retain];
    r22 = [r22 retain];
    r0 = [NSBlockOperation blockOperationWithBlock:&var_68];
    r23 = [r0 retain];
    r21 = [[self startedAppGateOp] retain];
    [r23 addDependency:r21];
    [r21 release];
    r0 = [NSOperationQueue mainQueue];
    r0 = [r0 retain];
    r21 = r0;
    [r0 addOperation:r23];
    [r21 release];
    [r23 release];
    [var_38 release];
    [var_40 release];
    [r24 release];
    [r22 release];
    [r20 release];
    [r19 release];
    return 0x1;


// 0x100015970
// -[CXServer applicationOpenUntitledFile:]
    *(int8_t *)(int64_t *)&self->gotLaunchEvent = 0x1;
    return 0x1;


// 0x100015988
// -[CXServer applicationShouldOpenUntitledFile:]
    return 0x1;


// 0x100015990
// -[CXServer applicationShouldHandleReopen:hasVisibleWindows:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg3;
    r19 = [arg2 retain];
    r21 = [[**_NSApp wineController] retain];
    r22 = objc_opt_respondsToSelector();
    [r21 release];
    if ((r22 & 0x1) != 0x0) {
            r0 = **_NSApp;
            r0 = [r0 wineController];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [r0 applicationShouldHandleReopen:r19 hasVisibleWindows:r20];
            [r21 release];
    }
    else {
            r20 = 0x1;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100015a40
// -[CXServer openDocument:]
    r20 = [[SelectBottleController alloc] init];
    r0 = [NSOpenPanel openPanel];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setCanChooseFiles:0x1];
    [r21 setCanChooseDirectories:0x0];
    [r21 setAllowsMultipleSelection:0x1];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"If possible, the selected document will be opened in the appropriate Windows application.\nAvailable file types may vary depending on which bottle is selected below." value:@"" table:0x0] retain];
    [r21 setMessage:r24];
    [r24 release];
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r25 = [[r0 localizedStringForKey:@"Open" value:@"" table:0x0] retain];
    [r21 setPrompt:r25];
    [r25 release];
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [[r0 localizedStringForKey:@"Open" value:@"" table:0x0] retain];
    [r21 setTitle:r22];
    [r22 release];
    [r23 release];
    [r21 setCanCreateDirectories:0x0];
    r22 = [[r20 view] retain];
    [r21 setAccessoryView:r22];
    [r22 release];
    [r21 setDelegate:r20];
    var_78 = *__NSConcreteStackBlock;
    var_58 = r20;
    r19 = [r21 retain];
    r20 = [r20 retain];
    [r19 beginWithCompletionHandler:&var_78];
    [r21 release];
    [var_58 release];
    [r19 release];
    [r20 release];
    return;


// 0x100015dfc
// -[CXServer addToRecentItems:bottle:]
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
    r22 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r21 = r0;
    [r0 fileExistsAtPath:r19 isDirectory:&var_51];
    asm { ccmp       w8, #0x0, #0x0, ne };
    if (!asm { ccmp       w8, #0x0, #0x0, ne }) {
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 arrayForKey:@"RecentItems"];
            r0 = [r0 retain];
            r25 = r0;
            r24 = [r0 mutableCopy];
            [r25 release];
            r26 = [r23 integerForKey:@"RecentItemsCount"];
            r0 = [r21 bookmarkDataFromPath:r19];
            r0 = [r0 retain];
            r25 = r0;
            if (r0 != 0x0) {
                    var_90 = *__NSConcreteStackBlock;
                    r0 = [r20 retain];
                    r28 = r0;
                    var_70 = r0;
                    var_68 = [r21 retain];
                    var_60 = [r19 retain];
                    r0 = [r24 indexOfObjectPassingTest:&var_90];
                    if (r0 != 0x7fffffffffffffff) {
                            [r24 removeObjectAtIndex:r0];
                    }
                    r0 = [NSMutableDictionary dictionary];
                    r0 = [r0 retain];
                    r27 = r0;
                    [r0 setObject:r25 forKey:@"bookmark"];
                    if (r28 != 0x0) {
                            [r27 setObject:r28 forKey:@"bottle"];
                    }
                    [r24 insertObject:r27 atIndex:0x0];
                    if ([r24 count] >= r26) {
                            [r24 count] - r26;
                            [r24 removeObjectsInRange:r26];
                    }
                    [r23 setObject:r24 forKey:@"RecentItems"];
                    [r22 updateRecentItemsMenu];
                    [r27 release];
                    [var_60 release];
                    [var_68 release];
                    [var_70 release];
            }
            [r25 release];
            [r24 release];
            [r23 release];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x100016148
// -[CXServer makeBottleTaggedName:withBottleName:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg3;
    r19 = [arg2 retain];
    if (r20 != 0x0) {
            r22 = [r20 retain];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 localizedStringForKey:@"%1$@ (%2$@)" value:@"" table:0x0] retain];
            [r20 release];
            r20 = [[NSString stringWithFormat:r21] retain];
            [r22 release];
            [r21 release];
    }
    else {
            r20 = [r19 retain];
    }
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100016224
// -[CXServer updateRecentItemsMenu]
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
    r20 = self;
    var_60 = **___stack_chk_guard;
    r8 = sign_extend_64(*(int32_t *)ivar_offset(openRecent));
    var_140 = r8;
    [*(self + r8) removeAllItems];
    r26 = [[NSFileManager defaultManager] retain];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 arrayForKey:@"RecentItems"] retain];
    var_170 = r19;
    r24 = [r19 integerForKey:@"RecentItemsCount"];
    r23 = [[NSMutableArray arrayWithCapacity:[r21 count]] retain];
    var_168 = [[NSMutableIndexSet indexSet] retain];
    var_120 = q0;
    var_110 = q0;
    r0 = [r21 retain];
    var_160 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    var_148 = r23;
    var_130 = r0;
    if (r0 != 0x0) {
            var_138 = *var_110;
            var_150 = r24;
            while (true) {
                    r25 = 0x0;
                    var_158 = @selector(openRecent:);
                    while (true) {
                            if (*var_110 != var_138) {
                                    objc_enumerationMutation(var_160);
                            }
                            r0 = *(var_118 + r25 * 0x8);
                            r0 = [r0 retain];
                            r28 = r0;
                            r24 = [[r0 objectForKey:@"bookmark"] retain];
                            r0 = [r26 pathFromBookmarkData:r24 stale:&var_121];
                            r21 = [r0 retain];
                            asm { ccmp       w8, #0x0, #0x4, ne };
                            if (!asm { ccmp       w8, #0x0, #0x4, ne }) {
                                    [r23 addObject:r28];
                                    if (r21 != 0x0) {
                                            r27 = r24;
                                            r22 = r26;
                                            r24 = [[r26 displayNameAtPath:r21] retain];
                                            r23 = [[r28 objectForKey:@"bottle"] retain];
                                            r26 = [[r20 makeBottleTaggedName:r24 withBottleName:r23] retain];
                                            [r23 release];
                                            r0 = [NSMenuItem alloc];
                                            r0 = [r0 initWithTitle:r26 action:var_158 keyEquivalent:@""];
                                            r23 = r0;
                                            [r0 setTarget:r20];
                                            [r23 setRepresentedObject:r28];
                                            [*(r20 + var_140) addItem:r23];
                                            r19 = [*(r20 + var_140) numberOfItems];
                                            [r23 release];
                                            [r26 release];
                                            [r24 release];
                                            r24 = var_150;
                                            if (r19 < r24) {
                                                    r24 = r27;
                                                    r26 = r22;
                                                    r23 = var_148;
                                                    [r21 release];
                                                    [r24 release];
                                                    [r28 release];
                                                    r25 = r25 + 0x1;
                                                    if (var_130 != r25) {
                                                            continue;
                                                    }
                                                    temp_0 = 0x0;
                                                    break;
                                            }
                                            else {
                                                    [r21 release];
                                                    [r27 release];
                                                    [r28 release];
                                                    r26 = r22;
                                                    r23 = var_148;
                                                    temp_0 = 0x1;
                                                    break;
                                            }
                                    }
                                    else {
                                            [var_168 addIndex:[r23 count] - 0x1];
                                            [r21 release];
                                            [r24 release];
                                            [r28 release];
                                            r25 = r25 + 0x1;
                                            if (var_130 != r25) {
                                                    continue;
                                            }
                                            temp_0 = 0x0;
                                            break;
                                    }
                            }
                            else {
                                    r27 = [[r26 bookmarkDataFromPath:r21] retain];
                                    [r24 release];
                                    if (r27 != 0x0) {
                                            r0 = [r28 mutableCopy];
                                            r24 = r0;
                                            [r0 setObject:r27 forKey:@"bookmark"];
                                            [r28 release];
                                            r28 = r24;
                                    }
                                    [r23 addObject:r28];
                                    r22 = r26;
                                    r24 = [[r26 displayNameAtPath:r21] retain];
                                    r23 = [[r28 objectForKey:@"bottle"] retain];
                                    r26 = [[r20 makeBottleTaggedName:r24 withBottleName:r23] retain];
                                    [r23 release];
                                    r0 = [NSMenuItem alloc];
                                    r0 = [r0 initWithTitle:r26 action:var_158 keyEquivalent:@""];
                                    r23 = r0;
                                    [r0 setTarget:r20];
                                    [r23 setRepresentedObject:r28];
                                    [*(r20 + var_140) addItem:r23];
                                    r19 = [*(r20 + var_140) numberOfItems];
                                    [r23 release];
                                    [r26 release];
                                    [r24 release];
                                    r24 = var_150;
                                    if (r19 < r24) {
                                            r24 = r27;
                                            r26 = r22;
                                            r23 = var_148;
                                            [r21 release];
                                            [r24 release];
                                            [r28 release];
                                            r25 = r25 + 0x1;
                                            if (var_130 != r25) {
                                                    continue;
                                            }
                                            temp_0 = 0x0;
                                            break;
                                    }
                                    else {
                                            [r21 release];
                                            [r27 release];
                                            [r28 release];
                                            r26 = r22;
                                            r23 = var_148;
                                            temp_0 = 0x1;
                                            break;
                                    }
                            }
                    }
                    if (temp_0 == 0x0) {
                            r0 = [var_160 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                            r24 = var_150;
                            var_130 = r0;
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
    [var_160 release];
    r22 = var_170;
    r25 = var_168;
    if ([r23 count] >= r24) {
            do {
                    if ([r25 count] != 0x0) {
                            r19 = [r25 lastIndex];
                            [r23 removeObjectAtIndex:r19];
                            [r25 removeIndex:r19];
                    }
                    else {
                            [r23 count] - r24;
                            [r23 removeObjectsInRange:r24];
                    }
            } while ([r23 count] > r24);
    }
    [r22 setObject:r23 forKey:@"RecentItems"];
    r19 = [NSMenuItem alloc];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"Clear" value:@"" table:0x0] retain];
    r21 = [r19 initWithTitle:r24 action:@selector(clearRecent:) keyEquivalent:@""];
    [r24 release];
    [r23 release];
    [r21 setTarget:r20];
    r24 = var_140;
    if ([*(r20 + r24) numberOfItems] != 0x0) {
            r19 = *(r20 + r24);
            r23 = [[NSMenuItem separatorItem] retain];
            [r19 addItem:r23];
            [r23 release];
    }
    else {
            [r21 setAction:0x0];
    }
    [*(r20 + r24) addItem:r21];
    [r21 release];
    [r25 release];
    [var_148 release];
    [var_160 release];
    [r22 release];
    [r26 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x100016784
// -[CXServer openRecent:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r0 = [arg2 representedObject];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 objectForKey:@"bookmark"] retain];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [[r0 pathFromBookmarkData:r20 stale:0x0] retain];
    [r23 release];
    if (r22 != 0x0) {
            r23 = [[r19 objectForKey:@"bottle"] retain];
            [r21 runClient:r22 inBottle:r23];
            [r23 release];
    }
    else {
            NSBeep();
            [r21 updateRecentItemsMenu];
    }
    [r22 release];
    [r20 release];
    [r19 release];
    return;


// 0x100016870
// -[CXServer clearRecent:]
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObjectForKey:@"RecentItems"];
    [r20 release];
    [self updateRecentItemsMenu];
    return;


// 0x1000168bc
// -[CXServer processFirstRun:]
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setObject:@"26.3.0.39832" forKey:@"FirstRunVersion"];
    [r19 release];
    return;


// 0x100016904
// -[CXServer handleGetURLEvent:withReplyEvent:]
    r3 = arg3;
    r31 = r31 - 0xc0;
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
    r23 = self;
    *(int8_t *)(int64_t *)&self->gotLaunchEvent = 0x1;
    r0 = [arg2 retain];
    r22 = r0;
    r0 = [r0 paramDescriptorForKeyword:0x2d2d2d2d];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 stringValue] retain];
    r21 = [[r22 paramDescriptorForKeyword:0x70726474] retain];
    [r22 release];
    r0 = [r21 descriptorForKeyword:0x42744e6d];
    r0 = [r0 retain];
    r24 = r0;
    r22 = [[r0 stringValue] retain];
    [r24 release];
    if ([r20 length] != 0x0) {
            r0 = [NSURL URLWithString:r20];
            r0 = [r0 retain];
            r25 = r0;
            r0 = [r0 scheme];
            r0 = [r0 retain];
            r26 = r0;
            r0 = [r0 caseInsensitiveCompare:@"com.codeweavers.private-CrossOver-app-scheme"];
            r27 = r0;
            if (r0 != 0x0) {
                    r24 = 0x1;
            }
            [r26 release];
            if (r27 != 0x0) {
                    var_8C = r24;
                    var_88 = r25;
                    if (r22 != 0x0) {
                            r27 = [[r22 stringQuotedForBash] retain];
                            r24 = [[NSString stringWithFormat:@"--bottle %@", r3] retain];
                            [r27 release];
                    }
                    else {
                            r24 = @"--bottle default";
                    }
                    r0 = **_NSApp;
                    r0 = [r0 crossOverRoot];
                    r0 = [r0 retain];
                    r28 = r0;
                    r0 = [r0 stringByAppendingPathComponent:@"bin"];
                    r0 = [r0 retain];
                    r26 = r0;
                    r0 = [r0 stringByAppendingPathComponent:@"cxstart"];
                    r0 = [r0 retain];
                    r27 = r0;
                    var_98 = r0;
                    [r26 release];
                    [r28 release];
                    r28 = [[r27 stringQuotedForBash] retain];
                    r25 = [[r20 stringQuotedForBash] retain];
                    r26 = [[NSString stringWithFormat:@"%@ %@ --wait-children --enable-alt-loader macdrv -- %@", r3, r4, r5] retain];
                    [r25 release];
                    [r28 release];
                    var_80 = *__NSConcreteStackBlock;
                    var_58 = r26;
                    r26 = [r26 retain];
                    r0 = [NSBlockOperation blockOperationWithBlock:&var_80];
                    r25 = [r0 retain];
                    r23 = [[r23 startedAppGateOp] retain];
                    [r25 addDependency:r23];
                    [r23 release];
                    r0 = [NSOperationQueue mainQueue];
                    r0 = [r0 retain];
                    r23 = r0;
                    [r0 addOperation:r25];
                    [r23 release];
                    [r25 release];
                    [var_58 release];
                    [r26 release];
                    [var_98 release];
                    [r24 release];
                    r25 = var_88;
                    r24 = var_8C;
            }
            [r25 release];
    }
    else {
            r24 = 0x0;
    }
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = r24;
    return r0;


// 0x100016c80
// -[CXServer .cxx_destruct]
    objc_storeStrong((int64_t *)&self->lastDemoNagTime, 0x0);
    objc_storeStrong((int64_t *)&self->startAppOp, 0x0);
    objc_storeStrong((int64_t *)&self->backgroundQueue, 0x0);
    objc_storeStrong((int64_t *)&self->tasksInProgress, 0x0);
    objc_storeStrong((int64_t *)&self->demoRegisterController, 0x0);
    objc_storeStrong((int64_t *)&self->shutdownController, 0x0);
    objc_storeStrong((int64_t *)&self->launchFeedbackTimer, 0x0);
    objc_storeStrong((int64_t *)&self->pendingAppLaunches, 0x0);
    objc_storeStrong((int64_t *)&self->openRecent, 0x0);
    return;


