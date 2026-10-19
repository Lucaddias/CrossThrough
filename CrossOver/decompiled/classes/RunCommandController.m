// RunCommandController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000176fc
// -[RunCommandController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithWindowNibName:@"RunCommand"];
    return r0;


// 0x100017738
// -[RunCommandController initWithFileToRun:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r0 = [self init];
    r20 = r0;
    if (r0 != 0x0) {
            r21 = [[NSPredicate predicateWithFormat:@"canRunCommands != FALSE"] retain];
            [r20 setCanRunFilterPredicate:r21];
            [r21 release];
            r21 = [[NSString stringWithFormat:@"\"%@\"", r3] retain];
            [r20 setCommand:r21];
            [r21 release];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x1000177f8
// -[RunCommandController dealloc]
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x100017860
// +[RunCommandController automaticallyNotifiesObserversOfSelectedBottle]
    return 0x0;


// 0x100017868
// -[RunCommandController setSelectedBottle:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = arg2;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    r21 = (int64_t *)&r20->_selectedBottle;
    if (*r21 != r0) {
            [r20 willChangeValueForKey:@"selectedBottle"];
            objc_storeStrong(r21, r22);
            [r20 didChangeValueForKey:@"selectedBottle"];
            if (*r21 != 0x0) {
                    r0 = [r20 bottleArray];
                    r0 = [r0 retain];
                    r23 = r0;
                    r0 = [r0 arrangedObjects];
                    r0 = [r0 retain];
                    r24 = r0;
                    r22 = [r0 indexOfObjectIdenticalTo:*r21];
                    [r24 release];
                    [r23 release];
                    if (r22 == 0x7fffffffffffffff) {
                            [r20 setSelectedBottleIndexes:0x0];
                    }
                    else {
                            r22 = [[NSIndexSet indexSetWithIndex:r22] retain];
                            [r20 setSelectedBottleIndexes:r22];
                            [r22 release];
                    }
            }
            else {
                    [r20 setSelectedBottleIndexes:0x0];
            }
            if (*r21 != 0x0) {
                    r20 = [[r20 loggingOptions] retain];
                    r21 = [[r19 name] retain];
                    [r20 setLogFileName:r21];
                    [r21 release];
                    [r20 release];
            }
    }
    [r19 release];
    return;


// 0x1000179cc
// +[RunCommandController automaticallyNotifiesObserversOfSelectedBottleIndexes]
    return 0x0;


// 0x1000179d4
// -[RunCommandController setSelectedBottleIndexes:]
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
    r0 = [arg2 retain];
    r19 = r0;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(_selectedBottleIndexes));
    r2 = *(r20 + r21);
    if (r2 != r0) {
            if (r19 != 0x0) {
                    if (r2 != 0x0) {
                            if (([r19 isEqualToIndexSet:r2] & 0x1) == 0x0) {
                                    [r20 willChangeValueForKey:@"selectedBottleIndexes"];
                                    r0 = [r19 copy];
                                    r8 = *(r20 + r21);
                                    *(r20 + r21) = r0;
                                    [r8 release];
                                    [r20 didChangeValueForKey:@"selectedBottleIndexes"];
                                    r0 = *(r20 + r21);
                                    r0 = [r0 firstIndex];
                                    if (r0 == 0x7fffffffffffffff) {
                                            [r20 setSelectedBottle:0x0];
                                    }
                                    else {
                                            r21 = r0;
                                            r0 = [r20 bottleArray];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            r0 = [r0 arrangedObjects];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r21 = [[r0 objectAtIndex:r21] retain];
                                            [r20 setSelectedBottle:r21];
                                            [r21 release];
                                            [r23 release];
                                            [r22 release];
                                    }
                                    [r19 release];
                            }
                            else {
                                    [r19 release];
                            }
                    }
                    else {
                            [r20 willChangeValueForKey:@"selectedBottleIndexes"];
                            if (r19 != 0x0) {
                                    r0 = [r19 copy];
                            }
                            else {
                                    r0 = [[NSIndexSet alloc] init];
                            }
                            r8 = *(r20 + r21);
                            *(r20 + r21) = r0;
                            [r8 release];
                            [r20 didChangeValueForKey:@"selectedBottleIndexes"];
                            r0 = *(r20 + r21);
                            r0 = [r0 firstIndex];
                            if (r0 == 0x7fffffffffffffff) {
                                    [r20 setSelectedBottle:0x0];
                            }
                            else {
                                    r21 = r0;
                                    r0 = [r20 bottleArray];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    r0 = [r0 arrangedObjects];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r21 = [[r0 objectAtIndex:r21] retain];
                                    [r20 setSelectedBottle:r21];
                                    [r21 release];
                                    [r23 release];
                                    [r22 release];
                            }
                            [r19 release];
                    }
            }
            else {
                    [r20 willChangeValueForKey:@"selectedBottleIndexes"];
                    if (r19 != 0x0) {
                            r0 = [r19 copy];
                    }
                    else {
                            r0 = [[NSIndexSet alloc] init];
                    }
                    r8 = *(r20 + r21);
                    *(r20 + r21) = r0;
                    [r8 release];
                    [r20 didChangeValueForKey:@"selectedBottleIndexes"];
                    r0 = *(r20 + r21);
                    r0 = [r0 firstIndex];
                    if (r0 == 0x7fffffffffffffff) {
                            [r20 setSelectedBottle:0x0];
                    }
                    else {
                            r21 = r0;
                            r0 = [r20 bottleArray];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 arrangedObjects];
                            r0 = [r0 retain];
                            r23 = r0;
                            r21 = [[r0 objectAtIndex:r21] retain];
                            [r20 setSelectedBottle:r21];
                            [r21 release];
                            [r23 release];
                            [r22 release];
                    }
                    [r19 release];
            }
    }
    else {
            [r19 release];
    }
    return;


