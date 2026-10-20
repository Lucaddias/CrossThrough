// ShutdownController.m — CrossThrough
#import "ShutdownController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation ShutdownController

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)bottleCollection {
    return [[CXSetupLib bottleCollectionClass] sharedCollection];
}

- (void)cancelShutdown:(id)arg1 {
    return;
}

- (void)forceShutdown:(id)arg1 {
    return;
}

- (void)shutdownAllBottles {
    return;
}

- (void)shutdownAllBottlesBackground {
    return;
}

- (void)killAllBottles {
    return;
}

- (void)windowDidLoad {
    return;
}

- (id)quitBottleSemaphore {
    return [[self->_quitBottleSemaphore retain] autorelease];
}

- (void)setQuitBottleSemaphore:(id)arg1 {
    if (self->_quitBottleSemaphore != arg1) {
        [self->_quitBottleSemaphore release];
        self->_quitBottleSemaphore = [arg1 retain];
    }
}

- (BOOL)cancelingShutdown {
    return self->_cancelingShutdown;
}

- (void)setCancelingShutdown:(BOOL)arg1 {
    self->_cancelingShutdown = arg1;
}

- (BOOL)forcingShutdown {
    return self->_forcingShutdown;
}

- (void)setForcingShutdown:(BOOL)arg1 {
    self->_forcingShutdown = arg1;
}

- (id)bottleList {
    return [[self->_bottleList retain] autorelease];
}

- (void)setBottleList:(id)arg1 {
    if (self->_bottleList != arg1) {
        [self->_bottleList release];
        self->_bottleList = [arg1 retain];
    }
}

- (id)canRunFilterPredicate {
    return [[self->_canRunFilterPredicate retain] autorelease];
}

- (void)setCanRunFilterPredicate:(id)arg1 {
    if (self->_canRunFilterPredicate != arg1) {
        [self->_canRunFilterPredicate release];
        self->_canRunFilterPredicate = [arg1 retain];
    }
}

- (id)shutdownCallbackObject {
    return [[self->_shutdownCallbackObject retain] autorelease];
}

- (void)setShutdownCallbackObject:(id)arg1 {
    if (self->_shutdownCallbackObject != arg1) {
        [self->_shutdownCallbackObject release];
        self->_shutdownCallbackObject = [arg1 retain];
    }
}

- (SEL)shutdownCallbackSelector {
    return self->_shutdownCallbackSelector;
}

- (void)setShutdownCallbackSelector:(SEL)arg1 {
    self->_shutdownCallbackSelector = arg1;
}

@end
