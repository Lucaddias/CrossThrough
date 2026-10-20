// LauncherIcon.m — CrossThrough
#import "LauncherIcon.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherIcon

- (id)initWithName:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)copyWithZone:(void *)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = self;
     *   r0 = [[&var_20 super] copyWithZone:arg2];
     *   r20 = r0;
     *   [r0 setIcon:self->_icon];
     *   [r20 setBottle:self->_bottle];
     *   r0 = r20;
     *   return r0;
     */
    return nil;
}

- (id)tooltip {
    return nil;
}

- (void)launchWithErrorHandler:(id)arg1 {
    return;
}

- (id)description {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_40 = self;
     *   r0 = [[&var_40 super] description];
     *   r21 = [r0 retain];
     *   r22 = [[self icon] retain];
     *   r0 = [self bottle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r23 = [[r0 name] retain];
     *   r20 = [[NSString stringWithFormat:@"%@ icon %p bottle name %@", r3, r4, r5] retain];
     *   [r23 release];
     *   [r19 release];
     *   [r22 release];
     *   [r21 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)icon {
    return self->_icon;
}

- (void)setIcon:(id)arg1 {
    self->_icon = arg1;
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    self->_bottle = arg1;
}

@end
