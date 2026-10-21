// MainWindowController.m — CrossThrough
#import "MainWindowController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "BottleMenuHandler.h"
#import "NewBottleController.h"
#import "UpdateController.h"
#import "PackageTreeNode.h"
#import "BottleNode.h"
#import "CXSetupLib.h"
#import "BottleViewController.h"
#import "LauncherIconViewController.h"
#import "PackageViewController.h"
#import "CXSourceList.h"

#import "BottleTableRowView.h"

static void *MainWindowControllerKVOContext = &MainWindowControllerKVOContext;

@implementation MainWindowController

+ (void)initialize {
    if (self == [MainWindowController class]) {
        NSDictionary *defaults = @{ @"HiddenLauncherIDs": @[] };
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    }
}

- (id)init {
    self = [super initWithWindowNibName:@"MainWindow"];
    if (self) {
        self->_bottleViewController = [[BottleViewController alloc] init];
        self->_iconViewController = [[LauncherIconViewController alloc] init];
        self->_packageViewController = [[PackageViewController alloc] init];
        [self->_packageViewController setDelegate:self];
    }
    return self;
}

- (void)dealloc {
    [[self bottleSourceView] setDelegate:nil];
    [[self bottleSourceView] setDataSource:nil];
    [self->_packageViewController setDelegate:nil];
    if (self->_observingBottleList) {
        id collection = [[CXSetupLib bottleCollectionClass] sharedCollection];
        for (id bottle in [collection bottleList]) {
            [bottle removeObserver:self forKeyPath:@"isBusy" context:MainWindowControllerKVOContext];
        }
        [collection removeObserver:self forKeyPath:@"bottleList" context:MainWindowControllerKVOContext];
    }
    [[NSUserDefaultsController sharedUserDefaultsController] removeObserver:self forKeyPath:@"values.AutoUpdateCrossTies" context:MainWindowControllerKVOContext];

    objc_storeWeak((id *)&self->_mainContentView, nil);
    objc_storeWeak((id *)&self->_splitView, nil);
    objc_storeWeak((id *)&self->_topMenuSourceView, nil);
    objc_storeWeak((id *)&self->_bottomMenuSourceView, nil);
    objc_storeWeak((id *)&self->_topMenuTreeController, nil);
    objc_storeWeak((id *)&self->_bottomMenuTreeController, nil);
    objc_storeWeak((id *)&self->_bottleSourceView, nil);
    objc_storeWeak((id *)&self->_bottleTreeController, nil);
    [self->_bottleNodes release];
    [self->_bottleViewController release];
    [self->_iconViewController release];
    [self->_packageViewController release];
    [self->_topMenuNodes release];
    [self->_bottomMenuNodes release];
    [self->_privateBottleGroup release];
    [self->_publishedBottleGroup release];
    [super dealloc];
}

- (id)bottleNodes {
    return self->_bottleNodes;
}

- (void)setBottleNodes:(id)arg1 {
    if (self->_bottleNodes != arg1) {
        [self->_bottleNodes release];
        self->_bottleNodes = [arg1 mutableCopy];
    }
}

- (void)insertObject:(id)arg1 inBottleNodesAtIndex:(NSUInteger)arg2 {
    [self->_bottleNodes insertObject:arg1 atIndex:arg2];
}

- (void)removeObjectFromBottleNodesAtIndex:(NSUInteger)arg1 {
    [self->_bottleNodes removeObjectAtIndex:arg1];
}

- (id)selectedBottleNode {
    NSArray *selected = nil;
    NSInteger clicked = [[self bottleSourceView] clickedRow];
    if (clicked != -1) {
        // A right-clicked row wins over the selection while its menu is up.
        id item = [[self bottleSourceView] itemAtRow:clicked];
        id node = [item valueForKey:@"representedObject"];
        if (node) {
            selected = [NSArray arrayWithObject:node];
        }
    }
    if (!selected) {
        selected = [[self bottleTreeController] selectedObjects];
    }
    if ([selected count] == 1) {
        BottleNode *node = [selected objectAtIndex:0];
        if ([node type] == 2) {
            return node;
        }
    }
    return nil;
}

- (void)loadInfoForSelectedBottle {
    BottleNode *node = [self selectedBottleNode];
    if (node) {
        [[node bottle] loadHighResolutionInfo];
    }
}

- (id)privateBottlesGroupNameNoPublished {
    return [[NSBundle mainBundle] localizedStringForKey:@"BOTTLES" value:@"" table:nil];
}

