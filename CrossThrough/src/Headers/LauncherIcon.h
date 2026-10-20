// LauncherIcon.h — CrossThrough
#ifndef LauncherIcon_h
#define LauncherIcon_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherItem.h"

@class LauncherIcon;

@interface LauncherIcon : LauncherItem
{
    NSImage * _icon;
    BottleWrapper * _bottle;
}

// Instance Methods
- (id)initWithName:(id)arg1;
- (id)copyWithZone:(void *)arg1;
- (id)tooltip;
- (void)launchWithErrorHandler:(id)arg1;
- (id)description;
- (id)icon;
- (void)setIcon:(id)arg1;
- (id)bottle;
- (void)setBottle:(id)arg1;

@end

#endif /* LauncherIcon_h */
