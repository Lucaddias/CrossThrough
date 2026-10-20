// CXUpdater.m — CrossThrough
#import "CXUpdater.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXUpdater

+ (id)sharedUpdater {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [[NSBundle mainBundle] retain];
     *   r19 = [[self updaterForBundle:r20] retain];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)updaterForBundle:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [arg2 retain];
     *   r19 = r0;
     *   if (r0 == 0x0) {
     *   r19 = [[NSBundle mainBundle] retain];
     *   }
     *   r21 = *_sharedUpdaters;
     *   r22 = [[NSValue valueWithNonretainedObject:r19] retain];
     *   r21 = [[r21 objectForKey:r22] retain];
     *   [r22 release];
     *   if (r21 == 0x0) {
     *   r21 = [[objc_opt_class(r20) alloc] initForBundle:r19];
     *   }
     *   [r19 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)initForBundle:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)setUserAgentString {
    return;
}

- (BOOL)automaticallyChecksForUpdates {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self[0x1];
     *   r0 = [r0 automaticallyChecksForUpdates];
     *   return r0;
     */
    return NO;
}

- (void)setAutomaticallyChecksForUpdates:(BOOL)arg1 {
    return;
}

- (CGFloat)updateCheckInterval {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self[0x1];
     *   r0 = [r0 updateCheckInterval];
     *   return r0;
     */
    return 0.0;
}

- (void)checkForUpdates:(id)arg1 {
    return;
}

- (BOOL)validateMenuItem:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   if ([arg2 action] != @selector(checkForUpdates:)) {
     *   r0 = 0x1;
     *   }
     *   else {
     *   r0 = r19[0x1];
     *   r0 = [r0 canCheckForUpdates];
     *   }
     *   return r0;
     */
    return NO;
}

- (void)checkForUpdatesInBackground {
    return;
}

- (id)lastUpdateCheckDate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self[0x1];
     *   r0 = [r0 lastUpdateCheckDate];
     *   return r0;
     */
    return nil;
}

- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r19 = [arg2 retain];
     *   r21 = r20 + 0x20;
     *   r22 = objc_loadWeakRetained(r21);
     *   r23 = objc_opt_respondsToSelector();
     *   [r22 release];
     *   if ((r23 & 0x1) != 0x0) {
     *   r0 = objc_loadWeakRetained(r21);
     *   r21 = r0;
     *   r20 = [[r0 bestValidUpdateInAppcast:r19 forUpdater:r20] retain];
     *   [r21 release];
     *   }
     *   else {
     *   r20 = 0x0;
     *   }
     *   [r19 release];
     *   ... (2 more lines)
     */
    return nil;
}

- (void)updaterDidNotFindUpdate:(id)arg1 {
    return;
}

- (void)updater:(id)arg1 didAbortWithError:(id)arg2 {
    return;
}

- (void)updater:(id)arg1 userDidMakeChoice:(NSInteger)arg2 forUpdate:(id)arg3 state:(id)arg4 {
    return;
}

- (void)updater:(id)arg1 failedToDownloadUpdate:(id)arg2 error:(id)arg3 {
    return;
}

- (void)userDidCancelDownload:(id)arg1 {
    return;
}

- (void)setNotLicensed:(BOOL)arg1 {
    return;
}

- (void)standardUserDriverWillHandleShowingUpdate:(BOOL)arg1 forUpdate:(id)arg2 state:(id)arg3 {
    return;
}

- (void)standardUserDriverWillFinishUpdateSession {
    return;
}

- (id)delegate {
    return [objc_loadWeakRetained((id *)&self->_delegate) autorelease];
}

- (void)setDelegate:(id)arg1 {
    objc_storeWeak((id *)&self->_delegate, arg1);
}

- (void)setUpdateCheckInterval:(CGFloat)arg1 {
    self->_updateCheckInterval = arg1;
}

@end
