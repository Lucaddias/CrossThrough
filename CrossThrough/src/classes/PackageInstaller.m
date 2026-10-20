// PackageInstaller.m — CrossThrough
#import "PackageInstaller.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PackageInstaller

+ (id)keyPathsForValuesAffectingIsUnknownPackage {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"package"];
     *   return r0;
     */
    return nil;
}

- (id)initWithPackage:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (void)setSelectedPackage:(id)arg1 {
    return;
}

- (void)setSelectedBottle:(id)arg1 {
    return;
}

- (void)setInstallerSource:(id)arg1 {
    return;
}

- (void)setUnknownPackage:(id)arg1 {
    return;
}

- (BOOL)isUnknownPackage {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self package];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 packageid];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 isEqualToString:@"com.codeweavers.unknown"];
     *   [r20 release];
     *   [r19 release];
     *   r0 = r21;
     *   return r0;
     */
    return NO;
}

- (void)install {
    return;
}

- (void)cancel {
    return;
}

- (void)startInstallation {
    return;
}

- (void)selectInstaller:(id)arg1 {
    return;
}

- (void)selectBottleWithCompletion:(id)arg1 {
    return;
}

- (void)installOptions {
    return;
}

- (void)queueInstallOperationWithTaskStatus:(id)arg1 {
    return;
}

- (void)addTaskToQueue:(id)arg1 {
    return;
}

- (id)visibleTask {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x120;
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
     *   var_48 = **___stack_chk_guard;
     *   var_110 = q0;
     *   var_100 = q0;
     *   r0 = [self currentTasks];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
     *   r20 = r0;
     *   if (r0 != 0x0) {
     *   r24 = *var_100;
     *   while (true) {
     *   r25 = 0x0;
     *   while (true) {
     *   if (*var_100 != r24) {
     *   ... (47 more lines)
     */
    return nil;
}

- (id)currentTaskDescription {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [self visibleTask];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   r20 = [[r19 label] retain];
     *   }
     *   else {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [[r0 localizedStringForKey:@"In Process…" value:@"" table:0x0] retain];
     *   [r21 release];
     *   }
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)startDownloadProgressTimer {
    return;
}

- (void)stopDownloadProgressTimer {
    return;
}

- (void)updateDownloadProgress:(id)arg1 {
    return;
}

- (void)spoolAvailableTasks {
    return;
}

- (void)taskCompleted:(id)arg1 {
    return;
}

- (void)addBottleToInstallTask:(id)arg1 {
    return;
}

- (void)removeBottleFromInstallTask:(id)arg1 {
    return;
}

- (void)trackBottle:(id)arg1 {
    return;
}

- (void)stopTrackingBottle:(id)arg1 {
    return;
}

- (void)bottleLoadedInfo:(id)arg1 {
    return;
}

- (void)continueInstallation {
    return;
}

- (void)cancelTask:(id)arg1 {
    return;
}

- (void)installationOver {
    return;
}

- (void)addMountedVolumes {
    return;
}

- (void)observeMount:(id)arg1 {
    return;
}

- (void)observeUnmount:(id)arg1 {
    return;
}

- (void)autoPlayWithParsedAutorunFile:(id)arg1 {
    return;
}

- (void)updateProfiles {
    return;
}

- (void)updateInstallationNotes {
    return;
}

- (id)detailsFromDictionary:(id)arg1 withAction:(SEL)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_50 = r28;
     *   decomp_var_48 = r27;
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
     *   r31 = r31 + 0xffffffffffffffa0 - 0x1b0;
     *   r20 = arg3;
     *   var_60 = **___stack_chk_guard;
     *   r21 = [arg2 retain];
     *   r19 = [[NSMutableArray array] retain];
     *   var_1A0 = q0;
     *   var_190 = q0;
     *   r0 = [r21 retain];
     *   var_1F0 = r0;
     *   r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
     *   var_1F8 = r0;
     *   if (r0 != 0x0) {
     *   var_200 = *var_190;
     *   ... (84 more lines)
     */
    return nil;
}

- (id)detailsFromDictionary:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self detailsFromDictionary:arg2 withAction:0x0];
     *   return r0;
     */
    return nil;
}

- (void)updateSummaryDetails {
    return;
}

- (void)updateCompletionNotes {
    return;
}

- (void)displayNextFailureMessage {
    return;
}

- (void)profileChanged {
    return;
}

- (void)sourceChanged {
    return;
}

- (void)bottleCreateChanged {
    return;
}

- (void)bottleNewnameChanged {
    return;
}

- (void)bottleTemplateChanged {
    return;
}

- (void)bottleNameChanged {
    return;
}

- (void)categorizedAllBottles {
    return;
}

- (void)analyzedBottle:(id)arg1 {
    return;
}

- (id)delegate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_delegate);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDelegate:(id)arg1 {
    return;
}