// 0x100017b1c
// -[RunCommandController browseForCommand:]
    r31 = r31 - 0x70;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = **_NSApp;
    r0 = [r0 crossOverRoot];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 stringByAppendingPathComponent:@"bin"] retain];
    [r21 release];
    r0 = [r20 bottleArray];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 selectedObjects];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 count];
    [r22 release];
    [r21 release];
    if (r23 != 0x0) {
            r0 = [r20 bottleArray];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 selectedObjects];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 objectAtIndex:0x0] retain];
            [r22 release];
            [r21 release];
            r21 = [[r23 systemDrive] retain];
            [r23 release];
    }
    else {
            r21 = [r19 retain];
    }
    r0 = [NSOpenPanel openPanel];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setCanChooseFiles:0x1];
    [r22 setCanChooseDirectories:0x0];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"Please choose a file to run." value:@"" table:0x0] retain];
    [r22 setMessage:r24];
    [r24 release];
    [r23 release];
    r23 = [[NSURL fileURLWithPath:r21] retain];
    [r22 setDirectoryURL:r23];
    [r23 release];
    r23 = [[r20 window] retain];
    var_60 = *__NSConcreteStackBlock;
    r0 = [r22 retain];
    r20 = r0;
    [r0 beginSheetModalForWindow:r23 completionHandler:&var_60];
    [r23 release];
    [r22 release];
    [r20 release];
    [r21 release];
    [r19 release];
    return;


// 0x100017e18
// -[RunCommandController runCommandPressed:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([self canRun] != 0x0) {
            [r19 runCommand];
    }
    return;


