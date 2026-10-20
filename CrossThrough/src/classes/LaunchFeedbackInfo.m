// LaunchFeedbackInfo.m — CrossThrough
#import "LaunchFeedbackInfo.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LaunchFeedbackInfo

- (id)initWithIcon:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (NSInteger)lifeCounter {
    return self->lifeCounter;
}

- (void)setLifeCounter:(NSInteger)arg1 {
    self->lifeCounter = arg1;
}

- (id)socketPath {
    return self->socketPath;
}

- (id)badgeIcon {
    return self->badgeIcon;
}

- (BOOL)notified {
    return self->notified;
}

- (void)setNotified:(BOOL)arg1 {
    self->notified = arg1;
}

- (void)connectionAccepted:(id)arg1 {
    return;
}

@end
