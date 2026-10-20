// LauncherIconViewController.m — CrossThrough
#import "LauncherIconViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherIconViewController

- (id)init {
    self = [super initWithNibName:@"LauncherIconView" bundle:nil];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    // dealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self->_iconCollectionViewController) {
        self->_iconCollectionViewController = [[IconCollectionViewController alloc] init];
    }
    if (self->_iconCollectionView && self->_iconCollectionViewController) {
        NSView *v = [self->_iconCollectionViewController view];
        [v setFrame:[self->_iconCollectionView bounds]];
        [v setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        [self->_iconCollectionView setSubviews:@[v]];
    }
}

- (void)reloadLaunchers {
    return;
}

- (id)launcherNodesForLaunchers:(id)arg1 {
    return @[];
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (BOOL)performDragOperation:(id)arg1 {
    return YES;
}

- (id)iconCollectionViewController {
    return self->_iconCollectionViewController;
}

- (void)setIconCollectionViewController:(id)arg1 {
    self->_iconCollectionViewController = arg1;
}

- (id)bottleCollection {
    return objc_loadWeakRetained((id *)&self->_bottleCollection);
}

- (void)setBottleCollection:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleCollection, arg1);
}

- (id)iconCollectionView {
    return objc_loadWeakRetained((id *)&self->_iconCollectionView);
}

- (void)setIconCollectionView:(id)arg1 {
    objc_storeWeak((id *)&self->_iconCollectionView, arg1);
}

- (id)dragView {
    return objc_loadWeakRetained((id *)&self->_dragView);
}

- (void)setDragView:(id)arg1 {
    objc_storeWeak((id *)&self->_dragView, arg1);
}

@end
