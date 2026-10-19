// IconCollectionViewController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100045774
// -[IconCollectionViewController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithNibName:@"IconCollectionView" bundle:0x0];
    return r0;


// 0x1000457b4
// -[IconCollectionViewController viewDidLoad]
    var_30 = self;
    [[&var_30 super] viewDidLoad];
    r20 = [[self collectionView] retain];
    [r20 registerClass:objc_opt_class(@class(IconViewItem)) forItemWithIdentifier:@"IconViewItem"];
    [r20 release];
    r0 = [self collectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDraggingSourceOperationMask:0xffffffffffffffff forLocal:0x1];
    [r20 release];
    r0 = [self collectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDraggingSourceOperationMask:0x6 forLocal:0x0];
    [r20 release];
    r20 = [[self contextualMenu] retain];
    r0 = [self collectionView];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setMenu:r20];
    [r21 release];
    [r20 release];
    r0 = [self collectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:self];
    [r20 release];
    r0 = [self collectionView];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 collectionViewLayout] retain];
    [r19 release];
    [r20 setMinimumLineSpacing:r2];
    [r20 setMinimumInteritemSpacing:r2];
    [r20 release];
    return;


// 0x100045938
// -[IconCollectionViewController margins]
    r0 = [self collectionView];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 collectionViewLayout];
    r0 = [r0 retain];
    r20 = r0;
    [r0 margins];
    [r20 release];
    r0 = [r19 release];
    return r0;


// 0x1000459b4
// -[IconCollectionViewController setMargins:]
    {r2:r3:r4:r5} = arg2;
    r0 = [self collectionView];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 collectionViewLayout];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setMargins:r2];
    [r20 release];
    [r19 release];
    return;


// 0x100045a2c
// -[IconCollectionViewController selectedItem]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self collectionView];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 selectionIndexPaths] retain];
    [r21 release];
    if ([r19 count] == 0x1) {
            r21 = [[r19 anyObject] retain];
            r0 = [r20 collectionView];
            r0 = [r0 retain];
            r22 = r0;
            r20 = [[r0 itemAtIndexPath:r21] retain];
            [r22 release];
            [r21 release];
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100045ae8
// -[IconCollectionViewController allowsMultipleSelection]
    r0 = [self collectionView];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 allowsMultipleSelection];
    [r19 release];
    r0 = r20;
    return r0;


// 0x100045b24
// -[IconCollectionViewController setAllowsMultipleSelection:]
    r0 = [self collectionView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setAllowsMultipleSelection:arg2];
    [r20 release];
    return;


// 0x100045b5c
// -[IconCollectionViewController selectedLauncher]
    r0 = [self selectedItem];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 representedObject] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100045ba0
