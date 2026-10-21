// FilteredTreeNode.m — CrossThrough
#import "FilteredTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation FilteredTreeNode

+ (id)keyPathsForValuesAffectingAncestors {
    return [NSSet setWithObject:@"parent"];
}

+ (id)keyPathsForValuesAffectingLeaf {
    return [NSSet setWithObject:@"children"];
}

+ (BOOL)automaticallyNotifiesObserversOfFilterPredicate {
    return NO;
}

- (id)init {
    return [super init];
}

- (void)dealloc {
    for (id child in self->_children) {
        [self abandonChild:child];
    }
    [self->_children release];
    [self->_filteredChildren release];
    [self->_filterPredicate release];
    objc_destroyWeak((id *)&self->_parent);
    [super dealloc];
}

- (id)ancestors {
    NSMutableArray *ancestors = [NSMutableArray array];
    id node = [self parent];
    while (node) {
        [ancestors addObject:node];
        node = [node parent];
    }
    return ancestors;
}

- (BOOL)isLeaf {
    return self->_children == nil;
}

- (id)children {
    return [[self->_children retain] autorelease];
}

- (void)setChildren:(id)arg1 {
    if (self->_children == arg1) {
        return;
    }
    BOOL wasLeaf = [self isLeaf];
    for (id child in self->_children) {
        [self abandonChild:child];
    }
    NSMutableArray *old = self->_children;
    self->_children = [arg1 mutableCopy];
    [old release];
    for (id child in self->_children) {
        [self adoptChild:child];
    }
    [self filterWithPredicate];
    if (wasLeaf != [self isLeaf]) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (void)insertObject:(id)arg1 inChildrenAtIndex:(NSUInteger)arg2 {
    BOOL wasLeaf = [self isLeaf];
    if (!self->_children) {
        self->_children = [[NSMutableArray alloc] init];
    }
    [self->_children insertObject:arg1 atIndex:arg2];
    [self adoptChild:arg1];
    if ([arg1 passesFilter]) {
        [self addObjectToFilteredChildren:arg1];
    }
    if (wasLeaf != [self isLeaf]) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (void)insertChildren:(id)arg1 atIndexes:(id)arg2 {
    BOOL wasLeaf = [self isLeaf];
    if (!self->_children) {
        self->_children = [[NSMutableArray alloc] init];
    }
    [self->_children insertObjects:arg1 atIndexes:arg2];
    for (id child in arg1) {
        [self adoptChild:child];
    }
    NSIndexSet *passing = [arg1 indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [obj passesFilter];
    }];
    if ([passing count] != 0) {
        NSArray *passingChildren = [arg1 objectsAtIndexes:passing];
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self->_filteredChildren count], [passing count])];
        [self insertFilteredChildren:passingChildren atIndexes:indexes];
    }
    if (wasLeaf != [self isLeaf]) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)arg1 {
    id child = [[self->_children objectAtIndex:arg1] retain];
    [self abandonChild:child];
    [self->_children removeObjectAtIndex:arg1];
    NSUInteger filteredIndex = [self->_filteredChildren indexOfObjectIdenticalTo:child];
    if (filteredIndex != NSNotFound) {
        [self removeObjectFromFilteredChildrenAtIndex:filteredIndex];
    }
    [child release];
}

- (void)removeChildrenAtIndexes:(id)arg1 {
    NSMutableIndexSet *filteredIndexes = [NSMutableIndexSet indexSet];
    [self->_children enumerateObjectsAtIndexes:arg1 options:0 usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self abandonChild:obj];
        NSUInteger filteredIndex = [self->_filteredChildren indexOfObjectIdenticalTo:obj];
        if (filteredIndex != NSNotFound) {
            [filteredIndexes addIndex:filteredIndex];
        }
    }];
    [self->_children removeObjectsAtIndexes:arg1];
    if ([filteredIndexes count] != 0) {
        [self removeFilteredChildrenAtIndexes:filteredIndexes];
    }
}

- (void)addObjectToChildren:(id)arg1 {
    [self insertObject:arg1 inChildrenAtIndex:[self->_children count]];
}

- (void)addChildrenFromArray:(id)arg1 {
    if ([arg1 count] != 0) {
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self->_children count], [arg1 count])];
        [self insertChildren:arg1 atIndexes:indexes];
    }
}

