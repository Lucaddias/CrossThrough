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
    return [objc_loadWeakRetained((id *)&self->_messageTextField) autorelease];
}

- (void)setMessageTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_messageTextField, arg1);
}

- (id)bottleTableScrollView {
    return [objc_loadWeakRetained((id *)&self->_bottleTableScrollView) autorelease];
}

- (void)setBottleTableScrollView:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleTableScrollView, arg1);
}

- (id)messageToTableSpacing {
    return [objc_loadWeakRetained((id *)&self->_messageToTableSpacing) autorelease];
}

- (void)setMessageToTableSpacing:(id)arg1 {
    objc_storeWeak((id *)&self->_messageToTableSpacing, arg1);
}

- (id)tableToUpgradingSpacing {
    return [objc_loadWeakRetained((id *)&self->_tableToUpgradingSpacing) autorelease];
}

- (void)setTableToUpgradingSpacing:(id)arg1 {
    objc_storeWeak((id *)&self->_tableToUpgradingSpacing, arg1);
}

- (id)managedBottlesToUpgrade {
    return [[self->_managedBottlesToUpgrade retain] autorelease];
}

- (void)setManagedBottlesToUpgrade:(id)arg1 {
    if (self->_managedBottlesToUpgrade != arg1) {
        [self->_managedBottlesToUpgrade release];
        self->_managedBottlesToUpgrade = [arg1 retain];
    }
}

- (BOOL)upgradeInProgress {
    return self->_upgradeInProgress;
}

- (void)setUpgradeInProgress:(BOOL)arg1 {
    self->_upgradeInProgress = arg1;
}

@end
