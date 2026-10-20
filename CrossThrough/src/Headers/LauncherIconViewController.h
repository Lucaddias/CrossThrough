// LauncherIconViewController.h — CrossThrough
#ifndef LauncherIconViewController_h
#define LauncherIconViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class LauncherIconViewController;
@class IconCollectionViewController;
@class CXDragView;

@interface LauncherIconViewController : CXViewController <CXDragViewDelegate>
{
    IconCollectionViewController * _iconCollectionViewController;
    BottleCollection * _bottleCollection;
    NSView * _iconCollectionView;
    CXDragView * _dragView;
}

// Instance Methods
- (id)init;
- (void)dealloc;
- (void)viewDidLoad;
- (void)reloadLaunchers;
- (id)launcherNodesForLaunchers:(id)arg1;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (BOOL)performDragOperation:(id)arg1;
- (id)iconCollectionViewController;
- (void)setIconCollectionViewController:(id)arg1;
- (id)bottleCollection;
- (void)setBottleCollection:(id)arg1;
- (id)iconCollectionView;
- (void)setIconCollectionView:(id)arg1;
- (id)dragView;
- (void)setDragView:(id)arg1;

@end

#endif /* LauncherIconViewController_h */
