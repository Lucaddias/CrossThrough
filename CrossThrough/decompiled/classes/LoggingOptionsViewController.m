// LoggingOptionsViewController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000345cc
// -[LoggingOptionsViewController initWithLogFileName:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    var_30 = self;
    r0 = [[&var_30 super] initWithNibName:@"LoggingOptionsView" bundle:0x0];
    r20 = r0;
    if (r0 != 0x0) {
            [r20 setEnabled:0x1];
            [r20 setLogFileName:r19];
            [r20 setLogFileNameFromUser:0x0];
            r22 = [[LoggingOption commonPresets] retain];
            r21 = [[NSMutableArray arrayWithArray:r22] retain];
            [r20 setChannelCombos:r21];
            [r21 release];
            [r22 release];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x1000346b8
// -[LoggingOptionsViewController viewDidLoad]
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
    r23 = self;
    var_60 = **___stack_chk_guard;
    var_F0 = self;
    [[&var_F0 super] viewDidLoad];
    r0 = [r23 logFileURL];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    r0 = r23;
    if (r20 != 0x0) {
            [r0 setCreateLogFile:0x1];
            r0 = [r23 logFileURL];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 URLByDeletingLastPathComponent] retain];
            [r23 setLogDirectoryURL:r21];
            [r21 release];
            [r20 release];
            [r23 setLogFileNameFromUser:0x1];
    }
    else {
            [r0 setCreateLogFile:0x0];
            r0 = [NSFileManager defaultManager];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 URLForDirectory:0x5 inDomain:0x1 appropriateForURL:0x0 create:0x1 error:0x0] retain];
            [r23 setLogDirectoryURL:r21];
            [r21 release];
            r0 = [r23 logDirectoryURL];
            r0 = [r0 retain];
            r21 = r0;
            [r0 release];
            if (r21 == 0x0) {
                    r22 = [[@"~/Library" stringByExpandingTildeInPath] retain];
                    r21 = [[NSURL fileURLWithPath:r22 isDirectory:0x1] retain];
                    [r23 setLogDirectoryURL:r21];
                    [r21 release];
                    [r22 release];
            }
            r0 = [r23 logDirectoryURL];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 URLByAppendingPathComponent:@"Logs" isDirectory:0x1] retain];
            [r23 setLogDirectoryURL:r22];
            [r22 release];
            [r21 release];
            r0 = [r23 logDirectoryURL];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 URLByAppendingPathComponent:@"CrossOver" isDirectory:0x1] retain];
            [r23 setLogDirectoryURL:r22];
            [r22 release];
            [r21 release];
            [r23 updateLogFileURL];
            [r20 release];
    }
    r19 = [[NSFileManager defaultManager] retain];
    r20 = [[r23 logDirectoryURL] retain];
    var_150 = r19;
    [r19 createDirectoryAtURL:r20 withIntermediateDirectories:0x1 attributes:0x0 error:0x0];
    [r20 release];
    [r23 updateRecentMenuItems];
    var_130 = q0;
    var_120 = q0;
    var_138 = r23;
    r0 = [r23 channelCombos];
    r0 = [r0 retain];
    r3 = &decomp_var_e0;
    var_148 = r0;
    r4 = 0x10;
    r0 = [r0 countByEnumeratingWithState:&var_130 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            var_140 = *var_120;
            do {
                    r19 = 0x0;
                    do {
                            if (*var_120 != var_140) {
                                    objc_enumerationMutation(var_148);
                            }
                            r26 = *(var_128 + r19 * 0x8);
                            r0 = [r26 logChannels];
                            r0 = [r0 retain];
                            r25 = r0;
                            r20 = [[r0 sortedArrayUsingSelector:@selector(localizedStandardCompare:)] retain];
                            [r25 release];
                            r25 = [[r20 componentsJoinedByString:@","] retain];
                            r0 = [r26 logEnvironment];
                            r0 = [r0 retain];
                            r21 = r0;
                            r23 = [r0 count];
                            [r21 release];
                            if (r23 != 0x0) {
                                    r0 = [r26 logEnvironment];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r24 = [[r0 componentsJoinedByString:@"\n"] retain];
                                    r21 = [[NSString stringWithFormat:@"%@\n%@", r3, r4] retain];
                                    [r25 release];
                                    [r24 release];
                                    [r23 release];
                                    r25 = r21;
                            }
                            r21 = [NSMenuItem alloc];
                            r23 = [[r26 name] retain];
                            r3 = @selector(addLoggingChannels:);
                            r4 = @"";
                            r21 = [r21 initWithTitle:r23 action:@selector(addLoggingChannels:) keyEquivalent:@""];
                            [r23 release];
                            [r21 setTarget:var_138];
                            [r21 setRepresentedObject:r26];
                            [r21 setToolTip:r25];
                            [r21 setIndentationLevel:0x1];
                            r0 = [var_138 channelPresets];
                            r0 = [r0 retain];
                            r23 = r0;
                            r0 = [r0 menu];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 addItem:r21];
                            [r24 release];
                            [r23 release];
                            [r21 release];
                            [r25 release];
                            [r20 release];
                            r19 = r19 + 0x1;
                    } while (r22 != r19);
                    r3 = &decomp_var_e0;
                    r4 = 0x10;
                    r0 = [var_148 countByEnumeratingWithState:&var_130 objects:r3 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [var_148 release];
    [var_150 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x100034bf0
// -[LoggingOptionsViewController updateLogFileURL]
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
    r19 = self;
    if (([self logFileNameFromUser] & 0x1) == 0x0) {
            r20 = [[NSFileManager defaultManager] retain];
            r26 = 0x1;
            do {
                    r0 = [r19 logFileName];
                    r0 = [r0 retain];
                    r24 = r0;
                    r23 = [r0 mutableCopy];
                    [r24 release];
                    if (r26 != 0x1) {
                            [r23 appendFormat:@" %d", r3];
                    }
                    [r23 appendString:@".cxlog"];
                    r0 = [r19 logDirectoryURL];
                    r0 = [r0 retain];
                    r24 = r0;
                    r3 = 0x0;
                    r25 = [[r0 URLByAppendingPathComponent:r23 isDirectory:0x0] retain];
                    [r19 setLogFileURL:r25];
                    [r25 release];
                    [r24 release];
                    [r23 release];
                    r0 = [r19 logFileURL];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [[r0 path] retain];
                    r25 = [r20 fileExistsAtPath:r24];
                    [r24 release];
                    [r23 release];
                    r26 = r26 + 0x1;
            } while ((r25 & 0x1) != 0x0);
            [r20 release];
    }
    return;


// 0x100034d64
// -[LoggingOptionsViewController setLogFileName:]
    r2 = arg2;
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_logFileName));
    if (*(r0 + r20) != r2) {
            r19 = r0;
            r0 = [r2 copy];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
            [r19 updateLogFileURL];
    }
    return;


// 0x100034dbc
// -[LoggingOptionsViewController selectLogFile:]
    r31 = r31 - 0x80;
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
    r20 = [[NSSavePanel savePanel] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"Select a log file" value:@"" table:0x0] retain];
    [r20 setMessage:r22];
    [r22 release];
    [r21 release];
    var_40 = @"cxlog";
    r0 = [NSArray arrayWithObjects:&var_40 count:0x1];
    r21 = [r0 retain];
    [r20 setAllowedFileTypes:r21];
    [r21 release];
    [r20 setAllowsOtherFileTypes:0x1];
    [r20 setCanSelectHiddenExtension:0x1];
    r0 = [r19 logFileURL];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 lastPathComponent] retain];
    [r22 release];
    if (r21 != 0x0) {
            [r20 setNameFieldStringValue:r21];
    }
    r22 = [[r19 logDirectoryURL] retain];
    [r20 setDirectoryURL:r22];
    [r22 release];
    [r20 setShowsTagField:0x0];
    r0 = [r19 view];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 window] retain];
    var_70 = *__NSConcreteStackBlock;
    r0 = [r20 retain];
    r19 = r0;
    [r0 beginSheetModalForWindow:r23 completionHandler:&var_70];
    [r23 release];
    [r22 release];
    [r20 release];
    [r19 release];
    [r21 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x100035088
// -[LoggingOptionsViewController clearLoggingChannels:]
    [self setLogChannels:0x0];
    [self setLogEnvironment:0x0];
    return;


// 0x1000350b4
// -[LoggingOptionsViewController combineChannels:with:andDelimiter:]
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
    var_60 = **___stack_chk_guard;
    r21 = [arg2 retain];
    r19 = [arg3 retain];
    r20 = [arg4 retain];
    r22 = [[r21 componentsSeparatedByString:r20] retain];
    if (r21 == 0x0) {
            r21 = @"";
    }
    r23 = [[NSMutableString string] retain];
    if ([r22 count] != 0x0) {
            r24 = [[NSSet setWithArray:r22] retain];
            var_120 = q0;
            var_110 = q0;
            var_128 = r19;
            r0 = [r19 retain];
            r25 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
            if (r0 != 0x0) {
                    r26 = r0;
                    r28 = *var_110;
                    do {
                            r19 = 0x0;
                            do {
                                    if (*var_110 != r28) {
                                            objc_enumerationMutation(r25);
                                    }
                                    r27 = *(var_118 + r19 * 0x8);
                                    if (([r24 containsObject:r27] & 0x1) == 0x0) {
                                            if ([r23 length] != 0x0) {
                                                    [r23 appendString:r20];
                                            }
                                            [r23 appendString:r27];
                                    }
                                    r19 = r19 + 0x1;
                            } while (r26 != r19);
                            r0 = [r25 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                            r26 = r0;
                    } while (r0 != 0x0);
            }
            [r25 release];
            [r24 release];
            r19 = var_128;
    }
    else {
            r24 = [[r19 componentsJoinedByString:r20] retain];
            [r23 setString:r24];
            [r24 release];
    }
    if ([r23 length] != 0x0) {
            if ([r21 length] != 0x0 && ([r21 hasSuffix:r20] & 0x1) == 0x0) {
                    r24 = [[r21 stringByAppendingString:r20] retain];
                    [r21 release];
                    r21 = r24;
            }
            r0 = [r21 stringByAppendingString:r23];
            r0 = [r0 retain];
    }
    else {
            r0 = [r21 retain];
            r21 = r0;
    }
    r24 = r0;
    [r23 release];
    [r22 release];
    [r20 release];
    [r19 release];
    r0 = [r21 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r24 autorelease];
    return r0;


// 0x100035354
// -[LoggingOptionsViewController addLoggingChannels:]
    r0 = [arg2 retain];
    r21 = r0;
    r19 = [[r0 representedObject] retain];
    r22 = [[self logChannels] retain];
    r23 = [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
    r24 = [[r22 stringByRemovingCharactersInSet:r23] retain];
    [r23 release];
    [r22 release];
    r22 = [[r19 logChannels] retain];
    r23 = [[self combineChannels:r24 with:r22 andDelimiter:@","] retain];
    [self setLogChannels:r23];
    [r23 release];
    [r22 release];
    [self addExtraEnvVariables:r21];
    [r21 release];
    [r24 release];
    [r19 release];
    return;


// 0x100035464
// -[LoggingOptionsViewController addExtraEnvVariables:]
    r20 = [[arg2 representedObject] retain];
    r21 = [[self logEnvironment] retain];
    r22 = [[r20 logEnvironment] retain];
    r23 = [[self combineChannels:r21 with:r22 andDelimiter:@" "] retain];
    [self setLogEnvironment:r23];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x100035518
// +[LoggingOptionsViewController keyPathsForValuesAffectingEnableControls]
    r31 = r31 - 0x40;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_18 = **___stack_chk_guard;
    var_28 = @"createLogFile";
    r0 = [NSArray arrayWithObjects:&var_28 count:0x2];
    r20 = [r0 retain];
    r19 = [[NSSet setWithArray:r20] retain];
    r0 = [r20 release];
    if (**___stack_chk_guard != var_18) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x1000355c4
// -[LoggingOptionsViewController enableControls]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self createLogFile];
    if (r0 != 0x0) {
            r0 = [r19 enabled];
    }
    return r0;


// 0x1000355f8
// -[LoggingOptionsViewController sanitizeLogChannels]
    r21 = [[self logChannels] retain];
    r20 = [[DebugChannelFormatter sanitizeChannelString:r21] retain];
    [self setLogChannels:r20];
    [r20 release];
    [r21 release];
    return;


// 0x100035664
// -[LoggingOptionsViewController saveSettingsToRecent]
    r31 = r31 - 0x60;
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
    if ([self createLogFile] != 0x0) {
            r0 = [r19 logChannels];
            r0 = [r0 retain];
            r20 = r0;
            if ([r0 length] != 0x0) {
                    [r20 release];
                    r0 = [r19 logChannels];
                    r0 = [r0 retain];
                    r21 = r0;
                    if (r0 != 0x0) {
                            r22 = [[r19 logChannels] retain];
                    }
                    else {
                            r22 = @"";
                    }
                    var_48 = r22;
                    r0 = [r19 logEnvironment];
                    r0 = [r0 retain];
                    r23 = r0;
                    if (r0 != 0x0) {
                            r24 = [[r19 logEnvironment] retain];
                    }
                    else {
                            r24 = @"";
                    }
                    r0 = [NSArray arrayWithObjects:&var_48 count:0x2];
                    r20 = [r0 retain];
                    if (r23 != 0x0) {
                            [r24 release];
                    }
                    [r23 release];
                    if (r21 != 0x0) {
                            [r22 release];
                    }
                    [r21 release];
                    r0 = [NSUserDefaults standardUserDefaults];
                    r0 = [r0 retain];
                    r22 = r0;
                    r0 = [r0 arrayForKey:@"RecentLoggingOptions"];
                    r0 = [r0 retain];
                    r23 = r0;
                    r21 = [r0 mutableCopy];
                    [r23 release];
                    [r22 release];
                    if (r21 == 0x0) {
                            r21 = [[NSMutableArray array] retain];
                    }
                    r0 = [r21 indexOfObject:r20];
                    if (r0 != 0x7fffffffffffffff) {
                            [r21 removeObjectAtIndex:r0];
                    }
                    [r21 insertObject:r20 atIndex:0x0];
                    if ([r21 count] >= 0x4) {
                            [r21 count] - 0x3;
                            [r21 removeObjectsInRange:0x3];
                    }
                    r0 = [NSUserDefaults standardUserDefaults];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 setObject:r21 forKey:@"RecentLoggingOptions"];
                    [r22 release];
                    [r19 updateRecentMenuItems];
                    [r21 release];
                    [r20 release];
                    if (**___stack_chk_guard != var_38) {
                            __stack_chk_fail();
                    }
            }
            else {
                    r0 = [r19 logEnvironment];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [r0 length];
                    [r21 release];
                    [r20 release];
                    if (r22 != 0x0) {
                            r0 = [r19 logChannels];
                            r0 = [r0 retain];
                            r21 = r0;
                            if (r0 != 0x0) {
                                    r22 = [[r19 logChannels] retain];
                            }
                            else {
                                    r22 = @"";
                            }
                            var_48 = r22;
                            r0 = [r19 logEnvironment];
                            r0 = [r0 retain];
                            r23 = r0;
                            if (r0 != 0x0) {
                                    r24 = [[r19 logEnvironment] retain];
                            }
                            else {
                                    r24 = @"";
                            }
                            r0 = [NSArray arrayWithObjects:&var_48 count:0x2];
                            r20 = [r0 retain];
                            if (r23 != 0x0) {
                                    [r24 release];
                            }
                            [r23 release];
                            if (r21 != 0x0) {
                                    [r22 release];
                            }
                            [r21 release];
                            r0 = [NSUserDefaults standardUserDefaults];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 arrayForKey:@"RecentLoggingOptions"];
                            r0 = [r0 retain];
                            r23 = r0;
                            r21 = [r0 mutableCopy];
                            [r23 release];
                            [r22 release];
                            if (r21 == 0x0) {
                                    r21 = [[NSMutableArray array] retain];
                            }
                            r0 = [r21 indexOfObject:r20];
                            if (r0 != 0x7fffffffffffffff) {
                                    [r21 removeObjectAtIndex:r0];
                            }
                            [r21 insertObject:r20 atIndex:0x0];
                            if ([r21 count] >= 0x4) {
                                    [r21 count] - 0x3;
                                    [r21 removeObjectsInRange:0x3];
                            }
                            r0 = [NSUserDefaults standardUserDefaults];
                            r0 = [r0 retain];
                            r22 = r0;
                            [r0 setObject:r21 forKey:@"RecentLoggingOptions"];
                            [r22 release];
                            [r19 updateRecentMenuItems];
                            [r21 release];
                            [r20 release];
                            if (**___stack_chk_guard != var_38) {
                                    __stack_chk_fail();
                            }
                    }
                    else {
                            if (**___stack_chk_guard != var_38) {
                                    __stack_chk_fail();
                            }
                    }
            }
    }
    else {
            if (**___stack_chk_guard != var_38) {
                    __stack_chk_fail();
            }
    }
    return;


// 0x1000358e8
// -[LoggingOptionsViewController updateRecentMenuItems]
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
    r19 = self;
    var_60 = **___stack_chk_guard;
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 arrayForKey:@"RecentLoggingOptions"] retain];
    [r20 release];
    if ([r21 count] == 0x0) {
            r20 = 0x1;
    }
    r0 = [r19 recentChannelsMenuItem];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setHidden:r20];
    r0 = [r19 recentChannelsDivider];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setHidden:r20];
    [r23 release];
    [r22 release];
    r0 = [r19 channelPresets];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 menu] retain];
    r26 = r19;
    r23 = [[r19 recentChannelsMenuItem] retain];
    var_138 = [r22 indexOfItem:r23] + 0x1;
    [r23 release];
    while (true) {
            [r22 release];
            [r20 release];
            r0 = [r26 channelPresets];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 menu];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 itemAtIndex:var_138] retain];
            r0 = [r26 recentChannelsDivider];
            r0 = [r0 retain];
            r24 = r0;
            [r0 release];
            [r23 release];
            [r22 release];
            [r20 release];
            if (r23 == r24) {
                    break;
            }
            r0 = [r26 channelPresets];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 menu];
            r0 = [r0 retain];
            r22 = r0;
            [r0 removeItemAtIndex:var_138];
    }
    var_120 = q0;
    var_110 = q0;
    r0 = [r21 retain];
    r3 = &decomp_var_e0;
    var_150 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:r3 count:0x10];
    if (r0 == 0x0) goto loc_100035da8;
    goto loc_100035ae4;

