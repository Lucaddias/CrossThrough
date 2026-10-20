// BottleViewController.m — CrossThrough
#import "BottleViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static void *_BottleViewControllerKVCContext = &_BottleViewControllerKVCContext;

static CXServerCrossOver *BottleViewControllerServer(void) {
    return (CXServerCrossOver *)[(CXApplication *)NSApp CXServer];
}


@implementation BottleViewController

+ (id)keyPathsForValuesAffectingBottleDescription {
    return [NSSet setWithObject:@"bottle.currentDescription"];
}

- (id)init {
    self = [super initWithNibName:@"BottleView" bundle:nil];
    if (self) {
        [self setObservers:@[@"canForceQuit", @"canRunCommands", @"isActive", @"isBusy",
                             @"isDefault", @"isControlPanelReady", @"isHighResolutionEnabledReady",
                             @"isD3DMetalEnabled", @"isDLSSEnabled", @"isDXMTEnabled", @"isDXVKEnabled",
                             @"isWineD3DEnabled", @"isMoltenVKEnabled", @"isMTLVKEnabled",
                             @"isMSyncEnabled", @"isPreviewEnabled"]];
    }
    return self;
}

- (void)dealloc {
    if ([self isViewLoaded]) {
        [BottleViewControllerServer() removeObserver:self forKeyPath:@"launchers"];
    }
    for (NSString *keyPath in [self observers]) {
        [self->_bottle removeObserver:self forKeyPath:keyPath];
    }
    [[self iconCollectionView] setDelegate:nil];
    [self->_bottle release];
    [self->_observers release];
    [self->_package release];
    [self->_iconCollectionViewController release];
    [self->_controlPanelLaunchers release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    IconCollectionViewController *icvc = [[IconCollectionViewController alloc] init];
    [self setIconCollectionViewController:icvc];
    [icvc release];

    NSView *iconView = [[self iconCollectionViewController] view];
    [[self iconCollectionView] setSubviews:@[iconView]];
    NSDictionary *views = NSDictionaryOfVariableBindings(iconView);
    [[self iconCollectionView] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[iconView]|" options:0 metrics:nil views:views]];
    [[self iconCollectionView] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[iconView]|" options:0 metrics:nil views:views]];
    [[self iconCollectionViewController] setMargins:NSEdgeInsetsMake(0.0, 40.0, 0.0, 0.0)];
    [[self iconCollectionViewController] setDelegate:self];

    [BottleViewControllerServer() addObserver:self forKeyPath:@"launchers" options:0 context:_BottleViewControllerKVCContext];

    [[self controlPanelsLoadingSpinner] setUsesThreadedAnimation:YES];
    [self setControlPanelLaunchers:[NSMutableArray array]];

    NSBundle *bundle = [NSBundle mainBundle];
    [[self graphicsOptionView] setToolTip:[bundle localizedStringForKey:@"Graphics backend options" value:@"" table:nil]];
    CXFlatPopUpButton *graphics = [self graphicsPopUpButton];
    [self setAutoGraphicsMenuItem:[graphics addItemWithTitle:[bundle localizedStringForKey:@"Auto" value:@"" table:nil]
                                                     toolTip:[bundle localizedStringForKey:@"Automatically use the best graphics backend" value:@"" table:nil]]];
    [self setD3dMetalMenuItem:[graphics addItemWithTitle:[bundle localizedStringForKey:@"D3DMetal" value:@"" table:nil] toolTip:@""]];
    [self setDxmtMenuItem:[graphics addItemWithTitle:[bundle localizedStringForKey:@"DXMT" value:@"" table:nil] toolTip:@""]];
    [self setDxvkMenuItem:[graphics addItemWithTitle:[bundle localizedStringForKey:@"DXVK" value:@"" table:nil]
                                             toolTip:[bundle localizedStringForKey:@"DXVK graphics backend" value:@"" table:nil]]];
    [self setWined3dMenuItem:[graphics addItemWithTitle:[bundle localizedStringForKey:@"Wine" value:@"" table:nil]
                                                toolTip:[bundle localizedStringForKey:@"Wine graphics backend" value:@"" table:nil]]];
    CXFlatPopUpButton *vulkan = [self vulkanPopUpButton];
    [self setMoltenvkMenuItem:[vulkan addItemWithTitle:[bundle localizedStringForKey:@"MoltenVK" value:@"" table:nil]
                                               toolTip:[bundle localizedStringForKey:@"MoltenVK Vulkan backend" value:@"" table:nil]]];
    [self setMtlvkMenuItem:[vulkan addItemWithTitle:@"MTLVK" toolTip:@"MTLVK translation layer for D3D12."]];

    NSSortDescriptor *byName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
    [[self installedSoftwareTableView] setSortDescriptors:@[byName]];
    [[self leaveRatingButton] setContentTintColor:[NSColor linkColor]];
    [[self iconCollectionView] registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
    [[self iconCollectionView] setDelegate:self];
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    if (self->_bottle == arg1) {
        return;
    }
    for (NSString *keyPath in [self observers]) {
        [self->_bottle removeObserver:self forKeyPath:keyPath];
    }
    [self willChangeValueForKey:@"bottle"];
    [self->_bottle release];
    self->_bottle = [arg1 retain];
    [self didChangeValueForKey:@"bottle"];

    [self setPackage:[self packageForBottle:arg1]];
    if ([self package] && [[self package] packageobject]) {
        [self setCanBeRated:![[self package] isComponent] && ![arg1 isIsManaged]];
    } else {
        [self setCanBeRated:NO];
    }
    [self reloadLaunchers];
    [self resetMenuForNewBottle];
    [[self bottle] loadApplicationInfo];
    for (NSString *keyPath in [self observers]) {
        [self->_bottle addObserver:self forKeyPath:keyPath options:0 context:_BottleViewControllerKVCContext];
    }
}

- (void)reloadLaunchers {
    NSArray *launchers = [BottleViewControllerServer() launchers];
    [[self iconCollectionViewController] setLaunchers:[self launcherNodesForLaunchers:launchers]];
    [[self noAppsFoundLabel] setHidden:[[[self iconCollectionViewController] launchers] count] != 0];
}

- (void)reloadControlPanels {
    [[self controlPanelLaunchers] removeAllObjects];
    NSArray *arranged = [[[[self controlPanelsSection] arrangedSubviews] copy] autorelease];
    for (NSView *view in arranged) {
        if (view != [self controlPanelsLoadingView]) {
            [[self controlPanelsSection] removeArrangedSubview:view];
            [view removeFromSuperview];
        }
    }
    if ([[self bottle] isIsControlPanelReady]) {
        [self showControlPanelLoader:NO];
        NSMutableArray *panels = [NSMutableArray arrayWithArray:[[self bottle] controlPanelTable]];
        [self sortControlPanels:panels];
        for (NSUInteger i = 0; i < [panels count]; i++) {
            id panel = [panels objectAtIndexedSubscript:i];
            [[self controlPanelLaunchers] addObject:[LauncherControlPanel launcherWithControlPanel:panel bottle:[self bottle]]];
            [self addButtonForControlPanel:panel index:i];
        }
    } else {
        [self showControlPanelLoader:YES];
        [[self bottle] loadControlPanelInfo];
    }
}

- (id)packageForBottle:(id)arg1 {
    id profiles = [[CXSetupLib c4ProfilesClass] profilesSet];
    NSDictionary *profilesByID = [profiles respondsToSelector:@selector(contentsDict)] ? [profiles contentsDict] : profiles;
    NSString *appID = [NSString stringWithFormat:@"com.codeweavers.c4.%@", [[self bottle] appid]];
    id profile = [profilesByID objectForKey:appID];
    return [[[PackageTreeNode alloc] initWithProfile:profile] autorelease];
}


- (void)updateDependencyButton {
    NSArray *missing = [[CXSetupLib installTaskClass] getMissingDependencies:[self bottle]];
    [[self dependencyButton] setHidden:[missing count] == 0];
}

- (void)updateQuitButton {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *tooltipFormat;
    if ([[self bottle] isCanForceQuit]) {
        [[self quitButton] setTitle:[bundle localizedStringForKey:@"Force Quit" value:@"" table:nil]];
        [[self quitButton] setEnabled:YES];
        tooltipFormat = [bundle localizedStringForKey:@"Force quit all applications in the '%@' bottle" value:@"" table:nil];
    } else {
        [[self quitButton] setTitle:[bundle localizedStringForKey:@"Quit All Applications" value:@"" table:nil]];
        tooltipFormat = [bundle localizedStringForKey:@"Quit all applications in the '%@' bottle" value:@"" table:nil];
    }
    [[self quitButton] setToolTip:[NSString stringWithFormat:tooltipFormat, [[self bottle] name]]];
}

- (void)updateMenuItems {
    BottleWrapper *bottle = [self bottle];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *bottleName = [bottle name];
    BOOL configurable = ![bottle isIsManaged] && ![bottle isIsDisabled];
    LauncherTreeNode *selected = [[self iconCollectionViewController] selectedLauncher];

    [[self runWithOptionsButton] setHidden:selected == nil];
    [[self runWithOptionsButton] setToolTip:[bundle localizedStringForKey:@"Run the selected launcher with options" value:@"" table:nil]];
    [[self runWithOptionsButton] setEnabled:[bottle isCanRunCommands] && [selected canRunCommands]];

    [[self runCommandButton] setEnabled:[bottle isCanRunCommands]];
    [[self runCommandButton] setToolTip:[NSString stringWithFormat:[bundle localizedStringForKey:@"Select a command to run in the '%@' bottle" value:@"" table:nil], bottleName]];
    [[self openCDriveButton] setEnabled:[bottle isIsUsable]];
    [[self openCDriveButton] setToolTip:[NSString stringWithFormat:[bundle localizedStringForKey:@"Open the C: drive for the '%@' bottle" value:@"" table:nil], bottleName]];
    [[self installIntoBottleButton] setEnabled:[bottle isCanInstall]];
    [[self installIntoBottleButton] setToolTip:[NSString stringWithFormat:[bundle localizedStringForKey:@"Install a Windows application into the '%@' bottle" value:@"" table:nil], bottleName]];
    [[self deleteButton] setEnabled:![bottle isIsBusy]];
    [[self deleteButton] setToolTip:[NSString stringWithFormat:[bundle localizedStringForKey:@"Delete the '%@' bottle" value:@"" table:nil], bottleName]];

    NSColor *enabledColor = [NSColor labelColor];
    NSColor *disabledColor = [NSColor secondarySelectedControlColor];

    // Graphics backend.
    [[self graphicsPopUpButton] setEnabled:configurable && [bottle isCanRunCommands]];
    [[self graphicsLabel] setTextColor:[[self graphicsPopUpButton] isEnabled] ? enabledColor : disabledColor];
    NSString *d3dMetalTip = [bundle localizedStringForKey:@"D3DMetal translation layer for D3D11 and D3D12.\nPart of the Game Porting Toolkit." value:@"" table:nil];
    [[self d3dMetalMenuItem] setEnabled:[bottle isIsD3DMetalAvailable] && ![bottle isIsMTLVKEnabled]];
    [[self d3dMetalMenuItem] setToolTip:d3dMetalTip];
    if (![bottle isIsD3DMetalAvailable]) {
        [[self d3dMetalMenuItem] setToolTip:[bundle localizedStringForKey:@"D3DMetal translation layer for D3D11 and D3D12.\nPart of the Game Porting Toolkit.\n\nNot supported on this computer: requires Apple Silicon and macOS Sonoma." value:@"" table:nil]];
    }
    [[self dxmtMenuItem] setEnabled:[bottle isIsDXMTAvailable]];
    [[self dxmtMenuItem] setToolTip:[bundle localizedStringForKey:@"DXMT translation layer for D3D11." value:@"" table:nil]];
    if (![bottle isIsDXMTAvailable]) {
        [[self dxmtMenuItem] setToolTip:[bundle localizedStringForKey:@"DXMT translation layer for D3D11.\n\nNot supported on this computer: requires Apple Silicon and macOS Sonoma." value:@"" table:nil]];
    }
    [[self dxmtMenuItem] setEnabled:![bottle isIsMTLVKEnabled]];
    [[self dxvkMenuItem] setEnabled:![bottle isIsMTLVKEnabled]];
    NSMenuItem *graphicsItem;
    if ([bottle isIsDXVKEnabled]) {
        graphicsItem = [self dxvkMenuItem];
    } else if ([bottle isIsDXMTEnabled]) {
        graphicsItem = [self dxmtMenuItem];
    } else if ([bottle isIsD3DMetalEnabled]) {
        graphicsItem = [self d3dMetalMenuItem];
    } else if ([bottle isIsWineD3DEnabled]) {
        graphicsItem = [self wined3dMenuItem];
    } else {
        graphicsItem = [self autoGraphicsMenuItem];
    }
    [[self graphicsPopUpButton] selectItem:graphicsItem];

    // Vulkan backend: only selectable when no D3D translation layer is forced.
    BOOL vulkanEnabled = configurable && [bottle isCanRunCommands] && [bottle isIsMTLVKAvailable] &&
                         ![bottle isIsDXMTEnabled] && ![bottle isIsDXVKEnabled] && ![bottle isIsD3DMetalEnabled];
    [[self vulkanPopUpButton] setEnabled:vulkanEnabled];
    [[self vulkanLabel] setTextColor:[[self vulkanPopUpButton] isEnabled] ? enabledColor : disabledColor];
    [[self mtlvkMenuItem] setEnabled:[bottle isIsMTLVKAvailable]];
    [[self vulkanOptionView] setToolTip:[bundle localizedStringForKey:@"Vulkan backend options" value:@"" table:nil]];
    if ([bottle isIsMTLVKAvailable]) {
        if ([bottle isIsDXVKEnabled] || [bottle isIsD3DMetalEnabled]) {
            [[self vulkanOptionView] setToolTip:[bundle localizedStringForKey:@"Vulkan backend options.\n\nNot available in combination with DXVK or D3DMetal." value:@"" table:nil]];
        }
    } else {
        [[self vulkanOptionView] setToolTip:[bundle localizedStringForKey:@"Vulkan backend options.\n\nAlternatives supported on this computer: requires Apple Silicon and macOS Sequoia." value:@"" table:nil]];
    }
    [[self vulkanPopUpButton] selectItem:[bottle isIsMTLVKEnabled] ? [self mtlvkMenuItem] : [self moltenvkMenuItem]];
    [[self vulkanOptionView] setHidden:YES];

    // MSync.
    [[self msyncSwitch] setEnabled:configurable && [bottle isCanRunCommands]];
    [[self msyncLabel] setTextColor:[[self msyncSwitch] isEnabled] ? enabledColor : disabledColor];
    [[self msyncSwitch] setState:[bottle isIsMSyncEnabled] ? NSControlStateValueOn : NSControlStateValueOff];
    [[self msyncView] setToolTip:[bundle localizedStringForKey:@"Mach Semaphore-based synchronization" value:@"" table:nil]];

    // DLSS.
    [[self dlssSwitch] setEnabled:configurable && [bottle isCanRunCommands] && [bottle isIsDLSSAvailable]];
    [[self dlssLabel] setTextColor:[[self dlssSwitch] isEnabled] ? enabledColor : disabledColor];
    [[self dlssSwitch] setState:[bottle isIsDLSSEnabled] ? NSControlStateValueOn : NSControlStateValueOff];
    [[self dlssView] setToolTip:[bundle localizedStringForKey:@"DLSS for D3DMetal and DXMT" value:@"" table:nil]];
    if (![bottle isIsDLSSAvailable]) {
        [[self dlssView] setToolTip:[bundle localizedStringForKey:@"DLSS for D3DMetal and DXMT. Requires Apple Silicon and macOS Tahoe for D3DMetal, macOS Sonoma for DXMT." value:@"" table:nil]];
    }

    // High resolution.
    [[self highResolutionSwitch] setEnabled:configurable && [bottle isIsActive] && [bottle isIsHighResolutionEnabledReady]];
    [[self highResolutionLabel] setTextColor:[[self highResolutionSwitch] isEnabled] ? enabledColor : disabledColor];
    [[self highResolutionSwitch] setState:[bottle isIsHighResolutionEnabled] ? NSControlStateValueOn : NSControlStateValueOff];
    [[self highResolutionView] setToolTip:[bundle localizedStringForKey:@"High resolution mode" value:@"" table:nil]];

    // CrossOver Preview.
    [[self previewSwitch] setEnabled:![bottle isIsManaged]];
    [[self previewLabel] setTextColor:[[self previewSwitch] isEnabled] ? enabledColor : disabledColor];
    [[self previewSwitch] setState:[bottle isIsPreviewEnabled] ? NSControlStateValueOn : NSControlStateValueOff];
    [[self previewView] setToolTip:[bundle localizedStringForKey:@"Enable this bottle for CrossOver Preview" value:@"" table:nil]];
    [[self previewView] setHidden:YES];

    [self updateDependencyButton];
    [[self quitButton] setEnabled:[bottle isIsActive]];
    [self updateQuitButton];
}

- (void)resetMenuForNewBottle {
    [[self installedSoftwareTableView] scrollToBeginningOfDocument:nil];
    [self updateMenuItems];
    [self reloadControlPanels];
}

- (id)iconForControlPanel:(id)arg1 {
    static dispatch_once_t onceToken;
    static NSDictionary *iconsNamesByExe = nil;
    dispatch_once(&onceToken, ^{
        iconsNamesByExe = [@{@"winecfg.exe": @"sf-symbols.gearshape",
                             @"joy.cpl": @"sf-symbols.gamecontroller",
                             @"wineboot.exe": @"sf-symbols.restart.circle",
                             @"taskmgr.exe": @"sf-symbols.list.bullet",
                             @"inetcpl.cpl": @"sf-symbols.network"} retain];
    });
    NSString *exe = [[[arg1 valueForKey:@"exe"] lastPathComponent] lowercaseString];
    NSString *iconName = [iconsNamesByExe objectForKeyedSubscript:exe];
    return [NSImage imageNamed:iconName ?: @"sf-symbols.gearshape-2"];
}

- (void)sortControlPanels:(id)arg1 {
    static dispatch_once_t onceToken;
    static NSArray *orderOfWellKnownPanels = nil;
    dispatch_once(&onceToken, ^{
        orderOfWellKnownPanels = [@[@"winecfg.exe", @"joy.cpl", @"wineboot.exe", @"taskmgr.exe", @"inetcpl.cpl"] retain];
    });
    // Well-known panels come first in a fixed order; the rest follow by name.
    [arg1 sortUsingComparator:^NSComparisonResult(id a, id b) {
        NSUInteger ia = [orderOfWellKnownPanels indexOfObject:[[[a valueForKey:@"exe"] lastPathComponent] lowercaseString]];
        NSUInteger ib = [orderOfWellKnownPanels indexOfObject:[[[b valueForKey:@"exe"] lastPathComponent] lowercaseString]];
        if (ia != NSNotFound && ib != NSNotFound) {
            return ia < ib ? NSOrderedAscending : (ia > ib ? NSOrderedDescending : NSOrderedSame);
        }
        if (ia != NSNotFound) {
            return NSOrderedAscending;
        }
        if (ib != NSNotFound) {
            return NSOrderedDescending;
        }
        return [[a valueForKey:@"name"] localizedCaseInsensitiveCompare:[b valueForKey:@"name"]];
    }];
}

- (void)addButtonForControlPanel:(id)arg1 index:(NSInteger)arg2 {
    CXFlatButton *button = [CXFlatButton flatButtonWithTitle:[arg1 valueForKey:@"name"] icon:[self iconForControlPanel:arg1]];
    [button setShowsBorderOnlyWhileMouseInside:YES];
    [button setToolTip:[arg1 valueForKey:@"description"]];
    [button setTag:arg2];
    [button setTarget:self];
    [button setAction:@selector(controlPanelButtonClicked:)];
    [[self controlPanelsSection] addArrangedSubview:button];
    [[[button widthAnchor] constraintEqualToAnchor:[[self controlPanelsSection] widthAnchor]] setActive:YES];
}

- (void)showControlPanelLoader:(BOOL)arg1 {
    [[self controlPanelsLoadingView] setHidden:!arg1];
    if (arg1) {
        [[self controlPanelsLoadingSpinner] startAnimation:nil];
    } else {
        [[self controlPanelsLoadingSpinner] stopAnimation:nil];
    }
}


- (id)launcherNodesForLaunchers:(id)arg1 {
    NSMutableArray *nodes = [NSMutableArray array];
    for (LauncherItem *item in arg1) {
        if ([item isLeaf] && [item isKindOfClass:[LauncherApp class]]) {
            if ([item bottle] == [self bottle]) {
                [nodes addObject:[LauncherAppTreeNode fromLauncher:item]];
            }
        } else if (![item isLeaf] && [item isKindOfClass:[LauncherFolder class]]) {
            [nodes addObjectsFromArray:[self launcherNodesForLaunchers:[(LauncherFolder *)item items]]];
        }
    }
    [nodes sortUsingSelector:@selector(compareSortOrderThenName:)];
    return nodes;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    if (arg4 != _BottleViewControllerKVCContext) {
        [super observeValueForKeyPath:arg1 ofObject:arg2 change:arg3 context:arg4];
        return;
    }
    if (arg2 == BottleViewControllerServer() && [arg1 isEqualToString:@"launchers"]) {
        [self reloadLaunchers];
    } else if (arg2 == [self bottle] && [arg1 isEqualToString:@"isControlPanelReady"]) {
        [self reloadControlPanels];
    } else if (arg2 == [self bottle]) {
        [self updateMenuItems];
    }
}

- (void)leaveRating:(id)arg1 {
    if (![self canBeRated]) {
        return;
    }
    SubmitRatingController *rating = [[SubmitRatingController alloc] initWithBottle:[self bottle]];
    if (rating) {
        [[[self view] window] beginSheet:[rating window] completionHandler:nil];
    }
}

- (id)bottleDescription {
    NSString *description = [[self bottle] currentDescription];
    return [description length] != 0 ? description : nil;
}

- (void)setBottleDescription:(id)arg1 {
    [[self bottle] setCurrentDescription:arg1 ?: @""];
}

- (void)iconCollectionViewControllerSelectionChanged:(id)arg1 {
    [self updateMenuItems];
}

- (void)runWithOptionsClicked:(id)arg1 {
    id selected = [[self iconCollectionViewController] selectedLauncher];
    if ([selected isKindOfClass:[LauncherAppTreeNode class]]) {
        [BottleMenuHandler runCommandInBottle:[self bottle] withLauncher:[selected launcher]];
    }
}

- (void)runCommandClicked:(id)arg1 {
    [BottleMenuHandler runCommandInBottle:[self bottle]];
}

- (void)installIntoBottleClicked:(id)arg1 {
    [BottleMenuHandler installSoftwareIntoBottle:[self bottle] withWindow:[[self view] window]];
}

- (void)dependencyButtonClicked:(id)arg1 {
    [BottleMenuHandler installMissingDependencies:[self bottle] withWindow:[[self view] window]];
}

- (void)openCDriveClicked:(id)arg1 {
    [BottleMenuHandler openCDriveForBottle:[self bottle]];
}

- (void)quitClicked:(id)arg1 {
    if ([[self bottle] isCanForceQuit]) {
        [BottleMenuHandler forceQuitBottle:[self bottle]];
    } else {
        [BottleMenuHandler quitBottle:[self bottle]];
    }
}

- (void)deleteClicked:(id)arg1 {
    [BottleMenuHandler deleteBottle:[self bottle] withWindow:[[self view] window]];
}

- (void)graphicsOptionChanged:(id)arg1 {
    NSMenuItem *item = [[self graphicsPopUpButton] selectedItem];
    if (item == [self autoGraphicsMenuItem]) {
        [[self bottle] setGraphicsBackendAuto];
    } else if (item == [self d3dMetalMenuItem]) {
        [[self bottle] setGraphicsBackendD3DMetal];
    } else if (item == [self dxmtMenuItem]) {
        [[self bottle] setGraphicsBackendDXMT];
    } else if (item == [self dxvkMenuItem]) {
        [[self bottle] setGraphicsBackendDXVK];
    } else if (item == [self wined3dMenuItem]) {
        [[self bottle] setGraphicsBackendWine];
    }
}

- (void)vulkanOptionChanged:(id)arg1 {
    NSMenuItem *item = [[self vulkanPopUpButton] selectedItem];
    if (item == [self moltenvkMenuItem]) {
        [[self bottle] setVulkanBackendMoltenVK];
    } else if (item == [self mtlvkMenuItem]) {
        [[self bottle] setVulkanBackendMTLVK];
    }
}

- (void)dlssToggled:(id)arg1 {
    if ([[self bottle] isIsDLSSEnabled]) {
        [[self bottle] disableDLSS];
    } else {
        [[self bottle] enableDLSS];
    }
}

- (void)msyncToggled:(id)arg1 {
    [BottleMenuHandler toggleMSyncForBottle:[self bottle] withWindow:[[self view] window] modalCompletionHandler:^(BOOL cancelled) {
        if (cancelled) {
            [arg1 setState:[arg1 state] != NSControlStateValueOn];
        }
    }];
}

- (void)highResolutionToggled:(id)arg1 {
    [BottleMenuHandler toggleHighResolutionForBottle:[self bottle] withWindow:[[self view] window] modalCompletionHandler:^(BOOL cancelled) {
        if (cancelled) {
            [arg1 setState:[arg1 state] != NSControlStateValueOn];
        }
    }];
}

- (void)previewToggled:(id)arg1 {
    [BottleMenuHandler togglePreviewForBottle:[self bottle] withWindow:[[self view] window] modalCompletionHandler:^(BOOL cancelled) {
        if (cancelled) {
            [arg1 setState:[arg1 state] != NSControlStateValueOn];
        }
    }];
}

- (void)controlPanelButtonClicked:(id)arg1 {
    NSButton *button = arg1;
    [button setEnabled:NO];
    LauncherControlPanel *launcher = [[self controlPanelLaunchers] objectAtIndexedSubscript:[button tag]];
    [launcher launchWithErrorHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentError:error modalForWindow:[[self view] window] delegate:nil didPresentSelector:NULL contextInfo:NULL];
            [button setEnabled:YES];
        });
    }];
    // Re-enable the button after a few seconds unless the bottle changed.
    BottleWrapper *bottle = [[self bottle] retain];
    [self retain];
    [button retain];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if ([self bottle] == bottle) {
            [button setEnabled:YES];
        }
        [button release];
        [bottle release];
        [self release];
    });
}

