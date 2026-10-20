// LauncherDiskFolder.m — CrossThrough
#import "LauncherDiskFolder.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherDiskFolder

+ (id)launcherWithFolderURL:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r19 = [[self alloc] initWithURL:r20];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)initWithURL:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)copyWithZone:(void *)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = self;
     *   r0 = [[&var_20 super] copyWithZone:arg2];
     *   r20 = r0;
     *   [r0 setUrl:self->_url];
     *   r0 = r20;
     *   return r0;
     */
    return nil;
}

- (id)icon {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [[NSWorkspace sharedWorkspace] retain];
     *   r0 = [self url];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r21 = [[r0 path] retain];
     *   r22 = [[r20 iconForFile:r21] retain];
     *   [r21 release];
     *   [r19 release];
     *   [r20 release];
     *   r0 = [r22 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)description {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = self;
     *   r0 = [[&var_30 super] description];
     *   r21 = [r0 retain];
     *   r19 = [[self url] retain];
     *   r20 = [[NSString stringWithFormat:@"%@ url %@", r3, r4] retain];
     *   [r19 release];
     *   [r21 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)url {
    return self->_url;
}

- (void)setUrl:(id)arg1 {
    if (self->_url != arg1) {
        [self->_url release];
        self->_url = [arg1 copy];
    }
}

@end
