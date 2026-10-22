// IconCollectionViewController.h — CrossThrough
#ifndef IconCollectionViewController_h
#define IconCollectionViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class IconCollectionViewController;

@interface IconCollectionViewController : CXViewController <NSCollectionViewDataSource, NSObject, NSCollectionViewDelegate>
{
    id<IconCollectionViewControllerDelegate> _delegate;
    NSArray * _launchers;
    NSCollectionView * _collectionView;
    NSMenu * _contextualMenu;
}

// Instance Methods
- (id)init;
- (void)viewDidLoad;
- (NSEdgeInsets)margins;
- (void)setMargins:(NSEdgeInsets)arg1;
- (id)selectedItem;
- (BOOL)allowsMultipleSelection;
- (void)setAllowsMultipleSelection:(BOOL)arg1;
- (id)selectedLauncher;
- (id)selectedLaunchers;
- (void)setLaunchers:(id)arg1;
- (void)openLauncherTreeNode:(id)arg1 fromRect:(NSRect)arg2 view:(id)arg3;
- (void)openIcon:(id)arg1;
- (void)runIconWithOptions:(id)arg1;
- (BOOL)launcherIsHidden:(id)arg1;
- (void)markLauncher:(id)arg1 asHidden:(BOOL)arg2;
- (void)toggleApplicationIsHidden:(id)arg1;
- (BOOL)validateUserInterfaceItem:(id)arg1;
- (BOOL)validateMenuItem:(id)arg1;
- (NSInteger)numberOfSectionsInCollectionView:(id)arg1;
- (NSInteger)collectionView:(id)arg1 numberOfItemsInSection:(NSInteger)arg2;
- (id)collectionView:(id)arg1 itemForRepresentedObjectAtIndexPath:(id)arg2;
- (id)collectionView:(id)arg1 pasteboardWriterForItemAtIndexPath:(id)arg2;
- (void)collectionView:(id)arg1 draggingSession:(id)arg2 willBeginAtPoint:(NSPoint)arg3 forItemsAtIndexPaths:(id)arg4;
- (void)collectionView:(id)arg1 didSelectItemsAtIndexPaths:(id)arg2;
- (void)collectionView:(id)arg1 didDeselectItemsAtIndexPaths:(id)arg2;
- (void)keyDown:(id)arg1;
- (void)mouseDown:(id)arg1;
- (id)delegate;
- (void)setDelegate:(id)arg1;
- (id)launchers;
- (id)collectionView;
- (void)setCollectionView:(id)arg1;
- (id)contextualMenu;
- (void)setContextualMenu:(id)arg1;

@end

#endif /* IconCollectionViewController_h */
