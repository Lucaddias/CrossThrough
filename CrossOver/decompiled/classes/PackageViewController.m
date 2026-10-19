// PackageViewController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003a7c8
// -[PackageViewController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithNibName:@"PackageView" bundle:0x0];
    return r0;


// 0x10003a808
// -[PackageViewController dealloc]
    r0 = [self collectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self forKeyPath:@"selectionIndexPaths"];
    [r20 release];
    r0 = [self installer];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self forKeyPath:@"summaryDetails"];
    [r20 release];
    r0 = [self installerView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:0x0];
    [r20 release];
    r0 = [self packageView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:0x0];
    [r20 release];
    r20 = [[self packageDescriptionTextField] retain];
    [self stopObservingFrameOfView:r20];
    [r20 release];
    r20 = [[self installationNotesTextField] retain];
    [self stopObservingFrameOfView:r20];
    [r20 release];
    r0 = [NSUserDefaultsController sharedUserDefaultsController];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self forKeyPath:@"values.ShowUntestedApps" context:0x0];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x10003a968
// -[PackageViewController viewDidLoad]
    r31 = r31 - 0xa0;
    var_50 = d11;
    decomp_var_48 = d10;
    var_40 = d9;
    decomp_var_38 = d8;
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
    var_90 = self;
    [[&var_90 super] viewDidLoad];
    r0 = [r19 view];
    r0 = [r0 retain];
    r20 = r0;
    [r0 bounds];
    r0 = [r19 packageView];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setFrame:r2];
    [r21 release];
    [r20 release];
    r0 = [r19 packageView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setAutoresizingMask:0x12];
    [r20 release];
    r20 = [[r19 packageView] retain];
    r22 = **_NSPasteboardTypeFileURL;
    var_60 = r22;
    r0 = [NSArray arrayWithObjects:&var_60 count:0x1];
    r21 = [r0 retain];
    [r20 registerForDraggedTypes:r21];
    [r21 release];
    [r20 release];
    r0 = [r19 packageView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:r19];
    [r20 release];
    r0 = [r19 view];
    r0 = [r0 retain];
    r20 = r0;
    [r0 bounds];
    r0 = [r19 installerView];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setFrame:r2];
    [r21 release];
    [r20 release];
    r0 = [r19 installerView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setAutoresizingMask:0x12];
    [r20 release];
    r0 = [r19 installerView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setHidden:0x1];
    [r20 release];
    r20 = [[r19 installerView] retain];
    var_68 = r22;
    r0 = [NSArray arrayWithObjects:&var_68 count:0x1];
    r21 = [r0 retain];
    [r20 registerForDraggedTypes:r21];
    [r21 release];
    [r20 release];
    r0 = [r19 installerView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:r19];
    [r20 release];
    r0 = [r19 packageView];
    r0 = [r0 retain];
    r20 = r0;
    var_78 = r0;
    r21 = [[r19 installerView] retain];
    r0 = [NSArray arrayWithObjects:&var_78 count:0x2];
    r22 = [r0 retain];
    r0 = [r19 view];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setSubviews:r22];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r20 = [[r19 collectionView] retain];
    [r20 registerClass:objc_opt_class(@class(PackageViewItem)) forItemWithIdentifier:@"PackageViewItem"];
    [r20 release];
    r0 = [r19 collectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 addObserver:r19 forKeyPath:@"selectionIndexPaths" options:0x0 context:0x0];
    [r20 release];
    r0 = [r19 collectionView];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 collectionViewLayout] retain];
    [r21 release];
    [r20 setMinimumInteritemSpacing:r2];
    [r20 setMinimumLineSpacing:r2];
    [r20 setMargins:r2];
    r21 = [[NSColor controlAccentColor] retain];
    r0 = [r19 installButton];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setBezelColor:r21];
    [r22 release];
    [r21 release];
    r0 = [r19 optionsButton];
    r0 = [r0 retain];
    r21 = r0;
    [r0 sendActionOn:0x2];
    [r21 release];
    r21 = [[NSColor linkColor] retain];
    r0 = [r19 installUnlistedAppButton];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setContentTintColor:r21];
    [r22 release];
    [r21 release];
    r21 = [[r19 packageDescriptionTextField] retain];
    [r19 startObservingFrameOfView:r21];
    [r21 release];
    r21 = [[r19 installationNotesTextField] retain];
    [r19 startObservingFrameOfView:r21];
    [r21 release];
    r0 = [NSSortDescriptor sortDescriptorWithKey:@"softwarePackage" ascending:0x1 selector:@selector(localizedStandardCompare:)];
    r0 = [r0 retain];
    r21 = r0;
    var_80 = r0;
    r0 = [NSArray arrayWithObjects:&var_80 count:0x1];
    r22 = [r0 retain];
    [r19 setSortDescriptors:r22];
    [r22 release];
    [r21 release];
    r0 = [NSUserDefaultsController sharedUserDefaultsController];
    r0 = [r0 retain];
    r21 = r0;
    [r0 addObserver:r19 forKeyPath:@"values.ShowUntestedApps" options:0x0 context:0x0];
    r0 = [r19 packages];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    if (r22 == 0x0) {
            [r19 populatePackages];
    }
    [r19 back];
    [r21 release];
    [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x10003af40
// -[PackageViewController viewDidAppear]
    var_20 = self;
    [[&var_20 super] viewDidAppear];
    r20 = [[self window] retain];
    r19 = [[self searchField] retain];
    [r20 makeFirstResponder:r19];
    [r19 release];
    [r20 release];
    return;


// 0x10003afc4
// -[PackageViewController viewDidDisappear]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_30 = self;
    [[&var_30 super] viewDidDisappear];
    r0 = [r19 installerView];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isHidden];
    [r20 release];
    if (r21 != 0x0) {
            [r19 back];
    }
    return;


// 0x10003b03c
// -[PackageViewController packageForCategory:root:cache:]
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
    r24 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r0 = [arg4 retain];
    r21 = r0;
    r0 = [r0 objectForKey:r19];
    r0 = [r0 retain];
    r22 = r0;
    if (r0 == 0x0) {
            r23 = [[r19 lastObject] retain];
            r22 = [[PackageTreeNode alloc] initWithCategoryID:r23 name:r23 children:0x0 sortKey:r23];
            if ([r19 count] == 0x1) {
                    r24 = [r20 retain];
            }
            else {
                    [r19 count] - 0x1;
                    r25 = [[r19 subarrayWithRange:0x0] retain];
                    r24 = [[r24 packageForCategory:r25 root:r20 cache:r21] retain];
                    [r25 release];
            }
            r0 = [r24 unfilteredChildren];
            r0 = [r0 retain];
            r25 = r0;
            [r24 insertObject:r22 inUnfilteredChildrenAtIndex:[r0 count]];
            [r25 release];
            [r21 setObject:r22 forKey:r19];
            [r24 release];
            [r23 release];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = [r22 autorelease];
    return r0;


// 0x10003b1c4
// -[PackageViewController populatePackages]
    r0 = dispatch_get_global_queue(0x0, 0x0);
    r0 = [r0 retain];
    r20 = r0;
    r21 = *__NSConcreteStackBlock;
    var_58 = r21;
    dispatch_async(r0, &var_58);
    [r20 release];
    var_80 = r21;
    dispatch_async(r20, &var_80);
    [r20 release];
    return;


// 0x10003b9f0
// -[PackageViewController loadIcons]
    r20 = [[self visiblePackages] retain];
    r19 = [[NSArray arrayWithArray:r20] retain];
    [r20 release];
    r20 = [dispatch_get_global_queue(0x0, 0x0) retain];
    var_38 = *__NSConcreteStackBlock;
    var_18 = r19;
    r19 = [r19 retain];
    dispatch_async(r20, &var_38);
    [r20 release];
    [var_18 release];
    [r19 release];
    return;


// 0x10003bbac
// -[PackageViewController setInstaller:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg2;
    r20 = self;
    r19 = [arg2 retain];
    r0 = [r20 installer];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    if (r22 != r19) {
            r0 = [r20 installer];
            r0 = [r0 retain];
            r22 = r0;
            [r0 release];
            if (r22 != 0x0) {
                    r0 = [r20 installer];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 removeObserver:r20 forKeyPath:@"summaryDetails"];
                    [r22 release];
            }
            objc_storeStrong((int64_t *)&r20->_installer, r21);
            if (r19 != 0x0) {
                    r0 = [r20 installer];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 addObserver:r20 forKeyPath:@"summaryDetails" options:0x0 context:0x0];
                    [r21 release];
                    r0 = [r20 installer];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 setDelegate:r20];
                    [r21 release];
                    [r20 updateSummaryDetails];
                    [r20 expandPackageDescription:0x0];
                    [r20 expandInstallationNotes:0x0];
            }
    }
    [r19 release];
    return;


