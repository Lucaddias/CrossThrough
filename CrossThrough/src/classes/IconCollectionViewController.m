// IconCollectionViewController.m — CrossThrough
#import "IconCollectionViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation IconCollectionViewController

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)viewDidLoad {
    return;
}

- (id)margins {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self collectionView];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 collectionViewLayout];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 margins];
     *   [r20 release];
     *   r0 = [r19 release];
     *   return r0;
     */
    return nil;
}

- (void)setMargins:(id)arg1 {
    return;
}

- (id)selectedItem {
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
     *   r0 = [self collectionView];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r19 = [[r0 selectionIndexPaths] retain];
     *   [r21 release];
     *   if ([r19 count] == 0x1) {
     *   r21 = [[r19 anyObject] retain];
     *   r0 = [r20 collectionView];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r20 = [[r0 itemAtIndexPath:r21] retain];
     *   [r22 release];
     *   [r21 release];
     *   }
     *   else {
     *   r20 = 0x0;
     *   }
     *   ... (3 more lines)
     */
    return nil;
}

- (BOOL)allowsMultipleSelection {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self collectionView];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [r0 allowsMultipleSelection];
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return NO;
}

- (void)setAllowsMultipleSelection:(BOOL)arg1 {
    return;
}

- (id)selectedLauncher {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self selectedItem];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 representedObject] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)selectedLaunchers {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x130;
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
     *   r19 = self;
     *   var_58 = **___stack_chk_guard;
     *   r0 = [self collectionView];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 selectionIndexPaths] retain];
     *   [r20 release];
     *   r20 = [[NSMutableArray arrayWithCapacity:[r21 count]] retain];
     *   var_120 = q0;
     *   var_110 = q0;
     *   r0 = [r21 retain];
     *   r21 = r0;
     *   ... (33 more lines)
     */
    return nil;
}

- (void)setLaunchers:(id)arg1 {
    return;
}

- (void)openLauncherTreeNode:(id)arg1 fromRect:(NSRect)arg2 view:(id)arg3 {
    return;
}

- (void)openIcon:(id)arg1 {
    return;
}

- (void)runIconWithOptions:(id)arg1 {
    return;
}

- (BOOL)launcherIsHidden:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [arg2 persistentID];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   r20 = [NSSet alloc];
     *   r0 = [NSUserDefaults standardUserDefaults];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r22 = [[r0 objectForKey:@"HiddenLauncherIDs"] retain];
     *   r20 = [r20 initWithArray:r22];
     *   [r22 release];
     *   [r21 release];
     *   r21 = [r20 containsObject:r19];
     *   [r20 release];
     *   if ((r21 & 0x1) != 0x0) {
     *   r20 = 0x1;
     *   }
     *   else {
     *   ... (9 more lines)
     */
    return NO;
}

- (void)markLauncher:(id)arg1 asHidden:(BOOL)arg2 {
    return;
}

- (void)toggleApplicationIsHidden:(id)arg1 {
    return;
}

- (BOOL)validateUserInterfaceItem:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r19 = [arg2 retain];
     *   r0 = **_NSApp;
     *   r0 = [r0 modalWindow];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   r20 = r0;
     *   r21 = 0x0;
     *   [r20 release];
     *   }
     *   else {
     *   r0 = [r21 view];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 window];
     *   r0 = [r0 retain];
     *   ... (48 more lines)
     */
    return NO;
}

- (BOOL)validateMenuItem:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [arg2 retain];
     *   r19 = r0;
     *   if ([r0 action] == @selector(toggleApplicationIsHidden:)) {
     *   r21 = [[r20 selectedLauncher] retain];
     *   r0 = [r20 selectedLaunchers];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   if ([r0 count] <= 0x1) {
     *   if ([r21 canBeFavorite] != 0x0) {
     *   r23 = [r20 launcherIsHidden:r21];
     *   [r22 release];
     *   if ((r23 & 0x1) != 0x0) {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   ... (34 more lines)
     */
    return NO;
}

- (NSInteger)numberOfSectionsInCollectionView:(id)arg1 {
    return 1;
}

- (NSInteger)collectionView:(id)arg1 numberOfItemsInSection:(NSInteger)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self launchers];
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
     *   r19 = [[arg2 makeItemWithIdentifier:@"IconViewItem" forIndexPath:r21] retain];
     *   r20 = [[self launchers] retain];
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

- (id)collectionView:(id)arg1 pasteboardWriterForItemAtIndexPath:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [arg2 itemAtIndexPath:arg3];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 representedObject];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 pasteboardWriter] retain];
     *   [r20 release];
     *   [r19 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)collectionView:(id)arg1 draggingSession:(id)arg2 willBeginAtPoint:(NSPoint)arg3 forItemsAtIndexPaths:(id)arg4 {
    return;
}

- (void)collectionView:(id)arg1 didSelectItemsAtIndexPaths:(id)arg2 {
    return;
}

- (void)collectionView:(id)arg1 didDeselectItemsAtIndexPaths:(id)arg2 {
    return;
}

- (void)keyDown:(id)arg1 {
    return;
}

- (void)mouseDown:(id)arg1 {
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

- (id)launchers {
    return self->_launchers;
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

- (id)contextualMenu {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_contextualMenu);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setContextualMenu:(id)arg1 {
    return;
}

@end
