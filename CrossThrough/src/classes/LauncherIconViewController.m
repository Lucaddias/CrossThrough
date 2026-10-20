// LauncherIconViewController.m — CrossThrough
#import "LauncherIconViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherIconViewController

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

- (void)reloadLaunchers {
    return;
}

- (id)launcherNodesForLaunchers:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x140;
     *   var_50 = r28;
     *   decomp_var_48 = r27;
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
     *   var_130 = self;
     *   var_60 = **___stack_chk_guard;
     *   r22 = [arg2 retain];
     *   r20 = [NSSet alloc];
     *   r0 = [NSUserDefaults standardUserDefaults];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r23 = [[r0 objectForKey:@"HiddenLauncherIDs"] retain];
     *   var_128 = [r20 initWithArray:r23];
     *   [r23 release];
     *   [r21 release];
     *   r21 = [[NSMutableArray array] retain];
     *   ... (112 more lines)
     */
    return nil;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (BOOL)performDragOperation:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [[arg2 draggingPasteboard] retain];
     *   r19 = [[NSURL URLFromPasteboard:r20] retain];
     *   [r20 release];
     *   r20 = [[**_NSApp CXServer] retain];
     *   r21 = [[r19 path] retain];
     *   [r20 runClient:r21 inBottle:0x0 withDialog:0x1];
     *   [r21 release];
     *   [r20 release];
     *   [r19 release];
     *   return 0x1;
     */
    return NO;
}

- (id)iconCollectionViewController {
    return self->_iconCollectionViewController;
}

- (void)setIconCollectionViewController:(id)arg1 {
    self->_iconCollectionViewController = arg1;
}

- (id)bottleCollection {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleCollection:(id)arg1 {
    return;
}

- (id)iconCollectionView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_iconCollectionView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setIconCollectionView:(id)arg1 {
    return;
}

- (id)dragView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_dragView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDragView:(id)arg1 {
    return;
}

@end