// 0x10003bcdc
// -[PackageViewController setSelectedBottle:]
    r2 = arg2;
    r0 = self;
    if (r2 != 0x0) {
            r31 = r31 - 0x50;
            var_40 = r24;
            decomp_var_38 = r23;
            var_30 = r22;
            decomp_var_28 = r21;
            var_20 = r20;
            decomp_var_18 = r19;
            var_10 = r29;
            decomp_var_8 = r30;
            r19 = r0;
            r20 = [r2 retain];
            r0 = [r19 installer];
            r0 = [r0 retain];
            r21 = r0;
            [r0 release];
            if (r21 == 0x0) {
                    r21 = [[PackageInstaller alloc] initWithPackage:0x0];
                    [r19 setInstaller:r21];
                    [r21 release];
            }
            r0 = [r19 installer];
            r0 = [r0 retain];
            r21 = r0;
            [r0 setSelectedBottle:r20];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 localizedStringForKey:@"Install a Windows Application into %@" value:@"" table:0x0] retain];
            r24 = [[r20 name] retain];
            [r20 release];
            r20 = [[NSString stringWithFormat:r23] retain];
            [r19 setPackageViewTitle:r20];
            [r20 release];
            [r24 release];
            [r23 release];
            [r22 release];
    }
    return;


// 0x10003be34
// -[PackageViewController setSelectedPackage:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [arg2 retain];
    r0 = [r19 installer];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    if (r21 != 0x0) {
            r0 = [r19 installer];
            r0 = [r0 retain];
            r21 = r0;
            [r0 setSelectedPackage:r20];
            [r20 release];
    }
    else {
            r21 = [[PackageInstaller alloc] initWithPackage:r20];
            [r20 release];
            [r19 setInstaller:r21];
    }
    [r21 release];
    [r19 openInstallerView];
    return;