loc_100035da8:
    [var_150 release];
    [var_150 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;

loc_100035ae4:
    r25 = r0;
    var_148 = *var_110;
    goto loc_100035af4;

loc_100035af4:
    r19 = 0x0;
    var_140 = @selector(restoreRecent:);
    goto loc_100035b04;

loc_100035b04:
    if (*var_110 != var_148) {
            objc_enumerationMutation(var_150);
    }
    r27 = *(var_118 + r19 * 0x8);
    r20 = [[r27 objectAtIndexedSubscript:0x0] retain];
    r21 = [[r27 objectAtIndexedSubscript:0x1] retain];
    r28 = [[NSMutableString string] retain];
    r0 = [r20 length];
    var_130 = r21;
    var_128 = r20;
    if (r0 != 0x0) {
            r23 = [r20 retain];
            [r28 setString:r23];
            if ([r21 length] != 0x0) {
                    if (r23 != 0x0) {
                            [r28 appendFormat:@"\n%@", r3];
                    }
                    else {
                            r23 = [r21 retain];
                            [r28 setString:r23];
                    }
            }
    }
    else {
            if ([r21 length] != 0x0) {
                    r23 = [r21 retain];
                    [r28 setString:r23];
            }
            else {
                    r23 = 0x0;
            }
    }
    r0 = [r23 length];
    r24 = r0;
    if (r0 >= 0x29) {
            r21 = r27;
            r27 = r28;
            r22 = [[r23 substringToIndex:0x13] retain];
            r28 = r26;
            r26 = [[r23 substringFromIndex:[r23 length] - 0x14] retain];
            r20 = [[NSString stringWithFormat:@"%@…%@", r3, r4] retain];
            [r23 release];
            r0 = r26;
            r26 = r28;
            [r0 release];
            r28 = r27;
            r27 = r21;
            [r22 release];
            r23 = r20;
    }
    r0 = [NSMenuItem alloc];
    r0 = [r0 initWithTitle:r23 action:var_140 keyEquivalent:@""];
    r20 = r0;
    [r0 setTarget:r26];
    [r20 setRepresentedObject:r27];
    [r20 setIndentationLevel:0x1];
    if (r24 > 0x28 || [var_128 length] != 0x0 && [var_130 length] != 0x0) {
            [r20 setToolTip:r28];
    }
    r0 = [r26 channelPresets];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 menu];
    r0 = [r0 retain];
    r24 = r0;
    r3 = var_138 + r19;
    [r0 insertItem:r20 atIndex:r3];
    [r24 release];
    [r22 release];
    [r20 release];
    [r28 release];
    [r23 release];
    [var_130 release];
    [var_128 release];
    r19 = r19 + 0x1;
    if (r25 != r19) {
            continue;
    }
    break;
    r3 = &decomp_var_e0;
    r0 = [var_150 countByEnumeratingWithState:&var_120 objects:r3 count:0x10];
    r25 = r0;
    var_138 = var_138 + r19;
    if (r0 != 0x0) {
            continue;
    }
    break;


