// RosettaInstallationController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10002f174
// -[RosettaInstallationController init]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_30 = self;
    r0 = [[&var_30 super] initWithWindowNibName:@"RosettaInstallation"];
    r19 = r0;
    if (r0 != 0x0) {
            r20 = [[NSMutableArray alloc] init];
            [r19 setDetailsShownConstraints:r20];
            [r20 release];
            r20 = [[NSMutableArray alloc] init];
            [r19 setDetailsHiddenConstraints:r20];
            [r20 release];
    }
    r0 = r19;
    return r0;


// 0x10002f210
// -[RosettaInstallationController findDetailsConstraints:]
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
    r19 = self;
    var_60 = **___stack_chk_guard;
    r0 = [arg2 retain];
    var_1A0 = q0;
    var_190 = q0;
    var_1E8 = r0;
    r0 = [r0 constraints];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r28 = *var_190;
            do {
                    r20 = 0x0;
                    do {
                            if (*var_190 != r28) {
                                    objc_enumerationMutation(r21);
                            }
                            r25 = *(var_198 + r20 * 0x8);
                            r0 = [r25 identifier];
                            r0 = [r0 retain];
                            r26 = r0;
                            r27 = [r0 containsString:@"detailsShown"];
                            [r26 release];
                            if (r27 != 0x0) {
                                    r0 = [r19 detailsShownConstraints];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    [r0 addObject:r25];
                                    [r26 release];
                            }
                            r0 = [r25 identifier];
                            r0 = [r0 retain];
                            r26 = r0;
                            r27 = [r0 containsString:@"detailsHidden"];
                            [r26 release];
                            if (r27 != 0x0) {
                                    r0 = [r19 detailsHiddenConstraints];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    [r0 addObject:r25];
                                    [r26 release];
                            }
                            r20 = r20 + 0x1;
                    } while (r24 != r20);
                    r0 = [r21 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    var_1E0 = q0;
    var_1D0 = q0;
    r24 = var_1E8;
    r0 = [r24 subviews];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r20 = *var_1D0;
            do {
                    r23 = 0x0;
                    do {
                            if (*var_1D0 != r20) {
                                    objc_enumerationMutation(r21);
                            }
                            [r19 findDetailsConstraints:*(var_1D8 + r23 * 0x8)];
                            r23 = r23 + 0x1;
                    } while (r22 != r23);
                    r0 = [r21 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    [r24 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10002f474
// -[RosettaInstallationController windowDidLoad]
    var_40 = self;
    [[&var_40 super] windowDidLoad];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"To use %1$@, you need to install Rosetta. Do you want to install it now?" value:@"" table:0x0] retain];
    r20 = [[NSString stringWithFormat:r22] retain];
    r0 = [self titleLabel];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setStringValue:r20];
    [r23 release];
    [r20 release];
    [r22 release];
    [r21 release];
    r0 = [self licenseLabel];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 stringValue] retain];
    [r21 release];
    r21 = [[NSDataDetector dataDetectorWithTypes:0x20 error:0x0] retain];
    r0 = [r20 length];
    [r21 enumerateMatchesInString:r20 options:0x0 range:0x0 usingBlock:r0];
    r0 = [self progressSheet];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 contentView] retain];
    [self findDetailsConstraints:r23];
    [r23 release];
    [r22 release];
    r23 = [[self detailsShownConstraints] retain];
    [NSLayoutConstraint deactivateConstraints:r23];
    [r23 release];
    r19 = [[self detailsHiddenConstraints] retain];
    [NSLayoutConstraint activateConstraints:r19];
    [r19 release];
    [r21 release];
    [r20 release];
    return;


// 0x10002f8e8
// -[RosettaInstallationController exitButton:]
    [arg2 retain];
    _CXLog();
    exit(0x0);
    return;


// 0x10002f90c
// -[RosettaInstallationController installFailed]
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"Rosetta installation failed. %1$@ is unable to run, and will now quit." value:@"" table:0x0] retain];
    r20 = [[NSString stringWithFormat:r22] retain];
    r0 = [self progressSheetDetailsLabel];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setStringValue:r20];
    [r23 release];
    [r20 release];
    [r22 release];
    [r21 release];
    r20 = [[NSImage imageNamed:**_NSImageNameCaution] retain];
    r0 = [self progressSheetIcon];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setImage:r20];
    [r21 release];
    [r20 release];
    r0 = [self progressSheetDoneButton];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setTitle:@"Quit"];
    [r19 release];
    return;


