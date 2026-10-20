// BottleMenuHandler.h — CrossThrough
#ifndef BottleMenuHandler_h
#define BottleMenuHandler_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class BottleMenuHandler;

@interface BottleMenuHandler : CXObject

// Class Methods
+ (void)deleteBottle:(id)arg1 withWindow:(id)arg2;
+ (void)deleteManagedBottle:(id)arg1 withWindow:(id)arg2 authorization:(id)arg3;
+ (void)duplicateBottle:(id)arg1 withWindow:(id)arg2;
+ (void)exportBottle:(id)arg1 withWindow:(id)arg2;
+ (void)installSoftwareIntoBottle:(id)arg1 withWindow:(id)arg2;
+ (void)installMissingDependencies:(id)arg1 withWindow:(id)arg2;
+ (void)openCDriveForBottle:(id)arg1;
+ (void)openShellForBottle:(id)arg1;
+ (void)publishBottle:(id)arg1 withWindow:(id)arg2;
+ (void)rateBottle:(id)arg1 withWindow:(id)arg2 isDeleting:(BOOL)arg3;
+ (void)runCommandInBottle:(id)arg1;
+ (void)runCommandInBottle:(id)arg1 withLauncher:(id)arg2;
+ (void)toggleDefaultBottle:(id)arg1;
+ (void)toggleMSyncForBottle:(id)arg1 withWindow:(id)arg2;
+ (void)toggleMSyncForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3;
+ (void)toggleHighResolutionForBottle:(id)arg1 withWindow:(id)arg2;
+ (void)toggleHighResolutionForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3;
+ (void)togglePreviewForBottle:(id)arg1 withWindow:(id)arg2;
+ (void)togglePreviewForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3;
+ (void)quitBottle:(id)arg1;
+ (void)forceQuitBottle:(id)arg1;

@end

#endif /* BottleMenuHandler_h */
