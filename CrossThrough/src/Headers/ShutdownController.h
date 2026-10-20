// ShutdownController.h — CrossThrough
#ifndef ShutdownController_h
#define ShutdownController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class ShutdownController;

@interface ShutdownController : CXWindowController
{
    NSArrayController * bottleArray;
    BOOL _cancelingShutdown;
    BOOL _forcingShutdown;
    NSObject<OS_dispatch_semaphore> * _quitBottleSemaphore;
    NSMutableArray * _bottleList;
    NSPredicate * _canRunFilterPredicate;
    id _shutdownCallbackObject;
    SEL _shutdownCallbackSelector;
}

// Instance Methods
- (id)init;
- (id)bottleCollection;
- (void)cancelShutdown:(id)arg1;
- (void)forceShutdown:(id)arg1;
- (void)shutdownAllBottles;
- (void)shutdownAllBottlesBackground;
- (void)killAllBottles;
- (void)windowDidLoad;
- (id)quitBottleSemaphore;
- (void)setQuitBottleSemaphore:(id)arg1;
- (BOOL)cancelingShutdown;
- (void)setCancelingShutdown:(BOOL)arg1;
- (BOOL)forcingShutdown;
- (void)setForcingShutdown:(BOOL)arg1;
- (id)bottleList;
- (void)setBottleList:(id)arg1;
- (id)canRunFilterPredicate;
- (void)setCanRunFilterPredicate:(id)arg1;
- (id)shutdownCallbackObject;
- (void)setShutdownCallbackObject:(id)arg1;
- (SEL)shutdownCallbackSelector;
- (void)setShutdownCallbackSelector:(SEL)arg1;

@end

#endif /* ShutdownController_h */