// 0x10003bee0
// -[PackageViewController updateVisiblePackages]
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
    r19 = self;
    var_48 = **___stack_chk_guard;
    r24 = 0x1000c8000;
    if (*_updateVisiblePackages.rankedPredicate == 0x0) {
            r24 = 0x1000c8000;
            r0 = [NSPredicate predicateWithFormat:@"ranked != FALSE"];
            r0 = [r0 retain];
            r8 = *_updateVisiblePackages.rankedPredicate;
            *_updateVisiblePackages.rankedPredicate = r0;
            [r8 release];
    }
    r25 = 0x1000c8000;
    if (*_updateVisiblePackages.highlightedPredicate == 0x0) {
            r25 = 0x1000c8000;
            r0 = [NSPredicate predicateWithFormat:@"highlighted != FALSE"];
            r0 = [r0 retain];
            r8 = *_updateVisiblePackages.highlightedPredicate;
            *_updateVisiblePackages.highlightedPredicate = r0;
            [r8 release];
    }
    r20 = [[r19 packages] retain];
    [r19 setIsHighlighted:0x0];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r21 = r0;
    r23 = [r0 boolForKey:@"ShowUntestedApps"];
    [r21 release];
    r0 = [r19 filterPredicate];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    if ((r23 & 0x1) != 0x0) {
            if (r22 != 0x0) {
                    r21 = [[r19 filterPredicate] retain];
                    if (r21 != 0x0) {
                            r22 = [[r20 filteredArrayUsingPredicate:r21] retain];
                            [r20 release];
                            r20 = r22;
                    }
            }
            else {
                    r25 = 0x1000c8000;
                    r21 = [*_updateVisiblePackages.highlightedPredicate retain];
                    [r19 setIsHighlighted:0x1];
                    if (r21 != 0x0) {
                            r22 = [[r20 filteredArrayUsingPredicate:r21] retain];
                            [r20 release];
                            r20 = r22;
                    }
            }
    }
    else {
            r24 = 0x1000c8000;
            if (r22 != 0x0) {
                    var_58 = *_updateVisiblePackages.rankedPredicate;
                    r22 = [[r19 filterPredicate] retain];
                    r0 = [NSArray arrayWithObjects:&var_58 count:0x2];
                    r23 = [r0 retain];
                    r21 = [[NSCompoundPredicate andPredicateWithSubpredicates:r23] retain];
                    [r23 release];
                    [r22 release];
                    if (r21 != 0x0) {
                            r22 = [[r20 filteredArrayUsingPredicate:r21] retain];
                            [r20 release];
                            r20 = r22;
                    }
            }
            else {
                    r25 = 0x1000c8000;
                    var_68 = *_updateVisiblePackages.rankedPredicate;
                    r0 = [NSArray arrayWithObjects:&var_68 count:0x2];
                    r22 = [r0 retain];
                    r21 = [[NSCompoundPredicate andPredicateWithSubpredicates:r22] retain];
                    [r22 release];
                    [r19 setIsHighlighted:0x1];
                    if (r21 != 0x0) {
                            r22 = [[r20 filteredArrayUsingPredicate:r21] retain];
                            [r20 release];
                            r20 = r22;
                    }
            }
    }
    r0 = [r19 sortDescriptors];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    if (r22 != 0x0) {
            r22 = [[r19 sortDescriptors] retain];
            r23 = [[r20 sortedArrayUsingDescriptors:r22] retain];
            [r20 release];
            [r22 release];
            r20 = r23;
    }
    r0 = [r20 count];
    r22 = [[r20 subarrayWithRange:0x0] retain];
    [r19 setVisiblePackages:r22];
    [r22 release];
    r0 = [r19 packages];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 count];
    r23 = r0;
    if (r0 != 0x0) {
            r0 = [r19 visiblePackages];
            r0 = [r0 retain];
            r24 = r0;
            if ([r0 count] != 0x0) {
                    r25 = 0x1;
            }
    }
    else {
            r25 = 0x1;
    }
    r0 = [r19 noResultsLabel];
    r0 = [r0 retain];
    r26 = r0;
    [r0 setHidden:r25];
    [r26 release];
    if (r23 != 0x0) {
            [r24 release];
    }
    [r22 release];
    [r19 loadIcons];
    [r21 release];
    [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x10003c280
// -[PackageViewController setSortDescriptors:]
    objc_storeStrong((int64_t *)&self->_sortDescriptors, arg2);
    [self updateVisiblePackages];
    return;


// 0x10003c2b4
// -[PackageViewController setFilterPredicate:]
    objc_storeStrong((int64_t *)&self->_filterPredicate, arg2);
    [self updateVisiblePackages];
    return;


// 0x10003c2e8
// -[PackageViewController updateSummaryDetails]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x270;
    r19 = self;
    var_60 = **___stack_chk_guard;
    r0 = [self installButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:0x1];
    [r20 release];
    r0 = [r19 installer];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 steamID];
    r0 = [r0 retain];
    var_2B8 = r0;
    [r0 release];
    [r21 release];
    [r20 release];
    r0 = [r19 installer];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 downloadURL];
    r0 = [r0 retain];
    var_2C0 = r0;
    [r0 release];
    [r21 release];
    [r20 release];
    r0 = [r19 installer];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 summaryDetails];
    r0 = [r0 retain];
    r21 = r0;
    r24 = [r0 copy];
    [r21 release];
    [r20 release];
    var_2A8 = [[NSMutableArray alloc] init];
    var_220 = q0;
    var_210 = q0;
    r0 = [r24 retain];
    var_2B0 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_220 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r22 = *var_210;
            if ((var_2B8 | var_2C0) == 0x0) {
                    r23 = 0x1;
            }
            do {
                    r21 = 0x0;
                    do {
                            if (*var_210 != r22) {
                                    objc_enumerationMutation(var_2B0);
                            }
                            r26 = *(var_218 + r21 * 0x8);
                            r25 = [[InstallSummaryDetailViewController alloc] init];
                            r28 = [[r26 label] retain];
                            r27 = [[NSAttributedString cx_attributedStringWithHTML:r28] retain];
                            [r25 setText:r27];
                            [r27 release];
                            [r28 release];
                            r27 = [[r26 image] retain];
                            [r25 setImage:r27];
                            [r27 release];
                            [r25 setAction:[r26 action]];
                            r2 = r19;
                            [r25 setDelegate:r2];
                            if ([r26 action] != @selector(editInstallerSource:)) {
                                    r8 = 0x1;
                            }
                            else {
                                    r8 = r23;
                            }
                            if ((r8 & 0x1) == 0x0) {
                                    r2 = 0x1;
                                    [r25 setSendsActionOnMouseDown:0x1];
                            }
                            r0 = [r19 installer];
                            r0 = [r0 retain];
                            r27 = r0;
                            if ([r0 status] == 0x0) {
                                    r2 = 0x1;
                            }
                            [r25 setButtonEnabled:r2];
                            [r27 release];
                            [var_2A8 addObject:r25];
                            if ([r26 type] == 0x0) {
                                    r0 = [r19 installButton];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    [r0 setEnabled:0x0];
                                    [r26 release];
                            }
                            [r25 release];
                            r21 = r21 + 0x1;
                    } while (r24 != r21);
                    r0 = [var_2B0 countByEnumeratingWithState:&var_220 objects:&decomp_var_e0 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [var_2B0 release];
    r0 = [r19 summaryDetailsControllers];
    r0 = [r0 retain];
    r24 = r0;
    [r0 release];
    if (r24 != 0x0) {
            var_260 = q0;
            var_250 = q0;
            r0 = [r19 summaryDetailsControllers];
            r0 = [r0 retain];
            r24 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_260 objects:&decomp_var_160 count:0x10];
            if (r0 != 0x0) {
                    r25 = r0;
                    r20 = *var_250;
                    do {
                            r21 = 0x0;
                            do {
                                    if (*var_250 != r20) {
                                            objc_enumerationMutation(r24);
                                    }
                                    r0 = *(var_258 + r21 * 0x8);
                                    r0 = [r0 view];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    [r0 removeFromSuperview];
                                    [r26 release];
                                    r21 = r21 + 0x1;
                            } while (r25 != r21);
                            r0 = [r24 countByEnumeratingWithState:&var_260 objects:&decomp_var_160 count:0x10];
                            r25 = r0;
                    } while (r0 != 0x0);
            }
            [r24 release];
    }
    [r19 setSummaryDetailsControllers:var_2A8];
    var_2A0 = q0;
    var_290 = q0;
    r0 = [r19 summaryDetailsControllers];
    r0 = [r0 retain];
    r24 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_2A0 objects:&decomp_var_1e0 count:0x10];
    if (r0 != 0x0) {
            r25 = r0;
            r20 = *var_290;
            do {
                    r21 = 0x0;
                    do {
                            if (*var_290 != r20) {
                                    objc_enumerationMutation(r24);
                            }
                            r26 = *(var_298 + r21 * 0x8);
                            r27 = [[r19 summaryDetailsView] retain];
                            r26 = [[r26 view] retain];
                            [r27 addArrangedSubview:r26];
                            [r26 release];
                            [r27 release];
                            r21 = r21 + 0x1;
                    } while (r25 != r21);
                    r0 = [r24 countByEnumeratingWithState:&var_2A0 objects:&decomp_var_1e0 count:0x10];
                    r25 = r0;
            } while (r0 != 0x0);
    }
    if (var_2C0 == 0x0) {
            r23 = 0x1;
    }
    if (var_2B8 == 0x0) {
            r22 = 0x1;
    }
    [r24 release];
    r0 = [r19 installWithSteamMenuItem];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setHidden:r22];
    [r24 release];
    r0 = [r19 installer];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 installConfiguration];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [r0 installWithSteam];
    r0 = [r19 installWithSteamMenuItem];
    r0 = [r0 retain];
    r26 = r0;
    [r0 setState:r25];
    [r26 release];
    [r24 release];
    [r22 release];
    r0 = [r19 downloadInstallerMenuItem];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setHidden:r23];
    [r22 release];
    r0 = [r19 installer];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 installConfiguration];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 installerDownloadSource];
    r0 = [r0 retain];
    r24 = r0;
    if (r0 != 0x0) {
            r25 = 0x1;
    }
    r0 = [r19 downloadInstallerMenuItem];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setState:r25];
    [r19 release];
    [r24 release];
    [r23 release];
    [r22 release];
    [var_2A8 release];
    [var_2B0 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10003c92c
// -[PackageViewController openInstallerView]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self installer];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 status];
    [r20 release];
    if (r21 == 0x1) {
            [r19 installationStarted];
    }
    r0 = [r19 installer];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 status];
    [r20 release];
    if (r21 == 0x2) {
            [r19 installationCompleted];
    }
    r0 = [r19 installer];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:r19];
    [r20 release];
    r0 = [r19 packageView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setHidden:0x1];
    [r20 release];
    r0 = [r19 installerView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setHidden:0x0];
    [r20 release];
    r0 = [r19 installButton];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setHidden:0x0];
    [r19 release];
    return;


// 0x10003ca40
// -[PackageViewController optionsButtonClicked:]
    r20 = [arg2 retain];
    r19 = [[self optionsMenu] retain];
    [r20 bounds];
    [r19 popUpMenuPositioningItem:0x0 atLocation:r20 inView:r4];
    [r20 release];
    [r19 release];
    return;