- (void)bottleDescriptionDidEndEditing:(id)arg1 {
    [[self bottle] writeDescription];
}

- (id)selectedApplication {
    NSInteger row = [[self installedSoftwareTableView] clickedRow];
    if (row == -1) {
        return nil;
    }
    return [[[self installedSoftware] arrangedObjects] objectAtIndexedSubscript:row];
}

- (BOOL)canUninstall {
    id<CXInstalledApplication> app = [self selectedApplication];
    return app && [[app canUninstall] boolValue];
}

- (void)uninstallClicked:(id)arg1 {
    id<CXInstalledApplication> app = [self selectedApplication];
    if (app) {
        [app uninstall];
    }
}

- (BOOL)control:(id)arg1 textView:(id)arg2 doCommandBySelector:(SEL)arg3 {
    if (arg3 == @selector(insertNewline:)) {
        [arg1 endEditing:[arg1 currentEditor]];
        return YES;
    }
    return NO;
}

- (BOOL)performDragOperation:(id)arg1 {
    NSURL *url = [NSURL URLFromPasteboard:[arg1 draggingPasteboard]];
    [BottleViewControllerServer() runClient:[url path] inBottle:[[self bottle] name] withDialog:YES];
    return YES;
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
    if (self->_package != arg1) {
        [self->_package release];
        self->_package = [arg1 retain];
    }
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
    if (self->_iconCollectionViewController != arg1) {
        [self->_iconCollectionViewController release];
        self->_iconCollectionViewController = [arg1 retain];
    }
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
    if (self->_controlPanelLaunchers != arg1) {
        [self->_controlPanelLaunchers release];
        self->_controlPanelLaunchers = [arg1 retain];
    }
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
