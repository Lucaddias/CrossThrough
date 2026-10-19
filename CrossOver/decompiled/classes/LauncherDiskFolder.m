// LauncherDiskFolder — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000407a4
// -[LauncherDiskFolder initWithURL:]
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
    r22 = [[NSFileManager defaultManager] retain];
    r23 = [[r19 path] retain];
    r20 = [[r22 displayNameAtPath:r23] retain];
    [r23 release];
    [r22 release];
    var_40 = self;
    r0 = [[&var_40 super] initWithName:r20];
    r21 = r0;
    if (r0 != 0x0) {
            r0 = [r19 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_url));
            r8 = *(r21 + r9);
            *(r21 + r9) = r0;
            [r8 release];
    }
    [r20 release];
    [r19 release];
    r0 = r21;
    return r0;


// 0x100040894
// +[LauncherDiskFolder launcherWithFolderURL:]
    r20 = [arg2 retain];
    r19 = [[self alloc] initWithURL:r20];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x1000408dc
// -[LauncherDiskFolder copyWithZone:]
    var_20 = self;
    r0 = [[&var_20 super] copyWithZone:arg2];
    r20 = r0;
    [r0 setUrl:self->_url];
    r0 = r20;
    return r0;


// 0x100040934
// -[LauncherDiskFolder icon]
    r20 = [[NSWorkspace sharedWorkspace] retain];
    r0 = [self url];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 path] retain];
    r22 = [[r20 iconForFile:r21] retain];
    [r21 release];
    [r19 release];
    [r20 release];
    r0 = [r22 autorelease];
    return r0;


// 0x1000409c8
// -[LauncherDiskFolder description]
    var_30 = self;
    r0 = [[&var_30 super] description];
    r21 = [r0 retain];
    r19 = [[self url] retain];
    r20 = [[NSString stringWithFormat:@"%@ url %@", r3, r4] retain];
    [r19 release];
    [r21 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100040a6c
// -[LauncherDiskFolder url]
    r0 = self->_url;
    return r0;


// 0x100040a7c
// -[LauncherDiskFolder setUrl:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100040a88
// -[LauncherDiskFolder .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_url, 0x0);
    return;