// 0x10003caac
// -[PackageViewController autoPlay:]
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
    r21 = _cmd;
    r20 = self;
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r20 file:@"PackageViewController.m" lineNumber:0x1d9 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [r20 installer];
    r0 = [r0 retain];
    r21 = r0;
    if (r0 == 0x0) {
            r21 = [[PackageInstaller alloc] initWithPackage:0x0];
    }
    r0 = [CXSetupLib c4ProfilesClass];
    r0 = [r0 getMatchingProfiles:r19];
    r0 = [r0 retain];
    r22 = r0;
    if ([r0 count] == 0x1) {
            var_128 = r19;
            var_120 = q0;
            var_110 = q0;
            r0 = [r22 retain];
            r23 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
            if (r0 != 0x0) {
                    r24 = r0;
                    r27 = *var_110;
                    do {
                            r19 = 0x0;
                            do {
                                    if (*var_110 != r27) {
                                            objc_enumerationMutation(r23);
                                    }
                                    r25 = [[r23 objectForKeyedSubscript:*(var_118 + r19 * 0x8)] retain];
                                    r26 = [[PackageTreeNode alloc] initWithProfile:r25];
                                    [r21 setSelectedPackage:r26];
                                    [r26 release];
                                    [r25 release];
                                    r19 = r19 + 0x1;
                            } while (r24 != r19);
                            r0 = [r23 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                            r24 = r0;
                    } while (r0 != 0x0);
            }
            [r23 release];
            r19 = var_128;
    }
    [r21 setInstallerSource:r19];
    r23 = [[r20 unknownPackage] retain];
    [r21 setUnknownPackage:r23];
    [r23 release];
    [r20 setInstaller:r21];
    [r20 openInstallerView];
    [r22 release];
    [r21 release];
    [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10003cd18
// -[PackageViewController autoPlayWithParsedFile:]
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
            [r0 handleFailureInMethod:r21 object:r20 file:@"PackageViewController.m" lineNumber:0x1f3 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [r20 installer];
    r0 = [r0 retain];
    r21 = r0;
    if (r0 == 0x0) {
            r21 = [[PackageInstaller alloc] initWithPackage:0x0];
    }
    [r21 autoPlayWithParsedAutorunFile:r19];
    r22 = [[r20 unknownPackage] retain];
    [r21 setUnknownPackage:r22];
    [r22 release];
    [r20 setInstaller:r21];
    [r20 openInstallerView];
    [r21 release];
    [r19 release];
    return;


// 0x10003ce24
// -[PackageViewController autoPlayWithAutorunFile:]
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
    r21 = _cmd;
    r20 = self;
    r19 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r20 file:@"PackageViewController.m" lineNumber:0x202 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [CXSetupLib c4ProfilesClass];
    r0 = [r0 tasteC4PFile:r19];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 boolValue];
    [r21 release];
    if (r22 != 0x0) {
            r0 = [r20 window];
            r0 = [r0 retain];
            r21 = r0;
            [r0 makeKeyAndOrderFront:r20];
            [r21 release];
            [r20 displayLoadingSheetAndPrepareCrossTie:r19];
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 localizedStringForKey:@"The CrossTie file '%@' is not from a trusted source!\n\nThis means that CodeWeavers has no knowledge or control over what actions profiles from this file may attempt. Be VERY cautious loading untrusted CrossTies as they can cause great damage to your compute…" value:@"" table:0x0] retain];
            [r22 release];
            r22 = [[NSAlert alloc] init];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r24 = r0;
            r25 = [[r0 localizedStringForKey:@"Load untrusted CrossTie file?" value:@"" table:0x0] retain];
            [r22 setMessageText:r25];
            [r25 release];
            [r24 release];
            r0 = [NSFileManager defaultManager];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [[r0 displayNameAtPath:r19] retain];
            r24 = [[NSString stringWithFormat:r21] retain];
            [r22 setInformativeText:r24];
            [r24 release];
            [r26 release];
            [r25 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r24 = r0;
            r25 = [[r0 localizedStringForKey:@"Don't Load" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r22 addButtonWithTitle:r25]);
            [r25 release];
            [r24 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r24 = r0;
            r23 = [[r0 localizedStringForKey:@"Load" value:@"" table:0x0] retain];
            objc_unsafeClaimAutoreleasedReturnValue([r22 addButtonWithTitle:r23]);
            [r23 release];
            [r24 release];
            r0 = [r20 window];
            r0 = [r0 retain];
            r23 = r0;
            [r0 makeKeyAndOrderFront:r20];
            [r23 release];
            r23 = [[r20 window] retain];
            var_80 = *__NSConcreteStackBlock;
            var_58 = [r19 retain];
            [r22 beginSheetModalForWindow:r23 completionHandler:&var_80];
            [r23 release];
            [var_58 release];
            [r22 release];
            [r21 release];
    }
    [r19 release];
    return;


// 0x10003d1c4
// -[PackageViewController prepareDropinC4pAndAutorun:]
    r31 = r31 - 0xe0;
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
    r20 = self;
    r19 = [arg2 retain];
    if ([NSThread isMainThread] != 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r20 file:@"PackageViewController.m" lineNumber:0x226 description:@"Background-only method or function called on main thread"];
            [r22 release];
    }
    r0 = [CXSetupLib c4ProfilesClass];
    r0 = [r0 prepareSingleUseC4PFile:r19];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 count] == 0x2) {
            r0 = [r21 objectAtIndex:0x0];
            r0 = [r0 retain];
            r22 = r0;
            [r0 release];
            if (r22 != 0x0) {
                    r22 = [CXSetupLib c4ProfilesClass];
                    r23 = [[r21 objectAtIndex:0x0] retain];
                    r24 = [[r21 objectAtIndex:0x1] retain];
                    r22 = [[r22 dropinC4PFile:r23 withSig:r24] retain];
                    [r24 release];
                    [r23 release];
                    r0 = [r21 objectAtIndex:0x0];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r24 = [[r21 objectAtIndex:0x0] retain];
                            objc_opt_class(@class(NSNull));
                            r25 = objc_opt_isKindOfClass();
                            [r24 release];
                            [r0 release];
                            if ((r25 & 0x1) == 0x0) {
                                    r23 = [[NSFileManager defaultManager] retain];
                                    r24 = [[r21 objectAtIndex:0x0] retain];
                                    [r23 removeItemAtPath:r24 error:0x0];
                                    [r24 release];
                                    [r23 release];
                            }
                    }
                    r0 = [r21 objectAtIndex:0x1];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r24 = [[r21 objectAtIndex:0x1] retain];
                            objc_opt_class(@class(NSNull));
                            r25 = objc_opt_isKindOfClass();
                            [r24 release];
                            [r0 release];
                            if ((r25 & 0x1) == 0x0) {
                                    r23 = [[NSFileManager defaultManager] retain];
                                    r24 = [[r21 objectAtIndex:0x1] retain];
                                    [r23 removeItemAtPath:r24 error:0x0];
                                    [r24 release];
                                    [r23 release];
                            }
                    }
                    r0 = [r22 valueForKey:@"malware_appid"];
                    r0 = [r0 retain];
                    r23 = r0;
                    if (r0 != 0x0) {
                            var_70 = *__NSConcreteStackBlock;
                            r8 = ___52-[PackageViewController prepareDropinC4pAndAutorun:]_block_invoke;
                            r24 = &var_70;
                            r0 = r22;
                    }
                    else {
                            r0 = [r22 valueForKey:@"useful_for_current_product"];
                            r0 = [r0 retain];
                            r24 = r0;
                            r25 = [r0 boolValue];
                            [r24 release];
                            if ((r25 & 0x1) != 0x0) {
                                    [r20 populatePackages];
                                    var_D0 = *__NSConcreteStackBlock;
                                    r8 = ___52-[PackageViewController prepareDropinC4pAndAutorun:]_block_invoke_2;
                                    r24 = &var_D0;
                                    r0 = r22;
                            }
                            else {
                                    var_A0 = *__NSConcreteStackBlock;
                                    r8 = ___52-[PackageViewController prepareDropinC4pAndAutorun:]_block_invoke.114;
                                    r24 = &var_A0;
                                    r0 = r19;
                            }
                    }
                    r24[0x1] = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbf0);
                    r24[0x2] = r8;
                    r24[0x3] = ___block_descriptor_48_e8_32s40s_e5_v8?0l;
                    r24[0x4] = r20;
                    r24[0x5] = [r0 retain];
                    dispatch_async(*__dispatch_main_q, r24);
                    [r24[0x5] release];
                    [r23 release];
                    [r22 release];
            }
    }
    [r21 release];
    [r19 release];
    return;


// 0x10003d5ac
// -[PackageViewController displayLoadingSheetAndPrepareCrossTie:]
    r19 = [arg2 retain];
    r21 = [[LoadingCrossTieSheetController alloc] init];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 displayNameAtPath:r19] retain];
    [r21 setCrossTieDisplayName:r23];
    [r23 release];
    [r22 release];
    r22 = [[self window] retain];
    r23 = [[r21 window] retain];
    [r22 beginSheet:r23 completionHandler:___block_literal_global];
    [r23 release];
    [r22 release];
    r22 = [dispatch_get_global_queue(0x0, 0x0) retain];
    var_68 = *__NSConcreteStackBlock;
    var_40 = r19;
    r20 = [r21 retain];
    r19 = [r19 retain];
    dispatch_async(r22, &var_68);
    [r22 release];
    [r21 release];
    [var_40 release];
    [r20 release];
    [r19 release];
    return;


