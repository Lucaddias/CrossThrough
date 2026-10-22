// DemoBaseController.m — CrossThrough
#import "DemoBaseController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation DemoBaseController

- (id)initWithWindowNibName:(id)arg1 {
    self = [super initWithWindowNibName:arg1];
    if (self) {
        NSInteger daysLeft = [(CXApplication *)[NSApplication sharedApplication] daysLeft];
        NSString *format;
        if (daysLeft <= 0) {
            format = [[NSBundle mainBundle] localizedStringForKey:@"This trial version of %1$@ has expired." value:@"" table:nil];
        } else if (daysLeft == 1) {
            format = [[NSBundle mainBundle] localizedStringForKey:@"This is a time limited trial version of %@. It will stop working in 1 day." value:@"" table:nil];
        } else {
            format = [[NSBundle mainBundle] localizedStringForKey:@"This is a time limited trial version of %1$@. It will stop working in %2$d days." value:@"" table:nil];
        }
        self->_expirationText = [[NSString stringWithFormat:format, @"CrossOver", (int)daysLeft] copy];
    }
    return self;
}

- (id)expirationText {
    return self->_expirationText;
}

- (void)setExpirationText:(id)arg1 {
    if (self->_expirationText != arg1) {
        [self->_expirationText release];
        self->_expirationText = [arg1 copy];
    }
}

- (void)dealloc {
    [self->_expirationText release];
    [super dealloc];
}

@end
