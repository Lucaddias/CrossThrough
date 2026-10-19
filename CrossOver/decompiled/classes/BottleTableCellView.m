// BottleTableCellView — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100059604
// -[BottleTableCellView dealloc]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if (*(int8_t *)(self + sign_extend_64(*(int32_t *)ivar_offset(_observing))) != 0x0) {
            [r19 removeObserver:r19 forKeyPath:@"objectValue.bottle.isDefault" context:_BottleTableCellViewKVOContext];
    }
    var_20 = r19;
    [[&var_20 super] dealloc];
    return;


// 0x100059670
// -[BottleTableCellView awakeFromNib]
    r0 = [NSTrackingArea alloc];
    r20 = [r0 initWithRect:0x241 options:self owner:0x0 userInfo:r5];
    [self addTrackingArea:r20];
    [self addObserver:self forKeyPath:@"objectValue.bottle.isDefault" options:0x0 context:_BottleTableCellViewKVOContext];
    *(int8_t *)(int64_t *)&self->_observing = 0x1;
    [r20 release];
    return;


// 0x1000596fc
// -[BottleTableCellView setBackgroundStyle:]
    var_30 = self;
    [[&var_30 super] setBackgroundStyle:r2];
    r0 = [self textField];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 cell];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setBackgroundStyle:arg2];
    [r22 release];
    [r21 release];
    r0 = [self needsUpgradeButton];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 cell];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setBackgroundStyle:arg2];
    [r21 release];
    [r20 release];
    return;


// 0x1000597c0
// -[BottleTableCellView updateTextField]
    r31 = r31 - 0x80;
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
    r19 = self;
    r0 = [self objectValue];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 bottle];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [r0 isIsDefault];
    [r22 release];
    [r20 release];
    r0 = [r19 textField];
    r0 = [r0 retain];
    r22 = r0;
    r20 = [[r0 cell] retain];
    [r22 release];
    r22 = [[NSFontManager sharedFontManager] retain];
    r23 = [[r20 font] retain];
    if (r21 == 0x0) {
            r3 = 0x4;
    }
    else {
            r3 = 0x2;
    }
    r24 = [[r22 convertFont:r23 toHaveTrait:r3] retain];
    [r20 setFont:r24];
    [r24 release];
    [r23 release];
    [r22 release];
    r0 = [r19 textField];
    r0 = [r0 retain];
    r23 = r0;
    r22 = [[r0 objectValue] retain];
    [r23 release];
    objc_opt_class(@class(NSAttributedString));
    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
            r0 = [r22 mutableCopy];
            r23 = r0;
            r24 = **_NSFontAttributeName;
            r25 = [r0 length];
            r0 = [r23 retain];
            r21 = r0;
            [r0 enumerateAttribute:r24 inRange:0x0 options:r25 usingBlock:0x100000];
            r0 = [r19 textField];
            r0 = [r0 retain];
            r19 = r0;
            [r0 setAttributedStringValue:r21];
            [r19 release];
            [r23 release];
            [r21 release];
    }
    [r22 release];
    [r20 release];
    return;


// 0x100059a90
// -[BottleTableCellView viewWillDraw]
    var_20 = self;
    [[&var_20 super] viewWillDraw];
    [self updateTextField];
    return;


// 0x100059ad8
// -[BottleTableCellView observeValueForKeyPath:ofObject:change:context:]
    r5 = arg5;
    r4 = arg4;
    r3 = arg3;
    r2 = arg2;
    r0 = self;
    if (r5 != _BottleTableCellViewKVOContext) {
            var_20 = r0;
            [[&var_20 super] observeValueForKeyPath:r2 ofObject:r3 change:r4 context:r5];
    }
    else {
            [r0 updateTextField];
    }
    return;


// 0x100059b20
// -[BottleTableCellView needsUpgradeButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_needsUpgradeButton);
    r0 = [r0 autorelease];
    return r0;


// 0x100059b40
// -[BottleTableCellView setNeedsUpgradeButton:]
    objc_storeWeak((int64_t *)&self->_needsUpgradeButton, arg2);
    return;


// 0x100059b54
// -[BottleTableCellView .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_needsUpgradeButton);
    return;


// === Block Invocations for BottleTableCellView ===

// 0x1000599d8
// ___38-[BottleTableCellView updateTextField]_block_invoke
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg3;
    r20 = arg2;
    r21 = arg0;
    r23 = [arg1 retain];
    r0 = [NSFontManager sharedFontManager];
    r0 = [r0 retain];
    r22 = r0;
    if (r21[0x28] != 0x0) {
            r3 = 0x2;
    }
    else {
            r3 = 0x4;
    }
    r24 = [[r0 convertFont:r23 toHaveTrait:r3] retain];
    [r23 release];
    [r22 release];
    [r21[0x4] addAttribute:**_NSFontAttributeName value:r24 range:r20];
    r0 = [r24 release];
    return r0;


