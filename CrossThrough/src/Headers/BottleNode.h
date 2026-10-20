// BottleNode.h — CrossThrough
#ifndef BottleNode_h
#define BottleNode_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class BottleNode;

@interface BottleNode : CXObject
{
    NSString * _name;
    NSMutableArray * _children;
    NSInteger _type;
    NSInteger _sortPriority;
    NSImage * _image;
    BottleWrapper * _bottle;
}

// Class Methods
+ (id)bottleNodeWithBottle:(id)arg1;
+ (id)groupBottleNodeWithName:(id)arg1;
+ (id)allBottlesBottleNode;
+ (id)installBottleNode;
+ (id)keyPathsForValuesAffectingName;

// Instance Methods
- (id)init;
- (id)image;
- (id)name;
- (void)setName:(id)arg1;
- (void)setChildren:(id)arg1;
- (void)insertObject:(id)arg1 inChildrenAtIndex:(NSUInteger)arg2;
- (void)insertChildren:(id)arg1 atIndexes:(id)arg2;
- (void)removeObjectFromChildrenAtIndex:(NSUInteger)arg1;
- (void)removeChildrenAtIndexes:(id)arg1;
- (void)replaceChildrenAtIndexes:(id)arg1 withChildren:(id)arg2;
- (BOOL)isLeaf;
- (NSInteger)type;
- (void)setType:(NSInteger)arg1;
- (void)setImage:(id)arg1;
- (id)children;
- (id)bottle;
- (void)setBottle:(id)arg1;
- (NSInteger)sortPriority;
- (void)setSortPriority:(NSInteger)arg1;

@end

#endif /* BottleNode_h */
