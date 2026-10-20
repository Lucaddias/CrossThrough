// PreferencesController.m — CrossThrough
#import "PreferencesController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PreferencesController

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (void)windowDidLoad {
    return;
}

- (void)updateC4PModDate {
    return;
}

- (void)windowWillLoad {
    return;
}

- (void)bottlesFolderChanged:(id)arg1 {
    return;
}

- (void)resetBottlesFolder:(id)arg1 {
    return;
}

- (void)browseForBottlesFolder:(id)arg1 {
    return;
}

- (void)programsFolderChanged:(id)arg1 {
    return;
}

- (void)resetProgramsFolder:(id)arg1 {
    return;
}

- (void)browseForProgramsFolder:(id)arg1 {
    return;
}

- (BOOL)panel:(id)arg1 isValidFilename:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x60;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = [arg3 retain];
     *   r0 = [NSFileManager defaultManager];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r19 = [r0 isWritableFileAtPath:r20];
     *   [r20 release];
     *   [r21 release];
     *   if ((r19 & 0x1) == 0x0) {
     *   r0 = [[NSAlert alloc] init];
     *   r20 = r0;
     *   [r0 setAlertStyle:0x1];
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   ... (25 more lines)
     */
    return NO;
}

- (id)installerCacheSizeStringWhileCalculating {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 localizedStringForKey:@"Calculating…" value:@"" table:0x0] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)enumerateCachedInstallersWithBlock:(id)arg1 {
    return;
}

- (void)calculateInstallerCacheSize {
    return;
}

- (void)installersCacheEventStreamCallback {
    return;
}

- (void)clearInstallerCache:(id)arg1 {
    return;
}

- (void)openInstallerCache:(id)arg1 {
    return;
}

- (id)installerCacheSizeLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installerCacheSizeLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallerCacheSizeLabel:(id)arg1 {
    return;
}

- (id)bottlesFolderURL {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottlesFolderURL)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setBottlesFolderURL:(id)arg1 {
    return;
}

- (id)programsFolderURL {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_programsFolderURL)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setProgramsFolderURL:(id)arg1 {
    return;
}

- (id)lastUpdated {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_lastUpdated)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setLastUpdated:(id)arg1 {
    return;
}

@end
