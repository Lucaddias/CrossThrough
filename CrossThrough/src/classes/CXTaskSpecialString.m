// CXTaskSpecialString.m — CrossThrough
#import "CXTaskSpecialString.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXTaskSpecialString

- (id)initWithString:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)copy {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self copyWithZone:0x0];
     *   return r0;
     */
    return nil;
}

- (id)mutableCopy {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self mutableCopyWithZone:0x0];
     *   return r0;
     */
    return nil;
}

- (id)copyWithZone:(void *)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r19 = [self->realString copyWithZone:arg2];
     *   r20 = [[CXTaskSpecialString alloc] initWithString:r19];
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return nil;
}

- (id)mutableCopyWithZone:(void *)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r19 = [self->realString mutableCopyWithZone:arg2];
     *   r20 = [[CXTaskSpecialString alloc] initWithString:r19];
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return nil;
}

- (id)fileSystemRepresentation {
    return self->realString;
}

- (id)forwardingTargetForSelector:(SEL)arg1 {
    return self->realString;
}

@end
