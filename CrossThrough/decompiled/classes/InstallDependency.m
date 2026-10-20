// InstallDependency — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100031270
// -[InstallDependency description]
    var_40 = self;
    r0 = [[&var_40 super] description];
    r21 = [r0 retain];
    r22 = [[self appID] retain];
    r23 = [[self reason] retain];
    r24 = [[self reasonString] retain];
    [self undo];
    r19 = [[NSString stringWithFormat:@"%@ appID %@ reason %@ %@ undo %lu", r3, r4, r5, r6, r7] retain];
    [r24 release];
    [r23 release];
    [r22 release];
    [r21 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100031364
// -[InstallDependency isEqual:]
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
    if (r0 != r20) {
            if ([r19 isMemberOfClass:objc_opt_class(r20)] != 0x0) {
                    r21 = [[r20 appID] retain];
                    r22 = [[r19 appID] retain];
                    r20 = [r21 isEqualToString:r22];
                    [r22 release];
                    [r21 release];
            }
            else {
                    r20 = 0x0;
            }
    }
    else {
            r20 = 0x1;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100031418
// -[InstallDependency hash]
    r0 = [self appID];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 hash];
    [r19 release];
    r0 = r20;
    return r0;


// 0x100031454
// +[InstallDependency keyPathsForValuesAffectingManuallyRemoved]
    r0 = [NSSet setWithObject:@"undo"];
    return r0;


// 0x100031468
// -[InstallDependency isManuallyRemoved]
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    r0 = [self undo];
    if (r0 == 0x1) {
            r0 = 0x1;
    }
    return r0;


// 0x100031484
// +[InstallDependency keyPathsForValuesAffectingManuallyAdded]
    r0 = [NSSet setWithObject:@"undo"];
    return r0;


// 0x100031498
// -[InstallDependency isManuallyAdded]
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    r0 = [self undo];
    if (r0 == 0x2) {
            r0 = 0x1;
    }
    return r0;


// 0x1000314b4
// +[InstallDependency keyPathsForValuesAffectingDisplayName]
    r0 = [NSSet setWithObjects:@"name"];
    return r0;


// 0x1000314ec
// -[InstallDependency displayName]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    [NSFont systemFontSize];
    r21 = [[NSFont systemFontOfSize:r2] retain];
    r20 = [[NSMutableDictionary dictionaryWithObject:r21 forKey:**_NSFontAttributeName] retain];
    [r21 release];
    if ([r19 isManuallyRemoved] != 0x0) {
            r21 = [@(0x1) retain];
            [r20 setObject:r21 forKey:**_NSStrikethroughStyleAttributeName];
            [r21 release];
    }
    r21 = [NSAttributedString alloc];
    r19 = [[r19 name] retain];
    r21 = [r21 initWithString:r19 attributes:r20];
    [r19 release];
    [r20 release];
    r0 = [r21 autorelease];
    return r0;


// 0x1000315fc
// +[InstallDependency keyPathsForValuesAffectingCanRemove]
    r0 = [NSSet setWithObjects:@"reason"];
    return r0;


// 0x100031634
// -[InstallDependency canRemove]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if (([self isManuallyRemoved] & 0x1) != 0x0) {
            r0 = 0x0;
    }
    else {
            r19 = [[r19 reason] retain];
            r20 = [[InstallConfiguration reasonMain] retain];
            r21 = [r19 isEqualToNumber:r20];
            [r20 release];
            [r19 release];
            r0 = r21 ^ 0x1;
    }
    return r0;


// 0x1000316b8
// +[InstallDependency keyPathsForValuesAffectingCanReAdd]
    r0 = [NSSet setWithObject:@"manuallyRemoved"];
    return r0;


// 0x1000316cc
// -[InstallDependency canReAdd]
    r0 = [self isManuallyRemoved];
    return r0;


// 0x1000316d0
// -[InstallDependency depth]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self parent];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r20 = r0;
            r19 = 0x0;
            do {
                    r19 = r19 + 0x1;
                    r21 = [[r20 parent] retain];
                    [r20 release];
                    r20 = r21;
            } while (r21 != 0x0);
    }
    else {
            r19 = 0x0;
    }
    r0 = r19;
    return r0;


// 0x10003173c
// -[InstallDependency sortKey]
    r0 = self;
    return r0;


// 0x100031740
// -[InstallDependency compareInstallDependencySortKey:]
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
    if (r20 != r0) {
            r21 = [r20 depth];
            r0 = [r19 depth];
            bool_2 = r21 <= r0;
            if (r21 < r0) {
                    r20 = 0xffffffffffffffff;
            }
            else {
                    if (!bool_2) {
                            r20 = 0x1;
                    }
                    else {
                            r20 = [r20 compareInstallDependencyWithinDepth:r19];
                    }
            }
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x1000317cc
// -[InstallDependency compareInstallDependencyWithinDepth:]
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
    r22 = [[r20 reason] retain];
    r23 = [[r19 reason] retain];
    r21 = [r22 compare:r23];
    [r23 release];
    [r22 release];
    if (r21 == 0x0) {
            r0 = [r20 parent];
            r0 = [r0 retain];
            r21 = r0;
            [r0 release];
            if (r21 != 0x0) {
                    r20 = [[r20 parent] retain];
                    r22 = [[r19 parent] retain];
                    r21 = [r20 compareInstallDependencyWithinDepth:r22];
                    [r22 release];
                    [r20 release];
            }
    }
    [r19 release];
    r0 = r21;
    return r0;


// 0x1000318c0
// -[InstallDependency appID]
    r0 = self->_appID;
    return r0;


// 0x1000318d0
// -[InstallDependency setAppID:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000318dc
// -[InstallDependency parent]
    r0 = objc_loadWeakRetained((int64_t *)&self->_parent);
    r0 = [r0 autorelease];
    return r0;


// 0x1000318fc
// -[InstallDependency setParent:]
    objc_storeWeak((int64_t *)&self->_parent, arg2);
    return;


// 0x100031910
// -[InstallDependency name]
    r0 = self->_name;
    return r0;


// 0x100031920
// -[InstallDependency setName:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10003192c
// -[InstallDependency reason]
    r0 = self->_reason;
    return r0;


// 0x10003193c
// -[InstallDependency setReason:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100031948
// -[InstallDependency reasonString]
    r0 = self->_reasonString;
    return r0;


// 0x100031958
// -[InstallDependency setReasonString:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100031964
// -[InstallDependency undo]
    r0 = self->_undo;
    return r0;


// 0x100031974
// -[InstallDependency setUndo:]
    self->_undo = arg2;
    return;


// 0x100031984
// -[InstallDependency .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_reasonString, 0x0);
    objc_storeStrong((int64_t *)&self->_reason, 0x0);
    objc_storeStrong((int64_t *)&self->_name, 0x0);
    objc_destroyWeak((int64_t *)&self->_parent);
    objc_storeStrong((int64_t *)&self->_appID, 0x0);
    return;


