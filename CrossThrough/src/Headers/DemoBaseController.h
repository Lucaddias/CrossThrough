// DemoBaseController.h — CrossThrough
#ifndef DemoBaseController_h
#define DemoBaseController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class DemoBaseController;

@interface DemoBaseController : CXWindowController
{
    NSString * _expirationText;
}

// Instance Methods
- (id)initWithWindowNibName:(id)arg1;
- (id)expirationText;
- (void)setExpirationText:(id)arg1;

@end

#endif /* DemoBaseController_h */