// 0x10003d810
// -[PackageViewController displayEmptyFileAlert:]
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
    r21 = _cmd;
    r19 = self;
    r20 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r19 file:@"PackageViewController.m" lineNumber:0x261 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 localizedStringForKey:@"The CrossTie file '%@' does not contain installation profiles for anything that can be installed with this product." value:@"" table:0x0] retain];
    [r22 release];
    r22 = [[NSAlert alloc] init];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r23 = [[r0 localizedStringForKey:@"Invalid File" value:@"" table:0x0] retain];
    [r22 setMessageText:r23];
    [r23 release];
    [r24 release];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 displayNameAtPath:r20] retain];
    [r20 release];
    r20 = [[NSString stringWithFormat:r21] retain];
    [r22 setInformativeText:r20];
    [r20 release];
    [r25 release];
    [r24 release];
    r19 = [[r19 window] retain];
    [r22 beginSheetModalForWindow:r19 completionHandler:0x0];
    [r19 release];
    [r22 release];
    [r21 release];
    return;


// 0x10003da10
// -[PackageViewController displayRevokedFileAlert:]
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
    r21 = _cmd;
    r20 = self;
    r19 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r20 file:@"PackageViewController.m" lineNumber:0x26f description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 localizedStringForKey:@"This file cannot be used because it would install malicious software or otherwise harm your computer." value:@"" table:0x0] retain];
    [r22 release];
    r22 = [[NSAlert alloc] init];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"Malware Detected" value:@"" table:0x0] retain];
    [r22 setMessageText:r25];
    [r25 release];
    [r24 release];
    [r22 setInformativeText:r21];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r25 = [[r0 localizedStringForKey:@"OK" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r22 addButtonWithTitle:r25]);
    [r25 release];
    [r24 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r24 = r0;
    r23 = [[r0 localizedStringForKey:@"More Info" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r22 addButtonWithTitle:r23]);
    [r23 release];
    [r24 release];
    r20 = [[r20 window] retain];
    var_68 = *__NSConcreteStackBlock;
    var_48 = r19;
    r19 = [r19 retain];
    [r22 beginSheetModalForWindow:r20 completionHandler:&var_68];
    [r20 release];
    [var_48 release];
    [r19 release];
    [r22 release];
    [r21 release];
    return;


// 0x10003dd94
// -[PackageViewController numberOfSectionsInCollectionView:]
    return 0x1;


// 0x10003dd9c
// -[PackageViewController collectionView:numberOfItemsInSection:]
    r0 = [self visiblePackages];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 count];
    [r19 release];
    r0 = r20;
    return r0;


// 0x10003ddd8
// -[PackageViewController collectionView:itemForRepresentedObjectAtIndexPath:]
    r21 = [arg3 retain];
    r19 = [[arg2 makeItemWithIdentifier:@"PackageViewItem" forIndexPath:r21] retain];
    r20 = [[self visiblePackages] retain];
    r22 = [r21 item];
    [r21 release];
    r21 = [[r20 objectAtIndexedSubscript:r22] retain];
    [r19 setRepresentedObject:r21];
    [r21 release];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x10003de8c
// -[PackageViewController collectionView:willDisplayItem:forRepresentedObjectAtIndexPath:]
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
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    r0 = [r19 numberOfItemsInSection:0x0];
    r22 = r0 - 0x1;
    if (r22 == 0x0) {
            r22 = 0x1;
    }
    else {
            if ([r21 item] < r0 - 0xa) {
                    r22 = 0x0;
            }
            else {
                    r23 = [[NSIndexPath indexPathForItem:r22 inSection:0x0] retain];
                    r24 = [[r19 layoutAttributesForItemAtIndexPath:r23] retain];
                    r0 = [r19 layoutAttributesForItemAtIndexPath:r21];
                    r0 = [r0 retain];
                    r25 = r0;
                    CGRectGetMaxY([r0 frame]);
                    CGRectGetMaxY([r24 frame]);
                    if (d8 == d0) {
                            r22 = 0x1;
                    }
                    [r25 release];
                    [r24 release];
                    [r23 release];
            }
    }
    r0 = [r20 dividerLine];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setHidden:r22];
    [r23 release];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x10003dfec
// -[PackageViewController observeValueForKeyPath:ofObject:change:context:]
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
    r24 = arg5;
    r23 = _cmd;
    r22 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    if ([r19 isEqualToString:@"selectionIndexPaths"] != 0x0) {
            r0 = [r22 collectionView];
            r0 = [r0 retain];
            r24 = r0;
            r0 = [r0 selectionIndexPaths];
            r0 = [r0 retain];
            r25 = r0;
            r26 = [r0 count];
            [r25 release];
            [r24 release];
            if (r26 != 0x1) {
                    r24 = [[NSAssertionHandler currentHandler] retain];
                    r0 = [r22 collectionView];
                    r0 = [r0 retain];
                    r25 = r0;
                    r0 = [r0 selectionIndexPaths];
                    r0 = [r0 retain];
                    r26 = r0;
                    [r0 count];
                    [r24 handleFailureInMethod:r23 object:r22 file:@"PackageViewController.m" lineNumber:0x2b6 description:@"%d packages selected"];
                    [r26 release];
                    [r25 release];
                    [r24 release];
            }
            r0 = [r22 collectionView];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 selectionIndexPaths];
            r0 = [r0 retain];
            r24 = r0;
            r25 = [[r0 anyObject] retain];
            [r24 release];
            [r23 release];
            r23 = [[r22 visiblePackages] retain];
            r24 = [[r23 objectAtIndexedSubscript:[r25 item]] retain];
            [r23 release];
            [r22 setSelectedPackage:r24];
            [r24 release];
            r0 = r25;
            [r0 release];
    }
    else {
            if ([r19 isEqualToString:@"summaryDetails"] != 0x0) {
                    [r22 updateSummaryDetails];
            }
            else {
                    if ([r19 isEqualToString:@"values.ShowUntestedApps"] != 0x0) {
                            [r22 updateVisiblePackages];
                            r0 = [r22 collectionView];
                            r0 = [r0 retain];
                            r22 = r0;
                            [r0 reloadData];
                            r0 = r22;
                            [r0 release];
                    }
                    else {
                            var_50 = r22;
                            [[&var_50 super] observeValueForKeyPath:r19 ofObject:r20 change:r21 context:r24];
                    }
            }
    }
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x10003e278
// -[PackageViewController back:]
    r0 = [self packageView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setHidden:0x0];
    [r20 release];
    r0 = [self installerView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setHidden:0x1];
    [r20 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 localizedStringForKey:@"Install a Windows Application" value:@"" table:0x0] retain];
    [self setPackageViewTitle:r21];
    [r21 release];
    [r20 release];
    r0 = [self collectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 deselectAll:0x0];
    [r20 release];
    r20 = [[self window] retain];
    r21 = [[self searchField] retain];
    [r20 makeFirstResponder:r21];
    [r21 release];
    [r20 release];
    [self setInstaller:0x0];
    return;


// 0x10003e3a8
// -[PackageViewController back]
    [self back:0x0];
    return;


