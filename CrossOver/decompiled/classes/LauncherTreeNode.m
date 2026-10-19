// LauncherTreeNode — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100026274
// +[LauncherTreeNode keyPathsForValuesAffectingLeaf]
    r0 = [NSSet set];
    return r0;


// 0x100026280
// -[LauncherTreeNode isLeaf]
    return 0x1;


// 0x100026288
// -[LauncherTreeNode isOpenable]
    return 0x0;


// 0x100026290
// -[LauncherTreeNode canRunCommands]
    return 0x0;


// 0x100026298
// -[LauncherTreeNode animateOpen]
    return 0x1;


// 0x1000262a0
// -[LauncherTreeNode affectsAutoExpansion]
    return 0x1;


// 0x1000262a8
// -[LauncherTreeNode url]
    return 0x0;


// 0x1000262b0
// -[LauncherTreeNode persistentID]
    return 0x0;


// 0x1000262b8
// -[LauncherTreeNode canBeFavorite]
    return 0x0;


// 0x1000262c0
// -[LauncherTreeNode canBeRated]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = self->_bottle;
    if (r0 != 0x0) {
            r0 = [r0 appid];
            r0 = [r0 retain];
            r20 = r0;
            if ([r0 length] != 0x0) {
                    r19 = 0x1;
            }
            [r20 release];
    }
    else {
            r19 = 0x0;
    }
    r0 = r19;
    return r0;


// 0x100026318
// -[LauncherTreeNode openWithErrorHandler:]
    [arg2 retain];
    r21 = **_NSInternalInconsistencyException;
    r19 = [NSStringFromClass(objc_opt_class(self)) retain];
    r22 = [[NSString stringWithFormat:@"%s called; %@ is not openable", r3, r4] retain];
    [[[NSException exceptionWithName:r21 reason:r22 userInfo:0x0] retain] autorelease];
    [r22 release];
    [r19 release];
    objc_exception_throw(r20);
    return;


// 0x1000263d0
// -[LauncherTreeNode pasteboardWriter]
    return 0x0;


// 0x1000263d8
// +[LauncherTreeNode keyPathsForValuesAffectingSortOrderThenName]
    r0 = [NSSet setWithObjects:@"sortOrder"];
    return r0;


// 0x100026410
// -[LauncherTreeNode sortOrderThenName]
    r0 = self;
    return r0;


// 0x100026414
// +[LauncherTreeNode keyPathsForValuesAffectingSortOrderThenBottleName]
    r0 = [NSSet setWithObjects:@"sortOrder"];
    return r0;


// 0x10002644c
// -[LauncherTreeNode sortOrderThenBottleName]
    r0 = self;
    return r0;


// 0x100026450
// -[LauncherTreeNode compareSortOrderThenName:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if ([r20 sortOrder] < [r19 sortOrder]) {
            r20 = 0xffffffffffffffff;
    }
    else {
            if ([r20 sortOrder] > [r19 sortOrder]) {
                    r20 = 0x1;
            }
            else {
                    r21 = [[r20 name] retain];
                    r22 = [[r19 name] retain];
                    r20 = [r21 localizedStandardCompare:r22];
                    [r22 release];
                    [r21 release];
            }
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x10002651c
// -[LauncherTreeNode compareSortOrderThenBottleName:]
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
    r19 = [arg2 retain];
    if ([r20 sortOrder] < [r19 sortOrder]) {
            r20 = 0xffffffffffffffff;
    }
    else {
            if ([r20 sortOrder] > [r19 sortOrder]) {
                    r20 = 0x1;
            }
            else {
                    r0 = [r20 bottle];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [[r0 name] retain];
                    r0 = [r19 bottle];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [[r0 name] retain];
                    r20 = [r22 localizedStandardCompare:r24];
                    [r24 release];
                    [r23 release];
                    [r22 release];
                    [r21 release];
            }
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100026620
// -[LauncherTreeNode name]
    r0 = self->_name;
    return r0;


// 0x100026630
// -[LauncherTreeNode setName:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10002663c
// -[LauncherTreeNode icon]
    r0 = self->_icon;
    return r0;


// 0x10002664c
// -[LauncherTreeNode setIcon:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100026658
// -[LauncherTreeNode bottle]
    r0 = self->_bottle;
    return r0;


// 0x100026668
// -[LauncherTreeNode setBottle:]
    objc_storeStrong((int64_t *)&self->_bottle, arg2);
    return;


// 0x10002667c
// -[LauncherTreeNode tooltip]
    r0 = self->_tooltip;
    return r0;


// 0x10002668c
// -[LauncherTreeNode setTooltip:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100026698
// -[LauncherTreeNode sortOrder]
    r0 = *(int32_t *)(int64_t *)&self->_sortOrder;
    return r0;


// 0x1000266a8
// -[LauncherTreeNode setSortOrder:]
    *(int32_t *)(int64_t *)&self->_sortOrder = arg2;
    return;


// 0x1000266b8
// -[LauncherTreeNode showBottleName]
    r0 = *(int8_t *)(int64_t *)&self->_showBottleName & 0x1;
    return r0;


// 0x1000266cc
// -[LauncherTreeNode setShowBottleName:]
    *(int8_t *)(int64_t *)&self->_showBottleName = arg2;
    return;


// 0x1000266dc
// -[LauncherTreeNode .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_tooltip, 0x0);
    objc_storeStrong((int64_t *)&self->_bottle, 0x0);
    objc_storeStrong((int64_t *)&self->_icon, 0x0);
    objc_storeStrong((int64_t *)&self->_name, 0x0);
    return;


