// MainWindowController.m — CrossThrough
#import "MainWindowController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation MainWindowController

+ (void)initialize {
    if (self == [MainWindowController class]) {
        NSDictionary *defaults = @{ @"HiddenLauncherIDs": @[] };
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    }
}

- (id)init {
    self = [super initWithWindowNibName:@"MainWindow"];
    NSLog(@"[MainWindowController] init called, nibName=%@", [self windowNibName]);
    if (self) {
        self->_bottleViewController = [[BottleViewController alloc] init];
        self->_iconViewController = [[LauncherIconViewController alloc] init];
        self->_packageViewController = [[PackageViewController alloc] init];
        self->_bottleNodes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)bottleNodes {
    return self->_bottleNodes;
}

- (void)setBottleNodes:(id)arg1 {
    if (self->_bottleNodes != arg1) {
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
    if (self->_bottleSourceView) {
        NSInteger clicked = [self->_bottleSourceView clickedRow];
        if (clicked != -1) {
            id item = [self->_bottleSourceView itemAtRow:clicked];
            if ([item respondsToSelector:@selector(representedObject)]) {
                return [item representedObject];
            }
            return item;
        }
        NSInteger selected = [self->_bottleSourceView selectedRow];
        if (selected != -1) {
            id item = [self->_bottleSourceView itemAtRow:selected];
            if ([item respondsToSelector:@selector(representedObject)]) {
                return [item representedObject];
            }
            return item;
        }
    }
    return nil;
}

- (void)loadInfoForSelectedBottle {
    [self updateMainContentView];
}

- (id)privateBottlesGroupNameNoPublished {
    NSString *name = [[NSBundle mainBundle] localizedStringForKey:@"BOTTLES" value:@"BOTTLES" table:nil];
    return name ?: @"BOTTLES";
}

- (void)windowDidLoad {
    NSLog(@"[MainWindowController] windowDidLoad called! window=%@", [self window]);
    [super windowDidLoad];

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

    NSMutableArray *bNodes = [NSMutableArray array];
    BottleNode *privGroup = [BottleNode groupBottleNodeWithName:[self privateBottlesGroupNameNoPublished]];
    [privGroup setSortPriority:2];
    [self setPrivateBottleGroup:privGroup];
    [bNodes addObject:privGroup];

    NSString *pubTitle = [[NSBundle mainBundle] localizedStringForKey:@"PUBLISHED BOTTLES" value:@"PUBLISHED BOTTLES" table:nil];
    BottleNode *pubGroup = [BottleNode groupBottleNodeWithName:pubTitle];
    [pubGroup setSortPriority:3];
    [self setPublishedBottleGroup:pubGroup];

    [self setBottleNodes:bNodes];

    if (self->_bottleTreeController) {
        NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"sortPriority" ascending:YES selector:@selector(compare:)];
        NSSortDescriptor *sd2 = [NSSortDescriptor sortDescriptorWithKey:@"bottle.isDefault" ascending:NO selector:@selector(compare:)];
        NSSortDescriptor *sd3 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
        [self->_bottleTreeController setSortDescriptors:@[sd1, sd2, sd3]];
    }

    if (self->_mainContentView) {
        NSRect contentBounds = [self->_mainContentView bounds];
        NSMutableArray *subviews = [NSMutableArray array];

        if (self->_iconViewController) {
            NSView *v = [self->_iconViewController view];
            if (v) {
                [v setFrame:contentBounds];
                [v setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
                [subviews addObject:v];
            }
        }
        if (self->_packageViewController) {
            NSView *v = [self->_packageViewController view];
            if (v) {
                [v setFrame:contentBounds];
                [v setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
                [subviews addObject:v];
            }
        }
        if (self->_bottleViewController) {
            NSView *v = [self->_bottleViewController view];
            if (v) {
                [v setFrame:contentBounds];
                [v setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
                [subviews addObject:v];
            }
        }
        [self->_mainContentView setSubviews:subviews];
    }

    if (self->_splitView) {
        [self->_splitView setAutosaveName:@"MainWindowSplit22"];
    }

    NSWindow *win = [self window];
    if (win) {
        [win setBackgroundColor:[NSColor controlBackgroundColor]];
    }

    [self selectDefaultView];
}

- (NSUInteger)window:(id)arg1 willUseFullScreenPresentationOptions:(NSUInteger)arg2 {
    return arg2 | 0x800;
}

- (void)updateMainContentView {
    NSArray *selected = [self.topMenuTreeController selectedObjects];
    if ([selected count] == 0) {
        selected = [self.bottleTreeController selectedObjects];
    }
    if ([selected count] == 0) {
        selected = [self.bottomMenuTreeController selectedObjects];
    }

    BottleNode *node = [selected count] > 0 ? selected[0] : nil;
    NSInteger type = node ? [node type] : 1;

    if (type == 3) {
        // Install Software View
        [[self.iconViewController view] setHidden:YES];
        [[self.packageViewController view] setHidden:NO];
        [[self.bottleViewController view] setHidden:YES];
    } else if (type == 2) {
        // Single Bottle Detail View
        [[self.iconViewController view] setHidden:YES];
        [[self.packageViewController view] setHidden:YES];
        [[self.bottleViewController view] setHidden:NO];
    } else {
        // All Bottles / Home View
        [[self.iconViewController view] setHidden:NO];
        [[self.packageViewController view] setHidden:YES];
        [[self.bottleViewController view] setHidden:YES];
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
    return;
}

- (void)autoPlay:(id)arg1 inBottle:(id)arg2 {
    [self selectInstallView];
}

- (void)autoPlayWithAutorunFile:(id)arg1 inBottle:(id)arg2 {
    [self selectInstallView];
}

- (void)addIconsForBottles:(id)arg1 {
    return;
}

- (BOOL)isPreview {
    return NO;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    [self updateMainContentView];
}

- (BOOL)outlineView:(id)arg1 isGroupItem:(id)arg2 {
    id item = [arg2 respondsToSelector:@selector(representedObject)] ? [arg2 representedObject] : arg2;
    if ([item respondsToSelector:@selector(type)]) {
        return [item type] == 0;
    }
    return NO;
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
    id obj = [arg1 respondsToSelector:@selector(object)] ? [arg1 object] : arg1;
    if (obj == self->_topMenuSourceView && [self->_topMenuSourceView selectedRow] != -1) {
        [self->_bottleSourceView deselectAll:self];
        [self->_bottomMenuSourceView deselectAll:self];
    } else if (obj == self->_bottleSourceView && [self->_bottleSourceView selectedRow] != -1) {
        [self->_topMenuSourceView deselectAll:self];
        [self->_bottomMenuSourceView deselectAll:self];
    } else if (obj == self->_bottomMenuSourceView && [self->_bottomMenuSourceView selectedRow] != -1) {
        [self->_topMenuSourceView deselectAll:self];
        [self->_bottleSourceView deselectAll:self];
    }
    [self updateMainContentView];
}

- (id)outlineView:(id)arg1 rowViewForItem:(id)arg2 {
    return [[[BottleTableRowView alloc] init] autorelease];
}

- (id)outlineView:(id)arg1 viewForTableColumn:(id)arg2 item:(id)arg3 {
    NSString *identifier = arg2 ? @"DataCell" : @"HeaderCell";
    return [arg1 makeViewWithIdentifier:identifier owner:self];
}

- (BOOL)validateUserInterfaceItem:(id)arg1 {
    return YES;
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
    return YES;
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
    [self selectInstallView];
}

- (void)showInstallViewWithSelectedBottle:(id)arg1 {
    [self selectInstallView];
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
    [self selectInstallView];
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
    return objc_loadWeakRetained((id *)&self->_mainContentView);
}

- (void)setMainContentView:(id)arg1 {
    objc_storeWeak((id *)&self->_mainContentView, arg1);
}

- (id)splitView {
    return objc_loadWeakRetained((id *)&self->_splitView);
}

- (void)setSplitView:(id)arg1 {
    objc_storeWeak((id *)&self->_splitView, arg1);
}

- (id)topMenuNodes {
    return self->_topMenuNodes;
}

- (void)setTopMenuNodes:(id)arg1 {
    if (self->_topMenuNodes != arg1) {
        self->_topMenuNodes = [arg1 copy];
    }
}

- (id)bottomMenuNodes {
    return self->_bottomMenuNodes;
}

- (void)setBottomMenuNodes:(id)arg1 {
    if (self->_bottomMenuNodes != arg1) {
        self->_bottomMenuNodes = [arg1 copy];
    }
}

- (id)topMenuSourceView {
    return objc_loadWeakRetained((id *)&self->_topMenuSourceView);
}

- (void)setTopMenuSourceView:(id)arg1 {
    objc_storeWeak((id *)&self->_topMenuSourceView, arg1);
}

- (id)bottomMenuSourceView {
    return objc_loadWeakRetained((id *)&self->_bottomMenuSourceView);
}

- (void)setBottomMenuSourceView:(id)arg1 {
    objc_storeWeak((id *)&self->_bottomMenuSourceView, arg1);
}

- (id)topMenuTreeController {
    return objc_loadWeakRetained((id *)&self->_topMenuTreeController);
}

- (void)setTopMenuTreeController:(id)arg1 {
    objc_storeWeak((id *)&self->_topMenuTreeController, arg1);
}

- (id)bottomMenuTreeController {
    return objc_loadWeakRetained((id *)&self->_bottomMenuTreeController);
}

- (void)setBottomMenuTreeController:(id)arg1 {
    objc_storeWeak((id *)&self->_bottomMenuTreeController, arg1);
}

- (id)bottleSourceView {
    return objc_loadWeakRetained((id *)&self->_bottleSourceView);
}

- (void)setBottleSourceView:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleSourceView, arg1);
}

- (id)bottleTreeController {
    return objc_loadWeakRetained((id *)&self->_bottleTreeController);
}

- (void)setBottleTreeController:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleTreeController, arg1);
}

- (id)privateBottleGroup {
    return self->_privateBottleGroup;
}

- (void)setPrivateBottleGroup:(id)arg1 {
    self->_privateBottleGroup = arg1;
}

- (id)publishedBottleGroup {
    return self->_publishedBottleGroup;
}

- (void)setPublishedBottleGroup:(id)arg1 {
    self->_publishedBottleGroup = arg1;
}

- (BOOL)updating {
    return self->_updating;
}

- (void)setUpdating:(BOOL)arg1 {
    self->_updating = arg1;
}

@end
