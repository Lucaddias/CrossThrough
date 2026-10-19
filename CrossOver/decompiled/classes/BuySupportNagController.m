// BuySupportNagController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100057134
// -[BuySupportNagController initWithAppcastItem:]
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
    r20 = arg2;
    r21 = self;
    r19 = [arg2 retain];
    r0 = objc_opt_class(r21);
    r0 = [NSBundle bundleForClass:r0];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [[r0 pathForResource:@"BuySupportNag" ofType:@"nib"] retain];
    [r23 release];
    if (r22 == 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 sharedFrameworksPath];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [[r0 stringByAppendingPathComponent:@"Sparkle.framework"] retain];
            [r23 release];
            [r22 release];
            r0 = [NSBundle bundleWithPath:r24];
            r0 = [r0 retain];
            r23 = r0;
            r22 = [[r0 pathForResource:@"BuySupportNag" ofType:@"nib"] retain];
            [r23 release];
            [r24 release];
    }
    var_50 = r21;
    r0 = [[&var_50 super] initWithWindowNibPath:r22 owner:r21];
    r21 = r0;
    if (r0 != 0x0) {
            objc_storeStrong((int64_t *)&r21->_updateItem, r20);
            [r21 setShouldCascadeWindows:0x0];
    }
    [r22 release];
    [r19 release];
    r0 = r21;
    return r0;


// 0x1000572c8
// -[BuySupportNagController setOwnsSelf:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg2;
    r20 = self;
    if (*_selfOwnedControllers == 0x0) {
            r0 = [[NSMutableArray alloc] init];
            r8 = *_selfOwnedControllers;
            *_selfOwnedControllers = r0;
            [r8 release];
    }
    r22 = sign_extend_64(*(int32_t *)ivar_offset(ownsSelf));
    if (*(int8_t *)(r20 + r22) != 0x0 && (r19 & 0x1) == 0x0) {
            [*_selfOwnedControllers removeObject:r20];
    }
    asm { ccmp       w19, #0x0, #0x4, eq };
    if (!asm { ccmp       w19, #0x0, #0x4, eq }) {
            [*_selfOwnedControllers addObject:r20];
    }
    *(int8_t *)(r20 + r22) = r19;
    return;


// 0x100057358
// -[BuySupportNagController bundleVersion]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 objectForInfoDictionaryKey:**_kCFBundleVersionKey] retain];
    [r20 release];
    r20 = @"";
    if (r19 != 0x0) {
            if ([r19 length] != 0x0) {
                    r20 = r19;
            }
    }
    r20 = objc_retainAutoreleaseReturnValue(r20);
    [r19 release];
    r0 = r20;
    return r0;


// 0x1000573e0
// -[BuySupportNagController bundleDisplayVersion]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 objectForInfoDictionaryKey:@"CFBundleShortVersionString"] retain];
    [r21 release];
    if (r19 != 0x0) {
            r0 = [r19 retain];
    }
    else {
            r0 = [r20 bundleVersion];
            r0 = [r0 retain];
    }
    [r19 release];
    r0 = [r0 autorelease];
    return r0;


// 0x10005746c
// -[BuySupportNagController bundleName]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 objectForInfoDictionaryKey:@"SUBundleName"] retain];
    [r20 release];
    if (r19 != 0x0) {
            if ([r19 length] == 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r21 = r0;
                    r20 = [[r0 objectForInfoDictionaryKey:@"CFBundleDisplayName"] retain];
                    [r19 release];
                    [r21 release];
                    if (r20 != 0x0) {
                            if ([r20 length] != 0x0) {
                                    r19 = r20;
                                    r0 = [r19 retain];
                                    r20 = r0;
                                    r19 = r0;
                                    [r19 release];
                                    r0 = [r20 autorelease];
                            }
                            else {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r19 = [[r0 objectForInfoDictionaryKey:**_kCFBundleNameKey] retain];
                                    [r20 release];
                                    [r21 release];
                                    if (r19 != 0x0 && [r19 length] != 0x0) {
                                            r0 = [r19 retain];
                                            r20 = r0;
                                            r19 = r0;
                                    }
                                    else {
                                            r20 = @"";
                                    }
                                    [r19 release];
                                    r0 = [r20 autorelease];
                            }
                    }
                    else {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r21 = r0;
                            r19 = [[r0 objectForInfoDictionaryKey:**_kCFBundleNameKey] retain];
                            [r20 release];
                            [r21 release];
                            if (r19 != 0x0 && [r19 length] != 0x0) {
                                    r0 = [r19 retain];
                                    r20 = r0;
                                    r19 = r0;
                            }
                            else {
                                    r20 = @"";
                            }
                            [r19 release];
                            r0 = [r20 autorelease];
                    }
            }
            else {
                    r0 = [r19 retain];
                    r20 = r0;
                    r19 = r0;
                    [r19 release];
                    r0 = [r20 autorelease];
            }
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 objectForInfoDictionaryKey:@"CFBundleDisplayName"] retain];
            [r19 release];
            [r21 release];
            if (r20 != 0x0) {
                    if ([r20 length] != 0x0) {
                            r19 = r20;
                            r0 = [r19 retain];
                            r20 = r0;
                            r19 = r0;
                            [r19 release];
                            r0 = [r20 autorelease];
                    }
                    else {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r21 = r0;
                            r19 = [[r0 objectForInfoDictionaryKey:**_kCFBundleNameKey] retain];
                            [r20 release];
                            [r21 release];
                            if (r19 != 0x0 && [r19 length] != 0x0) {
                                    r0 = [r19 retain];
                                    r20 = r0;
                                    r19 = r0;
                            }
                            else {
                                    r20 = @"";
                            }
                            [r19 release];
                            r0 = [r20 autorelease];
                    }
            }
            else {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r21 = r0;
                    r19 = [[r0 objectForInfoDictionaryKey:**_kCFBundleNameKey] retain];
                    [r20 release];
                    [r21 release];
                    if (r19 != 0x0 && [r19 length] != 0x0) {
                            r0 = [r19 retain];
                            r20 = r0;
                            r19 = r0;
                    }
                    else {
                            r20 = @"";
                    }
                    [r19 release];
                    r0 = [r20 autorelease];
            }
    }
    return r0;


