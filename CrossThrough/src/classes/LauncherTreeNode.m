// LauncherTreeNode.m — CrossThrough
#import "LauncherTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherTreeNode

+ (id)keyPathsForValuesAffectingLeaf {
    return [NSSet set];
}

+ (id)keyPathsForValuesAffectingSortOrderThenName {
    return [NSSet setWithObjects:@"sortOrder", @"name", nil];
}

+ (id)keyPathsForValuesAffectingSortOrderThenBottleName {
    return [NSSet setWithObjects:@"sortOrder", @"bottle.name", nil];
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
    return self->_bottle && [[self->_bottle appid] length] != 0;
}

- (void)openWithErrorHandler:(id)arg1 {
    [NSException raise:NSInternalInconsistencyException
                format:@"%s called; %@ is not openable", __PRETTY_FUNCTION__, NSStringFromClass([self class])];
}

- (id)pasteboardWriter {
    return nil;
}

- (id)sortOrderThenName {
    return self;
}

- (id)sortOrderThenBottleName {
    return self;
}

- (NSInteger)compareSortOrderThenName:(id)arg1 {
    if ([self sortOrder] < [arg1 sortOrder]) {
        return NSOrderedAscending;
    }
    if ([self sortOrder] > [arg1 sortOrder]) {
        return NSOrderedDescending;
    }
    return [[self name] localizedStandardCompare:[arg1 name]];
}

- (NSInteger)compareSortOrderThenBottleName:(id)arg1 {
    if ([self sortOrder] < [arg1 sortOrder]) {
        return NSOrderedAscending;
    }
    if ([self sortOrder] > [arg1 sortOrder]) {
        return NSOrderedDescending;
    }
    return [[[self bottle] name] localizedStandardCompare:[[arg1 bottle] name]];
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
    if (self->_bottle != arg1) {
        [self->_bottle release];
        self->_bottle = [arg1 retain];
    }
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
    return self->_sortOrder;
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

- (void)dealloc {
    [self->_name release];
    [self->_icon release];
    [self->_bottle release];
    [self->_tooltip release];
    [super dealloc];
}

@end
