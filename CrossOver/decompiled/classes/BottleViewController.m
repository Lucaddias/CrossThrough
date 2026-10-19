// BottleViewController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001f470
// -[BottleViewController init]
    r31 = r31 - 0xc0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_18 = **___stack_chk_guard;
    var_A8 = self;
    r0 = [[&var_A8 super] initWithNibName:@"BottleView" bundle:0x0];
    r19 = r0;
    if (r0 != 0x0) {
            var_98 = @"canForceQuit";
            r0 = [NSArray arrayWithObjects:&var_98 count:0x10];
            r20 = [r0 retain];
            [r19 setObservers:r20];
            r0 = [r20 release];
    }
    if (**___stack_chk_guard != var_18) {
            __stack_chk_fail();
    }
    r0 = r19;
    return r0;


// 0x10001f5c4
// -[BottleViewController dealloc]
    r31 = r31 - 0x130;
    var_40 = r28;
    decomp_var_38 = r27;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_48 = **___stack_chk_guard;
    r0 = **_NSApp;
    r0 = [r0 CXServer];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:r19 forKeyPath:@"launchers"];
    [r20 release];
    var_110 = q0;
    var_100 = q0;
    r0 = [r19 observers];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r22 = *var_100;
            do {
                    r24 = 0x0;
                    do {
                            if (*var_100 != r22) {
                                    objc_enumerationMutation(r20);
                            }
                            [r19->_bottle removeObserver:r19 forKeyPath:*(var_108 + r24 * 0x8)];
                            r24 = r24 + 0x1;
                    } while (r21 != r24);
                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    r0 = [r19 iconCollectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:0x0];
    [r20 release];
    var_120 = r19;
    [[&var_120 super] dealloc];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x10001f748
// -[BottleViewController viewDidLoad]
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
    var_58 = **___stack_chk_guard;
    var_80 = self;
    [[&var_80 super] viewDidLoad];
    r20 = [[IconCollectionViewController alloc] init];
    [self setIconCollectionViewController:r20];
    [r20 release];
    r0 = [self iconCollectionViewController];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 view] retain];
    [r21 release];
    var_60 = r20;
    r0 = [NSArray arrayWithObjects:&var_60 count:0x1];
    r21 = [r0 retain];
    r0 = [self iconCollectionView];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setSubviews:r21];
    [r22 release];
    [r21 release];
    r21 = [_NSDictionaryOfVariableBindings(@"view", r20) retain];
    r22 = [[self iconCollectionView] retain];
    r23 = [[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0x0 metrics:0x0 views:r21] retain];
    [r22 addConstraints:r23];
    [r23 release];
    [r22 release];
    r22 = [[self iconCollectionView] retain];
    r23 = [[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0x0 metrics:0x0 views:r21] retain];
    [r22 addConstraints:r23];
    [r23 release];
    [r22 release];
    r0 = [self iconCollectionViewController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setMargins:r2];
    [r22 release];
    r0 = [self iconCollectionViewController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setDelegate:self];
    [r22 release];
    r0 = **_NSApp;
    r0 = [r0 CXServer];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addObserver:self forKeyPath:@"launchers" options:0x0 context:_BottleViewControllerKVCContext];
    [r22 release];
    r0 = [self controlPanelsLoadingSpinner];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setUsesThreadedAnimation:0x1];
    [r22 release];
    r22 = [[NSMutableArray array] retain];
    [self setControlPanelLaunchers:r22];
    [r22 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"Graphics backend options" value:@"" table:0x0] retain];
    r0 = [self graphicsOptionView];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setToolTip:r24];
    [r25 release];
    [r24 release];
    [r23 release];
    r23 = [[self graphicsPopUpButton] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"Auto" value:@"" table:0x0] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r26 = r0;
    r27 = [[r0 localizedStringForKey:@"Automatically use the best graphics backend" value:@"" table:0x0] retain];
    r28 = [[r23 addItemWithTitle:r25 toolTip:r27] retain];
    [self setAutoGraphicsMenuItem:r28];
    [r28 release];
    [r27 release];
    [r26 release];
    [r25 release];
    [r24 release];
    [r23 release];
    r23 = [[self graphicsPopUpButton] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"D3DMetal" value:@"" table:0x0] retain];
    r26 = [[r23 addItemWithTitle:r25 toolTip:@""] retain];
    [self setD3dMetalMenuItem:r26];
    [r26 release];
    [r25 release];
    [r24 release];
    [r23 release];
    r23 = [[self graphicsPopUpButton] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"DXMT" value:@"" table:0x0] retain];
    r26 = [[r23 addItemWithTitle:r25 toolTip:@""] retain];
    [self setDxmtMenuItem:r26];
    [r26 release];
    [r25 release];
    [r24 release];
    [r23 release];
    r23 = [[self graphicsPopUpButton] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"DXVK" value:@"" table:0x0] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r26 = r0;
    r27 = [[r0 localizedStringForKey:@"DXVK graphics backend" value:@"" table:0x0] retain];
    r28 = [[r23 addItemWithTitle:r25 toolTip:r27] retain];
    [self setDxvkMenuItem:r28];
    [r28 release];
    [r27 release];
    [r26 release];
    [r25 release];
    [r24 release];
    [r23 release];
    r23 = [[self graphicsPopUpButton] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"Wine" value:@"" table:0x0] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r26 = r0;
    r27 = [[r0 localizedStringForKey:@"Wine graphics backend" value:@"" table:0x0] retain];
    r28 = [[r23 addItemWithTitle:r25 toolTip:r27] retain];
    [self setWined3dMenuItem:r28];
    [r28 release];
    [r27 release];
    [r26 release];
    [r25 release];
    [r24 release];
    [r23 release];
    r23 = [[self vulkanPopUpButton] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"MoltenVK" value:@"" table:0x0] retain];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r26 = r0;
    r22 = [[r0 localizedStringForKey:@"MoltenVK Vulkan backend" value:@"" table:0x0] retain];
    r27 = [[r23 addItemWithTitle:r25 toolTip:r22] retain];
    [self setMoltenvkMenuItem:r27];
    [r27 release];
    [r22 release];
    [r26 release];
    [r25 release];
    [r24 release];
    [r23 release];
    r0 = [self vulkanPopUpButton];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 addItemWithTitle:@"MTLVK" toolTip:@"MTLVK translation layer for D3D12."] retain];
    [self setMtlvkMenuItem:r23];
    [r23 release];
    [r22 release];
    r0 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:0x1 selector:@selector(localizedStandardCompare:)];
    r0 = [r0 retain];
    r22 = r0;
    var_68 = r0;
    r0 = [NSArray arrayWithObjects:&var_68 count:0x1];
    r23 = [r0 retain];
    r0 = [self installedSoftwareTableView];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setSortDescriptors:r23];
    [r24 release];
    [r23 release];
    [r22 release];
    r22 = [[NSColor linkColor] retain];
    r0 = [self leaveRatingButton];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setContentTintColor:r22];
    [r23 release];
    [r22 release];
    r22 = [[self iconCollectionView] retain];
    var_70 = **_NSPasteboardTypeFileURL;
    r0 = [NSArray arrayWithObjects:&var_70 count:0x1];
    r23 = [r0 retain];
    [r22 registerForDraggedTypes:r23];
    [r23 release];
    [r22 release];
    r0 = [self iconCollectionView];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setDelegate:self];
    [r22 release];
    [r21 release];
    [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x1000200c0
// -[BottleViewController setBottle:]
    r31 = r31 - 0x1f0;
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
    r22 = arg2;
    r20 = self;
    var_58 = **___stack_chk_guard;
    r0 = [arg2 retain];
    r19 = r0;
    r21 = (int64_t *)&r20->_bottle;
    if (*r21 != r0) {
            var_1A0 = q0;
            var_190 = q0;
            r0 = [r20 observers];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_d8 count:0x10];
            if (r0 != 0x0) {
                    r24 = r0;
                    r25 = *var_190;
                    do {
                            r26 = 0x0;
                            do {
                                    if (*var_190 != r25) {
                                            objc_enumerationMutation(r23);
                                    }
                                    [*r21 removeObserver:r20 forKeyPath:*(var_198 + r26 * 0x8)];
                                    r26 = r26 + 0x1;
                            } while (r24 != r26);
                            r0 = [r23 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_d8 count:0x10];
                            r24 = r0;
                    } while (r0 != 0x0);
            }
            [r23 release];
            objc_storeStrong(r21, r22);
            r22 = [[r20 packageForBottle:r19] retain];
            [r20 setPackage:r22];
            [r22 release];
            r0 = [r20 package];
            r0 = [r0 retain];
            r22 = r0;
            if (r0 != 0x0) {
                    r0 = [r20 package];
                    r0 = [r0 retain];
                    r23 = r0;
                    r0 = [r0 packageobject];
                    r0 = [r0 retain];
                    r24 = r0;
                    if (r0 != 0x0) {
                            r0 = [r20 package];
                            r0 = [r0 retain];
                            r25 = r0;
                            if (([r0 isComponent] & 0x1) != 0x0) {
                                    r2 = 0x0;
                            }
                            else {
                                    r2 = [r19 isIsManaged] ^ 0x1;
                            }
                            [r20 setCanBeRated:r2];
                            [r25 release];
                    }
                    else {
                            [r20 setCanBeRated:0x0];
                    }
                    [r24 release];
                    [r23 release];
            }
            else {
                    [r20 setCanBeRated:0x0];
            }
            [r22 release];
            [r20 reloadLaunchers];
            [r20 resetMenuForNewBottle];
            r0 = [r20 bottle];
            r0 = [r0 retain];
            r22 = r0;
            [r0 loadApplicationInfo];
            [r22 release];
            var_1E0 = q0;
            var_1D0 = q0;
            r0 = [r20 observers];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_158 count:0x10];
            if (r0 != 0x0) {
                    r24 = r0;
                    r25 = *var_1D0;
                    do {
                            r26 = 0x0;
                            do {
                                    if (*var_1D0 != r25) {
                                            objc_enumerationMutation(r22);
                                    }
                                    [*r21 addObserver:r20 forKeyPath:*(var_1D8 + r26 * 0x8) options:0x0 context:_BottleViewControllerKVCContext];
                                    r26 = r26 + 0x1;
                            } while (r24 != r26);
                            r0 = [r22 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_158 count:0x10];
                            r24 = r0;
                    } while (r0 != 0x0);
            }
            [r22 release];
    }
    [r19 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x1000203d0
// -[BottleViewController packageForBottle:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [[[CXSetupLib c4ProfilesClass] profilesSet] retain];
    if ((objc_opt_respondsToSelector() & 0x1) != 0x0) {
            r0 = [r19 contentsDict];
            r0 = [r0 retain];
    }
    else {
            r0 = [r19 retain];
    }
    r20 = r0;
    r0 = [r21 bottle];
    r0 = [r0 retain];
    r21 = r0;
    r23 = [[r0 appid] retain];
    r22 = [[NSString stringWithFormat:@"com.codeweavers.c4.%@", r3] retain];
    [r23 release];
    [r21 release];
    r21 = [[r20 objectForKey:r22] retain];
    r23 = [[PackageTreeNode alloc] initWithProfile:r21];
    [r21 release];
    [r22 release];
    [r20 release];
    [r19 release];
    r0 = [r23 autorelease];
    return r0;


// 0x100020500
// -[BottleViewController reloadLaunchers]
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
    r0 = **_NSApp;
    r0 = [r0 CXServer];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 launchers] retain];
    r22 = [[r19 launcherNodesForLaunchers:r21] retain];
    r0 = [r19 iconCollectionViewController];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setLaunchers:r22];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 iconCollectionViewController];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 launchers];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 count] != 0x0) {
            r22 = 0x1;
    }
    r0 = [r19 noAppsFoundLabel];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setHidden:r22];
    [r19 release];
    [r21 release];
    [r20 release];
    return;


