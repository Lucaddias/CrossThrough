// MainWindowController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10005e8e4
// +[MainWindowController initialize]
    r31 = r31 - 0x40;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_18 = **___stack_chk_guard;
    if (objc_opt_class(@class(MainWindowController)) == self) {
            r19 = [[NSUserDefaults standardUserDefaults] retain];
            var_28 = @"HiddenLauncherIDs";
            var_20 = **___NSArray0__;
            r0 = [NSDictionary dictionaryWithObjects:&var_20 forKeys:&var_28 count:0x1];
            r20 = [r0 retain];
            [r19 registerDefaults:r20];
            [r20 release];
            [r19 release];
    }
    if (**___stack_chk_guard != var_18) {
            __stack_chk_fail();
    }
    return;


// 0x10005e9bc
// -[MainWindowController init]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] initWithWindowNibName:@"MainWindow"];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [[BottleViewController alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_bottleViewController));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            r0 = [[LauncherIconViewController alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_iconViewController));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            r0 = [[PackageViewController alloc] init];
            r20 = sign_extend_64(*(int32_t *)ivar_offset(_packageViewController));
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
            [*(r19 + r20) setDelegate:r19];
    }
    r0 = r19;
    return r0;


// 0x10005ea84
// -[MainWindowController dealloc]
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
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleSourceView);
    r21 = r0;
    [r0 setDelegate:0x0];
    [r21 release];
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleSourceView);
    r20 = r0;
    [r0 setDataSource:0x0];
    [r20 release];
    [r19->_packageViewController setDelegate:0x0];
    if (*(int8_t *)(r19 + sign_extend_64(*(int32_t *)ivar_offset(_observingBottleList))) != 0x0) {
            var_120 = q0;
            var_110 = q0;
            r0 = [CXSetupLib bottleCollectionClass];
            r0 = [r0 sharedCollection];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 bottleList] retain];
            [r21 release];
            r0 = [r20 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
            if (r0 != 0x0) {
                    r22 = r0;
                    r25 = *var_110;
                    do {
                            r26 = 0x0;
                            do {
                                    if (*var_110 != r25) {
                                            objc_enumerationMutation(r20);
                                    }
                                    [*(var_118 + r26 * 0x8) removeObserver:r19 forKeyPath:@"isBusy" context:*_MainWindowControllerKVOContext];
                                    r26 = r26 + 0x1;
                            } while (r22 != r26);
                            r0 = [r20 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
                            r22 = r0;
                    } while (r0 != 0x0);
            }
            [r20 release];
            r0 = [CXSetupLib bottleCollectionClass];
            r0 = [r0 sharedCollection];
            r0 = [r0 retain];
            r20 = r0;
            [r0 removeObserver:r19 forKeyPath:@"bottleList" context:*_MainWindowControllerKVOContext];
            [r20 release];
    }
    r0 = [NSUserDefaultsController sharedUserDefaultsController];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:r19 forKeyPath:@"values.AutoUpdateCrossTies" context:*_MainWindowControllerKVOContext];
    [r20 release];
    var_130 = r19;
    [[&var_130 super] dealloc];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x10005ecb4
// -[MainWindowController bottleNodes]
    r0 = self->_bottleNodes;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10005ecc4
// -[MainWindowController setBottleNodes:]
    r2 = arg2;
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_bottleNodes));
    if (*(r0 + r20) != r2) {
            r19 = r0;
            r0 = [r2 mutableCopy];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
    }
    return;


// 0x10005ed14
// -[MainWindowController insertObject:inBottleNodesAtIndex:]
    [self->_bottleNodes insertObject:arg2 atIndex:arg3];
    return;


// 0x10005ed24
// -[MainWindowController removeObjectFromBottleNodesAtIndex:]
    [self->_bottleNodes removeObjectAtIndex:arg2];
    return;


// 0x10005ed34
// -[MainWindowController selectedBottleNode]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_28 = **___stack_chk_guard;
    r0 = [self bottleSourceView];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 clickedRow];
    [r20 release];
    if (r21 != -0x1) {
            r20 = [[r19 bottleSourceView] retain];
            r0 = [r19 bottleSourceView];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r20 itemAtRow:[r0 clickedRow]] retain];
            [r22 release];
            [r20 release];
            if (r21 != 0x0) {
                    r0 = [r21 valueForKey:@"representedObject"];
                    r0 = [r0 retain];
                    r22 = r0;
                    var_30 = r0;
                    r0 = [NSArray arrayWithObjects:&var_30 count:0x1];
                    r20 = [r0 retain];
                    [r22 release];
                    [r21 release];
                    if (r20 == 0x0) {
                            r0 = [r19 bottleTreeController];
                            r0 = [r0 retain];
                            r19 = r0;
                            r20 = [[r0 selectedObjects] retain];
                            [r19 release];
                    }
            }
            else {
                    r0 = [r19 bottleTreeController];
                    r0 = [r0 retain];
                    r19 = r0;
                    r20 = [[r0 selectedObjects] retain];
                    [r19 release];
            }
    }
    else {
            r0 = [r19 bottleTreeController];
            r0 = [r0 retain];
            r19 = r0;
            r20 = [[r0 selectedObjects] retain];
            [r19 release];
    }
    if ([r20 count] == 0x1) {
            r0 = [r20 objectAtIndex:0x0];
            r0 = [r0 retain];
            r21 = r0;
            r19 = 0x0;
            if ([r0 type] == 0x2) {
                    r19 = [r21 retain];
            }
            [r21 release];
    }
    else {
            r19 = 0x0;
    }
    r0 = [r20 release];
    if (**___stack_chk_guard != var_28) {
            __stack_chk_fail();
    }
    r0 = [r19 autorelease];
    return r0;


// 0x10005eeec
// -[MainWindowController loadInfoForSelectedBottle]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r20 = r0;
            [r0 loadHighResolutionInfo];
            [r20 release];
    }
    [r19 release];
    return;


// 0x10005ef3c
// -[MainWindowController updateMainContentView]
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
    r0 = [self topMenuTreeController];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 selectedObjects] retain];
    [r21 release];
    if ([r19 count] == 0x0) {
            r0 = [r20 bottleTreeController];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 selectedObjects] retain];
            [r19 release];
            [r21 release];
            r19 = r22;
    }
    if ([r19 count] == 0x0) {
            r0 = [r20 bottomMenuTreeController];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 selectedObjects] retain];
            [r19 release];
            [r21 release];
            r19 = r22;
    }
    if ([r19 count] != 0x0) {
            r0 = [r19 objectAtIndexedSubscript:0x0];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 type];
            if (r0 != 0x1) {
                    if (r0 == 0x3) {
                            r0 = [r20 iconViewController];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 view];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 setHidden:0x1];
                            [r23 release];
                            [r22 release];
                            r0 = [r20 packageViewController];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 view];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 setHidden:0x0];
                            [r23 release];
                            [r22 release];
                            r0 = [r20 bottleViewController];
                            r0 = [r0 retain];
                            r20 = r0;
                            r0 = [r0 view];
                            r0 = [r0 retain];
                            r22 = r0;
                            [r0 setHidden:0x1];
                            [r22 release];
                            [r20 release];
                            [r21 release];
                            [r19 release];
                    }
                    else {
                            r0 = [r20 iconViewController];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 view];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 setHidden:0x1];
                            [r23 release];
                            [r22 release];
                            r0 = [r20 packageViewController];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 view];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 setHidden:0x1];
                            [r23 release];
                            [r22 release];
                            r0 = [r20 bottleViewController];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 view];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 setHidden:0x0];
                            [r23 release];
                            [r22 release];
                            r22 = [[r21 bottle] retain];
                            r0 = [r20 bottleViewController];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 setBottle:r22];
                            [r23 release];
                            [r22 release];
                            [r20 loadInfoForSelectedBottle];
                            [r21 release];
                            [r19 release];
                    }
            }
            else {
                    r0 = [r20 iconViewController];
                    r0 = [r0 retain];
                    r22 = r0;
                    r0 = [r0 view];
                    r0 = [r0 retain];
                    r23 = r0;
                    [r0 setHidden:0x0];
                    [r23 release];
                    [r22 release];
                    r0 = [r20 packageViewController];
                    r0 = [r0 retain];
                    r22 = r0;
                    r0 = [r0 view];
                    r0 = [r0 retain];
                    r23 = r0;
                    [r0 setHidden:0x1];
                    [r23 release];
                    [r22 release];
                    r0 = [r20 bottleViewController];
                    r0 = [r0 retain];
                    r20 = r0;
                    r0 = [r0 view];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 setHidden:0x1];
                    [r22 release];
                    [r20 release];
                    [r21 release];
                    [r19 release];
            }
    }
    else {
            [r20 selectDefaultView];
            [r19 release];
    }
    return;


// 0x10005f284
// -[MainWindowController privateBottlesGroupNameNoPublished]
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 localizedStringForKey:@"BOTTLES" value:@"" table:0x0] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10005f2e4
// -[MainWindowController windowDidLoad]
    r31 = r31 - 0xd0;
    var_70 = d11;
    decomp_var_68 = d10;
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
    var_78 = **___stack_chk_guard;
    r21 = [[NSMutableArray array] retain];
    r0 = [BottleNode allBottlesBottleNode];
    r0 = [r0 retain];
    r23 = r0;
    var_B0 = r0;
    [r0 setSortPriority:0x0];
    [r21 addObject:r23];
    [self setTopMenuNodes:r21];
    r23 = [[NSMutableArray array] retain];
    [r21 release];
    r0 = [BottleNode installBottleNode];
    r0 = [r0 retain];
    r21 = r0;
    var_B8 = r0;
    [r0 setSortPriority:0x0];
    [r23 addObject:r21];
    [self setBottomMenuNodes:r23];
    r0 = [NSMutableArray array];
    r0 = [r0 retain];
    r21 = r0;
    var_C0 = r0;
    [r23 release];
    r24 = [[self privateBottlesGroupNameNoPublished] retain];
    r23 = [[BottleNode groupBottleNodeWithName:r24] retain];
    [self setPrivateBottleGroup:r23];
    [r23 release];
    [r24 release];
    r0 = [self privateBottleGroup];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setSortPriority:0x2];
    [r23 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"PUBLISHED BOTTLES" value:@"" table:0x0] retain];
    r23 = [[BottleNode groupBottleNodeWithName:r25] retain];
    [self setPublishedBottleGroup:r23];
    [r23 release];
    [r25 release];
    [r24 release];
    r0 = [self publishedBottleGroup];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setSortPriority:0x3];
    [r23 release];
    [self setBottleNodes:r21];
    *(int8_t *)(int64_t *)&self->_observingBottleList = 0x1;
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r23 = r0;
    [r0 addObserver:self forKeyPath:@"bottleList" options:0x7 context:*_MainWindowControllerKVOContext];
    [r23 release];
    r0 = [NSSortDescriptor sortDescriptorWithKey:@"sortPriority" ascending:0x1 selector:@selector(compare:)];
    r0 = [r0 retain];
    r24 = r0;
    var_90 = r0;
    r25 = [[NSSortDescriptor sortDescriptorWithKey:@"bottle.isDefault" ascending:0x0 selector:@selector(compare:)] retain];
    r26 = [[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:0x1 selector:@selector(localizedStandardCompare:)] retain];
    r0 = [NSArray arrayWithObjects:&var_90 count:0x3];
    r23 = [r0 retain];
    [r26 release];
    [r25 release];
    [r24 release];
    r0 = [self bottleTreeController];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setSortDescriptors:r23];
    [r24 release];
    r0 = [self mainContentView];
    r0 = [r0 retain];
    r24 = r0;
    [r0 bounds];
    r0 = [self iconViewController];
    r0 = [r0 retain];
    r25 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r26 = r0;
    [r0 setFrame:r2];
    [r26 release];
    [r25 release];
    [r24 release];
    r0 = [self iconViewController];
    r0 = [r0 retain];
    r24 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setAutoresizingMask:0x12];
    [r25 release];
    [r24 release];
    r0 = [self mainContentView];
    r0 = [r0 retain];
    r24 = r0;
    [r0 bounds];
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r25 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r26 = r0;
    [r0 setFrame:r2];
    [r26 release];
    [r25 release];
    [r24 release];
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r24 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setAutoresizingMask:0x12];
    [r25 release];
    [r24 release];
    r0 = [self mainContentView];
    r0 = [r0 retain];
    r24 = r0;
    [r0 bounds];
    r0 = [self bottleViewController];
    r0 = [r0 retain];
    r25 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r26 = r0;
    [r0 setFrame:r2];
    [r26 release];
    [r25 release];
    [r24 release];
    r0 = [self bottleViewController];
    r0 = [r0 retain];
    r24 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r25 = r0;
    [r0 setAutoresizingMask:0x12];
    [r25 release];
    [r24 release];
    r0 = [self iconViewController];
    r0 = [r0 retain];
    r24 = r0;
    r0 = [r0 view];
    r0 = [r0 retain];
    r25 = r0;
    var_A8 = r0;
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r26 = r0;
    r27 = [[r0 view] retain];
    r0 = [self bottleViewController];
    r0 = [r0 retain];
    r28 = r0;
    r22 = [[r0 view] retain];
    r0 = [NSArray arrayWithObjects:&var_A8 count:0x3];
    r19 = [r0 retain];
    r0 = [self mainContentView];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setSubviews:r19];
    [r21 release];
    [r19 release];
    [r22 release];
    [r28 release];
    [r27 release];
    [r26 release];
    [r25 release];
    [r24 release];
    r0 = [self splitView];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setAutosaveName:@"MainWindowSplit22"];
    [r19 release];
    r19 = [[NSColor controlBackgroundColor] retain];
    r0 = [self window];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setBackgroundColor:r19];
    [r21 release];
    [r19 release];
    [self selectDefaultView];
    [self updateC4Ps];
    r0 = [NSUserDefaultsController sharedUserDefaultsController];
    r0 = [r0 retain];
    r19 = r0;
    [r0 addObserver:self forKeyPath:@"values.AutoUpdateCrossTies" options:0x0 context:*_MainWindowControllerKVOContext];
    [r19 release];
    [r23 release];
    [var_B8 release];
    [var_B0 release];
    [var_C0 release];
    if (**___stack_chk_guard != var_78) {
            __stack_chk_fail();
    }
    return;