// 0x100017e4c
// -[RunCommandController runCommand]
    r31 = r31 - 0xf0;
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
    [self setCommandRunning:0x1];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r20 = r0;
    [r0 sanitizeLogChannels];
    [r20 release];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r20 = r0;
    [r0 saveSettingsToRecent];
    [r20 release];
    r0 = [r19 launcher];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    [r20 release];
    r0 = r19;
    if (r21 != 0x0) {
            r0 = [r0 launcher];
            r0 = [r0 retain];
            r20 = r0;
            r22 = [[r0 bottle] retain];
            [r20 release];
            r26 = [[r22 name] retain];
    }
    else {
            r0 = [r0 bottleArray];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 selectedObjects];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 count];
            [r21 release];
            [r20 release];
            if (r22 != 0x0) {
                    r0 = [r19 bottleArray];
                    r0 = [r0 retain];
                    r20 = r0;
                    r0 = [r0 selectedObjects];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [[r0 objectAtIndex:0x0] retain];
                    [r21 release];
                    [r20 release];
                    r26 = [[r22 name] retain];
            }
            else {
                    r26 = @"default";
            }
    }
    var_A8 = r22;
    r0 = [r19 launcher];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    var_B0 = r26;
    if (r20 != 0x0) {
            r25 = *_NSApp;
            r0 = [r19 launcher];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 url] retain];
            r24 = [[CXBundle bundleWithURL:r22] retain];
            [r22 release];
            [r21 release];
            r22 = [[r24 objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"] retain];
            r0 = *r25;
            r0 = [r0 crossOverRoot];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 stringByAppendingPathComponent:@"bin"];
            r0 = [r0 retain];
            r21 = r0;
            var_A0 = [[r0 stringByAppendingPathComponent:@"cxmenu"] retain];
            [r21 release];
            [r20 release];
            var_80 = @"--bottle";
            var_B8 = r22;
            r3 = 0x5;
            r0 = [NSArray arrayWithObjects:&var_80 count:0x5];
            r28 = [r0 retain];
            [r24 release];
    }
    else {
            r0 = **_NSApp;
            r0 = [r0 crossOverRoot];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 stringByAppendingPathComponent:@"bin"];
            r0 = [r0 retain];
            r21 = r0;
            var_A0 = [[r0 stringByAppendingPathComponent:@"cxstart"] retain];
            [r21 release];
            [r20 release];
            var_98 = @"--bottle";
            r3 = 0x3;
            r0 = [NSArray arrayWithObjects:&var_98 count:0x3];
            r28 = [r0 retain];
            var_B8 = 0x0;
    }
    r0 = [r19 envVars];
    r0 = [r0 retain];
    r20 = r0;
    r24 = [r0 copy];
    [r20 release];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 createLogFile];
    [r20 release];
    if (r21 != 0x0) {
            r0 = [r19 loggingOptions];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 logFileURL];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 path];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [r0 length];
            [r22 release];
            [r21 release];
            [r20 release];
            if (r23 != 0x0) {
                    r20 = [[r28 arrayByAddingObject:@"--verbose"] retain];
                    [r28 release];
                    r26 = [[r20 arrayByAddingObject:@"--cx-log"] retain];
                    [r20 release];
                    r0 = [r19 loggingOptions];
                    r0 = [r0 retain];
                    r20 = r0;
                    r0 = [r0 logEnvironment];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [r0 length];
                    [r21 release];
                    [r20 release];
                    if (r22 != 0x0) {
                            if ([r24 length] != 0x0) {
                                    r0 = [r19 loggingOptions];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r22 = [[r0 logEnvironment] retain];
                                    r21 = [[NSString stringWithFormat:@"%@ %@\n", r3, r4] retain];
                                    [r24 release];
                                    r24 = r22;
                            }
                            else {
                                    r0 = [r19 loggingOptions];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r21 = [[r0 logEnvironment] retain];
                            }
                            [r24 release];
                            [r20 release];
                            r24 = r21;
                    }
                    r0 = [r19 loggingOptions];
                    r0 = [r0 retain];
                    r21 = r0;
                    r0 = [r0 logFileURL];
                    r0 = [r0 retain];
                    r22 = r0;
                    r0 = [r0 path];
                    r0 = [r0 retain];
                    r0 = objc_retainAutorelease(r0);
                    r23 = r0;
                    r20 = open([r0 fileSystemRepresentation], 0x609);
                    [r23 release];
                    [r22 release];
                    [r21 release];
                    if (r20 != -0x1) {
                            r0 = [NSFileHandle alloc];
                            r0 = [r0 initWithFileDescriptor:r20 closeOnDealloc:0x1];
                            if (r0 != 0x0) {
                                    r25 = r0;
                                    r0 = [r19 launcher];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    [r0 release];
                                    r0 = r19;
                                    if (r20 != 0x0) {
                                            r0 = [r0 launcher];
                                            r0 = [r0 retain];
                                            r27 = r0;
                                            r23 = [[r0 name] retain];
                                            r0 = [r19 command];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            r0 = [r0 length];
                                            r21 = r0;
                                            if (r0 != 0x0) {
                                                    r22 = [[r19 command] retain];
                                            }
                                            else {
                                                    r22 = @"";
                                            }
                                            r28 = [[NSString stringWithFormat:@"Running launcher: %@ (%@)\nCommand-line options: %@\n", 0x1, r4, r5] retain];
                                            if (r21 != 0x0) {
                                                    [r22 release];
                                            }
                                            [r20 release];
                                            [r23 release];
                                    }
                                    else {
                                            r27 = [[r0 command] retain];
                                            r28 = [[NSString stringWithFormat:@"Running command: %@\n", r3] retain];
                                    }
                                    [r27 release];
                                    r0 = [r19 loggingOptions];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r21 = [[r0 logChannels] retain];
                                    r27 = [[r28 stringByAppendingFormat:@"Bottle: %@\nDebug channels: %@\nExtra environment variables: %@\n\n", r3, r4, r5] retain];
                                    [r28 release];
                                    [r21 release];
                                    [r20 release];
                                    r20 = [[r27 dataUsingEncoding:0x4] retain];
                                    [r25 writeData:r20];
                                    [r20 release];
                                    r0 = [CXSetupLib systemInfoClass];
                                    r2 = var_A8;
                                    if (r2 != 0x0) {
                                            r0 = [r0 systemInformationStringForBottle:r2];
                                            r0 = [r0 retain];
                                    }
                                    else {
                                            r0 = [r0 systemInformationString];
                                            r0 = [r0 retain];
                                    }
                                    r21 = [[r0 dataUsingEncoding:0x4] retain];
                                    [r25 writeData:r21];
                                    [r21 release];
                                    [r0 release];
                                    r28 = [[r26 arrayByAddingObject:@"-"] retain];
                            }
                            else {
                                    r0 = [r19 loggingOptions];
                                    r0 = [r0 retain];
                                    r27 = r0;
                                    r0 = [r0 logFileURL];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r21 = [[r0 path] retain];
                                    r28 = [[r26 arrayByAddingObject:r21] retain];
                                    [r26 release];
                                    [r21 release];
                                    r25 = 0x0;
                                    r26 = r20;
                            }
                    }
                    else {
                            r0 = [r19 loggingOptions];
                            r0 = [r0 retain];
                            r27 = r0;
                            r0 = [r0 logFileURL];
                            r0 = [r0 retain];
                            r20 = r0;
                            r21 = [[r0 path] retain];
                            r28 = [[r26 arrayByAddingObject:r21] retain];
                            [r26 release];
                            [r21 release];
                            r25 = 0x0;
                            r26 = r20;
                    }
                    [r26 release];
                    [r27 release];
            }
            else {
                    r25 = 0x0;
            }
            r0 = [r19 loggingOptions];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 logChannels];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 length];
            [r21 release];
            [r20 release];
            if (r22 != 0x0) {
                    r20 = [[r28 arrayByAddingObject:@"--debugmsg"] retain];
                    [r28 release];
                    r0 = [r19 loggingOptions];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [[r0 logChannels] retain];
                    r28 = [[r20 arrayByAddingObject:r22] retain];
                    [r20 release];
                    [r22 release];
                    [r21 release];
            }
    }
    else {
            r25 = 0x0;
    }
    if ([r24 length] != 0x0) {
            r20 = [[r28 arrayByAddingObject:@"--env"] retain];
            [r28 release];
            r28 = [[r20 arrayByAddingObject:r24] retain];
            [r20 release];
    }
    r0 = [r19 command];
    r0 = [r0 retain];
    r20 = r0;
    if ([r0 length] != 0x0) {
            r21 = [CXSetupLib cxUtilsClass];
            r22 = [[r19 command] retain];
            r27 = [[r21 cmdLineToArgv:r22] retain];
            [r22 release];
    }
    else {
            r27 = [[NSArray array] retain];
    }
    [r20 release];
    r0 = [r19 launcher];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    var_C0 = r24;
    if (r20 == 0x0) {
            r20 = [CXSetupLib cxUtilsClass];
            r21 = [[r27 objectAtIndex:0x0] retain];
            r23 = [[r20 dirname:r21] retain];
            [r21 release];
            if ([r23 length] != 0x0) {
                    r20 = [[r28 arrayByAddingObject:@"--workdir"] retain];
                    [r28 release];
                    r28 = [[r20 arrayByAddingObject:r23] retain];
                    [r20 release];
            }
            r20 = [[r28 arrayByAddingObject:@"--"] retain];
            [r28 release];
            [r23 release];
            r28 = r20;
    }
    var_C8 = r27;
    r27 = [[r28 arrayByAddingObjectsFromArray:r27] retain];
    [r28 release];
    r0 = [[CXTask alloc] init];
    r24 = sign_extend_64(*(int32_t *)ivar_offset(task));
    r8 = *(r19 + r24);
    *(r19 + r24) = r0;
    [r8 release];
    [*(r19 + r24) setArguments:r27];
    [*(r19 + r24) setLaunchPath:var_A0];
    r20 = *(r19 + r24);
    r21 = [[NSPipe pipe] retain];
    [r20 setStandardOutput:r21];
    [r21 release];
    if (r25 != 0x0) {
            [*(r19 + r24) setStandardError:r25];
    }
    else {
            r20 = [[NSPipe pipe] retain];
            [*(r19 + r24) setStandardError:r20];
            [r20 release];
    }
    r8 = sign_extend_64(*(int32_t *)ivar_offset(stdOut));
    r0 = *(r19 + r8);
    if (r0 != 0x0) {
            *(r19 + r8) = 0x0;
            [r0 release];
    }
    if (r25 != 0x0) {
            r20 = [[NSData data] retain];
            [r19 setStdErr:r20];
            [r20 release];
    }
    else {
            [r19 setStdErr:0x0];
    }
    *(int8_t *)(int64_t *)&r19->taskComplete = 0x0;
    r20 = [[NSNotificationCenter defaultCenter] retain];
    r28 = **_NSFileHandleReadToEndOfFileCompletionNotification;
    r0 = *(r19 + r24);
    r0 = [r0 standardOutput];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 fileHandleForReading] retain];
    [r20 addObserver:r19 selector:@selector(getStdout:) name:r28 object:r23];
    [r23 release];
    [r22 release];
    [r20 release];
    r23 = [[NSNotificationCenter defaultCenter] retain];
    if (r25 != 0x0) {
            [r23 addObserver:r19 selector:@selector(didTerminate:) name:**_NSTaskDidTerminateNotification object:*(r19 + r24)];
            [r23 release];
    }
    else {
            r28 = **_NSFileHandleReadToEndOfFileCompletionNotification;
            r0 = *(r19 + r24);
            r0 = [r0 standardError];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 fileHandleForReading] retain];
            [r23 addObserver:r19 selector:@selector(getStderr:) name:r28 object:r22];
            [r22 release];
            [r21 release];
            [r23 release];
            r0 = [NSNotificationCenter defaultCenter];
            r0 = [r0 retain];
            r20 = r0;
            [r0 addObserver:r19 selector:@selector(didTerminate:) name:**_NSTaskDidTerminateNotification object:*(r19 + r24)];
            [r20 release];
            r0 = *(r19 + r24);
            r0 = [r0 standardError];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 fileHandleForReading];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 fileDescriptor];
            [r21 release];
            [r20 release];
            fcntl(r22, 0x3) | 0x4;
            fcntl(r22, 0x4);
    }
    r26 = var_B0;
    r23 = var_A8;
    r0 = *(r19 + r24);
    r0 = [r0 standardOutput];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 fileHandleForReading];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 fileDescriptor];
    [r21 release];
    [r20 release];
    fcntl(r22, 0x3) | 0x4;
    fcntl(r22, 0x4);
    if (r25 == 0x0) {
            r0 = *(r19 + r24);
            r0 = [r0 standardError];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 fileHandleForReading];
            r0 = [r0 retain];
            r21 = r0;
            [r0 readToEndOfFileInBackgroundAndNotify];
            [r21 release];
            [r20 release];
    }
    r0 = *(r19 + r24);
    r0 = [r0 standardOutput];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 fileHandleForReading];
    r0 = [r0 retain];
    r21 = r0;
    [r0 readToEndOfFileInBackgroundAndNotify];
    [r21 release];
    [r20 release];
    [*(r19 + r24) launch];
    [var_C8 release];
    [r25 release];
    [var_C0 release];
    [var_B8 release];
    [r27 release];
    [var_A0 release];
    [r26 release];
    [r23 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x100018d4c
// -[RunCommandController getStdout:]
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
    r0 = [arg2 retain];
    r20 = r0;
    r0 = [r0 userInfo];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 objectForKey:**_NSFileHandleNotificationDataItem];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 copy];
    r24 = sign_extend_64(*(int32_t *)ivar_offset(stdOut));
    r8 = *(r19 + r24);
    *(r19 + r24) = r0;
    [r8 release];
    [r22 release];
    [r21 release];
    r21 = [[NSNotificationCenter defaultCenter] retain];
    r22 = [[r20 name] retain];
    r23 = [[r20 object] retain];
    [r20 release];
    [r21 removeObserver:r19 name:r22 object:r23];
    [r23 release];
    [r22 release];
    [r21 release];
    if (*(r19 + r24) != 0x0 && *(r19 + sign_extend_64(*(int32_t *)ivar_offset(_stdErr))) != 0x0) {
            if (*(int8_t *)(r19 + sign_extend_64(*(int32_t *)ivar_offset(taskComplete))) != 0x0) {
                    [r19 commandComplete];
            }
    }
    return;


