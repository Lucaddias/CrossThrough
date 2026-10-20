// BottleViewController.m — CrossThrough
#import "BottleViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BottleViewController

+ (id)keyPathsForValuesAffectingBottleDescription {
    return [NSSet setWithObject:@"bottle.currentDescription"];
}

- (id)init {
    self = [super initWithNibName:@"BottleView" bundle:nil];
    if (self) {
        self->_controlPanelLaunchers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    IconCollectionViewController *icvc = [[IconCollectionViewController alloc] init];
    [self setIconCollectionViewController:icvc];
    [icvc setDelegate:self];

    if (self->_iconCollectionView) {
        NSView *v = [icvc view];
        if (v) {
            [v setFrame:[self->_iconCollectionView bounds]];
            [v setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
            [self->_iconCollectionView setSubviews:@[v]];
        }
    }

    if (self->_controlPanelsLoadingSpinner) {
        [self->_controlPanelsLoadingSpinner setUsesThreadedAnimation:YES];
    }

    if (!self->_controlPanelLaunchers) {
        self->_controlPanelLaunchers = [[NSMutableArray alloc] init];
    }
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    if (self->_bottle != arg1) {
        [self willChangeValueForKey:@"bottle"];
        [self->_bottle release];
        self->_bottle = [arg1 retain];
        [self didChangeValueForKey:@"bottle"];

        [self reloadLaunchers];
        [self reloadControlPanels];
    }
}

- (void)reloadLaunchers {
    if (!self->_bottle) return;
    NSArray *apps = nil;
    if ([self->_bottle respondsToSelector:@selector(launchers)]) {
        apps = [self->_bottle launchers];
    }
    if (self->_iconCollectionViewController) {
        [self->_iconCollectionViewController setLaunchers:apps ?: @[]];
    }
    if (self->_noAppsFoundLabel) {
        [self->_noAppsFoundLabel setHidden:([apps count] > 0)];
    }
}

- (void)reloadControlPanels {
    if (!self->_bottle) return;
    if (self->_controlPanelsLoadingSpinner) {
        [self->_controlPanelsLoadingSpinner startAnimation:self];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *cpls = nil;
        if ([self->_bottle respondsToSelector:@selector(controlPanels)]) {
            cpls = [self->_bottle controlPanels];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_controlPanelLaunchers removeAllObjects];
            if (cpls) {
                [self->_controlPanelLaunchers addObjectsFromArray:cpls];
            }
            if (self->_controlPanelsLoadingSpinner) {
                [self->_controlPanelsLoadingSpinner stopAnimation:self];
            }
            if (self->_controlPanelsLoadingView) {
                [self->_controlPanelsLoadingView setHidden:YES];
            }
        });
    });
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
    if (self->_bottle && [self->_bottle respondsToSelector:@selector(setCurrentDescription:)]) {
        [self->_bottle setCurrentDescription:arg1 ?: @""];
    }
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

- (id)observers {
    return self->_observers;
}

- (void)setObservers:(id)arg1 {
    if (self->_observers != arg1) {
        [self->_observers release];
        self->_observers = [arg1 copy];
    }
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
    return objc_loadWeakRetained((id *)&self->_iconCollectionView);
}

- (void)setIconCollectionView:(id)arg1 {
    objc_storeWeak((id *)&self->_iconCollectionView, arg1);
}

- (id)noAppsFoundLabel {
    return objc_loadWeakRetained((id *)&self->_noAppsFoundLabel);
}

- (void)setNoAppsFoundLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_noAppsFoundLabel, arg1);
}

- (id)leaveRatingButton {
    return objc_loadWeakRetained((id *)&self->_leaveRatingButton);
}

- (void)setLeaveRatingButton:(id)arg1 {
    objc_storeWeak((id *)&self->_leaveRatingButton, arg1);
}

- (id)controlPanelLaunchers {
    return self->_controlPanelLaunchers;
}

- (void)setControlPanelLaunchers:(id)arg1 {
    self->_controlPanelLaunchers = arg1;
}

- (id)runWithOptionsButton {
    return objc_loadWeakRetained((id *)&self->_runWithOptionsButton);
}

- (void)setRunWithOptionsButton:(id)arg1 {
    objc_storeWeak((id *)&self->_runWithOptionsButton, arg1);
}

