// BottleMenuHandler — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10000d2fc
// +[BottleMenuHandler deleteBottle:withWindow:]
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
    r20 = [arg2 retain];
    r21 = [arg3 retain];
    r22 = [[r20 name] retain];
    r19 = [[NSAlert alloc] init];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r25 = r0;
    r26 = [[r0 localizedStringForKey:@"Are you sure you want to delete the '%@' bottle?" value:@"" table:0x0] retain];
    r24 = [[NSString stringWithFormat:r26] retain];
    [r19 setMessageText:r24];
    [r24 release];
    [r26 release];
    [r25 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r25 = r0;
    r26 = [[r0 localizedStringForKey:@"Deleting this bottle will permanently erase all Windows applications contained in it, as well as any documents stored in its C: drive." value:@"" table:0x0] retain];
    r24 = [[NSString stringWithFormat:r26] retain];
    [r19 setInformativeText:r24];
    [r24 release];
    [r26 release];
    [r25 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"Cancel" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r19 addButtonWithTitle:r25]);
    [r25 release];
    [r24 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r23 = [[r0 localizedStringForKey:@"Delete" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r19 addButtonWithTitle:r23]);
    [r23 release];
    [r24 release];
    if (___isPlatformVersionAtLeast(0x1, 0xb, 0x0, 0x0) != 0x0) {
            r0 = [r19 buttons];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 objectAtIndexedSubscript:0x1];
            r0 = [r0 retain];
            r24 = r0;
            [r0 setHasDestructiveAction:0x1];
            [r24 release];
            [r23 release];
    }
    var_88 = *__NSConcreteStackBlock;
    var_68 = r20;
    var_60 = r21;
    var_58 = r22;
    r22 = [r22 retain];
    r21 = [r21 retain];
    r20 = [r20 retain];
    [r19 beginSheetModalForWindow:r21 completionHandler:&var_88];
    [var_58 release];
    [var_60 release];
    [var_68 release];
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x10000d934
// +[BottleMenuHandler deleteManagedBottle:withWindow:authorization:]
    r3 = arg3;
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
    r31 = r31 + 0xffffffffffffffb0 - 0x490;
    r20 = r3;
    var_48 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r20 = [r20 retain];
    r21 = [arg4 retain];
    if ([r19 isIsManaged] != 0x0) {
            r0 = [r19 name];
            r0 = [r0 retain];
            var_88 = "cxbottle";
            r0 = objc_retainAutorelease(r0);
            r22 = r0;
            [r0 UTF8String];
            var_490 = 0x0;
            r23 = [[**_NSApp crossOverRoot] retain];
            r24 = [[NSString stringWithFormat:@"%@/bin/cxbounce", r3] retain];
            r25 = [r21 authorizationRef];
            r0 = objc_retainAutorelease(r24);
            r24 = r0;
            r0 = [r0 fileSystemRepresentation];
            r0 = AuthorizationExecuteWithPrivileges(r25, r0, 0x0, &var_88, &var_490);
            if (r0 != 0x0) {
                    var_4C0 = *__NSConcreteStackBlock;
                    var_4A0 = [r22 retain];
                    var_498 = [r20 retain];
                    dispatch_async(*__dispatch_main_q, &var_4C0);
                    [var_498 release];
                    [var_4A0 release];
            }
            else {
                    do {
                            r0 = fileno(var_490);
                            r1 = &decomp_var_488;
                            r0 = read(r0, r1, 0x400);
                            if ((r0 & 0xffffffff80000000) != 0x0) {
                                    r0 = __error(r0, r1, 0x400);
                                    if (*(int32_t *)r0 == 0x4) {
                                            continue;
                                    }
                                    if (*(int32_t *)__error(r0, r1, 0x400) == 0x23) {
                                            continue;
                                    }
                                    break;
                            }
                    } while (r0 != 0x0);
                    fclose(var_490);
                    dispatch_async(*__dispatch_main_q, ___block_literal_global);
            }
            [r24 release];
            [r23 release];
            [r22 release];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x10000dd5c
// +[BottleMenuHandler duplicateBottle:withWindow:]
    r20 = [arg3 retain];
    r19 = [[arg2 name] retain];
    r0 = [[NewBottleController alloc] init];
    r21 = r0;
    [r0 setCopyMode:0x1 withBottleToCopy:r19];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"copy of %@" value:@"" table:0x0] retain];
    r22 = [[NSString stringWithFormat:r24] retain];
    [r21 setSuggestedBottleName:r22];
    [r22 release];
    [r24 release];
    [r23 release];
    [r21 setupGUI];
    r22 = [[r21 window] retain];
    [r20 beginSheet:r22 completionHandler:0x0];
    [r20 release];
    [r22 release];
    [r21 release];
    [r19 release];
    return;


