// NSWorkspace+CrossOverAdditions.m — CrossThrough
#import "NSWorkspace+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSWorkspace (CrossOverAdditions)

- (id)CX_findRunningAppBundleWithIdentifier:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [NSRunningApplication runningApplicationsWithBundleIdentifier:arg2];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if ([r0 count] != 0x0) {
     *   r0 = [r19 objectAtIndex:0x0];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r0 = [r0 bundleURL];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r20 = [[r0 path] retain];
     *   [r22 release];
     *   [r21 release];
     *   }
     *   else {
     *   r20 = 0x0;
     *   }
     *   [r19 release];
     *   ... (2 more lines)
     */
    return nil;
}

- (id)CX_absolutePathForAppBundleWithIdentifier:(id)arg1 orIdentifyingURLScheme:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r3 = arg3;
     *   r31 = r31 - 0x1a0;
     *   var_50 = r28;
     *   decomp_var_48 = r27;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = r3;
     *   r20 = _cmd;
     *   r19 = self;
     *   var_60 = **___stack_chk_guard;
     *   r26 = [arg2 retain];
     *   r22 = [r21 retain];
     *   if (r26 == 0x0) {
     *   r0 = [NSAssertionHandler currentHandler];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r3 = r19;
     *   ... (307 more lines)
     */
    return nil;
}

- (BOOL)CX_launchAppWithBundleIdentifier:(id)arg1 orIdentifyingURLScheme:(id)arg2 options:(NSUInteger)arg3 additionalEventParamDescriptor:(id)arg4 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x60;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = arg4;
     *   r24 = _cmd;
     *   r23 = self;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   r22 = [arg5 retain];
     *   if (r19 == 0x0) {
     *   r0 = [NSAssertionHandler currentHandler];
     *   r0 = [r0 retain];
     *   r25 = r0;
     *   [r0 handleFailureInMethod:r24 object:r23 file:@"NSWorkspace+CrossOverAdditions.m" lineNumber:0x77 description:@"Invalid parameter not satisfying: %@"];
     *   [r25 release];
     *   }
     *   r0 = [r23 CX_findRunningAppBundleWithIdentifier:r19];
     *   ... (14 more lines)
     */
    return NO;
}

- (BOOL)CX_openURLs:(id)arg1 withAppBundleIdentifier:(id)arg2 orIdentifyingURLScheme:(id)arg3 options:(NSUInteger)arg4 additionalEventParamDescriptor:(id)arg5 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x80;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r22 = arg5;
     *   r25 = _cmd;
     *   r24 = self;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   r21 = [arg4 retain];
     *   r23 = [arg6 retain];
     *   if (r20 != 0x0) {
     *   r0 = [r24 CX_absolutePathForAppBundleWithIdentifier:r20 orIdentifyingURLScheme:r21];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   r24 = [[NSURL fileURLWithPath:r0] retain];
     *   [r0 release];
     *   [r24 release];
     *   ... (60 more lines)
     */
    return NO;
}

@end