// 0x100018e90
// -[RunCommandController getStderr:]
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
    r0 = [arg2 retain];
    r20 = r0;
    r0 = [r0 userInfo];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 objectForKey:**_NSFileHandleNotificationDataItem] retain];
    [r19 setStdErr:r22];
    [r22 release];
    [r21 release];
    r21 = [[NSNotificationCenter defaultCenter] retain];
    r22 = [[r20 name] retain];
    r23 = [[r20 object] retain];
    [r20 release];
    [r21 removeObserver:r19 name:r22 object:r23];
    [r23 release];
    [r22 release];
    [r21 release];
    if (*(r19 + sign_extend_64(*(int32_t *)ivar_offset(stdOut))) != 0x0 && *(r19 + sign_extend_64(*(int32_t *)ivar_offset(_stdErr))) != 0x0) {
            if (*(int8_t *)(r19 + sign_extend_64(*(int32_t *)ivar_offset(taskComplete))) != 0x0) {
                    [r19 commandComplete];
            }
    }
    return;


// 0x100018fcc
// -[RunCommandController didTerminate:]
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
    r24 = sign_extend_64(*(int32_t *)ivar_offset(taskComplete));
    *(int8_t *)(self + r24) = 0x1;
    r21 = [arg2 retain];
    r20 = [[NSNotificationCenter defaultCenter] retain];
    r22 = [[r21 name] retain];
    r23 = [[r21 object] retain];
    [r21 release];
    [r20 removeObserver:r19 name:r22 object:r23];
    [r23 release];
    [r22 release];
    [r20 release];
    if (*(r19 + sign_extend_64(*(int32_t *)ivar_offset(stdOut))) != 0x0 && *(r19 + sign_extend_64(*(int32_t *)ivar_offset(_stdErr))) != 0x0) {
            if (*(int8_t *)(r19 + r24) != 0x0) {
                    [r19 commandComplete];
            }
    }
    return;