// 0x10002060c
// -[BottleViewController updateDependencyButton]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [CXSetupLib installTaskClass];
    r21 = [[r19 bottle] retain];
    r0 = [r20 getMissingDependencies:r21];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [r0 count];
    [r20 release];
    [r21 release];
    if (r22 == 0x0) {
            r20 = 0x1;
    }
    r0 = [r19 dependencyButton];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setHidden:r20];
    [r19 release];
    return;


// 0x1000206ac
// -[BottleViewController updateQuitButton]
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
    r0 = [self bottle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isCanForceQuit];
    [r20 release];
    r20 = [[NSBundle mainBundle] retain];
    if (r21 != 0x0) {
            r22 = [[r20 localizedStringForKey:@"Force Quit" value:@"" table:0x0] retain];
            r0 = [r19 quitButton];
            r0 = [r0 retain];
            r23 = r0;
            [r0 setTitle:r22];
            [r23 release];
            [r22 release];
            [r20 release];
            r0 = [r19 quitButton];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setEnabled:0x1];
            [r20 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r2 = @"Force quit all applications in the '%@' bottle";
    }
    else {
            r22 = [[r20 localizedStringForKey:@"Quit All Applications" value:@"" table:0x0] retain];
            r0 = [r19 quitButton];
            r0 = [r0 retain];
            r23 = r0;
            [r0 setTitle:r22];
            [r23 release];
            [r22 release];
            [r20 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r2 = @"Quit all applications in the '%@' bottle";
    }
    r21 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 name] retain];
    r24 = [[NSString stringWithFormat:r21] retain];
    r0 = [r19 quitButton];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setToolTip:r24];
    [r19 release];
    [r24 release];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x1000208f4
