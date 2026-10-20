// FilteredTreeNode.h — CrossThrough
#ifndef FilteredTreeNode_h
#define FilteredTreeNode_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class FilteredTreeNode;

@interface FilteredTreeNode : CXObject
{
    BOOL _insideFilterWithPredicate;
    NSMutableArray * _children;
    NSMutableArray * _filteredChildren;
    BOOL _filtersSeparately;
    NSPredicate * _filterPredicate;
    FilteredTreeNode * _parent;
}

// Class Methods
+ (id)keyPathsForValuesAffectingAncestors;
+ (id)keyPathsForValuesAffectingLeaf;
+ (BOOL)automaticallyNotifiesObserversOfFilterPredicate;

// Instance Methods
- (id)init;
- (void)dealloc;
- (id)ancestors;
- (BOOL)isLeaf;
- (id)children;
- (void)setChildren:(id)arg1;
- (void)insertObject:(id)arg1 inChildrenAtIndex:(NSUInteger)arg2;
- (void)insertChildren:(id)arg1 atIndexes:(id)arg2;
- (void)removeObjectFromChildrenAtIndex:(NSUInteger)arg1;
- (void)removeChildrenAtIndexes:(id)arg1;
- (void)addObjectToChildren:(id)arg1;
- (void)addChildrenFromArray:(id)arg1;
- (void)setFilterPredicate:(id)arg1;
- (void)setFilterPredicateInternal:(id)arg1;
- (id)filteredChildren;
- (void)setFilteredChildren:(id)arg1;
- (void)insertObject:(id)arg1 inFilteredChildrenAtIndex:(NSUInteger)arg2;
- (void)insertFilteredChildren:(id)arg1 atIndexes:(id)arg2;
- (void)addObjectToFilteredChildren:(id)arg1;
- (void)removeObjectFromFilteredChildrenAtIndex:(NSUInteger)arg1;
- (void)removeFilteredChildrenAtIndexes:(id)arg1;
- (BOOL)passesFilter;
- (void)noteChildChangedPassesFilter:(id)arg1;
- (void)adoptChild:(id)arg1;
- (void)abandonChild:(id)arg1;
- (void)filterWithPredicate;
- (id)filterPredicate;
- (BOOL)filtersSeparately;
- (void)setFiltersSeparately:(BOOL)arg1;
- (id)parent;
- (void)setParent:(id)arg1;

@end

#endif /* FilteredTreeNode_h */
