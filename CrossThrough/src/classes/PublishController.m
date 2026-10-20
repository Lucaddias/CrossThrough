// PublishController.m — CrossThrough
#import "PublishController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PublishController

+ (id)keyPathsForValuesAffectingNameCollides {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"bottleName"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingCanPublish {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"bottleName"];
     *   return r0;
     */
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)setBottleName:(id)arg1 {
    return;
}

- (void)setupGUI {
    return;
}

- (void)publishPressed:(id)arg1 {
    return;
}

- (void)doPublish {
    return;
}

- (void)publishFailed {
    return;
}

- (void)exitSuccess:(id)arg1 {
    return;
}

- (void)cancelPressed:(id)arg1 {
    return;
}

- (BOOL)nameCollides {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [self bottleName];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if ([r0 length] != 0x0) {
     *   r21 = [CXSetupLib bottleQueryClass];
     *   r22 = [[r20 bottleName] retain];
     *   r0 = [r21 isValidNewBottleName:r22];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [r0 boolValue] ^ 0x1;
     *   [r21 release];
     *   [r22 release];
     *   }
     *   else {
     *   r20 = 0x0;
     *   }
     *   [r19 release];
     *   ... (2 more lines)
     */
    return NO;
}

- (BOOL)canPublish {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [self bottleName];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if ([r0 length] != 0x0) {
     *   r20 = [r20 nameCollides];
     *   [r19 release];
     *   r0 = r20 ^ 0x1;
     *   }
     *   else {
     *   [r19 release];
     *   r0 = 0x0;
     *   }
     *   return r0;
     */
    return NO;
}

- (void)setSourceBottle:(id)arg1 {
    return;
}

- (id)bottleName {
    return self->_bottleName;
}

- (id)bounceUtil {
    return self->_bounceUtil;
}

- (void)setBounceUtil:(id)arg1 {
    return;
}

- (id)sourceBottle {
    return self->_sourceBottle;
}

- (id)authorization {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_authorization)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setAuthorization:(id)arg1 {
    return;
}

- (BOOL)isWorking {
    return self->_isWorking;
}

- (void)setIsWorking:(BOOL)arg1 {
    self->_isWorking = arg1;
}

@end
