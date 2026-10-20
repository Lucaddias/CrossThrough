// ControlPanelLauncherTreeNode.h — CrossThrough
#ifndef ControlPanelLauncherTreeNode_h
#define ControlPanelLauncherTreeNode_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherTreeNode.h"

@class ControlPanelLauncherTreeNode;

@interface ControlPanelLauncherTreeNode : LauncherTreeNode
{
    NSString * _persistentID;
    id _controlPanel;
}

// Class Methods
+ (id)keyPathsForValuesAffectingPersistentID;
+ (id)bottleNameFromPersistentID:(id)arg1;

// Instance Methods
- (BOOL)isOpenable;
- (id)persistentID;
- (BOOL)canBeFavorite;
- (void)openWithErrorHandler:(id)arg1;
- (id)controlPanel;
- (void)setControlPanel:(id)arg1;

@end

#endif /* ControlPanelLauncherTreeNode_h */