// -[IconCollectionViewController selectedLaunchers]
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
    r19 = self;
    var_58 = **___stack_chk_guard;
    r0 = [self collectionView];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 selectionIndexPaths] retain];
    [r20 release];
    r20 = [[NSMutableArray arrayWithCapacity:[r21 count]] retain];
    var_120 = q0;
    var_110 = q0;
    r0 = [r21 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r25 = *var_110;
            do {
                    r26 = 0x0;
                    do {
                            if (*var_110 != r25) {
                                    objc_enumerationMutation(r21);
                            }
                            r23 = *(var_118 + r26 * 0x8);
                            r0 = [r19 collectionView];
                            r0 = [r0 retain];
                            r24 = r0;
                            r23 = [[r0 itemAtIndexPath:r23] retain];
                            [r24 release];
                            r24 = [[r23 representedObject] retain];
                            [r20 addObject:r24];
                            [r24 release];
                            [r23 release];
                            r26 = r26 + 0x1;
                    } while (r22 != r26);
                    r0 = [r21 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    r0 = [r21 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    r0 = [r20 autorelease];
    return r0;


// 0x100045d58
// -[IconCollectionViewController setLaunchers:]
    r2 = arg2;
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_launchers));
    if (*(r0 + r20) != r2) {
            r19 = r0;
            r0 = [r2 copy];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
            r0 = [r19 collectionView];
            r0 = [r0 retain];
            r19 = r0;
            [r0 reloadData];
            [r19 release];
    }
    return;


// 0x100045dc8
// -[IconCollectionViewController openLauncherTreeNode:fromRect:view:]
    {r3:r4:r5:r6} = arg3;
    r31 = r31 - 0x160;
    var_70 = d13;
    decomp_var_68 = d12;
    var_60 = d11;
    decomp_var_58 = d10;
    var_50 = d9;
    decomp_var_48 = d8;
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
    r20 = r3;
    d8 = d3;
    d9 = d2;
    d10 = d1;
    d11 = d0;
    r21 = self;
    r19 = [arg2 retain];
    r20 = [r20 retain];
    if ([r19 isOpenable] != 0x0) {
            var_98 = *__NSConcreteStackBlock;
            d12 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbf0);
            [r19 openWithErrorHandler:&var_98];
            if ([r19 animateOpen] != 0x0) {
                    r23 = *__NSConcreteStackBlock;
                    var_C8 = 0x0;
                    var_128 = r23;
                    var_100 = [r20 retain];
                    var_F8 = [r19 retain];
                    var_150 = r23;
                    [NSAnimationContext runAnimationGroup:&var_128 completionHandler:&var_150];
                    [var_F8 release];
                    [var_100 release];
                    _Block_object_dispose(&var_C8, 0x8);
                    [0x0 release];
            }
    }
    [r20 release];
    [r19 release];
    return;


// 0x1000464f4
// -[IconCollectionViewController openIcon:]
    r20 = [[self selectedLauncher] retain];
    r0 = [self selectedItem];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 view] retain];
    [self openLauncherTreeNode:r20 fromRect:r22 view:r4];
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x100046580
// -[IconCollectionViewController runIconWithOptions:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [[self selectedLauncher] retain];
    objc_opt_class(@class(LauncherAppTreeNode));
    if ((objc_opt_isKindOfClass() & 0x1) != 0x0 && [r19 isOpenable] != 0x0) {
            r0 = [r19 retain];
            r21 = r0;
            r22 = [[r0 bottle] retain];
            r23 = [[r21 launcher] retain];
            [r21 release];
            [BottleMenuHandler runCommandInBottle:r22 withLauncher:r23];
            [r23 release];
            [r22 release];
    }
    [r19 release];
    return;


// 0x100046644
// -[IconCollectionViewController launcherIsHidden:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [arg2 persistentID];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r20 = [NSSet alloc];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 objectForKey:@"HiddenLauncherIDs"] retain];
            r20 = [r20 initWithArray:r22];
            [r22 release];
            [r21 release];
            r21 = [r20 containsObject:r19];
            [r20 release];
            if ((r21 & 0x1) != 0x0) {
                    r20 = 0x1;
            }
            else {
                    r20 = 0x0;
            }
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100046710
// -[IconCollectionViewController markLauncher:asHidden:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg3;
    r0 = [arg2 retain];
    r19 = r0;
    r0 = [r0 persistentID];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r20 = [NSMutableSet alloc];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 objectForKey:@"HiddenLauncherIDs"] retain];
            r20 = [r20 initWithArray:r23];
            [r23 release];
            [r22 release];
            r22 = [[r19 persistentID] retain];
            r0 = r20;
            r2 = r22;
            if (r21 != 0x0) {
                    [r0 addObject:r2];
            }
            else {
                    [r0 removeObject:r2];
            }
            [r22 release];
            r21 = [[NSUserDefaults standardUserDefaults] retain];
            r22 = [[r20 allObjects] retain];
            [r21 setObject:r22 forKey:@"HiddenLauncherIDs"];
            [r22 release];
            [r21 release];
            [r20 release];
    }
    [r19 release];
    return;


