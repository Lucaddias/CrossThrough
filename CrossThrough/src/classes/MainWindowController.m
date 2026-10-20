// MainWindowController.m — CrossThrough
#import "MainWindowController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation MainWindowController

+ (void)initialize {
    return;
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

- (id)bottleNodes {
    return self->_bottleNodes;
}

- (void)setBottleNodes:(id)arg1 {
    return;
}

- (void)insertObject:(id)arg1 inBottleNodesAtIndex:(NSUInteger)arg2 {
    return;
}

- (void)removeObjectFromBottleNodesAtIndex:(NSUInteger)arg1 {
    return;
}

- (id)selectedBottleNode {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   var_28 = **___stack_chk_guard;
     *   r0 = [self bottleSourceView];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 clickedRow];
     *   [r20 release];
     *   if (r21 != -0x1) {
     *   r20 = [[r19 bottleSourceView] retain];
     *   r0 = [r19 bottleSourceView];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r21 = [[r20 itemAtRow:[r0 clickedRow]] retain];
     *   [r22 release];
     *   [r20 release];
     *   if (r21 != 0x0) {
     *   r0 = [r21 valueForKey:@"representedObject"];
     *   r0 = [r0 retain];
     *   ... (48 more lines)
     */
    return nil;
}

- (void)loadInfoForSelectedBottle {
    return;
}

- (void)updateMainContentView {
    return;
}

- (id)privateBottlesGroupNameNoPublished {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 localizedStringForKey:@"BOTTLES" value:@"" table:0x0] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)windowDidLoad {
    return;
}

- (NSUInteger)window:(id)arg1 willUseFullScreenPresentationOptions:(NSUInteger)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = arg3 | 0x800;
     *   return r0;
     */
    return 0;
}

- (void)selectLaunchView {
    return;
}

- (void)selectInstallView {
    return;
}

- (void)selectDefaultView {
    return;
}

- (void)updateC4Ps {
    return;
}

- (void)autoPlay:(id)arg1 inBottle:(id)arg2 {
    return;
}

- (void)autoPlayWithAutorunFile:(id)arg1 inBottle:(id)arg2 {
    return;
}

- (void)addIconsForBottles:(id)arg1 {
    return;
}

- (BOOL)isPreview {
    return NO;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (BOOL)outlineView:(id)arg1 isGroupItem:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [arg3 representedObject];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if ([r0 type] == 0x0) {
     *   r20 = 0x1;
     *   }
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return NO;
}

- (BOOL)outlineView:(id)arg1 shouldShowOutlineCellForItem:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self outlineView:arg2 isGroupItem:arg3];
     *   r0 = r0 ^ 0x1;
     *   return r0;
     */
    return NO;
}

- (BOOL)outlineView:(id)arg1 shouldSelectItem:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self outlineView:arg2 isGroupItem:arg3];
     *   r0 = r0 ^ 0x1;
     *   return r0;
     */
    return NO;
}

- (void)outlineView:(id)arg1 didRemoveRowView:(id)arg2 forRow:(NSInteger)arg3 {
    return;
}

- (void)outlineViewSelectionDidChange:(id)arg1 {
    return;
}