// 0x100035df8
// -[LoggingOptionsViewController restoreRecent:]
    r0 = [arg2 representedObject];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 objectAtIndexedSubscript:0x0] retain];
    [self setLogChannels:r21];
    [r21 release];
    r21 = [[r20 objectAtIndexedSubscript:0x1] retain];
    [self setLogEnvironment:r21];
    [r21 release];
    [r20 release];
    return;


// 0x100035e88
// -[LoggingOptionsViewController createLogFile]
    r0 = *(int8_t *)(int64_t *)&self->_createLogFile & 0x1;
    return r0;


// 0x100035e9c
// -[LoggingOptionsViewController setCreateLogFile:]
    *(int8_t *)(int64_t *)&self->_createLogFile = arg2;
    return;


// 0x100035eac
// -[LoggingOptionsViewController enabled]
    r0 = *(int8_t *)(int64_t *)&self->_enabled & 0x1;
    return r0;


// 0x100035ec0
// -[LoggingOptionsViewController setEnabled:]
    *(int8_t *)(int64_t *)&self->_enabled = arg2;
    return;


// 0x100035ed0
// -[LoggingOptionsViewController channelCombos]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_channelCombos)), 0x1);
    return r0;


// 0x100035ee0
// -[LoggingOptionsViewController setChannelCombos:]
    objc_setProperty_atomic();
    return;


