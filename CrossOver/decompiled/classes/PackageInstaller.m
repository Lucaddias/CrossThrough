// PackageInstaller — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100008690
// -[PackageInstaller initWithPackage:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    var_30 = self;
    r0 = [[&var_30 super] init];
    r20 = r0;
    if (r0 != 0x0) {
            r21 = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
            objc_storeWeak((int64_t *)&r20->_bottleCollection, r21);
            [r21 release];
            r0 = [[InstallConfiguration alloc] init];
            r21 = sign_extend_64(*(int32_t *)ivar_offset(_installConfiguration));
            r8 = *(r20 + r21);
            *(r20 + r21) = r0;
            [r8 release];
            [*(r20 + r21) addDelegate:r20];
            [r20 setSelectedPackage:r19];
            [r20 addMountedVolumes];
            r0 = [r20 bottleCollection];
            r0 = [r0 retain];
            r21 = r0;
            [r0 addObserver:r20 forKeyPath:@"bottleList" options:0x7 context:_PackageInstallerKVOContext];
            [r21 release];
            r0 = [NSMutableArray arrayWithCapacity:0x4];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_currentTasks));
            r8 = *(r20 + r9);
            *(r20 + r9) = r0;
            [r8 release];
            r0 = [NSMutableArray arrayWithCapacity:0x4];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_failedTasks));
            r8 = *(r20 + r9);
            *(r20 + r9) = r0;
            [r8 release];
            [r20 setStatus:0x0];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100008814
// -[PackageInstaller dealloc]
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
    r19 = self;
    var_58 = **___stack_chk_guard;
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
    r21 = r0;
    [r0 removeObserver:r19 forKeyPath:@"bottleList"];
    [r21 release];
    var_120 = q0;
    var_110 = q0;
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
    r21 = r0;
    r20 = [[r0 bottleList] retain];
    [r21 release];
    r0 = [r20 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r26 = *var_110;
            do {
                    r27 = 0x0;
                    do {
                            if (*var_110 != r26) {
                                    objc_enumerationMutation(r20);
                            }
                            r25 = *(var_118 + r27 * 0x8);
                            [r25 removeObserver:r19 forKeyPath:@"canInstall" context:_PackageInstallerKVOContext];
                            [r25 removeObserver:r19 forKeyPath:@"isInstalledPackagesReady" context:_PackageInstallerKVOContext];
                            r27 = r27 + 0x1;
                    } while (r23 != r27);
                    r0 = [r20 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    [r19->_downloadUpdateTimer invalidate];
    [r19->_installConfiguration removeDelegate:r19];
    var_130 = r19;
    [[&var_130 super] dealloc];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x1000089dc
// -[PackageInstaller observeValueForKeyPath:ofObject:change:context:]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x1a0;
    r24 = arg5;
    r23 = _cmd;
    r22 = self;
    var_58 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    if (r24 != _PackageInstallerKVOContext) {
            var_1F0 = r22;
            [[&var_1F0 super] observeValueForKeyPath:r19 ofObject:r20 change:r21 context:r24];
            [r21 release];
            [r20 release];
            [r19 release];
            if (**___stack_chk_guard != var_58) {
                    __stack_chk_fail();
            }
    }
    else {
            r0 = [r22 bottleCollection];
            r0 = [r0 retain];
            if (r0 != r20) {
                    [r0 release];
                    if ([r19 isEqualToString:@"canInstall"] != 0x0) {
                            r23 = [r20 retain];
                            r0 = [r22 installConfiguration];
                            r0 = [r0 retain];
                            r25 = r0;
                            r24 = [[r0 bottles] retain];
                            [r25 release];
                            r26 = [[r23 name] retain];
                            r0 = [r24 objectForKey:r26];
                            r0 = [r0 retain];
                            r25 = r0;
                            [r0 release];
                            [r26 release];
                            r0 = [r21 objectForKey:**_NSKeyValueChangeNewKey];
                            r0 = [r0 retain];
                            r27 = r0;
                            r26 = [r0 boolValue];
                            [r27 release];
                            if (r25 == 0x0) {
                                    if (r26 != 0x0) {
                                            [r22 addBottleToInstallTask:r23];
                                    }
                                    else {
                                            if (r25 == 0x0) {
                                                    r8 = 0x1;
                                            }
                                            else {
                                                    r8 = r26;
                                            }
                                            if ((r8 & 0x1) == 0x0) {
                                                    [r22 removeBottleFromInstallTask:r23];
                                            }
                                    }
                            }
                            else {
                                    if (r25 == 0x0) {
                                            if (0x1 == 0x0) {
                                                    [r22 removeBottleFromInstallTask:r23];
                                            }
                                    }
                                    else {
                                            r8 = r26;
                                            if ((r8 & 0x1) == 0x0) {
                                                    [r22 removeBottleFromInstallTask:r23];
                                            }
                                    }
                            }
                            [r24 release];
                            [r23 release];
                    }
                    else {
                            if ([r19 isEqualToString:@"isInstalledPackagesReady"] != 0x0) {
                                    [r22 bottleLoadedInfo:r20];
                            }
                    }
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    if (**___stack_chk_guard != var_58) {
                            __stack_chk_fail();
                    }
            }
            else {
                    r24 = [r19 isEqualToString:@"bottleList"];
                    [r20 release];
                    if (r24 != 0x0) {
                            if (([NSThread isMainThread] & 0x1) == 0x0) {
                                    r0 = [NSAssertionHandler currentHandler];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    [r0 handleFailureInMethod:r23 object:r22 file:@"PackageInstaller.m" lineNumber:0x86 description:@"Main thread method or function called on non-main thread"];
                                    [r24 release];
                            }
                            r0 = [r21 objectForKey:**_NSKeyValueChangeNewKey];
                            r0 = [r0 retain];
                            r23 = r0;
                            var_1A0 = q0;
                            var_190 = q0;
                            r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_d8 count:0x10];
                            if (r0 != 0x0) {
                                    r24 = r0;
                                    r26 = *var_190;
                                    do {
                                            r27 = 0x0;
                                            do {
                                                    if (*var_190 != r26) {
                                                            objc_enumerationMutation(r23);
                                                    }
                                                    r25 = *(var_198 + r27 * 0x8);
                                                    [r25 loadApplicationInfo];
                                                    [r22 trackBottle:r25];
                                                    r27 = r27 + 0x1;
                                            } while (r24 != r27);
                                            r0 = [r23 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_d8 count:0x10];
                                            r24 = r0;
                                    } while (r0 != 0x0);
                            }
                            r0 = [r21 objectForKey:**_NSKeyValueChangeOldKey];
                            r0 = [r0 retain];
                            r24 = r0;
                            var_1E0 = q0;
                            var_1D0 = q0;
                            r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_158 count:0x10];
                            if (r0 != 0x0) {
                                    r25 = r0;
                                    r26 = *var_1D0;
                                    do {
                                            r27 = 0x0;
                                            do {
                                                    if (*var_1D0 != r26) {
                                                            objc_enumerationMutation(r24);
                                                    }
                                                    [r22 stopTrackingBottle:*(var_1D8 + r27 * 0x8)];
                                                    r27 = r27 + 0x1;
                                            } while (r25 != r27);
                                            r0 = [r24 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_158 count:0x10];
                                            r25 = r0;
                                    } while (r0 != 0x0);
                            }
                            [r24 release];
                            [r23 release];
                            [r21 release];
                            [r20 release];
                            [r19 release];
                            if (**___stack_chk_guard != var_58) {
                                    __stack_chk_fail();
                            }
                    }
                    else {
                            if ([r19 isEqualToString:@"canInstall"] != 0x0) {
                                    r23 = [r20 retain];
                                    r0 = [r22 installConfiguration];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r24 = [[r0 bottles] retain];
                                    [r25 release];
                                    r26 = [[r23 name] retain];
                                    r0 = [r24 objectForKey:r26];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    [r0 release];
                                    [r26 release];
                                    r0 = [r21 objectForKey:**_NSKeyValueChangeNewKey];
                                    r0 = [r0 retain];
                                    r27 = r0;
                                    r26 = [r0 boolValue];
                                    [r27 release];
                                    if (r25 == 0x0) {
                                            if (r26 != 0x0) {
                                                    [r22 addBottleToInstallTask:r23];
                                            }
                                            else {
                                                    if (r25 == 0x0) {
                                                            r8 = 0x1;
                                                    }
                                                    else {
                                                            r8 = r26;
                                                    }
                                                    if ((r8 & 0x1) == 0x0) {
                                                            [r22 removeBottleFromInstallTask:r23];
                                                    }
                                            }
                                    }
                                    else {
                                            if (r25 == 0x0) {
                                                    if (0x1 == 0x0) {
                                                            [r22 removeBottleFromInstallTask:r23];
                                                    }
                                            }
                                            else {
                                                    r8 = r26;
                                                    if ((r8 & 0x1) == 0x0) {
                                                            [r22 removeBottleFromInstallTask:r23];
                                                    }
                                            }
                                    }
                                    [r24 release];
                                    [r23 release];
                            }
                            else {
                                    if ([r19 isEqualToString:@"isInstalledPackagesReady"] != 0x0) {
                                            [r22 bottleLoadedInfo:r20];
                                    }
                            }
                            [r21 release];
                            [r20 release];
                            [r19 release];
                            if (**___stack_chk_guard != var_58) {
                                    __stack_chk_fail();
                            }
                    }
            }
    }
    return;


// 0x100008dd4
// -[PackageInstaller setSelectedPackage:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [arg2 retain];
    [r19 setPackage:r20];
    if (r20 != 0x0) {
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            [r0 setSelectedPackage:r20 forUser:0x1];
            [r21 release];
    }
    [r19 updateInstallationNotes];
    [r19 updateSummaryDetails];
    [r20 release];
    return;


// 0x100008e50
// -[PackageInstaller setSelectedBottle:]
    r20 = [[arg2 name] retain];
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setBottleName:r20];
    [r19 release];
    [r20 release];
    return;


