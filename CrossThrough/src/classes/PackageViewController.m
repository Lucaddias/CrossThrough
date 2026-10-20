// PackageViewController.m — CrossThrough
#import "PackageViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PackageViewController

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

- (void)viewDidAppear {
    return;
}

- (void)viewDidDisappear {
    return;
}

- (id)packageForCategory:(id)arg1 root:(id)arg2 cache:(id)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   r31 = r31 + 0xffffffffffffffb0;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r24 = self;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   r0 = [arg4 retain];
     *   r21 = r0;
     *   r0 = [r0 objectForKey:r19];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   if (r0 == 0x0) {
     *   r23 = [[r19 lastObject] retain];
     *   r22 = [[PackageTreeNode alloc] initWithCategoryID:r23 name:r23 children:0x0 sortKey:r23];
     *   if ([r19 count] == 0x1) {
     *   r24 = [r20 retain];
     *   }
     *   ... (20 more lines)
     */
    return nil;
}

- (void)populatePackages {
    return;
}

- (void)loadIcons {
    return;
}

- (void)setInstaller:(id)arg1 {
    return;
}

- (void)setSelectedBottle:(id)arg1 {
    return;
}

- (void)setSelectedPackage:(id)arg1 {
    return;
}

- (void)updateVisiblePackages {
    return;
}

- (void)setSortDescriptors:(id)arg1 {
    self->_sortDescriptors = arg1;
}

- (void)setFilterPredicate:(id)arg1 {
    self->_filterPredicate = arg1;
}

- (void)updateSummaryDetails {
    return;
}

- (void)openInstallerView {
    return;
}

- (void)optionsButtonClicked:(id)arg1 {
    return;
}

- (void)autoPlay:(id)arg1 {
    return;
}

- (void)autoPlayWithParsedFile:(id)arg1 {
    return;
}

- (void)autoPlayWithAutorunFile:(id)arg1 {
    return;
}

- (void)prepareDropinC4pAndAutorun:(id)arg1 {
    return;
}

- (void)displayLoadingSheetAndPrepareCrossTie:(id)arg1 {
    return;
}

- (void)displayEmptyFileAlert:(id)arg1 {
    return;
}

- (void)displayRevokedFileAlert:(id)arg1 {
    return;
}

- (NSInteger)numberOfSectionsInCollectionView:(id)arg1 {
    return 1;
}

- (NSInteger)collectionView:(id)arg1 numberOfItemsInSection:(NSInteger)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self visiblePackages];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [r0 count];
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return 0;
}

- (id)collectionView:(id)arg1 itemForRepresentedObjectAtIndexPath:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r21 = [arg3 retain];
     *   r19 = [[arg2 makeItemWithIdentifier:@"PackageViewItem" forIndexPath:r21] retain];
     *   r20 = [[self visiblePackages] retain];
     *   r22 = [r21 item];
     *   [r21 release];
     *   r21 = [[r20 objectAtIndexedSubscript:r22] retain];
     *   [r19 setRepresentedObject:r21];
     *   [r21 release];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)collectionView:(id)arg1 willDisplayItem:(id)arg2 forRepresentedObjectAtIndexPath:(id)arg3 {
    return;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (void)back:(id)arg1 {
    return;
}

- (void)back {
    return;
}

- (void)search:(id)arg1 {
    return;
}

- (void)install:(id)arg1 {
    return;
}

- (void)selectUnknownPackage:(id)arg1 {
    return;
}

- (void)editInstallerSource:(id)arg1 {
    return;
}

- (void)selectSteamInstall:(id)arg1 {
    return;
}

- (void)selectInstallerDownload:(id)arg1 {
    return;
}

- (void)selectInstaller:(id)arg1 {
    return;
}

- (void)selectBottle:(id)arg1 {
    return;
}

- (void)c4pButton:(id)arg1 {
    return;
}

- (void)downloadButton:(id)arg1 {
    return;
}

- (void)installOptions:(id)arg1 {
    return;
}

- (void)installationCompleted {
    return;
}

- (void)installationStarted {
    return;
}

- (id)window {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self view];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 window] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (BOOL)performDragOperation:(id)arg1 {
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
     *   r21 = [[arg2 draggingPasteboard] retain];
     *   r19 = [[NSURL URLFromPasteboard:r21] retain];
     *   [r21 release];
     *   r0 = [r20 packageView];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r22 = [r0 isHidden];
     *   [r21 release];
     *   if (r22 != 0x0) {
     *   r20 = [[r20 installer] retain];
     *   r21 = [[r19 path] retain];
     *   [r20 setInstallerSource:r21];
     *   }
     *   else {
     *   r20 = [[**_NSApp CXServer] retain];
     *   r21 = [[r19 path] retain];
     *   [r20 runClient:r21 inBottle:0x0];
     *   ... (5 more lines)
     */
    return NO;
}

- (BOOL)textFieldIsTruncated:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [arg2 retain];
     *   r19 = r0;
     *   r20 = [[r0 cell] retain];
     *   [r19 frame];
     *   [r20 expansionFrameWithFrame:r19 inView:r3];
     *   [r19 release];
     *   r0 = [r20 release];
     *   r0 = NSEqualRects(r0, r1);
     *   r0 = r0 ^ 0x1;
     *   return r0;
     */
    return NO;
}