- (void)windowDidLoad {
    NSMutableArray *topNodes = [NSMutableArray array];
    BottleNode *allNode = [BottleNode allBottlesBottleNode];
    [allNode setSortPriority:0];
    [topNodes addObject:allNode];
    [self setTopMenuNodes:topNodes];

    NSMutableArray *bottomNodes = [NSMutableArray array];
    BottleNode *installNode = [BottleNode installBottleNode];
    [installNode setSortPriority:0];
    [bottomNodes addObject:installNode];
    [self setBottomMenuNodes:bottomNodes];

    // The bottle groups only join the sidebar once the bottle list has members.
    NSMutableArray *bottleNodes = [NSMutableArray array];
    [self setPrivateBottleGroup:[BottleNode groupBottleNodeWithName:[self privateBottlesGroupNameNoPublished]]];
    [[self privateBottleGroup] setSortPriority:2];
    [self setPublishedBottleGroup:[BottleNode groupBottleNodeWithName:[[NSBundle mainBundle] localizedStringForKey:@"PUBLISHED BOTTLES" value:@"" table:nil]]];
    [[self publishedBottleGroup] setSortPriority:3];
    [self setBottleNodes:bottleNodes];

    self->_observingBottleList = YES;
    [[[CXSetupLib bottleCollectionClass] sharedCollection] addObserver:self
                                                            forKeyPath:@"bottleList"
                                                               options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                                               context:MainWindowControllerKVOContext];

    NSArray *sortDescriptors = @[
        [NSSortDescriptor sortDescriptorWithKey:@"sortPriority" ascending:YES selector:@selector(compare:)],
        [NSSortDescriptor sortDescriptorWithKey:@"bottle.isDefault" ascending:NO selector:@selector(compare:)],
        [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)],
    ];
    [[self bottleTreeController] setSortDescriptors:sortDescriptors];

    [[[self iconViewController] view] setFrame:[[self mainContentView] bounds]];
    [[[self iconViewController] view] setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [[[self packageViewController] view] setFrame:[[self mainContentView] bounds]];
    [[[self packageViewController] view] setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [[[self bottleViewController] view] setFrame:[[self mainContentView] bounds]];
    [[[self bottleViewController] view] setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [[self mainContentView] setSubviews:@[[[self iconViewController] view], [[self packageViewController] view], [[self bottleViewController] view]]];

    [[self splitView] setAutosaveName:@"MainWindowSplit22"];
    [[self window] setBackgroundColor:[NSColor controlBackgroundColor]];
    [self selectDefaultView];
    [self updateC4Ps];
    [[NSUserDefaultsController sharedUserDefaultsController] addObserver:self forKeyPath:@"values.AutoUpdateCrossTies" options:0 context:MainWindowControllerKVOContext];
}

- (NSUInteger)window:(id)arg1 willUseFullScreenPresentationOptions:(NSUInteger)arg2 {
    return arg2 | 0x800;
}

- (void)updateMainContentView {
    NSArray *selected = [[self topMenuTreeController] selectedObjects];
    if ([selected count] == 0) {
        selected = [[self bottleTreeController] selectedObjects];
    }
    if ([selected count] == 0) {
        selected = [[self bottomMenuTreeController] selectedObjects];
    }
    if ([selected count] == 0) {
        [self selectDefaultView];
        return;
    }

    BottleNode *node = [selected objectAtIndexedSubscript:0];
    NSInteger type = [node type];
    if (type == 1) {
        [[[self iconViewController] view] setHidden:NO];
        [[[self packageViewController] view] setHidden:YES];
        [[[self bottleViewController] view] setHidden:YES];
    } else if (type == 3) {
        [[[self iconViewController] view] setHidden:YES];
        [[[self packageViewController] view] setHidden:NO];
        [[[self bottleViewController] view] setHidden:YES];
    } else {
        [[[self iconViewController] view] setHidden:YES];
        [[[self packageViewController] view] setHidden:YES];
        [[[self bottleViewController] view] setHidden:NO];
        [[self bottleViewController] setBottle:[node bottle]];
        [self loadInfoForSelectedBottle];
    }
}

- (void)selectLaunchView {
    if (self->_topMenuSourceView) {
        [self->_topMenuSourceView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    }
    [self->_bottleSourceView deselectAll:self];
    [self->_bottomMenuSourceView deselectAll:self];
    [self updateMainContentView];
}

- (void)selectInstallView {
    [self->_topMenuSourceView deselectAll:self];
    [self->_bottleSourceView deselectAll:self];
    if (self->_bottomMenuSourceView) {
        [self->_bottomMenuSourceView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    }
    [self updateMainContentView];
}

- (void)selectDefaultView {
    id collection = [[CXSetupLib bottleCollectionClass] sharedCollection];
    NSArray *list = [collection respondsToSelector:@selector(bottleList)] ? [collection bottleList] : nil;
    if ([list count] > 0) {
        [self selectLaunchView];
    } else {
        [self selectInstallView];
    }
}

- (void)updateC4Ps {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"AutoUpdateCrossTies"] || [self updating]) {
        return;
    }
    [self setUpdating:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[CXSetupLib webUtilsClass] updateCompatDB];
        [[CXSetupLib c4ProfilesClass] updateOnlineProfilesFromURL:[[NSUserDefaults standardUserDefaults] objectForKey:@"TieURL"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self packageViewController] populatePackages];
            [self setUpdating:NO];
            // Check again in a day.
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 86400 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self updateC4Ps];
            });
        });
    });
}

