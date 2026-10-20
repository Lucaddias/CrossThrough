// CXDisclosureView — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100005284
// -[CXDisclosureView initWithFrame:]
    {r2:r3:r4:r5} = arg2;
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] initWithFrame:r2];
    r19 = r0;
    if (r0 != 0x0) {
            [r19 finishInit];
    }
    r0 = r19;
    return r0;


// 0x1000052d4
// -[CXDisclosureView initWithCoder:]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] initWithCoder:arg2];
    r19 = r0;
    if (r0 != 0x0) {
            [r19 finishInit];
    }
    r0 = r19;
    return r0;


// 0x100005324
// -[CXDisclosureView finishInit]
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
    [self setTranslatesAutoresizingMaskIntoConstraints:0x0];
    r20 = [[NSButton buttonWithTitle:@" " target:r19 action:@selector(disclosureTriangleClicked:)] retain];
    [r19 setDisclosureTriangle:r20];
    [r20 release];
    r0 = [r19 disclosureTriangle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setTranslatesAutoresizingMaskIntoConstraints:0x0];
    [r20 release];
    r0 = [r19 disclosureTriangle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setBezelStyle:0x5];
    [r20 release];
    r0 = [r19 disclosureTriangle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setButtonType:0x6];
    [r20 release];
    r20 = [[r19 disclosureTriangle] retain];
    [r19 addSubview:r20];
    [r20 release];
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_title));
    r2 = *(r19 + r20);
    if (r2 == 0x0) {
            *(r19 + r20) = @"";
            [r2 release];
            r2 = *(r19 + r20);
    }
    r20 = [[NSButton buttonWithTitle:r2 target:r19 action:@selector(titleButtonClicked:)] retain];
    [r19 setTitleButton:r20];
    [r20 release];
    r20 = [[NSColor headerColor] retain];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setContentTintColor:r20];
    [r21 release];
    [r20 release];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setTranslatesAutoresizingMaskIntoConstraints:0x0];
    [r20 release];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setBordered:0x0];
    [r20 release];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setAlignment:0x0];
    [r20 release];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setLineBreakMode:0x4];
    [r20 release];
    [NSFont systemFontSizeForControlSize:0x1];
    r20 = [[NSFont systemFontOfSize:r2 weight:r3] retain];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setFont:r20];
    [r21 release];
    [r20 release];
    r20 = [[r19 titleButton] retain];
    [r19 addSubview:r20];
    [r20 release];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 leadingAnchor] retain];
    r22 = [[r19 leadingAnchor] retain];
    r0 = [r21 constraintEqualToAnchor:r22];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setActive:0x1];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 topAnchor] retain];
    r22 = [[r19 topAnchor] retain];
    r0 = [r21 constraintEqualToAnchor:r22];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setActive:0x1];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 bottomAnchor] retain];
    r22 = [[r19 bottomAnchor] retain];
    r0 = [r21 constraintEqualToAnchor:r22];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setActive:0x1];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 rightAnchor] retain];
    r0 = [r19 disclosureTriangle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 leftAnchor] retain];
    r0 = [r21 constraintEqualToAnchor:r23];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setActive:0x1];
    [r24 release];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 disclosureTriangle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 centerYAnchor] retain];
    r0 = [r19 titleButton];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 centerYAnchor] retain];
    r0 = [r21 constraintEqualToAnchor:r23];
    r0 = [r0 retain];
    r24 = r0;
    [r0 setActive:0x1];
    [r24 release];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 disclosureTriangle];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 rightAnchor] retain];
    r22 = [[r19 rightAnchor] retain];
    r0 = [r21 constraintEqualToAnchor:r22];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setActive:0x1];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [r19 autosaveName];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r21 = [[NSUserDefaults standardUserDefaults] retain];
            r22 = [[r19 autosaveName] retain];
            r20 = [[r21 objectForKey:r22] retain];
            [r22 release];
            [r21 release];
            if (r20 != 0x0) {
                    [r19 setOn:[r20 boolValue]];
                    [r20 release];
            }
            else {
                    if ([r19 gotOnState] != 0x0) {
                            r2 = [r19 isOn];
                    }
                    else {
                            r2 = 0x1;
                    }
                    [r19 setOn:r2];
            }
    }
    else {
            if ([r19 gotOnState] != 0x0) {
                    r2 = [r19 isOn];
            }
            else {
                    r2 = 0x1;
            }
            [r19 setOn:r2];
    }
    return;


// 0x1000059a8
// -[CXDisclosureView setTitle:]
    r0 = [arg2 copy];
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_title));
    r8 = *(self + r20);
    *(self + r20) = r0;
    [r8 release];
    r20 = *(self + r20);
    r0 = [self titleButton];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setTitle:r20];
    [r21 release];
    [self invalidateIntrinsicContentSize];
    return;


