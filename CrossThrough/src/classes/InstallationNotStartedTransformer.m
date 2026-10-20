// InstallationNotStartedTransformer.m — CrossThrough
#import "InstallationNotStartedTransformer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallationNotStartedTransformer

+ (BOOL)allowsReverseTransformation {
    return NO;
}

+ (Class)transformedValueClass {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_opt_class(@class(NSNumber));
     *   return r0;
     */
    return nil;
}

- (id)transformedValue:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r2 = arg2;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   if ([r2 intValue] != 0x1) {
     *   r2 = 0x1;
     *   }
     *   r0 = [NSNumber numberWithBool:r2];
     *   return r0;
     */
    return nil;
}

@end
