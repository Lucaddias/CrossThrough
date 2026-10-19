// InstallOptionsSheetController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000319fc
// -[InstallOptionsSheetController initWithInstallConfiguration:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg2;
    r20 = [arg2 retain];
    var_30 = self;
    r0 = [[&var_30 super] initWithWindowNibName:@"InstallOptionsSheet"];
    r21 = r0;
    if (r0 != 0x0) {
            objc_storeStrong((int64_t *)&r21->_installConfiguration, r19);
    }
    [r20 release];
    r0 = r21;
    return r0;


// 0x100031a84
// -[InstallOptionsSheetController dealloc]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installDependencyTable);
    r20 = r0;
    [r0 setDelegate:0x0];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x100031ae8
// -[InstallOptionsSheetController windowDidLoad]
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
    var_68 = self;
    [[&var_68 super] windowDidLoad];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 hasBottle];
    [r20 release];
    if ((r21 & 0x1) == 0x0) {
            r0 = [r19 installDependencyTable];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 enclosingScrollView];
            r0 = [r0 retain];
            r21 = r0;
            [r0 setVerticalScrollElasticity:0x1];
            [r21 release];
            [r20 release];
            r0 = [r19 installDependencyTable];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setAlphaValue:r2];
            [r20 release];
    }
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    [r0 addDelegate:r19];
    [r20 release];
    [r19 fillDependencyList];
    r0 = [NSSortDescriptor sortDescriptorWithKey:@"sortKey" ascending:0x1 selector:@selector(compareInstallDependencySortKey:)];
    r0 = [r0 retain];
    r20 = r0;
    var_48 = r0;
    r21 = [[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:0x1 selector:@selector(localizedStandardCompare:)] retain];
    r0 = [NSArray arrayWithObjects:&var_48 count:0x2];
    r22 = [r0 retain];
    r0 = [r19 installDependencyArrayController];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setSortDescriptors:r22];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r20 = [LoggingOptionsViewController alloc];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 logFileName] retain];
    r20 = [r20 initWithLogFileName:r22];
    [r19 setLoggingOptions:r20];
    [r20 release];
    [r22 release];
    [r21 release];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 logFileURL] retain];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setLogFileURL:r21];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 logChannels] retain];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setLogChannels:r21];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 logEnvironment] retain];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setLogEnvironment:r21];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 environment] retain];
    [r19 setEnvironment:r21];
    [r21 release];
    [r20 release];
    r0 = [CXSetupLib cxUtilsClass];
    r0 = [r0 installerLoggingPreset];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 valueForKey:@"label"] retain];
    r23 = [[r20 valueForKey:@"channels"] retain];
    r21 = [[LoggingOption loggingOptionWithName:r22 channels:r23] retain];
    [r23 release];
    [r22 release];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 channelCombos];
    r0 = [r0 retain];
    r23 = r0;
    [r0 insertObject:r21 atIndex:0x0];
    [r23 release];
    [r22 release];
    r22 = [[r19 stackView] retain];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 view] retain];
    [r22 insertArrangedSubview:r24 atIndex:0x0];
    [r24 release];
    [r23 release];
    [r22 release];
    var_58 = @"view";
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r23 = r0;
    var_50 = r0;
    r0 = [NSDictionary dictionaryWithObjects:&var_50 forKeys:&var_58 count:0x1];
    r24 = [r0 retain];
    [r23 release];
    [r22 release];
    r22 = [[r19 stackView] retain];
    r23 = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0x0 metrics:0x0 views:r24] retain];
    [r22 addConstraints:r23];
    [r23 release];
    [r22 release];
    [r19 updateLanguages];
    [r24 release];
    [r21 release];
    [r20 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x10003208c
// -[InstallOptionsSheetController updateLogFileName]
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 logFileName] retain];
    r0 = [self loggingOptions];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setLogFileName:r21];
    [r19 release];
    [r21 release];
    [r20 release];
    return;


