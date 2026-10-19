// SerialCodeRegisterController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10005d0e4
// -[SerialCodeRegisterController init]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] initWithWindowNibName:@"SerialCodeRegister"];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [[RegistrationController alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_regController));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
    }
    r0 = r19;
    return r0;


// 0x10005d158
// -[SerialCodeRegisterController registerWithSerialCode:]
    r8 = sign_extend_64(*(int32_t *)ivar_offset(_regController));
    r8 = *(self + r8);
    var_28 = *__NSConcreteStackBlock;
    [r8 beginRegisterAppWithSerialCodeWithCompletionHandler:&var_28];
    return;


// 0x10005d2d4
// -[SerialCodeRegisterController exitSuccess]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self window];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [r0 isSheet];
    [r19 release];
    if (r21 != 0x0) {
            r19 = [[NSApplication sharedApplication] retain];
            r20 = [[r20 window] retain];
            [r19 endSheet:r20 returnCode:0x1];
            [r20 release];
    }
    else {
            r0 = [r20 window];
            r0 = [r0 retain];
            r19 = r0;
            [r0 close];
    }
    [r19 release];
    return;


// 0x10005d380
// -[SerialCodeRegisterController cancel:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    [self->_regController cancel];
    r0 = [r19 window];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isSheet];
    [r20 release];
    if (r21 != 0x0) {
            r20 = [[NSApplication sharedApplication] retain];
            r19 = [[r19 window] retain];
            [r20 endSheet:r19 returnCode:0x0];
            [r19 release];
    }
    else {
            r0 = [r19 window];
            r0 = [r0 retain];
            r20 = r0;
            [r0 close];
    }
    [r20 release];
    return;


// 0x10005d440
// -[SerialCodeRegisterController openNormalRegistrationWindow:]
    r20 = [[NSApplication sharedApplication] retain];
    r19 = [[self window] retain];
    [r20 endSheet:r19 returnCode:0x3];
    [r19 release];
    [r20 release];
    return;


// 0x10005d4a4
// -[SerialCodeRegisterController regController]
    r0 = self->_regController;
    return r0;


// 0x10005d4b4
// -[SerialCodeRegisterController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_regController, 0x0);
    return;


// === Block Invocations for SerialCodeRegisterController ===

// 0x10005d1b8
// ___55-[SerialCodeRegisterController registerWithSerialCode:]_block_invoke
    r31 = r31 - 0x70;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = arg1;
    r21 = arg0;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    if (r19 != 0x0) {
            r0 = [[NSAlert alloc] init];
            r23 = r0;
            [r0 setMessageText:r19];
            [r23 setInformativeText:r20];
            r24 = [[r21[0x4] window] retain];
            var_60 = *__NSConcreteStackBlock;
            [r23 beginSheetModalForWindow:r24 completionHandler:&var_60];
            [r24 release];
            [r23 release];
    }
    else {
            if (r22 != 0x0) {
                    [r21[0x4] exitSuccess];
            }
    }
    [r20 release];
    r0 = [r19 release];
    return r0;


// 0x10005d2c0
// ___55-[SerialCodeRegisterController registerWithSerialCode:]_block_invoke_2
    r0 = arg0;
    if (r0[0x28] != 0x0) {
            [r0[0x4] exitSuccess];
    }
    return;


