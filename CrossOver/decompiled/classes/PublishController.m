// PublishController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100038910
// -[PublishController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithWindowNibName:@"Publish"];
    return r0;


// 0x10003894c
// -[PublishController setBottleName:]
    r2 = arg2;
    r0 = self;
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(_bottleName));
    if (*(r0 + r21) != r2) {
            r19 = r0;
            r0 = [r2 stringInFileSystemRepresentationForm];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 copy];
            r8 = *(r19 + r21);
            *(r19 + r21) = r0;
            [r8 release];
            [r20 release];
    }
    return;


// 0x1000389c0
// -[PublishController setupGUI]
    [self setIsWorking:0x0];
    r20 = [[**_NSApp crossOverRoot] retain];
    r21 = [[NSString stringWithFormat:@"%@/bin/cxbounce", r3] retain];
    [self setBounceUtil:r21];
    [r21 release];
    [r20 release];
    return;


// 0x100038a4c
// -[PublishController publishPressed:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [[SFAuthorization alloc] init];
    [r19 setAuthorization:r20];
    [r20 release];
    r0 = [r19 authorization];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 obtainWithRight:"system.privilege.admin" flags:0x13 error:0x0];
    [r20 release];
    if (r21 != 0x0) {
            [r19 setIsWorking:0x1];
            [NSThread detachNewThreadSelector:@selector(doPublish) toTarget:r19 withObject:0x0];
    }
    return;


// 0x100038b00
// -[PublishController doPublish]
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xffffffffffffffc0 - 0x4b0;
    r20 = self;
    var_38 = **___stack_chk_guard;
    r19 = objc_autoreleasePoolPush();
    var_480 = "cxbottle";
    r0 = [r20 sourceBottle];
    r0 = [r0 retain];
    r0 = objc_retainAutorelease(r0);
    r21 = r0;
    [r0 UTF8String];
    r0 = [r20 bottleName];
    r0 = [r0 retain];
    r0 = objc_retainAutorelease(r0);
    r22 = r0;
    [r0 UTF8String];
    [r22 release];
    [r21 release];
    var_488 = 0x0;
    r0 = [r20 authorization];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 authorizationRef];
    r0 = [r20 bounceUtil];
    r0 = [r0 retain];
    r0 = objc_retainAutorelease(r0);
    r23 = r0;
    r0 = [r0 fileSystemRepresentation];
    r0 = AuthorizationExecuteWithPrivileges(r22, r0, 0x0, &var_480, &var_488);
    r22 = r0;
    [r23 release];
    [r21 release];
    if (r22 != 0x0) {
            var_4D8 = *__NSConcreteStackBlock;
            r8 = ___30-[PublishController doPublish]_block_invoke.16;
            r1 = &var_4D8;
    }
    else {
            do {
                    r0 = fileno(var_488);
                    r0 = read(r0, &decomp_var_438, 0x400);
            } while (r0 > 0x0);
            fclose(var_488);
            var_4B0 = *__NSConcreteStackBlock;
            r8 = ___30-[PublishController doPublish]_block_invoke;
            r1 = &var_4B0;
    }
    r1[0x1] = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbf0);
    r1[0x2] = r8;
    r1[0x3] = ___block_descriptor_40_e8_32s_e5_v8?0l;
    r1[0x4] = r20;
    dispatch_async(*__dispatch_main_q, r1);
    objc_autoreleasePoolPop(r19);
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x100038d6c
// -[PublishController publishFailed]
    r20 = [[NSAlert alloc] init];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 localizedStringForKey:@"Bottle publish failed" value:@"" table:0x0] retain];
    [r20 setMessageText:r22];
    [r22 release];
    [r21 release];
    r19 = [[self window] retain];
    [r20 beginSheetModalForWindow:r19 completionHandler:0x0];
    [r19 release];
    [r20 release];
    return;


// 0x100038e28
// -[PublishController exitSuccess:]
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 close];
    [r20 release];
    r20 = [[NSApplication sharedApplication] retain];
    r19 = [[self window] retain];
    [r20 endSheet:r19 returnCode:0x1];
    [r19 release];
    [r20 release];
    return;


// 0x100038ea8
// -[PublishController cancelPressed:]
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 close];
    [r20 release];
    r20 = [[NSApplication sharedApplication] retain];
    r19 = [[self window] retain];
    [r20 endSheet:r19 returnCode:0x0];
    [r19 release];
    [r20 release];
    return;


// 0x100038f28
// +[PublishController keyPathsForValuesAffectingNameCollides]
    r0 = [NSSet setWithObject:@"bottleName"];
    return r0;


// 0x100038f3c
// -[PublishController nameCollides]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self bottleName];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 length] != 0x0) {
            r21 = [CXSetupLib bottleQueryClass];
            r22 = [[r20 bottleName] retain];
            r0 = [r21 isValidNewBottleName:r22];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [r0 boolValue] ^ 0x1;
            [r21 release];
            [r22 release];
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100038fe0
// +[PublishController keyPathsForValuesAffectingCanPublish]
    r0 = [NSSet setWithObjects:@"bottleName"];
    return r0;


// 0x100039018
// -[PublishController canPublish]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self bottleName];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 length] != 0x0) {
            r20 = [r20 nameCollides];
            [r19 release];
            r0 = r20 ^ 0x1;
    }
    else {
            [r19 release];
            r0 = 0x0;
    }
    return r0;


// 0x100039074
// -[PublishController setSourceBottle:]
    r2 = arg2;
    r0 = self;
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r23 = sign_extend_64(*(int32_t *)ivar_offset(_sourceBottle));
    if (*(r0 + r23) != r2) {
            r19 = r0;
            r0 = [r2 copy];
            r8 = *(r19 + r23);
            *(r19 + r23) = r0;
            [r8 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 localizedStringForKey:@"published_%@" value:@"" table:0x0] retain];
            r20 = [[NSString stringWithFormat:r22] retain];
            [r22 release];
            [r21 release];
            r21 = [[[CXSetupLib bottleQueryClass] uniqueBottleName:r20] retain];
            [r19 setBottleName:r21];
            [r21 release];
            [r20 release];
    }
    return;


// 0x100039198
// -[PublishController bottleName]
    r0 = self->_bottleName;
    return r0;


// 0x1000391a8
// -[PublishController bounceUtil]
    r0 = self->_bounceUtil;
    return r0;


// 0x1000391b8
// -[PublishController setBounceUtil:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000391c4
// -[PublishController sourceBottle]
    r0 = self->_sourceBottle;
    return r0;


// 0x1000391d4
// -[PublishController authorization]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_authorization)), 0x1);
    return r0;


// 0x1000391e4
// -[PublishController setAuthorization:]
    objc_setProperty_atomic();
    return;


// 0x1000391f0
// -[PublishController isWorking]
    r0 = *(int8_t *)(int64_t *)&self->_isWorking & 0x1;
    return r0;


// 0x100039204
// -[PublishController setIsWorking:]
    *(int8_t *)(int64_t *)&self->_isWorking = arg2;
    return;


// 0x100039214
// -[PublishController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_authorization, 0x0);
    objc_storeStrong((int64_t *)&self->_sourceBottle, 0x0);
    objc_storeStrong((int64_t *)&self->_bounceUtil, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleName, 0x0);
    return;


