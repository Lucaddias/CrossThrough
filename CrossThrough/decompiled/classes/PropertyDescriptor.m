// PropertyDescriptor — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10005517c
// -[PropertyDescriptor description]
    r31 = r31 - 0x70;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_30 = self;
    r0 = [[&var_30 super] description];
    r0 = [r0 retain];
    r21 = r0;
    r8 = sign_extend_64(*(int32_t *)ivar_offset(_installTaskAttribute));
    r8 = *(r19 + r8);
    if (*(int8_t *)(r19 + sign_extend_64(*(int32_t *)ivar_offset(_boolTyped))) != 0x0) {
            r9 = @"YES";
    }
    else {
            r9 = @"NO";
    }
    r19 = [[NSString stringWithFormat:@"%@ installTaskAttribute %@ bool %@ getter %@ setter %@", r3, r4, r5, r6, r7] retain];
    [r21 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100055254
// -[PropertyDescriptor installTaskAttribute]
    r0 = self->_installTaskAttribute;
    return r0;


// 0x100055264
// -[PropertyDescriptor setInstallTaskAttribute:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100055270
// -[PropertyDescriptor boolTyped]
    r0 = *(int8_t *)(int64_t *)&self->_boolTyped;
    return r0;


// 0x100055280
// -[PropertyDescriptor setBoolTyped:]
    *(int8_t *)(int64_t *)&self->_boolTyped = arg2;
    return;


// 0x100055290
// -[PropertyDescriptor getter]
    r0 = self->_getter;
    return r0;


// 0x1000552a0
// -[PropertyDescriptor setGetter:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000552ac
// -[PropertyDescriptor setter]
    r0 = self->_setter;
    return r0;


// 0x1000552bc
// -[PropertyDescriptor setSetter:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000552c8
// -[PropertyDescriptor .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_setter, 0x0);
    objc_storeStrong((int64_t *)&self->_getter, 0x0);
    objc_storeStrong((int64_t *)&self->_installTaskAttribute, 0x0);
    return;