// 0x100008ea8
// -[PackageInstaller setInstallerSource:]
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
            [r0 handleFailureInMethod:r21 object:r20 file:@"PackageInstaller.m" lineNumber:0xb9 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [r20 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setInstallerSource:r19 forUser:0x1];
    [r19 release];
    [r20 release];
    return;


// 0x100008f60
// -[PackageInstaller setUnknownPackage:]
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
    r19 = [arg2 retain];
    r0 = [r21 installConfiguration];
    r0 = [r0 retain];
    r22 = r0;
    r20 = [[r0 profile] retain];
    [r22 release];
    r0 = [r21 package];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r22 = r0;
            r0 = [r21 package];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 packageobject];
            r0 = [r0 retain];
            r24 = r0;
            [r0 release];
            [r23 release];
            [r22 release];
            if (r24 != r20) {
                    [r21 setPackage:r19];
                    r22 = [[r21 installConfiguration] retain];
                    r23 = [[r21 package] retain];
                    [r22 setSelectedPackage:r23 forUser:0x1];
                    [r23 release];
                    [r22 release];
                    r0 = [r21 installConfiguration];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 setNewBottleName:@""];
                    [r21 release];
                    [r20 release];
                    [r19 release];
            }
            else {
                    [r20 release];
                    [r19 release];
            }
    }
    else {
            [r21 setPackage:r19];
            r22 = [[r21 installConfiguration] retain];
            r23 = [[r21 package] retain];
            [r22 setSelectedPackage:r23 forUser:0x1];
            [r23 release];
            [r22 release];
            r0 = [r21 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            [r0 setNewBottleName:@""];
            [r21 release];
            [r20 release];
            [r19 release];
    }
    return;


// 0x1000090a4
// -[PackageInstaller isUnknownPackage]
    r0 = [self package];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 packageid];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isEqualToString:@"com.codeweavers.unknown"];
    [r20 release];
    [r19 release];
    r0 = r21;
    return r0;


// 0x100009108
// +[PackageInstaller keyPathsForValuesAffectingIsUnknownPackage]
    r0 = [NSSet setWithObject:@"package"];
    return r0;


// 0x10000911c
// -[PackageInstaller install]
    r31 = r31 - 0x60;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 hasBottle];
    [r20 release];
    if ((r21 & 0x1) != 0x0) {
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 hasInstallerSource];
            [r20 release];
            r0 = r19;
            if ((r21 & 0x1) != 0x0) {
                    [r0 startInstallation];
            }
            else {
                    [r0 selectInstaller:0x0];
            }
    }
    else {
            var_48 = *__NSConcreteStackBlock;
            [r19 selectBottleWithCompletion:&var_48];
    }
    return;


// 0x100009270
// -[PackageInstaller cancel]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([self status] == 0x1 && ([r19 cancelled] & 0x1) == 0x0) {
            [r19 setCancelled:0x1];
            [r19 continueInstallation];
    }
    return;


// 0x1000092c0
// -[PackageInstaller startInstallation]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = _cmd;
    r19 = self;
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r21 = r0;
            [r0 handleFailureInMethod:r20 object:r19 file:@"PackageInstaller.m" lineNumber:0xf0 description:@"Main thread method or function called on non-main thread"];
            [r21 release];
    }
    [r19 setCancelled:0x0];
    r20 = [[NSOperationQueue alloc] init];
    [r19 setInstallQueue:r20];
    [r20 release];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 newInstallEngine];
    [r19 setInstallEngine:r21];
    [r21 release];
    [r20 release];
    [r19 setInstallStepsCancelled:0x0];
    [r19 setInstallStepsCompleted:0x0];
    [r19 setInstallStepsSkipped:0x0];
    r0 = [r19 installEngine];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 sortedTasks];
    r0 = [r0 retain];
    r21 = r0;
    [r19 setTotalInstallSteps:[r0 count]];
    [r21 release];
    [r20 release];
    r20 = [[NSAttributedString alloc] initWithString:@""];
    [r19 setCompletionNotes:r20];
    [r20 release];
    [r19 startDownloadProgressTimer];
    [r19 setStatus:0x1];
    r0 = [r19 delegate];
    r0 = [r0 retain];
    r20 = r0;
    [r0 installationStarted];
    [r20 release];
    [r19 spoolAvailableTasks];
    return;


// 0x100009474
// -[PackageInstaller selectInstaller:]
    r31 = r31 - 0x100;
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
    r21 = _cmd;
    r19 = self;
    var_48 = **___stack_chk_guard;
    r20 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r19 file:@"PackageInstaller.m" lineNumber:0x106 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [NSOpenPanel openPanel];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setCanChooseFiles:0x1];
    [r21 setCanChooseDirectories:0x1];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r24 = [[r0 localizedStringForKey:@"Please choose a Windows installer file or a directory that will be treated as an installation volume" value:@"" table:0x0] retain];
    [r21 setMessage:r24];
    [r24 release];
    [r22 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 localizedStringForKey:@"Choose installer" value:@"" table:0x0] retain];
    [r21 setPrompt:r23];
    [r23 release];
    [r22 release];
    var_B8 = @"exe";
    r0 = [NSArray arrayWithObjects:&var_B8 count:0xe];
    r22 = [r0 retain];
    [r21 setAllowedFileTypes:r22];
    [r22 release];
    r0 = [r19 delegate];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 window] retain];
    var_F0 = *__NSConcreteStackBlock;
    var_C0 = r20;
    r19 = [r20 retain];
    r0 = [r21 retain];
    r20 = r0;
    [r0 beginSheetModalForWindow:r23 completionHandler:&var_F0];
    [r23 release];
    [r22 release];
    [var_C0 release];
    [r21 release];
    [r19 release];
    [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100009894
// -[PackageInstaller selectBottleWithCompletion:]
    r31 = r31 - 0x70;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
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
            [r0 handleFailureInMethod:r21 object:r20 file:@"PackageInstaller.m" lineNumber:0x11e description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r21 = [SelectBottleSheetController alloc];
    r22 = [[r20 installConfiguration] retain];
    r21 = [r21 initWithInstallConfiguration:r22];
    [r22 release];
    r0 = [r20 delegate];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 window] retain];
    r23 = [[r21 window] retain];
    var_58 = *__NSConcreteStackBlock;
    var_38 = r19;
    r19 = [r19 retain];
    [r22 beginSheet:r23 completionHandler:&var_58];
    [r23 release];
    [r22 release];
    [r20 release];
    [var_38 release];
    [r19 release];
    [r21 release];
    return;