// 0x1000575a0
// -[BuySupportNagController descriptionText]
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
    r19 = self;
    r0 = [self updateItem];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 displayVersionString] retain];
    [r20 release];
    r20 = [[r19 bundleDisplayVersion] retain];
    if ([r21 isEqualToString:r20] != 0x0) {
            r0 = [r19 updateItem];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 versionString] retain];
            r25 = [[r21 stringByAppendingFormat:@" (%@)", r3] retain];
            [r21 release];
            [r23 release];
            [r22 release];
            r21 = [[r19 bundleVersion] retain];
            r22 = [[r20 stringByAppendingFormat:@" (%@)", r3] retain];
            [r20 release];
            [r21 release];
            r21 = r25;
            r20 = r22;
    }
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"%1$@ %2$@ is now available – you have %3$@." value:@"" table:0x0] retain];
    r19 = [[r19 bundleName] retain];
    r22 = [[NSString stringWithFormat:r24] retain];
    [r19 release];
    [r24 release];
    [r23 release];
    [r20 release];
    [r21 release];
    r0 = [r22 autorelease];
    return r0;


// 0x100057774
// -[BuySupportNagController buyNow:]
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 localizedStringForKey:@"https://www.codeweavers.com/store/renewal/" value:@"" table:@"Vendor"] retain];
    [r19 release];
    r19 = [[NSWorkspace sharedWorkspace] retain];
    r21 = [[NSURL URLWithString:r20] retain];
    [r19 openURL:r21];
    [r21 release];
    [r19 release];
    [r20 release];
    return;


