// NSAttributedString — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000375fc
// +[NSAttributedString cx_attributedStringWithHTML:font:]
    r0 = [NSMutableAttributedString cx_attributedStringWithHTML:arg2 font:arg3];
    return r0;


// 0x100037608
// +[NSAttributedString cx_attributedStringWithHTML:]
    r0 = [NSMutableAttributedString cx_attributedStringWithHTML:arg2];
    return r0;


// 0x100037614
// -[NSAttributedString cx_attributedStringByRemovingTrailingWhitespaceAndNewlines]
    r0 = [self mutableCopy];
    r19 = r0;
    [r0 cx_removeTrailingWhitespaceAndNewlines];
    r0 = [r19 autorelease];
    return r0;


