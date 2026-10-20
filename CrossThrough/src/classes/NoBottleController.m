// NoBottleController.m — CrossThrough
#import "NoBottleController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NoBottleController

+ (id)keyPathsForValuesAffectingCanCreate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"nameForNewBottle"];
     *   return r0;
     */
    return nil;
}

- (id)initWithFileToLaunch:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)awakeFromNib {
    return;
}

- (void)createPressed:(id)arg1 {
    return;
}

- (void)doCreate {
    return;
}

- (void)createFailed:(id)arg1 {
    return;
}

- (void)exitSuccess:(id)arg1 {
    return;
}

- (void)cancelPressed:(id)arg1 {
    return;
}

- (void)scopeChanged:(id)arg1 {
    return;
}

- (BOOL)canCreate {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [self nameForNewBottle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if ([r0 length] != 0x0) {
     *   r20 = 0x1;
     *   }
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return NO;
}

- (id)fileToLaunch {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_fileToLaunch)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setFileToLaunch:(id)arg1 {
    return;
}

- (id)nameForNewBottle {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_nameForNewBottle)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setNameForNewBottle:(id)arg1 {
    return;
}

- (id)bottleTemplate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleTemplate)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setBottleTemplate:(id)arg1 {
    return;
}

- (id)fileToLaunchString {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_fileToLaunchString)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setFileToLaunchString:(id)arg1 {
    return;
}

- (BOOL)isWorking {
    return self->_isWorking;
}

- (void)setIsWorking:(BOOL)arg1 {
    self->_isWorking = arg1;
}

- (id)templateArray {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_templateArray)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setTemplateArray:(id)arg1 {
    return;
}

@end