- (id)runCommandButton {
    return objc_loadWeakRetained((id *)&self->_runCommandButton);
}

- (void)setRunCommandButton:(id)arg1 {
    objc_storeWeak((id *)&self->_runCommandButton, arg1);
}

- (id)installIntoBottleButton {
    return objc_loadWeakRetained((id *)&self->_installIntoBottleButton);
}

- (void)setInstallIntoBottleButton:(id)arg1 {
    objc_storeWeak((id *)&self->_installIntoBottleButton, arg1);
}

- (id)openCDriveButton {
    return objc_loadWeakRetained((id *)&self->_openCDriveButton);
}

- (void)setOpenCDriveButton:(id)arg1 {
    objc_storeWeak((id *)&self->_openCDriveButton, arg1);
}

- (id)quitButton {
    return objc_loadWeakRetained((id *)&self->_quitButton);
}

- (void)setQuitButton:(id)arg1 {
    objc_storeWeak((id *)&self->_quitButton, arg1);
}

- (id)deleteButton {
    return objc_loadWeakRetained((id *)&self->_deleteButton);
}

- (void)setDeleteButton:(id)arg1 {
    objc_storeWeak((id *)&self->_deleteButton, arg1);
}

- (id)dependencyButton {
    return objc_loadWeakRetained((id *)&self->_dependencyButton);
}

- (void)setDependencyButton:(id)arg1 {
    objc_storeWeak((id *)&self->_dependencyButton, arg1);
}

- (id)graphicsOptionView {
    return objc_loadWeakRetained((id *)&self->_graphicsOptionView);
}

- (void)setGraphicsOptionView:(id)arg1 {
    objc_storeWeak((id *)&self->_graphicsOptionView, arg1);
}

- (id)graphicsLabel {
    return objc_loadWeakRetained((id *)&self->_graphicsLabel);
}

- (void)setGraphicsLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_graphicsLabel, arg1);
}

- (id)graphicsPopUpButton {
    return objc_loadWeakRetained((id *)&self->_graphicsPopUpButton);
}

- (void)setGraphicsPopUpButton:(id)arg1 {
    objc_storeWeak((id *)&self->_graphicsPopUpButton, arg1);
}

- (id)autoGraphicsMenuItem {
    return objc_loadWeakRetained((id *)&self->_autoGraphicsMenuItem);
}

- (void)setAutoGraphicsMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_autoGraphicsMenuItem, arg1);
}

- (id)dxmtMenuItem {
    return objc_loadWeakRetained((id *)&self->_dxmtMenuItem);
}

- (void)setDxmtMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_dxmtMenuItem, arg1);
}

- (id)dxvkMenuItem {
    return objc_loadWeakRetained((id *)&self->_dxvkMenuItem);
}

- (void)setDxvkMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_dxvkMenuItem, arg1);
}

- (id)d3dMetalMenuItem {
    return objc_loadWeakRetained((id *)&self->_d3dMetalMenuItem);
}

- (void)setD3dMetalMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_d3dMetalMenuItem, arg1);
}

- (id)wined3dMenuItem {
    return objc_loadWeakRetained((id *)&self->_wined3dMenuItem);
}

- (void)setWined3dMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_wined3dMenuItem, arg1);
}

- (id)vulkanOptionView {
    return objc_loadWeakRetained((id *)&self->_vulkanOptionView);
}

- (void)setVulkanOptionView:(id)arg1 {
    objc_storeWeak((id *)&self->_vulkanOptionView, arg1);
}

- (id)vulkanLabel {
    return objc_loadWeakRetained((id *)&self->_vulkanLabel);
}

- (void)setVulkanLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_vulkanLabel, arg1);
}

- (id)vulkanPopUpButton {
    return objc_loadWeakRetained((id *)&self->_vulkanPopUpButton);
}

- (void)setVulkanPopUpButton:(id)arg1 {
    objc_storeWeak((id *)&self->_vulkanPopUpButton, arg1);
}

- (id)moltenvkMenuItem {
    return objc_loadWeakRetained((id *)&self->_moltenvkMenuItem);
}

- (void)setMoltenvkMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_moltenvkMenuItem, arg1);
}