// 0x100035eec
// -[LoggingOptionsViewController logChannels]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_logChannels)), 0x1);
    return r0;


// 0x100035efc
// -[LoggingOptionsViewController setLogChannels:]
    objc_setProperty_atomic_copy();
    return;


// 0x100035f08
// -[LoggingOptionsViewController logEnvironment]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_logEnvironment)), 0x1);
    return r0;


// 0x100035f18
// -[LoggingOptionsViewController setLogEnvironment:]
    objc_setProperty_atomic_copy();
    return;


// 0x100035f24
// -[LoggingOptionsViewController logFileName]
    r0 = self->_logFileName;
    return r0;


// 0x100035f34
// -[LoggingOptionsViewController logFileURL]
    r0 = self->_logFileURL;
    return r0;


// 0x100035f44
// -[LoggingOptionsViewController setLogFileURL:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100035f50
// -[LoggingOptionsViewController logDirectoryURL]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_logDirectoryURL)), 0x1);
    return r0;


// 0x100035f60
// -[LoggingOptionsViewController setLogDirectoryURL:]
    objc_setProperty_atomic_copy();
    return;


// 0x100035f6c
// -[LoggingOptionsViewController logFileNameFromUser]
    r0 = *(int8_t *)(int64_t *)&self->_logFileNameFromUser & 0x1;
    return r0;