// 0x100032100
// -[InstallOptionsSheetController addDependenciesOfApp:fromReasons:to:]
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
    r21 = self;
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r22 = [arg3 retain];
    var_150 = [arg4 retain];
    r20 = [[r21 installConfiguration] retain];
    r24 = [[r19 appID] retain];
    var_158 = [[r20 nameForProfileWithAppID:r24] retain];
    [r24 release];
    [r20 release];
    r0 = [r21 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 targetBottle];
    r0 = [r0 retain];
    r25 = r0;
    var_138 = [[r0 valueForKey:@"installers"] retain];
    [r25 release];
    [r20 release];
    var_130 = q0;
    var_120 = q0;
    r0 = [InstallConfiguration reasonDependency];
    r0 = [r0 retain];
    r20 = r0;
    var_F0 = r0;
    var_148 = r19;
    r25 = [[r19 appID] retain];
    r0 = [NSArray arrayWithObjects:&var_F0 count:0x2];
    r26 = [r0 retain];
    var_168 = r22;
    r19 = [[r22 objectForKey:r26] retain];
    [r26 release];
    [r25 release];
    [r20 release];
    var_160 = r19;
    r0 = [r19 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r26 = r0;
            var_140 = *var_120;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_120 != var_140) {
                                    objc_enumerationMutation(var_160);
                            }
                            r28 = *(var_128 + r22 * 0x8);
                            r0 = [var_138 objectForKey:r28];
                            r0 = [r0 retain];
                            r27 = r0;
                            [r0 release];
                            if (r27 != 0x0) {
                                    r0 = [[InstallDependency alloc] init];
                                    r20 = r0;
                                    [r0 setAppID:r28];
                                    [r20 setParent:var_148];
                                    r0 = [r21 installConfiguration];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r23 = [[r0 nameForProfileWithAppID:r28] retain];
                                    [r20 setName:r23];
                                    [r23 release];
                                    [r19 release];
                                    r19 = [[InstallConfiguration reasonDependency] retain];
                                    [r20 setReason:r19];
                                    [r19 release];
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    if (r27 != 0x0) {
                                            r28 = [[r0 localizedStringForKey:@"Required by %@" value:@"" table:0x0] retain];
                                            [r25 release];
                                    }
                                    else {
                                            r28 = [[r0 localizedStringForKey:@"Required by %@, Manually Removed" value:@"" table:0x0] retain];
                                            [r25 release];
                                            [r20 setUndo:0x1];
                                    }
                                    r23 = var_150;
                                    r19 = [[NSString stringWithFormat:r28] retain];
                                    [r20 setReasonString:r19];
                                    [r19 release];
                                    [r23 addObject:r20];
                                    if (r27 != 0x0) {
                                            [r21 addDependenciesOfApp:r20 fromReasons:var_168 to:r23];
                                    }
                                    [r28 release];
                                    [r20 release];
                                    r22 = r22 + 0x1;
                                    if (r26 != r22) {
                                            continue;
                                    }
                                    break;
                            }
                            r0 = [r21 installConfiguration];
                            r0 = [r0 retain];
                            r20 = r0;
                            r0 = [r0 dependencyOverrides];
                            r0 = [r0 retain];
                            r25 = r0;
                            r19 = [[r0 objectForKey:r28] retain];
                            r23 = [[InstallConfiguration overrideExclude] retain];
                            r24 = [r19 isEqualToNumber:r23];
                            [r23 release];
                            [r19 release];
                            [r25 release];
                            [r20 release];
                            if (r24 == 0x0) {
                                    r22 = r22 + 0x1;
                                    if (r26 != r22) {
                                            continue;
                                    }
                                    break;
                            }
                            r0 = [[InstallDependency alloc] init];
                            r20 = r0;
                            [r0 setAppID:r28];
                            [r20 setParent:var_148];
                            r0 = [r21 installConfiguration];
                            r0 = [r0 retain];
                            r19 = r0;
                            r23 = [[r0 nameForProfileWithAppID:r28] retain];
                            [r20 setName:r23];
                            [r23 release];
                            [r19 release];
                            r19 = [[InstallConfiguration reasonDependency] retain];
                            [r20 setReason:r19];
                            [r19 release];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            if (r27 != 0x0) {
                                    r28 = [[r0 localizedStringForKey:@"Required by %@" value:@"" table:0x0] retain];
                                    [r25 release];
                            }
                            else {
                                    r28 = [[r0 localizedStringForKey:@"Required by %@, Manually Removed" value:@"" table:0x0] retain];
                                    [r25 release];
                                    [r20 setUndo:0x1];
                            }
                            r23 = var_150;
                            r19 = [[NSString stringWithFormat:r28] retain];
                            [r20 setReasonString:r19];
                            [r19 release];
                            [r23 addObject:r20];
                            if (r27 != 0x0) {
                                    [r21 addDependenciesOfApp:r20 fromReasons:var_168 to:r23];
                            }
                            [r28 release];
                            [r20 release];
                            r22 = r22 + 0x1;
                    } while (r26 != r22);
                    r0 = [var_160 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                    r26 = r0;
            } while (r0 != 0x0);
    }
    [var_160 release];
    [var_138 release];
    [var_158 release];
    [var_150 release];
    [var_168 release];
    [var_148 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x1000325a4
// -[InstallOptionsSheetController addDependenciesForReason:fromMap:reasonString:removedString:to:]
    r31 = r31 - 0x190;
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
    var_60 = **___stack_chk_guard;
    r27 = [arg2 retain];
    r21 = [arg3 retain];
    r28 = [arg4 retain];
    var_158 = [arg5 retain];
    var_150 = [arg6 retain];
    r20 = [[InstallConfiguration reasonOverride] retain];
    var_16C = [r27 isEqualToNumber:r20];
    [r20 release];
    r0 = [r24 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 targetBottle];
    r0 = [r0 retain];
    r22 = r0;
    var_140 = [[r0 valueForKey:@"installers"] retain];
    [r22 release];
    [r20 release];
    var_130 = q0;
    var_120 = q0;
    var_F0 = r27;
    r20 = [[NSNull null] retain];
    r0 = [NSArray arrayWithObjects:&var_F0 count:0x2];
    r22 = [r0 retain];
    var_168 = r21;
    r19 = [[r21 objectForKey:r22] retain];
    [r22 release];
    [r20 release];
    var_160 = r19;
    r0 = [r19 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
    var_138 = r0;
    if (r0 != 0x0) {
            var_148 = *var_120;
            var_178 = r28;
            do {
                    r21 = 0x0;
                    while (true) {
                            if (*var_120 != var_148) {
                                    objc_enumerationMutation(var_160);
                            }
                            r25 = *(var_128 + r21 * 0x8);
                            r0 = [var_140 objectForKey:r25];
                            r0 = [r0 retain];
                            r20 = r0;
                            [r0 release];
                            r22 = r28;
                            if (r20 != 0x0) {
                                    r0 = [[InstallDependency alloc] init];
                                    r23 = r0;
                                    [r0 setAppID:r25];
                                    r0 = [r24 installConfiguration];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r25 = [[r0 nameForProfileWithAppID:r25] retain];
                                    [r23 setName:r25];
                                    [r25 release];
                                    [r19 release];
                                    [r23 setReason:r27];
                                    [r23 setReasonString:r22];
                                    if (r20 != 0x0) {
                                            if (var_16C != 0x0) {
                                                    [r23 setUndo:0x2];
                                            }
                                            [var_150 addObject:r23];
                                            [r24 addDependenciesOfApp:r23 fromReasons:var_168 to:var_150];
                                    }
                                    else {
                                            [r23 setUndo:0x1];
                                            [var_150 addObject:r23];
                                    }
                                    [r23 release];
                                    r21 = r21 + 0x1;
                                    if (var_138 != r21) {
                                            continue;
                                    }
                                    break;
                            }
                            else {
                                    if (var_158 != 0x0) {
                                            r0 = [r24 installConfiguration];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            r0 = [r0 dependencyOverrides];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r28 = r24;
                                            r24 = r27;
                                            r27 = [[r0 objectForKey:r25] retain];
                                            r19 = [[InstallConfiguration overrideExclude] retain];
                                            r26 = [r27 isEqualToNumber:r19];
                                            [r19 release];
                                            r0 = r27;
                                            r27 = r24;
                                            r24 = r28;
                                            r28 = var_178;
                                            [r0 release];
                                            [r23 release];
                                            [r22 release];
                                            r22 = var_158;
                                            if (r26 == 0x0) {
                                                    r21 = r21 + 0x1;
                                                    if (var_138 != r21) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                            else {
                                                    r0 = [[InstallDependency alloc] init];
                                                    r23 = r0;
                                                    [r0 setAppID:r25];
                                                    r0 = [r24 installConfiguration];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    r25 = [[r0 nameForProfileWithAppID:r25] retain];
                                                    [r23 setName:r25];
                                                    [r25 release];
                                                    [r19 release];
                                                    [r23 setReason:r27];
                                                    [r23 setReasonString:r22];
                                                    if (r20 != 0x0) {
                                                            if (var_16C != 0x0) {
                                                                    [r23 setUndo:0x2];
                                                            }
                                                            [var_150 addObject:r23];
                                                            [r24 addDependenciesOfApp:r23 fromReasons:var_168 to:var_150];
                                                    }
                                                    else {
                                                            [r23 setUndo:0x1];
                                                            [var_150 addObject:r23];
                                                    }
                                                    [r23 release];
                                                    r21 = r21 + 0x1;
                                                    if (var_138 != r21) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                                    else {
                                            r21 = r21 + 0x1;
                                            if (var_138 != r21) {
                                                    continue;
                                            }
                                            break;
                                    }
                            }
                    }
                    r0 = [var_160 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                    var_138 = r0;
            } while (r0 != 0x0);
    }
    [var_160 release];
    [var_140 release];
    [var_150 release];
    [var_158 release];
    [r28 release];
    [var_168 release];
    [r27 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x1000329b0
// -[InstallOptionsSheetController fillDependencyList]
    r31 = r31 - 0x90;
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
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 targetBottle];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 analyzed];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 boolValue];
    [r22 release];
    [r21 release];
    [r20 release];
    if (r23 != 0x0) {
            r20 = [[NSMutableArray array] retain];
            r22 = [[NSMutableDictionary dictionary] retain];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 targetBottle];
            r0 = [r0 retain];
            r24 = r0;
            r0 = [r0 valueForKey:@"reasons"];
            r0 = [r0 retain];
            r21 = r0;
            var_80 = r0;
            [r24 release];
            [r23 release];
            var_78 = *__NSConcreteStackBlock;
            var_58 = r22;
            r22 = [r22 retain];
            [r21 enumerateKeysAndObjectsUsingBlock:&var_78];
            r24 = [[InstallConfiguration reasonMain] retain];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 localizedStringForKey:@"Selected for install" value:@"" table:0x0] retain];
            [r19 addDependenciesForReason:r24 fromMap:r22 reasonString:r26 removedString:0x0 to:r20];
            [r26 release];
            [r25 release];
            [r24 release];
            r24 = [[InstallConfiguration reasonSteam] retain];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 localizedStringForKey:@"Installing via Steam" value:@"" table:0x0] retain];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r27 = r0;
            r28 = [[r0 localizedStringForKey:@"Installing via Steam, Manually Removed" value:@"" table:0x0] retain];
            [r19 addDependenciesForReason:r24 fromMap:r22 reasonString:r26 removedString:r28 to:r20];
            [r28 release];
            [r27 release];
            [r26 release];
            [r25 release];
            [r24 release];
            r24 = [[InstallConfiguration reasonOverride] retain];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r23 = [[r0 localizedStringForKey:@"Manually added" value:@"" table:0x0] retain];
            [r19 addDependenciesForReason:r24 fromMap:r22 reasonString:r23 removedString:0x0 to:r20];
            [r23 release];
            [r25 release];
            [r24 release];
            [r19 setDependencies:r20];
            [var_58 release];
            [r22 release];
            [var_80 release];
            [r20 release];
    }
    else {
            [r19 setDependencies:0x0];
    }
    return;


