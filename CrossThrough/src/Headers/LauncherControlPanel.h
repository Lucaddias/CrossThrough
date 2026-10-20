// LauncherControlPanel.h — CrossThrough
#ifndef LauncherControlPanel_h
#define LauncherControlPanel_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherIcon.h"

@class LauncherControlPanel;

@interface LauncherControlPanel : LauncherIcon
{
    id _controlPanel;
}

// Class Methods
+ (id)launcherWithControlPanel:(id)arg1 bottle:(id)arg2;

// Instance Methods
- (id)initWithControlPanel:(id)arg1 bottle:(id)arg2;
- (id)copyWithZone:(void *)arg1;
- (id)tooltip;
- (void)launchWithErrorHandler:(id)arg1;
- (id)description;

@end

#endif /* LauncherControlPanel_h */
