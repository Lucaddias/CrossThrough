// IconViewBox — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10005d4c8
// -[IconViewBox dealloc]
    r0 = [NSNotificationCenter defaultCenter];
    r0 = [r0 retain];
    r20 = r0;
    [r0 removeObserver:self];
    [r20 release];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x10005d530
// -[IconViewBox pathForIconHighlight]
    r0 = [self item];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 imageView];
    r0 = [r0 retain];
    r20 = r0;
    NSInsetRect([r0 frame], r1, r2);
    [r20 release];
    [r19 release];
    r0 = [NSBezierPath bezierPathWithRoundedRect:r2 xRadius:r3 yRadius:r4];
    return r0;


// 0x10005d5c8
// -[IconViewBox pathForLabelHighlight]
    r0 = [self item];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 textField];
    r0 = [r0 retain];
    r20 = r0;
    [r0 frame];
    [r20 release];
    [r19 release];
    r0 = [NSBezierPath bezierPathWithRoundedRect:r2 xRadius:r3 yRadius:r4];
    return r0;


// 0x10005d65c
// -[IconViewBox menuForEvent:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    var_30 = r20;
    r0 = [[&var_30 super] menuForEvent:r19];
    r0 = [r0 retain];
    r21 = r0;
    if (r0 == 0x0) {
            r0 = [r20 item];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 collectionView];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 menuForEvent:r19] retain];
            [r22 release];
            [r20 release];
    }
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x10005d718
// -[IconViewBox hitTest:]
    {r2:r3} = arg2;
    r31 = r31 - 0x60;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = self;
    var_50 = self;
    r0 = [[&var_50 super] hitTest:r2];
    r19 = [r0 retain];
    r0 = [r22 item];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 textField] retain];
    r0 = r19;
    if (r19 != r21) {
            r0 = [r22 item];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 imageView];
            r0 = [r0 retain];
            if (r19 != r0) {
                    r24 = r0;
                    r0 = [r22 auxField];
                    r0 = [r0 retain];
                    r25 = r0;
                    if (([r0 isHidden] & 0x1) != 0x0) {
                            [r25 release];
                            [r24 release];
                            [r23 release];
                            [r21 release];
                            [r20 release];
                            r20 = 0x0;
                    }
                    else {
                            r0 = [r22 auxField];
                            r0 = [r0 retain];
                            r22 = r0;
                            [r0 release];
                            [r25 release];
                            [r24 release];
                            [r23 release];
                            [r21 release];
                            [r20 release];
                            if (r19 != r22) {
                                    r20 = 0x0;
                            }
                            else {
                                    r20 = [r19 retain];
                            }
                    }
            }
            else {
                    [r19 release];
                    [r23 release];
                    r0 = r21;
                    [r0 release];
                    [r20 release];
                    r20 = [r19 retain];
            }
    }
    else {
            [r0 release];
            [r20 release];
            r20 = [r19 retain];
    }
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10005d8a8
// -[IconViewBox isHighlighted]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = self;
    r0 = [self item];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 isSelected];
    r21 = r0;
    if (r0 != 0x0) {
            r0 = [r22 item];
            r0 = [r0 retain];
            r20 = r0;
            if ([r0 highlightState] == 0x2) {
                    r0 = [r22 item];
                    r0 = [r0 retain];
                    r23 = r0;
                    if ([r0 highlightState] == 0x1) {
                            r22 = 0x1;
                    }
                    [r23 release];
                    if (r21 != 0x0) {
                            [r20 release];
                    }
                    [r19 release];
                    r0 = r22;
            }
            else {
                    [r20 release];
                    [r19 release];
                    r0 = 0x1;
            }
    }
    else {
            r0 = [r22 item];
            r0 = [r0 retain];
            r23 = r0;
            if ([r0 highlightState] == 0x1) {
                    r22 = 0x1;
            }
            [r23 release];
            if (r21 != 0x0) {
                    [r20 release];
            }
            [r19 release];
            r0 = r22;
    }
    return r0;