// 0x10002fa58
// -[RosettaInstallationController installButton:]
    r31 = r31 - 0x120;
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
    r20 = self;
    var_68 = **___stack_chk_guard;
    r19 = [arg2 retain];
    _CXLog();
    r21 = [[r20 window] retain];
    r22 = [[r20 progressSheet] retain];
    r23 = *__NSConcreteStackBlock;
    var_A0 = r23;
    [r21 beginSheet:r22 completionHandler:&var_A0];
    [r22 release];
    [r21 release];
    r0 = [r20 progressSheetProgressIndicator];
    r0 = [r0 retain];
    r21 = r0;
    [r0 startAnimation:r20];
    [r21 release];
    r21 = [[NSTask alloc] init];
    [r20 setTask:r21];
    [r21 release];
    r21 = [[NSURL fileURLWithPath:@"/usr/sbin/softwareupdate" isDirectory:0x0] retain];
    r0 = [r20 task];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setExecutableURL:r21];
    [r22 release];
    [r21 release];
    var_78 = @"--install-rosetta";
    r0 = [NSArray arrayWithObjects:&var_78 count:0x2];
    r21 = [r0 retain];
    r0 = [r20 task];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setArguments:r21];
    [r22 release];
    [r21 release];
    objc_initWeak(&decomp_var_a8, r20);
    var_D0 = r23;
    r21 = &var_D0 + 0x20;
    r0 = objc_copyWeak(r21, &decomp_var_a8);
    r0 = [r20 task];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setTerminationHandler:&var_D0];
    [r22 release];
    r0 = [[NSPipe alloc] init];
    r22 = r0;
    var_F8 = r23;
    r0 = [r0 fileHandleForReading];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setReadabilityHandler:&var_F8];
    [r23 release];
    r0 = [r20 task];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setStandardOutput:r22];
    [r23 release];
    r0 = [r20 progressSheetTextView];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 textStorage];
    r0 = [r0 retain];
    r24 = r0;
    r0 = [r0 mutableString];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setString:@"% softwareupdate --install-rosetta --agree-to-license\n"];
    [r25 release];
    [r24 release];
    [r23 release];
    r0 = [r20 task];
    r0 = [r0 retain];
    r24 = r0;
    var_100 = 0x0;
    [r0 launchAndReturnError:&var_100];
    r23 = [var_100 retain];
    [r24 release];
    if (r23 != 0x0) {
            _CXLog();
            r0 = [r20 progressSheetTextView];
            r0 = [r0 retain];
            r24 = r0;
            r0 = [r0 textStorage];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 mutableString] retain];
            r27 = [[r23 localizedDescription] retain];
            [r26 setString:r27];
            [r27 release];
            [r26 release];
            [r25 release];
            [r24 release];
            [r20 installFailed];
            r0 = [r20 progressSheetProgressIndicator];
            r0 = [r0 retain];
            r24 = r0;
            [r0 setIndeterminate:0x0];
            [r24 release];
            r0 = [r20 progressSheetDoneButton];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setEnabled:0x1];
            [r20 release];
    }
    [r23 release];
    [r22 release];
    objc_destroyWeak(r21);
    objc_destroyWeak(&decomp_var_a8);
    [r19 release];
    if (**___stack_chk_guard != var_68) {
            __stack_chk_fail();
    }
    return;


// 0x100030394
// -[RosettaInstallationController sheetDoneButton:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if (___isPlatformVersionAtLeast(0x1, 0xb, 0x0, 0x0) != 0x0 && CFBundleIsArchitectureLoadable() == 0x0) {
            _CXLog();
            exit(0x0);
    }
    r21 = [[r20 window] retain];
    r20 = [[r20 progressSheet] retain];
    [r21 endSheet:r20];
    [r20 release];
    [r21 release];
    [r19 release];
    return;


// 0x100030448
// -[RosettaInstallationController sheetDetailDisclosureButton:]
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
    r19 = self;
    r20 = [arg2 retain];
    r0 = [r19 progressSheet];
    r0 = [r0 retain];
    r21 = r0;
    [r0 frame];
    d8 = d0;
    d9 = d1;
    d10 = d2;
    d11 = d3;
    [r21 release];
    r21 = [r20 state];
    [r20 release];
    r20 = [[NSBundle mainBundle] retain];
    if (r21 == 0x1) {
            r21 = [[r20 localizedStringForKey:@"Hide Details" value:@"" table:0x0] retain];
            r0 = [r19 progressSheetShowHideDetailsButton];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setTitle:r21];
            [r22 release];
            [r21 release];
            [r20 release];
            d11 = d11 + *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xca8);
            r0 = [r19 progressSheetScrollView];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setBorderType:0x1];
            [r20 release];
            r21 = [[r19 detailsHiddenConstraints] retain];
            [NSLayoutConstraint deactivateConstraints:r21];
            [r21 release];
            r20 = [[r19 detailsShownConstraints] retain];
            [NSLayoutConstraint activateConstraints:r20];
    }
    else {
            r21 = [[r20 localizedStringForKey:@"Show Details" value:@"" table:0x0] retain];
            r0 = [r19 progressSheetShowHideDetailsButton];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setTitle:r21];
            [r22 release];
            [r21 release];
            [r20 release];
            d11 = d11 + *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xca0);
            r0 = [r19 progressSheetScrollView];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setBorderType:0x0];
            [r20 release];
            r21 = [[r19 detailsHiddenConstraints] retain];
            [NSLayoutConstraint activateConstraints:r21];
            [r21 release];
            r20 = [[r19 detailsShownConstraints] retain];
            [NSLayoutConstraint deactivateConstraints:r20];
    }
    [r20 release];
    r0 = [r19 progressSheet];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setFrame:0x1 display:r3];
    [r19 release];
    return;


