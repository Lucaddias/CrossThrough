// LauncherTreeNode.m — CrossThrough
#import "LauncherTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherTreeNode

+ (id)keyPathsForValuesAffectingLeaf {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet set];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingSortOrderThenName {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"sortOrder"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingSortOrderThenBottleName {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"sortOrder"];
     *   return r0;
     */
    return nil;
}

- (BOOL)isLeaf {
    return YES;
}

- (BOOL)isOpenable {
    return NO;
}

- (BOOL)canRunCommands {
    return NO;
}

- (BOOL)animateOpen {
    return YES;
}

- (BOOL)affectsAutoExpansion {
    return YES;
}

- (id)url {
    return nil;
}

- (id)persistentID {
    return nil;
}

- (BOOL)canBeFavorite {
    return NO;
}

- (BOOL)canBeRated {
    return self->_bottle;
}

- (void)openWithErrorHandler:(id)arg1 {
    return;
}

- (id)pasteboardWriter {
    return nil;
}

- (id)sortOrderThenName {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   return r0;
     */
    return nil;
}

- (id)sortOrderThenBottleName {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   return r0;
     */
    return nil;
}

- (NSInteger)compareSortOrderThenName:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r19 = [arg2 retain];
     *   if ([r20 sortOrder] < [r19 sortOrder]) {
     *   r20 = 0xffffffffffffffff;
     *   }
     *   else {
     *   if ([r20 sortOrder] > [r19 sortOrder]) {
     *   r20 = 0x1;
     *   }
     *   else {
     *   r21 = [[r20 name] retain];
     *   r22 = [[r19 name] retain];
     *   r20 = [r21 localizedStandardCompare:r22];
     *   [r22 release];
     *   [r21 release];
     *   }
     *   }
     *   [r19 release];
     *   ... (2 more lines)
     */
    return 0;
}

- (NSInteger)compareSortOrderThenBottleName:(id)arg1 {
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
     *   r20 = self;
     *   r19 = [arg2 retain];
     *   if ([r20 sortOrder] < [r19 sortOrder]) {
     *   r20 = 0xffffffffffffffff;
     *   }
     *   else {
     *   if ([r20 sortOrder] > [r19 sortOrder]) {
     *   r20 = 0x1;
     *   }
     *   else {
     *   r0 = [r20 bottle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r22 = [[r0 name] retain];
     *   r0 = [r19 bottle];
     *   r0 = [r0 retain];
     *   ... (12 more lines)
     */
    return 0;
}

- (id)name {
    return self->_name;
}

- (void)setName:(id)arg1 {
    if (self->_name != arg1) {
        [self->_name release];
        self->_name = [arg1 copy];
    }
}

- (id)icon {
    return self->_icon;
}

- (void)setIcon:(id)arg1 {
    if (self->_icon != arg1) {
        [self->_icon release];
        self->_icon = [arg1 copy];
    }
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    self->_bottle = arg1;
}

- (id)tooltip {
    return self->_tooltip;
}

- (void)setTooltip:(id)arg1 {
    if (self->_tooltip != arg1) {
        [self->_tooltip release];
        self->_tooltip = [arg1 copy];
    }
}

- (NSInteger)sortOrder {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->_sortOrder;
     *   return r0;
     */
    return 0;
}

- (void)setSortOrder:(NSInteger)arg1 {
    self->_sortOrder = arg1;
}

- (BOOL)showBottleName {
    return self->_showBottleName;
}

- (void)setShowBottleName:(BOOL)arg1 {
    self->_showBottleName = arg1;
}

@end
