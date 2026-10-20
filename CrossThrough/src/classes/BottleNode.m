// BottleNode.m — CrossThrough
#import "BottleNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BottleNode

+ (id)bottleNodeWithBottle:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r0 = [[self alloc] init];
     *   r19 = r0;
     *   [r0 setType:0x2];
     *   [r19 setBottle:r20];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)groupBottleNodeWithName:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r0 = [[self alloc] init];
     *   r19 = r0;
     *   [r0 setType:0x0];
     *   [r19 setName:r20];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)allBottlesBottleNode {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [[self alloc] init];
     *   r19 = r0;
     *   [r0 setType:0x1];
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 localizedStringForKey:@"Home" value:@"" table:0x0] retain];
     *   [r19 setName:r21];
     *   [r21 release];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)installBottleNode {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [[self alloc] init];
     *   r19 = r0;
     *   [r0 setType:0x3];
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 localizedStringForKey:@"Install" value:@"" table:0x0] retain];
     *   [r19 setName:r21];
     *   [r21 release];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingName {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"bottle.changeableName"];
     *   return r0;
     */
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)image {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   if ([self type] == 0x1) {
     *   r2 = @"sf-symbols.house.fill";
     *   }
     *   else {
     *   if ([r19 type] == 0x3) {
     *   r2 = @"sf-symbols.plus.app.fill";
     *   }
     *   else {
     *   r2 = **_NSImageNameCaution;
     *   }
     *   }
     *   r0 = [NSImage imageNamed:r2];
     *   r0 = [r0 retain];
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)name {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r31 = r31 + 0xfffffffffffffff0;
     *   r8 = sign_extend_64(*(int32_t *)ivar_offset(_bottle));
     *   r8 = *(r0 + r8);
     *   if (r8 != 0x0) {
     *   r0 = [r8 changeableName];
     *   r0 = [r0 retain];
     *   }
     *   else {
     *   r0 = r0->_name;
     *   r0 = [r0 retain];
     *   }
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setName:(id)arg1 {
    return;
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

- (void)replaceChildrenAtIndexes:(id)arg1 withChildren:(id)arg2 {
    return;
}

- (BOOL)isLeaf {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   if (*(int32_t *)(r0 + sign_extend_64(*(int32_t *)ivar_offset(_type))) != 0x0) {
     *   r0 = 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (NSInteger)type {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->_type;
     *   return r0;
     */
    return 0;
}

- (void)setType:(NSInteger)arg1 {
    return;
}

- (void)setImage:(id)arg1 {
    return;
}

- (id)children {
    return self->_children;
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    self->_bottle = arg1;
}

- (NSInteger)sortPriority {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->_sortPriority;
     *   return r0;
     */
    return 0;
}

- (void)setSortPriority:(NSInteger)arg1 {
    return;
}

@end
