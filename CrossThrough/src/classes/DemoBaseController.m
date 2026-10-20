// DemoBaseController.m — CrossThrough
#import "DemoBaseController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation DemoBaseController

- (id)initWithWindowNibName:(id)arg1 {
    self = [super initWithWindowNibName:arg1];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)expirationText {
    return self->_expirationText;
}

- (void)setExpirationText:(id)arg1 {
    return;
}

@end