// 0x10005d958
// -[IconViewBox drawRect:]
    {r2:r3:r4:r5} = arg2;
    r1 = _cmd;
    var_50 = d11;
    decomp_var_48 = d10;
    r31 = r31 + 0xffffffffffffffa0;
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
    d8 = d3;
    d9 = d2;
    d10 = d1;
    d11 = d0;
    r19 = self;
    if ([self isHighlighted] != 0x0) {
            r0 = [r19 pathForIconHighlight];
            r0 = [r0 retain];
            r21 = r0;
            if (NSIntersectsRect(NSInsetRect([r0 bounds], r1, r2), r1) != 0x0) {
                    [NSGraphicsContext saveGraphicsState];
                    if ([r19 hasDarkModeApppearance] != 0x0) {
                            r0 = [NSColor whiteColor];
                            r0 = [r0 retain];
                            r20 = r0;
                    }
                    else {
                            r0 = [NSColor blackColor];
                            r0 = [r0 retain];
                            r20 = r0;
                    }
                    r0 = [r0 colorWithAlphaComponent:r2];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 set];
                    [r22 release];
                    [r20 release];
                    [r21 fill];
                    [NSGraphicsContext restoreGraphicsState];
            }
            r20 = [[r19 pathForLabelHighlight] retain];
            [r21 release];
            if (NSIntersectsRect([r20 bounds], r1) != 0x0) {
                    [NSGraphicsContext saveGraphicsState];
                    r0 = [r19 window];
                    r0 = [r0 retain];
                    r21 = r0;
                    if (([r0 isKeyWindow] & 0x1) != 0x0) {
                            r0 = [r19 item];
                            r0 = [r0 retain];
                            r19 = r0;
                            r0 = [r0 collectionView];
                            r0 = [r0 retain];
                            r22 = r0;
                            r23 = [r0 isFirstResponder];
                            [r22 release];
                            [r19 release];
                            [r21 release];
                            if (r23 != 0x0) {
                                    r0 = [NSColor alternateSelectedControlColor];
                                    r0 = [r0 retain];
                            }
                            else {
                                    r0 = [NSColor secondarySelectedControlColor];
                                    r0 = [r0 retain];
                            }
                    }
                    else {
                            [r21 release];
                            r0 = [NSColor secondarySelectedControlColor];
                            r0 = [r0 retain];
                    }
                    [r0 set];
                    [r0 release];
                    [r20 fill];
                    [NSGraphicsContext restoreGraphicsState];
            }
            [r20 release];
    }
    return;


// 0x10005db94
// -[IconViewBox updateLabelTextColor]
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
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    if ([r0 isKeyWindow] != 0x0) {
            if (([r19 isHighlighted] & 0x1) != 0x0) {
                    r0 = [r19 item];
                    r0 = [r0 retain];
                    r21 = r0;
                    r0 = [r0 collectionView];
                    r0 = [r0 retain];
                    r22 = r0;
                    r23 = [r0 isFirstResponder];
                    [r22 release];
                    [r21 release];
                    [r20 release];
                    if (r23 != 0x0) {
                            r0 = [NSColor alternateSelectedControlTextColor];
                            r0 = [r0 retain];
                    }
                    else {
                            r0 = [NSColor controlTextColor];
                            r0 = [r0 retain];
                    }
            }
            else {
                    [r20 release];
                    r0 = [NSColor controlTextColor];
                    r0 = [r0 retain];
            }
    }
    else {
            [r20 release];
            r0 = [NSColor controlTextColor];
            r0 = [r0 retain];
    }
    r20 = r0;
    r0 = [r19 item];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 textField];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setTextColor:r20];
    [r21 release];
    [r19 release];
    [r20 release];
    return;


// 0x10005dca4
// -[IconViewBox viewDidMoveToWindow]
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
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r20 = [[NSNotificationCenter defaultCenter] retain];
            r22 = **_NSWindowDidBecomeKeyNotification;
            r23 = [[r19 window] retain];
            [r20 addObserver:r19 selector:@selector(keyStatusDidChange) name:r22 object:r23];
            [r23 release];
            r22 = **_NSWindowDidResignKeyNotification;
            r23 = [[r19 window] retain];
            [r20 addObserver:r19 selector:@selector(keyStatusDidChange) name:r22 object:r23];
            [r23 release];
            [r20 release];
    }
    return;


