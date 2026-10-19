// CXFlatButton — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100005ee8
// +[CXFlatButton flatButtonWithTitle:icon:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [arg2 retain];
    r0 = [arg3 retain];
    r20 = r0;
    if (r0 != 0x0) {
            r0 = [r21 buttonWithTitle:r19 image:r20 target:0x0 action:0x0];
            r0 = [r0 retain];
    }
    else {
            r0 = [r21 buttonWithTitle:r19 target:0x0 action:0x0];
            r0 = [r0 retain];
    }
    r21 = r0;
    [r0 setAlignment:0x0];
    [r21 setImage:r20];
    [r21 setImagePosition:0x2];
    [r21 setImageScaling:0x3];
    if (r20 == 0x0) {
            [r21 setFlexibleIconWidth:0x1];
    }
    [r21 sizeToFit];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x100005fc8
// +[CXFlatButton flatButtonWithTitle:]
    r0 = [self flatButtonWithTitle:arg2 icon:0x0];
    return r0;


// 0x100005fd0
// -[CXFlatButton initWithFrame:]
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


// 0x100006020
// -[CXFlatButton initWithCoder:]
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


// 0x100006070
// -[CXFlatButton finishInit]
    [self setBordered:0x0];
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
    r0 = [NSTrackingArea alloc];
    r20 = [r0 initWithRect:0x241 options:self owner:0x0 userInfo:r5];
    [self addTrackingArea:r20];
    [r20 release];
    r20 = [[NSTextField labelWithString:@""] retain];
    [self setTitleTextField:r20];
    [r20 release];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setTranslatesAutoresizingMaskIntoConstraints:0x0];
    [r20 release];
    r20 = [[self titleTextField] retain];
    [self addSubview:r20];
    [r20 release];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 centerYAnchor] retain];
    r22 = [[self centerYAnchor] retain];
    r0 = [r21 constraintEqualToAnchor:r22];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setActive:0x1];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 rightAnchor] retain];
    r23 = [[self rightAnchor] retain];
    r20 = [[r22 constraintEqualToAnchor:r23 constant:r3] retain];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 setPriority:r2];
    [r20 setActive:0x1];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 leftAnchor] retain];
    r23 = [[self leftAnchor] retain];
    r24 = [[r22 constraintEqualToAnchor:r23] retain];
    [self setTitleTextFieldLeftConstraint:r24];
    [r24 release];
    [r23 release];
    [r22 release];
    [r21 release];
    [self updateTitleConstraints];
    r0 = [self titleTextFieldLeftConstraint];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setActive:0x1];
    [r21 release];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 widthAnchor];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 constraintEqualToConstant:r2] retain];
    [self setTitleTextFieldZeroWidthConstraint:r23];
    [r23 release];
    [r22 release];
    [r21 release];
    [self updateColors];
    [self reconfigureTitleTextField];
    [r20 release];
    return;


// 0x1000063d4
// -[CXFlatButton reconfigureTitleTextField]
    r20 = [[self font] retain];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setFont:r20];
    [r21 release];
    [r20 release];
    r20 = [[self title] retain];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setStringValue:r20];
    [r21 release];
    [r20 release];
    r20 = [self alignment];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setAlignment:r20];
    [r21 release];
    r20 = [self controlSize];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setControlSize:r20];
    [r21 release];
    r20 = [self lineBreakMode];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setLineBreakMode:r20];
    [r21 release];
    r20 = [self usesSingleLineMode];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setUsesSingleLineMode:r20];
    [r21 release];
    r20 = [self baseWritingDirection];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setBaseWritingDirection:r20];
    [r21 release];
    r20 = [self allowsExpansionToolTips];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setAllowsExpansionToolTips:r20];
    [r21 release];
    [self updateTitleTextColor];
    [self updateTitleConstraints];
    return;


// 0x1000065a0
// -[CXFlatButton updateTitleTextColor]
    r20 = [[self effectiveContentTintColor] retain];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setTextColor:r20];
    [r19 release];
    [r20 release];
    return;