// 0x100009a40
// -[PackageInstaller installOptions]
    r20 = [InstallOptionsSheetController alloc];
    r21 = [[self installConfiguration] retain];
    r20 = [r20 initWithInstallConfiguration:r21];
    [r21 release];
    r0 = [self delegate];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 window] retain];
    r22 = [[r20 window] retain];
    [r21 beginSheet:r22 completionHandler:0x0];
    [r22 release];
    [r21 release];
    [r19 release];
    [r20 release];
    return;


// 0x100009b04
// -[PackageInstaller queueInstallOperationWithTaskStatus:]
    r21 = [arg2 retain];
    r20 = [[InstallationOperation alloc] initWithTaskStatus:r21 completionSelector:@selector(taskCompleted:) andTarget:self];
    [r21 setInstallOp:r20];
    [r21 release];
    r0 = [self installQueue];
    r0 = [r0 retain];
    r19 = r0;
    [r0 addOperation:r20];
    [r19 release];
    [r20 release];
    return;


// 0x100009b98
// -[PackageInstaller addTaskToQueue:]
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
    r0 = [r20 installEngine];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 schedule:r19];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 boolValue];
    [r22 release];
    [r21 release];
    if (r23 != 0x0) {
            r21 = [[TaskStatus alloc] initWithTask:r19];
            r0 = [r20 currentTasks];
            r0 = [r0 retain];
            r22 = r0;
            [r0 addObject:r21];
            [r22 release];
            [r20 queueInstallOperationWithTaskStatus:r21];
            [r21 release];
    }
    [r19 release];
    return;


// 0x100009c68
// -[PackageInstaller visibleTask]
    r31 = r31 - 0x120;
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
    var_48 = **___stack_chk_guard;
    var_110 = q0;
    var_100 = q0;
    r0 = [self currentTasks];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    r20 = r0;
    if (r0 != 0x0) {
            r24 = *var_100;
            while (true) {
                    r25 = 0x0;
                    while (true) {
                            if (*var_100 != r24) {
                                    objc_enumerationMutation(r19);
                            }
                            r21 = *(var_108 + r25 * 0x8);
                            r0 = [r21 label];
                            r0 = [r0 retain];
                            r22 = r0;
                            r23 = [r0 length];
                            [r22 release];
                            if (r23 == 0x0) {
                                    r25 = r25 + 0x1;
                                    if (r20 != r25) {
                                            continue;
                                    }
                                    temp_0 = 0x0;
                                    break;
                            }
                            if ([r21 finished] == 0x0) {
                                    r20 = [r21 retain];
                                    temp_0 = 0x1;
                                    break;
                            }
                            r25 = r25 + 0x1;
                            if (r20 != r25) {
                                    continue;
                            }
                            temp_0 = 0x0;
                            break;
                    }
                    if (temp_0 == 0x0) {
                            r0 = [r19 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                            r20 = r0;
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
    r0 = [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    r0 = [r20 autorelease];
    return r0;


// 0x100009da4
// -[PackageInstaller currentTaskDescription]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self visibleTask];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r20 = [[r19 label] retain];
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 localizedStringForKey:@"In Process…" value:@"" table:0x0] retain];
            [r21 release];
    }
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100009e40
// -[PackageInstaller startDownloadProgressTimer]
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_downloadUpdateTimer));
    if (*(r0 + r20) == 0x0) {
            r19 = r0;
            r0 = [NSTimer scheduledTimerWithTimeInterval:s0 target:r19 selector:@selector(updateDownloadProgress:) userInfo:0x0 repeats:0x1];
            r0 = [r0 retain];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
    }
    return;


// 0x100009eb0
// -[PackageInstaller stopDownloadProgressTimer]
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_downloadUpdateTimer));
    [*(self + r20) invalidate];
    r0 = *(self + r20);
    *(self + r20) = 0x0;
    [r0 release];
    return;


// 0x100009ee4
// -[PackageInstaller updateDownloadProgress:]
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
    r21 = self;
    r0 = [self visibleTask];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 task];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0) {
            r0 = [r20 valueForKey:@"download_task"];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [r0 boolValue];
            [r22 release];
            if ((r23 & 0x1) != 0x0) {
                    r0 = [r20 valueForKey:@"size"];
                    r0 = [r0 retain];
                    r23 = r0;
                    r22 = [r0 longLongValue];
                    [r23 release];
                    r0 = [r20 valueForKey:@"downloaded"];
                    r0 = [r0 retain];
                    r24 = r0;
                    r23 = [r0 longLongValue];
                    [r24 release];
                    if (r22 >= 0x1) {
                            if (r23 > 0x0) {
                                    if (*_updateDownloadProgress:.formatter == 0x0) {
                                            r0 = [[NSByteCountFormatter alloc] init];
                                            r8 = *_updateDownloadProgress:.formatter;
                                            *_updateDownloadProgress:.formatter = r0;
                                            [r8 release];
                                            [*_updateDownloadProgress:.formatter setZeroPadsFractionDigits:0x1];
                                            [*_updateDownloadProgress:.formatter setFormattingContext:0x1];
                                    }
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r26 = [[r0 localizedStringForKey:@"%1$@ / %2$@" value:@"" table:0x0] retain];
                                    r23 = [[*_updateDownloadProgress:.formatter stringFromByteCount:r23] retain];
                                    r22 = [[*_updateDownloadProgress:.formatter stringFromByteCount:r22] retain];
                                    r24 = [[NSString stringWithFormat:r26] retain];
                                    [r21 setCurrentTaskDownloadDescription:r24];
                                    [r24 release];
                                    [r22 release];
                                    [r23 release];
                                    [r26 release];
                                    [r25 release];
                            }
                            else {
                                    [r21 setCurrentTaskDownloadDescription:0x0];
                            }
                    }
                    else {
                            [r21 setCurrentTaskDownloadDescription:0x0];
                    }
            }
            else {
                    [r21 setCurrentTaskDownloadDescription:0x0];
            }
    }
    else {
            [r21 setCurrentTaskDownloadDescription:0x0];
    }
    [r20 release];
    [r19 release];
    return;


