// LauncherFolder — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100040588
// -[LauncherFolder init]
    r0 = [self initWithName:0x0];
    return r0;


// 0x100040590
// -[LauncherFolder initWithName:]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] initWithName:arg2];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [[NSMutableArray alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_items));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
    }
    r0 = r19;
    return r0;


// 0x1000405fc
// -[LauncherFolder copyWithZone:]
    var_10 = self;
    r0 = [[&var_10 super] copyWithZone:arg2];
    return r0;


// 0x100040630
// -[LauncherFolder isLeaf]
    return 0x0;


// 0x100040638
// -[LauncherFolder items]
    r0 = self->_items;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100040648
// -[LauncherFolder setItems:]
    r0 = [arg2 mutableCopy];
    r9 = sign_extend_64(*(int32_t *)ivar_offset(_items));
    r8 = *(self + r9);
    *(self + r9) = r0;
    [r8 release];
    return;


// 0x100040680
// -[LauncherFolder insertObject:inItemsAtIndex:]
    [self->_items insertObject:arg2 atIndex:arg3];
    return;


// 0x100040690
// -[LauncherFolder addLauncherItem:]
    r20 = self->_items;
    r21 = [arg2 retain];
    [self insertObject:r21 inItemsAtIndex:[r20 count]];
    [r21 release];
    return;


// 0x1000406e8
// -[LauncherFolder description]
    var_30 = self;
    r0 = [[&var_30 super] description];
    r21 = [r0 retain];
    r0 = [self items];
    r0 = [r0 retain];
    r19 = r0;
    [r0 count];
    r20 = [[NSString stringWithFormat:@"%@ item count %lu", r3, r4] retain];
    [r19 release];
    [r21 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100040790
// -[LauncherFolder .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_items, 0x0);
    return;


