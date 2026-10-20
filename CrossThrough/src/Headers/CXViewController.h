// CXViewController.h — CrossThrough
#ifndef CXViewController_h
#define CXViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXViewController;

@interface CXViewController : NSViewController

// Class Methods
+ (BOOL)accessInstanceVariablesDirectly;

@end

#endif /* CXViewController_h */
