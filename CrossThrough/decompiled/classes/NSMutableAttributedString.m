// NSMutableAttributedString — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003763c
// +[NSMutableAttributedString cx_attributedStringWithHTML:font:]
    r31 = r31 - 0x60;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_38 = **___stack_chk_guard;
    r20 = [arg3 retain];
    r19 = [[arg2 dataUsingEncoding:0x4] retain];
    r21 = [NSMutableAttributedString alloc];
    var_48 = **_NSCharacterEncodingDocumentOption;
    r0 = @(0x4);
    r0 = [r0 retain];
    r22 = r0;
    var_40 = r0;
    r0 = [NSDictionary dictionaryWithObjects:&var_40 forKeys:&var_48 count:0x1];
    r23 = [r0 retain];
    r2 = r19;
    r21 = [r21 initWithHTML:r2 options:r23 documentAttributes:0x0];
    [r23 release];
    [r22 release];
    if (r20 == 0x0) {
            [NSFont systemFontSize];
            r20 = [[NSFont systemFontOfSize:r2] retain];
    }
    r22 = **_NSForegroundColorAttributeName;
    r23 = [[NSColor labelColor] retain];
    [r21 length];
    [r21 addAttribute:r22 value:r23 range:0x0];
    [r23 release];
    r22 = **_NSFontAttributeName;
    [r21 length];
    [r21 addAttribute:r22 value:r20 range:0x0];
    [r21 cx_removeTrailingWhitespaceAndNewlines];
    [r19 release];
    r0 = [r20 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    r0 = [r21 autorelease];
    return r0;


// 0x100037808
// +[NSMutableAttributedString cx_attributedStringWithHTML:]
    r0 = [self cx_attributedStringWithHTML:arg2 font:0x0];
    return r0;


// 0x100037810
// -[NSMutableAttributedString cx_removeTrailingWhitespaceAndNewlines]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self string];
    r0 = [r0 retain];
    r22 = r0;
    r20 = [r0 rangeOfString:@"[\s\v]+$" options:0x400];
    r21 = r1;
    [r22 release];
    if (r20 != 0x7fffffffffffffff) {
            [r19 deleteCharactersInRange:r20];
    }
    return;