// 0x10005fa60
// -[MainWindowController window:willUseFullScreenPresentationOptions:]
    r0 = arg3 | 0x800;
    return r0;


// 0x10005fa68
// -[MainWindowController selectLaunchView]
    r20 = [[self topMenuSourceView] retain];
    r21 = [[NSIndexSet indexSetWithIndex:0x0] retain];
    [r20 selectRowIndexes:r21 byExtendingSelection:0x0];
    [r21 release];
    [r20 release];
    r0 = [self bottleSourceView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 deselectAll:self];
    [r20 release];
    r0 = [self bottomMenuSourceView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 deselectAll:self];
    [r20 release];
    [self updateMainContentView];
    return;


// 0x10005fb24
// -[MainWindowController selectInstallView]
    r0 = [self topMenuSourceView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 deselectAll:self];
    [r20 release];
    r0 = [self bottleSourceView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 deselectAll:self];
    [r20 release];
    r20 = [[self bottomMenuSourceView] retain];
    r21 = [[NSIndexSet indexSetWithIndex:0x0] retain];
    [r20 selectRowIndexes:r21 byExtendingSelection:0x0];
    [r21 release];
    [r20 release];
    [self updateMainContentView];
    return;


// 0x10005fbe0
// -[MainWindowController selectDefaultView]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 bottleList];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 count];
    [r21 release];
    [r20 release];
    r0 = self;
    if (r22 != 0x0) {
            [r0 selectLaunchView];
    }
    else {
            [r0 selectInstallView];
    }
    return;


// 0x10005fc60
// -[MainWindowController updateC4Ps]
    r31 = r31 - 0x60;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 boolForKey:@"AutoUpdateCrossTies"];
    [r20 release];
    if (r21 != 0x0 && ([r19 updating] & 0x1) == 0x0) {
            [r19 setUpdating:0x1];
            r0 = dispatch_get_global_queue(0x0, 0x0);
            r0 = [r0 retain];
            r20 = r0;
            var_48 = *__NSConcreteStackBlock;
            dispatch_async(r0, &var_48);
            [r20 release];
    }
    return;


// 0x10005febc
// -[MainWindowController autoPlay:inBottle:]
    r21 = [arg3 retain];
    r19 = [arg2 retain];
    [self selectInstallView];
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 back];
    [r22 release];
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 autoPlay:r19];
    [r19 release];
    [r22 release];
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setSelectedBottle:r21];
    [r21 release];
    [r19 release];
    return;


// 0x10005ff78
// -[MainWindowController autoPlayWithAutorunFile:inBottle:]
    r21 = [arg3 retain];
    r19 = [arg2 retain];
    [self selectInstallView];
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 back];
    [r22 release];
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 autoPlayWithAutorunFile:r19];
    [r19 release];
    [r22 release];
    r0 = [self packageViewController];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setSelectedBottle:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100060034
