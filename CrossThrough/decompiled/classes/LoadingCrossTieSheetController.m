// LoadingCrossTieSheetController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100041860
// -[LoadingCrossTieSheetController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithWindowNibName:@"LoadingCrossTieSheet"];
    return r0;


// 0x10004189c
// -[LoadingCrossTieSheetController setCrossTieDisplayName:]
    r2 = arg2;
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_crossTieDisplayName));
    if (*(r0 + r20) != r2) {
            r19 = r0;
            r0 = [r2 copy];
            r8 = *(r19 + r20);
            *(r19 + r20) = r0;
            [r8 release];
            [r19 updateLoadingLabel];
    }
    return;


// 0x1000418f4
// -[LoadingCrossTieSheetController windowDidLoad]
    var_20 = self;
    [[&var_20 super] windowDidLoad];
    [self updateLoadingLabel];
    r0 = [self progressIndicator];
    r0 = [r0 retain];
    r19 = r0;
    [r0 startAnimation:0x0];
    [r19 release];
    return;


// 0x100041960
// -[LoadingCrossTieSheetController updateLoadingLabel]
    r1 = _cmd;
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self loadingLabel];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r20 = r0;
            r0 = [r19 crossTieDisplayName];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 length];
            [r21 release];
            [r20 release];
            if (r22 != 0x0) {
                    r0 = [r19 loadingLabel];
                    r0 = [r0 retain];
                    r20 = r0;
                    r0 = [r0 attributedStringValue];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [r0 mutableCopy];
                    [r21 release];
                    [r20 release];
                    r0 = [r22 string];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [r0 rangeOfString:@"%@"];
                    [r20 release];
                    r20 = [[r19 crossTieDisplayName] retain];
                    [r22 replaceCharactersInRange:r21 withString:r1];
                    [r20 release];
                    r0 = [r19 loadingLabel];
                    r0 = [r0 retain];
                    r19 = r0;
                    [r0 setAttributedStringValue:r22];
                    [r19 release];
                    [r22 release];
            }
    }
    return;


// 0x100041aa8
// -[LoadingCrossTieSheetController crossTieDisplayName]
    r0 = self->_crossTieDisplayName;
    return r0;


// 0x100041ab8
// -[LoadingCrossTieSheetController loadingLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_loadingLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x100041ad8
// -[LoadingCrossTieSheetController setLoadingLabel:]
    objc_storeWeak((int64_t *)&self->_loadingLabel, arg2);
    return;


// 0x100041aec
// -[LoadingCrossTieSheetController progressIndicator]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressIndicator);
    r0 = [r0 autorelease];
    return r0;


// 0x100041b0c
// -[LoadingCrossTieSheetController setProgressIndicator:]
    objc_storeWeak((int64_t *)&self->_progressIndicator, arg2);
    return;


// 0x100041b20
// -[LoadingCrossTieSheetController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_progressIndicator);
    objc_destroyWeak((int64_t *)&self->_loadingLabel);
    objc_storeStrong((int64_t *)&self->_crossTieDisplayName, 0x0);
    return;


