// LauncherAppTreeNode.h — CrossThrough
#ifndef LauncherAppTreeNode_h
#define LauncherAppTreeNode_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherTreeNode.h"

@class LauncherAppTreeNode;
@class LauncherApp;

@interface LauncherAppTreeNode : LauncherTreeNode
{
    NSString * _persistentID;
    LauncherApp * _launcher;
}

// Class Methods
+ (id)fromLauncher:(id)arg1;
+ (id)keyPathsForValuesAffectingPersistentID;

// Instance Methods
- (BOOL)isOpenable;
- (BOOL)canRunCommands;
- (id)url;
- (id)persistentID;
- (BOOL)canBeFavorite;
- (void)openWithErrorHandler:(id)arg1;
- (id)pasteboardWriter;
- (id)launcher;
- (void)setLauncher:(id)arg1;

@end

#endif /* LauncherAppTreeNode_h */
