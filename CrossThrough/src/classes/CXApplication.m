// CXApplication.m — CrossThrough
#import "CXApplication.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXApplication

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)setDelegate:(id)arg1 {
    return;
}

- (id)crossOverRoot {
    return self->crossOverRoot;
}

- (id)crossOverRootURL {
    return self->crossOverRootURL;
}

- (BOOL)isDemo {
    return self->isDemo;
}

- (void)setIsDemo {
    return;
}

- (NSInteger)daysLeft {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->daysLeft;
     *   return r0;
     */
    return 0;
}

- (void)setDaysLeft {
    return;
}

- (void)orderFrontStandardAboutPanel:(id)arg1 {
    return;
}

- (void)reportException:(id)arg1 {
    return;
}

- (void)setWineController:(id)arg1 {
    return;
}

- (void)sendEvent:(id)arg1 {
    return;
}

- (id)licenseID {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_licenseID)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setLicenseID:(id)arg1 {
    return;
}

- (id)licenseExpirationDate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_licenseExpirationDate)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setLicenseExpirationDate:(id)arg1 {
    return;
}

- (id)wineController {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_wineController);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)demoString {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_demoString)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setDemoString:(id)arg1 {
    return;
}

- (id)CXServer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_CXServer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setCXServer:(id)arg1 {
    return;
}

@end
