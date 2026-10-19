// CXUpdater — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001c5b0
// +[CXUpdater sharedUpdater]
    r20 = [[NSBundle mainBundle] retain];
    r19 = [[self updaterForBundle:r20] retain];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x10001c608
// +[CXUpdater updaterForBundle:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    if (r0 == 0x0) {
            r19 = [[NSBundle mainBundle] retain];
    }
    r21 = *_sharedUpdaters;
    r22 = [[NSValue valueWithNonretainedObject:r19] retain];
    r21 = [[r21 objectForKey:r22] retain];
    [r22 release];
    if (r21 == 0x0) {
            r21 = [[objc_opt_class(r20) alloc] initForBundle:r19];
    }
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x10001c6c0
// -[CXUpdater initForBundle:]
    r31 = r31 - 0x60;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    var_40 = self;
    r0 = [[&var_40 super] init];
    r20 = r0;
    if (r19 == 0x0) {
            r19 = [[NSBundle mainBundle] retain];
    }
    r21 = *_sharedUpdaters;
    r22 = [[NSValue valueWithNonretainedObject:r19] retain];
    r21 = [[r21 objectForKey:r22] retain];
    [r22 release];
    if (r21 != 0x0) {
            r22 = r20;
            r20 = [r21 retain];
            [r22 release];
    }
    else {
            if (r20 != 0x0) {
                    r22 = *_sharedUpdaters;
                    if (*_sharedUpdaters == 0x0) {
                            r0 = [[NSMutableDictionary alloc] init];
                            r8 = *_sharedUpdaters;
                            *_sharedUpdaters = r0;
                            [r8 release];
                            r22 = *_sharedUpdaters;
                    }
                    r23 = [[NSValue valueWithNonretainedObject:r19] retain];
                    [r22 setObject:r20 forKey:r23];
                    [r23 release];
                    r0 = [CXSparkleUserDriver alloc];
                    r0 = [r0 initWithHostBundle:r19 delegate:r20];
                    r8 = r20[0x2];
                    r20[0x2] = r0;
                    [r8 release];
                    r0 = [SPUUpdater alloc];
                    r0 = [r0 initWithHostBundle:r19 applicationBundle:r19 userDriver:r20[0x2] delegate:r20];
                    r8 = r20[0x1];
                    r20[0x1] = r0;
                    [r8 release];
                    r0 = r20[0x1];
                    var_48 = 0x0;
                    r0 = [r0 startUpdater:&var_48];
                    r23 = r0;
                    r22 = [var_48 retain];
                    if ((r23 & 0x1) == 0x0) {
                            _CXLog();
                    }
                    [r20 setUserAgentString];
                    [r22 release];
            }
    }
    [r21 release];
    [r19 release];
    r0 = r20;
    return r0;


// 0x10001c8a4
// -[CXUpdater init]
    r20 = [[NSBundle mainBundle] retain];
    r19 = [self initForBundle:r20];
    [r20 release];
    r0 = r19;
    return r0;


// 0x10001c8f4
// -[CXUpdater setUserAgentString]
    r31 = r31 - 0x60;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [NSProcessInfo processInfo];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0) {
            [r20 operatingSystemVersion];
    }
    else {
            var_38 = 0x0;
            var_28 = 0x0;
    }
    [r20 release];
    r20 = [[r19[0x1] userAgentString] retain];
    r21 = [[NSString stringWithFormat:@" (macOS %ld.%ld.%ld) Sparkle", r3, r4, r5] retain];
    r22 = [[r20 stringByReplacingOccurrencesOfString:@" Sparkle" withString:r21] retain];
    [r21 release];
    [r20 release];
    [r19[0x1] setUserAgentString:r22];
    [r22 release];
    return;


// 0x10001c9e4
// -[CXUpdater automaticallyChecksForUpdates]
    r0 = self[0x1];
    r0 = [r0 automaticallyChecksForUpdates];
    return r0;


// 0x10001c9ec
// -[CXUpdater setAutomaticallyChecksForUpdates:]
    [self[0x1] setAutomaticallyChecksForUpdates:arg2];
    return;


// 0x10001c9f4
// -[CXUpdater updateCheckInterval]
    r0 = self[0x1];
    r0 = [r0 updateCheckInterval];
    return r0;


// 0x10001c9fc
// -[CXUpdater checkForUpdates:]
    [self[0x1] checkForUpdates];
    return;


// 0x10001ca04
// -[CXUpdater validateMenuItem:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([arg2 action] != @selector(checkForUpdates:)) {
            r0 = 0x1;
    }
    else {
            r0 = r19[0x1];
            r0 = [r0 canCheckForUpdates];
    }
    return r0;


// 0x10001ca4c
// -[CXUpdater checkForUpdatesInBackground]
    r0 = self;
    if (r0[0x18] != 0x0) {
            [r0 checkForUpdates:0x0];
    }
    else {
            [r0[0x1] checkForUpdatesInBackground];
    }
    return;


