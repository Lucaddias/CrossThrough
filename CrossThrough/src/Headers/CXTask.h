// CXTask.h — CrossThrough
#ifndef CXTask_h
#define CXTask_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXTask;

@interface CXTask : NSProxy
{
    NSTask * realTask;
}

// Class Methods
+ (id)argumentsWithStringsReplacedBySpecialStrings:(id)arg1;
+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2;

// Instance Methods
- (id)initWithTask:(id)arg1;
- (id)init;
- (void)dealloc;
- (void)cxtaskObserveRealTaskTermination:(id)arg1;
- (void)setArguments:(id)arg1;
- (void)setTerminationHandler:(id)arg1;
- (id)forwardingTargetForSelector:(SEL)arg1;

@end

#endif /* CXTask_h */