// 0x10000de98
// +[BottleMenuHandler exportBottle:withWindow:]
    r31 = r31 - 0xa0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_38 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r21 = [arg3 retain];
    r22 = [[r19 name] retain];
    r20 = [[NSSavePanel savePanel] retain];
    var_40 = @"cxarchive";
    r0 = [NSArray arrayWithObjects:&var_40 count:0x1];
    r23 = [r0 retain];
    [r20 setAllowedFileTypes:r23];
    [r23 release];
    [r20 setCanSelectHiddenExtension:0x1];
    r23 = [[NSString stringWithFormat:@"%@.cxarchive", r3] retain];
    [r20 setNameFieldStringValue:r23];
    [r23 release];
    var_80 = *__NSConcreteStackBlock;
    var_60 = r20;
    var_58 = r19;
    var_50 = r22;
    var_48 = r21;
    r21 = [r21 retain];
    r22 = [r22 retain];
    r19 = [r19 retain];
    r0 = [r20 retain];
    r20 = r0;
    [r0 beginSheetModalForWindow:r21 completionHandler:&var_80];
    [var_48 release];
    [var_50 release];
    [var_58 release];
    [var_60 release];
    [r21 release];
    [r22 release];
    [r19 release];
    [r20 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x10000e48c
// +[BottleMenuHandler installSoftwareIntoBottle:withWindow:]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r20 = [[arg3 windowController] retain];
    r1 = objc_opt_class(@class(MainWindowController));
    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
            [r20 showInstallViewWithSelectedBottle:r19];
    }
    else {
            NSLog(@"Expected controller of window in +installSoftwareIntoBottle:withWindow: to be a MainWindowController, but got %@", r1);
    }
    [r20 release];
    [r19 release];
    return;


// 0x10000e518
// +[BottleMenuHandler installMissingDependencies:withWindow:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r20 = [[arg3 windowController] retain];
    r1 = objc_opt_class(@class(MainWindowController));
    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
            r0 = [r19 getMissingDependenciesProfile];
            r0 = [r0 retain];
            r21 = r0;
            if (r0 != 0x0) {
                    r0 = [PackageTreeNode alloc];
                    r0 = [r0 initWithProfile:r21];
                    r22 = r0;
                    [r0 loadIcon];
                    [r20 showInstallViewWithSelectedBottle:r19 package:r22];
                    [r22 release];
            }
            [r21 release];
    }
    else {
            NSLog(@"Expected controller of window in +installMissingDependencies:withWindow: to be a MainWindowController, but got %@", r1);
    }
    [r20 release];
    [r19 release];
    return;


// 0x10000e5f4
// +[BottleMenuHandler openCDriveForBottle:]
    r20 = [arg2 retain];
    r19 = [[NSWorkspace sharedWorkspace] retain];
    r21 = [[r20 systemDrive] retain];
    [r20 release];
    [r19 openFile:r21];
    [r21 release];
    [r19 release];
    return;


// 0x10000e670
// +[BottleMenuHandler openShellForBottle:]
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
    r0 = [arg2 retain];
    r20 = r0;
    r21 = [[r0 name] retain];
    r22 = [[r20 systemDrive] retain];
    [r20 release];
    r0 = **_NSApp;
    r0 = [r0 crossOverRoot];
    r0 = [r0 retain];
    r20 = r0;
    r28 = [[r0 stringByAppendingPathComponent:@"bin"] retain];
    [r20 release];
    r20 = [[NSSet setWithObjects:@"HOME"] retain];
    r0 = [NSProcessInfo processInfo];
    r0 = [r0 retain];
    r23 = r0;
    r19 = [[r0 environment] retain];
    [r23 release];
    r24 = [[NSMutableString string] retain];
    var_88 = *__NSConcreteStackBlock;
    r0 = [r20 retain];
    r23 = r0;
    var_68 = r0;
    r0 = [r24 retain];
    r24 = r0;
    var_60 = r0;
    var_B0 = r19;
    [r19 enumerateKeysAndObjectsUsingBlock:&var_88];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r26 = r0;
    r27 = [[r0 localizedStringForKey:@"%1$@ Bottle \"%2$@\"" value:@"" table:0x0] retain];
    r25 = [[NSString stringWithFormat:r27] retain];
    [r27 release];
    [r26 release];
    var_98 = r21;
    r27 = [[r21 stringQuotedForBash] retain];
    var_A8 = r28;
    r28 = [[r28 stringQuotedForBash] retain];
    var_A0 = r22;
    r21 = [[r22 stringQuotedForBash] retain];
    r26 = [[NSString stringWithFormat:@"export CX_BOTTLE=%@\nexport PATH=%@\":$PATH\"\ncd %@", r3, r4, r5] retain];
    [r21 release];
    [r28 release];
    [r27 release];
    r21 = [[r25 stringQuotedForAppleScript] retain];
    r28 = [[r26 stringQuotedForAppleScript] retain];
    r27 = [[NSString stringWithFormat:@"tell app \"Terminal\"\nactivate\ndelay 0.1\ndo script \"exec /bin/bash -l\"\nset theWindow to the front window\nset the custom title of theWindow to %@\ndelay 1.0\n%@do script %@ in theWindow\nend tell", r3, r4, r5] retain];
    [r28 release];
    [r21 release];
    r0 = [NSAppleScript alloc];
    r0 = [r0 initWithSource:r27];
    r28 = r0;
    var_90 = 0x0;
    r2 = &var_90;
    r21 = [[r0 executeAndReturnError:r2] retain];
    r20 = [var_90 retain];
    [r21 release];
    if (r21 == 0x0) {
            NSLog(@"Error running script: error %@\nsource: %@\n", r1, r2);
    }
    [r20 release];
    [r28 release];
    [r27 release];
    [r26 release];
    [r25 release];
    [var_60 release];
    [var_68 release];
    [r24 release];
    [var_B0 release];
    [r23 release];
    [var_A8 release];
    [var_A0 release];
    [var_98 release];
    return;