// 0x1000190cc
// -[RunCommandController commandComplete]
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
    r19 = self;
    r27 = sign_extend_64(*(int32_t *)ivar_offset(task));
    if ([*(self + r27) terminationStatus] != 0x0) {
            r20 = [[NSAlert alloc] init];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 localizedStringForKey:@"Command results" value:@"" table:0x0] retain];
            [r20 setMessageText:r22];
            [r22 release];
            [r21 release];
            r0 = [r19 launcher];
            r0 = [r0 retain];
            r21 = r0;
            [r0 release];
            if (r21 != 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r22 = r0;
                    r21 = [[r0 localizedStringForKey:@"%1$@ returned status %2$d." value:@"" table:0x0] retain];
                    [r22 release];
                    r0 = [r19 launcher];
                    r0 = [r0 retain];
                    r22 = r0;
                    r23 = [[r0 name] retain];
                    [*(r19 + r27) terminationStatus];
                    r2 = r21;
            }
            else {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [[r0 localizedStringForKey:@"The command %@ returned %d." value:@"" table:0x0] retain];
                    r23 = [[r19 command] retain];
                    [*(r19 + r27) terminationStatus];
                    r2 = r22;
            }
            r24 = [[NSString stringWithFormat:r2] retain];
            [r20 setInformativeText:r24];
            [r24 release];
            [r23 release];
            [r22 release];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 localizedStringForKey:@"OK" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r20 addButtonWithTitle:r22]);
            [r22 release];
            [r21 release];
            r21 = [[NSString alloc] initWithData:r19->stdOut encoding:0x4];
            r0 = [NSString alloc];
            r2 = r19->_stdErr;
            r22 = [r0 initWithData:r2 encoding:0x4];
            if ([r21 length] == 0x0) {
                    if ([r22 length] != 0x0) {
                            if ([r21 length] != 0x0) {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r25 = [[r0 localizedStringForKey:@"Command output:" value:@"" table:0x0] retain];
                                    r24 = [[@"" stringByAppendingString:r25] retain];
                                    [r25 release];
                                    [r23 release];
                                    r25 = [[r24 stringByAppendingString:@"\n"] retain];
                                    [r24 release];
                                    r2 = r21;
                                    r23 = [[r25 stringByAppendingString:r2] retain];
                                    [r25 release];
                                    if ([r22 length] != 0x0) {
                                            r2 = @"\n\n";
                                            r24 = [[r23 stringByAppendingString:@"\n\n"] retain];
                                            [r23 release];
                                            r23 = r24;
                                    }
                            }
                            else {
                                    r23 = @"";
                            }
                            if ([r22 length] != 0x0) {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    r25 = [[r0 localizedStringForKey:@"Command error text:" value:@"" table:0x0] retain];
                                    r26 = [[r23 stringByAppendingString:r25] retain];
                                    [r23 release];
                                    [r25 release];
                                    [r24 release];
                                    r24 = [[r26 stringByAppendingString:@"\n"] retain];
                                    [r26 release];
                                    r2 = r22;
                                    r23 = [[r24 stringByAppendingString:r2] retain];
                                    [r24 release];
                            }
                            r24 = [[r19 failAlertAccessoryView] retain];
                            [r20 setAccessoryView:r24];
                            [r24 release];
                            r0 = [r19 failAlertTextView];
                            r0 = [r0 retain];
                            r24 = r0;
                            r0 = [r0 textContainer];
                            r0 = [r0 retain];
                            r25 = r0;
                            [r0 setHeightTracksTextView:0x0];
                            [r25 release];
                            [r24 release];
                            r0 = [r19 failAlertTextView];
                            r0 = [r0 retain];
                            r24 = r0;
                            r0 = [r0 textContainer];
                            r0 = [r0 retain];
                            r25 = r0;
                            [r0 setWidthTracksTextView:0x0];
                            [r25 release];
                            [r24 release];
                            r0 = [r19 failAlertTextView];
                            r0 = [r0 retain];
                            r24 = r0;
                            r0 = [r0 textContainer];
                            r0 = [r0 retain];
                            r25 = r0;
                            [r0 setContainerSize:r2];
                            [r25 release];
                            [r24 release];
                            r0 = [r19 failAlertTextView];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 setString:r23];
                            [r24 release];
                            [r23 release];
                            r23 = [[r19 window] retain];
                            [r20 beginSheetModalForWindow:r23 completionHandler:0x0];
                            [r23 release];
                            [r22 release];
                            [r21 release];
                            [r20 release];
                            [r19 setCommandRunning:0x0];
                            r0 = [r19 loggingOptions];
                            r0 = [r0 retain];
                            r19 = r0;
                            [r0 updateLogFileURL];
                            [r19 release];
                    }
                    else {
                            r23 = [[r19 window] retain];
                            [r20 beginSheetModalForWindow:r23 completionHandler:0x0];
                            [r23 release];
                            [r22 release];
                            [r21 release];
                            [r20 release];
                            [r19 setCommandRunning:0x0];
                            r0 = [r19 loggingOptions];
                            r0 = [r0 retain];
                            r19 = r0;
                            [r0 updateLogFileURL];
                            [r19 release];
                    }
            }
            else {
                    if ([r21 length] != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r23 = r0;
                            r25 = [[r0 localizedStringForKey:@"Command output:" value:@"" table:0x0] retain];
                            r24 = [[@"" stringByAppendingString:r25] retain];
                            [r25 release];
                            [r23 release];
                            r25 = [[r24 stringByAppendingString:@"\n"] retain];
                            [r24 release];
                            r2 = r21;
                            r23 = [[r25 stringByAppendingString:r2] retain];
                            [r25 release];
                            if ([r22 length] != 0x0) {
                                    r2 = @"\n\n";
                                    r24 = [[r23 stringByAppendingString:@"\n\n"] retain];
                                    [r23 release];
                                    r23 = r24;
                            }
                    }
                    else {
                            r23 = @"";
                    }
                    if ([r22 length] != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r24 = r0;
                            r25 = [[r0 localizedStringForKey:@"Command error text:" value:@"" table:0x0] retain];
                            r26 = [[r23 stringByAppendingString:r25] retain];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            r24 = [[r26 stringByAppendingString:@"\n"] retain];
                            [r26 release];
                            r2 = r22;
                            r23 = [[r24 stringByAppendingString:r2] retain];
                            [r24 release];
                    }
                    r24 = [[r19 failAlertAccessoryView] retain];
                    [r20 setAccessoryView:r24];
                    [r24 release];
                    r0 = [r19 failAlertTextView];
                    r0 = [r0 retain];
                    r24 = r0;
                    r0 = [r0 textContainer];
                    r0 = [r0 retain];
                    r25 = r0;
                    [r0 setHeightTracksTextView:0x0];
                    [r25 release];
                    [r24 release];
                    r0 = [r19 failAlertTextView];
                    r0 = [r0 retain];
                    r24 = r0;
                    r0 = [r0 textContainer];
                    r0 = [r0 retain];
                    r25 = r0;
                    [r0 setWidthTracksTextView:0x0];
                    [r25 release];
                    [r24 release];
                    r0 = [r19 failAlertTextView];
                    r0 = [r0 retain];
                    r24 = r0;
                    r0 = [r0 textContainer];
                    r0 = [r0 retain];
                    r25 = r0;
                    [r0 setContainerSize:r2];
                    [r25 release];
                    [r24 release];
                    r0 = [r19 failAlertTextView];
                    r0 = [r0 retain];
                    r24 = r0;
                    [r0 setString:r23];
                    [r24 release];
                    [r23 release];
                    r23 = [[r19 window] retain];
                    [r20 beginSheetModalForWindow:r23 completionHandler:0x0];
                    [r23 release];
                    [r22 release];
                    [r21 release];
                    [r20 release];
                    [r19 setCommandRunning:0x0];
                    r0 = [r19 loggingOptions];
                    r0 = [r0 retain];
                    r19 = r0;
                    [r0 updateLogFileURL];
                    [r19 release];
            }
    }
    else {
            [r19 setCommandRunning:0x0];
            r0 = [r19 loggingOptions];
            r0 = [r0 retain];
            r19 = r0;
            [r0 updateLogFileURL];
            [r19 release];
    }
    return;