// -[BottleViewController updateMenuItems]
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
    r0 = [self bottle];
    r0 = [r0 retain];
    r20 = r0;
    if (([r0 isIsManaged] & 0x1) != 0x0) {
            r22 = 0x0;
    }
    else {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 isIsDisabled] ^ 0x1;
            [r21 release];
    }
    var_5C = r22;
    [r20 release];
    r0 = [r19 iconCollectionViewController];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 selectedLauncher] retain];
    [r21 release];
    if (r20 == 0x0) {
            r21 = 0x1;
    }
    r0 = [r19 runWithOptionsButton];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setHidden:r21];
    [r22 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"Run the selected launcher with options" value:@"" table:0x0] retain];
    r0 = [r19 runWithOptionsButton];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setToolTip:r22];
    [r23 release];
    [r22 release];
    [r21 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 isCanRunCommands];
    var_68 = r20;
    if (r0 != 0x0) {
            r22 = [r20 canRunCommands];
    }
    else {
            r22 = 0x0;
    }
    r0 = [r19 runWithOptionsButton];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setEnabled:r22];
    [r23 release];
    [r21 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 isCanRunCommands];
    r0 = [r19 runCommandButton];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setEnabled:r22];
    [r23 release];
    [r21 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r24 = [[r0 localizedStringForKey:@"Select a command to run in the '%@' bottle" value:@"" table:0x0] retain];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r25 = r0;
    r26 = [[r0 name] retain];
    r23 = [[NSString stringWithFormat:r24] retain];
    r0 = [r19 runCommandButton];
    r0 = [r0 retain];
    r27 = r0;
    [r0 setToolTip:r23];
    [r27 release];
    [r23 release];
    [r26 release];
    [r25 release];
    [r24 release];
    [r22 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 isIsUsable];
    r0 = [r19 openCDriveButton];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setEnabled:r23];
    [r24 release];
    [r22 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r24 = [[r0 localizedStringForKey:@"Open the C: drive for the '%@' bottle" value:@"" table:0x0] retain];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r25 = r0;
    r26 = [[r0 name] retain];
    r23 = [[NSString stringWithFormat:r24] retain];
    r0 = [r19 openCDriveButton];
    r0 = [r0 retain];
    r27 = r0;
    [r0 setToolTip:r23];
    [r27 release];
    [r23 release];
    [r26 release];
    [r25 release];
    [r24 release];
    [r22 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 isCanInstall];
    r0 = [r19 installIntoBottleButton];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setEnabled:r23];
    [r24 release];
    [r22 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r24 = [[r0 localizedStringForKey:@"Install a Windows application into the '%@' bottle" value:@"" table:0x0] retain];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r25 = r0;
    r26 = [[r0 name] retain];
    r23 = [[NSString stringWithFormat:r24] retain];
    r0 = [r19 installIntoBottleButton];
    r0 = [r0 retain];
    r27 = r0;
    [r0 setToolTip:r23];
    [r27 release];
    [r23 release];
    [r26 release];
    [r25 release];
    [r24 release];
    [r22 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 isIsBusy] ^ 0x1;
    r0 = [r19 deleteButton];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setEnabled:r23];
    [r24 release];
    [r22 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 localizedStringForKey:@"Delete the '%@' bottle" value:@"" table:0x0] retain];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 name] retain];
    r23 = [[NSString stringWithFormat:r21] retain];
    r0 = [r19 deleteButton];
    r0 = [r0 retain];
    r26 = r0;
    [r0 setToolTip:r23];
    [r26 release];
    [r23 release];
    [r25 release];
    [r24 release];
    [r21 release];
    [r22 release];
    r22 = [[NSColor labelColor] retain];
    var_58 = [[NSColor secondarySelectedControlColor] retain];
    r21 = var_5C;
    if (r21 != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [r0 isCanRunCommands];
    }
    else {
            r24 = 0x0;
    }
    r0 = [r19 graphicsPopUpButton];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setEnabled:r24];
    [r25 release];
    if (r21 != 0x0) {
            [r23 release];
    }
    r0 = [r19 graphicsPopUpButton];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 isEnabled];
    r8 = var_58;
    if (r0 == 0x0) {
            r24 = r8;
    }
    else {
            r24 = r22;
    }
    r0 = [r19 graphicsLabel];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setTextColor:r24];
    [r25 release];
    [r23 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 isIsD3DMetalAvailable];
    r24 = r0;
    if (r0 != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [r0 isIsMTLVKEnabled] ^ 0x1;
    }
    else {
            r26 = 0x0;
    }
    r0 = [r19 d3dMetalMenuItem];
    r0 = [r0 retain];
    r27 = r0;
    [r0 setEnabled:r26];
    [r27 release];
    if (r24 != 0x0) {
            [r25 release];
    }
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"D3DMetal translation layer for D3D11 and D3D12.\nPart of the Game Porting Toolkit." value:@"" table:0x0] retain];
    r0 = [r19 d3dMetalMenuItem];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setToolTip:r24];
    [r25 release];
    [r24 release];
    [r23 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [r0 isIsD3DMetalAvailable];
    [r23 release];
    if ((r24 & 0x1) != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [r0 isIsMTLVKEnabled];
            [r23 release];
            if (r24 != 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [[r0 localizedStringForKey:@"D3DMetal translation layer for D3D11 and D3D12.\nPart of the Game Porting Toolkit." value:@"" table:0x0] retain];
                    r0 = [r19 d3dMetalMenuItem];
                    r0 = [r0 retain];
                    r25 = r0;
                    [r0 setToolTip:r24];
                    [r25 release];
                    [r24 release];
                    [r23 release];
            }
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [[r0 localizedStringForKey:@"D3DMetal translation layer for D3D11 and D3D12.\nPart of the Game Porting Toolkit.\n\nNot supported on this computer: requires Apple Silicon and macOS Sonoma." value:@"" table:0x0] retain];
            r0 = [r19 d3dMetalMenuItem];
            r0 = [r0 retain];
            r25 = r0;
            [r0 setToolTip:r24];
            [r25 release];
            [r24 release];
            [r23 release];
    }
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [r0 isIsDXMTAvailable];
    r0 = [r19 dxmtMenuItem];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setEnabled:r24];
    [r25 release];
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [[r0 localizedStringForKey:@"DXMT translation layer for D3D11." value:@"" table:0x0] retain];
    r0 = [r19 dxmtMenuItem];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setToolTip:r24];
    [r25 release];
    [r24 release];
    [r23 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [r0 isIsDXMTAvailable];
    [r23 release];
    if ((r24 & 0x1) == 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [[r0 localizedStringForKey:@"DXMT translation layer for D3D11.\n\nNot supported on this computer: requires Apple Silicon and macOS Sonoma." value:@"" table:0x0] retain];
            r0 = [r19 dxmtMenuItem];
            r0 = [r0 retain];
            r25 = r0;
            [r0 setToolTip:r24];
            [r25 release];
            [r24 release];
            [r23 release];
    }
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [r0 isIsMTLVKEnabled] ^ 0x1;
    r0 = [r19 dxmtMenuItem];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setEnabled:r24];
    [r25 release];
    [r23 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [r0 isIsMTLVKEnabled] ^ 0x1;
    r0 = [r19 dxvkMenuItem];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setEnabled:r24];
    [r25 release];
    [r23 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r23 = r0;
    r24 = [r0 isIsDXVKEnabled];
    [r23 release];
    r0 = r19;
    if (r24 != 0x0) {
            r23 = [[r0 graphicsPopUpButton] retain];
            r0 = [r19 dxvkMenuItem];
            r0 = [r0 retain];
    }
    else {
            r0 = [r0 bottle];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [r0 isIsDXMTEnabled];
            [r23 release];
            r0 = r19;
            if (r24 != 0x0) {
                    r23 = [[r0 graphicsPopUpButton] retain];
                    r0 = [r19 dxmtMenuItem];
                    r0 = [r0 retain];
            }
            else {
                    r0 = [r0 bottle];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [r0 isIsD3DMetalEnabled];
                    [r23 release];
                    r0 = r19;
                    if (r24 != 0x0) {
                            r23 = [[r0 graphicsPopUpButton] retain];
                            r0 = [r19 d3dMetalMenuItem];
                            r0 = [r0 retain];
                    }
                    else {
                            r0 = [r0 bottle];
                            r0 = [r0 retain];
                            r23 = r0;
                            r24 = [r0 isIsWineD3DEnabled];
                            [r23 release];
                            r23 = [[r19 graphicsPopUpButton] retain];
                            r0 = r19;
                            if (r24 != 0x0) {
                                    r0 = [r0 wined3dMenuItem];
                                    r0 = [r0 retain];
                            }
                            else {
                                    r0 = [r0 autoGraphicsMenuItem];
                                    r0 = [r0 retain];
                            }
                    }
            }
    }
    [r23 selectItem:r0];
    r28 = var_68;
    [r0 release];
    [r23 release];
    if (r21 != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 isCanRunCommands];
            var_78 = r20;
            if (r0 != 0x0) {
                    r0 = [r19 bottle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r0 = [r0 isIsMTLVKAvailable];
                    var_70 = r20;
                    if (r0 != 0x0) {
                            r0 = [r19 bottle];
                            r0 = [r0 retain];
                            r21 = r0;
                            r0 = [r0 isIsDXMTEnabled];
                            var_80 = r21;
                            r24 = r22;
                            if ((r0 & 0x1) != 0x0) {
                                    r26 = 0x0;
                                    r25 = 0x0;
                                    r27 = 0x0;
                                    r21 = 0x1;
                                    r22 = 0x1;
                            }
                            else {
                                    r0 = [r19 bottle];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    if (([r0 isIsDXVKEnabled] & 0x1) != 0x0) {
                                            r25 = 0x0;
                                            r27 = 0x0;
                                            r21 = 0x1;
                                            r22 = 0x1;
                                            r26 = 0x1;
                                    }
                                    else {
                                            r0 = [r19 bottle];
                                            r0 = [r0 retain];
                                            var_88 = r0;
                                            r27 = [r0 isIsD3DMetalEnabled] ^ 0x1;
                                            r21 = 0x1;
                                            r22 = 0x1;
                                            r26 = 0x1;
                                            r25 = 0x1;
                                    }
                            }
                    }
                    else {
                            r24 = r22;
                            r22 = 0x0;
                            r26 = 0x0;
                            r25 = 0x0;
                            r27 = 0x0;
                            r21 = 0x1;
                    }
            }
            else {
                    r24 = r22;
                    r21 = 0x0;
                    r22 = 0x0;
                    r26 = 0x0;
                    r25 = 0x0;
                    r27 = 0x0;
            }
    }
    else {
            r24 = r22;
            r22 = 0x0;
            r26 = 0x0;
            r25 = 0x0;
            r27 = 0x0;
    }
    r0 = [r19 vulkanPopUpButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:r27];
    [r20 release];
    if (r25 != 0x0) {
            [var_88 release];
    }
    if (r26 != 0x0) {
            [r23 release];
    }
    r26 = r28;
    r20 = var_70;
    if (r22 != 0x0) {
            [var_80 release];
    }
    r27 = var_5C;
    r28 = r24;
    if (r21 != 0x0) {
            [r20 release];
    }
    if (r27 != 0x0) {
            [var_78 release];
    }
    r0 = [r19 vulkanPopUpButton];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 isEnabled];
    r8 = var_58;
    if (r0 == 0x0) {
            r23 = r8;
    }
    else {
            r23 = r28;
    }
    r0 = [r19 vulkanLabel];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setTextColor:r23];
    [r24 release];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [r0 isIsMTLVKAvailable];
    r0 = [r19 mtlvkMenuItem];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setEnabled:r23];
    [r24 release];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [[r0 localizedStringForKey:@"Vulkan backend options" value:@"" table:0x0] retain];
    r0 = [r19 vulkanOptionView];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setToolTip:r23];
    [r24 release];
    [r23 release];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [r0 isIsMTLVKAvailable];
    [r20 release];
    if ((r23 & 0x1) != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r23 = r0;
            if ([r0 isIsDXVKEnabled] != 0x0) {
                    [r23 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [[r0 localizedStringForKey:@"Vulkan backend options.\n\nNot available in combination with DXVK or D3DMetal." value:@"" table:0x0] retain];
                    r0 = [r19 vulkanOptionView];
                    r0 = [r0 retain];
                    r25 = r0;
                    [r0 setToolTip:r24];
                    [r25 release];
                    [r24 release];
                    [r23 release];
            }
            else {
                    r0 = [r19 bottle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r24 = [r0 isIsD3DMetalEnabled];
                    [r20 release];
                    [r23 release];
                    if (r24 != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r23 = r0;
                            r24 = [[r0 localizedStringForKey:@"Vulkan backend options.\n\nNot available in combination with DXVK or D3DMetal." value:@"" table:0x0] retain];
                            r0 = [r19 vulkanOptionView];
                            r0 = [r0 retain];
                            r25 = r0;
                            [r0 setToolTip:r24];
                            [r25 release];
                            [r24 release];
                            [r23 release];
                    }
            }
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [[r0 localizedStringForKey:@"Vulkan backend options.\n\nAlternatives supported on this computer: requires Apple Silicon and macOS Sequoia." value:@"" table:0x0] retain];
            r0 = [r19 vulkanOptionView];
            r0 = [r0 retain];
            r25 = r0;
            [r0 setToolTip:r24];
            [r25 release];
            [r24 release];
            [r23 release];
    }
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r24 = [r0 isIsMTLVKEnabled];
    [r20 release];
    r23 = [[r19 vulkanPopUpButton] retain];
    r0 = r19;
    if (r24 != 0x0) {
            r0 = [r0 mtlvkMenuItem];
            r0 = [r0 retain];
    }
    else {
            r0 = [r0 moltenvkMenuItem];
            r0 = [r0 retain];
    }
    [r23 selectItem:r0];
    [r0 release];
    [r23 release];
    r0 = [r19 vulkanOptionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setHidden:0x1];
    [r20 release];
    if (r27 != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [r0 isCanRunCommands];
    }
    else {
            r24 = 0x0;
    }
    r0 = [r19 msyncSwitch];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:r24];
    [r20 release];
    if (r27 != 0x0) {
            [r23 release];
    }
    r0 = [r19 msyncSwitch];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 isEnabled];
    r8 = var_58;
    if (r0 == 0x0) {
            r23 = r8;
    }
    else {
            r23 = r28;
    }
    r0 = [r19 msyncLabel];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setTextColor:r23];
    [r24 release];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [r0 isIsMSyncEnabled];
    r0 = [r19 msyncSwitch];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setState:r23];
    [r24 release];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [[r0 localizedStringForKey:@"Mach Semaphore-based synchronization" value:@"" table:0x0] retain];
    r0 = [r19 msyncView];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setToolTip:r23];
    [r24 release];
    [r23 release];
    [r20 release];
    if (r27 != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r23 = r0;
            if ([r0 isCanRunCommands] != 0x0) {
                    r0 = [r19 bottle];
                    r0 = [r0 retain];
                    r24 = r0;
                    r25 = [r0 isIsDLSSAvailable];
                    r21 = 0x1;
            }
            else {
                    r21 = 0x0;
                    r25 = 0x0;
            }
    }
    else {
            r21 = 0x0;
            r25 = 0x0;
    }
    r0 = [r19 dlssSwitch];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:r25];
    [r20 release];
    if (r21 != 0x0) {
            [r24 release];
    }
    if (r27 != 0x0) {
            [r23 release];
    }
    r0 = [r19 dlssSwitch];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 isEnabled];
    r8 = var_58;
    if (r0 == 0x0) {
            r23 = r8;
    }
    else {
            r23 = r28;
    }
    r0 = [r19 dlssLabel];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setTextColor:r23];
    [r24 release];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [r0 isIsDLSSEnabled];
    r0 = [r19 dlssSwitch];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setState:r23];
    [r24 release];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [[r0 localizedStringForKey:@"DLSS for D3DMetal and DXMT" value:@"" table:0x0] retain];
    r0 = [r19 dlssView];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setToolTip:r23];
    [r24 release];
    [r23 release];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [r0 isIsDLSSAvailable];
    [r20 release];
    if ((r23 & 0x1) == 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r23 = [[r0 localizedStringForKey:@"DLSS for D3DMetal and DXMT. Requires Apple Silicon and macOS Tahoe for D3DMetal, macOS Sonoma for DXMT." value:@"" table:0x0] retain];
            r0 = [r19 dlssView];
            r0 = [r0 retain];
            r24 = r0;
            [r0 setToolTip:r23];
            [r24 release];
            [r23 release];
            [r20 release];
    }
    if (r27 != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r23 = r0;
            if ([r0 isIsActive] != 0x0) {
                    r0 = [r19 bottle];
                    r0 = [r0 retain];
                    r24 = r0;
                    r25 = [r0 isIsHighResolutionEnabledReady];
                    r21 = 0x1;
            }
            else {
                    r21 = 0x0;
                    r25 = 0x0;
            }
    }
    else {
            r21 = 0x0;
            r25 = 0x0;
    }
    r0 = [r19 highResolutionSwitch];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:r25];
    [r20 release];
    if (r21 != 0x0) {
            [r24 release];
    }
    if (r27 != 0x0) {
            [r23 release];
    }
    r0 = [r19 highResolutionSwitch];
    r0 = [r0 retain];
    r20 = r0;
    r21 = var_58;
    if ([r0 isEnabled] == 0x0) {
            r23 = r21;
    }
    else {
            r23 = r28;
    }
    r0 = [r19 highResolutionLabel];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setTextColor:r23];
    [r24 release];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [r0 isIsHighResolutionEnabled];
    r0 = [r19 highResolutionSwitch];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setState:r23];
    [r24 release];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r24 = [[r0 localizedStringForKey:@"High resolution mode" value:@"" table:0x0] retain];
    r0 = [r19 highResolutionView];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setToolTip:r24];
    [r25 release];
    [r24 release];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r24 = [r0 isIsManaged] ^ 0x1;
    r0 = [r19 previewSwitch];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setEnabled:r24];
    [r25 release];
    [r20 release];
    r0 = [r19 previewSwitch];
    r0 = [r0 retain];
    r20 = r0;
    if ([r0 isEnabled] == 0x0) {
            r24 = r21;
    }
    else {
            r24 = r28;
    }
    r0 = [r19 previewLabel];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setTextColor:r24];
    [r25 release];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r24 = [r0 isIsPreviewEnabled];
    r0 = [r19 previewSwitch];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setState:r24];
    [r25 release];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [[r0 localizedStringForKey:@"Enable this bottle for CrossOver Preview" value:@"" table:0x0] retain];
    r0 = [r19 previewView];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setToolTip:r23];
    [r24 release];
    [r23 release];
    [r20 release];
    r0 = [r19 previewView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setHidden:0x1];
    [r20 release];
    [r19 updateDependencyButton];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r23 = [r0 isIsActive];
    r0 = [r19 quitButton];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setEnabled:r23];
    [r24 release];
    [r20 release];
    [r19 updateQuitButton];
    [r21 release];
    [r28 release];
    [r26 release];
    return;