// 0x1000065f4
// -[CXFlatButton updateTitleConstraints]
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
    [self alottedWidthForImage];
    d9 = 0x4024000000000000;
    d8 = d0 + 0x4024000000000000;
    if (d0 > 0x0) {
            r0 = [r19 title];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 length];
            [r20 release];
            d0 = d8 + d9;
            if (r21 != 0x0) {
                    d8 = d0;
            }
    }
    r0 = [r19 titleTextFieldLeftConstraint];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setConstant:r2];
    [r20 release];
    r0 = [r19 title];
    r0 = [r0 retain];
    r20 = r0;
    if ([r0 length] == 0x0) {
            r21 = 0x1;
    }
    r0 = [r19 titleTextFieldZeroWidthConstraint];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setActive:r21];
    [r22 release];
    [r20 release];
    [r19 invalidateIntrinsicContentSize];
    return;


// 0x1000066d8
// -[CXFlatButton setFlexibleIconWidth:]
    *(int8_t *)(int64_t *)&self->_flexibleIconWidth = arg2;
    [self updateTitleConstraints];
    [self reconfigureIcon];
    return;


// 0x100006708
// -[CXFlatButton reconfigureIcon]
    [self setNeedsDisplay:0x1];
    return;


// 0x100006710
// -[CXFlatButton imageAlignmentRectInsets]
    var_40 = d13;
    decomp_var_38 = d12;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = d11;
    decomp_var_28 = d10;
    var_20 = d9;
    decomp_var_18 = d8;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self image];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 release];
    if (r20 != 0x0) {
            r0 = [r19 image];
            r0 = [r0 retain];
            r20 = r0;
            [r0 alignmentRect];
            d8 = d0;
            d9 = d1;
            [r20 release];
            r0 = [r19 image];
            r0 = [r0 retain];
            r19 = r0;
            [r0 size];
            r0 = [r19 release];
    }
    else {
            r8 = *_NSEdgeInsetsZero;
            d8 = r8[0x1];
            d9 = r8[0x2];
    }
    return r0;


// 0x1000067e0
// -[CXFlatButton rectByRemovingInsets:fromRect:]
    {r2:r3:r4:r5} = arg2;
    r0 = self;
    return r0;


// 0x100006808
// -[CXFlatButton rectByRoundingRect:toPixelScale:]
    {r2:r3:r4:r5} = arg2;
    r0 = NSIntegralRect(self);
    return r0;


// 0x100006848
// -[CXFlatButton imageAlignmentRectSizeForCapHeight:scaleFactor:]
    r2 = arg3;
    r1 = _cmd;
    r31 = r31 - 0x70;
    var_50 = d13;
    decomp_var_48 = d12;
    var_40 = d11;
    decomp_var_38 = d10;
    var_30 = d9;
    decomp_var_28 = d8;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = r2;
    d8 = d0;
    r20 = self;
    r0 = [self image];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 release];
    if (r21 != 0x0) {
            r0 = [r20 image];
            r0 = [r0 retain];
            r21 = r0;
            [r0 alignmentRect];
            d10 = d2;
            d11 = d3;
            [r21 release];
            d12 = d8 / d11;
            d13 = d10 * d12;
            r0 = [r20 flexibleIconWidth];
            if ((r0 & 0x1) == 0x0) {
                    d9 = 0x4037000000000000;
                    if (d13 > 0x4037000000000000) {
                            r0 = NSLog(@"Scaling to cap height resulted in an icon of width %.1f (max is %.1f); scaling to max icon width instead. Increase CXFlatButtonFixedIconWidth or use flexibleIconWidth to ensure proper alignment.", r1, r2);
                            d12 = d9 / d10;
                            d8 = d11 * d12;
                            if (r19 != 0x0) {
                                    *r19 = d12;
                            }
                    }
                    else {
                            d9 = d13;
                            if (r19 != 0x0) {
                                    *r19 = d12;
                            }
                    }
            }
            else {
                    d9 = d13;
                    if (r19 != 0x0) {
                            *r19 = d12;
                    }
            }
    }
    else {
            if (r19 != 0x0) {
                    *r19 = 0x3ff0000000000000;
            }
            r8 = *_NSZeroSize;
            d9 = *r8;
            d8 = r8[0x1];
    }
    return r0;


// 0x10000694c
// -[CXFlatButton alottedWidthForImage]
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
    r0 = [self flexibleIconWidth];
    d8 = 0x4037000000000000;
    if (r0 != 0x0) {
            r0 = [r19 titleTextField];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 font];
            r0 = [r0 retain];
            r21 = r0;
            [r0 capHeight];
            [r19 imageAlignmentRectSizeForCapHeight:0x0 scaleFactor:r3];
            d8 = d0;
            [r21 release];
            r0 = [r20 release];
    }
    return r0;