- (void)autoPlay:(id)arg1 inBottle:(id)arg2 {
    [self selectInstallView];
    [[self packageViewController] back];
    [[self packageViewController] autoPlay:arg1];
    [[self packageViewController] setSelectedBottle:arg2];
}

- (void)autoPlayWithAutorunFile:(id)arg1 inBottle:(id)arg2 {
    [self selectInstallView];
    [[self packageViewController] back];
    [[self packageViewController] autoPlayWithAutorunFile:arg1];
    [[self packageViewController] setSelectedBottle:arg2];
}

- (void)addIconsForBottles:(id)arg1 {
    for (id bottle in arg1) {
        [bottle addObserver:self forKeyPath:@"isBusy" options:0 context:MainWindowControllerKVOContext];
    }
}

- (BOOL)isPreview {
    return NO;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    if (arg4 != MainWindowControllerKVOContext) {
        [super observeValueForKeyPath:arg1 ofObject:arg2 change:arg3 context:arg4];
        return;
    }

    if (arg2 == [[CXSetupLib bottleCollectionClass] sharedCollection] && [arg1 isEqualToString:@"bottleList"]) {
        [self updateMainContentView];
        if ([[self bottleSourceView] clickedRow] != -1) {
            [[[self bottleSourceView] menu] cancelTracking];
        }

        int kind = [[arg3 objectForKey:NSKeyValueChangeKindKey] intValue];
        NSArray *oldBottles = [arg3 objectForKey:NSKeyValueChangeOldKey];
        NSArray *newBottles = [arg3 objectForKey:NSKeyValueChangeNewKey];
        NSMutableSet *added = nil;
        NSMutableSet *removed = nil;
        if (kind != NSKeyValueChangeRemoval && [newBottles count]) {
            added = [NSMutableSet setWithArray:newBottles];
            if (kind != NSKeyValueChangeInsertion && [oldBottles count]) {
                [added minusSet:[NSSet setWithArray:oldBottles]];
            }
        }
        if (kind != NSKeyValueChangeInsertion && [oldBottles count]) {
            removed = [NSMutableSet setWithArray:oldBottles];
            if (kind != NSKeyValueChangeRemoval && [newBottles count]) {
                [removed minusSet:[NSSet setWithArray:newBottles]];
            }
        }

        if ([removed count]) {
            BOOL (^isRemoved)(id, NSUInteger, BOOL *) = ^BOOL(id node, NSUInteger idx, BOOL *stop) {
                return [removed containsObject:[node bottle]];
            };
            NSIndexSet *privateIndexes = [[[self privateBottleGroup] children] indexesOfObjectsPassingTest:isRemoved];
            NSMutableArray *removedNodes = [[[[self privateBottleGroup] children] objectsAtIndexes:privateIndexes] mutableCopy];
            if ([privateIndexes count]) {
                [[self privateBottleGroup] removeChildrenAtIndexes:privateIndexes];
                if ([[[self privateBottleGroup] children] count] == 0) {
                    NSUInteger idx = [[self bottleNodes] indexOfObjectIdenticalTo:[self privateBottleGroup]];
                    if (idx != NSNotFound) {
                        [self removeObjectFromBottleNodesAtIndex:idx];
                    }
                }
            }
            NSIndexSet *publishedIndexes = [[[self publishedBottleGroup] children] indexesOfObjectsPassingTest:isRemoved];
            if ([publishedIndexes count]) {
                [removedNodes addObjectsFromArray:[[[self publishedBottleGroup] children] objectsAtIndexes:publishedIndexes]];
                [[self publishedBottleGroup] removeChildrenAtIndexes:publishedIndexes];
                if ([[[self publishedBottleGroup] children] count] == 0) {
                    NSUInteger idx = [[self bottleNodes] indexOfObjectIdenticalTo:[self publishedBottleGroup]];
                    if (idx != NSNotFound) {
                        [self removeObjectFromBottleNodesAtIndex:idx];
                    }
                    [(BottleNode *)[self privateBottleGroup] setName:[self privateBottlesGroupNameNoPublished]];
                }
            }
            for (BottleNode *node in removedNodes) {
                [node removeObserver:self forKeyPath:@"bottle.isDefault" context:MainWindowControllerKVOContext];
                [node removeObserver:self forKeyPath:@"name" context:MainWindowControllerKVOContext];
            }
            [removedNodes release];
            for (id bottle in removed) {
                [bottle removeObserver:self forKeyPath:@"isBusy" context:MainWindowControllerKVOContext];
            }
        }

        if ([added count]) {
            NSMutableArray *privateNodes = [NSMutableArray array];
            NSMutableArray *publishedNodes = [NSMutableArray array];
            for (id bottle in added) {
                BottleNode *node = [BottleNode bottleNodeWithBottle:bottle];
                [node addObserver:self forKeyPath:@"bottle.isDefault" options:0 context:MainWindowControllerKVOContext];
                [node addObserver:self forKeyPath:@"name" options:0 context:MainWindowControllerKVOContext];
                [([bottle isIsManaged] ? publishedNodes : privateNodes) addObject:node];
            }
            if ([privateNodes count]) {
                if ([[[self privateBottleGroup] children] count] == 0) {
                    [self insertObject:[self privateBottleGroup] inBottleNodesAtIndex:[[self bottleNodes] count]];
                    [[self bottleSourceView] expandItem:nil expandChildren:YES];
                }
                NSUInteger start = [[[self privateBottleGroup] children] count];
                [[self privateBottleGroup] insertChildren:privateNodes atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(start, [privateNodes count])]];
            }
            if ([publishedNodes count]) {
                if ([[[self publishedBottleGroup] children] count] == 0) {
                    [(BottleNode *)[self privateBottleGroup] setName:[[NSBundle mainBundle] localizedStringForKey:@"PRIVATE BOTTLES" value:@"" table:nil]];
                    [self insertObject:[self publishedBottleGroup] inBottleNodesAtIndex:[[self bottleNodes] count]];
                    [[self bottleSourceView] expandItem:nil expandChildren:YES];
                }
                NSUInteger start = [[[self publishedBottleGroup] children] count];
                [[self publishedBottleGroup] insertChildren:publishedNodes atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(start, [publishedNodes count])]];
            }
            [self addIconsForBottles:added];
        }
        [self updateMainContentView];
    } else if ([arg1 isEqualToString:@"isBusy"]) {
        NSOutlineView *outline = [self bottleSourceView];
        for (NSInteger row = 0; row < [outline numberOfRows]; row++) {
            if ([[[outline itemAtRow:row] representedObject] bottle] == arg2) {
                [outline setNeedsDisplayInRect:[outline rectOfRow:row]];
                break;
            }
        }
    } else if ([arg1 isEqualToString:@"values.AutoUpdateCrossTies"]) {
        [self updateC4Ps];
    } else if ([arg2 isKindOfClass:[BottleNode class]]) {
        [[self bottleTreeController] rearrangeObjects];
    }
}

