// BottleNode — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000642d0
// +[BottleNode bottleNodeWithBottle:]
    r20 = [arg2 retain];
    r0 = [[self alloc] init];
    r19 = r0;
    [r0 setType:0x2];
    [r19 setBottle:r20];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100064324
// +[BottleNode groupBottleNodeWithName:]
    r20 = [arg2 retain];
    r0 = [[self alloc] init];
    r19 = r0;
    [r0 setType:0x0];
    [r19 setName:r20];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100064378
// +[BottleNode allBottlesBottleNode]
    r0 = [[self alloc] init];
    r19 = r0;
    [r0 setType:0x1];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 localizedStringForKey:@"Home" value:@"" table:0x0] retain];
    [r19 setName:r21];
    [r21 release];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100064404
// +[BottleNode installBottleNode]
    r0 = [[self alloc] init];
    r19 = r0;
    [r0 setType:0x3];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 localizedStringForKey:@"Install" value:@"" table:0x0] retain];
    [r19 setName:r21];
    [r21 release];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100064490
// -[BottleNode init]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] init];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [[NSMutableArray alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_children));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
    }
    r0 = r19;
    return r0;


// 0x1000644fc
// +[BottleNode keyPathsForValuesAffectingName]
    r0 = [NSSet setWithObject:@"bottle.changeableName"];
    return r0;


// 0x100064510
// -[BottleNode image]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([self type] == 0x1) {
            r2 = @"sf-symbols.house.fill";
    }
    else {
            if ([r19 type] == 0x3) {
                    r2 = @"sf-symbols.plus.app.fill";
            }
            else {
                    r2 = **_NSImageNameCaution;
            }
    }
    r0 = [NSImage imageNamed:r2];
    r0 = [r0 retain];
    r0 = [r0 autorelease];
    return r0;


// 0x10006458c
// -[BottleNode name]
    r0 = self;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    r8 = sign_extend_64(*(int32_t *)ivar_offset(_bottle));
    r8 = *(r0 + r8);
    if (r8 != 0x0) {
            r0 = [r8 changeableName];
            r0 = [r0 retain];
    }
    else {
            r0 = r0->_name;
            r0 = [r0 retain];
    }
    r0 = [r0 autorelease];
    return r0;


// 0x1000645d0
// -[BottleNode setName:]
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
    r23 = sign_extend_64(*(int32_t *)ivar_offset(_bottle));
    if (*(r20 + r23) != 0x0) {
            r0 = [r20 name];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 isEqual:r19];
            [r21 release];
            if ((r22 & 0x1) == 0x0) {
                    [*(r20 + r23) rename:r19 completionHandler:___block_literal_global];
            }
    }
    else {
            r21 = sign_extend_64(*(int32_t *)ivar_offset(_name));
            if (*(r20 + r21) != r19) {
                    r0 = [r19 copy];
                    r8 = *(r20 + r21);
                    *(r20 + r21) = r0;
                    [r8 release];
            }
    }
    [r19 release];
    return;


// 0x1000646c8
// -[BottleNode setChildren:]
    r2 = arg2;
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_children));
    if (*(r0 + r20) != r2) {
            r19 = r0;
            r0 = [r2 mutableCopy];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
    }
    return;


// 0x100064718
// -[BottleNode insertObject:inChildrenAtIndex:]
    [self->_children insertObject:arg2 atIndex:arg3];
    return;


// 0x100064728
// -[BottleNode insertChildren:atIndexes:]
    [self->_children insertObjects:arg2 atIndexes:arg3];
    return;


// 0x100064738
// -[BottleNode removeObjectFromChildrenAtIndex:]
    [self->_children removeObjectAtIndex:arg2];
    return;


// 0x100064748
// -[BottleNode removeChildrenAtIndexes:]
    [self->_children removeObjectsAtIndexes:arg2];
    return;


// 0x100064758
// -[BottleNode replaceChildrenAtIndexes:withChildren:]
    [self->_children replaceObjectsAtIndexes:arg2 withObjects:arg3];
    return;


// 0x100064768
// -[BottleNode isLeaf]
    r0 = self;
    if (*(int32_t *)(r0 + sign_extend_64(*(int32_t *)ivar_offset(_type))) != 0x0) {
            r0 = 0x1;
    }
    return r0;


// 0x100064780
// -[BottleNode type]
    r0 = *(int32_t *)(int64_t *)&self->_type;
    return r0;


// 0x100064790
// -[BottleNode setType:]
    *(int32_t *)(int64_t *)&self->_type = arg2;
    return;


// 0x1000647a0
// -[BottleNode setImage:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000647ac
// -[BottleNode children]
    r0 = self->_children;
    return r0;


// 0x1000647bc
// -[BottleNode bottle]
    r0 = self->_bottle;
    return r0;


// 0x1000647cc
// -[BottleNode setBottle:]
    objc_storeStrong((int64_t *)&self->_bottle, arg2);
    return;


// 0x1000647e0
// -[BottleNode sortPriority]
    r0 = *(int32_t *)(int64_t *)&self->_sortPriority;
    return r0;


// 0x1000647f0
// -[BottleNode setSortPriority:]
    *(int32_t *)(int64_t *)&self->_sortPriority = arg2;
    return;


// 0x100064800
// -[BottleNode .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_bottle, 0x0);
    objc_storeStrong((int64_t *)&self->_image, 0x0);
    objc_storeStrong((int64_t *)&self->_children, 0x0);
    objc_storeStrong((int64_t *)&self->_name, 0x0);
    return;


// === Block Invocations for BottleNode ===

// 0x10006468c
// ___22-[BottleNode setName:]_block_invoke
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r19 = r0;
    [r0 refresh];
    [r19 release];
    return;


