// RunCommandController.h — CrossThrough
#ifndef RunCommandController_h
#define RunCommandController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class RunCommandController;
@class LauncherApp;
@class CXViewController;
@class LoggingOptionsViewController;

@interface RunCommandController : CXWindowController
{
    NSTask * task;
    NSData * stdOut;
    BOOL taskComplete;
    BOOL _enableLoggingChannelsControls;
    BOOL _commandRunning;
    NSArrayController * _bottleArray;
    BottleWrapper * _selectedBottle;
    NSIndexSet * _selectedBottleIndexes;
    NSScrollView * _failAlertAccessoryView;
    NSTextView * _failAlertTextView;
    LauncherApp * _launcher;
    NSView * _loggingViewContainer;
    NSView * _modeSpecificViewContainer;
    NSView * _nonLauncherModeView;
    NSTextField * _nonLauncherModeCommandTextField;
    NSString * _command;
    NSPredicate * _canRunFilterPredicate;
    CXViewController * _launcherModeViewController;
    LoggingOptionsViewController * _loggingOptions;
    NSString * _envVars;
    NSData * _stdErr;
}

// Class Methods
+ (BOOL)automaticallyNotifiesObserversOfSelectedBottle;
+ (BOOL)automaticallyNotifiesObserversOfSelectedBottleIndexes;
+ (id)keyPathsForValuesAffectingCanRun;

// Instance Methods
- (id)init;
- (id)initWithFileToRun:(id)arg1;
- (void)dealloc;
- (void)setSelectedBottle:(id)arg1;
- (void)setSelectedBottleIndexes:(id)arg1;
- (void)browseForCommand:(id)arg1;
- (void)runCommandPressed:(id)arg1;
- (void)runCommand;
- (void)getStdout:(id)arg1;
- (void)getStderr:(id)arg1;
- (void)didTerminate:(id)arg1;
- (void)commandComplete;
- (void)setCommand:(id)arg1;
- (void)setCommandRunning:(BOOL)arg1;
- (id)bottleCollection;
- (void)createIcon:(id)arg1;
- (void)windowDidLoad;
- (void)windowWillClose:(id)arg1;
- (BOOL)canRun;
- (BOOL)supportsAVX;
- (void)appendEnvVar:(id)arg1;
- (void)metalHudSelected:(id)arg1;
- (void)AVXSelected:(id)arg1;
- (id)bottleArray;
- (void)setBottleArray:(id)arg1;
- (id)selectedBottle;
- (id)selectedBottleIndexes;
- (id)failAlertAccessoryView;
- (void)setFailAlertAccessoryView:(id)arg1;
- (id)failAlertTextView;
- (void)setFailAlertTextView:(id)arg1;
- (BOOL)enableLoggingChannelsControls;
- (id)launcher;
- (void)setLauncher:(id)arg1;
- (id)loggingViewContainer;
- (void)setLoggingViewContainer:(id)arg1;
- (id)modeSpecificViewContainer;
- (void)setModeSpecificViewContainer:(id)arg1;
- (id)nonLauncherModeView;
- (void)setNonLauncherModeView:(id)arg1;
- (id)nonLauncherModeCommandTextField;
- (void)setNonLauncherModeCommandTextField:(id)arg1;
- (id)command;
- (BOOL)commandRunning;
- (id)canRunFilterPredicate;
- (void)setCanRunFilterPredicate:(id)arg1;
- (id)launcherModeViewController;
- (void)setLauncherModeViewController:(id)arg1;
- (id)loggingOptions;
- (void)setLoggingOptions:(id)arg1;
- (id)envVars;
- (void)setEnvVars:(id)arg1;
- (id)stdErr;
- (void)setStdErr:(id)arg1;

@end

#endif /* RunCommandController_h */