// 0x10003e3b0
// -[PackageViewController search:]
    r31 = r31 - 0x150;
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
    r21 = [[arg2 stringValue] retain];
    r22 = [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
    r24 = [[r21 stringByTrimmingCharactersInSet:r22] retain];
    [r21 release];
    [r22 release];
    if ([r24 length] != 0x0) {
            var_138 = r23;
            if (*_search:.searchPredicateTemplate == 0x0) {
                    r0 = [NSPredicate predicateWithFormat:@"softwarePackage LIKE[cd] $SEARCH"];
                    r0 = [r0 retain];
                    r8 = *_search:.searchPredicateTemplate;
                    *_search:.searchPredicateTemplate = r0;
                    [r8 release];
            }
            r21 = [[NSMutableString stringWithString:@"*"] retain];
            var_130 = q0;
            var_120 = q0;
            r23 = [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
            var_140 = r24;
            r22 = [[r24 componentsSeparatedByCharactersInSet:r23] retain];
            [r23 release];
            r0 = [r22 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
            if (r0 != 0x0) {
                    r23 = r0;
                    r19 = *var_120;
                    do {
                            r25 = 0x0;
                            do {
                                    if (*var_120 != r19) {
                                            objc_enumerationMutation(r22);
                                    }
                                    r28 = *(var_128 + r25 * 0x8);
                                    if ([r28 length] != 0x0) {
                                            r0 = [r28 stringByReplacingOccurrencesOfString:@"*" withString:@"\*"];
                                            r0 = [r0 retain];
                                            r28 = r0;
                                            r20 = [[r0 stringByReplacingOccurrencesOfString:@"?" withString:@"\?"] retain];
                                            [r28 release];
                                            [r21 appendString:r20];
                                            [r21 appendString:@"*"];
                                            [r20 release];
                                    }
                                    r25 = r25 + 0x1;
                            } while (r23 != r25);
                            r0 = [r22 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                            r23 = r0;
                    } while (r0 != 0x0);
            }
            [r22 release];
            r20 = *_search:.searchPredicateTemplate;
            var_F0 = @"SEARCH";
            decomp_var_e8 = r21;
            r0 = [NSDictionary dictionaryWithObjects:&decomp_var_e8 forKeys:&var_F0 count:0x1];
            r22 = [r0 retain];
            r20 = [[r20 predicateWithSubstitutionVariables:r22] retain];
            r23 = var_138;
            r2 = r20;
            [r23 setFilterPredicate:r2];
            [r20 release];
            [r22 release];
            [r21 release];
            r24 = var_140;
    }
    else {
            r2 = 0x0;
            [r23 setFilterPredicate:0x0];
    }
    r0 = [r23 collectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 reloadData];
    [r20 release];
    r0 = [r23 collectionView];
    r0 = [r0 retain];
    r19 = r0;
    [r0 scrollPoint:r2];
    [r19 release];
    [r24 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10003e6fc
// -[PackageViewController install:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self installer];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 status];
    [r20 release];
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    if (r21 == 0x1) {
            [r0 cancel];
    }
    else {
            [r0 install];
    }
    [r19 release];
    return;


// 0x10003e76c
// -[PackageViewController selectUnknownPackage:]
    r20 = [[self unknownPackage] retain];
    [self setSelectedPackage:r20];
    [r20 release];
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setNewBottleName:@""];
    [r20 release];
    [r19 release];
    return;


// 0x10003e7e8
// -[PackageViewController editInstallerSource:]
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
    r0 = [r20 installer];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 installConfiguration];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 steamID];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            [r0 release];
            [r22 release];
            [r21 release];
            r20 = [[r20 installerSourceMenu] retain];
            [r19 bounds];
            [r20 popUpMenuPositioningItem:0x0 atLocation:r19 inView:r4];
            [r20 release];
            [r19 release];
    }
    else {
            r0 = [r20 installer];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 installConfiguration];
            r0 = [r0 retain];
            r24 = r0;
            r0 = [r0 downloadURL];
            r0 = [r0 retain];
            r25 = r0;
            [r0 release];
            [r24 release];
            [r23 release];
            [r22 release];
            [r21 release];
            if (r25 != 0x0) {
                    r20 = [[r20 installerSourceMenu] retain];
                    [r19 bounds];
                    [r20 popUpMenuPositioningItem:0x0 atLocation:r19 inView:r4];
                    [r20 release];
                    [r19 release];
            }
            else {
                    [r20 selectInstaller:r19];
                    [r19 release];
            }
    }
    return;


// 0x10003e924
// -[PackageViewController selectSteamInstall:]
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setInstallerSteam];
    [r20 release];
    [r19 release];
    return;


// 0x10003e96c
// -[PackageViewController selectInstallerDownload:]
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setInstallerDownload];
    [r20 release];
    [r19 release];
    return;


// 0x10003e9b4
// -[PackageViewController selectInstaller:]
    r20 = [arg2 retain];
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    [r0 selectInstaller:r20];
    [r20 release];
    [r19 release];
    return;


// 0x10003ea04
// -[PackageViewController selectBottle:]
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    [r0 selectBottleWithCompletion:0x0];
    [r19 release];
    return;


// 0x10003ea38
// -[PackageViewController c4pButton:]
    r20 = [[NSWorkspace sharedWorkspace] retain];
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 package];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 c4pPage] retain];
    r21 = [[NSURL URLWithString:r23] retain];
    [r20 openURL:r21];
    [r21 release];
    [r23 release];
    [r22 release];
    [r19 release];
    [r20 release];
    return;


// 0x10003eb00
// -[PackageViewController downloadButton:]
    r20 = [[NSWorkspace sharedWorkspace] retain];
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 package];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 homePage] retain];
    r21 = [[NSURL URLWithString:r23] retain];
    [r20 openURL:r21];
    [r21 release];
    [r23 release];
    [r22 release];
    [r19 release];
    [r20 release];
    return;


// 0x10003ebc8
// -[PackageViewController installOptions:]
    r0 = [self installer];
    r0 = [r0 retain];
    r19 = r0;
    [r0 installOptions];
    [r19 release];
    return;


// 0x10003ebf8
// -[PackageViewController installationCompleted]
    r31 = r31 - 0x110;
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
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 localizedStringForKey:@"Install" value:@"" table:0x0] retain];
    r0 = [r19 installButton];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setTitle:r21];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 optionsButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:0x1];
    [r20 release];
    r0 = [r19 installer];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 status];
    [r20 release];
    if (r21 == 0x2) {
            r20 = [[r19 delegate] retain];
            r0 = [r19 installer];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 bottle] retain];
            [r20 revealNewBottle:r22];
            [r22 release];
            [r21 release];
            [r20 release];
            if (**___stack_chk_guard != var_38) {
                    __stack_chk_fail();
            }
            [r19 back];
    }
    else {
            var_100 = q0;
            var_F0 = q0;
            r0 = [r19 summaryDetailsControllers];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
            if (r0 != 0x0) {
                    r21 = r0;
                    r22 = *var_F0;
                    do {
                            r23 = 0x0;
                            do {
                                    if (*var_F0 != r22) {
                                            objc_enumerationMutation(r20);
                                    }
                                    [*(var_F8 + r23 * 0x8) setButtonEnabled:0x1];
                                    r23 = r23 + 0x1;
                            } while (r21 != r23);
                            r0 = [r20 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                            r21 = r0;
                    } while (r0 != 0x0);
            }
            [r20 release];
            r0 = [r19 delegate];
            r0 = [r0 retain];
            r19 = r0;
            [r0 selectInstallView];
            [r19 release];
            if (**___stack_chk_guard != var_38) {
                    __stack_chk_fail();
            }
    }
    return;


// 0x10003ee64
// -[PackageViewController installationStarted]
    r31 = r31 - 0x110;
    var_30 = r28;
    decomp_var_28 = r27;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_38 = **___stack_chk_guard;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 localizedStringForKey:@"Cancel" value:@"" table:0x0] retain];
    r0 = [self installButton];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setTitle:r21];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [self optionsButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:0x0];
    [r20 release];
    var_100 = q0;
    var_F0 = q0;
    r0 = [self summaryDetailsControllers];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
    if (r0 != 0x0) {
            r20 = r0;
            r21 = *var_F0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_F0 != r21) {
                                    objc_enumerationMutation(r19);
                            }
                            [*(var_F8 + r22 * 0x8) setButtonEnabled:0x0];
                            r22 = r22 + 0x1;
                    } while (r20 != r22);
                    r0 = [r19 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                    r20 = r0;
            } while (r0 != 0x0);
    }
    [r19 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x10003eff4
// -[PackageViewController window]
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 window] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10003f038
// -[PackageViewController performDragOperation:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r21 = [[arg2 draggingPasteboard] retain];
    r19 = [[NSURL URLFromPasteboard:r21] retain];
    [r21 release];
    r0 = [r20 packageView];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 isHidden];
    [r21 release];
    if (r22 != 0x0) {
            r20 = [[r20 installer] retain];
            r21 = [[r19 path] retain];
            [r20 setInstallerSource:r21];
    }
    else {
            r20 = [[**_NSApp CXServer] retain];
            r21 = [[r19 path] retain];
            [r20 runClient:r21 inBottle:0x0];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    return 0x1;


// 0x10003f154
// -[PackageViewController textFieldIsTruncated:]
    r0 = [arg2 retain];
    r19 = r0;
    r20 = [[r0 cell] retain];
    [r19 frame];
    [r20 expansionFrameWithFrame:r19 inView:r3];
    [r19 release];
    r0 = [r20 release];
    r0 = NSEqualRects(r0, r1);
    r0 = r0 ^ 0x1;
    return r0;


// 0x10003f1f4
// -[PackageViewController startObservingFrameOfView:]
    r21 = [arg2 retain];
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 addObserver:self selector:@selector(subviewFrameChanged:) name:**_NSViewFrameDidChangeNotification object:r21];
    [r20 release];
    [r21 setPostsFrameChangedNotifications:0x1];
    [r21 release];
    return;