// 0x100022018
// -[BottleViewController resetMenuForNewBottle]
    r0 = [self installedSoftwareTableView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 scrollToBeginningOfDocument:0x0];
    [r20 release];
    [self updateMenuItems];
    [self reloadControlPanels];
    return;


// 0x100022060
// -[BottleViewController iconForControlPanel:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    if (*_iconForControlPanel:.onceToken != -0x1) {
            dispatch_once(_iconForControlPanel:.onceToken, ___block_literal_global);
    }
    r0 = [r19 valueForKey:@"exe"];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 lastPathComponent];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 lowercaseString] retain];
    [r21 release];
    [r20 release];
    r0 = *_iconForControlPanel:.iconsNamesByExe;
    r0 = [r0 objectForKeyedSubscript:r22];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r20 = r0;
    }
    else {
            r20 = @"sf-symbols.gearshape-2";
    }
    r21 = [[NSImage imageNamed:r20] retain];
    [r20 release];
    [r22 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x100022240
// -[BottleViewController sortControlPanels:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = *_sortControlPanels:.onceToken;
    r19 = [arg2 retain];
    if (r20 != -0x1) {
            dispatch_once(_sortControlPanels:.onceToken, ___block_literal_global.159);
    }
    [r19 sortUsingComparator:___block_literal_global.161];
    [r19 release];
    return;


// 0x100022504
// -[BottleViewController addButtonForControlPanel:index:]
    r0 = [arg2 retain];
    r22 = r0;
    r23 = [[r0 valueForKey:@"name"] retain];
    r24 = [[self iconForControlPanel:r22] retain];
    r19 = [[CXFlatButton flatButtonWithTitle:r23 icon:r24] retain];
    [r24 release];
    [r23 release];
    [r19 setShowsBorderOnlyWhileMouseInside:0x1];
    r23 = [[r22 valueForKey:@"description"] retain];
    [r22 release];
    [r19 setToolTip:r23];
    [r23 release];
    [r19 setTag:arg3];
    [r19 setTarget:self];
    [r19 setAction:@selector(controlPanelButtonClicked:)];
    r0 = [self controlPanelsSection];
    r0 = [r0 retain];
    r21 = r0;
    [r0 addArrangedSubview:r19];
    [r21 release];
    r21 = [[r19 widthAnchor] retain];
    r0 = [self controlPanelsSection];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 widthAnchor] retain];
    r0 = [r21 constraintEqualToAnchor:r22];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setActive:0x1];
    [r23 release];
    [r22 release];
    [r20 release];
    [r21 release];
    [r19 release];
    return;


// 0x1000226b0
// -[BottleViewController showControlPanelLoader:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self controlPanelsLoadingView];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setHidden:arg2 ^ 0x1];
    [r21 release];
    r0 = [self controlPanelsLoadingSpinner];
    r0 = [r0 retain];
    r19 = r0;
    if (((arg2 ^ 0x1) & 0x1) == 0x0) {
            [r0 startAnimation:0x0];
    }
    else {
            [r0 stopAnimation:0x0];
    }
    [r19 release];
    return;


