# Referência da API

Gerada a partir de `CrossThrough/src/Headers` e `src/include`: todas as classes (o nome do produto host nos identificadores aparece como `<Produto>`), com seus métodos de classe (`+`) e de instância (`-`), e as funções C.


## AddDependenciesViewController : CXViewController

- `+ (id)keyPathsForValuesAffectingInstallConfiguration`
- `- (id)init`
- `- (void)dealloc`
- `- (id)installConfiguration`
- `- (void)loadView`
- `- (void)addDependencies:(id)arg1`
- `- (id)searchField`
- `- (void)setSearchField:(id)arg1`
- `- (id)arrayController`
- `- (void)setArrayController:(id)arg1`
- `- (id)addableDependencies`
- `- (void)setAddableDependencies:(id)arg1`

## AskUpdateBottlesOp : NSOperation

- `- (void)main`

## BooleanToLabelColorTransformer : NSValueTransformer

- `+ (BOOL)allowsReverseTransformation`
- `+ (Class)transformedValueClass`
- `- (id)transformedValue:(id)arg1`

## BottleMenuHandler : CXObject

- `+ (void)deleteBottle:(id)arg1 withWindow:(id)arg2`
- `+ (void)deleteManagedBottle:(id)arg1 withWindow:(id)arg2 authorization:(id)arg3`
- `+ (void)duplicateBottle:(id)arg1 withWindow:(id)arg2`
- `+ (void)exportBottle:(id)arg1 withWindow:(id)arg2`
- `+ (void)installSoftwareIntoBottle:(id)arg1 withWindow:(id)arg2`
- `+ (void)installMissingDependencies:(id)arg1 withWindow:(id)arg2`
- `+ (void)openCDriveForBottle:(id)arg1`
- `+ (void)openShellForBottle:(id)arg1`
- `+ (void)publishBottle:(id)arg1 withWindow:(id)arg2`
- `+ (void)rateBottle:(id)arg1 withWindow:(id)arg2 isDeleting:(BOOL)arg3`
- `+ (void)runCommandInBottle:(id)arg1`
- `+ (void)runCommandInBottle:(id)arg1 withLauncher:(id)arg2`
- `+ (void)toggleDefaultBottle:(id)arg1`
- `+ (void)toggleMSyncForBottle:(id)arg1 withWindow:(id)arg2`
- `+ (void)toggleMSyncForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3`
- `+ (void)toggleHighResolutionForBottle:(id)arg1 withWindow:(id)arg2`
- `+ (void)toggleHighResolutionForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3`
- `+ (void)togglePreviewForBottle:(id)arg1 withWindow:(id)arg2`
- `+ (void)togglePreviewForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3`
- `+ (void)quitBottle:(id)arg1`
- `+ (void)forceQuitBottle:(id)arg1`

## BottleNameFormatter : NSFormatter

- `+ (BOOL)accessInstanceVariablesDirectly`
- `- (id)stringForObjectValue:(id)arg1`
- `- (BOOL)getObjectValue:(id *)arg1 forString:(id)arg2 errorDescription:(id *)arg3`
- `- (BOOL)isPartialStringValid:(id)arg1 newEditingString:(id *)arg2 errorDescription:(id *)arg3`

## BottleNode : CXObject

- `+ (id)bottleNodeWithBottle:(id)arg1`
- `+ (id)groupBottleNodeWithName:(id)arg1`
- `+ (id)allBottlesBottleNode`
- `+ (id)installBottleNode`
- `+ (id)keyPathsForValuesAffectingName`
- `- (id)init`
- `- (id)image`
- `- (id)name`
- `- (void)setName:(id)arg1`
- `- (void)setChildren:(id)arg1`
- `- (void)insertObject:(id)arg1 inChildrenAtIndex:(NSUInteger)arg2`
- `- (void)insertChildren:(id)arg1 atIndexes:(id)arg2`
- `- (void)removeObjectFromChildrenAtIndex:(NSUInteger)arg1`
- `- (void)removeChildrenAtIndexes:(id)arg1`
- `- (void)replaceChildrenAtIndexes:(id)arg1 withChildren:(id)arg2`
- `- (BOOL)isLeaf`
- `- (NSInteger)type`
- `- (void)setType:(NSInteger)arg1`
- `- (void)setImage:(id)arg1`
- `- (id)children`
- `- (id)bottle`
- `- (void)setBottle:(id)arg1`
- `- (NSInteger)sortPriority`
- `- (void)setSortPriority:(NSInteger)arg1`

## BottleTableCellView : NSTableCellView

- `- (void)dealloc`
- `- (void)awakeFromNib`
- `- (void)setBackgroundStyle:(NSInteger)arg1`
- `- (void)updateTextField`
- `- (void)viewWillDraw`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (id)needsUpgradeButton`
- `- (void)setNeedsUpgradeButton:(id)arg1`

## BottleTableRowView : NSTableRowView

- `- (void)drawRect:(NSRect)arg1`
- `- (BOOL)isEmphasized`

## BottleViewController : CXViewController

- `+ (id)keyPathsForValuesAffectingBottleDescription`
- `- (id)init`
- `- (void)dealloc`
- `- (void)viewDidLoad`
- `- (void)setBottle:(id)arg1`
- `- (id)packageForBottle:(id)arg1`
- `- (void)reloadLaunchers`
- `- (void)updateDependencyButton`
- `- (void)updateQuitButton`
- `- (void)updateMenuItems`
- `- (void)resetMenuForNewBottle`
- `- (id)iconForControlPanel:(id)arg1`
- `- (void)sortControlPanels:(id)arg1`
- `- (void)addButtonForControlPanel:(id)arg1 index:(NSInteger)arg2`
- `- (void)showControlPanelLoader:(BOOL)arg1`
- `- (void)reloadControlPanels`
- `- (id)launcherNodesForLaunchers:(id)arg1`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (void)leaveRating:(id)arg1`
- `- (id)bottleDescription`
- `- (void)setBottleDescription:(id)arg1`
- `- (void)iconCollectionViewControllerSelectionChanged:(id)arg1`
- `- (void)runWithOptionsClicked:(id)arg1`
- `- (void)runCommandClicked:(id)arg1`
- `- (void)installIntoBottleClicked:(id)arg1`
- `- (void)dependencyButtonClicked:(id)arg1`
- `- (void)openCDriveClicked:(id)arg1`
- `- (void)quitClicked:(id)arg1`
- `- (void)deleteClicked:(id)arg1`
- `- (void)graphicsOptionChanged:(id)arg1`
- `- (void)vulkanOptionChanged:(id)arg1`
- `- (void)dlssToggled:(id)arg1`
- `- (void)msyncToggled:(id)arg1`
- `- (void)highResolutionToggled:(id)arg1`
- `- (void)previewToggled:(id)arg1`
- `- (void)controlPanelButtonClicked:(id)arg1`
- `- (void)bottleDescriptionDidEndEditing:(id)arg1`
- `- (id)selectedApplication`
- `- (BOOL)canUninstall`
- `- (void)uninstallClicked:(id)arg1`
- `- (BOOL)control:(id)arg1 textView:(id)arg2 doCommandBySelector:(SEL)arg3`
- `- (BOOL)performDragOperation:(id)arg1`
- `- (id)bottle`
- `- (id)observers`
- `- (void)setObservers:(id)arg1`
- `- (id)package`
- `- (void)setPackage:(id)arg1`
- `- (BOOL)canBeRated`
- `- (void)setCanBeRated:(BOOL)arg1`
- `- (id)iconCollectionViewController`
- `- (void)setIconCollectionViewController:(id)arg1`
- `- (id)iconCollectionView`
- `- (void)setIconCollectionView:(id)arg1`
- `- (id)noAppsFoundLabel`
- `- (void)setNoAppsFoundLabel:(id)arg1`
- `- (id)leaveRatingButton`
- `- (void)setLeaveRatingButton:(id)arg1`
- `- (id)controlPanelLaunchers`
- `- (void)setControlPanelLaunchers:(id)arg1`
- `- (id)runWithOptionsButton`
- `- (void)setRunWithOptionsButton:(id)arg1`
- `- (id)runCommandButton`
- `- (void)setRunCommandButton:(id)arg1`
- `- (id)installIntoBottleButton`
- `- (void)setInstallIntoBottleButton:(id)arg1`
- `- (id)openCDriveButton`
- `- (void)setOpenCDriveButton:(id)arg1`
- `- (id)quitButton`
- `- (void)setQuitButton:(id)arg1`
- `- (id)deleteButton`
- `- (void)setDeleteButton:(id)arg1`
- `- (id)dependencyButton`
- `- (void)setDependencyButton:(id)arg1`
- `- (id)graphicsOptionView`
- `- (void)setGraphicsOptionView:(id)arg1`
- `- (id)graphicsLabel`
- `- (void)setGraphicsLabel:(id)arg1`
- `- (id)graphicsPopUpButton`
- `- (void)setGraphicsPopUpButton:(id)arg1`
- `- (id)autoGraphicsMenuItem`
- `- (void)setAutoGraphicsMenuItem:(id)arg1`
- `- (id)dxmtMenuItem`
- `- (void)setDxmtMenuItem:(id)arg1`
- `- (id)dxvkMenuItem`
- `- (void)setDxvkMenuItem:(id)arg1`
- `- (id)d3dMetalMenuItem`
- `- (void)setD3dMetalMenuItem:(id)arg1`
- `- (id)wined3dMenuItem`
- `- (void)setWined3dMenuItem:(id)arg1`
- `- (id)vulkanOptionView`
- `- (void)setVulkanOptionView:(id)arg1`
- `- (id)vulkanLabel`
- `- (void)setVulkanLabel:(id)arg1`
- `- (id)vulkanPopUpButton`
- `- (void)setVulkanPopUpButton:(id)arg1`
- `- (id)moltenvkMenuItem`
- `- (void)setMoltenvkMenuItem:(id)arg1`
- `- (id)mtlvkMenuItem`
- `- (void)setMtlvkMenuItem:(id)arg1`
- `- (id)msyncLabel`
- `- (void)setMsyncLabel:(id)arg1`
- `- (id)msyncSwitch`
- `- (void)setMsyncSwitch:(id)arg1`
- `- (id)msyncView`
- `- (void)setMsyncView:(id)arg1`
- `- (id)dlssLabel`
- `- (void)setDlssLabel:(id)arg1`
- `- (id)dlssSwitch`
- `- (void)setDlssSwitch:(id)arg1`
- `- (id)dlssView`
- `- (void)setDlssView:(id)arg1`
- `- (id)highResolutionLabel`
- `- (void)setHighResolutionLabel:(id)arg1`
- `- (id)highResolutionSwitch`
- `- (void)setHighResolutionSwitch:(id)arg1`
- `- (id)highResolutionView`
- `- (void)setHighResolutionView:(id)arg1`
- `- (id)previewLabel`
- `- (void)setPreviewLabel:(id)arg1`
- `- (id)previewSwitch`
- `- (void)setPreviewSwitch:(id)arg1`
- `- (id)previewView`
- `- (void)setPreviewView:(id)arg1`
- `- (id)controlPanelsSection`
- `- (void)setControlPanelsSection:(id)arg1`
- `- (id)controlPanelsLoadingView`
- `- (void)setControlPanelsLoadingView:(id)arg1`
- `- (id)controlPanelsLoadingSpinner`
- `- (void)setControlPanelsLoadingSpinner:(id)arg1`
- `- (id)installedSoftwareTableView`
- `- (void)setInstalledSoftwareTableView:(id)arg1`
- `- (id)installedSoftware`
- `- (void)setInstalledSoftware:(id)arg1`

## BuySupportNagController : NSWindowController

- `- (id)initWithAppcastItem:(id)arg1`
- `- (void)setOwnsSelf:(BOOL)arg1`
- `- (id)bundleVersion`
- `- (id)bundleDisplayVersion`
- `- (id)bundleName`
- `- (id)descriptionText`
- `- (void)buyNow:(id)arg1`
- `- (void)windowDidLoad`
- `- (BOOL)windowShouldClose:(id)arg1`
- `- (void)windowWillClose:(id)arg1`
- `- (void)remindMeLater:(id)arg1`
- `- (void)refreshRegistration:(id)arg1`
- `- (void)skipThisVersion:(id)arg1`
- `- (id)applicationIcon`
- `- (BOOL)showsReleaseNotes`
- `- (id)titleText`
- `- (void)displayReleaseNotes`
- `- (void)endWithSelection`
- `- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2`
- `- (void)webView:(id)arg1 decidePolicyForNavigationAction:(id)arg2 request:(id)arg3 frame:(id)arg4 decisionListener:(id)arg5`
- `- (id)webView:(id)arg1 contextMenuItemsForElement:(id)arg2 defaultMenuItems:(id)arg3`
- `- (id)notEntitledLabel`
- `- (void)setNotEntitledLabel:(id)arg1`
- `- (id)refreshRegistrationButton`
- `- (void)setRefreshRegistrationButton:(id)arg1`
- `- (id)buySupportExtensionButton`
- `- (void)setBuySupportExtensionButton:(id)arg1`
- `- (id)releaseNotesView`
- `- (void)setReleaseNotesView:(id)arg1`
- `- (BOOL)registrationRefreshEnough`
- `- (void)setRegistrationRefreshEnough:(BOOL)arg1`
- `- (id)refreshRegistrationToBuySupportSpacer`
- `- (void)setRefreshRegistrationToBuySupportSpacer:(id)arg1`
- `- (id)notEntitledLabelToReleaseNotesBoxSpacer`
- `- (void)setNotEntitledLabelToReleaseNotesBoxSpacer:(id)arg1`
- `- (id)notEntitledLabelToDescriptionLabelSpacer`
- `- (void)setNotEntitledLabelToDescriptionLabelSpacer:(id)arg1`
- `- (id)updateItem`
- `- (void)setUpdateItem:(id)arg1`
- `- (id)releaseNotesSpinner`
- `- (void)setReleaseNotesSpinner:(id)arg1`

## CDTools : CXObject

- `+ (BOOL)isValidInstallerVolume:(id)arg1 requireRemovable:(BOOL)arg2`
- `+ (BOOL)isValidInstallerVolume:(id)arg1`
- `+ (void)removeCDHelper`
- `+ (id)getListOfAppsHelpedByTheCDHelper`
- `+ (void)removeCDHelperAndPrefsForAllInstalls`
- `+ (id)identifyInstallablePackagesForVolume:(id)arg1`

