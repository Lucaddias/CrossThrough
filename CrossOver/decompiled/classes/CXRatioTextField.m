// CXRatioTextField — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100038378
// -[CXRatioTextField initWithCoder:]
    r31 = r31 - 0x20;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_10 = self;
    r0 = [[&var_10 super] initWithCoder:arg2];
    if (r0 != 0x0) {
            r0->_maxAspectRatio = 0x555d555555555555;
    }
    return r0;


// 0x1000383c4
// -[CXRatioTextField initWithFrame:]
    {r2:r3:r4:r5} = arg2;
    r31 = r31 - 0x20;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_10 = self;
    r0 = [[&var_10 super] initWithFrame:r2];
    if (r0 != 0x0) {
            r0->_maxAspectRatio = 0x555d555555555555;
    }
    return r0;


// 0x100038410
// -[CXRatioTextField intrinsicContentSize]
    r31 = r31 - 0x90;
    var_70 = d15;
    decomp_var_68 = d14;
    var_60 = d13;
    decomp_var_58 = d12;
    var_50 = d11;
    decomp_var_48 = d10;
    var_40 = d9;
    decomp_var_38 = d8;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r21 = (int64_t *)&self->_cachedIntrinsicContentSize;
    r0 = NSEqualSizes(self, _cmd);
    if ((r0 & 0x1) != 0x0) {
            r0 = [r19 cell];
            r0 = [r0 retain];
            r20 = r0;
            d2 = 0x7fefffffffffffff;
            d3 = 0x7fefffffffffffff;
            [r0 cellSizeForBounds:r2];
            d9 = d0;
            d10 = d1;
            [r20 release];
            r22 = sign_extend_64(*(int32_t *)ivar_offset(_maxAspectRatio));
            d0 = *(r19 + r22);
            d8 = d10 * d0;
            if (d9 > d8) {
                    d14 = d10 + d10;
                    d15 = 0x3ff0000000000000;
                    var_78 = d10;
                    if (d9 - d8 > 0x3ff0000000000000) {
                            d13 = d8;
                            do {
                                    d10 = (d9 + d13) * 0x3fe0000000000000;
                                    r0 = [r19 cell];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    d3 = 0x7fefffffffffffff;
                                    d2 = d10;
                                    [r0 cellSizeForBounds:r2];
                                    d11 = d0;
                                    d12 = d1;
                                    [r20 release];
                                    d0 = *(r19 + r22);
                                    bool_11 = d11 > d12 * d0;
                                    bool_10 = d11 > d12 * d0;
                                    bool_9 = d11 > d12 * d0;
                                    if (d11 > d12 * d0) {
                                            d9 = d10;
                                    }
                                    if (!bool_11) {
                                            d13 = d10;
                                    }
                                    if (!bool_9) {
                                            d8 = d11;
                                    }
                                    if (!bool_10) {
                                            d14 = d12;
                                    }
                            } while (d9 - d13 > d15);
                    }
                    d1 = var_78;
                    if (d14 > d1) {
                            d11 = d1 * d0;
                            d13 = d8;
                            if (d8 - d11 > 0x3ff0000000000000) {
                                    d15 = d8;
                                    d13 = d8;
                                    do {
                                            d12 = (d15 + d11) * 0x3fe0000000000000;
                                            r0 = [r19 cell];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            [r0 cellSizeForBounds:r2];
                                            d9 = d0;
                                            [r20 release];
                                            d1 = 0x3ff0000000000000;
                                            bool_7 = d10 > d14;
                                            bool_5 = d10 > d14;
                                            if (d10 <= d14) {
                                                    d13 = d9;
                                            }
                                            if (!bool_7) {
                                                    d15 = d12;
                                            }
                                            if (bool_5) {
                                                    d11 = d12;
                                            }
                                    } while (d15 - d11 > d1);
                            }
                            r0 = [r19 cell];
                            r0 = [r0 retain];
                            r20 = r0;
                            d3 = 0x7fefffffffffffff;
                            d2 = d8;
                            [r0 cellSizeForBounds:r2];
                            [r20 release];
                    }
            }
            asm { frintp     d2, d9 };
            asm { frintp     d3, d10 };
            r0 = [r19 alignmentRectForFrame:r2];
            *r21 = d2;
            r21[0x1] = d3;
    }
    return r0;


// 0x100038680
// -[CXRatioTextField invalidateIntrinsicContentSize]
    *(int128_t *)(int64_t *)&self->_cachedIntrinsicContentSize = *(int128_t *)*_NSZeroSize;
    var_10 = self;
    [[&var_10 super] invalidateIntrinsicContentSize];
    return;


// 0x1000386cc
// -[CXRatioTextField invalidateIntrinsicContentSizeForCell:]
    r20 = [arg2 retain];
    [self invalidateIntrinsicContentSize];
    var_20 = self;
    [[&var_20 super] invalidateIntrinsicContentSizeForCell:r20];
    [r20 release];
    return;


// 0x10003872c
// -[CXRatioTextField maxAspectRatio]
    r0 = self;
    return r0;


// 0x10003873c
// -[CXRatioTextField setMaxAspectRatio:]
    self->_maxAspectRatio = d0;
    return;


