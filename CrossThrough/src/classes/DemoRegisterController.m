// DemoRegisterController.m — CrossThrough
#import "DemoRegisterController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation DemoRegisterController

+ (id)keyPathsForValuesAffectingCanRegister {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"regController.login"];
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

- (void)setRefreshLicenseMode:(BOOL)arg1 {
    return;
}

- (void)windowDidLoad {
    return;
}

- (BOOL)canRegister {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r0 = [self regController];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 login];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r21 regController];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r0 = [r0 password];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   r21 = 0x1;
     *   }
     *   [r0 release];
     *   [r22 release];
     *   ... (8 more lines)
     */
    return NO;
}

- (void)registerapp:(id)arg1 {
    return;
}

- (void)openSerialCodeWindow:(id)arg1 {
    return;
}

- (void)cancel:(id)arg1 {
    return;
}

- (void)exitSuccess {
    return;
}

- (void)controlTextDidChange:(id)arg1 {
    return;
}

- (id)regController {
    return self->_regController;
}

- (BOOL)refreshLicenseMode {
    return self->_refreshLicenseMode;
}

- (id)alreadyPurchasedToEmailSpacer {
    return [objc_loadWeakRetained((id *)&self->_alreadyPurchasedToEmailSpacer) autorelease];
}

- (void)setAlreadyPurchasedToEmailSpacer:(id)arg1 {
    objc_storeWeak((id *)&self->_alreadyPurchasedToEmailSpacer, arg1);
}

- (id)referToStoreTextField {
    return [objc_loadWeakRetained((id *)&self->_referToStoreTextField) autorelease];
}

- (void)setReferToStoreTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_referToStoreTextField, arg1);
}

- (id)forgotPasswordTextField {
    return [objc_loadWeakRetained((id *)&self->_forgotPasswordTextField) autorelease];
}

- (void)setForgotPasswordTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_forgotPasswordTextField, arg1);
}

@end
