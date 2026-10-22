// LauncherIconViewController.m — CrossThrough
#import "LauncherIconViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static void *_LauncherIconViewControllerKVCContext = &_LauncherIconViewControllerKVCContext;


@implementation LauncherIconViewController

- (id)init {
    return [super initWithNibName:@"LauncherIconView" bundle:nil];
}

- (void)dealloc {
    [[self dragView] setDelegate:nil];
    [[(CXApplication *)NSApp CXServer] removeObserver:self forKeyPath:@"launchers"];
    [[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:@"HiddenLauncherIDs"];
    [self->_iconCollectionViewController release];
    objc_destroyWeak((id *)&self->_bottleCollection);
    objc_destroyWeak((id *)&self->_iconCollectionView);
    objc_destroyWeak((id *)&self->_dragView);
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBottleCollection:[[CXSetupLib bottleCollectionClass] sharedCollection]];
    IconCollectionViewController *icvc = [[IconCollectionViewController alloc] init];
    [self setIconCollectionViewController:icvc];
    [icvc release];

    NSView *view = [[self iconCollectionViewController] view];
    [[self iconCollectionView] setSubviews:@[view]];
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    [[self iconCollectionView] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views]];
    [[self iconCollectionView] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
    [[self iconCollectionViewController] setMargins:NSEdgeInsetsMake(0.0, 40.0, 0.0, 40.0)];
    [[self iconCollectionViewController] setAllowsMultipleSelection:YES];
    [[self dragView] registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
    [[self dragView] setDelegate:self];

    [[(CXApplication *)NSApp CXServer] addObserver:self forKeyPath:@"launchers" options:0 context:_LauncherIconViewControllerKVCContext];
    [[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:@"HiddenLauncherIDs" options:0 context:_LauncherIconViewControllerKVCContext];
    [self reloadLaunchers];
}

- (void)reloadLaunchers {
    NSArray *launchers = [(CXServerCrossOver *)[(CXApplication *)NSApp CXServer] launchers];
    [[self iconCollectionViewController] setLaunchers:[self launcherNodesForLaunchers:launchers]];
}

- (id)launcherNodesForLaunchers:(id)arg1 {
    NSSet *hidden = [[NSSet alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"HiddenLauncherIDs"]];
    NSMutableArray *nodes = [NSMutableArray array];
    for (LauncherItem *item in arg1) {
        if ([item isLeaf] && [item isKindOfClass:[LauncherApp class]]) {
            LauncherAppTreeNode *node = [LauncherAppTreeNode fromLauncher:item];
            [node setShowBottleName:YES];
            if (![hidden containsObject:[node persistentID]]) {
                [nodes addObject:node];
            }
        } else if (![item isLeaf] && [item isKindOfClass:[LauncherFolder class]]) {
            [nodes addObjectsFromArray:[self launcherNodesForLaunchers:[(LauncherFolder *)item items]]];
        }
    }
    [nodes sortUsingSelector:@selector(compareSortOrderThenName:)];
    [hidden release];
    return nodes;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    if (arg4 != _LauncherIconViewControllerKVCContext) {
        [super observeValueForKeyPath:arg1 ofObject:arg2 change:arg3 context:arg4];
        return;
    }
    if ((arg2 == [(CXApplication *)NSApp CXServer] && [arg1 isEqualToString:@"launchers"]) ||
        (arg2 == [NSUserDefaults standardUserDefaults] && [arg1 isEqualToString:@"HiddenLauncherIDs"])) {
        [self reloadLaunchers];
    }
}

- (BOOL)performDragOperation:(id)arg1 {
    NSURL *url = [NSURL URLFromPasteboard:[arg1 draggingPasteboard]];
    [(CXServerCrossOver *)[(CXApplication *)NSApp CXServer] runClient:[url path] inBottle:nil withDialog:YES];
    return YES;
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

- (id)bottleCollection {
    return [objc_loadWeakRetained((id *)&self->_bottleCollection) autorelease];
}

- (void)setBottleCollection:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleCollection, arg1);
}

- (id)iconCollectionView {
    return [objc_loadWeakRetained((id *)&self->_iconCollectionView) autorelease];
}

- (void)setIconCollectionView:(id)arg1 {
    objc_storeWeak((id *)&self->_iconCollectionView, arg1);
}

- (id)dragView {
    return [objc_loadWeakRetained((id *)&self->_dragView) autorelease];
}

- (void)setDragView:(id)arg1 {
    objc_storeWeak((id *)&self->_dragView, arg1);
}

@end