// 0x100035f80
// -[LoggingOptionsViewController setLogFileNameFromUser:]
    *(int8_t *)(int64_t *)&self->_logFileNameFromUser = arg2;
    return;


// 0x100035f90
// -[LoggingOptionsViewController channelPresets]
    r0 = objc_loadWeakRetained((int64_t *)&self->_channelPresets);
    r0 = [r0 autorelease];
    return r0;


// 0x100035fb0
// -[LoggingOptionsViewController setChannelPresets:]
    objc_storeWeak((int64_t *)&self->_channelPresets, arg2);
    return;


// 0x100035fc4
// -[LoggingOptionsViewController recentChannelsDivider]
    r0 = objc_loadWeakRetained((int64_t *)&self->_recentChannelsDivider);
    r0 = [r0 autorelease];
    return r0;


// 0x100035fe4
// -[LoggingOptionsViewController setRecentChannelsDivider:]
    objc_storeWeak((int64_t *)&self->_recentChannelsDivider, arg2);
    return;


// 0x100035ff8
// -[LoggingOptionsViewController recentChannelsMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_recentChannelsMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x100036018
// -[LoggingOptionsViewController setRecentChannelsMenuItem:]
    objc_storeWeak((int64_t *)&self->_recentChannelsMenuItem, arg2);
    return;