// 0x100057830
// -[BuySupportNagController windowDidLoad]
    r31 = r31 - 0x80;
    var_60 = d11;
    decomp_var_58 = d10;
    var_50 = d9;
    decomp_var_48 = d8;
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
    r0 = [self notEntitledLabel];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 attributedStringValue];
    r0 = [r0 retain];
    r22 = r0;
    r20 = [r0 mutableCopy];
    [r22 release];
    [r21 release];
    r22 = [[r20 string] retain];
    r0 = [r19 refreshRegistrationButton];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 title] retain];
    r21 = [[NSString stringWithFormat:r22] retain];
    [r24 release];
    [r23 release];
    [r22 release];
    if (([r19 registrationRefreshEnough] & 0x1) == 0x0) {
            r22 = [[r21 stringByAppendingString:@" "] retain];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r23 = [[r0 localizedStringForKey:@"If your support has expired, click '%@' to receive this and future upgrades." value:@"" table:0x0] retain];
            [r21 release];
            r0 = [r19 buySupportExtensionButton];
            r0 = [r0 retain];
            r24 = r0;
            r25 = [[r0 title] retain];
            r21 = [[r22 stringByAppendingFormat:r23] retain];
            [r22 release];
            [r25 release];
            [r24 release];
            [r23 release];
    }
    r3 = [r20 length];
    [r20 replaceCharactersInRange:0x0 withString:r3];
    r0 = [r19 notEntitledLabel];
    r0 = [r0 retain];
    r22 = r0;
    r2 = r20;
    [r0 setAttributedStringValue:r2];
    [r22 release];
    if ([r19 registrationRefreshEnough] != 0x0) {
            r0 = [r19 window];
            r0 = [r0 retain];
            r22 = r0;
            [r0 layoutIfNeeded];
            [r22 release];
            r22 = [[r19 buySupportExtensionButton] retain];
            r0 = [r19 buySupportExtensionButton];
            r0 = [r0 retain];
            r23 = r0;
            [r0 frame];
            [r22 alignmentRectForFrame:r2];
            [r23 release];
            [r22 release];
            r22 = [[r19 refreshRegistrationButton] retain];
            r0 = [r19 refreshRegistrationButton];
            r0 = [r0 retain];
            r23 = r0;
            [r0 frame];
            [r22 alignmentRectForFrame:r2];
            [r23 release];
            [r22 release];
            d0 = d8 + d9 - d10 + d11;
            r23 = sign_extend_64(*(int32_t *)ivar_offset(_widthAdjustment));
            d1 = d10 - d8;
            if (d0 < 0x0) {
                    d0 = d1;
            }
            *(r19 + r23) = d0;
            r0 = [r19 refreshRegistrationToBuySupportSpacer];
            r0 = [r0 retain];
            r22 = r0;
            [r0 constant];
            [r22 setConstant:r2];
            [r22 release];
            r0 = [r19 window];
            r0 = [r0 retain];
            r22 = r0;
            [r0 frame];
            [r22 release];
            r0 = [r19 window];
            r0 = [r0 retain];
            r22 = r0;
            d0 = d8;
            [r0 setFrame:0x1 display:r3];
            [r22 release];
            r22 = [[r19 window] retain];
            r0 = [r19 refreshRegistrationButton];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [[r0 cell] retain];
            r2 = r24;
            [r22 setDefaultButtonCell:r2];
            [r24 release];
            [r23 release];
            [r22 release];
    }
    if (([r19 showsReleaseNotes] & 0x1) == 0x0) {
            r0 = [r19 notEntitledLabelToReleaseNotesBoxSpacer];
            r0 = [r0 retain];
            r22 = r0;
            [r0 constant];
            [r22 setConstant:r2];
            [r22 release];
            r0 = [r19 notEntitledLabelToDescriptionLabelSpacer];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setPriority:r2];
            [r22 release];
    }
    if ([**_NSApp activationPolicy] != 0x0) {
            r0 = [r19 window];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setLevel:0x3];
            [r22 release];
    }
    r0 = [r19 window];
    r0 = [r0 retain];
    r22 = r0;
    [r0 center];
    [r22 release];
    if ([r19 showsReleaseNotes] != 0x0) {
            [r19 displayReleaseNotes];
    }
    [r21 release];
    [r20 release];
    return;


// 0x100057cfc
// -[BuySupportNagController windowShouldClose:]
    [self endWithSelection];
    return 0x1;


