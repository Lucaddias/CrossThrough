// NSMutableAttributedString+CrossOverAdditions.m — CrossThrough
#import "NSMutableAttributedString+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSMutableAttributedString (CrossOverAdditions)

+ (id)cx_attributedStringWithHTML:(id)arg1 font:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x60;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_38 = **___stack_chk_guard;
     *   r20 = [arg3 retain];
     *   r19 = [[arg2 dataUsingEncoding:0x4] retain];
     *   r21 = [NSMutableAttributedString alloc];
     *   var_48 = **_NSCharacterEncodingDocumentOption;
     *   r0 = @(0x4);
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   var_40 = r0;
     *   r0 = [NSDictionary dictionaryWithObjects:&var_40 forKeys:&var_48 count:0x1];
     *   r23 = [r0 retain];
     *   r2 = r19;
     *   r21 = [r21 initWithHTML:r2 options:r23 documentAttributes:0x0];
     *   [r23 release];
     *   [r22 release];
     *   if (r20 == 0x0) {
     *   ... (19 more lines)
     */
    return nil;
}

+ (id)cx_attributedStringWithHTML:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self cx_attributedStringWithHTML:arg2 font:0x0];
     *   return r0;
     */
    return nil;
}

- (void)cx_removeTrailingWhitespaceAndNewlines {
    return;
}

@end
