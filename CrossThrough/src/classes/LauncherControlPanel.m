// LauncherControlPanel.m — CrossThrough
#import "LauncherControlPanel.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherControlPanel

+ (id)launcherWithControlPanel:(id)arg1 bottle:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r21 = [arg3 retain];
     *   r19 = [arg2 retain];
     *   r20 = [[self alloc] initWithControlPanel:r19 bottle:r21];
     *   [r21 release];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)initWithControlPanel:(id)arg1 bottle:(id)arg2 {
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
     *   r8 = sign_extend_64(*(int32_t *)ivar_offset(_controlPanel));
     *   objc_storeStrong(r0 + r8, *(self + r8));
     *   r0 = r20;
     *   return r0;
     */
    return nil;
}

- (id)tooltip {
    return self->_controlPanel;
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
     *   r19 = [[NSString stringWithFormat:@"%@ control panel %@", r3, r4] retain];
     *   [r21 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

@end