- (BOOL)outlineView:(id)arg1 isGroupItem:(id)arg2 {
    return [(BottleNode *)[arg2 representedObject] type] == 0;
}

- (BOOL)outlineView:(id)arg1 shouldShowOutlineCellForItem:(id)arg2 {
    return ![self outlineView:arg1 isGroupItem:arg2];
}

- (BOOL)outlineView:(id)arg1 shouldSelectItem:(id)arg2 {
    return ![self outlineView:arg1 isGroupItem:arg2];
}

- (void)outlineView:(id)arg1 didRemoveRowView:(id)arg2 forRow:(NSInteger)arg3 {
    [self updateMainContentView];
}

- (void)outlineViewSelectionDidChange:(id)arg1 {
    NSArray *bottleSelection = [[self bottleTreeController] selectedObjects];
    NSArray *topSelection = [[self topMenuTreeController] selectedObjects];
    NSArray *bottomSelection = [[self bottomMenuTreeController] selectedObjects];
    id source = [arg1 object];
    // The three sidebar lists behave as one: selecting in one clears the others.
    if (source == [self topMenuSourceView] && [topSelection count]) {
        if ([bottleSelection count]) [[self bottleSourceView] deselectAll:self];
        if ([bottomSelection count]) [[self bottomMenuSourceView] deselectAll:self];
    } else if (source == [self bottleSourceView] && [bottleSelection count]) {
        if ([topSelection count]) [[self topMenuSourceView] deselectAll:self];
        if ([bottomSelection count]) [[self bottomMenuSourceView] deselectAll:self];
    } else if (source == [self bottomMenuSourceView] && [bottomSelection count]) {
        if ([topSelection count]) [[self topMenuSourceView] deselectAll:self];
        if ([bottleSelection count]) [[self bottleSourceView] deselectAll:self];
    }
    [self updateMainContentView];
}

- (id)outlineView:(id)arg1 rowViewForItem:(id)arg2 {
    return [[[BottleTableRowView alloc] init] autorelease];
}

- (id)outlineView:(id)arg1 viewForTableColumn:(id)arg2 item:(id)arg3 {
    NSTableCellView *view = [arg1 makeViewWithIdentifier:(arg2 ? @"DataCell" : @"HeaderCell") owner:self];
    [[view textField] setAutoresizingMask:NSViewNotSizable];
    return view;
}

