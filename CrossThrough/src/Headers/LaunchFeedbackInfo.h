// LaunchFeedbackInfo.h — CrossThrough
#ifndef LaunchFeedbackInfo_h
#define LaunchFeedbackInfo_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class LaunchFeedbackInfo;

@interface LaunchFeedbackInfo : CXObject
{
    NSFileHandle * socketHandle;
    NSString * socketPath;
    NSImage * badgeIcon;
    NSInteger lifeCounter;
    BOOL notified;
}

// Instance Methods
- (id)initWithIcon:(id)arg1;
- (void)dealloc;
- (NSInteger)lifeCounter;
- (void)setLifeCounter:(NSInteger)arg1;
- (id)socketPath;
- (id)badgeIcon;
- (BOOL)notified;
- (void)setNotified:(BOOL)arg1;
- (void)connectionAccepted:(id)arg1;

@end

#endif /* LaunchFeedbackInfo_h */