// -[MainWindowController addIconsForBottles:]
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
    r0 = [arg2 retain];
    r20 = r0;
    var_110 = q0;
    var_100 = q0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r23 = *var_100;
            do {
                    r25 = 0x0;
                    do {
                            if (*var_100 != r23) {
                                    objc_enumerationMutation(r20);
                            }
                            [*(var_108 + r25 * 0x8) addObserver:r19 forKeyPath:@"isBusy" options:0x0 context:*_MainWindowControllerKVOContext];
                            r25 = r25 + 0x1;
                    } while (r22 != r25);
                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100060148
// -[MainWindowController isPreview]
    return 0x0;


// 0x100060150
// -[MainWindowController observeValueForKeyPath:ofObject:change:context:]
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
    r31 = r31 + 0xffffffffffffff90 - 0x300;
    r23 = arg5;
    r22 = self;
    var_70 = **___stack_chk_guard;
    r25 = [arg2 retain];
    r27 = [arg3 retain];
    r28 = [arg4 retain];
    if (*_MainWindowControllerKVOContext != r23) {
            var_200 = r22;
            [[&var_200 super] observeValueForKeyPath:r25 ofObject:r27 change:r28 context:r23];
            [r28 release];
            [r27 release];
            [r25 release];
            if (**___stack_chk_guard != var_70) {
                    __stack_chk_fail();
            }
    }
    else {
            r0 = [CXSetupLib bottleCollectionClass];
            r0 = [r0 sharedCollection];
            r0 = [r0 retain];
            if (r0 != r27) {
                    [r0 release];
                    if ([r25 isEqualToString:@"isBusy"] != 0x0) {
                            r0 = [r22 bottleSourceView];
                            r0 = [r0 retain];
                            r19 = r0;
                            r21 = [r0 numberOfRows];
                            [r19 release];
                            if (r21 >= 0x1) {
                                    r23 = 0x0;
                                    while (true) {
                                            r0 = [r22 bottleSourceView];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            r0 = [r0 itemAtRow:r23];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r24 = [[r0 representedObject] retain];
                                            [r21 release];
                                            [r19 release];
                                            r0 = [r24 bottle];
                                            r0 = [r0 retain];
                                            if (r0 == r27) {
                                                    r19 = [[r22 bottleSourceView] retain];
                                                    r0 = [r22 bottleSourceView];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    [r0 rectOfRow:r23];
                                                    [r19 setNeedsDisplayInRect:r2];
                                                    [r21 release];
                                                    [r19 release];
                                                    [r27 release];
                                                    r0 = r24;
                                                    temp_0 = 0x1;
                                                    break;
                                            }
                                            [r0 release];
                                            [r24 release];
                                            r23 = r23 + 0x1;
                                            r0 = [r22 bottleSourceView];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            r21 = [r0 numberOfRows];
                                            r0 = [r19 release];
                                            if (r21 > r23) {
                                                    continue;
                                            }
                                            temp_0 = 0x0;
                                            break;
                                    }
                                    if (temp_0 != 0x0) {
                                            [r0 release];
                                    }
                            }
                    }
                    else {
                            if ([r25 isEqualToString:@"values.AutoUpdateCrossTies"] != 0x0) {
                                    [r22 updateC4Ps];
                            }
                            else {
                                    objc_opt_class(@class(BottleNode));
                                    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                            r0 = [r22 bottleTreeController];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            [r0 rearrangeObjects];
                                            r0 = r19;
                                            [r0 release];
                                    }
                            }
                    }
                    [r28 release];
                    [r27 release];
                    [r25 release];
                    if (**___stack_chk_guard != var_70) {
                            __stack_chk_fail();
                    }
            }
            else {
                    r23 = [r25 isEqualToString:@"bottleList"];
                    [r27 release];
                    if (r23 != 0x0) {
                            [r22 updateMainContentView];
                            r0 = [r22 bottleSourceView];
                            r0 = [r0 retain];
                            r23 = r0;
                            r24 = [r0 clickedRow];
                            [r23 release];
                            if (r24 != -0x1) {
                                    r0 = [r22 bottleSourceView];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r0 = [r0 menu];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    [r0 cancelTracking];
                                    [r24 release];
                                    [r23 release];
                            }
                            r0 = [r28 objectForKey:**_NSKeyValueChangeKindKey];
                            r0 = [r0 retain];
                            r24 = r0;
                            r23 = [r0 intValue];
                            [r24 release];
                            r19 = [[r28 objectForKey:**_NSKeyValueChangeOldKey] retain];
                            r21 = [[r28 objectForKey:**_NSKeyValueChangeNewKey] retain];
                            if (r23 == 0x3) {
                                    r26 = 0x0;
                                    if ([r19 count] != 0x0) {
                                            r24 = [[NSMutableSet setWithArray:r19] retain];
                                            if (r23 != 0x3 && [r21 count] != 0x0) {
                                                    r23 = [[NSSet setWithArray:r21] retain];
                                                    [r24 minusSet:r23];
                                                    [r23 release];
                                            }
                                    }
                                    else {
                                            r24 = 0x0;
                                    }
                            }
                            else {
                                    if ([r21 count] != 0x0) {
                                            r26 = [[NSMutableSet setWithArray:r21] retain];
                                            if (r23 == 0x2) {
                                                    r24 = 0x0;
                                            }
                                            else {
                                                    if ([r19 count] != 0x0) {
                                                            r24 = [[NSSet setWithArray:r19] retain];
                                                            [r26 minusSet:r24];
                                                            [r24 release];
                                                    }
                                                    if ([r19 count] != 0x0) {
                                                            r24 = [[NSMutableSet setWithArray:r19] retain];
                                                            if (r23 != 0x3 && [r21 count] != 0x0) {
                                                                    r23 = [[NSSet setWithArray:r21] retain];
                                                                    [r24 minusSet:r23];
                                                                    [r23 release];
                                                            }
                                                    }
                                                    else {
                                                            r24 = 0x0;
                                                    }
                                            }
                                    }
                                    else {
                                            r26 = 0x0;
                                            r24 = 0x0;
                                            if (r23 != 0x2) {
                                                    if ([r19 count] != 0x0) {
                                                            r24 = [[NSMutableSet setWithArray:r19] retain];
                                                            if (r23 != 0x3 && [r21 count] != 0x0) {
                                                                    r23 = [[NSSet setWithArray:r21] retain];
                                                                    [r24 minusSet:r23];
                                                                    [r23 release];
                                                            }
                                                    }
                                                    else {
                                                            r24 = 0x0;
                                                    }
                                            }
                                    }
                            }
                            r0 = [r24 count];
                            var_338 = r27;
                            var_330 = r25;
                            var_348 = r19;
                            var_340 = r28;
                            var_358 = r26;
                            var_350 = r21;
                            var_360 = r24;
                            if (r0 != 0x0) {
                                    r0 = [r22 privateBottleGroup];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r26 = [[r0 children] retain];
                                    var_228 = *__NSConcreteStackBlock;
                                    d8 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbf0);
                                    r0 = [r24 retain];
                                    r24 = r0;
                                    var_208 = r0;
                                    r0 = [r26 indexesOfObjectsPassingTest:&var_228];
                                    r23 = [r0 retain];
                                    [r26 release];
                                    [r25 release];
                                    r0 = [r22 privateBottleGroup];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r0 = [r0 children];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r0 = [r0 objectsAtIndexes:r23];
                                    r0 = [r0 retain];
                                    r28 = r0;
                                    r27 = [r0 mutableCopy];
                                    [r28 release];
                                    [r26 release];
                                    [r25 release];
                                    if ([r23 count] != 0x0) {
                                            r0 = [r22 privateBottleGroup];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            [r0 removeChildrenAtIndexes:r23];
                                            [r25 release];
                                            r0 = [r22 privateBottleGroup];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r0 = [r0 children];
                                            r0 = [r0 retain];
                                            r26 = r0;
                                            r28 = [r0 count];
                                            [r26 release];
                                            [r25 release];
                                            if (r28 == 0x0) {
                                                    r26 = [[r22 bottleNodes] retain];
                                                    r28 = [[r22 privateBottleGroup] retain];
                                                    r25 = [r26 indexOfObjectIdenticalTo:r28];
                                                    [r28 release];
                                                    [r26 release];
                                                    if (r25 != 0x7fffffffffffffff) {
                                                            [r22 removeObjectFromBottleNodesAtIndex:r25];
                                                    }
                                            }
                                    }
                                    r19 = *__NSConcreteStackBlock;
                                    r0 = [r22 publishedBottleGroup];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r26 = [[r0 children] retain];
                                    var_250 = r19;
                                    r0 = [r24 retain];
                                    var_318 = r0;
                                    var_230 = r0;
                                    r0 = [r26 indexesOfObjectsPassingTest:&var_250];
                                    r24 = [r0 retain];
                                    [r23 release];
                                    [r26 release];
                                    [r25 release];
                                    if ([r24 count] != 0x0) {
                                            r0 = [r22 publishedBottleGroup];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r0 = [r0 children];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [[r0 objectsAtIndexes:r24] retain];
                                            [r27 addObjectsFromArray:r26];
                                            [r26 release];
                                            [r25 release];
                                            [r23 release];
                                            r0 = [r22 publishedBottleGroup];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            [r0 removeChildrenAtIndexes:r24];
                                            [r23 release];
                                            r0 = [r22 publishedBottleGroup];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r0 = [r0 children];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [r0 count];
                                            [r25 release];
                                            [r23 release];
                                            if (r26 == 0x0) {
                                                    r25 = [[r22 bottleNodes] retain];
                                                    r26 = [[r22 publishedBottleGroup] retain];
                                                    r23 = [r25 indexOfObjectIdenticalTo:r26];
                                                    [r26 release];
                                                    [r25 release];
                                                    if (r23 != 0x7fffffffffffffff) {
                                                            [r22 removeObjectFromBottleNodesAtIndex:r23];
                                                    }
                                                    r23 = [[r22 privateBottlesGroupNameNoPublished] retain];
                                                    r0 = [r22 privateBottleGroup];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    [r0 setName:r23];
                                                    [r25 release];
                                                    [r23 release];
                                            }
                                    }
                                    var_290 = q0;
                                    var_280 = q0;
                                    r0 = [r27 retain];
                                    r27 = r0;
                                    r0 = [r0 countByEnumeratingWithState:&var_290 objects:&decomp_var_f0 count:0x10];
                                    if (r0 != 0x0) {
                                            r26 = r0;
                                            r19 = *var_280;
                                            do {
                                                    r21 = 0x0;
                                                    do {
                                                            if (*var_280 != r19) {
                                                                    objc_enumerationMutation(r27);
                                                            }
                                                            r28 = *(var_288 + r21 * 0x8);
                                                            [r28 removeObserver:r22 forKeyPath:@"bottle.isDefault" context:*_MainWindowControllerKVOContext];
                                                            [r28 removeObserver:r22 forKeyPath:@"name" context:*_MainWindowControllerKVOContext];
                                                            r21 = r21 + 0x1;
                                                    } while (r26 != r21);
                                                    r0 = [r27 countByEnumeratingWithState:&var_290 objects:&decomp_var_f0 count:0x10];
                                                    r26 = r0;
                                            } while (r0 != 0x0);
                                    }
                                    [r27 release];
                                    var_2D0 = q0;
                                    var_2C0 = q0;
                                    r0 = [var_318 retain];
                                    r23 = r0;
                                    r0 = [r0 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_170 count:0x10];
                                    r28 = var_340;
                                    if (r0 != 0x0) {
                                            r26 = r0;
                                            r19 = *var_2C0;
                                            do {
                                                    r21 = 0x0;
                                                    do {
                                                            if (*var_2C0 != r19) {
                                                                    objc_enumerationMutation(r23);
                                                            }
                                                            [*(var_2C8 + r21 * 0x8) removeObserver:r22 forKeyPath:@"isBusy" context:*_MainWindowControllerKVOContext];
                                                            r21 = r21 + 0x1;
                                                    } while (r26 != r21);
                                                    r0 = [r23 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_170 count:0x10];
                                                    r26 = r0;
                                            } while (r0 != 0x0);
                                    }
                                    [r23 release];
                                    [var_230 release];
                                    [r27 release];
                                    [r24 release];
                                    [var_208 release];
                                    r27 = var_338;
                                    r25 = var_330;
                                    r21 = var_350;
                                    r19 = var_348;
                                    r24 = var_360;
                                    r26 = var_358;
                            }
                            if ([r26 count] != 0x0) {
                                    var_318 = [[NSMutableArray array] retain];
                                    r21 = [[NSMutableArray array] retain];
                                    var_310 = q0;
                                    var_300 = q0;
                                    r0 = [r26 retain];
                                    var_328 = r0;
                                    r0 = [r0 countByEnumeratingWithState:&var_310 objects:&decomp_var_1f0 count:0x10];
                                    var_320 = r21;
                                    if (r0 != 0x0) {
                                            r25 = r0;
                                            r24 = *var_300;
                                            do {
                                                    r28 = 0x0;
                                                    do {
                                                            if (*var_300 != r24) {
                                                                    objc_enumerationMutation(var_328);
                                                            }
                                                            r21 = *(var_308 + r28 * 0x8);
                                                            r0 = [BottleNode bottleNodeWithBottle:r21];
                                                            r0 = [r0 retain];
                                                            r19 = r0;
                                                            [r0 addObserver:r22 forKeyPath:@"bottle.isDefault" options:0x0 context:*_MainWindowControllerKVOContext];
                                                            [r19 addObserver:r22 forKeyPath:@"name" options:0x0 context:*_MainWindowControllerKVOContext];
                                                            r0 = [r21 isIsManaged];
                                                            r21 = var_320;
                                                            r8 = var_318;
                                                            if (r0 == 0x0) {
                                                                    r0 = r8;
                                                            }
                                                            else {
                                                                    r0 = r21;
                                                            }
                                                            [r0 addObject:r19];
                                                            [r19 release];
                                                            r28 = r28 + 0x1;
                                                    } while (r25 != r28);
                                                    r0 = [var_328 countByEnumeratingWithState:&var_310 objects:&decomp_var_1f0 count:0x10];
                                                    r25 = r0;
                                            } while (r0 != 0x0);
                                    }
                                    [var_328 release];
                                    if ([var_318 count] != 0x0) {
                                            r0 = [r22 privateBottleGroup];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            r0 = [r0 children];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r23 = [r0 count];
                                            [r21 release];
                                            [r19 release];
                                            if (r23 == 0x0) {
                                                    r19 = [[r22 privateBottleGroup] retain];
                                                    r0 = [r22 bottleNodes];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    [r22 insertObject:r19 inBottleNodesAtIndex:[r0 count]];
                                                    [r21 release];
                                                    [r19 release];
                                                    r0 = [r22 bottleSourceView];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    [r0 expandItem:0x0 expandChildren:0x1];
                                                    [r19 release];
                                            }
                                            r19 = [[r22 privateBottleGroup] retain];
                                            r0 = [r22 privateBottleGroup];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r0 = [r0 children];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [r0 count];
                                            [var_318 count];
                                            r21 = [[NSIndexSet indexSetWithIndexesInRange:r26] retain];
                                            [r19 insertChildren:var_318 atIndexes:r21];
                                            [r21 release];
                                            [r25 release];
                                            [r23 release];
                                            [r19 release];
                                            r21 = var_320;
                                    }
                                    r28 = var_340;
                                    r27 = var_338;
                                    r24 = var_360;
                                    if ([r21 count] != 0x0) {
                                            r0 = [r22 publishedBottleGroup];
                                            r0 = [r0 retain];
                                            r19 = r0;
                                            r0 = [r0 children];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r23 = [r0 count];
                                            [r21 release];
                                            [r19 release];
                                            if (r23 == 0x0) {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    r21 = [[r0 localizedStringForKey:@"PRIVATE BOTTLES" value:@"" table:0x0] retain];
                                                    r0 = [r22 privateBottleGroup];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    [r0 setName:r21];
                                                    [r23 release];
                                                    [r21 release];
                                                    [r19 release];
                                                    r19 = [[r22 publishedBottleGroup] retain];
                                                    r0 = [r22 bottleNodes];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    [r22 insertObject:r19 inBottleNodesAtIndex:[r0 count]];
                                                    [r21 release];
                                                    [r19 release];
                                                    r0 = [r22 bottleSourceView];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    [r0 expandItem:0x0 expandChildren:0x1];
                                                    [r19 release];
                                            }
                                            r19 = [[r22 publishedBottleGroup] retain];
                                            r0 = [r22 publishedBottleGroup];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r0 = [r0 children];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [r0 count];
                                            [var_320 count];
                                            r21 = [[NSIndexSet indexSetWithIndexesInRange:r26] retain];
                                            [r19 insertChildren:var_320 atIndexes:r21];
                                            r0 = r21;
                                            r21 = var_320;
                                            [r0 release];
                                            [r25 release];
                                            [r23 release];
                                            [r19 release];
                                    }
                                    [r22 addIconsForBottles:var_328];
                                    [r21 release];
                                    [var_318 release];
                                    r25 = var_330;
                                    r21 = var_350;
                                    r19 = var_348;
                                    r26 = var_358;
                            }
                            [r22 updateMainContentView];
                            [r24 release];
                            [r26 release];
                            [r21 release];
                            r0 = r19;
                            [r0 release];
                            [r28 release];
                            [r27 release];
                            [r25 release];
                            if (**___stack_chk_guard != var_70) {
                                    __stack_chk_fail();
                            }
                    }
                    else {
                            if ([r25 isEqualToString:@"isBusy"] != 0x0) {
                                    r0 = [r22 bottleSourceView];
                                    r0 = [r0 retain];
                                    r19 = r0;
                                    r21 = [r0 numberOfRows];
                                    [r19 release];
                                    if (r21 >= 0x1) {
                                            r23 = 0x0;
                                            while (true) {
                                                    r0 = [r22 bottleSourceView];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    r0 = [r0 itemAtRow:r23];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    r24 = [[r0 representedObject] retain];
                                                    [r21 release];
                                                    [r19 release];
                                                    r0 = [r24 bottle];
                                                    r0 = [r0 retain];
                                                    if (r0 == r27) {
                                                            r19 = [[r22 bottleSourceView] retain];
                                                            r0 = [r22 bottleSourceView];
                                                            r0 = [r0 retain];
                                                            r21 = r0;
                                                            [r0 rectOfRow:r23];
                                                            [r19 setNeedsDisplayInRect:r2];
                                                            [r21 release];
                                                            [r19 release];
                                                            [r27 release];
                                                            r0 = r24;
                                                            temp_0 = 0x1;
                                                            break;
                                                    }
                                                    [r0 release];
                                                    [r24 release];
                                                    r23 = r23 + 0x1;
                                                    r0 = [r22 bottleSourceView];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    r21 = [r0 numberOfRows];
                                                    r0 = [r19 release];
                                                    if (r21 > r23) {
                                                            continue;
                                                    }
                                                    temp_0 = 0x0;
                                                    break;
                                            }
                                            if (temp_0 != 0x0) {
                                                    [r0 release];
                                            }
                                    }
                            }
                            else {
                                    if ([r25 isEqualToString:@"values.AutoUpdateCrossTies"] != 0x0) {
                                            [r22 updateC4Ps];
                                    }
                                    else {
                                            objc_opt_class(@class(BottleNode));
                                            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                                    r0 = [r22 bottleTreeController];
                                                    r0 = [r0 retain];
                                                    r19 = r0;
                                                    [r0 rearrangeObjects];
                                                    r0 = r19;
                                                    [r0 release];
                                            }
                                    }
                            }
                            [r28 release];
                            [r27 release];
                            [r25 release];
                            if (**___stack_chk_guard != var_70) {
                                    __stack_chk_fail();
                            }
                    }
            }
    }
    return;