- (void)startObservingFrameOfView:(id)arg1 {
    return;
}

- (void)stopObservingFrameOfView:(id)arg1 {
    return;
}

- (void)subviewFrameChanged:(id)arg1 {
    return;
}

- (void)updatePackageDescriptionTruncation {
    return;
}

- (void)updateInstallationNotesTruncation {
    return;
}

- (void)expandPackageDescription:(BOOL)arg1 {
    return;
}

- (void)expandInstallationNotes:(BOOL)arg1 {
    return;
}

- (void)packageDescriptionExpandButtonClicked:(id)arg1 {
    return;
}

- (void)installationNotesExpandButtonClicked:(id)arg1 {
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

- (id)packages {
    return self->_packages;
}

- (void)setPackages:(id)arg1 {
    self->_packages = arg1;
}

- (id)unknownPackage {
    return self->_unknownPackage;
}

- (void)setUnknownPackage:(id)arg1 {
    self->_unknownPackage = arg1;
}

- (id)sortDescriptors {
    return self->_sortDescriptors;
}

- (id)filterPredicate {
    return self->_filterPredicate;
}

- (BOOL)isHighlighted {
    return self->_isHighlighted;
}

- (void)setIsHighlighted:(BOOL)arg1 {
    self->_isHighlighted = arg1;
}

- (id)visiblePackages {
    return self->_visiblePackages;
}

- (void)setVisiblePackages:(id)arg1 {
    self->_visiblePackages = arg1;
}

- (id)summaryDetailsControllers {
    return self->_summaryDetailsControllers;
}

- (void)setSummaryDetailsControllers:(id)arg1 {
    self->_summaryDetailsControllers = arg1;
}

- (id)installer {
    return self->_installer;
}

- (id)packageView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_packageView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setPackageView:(id)arg1 {
    return;
}

- (id)collectionView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_collectionView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setCollectionView:(id)arg1 {
    return;
}

- (id)loading {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_loading);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setLoading:(id)arg1 {
    return;
}

- (id)noResultsLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_noResultsLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNoResultsLabel:(id)arg1 {
    return;
}

- (id)searchField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_searchField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setSearchField:(id)arg1 {
    return;
}

- (id)installUnlistedAppButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installUnlistedAppButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallUnlistedAppButton:(id)arg1 {
    return;
}

- (id)packageViewTitle {
    return self->_packageViewTitle;
}

- (void)setPackageViewTitle:(id)arg1 {
    return;
}

- (id)installerView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installerView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallerView:(id)arg1 {
    return;
}

- (id)installButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallButton:(id)arg1 {
    return;
}

- (id)optionsButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_optionsButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setOptionsButton:(id)arg1 {
    return;
}

- (id)optionsMenu {
    return self->_optionsMenu;
}

- (void)setOptionsMenu:(id)arg1 {
    self->_optionsMenu = arg1;
}

- (id)installerSourceMenu {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installerSourceMenu);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallerSourceMenu:(id)arg1 {
    return;
}

- (id)installWithSteamMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installWithSteamMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallWithSteamMenuItem:(id)arg1 {
    return;
}

- (id)downloadInstallerMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_downloadInstallerMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDownloadInstallerMenuItem:(id)arg1 {
    return;
}

- (id)summaryDetailsView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_summaryDetailsView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setSummaryDetailsView:(id)arg1 {
    return;
}

- (id)packageDescriptionTextField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_packageDescriptionTextField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setPackageDescriptionTextField:(id)arg1 {
    return;
}

- (id)packageDescriptionExpandButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_packageDescriptionExpandButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setPackageDescriptionExpandButton:(id)arg1 {
    return;
}

- (id)packageDescriptionMoreLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_packageDescriptionMoreLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setPackageDescriptionMoreLabel:(id)arg1 {
    return;
}

- (id)installationNotesTextField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installationNotesTextField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallationNotesTextField:(id)arg1 {
    return;
}

- (id)installationNotesMoreLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installationNotesMoreLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallationNotesMoreLabel:(id)arg1 {
    return;
}

- (id)installationNotesExpandButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installationNotesExpandButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallationNotesExpandButton:(id)arg1 {
    return;
}

- (id)packageDescriptionCollapsedHeightConstraint {
    return self->_packageDescriptionCollapsedHeightConstraint;
}

- (void)setPackageDescriptionCollapsedHeightConstraint:(id)arg1 {
    self->_packageDescriptionCollapsedHeightConstraint = arg1;
}

- (id)installationNotesCollapsedHeightConstraint {
    return self->_installationNotesCollapsedHeightConstraint;
}

- (void)setInstallationNotesCollapsedHeightConstraint:(id)arg1 {
    self->_installationNotesCollapsedHeightConstraint = arg1;
}

@end
