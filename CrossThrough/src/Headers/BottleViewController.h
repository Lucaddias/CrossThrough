// BottleViewController.h — CrossThrough
#ifndef BottleViewController_h
#define BottleViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class BottleViewController;
@class PackageTreeNode;
@class IconCollectionViewController;
@class CXDragView;
@class CXFlatPopUpButton;
@class CXFlatPopUpButton;

@interface BottleViewController : CXViewController <NSTextFieldDelegate, NSControlTextEditingDelegate, NSObject, IconCollectionViewControllerDelegate, CXDragViewDelegate, NSCollectionViewDelegate, NSOutlineViewDataSource, NSOutlineViewDelegate>
{
    BOOL _canBeRated;
    BottleWrapper * _bottle;
    NSArray * _observers;
    PackageTreeNode * _package;
    IconCollectionViewController * _iconCollectionViewController;
    CXDragView * _iconCollectionView;
    NSTextField * _noAppsFoundLabel;
    NSButton * _leaveRatingButton;
    NSMutableArray * _controlPanelLaunchers;
    NSButton * _runWithOptionsButton;
    NSButton * _runCommandButton;
    NSButton * _installIntoBottleButton;
    NSButton * _openCDriveButton;
    NSButton * _quitButton;
    NSButton * _deleteButton;
    NSButton * _dependencyButton;
    NSStackView * _graphicsOptionView;
    NSTextField * _graphicsLabel;
    CXFlatPopUpButton * _graphicsPopUpButton;
    NSMenuItem * _autoGraphicsMenuItem;
    NSMenuItem * _dxmtMenuItem;
    NSMenuItem * _dxvkMenuItem;
    NSMenuItem * _d3dMetalMenuItem;
    NSMenuItem * _wined3dMenuItem;
    NSStackView * _vulkanOptionView;
    NSTextField * _vulkanLabel;
    CXFlatPopUpButton * _vulkanPopUpButton;
    NSMenuItem * _moltenvkMenuItem;
    NSMenuItem * _mtlvkMenuItem;
    NSTextField * _msyncLabel;
    NSSwitch * _msyncSwitch;
    NSStackView * _msyncView;
    NSTextField * _dlssLabel;
    NSSwitch * _dlssSwitch;
    NSStackView * _dlssView;
    NSTextField * _highResolutionLabel;
    NSSwitch * _highResolutionSwitch;
    NSStackView * _highResolutionView;
    NSTextField * _previewLabel;
    NSSwitch * _previewSwitch;
    NSStackView * _previewView;
    NSStackView * _controlPanelsSection;
    NSStackView * _controlPanelsLoadingView;
    NSProgressIndicator * _controlPanelsLoadingSpinner;
    NSTableView * _installedSoftwareTableView;
    NSArrayController * _installedSoftware;
}

// Class Methods
+ (id)keyPathsForValuesAffectingBottleDescription;