// 0x1000610bc
// -[MainWindowController outlineView:isGroupItem:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [arg3 representedObject];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 type] == 0x0) {
            r20 = 0x1;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100061100
// -[MainWindowController outlineView:shouldShowOutlineCellForItem:]
    r0 = [self outlineView:arg2 isGroupItem:arg3];
    r0 = r0 ^ 0x1;
    return r0;


// 0x100061118
// -[MainWindowController outlineView:shouldSelectItem:]
    r0 = [self outlineView:arg2 isGroupItem:arg3];
    r0 = r0 ^ 0x1;
    return r0;


// 0x100061130
// -[MainWindowController outlineView:didRemoveRowView:forRow:]
    [self updateMainContentView];
    return;


// 0x100061134
// -[MainWindowController outlineViewSelectionDidChange:]
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
    r20 = self;
    r19 = [arg2 retain];
    r0 = [r20 bottleTreeController];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 selectedObjects] retain];
    [r22 release];
    r0 = [r20 topMenuTreeController];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [[r0 selectedObjects] retain];
    [r23 release];
    r0 = [r20 bottomMenuTreeController];
    r0 = [r0 retain];
    r24 = r0;
    r23 = [[r0 selectedObjects] retain];
    [r24 release];
    r24 = [[r19 object] retain];
    r0 = [r20 topMenuSourceView];
    r0 = [r0 retain];
    if (r24 != r0) {
            [r0 release];
            [r24 release];
            r24 = [[r19 object] retain];
            r0 = [r20 bottleSourceView];
            r0 = [r0 retain];
            if (r24 != r0) {
                    [r0 release];
                    [r24 release];
                    r24 = [[r19 object] retain];
                    r0 = [r20 bottomMenuSourceView];
                    r0 = [r0 retain];
                    if (r24 != r0) {
                            [r0 release];
                            [r24 release];
                    }
                    else {
                            r25 = [r23 count];
                            [r24 release];
                            [r24 release];
                            if (r25 != 0x0) {
                                    if ([r22 count] != 0x0) {
                                            r0 = [r20 topMenuSourceView];
                                            r0 = [r0 retain];
                                            r24 = r0;
                                            [r0 deselectAll:r20];
                                            [r24 release];
                                    }
                                    if ([r21 count] != 0x0) {
                                            r0 = [r20 bottleSourceView];
                                            r0 = [r0 retain];
                                            r24 = r0;
                                            [r0 deselectAll:r20];
                                            [r24 release];
                                    }
                            }
                    }
                    [r20 updateMainContentView];
                    [r23 release];
                    [r22 release];
                    [r21 release];
                    [r19 release];
            }
            else {
                    r25 = [r21 count];
                    [r24 release];
                    [r24 release];
                    if (r25 != 0x0) {
                            if ([r22 count] != 0x0) {
                                    r0 = [r20 topMenuSourceView];
                                    r0 = [r0 retain];
                                    [r0 deselectAll:r20];
                                    [r0 release];
                            }
                            if ([r23 count] != 0x0) {
                                    r0 = [r20 bottomMenuSourceView];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    [r0 deselectAll:r20];
                                    [r24 release];
                            }
                            [r20 updateMainContentView];
                            [r23 release];
                            [r22 release];
                            [r21 release];
                            [r19 release];
                    }
                    else {
                            r24 = [[r19 object] retain];
                            r0 = [r20 bottomMenuSourceView];
                            r0 = [r0 retain];
                            if (r24 != r0) {
                                    [r0 release];
                                    [r24 release];
                            }
                            else {
                                    r25 = [r23 count];
                                    [r24 release];
                                    [r24 release];
                                    if (r25 != 0x0) {
                                            if ([r22 count] != 0x0) {
                                                    r0 = [r20 topMenuSourceView];
                                                    r0 = [r0 retain];
                                                    r24 = r0;
                                                    [r0 deselectAll:r20];
                                                    [r24 release];
                                            }
                                            if ([r21 count] != 0x0) {
                                                    r0 = [r20 bottleSourceView];
                                                    r0 = [r0 retain];
                                                    r24 = r0;
                                                    [r0 deselectAll:r20];
                                                    [r24 release];
                                            }
                                    }
                            }
                            [r20 updateMainContentView];
                            [r23 release];
                            [r22 release];
                            [r21 release];
                            [r19 release];
                    }
            }
    }
    else {
            r25 = [r22 count];
            [r24 release];
            [r24 release];
            if (r25 != 0x0) {
                    if ([r21 count] != 0x0) {
                            r0 = [r20 bottleSourceView];
                            r0 = [r0 retain];
                            [r0 deselectAll:r20];
                            [r0 release];
                    }
                    if ([r23 count] != 0x0) {
                            r0 = [r20 bottomMenuSourceView];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 deselectAll:r20];
                            [r24 release];
                    }
                    [r20 updateMainContentView];
                    [r23 release];
                    [r22 release];
                    [r21 release];
                    [r19 release];
            }
            else {
                    r24 = [[r19 object] retain];
                    r0 = [r20 bottleSourceView];
                    r0 = [r0 retain];
                    if (r24 != r0) {
                            [r0 release];
                            [r24 release];
                            r24 = [[r19 object] retain];
                            r0 = [r20 bottomMenuSourceView];
                            r0 = [r0 retain];
                            if (r24 != r0) {
                                    [r0 release];
                                    [r24 release];
                            }
                            else {
                                    r25 = [r23 count];
                                    [r24 release];
                                    [r24 release];
                                    if (r25 != 0x0) {
                                            if ([r22 count] != 0x0) {
                                                    r0 = [r20 topMenuSourceView];
                                                    r0 = [r0 retain];
                                                    r24 = r0;
                                                    [r0 deselectAll:r20];
                                                    [r24 release];
                                            }
                                            if ([r21 count] != 0x0) {
                                                    r0 = [r20 bottleSourceView];
                                                    r0 = [r0 retain];
                                                    r24 = r0;
                                                    [r0 deselectAll:r20];
                                                    [r24 release];
                                            }
                                    }
                            }
                            [r20 updateMainContentView];
                            [r23 release];
                            [r22 release];
                            [r21 release];
                            [r19 release];
                    }
                    else {
                            r25 = [r21 count];
                            [r24 release];
                            [r24 release];
                            if (r25 != 0x0) {
                                    if ([r22 count] != 0x0) {
                                            r0 = [r20 topMenuSourceView];
                                            r0 = [r0 retain];
                                            [r0 deselectAll:r20];
                                            [r0 release];
                                    }
                                    if ([r23 count] != 0x0) {
                                            r0 = [r20 bottomMenuSourceView];
                                            r0 = [r0 retain];
                                            r24 = r0;
                                            [r0 deselectAll:r20];
                                            [r24 release];
                                    }
                                    [r20 updateMainContentView];
                                    [r23 release];
                                    [r22 release];
                                    [r21 release];
                                    [r19 release];
                            }
                            else {
                                    r24 = [[r19 object] retain];
                                    r0 = [r20 bottomMenuSourceView];
                                    r0 = [r0 retain];
                                    if (r24 != r0) {
                                            [r0 release];
                                            [r24 release];
                                    }
                                    else {
                                            r25 = [r23 count];
                                            [r24 release];
                                            [r24 release];
                                            if (r25 != 0x0) {
                                                    if ([r22 count] != 0x0) {
                                                            r0 = [r20 topMenuSourceView];
                                                            r0 = [r0 retain];
                                                            r24 = r0;
                                                            [r0 deselectAll:r20];
                                                            [r24 release];
                                                    }
                                                    if ([r21 count] != 0x0) {
                                                            r0 = [r20 bottleSourceView];
                                                            r0 = [r0 retain];
                                                            r24 = r0;
                                                            [r0 deselectAll:r20];
                                                            [r24 release];
                                                    }
                                            }
                                    }
                                    [r20 updateMainContentView];
                                    [r23 release];
                                    [r22 release];
                                    [r21 release];
                                    [r19 release];
                            }
                    }
            }
    }
    return;


// 0x1000613f0
// -[MainWindowController outlineView:rowViewForItem:]
    r0 = [[BottleTableRowView alloc] init];
    r0 = [r0 autorelease];
    return r0;


// 0x10006140c
// -[MainWindowController outlineView:viewForTableColumn:item:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r9 = arg2;
    r8 = self;
    if (arg3 != 0x0) {
            r2 = @"DataCell";
    }
    else {
            r2 = @"HeaderCell";
    }
    r0 = [r9 makeViewWithIdentifier:r2 owner:r8];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 textField];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setAutoresizingMask:0x0];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100061480