// 0x10000ec18
// +[BottleMenuHandler publishBottle:withWindow:]
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
    r20 = [arg3 retain];
    if (([@"1" isEqualToString:@"0"] & 0x1) == 0x0) {
            r21 = [[r19 name] retain];
            r0 = [[PublishController alloc] init];
            r22 = r0;
            [r0 setupGUI];
            [r22 setSourceBottle:r21];
            r23 = [[r22 window] retain];
            [r20 beginSheet:r23 completionHandler:0x0];
            [r23 release];
            [r22 release];
            [r21 release];
    }
    [r20 release];
    [r19 release];
    return;


// 0x10000ecf0
// +[BottleMenuHandler rateBottle:withWindow:isDeleting:]
    r31 = r31 - 0x70;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = arg4;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    if (r19 != 0x0) {
            r0 = [r19 appid];
            r0 = [r0 retain];
            r21 = r0;
            if ([r0 length] != 0x0 && ([r19 isIsManaged] & 0x1) == 0x0) {
                    var_58 = *__NSConcreteStackBlock;
                    var_38 = [r19 retain];
                    var_30 = [r20 retain];
                    dispatch_async(*__dispatch_main_q, &var_58);
                    [var_30 release];
                    [var_38 release];
            }
            [r21 release];
    }
    [r20 release];
    [r19 release];
    return;


// 0x10000ee94
// +[BottleMenuHandler runCommandInBottle:]
    [BottleMenuHandler runCommandInBottle:arg2 withLauncher:0x0];
    return;


// 0x10000eea4
// +[BottleMenuHandler runCommandInBottle:withLauncher:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r21 = [arg3 retain];
    if (r19 != 0x0) {
            if ([r19 isCanRunCommands] != 0x0) {
                    r22 = [[RunCommandController alloc] init];
                    if (r21 != 0x0) {
                            [r22 setLauncher:r21];
                    }
                    objc_unsafeClaimAutoreleasedReturnValue([r22 window]);
                    if (r19 != 0x0) {
                            [r22 setSelectedBottle:r19];
                    }
                    [r22 showWindow:r20];
                    [r22 release];
                    [r21 release];
                    [r19 release];
            }
            else {
                    [r21 release];
                    [r19 release];
            }
    }
    else {
            r22 = [[RunCommandController alloc] init];
            if (r21 != 0x0) {
                    [r22 setLauncher:r21];
            }
            objc_unsafeClaimAutoreleasedReturnValue([r22 window]);
            if (r19 != 0x0) {
                    [r22 setSelectedBottle:r19];
            }
            [r22 showWindow:r20];
            [r22 release];
            [r21 release];
            [r19 release];
    }
    return;


// 0x10000ef54
// +[BottleMenuHandler toggleDefaultBottle:]
    r0 = [arg2 retain];
    r20 = r0;
    r19 = [[NSNumber numberWithBool:[r0 isIsDefault] ^ 0x1] retain];
    [r20 setIsDefault:r19 completionHandler:___block_literal_global.128];
    [r20 release];
    [r19 release];
    return;


// 0x10000eff8
// +[BottleMenuHandler toggleMSyncForBottle:withWindow:]
    [self toggleMSyncForBottle:arg2 withWindow:arg3 modalCompletionHandler:0x0];
    return;