// 0x10005dda0
// -[IconViewBox viewWillMoveToWindow:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [arg2 retain];
    r21 = [[r19 window] retain];
    [r20 release];
    [r21 release];
    if (r21 != r20) {
            r20 = [[NSNotificationCenter defaultCenter] retain];
            r21 = **_NSWindowDidBecomeKeyNotification;
            r22 = [[r19 window] retain];
            [r20 removeObserver:r19 name:r21 object:r22];
            [r22 release];
            r21 = **_NSWindowDidResignKeyNotification;
            r22 = [[r19 window] retain];
            [r20 removeObserver:r19 name:r21 object:r22];
            [r22 release];
            [r20 release];
    }
    return;


// 0x10005dea0
// -[IconViewBox hasDarkModeApppearance]
    r31 = r31 - 0x50;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_28 = **___stack_chk_guard;
    r19 = [[self effectiveAppearance] retain];
    r8 = *_NSAppearanceNameAqua;
    r9 = *_NSAppearanceNameDarkAqua;
    r8 = *r8;
    r20 = *r9;
    var_38 = r8;
    r0 = [NSArray arrayWithObjects:&var_38 count:0x2];
    r21 = [r0 retain];
    r22 = [[r19 bestMatchFromAppearancesWithNames:r21] retain];
    [r21 release];
    [r19 release];
    r19 = [r22 isEqualToString:r20];
    r0 = [r22 release];
    if (**___stack_chk_guard != var_28) {
            __stack_chk_fail();
    }
    r0 = r19;
    return r0;


// 0x10005df84
// -[IconViewBox keyStatusDidChange]
    [self updateLabelTextColor];
    [self setNeedsDisplay:0x1];
    return;


// 0x10005dfac
// -[IconViewBox rightMouseDown:]
    var_50 = r28;
    decomp_var_48 = r27;
    r31 = r31 + 0xffffffffffffffa0;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r0 = [r20 item];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 isSelected];
    [r21 release];
    if ((r22 & 0x1) == 0x0) {
            r0 = [r20 item];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 collectionView];
            r0 = [r0 retain];
            r22 = r0;
            [r0 deselectAll:r20];
            [r22 release];
            [r21 release];
            r0 = [r20 item];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 collectionView] retain];
            r0 = [r20 item];
            r0 = [r0 retain];
            r24 = r0;
            r25 = [[r0 collectionView] retain];
            r26 = [[r20 item] retain];
            r27 = [[r25 indexPathForItem:r26] retain];
            r23 = [[NSSet setWithObject:r27] retain];
            [r22 selectItemsAtIndexPaths:r23 scrollPosition:0x0];
            [r23 release];
            [r27 release];
            [r26 release];
            [r25 release];
            [r24 release];
            [r22 release];
            [r21 release];
    }
    r0 = [r20 nextResponder];
    r0 = [r0 retain];
    r20 = r0;
    [r0 rightMouseDown:r19];
    [r19 release];
    [r20 release];
    return;


// 0x10005e15c
// -[IconViewBox auxField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_auxField);
    r0 = [r0 autorelease];
    return r0;


// 0x10005e17c
// -[IconViewBox setAuxField:]
    objc_storeWeak((int64_t *)&self->_auxField, arg2);
    return;


// 0x10005e190
// -[IconViewBox item]
    r0 = objc_loadWeakRetained((int64_t *)&self->_item);
    r0 = [r0 autorelease];
    return r0;


// 0x10005e1b0
// -[IconViewBox setItem:]
    objc_storeWeak((int64_t *)&self->_item, arg2);
    return;


// 0x10005e1c4
// -[IconViewBox .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_item);
    objc_destroyWeak((int64_t *)&self->_auxField);
    return;