// 0x1000069d0
// -[CXFlatButton imageFrame]
    r31 = r31 - 0x70;
    var_50 = d13;
    decomp_var_48 = d12;
    var_40 = d11;
    decomp_var_38 = d10;
    var_30 = d9;
    decomp_var_28 = d8;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self image];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 release];
    if (r20 != 0x0) {
            r0 = [r19 titleTextField];
            r0 = [r0 retain];
            r20 = r0;
            [r0 frame];
            r0 = [r19 titleTextField];
            r0 = [r0 retain];
            r21 = r0;
            [r0 firstBaselineOffsetFromTop];
            [r21 release];
            [r20 release];
            r0 = [r19 titleTextField];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 font];
            r0 = [r0 retain];
            r21 = r0;
            [r0 capHeight];
            d11 = d0;
            [r21 release];
            [r20 release];
            d8 = d8 - d11;
            r2 = &var_58;
            d0 = d11;
            [r19 imageAlignmentRectSizeForCapHeight:r2 scaleFactor:r3];
            d9 = d0;
            d10 = d1;
            r0 = [r19 flexibleIconWidth];
            d12 = 0x4024000000000000;
            if ((r0 & 0x1) == 0x0) {
                    d1 = 0x3fe0000000000000;
                    d2 = 0x4024000000000000;
                    d12 = (0x4037000000000000 - d9) * 0x3fe0000000000000 + 0x4024000000000000;
                    d0 = (d11 - d10) * 0x3fe0000000000000;
                    d8 = d8 + d0;
            }
            [r19 imageAlignmentRectInsets];
            [r19 rectByRemovingInsets:r2 fromRect:r3];
            r0 = [r19 window];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 screen];
            r0 = [r0 retain];
            r21 = r0;
            [r0 backingScaleFactor];
            [r21 release];
            [r20 release];
            asm { fmaxnm     d4, d12, d0 };
            r0 = [r19 rectByRoundingRect:r2 toPixelScale:r3];
    }
    return r0;


// 0x100006bb4
// -[CXFlatButton drawRect:]
    {r2:r3:r4:r5} = arg2;
    r1 = _cmd;
    var_40 = d11;
    decomp_var_38 = d10;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = d9;
    decomp_var_28 = d8;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self image];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            [r19 imageFrame];
            d8 = d0;
            d9 = d1;
            d10 = d2;
            d11 = d3;
            if ([r19 needsToDrawRect:r2] != 0x0) {
                    r0 = [r19 image];
                    r0 = [r0 retain];
                    r20 = r0;
                    [r0 drawInRect:r2];
                    [r20 release];
                    r0 = [r19 image];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [r0 isTemplate];
                    [r20 release];
                    if (r21 != 0x0) {
                            r0 = [r19 effectiveContentTintColor];
                            r0 = [r0 retain];
                            r19 = r0;
                            [r0 setFill];
                            [r19 release];
                            NSRectFillUsingOperation(0x3, r1);
                    }
            }
    }
    return;


