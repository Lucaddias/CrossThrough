// LauncherTreeNode.h — CrossThrough
#ifndef LauncherTreeNode_h
#define LauncherTreeNode_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "FilteredTreeNode.h"

@class LauncherTreeNode;

@interface LauncherTreeNode : FilteredTreeNode
{
    BOOL _showBottleName;
    NSInteger _sortOrder;
    NSString * _name;
    NSImage * _icon;
    BottleWrapper * _bottle;
    NSString * _tooltip;
}

// Class Methods
+ (id)keyPathsForValuesAffectingLeaf;
+ (id)keyPathsForValuesAffectingSortOrderThenName;
+ (id)keyPathsForValuesAffectingSortOrderThenBottleName;

// Instance Methods
- (BOOL)isLeaf;
- (BOOL)isOpenable;
- (BOOL)canRunCommands;
- (BOOL)animateOpen;
- (BOOL)affectsAutoExpansion;
- (id)url;
- (id)persistentID;
- (BOOL)canBeFavorite;
- (BOOL)canBeRated;
- (void)openWithErrorHandler:(id)arg1;
- (id)pasteboardWriter;
- (id)sortOrderThenName;
- (id)sortOrderThenBottleName;
- (NSInteger)compareSortOrderThenName:(id)arg1;
- (NSInteger)compareSortOrderThenBottleName:(id)arg1;
- (id)name;
- (void)setName:(id)arg1;
- (id)icon;
- (void)setIcon:(id)arg1;
- (id)bottle;
- (void)setBottle:(id)arg1;
- (id)tooltip;
- (void)setTooltip:(id)arg1;
- (NSInteger)sortOrder;
- (void)setSortOrder:(NSInteger)arg1;
- (BOOL)showBottleName;
- (void)setShowBottleName:(BOOL)arg1;

@end

#endif /* LauncherTreeNode_h */