- (BOOL)validateUserInterfaceItem:(id)arg1 {
    SEL act = [arg1 action];
    BottleNode *node = [self selectedBottleNode];
    id bottle = [node bottle];

    if (act == @selector(duplicateBottle:) ||
        act == @selector(toggleDefaultBottle:) ||
        act == @selector(deleteBottle:) ||
        act == @selector(exportBottleToArchive:)) {
        return (bottle != nil && ![bottle isIsBusy]);
    }

    if (act == @selector(openBottleCDrive:)) {
        return (bottle != nil && [bottle isIsUsable]);
    }

    if (act == @selector(renameBottle:)) {
        return [bottle isCanRename];
    }

    if (act == @selector(publishBottle:)) {
        return (![bottle isIsManaged] && [bottle isIsUsable]);
    }

    if (act == @selector(toggleBottleHighResolution:)) {
        return (![bottle isIsManaged] && [bottle isIsHighResolutionEnabledReady] && [bottle isIsActive] && ![bottle isIsDisabled]);
    }

    if (act == @selector(toggleBottleGraphicsAuto:)) {
        return (![bottle isIsManaged] && [bottle isCanRunCommands] && ![bottle isIsDisabled]);
    }

    if (act == @selector(toggleBottleGraphicsD3DMetal:)) {
        return (![bottle isIsManaged] && [bottle isCanRunCommands] && ![bottle isIsDisabled] && [bottle isIsD3DMetalAvailable] && ![bottle isIsMTLVKEnabled]);
    }

    if (act == @selector(toggleBottleGraphicsDXMT:)) {
        return (![bottle isIsManaged] && [bottle isCanRunCommands] && ![bottle isIsDisabled] && [bottle isIsDXMTAvailable] && ![bottle isIsMTLVKEnabled]);
    }

    if (act == @selector(toggleBottleGraphicsDXVK:)) {
        return (![bottle isIsManaged] && [bottle isCanRunCommands] && ![bottle isIsDisabled] && ![bottle isIsMTLVKEnabled]);
    }

    if (act == @selector(toggleBottleVulkanMoltenVK:)) {
        return (![bottle isIsManaged] && [bottle isCanRunCommands] && ![bottle isIsDisabled]);
    }

    if (act == @selector(toggleBottleVulkanMTLVK:)) {
        return (![bottle isIsManaged] && [bottle isCanRunCommands] && ![bottle isIsDisabled] && [bottle isIsMTLVKAvailable] && ![bottle isIsD3DMetalEnabled] && ![bottle isIsDXMTEnabled] && ![bottle isIsDXVKEnabled]);
    }

    if (act == @selector(toggleBottleDLSS:)) {
        return (![bottle isIsManaged] && [bottle isCanRunCommands] && ![bottle isIsDisabled] && [bottle isIsDLSSAvailable]);
    }

    if (act == @selector(toggleBottleMSync:)) {
        return (![bottle isIsManaged] && ![bottle isIsDisabled]);
    }

    if (act == @selector(toggleBottlePreview:)) {
        return ![bottle isIsManaged];
    }

    if (act == @selector(updateBottle:)) {
        return ([bottle isIsManaged] && ![bottle isIsUpToDate] && ![bottle isIsBusy]);
    }

    if (act == @selector(installSoftwareToBottle:)) {
        return [bottle isCanInstall];
    }

    if (act == @selector(runCommandInBottle:)) {
        return [bottle isCanRunCommands];
    }

    if (act == @selector(openShellForBottle:)) {
        return [bottle isCanRunCommands];
    }

    if (act == @selector(quitBottle:)) {
        return [bottle isIsActive];
    }

    if (act == @selector(forceQuitBottle:)) {
        return [bottle isCanForceQuit];
    }

    return YES;
}

- (void)setMenuItem:(id)arg1 genericTitle:(id)arg2 bottleTitleFormat:(id)arg3 {
    BottleNode *node = [self selectedBottleNode];
    id bottle = [node bottle];
    if (bottle != nil) {
        NSString *name = [bottle name];
        [arg1 setTitle:[NSString stringWithFormat:arg3, name]];
    } else {
        [arg1 setTitle:arg2];
    }
}

- (void)menuNeedsUpdate:(id)arg1 {
    if ([[self bottleSourceView] menu] == arg1) {
        if ([self selectedBottleNode] == nil) {
            [arg1 cancelTracking];
        }
    }
}

