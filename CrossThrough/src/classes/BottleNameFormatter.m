// BottleNameFormatter.m — CrossThrough
#import "BottleNameFormatter.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BottleNameFormatter

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

- (id)stringForObjectValue:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = [arg2 retain];
     *   objc_opt_class(@class(NSString));
     *   if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
     *   r0 = [r19 retain];
     *   r20 = r0;
     *   }
     *   else {
     *   objc_opt_class(@class(NSAttributedString));
     *   if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
     *   r0 = [r19 string];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   }
     *   else {
     *   r20 = 0x0;
     *   }
     *   }
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (BOOL)getObjectValue:(id *)arg1 forString:(id)arg2 errorDescription:(id *)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   *arg2 = [[arg3 copy] autorelease];
     *   return 0x1;
     */
    return NO;
}

- (BOOL)isPartialStringValid:(id)arg1 newEditingString:(id *)arg2 errorDescription:(id *)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = [arg2 retain];
     *   r20 = [[NSCharacterSet characterSetWithCharactersInString:@"\/*?:|<>\"'{}"] retain];
     *   [r19 rangeOfCharacterFromSet:r20];
     *   if (r1 != 0x0) {
     *   [r20 release];
     *   r20 = 0x0;
     *   }
     *   else {
     *   r21 = [r19 hasPrefix:@"."];
     *   [r20 release];
     *   r20 = r21 ^ 0x1;
     *   }
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return NO;
}

@end