// 0x10000a104
// -[PackageInstaller spoolAvailableTasks]
    r31 = r31 - 0x110;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    var_38 = **___stack_chk_guard;
    r0 = [self failedTasks];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [r0 count];
    [r19 release];
    if (r21 != 0x0) {
            if (**___stack_chk_guard != var_38) {
                    __stack_chk_fail();
            }
            [r20 displayNextFailureMessage];
    }
    else {
            r0 = [r20 installEngine];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 sortedRunnable] retain];
            [r19 release];
            [r20 willChangeValueForKey:@"currentTaskDescription"];
            var_100 = q0;
            var_F0 = q0;
            r0 = [r21 retain];
            r19 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
            if (r0 != 0x0) {
                    r21 = r0;
                    r22 = *var_F0;
                    do {
                            r23 = 0x0;
                            do {
                                    if (*var_F0 != r22) {
                                            objc_enumerationMutation(r19);
                                    }
                                    [r20 addTaskToQueue:*(var_F8 + r23 * 0x8)];
                                    r23 = r23 + 0x1;
                            } while (r21 != r23);
                            r0 = [r19 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                            r21 = r0;
                    } while (r0 != 0x0);
            }
            [r19 release];
            [r20 didChangeValueForKey:@"currentTaskDescription"];
            r21 = [[r20 bottleCollection] retain];
            r0 = [r20 installConfiguration];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 bottleName] retain];
            r20 = [[r21 bottleWithName:r23] retain];
            [r23 release];
            [r22 release];
            [r21 release];
            if (r20 != 0x0) {
                    r21 = [[[CXSetupLib cxSetupClass] bottleStatus:@"INSTALLING"] retain];
                    [r20 addStatusOverride:r21];
                    [r21 release];
            }
            [r20 release];
            [r19 release];
            if (**___stack_chk_guard != var_38) {
                    __stack_chk_fail();
            }
    }
    return;


// 0x10000a350
// -[PackageInstaller taskCompleted:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = _cmd;
    r19 = self;
    r20 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r19 file:@"PackageInstaller.m" lineNumber:0x1a8 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [r20 installOp];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 isCancelled];
    [r21 release];
    if ((r22 & 0x1) == 0x0) {
            if ([r20 success] != 0x0) {
                    [r20 done];
                    r0 = [r19 currentTasks];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 removeObject:r20];
                    [r21 release];
                    [r19 setInstallStepsCompleted:[r19 installStepsCompleted] + 0x1];
            }
            else {
                    r0 = [r19 failedTasks];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 addObject:r20];
                    [r21 release];
            }
            [r19 continueInstallation];
    }
    [r20 release];
    return;


// 0x10000a480
// -[PackageInstaller addBottleToInstallTask:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = _cmd;
    r20 = self;
    r19 = [arg2 retain];
    if ([r20 status] == 0x0) {
            if (([NSThread isMainThread] & 0x1) == 0x0) {
                    r0 = [NSAssertionHandler currentHandler];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 handleFailureInMethod:r21 object:r20 file:@"PackageInstaller.m" lineNumber:0x1c5 description:@"Main thread method or function called on non-main thread"];
                    [r22 release];
            }
            r0 = [r20 installConfiguration];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 bottles] retain];
            [r22 release];
            r22 = [[r19 name] retain];
            r0 = [r21 objectForKey:r22];
            r0 = [r0 retain];
            r23 = r0;
            [r0 release];
            [r22 release];
            if (r23 == 0x0) {
                    r0 = [r20 installConfiguration];
                    r0 = [r0 retain];
                    r22 = r0;
                    objc_unsafeClaimAutoreleasedReturnValue([r0 addBottle:r19]);
                    [r22 release];
                    if ([r19 isIsInstalledPackagesReady] != 0x0) {
                            r0 = [r20 installConfiguration];
                            r0 = [r0 retain];
                            r20 = r0;
                            [r0 installedApplicationsReady:r19];
                            [r20 release];
                    }
            }
            [r21 release];
    }
    [r19 release];
    return;


// 0x10000a5ec
// -[PackageInstaller removeBottleFromInstallTask:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = _cmd;
    r20 = self;
    r19 = [arg2 retain];
    if ([r20 status] == 0x0) {
            if (([NSThread isMainThread] & 0x1) == 0x0) {
                    r0 = [NSAssertionHandler currentHandler];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 handleFailureInMethod:r21 object:r20 file:@"PackageInstaller.m" lineNumber:0x1d5 description:@"Main thread method or function called on non-main thread"];
                    [r22 release];
            }
            r0 = [r20 installConfiguration];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 bottles] retain];
            [r22 release];
            r22 = [[r19 name] retain];
            r0 = [r21 objectForKey:r22];
            r0 = [r0 retain];
            r23 = r0;
            [r0 release];
            [r22 release];
            if (r23 != 0x0) {
                    r0 = [r20 installConfiguration];
                    r0 = [r0 retain];
                    r20 = r0;
                    [r0 removeBottle:r19];
                    [r20 release];
            }
            [r21 release];
    }
    [r19 release];
    return;


// 0x10000a720
// -[PackageInstaller trackBottle:]
    r0 = [arg2 retain];
    r20 = r0;
    [r0 addObserver:self forKeyPath:@"canInstall" options:0x7 context:_PackageInstallerKVOContext];
    [r20 addObserver:self forKeyPath:@"isInstalledPackagesReady" options:0x0 context:_PackageInstallerKVOContext];
    [r20 release];
    return;


// 0x10000a790
// -[PackageInstaller stopTrackingBottle:]
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
    [r0 removeObserver:r20 forKeyPath:@"canInstall" context:_PackageInstallerKVOContext];
    [r19 removeObserver:r20 forKeyPath:@"isInstalledPackagesReady" context:_PackageInstallerKVOContext];
    if ([r19 isCanInstall] != 0x0) {
            [r20 removeBottleFromInstallTask:r19];
    }
    [r19 release];
    return;


// 0x10000a810
// -[PackageInstaller bottleLoadedInfo:]
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
    if ([r20 status] == 0x0) {
            if (([NSThread isMainThread] & 0x1) == 0x0) {
                    r0 = [NSAssertionHandler currentHandler];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 handleFailureInMethod:r21 object:r20 file:@"PackageInstaller.m" lineNumber:0x1f5 description:@"Main thread method or function called on non-main thread"];
                    [r22 release];
            }
            if ([r19 isIsInstalledPackagesReady] != 0x0) {
                    r0 = [r20 installConfiguration];
                    r0 = [r0 retain];
                    r20 = r0;
                    [r0 installedApplicationsReady:r19];
                    [r20 release];
            }
    }
    [r19 release];
    return;


// 0x10000a8d8
// -[PackageInstaller continueInstallation]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self installEngine];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 allDone];
    r0 = [r0 retain];
    r21 = r0;
    if (([r0 boolValue] & 0x1) != 0x0) {
            [r21 release];
            [r20 release];
            [r19 installationOver];
    }
    else {
            r22 = [r19 cancelled];
            [r21 release];
            [r20 release];
            if ((r22 & 0x1) != 0x0) {
                    [r19 installationOver];
            }
            else {
                    [r19 spoolAvailableTasks];
            }
    }
    return;


// 0x10000a970
// -[PackageInstaller cancelTask:]
    r0 = [arg2 retain];
    r20 = r0;
    [r0 cancel];
    r0 = [self currentTasks];
    r0 = [r0 retain];
    r21 = r0;
    [r0 removeObject:r20];
    [r21 release];
    r0 = [self failedTasks];
    r0 = [r0 retain];
    r19 = r0;
    [r0 removeObject:r20];
    [r20 release];
    [r19 release];
    return;


