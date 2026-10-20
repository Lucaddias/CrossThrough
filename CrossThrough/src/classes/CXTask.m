// CXTask.m — CrossThrough
#import "CXTask.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXTask

+ (id)argumentsWithStringsReplacedBySpecialStrings:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x130;
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
     *   var_58 = **___stack_chk_guard;
     *   r0 = [arg2 retain];
     *   r20 = r0;
     *   r19 = [[NSMutableArray arrayWithCapacity:[r0 count]] retain];
     *   var_120 = q0;
     *   var_110 = q0;
     *   r0 = [r20 retain];
     *   r20 = r0;
     *   r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
     *   if (r0 != 0x0) {
     *   r21 = r0;
     *   r24 = *var_110;
     *   ... (28 more lines)
     */
    return nil;
}

+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r21 = [arg2 retain];
     *   r19 = [[self argumentsWithStringsReplacedBySpecialStrings:arg3] retain];
     *   r22 = [[NSTask launchedTaskWithLaunchPath:r21 arguments:r19] retain];
     *   [r21 release];
     *   r20 = [[objc_opt_class(self) alloc] initWithTask:r22];
     *   [r22 release];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)initWithTask:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (void)cxtaskObserveRealTaskTermination:(id)arg1 {
    return;
}

- (void)setArguments:(id)arg1 {
    return;
}

- (id)forwardingTargetForSelector:(SEL)arg1 {
    return self->realTask;
}

@end
