// NSAttributedString+CrossOverAdditions.m — CrossThrough
#import "NSAttributedString+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSAttributedString (CrossOverAdditions)

+ (id)cx_attributedStringWithHTML:(id)arg1 font:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSMutableAttributedString cx_attributedStringWithHTML:arg2 font:arg3];
     *   return r0;
     */
    return nil;
}

+ (id)cx_attributedStringWithHTML:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSMutableAttributedString cx_attributedStringWithHTML:arg2];
     *   return r0;
     */
    return nil;
}

- (id)cx_attributedStringByRemovingTrailingWhitespaceAndNewlines {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self mutableCopy];
     *   r19 = r0;
     *   [r0 cx_removeTrailingWhitespaceAndNewlines];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

@end