// 0x100022724
// -[BottleViewController reloadControlPanels]
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
    r19 = self;
    var_48 = **___stack_chk_guard;
    r0 = [self controlPanelLaunchers];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeAllObjects];
    [r20 release];
    var_110 = q0;
    var_100 = q0;
    r0 = [r19 controlPanelsSection];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 arrangedSubviews];
    r0 = [r0 retain];
    r22 = r0;
    r20 = [r0 copy];
    [r22 release];
    [r21 release];
    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r24 = *var_100;
            do {
                    r25 = 0x0;
                    do {
                            if (*var_100 != r24) {
                                    objc_enumerationMutation(r20);
                            }
                            r22 = *(var_108 + r25 * 0x8);
                            r0 = [r19 controlPanelsLoadingView];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 release];
                            if (r22 != r23) {
                                    r0 = [r19 controlPanelsSection];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    [r0 removeArrangedSubview:r22];
                                    [r23 release];
                                    [r22 removeFromSuperview];
                            }
                            r25 = r25 + 0x1;
                    } while (r21 != r25);
                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isIsControlPanelReady];
    [r20 release];
    r0 = r19;
    if (r21 != 0x0) {
            [r0 showControlPanelLoader:0x0];
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 controlPanelTable] retain];
            r20 = [[NSMutableArray arrayWithArray:r22] retain];
            [r22 release];
            [r21 release];
            [r19 sortControlPanels:r20];
            if ([r20 count] != 0x0) {
                    r21 = 0x0;
                    do {
                            r22 = [[r20 objectAtIndexedSubscript:r21] retain];
                            r24 = [[r19 bottle] retain];
                            r23 = [[LauncherControlPanel launcherWithControlPanel:r22 bottle:r24] retain];
                            [r24 release];
                            r0 = [r19 controlPanelLaunchers];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 addObject:r23];
                            [r24 release];
                            [r19 addButtonForControlPanel:r22 index:r21];
                            [r23 release];
                            [r22 release];
                            r21 = r21 + 0x1;
                    } while (r21 < [r20 count]);
            }
    }
    else {
            [r0 showControlPanelLoader:0x1];
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r20 = r0;
            [r0 loadControlPanelInfo];
    }
    [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100022a34
// -[BottleViewController launcherNodesForLaunchers:]
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
    r20 = self;
    var_60 = **___stack_chk_guard;
    r21 = [arg2 retain];
    r19 = [[NSMutableArray array] retain];
    var_120 = q0;
    var_110 = q0;
    r0 = [r21 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r26 = *var_110;
            do {
                    r28 = 0x0;
                    while (true) {
                            if (*var_110 != r26) {
                                    objc_enumerationMutation(r21);
                            }
                            r23 = *(var_118 + r28 * 0x8);
                            if ([r23 isLeaf] != 0x0) {
                                    objc_opt_class(@class(LauncherApp));
                                    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                            r0 = [r23 retain];
                                            r23 = r0;
                                            r24 = [[r0 bottle] retain];
                                            r0 = [r20 bottle];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            [r0 release];
                                            [r24 release];
                                            if (r24 == r25) {
                                                    r24 = [[LauncherAppTreeNode fromLauncher:r23] retain];
                                                    [r19 addObject:r24];
                                                    [r24 release];
                                            }
                                            [r23 release];
                                            r28 = r28 + 0x1;
                                            if (r22 != r28) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    else {
                                            if (([r23 isLeaf] & 0x1) == 0x0) {
                                                    objc_opt_class(@class(LauncherFolder));
                                                    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                                            r23 = [[r23 items] retain];
                                                            r24 = [[r20 launcherNodesForLaunchers:r23] retain];
                                                            [r19 addObjectsFromArray:r24];
                                                            [r24 release];
                                                            [r23 release];
                                                            r28 = r28 + 0x1;
                                                            if (r22 != r28) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                                    else {
                                                            r28 = r28 + 0x1;
                                                            if (r22 != r28) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                            else {
                                                    r28 = r28 + 0x1;
                                                    if (r22 != r28) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                            }
                            else {
                                    if (([r23 isLeaf] & 0x1) == 0x0) {
                                            objc_opt_class(@class(LauncherFolder));
                                            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                                    r23 = [[r23 items] retain];
                                                    r24 = [[r20 launcherNodesForLaunchers:r23] retain];
                                                    [r19 addObjectsFromArray:r24];
                                                    [r24 release];
                                                    [r23 release];
                                                    r28 = r28 + 0x1;
                                                    if (r22 != r28) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                            else {
                                                    r28 = r28 + 0x1;
                                                    if (r22 != r28) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                                    else {
                                            r28 = r28 + 0x1;
                                            if (r22 != r28) {
                                                    continue;
                                            }
                                            break;
                                    }
                            }
                    }
                    r0 = [r21 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    [r19 sortUsingSelector:@selector(compareSortOrderThenName:)];
    r0 = [r21 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x100022c78
// -[BottleViewController observeValueForKeyPath:ofObject:change:context:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = arg5;
    r23 = arg4;
    r21 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    if (r22 != _BottleViewControllerKVCContext) {
            var_40 = r21;
            [[&var_40 super] observeValueForKeyPath:r19 ofObject:r20 change:r23 context:r22];
            [r20 release];
            [r19 release];
    }
    else {
            r0 = **_NSApp;
            r0 = [r0 CXServer];
            r0 = [r0 retain];
            if (r0 != r20) {
                    [r0 release];
                    r0 = [r21 bottle];
                    r0 = [r0 retain];
                    if (r0 != r20) {
                            [r0 release];
                            r0 = [r21 bottle];
                            r0 = [r0 retain];
                            r22 = r0;
                            [r0 release];
                            if (r22 == r20) {
                                    [r21 updateMenuItems];
                            }
                            [r20 release];
                            [r19 release];
                    }
                    else {
                            r22 = [r19 isEqualToString:@"isControlPanelReady"];
                            [r20 release];
                            if (r22 != 0x0) {
                                    [r21 reloadControlPanels];
                                    [r20 release];
                                    [r19 release];
                            }
                            else {
                                    r0 = [r21 bottle];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    [r0 release];
                                    if (r22 == r20) {
                                            [r21 updateMenuItems];
                                    }
                                    [r20 release];
                                    [r19 release];
                            }
                    }
            }
            else {
                    r22 = [r19 isEqualToString:@"launchers"];
                    [r20 release];
                    if (r22 != 0x0) {
                            [r21 reloadLaunchers];
                            [r20 release];
                            [r19 release];
                    }
                    else {
                            r0 = [r21 bottle];
                            r0 = [r0 retain];
                            if (r0 != r20) {
                                    [r0 release];
                                    r0 = [r21 bottle];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    [r0 release];
                                    if (r22 == r20) {
                                            [r21 updateMenuItems];
                                    }
                                    [r20 release];
                                    [r19 release];
                            }
                            else {
                                    r22 = [r19 isEqualToString:@"isControlPanelReady"];
                                    [r20 release];
                                    if (r22 != 0x0) {
                                            [r21 reloadControlPanels];
                                            [r20 release];
                                            [r19 release];
                                    }
                                    else {
                                            r0 = [r21 bottle];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            [r0 release];
                                            if (r22 == r20) {
                                                    [r21 updateMenuItems];
                                            }
                                            [r20 release];
                                            [r19 release];
                                    }
                            }
                    }
            }
    }
    return;


// 0x100022de8
// -[BottleViewController leaveRating:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    if ([self canBeRated] != 0x0) {
            r19 = [SubmitRatingController alloc];
            r21 = [[r20 bottle] retain];
            r19 = [r19 initWithBottle:r21];
            [r21 release];
            if (r19 != 0x0) {
                    r0 = [r20 view];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 window] retain];
                    r22 = [[r19 window] retain];
                    [r21 beginSheet:r22 completionHandler:0x0];
                    [r22 release];
                    [r21 release];
                    [r20 release];
            }
            [r19 release];
    }
    return;


// 0x100022ec8
// +[BottleViewController keyPathsForValuesAffectingBottleDescription]
    r0 = [NSSet setWithObject:@"bottle.currentDescription"];
    return r0;


// 0x100022edc
// -[BottleViewController bottleDescription]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self bottle];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 currentDescription] retain];
    [r20 release];
    if ([r19 length] != 0x0) {
            r20 = [r19 retain];
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100022f48
// -[BottleViewController setBottleDescription:]
    r2 = arg2;
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if (r2 != 0x0) {
            r20 = r2;
    }
    else {
            r20 = @"";
    }
    r21 = [r2 retain];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setCurrentDescription:r20];
    [r21 release];
    [r19 release];
    return;


// 0x100022fb0
// -[BottleViewController iconCollectionViewControllerSelectionChanged:]
    [self updateMenuItems];
    return;


// 0x100022fb4
// -[BottleViewController runWithOptionsClicked:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self iconCollectionViewController];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 selectedLauncher] retain];
    [r21 release];
    objc_opt_class(@class(LauncherAppTreeNode));
    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
            r20 = [[r20 bottle] retain];
            r22 = [[r19 launcher] retain];
            [BottleMenuHandler runCommandInBottle:r20 withLauncher:r22];
            [r22 release];
            [r20 release];
    }
    [r19 release];
    return;


// 0x100023070
// -[BottleViewController runCommandClicked:]
    r20 = [[self bottle] retain];
    [BottleMenuHandler runCommandInBottle:r20];
    [r20 release];
    return;


// 0x1000230b0
// -[BottleViewController installIntoBottleClicked:]
    r21 = [[self bottle] retain];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    r22 = [[r0 window] retain];
    [BottleMenuHandler installSoftwareIntoBottle:r21 withWindow:r22];
    [r22 release];
    [r19 release];
    [r21 release];
    return;


// 0x100023134
// -[BottleViewController dependencyButtonClicked:]
    r21 = [[self bottle] retain];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    r22 = [[r0 window] retain];
    [BottleMenuHandler installMissingDependencies:r21 withWindow:r22];
    [r22 release];
    [r19 release];
    [r21 release];
    return;


// 0x1000231b8
// -[BottleViewController openCDriveClicked:]
    r20 = [[self bottle] retain];
    [BottleMenuHandler openCDriveForBottle:r20];
    [r20 release];
    return;


// 0x1000231f8
// -[BottleViewController quitClicked:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self bottle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isCanForceQuit];
    [r20 release];
    r19 = [[self bottle] retain];
    r2 = r19;
    if (r21 != 0x0) {
            [BottleMenuHandler forceQuitBottle:r2];
    }
    else {
            [BottleMenuHandler quitBottle:r2];
    }
    [r19 release];
    return;


// 0x100023274
// -[BottleViewController deleteClicked:]
    r21 = [[self bottle] retain];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    r22 = [[r0 window] retain];
    [BottleMenuHandler deleteBottle:r21 withWindow:r22];
    [r22 release];
    [r19 release];
    [r21 release];
    return;


// 0x1000232f8
// -[BottleViewController graphicsOptionChanged:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self graphicsPopUpButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 selectedItem] retain];
    r0 = [r19 autoGraphicsMenuItem];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    [r21 release];
    [r20 release];
    if (r21 != r22) {
            r0 = [r19 graphicsPopUpButton];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 selectedItem] retain];
            r0 = [r19 d3dMetalMenuItem];
            r0 = [r0 retain];
            r22 = r0;
            [r0 release];
            [r21 release];
            [r20 release];
            if (r21 != r22) {
                    r0 = [r19 graphicsPopUpButton];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 selectedItem] retain];
                    r0 = [r19 dxmtMenuItem];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 release];
                    [r21 release];
                    [r20 release];
                    if (r21 != r22) {
                            r0 = [r19 graphicsPopUpButton];
                            r0 = [r0 retain];
                            r20 = r0;
                            r21 = [[r0 selectedItem] retain];
                            r0 = [r19 dxvkMenuItem];
                            r0 = [r0 retain];
                            r22 = r0;
                            [r0 release];
                            [r21 release];
                            [r20 release];
                            if (r21 != r22) {
                                    r0 = [r19 graphicsPopUpButton];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r21 = [[r0 selectedItem] retain];
                                    r0 = [r19 wined3dMenuItem];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    [r0 release];
                                    [r21 release];
                                    [r20 release];
                                    if (r21 == r22) {
                                            r0 = [r19 bottle];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            [r0 setGraphicsBackendWine];
                                            [r19 release];
                                    }
                            }
                            else {
                                    r0 = [r19 bottle];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    [r0 setGraphicsBackendDXVK];
                                    [r19 release];
                            }
                    }
                    else {
                            r0 = [r19 bottle];
                            r0 = [r0 retain];
                            r19 = r0;
                            [r0 setGraphicsBackendDXMT];
                            [r19 release];
                    }
            }
            else {
                    r0 = [r19 bottle];
                    r0 = [r0 retain];
                    r19 = r0;
                    [r0 setGraphicsBackendD3DMetal];
                    [r19 release];
            }
    }
    else {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r19 = r0;
            [r0 setGraphicsBackendAuto];
            [r19 release];
    }
    return;


// 0x100023558
// -[BottleViewController vulkanOptionChanged:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self vulkanPopUpButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 selectedItem] retain];
    r0 = [r19 moltenvkMenuItem];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    [r21 release];
    [r20 release];
    if (r21 != r22) {
            r0 = [r19 vulkanPopUpButton];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 selectedItem] retain];
            r0 = [r19 mtlvkMenuItem];
            r0 = [r0 retain];
            r22 = r0;
            [r0 release];
            [r21 release];
            [r20 release];
            if (r21 == r22) {
                    r0 = [r19 bottle];
                    r0 = [r0 retain];
                    r19 = r0;
                    [r0 setVulkanBackendMTLVK];
                    [r19 release];
            }
    }
    else {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r19 = r0;
            [r0 setVulkanBackendMoltenVK];
            [r19 release];
    }
    return;