// 0x100032dd4
// -[InstallOptionsSheetController done:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [[self environment] retain];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setEnvironment:r20];
    [r21 release];
    [r20 release];
    r0 = [r19 loggingOptions];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 createLogFile];
    [r20 release];
    r0 = r19;
    if (r21 != 0x0) {
            r0 = [r0 loggingOptions];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 logFileURL] retain];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setLogFileURL:r21];
            [r22 release];
            [r21 release];
            [r20 release];
            r0 = [r19 loggingOptions];
            r0 = [r0 retain];
            r20 = r0;
            [r0 sanitizeLogChannels];
            [r20 release];
            r0 = [r19 loggingOptions];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 logChannels] retain];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setLogChannels:r21];
            [r22 release];
            [r21 release];
            [r20 release];
            r0 = [r19 loggingOptions];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 logEnvironment] retain];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setLogEnvironment:r21];
            [r22 release];
            [r21 release];
            [r20 release];
            r0 = [r19 loggingOptions];
            r0 = [r0 retain];
            r20 = r0;
            [r0 saveSettingsToRecent];
    }
    else {
            r0 = [r0 installConfiguration];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setLogFileURL:0x0];
            [r20 release];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setLogChannels:0x0];
            [r20 release];
            r0 = [r19 installConfiguration];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setLogEnvironment:0x0];
    }
    [r20 release];
    r20 = **_NSApp;
    r19 = [[r19 window] retain];
    [r20 endSheet:r19];
    [r19 release];
    return;