- (void)menuWillOpen:(id)arg1 {
    [self loadInfoForSelectedBottle];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    if ([NSApp modalWindow] != nil || [[self window] attachedSheet] != nil) {
        return NO;
    }

    SEL act = [menuItem action];
    BottleNode *node = [self selectedBottleNode];
    id bottle = [node bottle];

    if (act == @selector(toggleDefaultBottle:)) {
        [menuItem setState:[bottle isIsDefault] ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleHighResolution:)) {
        BOOL state = (bottle != nil && [bottle isIsHighResolutionEnabledReady]) ? [bottle isIsHighResolutionEnabled] : NO;
        [menuItem setState:state ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleGraphicsAuto:)) {
        BOOL isAuto = (bottle != nil && ![bottle isIsD3DMetalEnabled] && ![bottle isIsDXMTEnabled] && ![bottle isIsDXVKEnabled]);
        [menuItem setState:isAuto ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleGraphicsD3DMetal:)) {
        [menuItem setState:(bottle && [bottle isIsD3DMetalEnabled]) ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleGraphicsDXMT:)) {
        [menuItem setState:(bottle && [bottle isIsDXMTEnabled]) ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleGraphicsDXVK:)) {
        [menuItem setState:(bottle && [bottle isIsDXVKEnabled]) ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleVulkanMoltenVK:)) {
        [menuItem setState:(bottle && [bottle isIsMoltenVKEnabled]) ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleVulkanMTLVK:)) {
        [menuItem setState:(bottle && [bottle isIsMTLVKEnabled]) ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleDLSS:)) {
        [menuItem setState:(bottle && [bottle isIsDLSSEnabled]) ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottleMSync:)) {
        [menuItem setState:(bottle && [bottle isIsMSyncEnabled]) ? NSControlStateValueOn : NSControlStateValueOff];
    }

    if (act == @selector(toggleBottlePreview:)) {
        [menuItem setState:(bottle && [bottle isIsPreviewEnabled]) ? NSControlStateValueOn : NSControlStateValueOff];
    }

    BOOL valid = [self validateUserInterfaceItem:menuItem];

    if (act == @selector(duplicateBottle:)) {
        NSString *generic = [[NSBundle mainBundle] localizedStringForKey:@"Duplicate Bottle…" value:@"" table:nil];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Duplicate '%@'…" value:@"" table:nil];
        [self setMenuItem:menuItem genericTitle:generic bottleTitleFormat:fmt];
    }

    if (act == @selector(renameBottle:)) {
        NSString *generic = [[NSBundle mainBundle] localizedStringForKey:@"Rename Bottle…" value:@"" table:nil];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Rename '%@'…" value:@"" table:nil];
        [self setMenuItem:menuItem genericTitle:generic bottleTitleFormat:fmt];
    }

    if (act == @selector(deleteBottle:)) {
        NSString *generic = [[NSBundle mainBundle] localizedStringForKey:@"Delete Bottle…" value:@"" table:nil];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Delete '%@'…" value:@"" table:nil];
        [self setMenuItem:menuItem genericTitle:generic bottleTitleFormat:fmt];
    }

    if (act == @selector(exportBottleToArchive:)) {
        NSString *generic = [[NSBundle mainBundle] localizedStringForKey:@"Export Bottle to Archive…" value:@"" table:nil];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Export '%@' to Archive…" value:@"" table:nil];
        [self setMenuItem:menuItem genericTitle:generic bottleTitleFormat:fmt];
    }

    if (act == @selector(publishBottle:)) {
        NSString *generic = [[NSBundle mainBundle] localizedStringForKey:@"Publish Bottle…" value:@"" table:nil];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Publish '%@'…" value:@"" table:nil];
        [self setMenuItem:menuItem genericTitle:generic bottleTitleFormat:fmt];
    }

    if (act == @selector(updateBottle:)) {
        if (bottle != nil && valid) {
            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Update '%@'…" value:@"" table:nil];
            [menuItem setTitle:[NSString stringWithFormat:fmt, [bottle name]]];
        } else {
            NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Update Published Bottle…" value:@"" table:nil];
            [menuItem setTitle:title];
        }
    }

    if (act == @selector(installSoftwareToBottle:)) {
        NSString *generic = [[NSBundle mainBundle] localizedStringForKey:@"Install Software into Bottle…" value:@"" table:nil];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Install Software into '%@'…" value:@"" table:nil];
        [self setMenuItem:menuItem genericTitle:generic bottleTitleFormat:fmt];
    }

    if (act == @selector(quitBottle:)) {
        NSString *generic = [[NSBundle mainBundle] localizedStringForKey:@"Quit Bottle" value:@"" table:nil];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Quit '%@'" value:@"" table:nil];
        [self setMenuItem:menuItem genericTitle:generic bottleTitleFormat:fmt];
    }

    if (act == @selector(forceQuitBottle:)) {
        NSString *generic = [[NSBundle mainBundle] localizedStringForKey:@"Force Quit Bottle" value:@"" table:nil];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Force Quit '%@'" value:@"" table:nil];
        [self setMenuItem:menuItem genericTitle:generic bottleTitleFormat:fmt];
    }

    return valid;
}

- (void)revealNewBottle:(id)arg1 {
    NSInteger count = [[self bottleSourceView] numberOfRows];
    for (NSInteger i = 0; i < count; i++) {
        id item = [[self bottleSourceView] itemAtRow:i];
        id rep = [item respondsToSelector:@selector(representedObject)] ? [item representedObject] : item;
        if ([rep respondsToSelector:@selector(bottle)] && [rep bottle] == arg1) {
            [[self bottleSourceView] selectRowIndexes:[NSIndexSet indexSetWithIndex:i] byExtendingSelection:NO];
            [[self bottleSourceView] scrollRowToVisible:i];
            break;
        }
    }
}

- (void)newBottle:(id)arg1 {
    NewBottleController *ctrl = [[NewBottleController alloc] init];
    [ctrl setCopyMode:NO withBottleToCopy:nil];
    [ctrl setupGUI];
    [[self window] beginSheet:[ctrl window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode != 0) {
            [self revealNewBottle:[ctrl bottle]];
        }
    }];
    [ctrl release];
}

- (void)duplicateBottle:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler duplicateBottle:[node bottle] withWindow:[self window]];
}

- (void)renameBottle:(id)arg1 {
    NSInteger row = [[self bottleSourceView] clickedRow];
    if (row == -1) {
        row = [[self bottleSourceView] selectedRow];
    }
    NSInteger col = [[self bottleSourceView] columnWithIdentifier:@"name"];
    [[self bottleSourceView] editColumn:col row:row withEvent:nil select:YES];
}

