// CXSourceList.m — CrossThrough
#import "CXSourceList.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXSourceList

- (NSRect)frameOfCellAtColumn:(NSInteger)arg1 row:(NSInteger)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = self;
     *   [[&var_30 super] frameOfCellAtColumn:arg2 row:arg3];
     *   r0 = [self frame];
     *   return r0;
     */
    return NSZeroRect;
}

- (BOOL)validateProposedFirstResponder:(id)arg1 forEvent:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   objc_opt_class(@class(NSTextField));
     *   if ((objc_opt_isKindOfClass() & 0x1) != 0x0 && [r20 type] == 0x3) {
     *   r21 = 0x0;
     *   }
     *   else {
     *   var_30 = r21;
     *   r0 = [[&var_30 super] validateProposedFirstResponder:r19 forEvent:r20];
     *   r21 = r0;
     *   }
     *   [r20 release];
     *   [r19 release];
     *   r0 = r21;
     *   return r0;
     */
    return NO;
}

@end