// 0x100006cc8
// -[CXFlatButton updateColors]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self bezelColor];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    r0 = r19;
    if (r20 != 0x0) {
            r0 = [r0 bezelColor];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 colorWithAlphaComponent:r2] retain];
            [r19 setNormalBackgroundColor:r21];
            [r21 release];
            [r20 release];
            r0 = [r19 bezelColor];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 colorWithAlphaComponent:r2] retain];
            [r19 setHoverBackgroundColor:r21];
            [r21 release];
            [r20 release];
            r20 = [[r19 bezelColor] retain];
            [r19 setSelectedBackgroundColor:r20];
    }
    else {
            if ([r0 hasDestructiveAction] != 0x0) {
                    r0 = [NSColor systemRedColor];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 colorWithAlphaComponent:r2] retain];
                    [r19 setNormalBackgroundColor:r21];
                    [r21 release];
                    [r20 release];
                    r0 = [NSColor systemRedColor];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 colorWithAlphaComponent:r2] retain];
                    r2 = r21;
                    [r19 setHoverBackgroundColor:r2];
                    [r21 release];
                    [r20 release];
                    r0 = [NSColor systemRedColor];
                    r0 = [r0 retain];
                    r20 = r0;
            }
            else {
                    r0 = [NSColor secondarySelectedControlColor];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 colorWithAlphaComponent:r2] retain];
                    [r19 setNormalBackgroundColor:r21];
                    [r21 release];
                    [r20 release];
                    r0 = [NSColor secondarySelectedControlColor];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 colorWithAlphaComponent:r2] retain];
                    r2 = r21;
                    [r19 setHoverBackgroundColor:r2];
                    [r21 release];
                    [r20 release];
                    r0 = [NSColor secondarySelectedControlColor];
                    r0 = [r0 retain];
                    r20 = r0;
            }
            r21 = [[r0 colorWithAlphaComponent:r2] retain];
            [r19 setSelectedBackgroundColor:r21];
            [r21 release];
    }
    [r20 release];
    if ([r19 hasDestructiveAction] != 0x0) {
            r0 = [NSColor systemRedColor];
            r0 = [r0 retain];
    }
    else {
            r0 = [NSColor labelColor];
            r0 = [r0 retain];
    }
    [r19 setTextColor:r0];
    [r0 release];
    if ([r19 showsBorderOnlyWhileMouseInside] != 0x0) {
            r20 = [[NSColor clearColor] retain];
            [r19 setNormalBackgroundColor:r20];
            [r20 release];
    }
    [r19 updateBackgroundColorForCurrentState];
    [r19 updateTitleTextColor];
    [r19 reconfigureIcon];
    return;


// 0x100006fd8
// -[CXFlatButton effectiveContentTintColor]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self contentTintColor];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    r0 = self;
    if (r20 != 0x0) {
            r0 = [r0 contentTintColor];
            r0 = [r0 retain];
    }
    else {
            r0 = [r0 textColor];
            r0 = [r0 retain];
    }
    r0 = [r0 autorelease];
    return r0;


// 0x10000702c
// -[CXFlatButton updateBackgroundColorForCurrentState]
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


// 0x100007124
// -[CXFlatButton viewDidChangeEffectiveAppearance]
    var_20 = self;
    [[&var_20 super] viewDidChangeEffectiveAppearance];
    [self updateColors];
    return;


// 0x10000716c
// -[CXFlatButton setHovering:]
    r2 = arg2;
    r0 = self;
    r8 = sign_extend_64(*(int32_t *)ivar_offset(_hovering));
    if (*(int8_t *)(r0 + r8) != r2) {
            *(int8_t *)(r0 + r8) = r2;
            [r0 updateBackgroundColorForCurrentState];
    }
    return;


// 0x10000718c
// -[CXFlatButton updateTrackingAreas]
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


// 0x100007258
// -[CXFlatButton mouseEntered:]
    var_20 = self;
    [[&var_20 super] mouseEntered:arg2];
    [self setHovering:0x1];
    return;


// 0x1000072a4
// -[CXFlatButton mouseExited:]
    var_20 = self;
    [[&var_20 super] mouseExited:arg2];
    [self setHovering:0x0];
    return;


// 0x1000072f0
// -[CXFlatButton mouseDown:]
    r20 = [arg2 retain];
    [self highlight:0x1];
    var_20 = self;
    [[&var_20 super] mouseDown:r20];
    [r20 release];
    [self highlight:0x0];
    return;


// 0x100007360
// -[CXFlatButton drawFocusRingMask]
    [self bounds];
    r0 = [NSBezierPath bezierPathWithRoundedRect:r2 xRadius:r3 yRadius:r4];
    r0 = [r0 retain];
    r19 = r0;
    [r0 fill];
    [r19 release];
    return;


// 0x1000073a8
// -[CXFlatButton alignmentRectInsets]
    r0 = self;
    return r0;


// 0x1000073bc
// -[CXFlatButton firstBaselineOffsetFromTop]
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 font];
    r0 = [r0 retain];
    r21 = r0;
    [r0 ascender];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r22 = r0;
    r0 = [r0 font];
    r0 = [r0 retain];
    r23 = r0;
    [r0 descender];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    [self bounds];
    r0 = [self titleTextField];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 font];
    r0 = [r0 retain];
    r20 = r0;
    [r0 ascender];
    [r20 release];
    r0 = [r19 release];
    return r0;


