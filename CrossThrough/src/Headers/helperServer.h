// helperServer.h — CrossThrough
#ifndef helperServer_h
#define helperServer_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class helperServer;

@interface helperServer : NSObject <HelperServer>
{
    BOOL isReady;
    NSConnection * _theConnection;
}

// Class Methods
+ (id)defaultHelperServer;

// Instance Methods
- (id)init;
- (bycopy id)getEnvironmentForXConnection;
- (void)setIsReady;
- (BOOL)isServerReady;
- (BOOL)isServerReadyForBottle:(id)arg1;
- (oneway void)raiseWindowsWithTag:(NSInteger)arg1;
- (id)theConnection;
- (void)setTheConnection:(id)arg1;

@end

#endif /* helperServer_h */
