// LauncherFolderTreeNode.h — CrossThrough
#ifndef LauncherFolderTreeNode_h
#define LauncherFolderTreeNode_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherTreeNode.h"

@class LauncherFolderTreeNode;

@interface LauncherFolderTreeNode : LauncherTreeNode

// Instance Methods
- (BOOL)isLeaf;

@end

#endif /* LauncherFolderTreeNode_h */