// 0x10000f000
// +[BottleMenuHandler toggleMSyncForBottle:withWindow:modalCompletionHandler:]
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
    r20 = [arg2 retain];
    r22 = [arg4 retain];
    var_90 = [arg3 retain];
    r23 = [r20 isIsMSyncEnabled];
    r19 = [[NSAlert alloc] init];
    r26 = [[NSBundle mainBundle] retain];
    if ((r23 & 0x1) != 0x0) {
            r24 = @"";
            r25 = [[r26 localizedStringForKey:@"Disable MSync" value:@"" table:0x0] retain];
            [r19 setMessageText:r25];
            [r25 release];
            [r26 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r2 = @"Reboot Bottle and Disable MSync";
    }
    else {
            r24 = [[r26 localizedStringForKey:@"Enable MSync" value:@"" table:0x0] retain];
            [r19 setMessageText:r24];
            [r24 release];
            [r26 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r24 = r0;
            r26 = [[r0 localizedStringForKey:@"WARNING: Some Windows applications will not work correctly with MSync enabled." value:@"" table:0x0] retain];
            [r24 release];
            r24 = [[r26 stringByAppendingString:@"\n\n"] retain];
            [r26 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r2 = @"Reboot Bottle and Enable MSync";
    }
    r25 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r19 addButtonWithTitle:r25]);
    [r25 release];
    [r26 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r25 = r0;
    r27 = [[r0 localizedStringForKey:@"Changing this setting will reboot the bottle and cause any running applications in the bottle to quit. Are you sure you want to do this?" value:@"" table:0x0] retain];
    r23 = [[r24 stringByAppendingString:r27] retain];
    [r24 release];
    [r27 release];
    [r25 release];
    [r19 setInformativeText:r23];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"Cancel" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r19 addButtonWithTitle:r25]);
    [r25 release];
    [r24 release];
    var_88 = *__NSConcreteStackBlock;
    var_68 = r20;
    var_60 = r22;
    r22 = [r22 retain];
    r20 = [r20 retain];
    [r19 beginSheetModalForWindow:var_90 completionHandler:&var_88];
    [var_90 release];
    [var_60 release];
    [var_68 release];
    [r22 release];
    [r20 release];
    [r23 release];
    [r19 release];
    return;


// 0x10000f410
// +[BottleMenuHandler toggleHighResolutionForBottle:withWindow:]
    [self toggleHighResolutionForBottle:arg2 withWindow:arg3 modalCompletionHandler:0x0];
    return;