## CXApplication : NSApplication

- `+ (BOOL)accessInstanceVariablesDirectly`
- `- (id)init`
- `- (void)setDelegate:(id)arg1`
- `- (id)<produto>Root`
- `- (id)<produto>RootURL`
- `- (BOOL)isDemo`
- `- (void)setIsDemo`
- `- (NSInteger)daysLeft`
- `- (void)setDaysLeft`
- `- (void)orderFrontStandardAboutPanel:(id)arg1`
- `- (void)reportException:(id)arg1`
- `- (void)setWineController:(id)arg1`
- `- (void)sendEvent:(id)arg1`
- `- (id)licenseID`
- `- (void)setLicenseID:(id)arg1`
- `- (id)licenseExpirationDate`
- `- (void)setLicenseExpirationDate:(id)arg1`
- `- (id)wineController`
- `- (id)demoString`
- `- (void)setDemoString:(id)arg1`
- `- (id)CXServer`
- `- (void)setCXServer:(id)arg1`

## CXBundle : CXObject

- `+ (id)bundleWithURL:(id)arg1`
- `- (id)initWithURL:(id)arg1`
- `- (void)dealloc`
- `- (id)objectForInfoDictionaryKey:(id)arg1`
- `- (id)bundleIdentifier`
- `- (id)executablePath`
- `- (NSUInteger)helperVersion`
- `- (id)icon`
- `- (id)url`
- `- (void)setUrl:(id)arg1`
- `- (CFBundleRef)cfBundle`
- `- (void)setCfBundle:(CFBundleRef)arg1`

## CXDisclosureView : NSView

- `- (id)initWithFrame:(NSRect)arg1`
- `- (id)initWithCoder:(id)arg1`
- `- (void)finishInit`
- `- (void)setTitle:(id)arg1`
- `- (void)setOn:(BOOL)arg1`
- `- (void)setAutosaveName:(id)arg1`
- `- (void)setDetailView:(id)arg1`
- `- (void)disclosureTriangleClicked:(id)arg1`
- `- (void)titleButtonClicked:(id)arg1`
- `- (NSSize)intrinsicContentSize`
- `- (void)prepareForInterfaceBuilder`
- `- (id)title`
- `- (BOOL)isOn`
- `- (id)detailView`
- `- (id)autosaveName`
- `- (BOOL)gotOnState`
- `- (void)setGotOnState:(BOOL)arg1`
- `- (id)disclosureTriangle`
- `- (void)setDisclosureTriangle:(id)arg1`
- `- (id)titleButton`
- `- (void)setTitleButton:(id)arg1`

## CXDragView : NSView

- `- (NSUInteger)draggingEntered:(id)arg1`
- `- (BOOL)performDragOperation:(id)arg1`
- `- (id)delegate`
- `- (void)setDelegate:(id)arg1`

## CXFlatButton : NSButton

- `+ (id)flatButtonWithTitle:(id)arg1 icon:(id)arg2`
- `+ (id)flatButtonWithTitle:(id)arg1`
- `- (id)initWithFrame:(NSRect)arg1`
- `- (id)initWithCoder:(id)arg1`
- `- (void)finishInit`
- `- (void)reconfigureTitleTextField`
- `- (void)updateTitleTextColor`
- `- (void)updateTitleConstraints`
- `- (void)setFlexibleIconWidth:(BOOL)arg1`
- `- (void)reconfigureIcon`
- `- (NSEdgeInsets)imageAlignmentRectInsets`
- `- (NSRect)rectByRemovingInsets:(NSEdgeInsets)arg1 fromRect:(NSRect)arg2`
- `- (NSRect)rectByRoundingRect:(NSRect)arg1 toPixelScale:(CGFloat)arg2`
- `- (NSSize)imageAlignmentRectSizeForCapHeight:(CGFloat)arg1 scaleFactor:(CGFloat *)arg2`
- `- (CGFloat)alottedWidthForImage`
- `- (NSRect)imageFrame`
- `- (void)drawRect:(NSRect)arg1`
- `- (void)updateColors`
- `- (id)effectiveContentTintColor`
- `- (void)updateBackgroundColorForCurrentState`
- `- (void)viewDidChangeEffectiveAppearance`
- `- (void)setHovering:(BOOL)arg1`
- `- (void)updateTrackingAreas`
- `- (void)mouseEntered:(id)arg1`
- `- (void)mouseExited:(id)arg1`
- `- (void)mouseDown:(id)arg1`
- `- (void)drawFocusRingMask`
- `- (NSEdgeInsets)alignmentRectInsets`
- `- (CGFloat)firstBaselineOffsetFromTop`
- `- (NSSize)intrinsicContentSize`
- `- (void)prepareForInterfaceBuilder`
- `- (void)setFont:(id)arg1`
- `- (void)setTitle:(id)arg1`
- `- (void)setAlignment:(NSInteger)arg1`
- `- (void)setControlSize:(NSUInteger)arg1`
- `- (void)setLineBreakMode:(NSUInteger)arg1`
- `- (void)setUsesSingleLineMode:(BOOL)arg1`
- `- (void)setBaseWritingDirection:(NSInteger)arg1`
- `- (void)setAllowsExpansionToolTips:(BOOL)arg1`
- `- (void)setImage:(id)arg1`
- `- (void)setEnabled:(BOOL)arg1`
- `- (void)highlight:(BOOL)arg1`
- `- (void)setHighlighted:(BOOL)arg1`
- `- (void)setShowsBorderOnlyWhileMouseInside:(BOOL)arg1`
- `- (void)setBezelColor:(id)arg1`
- `- (void)setHasDestructiveAction:(BOOL)arg1`
- `- (BOOL)hasDestructiveAction`
- `- (void)setContentTintColor:(id)arg1`
- `- (BOOL)flexibleIconWidth`
- `- (id)titleTextField`
- `- (void)setTitleTextField:(id)arg1`
- `- (id)titleTextFieldLeftConstraint`
- `- (void)setTitleTextFieldLeftConstraint:(id)arg1`
- `- (id)titleTextFieldZeroWidthConstraint`
- `- (void)setTitleTextFieldZeroWidthConstraint:(id)arg1`
- `- (BOOL)hovering`
- `- (id)normalBackgroundColor`
- `- (void)setNormalBackgroundColor:(id)arg1`
- `- (id)hoverBackgroundColor`
- `- (void)setHoverBackgroundColor:(id)arg1`
- `- (id)selectedBackgroundColor`
- `- (void)setSelectedBackgroundColor:(id)arg1`
- `- (id)textColor`
- `- (void)setTextColor:(id)arg1`

## CXFlatPopUpButton : NSPopUpButton

- `- (id)initWithFrame:(NSRect)arg1`
- `- (id)initWithCoder:(id)arg1`
- `- (void)finishInit`
- `- (void)updateColors`
- `- (void)viewDidChangeEffectiveAppearance`
- `- (void)updateBackgroundColorForCurrentState`
- `- (void)setHovering:(BOOL)arg1`
- `- (void)highlight:(BOOL)arg1`
- `- (void)setHighlighted:(BOOL)arg1`
- `- (void)setEnabled:(BOOL)arg1`
- `- (void)updateTrackingAreas`
- `- (void)mouseEntered:(id)arg1`
- `- (void)mouseExited:(id)arg1`
- `- (void)mouseDown:(id)arg1`
- `- (id)addItemWithTitle:(id)arg1 toolTip:(id)arg2`
- `- (id)normalBackgroundColor`
- `- (void)setNormalBackgroundColor:(id)arg1`
- `- (id)hoverBackgroundColor`
- `- (void)setHoverBackgroundColor:(id)arg1`
- `- (id)selectedBackgroundColor`
- `- (void)setSelectedBackgroundColor:(id)arg1`
- `- (BOOL)hovering`
- `- (BOOL)selected`
- `- (void)setSelected:(BOOL)arg1`

## CXFlippedClipView : NSClipView

- `- (BOOL)isFlipped`

## CXObject : NSObject

- `+ (BOOL)accessInstanceVariablesDirectly`

## CXRatioTextField : NSTextField

- `- (id)initWithCoder:(id)arg1`
- `- (id)initWithFrame:(NSRect)arg1`
- `- (NSSize)intrinsicContentSize`
- `- (void)invalidateIntrinsicContentSize`
- `- (void)invalidateIntrinsicContentSizeForCell:(id)arg1`
- `- (CGFloat)maxAspectRatio`
- `- (void)setMaxAspectRatio:(CGFloat)arg1`

## CXServer : CXObject

- `+ (id)getCellarID`
- `+ (id)getAppSupportDir`
- `+ (id)getCachesDir`
- `+ (id)getDefaultBottleDir`
- `+ (id)getBottleDir`
- `+ (id)fileTypesForBottle:(id)arg1`
- `- (id)init`
- `- (void)dealloc`
- `- (id)demoRegisterController`
- `- (id)shutdownController`
- `- (void)doPeriodicDemoNagForCommand:(id)arg1 withArgs:(id)arg2`
- `- (void)demoCheck`
- `- (void)registerDemo:(id)arg1`
- `- (BOOL)menusEnabled`
- `- (void)setMenusEnabled:(BOOL)arg1`
- `- (void)continueFromDemoCheck`
- `- (id)startAppOp`
- `- (void)rosettaCheck`
- `- (void)applicationWillFinishLaunching:(id)arg1`
- `- (void)applicationDidFinishLaunching:(id)arg1`
- `- (void)checkForHelperUpdate`
- `- (void)registerForCooperativeActivation`
- `- (void)otherWineAppWillActivate:(id)arg1`
- `- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1`
- `- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3`
- `- (void)finishedLaunches`
- `- (void)updateLaunchNotify`
- `- (id)startLaunchNotify:(id)arg1`
- `- (void)noteTask:(id)arg1 forCommand:(id)arg2 args:(id)arg3`
- `- (void)modifyEnvironmentForCommandTask:(id)arg1`
- `- (void)forkExecCommand:(id)arg1`
- `- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2`
- `- (void)observeTaskTermination:(id)arg1`
- `- (void)observeTaskErrorOutput:(id)arg1`
- `- (void)runClient:(id)arg1 inBottle:(id)arg2`
- `- (void)showLicense:(id)arg1`
- `- (void)setEnvValue:(id)arg1 forKey:(id)arg2`
- `- (void)unsetEnvValueForKey:(id)arg1`
- `- (void)setHttpProxyEnvironmentVariableFromSystemConfiguration`
- `- (void)beginMonitoringSystemConfigurationProxy`
- `- (id)managedBottlePath`
- `- (void)setEnvironmentVariables`
- `- (BOOL)validateMenuItem:(id)arg1`
- `- (void)runCommand:(id)arg1`
- `- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 copyingItemAtURL:(id)arg3 toURL:(id)arg4`
- `- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 linkingItemAtURL:(id)arg3 toURL:(id)arg4`
- `- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 movingItemAtURL:(id)arg3 toURL:(id)arg4`
- `- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 removingItemAtURL:(id)arg3`
- `- (void)replyToApplicationShouldTerminateTrampoline:(id)arg1`
- `- (NSUInteger)applicationShouldTerminate:(id)arg1`
- `- (id)applicationIcon`
- `- (id)startedAppGateOp`
- `- (BOOL)application:(id)arg1 openFile:(id)arg2`
- `- (BOOL)applicationOpenUntitledFile:(id)arg1`
- `- (BOOL)applicationShouldOpenUntitledFile:(id)arg1`
- `- (BOOL)applicationShouldHandleReopen:(id)arg1 hasVisibleWindows:(BOOL)arg2`
- `- (void)openDocument:(id)arg1`
- `- (void)addToRecentItems:(id)arg1 bottle:(id)arg2`
- `- (id)makeBottleTaggedName:(id)arg1 withBottleName:(id)arg2`
- `- (void)updateRecentItemsMenu`
- `- (void)openRecent:(id)arg1`
- `- (void)clearRecent:(id)arg1`
- `- (void)processFirstRun:(BOOL)arg1`
- `- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2`

## CXServer<Produto> : CXServer