// 0x10000a9f0
// -[PackageInstaller installationOver]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = _cmd;
    r19 = self;
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r21 = r0;
            [r0 handleFailureInMethod:r20 object:r19 file:@"PackageInstaller.m" lineNumber:0x20d description:@"Main thread method or function called on non-main thread"];
            [r21 release];
    }
    [r19 stopDownloadProgressTimer];
    r0 = [r19 installQueue];
    r0 = [r0 retain];
    r20 = r0;
    [r0 cancelAllOperations];
    while (true) {
            [r20 release];
            r0 = [r19 currentTasks];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 count];
            [r20 release];
            if (r21 == 0x0) {
                    break;
            }
            r0 = [r19 currentTasks];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 objectAtIndex:0x0] retain];
            [r19 cancelTask:r21];
            [r21 release];
    }
    while (true) {
            r0 = [r19 failedTasks];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 count];
            [r20 release];
            r0 = r19;
            if (r21 == 0x0) {
                    break;
            }
            r0 = [r0 failedTasks];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 objectAtIndex:0x0] retain];
            [r19 cancelTask:r21];
            [r21 release];
            [r20 release];
    }
    r0 = [r0 installEngine];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 allDone];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 boolValue];
    [r21 release];
    [r20 release];
    if ((r22 & 0x1) == 0x0) {
            do {
                    r0 = [r19 installEngine];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [[r0 sortedRunnable] retain];
                    [r21 release];
                    [r22 makeObjectsPerformSelector:@selector(done)];
                    [r22 release];
                    r0 = [r19 installEngine];
                    r0 = [r0 retain];
                    r21 = r0;
                    r0 = [r0 allDone];
                    r0 = [r0 retain];
                    r22 = r0;
                    r23 = [r0 boolValue];
                    [r22 release];
                    [r21 release];
            } while (r23 == 0x0);
    }
    [r19 updateCompletionNotes];
    r21 = [[r19 bottleCollection] retain];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 bottleName] retain];
    r20 = [[r21 bottleWithName:r23] retain];
    [r23 release];
    [r22 release];
    [r21 release];
    if (r20 != 0x0) {
            [r20 reloadInfo];
    }
    else {
            r0 = [r19 bottleCollection];
            r0 = [r0 retain];
            r21 = r0;
            [r0 refresh];
            [r21 release];
    }
    r22 = [[r19 bottleCollection] retain];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 bottleName] retain];
    r21 = [[r22 bottleWithName:r24] retain];
    [r24 release];
    [r23 release];
    [r22 release];
    if (r21 != 0x0) {
            [r19 setBottle:r21];
            r22 = [[r19 bottle] retain];
            r23 = [[[CXSetupLib cxSetupClass] bottleStatus:@"INSTALLING"] retain];
            [r22 removeAllStatusOverrides:r23];
            [r23 release];
            [r22 release];
    }
    [r19 setTotalInstallSteps:0x0];
    if (([r19 cancelled] & 0x1) == 0x0 && [r19 installStepsCancelled] == 0x0) {
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r23 = r0;
            r22 = [[r0 postInstallURL] retain];
            [r23 release];
            if ([r22 length] != 0x0) {
                    r0 = [NSURL URLWithString:r22];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r23 = r0;
                            r0 = [NSWorkspace sharedWorkspace];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 openURL:r23];
                            [r24 release];
                            [r23 release];
                    }
            }
            [r22 release];
    }
    if ([r19 cancelled] != 0x0) {
            [r19 setStatus:0x0];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r22 = r0;
            [r0 triggerBottleAnalysis];
            [r22 release];
    }
    else {
            [r19 setStatus:0x2];
    }
    [r19 updateInstallationNotes];
    [r19 updateSummaryDetails];
    r0 = [r19 delegate];
    r0 = [r0 retain];
    r19 = r0;
    [r0 installationCompleted];
    [r19 release];
    [r21 release];
    [r20 release];
    return;


// 0x10000aed8
// -[PackageInstaller addMountedVolumes]
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
    r0 = [NSWorkspace sharedWorkspace];
    r0 = [r0 retain];
    var_128 = r0;
    r0 = [r0 notificationCenter];
    r0 = [r0 retain];
    r21 = r0;
    [r0 addObserver:r20 selector:@selector(observeMount:) name:**_NSWorkspaceDidMountNotification object:0x0];
    [r21 addObserver:r20 selector:@selector(observeUnmount:) name:**_NSWorkspaceDidUnmountNotification object:0x0];
    var_120 = q0;
    var_110 = q0;
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [[r0 mountedVolumeURLsIncludingResourceValuesForKeys:0x0 options:0x2] retain];
    [r23 release];
    r0 = [r22 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r27 = *var_110;
            do {
                    r19 = 0x0;
                    do {
                            if (*var_110 != r27) {
                                    objc_enumerationMutation(r22);
                            }
                            r24 = [[*(var_118 + r19 * 0x8) path] retain];
                            if ([CDTools isValidInstallerVolume:r24 requireRemovable:0x1] != 0x0) {
                                    r0 = [r20 installConfiguration];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    [r0 addSourceMedia:r24];
                                    [r25 release];
                                    r0 = [r20 installConfiguration];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r26 = [r0 volumeMatchesProfile:r24];
                                    [r25 release];
                                    if (r26 != 0x0) {
                                            r0 = [r20 installConfiguration];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            [r0 setInstallerSource:r24 forUser:0x0];
                                            [r25 release];
                                    }
                            }
                            [r24 release];
                            r19 = r19 + 0x1;
                    } while (r23 != r19);
                    r0 = [r22 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r22 release];
    [r21 release];
    [var_128 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10000b128
// -[PackageInstaller observeMount:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 userInfo];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 objectForKey:@"NSDevicePath"] retain];
    [r21 release];
    if ([CDTools isValidInstallerVolume:r19 requireRemovable:0x1] != 0x0) {
            r0 = [r20 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            [r0 addSourceMedia:r19];
            [r21 release];
            r0 = [r20 installConfiguration];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setInstallerSource:r19 forUser:0x0];
            [r20 release];
    }
    [r19 release];
    return;


// 0x10000b1e8
// -[PackageInstaller observeUnmount:]
    r0 = [arg2 userInfo];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 objectForKey:@"NSDevicePath"] retain];
    [r20 release];
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r19 = r0;
    [r0 removeSourceMedia:r21];
    [r19 release];
    [r21 release];
    return;


// 0x10000b268
// -[PackageInstaller autoPlayWithParsedAutorunFile:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = _cmd;
    r19 = self;
    r20 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r19 file:@"PackageInstaller.m" lineNumber:0x274 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    [r0 useAutorunFile:r20];
    [r20 release];
    [r21 release];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r19 = r0;
    [r0 autoFillSettings];
    [r19 release];
    return;


// 0x10000b33c
// -[PackageInstaller updateProfiles]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([self status] == 0x0) {
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r19 = r0;
            [r0 updateProfiles];
            [r19 release];
    }
    return;


// 0x10000b388
// -[PackageInstaller updateInstallationNotes]
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
    if ([self status] != 0x1) {
            r20 = [[NSMutableAttributedString alloc] init];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 hasPackage];
            [r21 release];
            if (r22 != 0x0) {
                    r0 = [r19 installConfiguration];
                    r0 = [r0 retain];
                    r22 = r0;
                    r21 = [[r0 installationNotes] retain];
                    [r22 release];
                    if ([r21 length] != 0x0) {
                            [NSFont systemFontSizeForControlSize:0x0];
                            r22 = [[NSFont systemFontOfSize:r2] retain];
                            r23 = [[NSAttributedString cx_attributedStringWithHTML:r21 font:r22] retain];
                            [r20 appendAttributedString:r23];
                            [r23 release];
                            [r22 release];
                    }
                    [r21 release];
            }
            r21 = [[r20 string] retain];
            r0 = [r19 installationNotes];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 string];
            r0 = [r0 retain];
            r23 = r0;
            [r0 release];
            [r22 release];
            [r21 release];
            if (r21 != r23) {
                    [r19 setInstallationNotes:r20];
            }
            [r20 release];
    }
    return;


