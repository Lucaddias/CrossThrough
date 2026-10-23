// CXServer.h — CrossThrough
#ifndef CXServer_h
#define CXServer_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class CXServer;
@class ShutdownController;
@class DemoRegisterController;

@interface CXServer : CXObject <NSApplicationDelegate, NSObject, NSAlertDelegate, NSFileManagerDelegate>
{
    NSMenu * openRecent;
    NSMutableArray * pendingAppLaunches;
    NSTimer * launchFeedbackTimer;
    ShutdownController * shutdownController;
    DemoRegisterController * demoRegisterController;
    BOOL quitting;
    NSMutableDictionary * tasksInProgress;
    SCDynamicStoreRef systemDynamicStore;
    NSOperationQueue * backgroundQueue;
    NSOperation * startAppOp;
    NSDate * lastDemoNagTime;
    BOOL gotLaunchEvent;
    BOOL menusEnabled;
}

// Class Methods
+ (id)getCellarID;
+ (id)getAppSupportDir;
+ (id)getCachesDir;
+ (id)getDefaultBottleDir;
+ (id)getBottleDir;
+ (id)fileTypesForBottle:(id)arg1;

// Instance Methods
- (id)init;
- (void)dealloc;
- (id)demoRegisterController;
- (id)shutdownController;
- (void)doPeriodicDemoNagForCommand:(id)arg1 withArgs:(id)arg2;
- (void)demoCheck;
- (void)registerDemo:(id)arg1;
- (BOOL)menusEnabled;
- (void)setMenusEnabled:(BOOL)arg1;
- (void)continueFromDemoCheck;
- (id)startAppOp;
- (void)rosettaCheck;
- (void)applicationWillFinishLaunching:(id)arg1;
- (void)applicationDidFinishLaunching:(id)arg1;
- (void)checkForHelperUpdate;
- (void)registerForCooperativeActivation;
- (void)otherWineAppWillActivate:(id)arg1;
- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1;
- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3;
- (void)finishedLaunches;
- (void)updateLaunchNotify;
- (id)startLaunchNotify:(id)arg1;
- (void)noteTask:(id)arg1 forCommand:(id)arg2 args:(id)arg3;
- (void)modifyEnvironmentForCommandTask:(id)arg1;
- (void)forkExecCommand:(id)arg1;
- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2;
- (void)observeTaskTermination:(id)arg1;
- (void)observeTaskErrorOutput:(id)arg1;
- (void)runClient:(id)arg1 inBottle:(id)arg2;
- (void)showLicense:(id)arg1;
- (void)setEnvValue:(id)arg1 forKey:(id)arg2;
- (void)unsetEnvValueForKey:(id)arg1;
- (void)setHttpProxyEnvironmentVariableFromSystemConfiguration;
- (void)beginMonitoringSystemConfigurationProxy;
- (id)managedBottlePath;
- (void)setEnvironmentVariables;
- (BOOL)validateMenuItem:(id)arg1;
- (void)runCommand:(id)arg1;
- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 copyingItemAtURL:(id)arg3 toURL:(id)arg4;
- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 linkingItemAtURL:(id)arg3 toURL:(id)arg4;
- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 movingItemAtURL:(id)arg3 toURL:(id)arg4;
- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 removingItemAtURL:(id)arg3;
- (void)replyToApplicationShouldTerminateTrampoline:(id)arg1;
- (NSUInteger)applicationShouldTerminate:(id)arg1;
- (id)applicationIcon;
- (id)startedAppGateOp;
- (BOOL)application:(id)arg1 openFile:(id)arg2;
- (BOOL)applicationOpenUntitledFile:(id)arg1;
- (BOOL)applicationShouldOpenUntitledFile:(id)arg1;
- (BOOL)applicationShouldHandleReopen:(id)arg1 hasVisibleWindows:(BOOL)arg2;
- (void)openDocument:(id)arg1;
- (void)addToRecentItems:(id)arg1 bottle:(id)arg2;
- (id)makeBottleTaggedName:(id)arg1 withBottleName:(id)arg2;
- (void)updateRecentItemsMenu;
- (void)openRecent:(id)arg1;
- (void)clearRecent:(id)arg1;
- (void)processFirstRun:(BOOL)arg1;
- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2;

@end

#endif /* CXServer_h */
