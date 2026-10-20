// LaunchFeedbackInfo — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003fe98
// -[LaunchFeedbackInfo initWithIcon:]
    r2 = arg2;
    r31 = r31 - 0xe0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_38 = **___stack_chk_guard;
    r19 = [r2 retain];
    var_B8 = self;
    r0 = [[&var_B8 super] init];
    r20 = r0;
    if (r0 != 0x0) {
            r1 = @selector(init);
            var_A2 = 0x16a;
            r0 = tmpnam(0x0);
            if (r0 != 0x0) {
                    r21 = r0;
                    r1 = r21;
                    r0 = __strlcpy_chk();
                    if (r0 >= 0x67) {
                            *(int32_t *)__error(r0, r1, 0x68);
                            NSLog(@"%s: failed to set up socket; errno %d", r1, r2);
                            if ((0xffffffff & 0xffffffff80000000) == 0x0) {
                                    close(0xffffffff);
                            }
                            [r19 release];
                            r0 = [r20 release];
                            if (**___stack_chk_guard != var_38) {
                                    __stack_chk_fail();
                            }
                            r0 = 0x0;
                    }
                    else {
                            r0 = socket(0x1, 0x1, 0x0);
                            r22 = r0;
                            if ((r0 & 0xffffffff80000000) == 0x0) {
                                    r1 = &var_A2;
                                    r0 = bind(r22, r1, 0x6a);
                                    if (r0 == 0x0) {
                                            r0 = listen(r22, 0x5);
                                            if (r0 == 0x0) {
                                                    r0 = [NSFileHandle alloc];
                                                    r0 = [r0 initWithFileDescriptor:r22 closeOnDealloc:0x1];
                                                    r23 = sign_extend_64(*(int32_t *)ivar_offset(socketHandle));
                                                    r8 = *(r20 + r23);
                                                    *(r20 + r23) = r0;
                                                    [r8 release];
                                                    if (*(r20 + r23) != 0x0) {
                                                            r0 = [NSNotificationCenter defaultCenter];
                                                            r0 = [r0 retain];
                                                            r22 = r0;
                                                            [r0 addObserver:r20 selector:@selector(connectionAccepted:) name:**_NSFileHandleConnectionAcceptedNotification object:*(r20 + r23)];
                                                            [r22 release];
                                                            [*(r20 + r23) acceptConnectionInBackgroundAndNotify];
                                                            r22 = [[NSFileManager defaultManager] retain];
                                                            r0 = strlen(r21);
                                                            r2 = r21;
                                                            r0 = [r22 stringWithFileSystemRepresentation:r2 length:r0];
                                                            r0 = [r0 retain];
                                                            r21 = sign_extend_64(*(int32_t *)ivar_offset(socketPath));
                                                            r8 = *(r20 + r21);
                                                            *(r20 + r21) = r0;
                                                            [r8 release];
                                                            [r22 release];
                                                            if (*(r20 + r21) != 0x0) {
                                                                    r0 = [r19 copy];
                                                                    r21 = sign_extend_64(*(int32_t *)ivar_offset(badgeIcon));
                                                                    r8 = *(r20 + r21);
                                                                    *(r20 + r21) = r0;
                                                                    [r8 release];
                                                                    [*(r20 + r21) setSize:r2];
                                                                    *(int32_t *)(int64_t *)&r20->lifeCounter = 0x0;
                                                                    r21 = [r20 retain];
                                                            }
                                                            else {
                                                                    r21 = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            close(r22);
                                                            r21 = 0x0;
                                                    }
                                            }
                                            else {
                                                    *(int32_t *)__error(r0, 0x5, 0x6a);
                                                    NSLog(@"%s: failed to set up socket; errno %d", r1, r2);
                                                    if ((r22 & 0xffffffff80000000) == 0x0) {
                                                            close(r22);
                                                    }
                                                    r21 = 0x0;
                                            }
                                    }
                                    else {
                                            *(int32_t *)__error(r0, r1, 0x6a);
                                            NSLog(@"%s: failed to set up socket; errno %d", r1, r2);
                                            if ((r22 & 0xffffffff80000000) == 0x0) {
                                                    close(r22);
                                            }
                                            r21 = 0x0;
                                    }
                                    [r19 release];
                                    r0 = [r20 release];
                                    if (**___stack_chk_guard != var_38) {
                                            __stack_chk_fail();
                                    }
                                    r0 = r21;
                            }
                            else {
                                    *(int32_t *)__error(r0, 0x1, 0x0);
                                    NSLog(@"%s: failed to set up socket; errno %d", r1, r2);
                                    if ((r22 & 0xffffffff80000000) == 0x0) {
                                            close(r22);
                                    }
                                    [r19 release];
                                    r0 = [r20 release];
                                    if (**___stack_chk_guard != var_38) {
                                            __stack_chk_fail();
                                    }
                                    r0 = 0x0;
                            }
                    }
            }
            else {
                    *(int32_t *)__error(r0, @selector(init), r2);
                    NSLog(@"%s: failed to set up socket; errno %d", r1, r2);
                    if ((0xffffffff & 0xffffffff80000000) == 0x0) {
                            close(0xffffffff);
                    }
                    [r19 release];
                    r0 = [r20 release];
                    if (**___stack_chk_guard != var_38) {
                            __stack_chk_fail();
                    }
                    r0 = 0x0;
            }
    }
    else {
            r21 = [r20 retain];
            [r19 release];
            r0 = [r20 release];
            if (**___stack_chk_guard != var_38) {
                    __stack_chk_fail();
            }
            r0 = r21;
    }
    return r0;


// 0x100040114
// -[LaunchFeedbackInfo dealloc]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = self->socketPath;
    if (r0 != 0x0) {
            unlink([r0 fileSystemRepresentation]);
    }
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:r19];
    [r20 release];
    [r19->socketHandle closeFile];
    var_20 = r19;
    [[&var_20 super] dealloc];
    return;


