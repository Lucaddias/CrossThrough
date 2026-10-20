// SummaryDetail — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10000855c
// +[SummaryDetail detailWithType:label:action:]
    r22 = [arg3 retain];
    r0 = [[SummaryDetail alloc] init];
    r21 = r0;
    [r0 setType:arg2];
    [r21 setLabel:r22];
    [r22 release];
    [r21 setAction:arg4];
    r0 = [r21 autorelease];
    return r0;


// 0x1000085d0
// -[SummaryDetail type]
    r0 = *(int32_t *)(int64_t *)&self->_type;
    return r0;


// 0x1000085e0
// -[SummaryDetail setType:]
    *(int32_t *)(int64_t *)&self->_type = arg2;
    return;


// 0x1000085f0
// -[SummaryDetail label]
    r0 = self->_label;
    return r0;


// 0x100008600
// -[SummaryDetail setLabel:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10000860c
// -[SummaryDetail action]
    r0 = self->_action;
    return r0;


// 0x10000861c
// -[SummaryDetail setAction:]
    self->_action = arg2;
    return;


// 0x10000862c
// -[SummaryDetail image]
    r0 = self->_image;
    return r0;


// 0x10000863c
// -[SummaryDetail setImage:]
    objc_storeStrong((int64_t *)&self->_image, arg2);
    return;


// 0x100008650
// -[SummaryDetail .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_image, 0x0);
    objc_storeStrong((int64_t *)&self->_label, 0x0);
    return;