// 0x1000074b8
// -[CXFlatButton intrinsicContentSize]
    var_40 = d11;
    decomp_var_38 = d10;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = d9;
    decomp_var_28 = d8;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self title];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 length];
    [r20 release];
    if (r21 != 0x0) {
            r0 = [r19 titleTextField];
            r0 = [r0 retain];
            r20 = r0;
            [r0 intrinsicContentSize];
            d8 = d0;
            d9 = d1;
            [r20 release];
    }
    else {
            r8 = *_NSZeroSize;
            d8 = *r8;
            d9 = r8[0x1];
    }
    d0 = **_NSViewNoIntrinsicMetric;
    d1 = 0x0;
    if (d8 == **_NSViewNoIntrinsicMetric) {
            d8 = d1;
    }
    [r19 alottedWidthForImage];
    d10 = 0x4024000000000000;
    d11 = d0 + 0x4024000000000000;
    r0 = [r19 title];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 length];
    r0 = [r19 release];
    d0 = 0x8000000000000000;
    if (r20 != 0x0) {
            d0 = d8;
    }
    asm { fmaxnm     d1, d9, d1 };
    return r0;


// 0x1000075c0
// -[CXFlatButton prepareForInterfaceBuilder]
    [self invalidateIntrinsicContentSize];
    var_20 = self;
    [[&var_20 super] prepareForInterfaceBuilder];
    return;


// 0x100007604
// -[CXFlatButton setFont:]
    var_20 = self;
    [[&var_20 super] setFont:arg2];
    [self reconfigureTitleTextField];
    return;


// 0x10000764c
// -[CXFlatButton setTitle:]
    var_20 = self;
    [[&var_20 super] setTitle:arg2];
    [self reconfigureTitleTextField];
    return;


// 0x100007694
// -[CXFlatButton setAlignment:]
    var_20 = self;
    [[&var_20 super] setAlignment:arg2];
    [self reconfigureTitleTextField];
    return;


// 0x1000076dc
// -[CXFlatButton setControlSize:]
    var_20 = self;
    [[&var_20 super] setControlSize:arg2];
    [self reconfigureTitleTextField];
    return;


// 0x100007724
// -[CXFlatButton setLineBreakMode:]
    r2 = arg2;
    r0 = self;
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = r0;
    if (r2 - 0x6 < -0x3) {
            r2 = 0x2;
    }
    var_20 = r0;
    [[&var_20 super] setLineBreakMode:r2];
    [r19 reconfigureTitleTextField];
    return;


// 0x10000777c
// -[CXFlatButton setUsesSingleLineMode:]
    var_20 = self;
    [[&var_20 super] setUsesSingleLineMode:arg2];
    [self reconfigureTitleTextField];
    return;


// 0x1000077c4
// -[CXFlatButton setBaseWritingDirection:]
    var_20 = self;
    [[&var_20 super] setBaseWritingDirection:arg2];
    [self reconfigureTitleTextField];
    return;


// 0x10000780c
// -[CXFlatButton setAllowsExpansionToolTips:]
    var_20 = self;
    [[&var_20 super] setAllowsExpansionToolTips:arg2];
    [self reconfigureTitleTextField];
    return;


// 0x100007854
// -[CXFlatButton setImage:]
    var_20 = self;
    [[&var_20 super] setImage:arg2];
    [self reconfigureIcon];
    return;


// 0x10000789c
// -[CXFlatButton setEnabled:]
    var_20 = self;
    [[&var_20 super] setEnabled:arg2];
    [self updateBackgroundColorForCurrentState];
    return;


// 0x1000078e4
// -[CXFlatButton highlight:]
    var_20 = self;
    [[&var_20 super] highlight:r2];
    [self setHighlighted:arg2];
    return;


// 0x100007934
// -[CXFlatButton setHighlighted:]
    var_20 = self;
    [[&var_20 super] setHighlighted:arg2];
    [self updateBackgroundColorForCurrentState];
    return;


// 0x10000797c
// -[CXFlatButton setShowsBorderOnlyWhileMouseInside:]
    var_20 = self;
    [[&var_20 super] setShowsBorderOnlyWhileMouseInside:arg2];
    [self updateColors];
    return;


// 0x1000079c4
// -[CXFlatButton setBezelColor:]
    var_20 = self;
    [[&var_20 super] setBezelColor:arg2];
    [self updateColors];
    return;


