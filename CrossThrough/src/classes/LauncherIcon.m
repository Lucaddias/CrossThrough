// LauncherIcon.m — CrossThrough
#import "LauncherIcon.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherIcon

- (id)initWithName:(id)arg1 {
    return [super initWithName:arg1];
}

- (void)dealloc {
    [self->_icon release];
    [self->_bottle release];
    [super dealloc];
}

- (id)copyWithZone:(void *)arg1 {
    LauncherIcon *copy = [super copyWithZone:arg1];
    [copy setIcon:self->_icon];
    [copy setBottle:self->_bottle];
    return copy;
}

- (id)tooltip {
    return nil;
}

- (void)launchWithErrorHandler:(id)arg1 {
    return;
}

- (id)description {
    return [NSString stringWithFormat:@"%@ icon %p bottle name %@", [super description], [self icon], [[self bottle] name]];
}

- (id)icon {
    return self->_icon;
}

- (void)setIcon:(id)arg1 {
    if (self->_icon != arg1) {
        [self->_icon release];
        self->_icon = [arg1 retain];
    }
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    if (self->_bottle != arg1) {
        [self->_bottle release];
        self->_bottle = [arg1 retain];
    }
}

@end
