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
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->lifeCounter;
     *   return r0;
     */
    return 0;
}

- (void)setLifeCounter:(NSInteger)arg1 {
    return;
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