// 0x100005a18
// -[CXDisclosureView setOn:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg2;
    r20 = self;
    *(int8_t *)(int64_t *)&self->_gotOnState = 0x1;
    *(int8_t *)(int64_t *)&self->_on = arg2;
    r0 = [self disclosureTriangle];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setState:arg2];
    [r22 release];
    r0 = [r20 detailView];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setHidden:r19 ^ 0x1];
    [r22 release];
    r0 = [r20 autosaveName];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    if (r21 != 0x0) {
            r21 = [[NSUserDefaults standardUserDefaults] retain];
            r20 = [[r20 autosaveName] retain];
            [r21 setBool:r19 forKey:r20];
            [r20 release];
            [r21 release];
    }
    return;


// 0x100005b1c
// -[CXDisclosureView setAutosaveName:]
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
    r0 = [arg2 copy];
    r20 = sign_extend_64(*(int32_t *)ivar_offset(_autosaveName));
    r8 = *(r19 + r20);
    *(r19 + r20) = r0;
    [r8 release];
    if (*(r19 + r20) != 0x0) {
            r21 = [[NSUserDefaults standardUserDefaults] retain];
            r22 = [[r19 autosaveName] retain];
            r20 = [[r21 objectForKey:r22] retain];
            [r22 release];
            [r21 release];
            if (r20 != 0x0) {
                    [r19 setOn:[r20 boolValue]];
            }
            else {
                    r21 = [[NSUserDefaults standardUserDefaults] retain];
                    r22 = [r19 isOn];
                    r19 = [[r19 autosaveName] retain];
                    [r21 setBool:r22 forKey:r19];
                    [r19 release];
                    [r21 release];
            }
            [r20 release];
    }
    return;


// 0x100005c4c
// -[CXDisclosureView setDetailView:]
    objc_storeWeak((int64_t *)&self->_detailView, arg2);
    r19 = [self isOn] ^ 0x1;
    r0 = objc_loadWeakRetained((int64_t *)&self->_detailView);
    r20 = r0;
    [r0 setHidden:r19];
    [r20 release];
    return;


// 0x100005ca4
// -[CXDisclosureView disclosureTriangleClicked:]
    [self setOn:[self isOn] ^ 0x1];
    return;


// 0x100005ccc
// -[CXDisclosureView titleButtonClicked:]
    r0 = [self disclosureTriangle];
    r0 = [r0 retain];
    r19 = r0;
    [r0 performClick:0x0];
    [r19 release];
    return;


// 0x100005d00
// -[CXDisclosureView intrinsicContentSize]
    r0 = [self titleButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 intrinsicContentSize];
    [r20 release];
    r0 = [self disclosureTriangle];
    r0 = [r0 retain];
    r19 = r0;
    CGRectGetMaxX([r0 frame]);
    r0 = [r19 release];
    return r0;


// 0x100005d74
// -[CXDisclosureView prepareForInterfaceBuilder]
    [self invalidateIntrinsicContentSize];
    var_20 = self;
    [[&var_20 super] prepareForInterfaceBuilder];
    return;


// 0x100005db8
// -[CXDisclosureView title]
    r0 = self->_title;
    return r0;


// 0x100005dc8
// -[CXDisclosureView isOn]
    r0 = *(int8_t *)(int64_t *)&self->_on;
    return r0;


// 0x100005dd8
// -[CXDisclosureView detailView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_detailView);
    r0 = [r0 autorelease];
    return r0;


// 0x100005df8
// -[CXDisclosureView autosaveName]
    r0 = self->_autosaveName;
    return r0;


// 0x100005e08
// -[CXDisclosureView gotOnState]
    r0 = *(int8_t *)(int64_t *)&self->_gotOnState;
    return r0;


// 0x100005e18
// -[CXDisclosureView setGotOnState:]
    *(int8_t *)(int64_t *)&self->_gotOnState = arg2;
    return;


// 0x100005e28
// -[CXDisclosureView disclosureTriangle]
    r0 = self->_disclosureTriangle;
    return r0;


// 0x100005e38
// -[CXDisclosureView setDisclosureTriangle:]
    objc_storeStrong((int64_t *)&self->_disclosureTriangle, arg2);
    return;


// 0x100005e4c
// -[CXDisclosureView titleButton]
    r0 = self->_titleButton;
    return r0;


// 0x100005e5c
// -[CXDisclosureView setTitleButton:]
    objc_storeStrong((int64_t *)&self->_titleButton, arg2);
    return;


// 0x100005e70
// -[CXDisclosureView .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_titleButton, 0x0);
    objc_storeStrong((int64_t *)&self->_disclosureTriangle, 0x0);
    objc_storeStrong((int64_t *)&self->_autosaveName, 0x0);
    objc_destroyWeak((int64_t *)&self->_detailView);
    objc_storeStrong((int64_t *)&self->_title, 0x0);
    return;