// 0x100023668
// -[BottleViewController dlssToggled:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self bottle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isIsDLSSEnabled];
    [r20 release];
    r0 = [self bottle];
    r0 = [r0 retain];
    r19 = r0;
    if (r21 != 0x0) {
            [r0 disableDLSS];
    }
    else {
            [r0 enableDLSS];
    }
    [r19 release];
    return;


// 0x1000236d4
// -[BottleViewController msyncToggled:]
    r20 = [arg2 retain];
    r22 = [[self bottle] retain];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    r23 = [[r0 window] retain];
    var_58 = *__NSConcreteStackBlock;
    var_38 = r20;
    r20 = [r20 retain];
    [BottleMenuHandler toggleMSyncForBottle:r22 withWindow:r23 modalCompletionHandler:&var_58];
    [r23 release];
    [r19 release];
    [r22 release];
    [var_38 release];
    [r20 release];
    return;


// 0x100023804
// -[BottleViewController highResolutionToggled:]
    r20 = [arg2 retain];
    r22 = [[self bottle] retain];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    r23 = [[r0 window] retain];
    var_58 = *__NSConcreteStackBlock;
    var_38 = r20;
    r20 = [r20 retain];
    [BottleMenuHandler toggleHighResolutionForBottle:r22 withWindow:r23 modalCompletionHandler:&var_58];
    [r23 release];
    [r19 release];
    [r22 release];
    [var_38 release];
    [r20 release];
    return;


// 0x100023934
// -[BottleViewController previewToggled:]
    r20 = [arg2 retain];
    r22 = [[self bottle] retain];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    r23 = [[r0 window] retain];
    var_58 = *__NSConcreteStackBlock;
    var_38 = r20;
    r20 = [r20 retain];
    [BottleMenuHandler togglePreviewForBottle:r22 withWindow:r23 modalCompletionHandler:&var_58];
    [r23 release];
    [r19 release];
    [r22 release];
    [var_38 release];
    [r20 release];
    return;


// 0x100023a64
// -[BottleViewController controlPanelButtonClicked:]
    r0 = [arg2 retain];
    r21 = r0;
    [r0 setEnabled:0x0];
    r22 = [[self controlPanelLaunchers] retain];
    r19 = [[r22 objectAtIndexedSubscript:[r21 tag]] retain];
    [r22 release];
    r24 = *__NSConcreteStackBlock;
    var_70 = r24;
    r0 = [r21 retain];
    r21 = r0;
    var_48 = r0;
    [r19 launchWithErrorHandler:&var_70];
    r22 = [[self bottle] retain];
    r23 = dispatch_time(0x0, 0xb2d05e00);
    var_A8 = r24;
    var_78 = r21;
    r20 = [r21 retain];
    r21 = [r22 retain];
    dispatch_after(r23, *__dispatch_main_q, &var_A8);
    [var_78 release];
    [r22 release];
    [r21 release];
    [var_48 release];
    [r20 release];
    [r19 release];
    return;


// 0x100023d6c
// -[BottleViewController bottleDescriptionDidEndEditing:]
    r0 = [self bottle];
    r0 = [r0 retain];
    r19 = r0;
    [r0 writeDescription];
    [r19 release];
    return;


// 0x100023d9c
// -[BottleViewController selectedApplication]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self installedSoftwareTableView];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [r0 clickedRow];
    [r21 release];
    if (r19 != -0x1) {
            r0 = [r20 installedSoftware];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 arrangedObjects];
            r0 = [r0 retain];
            r21 = r0;
            r19 = [[r0 objectAtIndexedSubscript:r19] retain];
            [r21 release];
            [r20 release];
    }
    else {
            r19 = 0x0;
    }
    r0 = [r19 autorelease];
    return r0;


// 0x100023e3c
// -[BottleViewController canUninstall]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self selectedApplication];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r0 = [r19 selectedApplication];
            r0 = [r0 retain];
            r19 = r0;
            r0 = [r0 canUninstall];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 boolValue];
            [r20 release];
            [r19 release];
            r0 = r21;
    }
    else {
            r0 = 0x0;
    }
    return r0;


// 0x100023ec0
// -[BottleViewController uninstallClicked:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self selectedApplication];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r0 = [r19 selectedApplication];
            r0 = [r0 retain];
            r19 = r0;
            [r0 uninstall];
            [r19 release];
    }
    return;


// 0x100023f1c
// -[BottleViewController control:textView:doCommandBySelector:]
    r2 = arg2;
    r0 = self;
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg4;
    if (@selector(insertNewline:) == arg4) {
            r0 = [r2 retain];
            r20 = r0;
            r21 = [[r0 currentEditor] retain];
            [r20 endEditing:r21];
            [r20 release];
            r0 = [r21 release];
    }
    if (@selector(insertNewline:) == r19) {
            r0 = 0x1;
    }
    return r0;


// 0x100023f90
// -[BottleViewController performDragOperation:]
    r21 = [[arg2 draggingPasteboard] retain];
    r20 = [[NSURL URLFromPasteboard:r21] retain];
    [r21 release];
    r21 = [[**_NSApp CXServer] retain];
    r22 = [[r20 path] retain];
    r0 = [self bottle];
    r0 = [r0 retain];
    r19 = r0;
    r23 = [[r0 name] retain];
    [r21 runClient:r22 inBottle:r23 withDialog:0x1];
    [r23 release];
    [r19 release];
    [r22 release];
    [r21 release];
    [r20 release];
    return 0x1;


// 0x10002408c
// -[BottleViewController bottle]
    r0 = self->_bottle;
    return r0;


// 0x10002409c
// -[BottleViewController observers]
    r0 = self->_observers;
    return r0;


// 0x1000240ac
// -[BottleViewController setObservers:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000240b8
// -[BottleViewController package]
    r0 = self->_package;
    return r0;


// 0x1000240c8
// -[BottleViewController setPackage:]
    objc_storeStrong((int64_t *)&self->_package, arg2);
    return;


// 0x1000240dc
// -[BottleViewController canBeRated]
    r0 = *(int8_t *)(int64_t *)&self->_canBeRated & 0x1;
    return r0;


// 0x1000240f0
// -[BottleViewController setCanBeRated:]
    *(int8_t *)(int64_t *)&self->_canBeRated = arg2;
    return;


// 0x100024100
// -[BottleViewController iconCollectionViewController]
    r0 = self->_iconCollectionViewController;
    return r0;


// 0x100024110
// -[BottleViewController setIconCollectionViewController:]
    objc_storeStrong((int64_t *)&self->_iconCollectionViewController, arg2);
    return;


// 0x100024124
// -[BottleViewController iconCollectionView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_iconCollectionView);
    r0 = [r0 autorelease];
    return r0;


// 0x100024144
// -[BottleViewController setIconCollectionView:]
    objc_storeWeak((int64_t *)&self->_iconCollectionView, arg2);
    return;


// 0x100024158
// -[BottleViewController noAppsFoundLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_noAppsFoundLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x100024178
// -[BottleViewController setNoAppsFoundLabel:]
    objc_storeWeak((int64_t *)&self->_noAppsFoundLabel, arg2);
    return;


// 0x10002418c
// -[BottleViewController leaveRatingButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_leaveRatingButton);
    r0 = [r0 autorelease];
    return r0;


// 0x1000241ac
// -[BottleViewController setLeaveRatingButton:]
    objc_storeWeak((int64_t *)&self->_leaveRatingButton, arg2);
    return;


// 0x1000241c0
// -[BottleViewController controlPanelLaunchers]
    r0 = self->_controlPanelLaunchers;
    return r0;


// 0x1000241d0
// -[BottleViewController setControlPanelLaunchers:]
    objc_storeStrong((int64_t *)&self->_controlPanelLaunchers, arg2);
    return;


// 0x1000241e4
// -[BottleViewController runWithOptionsButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_runWithOptionsButton);
    r0 = [r0 autorelease];
    return r0;


// 0x100024204
// -[BottleViewController setRunWithOptionsButton:]
    objc_storeWeak((int64_t *)&self->_runWithOptionsButton, arg2);
    return;


// 0x100024218
// -[BottleViewController runCommandButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_runCommandButton);
    r0 = [r0 autorelease];
    return r0;


// 0x100024238
// -[BottleViewController setRunCommandButton:]
    objc_storeWeak((int64_t *)&self->_runCommandButton, arg2);
    return;


// 0x10002424c
// -[BottleViewController installIntoBottleButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installIntoBottleButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10002426c
// -[BottleViewController setInstallIntoBottleButton:]
    objc_storeWeak((int64_t *)&self->_installIntoBottleButton, arg2);
    return;


// 0x100024280
// -[BottleViewController openCDriveButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_openCDriveButton);
    r0 = [r0 autorelease];
    return r0;


