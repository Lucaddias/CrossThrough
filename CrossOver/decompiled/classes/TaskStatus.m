// TaskStatus — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003a11c
// -[TaskStatus initWithTask:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    var_30 = self;
    r0 = [[&var_30 super] init];
    r20 = r0;
    if (r0 != 0x0) {
            [r20 setTask:r19];
            r0 = [r20 task];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 valueForKey:@"label"] retain];
            [r20 setLabel:r22];
            [r22 release];
            [r21 release];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x10003a1d8
// -[TaskStatus cancel]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self installOp];
    r0 = [r0 retain];
    r20 = r0;
    [r0 cancel];
    [r20 release];
    r0 = [r19 task];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 canCancel];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 boolValue];
    [r21 release];
    [r20 release];
    if (r22 != 0x0) {
            r0 = [r19 task];
            r0 = [r0 retain];
            r20 = r0;
            [r0 cancel];
            [r20 release];
    }
    [r19 done];
    [r19 setSuccess:0x0];
    return;


// 0x10003a288
// -[TaskStatus done]
    r0 = [self task];
    r0 = [r0 retain];
    r20 = r0;
    [r0 done];
    [r20 release];
    [self setFinished:0x1];
    [self setInstallOp:0x0];
    return;


// 0x10003a2d4
// -[TaskStatus finished]
    r0 = *(int8_t *)(int64_t *)&self->_finished & 0x1;
    return r0;


// 0x10003a2e8
// -[TaskStatus setFinished:]
    *(int8_t *)(int64_t *)&self->_finished = arg2;
    return;


// 0x10003a2f8
// -[TaskStatus success]
    r0 = *(int8_t *)(int64_t *)&self->_success & 0x1;
    return r0;


// 0x10003a30c
// -[TaskStatus setSuccess:]
    *(int8_t *)(int64_t *)&self->_success = arg2;
    return;


// 0x10003a31c
// -[TaskStatus label]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_label)), 0x1);
    return r0;


// 0x10003a32c
// -[TaskStatus setLabel:]
    objc_setProperty_atomic_copy();
    return;


// 0x10003a338
// -[TaskStatus task]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_task)), 0x1);
    return r0;


// 0x10003a348
// -[TaskStatus setTask:]
    objc_setProperty_atomic();
    return;


// 0x10003a354
// -[TaskStatus installOp]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_installOp)), 0x1);
    return r0;


// 0x10003a364
// -[TaskStatus setInstallOp:]
    objc_setProperty_atomic();
    return;


// 0x10003a370
// -[TaskStatus .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_installOp, 0x0);
    objc_storeStrong((int64_t *)&self->_task, 0x0);
    objc_storeStrong((int64_t *)&self->_label, 0x0);
    return;