// 0x100057d14
// -[BuySupportNagController windowWillClose:]
    var_40 = d11;
    decomp_var_38 = d10;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = d9;
    decomp_var_28 = d8;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if ([r20 registrationRefreshEnough] != 0x0) {
            r0 = [r20 window];
            r0 = [r0 retain];
            r21 = r0;
            [r0 orderOut:r20];
            [r21 release];
            r0 = [r20 window];
            r0 = [r0 retain];
            r21 = r0;
            [r0 frame];
            [r21 release];
            r0 = [r20 window];
            r0 = [r0 retain];
            r21 = r0;
            [r0 setFrame:0x0 display:r3];
            [r21 release];
    }
    if (*(int8_t *)(r20 + sign_extend_64(*(int32_t *)ivar_offset(ownsSelf))) != 0x0) {
            if ([r20 isWindowLoaded] != 0x0) {
                    r21 = [[r19 object] retain];
                    r0 = [r20 window];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 release];
                    [r21 release];
                    if (r21 == r22) {
                            r21 = *_selfOwnedControllers;
                            r0 = [r20 window];
                            r0 = [r0 retain];
                            r20 = r0;
                            r22 = [[r0 windowController] retain];
                            [r21 removeObject:r22];
                            [r22 release];
                            [r20 release];
                    }
            }
    }
    [r19 release];
    return;


// 0x100057e9c
// -[BuySupportNagController remindMeLater:]
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObjectForKey:@"SUSkippedVersion"];
    [r20 release];
    [self endWithSelection];
    return;


// 0x100057ee8
// -[BuySupportNagController refreshRegistration:]
    r0 = [[DemoRegisterController alloc] init];
    r20 = r0;
    [r0 setRefreshLicenseMode:0x1];
    [r20 showWindow:self];
    [self remindMeLater:0x0];
    [r20 release];
    return;


// 0x100057f38
// -[BuySupportNagController skipThisVersion:]
    r20 = [[NSUserDefaults standardUserDefaults] retain];
    r0 = [self updateItem];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 versionString] retain];
    [r20 setObject:r22 forKey:@"SUSkippedVersion"];
    [r22 release];
    [r21 release];
    [r20 release];
    [self endWithSelection];
    return;


// 0x100057fc8
// -[BuySupportNagController applicationIcon]
    r0 = **_NSApp;
    r0 = [r0 applicationIconImage];
    return r0;


// 0x100057fd8
// -[BuySupportNagController showsReleaseNotes]
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
    r24 = self;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 objectForInfoDictionaryKey:@"SUShowReleaseNotes"] retain];
    [r20 release];
    if (r19 != 0x0) {
            r24 = [r19 boolValue];
            [r19 release];
            r0 = r24;
    }
    else {
            r0 = [r24 updateItem];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 itemDescription];
            r0 = [r0 retain];
            r21 = r0;
            if (r0 != 0x0) {
                    r0 = [r24 updateItem];
                    r0 = [r0 retain];
                    r22 = r0;
                    r23 = [[r0 itemDescription] retain];
                    r25 = [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
                    r0 = [r23 stringByTrimmingCharactersInSet:r25];
                    r0 = [r0 retain];
                    r26 = r0;
                    if ([r0 length] != 0x0) {
                            [r26 release];
                            [r25 release];
                            [r23 release];
                            [r22 release];
                            [r21 release];
                            [r20 release];
                            [r19 release];
                            r0 = 0x1;
                    }
                    else {
                            r0 = [r24 updateItem];
                            r0 = [r0 retain];
                            r27 = r0;
                            r0 = [r0 releaseNotesURL];
                            r0 = [r0 retain];
                            if (r0 != 0x0) {
                                    r24 = 0x1;
                            }
                            [r0 release];
                            [r27 release];
                            if (r21 != 0x0) {
                                    [r26 release];
                                    [r25 release];
                                    [r23 release];
                                    [r22 release];
                            }
                            [r21 release];
                            [r20 release];
                            [r19 release];
                            r0 = r24;
                    }
            }
            else {
                    r0 = [r24 updateItem];
                    r0 = [r0 retain];
                    r27 = r0;
                    r0 = [r0 releaseNotesURL];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r24 = 0x1;
                    }
                    [r0 release];
                    [r27 release];
                    if (r21 != 0x0) {
                            [r26 release];
                            [r25 release];
                            [r23 release];
                            [r22 release];
                    }
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    r0 = r24;
            }
    }
    return r0;