// 0x10000b514
// -[PackageInstaller detailsFromDictionary:withAction:]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x1b0;
    r20 = arg3;
    var_60 = **___stack_chk_guard;
    r21 = [arg2 retain];
    r19 = [[NSMutableArray array] retain];
    var_1A0 = q0;
    var_190 = q0;
    r0 = [r21 retain];
    var_1F0 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
    var_1F8 = r0;
    if (r0 != 0x0) {
            var_200 = *var_190;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_190 != var_200) {
                                    objc_enumerationMutation(var_1F0);
                            }
                            var_1E8 = r22;
                            r26 = *(var_198 + r22 * 0x8);
                            var_1E0 = q0;
                            var_1D0 = q0;
                            r0 = [var_1F0 objectForKeyedSubscript:r26];
                            r0 = [r0 retain];
                            r27 = r0;
                            r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
                            if (r0 != 0x0) {
                                    r28 = r0;
                                    r25 = *var_1D0;
                                    do {
                                            r24 = 0x0;
                                            while (true) {
                                                    if (*var_1D0 != r25) {
                                                            objc_enumerationMutation(r27);
                                                    }
                                                    r22 = *(var_1D8 + r24 * 0x8);
                                                    if (([r26 isEqualToString:@"errors"] & 0x1) != 0x0) {
                                                            r22 = [[SummaryDetail detailWithType:0x0 label:r22 action:r20] retain];
                                                            [r19 addObject:r22];
                                                            [r22 release];
                                                            r24 = r24 + 0x1;
                                                            if (r28 != r24) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                                    else {
                                                            if (([r26 isEqualToString:@"warnings"] & 0x1) != 0x0) {
                                                                    r22 = [[SummaryDetail detailWithType:0x1 label:r22 action:r20] retain];
                                                                    [r19 addObject:r22];
                                                                    [r22 release];
                                                                    r24 = r24 + 0x1;
                                                                    if (r28 != r24) {
                                                                            continue;
                                                                    }
                                                                    break;
                                                            }
                                                            else {
                                                                    if ([r26 isEqualToString:@"notes"] != 0x0) {
                                                                            r22 = [[SummaryDetail detailWithType:0x2 label:r22 action:r20] retain];
                                                                            [r19 addObject:r22];
                                                                            [r22 release];
                                                                            r24 = r24 + 0x1;
                                                                            if (r28 != r24) {
                                                                                    continue;
                                                                            }
                                                                            break;
                                                                    }
                                                                    else {
                                                                            r24 = r24 + 0x1;
                                                                            if (r28 != r24) {
                                                                                    continue;
                                                                            }
                                                                            break;
                                                                    }
                                                            }
                                                    }
                                            }
                                            r0 = [r27 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
                                            r28 = r0;
                                    } while (r0 != 0x0);
                            }
                            [r27 release];
                            r22 = var_1E8 + 0x1;
                    } while (r22 != var_1F8);
                    r0 = [var_1F0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
                    var_1F8 = r0;
            } while (r0 != 0x0);
    }
    [var_1F0 release];
    r0 = [var_1F0 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x10000b778
// -[PackageInstaller detailsFromDictionary:]
    r0 = [self detailsFromDictionary:arg2 withAction:0x0];
    return r0;


// 0x10000b780
// -[PackageInstaller updateSummaryDetails]
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
    r19 = self;
    var_60 = **___stack_chk_guard;
    if ([self status] != 0x1) {
            r20 = [[NSMutableArray array] retain];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 miscDetails] retain];
            r23 = [[r19 detailsFromDictionary:r22] retain];
            [r20 addObjectsFromArray:r23];
            [r23 release];
            [r22 release];
            [r21 release];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 installerDetails] retain];
            r23 = [[r19 detailsFromDictionary:r22 withAction:@selector(editInstallerSource:)] retain];
            [r20 addObjectsFromArray:r23];
            [r23 release];
            [r22 release];
            [r21 release];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 bottleDetails] retain];
            r23 = [[r19 detailsFromDictionary:r22 withAction:@selector(selectBottle:)] retain];
            [r20 addObjectsFromArray:r23];
            [r23 release];
            [r22 release];
            [r21 release];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 languageDetails] retain];
            r23 = [[r19 detailsFromDictionary:r22 withAction:@selector(installOptions:)] retain];
            [r20 addObjectsFromArray:r23];
            [r23 release];
            [r22 release];
            [r21 release];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 dependencyDetails] retain];
            var_128 = r19;
            r23 = [[r19 detailsFromDictionary:r22] retain];
            [r20 addObjectsFromArray:r23];
            [r23 release];
            [r22 release];
            [r21 release];
            var_120 = q0;
            var_110 = q0;
            r0 = [r20 retain];
            r20 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
            if (r0 != 0x0) {
                    r22 = r0;
                    r27 = *var_110;
                    do {
                            r19 = 0x0;
                            do {
                                    if (*var_110 != r27) {
                                            objc_enumerationMutation(r20);
                                    }
                                    r25 = *(var_118 + r19 * 0x8);
                                    if ([r25 type] != 0x0) {
                                            if ([r25 type] == 0x1) {
                                                    r2 = @"sf-symbols.exclamationmark.circle.fill";
                                            }
                                            else {
                                                    r2 = @"sf-symbols.checkmark.circle";
                                            }
                                    }
                                    else {
                                            r2 = @"sf-symbols.xmark.octagon.fill";
                                    }
                                    r26 = [[NSImage imageNamed:r2] retain];
                                    [r25 setImage:r26];
                                    [r26 release];
                                    r19 = r19 + 0x1;
                            } while (r22 != r19);
                            r0 = [r20 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                            r22 = r0;
                    } while (r0 != 0x0);
            }
            [r20 release];
            [var_128 setSummaryDetails:r20];
            [r20 release];
    }
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10000bb2c
// -[PackageInstaller updateCompletionNotes]
    r31 = r31 - 0x70;
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
    r0 = [self package];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 softwarePackage] retain];
    [r21 release];
    if ([r20 cancelled] != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 localizedStringForKey:@"The installation was canceled." value:@"" table:0x0] retain];
    }
    else {
            if ([r20 installStepsCancelled] != 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r22 = r0;
                    r21 = [[r0 localizedStringForKey:@"The installation failed." value:@"" table:0x0] retain];
            }
            else {
                    r0 = [r20 installConfiguration];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [r0 installWithSteam];
                    [r21 release];
                    if (r22 != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r21 = r0;
                            r23 = [[r0 localizedStringForKey:@"%@ has configured the bottle '%@' for installing %@ via Steam. You will need to finish the installation in Steam." value:@"" table:0x0] retain];
                            [r21 release];
                            r22 = [[r20->_installConfiguration bottleName] retain];
                            r21 = [[NSString stringWithFormat:r23] retain];
                            [r23 release];
                    }
                    else {
                            r21 = [r20 installStepsSkipped];
                            r22 = [[NSBundle mainBundle] retain];
                            if (r21 != 0x0) {
                                    r2 = @"The installation is complete, but some tasks were skipped.";
                            }
                            else {
                                    r2 = @"The installation is complete.";
                            }
                            r0 = r22;
                            r21 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                    }
            }
    }
    [r22 release];
    r0 = [NSMutableString string];
    r0 = [r0 retain];
    r22 = r0;
    [r0 appendString:r21];
    r0 = r20->_installEngine;
    r0 = [r0 valueForKey:@"logfile"];
    r0 = [r0 retain];
    r23 = r0;
    if (r0 != 0x0) {
            r24 = [[NSURL fileURLWithPath:r23] retain];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 localizedStringForKey:@"More diagnostic information can be found in the <a href = \"%@\">debug log</a>." value:@"" table:0x0] retain];
            [r25 release];
            [r22 appendString:@" "];
            r25 = [[r24 absoluteString] retain];
            [r22 appendFormat:r26];
            [r25 release];
            [r26 release];
            [r24 release];
    }
    r24 = [[NSAttributedString cx_attributedStringWithHTML:r22] retain];
    [r20 setCompletionNotes:r24];
    [r24 release];
    [r23 release];
    [r22 release];
    [r21 release];
    [r19 release];
    return;


