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
    BottleNode *node = [self selectedBottleNode];
    if (node) {
        [[node bottle] loadHighResolutionInfo];
    }
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
        [bottle addObserver:self forKeyPath:@"isBusy" options:0 context:NULL];
    }
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
