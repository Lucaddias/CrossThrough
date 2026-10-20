// ControlPanelLauncherTreeNode — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100026d14
// -[ControlPanelLauncherTreeNode isOpenable]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self bottle];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [r20 bottle];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [r0 isCanRunCommands];
            [r21 release];
    }
    else {
            r20 = 0x1;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100026d84
// +[ControlPanelLauncherTreeNode keyPathsForValuesAffectingPersistentID]
    r0 = [NSSet setWithObjects:@"bottle.name"];
    return r0;


// 0x100026dbc
// -[ControlPanelLauncherTreeNode persistentID]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r23 = sign_extend_64(*(int32_t *)ivar_offset(_persistentID));
    r0 = *(self + r23);
    if (r0 == 0x0) {
            r20 = [[r19 controlPanel] retain];
            r0 = [r19 bottle];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 name] retain];
            [r22 release];
            r22 = [[r20 valueForKey:@"exe"] retain];
            if ([r21 length] != 0x0 && [r22 length] != 0x0) {
                    r0 = [NSString alloc];
                    r0 = [r0 initWithFormat:@"ControlPanelLauncherID/%@/%@", r3, r4];
                    r8 = *(r19 + r23);
                    *(r19 + r23) = r0;
                    [r8 release];
            }
            [r22 release];
            [r21 release];
            [r20 release];
            r0 = *(r19 + r23);
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100026ebc
// +[ControlPanelLauncherTreeNode bottleNameFromPersistentID:]
    r2 = arg2;
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (r2 != 0x0) {
            r0 = [NSScanner scannerWithString:r2];
            r0 = [r0 retain];
            r19 = r0;
            [r0 setCharactersToBeSkipped:0x0];
            r21 = 0x0;
            r20 = 0x0;
            if ([r19 scanString:@"ControlPanelLauncherID/" intoString:0x0] != 0x0) {
                    var_28 = 0x0;
                    r0 = [r19 scanUpToString:@"/" intoString:&var_28];
                    r22 = r0;
                    r21 = [var_28 retain];
                    if (r22 != 0x0) {
                            r0 = [r21 retain];
                            r21 = r0;
                            r20 = r0;
                    }
                    else {
                            r20 = 0x0;
                    }
            }
            [r19 release];
            [r21 release];
    }
    else {
            r20 = 0x0;
    }
    r0 = [r20 autorelease];
    return r0;


// 0x100026f88
// -[ControlPanelLauncherTreeNode canBeFavorite]
    return 0x1;


// 0x100026f90
// -[ControlPanelLauncherTreeNode openWithErrorHandler:]
    r21 = [arg2 retain];
    r22 = [[self controlPanel] retain];
    r19 = [[self bottle] retain];
    r20 = [[LauncherControlPanel launcherWithControlPanel:r22 bottle:r19] retain];
    [r19 release];
    [r22 release];
    [r20 launchWithErrorHandler:r21];
    [r21 release];
    [r20 release];
    return;


// 0x100027034
// -[ControlPanelLauncherTreeNode controlPanel]
    r0 = self->_controlPanel;
    return r0;


// 0x100027044
// -[ControlPanelLauncherTreeNode setControlPanel:]
    objc_storeStrong((int64_t *)&self->_controlPanel, arg2);
    return;


// 0x100027058
// -[ControlPanelLauncherTreeNode .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_controlPanel, 0x0);
    objc_storeStrong((int64_t *)&self->_persistentID, 0x0);
    return;