// 0x10001ca64
// -[CXUpdater lastUpdateCheckDate]
    r0 = self[0x1];
    r0 = [r0 lastUpdateCheckDate];
    return r0;


// 0x10001ca6c
// -[CXUpdater bestValidUpdateInAppcast:forUpdater:]
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
    r21 = r20 + 0x20;
    r22 = objc_loadWeakRetained(r21);
    r23 = objc_opt_respondsToSelector();
    [r22 release];
    if ((r23 & 0x1) != 0x0) {
            r0 = objc_loadWeakRetained(r21);
            r21 = r0;
            r20 = [[r0 bestValidUpdateInAppcast:r19 forUpdater:r20] retain];
            [r21 release];
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10001cb10
// -[CXUpdater updaterDidNotFindUpdate:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = self + 0x20;
    r21 = objc_loadWeakRetained(r20);
    r22 = objc_opt_respondsToSelector();
    [r21 release];
    if ((r22 & 0x1) != 0x0) {
            r0 = objc_loadWeakRetained(r20);
            r20 = r0;
            [r0 updaterDidNotFindUpdate:r19];
            [r20 release];
    }
    return;


// 0x10001cb88
// -[CXUpdater updater:didAbortWithError:]
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
    r19 = [arg3 retain];
    r21 = r20 + 0x20;
    r22 = objc_loadWeakRetained(r21);
    r23 = objc_opt_respondsToSelector();
    [r22 release];
    if ((r23 & 0x1) != 0x0) {
            r0 = objc_loadWeakRetained(r21);
            r21 = r0;
            [r0 updaterDidAbortWithError:r20 error:r19];
            [r21 release];
    }
    [r19 release];
    return;


// 0x10001cc10
// -[CXUpdater updater:userDidMakeChoice:forUpdate:state:]
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
    r23 = arg3;
    r22 = self;
    r19 = [arg2 retain];
    r20 = [arg4 retain];
    r21 = [arg5 retain];
    if (r23 != 0x2) {
            if (r23 == 0x0) {
                    r23 = r22 + 0x20;
                    r24 = objc_loadWeakRetained(r23);
                    r25 = objc_opt_respondsToSelector();
                    [r24 release];
                    if ((r25 & 0x1) != 0x0) {
                            r0 = objc_loadWeakRetained(r23);
                            r23 = r0;
                            [r0 updater:r22 userDidSkipThisVersion:r20];
                            [r23 release];
                    }
            }
    }
    else {
            r23 = r22 + 0x20;
            r24 = objc_loadWeakRetained(r23);
            r25 = objc_opt_respondsToSelector();
            [r24 release];
            if ((r25 & 0x1) != 0x0) {
                    r0 = objc_loadWeakRetained(r23);
                    r23 = r0;
                    [r0 userDidCancelDownload:r22];
                    [r23 release];
            }
    }
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x10001cd24
// -[CXUpdater updater:failedToDownloadUpdate:error:]
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
    r19 = [arg3 retain];
    r20 = [arg4 retain];
    r22 = r21 + 0x20;
    r23 = objc_loadWeakRetained(r22);
    r24 = objc_opt_respondsToSelector();
    [r23 release];
    if ((r24 & 0x1) != 0x0) {
            r0 = objc_loadWeakRetained(r22);
            r22 = r0;
            [r0 updater:r21 failedToDownloadUpdate:r19 error:r20];
            [r22 release];
    }
    [r20 release];
    [r19 release];
    return;


// 0x10001cdc8
// -[CXUpdater userDidCancelDownload:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = self + 0x20;
    r21 = objc_loadWeakRetained(r20);
    r22 = objc_opt_respondsToSelector();
    [r21 release];
    if ((r22 & 0x1) != 0x0) {
            r0 = objc_loadWeakRetained(r20);
            r20 = r0;
            [r0 userDidCancelDownload:r19];
            [r20 release];
    }
    return;


// 0x10001ce40
// -[CXUpdater setNotLicensed:]
    [self[0x2] setNotLicensed:arg2];
    return;


// 0x10001ce48
// -[CXUpdater standardUserDriverWillHandleShowingUpdate:forUpdate:state:]
    r0 = self;
    if ((arg2 & 0x1) == 0x0) {
            r0[0x18] = 0x1;
    }
    return;


// 0x10001ce58
// -[CXUpdater standardUserDriverWillFinishUpdateSession]
    self[0x18] = 0x0;
    return;


// 0x10001ce60
// -[CXUpdater delegate]
    r0 = objc_loadWeakRetained(self + 0x20);
    r0 = [r0 autorelease];
    return r0;


// 0x10001ce78
// -[CXUpdater setDelegate:]
    objc_storeWeak(self + 0x20, arg2);
    return;


// 0x10001ce84
// -[CXUpdater setUpdateCheckInterval:]
    self[0x5] = d0;
    return;


// 0x10001ce8c
// -[CXUpdater .cxx_destruct]
    objc_destroyWeak(self + 0x20);
    objc_storeStrong(self + 0x10, 0x0);
    objc_storeStrong(self + 0x8, 0x0);
    return;


