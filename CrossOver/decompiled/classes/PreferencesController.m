// PreferencesController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100010cf8
// -[PreferencesController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithWindowNibName:@"Preferences"];
    return r0;


// 0x100010d34
// -[PreferencesController dealloc]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_fsEventStream));
    r0 = *(self + r20);
    if (r0 != 0x0) {
            FSEventStreamStop(r0);
            FSEventStreamInvalidate(*(r19 + r20));
            FSEventStreamRelease(*(r19 + r20));
    }
    var_20 = r19;
    [[&var_20 super] dealloc];
    return;


// 0x100010d98
// -[PreferencesController windowDidLoad]
    r31 = r31 - 0xc0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_38 = **___stack_chk_guard;
    var_60 = self;
    [[&var_60 super] windowDidLoad];
    [self updateC4PModDate];
    r0 = [CXServerCrossOver getCachesDir];
    r0 = [r0 retain];
    r21 = r0;
    var_48 = r0;
    r0 = [NSArray arrayWithObjects:&var_48 count:0x2];
    r22 = [r0 retain];
    r0 = [NSURL fileURLWithPathComponents:r22];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 copy];
    r24 = sign_extend_64(*(int32_t *)ivar_offset(_installersCache));
    r8 = *(self + r24);
    *(self + r24) = r0;
    [r8 release];
    [r20 release];
    [r22 release];
    [r21 release];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r20 = r0;
    [r0 createDirectoryAtURL:*(self + r24) withIntermediateDirectories:0x1 attributes:0x0 error:0x0];
    [r20 release];
    r0 = dispatch_queue_create("com.codeweavers.CrossOver.installer-cache-sizing", 0x0);
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_queue));
    r8 = *(self + r22);
    *(self + r22) = r0;
    [r8 release];
    r20 = *(self + r22);
    r21 = [dispatch_get_global_queue(0xfffffffffffffffe, 0x0) retain];
    dispatch_set_target_queue(r20, r21);
    [r21 release];
    var_88 = 0x0;
    r0 = *(self + r24);
    r0 = [r0 path];
    r0 = [r0 retain];
    r20 = r0;
    var_50 = r0;
    r0 = [NSArray arrayWithObjects:&var_50 count:0x1];
    r0 = FSEventStreamCreate(0x0, _InstallersCacheEventStreamCallback, &var_88, r0, 0xffffffffffffffff, 0x4, r6);
    r21 = sign_extend_64(*(int32_t *)ivar_offset(_fsEventStream));
    *(self + r21) = r0;
    [r20 release];
    FSEventStreamSetDispatchQueue(*(self + r21), *(self + r22));
    FSEventStreamStart(*(self + r21));
    r20 = [[self installerCacheSizeStringWhileCalculating] retain];
    r0 = objc_loadWeakRetained((int64_t *)&self->_installerCacheSizeLabel);
    r21 = r0;
    [r0 setStringValue:r20];
    [r21 release];
    [r20 release];
    r0 = *(self + r22);
    var_B0 = *__NSConcreteStackBlock;
    dispatch_async(r0, &var_B0);
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x100011064
// -[PreferencesController updateC4PModDate]
    r20 = [[CXServerCrossOver crossTieModDateString] retain];
    [self setLastUpdated:r20];
    [r20 release];
    return;


// 0x1000110a8
// -[PreferencesController windowWillLoad]
    var_40 = self;
    [[&var_40 super] windowWillLoad];
    r21 = [[CXServerCrossOver getBottleDir] retain];
    r20 = [[NSURL fileURLWithPath:r21] retain];
    [self setBottlesFolderURL:r20];
    [r20 release];
    [r21 release];
    r21 = [[CXServerCrossOver getProgramsFolder] retain];
    r20 = [[NSURL fileURLWithPath:r21] retain];
    [self setProgramsFolderURL:r20];
    [r20 release];
    [r21 release];
    return;


// 0x100011198
// -[PreferencesController bottlesFolderChanged:]
    r20 = [[NSUserDefaults standardUserDefaults] retain];
    r0 = [self bottlesFolderURL];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 path] retain];
    [r20 setObject:r21 forKey:@"BottleDir"];
    [r21 release];
    [r19 release];
    [r20 release];
    r0 = **_NSApp;
    r0 = [r0 CXServer];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setEnvironmentVariables];
    [r19 release];
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r19 = r0;
    [r0 reset];
    [r19 release];
    return;


