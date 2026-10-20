// BooleanToLabelColorTransformer.m — CrossThrough
#import "BooleanToLabelColorTransformer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BooleanToLabelColorTransformer

+ (BOOL)allowsReverseTransformation {
    return NO;
}

+ (Class)transformedValueClass {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_opt_class(@class(NSColor));
     *   return r0;
     */
    return nil;
}

- (id)transformedValue:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r31 = r31 + 0xfffffffffffffff0;
     *   if (([arg2 boolValue] & 0x1) != 0x0) {
     *   r0 = [NSColor controlTextColor];
     *   r0 = [r0 retain];
     *   }
     *   else {
     *   r0 = [NSColor disabledControlTextColor];
     *   r0 = [r0 retain];
     *   }
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

@end
