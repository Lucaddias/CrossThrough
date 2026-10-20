// LauncherDiskFolderTreeNode.h — CrossThrough
#ifndef LauncherDiskFolderTreeNode_h
#define LauncherDiskFolderTreeNode_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherFolderTreeNode.h"

@class LauncherDiskFolderTreeNode;
@class LauncherDiskFolder;

@interface LauncherDiskFolderTreeNode : LauncherFolderTreeNode
{
    LauncherDiskFolder * _launcherFolder;
}

// Instance Methods
- (BOOL)isOpenable;
- (BOOL)animateOpen;
- (id)url;
- (void)openWithErrorHandler:(id)arg1;
- (id)pasteboardWriter;
- (id)launcherFolder;
- (void)setLauncherFolder:(id)arg1;

@end

#endif /* LauncherDiskFolderTreeNode_h */