// 0x100011270
// -[PreferencesController resetBottlesFolder:]
    r22 = [arg2 retain];
    r21 = [[CXServerCrossOver getDefaultBottleDir] retain];
    r20 = [[NSURL fileURLWithPath:r21] retain];
    [self setBottlesFolderURL:r20];
    [r20 release];
    [r21 release];
    [self bottlesFolderChanged:r22];
    [r22 release];
    return;


// 0x100011308
// -[PreferencesController browseForBottlesFolder:]
    r31 = r31 - 0x70;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [NSOpenPanel openPanel];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setCanChooseFiles:0x0];
    [r20 setCanChooseDirectories:0x1];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r23 = [[r0 localizedStringForKey:@"Choose a Bottles Folder" value:@"" table:0x0] retain];
    [r20 setMessage:r23];
    [r23 release];
    [r21 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"Choose" value:@"" table:0x0] retain];
    [r20 setPrompt:r22];
    [r22 release];
    [r21 release];
    [r20 setDelegate:r19];
    r0 = [r19 bottlesFolderURL];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 path] retain];
    [r22 release];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 isWritableFileAtPath:r21];
    [r22 release];
    if ((r23 & 0x1) == 0x0) {
            r22 = [[CXServerCrossOver getDefaultBottleDir] retain];
            [r21 release];
            r21 = r22;
    }
    r22 = [[NSURL fileURLWithPath:r21] retain];
    [r20 setDirectoryURL:r22];
    [r22 release];
    r22 = [[r19 window] retain];
    var_60 = *__NSConcreteStackBlock;
    r0 = [r20 retain];
    r19 = r0;
    [r0 beginSheetModalForWindow:r22 completionHandler:&var_60];
    [r22 release];
    [r20 release];
    [r19 release];
    [r21 release];
    return;


// 0x1000115a4
// -[PreferencesController programsFolderChanged:]
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
    r19 = [[NSUserDefaults standardUserDefaults] retain];
    r22 = [[NSFileManager defaultManager] retain];
    r0 = [r20 programsFolderURL];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 path] retain];
    r21 = [[r22 bookmarkDataFromPath:r24] retain];
    [r24 release];
    [r23 release];
    [r22 release];
    if (r21 != 0x0) {
            [r19 setObject:r21 forKey:@"ProgramsFolderBookmark"];
    }
    else {
            [r19 removeObjectForKey:@"ProgramsFolderBookmark"];
    }
    r0 = [r20 programsFolderURL];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 path] retain];
    [r19 setObject:r22 forKey:@"ProgramsFolderPath"];
    [r22 release];
    [r20 release];
    [r21 release];
    [r19 release];
    return;


// 0x1000116d4
// -[PreferencesController resetProgramsFolder:]
    r22 = [arg2 retain];
    r21 = [[CXServerCrossOver getDefaultProgramsFolder] retain];
    r20 = [[NSURL fileURLWithPath:r21] retain];
    [self setProgramsFolderURL:r20];
    [r20 release];
    [r21 release];
    [self programsFolderChanged:r22];
    [r22 release];
    return;


// 0x10001176c
// -[PreferencesController browseForProgramsFolder:]
    r31 = r31 - 0x70;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [NSOpenPanel openPanel];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setCanChooseFiles:0x0];
    [r20 setCanChooseDirectories:0x1];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r23 = [[r0 localizedStringForKey:@"Choose a Programs Folder" value:@"" table:0x0] retain];
    [r20 setMessage:r23];
    [r23 release];
    [r21 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"Choose" value:@"" table:0x0] retain];
    [r20 setPrompt:r22];
    [r22 release];
    [r21 release];
    [r20 setDelegate:r19];
    r0 = [r19 programsFolderURL];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 path] retain];
    [r22 release];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 isWritableFileAtPath:r21];
    [r22 release];
    if ((r23 & 0x1) == 0x0) {
            r22 = [[CXServerCrossOver getDefaultProgramsFolder] retain];
            [r21 release];
            r21 = r22;
    }
    r22 = [[NSURL fileURLWithPath:r21] retain];
    [r20 setDirectoryURL:r22];
    [r22 release];
    r22 = [[r19 window] retain];
    var_60 = *__NSConcreteStackBlock;
    r0 = [r20 retain];
    r19 = r0;
    [r0 beginSheetModalForWindow:r22 completionHandler:&var_60];
    [r22 release];
    [r20 release];
    [r19 release];
    [r21 release];
    return;