// 0x1000242a0
// -[BottleViewController setOpenCDriveButton:]
    objc_storeWeak((int64_t *)&self->_openCDriveButton, arg2);
    return;


// 0x1000242b4
// -[BottleViewController quitButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_quitButton);
    r0 = [r0 autorelease];
    return r0;


// 0x1000242d4
// -[BottleViewController setQuitButton:]
    objc_storeWeak((int64_t *)&self->_quitButton, arg2);
    return;


// 0x1000242e8
// -[BottleViewController deleteButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_deleteButton);
    r0 = [r0 autorelease];
    return r0;


// 0x100024308
// -[BottleViewController setDeleteButton:]
    objc_storeWeak((int64_t *)&self->_deleteButton, arg2);
    return;


// 0x10002431c
// -[BottleViewController dependencyButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_dependencyButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10002433c
// -[BottleViewController setDependencyButton:]
    objc_storeWeak((int64_t *)&self->_dependencyButton, arg2);
    return;


// 0x100024350
// -[BottleViewController graphicsOptionView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_graphicsOptionView);
    r0 = [r0 autorelease];
    return r0;


// 0x100024370
// -[BottleViewController setGraphicsOptionView:]
    objc_storeWeak((int64_t *)&self->_graphicsOptionView, arg2);
    return;


// 0x100024384
// -[BottleViewController graphicsLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_graphicsLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x1000243a4
// -[BottleViewController setGraphicsLabel:]
    objc_storeWeak((int64_t *)&self->_graphicsLabel, arg2);
    return;


// 0x1000243b8
// -[BottleViewController graphicsPopUpButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_graphicsPopUpButton);
    r0 = [r0 autorelease];
    return r0;


// 0x1000243d8
// -[BottleViewController setGraphicsPopUpButton:]
    objc_storeWeak((int64_t *)&self->_graphicsPopUpButton, arg2);
    return;


// 0x1000243ec
// -[BottleViewController autoGraphicsMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_autoGraphicsMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x10002440c
// -[BottleViewController setAutoGraphicsMenuItem:]
    objc_storeWeak((int64_t *)&self->_autoGraphicsMenuItem, arg2);
    return;


// 0x100024420
// -[BottleViewController dxmtMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_dxmtMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x100024440
// -[BottleViewController setDxmtMenuItem:]
    objc_storeWeak((int64_t *)&self->_dxmtMenuItem, arg2);
    return;


// 0x100024454
// -[BottleViewController dxvkMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_dxvkMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x100024474
// -[BottleViewController setDxvkMenuItem:]
    objc_storeWeak((int64_t *)&self->_dxvkMenuItem, arg2);
    return;


// 0x100024488
// -[BottleViewController d3dMetalMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_d3dMetalMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x1000244a8
// -[BottleViewController setD3dMetalMenuItem:]
    objc_storeWeak((int64_t *)&self->_d3dMetalMenuItem, arg2);
    return;


// 0x1000244bc
// -[BottleViewController wined3dMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_wined3dMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x1000244dc
// -[BottleViewController setWined3dMenuItem:]
    objc_storeWeak((int64_t *)&self->_wined3dMenuItem, arg2);
    return;


// 0x1000244f0
// -[BottleViewController vulkanOptionView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_vulkanOptionView);
    r0 = [r0 autorelease];
    return r0;


// 0x100024510
// -[BottleViewController setVulkanOptionView:]
    objc_storeWeak((int64_t *)&self->_vulkanOptionView, arg2);
    return;


// 0x100024524
// -[BottleViewController vulkanLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_vulkanLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x100024544
// -[BottleViewController setVulkanLabel:]
    objc_storeWeak((int64_t *)&self->_vulkanLabel, arg2);
    return;


// 0x100024558
// -[BottleViewController vulkanPopUpButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_vulkanPopUpButton);
    r0 = [r0 autorelease];
    return r0;


// 0x100024578
// -[BottleViewController setVulkanPopUpButton:]
    objc_storeWeak((int64_t *)&self->_vulkanPopUpButton, arg2);
    return;


// 0x10002458c
// -[BottleViewController moltenvkMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_moltenvkMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x1000245ac
// -[BottleViewController setMoltenvkMenuItem:]
    objc_storeWeak((int64_t *)&self->_moltenvkMenuItem, arg2);
    return;


// 0x1000245c0
// -[BottleViewController mtlvkMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_mtlvkMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x1000245e0
// -[BottleViewController setMtlvkMenuItem:]
    objc_storeWeak((int64_t *)&self->_mtlvkMenuItem, arg2);
    return;


// 0x1000245f4
// -[BottleViewController msyncLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_msyncLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x100024614
// -[BottleViewController setMsyncLabel:]
    objc_storeWeak((int64_t *)&self->_msyncLabel, arg2);
    return;


// 0x100024628
// -[BottleViewController msyncSwitch]
    r0 = objc_loadWeakRetained((int64_t *)&self->_msyncSwitch);
    r0 = [r0 autorelease];
    return r0;


// 0x100024648
// -[BottleViewController setMsyncSwitch:]
    objc_storeWeak((int64_t *)&self->_msyncSwitch, arg2);
    return;


// 0x10002465c
// -[BottleViewController msyncView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_msyncView);
    r0 = [r0 autorelease];
    return r0;


// 0x10002467c
// -[BottleViewController setMsyncView:]
    objc_storeWeak((int64_t *)&self->_msyncView, arg2);
    return;


// 0x100024690
// -[BottleViewController dlssLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_dlssLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x1000246b0
// -[BottleViewController setDlssLabel:]
    objc_storeWeak((int64_t *)&self->_dlssLabel, arg2);
    return;


// 0x1000246c4
// -[BottleViewController dlssSwitch]
    r0 = objc_loadWeakRetained((int64_t *)&self->_dlssSwitch);
    r0 = [r0 autorelease];
    return r0;


// 0x1000246e4
// -[BottleViewController setDlssSwitch:]
    objc_storeWeak((int64_t *)&self->_dlssSwitch, arg2);
    return;


// 0x1000246f8
// -[BottleViewController dlssView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_dlssView);
    r0 = [r0 autorelease];
    return r0;


// 0x100024718
// -[BottleViewController setDlssView:]
    objc_storeWeak((int64_t *)&self->_dlssView, arg2);
    return;


// 0x10002472c
// -[BottleViewController highResolutionLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_highResolutionLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x10002474c
// -[BottleViewController setHighResolutionLabel:]
    objc_storeWeak((int64_t *)&self->_highResolutionLabel, arg2);
    return;


// 0x100024760
// -[BottleViewController highResolutionSwitch]
    r0 = objc_loadWeakRetained((int64_t *)&self->_highResolutionSwitch);
    r0 = [r0 autorelease];
    return r0;


// 0x100024780
// -[BottleViewController setHighResolutionSwitch:]
    objc_storeWeak((int64_t *)&self->_highResolutionSwitch, arg2);
    return;


// 0x100024794
// -[BottleViewController highResolutionView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_highResolutionView);
    r0 = [r0 autorelease];
    return r0;


// 0x1000247b4
// -[BottleViewController setHighResolutionView:]
    objc_storeWeak((int64_t *)&self->_highResolutionView, arg2);
    return;


// 0x1000247c8
// -[BottleViewController previewLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_previewLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x1000247e8
// -[BottleViewController setPreviewLabel:]
    objc_storeWeak((int64_t *)&self->_previewLabel, arg2);
    return;


// 0x1000247fc
// -[BottleViewController previewSwitch]
    r0 = objc_loadWeakRetained((int64_t *)&self->_previewSwitch);
    r0 = [r0 autorelease];
    return r0;


// 0x10002481c
// -[BottleViewController setPreviewSwitch:]
    objc_storeWeak((int64_t *)&self->_previewSwitch, arg2);
    return;


// 0x100024830
// -[BottleViewController previewView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_previewView);
    r0 = [r0 autorelease];
    return r0;


// 0x100024850
// -[BottleViewController setPreviewView:]
    objc_storeWeak((int64_t *)&self->_previewView, arg2);
    return;


// 0x100024864
// -[BottleViewController controlPanelsSection]
    r0 = objc_loadWeakRetained((int64_t *)&self->_controlPanelsSection);
    r0 = [r0 autorelease];
    return r0;


// 0x100024884
// -[BottleViewController setControlPanelsSection:]
    objc_storeWeak((int64_t *)&self->_controlPanelsSection, arg2);
    return;


// 0x100024898
// -[BottleViewController controlPanelsLoadingView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_controlPanelsLoadingView);
    r0 = [r0 autorelease];
    return r0;


// 0x1000248b8
// -[BottleViewController setControlPanelsLoadingView:]
    objc_storeWeak((int64_t *)&self->_controlPanelsLoadingView, arg2);
    return;


// 0x1000248cc
// -[BottleViewController controlPanelsLoadingSpinner]
    r0 = objc_loadWeakRetained((int64_t *)&self->_controlPanelsLoadingSpinner);
    r0 = [r0 autorelease];
    return r0;


// 0x1000248ec
// -[BottleViewController setControlPanelsLoadingSpinner:]
    objc_storeWeak((int64_t *)&self->_controlPanelsLoadingSpinner, arg2);
    return;


// 0x100024900
// -[BottleViewController installedSoftwareTableView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installedSoftwareTableView);
    r0 = [r0 autorelease];
    return r0;


// 0x100024920
// -[BottleViewController setInstalledSoftwareTableView:]
    objc_storeWeak((int64_t *)&self->_installedSoftwareTableView, arg2);
    return;


// 0x100024934
// -[BottleViewController installedSoftware]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installedSoftware);
    r0 = [r0 autorelease];
    return r0;


