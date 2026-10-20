// LoggingOption.m — CrossThrough
#import "LoggingOption.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LoggingOption

+ (id)loggingOptionWithName:(id)arg1 channels:(id)arg2 environment:(id)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r22 = [arg4 retain];
     *   r19 = [arg3 retain];
     *   r20 = [arg2 retain];
     *   r21 = [[self alloc] initWithName:r20 channels:r19 environment:r22];
     *   [r22 release];
     *   [r19 release];
     *   [r20 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)loggingOptionWithName:(id)arg1 channels:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r21 = [arg3 retain];
     *   r19 = [arg2 retain];
     *   r20 = [[self alloc] initWithName:r19 channels:r21 environment:**___NSArray0__];
     *   [r21 release];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)commonPresets {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_28 = *__NSConcreteStackBlock;
     *   if (*_commonPresets.onceToken != -0x1) {
     *   dispatch_once(_commonPresets.onceToken, &var_28);
     *   }
     *   r0 = *_commonPresets.presets;
     *   r0 = objc_retainAutoreleaseReturnValue(r0);
     *   return r0;
     */
    return nil;
}

- (id)initWithName:(id)arg1 channels:(id)arg2 environment:(id)arg3 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)name {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self[0x1];
     *   return r0;
     */
    return nil;
}

- (void)setName:(id)arg1 {
    return;
}

- (id)logChannels {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self[0x2];
     *   return r0;
     */
    return nil;
}

- (void)setLogChannels:(id)arg1 {
    return;
}

- (id)logEnvironment {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self[0x3];
     *   return r0;
     */
    return nil;
}

- (void)setLogEnvironment:(id)arg1 {
    return;
}

@end