// 0x100007a0c
// -[CXFlatButton setHasDestructiveAction:]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg2;
    r19 = self;
    *(int8_t *)(int64_t *)&self->_cx_hasDestructiveAction = arg2;
    if (___isPlatformVersionAtLeast(0x1, 0xb, 0x0, 0x0) != 0x0) {
            var_20 = r19;
            [[&var_20 super] setHasDestructiveAction:r20];
    }
    [r19 updateColors];
    return;


// 0x100007a80
// -[CXFlatButton hasDestructiveAction]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = ___isPlatformVersionAtLeast(0x1, 0xb, 0x0, 0x0);
    if (r0 != 0x0) {
            var_20 = r19;
            r0 = [[&var_20 super] hasDestructiveAction];
    }
    else {
            if (*(int8_t *)(r19 + sign_extend_64(*(int32_t *)ivar_offset(_cx_hasDestructiveAction))) != 0x0) {
                    r0 = 0x1;
            }
    }
    return r0;


// 0x100007af0
// -[CXFlatButton setContentTintColor:]
    var_20 = self;
    [[&var_20 super] setContentTintColor:arg2];
    [self updateTitleTextColor];
    [self reconfigureIcon];
    return;


// 0x100007b40
// -[CXFlatButton flexibleIconWidth]
    r0 = *(int8_t *)(int64_t *)&self->_flexibleIconWidth;
    return r0;


// 0x100007b50
// -[CXFlatButton titleTextField]
    r0 = self->_titleTextField;
    return r0;


// 0x100007b60
// -[CXFlatButton setTitleTextField:]
    objc_storeStrong((int64_t *)&self->_titleTextField, arg2);
    return;


// 0x100007b74
// -[CXFlatButton titleTextFieldLeftConstraint]
    r0 = self->_titleTextFieldLeftConstraint;
    return r0;


// 0x100007b84
// -[CXFlatButton setTitleTextFieldLeftConstraint:]
    objc_storeStrong((int64_t *)&self->_titleTextFieldLeftConstraint, arg2);
    return;


// 0x100007b98
// -[CXFlatButton titleTextFieldZeroWidthConstraint]
    r0 = self->_titleTextFieldZeroWidthConstraint;
    return r0;


// 0x100007ba8
// -[CXFlatButton setTitleTextFieldZeroWidthConstraint:]
    objc_storeStrong((int64_t *)&self->_titleTextFieldZeroWidthConstraint, arg2);
    return;


// 0x100007bbc
// -[CXFlatButton hovering]
    r0 = *(int8_t *)(int64_t *)&self->_hovering;
    return r0;


// 0x100007bcc
// -[CXFlatButton normalBackgroundColor]
    r0 = self->_normalBackgroundColor;
    return r0;


// 0x100007bdc
// -[CXFlatButton setNormalBackgroundColor:]
    objc_storeStrong((int64_t *)&self->_normalBackgroundColor, arg2);
    return;


// 0x100007bf0
// -[CXFlatButton hoverBackgroundColor]
    r0 = self->_hoverBackgroundColor;
    return r0;


// 0x100007c00
// -[CXFlatButton setHoverBackgroundColor:]
    objc_storeStrong((int64_t *)&self->_hoverBackgroundColor, arg2);
    return;


// 0x100007c14
// -[CXFlatButton selectedBackgroundColor]
    r0 = self->_selectedBackgroundColor;
    return r0;


// 0x100007c24
// -[CXFlatButton setSelectedBackgroundColor:]
    objc_storeStrong((int64_t *)&self->_selectedBackgroundColor, arg2);
    return;


// 0x100007c38
// -[CXFlatButton textColor]
    r0 = self->_textColor;
    return r0;


// 0x100007c48
// -[CXFlatButton setTextColor:]
    objc_storeStrong((int64_t *)&self->_textColor, arg2);
    return;


// 0x100007c5c
// -[CXFlatButton .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_textColor, 0x0);
    objc_storeStrong((int64_t *)&self->_selectedBackgroundColor, 0x0);
    objc_storeStrong((int64_t *)&self->_hoverBackgroundColor, 0x0);
    objc_storeStrong((int64_t *)&self->_normalBackgroundColor, 0x0);
    objc_storeStrong((int64_t *)&self->_titleTextFieldZeroWidthConstraint, 0x0);
    objc_storeStrong((int64_t *)&self->_titleTextFieldLeftConstraint, 0x0);
    objc_storeStrong((int64_t *)&self->_titleTextField, 0x0);
    return;


