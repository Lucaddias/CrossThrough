// helperServer.m — CrossThrough
#import "helperServer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static helperServer *_defaultHelperServerSingleton = nil;

@implementation helperServer

+ (id)defaultHelperServer {
    @synchronized (self) {
        if (!_defaultHelperServerSingleton) {
            _defaultHelperServerSingleton = [[helperServer alloc] init];
        }
        return _defaultHelperServerSingleton;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        self->isReady = NO;
    }
    return self;
}

- (id)getEnvironmentForXConnection {
    if (self->isReady) {
        NSDictionary *env = [[NSProcessInfo processInfo] environment];
        NSMutableDictionary *mutableEnv = [env mutableCopy];
        NSString *root = [(CXApplication *)NSApp crossOverRoot];
        if (root) {
            [mutableEnv setObject:root forKey:@"CX_ROOT"];
        }
        return [mutableEnv autorelease];
    }
    return nil;
}

- (void)setIsReady {
    self->isReady = YES;
}

- (BOOL)isServerReady {
    return self->isReady;
}

- (BOOL)isServerReadyForBottle:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = [arg2 retain];
     *   if (self[0x8] != 0x0) {
     *   r0 = [CXSetupLib bottleCollectionClass];
     *   r0 = [r0 sharedCollection];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [[r0 bottleWithName:r19] retain];
     *   [r21 release];
     *   if (r20 != 0x0) {
     *   if ([r20 isIsDisabled] != 0x0) {
     *   r20 = [[r20 name] retain];
     *   r19 = [[NSString stringWithFormat:@"Bottle \"%@\" is disabled.", r3] retain];
     *   [r20 release];
     *   r0 = [NSException exceptionWithName:@"HelperServerException" reason:r19 userInfo:0x0];
     *   r0 = [r0 retain];
     *   r0 = objc_retainAutorelease(r0);
     *   objc_exception_throw(r0);
     *   }
     *   ... (15 more lines)
     */
    return NO;
}

- (id)raiseWindowsWithTag:(NSInteger)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   [**_NSApp arrangeInFront:0x0];
     *   return;
     */
    return nil;
}

- (id)theConnection {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, 0x10, 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setTheConnection:(id)arg1 {
    return;
}

@end
