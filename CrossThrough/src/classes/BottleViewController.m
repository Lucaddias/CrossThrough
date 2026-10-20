// BottleViewController.m — CrossThrough
#import "BottleViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BottleViewController

+ (id)keyPathsForValuesAffectingBottleDescription {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"bottle.currentDescription"];
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

- (void)dealloc {
    return;
}

- (void)viewDidLoad {
    return;
}

- (void)setBottle:(id)arg1 {
    return;
}

- (id)packageForBottle:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x50;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r19 = [[[CXSetupLib c4ProfilesClass] profilesSet] retain];
     *   if ((objc_opt_respondsToSelector() & 0x1) != 0x0) {
     *   r0 = [r19 contentsDict];
     *   r0 = [r0 retain];
     *   }
     *   else {
     *   r0 = [r19 retain];
     *   }
     *   r20 = r0;
     *   r0 = [r21 bottle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r23 = [[r0 appid] retain];
     *   r22 = [[NSString stringWithFormat:@"com.codeweavers.c4.%@", r3] retain];
     *   [r23 release];
     *   ... (9 more lines)
     */
    return nil;
}

- (void)reloadLaunchers {
    return;
}

- (void)updateDependencyButton {
    return;
}

- (void)updateQuitButton {
    return;
}

- (void)updateMenuItems {
    return;
}

- (void)resetMenuForNewBottle {
    return;
}

- (id)iconForControlPanel:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = [arg2 retain];
     *   if (*_iconForControlPanel:.onceToken != -0x1) {
     *   dispatch_once(_iconForControlPanel:.onceToken, ___block_literal_global);
     *   }
     *   r0 = [r19 valueForKey:@"exe"];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 lastPathComponent];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r22 = [[r0 lowercaseString] retain];
     *   [r21 release];
     *   [r20 release];
     *   r0 = *_iconForControlPanel:.iconsNamesByExe;
     *   r0 = [r0 objectForKeyedSubscript:r22];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   r20 = r0;
     *   ... (10 more lines)
     */
    return nil;
}

- (void)sortControlPanels:(id)arg1 {
    return;
}

- (void)addButtonForControlPanel:(id)arg1 index:(NSInteger)arg2 {
    return;
}

- (void)showControlPanelLoader:(BOOL)arg1 {
    return;
}

- (void)reloadControlPanels {
    return;
}

- (id)launcherNodesForLaunchers:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x130;
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
     *   r20 = self;
     *   var_60 = **___stack_chk_guard;
     *   r21 = [arg2 retain];
     *   r19 = [[NSMutableArray array] retain];
     *   var_120 = q0;
     *   var_110 = q0;
     *   r0 = [r21 retain];
     *   r21 = r0;
     *   r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
     *   if (r0 != 0x0) {
     *   r22 = r0;
     *   r26 = *var_110;
     *   ... (106 more lines)
     */
    return nil;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (void)leaveRating:(id)arg1 {
    return;
}

- (id)bottleDescription {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [self bottle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r19 = [[r0 currentDescription] retain];
     *   [r20 release];
     *   if ([r19 length] != 0x0) {
     *   r20 = [r19 retain];
     *   }
     *   else {
     *   r20 = 0x0;
     *   }
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleDescription:(id)arg1 {
    return;
}

- (void)iconCollectionViewControllerSelectionChanged:(id)arg1 {
    return;
}

- (void)runWithOptionsClicked:(id)arg1 {
    return;
}

- (void)runCommandClicked:(id)arg1 {
    return;
}

- (void)installIntoBottleClicked:(id)arg1 {
    return;
}

- (void)dependencyButtonClicked:(id)arg1 {
    return;
}

- (void)openCDriveClicked:(id)arg1 {
    return;
}

- (void)quitClicked:(id)arg1 {
    return;
}

- (void)deleteClicked:(id)arg1 {
    return;
}

- (void)graphicsOptionChanged:(id)arg1 {
    return;
}

- (void)vulkanOptionChanged:(id)arg1 {
    return;
}

- (void)dlssToggled:(id)arg1 {
    return;
}

- (void)msyncToggled:(id)arg1 {
    return;
}

- (void)highResolutionToggled:(id)arg1 {
    return;
}

- (void)previewToggled:(id)arg1 {
    return;
}

- (void)controlPanelButtonClicked:(id)arg1 {
    return;
}

- (void)bottleDescriptionDidEndEditing:(id)arg1 {
    return;
}

- (id)selectedApplication {
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
     *   r0 = [self installedSoftwareTableView];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r19 = [r0 clickedRow];
     *   [r21 release];
     *   if (r19 != -0x1) {
     *   r0 = [r20 installedSoftware];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 arrangedObjects];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r19 = [[r0 objectAtIndexedSubscript:r19] retain];
     *   [r21 release];
     *   [r20 release];
     *   }
     *   else {
     *   ... (4 more lines)
     */
    return nil;
}

- (BOOL)canUninstall {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self selectedApplication];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 release];
     *   if (r20 != 0x0) {
     *   r0 = [r19 selectedApplication];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 canUninstall];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 boolValue];
     *   [r20 release];
     *   [r19 release];
     *   r0 = r21;
     *   }
     *   else {
     *   ... (3 more lines)
     */
    return NO;
}

