// LauncherItem — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000403a0
// -[LauncherItem init]
    r0 = [self initWithName:0x0];
    return r0;


// 0x1000403a8
// -[LauncherItem initWithName:]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    var_20 = self;
    r0 = [[&var_20 super] init];
    r20 = r0;
    if (r0 != 0x0) {
            r0 = [r19 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_name));
            r8 = *(r20 + r9);
            *(r20 + r9) = r0;
            [r8 release];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100040428
// -[LauncherItem copyWithZone:]
    r0 = objc_opt_class(self);
    r0 = [r0 allocWithZone:arg2];
    r0 = [r0 init];
    r19 = r0;
    [r0 setName:self->_name];
    r0 = r19;
    return r0;


// 0x100040470
// -[LauncherItem icon]
    return 0x0;


// 0x100040478
// -[LauncherItem bottle]
    return 0x0;


// 0x100040480
// -[LauncherItem isLeaf]
    return 0x1;


// 0x100040488
// -[LauncherItem tooltip]
    return 0x0;


// 0x100040490
// -[LauncherItem description]
    r31 = r31 - 0x60;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_30 = self;
    r0 = [[&var_30 super] description];
    r21 = [r0 retain];
    r22 = [[self name] retain];
    r0 = [self isLeaf];
    r8 = @"NO";
    if (r0 != 0x0) {
            r8 = @"YES";
    }
    r19 = [[NSString stringWithFormat:@"%@ name %@ leaf %@", r3, r4, r5] retain];
    [r22 release];
    [r21 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100040558
// -[LauncherItem name]
    r0 = self->_name;
    return r0;


// 0x100040568
// -[LauncherItem setName:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100040574
// -[LauncherItem .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_name, 0x0);
    return;


