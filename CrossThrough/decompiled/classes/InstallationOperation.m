// InstallationOperation — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003a3c4
// -[InstallationOperation initWithTaskStatus:completionSelector:andTarget:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg4;
    r21 = arg3;
    r23 = arg2;
    r19 = [arg2 retain];
    r22 = [r20 retain];
    var_40 = self;
    r0 = [[&var_40 super] init];
    r24 = r0;
    if (r0 != 0x0) {
            objc_storeStrong((int64_t *)&r24->taskStatus, r23);
            r24->completionSelector = r21;
            objc_storeStrong((int64_t *)&r24->selectorTarget, r20);
    }
    [r22 release];
    [r19 release];
    r0 = r24;
    return r0;


// 0x10003a488
// -[InstallationOperation main]
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
    r23 = sign_extend_64(*(int32_t *)ivar_offset(taskStatus));
    r0 = *(self + r23);
    r0 = [r0 task];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 main];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [r0 boolValue];
    [r22 release];
    [r20 release];
    if (([r19 isCancelled] & 0x1) == 0x0) {
            [*(r19 + r23) setSuccess:r21];
            [r19->selectorTarget performSelectorOnMainThread:r19->completionSelector withObject:*(r19 + r23) waitUntilDone:0x0];
    }
    return;


// 0x10003a604
// -[InstallationOperation .cxx_destruct]
    objc_storeStrong((int64_t *)&self->selectorTarget, 0x0);
    objc_storeStrong((int64_t *)&self->taskStatus, 0x0);
    return;