// 0x10004684c
// -[IconCollectionViewController toggleApplicationIsHidden:]
    r31 = r31 - 0x120;
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
    var_110 = q0;
    var_100 = q0;
    r0 = [self selectedLaunchers];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r23 = *var_100;
            do {
                    r24 = 0x0;
                    do {
                            if (*var_100 != r23) {
                                    objc_enumerationMutation(r20);
                            }
                            r22 = *(var_108 + r24 * 0x8);
                            [r19 markLauncher:r22 asHidden:[r19 launcherIsHidden:r22] ^ 0x1];
                            r24 = r24 + 0x1;
                    } while (r21 != r24);
                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100046960
// -[IconCollectionViewController validateUserInterfaceItem:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [arg2 retain];
    r0 = **_NSApp;
    r0 = [r0 modalWindow];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r20 = r0;
            r21 = 0x0;
            [r20 release];
    }
    else {
            r0 = [r21 view];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 window];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 attachedSheet];
            r0 = [r0 retain];
            r23 = r0;
            [r0 release];
            [r22 release];
            [r20 release];
            if (r23 != 0x0) {
                    r21 = 0x0;
            }
            else {
                    r20 = [[r21 selectedLauncher] retain];
                    if ([r19 action] != @selector(openIcon:)) {
                            if ([r19 action] != @selector(runIconWithOptions:)) {
                                    if ([r19 action] == @selector(toggleApplicationIsHidden:)) {
                                            if (([r21 allowsMultipleSelection] & 0x1) != 0x0) {
                                                    r0 = [r21 selectedLaunchers];
                                                    r0 = [r0 retain];
                                                    r22 = r0;
                                                    if ([r0 count] != 0x0) {
                                                            r21 = 0x1;
                                                    }
                                                    [r22 release];
                                            }
                                            else {
                                                    r0 = [r20 canBeFavorite];
                                                    r21 = r0;
                                            }
                                    }
                                    else {
                                            r21 = 0x0;
                                    }
                            }
                            else {
                                    r0 = [r20 canRunCommands];
                                    r21 = r0;
                            }
                    }
                    else {
                            r0 = [r20 isOpenable];
                            r21 = r0;
                    }
                    [r20 release];
            }
    }
    [r19 release];
    r0 = r21;
    return r0;


// 0x100046ae0
// -[IconCollectionViewController validateMenuItem:]
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
    if ([r0 action] == @selector(toggleApplicationIsHidden:)) {
            r21 = [[r20 selectedLauncher] retain];
            r0 = [r20 selectedLaunchers];
            r0 = [r0 retain];
            r22 = r0;
            if ([r0 count] <= 0x1) {
                    if ([r21 canBeFavorite] != 0x0) {
                            r23 = [r20 launcherIsHidden:r21];
                            [r22 release];
                            if ((r23 & 0x1) != 0x0) {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    r2 = @"Show in 'Home'";
                            }
                            else {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    r2 = @"Hide from 'Home'";
                            }
                    }
                    else {
                            [r22 release];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r22 = r0;
                            r2 = @"Show in 'Home'";
                    }
            }
            else {
                    [r22 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r22 = r0;
                    r2 = @"Hide from 'Home'";
            }
            r23 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
            [r19 setTitle:r23];
            [r23 release];
            [r22 release];
            [r21 release];
    }
    r20 = [r20 validateUserInterfaceItem:r19];
    [r19 release];
    r0 = r20;
    return r0;


// 0x100046c3c
// -[IconCollectionViewController numberOfSectionsInCollectionView:]
    return 0x1;


// 0x100046c44
// -[IconCollectionViewController collectionView:numberOfItemsInSection:]
    r0 = [self launchers];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 count];
    [r19 release];
    r0 = r20;
    return r0;


// 0x100046c80
// -[IconCollectionViewController collectionView:itemForRepresentedObjectAtIndexPath:]
    r21 = [arg3 retain];
    r19 = [[arg2 makeItemWithIdentifier:@"IconViewItem" forIndexPath:r21] retain];
    r20 = [[self launchers] retain];
    r22 = [r21 item];
    [r21 release];
    r21 = [[r20 objectAtIndexedSubscript:r22] retain];
    [r19 setRepresentedObject:r21];
    [r21 release];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100046d34
// -[IconCollectionViewController collectionView:pasteboardWriterForItemAtIndexPath:]
    r0 = [arg2 itemAtIndexPath:arg3];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 representedObject];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 pasteboardWriter] retain];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x100046da0
