// LauncherApp.h — CrossThrough
#ifndef LauncherApp_h
#define LauncherApp_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherIcon.h"

@class LauncherApp;

@interface LauncherApp : LauncherIcon
{
    NSURL * _url;
    NSString * _bundleID;
    NSUInteger _helperVersion;
}

// Class Methods
+ (id)launcherWithURL:(id)arg1;

// Instance Methods
- (id)initWithURL:(id)arg1;
- (id)copyWithZone:(void *)arg1;
- (void)launchWithErrorHandler:(id)arg1;
- (id)description;
- (id)url;
- (void)setUrl:(id)arg1;
- (id)bundleID;
- (void)setBundleID:(id)arg1;
- (NSUInteger)helperVersion;
- (void)setHelperVersion:(NSUInteger)arg1;

@end

#endif /* LauncherApp_h */