// 0x1000196a8
// -[RunCommandController setCommand:]
    r2 = arg2;
    r0 = self;
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(_command));
    if (*(r0 + r21) != r2) {
            r19 = r0;
            r0 = [r2 decomposedStringWithCanonicalMapping];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 copy];
            r8 = *(r19 + r21);
            *(r19 + r21) = r0;
            [r8 release];
            [r20 release];
    }
    return;


// 0x10001971c
// -[RunCommandController setCommandRunning:]
    *(int8_t *)(int64_t *)&self->_commandRunning = arg2;
    r0 = [self loggingOptions];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:arg2 ^ 0x1];
    [r20 release];
    return;


// 0x100019760
// -[RunCommandController bottleCollection]
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    return r0;


// 0x10001977c
// -[RunCommandController createIcon:]
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
    r20 = self;
    r0 = [self bottleArray];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 selectedObjects];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 count];
    [r21 release];
    [r19 release];
    if (r22 != 0x0) {
            r0 = [r20 bottleArray];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 selectedObjects];
            r0 = [r0 retain];
            r22 = r0;
            r27 = [[r0 objectAtIndex:0x0] retain];
            [r22 release];
            [r21 release];
            r28 = [[[CXSetupLib cxMenuClass] localDesktopPath] retain];
            r22 = [[[CXSetupLib cxMenuClass] localStartMenuPath] retain];
            r0 = [r20 command];
            r0 = [r0 retain];
            r24 = r0;
            r23 = [[r0 componentsOfCommandLine] retain];
            [r24 release];
            r0 = [r23 objectAtIndex:0x0];
            r0 = [r0 retain];
            r25 = r0;
            r0 = [r0 lastUnixOrWindowsPathComponent];
            r0 = [r0 retain];
            r26 = r0;
            r24 = [[r0 stringByDeletingPathExtension] retain];
            [r26 release];
            [r25 release];
            if ([r23 count] >= 0x2) {
                    var_60 = r28;
                    decomp_var_58 = r27;
                    r25 = 0x1;
                    do {
                            r0 = [r23 objectAtIndex:r25];
                            r0 = [r0 retain];
                            r27 = r0;
                            r0 = [r0 lastUnixOrWindowsPathComponent];
                            r0 = [r0 retain];
                            r28 = r0;
                            r0 = [r0 pathExtension];
                            r0 = [r0 retain];
                            r19 = r0;
                            r21 = [r0 compare:@""];
                            [r19 release];
                            [r28 release];
                            [r27 release];
                            if (r21 != 0x0) {
                                    r0 = [r23 objectAtIndex:r25];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r0 = [r0 lastUnixOrWindowsPathComponent];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r25 = [[r0 stringByDeletingPathExtension] retain];
                                    [r24 release];
                                    [r21 release];
                                    [r19 release];
                                    r24 = r25;
                                    break;
                            }
                            r25 = r25 + 0x1;
                    } while ([r23 count] > r25);
                    r28 = var_60;
                    r27 = decomp_var_58;
            }
            r19 = [CXSetupLib cxMenuClass];
            r21 = [[r27 name] retain];
            r20 = [[r20 command] retain];
            [r19 createShortcutForBottle:r21 command:r20 name:r24 folder:r22 localDesktopPath:r28 andStartMenuPath:r22];
            [r20 release];
            [r21 release];
            r0 = **_NSApp;
            r0 = [r0 delegate];
            r0 = [r0 retain];
            r19 = r0;
            [r0 refreshPrograms:0x0];
            [r19 release];
            [r24 release];
            [r23 release];
            [r22 release];
            [r28 release];
            [r27 release];
    }
    else {
            NSLog(@"We can't create an icon when there is no current bottle.\n");
    }
    return;