- `+ (id)getDefaultProgramsFolder`
- `+ (id)getProgramsFolder`
- `+ (id)crossTieModDateString`
- `- (id)init`
- `- (id)preferencesController`
- `- (id)mainWindowController`
- `- (void)applicationWillFinishLaunching:(id)arg1`
- `- (void)applicationDidFinishLaunching:(id)arg1`
- `- (id)startedAppGateOp`
- `- (void)openAutoPlayInstallerForC4P:(id)arg1 inBottle:(id)arg2`
- `- (void)openAutoPlayInstallerForVolume:(id)arg1 inBottle:(id)arg2`
- `- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1`
- `- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3`
- `- (id)startLaunchNotify:(id)arg1`
- `- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2`
- `- (void)runClient:(id)arg1 inBottle:(id)arg2`
- `- (void)runClient:(id)arg1 inBottle:(id)arg2 withDialog:(BOOL)arg3`
- `- (void)continueFromDemoCheck`
- `- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2`
- `- (void)handleCrossTieURL:(id)arg1`
- `- (void)openScreenSharingHelpPage:(id)arg1`
- `- (void)openHelpInBrowser:(id)arg1`
- `- (void)showMainWindow:(id)arg1`
- `- (void)showPreferencesWindow:(id)arg1`
- `- (void)bottleCollectionChanged`
- `- (void)runCommand:(id)arg1`
- `- (void)rebuildMenus:(id)arg1`
- `- (BOOL)validateMenuItem:(id)arg1`
- `- (void)refreshProgramsAndAssociationsInBackground:(id)arg1`
- `- (void)setRebuildingPrograms:(id)arg1`
- `- (void)refreshPrograms:(id)arg1`
- `- (void)queueRefreshPrograms:(id)arg1`
- `- (void)watchMenuPLists`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (id)getMenuPList`
- `- (void)addProgramsFromMenuPlist:(id)arg1 bottle:(id)arg2 toDictionary:(id)arg3 atPath:(id)arg4`
- `- (void)addProgramsFromMenuPlist:(id)arg1 bottle:(id)arg2 toDictionary:(id)arg3`
- `- (BOOL)updateApplicationFolder:(BOOL)arg1`
- `- (id)shortenedBundleID:(id)arg1`
- `- (void)createProgramsMenuFromSubmenu:(id)arg1 hasPrograms:(BOOL)arg2`
- `- (void)createProgramsMenu:(id)arg1`
- `- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2 skippingFiles:(id)arg3`
- `- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2`
- `- (void)addLauncherItems:(id)arg1 toMenu:(id)arg2`
- `- (void)duplicateBottleList:(id)arg1`
- `- (id)combinedAssociationsPropertyListLatestDate:(id *)arg1`
- `- (void)addDocumentTypeDictionary:(id)arg1 forBottle:(id)arg2 toBundleArray:(id)arg3 andResourcesDir:(id)arg4`
- `- (void)informSystemOfUpdatedApp:(id)arg1`
- `- (void)adjustProgramHelpersForChangedAssociations:(id)arg1`
- `- (void)refreshAssociations:(BOOL)arg1`
- `- (id)getAssociationDictionaryForKey:(id)arg1 withExtensionAssociations:(id)arg2`
- `- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3`
- `- (id)findBestApplicationForDocType:(id)arg1 withProgramsDict:(id)arg2`
- `- (id)findBestApplicationForDocType:(id)arg1 forBottle:(id)arg2`
- `- (id)findMenusForAssociations:(id)arg1`
- `- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3 usingExistingHelper:(id)arg4`
- `- (void)launchHelper:(id)arg1`
- `- (BOOL)exportProgram:(id)arg1 bundleName:(id)arg2 withDictionary:(id)arg3 toFolder:(id)arg4`
- `- (BOOL)createIcnsFile:(id)arg1 fromImageFile:(id)arg2 forApp:(BOOL)arg3`
- `- (BOOL)applicationOpenUntitledFile:(id)arg1`
- `- (void)runCXUpgrade`
- `- (void)checkForHelperUpdate`
- `- (void)processFirstRun:(BOOL)arg1`
- `- (id)applicationDockMenu:(id)arg1`
- `- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2`
- `- (id)sparkleUpdater`
- `- (void)repairBottles:(id)arg1`
- `- (void)repairBottlesDialog:(id)arg1`
- `- (id)programsMenu`
- `- (void)setProgramsMenu:(id)arg1`
- `- (id)publishBottleMenuItem`
- `- (void)setPublishBottleMenuItem:(id)arg1`
- `- (id)updateBottleMenuItem`
- `- (void)setUpdateBottleMenuItem:(id)arg1`
- `- (id)launchers`
- `- (void)setLaunchers:(id)arg1`
- `- (id)urlHandler`
- `- (void)setUrlHandler:(id)arg1`
- `- (id)observedBottles`
- `- (void)setObservedBottles:(id)arg1`

## CXSetupLib : NSObject

- `+ (void)initialize`
- `+ (Class)bottleQueryClass`
- `+ (Class)bottleManagementClass`
- `+ (Class)cxSetupClass`
- `+ (Class)appDetectorClass`
- `+ (Class)cdDetectorClass`
- `+ (Class)demoUtilsClass`
- `+ (Class)c4ProfilesClass`
- `+ (Class)installTaskClass`
- `+ (Class)cxAiEngineClass`
- `+ (Class)cxUtilsClass`
- `+ (Class)cxMenuClass`
- `+ (Class)bottleCollectionClass`
- `+ (Class)bottleWrapperClass`
- `+ (Class)iconUtilsClass`
- `+ (Class)ratingUtilsClass`
- `+ (Class)systemInfoClass`
- `+ (Class)webUtilsClass`

## CXSourceList : NSOutlineView

- `- (NSRect)frameOfCellAtColumn:(NSInteger)arg1 row:(NSInteger)arg2`
- `- (BOOL)validateProposedFirstResponder:(id)arg1 forEvent:(id)arg2`

## CXSparkleUserDriver : SPUStandardUserDriver

- `- (void)setNotLicensed:(BOOL)arg1`
- `- (void)showUpdateFoundWithAppcastItem:(id)arg1 state:(id)arg2 reply:(id)arg3`

## CXTask : NSProxy

- `+ (id)argumentsWithStringsReplacedBySpecialStrings:(id)arg1`
- `+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2`
- `- (id)initWithTask:(id)arg1`
- `- (id)init`
- `- (void)dealloc`
- `- (void)cxtaskObserveRealTaskTermination:(id)arg1`
- `- (void)setArguments:(id)arg1`
- `- (id)forwardingTargetForSelector:(SEL)arg1`

## CXTask (NSTaskForwarding)

- `@property (copy) NSString *launchPath`
- `@property (copy) NSString *currentDirectoryPath`
- `@property (copy) NSDictionary *environment`
- `@property (retain) id standardInput`
- `@property (retain) id standardOutput`
- `@property (retain) id standardError`
- `@property (copy) void (^terminationHandler)(NSTask *)`
- `@property (readonly) int processIdentifier`
- `@property (readonly) int terminationStatus`
- `@property (readonly) NSTaskTerminationReason terminationReason`
- `@property (readonly, getter=isRunning) BOOL running`
- `- (NSArray *)arguments`
- `- (void)launch`
- `- (BOOL)launchAndReturnError:(NSError **)error`
- `- (void)terminate`
- `- (void)interrupt`
- `- (BOOL)suspend`
- `- (BOOL)resume`
- `- (void)waitUntilExit`

## CXTaskSpecialString : NSProxy

- `- (id)initWithString:(id)arg1`
- `- (id)copy`
- `- (id)mutableCopy`
- `- (id)copyWithZone:(void *)arg1`
- `- (id)mutableCopyWithZone:(void *)arg1`
- `- (const char *)fileSystemRepresentation`
- `- (id)forwardingTargetForSelector:(SEL)arg1`

## CXUpdater : NSObject

- `+ (id)sharedUpdater`
- `+ (id)updaterForBundle:(id)arg1`
- `- (id)initForBundle:(id)arg1`
- `- (id)init`
- `- (void)setUserAgentString`
- `- (BOOL)automaticallyChecksForUpdates`
- `- (void)setAutomaticallyChecksForUpdates:(BOOL)arg1`
- `- (CGFloat)updateCheckInterval`
- `- (void)checkForUpdates:(id)arg1`
- `- (BOOL)validateMenuItem:(id)arg1`
- `- (void)checkForUpdatesInBackground`
- `- (id)lastUpdateCheckDate`
- `- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2`
- `- (void)updaterDidNotFindUpdate:(id)arg1`
- `- (void)updater:(id)arg1 didAbortWithError:(id)arg2`
- `- (void)updater:(id)arg1 userDidMakeChoice:(NSInteger)arg2 forUpdate:(id)arg3 state:(id)arg4`
- `- (void)updater:(id)arg1 failedToDownloadUpdate:(id)arg2 error:(id)arg3`
- `- (void)userDidCancelDownload:(id)arg1`
- `- (void)setNotLicensed:(BOOL)arg1`
- `- (void)standardUserDriverWillHandleShowingUpdate:(BOOL)arg1 forUpdate:(id)arg2 state:(id)arg3`
- `- (void)standardUserDriverWillFinishUpdateSession`
- `- (id)delegate`
- `- (void)setDelegate:(id)arg1`
- `- (void)setUpdateCheckInterval:(CGFloat)arg1`

## CXViewController : NSViewController

- `+ (BOOL)accessInstanceVariablesDirectly`

## CXWindowController : NSWindowController

- `+ (BOOL)accessInstanceVariablesDirectly`
- `- (void)dealloc`
- `- (void)windowDidLoad`
- `- (void)windowWillClose:(id)arg1`
- `- (void)showWindow:(id)arg1`

## ControlPanelLauncherTreeNode : LauncherTreeNode

- `+ (id)keyPathsForValuesAffectingPersistentID`
- `+ (id)bottleNameFromPersistentID:(id)arg1`
- `- (BOOL)isOpenable`
- `- (id)persistentID`
- `- (BOOL)canBeFavorite`
- `- (void)openWithErrorHandler:(id)arg1`
- `- (id)controlPanel`
- `- (void)setControlPanel:(id)arg1`

## CrossTieURLHandler : NSObject

- `- (void)dealloc`
- `- (void)downloadWindowWillClose:(id)arg1`
- `- (void)doInstallWithParameters:(id)arg1`
- `- (void)handleCrossTieURL:(id)arg1`
- `- (id)delegate`
- `- (void)setDelegate:(id)arg1`
- `- (id)downloadProgress`
- `- (void)setDownloadProgress:(id)arg1`

## DebugChannelFormatter : NSFormatter

- `+ (id)sanitizePartialString:(id)arg1`
- `+ (id)sanitizeChannelString:(id)arg1`
- `- (id)stringForObjectValue:(id)arg1`
- `- (BOOL)getObjectValue:(id *)arg1 forString:(NSString *)arg2 errorDescription:(NSString **)arg3`
- `- (BOOL)isPartialStringValid:(NSString **)arg1 proposedSelectedRange:(NSRangePointer)arg2 originalString:(NSString *)arg3 originalSelectedRange:(NSRange)arg4 errorDescription:(NSString **)arg5`

## DemoBaseController : CXWindowController

- `- (id)initWithWindowNibName:(id)arg1`
- `- (id)expirationText`
- `- (void)setExpirationText:(id)arg1`

## DemoNagController : DemoBaseController

- `- (id)init`
- `- (void)windowDidLoad`
- `- (void)buy:(id)arg1`
- `- (void)showSerialCodeRegister`
- `- (void)registerapp:(id)arg1`
- `- (void)runapp:(id)arg1`
- `- (void)cancel:(id)arg1`
- `- (void)beginWindowWithCompletionHandler:(id)arg1`
- `- (id)registerButton`
- `- (void)setRegisterButton:(id)arg1`
- `- (id)tryNowButton`
- `- (void)setTryNowButton:(id)arg1`
- `- (id)buyButton`
- `- (void)setBuyButton:(id)arg1`
- `- (id)quitButton`
- `- (void)setQuitButton:(id)arg1`
- `- (id)registerToQuitSpacer`
- `- (void)setRegisterToQuitSpacer:(id)arg1`
- `- (id)registerToTryNowSpacer`
- `- (void)setRegisterToTryNowSpacer:(id)arg1`
- `- (id)buyToRegisterSpacer`
- `- (void)setBuyToRegisterSpacer:(id)arg1`

## DemoRegisterController : DemoBaseController

- `+ (id)keyPathsForValuesAffectingCanRegister`
- `- (id)init`
- `- (void)setRefreshLicenseMode:(BOOL)arg1`
- `- (void)windowDidLoad`
- `- (BOOL)canRegister`
- `- (void)registerapp:(id)arg1`
- `- (void)openSerialCodeWindow:(id)arg1`
- `- (void)cancel:(id)arg1`
- `- (void)exitSuccess`
- `- (void)controlTextDidChange:(id)arg1`
- `- (id)regController`
- `- (BOOL)refreshLicenseMode`
- `- (id)alreadyPurchasedToEmailSpacer`
- `- (void)setAlreadyPurchasedToEmailSpacer:(id)arg1`
- `- (id)referToStoreTextField`
- `- (void)setReferToStoreTextField:(id)arg1`
- `- (id)forgotPasswordTextField`
- `- (void)setForgotPasswordTextField:(id)arg1`

## DownloadProgressController : CXWindowController

- `- (id)initWithURL:(id)arg1`
- `- (void)windowDidLoad`
- `- (id)formattedSize:(NSInteger)arg1`
- `- (void)cancel:(id)arg1`
- `- (void)didPresentErrorWithRecovery:(BOOL)arg1 contextInfo:(void *)arg2`
- `- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didFinishDownloadingToURL:(id)arg3`
- `- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didWriteData:(NSInteger)arg3 totalBytesWritten:(NSInteger)arg4 totalBytesExpectedToWrite:(NSInteger)arg5`
- `- (void)URLSession:(id)arg1 task:(id)arg2 didCompleteWithError:(id)arg3`
- `- (id)caption`
- `- (void)setCaption:(id)arg1`
- `- (id)progressBar`
- `- (void)setProgressBar:(id)arg1`
- `- (id)progressText`
- `- (void)setProgressText:(id)arg1`
- `- (id)path`
- `- (void)setPath:(id)arg1`
- `- (id)urlSession`
- `- (void)setUrlSession:(id)arg1`
- `- (id)downloadTask`
- `- (void)setDownloadTask:(id)arg1`
- `- (id)progressFormat`
- `- (void)setProgressFormat:(id)arg1`

## FilteredTreeNode : CXObject

- `+ (id)keyPathsForValuesAffectingAncestors`
- `+ (id)keyPathsForValuesAffectingLeaf`
- `+ (BOOL)automaticallyNotifiesObserversOfFilterPredicate`
- `- (id)init`
- `- (void)dealloc`
- `- (id)ancestors`
- `- (BOOL)isLeaf`
- `- (id)children`
- `- (void)setChildren:(id)arg1`
- `- (void)insertObject:(id)arg1 inChildrenAtIndex:(NSUInteger)arg2`
- `- (void)insertChildren:(id)arg1 atIndexes:(id)arg2`
- `- (void)removeObjectFromChildrenAtIndex:(NSUInteger)arg1`
- `- (void)removeChildrenAtIndexes:(id)arg1`
- `- (void)addObjectToChildren:(id)arg1`
- `- (void)addChildrenFromArray:(id)arg1`
- `- (void)setFilterPredicate:(id)arg1`
- `- (void)setFilterPredicateInternal:(id)arg1`
- `- (id)filteredChildren`
- `- (void)setFilteredChildren:(id)arg1`
- `- (void)insertObject:(id)arg1 inFilteredChildrenAtIndex:(NSUInteger)arg2`
- `- (void)insertFilteredChildren:(id)arg1 atIndexes:(id)arg2`
- `- (void)addObjectToFilteredChildren:(id)arg1`
- `- (void)removeObjectFromFilteredChildrenAtIndex:(NSUInteger)arg1`
- `- (void)removeFilteredChildrenAtIndexes:(id)arg1`
- `- (BOOL)passesFilter`
- `- (void)noteChildChangedPassesFilter:(id)arg1`
- `- (void)adoptChild:(id)arg1`
- `- (void)abandonChild:(id)arg1`
- `- (void)filterWithPredicate`
- `- (id)filterPredicate`
- `- (BOOL)filtersSeparately`
- `- (void)setFiltersSeparately:(BOOL)arg1`
- `- (id)parent`
- `- (void)setParent:(id)arg1`

## IconCollectionView : NSCollectionView

- `- (BOOL)acceptsFirstResponder`
- `- (BOOL)becomeFirstResponder`
- `- (BOOL)resignFirstResponder`
- `- (void)keyDown:(id)arg1`
- `- (void)mouseDown:(id)arg1`
- `- (BOOL)isFirstResponder`
- `- (void)setIsFirstResponder:(BOOL)arg1`

## IconCollectionViewController : CXViewController

- `- (id)init`
- `- (void)viewDidLoad`
- `- (NSEdgeInsets)margins`
- `- (void)setMargins:(NSEdgeInsets)arg1`
- `- (id)selectedItem`
- `- (BOOL)allowsMultipleSelection`
- `- (void)setAllowsMultipleSelection:(BOOL)arg1`
- `- (id)selectedLauncher`
- `- (id)selectedLaunchers`
- `- (void)setLaunchers:(id)arg1`
- `- (void)openLauncherTreeNode:(id)arg1 fromRect:(NSRect)arg2 view:(id)arg3`
- `- (void)openIcon:(id)arg1`
- `- (void)runIconWithOptions:(id)arg1`
- `- (BOOL)launcherIsHidden:(id)arg1`
- `- (void)markLauncher:(id)arg1 asHidden:(BOOL)arg2`
- `- (void)toggleApplicationIsHidden:(id)arg1`
- `- (BOOL)validateUserInterfaceItem:(id)arg1`
- `- (BOOL)validateMenuItem:(id)arg1`
- `- (NSInteger)numberOfSectionsInCollectionView:(id)arg1`
- `- (NSInteger)collectionView:(id)arg1 numberOfItemsInSection:(NSInteger)arg2`
- `- (id)collectionView:(id)arg1 itemForRepresentedObjectAtIndexPath:(id)arg2`
- `- (id)collectionView:(id)arg1 pasteboardWriterForItemAtIndexPath:(id)arg2`
- `- (void)collectionView:(id)arg1 draggingSession:(id)arg2 willBeginAtPoint:(NSPoint)arg3 forItemsAtIndexPaths:(id)arg4`
- `- (void)collectionView:(id)arg1 didSelectItemsAtIndexPaths:(id)arg2`
- `- (void)collectionView:(id)arg1 didDeselectItemsAtIndexPaths:(id)arg2`
- `- (void)keyDown:(id)arg1`
- `- (void)mouseDown:(id)arg1`
- `- (id)delegate`
- `- (void)setDelegate:(id)arg1`
- `- (id)launchers`
- `- (id)collectionView`
- `- (void)setCollectionView:(id)arg1`
- `- (id)contextualMenu`
- `- (void)setContextualMenu:(id)arg1`

## IconViewBox : NSBox

- `- (void)dealloc`
- `- (id)pathForIconHighlight`
- `- (id)pathForLabelHighlight`
- `- (id)menuForEvent:(id)arg1`
- `- (id)hitTest:(NSPoint)arg1`
- `- (BOOL)isHighlighted`
- `- (void)drawRect:(NSRect)arg1`
- `- (void)updateLabelTextColor`
- `- (void)viewDidMoveToWindow`
- `- (void)viewWillMoveToWindow:(id)arg1`
- `- (BOOL)hasDarkModeApppearance`
- `- (void)keyStatusDidChange`
- `- (void)rightMouseDown:(id)arg1`
- `- (id)auxField`
- `- (void)setAuxField:(id)arg1`
- `- (id)item`
- `- (void)setItem:(id)arg1`

## IconViewItem : NSCollectionViewItem

- `- (void)setRepresentedObject:(id)arg1`
- `- (void)setSelected:(BOOL)arg1`
- `- (void)setHighlightState:(NSInteger)arg1`
- `- (id)draggingImageComponents`

## InstallConfiguration : CXObject

- `@property (nonatomic, copy) NSString *bottleName`
- `@property (nonatomic, readonly, copy) NSDictionary *bottles`
- `@property (nonatomic, readonly) BOOL newBottleCollidesWithExistingBottle`
- `@property (nonatomic, readonly) BOOL hasBottle`
- `@property (nonatomic, readonly) BOOL hasInstallerSource`
- `@property (nonatomic, readonly) BOOL hasPackage`
- `@property (nonatomic, readonly) BOOL bottleIsCompatibleWithPackage`
- `@property (nonatomic, readonly) BOOL creatingNewBottle`
- `@property (nonatomic, readonly, copy) NSDictionary *dependencyOverrides`
- `@property (nonatomic, readonly, copy) NSString *downloadURL`
- `@property (nonatomic, readonly, copy) NSString *installationNotes`
- `@property (nonatomic, readonly, copy) NSString *installerDownloadSource`
- `@property (nonatomic, copy) NSString *installerLocale`
- `@property (nonatomic, readonly, copy) NSString *installerSource`
- `@property (nonatomic, readonly) BOOL installWithSteam`
- `@property (nonatomic, copy) NSString *environment`
- `@property (nonatomic, copy) NSString *logChannels`
- `@property (nonatomic, copy) NSString *logEnvironment`
- `@property (nonatomic, readonly, copy) NSString *logFileName`
- `@property (nonatomic, copy) NSURL *logFileURL`
- `@property (nonatomic, readonly, copy) NSString *nameForNewBottle`
- `@property (nonatomic, readonly, copy) NSString *postInstallURL`
- `@property (nonatomic, readonly) id profile`
- `@property (nonatomic, readonly, copy) NSArray *profileLanguages`
- `@property (nonatomic, readonly) PackageTreeNode *selectedPackage`
- `@property (nonatomic, readonly, copy) NSString *steamID`
- `@property (nonatomic, readonly) id targetBottle`
- `@property (nonatomic, readonly, copy) NSDictionary *templates`
- `@property (nonatomic, readonly, getter=isVirtual) BOOL virtual`
- `@property (nonatomic, readonly) BOOL is64bit`
- `@property (nonatomic, readonly, copy) NSDictionary *dependencyDetails`
- `@property (nonatomic, readonly, copy) NSDictionary *installerDetails`
- `@property (nonatomic, readonly, copy) NSDictionary *bottleDetails`
- `@property (nonatomic, readonly, copy) NSDictionary *languageDetails`
- `@property (nonatomic, readonly, copy) NSDictionary *miscDetails`
- `+ (BOOL)automaticallyNotifiesObserversOfSelectedPackage`
- `+ (BOOL)resolveInstanceMethod:(SEL)arg1`
- `+ (id)reasonMain`
- `+ (id)reasonSteam`
- `+ (id)reasonOverride`
- `+ (id)reasonDependency`
- `+ (id)overrideExclude`
- `+ (id)overrideInclude`
- `- (id)init`
- `- (void)dealloc`
- `- (BOOL)newBottleCollidesWithExistingBottle`
- `- (BOOL)hasBottle`
- `- (BOOL)hasInstallerSource`
- `- (BOOL)hasPackage`
- `- (BOOL)bottleIsCompatibleWithPackage`
- `- (BOOL)creatingNewBottle`
- `- (void)setInstallerLocale:(NSString *)arg1`
- `- (void)setInstallerSource:(id)arg1 forUser:(BOOL)arg2`
- `- (void)setInstallerSteam`
- `- (void)setInstallerDownload`
- `- (void)setProfile:(id)arg1`
- `- (void)setSelectedPackage:(id)arg1 forUser:(BOOL)arg2`
- `- (id)profileLanguages`
- `- (id)dependencyDetails`
- `- (id)installerDetails`
- `- (id)bottleDetails`
- `- (id)languageDetails`
- `- (id)miscDetails`
- `- (void)updateProfiles`
- `- (BOOL)isNewBottleNameValid:(id)arg1`
- `- (void)createNewBottle:(id)arg1 template:(id)arg2`
- `- (void)setNewBottleName:(id)arg1`
- `- (void)addSourceMedia:(id)arg1 withLabel:(id)arg2 andDevice:(id)arg3`
- `- (void)addSourceMedia:(id)arg1`
- `- (void)removeSourceMedia:(id)arg1`
- `- (BOOL)volumeMatchesProfile:(id)arg1`
- `- (id)profiles`
- `- (id)profileForAppID:(id)arg1`
- `- (id)nameForProfileWithAppID:(id)arg1`
- `- (id)addBottle:(id)arg1`
- `- (void)removeBottle:(id)arg1`
- `- (void)installedApplicationsReady:(id)arg1`
- `- (void)triggerBottleAnalysis`
- `- (id)recommendedTemplate`
- `- (void)useAutorunFile:(id)arg1`
- `- (void)autoFillSettings`
- `- (id)logFileName`
- `- (id)newInstallEngine`
- `- (void)addDelegate:(id)arg1`
- `- (void)removeDelegate:(id)arg1`
- `- (void)forwardDelegateMethod:(SEL)arg1`
- `- (void)forwardDelegateMethod:(SEL)arg1 withObject:(id)arg2`
- `- (void)profileMediaAdded:(id)arg1`
- `- (void)profileMediaRemoved:(id)arg1`
- `- (void)profileChanged`
- `- (void)sourceChanged`
- `- (void)bottleCreateChanged`
- `- (void)bottleNewnameChanged`
- `- (void)bottleTemplateChanged`
- `- (void)bottleNameChanged`
- `- (void)categorizedBottle:(id)arg1`
- `- (void)categorizedAllBottles`
- `- (void)analyzedBottle:(id)arg1`
- `- (id)installTask`
- `- (id)delegates`
- `- (void)setDelegates:(id)arg1`
- `- (NSString *)environment`
- `- (void)setEnvironment:(NSString *)arg1`
- `- (NSString *)logChannels`
- `- (void)setLogChannels:(NSString *)arg1`
- `- (NSString *)logEnvironment`
- `- (void)setLogEnvironment:(NSString *)arg1`
- `- (NSURL *)logFileURL`
- `- (void)setLogFileURL:(NSURL *)arg1`
- `- (id)selectedPackage`
- `- (id)bottleCollection`

## InstallDependency : CXObject

- `+ (id)keyPathsForValuesAffectingManuallyRemoved`
- `+ (id)keyPathsForValuesAffectingManuallyAdded`
- `+ (id)keyPathsForValuesAffectingDisplayName`
- `+ (id)keyPathsForValuesAffectingCanRemove`
- `+ (id)keyPathsForValuesAffectingCanReAdd`
- `- (id)description`
- `- (BOOL)isEqual:(id)arg1`
- `- (NSUInteger)hash`
- `- (BOOL)isManuallyRemoved`
- `- (BOOL)isManuallyAdded`
- `- (id)displayName`
- `- (BOOL)canRemove`
- `- (BOOL)canReAdd`
- `- (NSInteger)depth`
- `- (id)sortKey`
- `- (NSInteger)compareInstallDependencySortKey:(id)arg1`
- `- (NSInteger)compareInstallDependencyWithinDepth:(id)arg1`
- `- (id)appID`
- `- (void)setAppID:(id)arg1`
- `- (id)parent`
- `- (void)setParent:(id)arg1`
- `- (id)name`
- `- (void)setName:(id)arg1`
- `- (id)reason`
- `- (void)setReason:(id)arg1`
- `- (id)reasonString`
- `- (void)setReasonString:(id)arg1`
- `- (NSUInteger)undo`
- `- (void)setUndo:(NSUInteger)arg1`

## InstallOptionsSheetController : CXWindowController

- `- (id)initWithInstallConfiguration:(id)arg1`
- `- (void)dealloc`
- `- (void)windowDidLoad`
- `- (void)updateLogFileName`
- `- (void)addDependenciesOfApp:(id)arg1 fromReasons:(id)arg2 to:(id)arg3`
- `- (void)addDependenciesForReason:(id)arg1 fromMap:(id)arg2 reasonString:(id)arg3 removedString:(id)arg4 to:(id)arg5`
- `- (void)fillDependencyList`
- `- (void)done:(id)arg1`
- `- (void)removeInstallDependency:(id)arg1`
- `- (void)reAddDependency:(id)arg1`
- `- (void)revertInstallDependencies:(id)arg1`
- `- (void)showAddDependenciesPopover:(id)arg1`
- `- (void)updateLanguages`
- `- (void)selectAppLanguage:(id)arg1`
- `- (void)windowWillClose:(id)arg1`
- `- (void)profileChanged`
- `- (void)sourceChanged`
- `- (void)bottleCreateChanged`
- `- (void)bottleNameChanged`
- `- (void)bottleNewnameChanged`
- `- (void)bottleTemplateChanged`
- `- (void)analyzedBottle:(id)arg1`
- `- (id)installDependencyTable`
- `- (void)setInstallDependencyTable:(id)arg1`
- `- (id)installDependencyArrayController`
- `- (void)setInstallDependencyArrayController:(id)arg1`
- `- (id)appLanguagePopUp`
- `- (void)setAppLanguagePopUp:(id)arg1`
- `- (id)stackView`
- `- (void)setStackView:(id)arg1`
- `- (id)dependencies`
- `- (void)setDependencies:(id)arg1`
- `- (id)installConfiguration`
- `- (id)loggingOptions`
- `- (void)setLoggingOptions:(id)arg1`
- `- (id)logFileURL`
- `- (NSInteger)numberOfLanguages`
- `- (void)setNumberOfLanguages:(NSInteger)arg1`
- `- (id)environment`
- `- (void)setEnvironment:(id)arg1`

## InstallSummaryDetailViewController : CXViewController

- `+ (id)keyPathsForValuesAffectingHasAction`
- `- (id)init`
- `- (BOOL)hasAction`
- `- (void)select:(id)arg1`
- `- (void)setSendsActionOnMouseDown:(BOOL)arg1`
- `- (void)setButtonEnabled:(BOOL)arg1`
- `- (void)viewDidLoad`
- `- (id)delegate`
- `- (void)setDelegate:(id)arg1`
- `- (id)image`
- `- (void)setImage:(id)arg1`
- `- (id)text`
- `- (void)setText:(id)arg1`
- `- (SEL)action`
- `- (void)setAction:(SEL)arg1`
- `- (BOOL)sendsActionOnMouseDown`
- `- (BOOL)buttonEnabled`
- `- (id)editButton`
- `- (void)setEditButton:(id)arg1`

## InstallationNotStartedTransformer : NSValueTransformer

- `+ (BOOL)allowsReverseTransformation`
- `+ (Class)transformedValueClass`
- `- (id)transformedValue:(id)arg1`

## InstallationOperation : NSOperation

- `- (id)initWithTaskStatus:(id)arg1 completionSelector:(SEL)arg2 andTarget:(id)arg3`
- `- (void)main`

## LaunchFeedbackInfo : CXObject

- `- (id)initWithIcon:(id)arg1`
- `- (void)dealloc`
- `- (NSInteger)lifeCounter`
- `- (void)setLifeCounter:(NSInteger)arg1`
- `- (id)socketPath`
- `- (id)badgeIcon`
- `- (BOOL)notified`
- `- (void)setNotified:(BOOL)arg1`
- `- (void)connectionAccepted:(id)arg1`

## LauncherApp : LauncherIcon

- `+ (id)launcherWithURL:(id)arg1`
- `- (id)initWithURL:(id)arg1`
- `- (id)copyWithZone:(void *)arg1`
- `- (void)launchWithErrorHandler:(id)arg1`
- `- (id)description`
- `- (id)url`
- `- (void)setUrl:(id)arg1`
- `- (id)bundleID`
- `- (void)setBundleID:(id)arg1`
- `- (NSUInteger)helperVersion`
- `- (void)setHelperVersion:(NSUInteger)arg1`

## LauncherAppTreeNode : LauncherTreeNode

- `+ (id)fromLauncher:(id)arg1`
- `+ (id)keyPathsForValuesAffectingPersistentID`
- `- (BOOL)isOpenable`
- `- (BOOL)canRunCommands`
- `- (id)url`
- `- (id)persistentID`
- `- (BOOL)canBeFavorite`
- `- (void)openWithErrorHandler:(id)arg1`
- `- (id)pasteboardWriter`
- `- (id)launcher`
- `- (void)setLauncher:(id)arg1`

## LauncherControlPanel : LauncherIcon

- `+ (id)launcherWithControlPanel:(id)arg1 bottle:(id)arg2`
- `- (id)initWithControlPanel:(id)arg1 bottle:(id)arg2`
- `- (id)copyWithZone:(void *)arg1`
- `- (id)tooltip`
- `- (void)launchWithErrorHandler:(id)arg1`
- `- (id)description`

## LauncherDiskFolder : LauncherFolder

- `+ (id)launcherWithFolderURL:(id)arg1`
- `- (id)initWithURL:(id)arg1`
- `- (id)copyWithZone:(void *)arg1`
- `- (id)icon`
- `- (id)description`
- `- (id)url`
- `- (void)setUrl:(id)arg1`

## LauncherDiskFolderTreeNode : LauncherFolderTreeNode

- `- (BOOL)isOpenable`
- `- (BOOL)animateOpen`
- `- (id)url`
- `- (void)openWithErrorHandler:(id)arg1`
- `- (id)pasteboardWriter`
- `- (id)launcherFolder`
- `- (void)setLauncherFolder:(id)arg1`

## LauncherFolder : LauncherItem

- `- (id)init`
- `- (id)initWithName:(id)arg1`
- `- (id)copyWithZone:(void *)arg1`
- `- (BOOL)isLeaf`
- `- (id)items`
- `- (void)setItems:(id)arg1`
- `- (void)insertObject:(id)arg1 inItemsAtIndex:(NSUInteger)arg2`
- `- (void)addLauncherItem:(id)arg1`
- `- (id)description`

## LauncherFolderTreeNode : LauncherTreeNode

- `- (BOOL)isLeaf`

## LauncherIcon : LauncherItem

- `- (id)initWithName:(id)arg1`
- `- (id)copyWithZone:(void *)arg1`
- `- (id)tooltip`
- `- (void)launchWithErrorHandler:(id)arg1`
- `- (id)description`
- `- (id)icon`
- `- (void)setIcon:(id)arg1`
- `- (id)bottle`
- `- (void)setBottle:(id)arg1`

## LauncherIconUtils : NSObject

- `+ (id)imageRepsForCXMenuIconsFromURL:(id)arg1`
- `+ (CGFloat)percentOfNonTransparentPixelsAlongEdgeOfImageRep:(id)arg1`
- `+ (id)maskIconToRoundRect:(id)arg1 destinationDimension:(NSUInteger)arg2`
- `+ (BOOL)createIcnsFileAtURL:(id)arg1 fromImageReps:(id)arg2 forApp:(BOOL)arg3`

## LauncherIconViewController : CXViewController

- `- (id)init`
- `- (void)dealloc`
- `- (void)viewDidLoad`
- `- (void)reloadLaunchers`
- `- (id)launcherNodesForLaunchers:(id)arg1`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (BOOL)performDragOperation:(id)arg1`
- `- (id)iconCollectionViewController`
- `- (void)setIconCollectionViewController:(id)arg1`
- `- (id)bottleCollection`
- `- (void)setBottleCollection:(id)arg1`
- `- (id)iconCollectionView`
- `- (void)setIconCollectionView:(id)arg1`
- `- (id)dragView`
- `- (void)setDragView:(id)arg1`

