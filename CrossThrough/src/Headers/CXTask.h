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
- (id)forwardingTargetForSelector:(SEL)arg1;

@end

// Everything else is forwarded to the wrapped NSTask.
@interface CXTask (NSTaskForwarding)
@property (copy) NSString *launchPath;
@property (copy) NSString *currentDirectoryPath;
@property (copy) NSDictionary *environment;
@property (retain) id standardInput;
@property (retain) id standardOutput;
@property (retain) id standardError;
@property (copy) void (^terminationHandler)(NSTask *);
@property (readonly) int processIdentifier;
@property (readonly) int terminationStatus;
@property (readonly) NSTaskTerminationReason terminationReason;
@property (readonly, getter=isRunning) BOOL running;
- (NSArray *)arguments;
- (void)launch;
- (BOOL)launchAndReturnError:(NSError **)error;
- (void)terminate;
- (void)interrupt;
- (BOOL)suspend;
- (BOOL)resume;
- (void)waitUntilExit;
@end

#endif /* CXTask_h */
