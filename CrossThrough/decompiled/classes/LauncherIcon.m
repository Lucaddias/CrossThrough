// LauncherIcon — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100040a9c
// -[LauncherIcon initWithName:]
    var_10 = self;
    r0 = [[&var_10 super] initWithName:arg2];
    return r0;


// 0x100040ad0
// -[LauncherIcon copyWithZone:]
    var_20 = self;
    r0 = [[&var_20 super] copyWithZone:arg2];
    r20 = r0;
    [r0 setIcon:self->_icon];
    [r20 setBottle:self->_bottle];
    r0 = r20;
    return r0;


// 0x100040b3c
// -[LauncherIcon tooltip]
    return 0x0;


// 0x100040b44
// -[LauncherIcon launchWithErrorHandler:]
    return;


// 0x100040b48
// -[LauncherIcon description]
    var_40 = self;
    r0 = [[&var_40 super] description];
    r21 = [r0 retain];
    r22 = [[self icon] retain];
    r0 = [self bottle];
    r0 = [r0 retain];
    r19 = r0;
    r23 = [[r0 name] retain];
    r20 = [[NSString stringWithFormat:@"%@ icon %p bottle name %@", r3, r4, r5] retain];
    [r23 release];
    [r19 release];
    [r22 release];
    [r21 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100040c2c
// -[LauncherIcon icon]
    r0 = self->_icon;
    return r0;


// 0x100040c3c
// -[LauncherIcon setIcon:]
    objc_storeStrong((int64_t *)&self->_icon, arg2);
    return;


// 0x100040c50
// -[LauncherIcon bottle]
    r0 = self->_bottle;
    return r0;


// 0x100040c60
// -[LauncherIcon setBottle:]
    objc_storeStrong((int64_t *)&self->_bottle, arg2);
    return;


// 0x100040c74
// -[LauncherIcon .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_bottle, 0x0);
    objc_storeStrong((int64_t *)&self->_icon, 0x0);
    return;