// 0x100011a08
// -[PreferencesController panel:isValidFilename:]
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
    r20 = [arg3 retain];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [r0 isWritableFileAtPath:r20];
    [r20 release];
    [r21 release];
    if ((r19 & 0x1) == 0x0) {
            r0 = [[NSAlert alloc] init];
            r20 = r0;
            [r0 setAlertStyle:0x1];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 localizedStringForKey:@"Please select a writable folder" value:@"" table:0x0] retain];
            [r20 setMessageText:r23];
            [r23 release];
            [r22 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [[r0 localizedStringForKey:@"In order for %@ to install Windows applications, you must have write permissions to this folder." value:@"" table:0x0] retain];
            r22 = [[NSString stringWithFormat:r24] retain];
            [r20 setInformativeText:r22];
            [r22 release];
            [r24 release];
            [r23 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 localizedStringForKey:@"OK" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r20 addButtonWithTitle:r21]);
            [r21 release];
            [r22 release];
            [r20 runModal];
            [r20 release];
    }
    r0 = r19;
    return r0;


// 0x100011bec
// -[PreferencesController installerCacheSizeStringWhileCalculating]
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 localizedStringForKey:@"Calculating…" value:@"" table:0x0] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100011c4c
// -[PreferencesController enumerateCachedInstallersWithBlock:]
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
    var_60 = **___stack_chk_guard;
    var_160 = [arg2 retain];
    r20 = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdef"] retain];
    r23 = [[NSFileManager defaultManager] retain];
    r24 = [[self->_installersCache URLByResolvingSymlinksInPath] retain];
    var_78 = **_NSURLNameKey;
    r0 = [NSArray arrayWithObjects:&var_78 count:0x3];
    r25 = [r0 retain];
    r26 = [[r23 enumeratorAtURL:r24 includingPropertiesForKeys:r25 options:0x3 errorHandler:0x0] retain];
    [r25 release];
    [r24 release];
    [r23 release];
    var_140 = q0;
    var_130 = q0;
    r0 = [r26 retain];
    var_158 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_140 objects:&decomp_var_f8 count:0x10];
    if (r0 == 0x0) goto loc_100011ec0;
    goto loc_100011d94;