// 0x10003f278
// -[PackageViewController stopObservingFrameOfView:]
    r21 = [arg2 retain];
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self name:**_NSViewFrameDidChangeNotification object:r21];
    [r21 release];
    [r20 release];
    return;


// 0x10003f2e8
// -[PackageViewController subviewFrameChanged:]
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
    r21 = [[r0 object] retain];
    r0 = [r20 packageDescriptionTextField];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    [r21 release];
    if (r21 != r22) {
            r21 = [[r19 object] retain];
            r0 = [r20 installationNotesTextField];
            r0 = [r0 retain];
            r22 = r0;
            [r0 release];
            [r21 release];
            if (r21 == r22) {
                    [r20 updateInstallationNotesTruncation];
            }
    }
    else {
            [r20 updatePackageDescriptionTruncation];
    }
    [r19 release];
    return;


// 0x10003f3a4
// -[PackageViewController updatePackageDescriptionTruncation]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self packageDescriptionCollapsedHeightConstraint];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 isActive] != 0x0) {
            r22 = [[r19 packageDescriptionTextField] retain];
            r20 = [r19 textFieldIsTruncated:r22] ^ 0x1;
            [r22 release];
    }
    else {
            r20 = 0x1;
    }
    [r21 release];
    r0 = [r19 packageDescriptionTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setSelectable:r20];
    [r21 release];
    r0 = [r19 packageDescriptionMoreLabel];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setHidden:r20];
    [r21 release];
    r0 = [r19 packageDescriptionExpandButton];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setHidden:r20];
    [r19 release];
    return;


// 0x10003f484
// -[PackageViewController updateInstallationNotesTruncation]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self installationNotesCollapsedHeightConstraint];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 isActive] != 0x0) {
            r22 = [[r19 installationNotesTextField] retain];
            r20 = [r19 textFieldIsTruncated:r22] ^ 0x1;
            [r22 release];
    }
    else {
            r20 = 0x1;
    }
    [r21 release];
    r0 = [r19 installationNotesTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setSelectable:r20];
    [r21 release];
    r0 = [r19 installationNotesMoreLabel];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setHidden:r20];
    [r21 release];
    r0 = [r19 installationNotesExpandButton];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setHidden:r20];
    [r19 release];
    return;


// 0x10003f564
// -[PackageViewController expandPackageDescription:]
    r0 = [self packageDescriptionCollapsedHeightConstraint];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setActive:arg2 ^ 0x1];
    [r21 release];
    [self updatePackageDescriptionTruncation];
    return;


// 0x10003f5b0
// -[PackageViewController expandInstallationNotes:]
    r0 = [self installationNotesCollapsedHeightConstraint];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setActive:arg2 ^ 0x1];
    [r21 release];
    [self updateInstallationNotesTruncation];
    return;


// 0x10003f5fc
// -[PackageViewController packageDescriptionExpandButtonClicked:]
    [self expandPackageDescription:0x1];
    return;


// 0x10003f604
// -[PackageViewController installationNotesExpandButtonClicked:]
    [self expandInstallationNotes:0x1];
    return;


// 0x10003f60c
// -[PackageViewController delegate]
    r0 = objc_loadWeakRetained((int64_t *)&self->_delegate);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f62c
// -[PackageViewController setDelegate:]
    objc_storeWeak((int64_t *)&self->_delegate, arg2);
    return;


// 0x10003f640
// -[PackageViewController packages]
    r0 = self->_packages;
    return r0;


// 0x10003f650
// -[PackageViewController setPackages:]
    objc_storeStrong((int64_t *)&self->_packages, arg2);
    return;


// 0x10003f664
// -[PackageViewController unknownPackage]
    r0 = self->_unknownPackage;
    return r0;


// 0x10003f674
// -[PackageViewController setUnknownPackage:]
    objc_storeStrong((int64_t *)&self->_unknownPackage, arg2);
    return;


// 0x10003f688
// -[PackageViewController sortDescriptors]
    r0 = self->_sortDescriptors;
    return r0;


// 0x10003f698
// -[PackageViewController filterPredicate]
    r0 = self->_filterPredicate;
    return r0;


// 0x10003f6a8
// -[PackageViewController isHighlighted]
    r0 = *(int8_t *)(int64_t *)&self->_isHighlighted;
    return r0;


// 0x10003f6b8
// -[PackageViewController setIsHighlighted:]
    *(int8_t *)(int64_t *)&self->_isHighlighted = arg2;
    return;


// 0x10003f6c8
// -[PackageViewController visiblePackages]
    r0 = self->_visiblePackages;
    return r0;


// 0x10003f6d8
// -[PackageViewController setVisiblePackages:]
    objc_storeStrong((int64_t *)&self->_visiblePackages, arg2);
    return;


// 0x10003f6ec
// -[PackageViewController summaryDetailsControllers]
    r0 = self->_summaryDetailsControllers;
    return r0;


// 0x10003f6fc
// -[PackageViewController setSummaryDetailsControllers:]
    objc_storeStrong((int64_t *)&self->_summaryDetailsControllers, arg2);
    return;


// 0x10003f710
// -[PackageViewController installer]
    r0 = self->_installer;
    return r0;


// 0x10003f720
// -[PackageViewController packageView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_packageView);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f740
// -[PackageViewController setPackageView:]
    objc_storeWeak((int64_t *)&self->_packageView, arg2);
    return;


// 0x10003f754
// -[PackageViewController collectionView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_collectionView);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f774
// -[PackageViewController setCollectionView:]
    objc_storeWeak((int64_t *)&self->_collectionView, arg2);
    return;


// 0x10003f788
// -[PackageViewController loading]
    r0 = objc_loadWeakRetained((int64_t *)&self->_loading);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f7a8
// -[PackageViewController setLoading:]
    objc_storeWeak((int64_t *)&self->_loading, arg2);
    return;


// 0x10003f7bc
// -[PackageViewController noResultsLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_noResultsLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f7dc
// -[PackageViewController setNoResultsLabel:]
    objc_storeWeak((int64_t *)&self->_noResultsLabel, arg2);
    return;


