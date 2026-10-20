// DebugChannelFormatter — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100030a3c
// -[DebugChannelFormatter stringForObjectValue:]
    r0 = [arg2 description];
    return r0;


// 0x100030a44
// -[DebugChannelFormatter getObjectValue:forString:errorDescription:]
    *arg2 = [[arg3 copy] autorelease];
    return 0x1;


// 0x100030a74
// +[DebugChannelFormatter sanitizePartialString:]
    r1 = _cmd;
    var_40 = r26;
    decomp_var_38 = r25;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    if (*_sanitizePartialString:.onceToken != -0x1) {
            r1 = ___block_literal_global;
            dispatch_once(_sanitizePartialString:.onceToken, ___block_literal_global);
    }
    r0 = [r19 mutableCopy];
    r20 = r0;
    r23 = [r0 length];
    r22 = 0x0;
    while (true) {
            r24 = [[NSCharacterSet newlineCharacterSet] retain];
            r22 = [r20 rangeOfCharacterFromSet:r24 options:0x0 range:r22];
            r23 = r1;
            [r24 release];
            asm { ccmp       x23, #0x0, #0x4, ne };
            if (asm { ccmp       x23, #0x0, #0x4, ne }) {
                    break;
            }
            [r20 replaceCharactersInRange:r22 withString:r23];
            r22 = r22 + 0x1;
            r23 = [r20 length] - r22;
    }
    do {
            [r20 length];
    } while ([r20 replaceOccurrencesOfString:@",," withString:@"," options:0x0 range:0x0] != 0x0);
    r21 = [[r20 stringByRemovingCharactersInSet:*_sanitizePartialString:.invalidCharacters] retain];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x100030c64
// +[DebugChannelFormatter sanitizeChannelString:]
    r0 = [self sanitizePartialString:arg2];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [r0 mutableCopy];
    [r20 release];
    [r19 length];
    [r19 replaceOccurrencesOfString:@" +" withString:@" " options:0x400 range:0x0];
    [r19 length];
    [r19 replaceOccurrencesOfString:@" " withString:@"" options:0x8 range:0x0];
    [r19 length];
    [r19 replaceOccurrencesOfString:@" " withString:@"" options:0xc range:0x0];
    [r19 length];
    [r19 replaceOccurrencesOfString:@" ?([,:]) ?" withString:@"$1" options:0x400 range:0x0];
    [r19 length];
    [r19 replaceOccurrencesOfString:@"," withString:@"" options:0x8 range:0x0];
    [r19 length];
    [r19 replaceOccurrencesOfString:@"," withString:@"" options:0xc range:0x0];
    r0 = [r19 autorelease];
    return r0;


// 0x100030da4
// -[DebugChannelFormatter isPartialStringValid:proposedSelectedRange:originalString:originalSelectedRange:errorDescription:]
    {r5:r6} = arg5;
    r31 = r31 - 0xb0;
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
    var_68 = arg6;
    r26 = r6;
    r25 = r5;
    r22 = arg3;
    r24 = arg2;
    var_90 = _cmd;
    r27 = self;
    r21 = [arg4 retain];
    r20 = [[NSMutableString string] retain];
    r19 = [*r24 length];
    var_60 = r21;
    r0 = [r21 length];
    var_70 = r26;
    r19 = (r26 - r0) + r19;
    r26 = *r22;
    var_78 = r22[0x1];
    var_58 = r24;
    if (r25 != 0x0) {
            r21 = objc_opt_class(r27);
            r24 = [[*r24 substringToIndex:r25] retain];
            r28 = [[r21 sanitizePartialString:r24] retain];
            [r24 release];
            r21 = r26 - r25;
            if (r21 >= 0x0) {
                    r26 = r21 + [r28 length];
            }
            [r20 appendString:r28];
    }
    else {
            r28 = 0x0;
    }
    r24 = objc_opt_class(r27);
    r23 = var_58;
    var_88 = r19 + r25;
    r21 = [[*r23 substringFromIndex:r19 + r25] retain];
    r0 = [r24 sanitizePartialString:r21];
    r24 = r19;
    r19 = [r0 retain];
    [r21 release];
    if (r24 != 0x0) {
            var_80 = r27;
            r21 = objc_opt_class(r27);
            var_98 = r24;
            r23 = [[*r23 substringWithRange:r25] retain];
            r24 = [[r21 sanitizePartialString:r23] retain];
            [r28 release];
            [r23 release];
            if ([r24 length] != 0x0) {
                    r23 = var_80;
                    r27 = r19;
                    if ([r20 length] != 0x0) {
                            r19 = var_70;
                            if ([r24 characterAtIndex:0x0] == 0x2c && [r20 characterAtIndex:[r20 length] - 0x1] == 0x2c) {
                                    r21 = [[r24 substringFromIndex:0x1] retain];
                                    [r24 release];
                                    r24 = r21;
                            }
                    }
                    else {
                            r19 = var_70;
                    }
            }
            else {
                    r23 = var_80;
                    r27 = r19;
                    r19 = var_70;
            }
            if ([r24 length] != 0x0 && [r27 length] != 0x0 && [r24 characterAtIndex:[r24 length] - 0x1] == 0x2c) {
                    if ([r27 characterAtIndex:0x0] == 0x2c) {
                            r21 = [[r24 substringToIndex:[r24 length] - 0x1] retain];
                            [r24 release];
                            r24 = r21;
                    }
            }
            if ([r24 length] == 0x0) {
                    if (r19 != 0x0) {
                            r19 = [[var_60 substringWithRange:r25] retain];
                            [r24 release];
                            r26 = [r20 length];
                            r25 = [r19 length];
                            r24 = r19;
                    }
                    else {
                            r8 = *r22;
                            if (r8 < var_88) {
                                    r9 = r22[0x1];
                                    if (r8 == r25) {
                                            r21 = 0x1;
                                    }
                                    if (r9 != var_98) {
                                            r19 = [r20 length];
                                            r0 = [r24 length];
                                            bool_39 = (r21 & r23) != 0x0;
                                            bool_38 = (r21 & r23) != 0x0;
                                            bool_37 = (r21 & r23) != 0x0;
                                            r23 = var_80;
                                            if (!bool_37) {
                                                    r8 = r0;
                                                    r26 = r19 + r8;
                                                    if (!bool_38) {
                                                            r25 = 0x0;
                                                    }
                                                    else {
                                                            r25 = r0;
                                                    }
                                            }
                                            else {
                                                    r26 = r19 + 0x0;
                                                    if (!bool_39) {
                                                            r25 = 0x0;
                                                    }
                                                    else {
                                                            r25 = r0;
                                                    }
                                            }
                                    }
                                    else {
                                            r19 = [r20 length];
                                            r0 = [r24 length];
                                            bool_42 = (r21 & 0x1) != 0x0;
                                            bool_41 = (r21 & 0x1) != 0x0;
                                            r23 = var_80;
                                            if ((r21 & 0x1) == 0x0) {
                                                    r8 = r0;
                                                    r26 = r19 + r8;
                                                    if (!bool_41) {
                                                            r25 = 0x0;
                                                    }
                                                    else {
                                                            r25 = r0;
                                                    }
                                            }
                                            else {
                                                    r26 = r19 + 0x0;
                                                    if (!bool_42) {
                                                            r25 = 0x0;
                                                    }
                                                    else {
                                                            r25 = r0;
                                                    }
                                            }
                                    }
                            }
                            else {
                                    r26 = (r26 - var_98) + [r24 length];
                                    r25 = var_78;
                            }
                    }
            }
            else {
                    r8 = *r22;
                    if (r8 < var_88) {
                            r9 = r22[0x1];
                            if (r8 != r25) {
                                    if (r9 != var_98) {
                                            r19 = [r20 length];
                                            r0 = [r24 length];
                                            bool_31 = (r21 & r23) != 0x0;
                                            bool_30 = (r21 & r23) != 0x0;
                                            bool_24 = (r21 & r23) != 0x0;
                                            r23 = var_80;
                                            if (!bool_30) {
                                                    r8 = r0;
                                                    r26 = r19 + r8;
                                                    if (!bool_31) {
                                                            r25 = 0x0;
                                                    }
                                                    else {
                                                            r25 = r0;
                                                    }
                                            }
                                            else {
                                                    r26 = r19 + 0x0;
                                                    if (!bool_24) {
                                                            r25 = 0x0;
                                                    }
                                                    else {
                                                            r25 = r0;
                                                    }
                                            }
                                    }
                                    else {
                                            r19 = [r20 length];
                                            r0 = [r24 length];
                                            bool_32 = (r21 & 0x1) != 0x0;
                                            r23 = var_80;
                                            if ((r21 & 0x1) == 0x0) {
                                                    r8 = r0;
                                            }
                                            else {
                                                    r8 = 0x0;
                                            }
                                            r26 = r19 + r8;
                                            if (!bool_32) {
                                                    r25 = 0x0;
                                            }
                                            else {
                                                    r25 = r0;
                                            }
                                    }
                            }
                            else {
                                    if (r9 == var_98) {
                                            r23 = 0x1;
                                    }
                                    r19 = [r20 length];
                                    r0 = [r24 length];
                                    bool_35 = (0x1 & r23) != 0x0;
                                    bool_34 = (0x1 & r23) != 0x0;
                                    bool_33 = (0x1 & r23) != 0x0;
                                    r23 = var_80;
                                    if (!bool_33) {
                                            r8 = r0;
                                            r26 = r19 + r8;
                                            if (!bool_34) {
                                                    r25 = 0x0;
                                            }
                                            else {
                                                    r25 = r0;
                                            }
                                    }
                                    else {
                                            r26 = r19 + 0x0;
                                            if (!bool_35) {
                                                    r25 = 0x0;
                                            }
                                            else {
                                                    r25 = r0;
                                            }
                                    }
                            }
                    }
                    else {
                            r26 = (r26 - var_98) + [r24 length];
                            r25 = var_78;
                    }
            }
            [r20 appendString:r24];
            r28 = r24;
            r24 = var_58;
    }
    else {
            r24 = r23;
            r23 = r27;
            r25 = var_78;
            r27 = r19;
    }
    [r20 appendString:r27];
    r21 = r25 + r26;
    if (r21 > [r20 length]) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r19 = r0;
            [r0 handleFailureInMethod:var_90 object:r23 file:@"DebugChannelFormatter.m" lineNumber:0x99 description:@"new selection range extends beyond end of new string"];
            [r19 release];
    }
    r19 = [r20 length];
    r0 = [r20 length];
    if (r26 >= r19) {
            r25 = 0x0;
            r26 = r0;
    }
    else {
            if (r21 >= r0) {
                    r25 = [r20 length] - r26;
            }
    }
    if (r26 == *r22) {
            if (r25 == r22[0x1]) {
                    if (([r20 isEqualToString:*r24] & 0x1) != 0x0) {
                            r19 = 0x1;
                    }
                    else {
                            *r24 = objc_retainAutorelease(r20);
                            *r22 = r26;
                            r22[0x1] = r25;
                            r8 = var_68;
                            if (r8 != 0x0) {
                                    r19 = 0x0;
                                    *r8 = 0x0;
                            }
                            else {
                                    r19 = 0x0;
                            }
                    }
            }
            else {
                    *r24 = objc_retainAutorelease(r20);
                    *r22 = r26;
                    r22[0x1] = r25;
                    r8 = var_68;
                    if (r8 != 0x0) {
                            r19 = 0x0;
                            *r8 = 0x0;
                    }
                    else {
                            r19 = 0x0;
                    }
            }
    }
    else {
            *r24 = objc_retainAutorelease(r20);
            *r22 = r26;
            r22[0x1] = r25;
            r8 = var_68;
            if (r8 != 0x0) {
                    r19 = 0x0;
                    *r8 = 0x0;
            }
            else {
                    r19 = 0x0;
            }
    }
    [r27 release];
    [r28 release];
    [r20 release];
    [var_60 release];
    r0 = r19;
    return r0;


// === Block Invocations for DebugChannelFormatter ===

// 0x100030bd8
// ___47+[DebugChannelFormatter sanitizePartialString:]_block_invoke
    r0 = [[NSMutableCharacterSet alloc] init];
    r19 = r0;
    [r0 addCharactersInRange:0x41];
    [r19 addCharactersInRange:0x61];
    [r19 addCharactersInRange:0x30];
    [r19 addCharactersInString:@"_,+-:. "];
    r0 = [r19 invertedSet];
    r0 = [r0 retain];
    r8 = *_sanitizePartialString:.invalidCharacters;
    *_sanitizePartialString:.invalidCharacters = r0;
    [r8 release];
    [r19 release];
    return;


