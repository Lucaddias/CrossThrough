// LauncherItem.m — CrossThrough
#import "LauncherItem.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherItem

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
     *   r0 = objc_opt_class(self);
     *   r0 = [r0 allocWithZone:arg2];
     *   r0 = [r0 init];
     *   r19 = r0;
     *   [r0 setName:self->_name];
     *   r0 = r19;
     *   return r0;
     */
    return nil;
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
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x60;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_30 = self;
     *   r0 = [[&var_30 super] description];
     *   r21 = [r0 retain];
     *   r22 = [[self name] retain];
     *   r0 = [self isLeaf];
     *   r8 = @"NO";
     *   if (r0 != 0x0) {
     *   r8 = @"YES";
     *   }
     *   r19 = [[NSString stringWithFormat:@"%@ name %@ leaf %@", r3, r4, r5] retain];
     *   [r22 release];
     *   [r21 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
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
