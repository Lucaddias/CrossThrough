// FilteredTreeNode.m — CrossThrough
#import "FilteredTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation FilteredTreeNode

+ (id)keyPathsForValuesAffectingAncestors {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"parent"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingLeaf {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"children"];
     *   return r0;
     */
    return nil;
}

+ (BOOL)automaticallyNotifiesObserversOfFilterPredicate {
    return NO;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (id)ancestors {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = [[NSMutableArray array] retain];
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_parent);
     *   if (r0 != 0x0) {
     *   r20 = r0;
     *   do {
     *   [r19 addObject:r20];
     *   r21 = [[r20 parent] retain];
     *   [r20 release];
     *   r20 = r21;
     *   } while (r21 != 0x0);
     *   }
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (BOOL)isLeaf {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   if (*(r0 + sign_extend_64(*(int32_t *)ivar_offset(_children))) == 0x0) {
     *   r0 = 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (id)children {
    return self->_children;
}

- (void)setChildren:(id)arg1 {
    return;
}

- (void)insertObject:(id)arg1 inChildrenAtIndex:(NSUInteger)arg2 {
    return;
}

- (void)insertChildren:(id)arg1 atIndexes:(id)arg2 {
    return;
}

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)arg1 {
    return;
}

- (void)removeChildrenAtIndexes:(id)arg1 {
    return;
}

- (void)addObjectToChildren:(id)arg1 {
    return;
}

- (void)addChildrenFromArray:(id)arg1 {
    return;
}

- (void)setFilterPredicate:(id)arg1 {
    return;
}

- (void)setFilterPredicateInternal:(id)arg1 {
    return;
}

- (id)filteredChildren {
    return self->_filteredChildren;
}

- (void)setFilteredChildren:(id)arg1 {
    return;
}

- (void)insertObject:(id)arg1 inFilteredChildrenAtIndex:(NSUInteger)arg2 {
    return;
}

- (void)insertFilteredChildren:(id)arg1 atIndexes:(id)arg2 {
    return;
}

- (void)addObjectToFilteredChildren:(id)arg1 {
    return;
}

- (void)removeObjectFromFilteredChildrenAtIndex:(NSUInteger)arg1 {
    return;
}

- (void)removeFilteredChildrenAtIndexes:(id)arg1 {
    return;
}

- (BOOL)passesFilter {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r0 = [self filterPredicate];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r21 isLeaf];
     *   r22 = r0;
     *   if ((r0 & 0x1) != 0x0) {
     *   if (([r21 isLeaf] & 0x1) == 0x0) {
     *   [r19 release];
     *   r0 = 0x0;
     *   }
     *   else {
     *   r0 = [r21 filterPredicate];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   ... (44 more lines)
     */
    return NO;
}

- (void)noteChildChangedPassesFilter:(id)arg1 {
    return;
}

- (void)adoptChild:(id)arg1 {
    return;
}

- (void)abandonChild:(id)arg1 {
    return;
}

- (void)filterWithPredicate {
    return;
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
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_parent);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setParent:(id)arg1 {
    return;
}

@end
