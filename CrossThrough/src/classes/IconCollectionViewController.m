// IconCollectionViewController.m — CrossThrough
#import "IconCollectionViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation IconCollectionViewController

- (id)init {
    return [super initWithNibName:@"IconCollectionView" bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSCollectionView *collectionView = [self collectionView];
    [collectionView registerClass:[IconViewItem class] forItemWithIdentifier:@"IconViewItem"];
    [collectionView setDraggingSourceOperationMask:NSDragOperationEvery forLocal:YES];
    [collectionView setDraggingSourceOperationMask:NSDragOperationCopy | NSDragOperationLink forLocal:NO];
    [collectionView setMenu:[self contextualMenu]];
    [collectionView setDelegate:self];
    NSCollectionViewGridLayout *layout = (NSCollectionViewGridLayout *)[collectionView collectionViewLayout];
    [layout setMinimumLineSpacing:10.0];
    [layout setMinimumInteritemSpacing:10.0];
}

- (NSEdgeInsets)margins {
    return [(NSCollectionViewGridLayout *)[[self collectionView] collectionViewLayout] margins];
}

- (void)setMargins:(NSEdgeInsets)arg1 {
    [(NSCollectionViewGridLayout *)[[self collectionView] collectionViewLayout] setMargins:arg1];
}

- (id)selectedItem {
    NSSet *selection = [[self collectionView] selectionIndexPaths];
    if ([selection count] != 1) {
        return nil;
    }
    return [[self collectionView] itemAtIndexPath:[selection anyObject]];
}

- (BOOL)allowsMultipleSelection {
    return [[self collectionView] allowsMultipleSelection];
}

- (void)setAllowsMultipleSelection:(BOOL)arg1 {
    [[self collectionView] setAllowsMultipleSelection:arg1];
}

- (id)selectedLauncher {
    return [[self selectedItem] representedObject];
}

- (id)selectedLaunchers {
    NSSet *selection = [[self collectionView] selectionIndexPaths];
    NSMutableArray *launchers = [NSMutableArray arrayWithCapacity:[selection count]];
    for (NSIndexPath *indexPath in selection) {
        [launchers addObject:[[[self collectionView] itemAtIndexPath:indexPath] representedObject]];
    }
    return launchers;
}


- (void)openLauncherTreeNode:(id)arg1 fromRect:(NSRect)arg2 view:(id)arg3 {
    LauncherTreeNode *node = arg1;
    NSView *sourceView = arg3;
    if (![node isOpenable]) {
        return;
    }
    [node openWithErrorHandler:^(NSError *error) {
        [error retain];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentError:error modalForWindow:[[self view] window] delegate:nil didPresentSelector:NULL contextInfo:NULL];
            [error release];
        });
    }];
    if (![node animateOpen]) {
        return;
    }
    __block NSWindow *zoomWindow = nil;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [context setDuration:0.5];
        NSView *view = [self view];
        NSRect rect;
        NSView *rectView;
        if (sourceView) {
            rect = NSIsEmptyRect(arg2) ? [sourceView bounds] : arg2;
            rectView = sourceView;
        } else {
            NSSize iconSize = [(NSImage *)[node icon] size];
            NSRect visible = [view visibleRect];
            rect = NSMakeRect(visible.origin.x + visible.size.width * 0.5 - iconSize.width * 0.5,
                              visible.origin.y + visible.size.height * 0.5 - iconSize.height * 0.5,
                              iconSize.width, iconSize.height);
            rectView = view;
        }
        rect = [rectView convertRect:rect toView:nil];
        if (!NSIntersectsRect(rect, [view convertRect:[view visibleRect] toView:nil])) {
            return;
        }
        NSRect screenRect = [[view window] convertRectToScreen:rect];
        zoomWindow = [[NSWindow alloc] initWithContentRect:screenRect styleMask:NSWindowStyleMaskBorderless backing:NSBackingStoreBuffered defer:NO];
        [zoomWindow setBackgroundColor:[NSColor clearColor]];
        [zoomWindow setOpaque:NO];
        NSImageView *imageView = [[NSImageView alloc] initWithFrame:NSOffsetRect(screenRect, -screenRect.origin.x, -screenRect.origin.y)];
        [imageView setImage:[node icon]];
        [imageView setImageScaling:NSImageScaleProportionallyUpOrDown];
        [imageView setWantsLayer:YES];
        [zoomWindow setContentView:imageView];
        [zoomWindow setAlphaValue:0.8];
        [zoomWindow setReleasedWhenClosed:NO];
        [zoomWindow setIgnoresMouseEvents:YES];
        [zoomWindow orderFront:nil];
        [zoomWindow setLevel:NSFloatingWindowLevel];
        [zoomWindow display];
        [[zoomWindow animator] setAlphaValue:0.0];
        NSRect grown = NSInsetRect(screenRect, screenRect.size.width * -2.0, screenRect.size.height * -2.0);
        [[zoomWindow animator] setFrame:[zoomWindow frameRectForContentRect:grown] display:NO];
        [imageView release];
    } completionHandler:^{
        [zoomWindow close];
        [zoomWindow release];
        zoomWindow = nil;
    }];
}