// 0x100058160
// -[BuySupportNagController titleText]
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"A new version of %@ is available!" value:@"" table:0x0] retain];
    r19 = [[self bundleName] retain];
    r20 = [[NSString stringWithFormat:r22] retain];
    [r19 release];
    [r22 release];
    [r21 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10005821c
// -[BuySupportNagController displayReleaseNotes]
    var_50 = d9;
    decomp_var_48 = d8;
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
    r19 = self;
    r0 = [self releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setPreferencesIdentifier:@"org.sparkle-project.Sparkle"];
    [r20 release];
    r0 = [NSFont systemFontOfSize:r2];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 familyName] retain];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 preferences];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setStandardFontFamily:r21];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    [NSFont systemFontSizeForControlSize:0x1];
    asm { fcvtzs     w20, d0 };
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 preferences];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setDefaultFontSize:r20];
    [r22 release];
    [r21 release];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setFrameLoadDelegate:r19];
    [r20 release];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setPolicyDelegate:r19];
    [r20 release];
    r20 = [[NSProgressIndicator alloc] initWithFrame:r2];
    [r19 setReleaseNotesSpinner:r20];
    [r20 release];
    r0 = [r19 releaseNotesSpinner];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setStyle:0x1];
    [r20 release];
    r0 = [r19 releaseNotesSpinner];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setTranslatesAutoresizingMaskIntoConstraints:0x0];
    [r20 release];
    r0 = [r19 releaseNotesSpinner];
    r0 = [r0 retain];
    r20 = r0;
    [r0 startAnimation:r19];
    [r20 release];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 superview] retain];
    r22 = [[r19 releaseNotesSpinner] retain];
    [r21 addSubview:r22];
    [r22 release];
    [r21 release];
    [r20 release];
    r21 = [[r19 releaseNotesSpinner] retain];
    r22 = [[NSLayoutConstraint constraintWithItem:r21 attribute:0x7 relatedBy:0x0 toItem:0x0 attribute:0x0 multiplier:r7 constant:var_50] retain];
    [r21 release];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 superview];
    r0 = [r0 retain];
    r21 = r0;
    [r0 addConstraint:r22];
    [r21 release];
    [r20 release];
    r21 = [[r19 releaseNotesSpinner] retain];
    r23 = [[r19 releaseNotesSpinner] retain];
    r20 = [[NSLayoutConstraint constraintWithItem:r21 attribute:0x7 relatedBy:0x0 toItem:r23 attribute:0x8 multiplier:r7 constant:var_50] retain];
    [r22 release];
    [r23 release];
    [r21 release];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 superview];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addConstraint:r20];
    [r22 release];
    [r21 release];
    r22 = [[r19 releaseNotesSpinner] retain];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 superview] retain];
    r21 = [[NSLayoutConstraint constraintWithItem:r22 attribute:0x9 relatedBy:0x0 toItem:r24 attribute:0x9 multiplier:r7 constant:var_50] retain];
    [r20 release];
    [r24 release];
    [r23 release];
    [r22 release];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 superview];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addConstraint:r21];
    [r22 release];
    [r20 release];
    r22 = [[r19 releaseNotesSpinner] retain];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 superview] retain];
    r20 = [[NSLayoutConstraint constraintWithItem:r22 attribute:0xa relatedBy:0x0 toItem:r24 attribute:0xa multiplier:r7 constant:var_50] retain];
    [r21 release];
    [r24 release];
    [r23 release];
    [r22 release];
    r0 = [r19 releaseNotesView];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 superview];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addConstraint:r20];
    [r22 release];
    [r21 release];
    *(int8_t *)(int64_t *)&r19->_webViewFinishedLoading = 0x0;
    r0 = [r19 updateItem];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 releaseNotesURL];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    [r21 release];
    r0 = r19;
    if (r22 != 0x0) {
            r0 = [r0 updateItem];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 releaseNotesURL];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [r0 isFileURL];
            [r22 release];
            [r21 release];
            r0 = [r19 releaseNotesView];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 mainFrame] retain];
            if (r23 != 0x0) {
                    [r22 loadHTMLString:@"Release notes with file:// URLs are not supported for security reasons&mdash;Javascript would be able to read files on your file system." baseURL:0x0];
            }
            else {
                    r0 = [r19 updateItem];
                    r0 = [r0 retain];
                    r19 = r0;
                    r24 = [[r0 releaseNotesURL] retain];
                    r23 = [[NSURLRequest requestWithURL:r24 cachePolicy:0x1 timeoutInterval:r4] retain];
                    [r22 loadRequest:r23];
                    [r23 release];
                    r0 = r24;
                    [r0 release];
                    [r19 release];
            }
    }
    else {
            r0 = [r0 releaseNotesView];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 mainFrame] retain];
            r0 = [r19 updateItem];
            r0 = [r0 retain];
            r19 = r0;
            r23 = [[r0 itemDescription] retain];
            [r22 loadHTMLString:r23 baseURL:0x0];
            r0 = r23;
            [r0 release];
            [r19 release];
    }
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x1000588fc
// -[BuySupportNagController endWithSelection]
    r0 = [self releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 stopLoading:self];
    [r20 release];
    r0 = [self releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setFrameLoadDelegate:0x0];
    [r20 release];
    r0 = [self releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setPolicyDelegate:0x0];
    [r20 release];
    r0 = [self releaseNotesView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeFromSuperview];
    [r20 release];
    [self close];
    return;