// 0x100033038
// -[InstallOptionsSheetController removeInstallDependency:]
    r31 = r31 - 0x60;
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
    r21 = [arg2 retain];
    r0 = [r20 installDependencyTable];
    r0 = [r0 retain];
    r22 = r0;
    r19 = [r0 rowForView:r21];
    [r21 release];
    [r22 release];
    if (r19 != -0x1) {
            r0 = [r20 installDependencyArrayController];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 arrangedObjects];
            r0 = [r0 retain];
            r22 = r0;
            r19 = [[r0 objectAtIndex:r19] retain];
            [r22 release];
            [r21 release];
            r23 = [r19 isManuallyAdded];
            r0 = [r20 installConfiguration];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 installTask] retain];
            r22 = [[r19 appID] retain];
            if (r23 != 0x0) {
                    var_40 = r22;
                    r0 = [NSArray arrayWithObjects:&var_40 count:0x1];
                    r23 = [r0 retain];
                    [r21 removeDependencyOverrides:r23];
            }
            else {
                    var_48 = r22;
                    r0 = [NSArray arrayWithObjects:&var_48 count:0x1];
                    r23 = [r0 retain];
                    r24 = [[InstallConfiguration overrideExclude] retain];
                    [r21 addDependencyOverrides:r23 ofType:r24];
                    [r24 release];
            }
            [r23 release];
            [r22 release];
            [r21 release];
            [r20 release];
            [r19 release];
    }
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x10003321c
// -[InstallOptionsSheetController reAddDependency:]
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
    var_38 = **___stack_chk_guard;
    r21 = [arg2 retain];
    r0 = [r20 installDependencyTable];
    r0 = [r0 retain];
    r22 = r0;
    r19 = [r0 rowForView:r21];
    [r21 release];
    [r22 release];
    if (r19 != -0x1) {
            r0 = [r20 installDependencyArrayController];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 arrangedObjects];
            r0 = [r0 retain];
            r22 = r0;
            r19 = [[r0 objectAtIndex:r19] retain];
            [r22 release];
            [r21 release];
            r0 = [r20 installConfiguration];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 installTask] retain];
            r0 = [r19 appID];
            r0 = [r0 retain];
            r22 = r0;
            var_40 = r0;
            r0 = [NSArray arrayWithObjects:&var_40 count:0x1];
            r23 = [r0 retain];
            [r21 removeDependencyOverrides:r23];
            [r23 release];
            [r22 release];
            [r21 release];
            [r20 release];
            [r19 release];
    }
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x100033398
// -[InstallOptionsSheetController revertInstallDependencies:]
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 installTask];
    r0 = [r0 retain];
    r20 = r0;
    [r0 ClearDependencyOverrides];
    [r20 release];
    [r19 release];
    return;