// 0x10000f418
// +[BottleMenuHandler toggleHighResolutionForBottle:withWindow:modalCompletionHandler:]
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
    var_60 = **___stack_chk_guard;
    r27 = [arg2 retain];
    r19 = [arg3 retain];
    r28 = [arg4 retain];
    r21 = [r27 isIsHighResolutionEnabled];
    r20 = [[NSAlert alloc] init];
    var_160 = r19;
    if ((r21 & 0x1) != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r19 = r0;
            r24 = @"";
            r25 = [[r0 localizedStringForKey:@"Disable High Resolution" value:@"" table:0x0] retain];
            [r20 setMessageText:r25];
            [r25 release];
            [r19 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r19 = r0;
            r25 = [[r0 localizedStringForKey:@"Reboot Bottle and Disable High Resolution Mode" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r20 addButtonWithTitle:r25]);
            [r25 release];
            [r19 release];
    }
    else {
            var_17C = r21;
            var_178 = r28;
            var_170 = r27;
            var_168 = r20;
            var_120 = q0;
            var_110 = q0;
            r0 = [NSScreen screens];
            r0 = [r0 retain];
            r24 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
            if (r0 != 0x0) {
                    r25 = r0;
                    r22 = 0x0;
                    r21 = *var_110;
                    r23 = 0x1;
                    do {
                            r20 = 0x0;
                            do {
                                    if (*var_110 != r21) {
                                            objc_enumerationMutation(r24);
                                    }
                                    r8 = var_118;
                                    r0 = *(r8 + r20 * 0x8);
                                    r0 = [r0 deviceDescription];
                                    r0 = [r0 retain];
                                    r27 = r0;
                                    r0 = [r0 objectForKey:@"NSScreenNumber"];
                                    r0 = [r0 retain];
                                    r28 = r0;
                                    r19 = [r0 unsignedIntValue];
                                    [r28 release];
                                    [r27 release];
                                    r0 = CGDisplayCopyDisplayMode(r19);
                                    r19 = r0;
                                    if (CGDisplayModeGetWidth(r0) != CGDisplayModeGetPixelWidth(r19)) {
                                            r8 = 0x1;
                                    }
                                    r23 = r8 & r23;
                                    r22 = r8 | r22;
                                    CGDisplayModeRelease(r19);
                                    r20 = r20 + 0x1;
                            } while (r25 != r20);
                            r0 = [r24 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                            r25 = r0;
                    } while (r0 != 0x0);
            }
            else {
                    r22 = 0x0;
                    r23 = 0x1;
            }
            [r24 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r19 = r0;
            r25 = [[r0 localizedStringForKey:@"Enable High Resolution" value:@"" table:0x0] retain];
            r20 = var_168;
            [r20 setMessageText:r25];
            [r25 release];
            [r19 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r19 = r0;
            r25 = [[r0 localizedStringForKey:@"WARNING: Many Windows applications render incorrectly in high resolution mode." value:@"" table:0x0] retain];
            [r19 release];
            if ((r22 & 0x1) != 0x0) {
                    r28 = var_178;
                    r21 = var_17C;
                    if ((r23 & 0x1) == 0x0) {
                            r24 = [[r25 stringByAppendingString:@"\n\n"] retain];
                            [r25 release];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r26 = r0;
                            r27 = [[r0 localizedStringForKey:@"NOTE: Your Mac has a mix of Retina and non-Retina displays. High resolution mode will make things look better on your Retina displays but worse on your non-Retina displays." value:@"" table:0x0] retain];
                            r25 = [[r24 stringByAppendingString:r27] retain];
                            [r24 release];
                            [r27 release];
                            [r26 release];
                    }
            }
            else {
                    r24 = [[r25 stringByAppendingString:@"\n\n"] retain];
                    [r25 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r26 = r0;
                    r27 = [[r0 localizedStringForKey:@"NOTE: Your Mac does not have any Retina displays that would benefit from high resolution mode. Enabling it will just make things look blurry." value:@"" table:0x0] retain];
                    r25 = [[r24 stringByAppendingString:r27] retain];
                    r28 = var_178;
                    r21 = var_17C;
                    [r24 release];
                    [r27 release];
                    [r26 release];
            }
            r24 = [[r25 stringByAppendingString:@"\n\n"] retain];
            [r25 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r19 = r0;
            r25 = [[r0 localizedStringForKey:@"Reboot Bottle and Enable High Resolution Mode" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r20 addButtonWithTitle:r25]);
            [r25 release];
            [r19 release];
            r27 = var_170;
    }
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r19 = r0;
    r26 = [[r0 localizedStringForKey:@"Changing this setting will reboot the bottle and cause any running applications in the bottle to quit. Are you sure you want to do this?" value:@"" table:0x0] retain];
    r23 = [[r24 stringByAppendingString:r26] retain];
    [r24 release];
    [r26 release];
    [r19 release];
    [r20 setInformativeText:r23];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r19 = r0;
    r24 = [[r0 localizedStringForKey:@"Cancel" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r20 addButtonWithTitle:r24]);
    [r24 release];
    [r19 release];
    var_158 = *__NSConcreteStackBlock;
    r19 = [r28 retain];
    r21 = [r27 retain];
    [r20 beginSheetModalForWindow:var_160 completionHandler:&var_158];
    [r28 release];
    [r27 release];
    [r19 release];
    [r21 release];
    [r23 release];
    [r20 release];
    [var_160 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10000facc
// +[BottleMenuHandler togglePreviewForBottle:withWindow:]
    [self togglePreviewForBottle:arg2 withWindow:arg3 modalCompletionHandler:0x0];
    return;


// 0x10000fad4
// +[BottleMenuHandler togglePreviewForBottle:withWindow:modalCompletionHandler:]
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
    r21 = [arg2 retain];
    r27 = [arg4 retain];
    r20 = [arg3 retain];
    r19 = [[NSAlert alloc] init];
    r23 = [r21 isIsPreviewEnabled];
    r25 = [[NSBundle mainBundle] retain];
    if (r23 != 0x0) {
            r26 = [[r25 localizedStringForKey:@"Disable for CrossOver Preview" value:@"" table:0x0] retain];
            [r19 setMessageText:r26];
            [r26 release];
            [r25 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 localizedStringForKey:@"Disabling this bottle for CrossOver Preview will cause any running applications in the bottle to quit. Are you sure you want to do this?" value:@"" table:0x0] retain];
            [r19 setInformativeText:r26];
            [r26 release];
            [r25 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r24 = [[r0 localizedStringForKey:@"Disable for CrossOver Preview" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r19 addButtonWithTitle:r24]);
            [r24 release];
            [r25 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r24 = r0;
            r23 = [[r0 localizedStringForKey:@"Cancel" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r19 addButtonWithTitle:r23]);
            [r23 release];
            [r24 release];
            var_80 = *__NSConcreteStackBlock;
            r22 = [r27 retain];
            r24 = [r21 retain];
            [r19 beginSheetModalForWindow:r20 completionHandler:&var_80];
            [r20 release];
            [r27 release];
            r23 = r21;
    }
    else {
            r26 = [[r25 localizedStringForKey:@"Enable for CrossOver Preview" value:@"" table:0x0] retain];
            [r19 setMessageText:r26];
            [r26 release];
            [r25 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 localizedStringForKey:@"WARNING: CrossOver Preview contains untested changes that may permanently break bottles." value:@"" table:0x0] retain];
            [r25 release];
            r25 = [[r26 stringByAppendingString:@"\n\n"] retain];
            [r26 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r24 = [[r0 localizedStringForKey:@"Enable for CrossOver Preview" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r19 addButtonWithTitle:r24]);
            [r24 release];
            [r26 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r22 = r27;
            r27 = [[r0 localizedStringForKey:@"Are you sure you want to enable the '%@' bottle for CrossOver Preview?" value:@"" table:0x0] retain];
            r28 = [[r21 name] retain];
            r0 = [NSString stringWithFormat:r27];
            r0 = [r0 retain];
            var_B8 = r20;
            r20 = r0;
            r24 = [[r25 stringByAppendingString:r20] retain];
            [r25 release];
            [r20 release];
            [r28 release];
            [r27 release];
            [r26 release];
            [r19 setInformativeText:r24];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r23 = [[r0 localizedStringForKey:@"Cancel" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r19 addButtonWithTitle:r23]);
            [r23 release];
            [r20 release];
            var_B0 = *__NSConcreteStackBlock;
            var_88 = r22;
            r23 = [r22 retain];
            r22 = [r21 retain];
            r20 = var_B8;
            [r19 beginSheetModalForWindow:r20 completionHandler:&var_B0];
            [r20 release];
            [var_88 release];
            [r21 release];
    }
    [r23 release];
    [r22 release];
    [r24 release];
    [r19 release];
    return;


// 0x1000100cc
// +[BottleMenuHandler quitBottle:]
    [arg2 quit:0x0];
    return;


// 0x1000100d8
// +[BottleMenuHandler forceQuitBottle:]
    [arg2 forceQuit:0x0];
    return;


// === Block Invocations for BottleMenuHandler ===

// 0x10000d624
// ___45+[BottleMenuHandler deleteBottle:withWindow:]_block_invoke
    r0 = arg0;
    if (r1 == 0x3e9) {
            r31 = r31 - 0x80;
            var_30 = r22;
            decomp_var_28 = r21;
            var_20 = r20;
            decomp_var_18 = r19;
            var_10 = r29;
            decomp_var_8 = r30;
            r20 = r0;
            r0 = r0[0x4];
            r0 = [r0 isIsManaged];
            r21 = r0;
            if (r0 != 0x0) {
                    r0 = [SFAuthorization authorization];
                    r0 = [r0 retain];
                    r19 = r0;
                    if ([r0 obtainWithRight:"system.privilege.admin" flags:0x13 error:0x0] == 0x0) {
                            [r19 release];
                    }
                    else {
                            [BottleMenuHandler rateBottle:r20[0x4] withWindow:r20[0x5] isDeleting:0x1];
                            r22 = [r20[0x4] retain];
                            [r20[0x6] retain];
                            [r20[0x5] retain];
                            r19 = [r19 retain];
                            [r22 delete:&var_78];
                            [var_40 release];
                            [var_48 release];
                            [var_50 release];
                            [var_58 release];
                            [r19 release];
                    }
            }
            else {
                    [BottleMenuHandler rateBottle:r20[0x4] withWindow:r20[0x5] isDeleting:0x1];
                    r22 = [r20[0x4] retain];
                    [r20[0x6] retain];
                    [r20[0x5] retain];
                    r19 = [0x0 retain];
                    [r22 delete:&var_78];
                    [var_40 release];
                    [var_48 release];
                    [var_50 release];
                    [var_58 release];
                    [r19 release];
            }
    }
    return;


// 0x10000d750
// ___45+[BottleMenuHandler deleteBottle:withWindow:]_block_invoke_2
    r31 = r31 - 0x80;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg0;
    r0 = arg0[0x4];
    r0 = [r0 isIsDeleted];
    if (r0 != 0x0) {
            r0 = [CXSetupLib bottleCollectionClass];
            r0 = [r0 sharedCollection];
            r0 = [r0 retain];
            r20 = r0;
            [r0 refresh];
            r0 = [r20 release];
    }
    else {
            if (r19[0x40] == 0x0) {
                    r20 = [[NSAlert alloc] init];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r22 = r0;
                    r23 = [[r0 localizedStringForKey:@"Failed to delete the bottle '%@'." value:@"" table:0x0] retain];
                    r21 = [[NSString stringWithFormat:r23] retain];
                    [r20 setMessageText:r21];
                    [r21 release];
                    [r23 release];
                    [r22 release];
                    [r20 beginSheetModalForWindow:r19[0x6] completionHandler:0x0];
                    r0 = [r20 release];
            }
    }
    if (r19[0x40] != 0x0) {
            r20 = [dispatch_get_global_queue(0x0, 0x0) retain];
            var_68 = *__NSConcreteStackBlock;
            var_48 = [r19[0x4] retain];
            var_40 = [r19[0x6] retain];
            var_38 = [r19[0x7] retain];
            dispatch_sync(r20, &var_68);
            [r20 release];
            [var_38 release];
            [var_40 release];
            r0 = [var_48 release];
    }
    return r0;


// 0x10000d91c
// ___45+[BottleMenuHandler deleteBottle:withWindow:]_block_invoke_3
    r0 = [BottleMenuHandler deleteManagedBottle:arg0[0x4] withWindow:arg0[0x5] authorization:arg0[0x6]];
    return r0;


// 0x10000db9c
// ___66+[BottleMenuHandler deleteManagedBottle:withWindow:authorization:]_block_invoke
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r19 = r0;
    [r0 refresh];
    [r19 release];
    return;


// 0x10000dbd8
// ___66+[BottleMenuHandler deleteManagedBottle:withWindow:authorization:]_block_invoke_2
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 localizedStringForKey:@"Could not obtain the authorization to delete files owned by the administrator." value:@"" table:0x0] retain];
    [r21 release];
    r21 = [[NSAlert alloc] init];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r22 = [[r0 localizedStringForKey:@"Failed to delete the published bottle '%@'." value:@"" table:0x0] retain];
    r23 = [[NSString stringWithFormat:r22] retain];
    [r21 setMessageText:r23];
    [r23 release];
    [r22 release];
    [r24 release];
    [r21 setInformativeText:r20];
    [r21 beginSheetModalForWindow:arg0[0x5] completionHandler:0x0];
    [r21 release];
    r0 = [r20 release];
    return r0;


// 0x10000e070
// ___45+[BottleMenuHandler exportBottle:withWindow:]_block_invoke
    r0 = arg0;
    if (r1 == 0x1) {
            r19 = r0;
            r0 = r0[0x4];
            r0 = [r0 URL];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 path];
            r0 = [r0 retain];
            r22 = r0;
            r20 = [[r0 stringInFileSystemRepresentationForm] retain];
            [r22 release];
            [r21 release];
            [r19[0x5] retain];
            dispatch_async(*__dispatch_main_q, &var_68);
            r21 = [dispatch_get_global_queue(0x0, 0x0) retain];
            [r19[0x6] retain];
            [r19[0x7] retain];
            [r19[0x5] retain];
            r19 = [r20 retain];
            dispatch_async(r21, &var_A8);
            [r21 release];
            [var_70 release];
            [var_78 release];
            [var_80 release];
            [var_88 release];
            [var_48 release];
            [r19 release];
    }
    return;


// 0x10000e1e0
// ___45+[BottleMenuHandler exportBottle:withWindow:]_block_invoke_2
    r19 = arg0[0x4];
    r20 = [[[CXSetupLib cxSetupClass] bottleStatus:@"ARCHIVING"] retain];
    [r19 addStatusOverride:r20];
    r0 = [r20 release];
    return r0;


// 0x10000e230
// ___45+[BottleMenuHandler exportBottle:withWindow:]_block_invoke.42
    r0 = [CXSetupLib bottleManagementClass];
    r0 = [r0 archiveBottle:arg0[0x4] toPath:arg0[0x5]];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 objectAtIndex:0x0];
    r0 = [r0 retain];
    r21 = r0;
    [r0 boolValue];
    [r21 release];
    var_68 = *__NSConcreteStackBlock;
    var_40 = [arg0[0x4] retain];
    var_38 = [arg0[0x6] retain];
    var_30 = [arg0[0x7] retain];
    r19 = [r20 retain];
    dispatch_async(*__dispatch_main_q, &var_68);
    [var_30 release];
    [var_38 release];
    [var_40 release];
    [r20 release];
    r0 = [r19 release];
    return r0;


// 0x10000e33c
// ___45+[BottleMenuHandler exportBottle:withWindow:]_block_invoke_2.43
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg0;
    if (arg0[0x40] == 0x0) {
            r0 = r19[0x4];
            r0 = [r0 objectAtIndex:0x1];
            r0 = [r0 retain];
            r20 = r0;
            if (r0 != 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [[r0 localizedStringForKey:@"Failed to export bottle '%@' to an archive." value:@"" table:0x0] retain];
                    [r21 release];
                    r21 = [[NSAlert alloc] init];
                    r23 = [[NSString stringWithFormat:r22] retain];
                    [r21 setMessageText:r23];
                    [r23 release];
                    [r21 setInformativeText:r20];
                    [r21 beginSheetModalForWindow:r19[0x6] completionHandler:0x0];
                    [r21 release];
                    [r22 release];
            }
            [r20 release];
    }
    r19 = r19[0x7];
    r20 = [[[CXSetupLib cxSetupClass] bottleStatus:@"ARCHIVING"] retain];
    [r19 removeStatusOverride:r20];
    r0 = [r20 release];
    return r0;


// 0x10000eae8
// ___40+[BottleMenuHandler openShellForBottle:]_block_invoke
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
    r21 = arg0;
    r19 = [arg1 retain];
    r20 = [arg2 retain];
    if (([r21[0x4] containsObject:r19] & 0x1) == 0x0) {
            r23 = [[r19 stringQuotedForBash] retain];
            r24 = [[r20 stringQuotedForBash] retain];
            r22 = [[NSString stringWithFormat:@"export %@=%@", r3, r4] retain];
            [r24 release];
            [r23 release];
            r24 = [[r22 stringQuotedForAppleScript] retain];
            r23 = [[NSString stringWithFormat:@"do script %@ in theWindow\ndelay 0.1\n", r3] retain];
            [r24 release];
            [r21[0x5] appendString:r23];
            [r23 release];
            [r22 release];
    }
    [r20 release];
    r0 = [r19 release];
    return r0;


// 0x10000ede4
// ___54+[BottleMenuHandler rateBottle:withWindow:isDeleting:]_block_invoke
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg0;
    r0 = [SubmitRatingController alloc];
    r0 = [r0 initWithBottle:r20[0x4] isNag:0x1 isDeleting:r20[0x30]];
    r19 = r0;
    if (r0 != 0x0) {
            r22 = r20[0x5];
            r21 = [[r19 window] retain];
            if (r22 != 0x0) {
                    [r22 beginSheet:r21 completionHandler:0x0];
            }
            else {
                    [r21 center];
                    [r21 release];
                    r0 = [r19 window];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 makeKeyAndOrderFront:r20[0x5]];
            }
            [r21 release];
    }
    r0 = [r19 release];
    return r0;


// 0x10000efbc
// ___41+[BottleMenuHandler toggleDefaultBottle:]_block_invoke
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r19 = r0;
    [r0 refreshDefaultBottle];
    [r19 release];
    return;


// 0x10000f37c
// ___76+[BottleMenuHandler toggleMSyncForBottle:withWindow:modalCompletionHandler:]_block_invoke
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg1;
    r20 = arg0;
    if (arg1 == 0x3e8) {
            r8 = r20[0x30];
            r0 = r20[0x4];
            if (r8 != 0x0) {
                    [r0 enableMSync];
            }
            else {
                    [r0 disableMSync];
            }
    }
    r0 = r20[0x5];
    if (r0 != 0x0) {
            r0 = (r0[0x2])();
    }
    return r0;


// 0x10000fa6c
// ___85+[BottleMenuHandler toggleHighResolutionForBottle:withWindow:modalCompletionHandler:]_block_invoke
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg1;
    r20 = arg0;
    if (arg1 == 0x3e8) {
            r8 = r20[0x30];
            r0 = r20[0x4];
            if (r8 != 0x0) {
                    [r0 enableHighResolution];
            }
            else {
                    [r0 disableHighResolution];
            }
    }
    r0 = r20[0x5];
    if (r0 != 0x0) {
            r0 = (r0[0x2])();
    }
    return r0;


// 0x10000ffe4
// ___78+[BottleMenuHandler togglePreviewForBottle:withWindow:modalCompletionHandler:]_block_invoke
    r31 = r31 - 0x50;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg1;
    r20 = arg0;
    if (arg1 == 0x3e8) {
            r0 = r20[0x4];
            var_38 = *__NSConcreteStackBlock;
            r0 = [r0 retain];
            var_18 = r0;
            [r0 quit:&var_38];
            [var_18 release];
    }
    r0 = r20[0x5];
    if (r0 != 0x0) {
            r0 = (r0[0x2])();
    }
    return r0;


// 0x100010074
// ___78+[BottleMenuHandler togglePreviewForBottle:withWindow:modalCompletionHandler:]_block_invoke_2
    r0 = arg0[0x4];
    r0 = [r0 disablePreview];
    return r0;


// 0x10001007c
// ___78+[BottleMenuHandler togglePreviewForBottle:withWindow:modalCompletionHandler:]_block_invoke.170
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg1;
    r20 = arg0;
    if (arg1 == 0x3e8) {
            [r20[0x4] enablePreview];
    }
    r0 = r20[0x5];
    if (r0 != 0x0) {
            r0 = (r0[0x2])();
    }
    return r0;


