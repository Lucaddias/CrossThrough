// helperServer.m — CrossThrough
#import "helperServer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation helperServer

+ (id)defaultHelperServer {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = objc_opt_class(@class(helperServer));
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   objc_sync_enter(r0);
     *   if (*_singleton == 0x0) {
     *   r0 = [[helperServer alloc] init];
     *   r8 = *_singleton;
     *   *_singleton = r0;
     *   [r8 release];
     *   }
     *   objc_sync_exit(r19);
     *   [r19 release];
     *   r0 = *_singleton;
     *   r0 = objc_retainAutoreleaseReturnValue(r0);
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

- (id)getEnvironmentForXConnection {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   if (self[0x8] != 0x0) {
     *   r0 = [NSProcessInfo processInfo];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 environment];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r19 = [r0 mutableCopy];
     *   [r21 release];
     *   [r20 release];
     *   r20 = [[**_NSApp crossOverRoot] retain];
     *   [r19 setObject:r20 forKey:@"CX_ROOT"];
     *   [r20 release];
     *   }
     *   else {
     *   r19 = 0x0;
     *   }
     *   r0 = [r19 autorelease];
     *   ... (1 more lines)
     */
    return nil;
}

- (void)setIsReady {
    return;
}

- (BOOL)isServerReady {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self[0x8];
     *   return r0;
     */
    return NO;
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
    return [[self->_theConnection retain] autorelease];
}

- (void)setTheConnection:(id)arg1 {
    if (self->_theConnection != arg1) {
        [self->_theConnection release];
        self->_theConnection = [arg1 retain];
    }
}

@end