// 0x100019ac0
// -[RunCommandController windowDidLoad]
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
    r19 = self;
    var_58 = **___stack_chk_guard;
    var_80 = self;
    [[&var_80 super] windowDidLoad];
    r20 = [[r19 bottleArray] retain];
    r22 = [[NSSortDescriptor alloc] initWithKey:@"isDefault" ascending:0x0];
    r23 = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:0x1 selector:@selector(localizedCaseInsensitiveCompare:)];
    r21 = [[NSArray arrayWithObjects:r22] retain];
    [r20 setSortDescriptors:r21];
    [r21 release];
    [r23 release];
    [r22 release];
    [r20 release];
    r0 = [r19 launcher];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    r0 = r19;
    if (r20 != 0x0) {
            r0 = [r0 launcher];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 name] retain];
            [r21 release];
    }
    else {
            r0 = [r0 bottleArray];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 selectedObjects];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 count];
            [r21 release];
            [r20 release];
            if (r22 != 0x0) {
                    r0 = [r19 bottleArray];
                    r0 = [r0 retain];
                    r21 = r0;
                    r0 = [r0 selectedObjects];
                    r0 = [r0 retain];
                    r22 = r0;
                    r0 = [r0 objectAtIndex:0x0];
                    r0 = [r0 retain];
                    r23 = r0;
                    r20 = [[r0 name] retain];
                    [r23 release];
                    [r22 release];
                    [r21 release];
            }
            else {
                    r20 = @"log";
            }
    }
    r21 = [[LoggingOptionsViewController alloc] initWithLogFileName:r20];
    [r19 setLoggingOptions:r21];
    [r21 release];
    r21 = [[r19 loggingViewContainer] retain];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r23 = r0;
    var_60 = r0;
    r0 = [NSArray arrayWithObjects:&var_60 count:0x1];
    r24 = [r0 retain];
    [r21 setSubviews:r24];
    [r24 release];
    [r23 release];
    [r22 release];
    [r21 release];
    var_70 = @"view";
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r23 = r0;
    var_68 = r0;
    r0 = [NSDictionary dictionaryWithObjects:&var_68 forKeys:&var_70 count:0x1];
    r21 = [r0 retain];
    [r23 release];
    [r22 release];
    r22 = [[r19 loggingViewContainer] retain];
    r23 = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0x0 metrics:0x0 views:r21] retain];
    [r22 addConstraints:r23];
    [r23 release];
    [r22 release];
    r22 = [[r19 loggingViewContainer] retain];
    r23 = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0x0 metrics:0x0 views:r21] retain];
    [r22 addConstraints:r23];
    [r23 release];
    [r22 release];
    r0 = [r19 launcher];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    if (r22 != 0x0) {
            r22 = [[RunCommandLauncherModeViewController alloc] init];
            [r19 setLauncherModeViewController:r22];
            [r22 release];
            r0 = [r19 launcherModeViewController];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setRepresentedObject:r19];
            [r22 release];
            r0 = [r19 launcherModeViewController];
            r0 = [r0 retain];
            r23 = r0;
            r22 = [[r0 view] retain];
            [r23 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r24 = r0;
            r23 = [[r0 localizedStringForKey:@"Run '%@'" value:@"" table:0x0] retain];
            [r24 release];
            r0 = [r19 launcher];
            r0 = [r0 retain];
            r24 = r0;
            r26 = [[r0 name] retain];
            r25 = [[NSString stringWithFormat:r23] retain];
            r0 = [r19 window];
            r0 = [r0 retain];
            r27 = r0;
            [r0 setTitle:r25];
            [r27 release];
            [r25 release];
            [r26 release];
    }
    else {
            r22 = [[r19 nonLauncherModeView] retain];
            r23 = [[r19 nonLauncherModeCommandTextField] retain];
            r0 = [r19 window];
            r0 = [r0 retain];
            r24 = r0;
            [r0 setInitialFirstResponder:r23];
    }
    [r24 release];
    [r23 release];
    r0 = [r19 modeSpecificViewContainer];
    r0 = [r0 retain];
    r23 = r0;
    [r0 addSubview:r22];
    [r23 release];
    r23 = [_NSDictionaryOfVariableBindings(@"viewToUse", r22) retain];
    [r21 release];
    r24 = [[NSLayoutConstraint constraintsWithVisualFormat:@"|[viewToUse]|" options:0x0 metrics:0x0 views:r23] retain];
    r0 = [r19 modeSpecificViewContainer];
    r0 = [r0 retain];
    r21 = r0;
    [r0 addConstraints:r24];
    [r21 release];
    r21 = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[viewToUse]|" options:0x0 metrics:0x0 views:r23] retain];
    [r24 release];
    r0 = [r19 modeSpecificViewContainer];
    r0 = [r0 retain];
    r24 = r0;
    [r0 addConstraints:r21];
    [r24 release];
    r0 = [r19 window];
    r0 = [r0 retain];
    r24 = r0;
    [r0 recalculateKeyViewLoop];
    [r24 release];
    r0 = [r19 window];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 standardWindowButton:0x2];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setEnabled:0x0];
    [r24 release];
    [r19 release];
    [r21 release];
    [r22 release];
    [r23 release];
    [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x10001a1c0
// -[RunCommandController windowWillClose:]
    r20 = [arg2 retain];
    r0 = [self launcherModeViewController];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setRepresentedObject:0x0];
    [r21 release];
    var_30 = self;
    [[&var_30 super] windowWillClose:r20];
    [r20 release];
    return;


// 0x10001a244
// +[RunCommandController keyPathsForValuesAffectingCanRun]
    r31 = r31 - 0x40;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_18 = **___stack_chk_guard;
    var_28 = @"launcher";
    r0 = [NSArray arrayWithObjects:&var_28 count:0x2];
    r20 = [r0 retain];
    r19 = [[NSSet setWithArray:r20] retain];
    r0 = [r20 release];
    if (**___stack_chk_guard != var_18) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x10001a2f0