// 0x1000333e0
// -[InstallOptionsSheetController showAddDependenciesPopover:]
    r21 = [arg2 retain];
    r20 = [[AddDependenciesViewController alloc] init];
    r19 = [[self installConfiguration] retain];
    [r20 setRepresentedObject:r19];
    [r19 release];
    r0 = [[NSPopover alloc] init];
    r19 = r0;
    [r0 setContentViewController:r20];
    [r19 setBehavior:0x1];
    [r19 showRelativeToRect:r21 ofView:0x1 preferredEdge:r4];
    [r21 release];
    [r19 release];
    [r20 release];
    return;


// 0x1000334a4
// -[InstallOptionsSheetController updateLanguages]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x210;
    var_60 = **___stack_chk_guard;
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 profileLanguages] retain];
    [r19 release];
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r19 = r0;
    var_230 = [[r0 installerLocale] retain];
    [r19 release];
    r0 = [self appLanguagePopUp];
    r0 = [r0 retain];
    r19 = r0;
    [r0 removeAllItems];
    [r19 release];
    r0 = [self appLanguagePopUp];
    r0 = [r0 retain];
    r19 = r0;
    [r0 selectItem:0x0];
    [r19 release];
    r0 = [r20 count];
    var_228 = self;
    [self setNumberOfLanguages:r0];
    if ([r20 count] == 0x0) goto loc_100033a70;
    goto loc_100033594;