loc_100011ec0:
    [var_158 release];
    [var_158 release];
    [r20 release];
    [var_160 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;

loc_100011d94:
    r24 = r0;
    r19 = *var_130;
    goto loc_100011da0;

loc_100011da0:
    r23 = 0x0;
    goto loc_100011da4;

loc_100011da4:
    if (*var_130 != r19) {
            objc_enumerationMutation(var_158);
    }
    r22 = **_NSURLIsDirectoryKey;
    r25 = *(var_138 + r23 * 0x8);
    var_148 = 0x0;
    r0 = [r25 getResourceValue:&var_148 forKey:r22 error:0x0];
    r27 = r0;
    r26 = [var_148 retain];
    if (r27 != 0x0) {
            if (([r26 boolValue] & 0x1) == 0x0) {
                    var_150 = 0x0;
                    r0 = [r25 getResourceValue:&var_150 forKey:**_NSURLNameKey error:0x0];
                    r28 = r0;
                    r27 = [var_150 retain];
                    if (r28 != 0x0 && [r27 length] >= 0x22 && [r27 characterAtIndex:0x20] == 0x2e) {
                            r28 = 0x0;
                            while (true) {
                                    if (([r20 characterIsMember:[r27 characterAtIndex:r28]] & 0x1) == 0x0) {
                                            temp_0 = 0x0;
                                            break;
                                    }
                                    r28 = r28 + 0x1;
                                    if (r28 != 0x20) {
                                            continue;
                                    }
                                    temp_0 = 0x1;
                                    break;
                            }
                            if (temp_0 != 0x0) {
                                    (var_160[0x2])(var_160, r25);
                            }
                    }
                    [r27 release];
                    [r26 release];
                    r23 = r23 + 0x1;
                    if (r23 != r24) {
                            continue;
                    }
                    break;
            }
            else {
                    [r26 release];
                    r23 = r23 + 0x1;
                    if (r23 != r24) {
                            continue;
                    }
                    break;
            }
    }
    else {
            var_150 = 0x0;
            r0 = [r25 getResourceValue:&var_150 forKey:**_NSURLNameKey error:0x0];
            r28 = r0;
            r27 = [var_150 retain];
            if (r28 != 0x0 && [r27 length] >= 0x22 && [r27 characterAtIndex:0x20] == 0x2e) {
                    r28 = 0x0;
                    while (true) {
                            if (([r20 characterIsMember:[r27 characterAtIndex:r28]] & 0x1) == 0x0) {
                                    temp_0 = 0x0;
                                    break;
                            }
                            r28 = r28 + 0x1;
                            if (r28 != 0x20) {
                                    continue;
                            }
                            temp_0 = 0x1;
                            break;
                    }
                    if (temp_0 != 0x0) {
                            (var_160[0x2])(var_160, r25);
                    }
            }
            [r27 release];
            [r26 release];
            r23 = r23 + 0x1;
            if (r23 != r24) {
                    continue;
            }
            break;
    }
    goto .l2;

.l2:
    r0 = [var_158 countByEnumeratingWithState:&var_140 objects:&decomp_var_f8 count:0x10];
    r24 = r0;
    if (r0 != 0x0) {
            continue;
    }
    break;


// 0x100011f20
// -[PreferencesController calculateInstallerCacheSize]
    var_40 = 0x0;
    var_38 = &var_40;
    r20 = *__NSConcreteStackBlock;
    var_68 = r20;
    [self enumerateCachedInstallersWithBlock:&var_68];
    r0 = [NSByteCountFormatter stringFromByteCount:var_38[0x3] countStyle:0x0];
    r0 = [r0 retain];
    var_98 = r20;
    var_70 = r0;
    r19 = [r0 retain];
    dispatch_async(*__dispatch_main_q, &var_98);
    [var_70 release];
    [r19 release];
    _Block_object_dispose(&var_40, 0x8);
    return;


// 0x1000120f8
// -[PreferencesController installersCacheEventStreamCallback]
    var_38 = *__NSConcreteStackBlock;
    dispatch_async(*__dispatch_main_q, &var_38);
    [self calculateInstallerCacheSize];
    return;


// 0x1000121c0
// -[PreferencesController clearInstallerCache:]
    r8 = sign_extend_64(*(int32_t *)ivar_offset(_queue));
    r8 = *(self + r8);
    var_28 = *__NSConcreteStackBlock;
    dispatch_async(r8, &var_28);
    return;


// 0x1000124d0
// -[PreferencesController openInstallerCache:]
    r0 = [NSWorkspace sharedWorkspace];
    r0 = [r0 retain];
    r20 = r0;
    [r0 openURL:self->_installersCache];
    [r20 release];
    return;


// 0x100012518
// -[PreferencesController installerCacheSizeLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installerCacheSizeLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x100012538
// -[PreferencesController setInstallerCacheSizeLabel:]
    objc_storeWeak((int64_t *)&self->_installerCacheSizeLabel, arg2);
    return;


// 0x10001254c
// -[PreferencesController bottlesFolderURL]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottlesFolderURL)), 0x1);
    return r0;


// 0x10001255c
// -[PreferencesController setBottlesFolderURL:]
    objc_setProperty_atomic_copy();
    return;


// 0x100012568
// -[PreferencesController programsFolderURL]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_programsFolderURL)), 0x1);
    return r0;


// 0x100012578
// -[PreferencesController setProgramsFolderURL:]
    objc_setProperty_atomic_copy();
    return;


// 0x100012584
// -[PreferencesController lastUpdated]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_lastUpdated)), 0x1);
    return r0;


// 0x100012594
// -[PreferencesController setLastUpdated:]
    objc_setProperty_atomic_copy();
    return;


// 0x1000125a0
// -[PreferencesController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_lastUpdated, 0x0);
    objc_storeStrong((int64_t *)&self->_programsFolderURL, 0x0);
    objc_storeStrong((int64_t *)&self->_bottlesFolderURL, 0x0);
    objc_destroyWeak((int64_t *)&self->_installerCacheSizeLabel);
    objc_storeStrong((int64_t *)&self->_queue, 0x0);
    objc_storeStrong((int64_t *)&self->_installersCache, 0x0);
    return;