- (void)setFilterPredicate:(id)arg1 {
    if (self->_filterPredicate == arg1) {
        return;
    }
    if (arg1 && self->_filterPredicate && [arg1 isEqual:self->_filterPredicate]) {
        return;
    }
    BOOL passed = [self passesFilter];
    [self willChangeValueForKey:@"filterPredicate"];
    [self setFilterPredicateInternal:arg1];
    [self filterWithPredicate];
    [self didChangeValueForKey:@"filterPredicate"];
    if (passed != [self passesFilter]) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (void)setFilterPredicateInternal:(id)arg1 {
    if (self->_filterPredicate == arg1) {
        return;
    }
    if (arg1 && self->_filterPredicate && [arg1 isEqual:self->_filterPredicate]) {
        return;
    }
    [self->_filterPredicate release];
    self->_filterPredicate = [arg1 retain];
    for (id child in self->_children) {
        if (![child filtersSeparately]) {
            [child setFilterPredicateInternal:arg1];
        }
    }
}

- (id)filteredChildren {
    return [[self->_filteredChildren retain] autorelease];
}

- (void)setFilteredChildren:(id)arg1 {
    if (self->_filteredChildren == arg1) {
        return;
    }
    BOOL wasEmpty = [self->_filteredChildren count] == 0;
    BOOL isEmpty = [arg1 count] == 0;
    NSMutableArray *old = self->_filteredChildren;
    self->_filteredChildren = [arg1 mutableCopy];
    [old release];
    if (wasEmpty != isEmpty) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (void)insertObject:(id)arg1 inFilteredChildrenAtIndex:(NSUInteger)arg2 {
    if (!self->_filteredChildren) {
        self->_filteredChildren = [[NSMutableArray alloc] init];
    }
    [self->_filteredChildren insertObject:arg1 atIndex:arg2];
    if ([self->_filteredChildren count] == 1) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (void)insertFilteredChildren:(id)arg1 atIndexes:(id)arg2 {
    if ([arg1 count] == 0) {
        return;
    }
    if (!self->_filteredChildren) {
        self->_filteredChildren = [[NSMutableArray alloc] init];
    }
    [self->_filteredChildren insertObjects:arg1 atIndexes:arg2];
    if ([self->_filteredChildren count] == [arg1 count]) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (void)addObjectToFilteredChildren:(id)arg1 {
    [self insertObject:arg1 inFilteredChildrenAtIndex:[self->_filteredChildren count]];
}

- (void)removeObjectFromFilteredChildrenAtIndex:(NSUInteger)arg1 {
    [self->_filteredChildren removeObjectAtIndex:arg1];
    if (self->_filteredChildren && [self->_filteredChildren count] == 0) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (void)removeFilteredChildrenAtIndexes:(id)arg1 {
    if ([arg1 count] == 0) {
        return;
    }
    [self->_filteredChildren removeObjectsAtIndexes:arg1];
    if (self->_filteredChildren && [self->_filteredChildren count] == 0) {
        [[self parent] noteChildChangedPassesFilter:self];
    }
}

- (BOOL)passesFilter {
    NSPredicate *predicate = [self filterPredicate];
    if (!predicate) {
        return YES;
    }
    if ([self isLeaf]) {
        return [predicate evaluateWithObject:self];
    }
    // A folder passes when any of its children does.
    return [[self filteredChildren] count] != 0;
}

- (void)noteChildChangedPassesFilter:(id)arg1 {
    if (self->_insideFilterWithPredicate) {
        return;
    }
    NSUInteger index = self->_filteredChildren ? [self->_filteredChildren indexOfObjectIdenticalTo:arg1] : NSNotFound;
    BOOL passes = [arg1 passesFilter];
    if (index != NSNotFound && !passes) {
        [self removeObjectFromFilteredChildrenAtIndex:index];
    } else if (index == NSNotFound && passes) {
        [self addObjectToFilteredChildren:arg1];
    }
}

- (void)adoptChild:(id)arg1 {
    if (![arg1 filtersSeparately]) {
        [arg1 setFilterPredicate:[self filterPredicate]];
    }
    [arg1 setParent:self];
}

- (void)abandonChild:(id)arg1 {
    [arg1 setParent:nil];
    if (![arg1 filtersSeparately]) {
        [arg1 setFilterPredicate:nil];
    }
}

- (void)filterWithPredicate {
    BOOL wasInside = self->_insideFilterWithPredicate;
    self->_insideFilterWithPredicate = YES;

    NSMutableSet *passing = [NSMutableSet set];
    for (id child in self->_children) {
        [child filterWithPredicate];
        if ([child passesFilter]) {
            [passing addObject:child];
        }
    }

    // Keep the children that still pass where they are; collect the ones
    // that stopped passing, and append the newly passing ones.
    NSMutableIndexSet *toRemove = [NSMutableIndexSet indexSet];
    [self->_filteredChildren enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([passing containsObject:obj]) {
            [passing removeObject:obj];
        } else {
            [toRemove addIndex:idx];
        }
    }];
    if ([passing count] != 0) {
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self->_filteredChildren count], [passing count])];
        [self insertFilteredChildren:[passing allObjects] atIndexes:indexes];
    }
    if ([toRemove count] != 0) {
        [self removeFilteredChildrenAtIndexes:toRemove];
    }

    self->_insideFilterWithPredicate = wasInside;
}

- (id)filterPredicate {
    return self->_filterPredicate;
}

- (BOOL)filtersSeparately {
    return self->_filtersSeparately;
}

- (void)setFiltersSeparately:(BOOL)arg1 {
    self->_filtersSeparately = arg1;
}

- (id)parent {
    return [objc_loadWeakRetained((id *)&self->_parent) autorelease];
}

- (void)setParent:(id)arg1 {
    objc_storeWeak((id *)&self->_parent, arg1);
}

@end
