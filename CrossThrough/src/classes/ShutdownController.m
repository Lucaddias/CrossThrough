// ShutdownController.m — CrossThrough
#import "ShutdownController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "c_functions.h"

@implementation ShutdownController

- (id)init {
    self = [super initWithWindowNibName:@"ShutdownProgress"];
    if (self) {
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        [self setQuitBottleSemaphore:semaphore];
        [semaphore release];
        [self setCancelingShutdown:NO];
        [self setForcingShutdown:NO];
    }
    return self;
}

- (id)bottleCollection {
    return [[CXSetupLib bottleCollectionClass] sharedCollection];
}

- (void)cancelShutdown:(id)arg1 {
    [self setCancelingShutdown:YES];
    [self setForcingShutdown:NO];
}

- (void)forceShutdown:(id)arg1 {
    [self setCancelingShutdown:NO];
    [self setForcingShutdown:YES];
}

- (void)shutdownAllBottles {
    _CXLog(@"Shutting down all bottles.\n");
    for (BottleWrapper *bottle in [[self bottleCollection] bottleList]) {
        [bottle suspend];
    }
    [NSThread detachNewThreadSelector:@selector(shutdownAllBottlesBackground) toTarget:self withObject:nil];
}

- (void)shutdownAllBottlesBackground {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    for (BottleWrapper *bottle in [[self bottleCollection] bottleList]) {
        // Each bottle gets 60 seconds to quit before the shutdown gives up.
        if (dispatch_semaphore_wait([self quitBottleSemaphore], dispatch_time(DISPATCH_TIME_NOW, 60 * NSEC_PER_SEC)) != 0) {
            if (![self forcingShutdown]) {
                [self performSelectorOnMainThread:@selector(setCancelingShutdown:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            }
        }
        if ([self cancelingShutdown] || [self forcingShutdown]) {
            _CXLog([self forcingShutdown] ? @"Forcing shutdown.\n" : @"Canceling shutdown.\n");
            dispatch_semaphore_signal([self quitBottleSemaphore]);
            break;
        }
        void (^completion)(void) = [^{
            dispatch_semaphore_signal([self quitBottleSemaphore]);
        } copy];
        [bottle performSelectorOnMainThread:@selector(quit:) withObject:completion waitUntilDone:NO];
        [completion release];
    }
    if ([self forcingShutdown] && ![self cancelingShutdown]) {
        [self killAllBottles];
    }
    [[(CXApplication *)NSApp CXServer] performSelectorOnMainThread:@selector(replyToApplicationShouldTerminateTrampoline:)
                                                        withObject:[NSNumber numberWithBool:![self cancelingShutdown]]
                                                     waitUntilDone:NO];
    if ([self cancelingShutdown]) {
        for (BottleWrapper *bottle in [[self bottleCollection] bottleList]) {
            [bottle performSelectorOnMainThread:@selector(resume) withObject:nil waitUntilDone:NO];
        }
    }
    [pool drain];
}

- (void)killAllBottles {
    for (BottleWrapper *bottle in [[self bottleCollection] bottleList]) {
        if (dispatch_semaphore_wait([self quitBottleSemaphore], dispatch_time(DISPATCH_TIME_NOW, 60 * NSEC_PER_SEC)) != 0) {
            [self performSelectorOnMainThread:@selector(setCancelingShutdown:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
        }
        if ([self cancelingShutdown]) {
            dispatch_semaphore_signal([self quitBottleSemaphore]);
            break;
        }
        void (^completion)(void) = [^{
            dispatch_semaphore_signal([self quitBottleSemaphore]);
        } copy];
        [bottle performSelectorOnMainThread:@selector(forceQuit:) withObject:completion waitUntilDone:NO];
        [completion release];
    }
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [[self window] recalculateKeyViewLoop];
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

- (void)dealloc {
    [self->_quitBottleSemaphore release];
    [self->_bottleList release];
    [self->_canRunFilterPredicate release];
    [self->_shutdownCallbackObject release];
    [super dealloc];
}

@end
