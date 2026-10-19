// LauncherAppTreeNode — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10002689c
// +[LauncherAppTreeNode fromLauncher:]
    r20 = [arg2 retain];
    r19 = [[self alloc] init];
    r21 = [[r20 name] retain];
    [r19 setName:r21];
    [r21 release];
    r21 = [[r20 icon] retain];
    [r19 setIcon:r21];
    [r21 release];
    r21 = [[r20 bottle] retain];
    [r19 setBottle:r21];
    [r21 release];
    [r19 setLauncher:r20];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100026968
// -[LauncherAppTreeNode isOpenable]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r0 = [self bottle];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [r21 bottle];
            r0 = [r0 retain];
            r20 = r0;
            if (([r0 isCanRunCommands] & 0x1) != 0x0) {
                    r21 = 0x1;
            }
            else {
                    r0 = [r21 bottle];
                    r0 = [r0 retain];
                    r22 = r0;
                    r21 = [r0 isIsDisabled];
                    [r22 release];
            }
            [r20 release];
    }
    else {
            r21 = 0x1;
    }
    [r19 release];
    r0 = r21;
    return r0;


// 0x100026a04
// -[LauncherAppTreeNode canRunCommands]
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


// 0x100026a74
// -[LauncherAppTreeNode url]
    r0 = [self launcher];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 url] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100026ab8
// +[LauncherAppTreeNode keyPathsForValuesAffectingPersistentID]
    r0 = [NSSet setWithObject:@"launcher.bundleID"];
    return r0;


// 0x100026acc
// -[LauncherAppTreeNode persistentID]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_persistentID));
    r0 = *(self + r22);
    if (r0 == 0x0) {
            r0 = [r19 launcher];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [[r0 bundleID] retain];
            [r21 release];
            if ([r20 length] != 0x0) {
                    r0 = [NSString alloc];
                    r0 = [r0 initWithFormat:@"ProgramLauncherID/%@", r3];
                    r8 = *(r19 + r22);
                    *(r19 + r22) = r0;
                    [r8 release];
            }
            [r20 release];
            r0 = *(r19 + r22);
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100026b78
// -[LauncherAppTreeNode canBeFavorite]
    return 0x1;


// 0x100026b80
// -[LauncherAppTreeNode openWithErrorHandler:]
    r20 = [arg2 retain];
    r21 = [dispatch_get_global_queue(0x2, 0x0) retain];
    var_50 = *__NSConcreteStackBlock;
    r19 = [r20 retain];
    dispatch_async(r21, &var_50);
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x100026c6c
// -[LauncherAppTreeNode pasteboardWriter]
    r0 = [self launcher];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 url] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100026cb0
// -[LauncherAppTreeNode launcher]
    r0 = self->_launcher;
    return r0;


// 0x100026cc0
// -[LauncherAppTreeNode setLauncher:]
    objc_storeStrong((int64_t *)&self->_launcher, arg2);
    return;


// 0x100026cd4
// -[LauncherAppTreeNode .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_launcher, 0x0);
    objc_storeStrong((int64_t *)&self->_persistentID, 0x0);
    return;


// === Block Invocations for LauncherAppTreeNode ===

// 0x100026c30
// ___44-[LauncherAppTreeNode openWithErrorHandler:]_block_invoke
    r0 = arg0[0x4];
    r0 = [r0 launcher];
    r0 = [r0 retain];
    r20 = r0;
    [r0 launchWithErrorHandler:arg0[0x5]];
    r0 = [r20 release];
    return r0;