## LauncherItem : CXObject

- `- (id)init`
- `- (id)initWithName:(id)arg1`
- `- (id)copyWithZone:(void *)arg1`
- `- (id)icon`
- `- (id)bottle`
- `- (BOOL)isLeaf`
- `- (id)tooltip`
- `- (id)description`
- `- (id)name`
- `- (void)setName:(id)arg1`

## LauncherTreeNode : FilteredTreeNode

- `+ (id)keyPathsForValuesAffectingLeaf`
- `+ (id)keyPathsForValuesAffectingSortOrderThenName`
- `+ (id)keyPathsForValuesAffectingSortOrderThenBottleName`
- `- (BOOL)isLeaf`
- `- (BOOL)isOpenable`
- `- (BOOL)canRunCommands`
- `- (BOOL)animateOpen`
- `- (BOOL)affectsAutoExpansion`
- `- (id)url`
- `- (id)persistentID`
- `- (BOOL)canBeFavorite`
- `- (BOOL)canBeRated`
- `- (void)openWithErrorHandler:(id)arg1`
- `- (id)pasteboardWriter`
- `- (id)sortOrderThenName`
- `- (id)sortOrderThenBottleName`
- `- (NSInteger)compareSortOrderThenName:(id)arg1`
- `- (NSInteger)compareSortOrderThenBottleName:(id)arg1`
- `- (id)name`
- `- (void)setName:(id)arg1`
- `- (id)icon`
- `- (void)setIcon:(id)arg1`
- `- (id)bottle`
- `- (void)setBottle:(id)arg1`
- `- (id)tooltip`
- `- (void)setTooltip:(id)arg1`
- `- (NSInteger)sortOrder`
- `- (void)setSortOrder:(NSInteger)arg1`
- `- (BOOL)showBottleName`
- `- (void)setShowBottleName:(BOOL)arg1`