- (void)openIcon:(id)arg1 {
    [self openLauncherTreeNode:[self selectedLauncher] fromRect:NSZeroRect view:[[self selectedItem] view]];
}

- (void)runIconWithOptions:(id)arg1 {
    id launcher = [self selectedLauncher];
    if ([launcher isKindOfClass:[LauncherAppTreeNode class]] && [launcher isOpenable]) {
        LauncherAppTreeNode *node = launcher;
        [BottleMenuHandler runCommandInBottle:[node bottle] withLauncher:[node launcher]];
    }
}

- (BOOL)launcherIsHidden:(id)arg1 {
    NSString *persistentID = [arg1 persistentID];
    if (!persistentID) {
        return NO;
    }
    NSSet *hidden = [[NSSet alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"HiddenLauncherIDs"]];
    BOOL isHidden = [hidden containsObject:persistentID];
    [hidden release];
    return isHidden;
}

- (void)markLauncher:(id)arg1 asHidden:(BOOL)arg2 {
    if (![arg1 persistentID]) {
        return;
    }
    NSMutableSet *hidden = [[NSMutableSet alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"HiddenLauncherIDs"]];
    if (arg2) {
        [hidden addObject:[arg1 persistentID]];
    } else {
        [hidden removeObject:[arg1 persistentID]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[hidden allObjects] forKey:@"HiddenLauncherIDs"];
    [hidden release];
}

- (void)toggleApplicationIsHidden:(id)arg1 {
    for (id launcher in [self selectedLaunchers]) {
        [self markLauncher:launcher asHidden:![self launcherIsHidden:launcher]];
    }
}

- (BOOL)validateUserInterfaceItem:(id)arg1 {
    if ([NSApp modalWindow] || [[[self view] window] attachedSheet]) {
        return NO;
    }
    LauncherTreeNode *launcher = [self selectedLauncher];
    SEL action = [arg1 action];
    if (action == @selector(openIcon:)) {
        return [launcher isOpenable];
    }
    if (action == @selector(runIconWithOptions:)) {
        return [launcher canRunCommands];
    }
    if (action == @selector(toggleApplicationIsHidden:)) {
        if ([self allowsMultipleSelection]) {
            return [[self selectedLaunchers] count] != 0;
        }
        return [launcher canBeFavorite];
    }
    return NO;
}

- (BOOL)validateMenuItem:(id)arg1 {
    if ([arg1 action] == @selector(toggleApplicationIsHidden:)) {
        LauncherTreeNode *launcher = [self selectedLauncher];
        NSString *title;
        if ([[self selectedLaunchers] count] > 1) {
            title = @"Hide from 'Home'";
        } else if ([launcher canBeFavorite] && ![self launcherIsHidden:launcher]) {
            title = @"Hide from 'Home'";
        } else {
            title = @"Show in 'Home'";
        }
        [arg1 setTitle:[[NSBundle mainBundle] localizedStringForKey:title value:@"" table:nil]];
    }
    return [self validateUserInterfaceItem:arg1];
}

- (NSInteger)numberOfSectionsInCollectionView:(id)arg1 {
    return 1;
}

- (NSInteger)collectionView:(id)arg1 numberOfItemsInSection:(NSInteger)arg2 {
    return [self->_launchers count];
}

- (id)collectionView:(id)arg1 itemForRepresentedObjectAtIndexPath:(id)arg2 {
    NSCollectionViewItem *item = [arg1 makeItemWithIdentifier:@"IconViewItem" forIndexPath:arg2];
    NSInteger idx = [(NSIndexPath *)arg2 item];
    if (idx >= 0 && idx < [self->_launchers count]) {
        [item setRepresentedObject:[self->_launchers objectAtIndex:idx]];
    }
    return item;
}

- (id)collectionView:(id)arg1 pasteboardWriterForItemAtIndexPath:(id)arg2 {
    return nil;
}

- (void)collectionView:(id)arg1 draggingSession:(id)arg2 willBeginAtPoint:(NSPoint)arg3 forItemsAtIndexPaths:(id)arg4 {
    for (NSIndexPath *indexPath in arg4) {
        [[[arg1 itemAtIndexPath:indexPath] view] setHidden:NO];
    }
}

- (void)collectionView:(id)arg1 didSelectItemsAtIndexPaths:(id)arg2 {
    [[self delegate] iconCollectionViewControllerSelectionChanged:self];
}

- (void)collectionView:(id)arg1 didDeselectItemsAtIndexPaths:(id)arg2 {
    [[self delegate] iconCollectionViewControllerSelectionChanged:self];
}

- (void)keyDown:(id)arg1 {
    NSEvent *event = arg1;
    NSString *characters = [event charactersIgnoringModifiers];
    if ([characters length] == 1) {
        unichar c = [characters characterAtIndex:0];
        if (c == NSCarriageReturnCharacter || c == NSEnterCharacter) {
            [self openIcon:self];
            return;
        }
    }
    if (([event modifierFlags] & NSEventModifierFlagCommand) && [event keyCode] == 0x7d) {
        [self openIcon:self];
    } else {
        [super keyDown:arg1];
    }
}

- (void)mouseDown:(id)arg1 {
    if ([arg1 clickCount] >= 2) {
        [self openIcon:self];
    } else {
        [super mouseDown:arg1];
    }
}

- (id)delegate {
    return objc_loadWeakRetained((id *)&self->_delegate);
}

- (void)setDelegate:(id)arg1 {
    objc_storeWeak((id *)&self->_delegate, arg1);
}

- (id)launchers {
    return self->_launchers;
}

- (void)setLaunchers:(id)arg1 {
    if (self->_launchers != arg1) {
        [self->_launchers release];
        self->_launchers = [arg1 copy];
        [[self collectionView] reloadData];
    }
}

- (id)collectionView {
    return objc_loadWeakRetained((id *)&self->_collectionView);
}

- (void)setCollectionView:(id)arg1 {
    objc_storeWeak((id *)&self->_collectionView, arg1);
}

- (id)contextualMenu {
    return objc_loadWeakRetained((id *)&self->_contextualMenu);
}

- (void)setContextualMenu:(id)arg1 {
    objc_storeWeak((id *)&self->_contextualMenu, arg1);
}

- (void)dealloc {
    [self->_launchers release];
    objc_destroyWeak((id *)&self->_delegate);
    objc_destroyWeak((id *)&self->_collectionView);
    objc_destroyWeak((id *)&self->_contextualMenu);
    [super dealloc];
}

@end