// 0x10003602c
// -[LoggingOptionsViewController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_recentChannelsMenuItem);
    objc_destroyWeak((int64_t *)&self->_recentChannelsDivider);
    objc_destroyWeak((int64_t *)&self->_channelPresets);
    objc_storeStrong((int64_t *)&self->_logDirectoryURL, 0x0);
    objc_storeStrong((int64_t *)&self->_logFileURL, 0x0);
    objc_storeStrong((int64_t *)&self->_logFileName, 0x0);
    objc_storeStrong((int64_t *)&self->_logEnvironment, 0x0);
    objc_storeStrong((int64_t *)&self->_logChannels, 0x0);
    objc_storeStrong((int64_t *)&self->_channelCombos, 0x0);
    return;


// === Block Invocations for LoggingOptionsViewController ===

// 0x100034fe8
// ___46-[LoggingOptionsViewController selectLogFile:]_block_invoke
    r0 = arg0;
    if (r1 == 0x1) {
            r19 = r0;
            [r0[0x4] setLogFileNameFromUser:0x1];
            r20 = [[r19[0x5] URL] retain];
            [r19[0x4] setLogFileURL:r20];
            [r20 release];
            r0 = r19[0x4];
            r0 = [r0 logFileURL];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 URLByDeletingLastPathComponent] retain];
            [r19[0x4] setLogDirectoryURL:r21];
            [r21 release];
            [r20 release];
    }
    return;