// -[MainWindowController validateUserInterfaceItem:]
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
    if ([r0 action] != @selector(duplicateBottle:)) {
            if ([r19 action] != @selector(toggleDefaultBottle:)) {
                    if ([r19 action] != @selector(deleteBottle:)) {
                            if ([r19 action] != @selector(exportBottleToArchive:)) {
                                    if ([r19 action] != @selector(openBottleCDrive:)) {
                                            if ([r19 action] != @selector(renameBottle:)) {
                                                    if ([r19 action] != @selector(publishBottle:)) {
                                                            if ([r19 action] != @selector(toggleBottleHighResolution:)) {
                                                                    if ([r19 action] != @selector(toggleBottleGraphicsAuto:)) {
                                                                            if ([r19 action] != @selector(toggleBottleGraphicsD3DMetal:)) {
                                                                                    if ([r19 action] != @selector(toggleBottleGraphicsDXMT:)) {
                                                                                            if ([r19 action] != @selector(toggleBottleGraphicsDXVK:)) {
                                                                                                    if ([r19 action] != @selector(toggleBottleVulkanMoltenVK:)) {
                                                                                                            if ([r19 action] != @selector(toggleBottleVulkanMTLVK:)) {
                                                                                                                    if ([r19 action] != @selector(toggleBottleDLSS:)) {
                                                                                                                            if ([r19 action] != @selector(toggleBottleMSync:)) {
                                                                                                                                    if ([r19 action] != @selector(toggleBottlePreview:)) {
                                                                                                                                            if ([r19 action] != @selector(updateBottle:)) {
                                                                                                                                                    if ([r19 action] != @selector(installSoftwareToBottle:)) {
                                                                                                                                                            if ([r19 action] != @selector(runCommandInBottle:)) {
                                                                                                                                                                    if ([r19 action] != @selector(openShellForBottle:)) {
                                                                                                                                                                            if ([r19 action] != @selector(quitBottle:)) {
                                                                                                                                                                                    if ([r19 action] != @selector(forceQuitBottle:)) {
                                                                                                                                                                                            r21 = 0x1;
                                                                                                                                                                                    }
                                                                                                                                                                                    else {
                                                                                                                                                                                            r0 = [r20 selectedBottleNode];
                                                                                                                                                                                            r0 = [r0 retain];
                                                                                                                                                                                            r21 = r0;
                                                                                                                                                                                            r20 = [[r0 bottle] retain];
                                                                                                                                                                                            [r21 release];
                                                                                                                                                                                            r0 = [r20 isCanForceQuit];
                                                                                                                                                                                            r21 = r0;
                                                                                                                                                                                            [r20 release];
                                                                                                                                                                                    }
                                                                                                                                                                            }
                                                                                                                                                                            else {
                                                                                                                                                                                    r0 = [r20 selectedBottleNode];
                                                                                                                                                                                    r0 = [r0 retain];
                                                                                                                                                                                    r21 = r0;
                                                                                                                                                                                    r20 = [[r0 bottle] retain];
                                                                                                                                                                                    [r21 release];
                                                                                                                                                                                    r0 = [r20 isIsActive];
                                                                                                                                                                                    r21 = r0;
                                                                                                                                                                                    [r20 release];
                                                                                                                                                                            }
                                                                                                                                                                            [r19 release];
                                                                                                                                                                            r0 = r21;
                                                                                                                                                                    }
                                                                                                                                                                    else {
                                                                                                                                                                            r0 = [r20 selectedBottleNode];
                                                                                                                                                                            r0 = [r0 retain];
                                                                                                                                                                            r21 = r0;
                                                                                                                                                                            r20 = [[r0 bottle] retain];
                                                                                                                                                                            [r21 release];
                                                                                                                                                                            r0 = [r20 isCanRunCommands];
                                                                                                                                                                            r21 = r0;
                                                                                                                                                                            [r20 release];
                                                                                                                                                                            [r19 release];
                                                                                                                                                                            r0 = r21;
                                                                                                                                                                    }
                                                                                                                                                            }
                                                                                                                                                            else {
                                                                                                                                                                    r0 = [r20 selectedBottleNode];
                                                                                                                                                                    r0 = [r0 retain];
                                                                                                                                                                    r21 = r0;
                                                                                                                                                                    r20 = [[r0 bottle] retain];
                                                                                                                                                                    [r21 release];
                                                                                                                                                                    r0 = [r20 isCanRunCommands];
                                                                                                                                                                    r21 = r0;
                                                                                                                                                                    [r20 release];
                                                                                                                                                                    [r19 release];
                                                                                                                                                                    r0 = r21;
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                                    else {
                                                                                                                                                            r0 = [r20 selectedBottleNode];
                                                                                                                                                            r0 = [r0 retain];
                                                                                                                                                            r21 = r0;
                                                                                                                                                            r20 = [[r0 bottle] retain];
                                                                                                                                                            [r21 release];
                                                                                                                                                            r0 = [r20 isCanInstall];
                                                                                                                                                            r21 = r0;
                                                                                                                                                            [r20 release];
                                                                                                                                                            [r19 release];
                                                                                                                                                            r0 = r21;
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    r0 = [r20 selectedBottleNode];
                                                                                                                                                    r0 = [r0 retain];
                                                                                                                                                    r21 = r0;
                                                                                                                                                    r20 = [[r0 bottle] retain];
                                                                                                                                                    [r21 release];
                                                                                                                                                    if ([r20 isIsManaged] != 0x0) {
                                                                                                                                                            if (([r20 isIsUpToDate] & 0x1) != 0x0) {
                                                                                                                                                                    [r20 release];
                                                                                                                                                                    [r19 release];
                                                                                                                                                                    r0 = 0x0;
                                                                                                                                                            }
                                                                                                                                                            else {
                                                                                                                                                                    r0 = [r20 isIsBusy];
                                                                                                                                                                    r21 = r0 ^ 0x1;
                                                                                                                                                                    [r20 release];
                                                                                                                                                                    [r19 release];
                                                                                                                                                                    r0 = r21;
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                                    else {
                                                                                                                                                            [r20 release];
                                                                                                                                                            [r19 release];
                                                                                                                                                            r0 = 0x0;
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            r0 = [r20 selectedBottleNode];
                                                                                                                                            r0 = [r0 retain];
                                                                                                                                            r21 = r0;
                                                                                                                                            r20 = [[r0 bottle] retain];
                                                                                                                                            [r21 release];
                                                                                                                                            r0 = [r20 isIsManaged];
                                                                                                                                            r21 = r0 ^ 0x1;
                                                                                                                                            [r20 release];
                                                                                                                                            [r19 release];
                                                                                                                                            r0 = r21;
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    r0 = [r20 selectedBottleNode];
                                                                                                                                    r0 = [r0 retain];
                                                                                                                                    r21 = r0;
                                                                                                                                    r20 = [[r0 bottle] retain];
                                                                                                                                    [r21 release];
                                                                                                                                    if (([r20 isIsManaged] & 0x1) != 0x0) {
                                                                                                                                            [r20 release];
                                                                                                                                            [r19 release];
                                                                                                                                            r0 = 0x0;
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            r0 = [r20 isIsDisabled];
                                                                                                                                            r21 = r0 ^ 0x1;
                                                                                                                                            [r20 release];
                                                                                                                                            [r19 release];
                                                                                                                                            r0 = r21;
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            r0 = [r20 selectedBottleNode];
                                                                                                                            r0 = [r0 retain];
                                                                                                                            r21 = r0;
                                                                                                                            r20 = [[r0 bottle] retain];
                                                                                                                            [r21 release];
                                                                                                                            if (([r20 isIsManaged] & 0x1) == 0x0) {
                                                                                                                                    if ([r20 isCanRunCommands] != 0x0) {
                                                                                                                                            if (([r20 isIsDisabled] & 0x1) == 0x0) {
                                                                                                                                                    r0 = [r20 isIsDLSSAvailable];
                                                                                                                                                    r21 = r0;
                                                                                                                                                    [r20 release];
                                                                                                                                                    [r19 release];
                                                                                                                                                    r0 = r21;
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    [r20 release];
                                                                                                                                                    [r19 release];
                                                                                                                                                    r0 = 0x0;
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            [r20 release];
                                                                                                                                            [r19 release];
                                                                                                                                            r0 = 0x0;
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    [r20 release];
                                                                                                                                    [r19 release];
                                                                                                                                    r0 = 0x0;
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r0 = [r20 selectedBottleNode];
                                                                                                                    r0 = [r0 retain];
                                                                                                                    r21 = r0;
                                                                                                                    r20 = [[r0 bottle] retain];
                                                                                                                    [r21 release];
                                                                                                                    if (([r20 isIsManaged] & 0x1) == 0x0) {
                                                                                                                            if ([r20 isCanRunCommands] != 0x0) {
                                                                                                                                    if (([r20 isIsDisabled] & 0x1) == 0x0) {
                                                                                                                                            if ([r20 isIsMTLVKAvailable] != 0x0) {
                                                                                                                                                    if (([r20 isIsD3DMetalEnabled] & 0x1) == 0x0) {
                                                                                                                                                            if (([r20 isIsDXMTEnabled] & 0x1) == 0x0) {
                                                                                                                                                                    r0 = [r20 isIsDXVKEnabled];
                                                                                                                                                                    r21 = r0 ^ 0x1;
                                                                                                                                                            }
                                                                                                                                                            else {
                                                                                                                                                                    r21 = 0x0;
                                                                                                                                                            }
                                                                                                                                                            [r20 release];
                                                                                                                                                            [r19 release];
                                                                                                                                                            r0 = r21;
                                                                                                                                                    }
                                                                                                                                                    else {
                                                                                                                                                            [r20 release];
                                                                                                                                                            [r19 release];
                                                                                                                                                            r0 = 0x0;
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    [r20 release];
                                                                                                                                                    [r19 release];
                                                                                                                                                    r0 = 0x0;
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            [r20 release];
                                                                                                                                            [r19 release];
                                                                                                                                            r0 = 0x0;
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    [r20 release];
                                                                                                                                    [r19 release];
                                                                                                                                    r0 = 0x0;
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            [r20 release];
                                                                                                                            [r19 release];
                                                                                                                            r0 = 0x0;
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r0 = [r20 selectedBottleNode];
                                                                                                            r0 = [r0 retain];
                                                                                                            r21 = r0;
                                                                                                            r20 = [[r0 bottle] retain];
                                                                                                            [r21 release];
                                                                                                            if (([r20 isIsManaged] & 0x1) == 0x0) {
                                                                                                                    if ([r20 isCanRunCommands] != 0x0) {
                                                                                                                            r0 = [r20 isIsDisabled];
                                                                                                                            r21 = r0 ^ 0x1;
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            r21 = 0x0;
                                                                                                                    }
                                                                                                                    [r20 release];
                                                                                                                    [r19 release];
                                                                                                                    r0 = r21;
                                                                                                            }
                                                                                                            else {
                                                                                                                    [r20 release];
                                                                                                                    [r19 release];
                                                                                                                    r0 = 0x0;
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    r0 = [r20 selectedBottleNode];
                                                                                                    r0 = [r0 retain];
                                                                                                    r21 = r0;
                                                                                                    r20 = [[r0 bottle] retain];
                                                                                                    [r21 release];
                                                                                                    if (([r20 isIsManaged] & 0x1) == 0x0) {
                                                                                                            if ([r20 isCanRunCommands] != 0x0) {
                                                                                                                    if (([r20 isIsDisabled] & 0x1) == 0x0) {
                                                                                                                            r0 = [r20 isIsMTLVKEnabled];
                                                                                                                            r21 = r0 ^ 0x1;
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            r21 = 0x0;
                                                                                                                    }
                                                                                                                    [r20 release];
                                                                                                                    [r19 release];
                                                                                                                    r0 = r21;
                                                                                                            }
                                                                                                            else {
                                                                                                                    [r20 release];
                                                                                                                    [r19 release];
                                                                                                                    r0 = 0x0;
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            [r20 release];
                                                                                                            [r19 release];
                                                                                                            r0 = 0x0;
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r0 = [r20 selectedBottleNode];
                                                                                            r0 = [r0 retain];
                                                                                            r21 = r0;
                                                                                            r20 = [[r0 bottle] retain];
                                                                                            [r21 release];
                                                                                            if (([r20 isIsManaged] & 0x1) == 0x0) {
                                                                                                    if ([r20 isCanRunCommands] != 0x0) {
                                                                                                            if (([r20 isIsDisabled] & 0x1) == 0x0) {
                                                                                                                    if ([r20 isIsDXMTAvailable] == 0x0) {
                                                                                                                            r21 = 0x0;
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            r0 = [r20 isIsMTLVKEnabled];
                                                                                                                            r21 = r0 ^ 0x1;
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r21 = 0x0;
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r21 = 0x0;
                                                                                                    }
                                                                                                    [r20 release];
                                                                                                    [r19 release];
                                                                                                    r0 = r21;
                                                                                            }
                                                                                            else {
                                                                                                    [r20 release];
                                                                                                    [r19 release];
                                                                                                    r0 = 0x0;
                                                                                            }
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r0 = [r20 selectedBottleNode];
                                                                                    r0 = [r0 retain];
                                                                                    r21 = r0;
                                                                                    r20 = [[r0 bottle] retain];
                                                                                    [r21 release];
                                                                                    if (([r20 isIsManaged] & 0x1) == 0x0) {
                                                                                            if ([r20 isCanRunCommands] != 0x0) {
                                                                                                    if (([r20 isIsDisabled] & 0x1) == 0x0) {
                                                                                                            if ([r20 isIsD3DMetalAvailable] == 0x0) {
                                                                                                                    r21 = 0x0;
                                                                                                            }
                                                                                                            else {
                                                                                                                    r0 = [r20 isIsMTLVKEnabled];
                                                                                                                    r21 = r0 ^ 0x1;
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r21 = 0x0;
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    r21 = 0x0;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r21 = 0x0;
                                                                                    }
                                                                                    [r20 release];
                                                                                    [r19 release];
                                                                                    r0 = r21;
                                                                            }
                                                                    }
                                                                    else {
                                                                            r0 = [r20 selectedBottleNode];
                                                                            r0 = [r0 retain];
                                                                            r21 = r0;
                                                                            r20 = [[r0 bottle] retain];
                                                                            [r21 release];
                                                                            if (([r20 isIsManaged] & 0x1) == 0x0) {
                                                                                    if ([r20 isCanRunCommands] != 0x0) {
                                                                                            r0 = [r20 isIsDisabled];
                                                                                            r21 = r0 ^ 0x1;
                                                                                    }
                                                                                    else {
                                                                                            r21 = 0x0;
                                                                                    }
                                                                                    [r20 release];
                                                                                    [r19 release];
                                                                                    r0 = r21;
                                                                            }
                                                                            else {
                                                                                    [r20 release];
                                                                                    [r19 release];
                                                                                    r0 = 0x0;
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    r0 = [r20 selectedBottleNode];
                                                                    r0 = [r0 retain];
                                                                    r21 = r0;
                                                                    r20 = [[r0 bottle] retain];
                                                                    [r21 release];
                                                                    if (([r20 isIsManaged] & 0x1) == 0x0) {
                                                                            if ([r20 isIsHighResolutionEnabledReady] != 0x0) {
                                                                                    if ([r20 isIsActive] == 0x0) {
                                                                                            r21 = 0x0;
                                                                                    }
                                                                                    else {
                                                                                            r0 = [r20 isIsDisabled];
                                                                                            r21 = r0 ^ 0x1;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r21 = 0x0;
                                                                            }
                                                                    }
                                                                    else {
                                                                            r21 = 0x0;
                                                                    }
                                                                    [r20 release];
                                                                    [r19 release];
                                                                    r0 = r21;
                                                            }
                                                    }
                                                    else {
                                                            if (([@"1" isEqualToString:@"0"] & 0x1) != 0x0) {
                                                                    [r19 release];
                                                                    r0 = 0x0;
                                                            }
                                                            else {
                                                                    r0 = [r20 selectedBottleNode];
                                                                    r0 = [r0 retain];
                                                                    r21 = r0;
                                                                    r20 = [[r0 bottle] retain];
                                                                    [r21 release];
                                                                    if (([r20 isIsManaged] & 0x1) != 0x0) {
                                                                            r21 = 0x0;
                                                                    }
                                                                    else {
                                                                            r0 = [r20 isIsUsable];
                                                                            r21 = r0;
                                                                    }
                                                                    [r20 release];
                                                                    [r19 release];
                                                                    r0 = r21;
                                                            }
                                                    }
                                            }
                                            else {
                                                    r0 = [r20 selectedBottleNode];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    r20 = [[r0 bottle] retain];
                                                    [r21 release];
                                                    r0 = [r20 isCanRename];
                                                    r21 = r0;
                                                    [r20 release];
                                                    [r19 release];
                                                    r0 = r21;
                                            }
                                    }
                                    else {
                                            r0 = [r20 selectedBottleNode];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r20 = [[r0 bottle] retain];
                                            [r21 release];
                                            if (r20 != 0x0) {
                                                    r0 = [r20 isIsUsable];
                                                    r21 = r0;
                                            }
                                            else {
                                                    r21 = 0x0;
                                            }
                                            [r20 release];
                                            [r19 release];
                                            r0 = r21;
                                    }
                            }
                            else {
                                    r0 = [r20 selectedBottleNode];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r20 = [[r0 bottle] retain];
                                    [r21 release];
                                    if (r20 != 0x0) {
                                            r0 = [r20 isIsBusy];
                                            r21 = r0 ^ 0x1;
                                    }
                                    else {
                                            r21 = 0x0;
                                    }
                                    [r20 release];
                                    [r19 release];
                                    r0 = r21;
                            }
                    }
                    else {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r21 = r0;
                            r20 = [[r0 bottle] retain];
                            [r21 release];
                            if (r20 != 0x0) {
                                    r0 = [r20 isIsBusy];
                                    r21 = r0 ^ 0x1;
                            }
                            else {
                                    r21 = 0x0;
                            }
                            [r20 release];
                            [r19 release];
                            r0 = r21;
                    }
            }
            else {
                    r0 = [r20 selectedBottleNode];
                    r0 = [r0 retain];
                    r21 = r0;
                    r20 = [[r0 bottle] retain];
                    [r21 release];
                    if (r20 != 0x0) {
                            r0 = [r20 isIsBusy];
                            r21 = r0 ^ 0x1;
                    }
                    else {
                            r21 = 0x0;
                    }
                    [r20 release];
                    [r19 release];
                    r0 = r21;
            }
    }
    else {
            r0 = [r20 selectedBottleNode];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 bottle] retain];
            [r21 release];
            if (r20 != 0x0) {
                    r0 = [r20 isIsBusy];
                    r21 = r0 ^ 0x1;
            }
            else {
                    r21 = 0x0;
            }
            [r20 release];
            [r19 release];
            r0 = r21;
    }
    return r0;


// 0x100061c3c
// -[MainWindowController setMenuItem:genericTitle:bottleTitleFormat:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [[r0 bottle] retain];
    [r23 release];
    if (r22 != 0x0) {
            r24 = [[r22 name] retain];
            r23 = [[NSString stringWithFormat:r21] retain];
            [r19 setTitle:r23];
            [r23 release];
            [r24 release];
    }
    else {
            [r19 setTitle:r20];
    }
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x100061d4c
// -[MainWindowController menuNeedsUpdate:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r0 = [r20 bottleSourceView];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 menu];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    [r21 release];
    if (r22 == r19) {
            r0 = [r20 selectedBottleNode];
            r0 = [r0 retain];
            r20 = r0;
            [r0 release];
            if (r20 == 0x0) {
                    [r19 cancelTracking];
            }
    }
    [r19 release];
    return;


// 0x100061ddc
// -[MainWindowController menuWillOpen:]
    [self loadInfoForSelectedBottle];
    return;


// 0x100061de0
// -[MainWindowController validateMenuItem:]
    r2 = arg2;
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
    r20 = self;
    r19 = [r2 retain];
    r0 = **_NSApp;
    r0 = [r0 modalWindow];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r22 = r0;
            r21 = 0x0;
            [r22 release];
    }
    else {
            r0 = [r20 window];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 attachedSheet];
            r0 = [r0 retain];
            r22 = r0;
            [r0 release];
            [r21 release];
            if (r22 != 0x0) {
                    r21 = 0x0;
            }
            else {
                    if ([r19 action] == @selector(toggleDefaultBottle:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r21 = r0;
                            r22 = [[r0 bottle] retain];
                            [r21 release];
                            r2 = [r22 isIsDefault];
                            [r19 setState:r2];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(toggleBottleHighResolution:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0 && [r21 isIsHighResolutionEnabledReady] != 0x0) {
                                    r2 = [r21 isIsHighResolutionEnabled];
                            }
                            else {
                                    asm { csetm      x2, ne };
                            }
                            [r19 setState:r2];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottleGraphicsAuto:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    if (([r21 isIsD3DMetalEnabled] & 0x1) == 0x0) {
                                            if (([r21 isIsDXMTEnabled] & 0x1) != 0x0) {
                                                    r8 = 0x0;
                                            }
                                            else {
                                                    r8 = [r21 isIsDXVKEnabled] ^ 0x1;
                                            }
                                    }
                                    else {
                                            r8 = 0x0;
                                    }
                            }
                            else {
                                    r8 = 0x0;
                            }
                            [r19 setState:r8];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottleGraphicsD3DMetal:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r0 = [r21 isIsD3DMetalEnabled];
                            }
                            else {
                                    r0 = 0x0;
                            }
                            [r19 setState:r0];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottleGraphicsDXMT:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r0 = [r21 isIsDXMTEnabled];
                            }
                            else {
                                    r0 = 0x0;
                            }
                            [r19 setState:r0];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottleGraphicsDXVK:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r0 = [r21 isIsDXVKEnabled];
                            }
                            else {
                                    r0 = 0x0;
                            }
                            [r19 setState:r0];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottleVulkanMoltenVK:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r0 = [r21 isIsMoltenVKEnabled];
                            }
                            else {
                                    r0 = 0x0;
                            }
                            [r19 setState:r0];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottleVulkanMTLVK:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r0 = [r21 isIsMTLVKEnabled];
                            }
                            else {
                                    r0 = 0x0;
                            }
                            [r19 setState:r0];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottleDLSS:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r2 = [r21 isIsDLSSEnabled];
                            }
                            else {
                                    r2 = 0x0;
                            }
                            [r19 setState:r2];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottleMSync:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r2 = [r21 isIsMSyncEnabled];
                            }
                            else {
                                    r2 = 0x0;
                            }
                            [r19 setState:r2];
                            [r21 release];
                    }
                    if ([r19 action] == @selector(toggleBottlePreview:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r22 = r0;
                            r21 = [[r0 bottle] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r2 = [r21 isIsPreviewEnabled];
                            }
                            else {
                                    r2 = 0x0;
                            }
                            [r19 setState:r2];
                            [r21 release];
                    }
                    r21 = [r20 validateUserInterfaceItem:r19];
                    if ([r19 action] == @selector(duplicateBottle:)) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r24 = [[r0 localizedStringForKey:@"Duplicate Bottle…" value:@"" table:0x0] retain];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            r23 = [[r0 localizedStringForKey:@"Duplicate '%@'…" value:@"" table:0x0] retain];
                            [r20 setMenuItem:r19 genericTitle:r24 bottleTitleFormat:r23];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(renameBottle:)) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r24 = [[r0 localizedStringForKey:@"Rename Bottle…" value:@"" table:0x0] retain];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            r23 = [[r0 localizedStringForKey:@"Rename '%@'…" value:@"" table:0x0] retain];
                            [r20 setMenuItem:r19 genericTitle:r24 bottleTitleFormat:r23];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(deleteBottle:)) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r24 = [[r0 localizedStringForKey:@"Delete Bottle…" value:@"" table:0x0] retain];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            r23 = [[r0 localizedStringForKey:@"Delete '%@'…" value:@"" table:0x0] retain];
                            [r20 setMenuItem:r19 genericTitle:r24 bottleTitleFormat:r23];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(exportBottleToArchive:)) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r24 = [[r0 localizedStringForKey:@"Export Bottle to Archive…" value:@"" table:0x0] retain];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            r23 = [[r0 localizedStringForKey:@"Export '%@' to Archive…" value:@"" table:0x0] retain];
                            [r20 setMenuItem:r19 genericTitle:r24 bottleTitleFormat:r23];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(publishBottle:)) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r24 = [[r0 localizedStringForKey:@"Publish Bottle…" value:@"" table:0x0] retain];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            r23 = [[r0 localizedStringForKey:@"Publish '%@'…" value:@"" table:0x0] retain];
                            [r20 setMenuItem:r19 genericTitle:r24 bottleTitleFormat:r23];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(updateBottle:)) {
                            r0 = [r20 selectedBottleNode];
                            r0 = [r0 retain];
                            r23 = r0;
                            r22 = [[r0 bottle] retain];
                            [r23 release];
                            if (r22 != 0x0) {
                                    r24 = r21;
                            }
                            else {
                                    r24 = 0x0;
                            }
                            r23 = [[NSBundle mainBundle] retain];
                            if (r24 == 0x1) {
                                    r25 = [[r23 localizedStringForKey:@"Update '%@'…" value:@"" table:0x0] retain];
                                    [r23 release];
                                    r24 = [[r22 name] retain];
                                    r23 = [[NSString stringWithFormat:r25] retain];
                                    [r19 setTitle:r23];
                                    [r23 release];
                                    r23 = r25;
                            }
                            else {
                                    r24 = [[r23 localizedStringForKey:@"Update Published Bottle…" value:@"" table:0x0] retain];
                                    [r19 setTitle:r24];
                            }
                            [r24 release];
                            [r23 release];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(installSoftwareToBottle:)) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r24 = [[r0 localizedStringForKey:@"Install Software into Bottle…" value:@"" table:0x0] retain];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            r23 = [[r0 localizedStringForKey:@"Install Software into '%@'…" value:@"" table:0x0] retain];
                            [r20 setMenuItem:r19 genericTitle:r24 bottleTitleFormat:r23];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(quitBottle:)) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r24 = [[r0 localizedStringForKey:@"Quit Bottle" value:@"" table:0x0] retain];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            r23 = [[r0 localizedStringForKey:@"Quit '%@'" value:@"" table:0x0] retain];
                            [r20 setMenuItem:r19 genericTitle:r24 bottleTitleFormat:r23];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            [r22 release];
                    }
                    if ([r19 action] == @selector(forceQuitBottle:)) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r24 = [[r0 localizedStringForKey:@"Force Quit Bottle" value:@"" table:0x0] retain];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r25 = r0;
                            r23 = [[r0 localizedStringForKey:@"Force Quit '%@'" value:@"" table:0x0] retain];
                            [r20 setMenuItem:r19 genericTitle:r24 bottleTitleFormat:r23];
                            [r23 release];
                            [r25 release];
                            [r24 release];
                            [r22 release];
                    }
            }
    }
    [r19 release];
    r0 = r21;
    return r0;


// 0x100062aac
// -[MainWindowController revealNewBottle:]
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
    r20 = self;
    r19 = [arg2 retain];
    r0 = [r20 bottleSourceView];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 numberOfRows];
    [r21 release];
    if (r22 != 0x0) {
            r21 = 0x0;
            while (true) {
                    r0 = [r20 bottleSourceView];
                    r0 = [r0 retain];
                    r23 = r0;
                    r22 = [[r0 itemAtRow:r21] retain];
                    [r23 release];
                    r0 = [r22 representedObject];
                    r0 = [r0 retain];
                    r23 = r0;
                    r0 = [r0 bottle];
                    r0 = [r0 retain];
                    r24 = r0;
                    [r0 release];
                    if (r24 == r19) {
                            r24 = [[r20 bottleSourceView] retain];
                            r25 = [[NSIndexSet indexSetWithIndex:r21] retain];
                            [r24 selectRowIndexes:r25 byExtendingSelection:0x0];
                            [r25 release];
                            [r24 release];
                            r0 = [r20 bottleSourceView];
                            r0 = [r0 retain];
                            r20 = r0;
                            [r0 scrollRowToVisible:r21];
                            [r20 release];
                            [r23 release];
                            [r22 release];
                            temp_0 = 0x1;
                            break;
                    }
                    [r23 release];
                    [r22 release];
                    r21 = r21 + 0x1;
                    r0 = [r20 bottleSourceView];
                    r0 = [r0 retain];
                    r22 = r0;
                    r23 = [r0 numberOfRows];
                    [r22 release];
                    if (r21 < r23) {
                            continue;
                    }
                    temp_0 = 0x0;
                    break;
            }
    }
    [r19 release];
    return;


// 0x100062c44
// -[MainWindowController newBottle:]
    r0 = [[NewBottleController alloc] init];
    r20 = r0;
    [r0 setCopyMode:0x0 withBottleToCopy:0x0];
    [r20 setupGUI];
    r21 = [[self window] retain];
    r22 = [[r20 window] retain];
    var_50 = *__NSConcreteStackBlock;
    r19 = [r20 retain];
    [r21 beginSheet:r22 completionHandler:&var_50];
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x100062d6c
// -[MainWindowController duplicateBottle:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 bottle] retain];
    r19 = [[self window] retain];
    [BottleMenuHandler duplicateBottle:r22 withWindow:r19];
    [r19 release];
    [r22 release];
    [r20 release];
    return;


// 0x100062df0
// -[MainWindowController renameBottle:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self bottleSourceView];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [r0 clickedRow];
    [r21 release];
    if (r20 == -0x1) {
            r0 = [r19 bottleSourceView];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [r0 selectedRow];
            [r21 release];
    }
    r21 = [[r19 bottleSourceView] retain];
    r0 = [r19 bottleSourceView];
    r0 = [r0 retain];
    r19 = r0;
    [r21 editColumn:[r0 columnWithIdentifier:@"name"] row:r20 withEvent:0x0 select:0x1];
    [r19 release];
    [r21 release];
    return;


// 0x100062eb8
// -[MainWindowController deleteBottle:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 bottle] retain];
    r19 = [[self window] retain];
    [BottleMenuHandler deleteBottle:r22 withWindow:r19];
    [r19 release];
    [r22 release];
    [r20 release];
    return;


// 0x100062f3c
// -[MainWindowController openBottleCDrive:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 bottle] retain];
    [BottleMenuHandler openCDriveForBottle:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100062f9c
// -[MainWindowController exportBottleToArchive:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 bottle] retain];
    r19 = [[self window] retain];
    [BottleMenuHandler exportBottle:r22 withWindow:r19];
    [r19 release];
    [r22 release];
    [r20 release];
    return;


// 0x100063020
// -[MainWindowController importBottleArchiveFromURL:]
    r31 = r31 - 0x80;
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
    r19 = [arg2 retain];
    r0 = [[NewBottleController alloc] init];
    r21 = r0;
    [r0 setCopyMode:0x0 withBottleToCopy:0x0];
    r23 = [[NSFileManager defaultManager] retain];
    r24 = [[r19 path] retain];
    r22 = [[r23 displayNameAtPath:r24] retain];
    [r24 release];
    [r23 release];
    r25 = [[r19 pathExtension] retain];
    r26 = [[@"." stringByAppendingString:r25] retain];
    r23 = [r22 rangeOfString:r26 options:0xc];
    r24 = r1;
    [r26 release];
    [r25 release];
    if (r23 != 0x7fffffffffffffff) {
            r23 = [[r22 stringByReplacingCharactersInRange:r23 withString:r24] retain];
            [r22 release];
            r22 = r23;
    }
    [r21 setSuggestedBottleName:r22];
    [r21 setArchiveURL:r19];
    [r21 setupGUI];
    r23 = [[r20 window] retain];
    r24 = [[r21 window] retain];
    var_70 = *__NSConcreteStackBlock;
    r20 = [r21 retain];
    [r23 beginSheet:r24 completionHandler:&var_70];
    [r24 release];
    [r23 release];
    [r21 release];
    [r20 release];
    [r22 release];
    [r19 release];
    return;


// 0x100063274
// -[MainWindowController importBottleArchive:]
    r31 = r31 - 0x80;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_38 = **___stack_chk_guard;
    r0 = [NSOpenPanel openPanel];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setCanChooseFiles:0x1];
    [r20 setCanChooseDirectories:0x0];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r23 = [[r0 localizedStringForKey:@"Restore Bottle Archive" value:@"" table:0x0] retain];
    [r20 setMessage:r23];
    [r23 release];
    [r21 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"Restore" value:@"" table:0x0] retain];
    [r20 setPrompt:r22];
    [r22 release];
    [r21 release];
    var_40 = @"cxarchive";
    r0 = [NSArray arrayWithObjects:&var_40 count:0x1];
    r21 = [r0 retain];
    [r20 setAllowedFileTypes:r21];
    [r21 release];
    r21 = [[self window] retain];
    var_70 = *__NSConcreteStackBlock;
    r0 = [r20 retain];
    r19 = r0;
    [r0 beginSheetModalForWindow:r21 completionHandler:&var_70];
    [r21 release];
    [r20 release];
    [r19 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x1000634e8
// -[MainWindowController showInstallViewWithSelectedBottle:package:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [arg3 retain];
    r21 = [arg2 retain];
    r0 = [r19 packageViewController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 back];
    [r22 release];
    if (r20 != 0x0) {
            r0 = [r19 packageViewController];
            r0 = [r0 retain];
            r22 = r0;
            [r0 setSelectedPackage:r20];
            [r22 release];
    }
    r0 = [r19 packageViewController];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setSelectedBottle:r21];
    [r21 release];
    [r22 release];
    [r19 selectInstallView];
    [r20 release];
    return;


// 0x1000635a8
// -[MainWindowController showInstallViewWithSelectedBottle:]
    [self showInstallViewWithSelectedBottle:arg2 package:0x0];
    return;


// 0x1000635b0
// -[MainWindowController publishBottle:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 bottle] retain];
    r19 = [[self window] retain];
    [BottleMenuHandler publishBottle:r22 withWindow:r19];
    [r19 release];
    [r22 release];
    [r20 release];
    return;


// 0x100063634
// -[MainWindowController toggleDefaultBottle:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 bottle] retain];
    [BottleMenuHandler toggleDefaultBottle:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100063694
// -[MainWindowController toggleBottleGraphicsAuto:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setGraphicsBackendAuto];
    [r20 release];
    [r19 release];
    return;


// 0x1000636dc
// -[MainWindowController toggleBottleGraphicsD3DMetal:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setGraphicsBackendD3DMetal];
    [r20 release];
    [r19 release];
    return;


// 0x100063724
// -[MainWindowController toggleBottleGraphicsDXMT:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setGraphicsBackendDXMT];
    [r20 release];
    [r19 release];
    return;


// 0x10006376c
// -[MainWindowController toggleBottleGraphicsDXVK:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setGraphicsBackendDXVK];
    [r20 release];
    [r19 release];
    return;


// 0x1000637b4
// -[MainWindowController toggleBottleGraphicsWine:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setGraphicsBackendWine];
    [r20 release];
    [r19 release];
    return;


// 0x1000637fc
// -[MainWindowController toggleBottleVulkanMoltenVK:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setVulkanBackendMoltenVK];
    [r20 release];
    [r19 release];
    return;


// 0x100063844
// -[MainWindowController toggleBottleVulkanMTLVK:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setVulkanBackendMTLVK];
    [r20 release];
    [r19 release];
    return;


// 0x10006388c
// -[MainWindowController toggleBottleDLSS:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isIsDLSSEnabled];
    [r20 release];
    r0 = [r19 bottle];
    r0 = [r0 retain];
    r20 = r0;
    if (r21 != 0x0) {
            [r0 disableDLSS];
    }
    else {
            [r0 enableDLSS];
    }
    [r20 release];
    [r19 release];
    return;


// 0x10006390c
// -[MainWindowController toggleBottleMSync:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 bottle] retain];
    r19 = [[self window] retain];
    [BottleMenuHandler toggleMSyncForBottle:r22 withWindow:r19];
    [r19 release];
    [r22 release];
    [r20 release];
    return;


// 0x100063990
// -[MainWindowController toggleBottleHighResolution:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 bottle] retain];
    r19 = [[self window] retain];
    [BottleMenuHandler toggleHighResolutionForBottle:r22 withWindow:r19];
    [r19 release];
    [r22 release];
    [r20 release];
    return;


// 0x100063a14
// -[MainWindowController toggleBottlePreview:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 bottle] retain];
    r19 = [[self window] retain];
    [BottleMenuHandler togglePreviewForBottle:r22 withWindow:r19];
    [r19 release];
    [r22 release];
    [r20 release];
    return;


// 0x100063a98
// -[MainWindowController updateBottle:]
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
    r21 = self;
    var_48 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r20 = [[NSMutableArray array] retain];
    [CXSetupLib bottleWrapperClass];
    if ((objc_opt_isKindOfClass() & 0x1) == 0x0) goto loc_100063b18;
    goto loc_100063b08;

loc_100063b18:
    r0 = [r21 bottleTreeController];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 selectedObjects] retain];
    [r21 release];
    var_110 = q0;
    var_100 = q0;
    r0 = [r22 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 == 0x0) goto loc_100063c14;
    goto loc_100063b70;

loc_100063b08:
    [r20 addObject:r19];
    goto loc_100063c24;

loc_100063c14:
    [r21 release];
    [r21 release];
    goto loc_100063c24;

loc_100063b70:
    r22 = r0;
    r24 = *var_100;
    goto loc_100063b7c;

loc_100063c24:
    r0 = [UpdateController alloc];
    r0 = [r0 initWithManagedBottles:r20];
    r21 = r0;
    [r0 showWindow:r19];
    [r21 release];
    [r20 release];
    [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;

loc_100063b7c:
    r25 = 0x0;
    goto loc_100063b80;

loc_100063b80:
    if (*var_100 != r24) {
            objc_enumerationMutation(r21);
    }
    r23 = *(var_108 + r25 * 0x8);
    if ([r23 type] == 0x2) {
            r0 = [r23 bottle];
            r0 = [r0 retain];
            r23 = r0;
            if ([r0 isIsManaged] != 0x0 && ([r23 isIsUpToDate] & 0x1) == 0x0) {
                    [r20 addObject:r23];
            }
            [r23 release];
    }
    r25 = r25 + 0x1;
    if (r22 != r25) {
            continue;
    }
    break;
    r0 = [r21 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    r22 = r0;
    if (r0 != 0x0) {
            continue;
    }
    break;


// 0x100063c94
// -[MainWindowController installSoftwareToBottle:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 bottle] retain];
    r19 = [[self window] retain];
    [BottleMenuHandler installSoftwareIntoBottle:r22 withWindow:r19];
    [r19 release];
    [r22 release];
    [r20 release];
    return;


// 0x100063d18
// -[MainWindowController runCommandInBottle:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 bottleList];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 count];
    [r21 release];
    [r20 release];
    if (r22 != 0x0) {
            r0 = [r19 selectedBottleNode];
            r0 = [r0 retain];
            r19 = r0;
            r21 = [[r0 bottle] retain];
            [BottleMenuHandler runCommandInBottle:r21];
            [r21 release];
            [r19 release];
    }
    return;


// 0x100063dd8
// -[MainWindowController openShellForBottle:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 bottle] retain];
    [BottleMenuHandler openShellForBottle:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100063e38
// -[MainWindowController quitBottle:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 bottle] retain];
    [BottleMenuHandler quitBottle:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100063e98
// -[MainWindowController forceQuitBottle:]
    r0 = [self selectedBottleNode];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 bottle] retain];
    [BottleMenuHandler forceQuitBottle:r21];
    [r21 release];
    [r19 release];
    return;


// 0x100063ef8
// -[MainWindowController bottleViewController]
    r0 = self->_bottleViewController;
    return r0;


// 0x100063f08
// -[MainWindowController setBottleViewController:]
    objc_storeStrong((int64_t *)&self->_bottleViewController, arg2);
    return;


// 0x100063f1c
// -[MainWindowController iconViewController]
    r0 = self->_iconViewController;
    return r0;


// 0x100063f2c
// -[MainWindowController setIconViewController:]
    objc_storeStrong((int64_t *)&self->_iconViewController, arg2);
    return;


// 0x100063f40
// -[MainWindowController packageViewController]
    r0 = self->_packageViewController;
    return r0;


// 0x100063f50
// -[MainWindowController setPackageViewController:]
    objc_storeStrong((int64_t *)&self->_packageViewController, arg2);
    return;


// 0x100063f64
// -[MainWindowController mainContentView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_mainContentView);
    r0 = [r0 autorelease];
    return r0;


// 0x100063f84
// -[MainWindowController setMainContentView:]
    objc_storeWeak((int64_t *)&self->_mainContentView, arg2);
    return;


// 0x100063f98
// -[MainWindowController splitView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_splitView);
    r0 = [r0 autorelease];
    return r0;


// 0x100063fb8
// -[MainWindowController setSplitView:]
    objc_storeWeak((int64_t *)&self->_splitView, arg2);
    return;


// 0x100063fcc
// -[MainWindowController topMenuNodes]
    r0 = self->_topMenuNodes;
    return r0;


// 0x100063fdc
// -[MainWindowController setTopMenuNodes:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100063fe8
// -[MainWindowController bottomMenuNodes]
    r0 = self->_bottomMenuNodes;
    return r0;


// 0x100063ff8
// -[MainWindowController setBottomMenuNodes:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100064004
// -[MainWindowController topMenuSourceView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_topMenuSourceView);
    r0 = [r0 autorelease];
    return r0;


// 0x100064024
// -[MainWindowController setTopMenuSourceView:]
    objc_storeWeak((int64_t *)&self->_topMenuSourceView, arg2);
    return;


// 0x100064038
// -[MainWindowController bottomMenuSourceView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottomMenuSourceView);
    r0 = [r0 autorelease];
    return r0;


// 0x100064058
// -[MainWindowController setBottomMenuSourceView:]
    objc_storeWeak((int64_t *)&self->_bottomMenuSourceView, arg2);
    return;


// 0x10006406c
// -[MainWindowController topMenuTreeController]
    r0 = objc_loadWeakRetained((int64_t *)&self->_topMenuTreeController);
    r0 = [r0 autorelease];
    return r0;


// 0x10006408c
// -[MainWindowController setTopMenuTreeController:]
    objc_storeWeak((int64_t *)&self->_topMenuTreeController, arg2);
    return;


// 0x1000640a0
// -[MainWindowController bottomMenuTreeController]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottomMenuTreeController);
    r0 = [r0 autorelease];
    return r0;


// 0x1000640c0
// -[MainWindowController setBottomMenuTreeController:]
    objc_storeWeak((int64_t *)&self->_bottomMenuTreeController, arg2);
    return;


// 0x1000640d4
// -[MainWindowController bottleSourceView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleSourceView);
    r0 = [r0 autorelease];
    return r0;


// 0x1000640f4
// -[MainWindowController setBottleSourceView:]
    objc_storeWeak((int64_t *)&self->_bottleSourceView, arg2);
    return;


// 0x100064108
// -[MainWindowController bottleTreeController]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleTreeController);
    r0 = [r0 autorelease];
    return r0;


// 0x100064128
// -[MainWindowController setBottleTreeController:]
    objc_storeWeak((int64_t *)&self->_bottleTreeController, arg2);
    return;


// 0x10006413c
// -[MainWindowController privateBottleGroup]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_privateBottleGroup)), 0x1);
    return r0;


// 0x10006414c
// -[MainWindowController setPrivateBottleGroup:]
    objc_setProperty_atomic();
    return;


// 0x100064158
// -[MainWindowController publishedBottleGroup]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_publishedBottleGroup)), 0x1);
    return r0;


// 0x100064168
// -[MainWindowController setPublishedBottleGroup:]
    objc_setProperty_atomic();
    return;


// 0x100064174
// -[MainWindowController updating]
    r0 = *(int8_t *)(int64_t *)&self->_updating & 0x1;
    return r0;


// 0x100064188
// -[MainWindowController setUpdating:]
    *(int8_t *)(int64_t *)&self->_updating = arg2;
    return;


// 0x100064198
// -[MainWindowController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_publishedBottleGroup, 0x0);
    objc_storeStrong((int64_t *)&self->_privateBottleGroup, 0x0);
    objc_destroyWeak((int64_t *)&self->_bottleTreeController);
    objc_destroyWeak((int64_t *)&self->_bottleSourceView);
    objc_destroyWeak((int64_t *)&self->_bottomMenuTreeController);
    objc_destroyWeak((int64_t *)&self->_topMenuTreeController);
    objc_destroyWeak((int64_t *)&self->_bottomMenuSourceView);
    objc_destroyWeak((int64_t *)&self->_topMenuSourceView);
    objc_storeStrong((int64_t *)&self->_bottomMenuNodes, 0x0);
    objc_storeStrong((int64_t *)&self->_topMenuNodes, 0x0);
    objc_destroyWeak((int64_t *)&self->_splitView);
    objc_destroyWeak((int64_t *)&self->_mainContentView);
    objc_storeStrong((int64_t *)&self->_packageViewController, 0x0);
    objc_storeStrong((int64_t *)&self->_iconViewController, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleViewController, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleNodes, 0x0);
    return;


// === Block Invocations for MainWindowController ===

// 0x10005fd30
// ___34-[MainWindowController updateC4Ps]_block_invoke
    [[CXSetupLib webUtilsClass] updateCompatDB];
    r20 = [CXSetupLib c4ProfilesClass];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 objectForKey:@"TieURL"] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r20 updateOnlineProfilesFromURL:r22]);
    [r22 release];
    [r21 release];
    var_48 = *__NSConcreteStackBlock;
    r0 = *__dispatch_main_q;
    r0 = dispatch_async(r0, &var_48);
    return r0;


// 0x10005fe10
// ___34-[MainWindowController updateC4Ps]_block_invoke_2
    r0 = arg0[0x4];
    r0 = [r0 packageViewController];
    r0 = [r0 retain];
    r20 = r0;
    [r0 populatePackages];
    [r20 release];
    [arg0[0x4] setUpdating:0x0];
    r0 = dispatch_time(0x0, 0x4e94914f0000);
    var_38 = *__NSConcreteStackBlock;
    r0 = dispatch_after(r0, *__dispatch_main_q, &var_38);
    return r0;


// 0x10005feb4
// ___34-[MainWindowController updateC4Ps]_block_invoke_3
    r0 = arg0[0x4];
    r0 = [r0 updateC4Ps];
    return r0;


// 0x100061024
// ___71-[MainWindowController observeValueForKeyPath:ofObject:change:context:]_block_invoke
    r19 = arg0[0x4];
    r20 = [[arg1 bottle] retain];
    r19 = [r19 containsObject:r20];
    [r20 release];
    r0 = r19;
    return r0;


// 0x100061070
// ___71-[MainWindowController observeValueForKeyPath:ofObject:change:context:]_block_invoke.55
    r19 = arg0[0x4];
    r20 = [[arg1 bottle] retain];
    r19 = [r19 containsObject:r20];
    [r20 release];
    r0 = r19;
    return r0;


// 0x100062d28
// ___34-[MainWindowController newBottle:]_block_invoke
    r0 = arg0;
    if (r1 != 0x0) {
            r19 = r0[0x4];
            r20 = [[r0[0x5] bottle] retain];
            [r19 revealNewBottle:r20];
            [r20 release];
    }
    return;


// 0x100063230
// ___51-[MainWindowController importBottleArchiveFromURL:]_block_invoke
    r0 = arg0;
    if (r1 != 0x0) {
            r19 = r0[0x4];
            r20 = [[r0[0x5] bottle] retain];
            [r19 revealNewBottle:r20];
            [r20 release];
    }
    return;


// 0x100063460
// ___44-[MainWindowController importBottleArchive:]_block_invoke
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg0;
    r0 = arg0[0x4];
    r0 = [r0 close];
    if (arg1 == 0x1) {
            r0 = r19[0x4];
            r0 = [r0 URLs];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 objectAtIndex:0x0] retain];
            [r20 release];
            [r19[0x5] importBottleArchiveFromURL:r21];
            r0 = [r21 release];
    }
    return r0;


