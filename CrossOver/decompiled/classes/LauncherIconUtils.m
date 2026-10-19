// LauncherIconUtils — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100044b04
// +[LauncherIconUtils imageRepsForCXMenuIconsFromURL:]
    r31 = r31 - 0x180;
    var_50 = r28;
    decomp_var_48 = r27;
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
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r0 = [NSMutableArray arrayWithCapacity:0x7];
    r0 = [r0 retain];
    r22 = r0;
    [r0 addObject:r19];
    r0 = [r19 pathComponents];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 mutableCopy];
    [r20 release];
    var_108 = *__NSConcreteStackBlock;
    r0 = [r21 retain];
    r20 = r0;
    var_E8 = r0;
    r0 = [r0 indexOfObjectWithOptions:0x2 passingTest:&var_108];
    if (r0 != 0x7fffffffffffffff) {
            r21 = r0;
            r26 = 0x0;
            do {
                    r24 = [[NSString stringWithFormat:@"%ix%i", r3, r4] retain];
                    [r20 replaceObjectAtIndex:r21 withObject:r24];
                    [r24 release];
                    r24 = [[NSURL fileURLWithPathComponents:r20] retain];
                    if (([r19 isEqual:r24] & 0x1) == 0x0) {
                            [r22 addObject:r24];
                    }
                    r26 = r26 + 0x4;
                    [r24 release];
            } while (r26 != 0x1c);
    }
    var_158 = r19;
    r21 = [[NSMutableArray arrayWithCapacity:[r22 count]] retain];
    var_150 = q0;
    var_140 = q0;
    r0 = [r22 retain];
    r22 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r26 = *var_140;
            do {
                    r19 = 0x0;
                    do {
                            if (*var_140 != r26) {
                                    objc_enumerationMutation(r22);
                            }
                            r0 = [NSData dataWithContentsOfURL:*(var_148 + r19 * 0x8)];
                            r0 = [r0 retain];
                            r24 = r0;
                            if (r0 != 0x0) {
                                    r0 = [NSBitmapImageRep imageRepWithData:r24];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    if (r0 != 0x0) {
                                            [r21 addObject:r25];
                                    }
                                    [r25 release];
                            }
                            [r24 release];
                            r19 = r19 + 0x1;
                    } while (r23 != r19);
                    r0 = [r22 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r22 release];
    [var_E8 release];
    [r20 release];
    [r22 release];
    r0 = [var_158 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [r21 autorelease];
    return r0;


// 0x100044e8c
// +[LauncherIconUtils percentOfNonTransparentPixelsAlongEdgeOfImageRep:]
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
    r19 = [arg2 retain];
    r0 = calloc(0x800000, 0x1);
    if (r0 != 0x0) {
            r20 = r0;
            r21 = CGBitmapContextCreate(r0, 0x400, 0x400, 0x8, 0x2000, 0x0, 0x7);
            r22 = [[NSGraphicsContext graphicsContextWithCGContext:r21 flipped:0x0] retain];
            [NSGraphicsContext setCurrentContext:r22];
            [r22 release];
            r0 = [NSColor whiteColor];
            r0 = [r0 retain];
            r22 = r0;
            [r0 set];
            NSFrameRectWithWidth([r22 release], r1);
            d0 = 0x0;
            [r19 drawInRect:0x7 fromRect:0x1 operation:0x0 fraction:r5 respectFlipped:r6 hints:r7];
            [NSGraphicsContext setCurrentContext:0x0];
            r8 = 0x0;
            r11 = 0x0;
            r9 = r20;
            do {
                    r10 = 0x0;
                    v0 = 0x0;
                    v1 = r11;
                    v3 = 0x0;
                    v2 = 0x0;
                    v6 = 0x0;
                    v4 = 0x0;
                    v7 = 0x0;
                    v5 = 0x0;
                    do {
                            asm { cmtst      v16.16b, v16.16b, v16.16b };
                            asm { ushll      v17.8h, v16.8b, #0x0 };
                            asm { ushll      v18.4s, v17.4h, #0x0 };
                            asm { dup        v19.2d, x22 };
                            asm { ushll      v20.2d, v18.2s, #0x0 };
                            v20 = v20 & v19;
                            asm { ushll2     v18.2d, v18.4s, #0x0 };
                            v18 = v18 & v19;
                            asm { ushll2     v17.4s, v17.8h, #0x0 };
                            asm { ushll      v21.2d, v17.2s, #0x0 };
                            v21 = v21 & v19;
                            asm { ushll2     v16.8h, v16.16b, #0x0 };
                            asm { ushll      v22.4s, v16.4h, #0x0 };
                            asm { ushll      v23.2d, v22.2s, #0x0 };
                            v23 = v23 & v19;
                            asm { ushll2     v17.2d, v17.4s, #0x0 };
                            v17 = v17 & v19;
                            asm { ushll2     v22.2d, v22.4s, #0x0 };
                            v22 = v22 & v19;
                            asm { ushll2     v16.4s, v16.8h, #0x0 };
                            asm { ushll      v24.2d, v16.2s, #0x0 };
                            v24 = v24 & v19;
                            asm { ushll2     v16.2d, v16.4s, #0x0 };
                            v16 = v16 & v19;
                            v5 = v5 + v16;
                            v7 = v7 + v24;
                            v4 = v4 + v22;
                            v2 = v2 + v17;
                            v6 = v6 + v23;
                            v3 = v3 + v21;
                            v0 = v0 + v18;
                            v1 = v1 + v20;
                            r10 = r10 + 0x10;
                    } while (r10 != 0x400);
                    asm { addp       d0, v0.2d };
                    r11 = d0;
                    r8 = r8 + 0x1;
                    r9 = r9 + 0x2000;
            } while (r8 != 0x400);
            d8 = r11 / *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xcd0);
            CGContextRelease(r21);
            free(r20);
    }
    else {
            d8 = 0x0;
    }
    r0 = [r19 release];
    return r0;


// 0x1000450f8
// +[LauncherIconUtils maskIconToRoundRect:destinationDimension:]
    r1 = _cmd;
    r31 = r31 - 0xf0;
    var_A0 = d15;
    decomp_var_98 = d14;
    var_90 = d13;
    decomp_var_88 = d12;
    var_80 = d11;
    decomp_var_78 = d10;
    var_70 = d9;
    decomp_var_68 = d8;
    var_60 = r28;
    decomp_var_58 = r27;
    var_50 = r26;
    decomp_var_48 = r25;
    var_40 = r24;
    decomp_var_38 = r23;
    var_30 = r22;
    decomp_var_28 = r21;
    var_20 = r20;
    decomp_var_18 = r19;
    var_10 = r29;
    decomp_var_8 = r30;
    r20 = arg3;
    var_A8 = **___stack_chk_guard;
    r22 = [arg2 retain];
    r2 = r22;
    r0 = [self percentOfNonTransparentPixelsAlongEdgeOfImageRep:r2];
    d1 = d0;
    d2 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xcd8);
    d0 = 0x4059000000000000;
    if (d1 > *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbd8)) {
            bool_1 = d1 >= *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xbc0);
            d1 = d0;
            d3 = d2;
            if (!bool_1) {
                    d0 = 0x4059000000000000;
                    d2 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xcd8);
                    d1 = 0x4059000000000000;
                    d3 = d2;
                    NSInsetRect(r0, r1, r2);
            }
    }
    else {
            d1 = d0;
            d3 = d2;
    }
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r19 = [[r0 imageForResource:@"app-icon-roundrect-mask"] retain];
    [r21 release];
    r0 = [NSBitmapImageRep alloc];
    r27 = *_NSDeviceRGBColorSpace;
    r21 = [r0 initWithBitmapDataPlanes:0x0 pixelsWide:r20 pixelsHigh:r20 bitsPerSample:0x8 samplesPerPixel:0x4 hasAlpha:0x1 isPlanar:0x0 colorSpaceName:*r27 bitmapFormat:0x0 bytesPerRow:0x0 bitsPerPixel:0x0];
    r23 = [[NSGraphicsContext graphicsContextWithBitmapImageRep:r21] retain];
    [NSGraphicsContext setCurrentContext:r23];
    [r23 release];
    [r19 drawInRect:r2];
    var_B8 = **_NSImageHintInterpolation;
    r0 = @(0x3);
    r0 = [r0 retain];
    r23 = r0;
    var_B0 = r0;
    r0 = [NSDictionary dictionaryWithObjects:&var_B0 forKeys:&var_B8 count:0x1];
    r24 = [r0 retain];
    [r22 drawInRect:0x3 fromRect:0x1 operation:r24 fraction:r5 respectFlipped:r6 hints:r7];
    [r22 release];
    [r24 release];
    [r23 release];
    [NSGraphicsContext setCurrentContext:0x0];
    r20 = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:0x0 pixelsWide:r20 pixelsHigh:r20 bitsPerSample:0x8 samplesPerPixel:0x4 hasAlpha:0x1 isPlanar:0x0 colorSpaceName:*r27 bitmapFormat:0x0 bytesPerRow:0x0 bitsPerPixel:0x0];
    r22 = [[NSGraphicsContext graphicsContextWithBitmapImageRep:r20] retain];
    [NSGraphicsContext setCurrentContext:r22];
    [r22 release];
    r0 = objc_opt_new();
    r22 = r0;
    [r0 setShadowOffset:r2];
    [r22 setShadowBlurRadius:r2];
    [NSGraphicsContext saveGraphicsState];
    [r22 set];
    [r19 drawInRect:r2];
    [NSGraphicsContext restoreGraphicsState];
    [r21 drawInRect:0x2 fromRect:0x1 operation:0x0 fraction:r5 respectFlipped:r6 hints:r7];
    [NSGraphicsContext setCurrentContext:0x0];
    [r22 release];
    [r21 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_A8) {
            __stack_chk_fail();
    }
    r0 = [r20 autorelease];
    return r0;


// 0x1000454dc
// +[LauncherIconUtils createIcnsFileAtURL:fromImageReps:forApp:]
    r31 = r31 - 0x130;
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
    var_48 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    if (arg4 != 0x0) {
            r0 = CGImageDestinationCreateWithURL(r19, **_kUTTypeAppleICNS, 0x2, 0x0);
            if (r0 != 0x0) {
                    r21 = r0;
                    r0 = [r20 sortedArrayUsingSelector:@selector(pixelsHigh)];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [[r0 lastObject] retain];
                    r0 = [r22 maskIconToRoundRect:r24 destinationDimension:0x200];
                    r0 = [r0 retain];
                    r25 = r0;
                    CGImageDestinationAddImage(r21, [r0 CGImageForProposedRect:0x0 context:0x0 hints:0x0], 0x0);
                    [r25 release];
                    r0 = [r22 maskIconToRoundRect:r24 destinationDimension:0x100];
                    r0 = [r0 retain];
                    r22 = r0;
                    r1 = [r0 CGImageForProposedRect:0x0 context:0x0 hints:0x0];
                    CGImageDestinationAddImage(r21, r1, 0x0);
                    [r22 release];
                    [r24 release];
                    r0 = r23;
                    [r0 release];
                    r0 = CGImageDestinationFinalize(r21);
                    r22 = r0;
                    if ((r0 & 0x1) == 0x0) {
                            NSLog(@"Failed to finalize ICNS file %@", r1);
                    }
                    CFRelease(r21);
            }
            else {
                    NSLog(@"Couldn't create CGImageDestination\n");
                    r22 = 0x0;
            }
    }
    else {
            r21 = **_kUTTypeAppleICNS;
            r0 = [r20 count];
            r1 = r21;
            r0 = CGImageDestinationCreateWithURL(r19, r1, r0, 0x0);
            if (r0 != 0x0) {
                    r21 = r0;
                    var_110 = q0;
                    var_100 = q0;
                    r0 = [r20 retain];
                    r22 = r0;
                    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    if (r0 != 0x0) {
                            r23 = r0;
                            r24 = *var_100;
                            do {
                                    r25 = 0x0;
                                    do {
                                            if (*var_100 != r24) {
                                                    objc_enumerationMutation(r22);
                                            }
                                            r1 = [*(var_108 + r25 * 0x8) CGImageForProposedRect:0x0 context:0x0 hints:0x0];
                                            CGImageDestinationAddImage(r21, r1, 0x0);
                                            r25 = r25 + 0x1;
                                    } while (r23 != r25);
                                    r0 = [r22 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                                    r23 = r0;
                            } while (r0 != 0x0);
                    }
                    r0 = r22;
                    [r0 release];
                    r0 = CGImageDestinationFinalize(r21);
                    r22 = r0;
                    if ((r0 & 0x1) == 0x0) {
                            NSLog(@"Failed to finalize ICNS file %@", r1);
                    }
                    CFRelease(r21);
            }
            else {
                    NSLog(@"Couldn't create CGImageDestination\n");
                    r22 = 0x0;
            }
    }
    [r20 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    r0 = r22;
    return r0;


// === Block Invocations for LauncherIconUtils ===

// 0x100044dec
// ___52+[LauncherIconUtils imageRepsForCXMenuIconsFromURL:]_block_invoke
    r0 = arg0;
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg2;
    r2 = arg2 - 0x2;
    if (r2 < 0x0) {
            r20 = 0x0;
    }
    else {
            r21 = r0;
            r0 = r0[0x4];
            r0 = [r0 objectAtIndexedSubscript:r2];
            r0 = [r0 retain];
            r19 = r0;
            if ([r0 isEqualToString:@"icons"] != 0x0) {
                    r0 = r21[0x4];
                    r0 = [r0 objectAtIndexedSubscript:r20 - 0x1];
                    r0 = [r0 retain];
                    r21 = r0;
                    r20 = [r0 isEqualToString:@"hicolor"];
                    [r21 release];
            }
            else {
                    r20 = 0x0;
            }
            [r19 release];
    }
    r0 = r20;
    return r0;