## LoadingCrossTieSheetController : CXWindowController

- `- (id)init`
- `- (void)setCrossTieDisplayName:(id)arg1`
- `- (void)windowDidLoad`
- `- (void)updateLoadingLabel`
- `- (id)crossTieDisplayName`
- `- (id)loadingLabel`
- `- (void)setLoadingLabel:(id)arg1`
- `- (id)progressIndicator`
- `- (void)setProgressIndicator:(id)arg1`

## LoggingOption : NSObject

- `+ (id)loggingOptionWithName:(id)arg1 channels:(id)arg2 environment:(id)arg3`
- `+ (id)loggingOptionWithName:(id)arg1 channels:(id)arg2`
- `+ (id)commonPresets`
- `- (id)initWithName:(id)arg1 channels:(id)arg2 environment:(id)arg3`
- `- (id)name`
- `- (void)setName:(id)arg1`
- `- (id)logChannels`
- `- (void)setLogChannels:(id)arg1`
- `- (id)logEnvironment`
- `- (void)setLogEnvironment:(id)arg1`

## LoggingOptionsViewController : CXViewController

- `+ (id)keyPathsForValuesAffectingEnableControls`
- `- (id)initWithLogFileName:(id)arg1`
- `- (void)viewDidLoad`
- `- (void)updateLogFileURL`
- `- (void)setLogFileName:(id)arg1`
- `- (void)selectLogFile:(id)arg1`
- `- (void)clearLoggingChannels:(id)arg1`
- `- (id)combineChannels:(id)arg1 with:(id)arg2 andDelimiter:(id)arg3`
- `- (void)addLoggingChannels:(id)arg1`
- `- (void)addExtraEnvVariables:(id)arg1`
- `- (BOOL)enableControls`
- `- (void)sanitizeLogChannels`
- `- (void)saveSettingsToRecent`
- `- (void)updateRecentMenuItems`
- `- (void)restoreRecent:(id)arg1`
- `- (BOOL)createLogFile`
- `- (void)setCreateLogFile:(BOOL)arg1`
- `- (BOOL)enabled`
- `- (void)setEnabled:(BOOL)arg1`
- `- (id)channelCombos`
- `- (void)setChannelCombos:(id)arg1`
- `- (id)logChannels`
- `- (void)setLogChannels:(id)arg1`
- `- (id)logEnvironment`
- `- (void)setLogEnvironment:(id)arg1`
- `- (id)logFileName`
- `- (id)logFileURL`
- `- (void)setLogFileURL:(id)arg1`
- `- (id)logDirectoryURL`
- `- (void)setLogDirectoryURL:(id)arg1`
- `- (BOOL)logFileNameFromUser`
- `- (void)setLogFileNameFromUser:(BOOL)arg1`
- `- (id)channelPresets`
- `- (void)setChannelPresets:(id)arg1`
- `- (id)recentChannelsDivider`
- `- (void)setRecentChannelsDivider:(id)arg1`
- `- (id)recentChannelsMenuItem`
- `- (void)setRecentChannelsMenuItem:(id)arg1`

## MainWindowController : CXWindowController