- (id)mtlvkMenuItem {
    return objc_loadWeakRetained((id *)&self->_mtlvkMenuItem);
}

- (void)setMtlvkMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_mtlvkMenuItem, arg1);
}

- (id)msyncLabel {
    return objc_loadWeakRetained((id *)&self->_msyncLabel);
}

- (void)setMsyncLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_msyncLabel, arg1);
}

- (id)msyncSwitch {
    return objc_loadWeakRetained((id *)&self->_msyncSwitch);
}

- (void)setMsyncSwitch:(id)arg1 {
    objc_storeWeak((id *)&self->_msyncSwitch, arg1);
}

- (id)msyncView {
    return objc_loadWeakRetained((id *)&self->_msyncView);
}

- (void)setMsyncView:(id)arg1 {
    objc_storeWeak((id *)&self->_msyncView, arg1);
}

- (id)dlssLabel {
    return objc_loadWeakRetained((id *)&self->_dlssLabel);
}

- (void)setDlssLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_dlssLabel, arg1);
}

- (id)dlssSwitch {
    return objc_loadWeakRetained((id *)&self->_dlssSwitch);
}

- (void)setDlssSwitch:(id)arg1 {
    objc_storeWeak((id *)&self->_dlssSwitch, arg1);
}

- (id)dlssView {
    return objc_loadWeakRetained((id *)&self->_dlssView);
}

- (void)setDlssView:(id)arg1 {
    objc_storeWeak((id *)&self->_dlssView, arg1);
}

- (id)highResolutionLabel {
    return objc_loadWeakRetained((id *)&self->_highResolutionLabel);
}

- (void)setHighResolutionLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_highResolutionLabel, arg1);
}

- (id)highResolutionSwitch {
    return objc_loadWeakRetained((id *)&self->_highResolutionSwitch);
}

- (void)setHighResolutionSwitch:(id)arg1 {
    objc_storeWeak((id *)&self->_highResolutionSwitch, arg1);
}

- (id)highResolutionView {
    return objc_loadWeakRetained((id *)&self->_highResolutionView);
}

- (void)setHighResolutionView:(id)arg1 {
    objc_storeWeak((id *)&self->_highResolutionView, arg1);
}

- (id)previewLabel {
    return objc_loadWeakRetained((id *)&self->_previewLabel);
}

- (void)setPreviewLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_previewLabel, arg1);
}

- (id)previewSwitch {
    return objc_loadWeakRetained((id *)&self->_previewSwitch);
}

- (void)setPreviewSwitch:(id)arg1 {
    objc_storeWeak((id *)&self->_previewSwitch, arg1);
}

- (id)previewView {
    return objc_loadWeakRetained((id *)&self->_previewView);
}

- (void)setPreviewView:(id)arg1 {
    objc_storeWeak((id *)&self->_previewView, arg1);
}

- (id)controlPanelsSection {
    return objc_loadWeakRetained((id *)&self->_controlPanelsSection);
}

- (void)setControlPanelsSection:(id)arg1 {
    objc_storeWeak((id *)&self->_controlPanelsSection, arg1);
}

- (id)controlPanelsLoadingView {
    return objc_loadWeakRetained((id *)&self->_controlPanelsLoadingView);
}

- (void)setControlPanelsLoadingView:(id)arg1 {
    objc_storeWeak((id *)&self->_controlPanelsLoadingView, arg1);
}

- (id)controlPanelsLoadingSpinner {
    return objc_loadWeakRetained((id *)&self->_controlPanelsLoadingSpinner);
}

- (void)setControlPanelsLoadingSpinner:(id)arg1 {
    objc_storeWeak((id *)&self->_controlPanelsLoadingSpinner, arg1);
}

- (id)installedSoftwareTableView {
    return objc_loadWeakRetained((id *)&self->_installedSoftwareTableView);
}

- (void)setInstalledSoftwareTableView:(id)arg1 {
    objc_storeWeak((id *)&self->_installedSoftwareTableView, arg1);
}

- (id)installedSoftware {
    return objc_loadWeakRetained((id *)&self->_installedSoftware);
}

- (void)setInstalledSoftware:(id)arg1 {
    objc_storeWeak((id *)&self->_installedSoftware, arg1);
}

@end
