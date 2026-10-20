// SelectBottleController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001e3e0
// +[SelectBottleController initialize]
    r31 = r31 - 0x40;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (objc_opt_class(@class(SelectBottleController)) == self) {
            r0 = [NSArray alloc];
            r0 = [r0 initWithObjects:@"exe"];
            r8 = *_builtInAllowedTypes;
            *_builtInAllowedTypes = r0;
            [r8 release];
    }
    return;


// 0x10001e470
// -[SelectBottleController init]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] initWithNibName:@"SelectBottleView" bundle:0x0];
    r19 = r0;
    if (r0 != 0x0) {
            r20 = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
            [r19 setRepresentedObject:r20];
            [r20 release];
            r20 = [[NSPredicate predicateWithFormat:@"canRunCommands != FALSE"] retain];
            [r19 setCanRunFilterPredicate:r20];
            [r20 release];
    }
    r0 = r19;
    return r0;


// 0x10001e528
// -[SelectBottleController dealloc]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleArrayController);
    r20 = r0;
    [r0 removeObserver:self forKeyPath:@"selectedObjects" context:_SelectBottleControllerKVOContextDummy];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x10001e59c
// -[SelectBottleController awakeFromNib]
    r20 = [[self bottleArrayController] retain];
    r22 = [[NSSortDescriptor alloc] initWithKey:@"isDefault" ascending:0x0];
    r23 = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:0x1 selector:@selector(localizedCaseInsensitiveCompare:)];
    r21 = [[NSArray arrayWithObjects:r22] retain];
    [r20 setSortDescriptors:r21];
    [r21 release];
    [r23 release];
    [r22 release];
    [r20 release];
    r0 = [self bottleArrayController];
    r0 = [r0 retain];
    r20 = r0;
    [r0 addObserver:self forKeyPath:@"selectedObjects" options:0x4 context:_SelectBottleControllerKVOContextDummy];
    [r20 release];
    return;


// 0x10001e6a8
// -[SelectBottleController setSelectedBottle:]
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
    r0 = (int64_t *)&r20->_selectedBottle;
    if (*r0 != r19) {
            objc_storeStrong(r0, r21);
            r8 = sign_extend_64(*(int32_t *)ivar_offset(cachedAllowedFileTypes));
            r0 = *(r20 + r8);
            *(r20 + r8) = 0x0;
            [r0 release];
            r0 = [r20 view];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 window];
            r0 = [r0 retain];
            r21 = r0;
            [r0 validateVisibleColumns];
            [r21 release];
            [r20 release];
    }
    [r19 release];
    return;


// 0x10001e74c
// -[SelectBottleController observeValueForKeyPath:ofObject:change:context:]
    r5 = arg5;
    r4 = arg4;
    r3 = arg3;
    r2 = arg2;
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if (r5 != _SelectBottleControllerKVOContextDummy) {
            var_30 = r19;
            [[&var_30 super] observeValueForKeyPath:r2 ofObject:r3 change:r4 context:r5];
    }
    else {
            r0 = [r19 bottleArrayController];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 selectedObjects] retain];
            [r21 release];
            if ([r20 count] != 0x0) {
                    r21 = [[r20 objectAtIndex:0x0] retain];
            }
            else {
                    r21 = 0x0;
            }
            [r19 setSelectedBottle:r21];
            [r21 release];
            [r20 release];
    }
    return;


// 0x10001e828
// -[SelectBottleController allowedFileTypes]
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
    r23 = sign_extend_64(*(int32_t *)ivar_offset(cachedAllowedFileTypes));
    r0 = *(self + r23);
    if (r0 == 0x0) {
            r20 = *_builtInAllowedTypes;
            r22 = [[r19 selectedBottle] retain];
            r21 = [[CXServer fileTypesForBottle:r22] retain];
            r0 = [r20 arrayByAddingObjectsFromArray:r21];
            r0 = [r0 retain];
            r8 = *(r19 + r23);
            *(r19 + r23) = r0;
            [r8 release];
            [r21 release];
            [r22 release];
            r0 = *(r19 + r23);
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10001e8d8
// -[SelectBottleController panel:shouldShowFilename:]
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
    r21 = self;
    var_48 = **___stack_chk_guard;
    r19 = [arg3 retain];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r20 = r0;
    [r0 fileExistsAtPath:r19 isDirectory:&var_C9];
    [r20 release];
    if (var_C9 != 0x0) {
            r22 = 0x1;
    }
    else {
            r20 = [[r19 pathExtension] retain];
            var_110 = q0;
            var_100 = q0;
            r0 = [r21 allowedFileTypes];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
            r22 = r0;
            if (r0 != 0x0) {
                    r23 = *var_100;
                    while (true) {
                            r24 = 0x0;
                            while (true) {
                                    if (*var_100 != r23) {
                                            objc_enumerationMutation(r21);
                                    }
                                    if ([r20 caseInsensitiveCompare:*(var_108 + r24 * 0x8)] == 0x0) {
                                            r22 = 0x1;
                                            temp_0 = 0x1;
                                            break;
                                    }
                                    r24 = r24 + 0x1;
                                    if (r22 != r24) {
                                            continue;
                                    }
                                    temp_0 = 0x0;
                                    break;
                            }
                            if (temp_0 == 0x0) {
                                    r0 = [r21 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                                    r22 = r0;
                                    if (r0 != 0x0) {
                                            continue;
                                    }
                                    temp_1 = 0x0;
                                    break;
                            }
                            temp_1 = 0x1;
                            break;
                    }
            }
            [r21 release];
            [r20 release];
    }
    r0 = [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    r0 = r22;
    return r0;


// 0x10001ea58
// -[SelectBottleController bottleArrayController]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleArrayController);
    r0 = [r0 autorelease];
    return r0;


// 0x10001ea78
// -[SelectBottleController setBottleArrayController:]
    objc_storeWeak((int64_t *)&self->_bottleArrayController, arg2);
    return;


// 0x10001ea8c
// -[SelectBottleController selectedBottle]
    r0 = self->_selectedBottle;
    return r0;


// 0x10001ea9c
// -[SelectBottleController canRunFilterPredicate]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_canRunFilterPredicate)), 0x1);
    return r0;


// 0x10001eaac
// -[SelectBottleController setCanRunFilterPredicate:]
    objc_setProperty_atomic();
    return;


// 0x10001eab8
// -[SelectBottleController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_canRunFilterPredicate, 0x0);
    objc_storeStrong((int64_t *)&self->_selectedBottle, 0x0);
    objc_destroyWeak((int64_t *)&self->_bottleArrayController);
    objc_storeStrong((int64_t *)&self->cachedAllowedFileTypes, 0x0);
    return;