// -[IconCollectionViewController collectionView:draggingSession:willBeginAtPoint:forItemsAtIndexPaths:]
    {r4:r5} = arg4;
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
    r20 = r4;
    var_48 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r0 = [r20 retain];
    r20 = r0;
    var_110 = q0;
    var_100 = q0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r24 = *var_100;
            do {
                    r25 = 0x0;
                    do {
                            if (*var_100 != r24) {
                                    objc_enumerationMutation(r20);
                            }
                            r0 = [r19 itemAtIndexPath:*(var_108 + r25 * 0x8)];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 view];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 setHidden:0x0];
                            [r23 release];
                            [r22 release];
                            r25 = r25 + 0x1;
                    } while (r21 != r25);
                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100046ee4
// -[IconCollectionViewController collectionView:didSelectItemsAtIndexPaths:]
    r0 = [self delegate];
    r0 = [r0 retain];
    r20 = r0;
    [r0 iconCollectionViewControllerSelectionChanged:self];
    [r20 release];
    return;


// 0x100046f1c
// -[IconCollectionViewController collectionView:didDeselectItemsAtIndexPaths:]
    r0 = [self delegate];
    r0 = [r0 retain];
    r20 = r0;
    [r0 iconCollectionViewControllerSelectionChanged:self];
    [r20 release];
    return;


// 0x100046f54
// -[IconCollectionViewController keyDown:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r0 = [arg2 retain];
    r19 = r0;
    r0 = [r0 charactersIgnoringModifiers];
    r0 = [r0 retain];
    r20 = r0;
    if ([r0 length] == 0x1) {
            r0 = [r20 characterAtIndex:0x0];
            switch (r0) {
                case 13:
                    [r21 openIcon:r21];
                    [r20 release];
                    [r19 release];
                    break;
                case 3:
                    [r21 openIcon:r21];
                    [r20 release];
                    [r19 release];
                    break;
                default:
                    if (([r19 modifierFlags] & 0x100000) != 0x0 && [r19 keyCode] == 0x7d) {
                            [r21 openIcon:r21];
                    }
                    else {
                            var_30 = r21;
                            [[&var_30 super] keyDown:r19];
                    }
                    [r20 release];
                    [r19 release];
                    break;
            }
    }
    else {
            if (([r19 modifierFlags] & 0x100000) != 0x0 && [r19 keyCode] == 0x7d) {
                    [r21 openIcon:r21];
            }
            else {
                    var_30 = r21;
                    [[&var_30 super] keyDown:r19];
            }
            [r20 release];
            [r19 release];
    }
    return;


// 0x100047020
// -[IconCollectionViewController mouseDown:]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    if ([r0 clickCount] >= 0x2) {
            [r20 openIcon:r20];
    }
    else {
            var_20 = r20;
            [[&var_20 super] mouseDown:r19];
    }
    [r19 release];
    return;


// 0x100047094
// -[IconCollectionViewController delegate]
    r0 = objc_loadWeakRetained((int64_t *)&self->_delegate);
    r0 = [r0 autorelease];
    return r0;


// 0x1000470b4
// -[IconCollectionViewController setDelegate:]
    objc_storeWeak((int64_t *)&self->_delegate, arg2);
    return;


// 0x1000470c8
// -[IconCollectionViewController launchers]
    r0 = self->_launchers;
    return r0;


// 0x1000470d8
// -[IconCollectionViewController collectionView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_collectionView);
    r0 = [r0 autorelease];
    return r0;


// 0x1000470f8
// -[IconCollectionViewController setCollectionView:]
    objc_storeWeak((int64_t *)&self->_collectionView, arg2);
    return;


// 0x10004710c
// -[IconCollectionViewController contextualMenu]
    r0 = objc_loadWeakRetained((int64_t *)&self->_contextualMenu);
    r0 = [r0 autorelease];
    return r0;


// 0x10004712c
// -[IconCollectionViewController setContextualMenu:]
    objc_storeWeak((int64_t *)&self->_contextualMenu, arg2);
    return;


// 0x100047140
// -[IconCollectionViewController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_contextualMenu);
    objc_destroyWeak((int64_t *)&self->_collectionView);
    objc_storeStrong((int64_t *)&self->_launchers, 0x0);
    objc_destroyWeak((int64_t *)&self->_delegate);
    return;


