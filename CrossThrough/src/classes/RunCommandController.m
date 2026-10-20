// RunCommandController.m — CrossThrough
#import "RunCommandController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation RunCommandController

+ (BOOL)automaticallyNotifiesObserversOfSelectedBottle {
    return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfSelectedBottleIndexes {
    return NO;
}

+ (id)keyPathsForValuesAffectingCanRun {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_18 = **___stack_chk_guard;
     *   var_28 = @"launcher";
     *   r0 = [NSArray arrayWithObjects:&var_28 count:0x2];
     *   r20 = [r0 retain];
     *   r19 = [[NSSet setWithArray:r20] retain];
     *   r0 = [r20 release];
     *   if (**___stack_chk_guard != var_18) {
     *   __stack_chk_fail();
     *   }
     *   r0 = [r19 autorelease];
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

- (id)initWithFileToRun:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (void)setSelectedBottle:(id)arg1 {
    return;
}

- (void)setSelectedBottleIndexes:(id)arg1 {
    return;
}

- (void)browseForCommand:(id)arg1 {
    return;
}

- (void)runCommandPressed:(id)arg1 {
    return;
}

- (void)runCommand {
    return;
}

- (void)getStdout:(id)arg1 {
    return;
}

- (void)getStderr:(id)arg1 {
    return;
}

- (void)didTerminate:(id)arg1 {
    return;
}

- (void)commandComplete {
    return;
}

- (void)setCommand:(id)arg1 {
    return;
}

- (void)setCommandRunning:(BOOL)arg1 {
    self->_commandRunning = arg1;
}

- (id)bottleCollection {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXSetupLib bottleCollectionClass];
     *   r0 = [r0 sharedCollection];
     *   return r0;
     */
    return nil;
}

- (void)createIcon:(id)arg1 {
    return;
}

- (void)windowDidLoad {
    return;
}

- (void)windowWillClose:(id)arg1 {
    return;
}

- (BOOL)canRun {
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
     *   r0 = [self launcher];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   r20 = 0x1;
     *   }
     *   else {
     *   r0 = [r20 command];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   if ([r0 length] != 0x0) {
     *   r20 = 0x1;
     *   }
     *   [r21 release];
     *   }
     *   [r19 release];
     *   r0 = r20;
     *   ... (1 more lines)
     */
    return NO;
}

- (BOOL)supportsAVX {
    /*
     * Decompiled from CrossOver 26.3:
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r31 = r31 + 0xfffffffffffffff0;
     *   r0 = ___isPlatformVersionAtLeast(0x1, 0xf, 0x0, 0x0);
     *   if (r0 != 0x0) {
     *   r0 = 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (void)appendEnvVar:(id)arg1 {
    return;
}

- (void)metalHudSelected:(id)arg1 {
    return;
}

- (void)AVXSelected:(id)arg1 {
    return;
}

- (id)bottleArray {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleArray);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleArray:(id)arg1 {
    return;
}

- (id)selectedBottle {
    return self->_selectedBottle;
}

- (id)selectedBottleIndexes {
    return self->_selectedBottleIndexes;
}

- (id)failAlertAccessoryView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_failAlertAccessoryView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setFailAlertAccessoryView:(id)arg1 {
    return;
}

- (id)failAlertTextView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_failAlertTextView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setFailAlertTextView:(id)arg1 {
    return;
}

- (BOOL)enableLoggingChannelsControls {
    return self->_enableLoggingChannelsControls;
}

- (id)launcher {
    return self->_launcher;
}

- (void)setLauncher:(id)arg1 {
    self->_launcher = arg1;
}

- (id)loggingViewContainer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_loggingViewContainer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setLoggingViewContainer:(id)arg1 {
    return;
}

- (id)modeSpecificViewContainer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_modeSpecificViewContainer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setModeSpecificViewContainer:(id)arg1 {
    return;
}

- (id)nonLauncherModeView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_nonLauncherModeView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNonLauncherModeView:(id)arg1 {
    return;
}

- (id)nonLauncherModeCommandTextField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_nonLauncherModeCommandTextField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNonLauncherModeCommandTextField:(id)arg1 {
    return;
}

- (id)command {
    return self->_command;
}

- (BOOL)commandRunning {
    return self->_commandRunning;
}

- (id)canRunFilterPredicate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_canRunFilterPredicate)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setCanRunFilterPredicate:(id)arg1 {
    return;
}

- (id)launcherModeViewController {
    return self->_launcherModeViewController;
}

- (void)setLauncherModeViewController:(id)arg1 {
    self->_launcherModeViewController = arg1;
}

- (id)loggingOptions {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_loggingOptions)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setLoggingOptions:(id)arg1 {
    return;
}

- (id)envVars {
    return self->_envVars;
}

- (void)setEnvVars:(id)arg1 {
    return;
}

- (id)stdErr {
    return self->_stdErr;
}

- (void)setStdErr:(id)arg1 {
    return;
}

@end