// 0x1000401a4
// -[LaunchFeedbackInfo lifeCounter]
    r0 = *(int32_t *)(int64_t *)&self->lifeCounter;
    return r0;


// 0x1000401b4
// -[LaunchFeedbackInfo setLifeCounter:]
    *(int32_t *)(int64_t *)&self->lifeCounter = arg2;
    return;


// 0x1000401c4
// -[LaunchFeedbackInfo socketPath]
    r0 = self->socketPath;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000401d4
// -[LaunchFeedbackInfo badgeIcon]
    r0 = self->badgeIcon;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000401e4
// -[LaunchFeedbackInfo notified]
    r0 = *(int8_t *)(int64_t *)&self->notified;
    return r0;


// 0x1000401f4
// -[LaunchFeedbackInfo setNotified:]
    *(int8_t *)(int64_t *)&self->notified = arg2;
    return;


// 0x100040204
// -[LaunchFeedbackInfo connectionAccepted:]
    r1 = _cmd;
    r31 = r31 - 0x50;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    r0 = [r0 userInfo];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 objectForKey:**_NSFileHandleNotificationFileHandleItem] retain];
    [r22 release];
    var_24 = 0x0;
    r0 = [r21 readDataOfLength:0x4];
    r0 = [r0 retain];
    r22 = r0;
    r2 = &var_24;
    [r0 getBytes:r2 length:0x4];
    r0 = [r22 length];
    r8 = var_24;
    if (r0 != 0x4 || r8 != 0x121) {
            NSLog(@"%s: got an unexpected launch-notify response: %u/0x%08x\n", r1, r2, 0x4);
    }
    [r22 release];
    [r20 setNotified:0x1];
    [r21 release];
    [r19 release];
    return;


// 0x10004034c
// -[LaunchFeedbackInfo .cxx_destruct]
    objc_storeStrong((int64_t *)&self->badgeIcon, 0x0);
    objc_storeStrong((int64_t *)&self->socketPath, 0x0);
    objc_storeStrong((int64_t *)&self->socketHandle, 0x0);
    return;