- (void)deleteBottle:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler deleteBottle:[node bottle] withWindow:[self window]];
}

- (void)openBottleCDrive:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler openCDriveForBottle:[node bottle]];
}

- (void)exportBottleToArchive:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler exportBottle:[node bottle] withWindow:[self window]];
}

- (void)importBottleArchiveFromURL:(id)arg1 {
    NewBottleController *ctrl = [[NewBottleController alloc] init];
    [ctrl setCopyMode:NO withBottleToCopy:nil];
    NSString *displayName = [[NSFileManager defaultManager] displayNameAtPath:[arg1 path]];
    NSString *ext = [arg1 pathExtension];
    NSString *dotExt = [@"." stringByAppendingString:ext];
    NSRange r = [displayName rangeOfString:dotExt options:NSBackwardsSearch | NSCaseInsensitiveSearch];
    if (r.location != NSNotFound) {
        displayName = [displayName stringByReplacingCharactersInRange:r withString:@""];
    }
    [ctrl setSuggestedBottleName:displayName];
    [ctrl setArchiveURL:arg1];
    [ctrl setupGUI];
    [[self window] beginSheet:[ctrl window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode != 0) {
            [self revealNewBottle:[ctrl bottle]];
        }
    }];
    [ctrl release];
}

- (void)importBottleArchive:(id)arg1 {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setMessage:[[NSBundle mainBundle] localizedStringForKey:@"Restore Bottle Archive" value:@"" table:nil]];
    [panel setPrompt:[[NSBundle mainBundle] localizedStringForKey:@"Restore" value:@"" table:nil]];
    [panel setAllowedFileTypes:@[@"cxarchive"]];
    [panel beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse returnCode) {
        [panel close];
        if (returnCode == NSModalResponseOK) {
            NSURL *url = [[panel URLs] objectAtIndex:0];
            [self importBottleArchiveFromURL:url];
        }
    }];
}

- (void)showInstallViewWithSelectedBottle:(id)arg1 package:(id)arg2 {
    [[self packageViewController] back];
    if (arg2 != nil) {
        [[self packageViewController] setSelectedPackage:arg2];
    }
    [[self packageViewController] setSelectedBottle:arg1];
    [self selectInstallView];
}

- (void)showInstallViewWithSelectedBottle:(id)arg1 {
    [self showInstallViewWithSelectedBottle:arg1 package:nil];
}

- (void)publishBottle:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler publishBottle:[node bottle] withWindow:[self window]];
}

- (void)toggleDefaultBottle:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler toggleDefaultBottle:[node bottle]];
}

- (void)toggleBottleGraphicsAuto:(id)arg1 {
    [[[self selectedBottleNode] bottle] setGraphicsBackendAuto];
}

- (void)toggleBottleGraphicsD3DMetal:(id)arg1 {
    [[[self selectedBottleNode] bottle] setGraphicsBackendD3DMetal];
}

- (void)toggleBottleGraphicsDXMT:(id)arg1 {
    [[[self selectedBottleNode] bottle] setGraphicsBackendDXMT];
}

- (void)toggleBottleGraphicsDXVK:(id)arg1 {
    [[[self selectedBottleNode] bottle] setGraphicsBackendDXVK];
}

- (void)toggleBottleGraphicsWine:(id)arg1 {
    [[[self selectedBottleNode] bottle] setGraphicsBackendWine];
}

- (void)toggleBottleVulkanMoltenVK:(id)arg1 {
    [[[self selectedBottleNode] bottle] setVulkanBackendMoltenVK];
}

- (void)toggleBottleVulkanMTLVK:(id)arg1 {
    [[[self selectedBottleNode] bottle] setVulkanBackendMTLVK];
}

- (void)toggleBottleDLSS:(id)arg1 {
    id bottle = [[self selectedBottleNode] bottle];
    if ([bottle isIsDLSSEnabled]) {
        [bottle disableDLSS];
    } else {
        [bottle enableDLSS];
    }
}

- (void)toggleBottleMSync:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler toggleMSyncForBottle:[node bottle] withWindow:[self window]];
}

- (void)toggleBottleHighResolution:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler toggleHighResolutionForBottle:[node bottle] withWindow:[self window]];
}

- (void)toggleBottlePreview:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler togglePreviewForBottle:[node bottle] withWindow:[self window]];
}

- (void)updateBottle:(id)arg1 {
    NSMutableArray *bottles = [NSMutableArray array];
    if ([arg1 isKindOfClass:[CXSetupLib bottleWrapperClass]]) {
        [bottles addObject:arg1];
    } else {
        NSArray *selected = [[self bottleTreeController] selectedObjects];
        for (BottleNode *node in selected) {
            if ([node type] == 2) {
                id b = [node bottle];
                if ([b isIsManaged] && ![b isIsUpToDate]) {
                    [bottles addObject:b];
                }
            }
        }
    }
    UpdateController *ctrl = [[UpdateController alloc] initWithManagedBottles:bottles];
    [ctrl showWindow:arg1];
    [ctrl release];
}

