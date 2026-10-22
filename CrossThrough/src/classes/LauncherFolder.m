// LauncherFolder.m — CrossThrough
#import "LauncherFolder.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherFolder

- (id)init {
    return [self initWithName:nil];
}

- (id)initWithName:(id)arg1 {
    self = [super initWithName:arg1];
    if (self) {
        self->_items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [self->_items release];
    [super dealloc];
}

- (id)copyWithZone:(void *)arg1 {
    return [super copyWithZone:arg1];
}

- (BOOL)isLeaf {
    return NO;
}

- (id)items {
    return [[self->_items retain] autorelease];
}

- (void)setItems:(id)arg1 {
    NSMutableArray *old = self->_items;
    self->_items = [arg1 mutableCopy];
    [old release];
}

- (void)insertObject:(id)arg1 inItemsAtIndex:(NSUInteger)arg2 {
    [self->_items insertObject:arg1 atIndex:arg2];
}

- (void)addLauncherItem:(id)arg1 {
    [self insertObject:arg1 inItemsAtIndex:[self->_items count]];
}

- (id)description {
    return [NSString stringWithFormat:@"%@ item count %lu", [super description], (unsigned long)[[self items] count]];
}

@end