loc_100033a70:
    r0 = [var_228 appLanguagePopUp];
    r0 = [r0 retain];
    r19 = r0;
    [r0 synchronizeTitleAndSelectedItem];
    [r19 release];
    [var_230 release];
    [r20 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;

loc_100033594:
    var_250 = [[NSLocale preferredLanguages] retain];
    r23 = [[NSMutableArray arrayWithCapacity:[r20 count]] retain];
    var_1E0 = q0;
    var_1D0 = q0;
    var_260 = r20;
    r0 = [r20 retain];
    var_238 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r19 = r0;
            r20 = *var_1D0;
            do {
                    r24 = 0x0;
                    do {
                            if (*var_1D0 != r20) {
                                    objc_enumerationMutation(var_238);
                            }
                            r27 = *(var_1D8 + r24 * 0x8);
                            if ([r27 length] != 0x0) {
                                    r26 = **_NSLocaleIdentifier;
                                    r28 = [[NSLocale canonicalLanguageIdentifierFromString:r27] retain];
                                    r0 = [NSLocale currentLocale];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r22 = [[r0 displayNameForKey:r26 value:r27] retain];
                                    [r25 release];
                                    r2 = [var_250 indexOfObject:r28];
                            }
                            else {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r28 = @"";
                                    r22 = [[r0 localizedStringForKey:@"Other Language" value:@"" table:0x0] retain];
                                    [r25 release];
                                    r2 = 0x7fffffffffffffff;
                            }
                            var_120 = @"lang";
                            var_100 = r27;
                            r25 = [[NSNumber numberWithUnsignedInteger:r2] retain];
                            r0 = [NSDictionary dictionaryWithObjects:&var_100 forKeys:&var_120 count:0x4];
                            r27 = [r0 retain];
                            [r25 release];
                            [r23 addObject:r27];
                            [r27 release];
                            [r22 release];
                            [r28 release];
                            r24 = r24 + 0x1;
                    } while (r19 != r24);
                    r0 = [var_238 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_e0 count:0x10];
                    r19 = r0;
            } while (r0 != 0x0);
    }
    [var_238 release];
    [r23 sortUsingFunction:_CompareLanguageEntries context:0x0];
    var_220 = q0;
    var_210 = q0;
    r0 = [r23 retain];
    var_258 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_220 objects:&decomp_var_1a0 count:0x10];
    var_238 = r0;
    if (r0 == 0x0) goto loc_100033a50;
    goto loc_10003380c;