// 0x10000be60
// -[PackageInstaller displayNextFailureMessage]
    r31 = r31 - 0xd0;
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
    r20 = _cmd;
    r19 = self;
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r21 = r0;
            [r0 handleFailureInMethod:r20 object:r19 file:@"PackageInstaller.m" lineNumber:0x2f8 description:@"Main thread method or function called on non-main thread"];
            [r21 release];
    }
    r0 = [r19 delegate];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 window];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 attachedSheet];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    [r21 release];
    [r20 release];
    if (r22 == 0x0) {
            r0 = [r19 failedTasks];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 count];
            [r20 release];
            if (r21 != 0x0) {
                    r0 = [r19 failedTasks];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 objectAtIndex:0x0] retain];
                    [r20 release];
                    [r21 setInstallOp:0x0];
                    r0 = [r19 failedTasks];
                    r0 = [r0 retain];
                    r20 = r0;
                    [r0 removeObject:r21];
                    [r20 release];
                    r22 = [[r21 task] retain];
                    r20 = [[r21 label] retain];
                    r0 = [r22 valueForKey:@"needs_download"];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [r0 boolValue];
                    [r23 release];
                    if (r24 != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r24 = r0;
                            r25 = [[r0 localizedStringForKey:@"Could not download the '%@' installer." value:@"" table:0x0] retain];
                            r26 = [[r22 valueForKeyPath:@"aiecore.name"] retain];
                            r23 = [[NSString stringWithFormat:r25] retain];
                            [r26 release];
                            [r25 release];
                            r27 = 0x1;
                    }
                    else {
                            if ([r20 length] != 0x0) {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    r25 = [[r0 localizedStringForKey:@"The '%@' task failed." value:@"" table:0x0] retain];
                                    r23 = [[NSString stringWithFormat:r25] retain];
                                    [r25 release];
                            }
                            else {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    r23 = [[r0 localizedStringForKey:@"An unknown installer task failed." value:@"" table:0x0] retain];
                            }
                            r27 = 0x0;
                    }
                    [r24 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r24 = r0;
                    r25 = [[r0 localizedStringForKey:@"Continuing with the install may produce unpredictable results." value:@"" table:0x0] retain];
                    [r24 release];
                    r0 = [r22 valueForKey:@"error"];
                    r0 = [r0 retain];
                    r24 = r0;
                    r0 = [r0 length];
                    var_A8 = r24;
                    if (r0 != 0x0) {
                            r26 = [[r24 stringByAppendingFormat:@"\n%@", @""] retain];
                            [r25 release];
                            r25 = r26;
                    }
                    var_AC = r27;
                    var_98 = r20;
                    if (r27 != 0x0) {
                            r0 = [r19 package];
                            r0 = [r0 retain];
                            r28 = r0;
                            r20 = [[r0 homePage] retain];
                            r27 = [[NSURL URLWithString:r20] retain];
                            [r20 release];
                            [r28 release];
                            r26 = [[r22 valueForKey:@"download_page_url"] retain];
                            [r27 release];
                            r27 = r26;
                            if (r27 != 0x0) {
                                    r20 = [[r25 stringByAppendingString:@"\n\n"] retain];
                                    [r25 release];
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r28 = [[r0 localizedStringForKey:@"If you have a working internet connection via your browser, you can download this file here:" value:@"" table:0x0] retain];
                                    r25 = [[r20 stringByAppendingString:r28] retain];
                                    [r20 release];
                                    [r28 release];
                                    [r26 release];
                                    r20 = [[NSString stringWithFormat:@"<a href = \"%@\">%@</a>", r3, r4] retain];
                                    r28 = [[NSAttributedString cx_attributedStringWithHTML:r20] retain];
                                    r26 = [[NSTextField labelWithAttributedString:r28] retain];
                                    [r28 release];
                                    [r26 setAllowsEditingTextAttributes:0x1];
                                    [r26 setSelectable:0x1];
                                    [r20 release];
                            }
                            else {
                                    r26 = 0x0;
                            }
                            [r27 release];
                    }
                    else {
                            r26 = 0x0;
                    }
                    r0 = [r19 installQueue];
                    r0 = [r0 retain];
                    r20 = r0;
                    [r0 setSuspended:0x1];
                    [r20 release];
                    r0 = [[NSAlert alloc] init];
                    r27 = r0;
                    var_A0 = r23;
                    [r0 setMessageText:r23];
                    [r27 setInformativeText:r25];
                    if (r26 != 0x0) {
                            [r27 setAccessoryView:r26];
                    }
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r23 = [[r0 localizedStringForKey:@"Cancel Installation" value:@"" table:0x0] retain];
                    r0 = [r27 addButtonWithTitle:r23];
                    r0 = [r0 retain];
                    r24 = r0;
                    [r0 setTag:0x3e8];
                    [r24 release];
                    [r23 release];
                    [r20 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r23 = [[r0 localizedStringForKey:@"Skip This Step" value:@"" table:0x0] retain];
                    r0 = [r27 addButtonWithTitle:r23];
                    r0 = [r0 retain];
                    r24 = r0;
                    [r0 setTag:0x3e9];
                    [r24 release];
                    [r23 release];
                    [r20 release];
                    if (var_AC != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r23 = [[r0 localizedStringForKey:@"Pick Installer File" value:@"" table:0x0] retain];
                            r0 = [r27 addButtonWithTitle:r23];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 setTag:0x3ea];
                            [r24 release];
                            [r23 release];
                            [r20 release];
                    }
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r23 = [[r0 localizedStringForKey:@"Try Again" value:@"" table:0x0] retain];
                    r0 = [r27 addButtonWithTitle:r23];
                    r0 = [r0 retain];
                    r24 = r0;
                    [r0 setTag:0x3eb];
                    [r24 release];
                    [r23 release];
                    [r20 release];
                    r0 = [r19 delegate];
                    r0 = [r0 retain];
                    r20 = r0;
                    r23 = [[r0 window] retain];
                    var_90 = *__NSConcreteStackBlock;
                    var_60 = r22;
                    var_58 = r21;
                    r19 = [r21 retain];
                    r21 = [r22 retain];
                    r0 = [r27 retain];
                    r22 = r0;
                    [r0 beginSheetModalForWindow:r23 completionHandler:&var_90];
                    [r23 release];
                    [r20 release];
                    [var_58 release];
                    [var_60 release];
                    [r27 release];
                    [r19 release];
                    [r21 release];
                    [r22 release];
                    [r26 release];
                    [var_A8 release];
                    [r25 release];
                    [var_A0 release];
                    [var_98 release];
            }
    }
    return;


// 0x10000ccb4
// -[PackageInstaller profileChanged]
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
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 profile] retain];
    [r21 release];
    r0 = [r19 package];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r21 = r0;
            r0 = [r19 package];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 packageobject];
            r0 = [r0 retain];
            r23 = r0;
            [r0 release];
            [r22 release];
            [r21 release];
            if (r23 != r20) {
                    if (r20 != 0x0) {
                            r21 = [[r20 valueForKey:@"appid"] retain];
                            r22 = [[PackageTreeNode alloc] initWithProfile:r20];
                            r23 = [[NSFont labelFontOfSize:r2] retain];
                            [r22 setDescriptionFont:r23];
                            [r23 release];
                            [r19 setPackage:r22];
                            [r22 release];
                            [r21 release];
                    }
                    r21 = [[r19 installConfiguration] retain];
                    r22 = [[r19 package] retain];
                    [r21 setSelectedPackage:r22 forUser:0x0];
                    [r22 release];
                    [r21 release];
                    [r19 updateInstallationNotes];
                    [r19 updateSummaryDetails];
                    [r20 release];
            }
            else {
                    [r19 updateInstallationNotes];
                    [r19 updateSummaryDetails];
                    [r20 release];
            }
    }
    else {
            if (r20 != 0x0) {
                    r21 = [[r20 valueForKey:@"appid"] retain];
                    r22 = [[PackageTreeNode alloc] initWithProfile:r20];
                    r23 = [[NSFont labelFontOfSize:r2] retain];
                    [r22 setDescriptionFont:r23];
                    [r23 release];
                    [r19 setPackage:r22];
                    [r22 release];
                    [r21 release];
            }
            r21 = [[r19 installConfiguration] retain];
            r22 = [[r19 package] retain];
            [r21 setSelectedPackage:r22 forUser:0x0];
            [r22 release];
            [r21 release];
            [r19 updateInstallationNotes];
            [r19 updateSummaryDetails];
            [r20 release];
    }
    return;


