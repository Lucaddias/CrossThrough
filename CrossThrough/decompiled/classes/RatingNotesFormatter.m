// RatingNotesFormatter — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001262c
// -[RatingNotesFormatter stringForObjectValue:]
    r0 = objc_retainAutoreleaseReturnValue(arg2);
    return r0;


// 0x100012634
// -[RatingNotesFormatter getObjectValue:forString:errorDescription:]
    *arg2 = [[arg3 copy] autorelease];
    return 0x1;


// 0x100012664
// -[RatingNotesFormatter isPartialStringValid:proposedSelectedRange:originalString:originalSelectedRange:errorDescription:]
    {r5:r6} = arg5;
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
    r23 = r6;
    r24 = r5;
    r20 = arg3;
    r21 = arg2;
    r22 = self;
    r19 = [arg4 retain];
    if ([r22 maxLength] != 0x0 && [*r21 length] >= [r22 maxLength]) {
            r25 = [r22 maxLength];
            r26 = [r19 length];
            r0 = *r21;
            r0 = [r0 mutableCopy];
            r27 = r0;
            [r0 length] - [r22 maxLength];
            [r27 deleteCharactersInRange:r24 + r23 + r25 - r26];
            r0 = objc_retainAutorelease(r27);
            *r21 = r0;
            *r20 = r24 + r23 + r25 - r26;
            r20[0x1] = 0x0;
            [r0 release];
            r20 = 0x0;
    }
    else {
            r20 = 0x1;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100012760
// -[RatingNotesFormatter maxLength]
    r0 = self->_maxLength;
    return r0;


// 0x100012770
// -[RatingNotesFormatter setMaxLength:]
    self->_maxLength = arg2;
    return;