// Instance Methods
- (id)init;
- (void)dealloc;
- (void)viewDidLoad;
- (void)setBottle:(id)arg1;
- (id)packageForBottle:(id)arg1;
- (void)reloadLaunchers;
- (void)updateDependencyButton;
- (void)updateQuitButton;
- (void)updateMenuItems;
- (void)resetMenuForNewBottle;
- (id)iconForControlPanel:(id)arg1;
- (void)sortControlPanels:(id)arg1;
- (void)addButtonForControlPanel:(id)arg1 index:(NSInteger)arg2;
- (void)showControlPanelLoader:(BOOL)arg1;
- (void)reloadControlPanels;
- (id)launcherNodesForLaunchers:(id)arg1;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)leaveRating:(id)arg1;
- (id)bottleDescription;
- (void)setBottleDescription:(id)arg1;
- (void)iconCollectionViewControllerSelectionChanged:(id)arg1;
- (void)runWithOptionsClicked:(id)arg1;
- (void)runCommandClicked:(id)arg1;
- (void)installIntoBottleClicked:(id)arg1;
- (void)dependencyButtonClicked:(id)arg1;
- (void)openCDriveClicked:(id)arg1;
- (void)quitClicked:(id)arg1;
- (void)deleteClicked:(id)arg1;
- (void)graphicsOptionChanged:(id)arg1;
- (void)vulkanOptionChanged:(id)arg1;
- (void)dlssToggled:(id)arg1;
- (void)msyncToggled:(id)arg1;
- (void)highResolutionToggled:(id)arg1;
- (void)previewToggled:(id)arg1;
- (void)controlPanelButtonClicked:(id)arg1;
- (void)bottleDescriptionDidEndEditing:(id)arg1;
- (id)selectedApplication;
- (BOOL)canUninstall;
- (void)uninstallClicked:(id)arg1;
- (BOOL)control:(id)arg1 textView:(id)arg2 doCommandBySelector:(SEL)arg3;
- (BOOL)performDragOperation:(id)arg1;
- (id)bottle;
- (id)observers;
- (void)setObservers:(id)arg1;
- (id)package;
- (void)setPackage:(id)arg1;
- (BOOL)canBeRated;
- (void)setCanBeRated:(BOOL)arg1;
- (id)iconCollectionViewController;
- (void)setIconCollectionViewController:(id)arg1;
- (id)iconCollectionView;
- (void)setIconCollectionView:(id)arg1;
- (id)noAppsFoundLabel;
- (void)setNoAppsFoundLabel:(id)arg1;
- (id)leaveRatingButton;
- (void)setLeaveRatingButton:(id)arg1;
- (id)controlPanelLaunchers;
- (void)setControlPanelLaunchers:(id)arg1;
- (id)runWithOptionsButton;
- (void)setRunWithOptionsButton:(id)arg1;
- (id)runCommandButton;
- (void)setRunCommandButton:(id)arg1;
- (id)installIntoBottleButton;
- (void)setInstallIntoBottleButton:(id)arg1;
- (id)openCDriveButton;
- (void)setOpenCDriveButton:(id)arg1;
- (id)quitButton;
- (void)setQuitButton:(id)arg1;
- (id)deleteButton;
- (void)setDeleteButton:(id)arg1;
- (id)dependencyButton;
- (void)setDependencyButton:(id)arg1;
- (id)graphicsOptionView;
- (void)setGraphicsOptionView:(id)arg1;
- (id)graphicsLabel;
- (void)setGraphicsLabel:(id)arg1;
- (id)graphicsPopUpButton;
- (void)setGraphicsPopUpButton:(id)arg1;
- (id)autoGraphicsMenuItem;
- (void)setAutoGraphicsMenuItem:(id)arg1;
- (id)dxmtMenuItem;
- (void)setDxmtMenuItem:(id)arg1;
- (id)dxvkMenuItem;
- (void)setDxvkMenuItem:(id)arg1;
- (id)d3dMetalMenuItem;
- (void)setD3dMetalMenuItem:(id)arg1;
- (id)wined3dMenuItem;
- (void)setWined3dMenuItem:(id)arg1;
- (id)vulkanOptionView;
- (void)setVulkanOptionView:(id)arg1;
- (id)vulkanLabel;
- (void)setVulkanLabel:(id)arg1;
- (id)vulkanPopUpButton;
- (void)setVulkanPopUpButton:(id)arg1;
- (id)moltenvkMenuItem;
- (void)setMoltenvkMenuItem:(id)arg1;
- (id)mtlvkMenuItem;
- (void)setMtlvkMenuItem:(id)arg1;
- (id)msyncLabel;
- (void)setMsyncLabel:(id)arg1;
- (id)msyncSwitch;
- (void)setMsyncSwitch:(id)arg1;
- (id)msyncView;
- (void)setMsyncView:(id)arg1;
- (id)dlssLabel;
- (void)setDlssLabel:(id)arg1;
- (id)dlssSwitch;
- (void)setDlssSwitch:(id)arg1;
- (id)dlssView;
- (void)setDlssView:(id)arg1;
- (id)highResolutionLabel;
- (void)setHighResolutionLabel:(id)arg1;
- (id)highResolutionSwitch;
- (void)setHighResolutionSwitch:(id)arg1;
- (id)highResolutionView;
- (void)setHighResolutionView:(id)arg1;
- (id)previewLabel;
- (void)setPreviewLabel:(id)arg1;
- (id)previewSwitch;
- (void)setPreviewSwitch:(id)arg1;
- (id)previewView;
- (void)setPreviewView:(id)arg1;
- (id)controlPanelsSection;
- (void)setControlPanelsSection:(id)arg1;
- (id)controlPanelsLoadingView;
- (void)setControlPanelsLoadingView:(id)arg1;
- (id)controlPanelsLoadingSpinner;
- (void)setControlPanelsLoadingSpinner:(id)arg1;
- (id)installedSoftwareTableView;
- (void)setInstalledSoftwareTableView:(id)arg1;
- (id)installedSoftware;
- (void)setInstalledSoftware:(id)arg1;

@end

#endif /* BottleViewController_h */
