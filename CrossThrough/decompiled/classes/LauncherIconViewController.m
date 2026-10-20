// LauncherIconViewController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003788c
// -[LauncherIconViewController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithNibName:@"LauncherIconView" bundle:0x0];
    return r0;


// 0x1000378cc
// -[LauncherIconViewController dealloc]
    r0 = [self dragView];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:0x0];
    [r20 release];
    r0 = **_NSApp;
    r0 = [r0 CXServer];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self forKeyPath:@"launchers"];
    [r20 release];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self forKeyPath:@"HiddenLauncherIDs"];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x100037990
// -[LauncherIconViewController viewDidLoad]
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
    var_48 = **___stack_chk_guard;
    var_68 = self;
    [[&var_68 super] viewDidLoad];
    r20 = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
    [self setBottleCollection:r20];
    [r20 release];
    r20 = [[IconCollectionViewController alloc] init];
    [self setIconCollectionViewController:r20];
    [r20 release];
    r0 = [self iconCollectionViewController];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 view] retain];
    [r21 release];
    var_50 = r20;
    r0 = [NSArray arrayWithObjects:&var_50 count:0x1];
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
    [r0 setAllowsMultipleSelection:0x1];
    [r22 release];
    r22 = [[self dragView] retain];
    var_58 = **_NSPasteboardTypeFileURL;
    r0 = [NSArray arrayWithObjects:&var_58 count:0x1];
    r23 = [r0 retain];
    [r22 registerForDraggedTypes:r23];
    [r23 release];
    [r22 release];
    r0 = [self dragView];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setDelegate:self];
    [r22 release];
    r0 = **_NSApp;
    r0 = [r0 CXServer];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addObserver:self forKeyPath:@"launchers" options:0x0 context:_LauncherIconViewControllerKVCContext];
    [r22 release];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addObserver:self forKeyPath:@"HiddenLauncherIDs" options:0x0 context:_LauncherIconViewControllerKVCContext];
    [r22 release];
    [self reloadLaunchers];
    [r21 release];
    [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100037d24
// -[LauncherIconViewController reloadLaunchers]
    r0 = **_NSApp;
    r0 = [r0 CXServer];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 launchers] retain];
    r22 = [[self launcherNodesForLaunchers:r21] retain];
    r0 = [self iconCollectionViewController];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setLaunchers:r22];
    [r19 release];
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x100037dc4
// -[LauncherIconViewController launcherNodesForLaunchers:]
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
    var_130 = self;
    var_60 = **___stack_chk_guard;
    r22 = [arg2 retain];
    r20 = [NSSet alloc];
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r21 = r0;
    r23 = [[r0 objectForKey:@"HiddenLauncherIDs"] retain];
    var_128 = [r20 initWithArray:r23];
    [r23 release];
    [r21 release];
    r21 = [[NSMutableArray array] retain];
    var_120 = q0;
    var_110 = q0;
    r0 = [r22 retain];
    r22 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r27 = *var_110;
            do {
                    r20 = 0x0;
                    while (true) {
                            if (*var_110 != r27) {
                                    objc_enumerationMutation(r22);
                            }
                            r24 = *(var_118 + r20 * 0x8);
                            if ([r24 isLeaf] != 0x0) {
                                    objc_opt_class(@class(LauncherApp));
                                    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                            r0 = [LauncherAppTreeNode fromLauncher:r24];
                                            r0 = [r0 retain];
                                            r24 = r0;
                                            [r0 setShowBottleName:0x1];
                                            r25 = [[r24 persistentID] retain];
                                            r26 = [var_128 containsObject:r25];
                                            [r25 release];
                                            if ((r26 & 0x1) == 0x0) {
                                                    [r21 addObject:r24];
                                            }
                                            [r24 release];
                                            r20 = r20 + 0x1;
                                            if (r23 != r20) {
                                                    continue;
                                            }
                                            break;
                                    }
                                    else {
                                            if (([r24 isLeaf] & 0x1) == 0x0) {
                                                    objc_opt_class(@class(LauncherFolder));
                                                    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                                            r24 = [[r24 items] retain];
                                                            r25 = [[var_130 launcherNodesForLaunchers:r24] retain];
                                                            [r21 addObjectsFromArray:r25];
                                                            [r25 release];
                                                            [r24 release];
                                                            r20 = r20 + 0x1;
                                                            if (r23 != r20) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                                    else {
                                                            r20 = r20 + 0x1;
                                                            if (r23 != r20) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                            else {
                                                    r20 = r20 + 0x1;
                                                    if (r23 != r20) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                            }
                            else {
                                    if (([r24 isLeaf] & 0x1) == 0x0) {
                                            objc_opt_class(@class(LauncherFolder));
                                            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                                                    r24 = [[r24 items] retain];
                                                    r25 = [[var_130 launcherNodesForLaunchers:r24] retain];
                                                    [r21 addObjectsFromArray:r25];
                                                    [r25 release];
                                                    [r24 release];
                                                    r20 = r20 + 0x1;
                                                    if (r23 != r20) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                            else {
                                                    r20 = r20 + 0x1;
                                                    if (r23 != r20) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                                    else {
                                            r20 = r20 + 0x1;
                                            if (r23 != r20) {
                                                    continue;
                                            }
                                            break;
                                    }
                            }
                    }
                    r0 = [r22 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r22 release];
    [r21 sortUsingSelector:@selector(compareSortOrderThenName:)];
    [var_128 release];
    r0 = [r22 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r21 autorelease];
    return r0;


// 0x100038064
// -[LauncherIconViewController observeValueForKeyPath:ofObject:change:context:]
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
    if (r22 != _LauncherIconViewControllerKVCContext) {
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
                    r0 = [NSUserDefaults standardUserDefaults];
                    r0 = [r0 retain];
                    if (r0 != r20) {
                            [r0 release];
                    }
                    else {
                            r22 = [r19 isEqualToString:@"HiddenLauncherIDs"];
                            [r20 release];
                            if (r22 != 0x0) {
                                    [r21 reloadLaunchers];
                            }
                    }
                    [r20 release];
                    [r19 release];
            }
            else {
                    r22 = [r19 isEqualToString:@"launchers"];
                    [r20 release];
                    if (r22 == 0x0) {
                            r0 = [NSUserDefaults standardUserDefaults];
                            r0 = [r0 retain];
                            if (r0 != r20) {
                                    [r0 release];
                            }
                            else {
                                    r22 = [r19 isEqualToString:@"HiddenLauncherIDs"];
                                    [r20 release];
                                    if (r22 != 0x0) {
                                            [r21 reloadLaunchers];
                                    }
                            }
                            [r20 release];
                            [r19 release];
                    }
                    else {
                            [r21 reloadLaunchers];
                            [r20 release];
                            [r19 release];
                    }
            }
    }
    return;


// 0x1000381a0
// -[LauncherIconViewController performDragOperation:]
    r20 = [[arg2 draggingPasteboard] retain];
    r19 = [[NSURL URLFromPasteboard:r20] retain];
    [r20 release];
    r20 = [[**_NSApp CXServer] retain];
    r21 = [[r19 path] retain];
    [r20 runClient:r21 inBottle:0x0 withDialog:0x1];
    [r21 release];
    [r20 release];
    [r19 release];
    return 0x1;


// 0x10003825c
// -[LauncherIconViewController iconCollectionViewController]
    r0 = self->_iconCollectionViewController;
    return r0;


// 0x10003826c
// -[LauncherIconViewController setIconCollectionViewController:]
    objc_storeStrong((int64_t *)&self->_iconCollectionViewController, arg2);
    return;


// 0x100038280
// -[LauncherIconViewController bottleCollection]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
    r0 = [r0 autorelease];
    return r0;


// 0x1000382a0
// -[LauncherIconViewController setBottleCollection:]
    objc_storeWeak((int64_t *)&self->_bottleCollection, arg2);
    return;


// 0x1000382b4
// -[LauncherIconViewController iconCollectionView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_iconCollectionView);
    r0 = [r0 autorelease];
    return r0;


// 0x1000382d4
// -[LauncherIconViewController setIconCollectionView:]
    objc_storeWeak((int64_t *)&self->_iconCollectionView, arg2);
    return;


// 0x1000382e8
// -[LauncherIconViewController dragView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_dragView);
    r0 = [r0 autorelease];
    return r0;


// 0x100038308
// -[LauncherIconViewController setDragView:]
    objc_storeWeak((int64_t *)&self->_dragView, arg2);
    return;


// 0x10003831c
// -[LauncherIconViewController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_dragView);
    objc_destroyWeak((int64_t *)&self->_iconCollectionView);
    objc_destroyWeak((int64_t *)&self->_bottleCollection);
    objc_storeStrong((int64_t *)&self->_iconCollectionViewController, 0x0);
    return;