// 0x100024954
// -[BottleViewController setInstalledSoftware:]
    objc_storeWeak((int64_t *)&self->_installedSoftware, arg2);
    return;


// 0x100024968
// -[BottleViewController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_installedSoftware);
    objc_destroyWeak((int64_t *)&self->_installedSoftwareTableView);
    objc_destroyWeak((int64_t *)&self->_controlPanelsLoadingSpinner);
    objc_destroyWeak((int64_t *)&self->_controlPanelsLoadingView);
    objc_destroyWeak((int64_t *)&self->_controlPanelsSection);
    objc_destroyWeak((int64_t *)&self->_previewView);
    objc_destroyWeak((int64_t *)&self->_previewSwitch);
    objc_destroyWeak((int64_t *)&self->_previewLabel);
    objc_destroyWeak((int64_t *)&self->_highResolutionView);
    objc_destroyWeak((int64_t *)&self->_highResolutionSwitch);
    objc_destroyWeak((int64_t *)&self->_highResolutionLabel);
    objc_destroyWeak((int64_t *)&self->_dlssView);
    objc_destroyWeak((int64_t *)&self->_dlssSwitch);
    objc_destroyWeak((int64_t *)&self->_dlssLabel);
    objc_destroyWeak((int64_t *)&self->_msyncView);
    objc_destroyWeak((int64_t *)&self->_msyncSwitch);
    objc_destroyWeak((int64_t *)&self->_msyncLabel);
    objc_destroyWeak((int64_t *)&self->_mtlvkMenuItem);
    objc_destroyWeak((int64_t *)&self->_moltenvkMenuItem);
    objc_destroyWeak((int64_t *)&self->_vulkanPopUpButton);
    objc_destroyWeak((int64_t *)&self->_vulkanLabel);
    objc_destroyWeak((int64_t *)&self->_vulkanOptionView);
    objc_destroyWeak((int64_t *)&self->_wined3dMenuItem);
    objc_destroyWeak((int64_t *)&self->_d3dMetalMenuItem);
    objc_destroyWeak((int64_t *)&self->_dxvkMenuItem);
    objc_destroyWeak((int64_t *)&self->_dxmtMenuItem);
    objc_destroyWeak((int64_t *)&self->_autoGraphicsMenuItem);
    objc_destroyWeak((int64_t *)&self->_graphicsPopUpButton);
    objc_destroyWeak((int64_t *)&self->_graphicsLabel);
    objc_destroyWeak((int64_t *)&self->_graphicsOptionView);
    objc_destroyWeak((int64_t *)&self->_dependencyButton);
    objc_destroyWeak((int64_t *)&self->_deleteButton);
    objc_destroyWeak((int64_t *)&self->_quitButton);
    objc_destroyWeak((int64_t *)&self->_openCDriveButton);
    objc_destroyWeak((int64_t *)&self->_installIntoBottleButton);
    objc_destroyWeak((int64_t *)&self->_runCommandButton);
    objc_destroyWeak((int64_t *)&self->_runWithOptionsButton);
    objc_storeStrong((int64_t *)&self->_controlPanelLaunchers, 0x0);
    objc_destroyWeak((int64_t *)&self->_leaveRatingButton);
    objc_destroyWeak((int64_t *)&self->_noAppsFoundLabel);
    objc_destroyWeak((int64_t *)&self->_iconCollectionView);
    objc_storeStrong((int64_t *)&self->_iconCollectionViewController, 0x0);
    objc_storeStrong((int64_t *)&self->_package, 0x0);
    objc_storeStrong((int64_t *)&self->_observers, 0x0);
    objc_storeStrong((int64_t *)&self->_bottle, 0x0);
    return;


// === Block Invocations for BottleViewController ===

// 0x100022160
// ___44-[BottleViewController iconForControlPanel:]_block_invoke
    r31 = r31 - 0x70;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_8 = **___stack_chk_guard;
    var_58 = @"winecfg.exe";
    var_30 = @"sf-symbols.gearshape";
    r0 = [NSDictionary dictionaryWithObjects:&var_30 forKeys:&var_58 count:0x5];
    r0 = [r0 retain];
    r8 = *_iconForControlPanel:.iconsNamesByExe;
    *_iconForControlPanel:.iconsNamesByExe = r0;
    [r8 release];
    if (**___stack_chk_guard != var_8) {
            __stack_chk_fail();
    }
    return;


// 0x1000222a0
// ___42-[BottleViewController sortControlPanels:]_block_invoke
    r31 = r31 - 0x40;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_8 = **___stack_chk_guard;
    var_30 = @"winecfg.exe";
    r0 = [NSArray arrayWithObjects:&var_30 count:0x5];
    r0 = [r0 retain];
    r8 = *_sortControlPanels:.orderOfWellKnownPanels;
    *_sortControlPanels:.orderOfWellKnownPanels = r0;
    [r8 release];
    if (**___stack_chk_guard != var_8) {
            __stack_chk_fail();
    }
    return;


// 0x100022348
// ___42-[BottleViewController sortControlPanels:]_block_invoke_2
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
    r19 = [arg1 retain];
    r20 = [arg2 retain];
    r0 = [r19 valueForKey:@"exe"];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 lastPathComponent];
    r0 = [r0 retain];
    r24 = r0;
    r21 = [[r0 lowercaseString] retain];
    [r24 release];
    [r23 release];
    r0 = [r20 valueForKey:@"exe"];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 lastPathComponent];
    r0 = [r0 retain];
    r24 = r0;
    r22 = [[r0 lowercaseString] retain];
    [r24 release];
    [r23 release];
    r23 = [*_sortControlPanels:.orderOfWellKnownPanels indexOfObject:r21];
    r0 = *_sortControlPanels:.orderOfWellKnownPanels;
    r0 = [r0 indexOfObject:r22];
    if (r23 != 0x7fffffffffffffff) {
            if (r0 != 0x7fffffffffffffff) {
                    asm { cneg       x23, x8, hs };
                    [r22 release];
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    r0 = r23;
            }
            else {
                    bool_3 = r23 != 0x7fffffffffffffff;
                    asm { cneg       x23, x9, eq };
                    if (!bool_3) {
                            if (r0 == 0x7fffffffffffffff) {
                                    r24 = [[r19 valueForKey:@"name"] retain];
                                    r25 = [[r20 valueForKey:@"name"] retain];
                                    r23 = [r24 localizedCaseInsensitiveCompare:r25];
                                    [r25 release];
                                    [r24 release];
                            }
                    }
                    [r22 release];
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    r0 = r23;
            }
    }
    else {
            bool_1 = r23 != 0x7fffffffffffffff;
            asm { cneg       x23, x9, eq };
            if (!bool_1) {
                    if (r0 == 0x7fffffffffffffff) {
                            r24 = [[r19 valueForKey:@"name"] retain];
                            r25 = [[r20 valueForKey:@"name"] retain];
                            r23 = [r24 localizedCaseInsensitiveCompare:r25];
                            [r25 release];
                            [r24 release];
                    }
            }
            [r22 release];
            [r21 release];
            [r20 release];
            [r19 release];
            r0 = r23;
    }
    return r0;


// 0x1000237cc
// ___37-[BottleViewController msyncToggled:]_block_invoke
    r0 = arg0;
    if (r1 != 0x0) {
            var_20 = r20;
            decomp_var_18 = r19;
            r31 = r31 + 0xffffffffffffffe0;
            var_10 = r29;
            decomp_var_8 = r30;
            r19 = r0;
            if ([r0[0x4] state] != 0x1) {
                    r2 = 0x1;
            }
            [r19[0x4] setState:r2];
    }
    return;


// 0x1000238fc
// ___46-[BottleViewController highResolutionToggled:]_block_invoke
    r0 = arg0;
    if (r1 != 0x0) {
            var_20 = r20;
            decomp_var_18 = r19;
            r31 = r31 + 0xffffffffffffffe0;
            var_10 = r29;
            decomp_var_8 = r30;
            r19 = r0;
            if ([r0[0x4] state] != 0x1) {
                    r2 = 0x1;
            }
            [r19[0x4] setState:r2];
    }
    return;


// 0x100023a2c
// ___39-[BottleViewController previewToggled:]_block_invoke
    r0 = arg0;
    if (r1 != 0x0) {
            var_20 = r20;
            decomp_var_18 = r19;
            r31 = r31 + 0xffffffffffffffe0;
            var_10 = r29;
            decomp_var_8 = r30;
            r19 = r0;
            if ([r0[0x4] state] != 0x1) {
                    r2 = 0x1;
            }
            [r19[0x4] setState:r2];
    }
    return;


// 0x100023be4
// ___50-[BottleViewController controlPanelButtonClicked:]_block_invoke
    r20 = [arg1 retain];
    var_48 = *__NSConcreteStackBlock;
    var_18 = [arg0[0x5] retain];
    r19 = [r20 retain];
    dispatch_async(*__dispatch_main_q, &var_48);
    [var_18 release];
    [r20 release];
    r0 = [r19 release];
    return r0;


// 0x100023c84
// ___50-[BottleViewController controlPanelButtonClicked:]_block_invoke_2
    r20 = arg0[0x4];
    r21 = arg0[0x5];
    r0 = [r20 view];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 window] retain];
    [r20 presentError:r21 modalForWindow:r23 delegate:0x0 didPresentSelector:0x0 contextInfo:0x0];
    [r23 release];
    [r22 release];
    r0 = arg0[0x6];
    r0 = [r0 setEnabled:0x1];
    return r0;


// 0x100023d0c
// ___50-[BottleViewController controlPanelButtonClicked:]_block_invoke.182
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg0;
    r0 = arg0[0x4];
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = r19[0x5];
    r0 = [r0 release];
    if (r20 == r21) {
            r0 = r19[0x6];
            r0 = [r0 setEnabled:0x1];
    }
    return r0;


