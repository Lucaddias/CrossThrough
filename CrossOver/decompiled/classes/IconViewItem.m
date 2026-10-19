// IconViewItem — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10005e1fc
// -[IconViewItem setRepresentedObject:]
    r31 = r31 - 0x60;
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
    r20 = [arg2 retain];
    var_50 = r19;
    r2 = r20;
    [[&var_50 super] setRepresentedObject:r2];
    r21 = [[r20 icon] retain];
    r20 = [r20 retain];
    objc_opt_class(@class(LauncherAppTreeNode));
    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
            r0 = [r20 launcher];
            r0 = [r0 retain];
            r22 = r0;
            [r0 helperVersion] > 0x2a;
            d8 = *0x10009dd68;
            [r22 release];
    }
    else {
            d8 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xd50);
    }
    r0 = [r19 imageView];
    r0 = [r0 retain];
    r22 = r0;
    [r0 frame];
    [r22 release];
    r0 = [r19 imageView];
    r0 = [r0 retain];
    r22 = r0;
    [r0 frame];
    [r22 release];
    r22 = [NSImage alloc];
    r0 = [r19 imageView];
    r0 = [r0 retain];
    r23 = r0;
    [r0 frame];
    r22 = [r22 initWithSize:r2];
    [r23 release];
    [r22 lockFocusFlipped:0x0];
    [r21 drawInRect:r2];
    [r22 unlockFocus];
    r0 = [r19 imageView];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setImage:r22];
    [r19 release];
    [r20 release];
    [r21 release];
    [r22 release];
    [r20 release];
    return;


// 0x10005e3e0
// -[IconViewItem setSelected:]
    var_20 = self;
    [[&var_20 super] setSelected:arg2];
    r0 = [self view];
    r0 = [r0 retain];
    r20 = r0;
    [r0 updateLabelTextColor];
    [r20 release];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setNeedsDisplay:0x1];
    [r19 release];
    return;


// 0x10005e464
// -[IconViewItem setHighlightState:]
    var_20 = self;
    [[&var_20 super] setHighlightState:arg2];
    r0 = [self view];
    r0 = [r0 retain];
    r20 = r0;
    [r0 updateLabelTextColor];
    [r20 release];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setNeedsDisplay:0x1];
    [r19 release];
    return;


// 0x10005e4e8
// -[IconViewItem draggingImageComponents]
    r31 = r31 - 0x70;
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
    r20 = self;
    var_60 = self;
    r0 = [[&var_60 super] draggingImageComponents];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [r0 mutableCopy];
    [r21 release];
    r0 = [r20 textField];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 stringValue];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 length];
    [r22 release];
    [r21 release];
    if (r23 != 0x0) {
            r0 = [r20 textField];
            r0 = [r0 retain];
            r21 = r0;
            NSInsetRect([r0 frame], r1, r2);
            [r21 release];
            r0 = [r20 view];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 bitmapImageRepForCachingDisplayInRect:r2] retain];
            [r22 release];
            r0 = [r20 view];
            r0 = [r0 retain];
            r22 = r0;
            [r0 cacheDisplayInRect:r21 toBitmapImageRep:r3];
            [r22 release];
            r22 = [NSImage alloc];
            [r21 size];
            r0 = [r22 initWithSize:r2];
            r22 = r0;
            [r0 addRepresentation:r21];
            r0 = [NSDraggingImageComponent draggingImageComponentWithKey:**_NSDraggingImageComponentLabelKey];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 setContents:r22];
            d0 = d8;
            d1 = d9;
            d2 = d10;
            d3 = d11;
            NSOffsetRect(r0, r1, r2);
            [r23 setFrame:r2];
            r0 = [r19 indexOfObjectPassingTest:___block_literal_global];
            if (r0 == 0x7fffffffffffffff) {
                    r2 = r23;
                    [r19 addObject:r2];
            }
            else {
                    r2 = r0;
                    r3 = r23;
                    [r19 replaceObjectAtIndex:r2 withObject:r3];
            }
            [r23 release];
            [r22 release];
            [r21 release];
    }
    r0 = [r20 view];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 auxField] retain];
    [r22 release];
    if (r21 != 0x0) {
            if (([r21 isHiddenOrHasHiddenAncestor] & 0x1) == 0x0) {
                    r0 = [r21 stringValue];
                    r0 = [r0 retain];
                    r22 = r0;
                    r23 = [r0 length];
                    [r22 release];
                    if (r23 != 0x0) {
                            [r21 bounds];
                            r22 = [[r21 bitmapImageRepForCachingDisplayInRect:r2] retain];
                            [r21 cacheDisplayInRect:r22 toBitmapImageRep:r3];
                            r23 = [NSImage alloc];
                            [r22 size];
                            r0 = [r23 initWithSize:r2];
                            r23 = r0;
                            [r0 addRepresentation:r22];
                            r0 = [NSDraggingImageComponent draggingImageComponentWithKey:@"Aux Label"];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 setContents:r23];
                            r0 = [r20 view];
                            r0 = [r0 retain];
                            r20 = r0;
                            NSOffsetRect([r0 convertRect:r21 fromView:r3], r1, r2);
                            [r24 setFrame:r2];
                            [r20 release];
                            [r19 addObject:r24];
                            [r24 release];
                            [r23 release];
                            [r22 release];
                    }
            }
    }
    [r21 release];
    r0 = [r19 autorelease];
    return r0;