// -[RunCommandController canRun]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self launcher];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r20 = 0x1;
    }
    else {
            r0 = [r20 command];
            r0 = [r0 retain];
            r21 = r0;
            if ([r0 length] != 0x0) {
                    r20 = 0x1;
            }
            [r21 release];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x10001a364
// -[RunCommandController supportsAVX]
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    r0 = ___isPlatformVersionAtLeast(0x1, 0xf, 0x0, 0x0);
    if (r0 != 0x0) {
            r0 = 0x1;
    }
    return r0;


// 0x10001a390
// -[RunCommandController appendEnvVar:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r0 = [r20 envVars];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 length];
    [r21 release];
    if (r22 != 0x0) {
            r21 = [[r20 envVars] retain];
            r22 = [[NSString stringWithFormat:@"%@ %@", r3, r4] retain];
            [r20 setEnvVars:r22];
            [r22 release];
    }
    else {
            r21 = [r19 copy];
            [r20 setEnvVars:r21];
    }
    [r21 release];
    [r19 release];
    return;


// 0x10001a468
// -[RunCommandController metalHudSelected:]
    [self appendEnvVar:@"MTL_HUD_ENABLED=1"];
    return;


// 0x10001a474
// -[RunCommandController AVXSelected:]
    [self appendEnvVar:@"ROSETTA_ADVERTISE_AVX=0"];
    return;


// 0x10001a480
// -[RunCommandController bottleArray]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleArray);
    r0 = [r0 autorelease];
    return r0;


// 0x10001a4a0
// -[RunCommandController setBottleArray:]
    objc_storeWeak((int64_t *)&self->_bottleArray, arg2);
    return;


// 0x10001a4b4
// -[RunCommandController selectedBottle]
    r0 = self->_selectedBottle;
    return r0;


// 0x10001a4c4
// -[RunCommandController selectedBottleIndexes]
    r0 = self->_selectedBottleIndexes;
    return r0;


// 0x10001a4d4
// -[RunCommandController failAlertAccessoryView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_failAlertAccessoryView);
    r0 = [r0 autorelease];
    return r0;


// 0x10001a4f4
// -[RunCommandController setFailAlertAccessoryView:]
    objc_storeWeak((int64_t *)&self->_failAlertAccessoryView, arg2);
    return;


// 0x10001a508
// -[RunCommandController failAlertTextView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_failAlertTextView);
    r0 = [r0 autorelease];
    return r0;


// 0x10001a528
// -[RunCommandController setFailAlertTextView:]
    objc_storeWeak((int64_t *)&self->_failAlertTextView, arg2);
    return;


// 0x10001a53c
// -[RunCommandController enableLoggingChannelsControls]
    r0 = *(int8_t *)(int64_t *)&self->_enableLoggingChannelsControls;
    return r0;


// 0x10001a54c
// -[RunCommandController launcher]
    r0 = self->_launcher;
    return r0;


// 0x10001a55c
// -[RunCommandController setLauncher:]
    objc_storeStrong((int64_t *)&self->_launcher, arg2);
    return;


// 0x10001a570
// -[RunCommandController loggingViewContainer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_loggingViewContainer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001a590
// -[RunCommandController setLoggingViewContainer:]
    objc_storeWeak((int64_t *)&self->_loggingViewContainer, arg2);
    return;


// 0x10001a5a4
// -[RunCommandController modeSpecificViewContainer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_modeSpecificViewContainer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001a5c4
// -[RunCommandController setModeSpecificViewContainer:]
    objc_storeWeak((int64_t *)&self->_modeSpecificViewContainer, arg2);
    return;


// 0x10001a5d8
// -[RunCommandController nonLauncherModeView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_nonLauncherModeView);
    r0 = [r0 autorelease];
    return r0;


// 0x10001a5f8
// -[RunCommandController setNonLauncherModeView:]
    objc_storeWeak((int64_t *)&self->_nonLauncherModeView, arg2);
    return;


// 0x10001a60c
// -[RunCommandController nonLauncherModeCommandTextField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_nonLauncherModeCommandTextField);
    r0 = [r0 autorelease];
    return r0;


// 0x10001a62c
// -[RunCommandController setNonLauncherModeCommandTextField:]
    objc_storeWeak((int64_t *)&self->_nonLauncherModeCommandTextField, arg2);
    return;


// 0x10001a640
// -[RunCommandController command]
    r0 = self->_command;
    return r0;


// 0x10001a650
// -[RunCommandController commandRunning]
    r0 = *(int8_t *)(int64_t *)&self->_commandRunning;
    return r0;


// 0x10001a660
// -[RunCommandController canRunFilterPredicate]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_canRunFilterPredicate)), 0x1);
    return r0;


// 0x10001a670
// -[RunCommandController setCanRunFilterPredicate:]
    objc_setProperty_atomic();
    return;


// 0x10001a67c
// -[RunCommandController launcherModeViewController]
    r0 = self->_launcherModeViewController;
    return r0;


// 0x10001a68c
// -[RunCommandController setLauncherModeViewController:]
    objc_storeStrong((int64_t *)&self->_launcherModeViewController, arg2);
    return;


// 0x10001a6a0
// -[RunCommandController loggingOptions]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_loggingOptions)), 0x1);
    return r0;


// 0x10001a6b0
// -[RunCommandController setLoggingOptions:]
    objc_setProperty_atomic();
    return;


// 0x10001a6bc
// -[RunCommandController envVars]
    r0 = self->_envVars;
    return r0;


// 0x10001a6cc
// -[RunCommandController setEnvVars:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10001a6d8
// -[RunCommandController stdErr]
    r0 = self->_stdErr;
    return r0;


// 0x10001a6e8
// -[RunCommandController setStdErr:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10001a6f4
// -[RunCommandController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_stdErr, 0x0);
    objc_storeStrong((int64_t *)&self->_envVars, 0x0);
    objc_storeStrong((int64_t *)&self->_loggingOptions, 0x0);
    objc_storeStrong((int64_t *)&self->_launcherModeViewController, 0x0);
    objc_storeStrong((int64_t *)&self->_canRunFilterPredicate, 0x0);
    objc_storeStrong((int64_t *)&self->_command, 0x0);
    objc_destroyWeak((int64_t *)&self->_nonLauncherModeCommandTextField);
    objc_destroyWeak((int64_t *)&self->_nonLauncherModeView);
    objc_destroyWeak((int64_t *)&self->_modeSpecificViewContainer);
    objc_destroyWeak((int64_t *)&self->_loggingViewContainer);
    objc_storeStrong((int64_t *)&self->_launcher, 0x0);
    objc_destroyWeak((int64_t *)&self->_failAlertTextView);
    objc_destroyWeak((int64_t *)&self->_failAlertAccessoryView);
    objc_storeStrong((int64_t *)&self->_selectedBottleIndexes, 0x0);
    objc_storeStrong((int64_t *)&self->_selectedBottle, 0x0);
    objc_destroyWeak((int64_t *)&self->_bottleArray);
    objc_storeStrong((int64_t *)&self->stdOut, 0x0);
    objc_storeStrong((int64_t *)&self->task, 0x0);
    return;


