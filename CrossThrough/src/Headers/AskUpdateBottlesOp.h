// AskUpdateBottlesOp.h — CrossThrough
#ifndef AskUpdateBottlesOp_h
#define AskUpdateBottlesOp_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class AskUpdateBottlesOp;

@interface AskUpdateBottlesOp : NSOperation

// Instance Methods
- (void)main;

@end

#endif /* AskUpdateBottlesOp_h */
