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
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXSetupLib bottleCollectionClass];
     *   r0 = [r0 sharedCollection];
     *   return r0;
     */
    return nil;
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
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_quitBottleSemaphore)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setQuitBottleSemaphore:(id)arg1 {
    return;
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
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleList)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setBottleList:(id)arg1 {
    return;
}

- (id)canRunFilterPredicate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_canRunFilterPredicate)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setCanRunFilterPredicate:(id)arg1 {
    return;
}

- (id)shutdownCallbackObject {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_shutdownCallbackObject)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setShutdownCallbackObject:(id)arg1 {
    return;
}

- (SEL)shutdownCallbackSelector {
    return self->_shutdownCallbackSelector;
}

- (void)setShutdownCallbackSelector:(SEL)arg1 {
    return;
}

@end