- (void)installSoftwareToBottle:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler installSoftwareIntoBottle:[node bottle] withWindow:[self window]];
}

- (void)runCommandInBottle:(id)arg1 {
    if ([[[[CXSetupLib bottleCollectionClass] sharedCollection] bottleList] count] != 0) {
        BottleNode *node = [self selectedBottleNode];
        [BottleMenuHandler runCommandInBottle:[node bottle]];
    }
}

- (void)openShellForBottle:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler openShellForBottle:[node bottle]];
}

- (void)quitBottle:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler quitBottle:[node bottle]];
}

- (void)forceQuitBottle:(id)arg1 {
    BottleNode *node = [self selectedBottleNode];
    [BottleMenuHandler forceQuitBottle:[node bottle]];
}

- (id)bottleViewController {
    return self->_bottleViewController;
}

- (void)setBottleViewController:(id)arg1 {
    if (self->_bottleViewController != arg1) {
        [self->_bottleViewController release];
        self->_bottleViewController = [arg1 retain];
    }
}

- (id)iconViewController {
    return self->_iconViewController;
}

- (void)setIconViewController:(id)arg1 {
    if (self->_iconViewController != arg1) {
        [self->_iconViewController release];
        self->_iconViewController = [arg1 retain];
    }
}

- (id)packageViewController {
    return self->_packageViewController;
}

- (void)setPackageViewController:(id)arg1 {
    if (self->_packageViewController != arg1) {
        [self->_packageViewController release];
        self->_packageViewController = [arg1 retain];
    }
}

- (id)mainContentView {
    return [objc_loadWeakRetained((id *)&self->_mainContentView) autorelease];
}

- (void)setMainContentView:(id)arg1 {
    objc_storeWeak((id *)&self->_mainContentView, arg1);
}

- (id)splitView {
    return [objc_loadWeakRetained((id *)&self->_splitView) autorelease];
}

- (void)setSplitView:(id)arg1 {
    objc_storeWeak((id *)&self->_splitView, arg1);
}

- (id)topMenuNodes {
    return self->_topMenuNodes;
}

- (void)setTopMenuNodes:(id)arg1 {
    if (self->_topMenuNodes != arg1) {
        [self->_topMenuNodes release];
        self->_topMenuNodes = [arg1 copy];
    }
}

- (id)bottomMenuNodes {
    return self->_bottomMenuNodes;
}

- (void)setBottomMenuNodes:(id)arg1 {
    if (self->_bottomMenuNodes != arg1) {
        [self->_bottomMenuNodes release];
        self->_bottomMenuNodes = [arg1 copy];
    }
}

- (id)topMenuSourceView {
    return [objc_loadWeakRetained((id *)&self->_topMenuSourceView) autorelease];
}

- (void)setTopMenuSourceView:(id)arg1 {
    objc_storeWeak((id *)&self->_topMenuSourceView, arg1);
}

- (id)bottomMenuSourceView {
    return [objc_loadWeakRetained((id *)&self->_bottomMenuSourceView) autorelease];
}

- (void)setBottomMenuSourceView:(id)arg1 {
    objc_storeWeak((id *)&self->_bottomMenuSourceView, arg1);
}

- (id)topMenuTreeController {
    return [objc_loadWeakRetained((id *)&self->_topMenuTreeController) autorelease];
}

- (void)setTopMenuTreeController:(id)arg1 {
    objc_storeWeak((id *)&self->_topMenuTreeController, arg1);
}

- (id)bottomMenuTreeController {
    return [objc_loadWeakRetained((id *)&self->_bottomMenuTreeController) autorelease];
}

- (void)setBottomMenuTreeController:(id)arg1 {
    objc_storeWeak((id *)&self->_bottomMenuTreeController, arg1);
}

- (id)bottleSourceView {
    return [objc_loadWeakRetained((id *)&self->_bottleSourceView) autorelease];
}

- (void)setBottleSourceView:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleSourceView, arg1);
}

- (id)bottleTreeController {
    return [objc_loadWeakRetained((id *)&self->_bottleTreeController) autorelease];
}

- (void)setBottleTreeController:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleTreeController, arg1);
}

- (id)privateBottleGroup {
    return self->_privateBottleGroup;
}

- (void)setPrivateBottleGroup:(id)arg1 {
    if (self->_privateBottleGroup != arg1) {
        [self->_privateBottleGroup release];
        self->_privateBottleGroup = [arg1 retain];
    }
}

- (id)publishedBottleGroup {
    return self->_publishedBottleGroup;
}

- (void)setPublishedBottleGroup:(id)arg1 {
    if (self->_publishedBottleGroup != arg1) {
        [self->_publishedBottleGroup release];
        self->_publishedBottleGroup = [arg1 retain];
    }
}

- (BOOL)updating {
    return self->_updating;
}

- (void)setUpdating:(BOOL)arg1 {
    self->_updating = arg1;
}

@end
