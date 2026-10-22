// LauncherItem.m — CrossThrough
#import "LauncherItem.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherItem

- (id)init {
    return [self initWithName:nil];
}

- (id)initWithName:(id)arg1 {
    self = [super init];
    if (self) {
        self->_name = [arg1 copy];
    }
    return self;
}

- (void)dealloc {
    [self->_name release];
    [super dealloc];
}

- (id)copyWithZone:(void *)arg1 {
    LauncherItem *copy = [[[self class] allocWithZone:(NSZone *)arg1] init];
    [copy setName:self->_name];
    return copy;
}

- (id)icon {
    return nil;
}

- (id)bottle {
    return nil;
}

- (BOOL)isLeaf {
    return YES;
}

- (id)tooltip {
    return nil;
}

- (id)description {
    return [NSString stringWithFormat:@"%@ name %@ leaf %@", [super description], [self name], [self isLeaf] ? @"YES" : @"NO"];
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

@end