// 0x10000ce40
// -[PackageInstaller sourceChanged]
    [self updateInstallationNotes];
    [self updateSummaryDetails];
    return;


// 0x10000ce64
// -[PackageInstaller bottleCreateChanged]
    [self updateInstallationNotes];
    [self updateSummaryDetails];
    return;


// 0x10000ce88
// -[PackageInstaller bottleNewnameChanged]
    [self updateInstallationNotes];
    [self updateSummaryDetails];
    return;


// 0x10000ceac
// -[PackageInstaller bottleTemplateChanged]
    [self updateInstallationNotes];
    [self updateSummaryDetails];
    return;


// 0x10000ced0
// -[PackageInstaller bottleNameChanged]
    [self updateInstallationNotes];
    [self updateSummaryDetails];
    return;


// 0x10000cef4
// -[PackageInstaller categorizedAllBottles]
    return;


// 0x10000cef8
// -[PackageInstaller analyzedBottle:]
    [self updateInstallationNotes];
    [self updateSummaryDetails];
    return;


// 0x10000cf1c
// -[PackageInstaller delegate]
    r0 = objc_loadWeakRetained((int64_t *)&self->_delegate);
    r0 = [r0 autorelease];
    return r0;


// 0x10000cf3c
// -[PackageInstaller setDelegate:]
    objc_storeWeak((int64_t *)&self->_delegate, arg2);
    return;


// 0x10000cf50
// -[PackageInstaller installConfiguration]
    r0 = self->_installConfiguration;
    return r0;


// 0x10000cf60
// -[PackageInstaller setInstallConfiguration:]
    objc_storeStrong((int64_t *)&self->_installConfiguration, arg2);
    return;


// 0x10000cf74
// -[PackageInstaller package]
    r0 = self->_package;
    return r0;


// 0x10000cf84
// -[PackageInstaller setPackage:]
    objc_storeStrong((int64_t *)&self->_package, arg2);
    return;


// 0x10000cf98
// -[PackageInstaller bottle]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottle);
    r0 = [r0 autorelease];
    return r0;


// 0x10000cfb8
// -[PackageInstaller setBottle:]
    objc_storeWeak((int64_t *)&self->_bottle, arg2);
    return;


// 0x10000cfcc
// -[PackageInstaller currentTaskDownloadDescription]
    r0 = self->_currentTaskDownloadDescription;
    return r0;


// 0x10000cfdc
// -[PackageInstaller setCurrentTaskDownloadDescription:]
    objc_storeStrong((int64_t *)&self->_currentTaskDownloadDescription, arg2);
    return;


// 0x10000cff0
// -[PackageInstaller installStepsCancelled]
    r0 = self->_installStepsCancelled;
    return r0;


// 0x10000d000
// -[PackageInstaller setInstallStepsCancelled:]
    self->_installStepsCancelled = arg2;
    return;


// 0x10000d010
// -[PackageInstaller installStepsCompleted]
    r0 = self->_installStepsCompleted;
    return r0;


// 0x10000d020
// -[PackageInstaller setInstallStepsCompleted:]
    self->_installStepsCompleted = arg2;
    return;


// 0x10000d030
// -[PackageInstaller installStepsSkipped]
    r0 = self->_installStepsSkipped;
    return r0;


// 0x10000d040
// -[PackageInstaller setInstallStepsSkipped:]
    self->_installStepsSkipped = arg2;
    return;


// 0x10000d050
// -[PackageInstaller totalInstallSteps]
    r0 = self->_totalInstallSteps;
    return r0;


// 0x10000d060
// -[PackageInstaller setTotalInstallSteps:]
    self->_totalInstallSteps = arg2;
    return;


// 0x10000d070
// -[PackageInstaller completionNotes]
    r0 = self->_completionNotes;
    return r0;


// 0x10000d080
// -[PackageInstaller setCompletionNotes:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10000d08c
// -[PackageInstaller installationNotes]
    r0 = self->_installationNotes;
    return r0;


// 0x10000d09c
// -[PackageInstaller setInstallationNotes:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10000d0a8
// -[PackageInstaller summaryDetails]
    r0 = self->_summaryDetails;
    return r0;


// 0x10000d0b8
// -[PackageInstaller setSummaryDetails:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10000d0c4
// -[PackageInstaller status]
    r0 = *(int32_t *)(int64_t *)&self->_status;
    return r0;


// 0x10000d0d4
// -[PackageInstaller setStatus:]
    *(int32_t *)(int64_t *)&self->_status = arg2;
    return;


// 0x10000d0e4
// -[PackageInstaller installEngine]
    r0 = self->_installEngine;
    return r0;


// 0x10000d0f4
// -[PackageInstaller setInstallEngine:]
    objc_storeStrong((int64_t *)&self->_installEngine, arg2);
    return;


// 0x10000d108
// -[PackageInstaller installQueue]
    r0 = self->_installQueue;
    return r0;


// 0x10000d118
// -[PackageInstaller setInstallQueue:]
    objc_storeStrong((int64_t *)&self->_installQueue, arg2);
    return;


// 0x10000d12c
// -[PackageInstaller currentTasks]
    r0 = self->_currentTasks;
    return r0;


// 0x10000d13c
// -[PackageInstaller setCurrentTasks:]
    objc_storeStrong((int64_t *)&self->_currentTasks, arg2);
    return;


// 0x10000d150
// -[PackageInstaller failedTasks]
    r0 = self->_failedTasks;
    return r0;


// 0x10000d160
// -[PackageInstaller setFailedTasks:]
    objc_storeStrong((int64_t *)&self->_failedTasks, arg2);
    return;


// 0x10000d174
// -[PackageInstaller cancelled]
    r0 = *(int8_t *)(int64_t *)&self->_cancelled;
    return r0;


// 0x10000d184
// -[PackageInstaller setCancelled:]
    *(int8_t *)(int64_t *)&self->_cancelled = arg2;
    return;


// 0x10000d194
// -[PackageInstaller downloadUpdateTimer]
    r0 = self->_downloadUpdateTimer;
    return r0;


// 0x10000d1a4
// -[PackageInstaller setDownloadUpdateTimer:]
    objc_storeStrong((int64_t *)&self->_downloadUpdateTimer, arg2);
    return;


// 0x10000d1b8
// -[PackageInstaller bottleCollection]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
    r0 = [r0 autorelease];
    return r0;


// 0x10000d1d8
// -[PackageInstaller .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_bottleCollection);
    objc_storeStrong((int64_t *)&self->_downloadUpdateTimer, 0x0);
    objc_storeStrong((int64_t *)&self->_failedTasks, 0x0);
    objc_storeStrong((int64_t *)&self->_currentTasks, 0x0);
    objc_storeStrong((int64_t *)&self->_installQueue, 0x0);
    objc_storeStrong((int64_t *)&self->_installEngine, 0x0);
    objc_storeStrong((int64_t *)&self->_summaryDetails, 0x0);
    objc_storeStrong((int64_t *)&self->_installationNotes, 0x0);
    objc_storeStrong((int64_t *)&self->_completionNotes, 0x0);
    objc_storeStrong((int64_t *)&self->_currentTaskDownloadDescription, 0x0);
    objc_destroyWeak((int64_t *)&self->_bottle);
    objc_storeStrong((int64_t *)&self->_package, 0x0);
    objc_storeStrong((int64_t *)&self->_installConfiguration, 0x0);
    objc_destroyWeak((int64_t *)&self->_delegate);
    return;


