// MainWindowController.h — CrossThrough
#ifndef MainWindowController_h
#define MainWindowController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class MainWindowController;
@class BottleViewController;
@class LauncherIconViewController;
@class PackageViewController;
@class BottleNode;
@class BottleNode;

@interface MainWindowController : CXWindowController <NSAnimationDelegate, NSObject, NSOutlineViewDelegate, NSControlTextEditingDelegate, NSMenuDelegate, PackageViewDelegate>
{
    NSMutableArray * _bottleNodes;
    BOOL _observingBottleList;
    NSInteger mode;
    BOOL _updating;
    BottleViewController * _bottleViewController;
    LauncherIconViewController * _iconViewController;
    PackageViewController * _packageViewController;
    NSView * _mainContentView;
    NSSplitView * _splitView;
    NSArray * _topMenuNodes;
    NSArray * _bottomMenuNodes;
    NSOutlineView * _topMenuSourceView;
    NSOutlineView * _bottomMenuSourceView;
    NSTreeController * _topMenuTreeController;
    NSTreeController * _bottomMenuTreeController;
    NSOutlineView * _bottleSourceView;
    NSTreeController * _bottleTreeController;
    BottleNode * _privateBottleGroup;
    BottleNode * _publishedBottleGroup;
}

// Class Methods
+ (void)initialize;

// Instance Methods
- (id)init;
- (void)dealloc;
- (id)bottleNodes;
- (void)setBottleNodes:(id)arg1;
- (void)insertObject:(id)arg1 inBottleNodesAtIndex:(NSUInteger)arg2;
- (void)removeObjectFromBottleNodesAtIndex:(NSUInteger)arg1;
- (id)selectedBottleNode;
- (void)loadInfoForSelectedBottle;
- (void)updateMainContentView;
- (id)privateBottlesGroupNameNoPublished;
- (void)windowDidLoad;
- (NSUInteger)window:(id)arg1 willUseFullScreenPresentationOptions:(NSUInteger)arg2;
- (void)selectLaunchView;
- (void)selectInstallView;
- (void)selectDefaultView;
- (void)updateC4Ps;
- (void)autoPlay:(id)arg1 inBottle:(id)arg2;
- (void)autoPlayWithAutorunFile:(id)arg1 inBottle:(id)arg2;
- (void)addIconsForBottles:(id)arg1;
- (BOOL)isPreview;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (BOOL)outlineView:(id)arg1 isGroupItem:(id)arg2;
- (BOOL)outlineView:(id)arg1 shouldShowOutlineCellForItem:(id)arg2;
- (BOOL)outlineView:(id)arg1 shouldSelectItem:(id)arg2;
- (void)outlineView:(id)arg1 didRemoveRowView:(id)arg2 forRow:(NSInteger)arg3;
- (void)outlineViewSelectionDidChange:(id)arg1;
- (id)outlineView:(id)arg1 rowViewForItem:(id)arg2;
- (id)outlineView:(id)arg1 viewForTableColumn:(id)arg2 item:(id)arg3;
- (BOOL)validateUserInterfaceItem:(id)arg1;
- (void)setMenuItem:(id)arg1 genericTitle:(id)arg2 bottleTitleFormat:(id)arg3;
- (void)menuNeedsUpdate:(id)arg1;
- (void)menuWillOpen:(id)arg1;
- (BOOL)validateMenuItem:(id)arg1;
- (void)revealNewBottle:(id)arg1;
- (void)newBottle:(id)arg1;
- (void)duplicateBottle:(id)arg1;
- (void)renameBottle:(id)arg1;
- (void)deleteBottle:(id)arg1;
- (void)openBottleCDrive:(id)arg1;
- (void)exportBottleToArchive:(id)arg1;
- (void)importBottleArchiveFromURL:(id)arg1;
- (void)importBottleArchive:(id)arg1;
- (void)showInstallViewWithSelectedBottle:(id)arg1 package:(id)arg2;
- (void)showInstallViewWithSelectedBottle:(id)arg1;
- (void)publishBottle:(id)arg1;
- (void)toggleDefaultBottle:(id)arg1;
- (void)toggleBottleGraphicsAuto:(id)arg1;
- (void)toggleBottleGraphicsD3DMetal:(id)arg1;
- (void)toggleBottleGraphicsDXMT:(id)arg1;
- (void)toggleBottleGraphicsDXVK:(id)arg1;
- (void)toggleBottleGraphicsWine:(id)arg1;
- (void)toggleBottleVulkanMoltenVK:(id)arg1;
- (void)toggleBottleVulkanMTLVK:(id)arg1;
- (void)toggleBottleDLSS:(id)arg1;
- (void)toggleBottleMSync:(id)arg1;
- (void)toggleBottleHighResolution:(id)arg1;
- (void)toggleBottlePreview:(id)arg1;
- (void)updateBottle:(id)arg1;
- (void)installSoftwareToBottle:(id)arg1;
- (void)runCommandInBottle:(id)arg1;
- (void)openShellForBottle:(id)arg1;
- (void)quitBottle:(id)arg1;
- (void)forceQuitBottle:(id)arg1;
- (id)bottleViewController;
- (void)setBottleViewController:(id)arg1;
- (id)iconViewController;
- (void)setIconViewController:(id)arg1;
- (id)packageViewController;
- (void)setPackageViewController:(id)arg1;
- (id)mainContentView;
- (void)setMainContentView:(id)arg1;
- (id)splitView;
- (void)setSplitView:(id)arg1;
- (id)topMenuNodes;
- (void)setTopMenuNodes:(id)arg1;
- (id)bottomMenuNodes;
- (void)setBottomMenuNodes:(id)arg1;
- (id)topMenuSourceView;
- (void)setTopMenuSourceView:(id)arg1;
- (id)bottomMenuSourceView;
- (void)setBottomMenuSourceView:(id)arg1;
- (id)topMenuTreeController;
- (void)setTopMenuTreeController:(id)arg1;
- (id)bottomMenuTreeController;
- (void)setBottomMenuTreeController:(id)arg1;
- (id)bottleSourceView;
- (void)setBottleSourceView:(id)arg1;
- (id)bottleTreeController;
- (void)setBottleTreeController:(id)arg1;
- (id)privateBottleGroup;
- (void)setPrivateBottleGroup:(id)arg1;
- (id)publishedBottleGroup;
- (void)setPublishedBottleGroup:(id)arg1;
- (BOOL)updating;
- (void)setUpdating:(BOOL)arg1;

@end

#endif /* MainWindowController_h */
