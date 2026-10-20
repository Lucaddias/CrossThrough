// BottleNode.m — CrossThrough
#import "BottleNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BottleNode

+ (id)bottleNodeWithBottle:(id)arg1 {
    BottleNode *node = [[self alloc] init];
    [node setType:2];
    [node setBottle:arg1];
    return node;
}

+ (id)groupBottleNodeWithName:(id)arg1 {
    BottleNode *node = [[self alloc] init];
    [node setType:0];
    [node setName:arg1];
    return node;
}

+ (id)allBottlesBottleNode {
    BottleNode *node = [[self alloc] init];
    [node setType:1];
    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Home" value:@"Home" table:nil];
    [node setName:title];
    return node;
}

+ (id)installBottleNode {
    BottleNode *node = [[self alloc] init];
    [node setType:3];
    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Install" value:@"Install" table:nil];
    [node setName:title];
    return node;
}

+ (id)keyPathsForValuesAffectingName {
    return [NSSet setWithObject:@"bottle.changeableName"];
}

- (id)init {
    self = [super init];
    if (self) {
        self->_children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)image {
    if (self->_type == 1) {
        NSImage *img = [NSImage imageNamed:@"sf-symbols.house.fill"];
        if (!img) img = [NSImage imageNamed:NSImageNameHomeTemplate];
        return img;
    }
    if (self->_type == 3) {
        NSImage *img = [NSImage imageNamed:@"sf-symbols.plus.app.fill"];
        if (!img) img = [NSImage imageNamed:NSImageNameAddTemplate];
        return img;
    }
    return [NSImage imageNamed:NSImageNameCaution];
}

- (id)name {
    if (self->_bottle && [self->_bottle respondsToSelector:@selector(changeableName)]) {
        return [(id)self->_bottle changeableName];
    }
    return self->_name;
}

- (void)setName:(id)arg1 {
    if (self->_bottle && [self->_bottle respondsToSelector:@selector(rename:completionHandler:)]) {
        if (![[self name] isEqual:arg1]) {
            [(id)self->_bottle rename:arg1 completionHandler:^(id error) {
                id col = [[CXSetupLib bottleCollectionClass] sharedCollection];
                [col refresh];
            }];
        }
    } else {
        if (self->_name != arg1) {
            self->_name = [arg1 copy];
        }
    }
}

- (id)children {
    return self->_children;
}

- (void)setChildren:(id)arg1 {
    if (self->_children != arg1) {
        self->_children = [arg1 mutableCopy];
    }
}

- (void)insertObject:(id)arg1 inChildrenAtIndex:(NSUInteger)arg2 {
    [self->_children insertObject:arg1 atIndex:arg2];
}

- (void)insertChildren:(id)arg1 atIndexes:(id)arg2 {
    [self->_children insertObjects:arg1 atIndexes:arg2];
}

- (void)removeObjectFromChildrenAtIndex:(NSUInteger)arg1 {
    [self->_children removeObjectAtIndex:arg1];
}

- (void)removeChildrenAtIndexes:(id)arg1 {
    [self->_children removeObjectsAtIndexes:arg1];
}

- (void)replaceChildrenAtIndexes:(id)arg1 withChildren:(id)arg2 {
    [self->_children replaceObjectsAtIndexes:arg1 withObjects:arg2];
}

- (BOOL)isLeaf {
    return self->_type != 0;
}

- (NSInteger)type {
    return self->_type;
}

- (void)setType:(NSInteger)arg1 {
    self->_type = arg1;
}

- (void)setImage:(id)arg1 {
    self->_image = arg1;
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    self->_bottle = arg1;
}

- (NSInteger)sortPriority {
    return self->_sortPriority;
}

- (void)setSortPriority:(NSInteger)arg1 {
    self->_sortPriority = arg1;
}

@end
