// SelectBottleController.m — CrossThrough
#import "SelectBottleController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation SelectBottleController

+ (void)initialize {
    return;
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

- (void)awakeFromNib {
    return;
}

- (void)setSelectedBottle:(id)arg1 {
    return;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (id)allowedFileTypes {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r23 = sign_extend_64(*(int32_t *)ivar_offset(cachedAllowedFileTypes));
     *   r0 = *(self + r23);
     *   if (r0 == 0x0) {
     *   r20 = *_builtInAllowedTypes;
     *   r22 = [[r19 selectedBottle] retain];
     *   r21 = [[CXServer fileTypesForBottle:r22] retain];
     *   r0 = [r20 arrayByAddingObjectsFromArray:r21];
     *   r0 = [r0 retain];
     *   r8 = *(r19 + r23);
     *   *(r19 + r23) = r0;
     *   [r8 release];
     *   [r21 release];
     *   [r22 release];
     *   r0 = *(r19 + r23);
     *   }
     *   ... (2 more lines)
     */
    return nil;
}

- (BOOL)panel:(id)arg1 shouldShowFilename:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x120;
     *   var_40 = r28;
     *   decomp_var_38 = r27;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   var_48 = **___stack_chk_guard;
     *   r19 = [arg3 retain];
     *   r0 = [NSFileManager defaultManager];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 fileExistsAtPath:r19 isDirectory:&var_C9];
     *   [r20 release];
     *   if (var_C9 != 0x0) {
     *   r22 = 0x1;
     *   }
     *   else {
     *   r20 = [[r19 pathExtension] retain];
     *   var_110 = q0;
     *   ... (48 more lines)
     */
    return NO;
}

- (id)bottleArrayController {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleArrayController);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleArrayController:(id)arg1 {
    return;
}

- (id)selectedBottle {
    return self->_selectedBottle;
}

- (id)canRunFilterPredicate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_canRunFilterPredicate)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setCanRunFilterPredicate:(id)arg1 {
    return;
}

@end