- `+ (void)initialize`
- `- (id)init`
- `- (void)dealloc`
- `- (id)bottleNodes`
- `- (void)setBottleNodes:(id)arg1`
- `- (void)insertObject:(id)arg1 inBottleNodesAtIndex:(NSUInteger)arg2`
- `- (void)removeObjectFromBottleNodesAtIndex:(NSUInteger)arg1`
- `- (id)selectedBottleNode`
- `- (void)loadInfoForSelectedBottle`
- `- (void)updateMainContentView`
- `- (id)privateBottlesGroupNameNoPublished`
- `- (void)windowDidLoad`
- `- (NSUInteger)window:(id)arg1 willUseFullScreenPresentationOptions:(NSUInteger)arg2`
- `- (void)selectLaunchView`
- `- (void)selectInstallView`
- `- (void)selectDefaultView`
- `- (void)updateC4Ps`
- `- (void)autoPlay:(id)arg1 inBottle:(id)arg2`
- `- (void)autoPlayWithAutorunFile:(id)arg1 inBottle:(id)arg2`
- `- (void)addIconsForBottles:(id)arg1`
- `- (BOOL)isPreview`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (BOOL)outlineView:(id)arg1 isGroupItem:(id)arg2`
- `- (BOOL)outlineView:(id)arg1 shouldShowOutlineCellForItem:(id)arg2`
- `- (BOOL)outlineView:(id)arg1 shouldSelectItem:(id)arg2`
- `- (void)outlineView:(id)arg1 didRemoveRowView:(id)arg2 forRow:(NSInteger)arg3`
- `- (void)outlineViewSelectionDidChange:(id)arg1`
- `- (id)outlineView:(id)arg1 rowViewForItem:(id)arg2`
- `- (id)outlineView:(id)arg1 viewForTableColumn:(id)arg2 item:(id)arg3`
- `- (BOOL)validateUserInterfaceItem:(id)arg1`
- `- (void)setMenuItem:(id)arg1 genericTitle:(id)arg2 bottleTitleFormat:(id)arg3`
- `- (void)menuNeedsUpdate:(id)arg1`
- `- (void)menuWillOpen:(id)arg1`
- `- (BOOL)validateMenuItem:(id)arg1`
- `- (void)revealNewBottle:(id)arg1`
- `- (void)newBottle:(id)arg1`
- `- (void)duplicateBottle:(id)arg1`
- `- (void)renameBottle:(id)arg1`
- `- (void)deleteBottle:(id)arg1`
- `- (void)openBottleCDrive:(id)arg1`
- `- (void)exportBottleToArchive:(id)arg1`
- `- (void)importBottleArchiveFromURL:(id)arg1`
- `- (void)importBottleArchive:(id)arg1`
- `- (void)showInstallViewWithSelectedBottle:(id)arg1 package:(id)arg2`
- `- (void)showInstallViewWithSelectedBottle:(id)arg1`
- `- (void)publishBottle:(id)arg1`
- `- (void)toggleDefaultBottle:(id)arg1`
- `- (void)toggleBottleGraphicsAuto:(id)arg1`
- `- (void)toggleBottleGraphicsD3DMetal:(id)arg1`
- `- (void)toggleBottleGraphicsDXMT:(id)arg1`
- `- (void)toggleBottleGraphicsDXVK:(id)arg1`
- `- (void)toggleBottleGraphicsWine:(id)arg1`
- `- (void)toggleBottleVulkanMoltenVK:(id)arg1`
- `- (void)toggleBottleVulkanMTLVK:(id)arg1`
- `- (void)toggleBottleDLSS:(id)arg1`
- `- (void)toggleBottleMSync:(id)arg1`
- `- (void)toggleBottleHighResolution:(id)arg1`
- `- (void)toggleBottlePreview:(id)arg1`
- `- (void)updateBottle:(id)arg1`
- `- (void)installSoftwareToBottle:(id)arg1`
- `- (void)runCommandInBottle:(id)arg1`
- `- (void)openShellForBottle:(id)arg1`
- `- (void)quitBottle:(id)arg1`
- `- (void)forceQuitBottle:(id)arg1`
- `- (id)bottleViewController`
- `- (void)setBottleViewController:(id)arg1`
- `- (id)iconViewController`
- `- (void)setIconViewController:(id)arg1`
- `- (id)packageViewController`
- `- (void)setPackageViewController:(id)arg1`
- `- (id)mainContentView`
- `- (void)setMainContentView:(id)arg1`
- `- (id)splitView`
- `- (void)setSplitView:(id)arg1`
- `- (id)topMenuNodes`
- `- (void)setTopMenuNodes:(id)arg1`
- `- (id)bottomMenuNodes`
- `- (void)setBottomMenuNodes:(id)arg1`
- `- (id)topMenuSourceView`
- `- (void)setTopMenuSourceView:(id)arg1`
- `- (id)bottomMenuSourceView`
- `- (void)setBottomMenuSourceView:(id)arg1`
- `- (id)topMenuTreeController`
- `- (void)setTopMenuTreeController:(id)arg1`
- `- (id)bottomMenuTreeController`
- `- (void)setBottomMenuTreeController:(id)arg1`
- `- (id)bottleSourceView`
- `- (void)setBottleSourceView:(id)arg1`
- `- (id)bottleTreeController`
- `- (void)setBottleTreeController:(id)arg1`
- `- (id)privateBottleGroup`
- `- (void)setPrivateBottleGroup:(id)arg1`
- `- (id)publishedBottleGroup`
- `- (void)setPublishedBottleGroup:(id)arg1`
- `- (BOOL)updating`
- `- (void)setUpdating:(BOOL)arg1`

## NSAttributedString (<Produto>Additions)

- `+ (id)cx_attributedStringWithHTML:(id)arg1 font:(id)arg2`
- `+ (id)cx_attributedStringWithHTML:(id)arg1`
- `- (id)cx_attributedStringByRemovingTrailingWhitespaceAndNewlines`

## NSFileManager (<Produto>Additions)

- `+ (id)systemPaths`
- `- (BOOL)createDirectoryAtPath:(id)arg1 attributes:(id)arg2 recursively:(BOOL)arg3`
- `- (BOOL)isSameFile:(id)arg1 asFile:(id)arg2`
- `- (id)getDisplayStringForPath:(id)arg1`
- `- (id)pathFromBookmarkData:(id)arg1 stale:(BOOL *)arg2`
- `- (id)bookmarkDataFromPath:(id)arg1`
- `- (BOOL)makeWritableAtPath:(id)arg1 recursively:(BOOL)arg2`
- `- (void)removeFolderIfEmpty:(id)arg1 upTo:(id)arg2`
- `- (BOOL)isFileInTrash:(id)arg1`
- `- (id)trashForFile:(id)arg1`
- `- (BOOL)isFile:(id)arg1 inDirectory:(id)arg2`
- `- (void)clearQuarantine:(id)arg1`

## NSMutableAttributedString (<Produto>Additions)

- `+ (id)cx_attributedStringWithHTML:(id)arg1 font:(id)arg2`
- `+ (id)cx_attributedStringWithHTML:(id)arg1`
- `- (void)cx_removeTrailingWhitespaceAndNewlines`

## NSString (<Produto>Additions)

- `- (NSString *)stringQuotedForBash`
- `- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)characterSet`
- `- (NSArray *)componentsOfCommandLine`
- `- (NSArray *)componentsSeparatedIntoAsciiAndNonAscii`
- `- (NSString *)asciiStringQuotedForAppleScript`
- `- (NSString *)nonAsciiStringQuotedForAppleScript`
- `- (NSString *)stringQuotedForAppleScript`
- `- (const char *)decomposedUTF8String`
- `- (NSString *)stringInFileSystemRepresentationForm`
- `- (BOOL)localizedStandardGreaterThan:(NSString *)other`
- `- (BOOL)localizedStandardLessThan:(NSString *)other`
- `- (NSString *)lastUnixOrWindowsPathComponent`
- `- (NSString *)MD5`
- `- (NSString *)stringByResolvingSymlinksAndAliases`
- `- (NSString *)stringByIterativelyResolvingSymlinkOrAlias`
- `- (NSString *)stringByResolvingAlias`
- `- (NSString *)stringByResolvingSymlink`
- `- (NSString *)stringByConditionallyResolvingSymlink`
- `- (NSString *)stringByConditionallyResolvingAlias`

## NSURL (<Produto>Additions)

- `- (id)stringWithFileSystemRepresentation`

## NSWorkspace (<Produto>Additions)

- `- (id)CX_findRunningAppBundleWithIdentifier:(id)arg1`
- `- (id)CX_absolutePathForAppBundleWithIdentifier:(id)arg1 orIdentifyingURLScheme:(id)arg2`
- `- (BOOL)CX_launchAppWithBundleIdentifier:(id)arg1 orIdentifyingURLScheme:(id)arg2 options:(NSUInteger)arg3 additionalEventParamDescriptor:(id)arg4`
- `- (BOOL)CX_openURLs:(id)arg1 withAppBundleIdentifier:(id)arg2 orIdentifyingURLScheme:(id)arg3 options:(NSUInteger)arg4 additionalEventParamDescriptor:(id)arg5`

## NewBottleController : CXWindowController

- `+ (id)keyPathsForValuesAffectingCanCreate`
- `- (id)init`
- `- (void)setCopyMode:(BOOL)arg1 withBottleToCopy:(id)arg2`
- `- (void)setupGUI`
- `- (void)createPressed:(id)arg1`
- `- (void)doCreate`
- `- (void)createFailed:(id)arg1`
- `- (void)exitSuccess:(id)arg1`
- `- (void)cancelPressed:(id)arg1`
- `- (BOOL)canCreate`
- `- (id)bottle`
- `- (void)setBottle:(id)arg1`
- `- (id)suggestedBottleName`
- `- (void)setSuggestedBottleName:(id)arg1`
- `- (id)archiveURL`
- `- (void)setArchiveURL:(id)arg1`
- `- (id)bottleTypePopUp`
- `- (void)setBottleTypePopUp:(id)arg1`
- `- (id)nameLabelTypeLabelWidths`
- `- (void)setNameLabelTypeLabelWidths:(id)arg1`
- `- (id)typeToCreatingSpacer`
- `- (void)setTypeToCreatingSpacer:(id)arg1`
- `- (id)sourceBottleLabel`
- `- (void)setSourceBottleLabel:(id)arg1`
- `- (id)nameLabelCopyingLabelWidths`
- `- (void)setNameLabelCopyingLabelWidths:(id)arg1`
- `- (id)sourceBottleToCreatingSpacer`
- `- (void)setSourceBottleToCreatingSpacer:(id)arg1`
- `- (id)archivePathControl`
- `- (void)setArchivePathControl:(id)arg1`
- `- (id)nameLabelRestoringLabelWidths`
- `- (void)setNameLabelRestoringLabelWidths:(id)arg1`
- `- (id)archiveToCreatingSpacer`
- `- (void)setArchiveToCreatingSpacer:(id)arg1`
- `- (id)bottleName`
- `- (void)setBottleName:(id)arg1`
- `- (id)bottleToCopy`
- `- (void)setBottleToCopy:(id)arg1`
- `- (id)bottleTemplate`
- `- (void)setBottleTemplate:(id)arg1`
- `- (id)templateArray`
- `- (void)setTemplateArray:(id)arg1`
- `- (BOOL)copyMode`
- `- (BOOL)isWorking`
- `- (void)setIsWorking:(BOOL)arg1`

## NoBottleController : CXWindowController

- `+ (id)keyPathsForValuesAffectingCanCreate`
- `- (id)initWithFileToLaunch:(id)arg1`
- `- (void)awakeFromNib`
- `- (void)createPressed:(id)arg1`
- `- (void)doCreate`
- `- (void)createFailed:(id)arg1`
- `- (void)exitSuccess:(id)arg1`
- `- (void)cancelPressed:(id)arg1`
- `- (void)scopeChanged:(id)arg1`
- `- (BOOL)canCreate`
- `- (id)fileToLaunch`
- `- (void)setFileToLaunch:(id)arg1`
- `- (id)nameForNewBottle`
- `- (void)setNameForNewBottle:(id)arg1`
- `- (id)bottleTemplate`
- `- (void)setBottleTemplate:(id)arg1`
- `- (id)fileToLaunchString`
- `- (void)setFileToLaunchString:(id)arg1`
- `- (BOOL)isWorking`
- `- (void)setIsWorking:(BOOL)arg1`
- `- (id)templateArray`
- `- (void)setTemplateArray:(id)arg1`

## PackageInstaller : CXObject

- `+ (id)keyPathsForValuesAffectingIsUnknownPackage`
- `- (id)initWithPackage:(id)arg1`
- `- (void)dealloc`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (void)setSelectedPackage:(id)arg1`
- `- (void)setSelectedBottle:(id)arg1`
- `- (void)setInstallerSource:(id)arg1`
- `- (void)setUnknownPackage:(id)arg1`
- `- (BOOL)isUnknownPackage`
- `- (void)install`
- `- (void)cancel`
- `- (void)startInstallation`
- `- (void)selectInstaller:(id)arg1`
- `- (void)selectBottleWithCompletion:(id)arg1`
- `- (void)installOptions`
- `- (void)queueInstallOperationWithTaskStatus:(id)arg1`
- `- (void)addTaskToQueue:(id)arg1`
- `- (id)visibleTask`
- `- (id)currentTaskDescription`
- `- (void)startDownloadProgressTimer`
- `- (void)stopDownloadProgressTimer`
- `- (void)updateDownloadProgress:(id)arg1`
- `- (void)spoolAvailableTasks`
- `- (void)taskCompleted:(id)arg1`
- `- (void)addBottleToInstallTask:(id)arg1`
- `- (void)removeBottleFromInstallTask:(id)arg1`
- `- (void)trackBottle:(id)arg1`
- `- (void)stopTrackingBottle:(id)arg1`
- `- (void)bottleLoadedInfo:(id)arg1`
- `- (void)continueInstallation`
- `- (void)cancelTask:(id)arg1`
- `- (void)installationOver`
- `- (void)addMountedVolumes`
- `- (void)observeMount:(id)arg1`
- `- (void)observeUnmount:(id)arg1`
- `- (void)autoPlayWithParsedAutorunFile:(id)arg1`
- `- (void)updateProfiles`
- `- (void)updateInstallationNotes`
- `- (id)detailsFromDictionary:(id)arg1 withAction:(SEL)arg2`
- `- (id)detailsFromDictionary:(id)arg1`
- `- (void)updateSummaryDetails`
- `- (void)updateCompletionNotes`
- `- (void)displayNextFailureMessage`
- `- (void)profileChanged`
- `- (void)sourceChanged`
- `- (void)bottleCreateChanged`
- `- (void)bottleNewnameChanged`
- `- (void)bottleTemplateChanged`
- `- (void)bottleNameChanged`
- `- (void)categorizedAllBottles`
- `- (void)analyzedBottle:(id)arg1`
- `- (id)delegate`
- `- (void)setDelegate:(id)arg1`
- `- (InstallConfiguration *)installConfiguration`
- `- (void)setInstallConfiguration:(id)arg1`
- `- (id)package`
- `- (void)setPackage:(id)arg1`
- `- (id)bottle`
- `- (void)setBottle:(id)arg1`
- `- (id)currentTaskDownloadDescription`
- `- (void)setCurrentTaskDownloadDescription:(id)arg1`
- `- (NSInteger)installStepsCancelled`
- `- (void)setInstallStepsCancelled:(NSInteger)arg1`
- `- (NSInteger)installStepsCompleted`
- `- (void)setInstallStepsCompleted:(NSInteger)arg1`
- `- (NSInteger)installStepsSkipped`
- `- (void)setInstallStepsSkipped:(NSInteger)arg1`
- `- (NSInteger)totalInstallSteps`
- `- (void)setTotalInstallSteps:(NSInteger)arg1`
- `- (id)completionNotes`
- `- (void)setCompletionNotes:(id)arg1`
- `- (id)installationNotes`
- `- (void)setInstallationNotes:(id)arg1`
- `- (id)summaryDetails`
- `- (void)setSummaryDetails:(id)arg1`
- `- (NSInteger)status`
- `- (void)setStatus:(NSInteger)arg1`
- `- (id)installEngine`
- `- (void)setInstallEngine:(id)arg1`
- `- (id)installQueue`
- `- (void)setInstallQueue:(id)arg1`
- `- (id)currentTasks`
- `- (void)setCurrentTasks:(id)arg1`
- `- (id)failedTasks`
- `- (void)setFailedTasks:(id)arg1`
- `- (BOOL)cancelled`
- `- (void)setCancelled:(BOOL)arg1`
- `- (id)downloadUpdateTimer`
- `- (void)setDownloadUpdateTimer:(id)arg1`
- `- (id)bottleCollection`

## PackageTreeNode : CXObject

