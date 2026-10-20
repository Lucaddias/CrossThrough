// CXFlatPopUpButton — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100007d00
// -[CXFlatPopUpButton initWithFrame:]
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


// 0x100007d50
// -[CXFlatPopUpButton initWithCoder:]
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


// 0x100007da0
// -[CXFlatPopUpButton finishInit]
    [self setWantsLayer:0x1];
    r0 = [self layer];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setMasksToBounds:0x1];
    [r20 release];
    r0 = [self layer];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setCornerRadius:r2];
    [r20 release];
    [self updateColors];
    [self setBordered:0x0];
    [self setBezelStyle:0x2];
    r0 = [NSTrackingArea alloc];
    r20 = [r0 initWithRect:0x241 options:self owner:0x0 userInfo:r5];
    [self addTrackingArea:r20];
    [r20 release];
    return;


// 0x100007e6c
// -[CXFlatPopUpButton updateColors]
    r0 = [NSColor secondarySelectedControlColor];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 colorWithAlphaComponent:r2] retain];
    [self setNormalBackgroundColor:r21];
    [r21 release];
    [r20 release];
    r0 = [NSColor secondarySelectedControlColor];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 colorWithAlphaComponent:r2] retain];
    [self setHoverBackgroundColor:r21];
    [r21 release];
    [r20 release];
    r0 = [NSColor secondarySelectedControlColor];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 colorWithAlphaComponent:r2] retain];
    [self setSelectedBackgroundColor:r21];
    [r21 release];
    [r20 release];
    [self updateBackgroundColorForCurrentState];
    return;


// 0x100007f6c
// -[CXFlatPopUpButton viewDidChangeEffectiveAppearance]
    var_20 = self;
    [[&var_20 super] viewDidChangeEffectiveAppearance];
    [self updateColors];
    return;


// 0x100007fb4
// -[CXFlatPopUpButton updateBackgroundColorForCurrentState]
    var_30 = d9;
    decomp_var_28 = d8;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self isEnabled];
    s0 = 0x3fe0000000000000;
    s1 = 0x3ff0000000000000;
    if (r0 == 0x0) {
            s8 = s0;
    }
    else {
            s8 = s1;
    }
    r0 = [r19 layer];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setOpacity:r2];
    [r20 release];
    if (([r19 isEnabled] & 0x1) != 0x0) {
            if ([r19 isHighlighted] != 0x0) {
                    r0 = [r19 selectedBackgroundColor];
                    r0 = [r0 retain];
            }
            else {
                    if ([r19 hovering] != 0x0) {
                            r0 = [r19 hoverBackgroundColor];
                            r0 = [r0 retain];
                    }
                    else {
                            r0 = [r19 normalBackgroundColor];
                            r0 = [r0 retain];
                    }
            }
    }
    else {
            r0 = [r19 normalBackgroundColor];
            r0 = [r0 retain];
    }
    r0 = objc_retainAutorelease(r0);
    r20 = r0;
    r21 = [r0 CGColor];
    r0 = [r19 layer];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setBackgroundColor:r21];
    [r19 release];
    [r20 release];
    return;


// 0x1000080ac
// -[CXFlatPopUpButton setHovering:]
    r2 = arg2;
    r0 = self;
    r8 = sign_extend_64(*(int32_t *)ivar_offset(_hovering));
    if (*(int8_t *)(r0 + r8) != r2) {
            *(int8_t *)(r0 + r8) = r2;
            [r0 updateBackgroundColorForCurrentState];
    }
    return;


// 0x1000080cc
// -[CXFlatPopUpButton highlight:]
    var_20 = self;
    [[&var_20 super] highlight:r2];
    [self setHighlighted:arg2];
    return;


// 0x10000811c
// -[CXFlatPopUpButton setHighlighted:]
    var_20 = self;
    [[&var_20 super] setHighlighted:arg2];
    [self updateBackgroundColorForCurrentState];
    return;


// 0x100008164
// -[CXFlatPopUpButton setEnabled:]
    var_20 = self;
    [[&var_20 super] setEnabled:arg2];
    [self updateBackgroundColorForCurrentState];
    return;


// 0x1000081ac
// -[CXFlatPopUpButton updateTrackingAreas]
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 mouseLocationOutsideOfEventStream];
    [r20 release];
    [self convertPoint:0x0 fromView:r3];
    [self bounds];
    [self setHovering:[self mouse:r2 inRect:r3]];
    var_30 = self;
    [[&var_30 super] updateTrackingAreas];
    return;


// 0x100008278
// -[CXFlatPopUpButton mouseEntered:]
    var_20 = self;
    [[&var_20 super] mouseEntered:arg2];
    [self setHovering:0x1];
    return;


// 0x1000082c4
// -[CXFlatPopUpButton mouseExited:]
    var_20 = self;
    [[&var_20 super] mouseExited:arg2];
    [self setHovering:0x0];
    return;


// 0x100008310
// -[CXFlatPopUpButton mouseDown:]
    r20 = [arg2 retain];
    [self highlight:0x1];
    var_20 = self;
    [[&var_20 super] mouseDown:r20];
    [r20 release];
    [self highlight:0x0];
    return;


// 0x100008380
// -[CXFlatPopUpButton addItemWithTitle:toolTip:]
    r21 = [arg3 retain];
    [self addItemWithTitle:arg2];
    r0 = [self menu];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 itemArray];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 lastObject] retain];
    [r20 release];
    [r19 release];
    [r22 setToolTip:r21];
    [r21 release];
    r0 = [r22 autorelease];
    return r0;


// 0x10000841c
// -[CXFlatPopUpButton normalBackgroundColor]
    r0 = self->_normalBackgroundColor;
    return r0;


// 0x10000842c
// -[CXFlatPopUpButton setNormalBackgroundColor:]
    objc_storeStrong((int64_t *)&self->_normalBackgroundColor, arg2);
    return;


// 0x100008440
// -[CXFlatPopUpButton hoverBackgroundColor]
    r0 = self->_hoverBackgroundColor;
    return r0;


// 0x100008450
// -[CXFlatPopUpButton setHoverBackgroundColor:]
    objc_storeStrong((int64_t *)&self->_hoverBackgroundColor, arg2);
    return;


// 0x100008464
// -[CXFlatPopUpButton selectedBackgroundColor]
    r0 = self->_selectedBackgroundColor;
    return r0;


// 0x100008474
// -[CXFlatPopUpButton setSelectedBackgroundColor:]
    objc_storeStrong((int64_t *)&self->_selectedBackgroundColor, arg2);
    return;


// 0x100008488
// -[CXFlatPopUpButton hovering]
    r0 = *(int8_t *)(int64_t *)&self->_hovering;
    return r0;


// 0x100008498
// -[CXFlatPopUpButton selected]
    r0 = *(int8_t *)(int64_t *)&self->_selected;
    return r0;


// 0x1000084a8
// -[CXFlatPopUpButton setSelected:]
    *(int8_t *)(int64_t *)&self->_selected = arg2;
    return;


// 0x1000084b8
// -[CXFlatPopUpButton .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_selectedBackgroundColor, 0x0);
    objc_storeStrong((int64_t *)&self->_hoverBackgroundColor, 0x0);
    objc_storeStrong((int64_t *)&self->_normalBackgroundColor, 0x0);
    return;


