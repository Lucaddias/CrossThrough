// CXObject.h — CrossThrough
#ifndef CXObject_h
#define CXObject_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXObject;

@interface CXObject : NSObject

// Class Methods
+ (BOOL)accessInstanceVariablesDirectly;

@end

#endif /* CXObject_h */
