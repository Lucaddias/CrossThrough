// LauncherFolder.m — CrossThrough
#import "LauncherFolder.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherFolder

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)initWithName:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)copyWithZone:(void *)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = self;
     *   r0 = [[&var_10 super] copyWithZone:arg2];
     *   return r0;
     */
    return nil;
}

- (BOOL)isLeaf {
    return NO;
}

- (id)items {
    return self->_items;
}

- (void)setItems:(id)arg1 {
    return;
}

- (void)insertObject:(id)arg1 inItemsAtIndex:(NSUInteger)arg2 {
    return;
}

- (void)addLauncherItem:(id)arg1 {
    return;
}

- (id)description {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = self;
     *   r0 = [[&var_30 super] description];
     *   r21 = [r0 retain];
     *   r0 = [self items];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   [r0 count];
     *   r20 = [[NSString stringWithFormat:@"%@ item count %lu", r3, r4] retain];
     *   [r19 release];
     *   [r21 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

@end