- (id)outlineView:(id)arg1 rowViewForItem:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [[BottleTableRowView alloc] init];
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)outlineView:(id)arg1 viewForTableColumn:(id)arg2 item:(id)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r9 = arg2;
     *   r8 = self;
     *   if (arg3 != 0x0) {
     *   r2 = @"DataCell";
     *   }
     *   else {
     *   r2 = @"HeaderCell";
     *   }
     *   r0 = [r9 makeViewWithIdentifier:r2 owner:r8];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 textField];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 setAutoresizingMask:0x0];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (BOOL)validateUserInterfaceItem:(id)arg1 {
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
     *   if ([r0 action] != @selector(duplicateBottle:)) {
     *   if ([r19 action] != @selector(toggleDefaultBottle:)) {
     *   if ([r19 action] != @selector(deleteBottle:)) {
     *   if ([r19 action] != @selector(exportBottleToArchive:)) {
     *   if ([r19 action] != @selector(openBottleCDrive:)) {
     *   if ([r19 action] != @selector(renameBottle:)) {
     *   if ([r19 action] != @selector(publishBottle:)) {
     *   if ([r19 action] != @selector(toggleBottleHighResolution:)) {
     *   if ([r19 action] != @selector(toggleBottleGraphicsAuto:)) {
     *   if ([r19 action] != @selector(toggleBottleGraphicsD3DMetal:)) {
     *   if ([r19 action] != @selector(toggleBottleGraphicsDXMT:)) {
     *   if ([r19 action] != @selector(toggleBottleGraphicsDXVK:)) {
     *   if ([r19 action] != @selector(toggleBottleVulkanMoltenVK:)) {
     *   if ([r19 action] != @selector(toggleBottleVulkanMTLVK:)) {
     *   if ([r19 action] != @selector(toggleBottleDLSS:)) {
     *   ... (525 more lines)
     */
    return NO;
}

- (void)setMenuItem:(id)arg1 genericTitle:(id)arg2 bottleTitleFormat:(id)arg3 {
    return;
}

- (void)menuNeedsUpdate:(id)arg1 {
    return;
}

- (void)menuWillOpen:(id)arg1 {
    return;
}

- (BOOL)validateMenuItem:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r2 = arg2;
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
     *   r20 = self;
     *   r19 = [r2 retain];
     *   r0 = **_NSApp;
     *   r0 = [r0 modalWindow];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   r22 = r0;
     *   r21 = 0x0;
     *   [r22 release];
     *   }
     *   else {
     *   r0 = [r20 window];
     *   r0 = [r0 retain];
     *   ... (336 more lines)
     */
    return NO;
}

- (void)revealNewBottle:(id)arg1 {
    return;
}

- (void)newBottle:(id)arg1 {
    return;
}

- (void)duplicateBottle:(id)arg1 {
    return;
}

- (void)renameBottle:(id)arg1 {
    return;
}

- (void)deleteBottle:(id)arg1 {
    return;
}

- (void)openBottleCDrive:(id)arg1 {
    return;
}

- (void)exportBottleToArchive:(id)arg1 {
    return;
}

- (void)importBottleArchiveFromURL:(id)arg1 {
    return;
}

- (void)importBottleArchive:(id)arg1 {
    return;
}

- (void)showInstallViewWithSelectedBottle:(id)arg1 package:(id)arg2 {
    return;
}

- (void)showInstallViewWithSelectedBottle:(id)arg1 {
    return;
}

- (void)publishBottle:(id)arg1 {
    return;
}

- (void)toggleDefaultBottle:(id)arg1 {
    return;
}

- (void)toggleBottleGraphicsAuto:(id)arg1 {
    return;
}

- (void)toggleBottleGraphicsD3DMetal:(id)arg1 {
    return;
}

- (void)toggleBottleGraphicsDXMT:(id)arg1 {
    return;
}

- (void)toggleBottleGraphicsDXVK:(id)arg1 {
    return;
}

- (void)toggleBottleGraphicsWine:(id)arg1 {
    return;
}

- (void)toggleBottleVulkanMoltenVK:(id)arg1 {
    return;
}

- (void)toggleBottleVulkanMTLVK:(id)arg1 {
    return;
}

- (void)toggleBottleDLSS:(id)arg1 {
    return;
}

- (void)toggleBottleMSync:(id)arg1 {
    return;
}

- (void)toggleBottleHighResolution:(id)arg1 {
    return;
}

- (void)toggleBottlePreview:(id)arg1 {
    return;
}

- (void)updateBottle:(id)arg1 {
    return;
}

- (void)installSoftwareToBottle:(id)arg1 {
    return;
}

- (void)runCommandInBottle:(id)arg1 {
    return;
}

- (void)openShellForBottle:(id)arg1 {
    return;
}

- (void)quitBottle:(id)arg1 {
    return;
}

- (void)forceQuitBottle:(id)arg1 {
    return;
}

- (id)bottleViewController {
    return self->_bottleViewController;
}

- (void)setBottleViewController:(id)arg1 {
    self->_bottleViewController = arg1;
}

- (id)iconViewController {
    return self->_iconViewController;
}

- (void)setIconViewController:(id)arg1 {
    self->_iconViewController = arg1;
}

- (id)packageViewController {
    return self->_packageViewController;
}

- (void)setPackageViewController:(id)arg1 {
    self->_packageViewController = arg1;
}

- (id)mainContentView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_mainContentView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMainContentView:(id)arg1 {
    return;
}

- (id)splitView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_splitView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setSplitView:(id)arg1 {
    return;
}

- (id)topMenuNodes {
    return self->_topMenuNodes;
}

- (void)setTopMenuNodes:(id)arg1 {
    return;
}

- (id)bottomMenuNodes {
    return self->_bottomMenuNodes;
}

- (void)setBottomMenuNodes:(id)arg1 {
    return;
}

- (id)topMenuSourceView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_topMenuSourceView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setTopMenuSourceView:(id)arg1 {
    return;
}

- (id)bottomMenuSourceView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottomMenuSourceView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottomMenuSourceView:(id)arg1 {
    return;
}

- (id)topMenuTreeController {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_topMenuTreeController);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setTopMenuTreeController:(id)arg1 {
    return;
}

- (id)bottomMenuTreeController {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottomMenuTreeController);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottomMenuTreeController:(id)arg1 {
    return;
}

- (id)bottleSourceView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleSourceView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleSourceView:(id)arg1 {
    return;
}

- (id)bottleTreeController {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleTreeController);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleTreeController:(id)arg1 {
    return;
}

- (id)privateBottleGroup {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_privateBottleGroup)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setPrivateBottleGroup:(id)arg1 {
    return;
}

- (id)publishedBottleGroup {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_publishedBottleGroup)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setPublishedBottleGroup:(id)arg1 {
    return;
}

- (BOOL)updating {
    return self->_updating;
}

- (void)setUpdating:(BOOL)arg1 {
    self->_updating = arg1;
}

@end
