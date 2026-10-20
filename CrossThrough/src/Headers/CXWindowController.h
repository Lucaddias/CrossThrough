// CXWindowController.h — CrossThrough
#ifndef CXWindowController_h
#define CXWindowController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXWindowController;

@interface CXWindowController : NSWindowController <NSWindowDelegate, NSObject>

// Class Methods
+ (BOOL)accessInstanceVariablesDirectly;

// Instance Methods
- (void)dealloc;
- (void)windowDidLoad;
- (void)windowWillClose:(id)arg1;
- (void)showWindow:(id)arg1;

@end

#endif /* CXWindowController_h */
