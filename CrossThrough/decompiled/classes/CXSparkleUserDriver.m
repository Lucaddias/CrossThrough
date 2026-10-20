// CXSparkleUserDriver — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003fdb8
// -[CXSparkleUserDriver setNotLicensed:]
    *(int8_t *)(int64_t *)&self->_isNotLicensed = arg2;
    return;


// 0x10003fdc8
// -[CXSparkleUserDriver showUpdateFoundWithAppcastItem:state:reply:]
    r31 = r31 - 0x40;
    decomp_var_30 = r22;
    decomp_var_28 = r21;
    decomp_var_20 = r20;
    decomp_var_18 = r19;
    decomp_var_10 = r29;
    decomp_var_8 = r30;
    r22 = r0;
    r19 = [r2 retain];
    r20 = [r3 retain];
    r21 = [r4 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            -[CXSparkleUserDriver showUpdateFoundWithAppcastItem:state:reply:].cold.1();
    }
    if (*(int8_t *)(r22 + sign_extend_64(*(int32_t *)ivar_offset(_isNotLicensed))) != 0x0) {
            (r21[0x2])(r21, 0x2);
    }
    else {
            decomp_var_40 = r22;
            [[&decomp_var_40 super] showUpdateFoundWithAppcastItem:r19 state:r20 reply:r21];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    return;


