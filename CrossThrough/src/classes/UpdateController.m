// UpdateController.m — CrossThrough
#import "UpdateController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation UpdateController

- (id)initWithManagedBottles:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)windowDidLoad {
    return;
}

- (void)finish {
    return;
}

- (void)updatePressed:(id)arg1 {
    return;
}

- (void)doUpdateWithAuthorization:(id)arg1 {
    return;
}

- (void)updateBottle:(id)arg1 WithAuthorization:(id)arg2 {
    return;
}

- (void)updateLaterPressed:(id)arg1 {
    return;
}

- (id)messageTextField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_messageTextField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMessageTextField:(id)arg1 {
    return;
}

- (id)bottleTableScrollView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleTableScrollView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleTableScrollView:(id)arg1 {
    return;
}

- (id)messageToTableSpacing {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_messageToTableSpacing);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMessageToTableSpacing:(id)arg1 {
    return;
}

- (id)tableToUpgradingSpacing {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_tableToUpgradingSpacing);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setTableToUpgradingSpacing:(id)arg1 {
    return;
}

- (id)managedBottlesToUpgrade {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_managedBottlesToUpgrade)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setManagedBottlesToUpgrade:(id)arg1 {
    return;
}

- (BOOL)upgradeInProgress {
    return self->_upgradeInProgress;
}

- (void)setUpgradeInProgress:(BOOL)arg1 {
    self->_upgradeInProgress = arg1;
}

@end