- `+ (id)keyPathsForValuesAffectingCountString`
- `+ (id)ratingImageWithName:(id)arg1`
- `+ (id)untrustedRatingImage`
- `+ (id)starRatingImage`
- `+ (id)starOutlineRatingImage`
- `+ (id)tooltipForRating:(NSInteger)arg1`
- `+ (id)keyPathsForValuesAffectingTotalChildren`
- `+ (id)keyPathsForValuesAffectingUnknown`
- `+ (void)updateIconList`
- `+ (id)defaultIcon`
- `- (id)initRootWithChildren:(id)arg1`
- `- (id)initWithProfile:(id)arg1`
- `- (id)initWithCategoryID:(id)arg1 name:(id)arg2 children:(id)arg3 sortKey:(id)arg4`
- `- (id)copyWithZone:(NSZone *)arg1`
- `- (id)mutableCopyWithZone:(NSZone *)arg1`
- `- (void)dealloc`
- `- (id)packageid`
- `- (id)packageobject`
- `- (id)countString`
- `- (id)description`
- `- (id)descriptionFont`
- `- (id)c4pPage`
- `- (id)homePage`
- `- (id)homePageDescription`
- `- (id)medaldatemessage`
- `- (id)ratingImageForIndex:(NSUInteger)arg1`
- `- (id)ratingImage1`
- `- (id)ratingImage2`
- `- (id)ratingImage3`
- `- (id)ratingImage4`
- `- (id)ratingImage5`
- `- (id)ratingTooltip`
- `- (id)ratingDescription`
- `- (id)children`
- `- (void)insertChildren:(id)arg1 atIndexes:(id)arg2`
- `- (void)removeChildrenAtIndexes:(id)arg1`
- `- (id)unfilteredChildren`
- `- (void)insertObject:(id)arg1 inUnfilteredChildrenAtIndex:(NSUInteger)arg2`
- `- (void)insertUnfilteredChildren:(id)arg1 atIndexes:(id)arg2`
- `- (void)removeObjectFromUnfilteredChildrenAtIndex:(NSUInteger)arg1`
- `- (void)removeUnfilteredChildrenAtIndexes:(id)arg1`
- `- (void)removeAllLeaves`
- `- (void)replaceAllLeavesWithNewChildren:(id)arg1`
- `- (void)startObservingChildren`
- `- (void)stopObservingChildren`
- `- (BOOL)leaf`
- `- (id)sortkey`
- `- (NSUInteger)totalChildren`
- `- (BOOL)isUnknown`
- `- (BOOL)isComponent`
- `- (BOOL)isHighlighted`
- `- (BOOL)highlighted`
- `- (BOOL)isRanked`
- `- (BOOL)ranked`
- `- (void)filterWithPredicate:(id)arg1`
- `- (void)filterWithPredicate:(id)arg1 keepEmptyCategories:(BOOL)arg2`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (void)loadIcon`
- `- (id)softwarePackage`
- `- (void)setSoftwarePackage:(id)arg1`
- `- (id)localizedNames`
- `- (void)setDescriptionFont:(id)arg1`
- `- (id)container`
- `- (void)setContainer:(id)arg1`
- `- (id)icon`
- `- (void)setIcon:(id)arg1`

## PackageViewController : CXViewController

- `- (id)init`
- `- (void)dealloc`
- `- (void)viewDidLoad`
- `- (void)viewDidAppear`
- `- (void)viewDidDisappear`
- `- (id)packageForCategory:(id)arg1 root:(id)arg2 cache:(id)arg3`
- `- (void)populatePackages`
- `- (void)loadIcons`
- `- (void)setInstaller:(id)arg1`
- `- (void)setSelectedBottle:(id)arg1`
- `- (void)setSelectedPackage:(id)arg1`
- `- (void)updateVisiblePackages`
- `- (void)setSortDescriptors:(id)arg1`
- `- (void)setFilterPredicate:(id)arg1`
- `- (void)updateSummaryDetails`
- `- (void)openInstallerView`
- `- (void)optionsButtonClicked:(id)arg1`
- `- (void)autoPlay:(id)arg1`
- `- (void)autoPlayWithParsedFile:(id)arg1`
- `- (void)autoPlayWithAutorunFile:(id)arg1`
- `- (void)prepareDropinC4pAndAutorun:(id)arg1`
- `- (void)displayLoadingSheetAndPrepareCrossTie:(id)arg1`
- `- (void)displayEmptyFileAlert:(id)arg1`
- `- (void)displayRevokedFileAlert:(id)arg1`
- `- (NSInteger)numberOfSectionsInCollectionView:(id)arg1`
- `- (NSInteger)collectionView:(id)arg1 numberOfItemsInSection:(NSInteger)arg2`
- `- (id)collectionView:(id)arg1 itemForRepresentedObjectAtIndexPath:(id)arg2`
- `- (void)collectionView:(id)arg1 willDisplayItem:(id)arg2 forRepresentedObjectAtIndexPath:(id)arg3`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (void)back:(id)arg1`
- `- (void)back`
- `- (void)search:(id)arg1`
- `- (void)install:(id)arg1`
- `- (void)selectUnknownPackage:(id)arg1`
- `- (void)editInstallerSource:(id)arg1`
- `- (void)selectSteamInstall:(id)arg1`
- `- (void)selectInstallerDownload:(id)arg1`
- `- (void)selectInstaller:(id)arg1`
- `- (void)selectBottle:(id)arg1`
- `- (void)c4pButton:(id)arg1`
- `- (void)downloadButton:(id)arg1`
- `- (void)installOptions:(id)arg1`
- `- (void)installationCompleted`
- `- (void)installationStarted`
- `- (id)window`
- `- (BOOL)performDragOperation:(id)arg1`
- `- (BOOL)textFieldIsTruncated:(id)arg1`
- `- (void)startObservingFrameOfView:(id)arg1`
- `- (void)stopObservingFrameOfView:(id)arg1`
- `- (void)subviewFrameChanged:(id)arg1`
- `- (void)updatePackageDescriptionTruncation`
- `- (void)updateInstallationNotesTruncation`
- `- (void)expandPackageDescription:(BOOL)arg1`
- `- (void)expandInstallationNotes:(BOOL)arg1`
- `- (void)packageDescriptionExpandButtonClicked:(id)arg1`
- `- (void)installationNotesExpandButtonClicked:(id)arg1`
- `- (id)delegate`
- `- (void)setDelegate:(id)arg1`
- `- (id)packages`
- `- (void)setPackages:(id)arg1`
- `- (id)unknownPackage`
- `- (void)setUnknownPackage:(id)arg1`
- `- (id)sortDescriptors`
- `- (id)filterPredicate`
- `- (BOOL)isHighlighted`
- `- (void)setIsHighlighted:(BOOL)arg1`
- `- (id)visiblePackages`
- `- (void)setVisiblePackages:(id)arg1`
- `- (id)summaryDetailsControllers`
- `- (void)setSummaryDetailsControllers:(id)arg1`
- `- (id)installer`
- `- (id)packageView`
- `- (void)setPackageView:(id)arg1`
- `- (id)collectionView`
- `- (void)setCollectionView:(id)arg1`
- `- (id)loading`
- `- (void)setLoading:(id)arg1`
- `- (id)noResultsLabel`
- `- (void)setNoResultsLabel:(id)arg1`
- `- (id)searchField`
- `- (void)setSearchField:(id)arg1`
- `- (id)installUnlistedAppButton`
- `- (void)setInstallUnlistedAppButton:(id)arg1`
- `- (id)packageViewTitle`
- `- (void)setPackageViewTitle:(id)arg1`
- `- (id)installerView`
- `- (void)setInstallerView:(id)arg1`
- `- (id)installButton`
- `- (void)setInstallButton:(id)arg1`
- `- (id)optionsButton`
- `- (void)setOptionsButton:(id)arg1`
- `- (id)optionsMenu`
- `- (void)setOptionsMenu:(id)arg1`
- `- (id)installerSourceMenu`
- `- (void)setInstallerSourceMenu:(id)arg1`
- `- (id)installWithSteamMenuItem`
- `- (void)setInstallWithSteamMenuItem:(id)arg1`
- `- (id)downloadInstallerMenuItem`
- `- (void)setDownloadInstallerMenuItem:(id)arg1`
- `- (id)summaryDetailsView`
- `- (void)setSummaryDetailsView:(id)arg1`
- `- (id)packageDescriptionTextField`
- `- (void)setPackageDescriptionTextField:(id)arg1`
- `- (id)packageDescriptionExpandButton`
- `- (void)setPackageDescriptionExpandButton:(id)arg1`
- `- (id)packageDescriptionMoreLabel`
- `- (void)setPackageDescriptionMoreLabel:(id)arg1`
- `- (id)installationNotesTextField`
- `- (void)setInstallationNotesTextField:(id)arg1`
- `- (id)installationNotesMoreLabel`
- `- (void)setInstallationNotesMoreLabel:(id)arg1`
- `- (id)installationNotesExpandButton`
- `- (void)setInstallationNotesExpandButton:(id)arg1`
- `- (id)packageDescriptionCollapsedHeightConstraint`
- `- (void)setPackageDescriptionCollapsedHeightConstraint:(id)arg1`
- `- (id)installationNotesCollapsedHeightConstraint`
- `- (void)setInstallationNotesCollapsedHeightConstraint:(id)arg1`

## PackageViewItem : NSCollectionViewItem

- `- (id)init`
- `- (id)dividerLine`
- `- (void)setDividerLine:(id)arg1`

## PreferencesController : CXWindowController

- `- (id)init`
- `- (void)dealloc`
- `- (void)windowDidLoad`
- `- (void)updateC4PModDate`
- `- (void)windowWillLoad`
- `- (void)bottlesFolderChanged:(id)arg1`
- `- (void)resetBottlesFolder:(id)arg1`
- `- (void)browseForBottlesFolder:(id)arg1`
- `- (void)programsFolderChanged:(id)arg1`
- `- (void)resetProgramsFolder:(id)arg1`
- `- (void)browseForProgramsFolder:(id)arg1`
- `- (BOOL)panel:(id)arg1 isValidFilename:(id)arg2`
- `- (id)installerCacheSizeStringWhileCalculating`
- `- (void)enumerateCachedInstallersWithBlock:(void (^)(NSURL *itemURL))arg1`
- `- (void)calculateInstallerCacheSize`
- `- (void)installersCacheEventStreamCallback`
- `- (void)clearInstallerCache:(id)arg1`
- `- (void)openInstallerCache:(id)arg1`
- `- (id)installerCacheSizeLabel`
- `- (void)setInstallerCacheSizeLabel:(id)arg1`
- `- (id)bottlesFolderURL`
- `- (void)setBottlesFolderURL:(id)arg1`
- `- (id)programsFolderURL`
- `- (void)setProgramsFolderURL:(id)arg1`
- `- (id)lastUpdated`
- `- (void)setLastUpdated:(id)arg1`

## PropertyDescriptor : CXObject

- `- (id)description`
- `- (id)installTaskAttribute`
- `- (void)setInstallTaskAttribute:(id)arg1`
- `- (BOOL)boolTyped`
- `- (void)setBoolTyped:(BOOL)arg1`
- `- (id)getter`
- `- (void)setGetter:(id)arg1`
- `- (id)setter`
- `- (void)setSetter:(id)arg1`

## PublishController : CXWindowController

- `+ (id)keyPathsForValuesAffectingNameCollides`
- `+ (id)keyPathsForValuesAffectingCanPublish`
- `- (id)init`
- `- (void)setBottleName:(id)arg1`
- `- (void)setupGUI`
- `- (void)publishPressed:(id)arg1`
- `- (void)doPublish`
- `- (void)publishFailed`
- `- (void)exitSuccess:(id)arg1`
- `- (void)cancelPressed:(id)arg1`
- `- (BOOL)nameCollides`
- `- (BOOL)canPublish`
- `- (NSArray *)publishArguments`
- `- (void)setSourceBottle:(id)arg1`
- `- (id)bottleName`
- `- (id)bounceUtil`
- `- (void)setBounceUtil:(id)arg1`
- `- (id)sourceBottle`
- `- (id)authorization`
- `- (void)setAuthorization:(id)arg1`
- `- (BOOL)isWorking`
- `- (void)setIsWorking:(BOOL)arg1`

## RatingNotesFormatter : NSFormatter

- `- (id)stringForObjectValue:(id)arg1`
- `- (BOOL)getObjectValue:(id *)arg1 forString:(NSString *)arg2 errorDescription:(NSString **)arg3`
- `- (BOOL)isPartialStringValid:(NSString **)arg1 proposedSelectedRange:(NSRangePointer)arg2 originalString:(NSString *)arg3 originalSelectedRange:(NSRange)arg4 errorDescription:(NSString **)arg5`
- `- (NSInteger)maxLength`
- `- (void)setMaxLength:(NSInteger)arg1`

## RegistrationController : CXObject

- `- (id)init`
- `- (BOOL)authIfNeeded`
- `- (id)formatSerialCode:(id)arg1`
- `- (void)beginRegisterAppWithSerialCodeWithCompletionHandler:(id)arg1`
- `- (void)beginRegisterAppWithCompletionHandler:(id)arg1`
- `- (void)handleRegistrationData:(id)arg1`
- `- (void)handleSerialCodeAccountCreationData:(id)arg1`
- `- (void)downloadTaskCompleted:(id)arg1 response:(id)arg2 error:(id)arg3 successHandler:(id)arg4 errorMessageText:(id)arg5`
- `- (BOOL)moveFile:(id)arg1 dest:(id)arg2`
- `- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 movingItemAtURL:(id)arg3 toURL:(id)arg4`
- `- (void)cancel`
- `- (BOOL)validLogin`
- `- (BOOL)validPassword`
- `- (BOOL)validSerialCode`
- `- (id)login`
- `- (void)setLogin:(id)arg1`
- `- (id)login2`
- `- (void)setLogin2:(id)arg1`
- `- (id)loginErrorText`
- `- (void)setLoginErrorText:(id)arg1`
- `- (id)password`
- `- (void)setPassword:(id)arg1`
- `- (id)password2`
- `- (void)setPassword2:(id)arg1`
- `- (id)passwordErrorText`
- `- (void)setPasswordErrorText:(id)arg1`
- `- (NSInteger)registrationWorkInProgress`
- `- (void)setRegistrationWorkInProgress:(NSInteger)arg1`
- `- (NSInteger)regMode`
- `- (void)setRegMode:(NSInteger)arg1`
- `- (id)globalRegModeCaption`
- `- (void)setGlobalRegModeCaption:(id)arg1`
- `- (id)accountName`
- `- (void)setAccountName:(id)arg1`
- `- (id)serialCode`
- `- (void)setSerialCode:(id)arg1`
- `- (id)serialCodeErrorText`
- `- (void)setSerialCodeErrorText:(id)arg1`
- `- (void (^)(BOOL, NSString *, NSString *))completionHandler`
- `- (void)setCompletionHandler:(id)arg1`

## RosettaInstallationController : CXWindowController

- `- (id)init`
- `- (void)findDetailsConstraints:(id)arg1`
- `- (void)windowDidLoad`
- `- (void)exitButton:(id)arg1`
- `- (void)installFailed`
- `- (void)installButton:(id)arg1`
- `- (void)sheetDoneButton:(id)arg1`
- `- (void)sheetDetailDisclosureButton:(id)arg1`
- `- (id)task`
- `- (void)setTask:(id)arg1`
- `- (id)detailsShownConstraints`
- `- (void)setDetailsShownConstraints:(id)arg1`
- `- (id)detailsHiddenConstraints`
- `- (void)setDetailsHiddenConstraints:(id)arg1`
- `- (id)licenseLabel`
- `- (void)setLicenseLabel:(id)arg1`
- `- (id)titleLabel`
- `- (void)setTitleLabel:(id)arg1`
- `- (id)progressSheet`
- `- (void)setProgressSheet:(id)arg1`
- `- (id)progressSheetDetailsLabel`
- `- (void)setProgressSheetDetailsLabel:(id)arg1`
- `- (id)progressSheetDoneButton`
- `- (void)setProgressSheetDoneButton:(id)arg1`
- `- (id)progressSheetIcon`
- `- (void)setProgressSheetIcon:(id)arg1`
- `- (id)progressSheetProgressIndicator`
- `- (void)setProgressSheetProgressIndicator:(id)arg1`
- `- (id)progressSheetShowHideDetailsButton`
- `- (void)setProgressSheetShowHideDetailsButton:(id)arg1`
- `- (id)progressSheetScrollView`
- `- (void)setProgressSheetScrollView:(id)arg1`
- `- (id)progressSheetTextView`
- `- (void)setProgressSheetTextView:(id)arg1`

## RunCommandController : CXWindowController