- (id)installConfiguration {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self->_installConfiguration;
     *   return r0;
     */
    return nil;
}

- (void)setInstallConfiguration:(id)arg1 {
    return;
}

- (id)package {
    return self->_package;
}

- (void)setPackage:(id)arg1 {
    self->_package = arg1;
}

- (id)bottle {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottle);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottle:(id)arg1 {
    return;
}

- (id)currentTaskDownloadDescription {
    return self->_currentTaskDownloadDescription;
}

- (void)setCurrentTaskDownloadDescription:(id)arg1 {
    self->_currentTaskDownloadDescription = arg1;
}

- (NSInteger)installStepsCancelled {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self->_installStepsCancelled;
     *   return r0;
     */
    return 0;
}

- (void)setInstallStepsCancelled:(NSInteger)arg1 {
    return;
}

- (NSInteger)installStepsCompleted {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self->_installStepsCompleted;
     *   return r0;
     */
    return 0;
}

- (void)setInstallStepsCompleted:(NSInteger)arg1 {
    return;
}

- (NSInteger)installStepsSkipped {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self->_installStepsSkipped;
     *   return r0;
     */
    return 0;
}

- (void)setInstallStepsSkipped:(NSInteger)arg1 {
    return;
}

- (NSInteger)totalInstallSteps {
    return self->_totalInstallSteps;
}

- (void)setTotalInstallSteps:(NSInteger)arg1 {
    return;
}

- (id)completionNotes {
    return self->_completionNotes;
}

- (void)setCompletionNotes:(id)arg1 {
    return;
}

- (id)installationNotes {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self->_installationNotes;
     *   return r0;
     */
    return nil;
}

- (void)setInstallationNotes:(id)arg1 {
    return;
}

- (id)summaryDetails {
    return self->_summaryDetails;
}

- (void)setSummaryDetails:(id)arg1 {
    return;
}

- (NSInteger)status {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->_status;
     *   return r0;
     */
    return 0;
}

- (void)setStatus:(NSInteger)arg1 {
    return;
}

- (id)installEngine {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self->_installEngine;
     *   return r0;
     */
    return nil;
}

- (void)setInstallEngine:(id)arg1 {
    return;
}

- (id)installQueue {
    return self->_installQueue;
}

- (void)setInstallQueue:(id)arg1 {
    self->_installQueue = arg1;
}

- (id)currentTasks {
    return self->_currentTasks;
}

- (void)setCurrentTasks:(id)arg1 {
    self->_currentTasks = arg1;
}

- (id)failedTasks {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self->_failedTasks;
     *   return r0;
     */
    return nil;
}

- (void)setFailedTasks:(id)arg1 {
    return;
}

- (BOOL)cancelled {
    return self->_cancelled;
}

- (void)setCancelled:(BOOL)arg1 {
    self->_cancelled = arg1;
}

- (id)downloadUpdateTimer {
    return self->_downloadUpdateTimer;
}

- (void)setDownloadUpdateTimer:(id)arg1 {
    self->_downloadUpdateTimer = arg1;
}

- (id)bottleCollection {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

@end