// 0x1000306e8
// -[RosettaInstallationController task]
    r0 = self->_task;
    return r0;


// 0x1000306f8
// -[RosettaInstallationController setTask:]
    objc_storeStrong((int64_t *)&self->_task, arg2);
    return;


// 0x10003070c
// -[RosettaInstallationController detailsShownConstraints]
    r0 = self->_detailsShownConstraints;
    return r0;


// 0x10003071c
// -[RosettaInstallationController setDetailsShownConstraints:]
    objc_storeStrong((int64_t *)&self->_detailsShownConstraints, arg2);
    return;


// 0x100030730
// -[RosettaInstallationController detailsHiddenConstraints]
    r0 = self->_detailsHiddenConstraints;
    return r0;


// 0x100030740
// -[RosettaInstallationController setDetailsHiddenConstraints:]
    objc_storeStrong((int64_t *)&self->_detailsHiddenConstraints, arg2);
    return;


// 0x100030754
// -[RosettaInstallationController licenseLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_licenseLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x100030774
// -[RosettaInstallationController setLicenseLabel:]
    objc_storeWeak((int64_t *)&self->_licenseLabel, arg2);
    return;


// 0x100030788
// -[RosettaInstallationController titleLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_titleLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x1000307a8
// -[RosettaInstallationController setTitleLabel:]
    objc_storeWeak((int64_t *)&self->_titleLabel, arg2);
    return;


// 0x1000307bc
// -[RosettaInstallationController progressSheet]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_progressSheet)), 0x1);
    return r0;


// 0x1000307cc
// -[RosettaInstallationController setProgressSheet:]
    objc_setProperty_atomic();
    return;


// 0x1000307d8
// -[RosettaInstallationController progressSheetDetailsLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetDetailsLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x1000307f8
// -[RosettaInstallationController setProgressSheetDetailsLabel:]
    objc_storeWeak((int64_t *)&self->_progressSheetDetailsLabel, arg2);
    return;


// 0x10003080c
// -[RosettaInstallationController progressSheetDoneButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetDoneButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10003082c
// -[RosettaInstallationController setProgressSheetDoneButton:]
    objc_storeWeak((int64_t *)&self->_progressSheetDoneButton, arg2);
    return;


// 0x100030840
// -[RosettaInstallationController progressSheetIcon]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetIcon);
    r0 = [r0 autorelease];
    return r0;


// 0x100030860
// -[RosettaInstallationController setProgressSheetIcon:]
    objc_storeWeak((int64_t *)&self->_progressSheetIcon, arg2);
    return;


// 0x100030874
// -[RosettaInstallationController progressSheetProgressIndicator]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetProgressIndicator);
    r0 = [r0 autorelease];
    return r0;


// 0x100030894
// -[RosettaInstallationController setProgressSheetProgressIndicator:]
    objc_storeWeak((int64_t *)&self->_progressSheetProgressIndicator, arg2);
    return;


// 0x1000308a8
// -[RosettaInstallationController progressSheetShowHideDetailsButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetShowHideDetailsButton);
    r0 = [r0 autorelease];
    return r0;


// 0x1000308c8
// -[RosettaInstallationController setProgressSheetShowHideDetailsButton:]
    objc_storeWeak((int64_t *)&self->_progressSheetShowHideDetailsButton, arg2);
    return;


// 0x1000308dc
// -[RosettaInstallationController progressSheetScrollView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetScrollView);
    r0 = [r0 autorelease];
    return r0;


// 0x1000308fc
// -[RosettaInstallationController setProgressSheetScrollView:]
    objc_storeWeak((int64_t *)&self->_progressSheetScrollView, arg2);
    return;


// 0x100030910
// -[RosettaInstallationController progressSheetTextView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetTextView);
    r0 = [r0 autorelease];
    return r0;


// 0x100030930
// -[RosettaInstallationController setProgressSheetTextView:]
    objc_storeWeak((int64_t *)&self->_progressSheetTextView, arg2);
    return;


// 0x100030944
// -[RosettaInstallationController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_progressSheetTextView);
    objc_destroyWeak((int64_t *)&self->_progressSheetScrollView);
    objc_destroyWeak((int64_t *)&self->_progressSheetShowHideDetailsButton);
    objc_destroyWeak((int64_t *)&self->_progressSheetProgressIndicator);
    objc_destroyWeak((int64_t *)&self->_progressSheetIcon);
    objc_destroyWeak((int64_t *)&self->_progressSheetDoneButton);
    objc_destroyWeak((int64_t *)&self->_progressSheetDetailsLabel);
    objc_storeStrong((int64_t *)&self->_progressSheet, 0x0);
    objc_destroyWeak((int64_t *)&self->_titleLabel);
    objc_destroyWeak((int64_t *)&self->_licenseLabel);
    objc_storeStrong((int64_t *)&self->_detailsHiddenConstraints, 0x0);
    objc_storeStrong((int64_t *)&self->_detailsShownConstraints, 0x0);
    objc_storeStrong((int64_t *)&self->_task, 0x0);
    return;


