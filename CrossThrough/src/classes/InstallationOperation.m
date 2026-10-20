// InstallationOperation.m — CrossThrough
#import "InstallationOperation.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallationOperation

- (id)initWithTaskStatus:(id)arg1 completionSelector:(SEL)arg2 andTarget:(id)arg3 {
    self = [super init];
    if (self) {
        self->taskStatus = [arg1 retain];
        self->completionSelector = arg2;
        self->selectorTarget = [arg3 retain];
    }
    return self;
}

- (void)main {
    BOOL success = [[(InstallEngineTask *)[self->taskStatus task] main] boolValue];
    if (![self isCancelled]) {
        [self->taskStatus setSuccess:success];
        [self->selectorTarget performSelectorOnMainThread:self->completionSelector withObject:self->taskStatus waitUntilDone:NO];
    }
}

- (void)dealloc {
    [self->taskStatus release];
    [self->selectorTarget release];
    [super dealloc];
}

@end