// 0x1000589a4
// -[BuySupportNagController webView:didFinishLoadForFrame:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r0 = [arg3 parentFrame];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    if (r21 == 0x0) {
            *(int8_t *)(int64_t *)&r20->_webViewFinishedLoading = 0x1;
            r0 = [r20 releaseNotesSpinner];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setHidden:0x1];
            [r20 release];
            [r19 display];
    }
    [r19 release];
    return;


// 0x100058a34
// -[BuySupportNagController webView:decidePolicyForNavigationAction:request:frame:decisionListener:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg6;
    r20 = [arg4 retain];
    if (*(int8_t *)(self + sign_extend_64(*(int32_t *)ivar_offset(_webViewFinishedLoading))) != 0x0) {
            r22 = [r19 retain];
            r21 = [[NSWorkspace sharedWorkspace] retain];
            r23 = [[r20 URL] retain];
            [r21 openURL:r23];
            [r23 release];
            [r21 release];
            [r22 ignore];
    }
    else {
            [[r19 retain] use];
    }
    [r19 release];
    [r20 release];
    return;


// 0x100058afc
// -[BuySupportNagController webView:contextMenuItemsForElement:defaultMenuItems:]
    r31 = r31 - 0x130;
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
    var_58 = **___stack_chk_guard;
    r0 = [arg4 retain];
    r20 = r0;
    r0 = [r0 mutableCopy];
    r19 = r0;
    if (r0 != 0x0) {
            var_120 = q0;
            var_110 = q0;
            r0 = [r20 retain];
            r21 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
            if (r0 != 0x0) {
                    r22 = r0;
                    r24 = *var_110;
                    do {
                            r27 = 0x0;
                            do {
                                    if (*var_110 != r24) {
                                            objc_enumerationMutation(r21);
                                    }
                                    r23 = *(var_118 + r27 * 0x8);
                                    0x1 << [r23 tag] & 0x1eb6;
                                    asm { ccmp       x8, #0x0, #0x4, ls };
                                    if (!asm { ccmp       x8, #0x0, #0x4, ls }) {
                                            [r19 removeObjectIdenticalTo:r23];
                                    }
                                    r27 = r27 + 0x1;
                            } while (r22 != r27);
                            r0 = [r21 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
                            r22 = r0;
                    } while (r0 != 0x0);
            }
            [r21 release];
    }
    r0 = [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x100058c48
// -[BuySupportNagController notEntitledLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_notEntitledLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x100058c68
// -[BuySupportNagController setNotEntitledLabel:]
    objc_storeWeak((int64_t *)&self->_notEntitledLabel, arg2);
    return;


// 0x100058c7c
// -[BuySupportNagController refreshRegistrationButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_refreshRegistrationButton);
    r0 = [r0 autorelease];
    return r0;


// 0x100058c9c
// -[BuySupportNagController setRefreshRegistrationButton:]
    objc_storeWeak((int64_t *)&self->_refreshRegistrationButton, arg2);
    return;


// 0x100058cb0
// -[BuySupportNagController buySupportExtensionButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_buySupportExtensionButton);
    r0 = [r0 autorelease];
    return r0;


// 0x100058cd0
// -[BuySupportNagController setBuySupportExtensionButton:]
    objc_storeWeak((int64_t *)&self->_buySupportExtensionButton, arg2);
    return;


// 0x100058ce4
// -[BuySupportNagController releaseNotesView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_releaseNotesView);
    r0 = [r0 autorelease];
    return r0;


// 0x100058d04
// -[BuySupportNagController setReleaseNotesView:]
    objc_storeWeak((int64_t *)&self->_releaseNotesView, arg2);
    return;


// 0x100058d18
// -[BuySupportNagController registrationRefreshEnough]
    r0 = *(int8_t *)(int64_t *)&self->_registrationRefreshEnough & 0x1;
    return r0;


// 0x100058d2c
// -[BuySupportNagController setRegistrationRefreshEnough:]
    *(int8_t *)(int64_t *)&self->_registrationRefreshEnough = arg2;
    return;


// 0x100058d3c
// -[BuySupportNagController refreshRegistrationToBuySupportSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_refreshRegistrationToBuySupportSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x100058d5c
// -[BuySupportNagController setRefreshRegistrationToBuySupportSpacer:]
    objc_storeWeak((int64_t *)&self->_refreshRegistrationToBuySupportSpacer, arg2);
    return;


// 0x100058d70
// -[BuySupportNagController notEntitledLabelToReleaseNotesBoxSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_notEntitledLabelToReleaseNotesBoxSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x100058d90
// -[BuySupportNagController setNotEntitledLabelToReleaseNotesBoxSpacer:]
    objc_storeWeak((int64_t *)&self->_notEntitledLabelToReleaseNotesBoxSpacer, arg2);
    return;


// 0x100058da4
// -[BuySupportNagController notEntitledLabelToDescriptionLabelSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_notEntitledLabelToDescriptionLabelSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x100058dc4
// -[BuySupportNagController setNotEntitledLabelToDescriptionLabelSpacer:]
    objc_storeWeak((int64_t *)&self->_notEntitledLabelToDescriptionLabelSpacer, arg2);
    return;


// 0x100058dd8
// -[BuySupportNagController updateItem]
    r0 = self->_updateItem;
    return r0;


// 0x100058de8
// -[BuySupportNagController setUpdateItem:]
    objc_storeStrong((int64_t *)&self->_updateItem, arg2);
    return;


// 0x100058dfc
// -[BuySupportNagController releaseNotesSpinner]
    r0 = self->_releaseNotesSpinner;
    return r0;


// 0x100058e0c
// -[BuySupportNagController setReleaseNotesSpinner:]
    objc_storeStrong((int64_t *)&self->_releaseNotesSpinner, arg2);
    return;


// 0x100058e20
// -[BuySupportNagController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_releaseNotesSpinner, 0x0);
    objc_storeStrong((int64_t *)&self->_updateItem, 0x0);
    objc_destroyWeak((int64_t *)&self->_notEntitledLabelToDescriptionLabelSpacer);
    objc_destroyWeak((int64_t *)&self->_notEntitledLabelToReleaseNotesBoxSpacer);
    objc_destroyWeak((int64_t *)&self->_refreshRegistrationToBuySupportSpacer);
    objc_destroyWeak((int64_t *)&self->_releaseNotesView);
    objc_destroyWeak((int64_t *)&self->_buySupportExtensionButton);
    objc_destroyWeak((int64_t *)&self->_refreshRegistrationButton);
    objc_destroyWeak((int64_t *)&self->_notEntitledLabel);
    return;