- (void)uninstallClicked:(id)arg1 {
    return;
}

- (BOOL)control:(id)arg1 textView:(id)arg2 doCommandBySelector:(SEL)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r2 = arg2;
     *   r0 = self;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = arg4;
     *   if (@selector(insertNewline:) == arg4) {
     *   r0 = [r2 retain];
     *   r20 = r0;
     *   r21 = [[r0 currentEditor] retain];
     *   [r20 endEditing:r21];
     *   [r20 release];
     *   r0 = [r21 release];
     *   }
     *   if (@selector(insertNewline:) == r19) {
     *   r0 = 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (BOOL)performDragOperation:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r21 = [[arg2 draggingPasteboard] retain];
     *   r20 = [[NSURL URLFromPasteboard:r21] retain];
     *   [r21 release];
     *   r21 = [[**_NSApp CXServer] retain];
     *   r22 = [[r20 path] retain];
     *   r0 = [self bottle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r23 = [[r0 name] retain];
     *   [r21 runClient:r22 inBottle:r23 withDialog:0x1];
     *   [r23 release];
     *   [r19 release];
     *   [r22 release];
     *   [r21 release];
     *   [r20 release];
     *   return 0x1;
     */
    return NO;
}

- (id)bottle {
    return self->_bottle;
}

- (id)observers {
    return self->_observers;
}

- (void)setObservers:(id)arg1 {
    return;
}

- (id)package {
    return self->_package;
}

- (void)setPackage:(id)arg1 {
    self->_package = arg1;
}

- (BOOL)canBeRated {
    return self->_canBeRated;
}

- (void)setCanBeRated:(BOOL)arg1 {
    self->_canBeRated = arg1;
}

- (id)iconCollectionViewController {
    return self->_iconCollectionViewController;
}

- (void)setIconCollectionViewController:(id)arg1 {
    self->_iconCollectionViewController = arg1;
}

- (id)iconCollectionView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_iconCollectionView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setIconCollectionView:(id)arg1 {
    return;
}

- (id)noAppsFoundLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_noAppsFoundLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNoAppsFoundLabel:(id)arg1 {
    return;
}

- (id)leaveRatingButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_leaveRatingButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setLeaveRatingButton:(id)arg1 {
    return;
}

- (id)controlPanelLaunchers {
    return self->_controlPanelLaunchers;
}

- (void)setControlPanelLaunchers:(id)arg1 {
    self->_controlPanelLaunchers = arg1;
}

- (id)runWithOptionsButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_runWithOptionsButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setRunWithOptionsButton:(id)arg1 {
    return;
}

- (id)runCommandButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_runCommandButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setRunCommandButton:(id)arg1 {
    return;
}

- (id)installIntoBottleButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installIntoBottleButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallIntoBottleButton:(id)arg1 {
    return;
}

- (id)openCDriveButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_openCDriveButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setOpenCDriveButton:(id)arg1 {
    return;
}

- (id)quitButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_quitButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setQuitButton:(id)arg1 {
    return;
}

- (id)deleteButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_deleteButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDeleteButton:(id)arg1 {
    return;
}

- (id)dependencyButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_dependencyButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDependencyButton:(id)arg1 {
    return;
}

- (id)graphicsOptionView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_graphicsOptionView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setGraphicsOptionView:(id)arg1 {
    return;
}

- (id)graphicsLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_graphicsLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setGraphicsLabel:(id)arg1 {
    return;
}

- (id)graphicsPopUpButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_graphicsPopUpButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setGraphicsPopUpButton:(id)arg1 {
    return;
}

- (id)autoGraphicsMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_autoGraphicsMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setAutoGraphicsMenuItem:(id)arg1 {
    return;
}

- (id)dxmtMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_dxmtMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDxmtMenuItem:(id)arg1 {
    return;
}

- (id)dxvkMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_dxvkMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDxvkMenuItem:(id)arg1 {
    return;
}

- (id)d3dMetalMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_d3dMetalMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setD3dMetalMenuItem:(id)arg1 {
    return;
}

- (id)wined3dMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_wined3dMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setWined3dMenuItem:(id)arg1 {
    return;
}

- (id)vulkanOptionView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_vulkanOptionView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setVulkanOptionView:(id)arg1 {
    return;
}

- (id)vulkanLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_vulkanLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setVulkanLabel:(id)arg1 {
    return;
}

- (id)vulkanPopUpButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_vulkanPopUpButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setVulkanPopUpButton:(id)arg1 {
    return;
}

- (id)moltenvkMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_moltenvkMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMoltenvkMenuItem:(id)arg1 {
    return;
}

- (id)mtlvkMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_mtlvkMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMtlvkMenuItem:(id)arg1 {
    return;
}

- (id)msyncLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_msyncLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMsyncLabel:(id)arg1 {
    return;
}

- (id)msyncSwitch {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_msyncSwitch);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMsyncSwitch:(id)arg1 {
    return;
}

- (id)msyncView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_msyncView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMsyncView:(id)arg1 {
    return;
}

- (id)dlssLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_dlssLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDlssLabel:(id)arg1 {
    return;
}

- (id)dlssSwitch {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_dlssSwitch);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDlssSwitch:(id)arg1 {
    return;
}

- (id)dlssView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_dlssView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDlssView:(id)arg1 {
    return;
}

- (id)highResolutionLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_highResolutionLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setHighResolutionLabel:(id)arg1 {
    return;
}

- (id)highResolutionSwitch {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_highResolutionSwitch);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setHighResolutionSwitch:(id)arg1 {
    return;
}

- (id)highResolutionView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_highResolutionView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setHighResolutionView:(id)arg1 {
    return;
}

- (id)previewLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_previewLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setPreviewLabel:(id)arg1 {
    return;
}

- (id)previewSwitch {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_previewSwitch);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setPreviewSwitch:(id)arg1 {
    return;
}

- (id)previewView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_previewView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setPreviewView:(id)arg1 {
    return;
}

- (id)controlPanelsSection {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_controlPanelsSection);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setControlPanelsSection:(id)arg1 {
    return;
}

- (id)controlPanelsLoadingView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_controlPanelsLoadingView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setControlPanelsLoadingView:(id)arg1 {
    return;
}

- (id)controlPanelsLoadingSpinner {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_controlPanelsLoadingSpinner);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setControlPanelsLoadingSpinner:(id)arg1 {
    return;
}

- (id)installedSoftwareTableView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installedSoftwareTableView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstalledSoftwareTableView:(id)arg1 {
    return;
}

- (id)installedSoftware {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installedSoftware);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstalledSoftware:(id)arg1 {
    return;
}

@end