- `+ (BOOL)automaticallyNotifiesObserversOfSelectedBottle`
- `+ (BOOL)automaticallyNotifiesObserversOfSelectedBottleIndexes`
- `+ (id)keyPathsForValuesAffectingCanRun`
- `- (id)init`
- `- (id)initWithFileToRun:(id)arg1`
- `- (void)dealloc`
- `- (void)setSelectedBottle:(id)arg1`
- `- (void)setSelectedBottleIndexes:(id)arg1`
- `- (void)browseForCommand:(id)arg1`
- `- (void)runCommandPressed:(id)arg1`
- `- (void)runCommand`
- `- (void)getStdout:(id)arg1`
- `- (void)getStderr:(id)arg1`
- `- (void)didTerminate:(id)arg1`
- `- (void)commandComplete`
- `- (void)setCommand:(id)arg1`
- `- (void)setCommandRunning:(BOOL)arg1`
- `- (id)bottleCollection`
- `- (void)createIcon:(id)arg1`
- `- (void)windowDidLoad`
- `- (void)windowWillClose:(id)arg1`
- `- (BOOL)canRun`
- `- (BOOL)supportsAVX`
- `- (void)appendEnvVar:(id)arg1`
- `- (void)metalHudSelected:(id)arg1`
- `- (void)AVXSelected:(id)arg1`
- `- (id)bottleArray`
- `- (void)setBottleArray:(id)arg1`
- `- (id)selectedBottle`
- `- (id)selectedBottleIndexes`
- `- (id)failAlertAccessoryView`
- `- (void)setFailAlertAccessoryView:(id)arg1`
- `- (id)failAlertTextView`
- `- (void)setFailAlertTextView:(id)arg1`
- `- (BOOL)enableLoggingChannelsControls`
- `- (id)launcher`
- `- (void)setLauncher:(id)arg1`
- `- (id)loggingViewContainer`
- `- (void)setLoggingViewContainer:(id)arg1`
- `- (id)modeSpecificViewContainer`
- `- (void)setModeSpecificViewContainer:(id)arg1`
- `- (id)nonLauncherModeView`
- `- (void)setNonLauncherModeView:(id)arg1`
- `- (id)nonLauncherModeCommandTextField`
- `- (void)setNonLauncherModeCommandTextField:(id)arg1`
- `- (id)command`
- `- (BOOL)commandRunning`
- `- (id)canRunFilterPredicate`
- `- (void)setCanRunFilterPredicate:(id)arg1`
- `- (id)launcherModeViewController`
- `- (void)setLauncherModeViewController:(id)arg1`
- `- (id)loggingOptions`
- `- (void)setLoggingOptions:(id)arg1`
- `- (id)envVars`
- `- (void)setEnvVars:(id)arg1`
- `- (id)stdErr`
- `- (void)setStdErr:(id)arg1`

## RunCommandLauncherModeViewController : CXViewController

- `- (id)init`
- `- (void)loadView`
- `- (id)launcherIconImageView`
- `- (void)setLauncherIconImageView:(id)arg1`
- `- (id)launcherNameTextField`
- `- (void)setLauncherNameTextField:(id)arg1`

## SelectBottleController : CXViewController

- `+ (void)initialize`
- `- (id)init`
- `- (void)dealloc`
- `- (void)awakeFromNib`
- `- (void)setSelectedBottle:(id)arg1`
- `- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4`
- `- (id)allowedFileTypes`
- `- (BOOL)panel:(id)arg1 shouldShowFilename:(id)arg2`
- `- (id)bottleArrayController`
- `- (void)setBottleArrayController:(id)arg1`
- `- (id)selectedBottle`
- `- (id)canRunFilterPredicate`
- `- (void)setCanRunFilterPredicate:(id)arg1`

## SelectBottleSheetController : CXWindowController

- `+ (id)keyPathsForValuesAffectingCreatingNewBottle`
- `+ (id)keyPathsForValuesAffectingConfigurationIsValid`
- `- (id)initWithInstallConfiguration:(id)arg1`
- `- (void)dealloc`
- `- (void)windowDidLoad`
- `- (BOOL)isTemplate:(id)arg1`
- `- (BOOL)creatingNewBottle`
- `- (void)setNameForNewBottle:(id)arg1`
- `- (id)stringInSystemFont:(id)arg1`
- `- (id)attributedStringWithImageNamed:(id)arg1`
- `- (id)attributedErrorStringWithString:(id)arg1`
- `- (id)attributedWarningStringWithString:(id)arg1`
- `- (void)updateBottleWarningText`
- `- (void)addMenuItemsFromCategories:(id)arg1 isBottles:(BOOL)arg2`
- `- (void)bottleItemSelected:(id)arg1`
- `- (void)templateItemSelected:(id)arg1`
- `- (void)updateBottlesList`
- `- (void)updateTemplatesList`
- `- (void)updateMenus`
- `- (void)updateInstallTaskWithBottleSelection`
- `- (BOOL)configurationIsValid`
- `- (void)done:(id)arg1`
- `- (void)cancel:(id)arg1`
- `- (void)windowWillClose:(id)arg1`
- `- (void)profileChanged`
- `- (void)bottleCreateChanged`
- `- (void)bottleNewnameChanged`
- `- (void)bottleTemplateChanged`
- `- (void)bottleNameChanged`
- `- (void)categorizedAllBottles`
- `- (void)analyzedBottle:(id)arg1`
- `- (InstallConfiguration *)installConfiguration`
- `- (id)bottleCollection`
- `- (id)categorizedBottles`
- `- (void)setCategorizedBottles:(id)arg1`
- `- (id)categorizedTemplates`
- `- (void)setCategorizedTemplates:(id)arg1`
- `- (id)bottleWarningText`
- `- (void)setBottleWarningText:(id)arg1`
- `- (id)nameForNewBottle`
- `- (id)targetBottle`
- `- (void)setTargetBottle:(id)arg1`
- `- (id)doneButton`
- `- (void)setDoneButton:(id)arg1`
- `- (id)nameForNewBottleTextField`
- `- (void)setNameForNewBottleTextField:(id)arg1`
- `- (id)bottleListPopUpButton`
- `- (void)setBottleListPopUpButton:(id)arg1`
- `- (id)makeNewBottleMenuItem`
- `- (void)setMakeNewBottleMenuItem:(id)arg1`
- `- (id)selectBottlePlaceholderMenuItem`
- `- (void)setSelectBottlePlaceholderMenuItem:(id)arg1`
- `- (id)templateTypesPopUpButton`
- `- (void)setTemplateTypesPopUpButton:(id)arg1`

## SerialCodeRegisterController : DemoBaseController

- `- (id)init`
- `- (void)registerWithSerialCode:(id)arg1`
- `- (void)exitSuccess`
- `- (void)cancel:(id)arg1`
- `- (void)openNormalRegistrationWindow:(id)arg1`
- `- (id)regController`

## ShutdownController : CXWindowController

- `- (id)init`
- `- (id)bottleCollection`
- `- (void)cancelShutdown:(id)arg1`
- `- (void)forceShutdown:(id)arg1`
- `- (void)shutdownAllBottles`
- `- (void)shutdownAllBottlesBackground`
- `- (void)killAllBottles`
- `- (void)windowDidLoad`
- `- (id)quitBottleSemaphore`
- `- (void)setQuitBottleSemaphore:(id)arg1`
- `- (BOOL)cancelingShutdown`
- `- (void)setCancelingShutdown:(BOOL)arg1`
- `- (BOOL)forcingShutdown`
- `- (void)setForcingShutdown:(BOOL)arg1`
- `- (id)bottleList`
- `- (void)setBottleList:(id)arg1`
- `- (id)canRunFilterPredicate`
- `- (void)setCanRunFilterPredicate:(id)arg1`
- `- (id)shutdownCallbackObject`
- `- (void)setShutdownCallbackObject:(id)arg1`
- `- (SEL)shutdownCallbackSelector`
- `- (void)setShutdownCallbackSelector:(SEL)arg1`

## SubmitRatingController : CXWindowController

- `+ (id)keyPathsForValuesAffectingRatingDescription`
- `+ (id)keyPathsForValuesAffectingCharactersLeft`
- `+ (id)keyPathsForValuesAffectingCanSubmit`
- `- (id)initWithBottle:(id)arg1`
- `- (id)initWithBottle:(id)arg1 isNag:(BOOL)arg2 isDeleting:(BOOL)arg3`
- `- (void)windowDidLoad`
- `- (id)ratingDescription`
- `- (NSInteger)charactersLeft`
- `- (BOOL)canSubmit`
- `- (BOOL)askAgain`
- `- (void)submit:(id)arg1`
- `- (void)never:(id)arg1`
- `- (void)cancel:(id)arg1`
- `- (void)close`
- `- (void)handleLogin:(BOOL)arg1`
- `- (void)doSubmit`
- `- (void)doRegister`
- `- (void)windowDidBecomeKey:(id)arg1`
- `- (void)controlTextDidChange:(id)arg1`
- `- (id)stackView`
- `- (void)setStackView:(id)arg1`
- `- (id)ratingIndicator`
- `- (void)setRatingIndicator:(id)arg1`
- `- (id)notesField`
- `- (void)setNotesField:(id)arg1`
- `- (id)submitButton`
- `- (void)setSubmitButton:(id)arg1`
- `- (id)notesFormatter`
- `- (void)setNotesFormatter:(id)arg1`
- `- (id)forgotPasswordLabel`
- `- (void)setForgotPasswordLabel:(id)arg1`
- `- (id)emailField`
- `- (void)setEmailField:(id)arg1`
- `- (id)bottle`
- `- (void)setBottle:(id)arg1`
- `- (id)dialogTitle`
- `- (void)setDialogTitle:(id)arg1`
- `- (id)message`
- `- (void)setMessage:(id)arg1`
- `- (NSInteger)rating`
- `- (void)setRating:(NSInteger)arg1`
- `- (id)notes`
- `- (void)setNotes:(id)arg1`
- `- (void)setCharactersLeft:(NSInteger)arg1`
- `- (id)email`
- `- (void)setEmail:(id)arg1`
- `- (id)password`
- `- (void)setPassword:(id)arg1`
- `- (BOOL)loggingIn`
- `- (void)setLoggingIn:(BOOL)arg1`
- `- (BOOL)failed`
- `- (void)setFailed:(BOOL)arg1`
- `- (BOOL)nag`
- `- (void)setNag:(BOOL)arg1`
- `- (BOOL)deleting`
- `- (void)setDeleting:(BOOL)arg1`
- `- (id)ratingUtils`
- `- (id)appid`
- `- (void)setAppid:(id)arg1`

## SummaryDetail : CXObject

- `+ (id)detailWithType:(NSInteger)arg1 label:(id)arg2 action:(SEL)arg3`
- `- (NSInteger)type`
- `- (void)setType:(NSInteger)arg1`
- `- (id)label`
- `- (void)setLabel:(id)arg1`
- `- (SEL)action`
- `- (void)setAction:(SEL)arg1`
- `- (id)image`
- `- (void)setImage:(id)arg1`

## TaskStatus : CXObject

- `- (id)initWithTask:(id)arg1`
- `- (void)cancel`
- `- (void)done`
- `- (BOOL)finished`
- `- (void)setFinished:(BOOL)arg1`
- `- (BOOL)success`
- `- (void)setSuccess:(BOOL)arg1`
- `- (id)label`
- `- (void)setLabel:(id)arg1`
- `- (id)task`
- `- (void)setTask:(id)arg1`
- `- (id)installOp`
- `- (void)setInstallOp:(id)arg1`

## UpdateController : CXWindowController

- `- (id)initWithManagedBottles:(id)arg1`
- `- (void)windowDidLoad`
- `- (void)finish`
- `- (void)updatePressed:(id)arg1`
- `- (void)doUpdateWithAuthorization:(id)arg1`
- `- (NSArray *)managedUpdateArgumentsForBottleName:(NSString *)arg1`
- `- (void)updateBottle:(id)arg1 WithAuthorization:(id)arg2`
- `- (void)updateLaterPressed:(id)arg1`
- `- (id)messageTextField`
- `- (void)setMessageTextField:(id)arg1`
- `- (id)bottleTableScrollView`
- `- (void)setBottleTableScrollView:(id)arg1`
- `- (id)messageToTableSpacing`
- `- (void)setMessageToTableSpacing:(id)arg1`
- `- (id)tableToUpgradingSpacing`
- `- (void)setTableToUpgradingSpacing:(id)arg1`
- `- (id)managedBottlesToUpgrade`
- `- (void)setManagedBottlesToUpgrade:(id)arg1`
- `- (BOOL)upgradeInProgress`
- `- (void)setUpgradeInProgress:(BOOL)arg1`

## helperServer : NSObject

- `+ (id)defaultHelperServer`
- `- (id)init`
- `- (bycopy id)getEnvironmentForXConnection`
- `- (void)setIsReady`
- `- (BOOL)isServerReady`
- `- (BOOL)isServerReadyForBottle:(id)arg1`
- `- (oneway void)raiseWindowsWithTag:(NSInteger)arg1`
- `- (id)theConnection`
- `- (void)setTheConnection:(id)arg1`

## Funções C (c_functions.h)

- `int main(int argc, const char * argv[])`
- `void _CXLog(NSString *format, ...)`
- `void _InitializePython(NSString *scriptName)`
- `void _PFMoveToApplicationsFolderIfNecessary(void)`
- `BOOL _IsLaunchedFromDMG(void)`
- `BOOL _PathIsWithinPath(NSString *path, NSString *parent)`
- `BOOL _Trash(NSString *path)`
- `void _InstallersCacheEventStreamCallback(ConstFSEventStreamRef streamRef, void *clientCallBackInfo, size_t numEvents, void *eventPaths, const FSEventStreamEventFlags eventFlags[], const FSEventStreamEventId eventIds[])`
- `void _observeProxyChange(void)`
- `void _initCharacterSets(void)`
- `NSComparisonResult _CompareLanguageEntries(id entry1, id entry2, void *context)`
- `BOOL _boolGetterMethodFastIMP(id self, SEL _cmd)`
- `BOOL _boolGetterMethodIMP(id self, SEL _cmd)`
- `id _objectGetterMethodFastIMP(id self, SEL _cmd)`
- `id _objectGetterMethodIMP(id self, SEL _cmd)`
- `void _boolSetterMethodIMP(id self, SEL _cmd, BOOL val)`
- `void _objectSetterMethodIMP(id self, SEL _cmd, id val)`

## Branding (CrossThroughBranding.h)

- `NSString *CTApplicationName(void);`
- `void CTRegisterBrandedLogo(void);`
- `void CTBrandAppMenu(void);`