loc_100033a50:
    [var_258 release];
    [var_258 release];
    [var_250 release];
    r20 = var_260;
    goto loc_100033a70;

loc_10003380c:
    r27 = 0x0;
    var_248 = *var_210;
    r22 = 0x7fffffffffffffff;
    r19 = var_228;
    goto loc_100033824;

loc_100033824:
    r20 = 0x0;
    var_240 = @selector(selectAppLanguage:);
    goto loc_100033834;

loc_100033834:
    r23 = r27;
    r21 = r22;
    if (*var_210 != var_248) {
            objc_enumerationMutation(var_258);
    }
    r27 = *(var_218 + r20 * 0x8);
    r25 = [[r27 objectForKey:@"lang"] retain];
    r26 = [[r27 objectForKey:@"displayName"] retain];
    r0 = [r27 objectForKey:@"rank"];
    r0 = [r0 retain];
    r28 = r0;
    r22 = [r0 unsignedIntegerValue];
    [r28 release];
    if (r23 != 0x0) {
            if (r21 != 0x7fffffffffffffff) {
                    if (r22 == 0x7fffffffffffffff || [r25 length] == 0x0) {
                            r0 = [var_228 appLanguagePopUp];
                            r0 = [r0 retain];
                            r28 = r0;
                            r21 = [[r0 menu] retain];
                            r24 = [[NSMenuItem separatorItem] retain];
                            [r21 addItem:r24];
                            [r24 release];
                            [r21 release];
                            [r28 release];
                    }
            }
            else {
                    if ([r25 length] == 0x0) {
                            r0 = [var_228 appLanguagePopUp];
                            r0 = [r0 retain];
                            r28 = r0;
                            r21 = [[r0 menu] retain];
                            r24 = [[NSMenuItem separatorItem] retain];
                            [r21 addItem:r24];
                            [r24 release];
                            [r21 release];
                            [r28 release];
                    }
            }
    }
    r0 = [r19 appLanguagePopUp];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 menu];
    r0 = [r0 retain];
    r24 = r0;
    r28 = [[r0 addItemWithTitle:r26 action:var_240 keyEquivalent:@""] retain];
    [r24 release];
    [r21 release];
    [r28 setTarget:r19];
    [r28 setRepresentedObject:r25];
    if (var_230 != 0x0 && [r25 isEqualToString:var_230] != 0x0) {
            r0 = [var_228 appLanguagePopUp];
            r0 = [r0 retain];
            r21 = r0;
            [r0 selectItem:r28];
            [r21 release];
    }
    r27 = [r27 retain];
    [r23 release];
    [r28 release];
    [r26 release];
    [r25 release];
    r20 = r20 + 0x1;
    if (var_238 != r20) {
            continue;
    }
    break;
    r0 = [var_258 countByEnumeratingWithState:&var_220 objects:&decomp_var_1a0 count:0x10];
    var_238 = r0;
    if (r0 != 0x0) {
            continue;
    }
    break;
    [r27 release];
    goto loc_100033a50;


// 0x100033cc4
// -[InstallOptionsSheetController selectAppLanguage:]
    r20 = [[arg2 representedObject] retain];
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setInstallerLocale:r20];
    [r19 release];
    [r20 release];
    return;


// 0x100033d1c
// -[InstallOptionsSheetController windowWillClose:]
    r20 = [arg2 retain];
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    [r0 removeDelegate:self];
    [r21 release];
    var_30 = self;
    [[&var_30 super] windowWillClose:r20];
    [r20 release];
    return;


// 0x100033da0
// -[InstallOptionsSheetController profileChanged]
    [self fillDependencyList];
    [self updateLanguages];
    [self updateLogFileName];
    return;


// 0x100033dcc
// -[InstallOptionsSheetController sourceChanged]
    [self fillDependencyList];
    [self updateLogFileName];
    return;


// 0x100033df0
// -[InstallOptionsSheetController bottleCreateChanged]
    [self fillDependencyList];
    [self updateLogFileName];
    return;