// 0x10003f7f0
// -[PackageViewController searchField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_searchField);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f810
// -[PackageViewController setSearchField:]
    objc_storeWeak((int64_t *)&self->_searchField, arg2);
    return;


// 0x10003f824
// -[PackageViewController installUnlistedAppButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installUnlistedAppButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f844
// -[PackageViewController setInstallUnlistedAppButton:]
    objc_storeWeak((int64_t *)&self->_installUnlistedAppButton, arg2);
    return;


// 0x10003f858
// -[PackageViewController packageViewTitle]
    r0 = self->_packageViewTitle;
    return r0;


// 0x10003f868
// -[PackageViewController setPackageViewTitle:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10003f874
// -[PackageViewController installerView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installerView);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f894
// -[PackageViewController setInstallerView:]
    objc_storeWeak((int64_t *)&self->_installerView, arg2);
    return;


// 0x10003f8a8
// -[PackageViewController installButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f8c8
// -[PackageViewController setInstallButton:]
    objc_storeWeak((int64_t *)&self->_installButton, arg2);
    return;


// 0x10003f8dc
// -[PackageViewController optionsButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_optionsButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f8fc
// -[PackageViewController setOptionsButton:]
    objc_storeWeak((int64_t *)&self->_optionsButton, arg2);
    return;


// 0x10003f910
// -[PackageViewController optionsMenu]
    r0 = self->_optionsMenu;
    return r0;


// 0x10003f920
// -[PackageViewController setOptionsMenu:]
    objc_storeStrong((int64_t *)&self->_optionsMenu, arg2);
    return;


// 0x10003f934
// -[PackageViewController installerSourceMenu]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installerSourceMenu);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f954
// -[PackageViewController setInstallerSourceMenu:]
    objc_storeWeak((int64_t *)&self->_installerSourceMenu, arg2);
    return;


// 0x10003f968
// -[PackageViewController installWithSteamMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installWithSteamMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f988
// -[PackageViewController setInstallWithSteamMenuItem:]
    objc_storeWeak((int64_t *)&self->_installWithSteamMenuItem, arg2);
    return;


// 0x10003f99c
// -[PackageViewController downloadInstallerMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_downloadInstallerMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f9bc
// -[PackageViewController setDownloadInstallerMenuItem:]
    objc_storeWeak((int64_t *)&self->_downloadInstallerMenuItem, arg2);
    return;


// 0x10003f9d0
// -[PackageViewController summaryDetailsView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_summaryDetailsView);
    r0 = [r0 autorelease];
    return r0;


// 0x10003f9f0
// -[PackageViewController setSummaryDetailsView:]
    objc_storeWeak((int64_t *)&self->_summaryDetailsView, arg2);
    return;


// 0x10003fa04
// -[PackageViewController packageDescriptionTextField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_packageDescriptionTextField);
    r0 = [r0 autorelease];
    return r0;


// 0x10003fa24
// -[PackageViewController setPackageDescriptionTextField:]
    objc_storeWeak((int64_t *)&self->_packageDescriptionTextField, arg2);
    return;


// 0x10003fa38
// -[PackageViewController packageDescriptionExpandButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_packageDescriptionExpandButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10003fa58
// -[PackageViewController setPackageDescriptionExpandButton:]
    objc_storeWeak((int64_t *)&self->_packageDescriptionExpandButton, arg2);
    return;


// 0x10003fa6c
// -[PackageViewController packageDescriptionMoreLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_packageDescriptionMoreLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x10003fa8c
// -[PackageViewController setPackageDescriptionMoreLabel:]
    objc_storeWeak((int64_t *)&self->_packageDescriptionMoreLabel, arg2);
    return;


// 0x10003faa0
// -[PackageViewController installationNotesTextField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installationNotesTextField);
    r0 = [r0 autorelease];
    return r0;


// 0x10003fac0
// -[PackageViewController setInstallationNotesTextField:]
    objc_storeWeak((int64_t *)&self->_installationNotesTextField, arg2);
    return;


// 0x10003fad4
// -[PackageViewController installationNotesMoreLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installationNotesMoreLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x10003faf4
// -[PackageViewController setInstallationNotesMoreLabel:]
    objc_storeWeak((int64_t *)&self->_installationNotesMoreLabel, arg2);
    return;


// 0x10003fb08
// -[PackageViewController installationNotesExpandButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_installationNotesExpandButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10003fb28
// -[PackageViewController setInstallationNotesExpandButton:]
    objc_storeWeak((int64_t *)&self->_installationNotesExpandButton, arg2);
    return;


// 0x10003fb3c
// -[PackageViewController packageDescriptionCollapsedHeightConstraint]
    r0 = self->_packageDescriptionCollapsedHeightConstraint;
    return r0;


// 0x10003fb4c
// -[PackageViewController setPackageDescriptionCollapsedHeightConstraint:]
    objc_storeStrong((int64_t *)&self->_packageDescriptionCollapsedHeightConstraint, arg2);
    return;


// 0x10003fb60
// -[PackageViewController installationNotesCollapsedHeightConstraint]
    r0 = self->_installationNotesCollapsedHeightConstraint;
    return r0;


// 0x10003fb70
// -[PackageViewController setInstallationNotesCollapsedHeightConstraint:]
    objc_storeStrong((int64_t *)&self->_installationNotesCollapsedHeightConstraint, arg2);
    return;


// 0x10003fb84
// -[PackageViewController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_installationNotesCollapsedHeightConstraint, 0x0);
    objc_storeStrong((int64_t *)&self->_packageDescriptionCollapsedHeightConstraint, 0x0);
    objc_destroyWeak((int64_t *)&self->_installationNotesExpandButton);
    objc_destroyWeak((int64_t *)&self->_installationNotesMoreLabel);
    objc_destroyWeak((int64_t *)&self->_installationNotesTextField);
    objc_destroyWeak((int64_t *)&self->_packageDescriptionMoreLabel);
    objc_destroyWeak((int64_t *)&self->_packageDescriptionExpandButton);
    objc_destroyWeak((int64_t *)&self->_packageDescriptionTextField);
    objc_destroyWeak((int64_t *)&self->_summaryDetailsView);
    objc_destroyWeak((int64_t *)&self->_downloadInstallerMenuItem);
    objc_destroyWeak((int64_t *)&self->_installWithSteamMenuItem);
    objc_destroyWeak((int64_t *)&self->_installerSourceMenu);
    objc_storeStrong((int64_t *)&self->_optionsMenu, 0x0);
    objc_destroyWeak((int64_t *)&self->_optionsButton);
    objc_destroyWeak((int64_t *)&self->_installButton);
    objc_destroyWeak((int64_t *)&self->_installerView);
    objc_storeStrong((int64_t *)&self->_packageViewTitle, 0x0);
    objc_destroyWeak((int64_t *)&self->_installUnlistedAppButton);
    objc_destroyWeak((int64_t *)&self->_searchField);
    objc_destroyWeak((int64_t *)&self->_noResultsLabel);
    objc_destroyWeak((int64_t *)&self->_loading);
    objc_destroyWeak((int64_t *)&self->_collectionView);
    objc_destroyWeak((int64_t *)&self->_packageView);
    objc_storeStrong((int64_t *)&self->_installer, 0x0);
    objc_storeStrong((int64_t *)&self->_summaryDetailsControllers, 0x0);
    objc_storeStrong((int64_t *)&self->_visiblePackages, 0x0);
    objc_storeStrong((int64_t *)&self->_filterPredicate, 0x0);
    objc_storeStrong((int64_t *)&self->_sortDescriptors, 0x0);
    objc_storeStrong((int64_t *)&self->_unknownPackage, 0x0);
    objc_storeStrong((int64_t *)&self->_packages, 0x0);
    objc_destroyWeak((int64_t *)&self->_delegate);
    return;


