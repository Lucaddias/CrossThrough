// RunCommandLauncherModeViewController.h — CrossThrough
#ifndef RunCommandLauncherModeViewController_h
#define RunCommandLauncherModeViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class RunCommandLauncherModeViewController;

@interface RunCommandLauncherModeViewController : CXViewController
{
    NSImageView * _launcherIconImageView;
    NSTextField * _launcherNameTextField;
}

// Instance Methods
- (id)init;
- (void)loadView;
- (id)launcherIconImageView;
- (void)setLauncherIconImageView:(id)arg1;
- (id)launcherNameTextField;
- (void)setLauncherNameTextField:(id)arg1;

@end

#endif /* RunCommandLauncherModeViewController_h */
