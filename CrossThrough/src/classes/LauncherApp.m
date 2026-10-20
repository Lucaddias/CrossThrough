// LauncherApp.m — CrossThrough
#import "LauncherApp.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherApp

+ (id)launcherWithURL:(id)arg1 {
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
     *   [r20 setBundleID:self->_bundleID];
     *   r0 = r20;
     *   return r0;
     */
    return nil;
}

- (void)launchWithErrorHandler:(id)arg1 {
    return;
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
    return;
}

- (id)bundleID {
    return self->_bundleID;
}

- (void)setBundleID:(id)arg1 {
    return;
}

- (NSUInteger)helperVersion {
    return self->_helperVersion;
}

- (void)setHelperVersion:(NSUInteger)arg1 {
    return;
}

@end