// 0x100033e14
// -[InstallOptionsSheetController bottleNameChanged]
    [self fillDependencyList];
    [self updateLogFileName];
    return;


// 0x100033e38
// -[InstallOptionsSheetController bottleNewnameChanged]
    [self fillDependencyList];
    [self updateLogFileName];
    return;


// 0x100033e5c
// -[InstallOptionsSheetController bottleTemplateChanged]
    [self fillDependencyList];
    [self updateLogFileName];
    return;


// 0x100033e80
// -[InstallOptionsSheetController analyzedBottle:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [arg2 retain];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 targetBottle] retain];
    [r20 release];
    [r22 release];
    [r21 release];
    if (r22 == r20) {
            [r19 fillDependencyList];
    }
    return;


// 0x100033f08
// -[InstallOptionsSheetController installDependencyTable]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installDependencyTable);
    r0 = [r0 autorelease];
    return r0;


// 0x100033f28
// -[InstallOptionsSheetController setInstallDependencyTable:]
    objc_storeWeak((int64_t *)&self->_installDependencyTable, arg2);
    return;


// 0x100033f3c
// -[InstallOptionsSheetController installDependencyArrayController]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installDependencyArrayController);
    r0 = [r0 autorelease];
    return r0;


// 0x100033f5c
// -[InstallOptionsSheetController setInstallDependencyArrayController:]
    objc_storeWeak((int64_t *)&self->_installDependencyArrayController, arg2);
    return;


// 0x100033f70
// -[InstallOptionsSheetController appLanguagePopUp]
    r0 = objc_loadWeakRetained((int64_t *)&self->_appLanguagePopUp);
    r0 = [r0 autorelease];
    return r0;


// 0x100033f90
// -[InstallOptionsSheetController setAppLanguagePopUp:]
    objc_storeWeak((int64_t *)&self->_appLanguagePopUp, arg2);
    return;


// 0x100033fa4
// -[InstallOptionsSheetController stackView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_stackView);
    r0 = [r0 autorelease];
    return r0;


// 0x100033fc4
// -[InstallOptionsSheetController setStackView:]
    objc_storeWeak((int64_t *)&self->_stackView, arg2);
    return;


// 0x100033fd8
// -[InstallOptionsSheetController dependencies]
    r0 = self->_dependencies;
    return r0;


// 0x100033fe8
// -[InstallOptionsSheetController setDependencies:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100033ff4
// -[InstallOptionsSheetController installConfiguration]
    r0 = self->_installConfiguration;
    return r0;


// 0x100034004
// -[InstallOptionsSheetController loggingOptions]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_loggingOptions)), 0x1);
    return r0;


// 0x100034014
// -[InstallOptionsSheetController setLoggingOptions:]
    objc_setProperty_atomic();
    return;


// 0x100034020
// -[InstallOptionsSheetController logFileURL]
    r0 = self->_logFileURL;
    return r0;


// 0x100034030
// -[InstallOptionsSheetController numberOfLanguages]
    r0 = self->_numberOfLanguages;
    return r0;


// 0x100034040
// -[InstallOptionsSheetController setNumberOfLanguages:]
    self->_numberOfLanguages = arg2;
    return;


// 0x100034050
// -[InstallOptionsSheetController environment]
    r0 = self->_environment;
    return r0;


// 0x100034060
// -[InstallOptionsSheetController setEnvironment:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10003406c
// -[InstallOptionsSheetController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_environment, 0x0);
    objc_storeStrong((int64_t *)&self->_logFileURL, 0x0);
    objc_storeStrong((int64_t *)&self->_loggingOptions, 0x0);
    objc_storeStrong((int64_t *)&self->_installConfiguration, 0x0);
    objc_storeStrong((int64_t *)&self->_dependencies, 0x0);
    objc_destroyWeak((int64_t *)&self->_stackView);
    objc_destroyWeak((int64_t *)&self->_appLanguagePopUp);
    objc_destroyWeak((int64_t *)&self->_installDependencyArrayController);
    objc_destroyWeak((int64_t *)&self->_installDependencyTable);
    return;


