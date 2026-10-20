// PackageViewController.h — CrossThrough
#ifndef PackageViewController_h
#define PackageViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class PackageViewController;
@class PackageTreeNode;
@class PackageInstaller;
@class CXDragView;
@class CXDragView;
@class CXFlatButton;

@interface PackageViewController : CXViewController <NSCollectionViewDelegate, NSObject, NSCollectionViewDataSource, CXDragViewDelegate, PackageInstallerDelegate>
{
    BOOL _isHighlighted;
    id<PackageViewDelegate> _delegate;
    NSArray * _packages;
    PackageTreeNode * _unknownPackage;
    NSArray * _sortDescriptors;
    NSPredicate * _filterPredicate;
    NSArray * _visiblePackages;
    NSArray * _summaryDetailsControllers;
    PackageInstaller * _installer;
    CXDragView * _packageView;
    NSCollectionView * _collectionView;
    NSTextField * _loading;
    NSTextField * _noResultsLabel;
    NSSearchField * _searchField;
    NSButton * _installUnlistedAppButton;
    NSString * _packageViewTitle;
    CXDragView * _installerView;
    CXFlatButton * _installButton;
    NSButton * _optionsButton;
    NSMenu * _optionsMenu;
    NSMenu * _installerSourceMenu;
    NSMenuItem * _installWithSteamMenuItem;
    NSMenuItem * _downloadInstallerMenuItem;
    NSStackView * _summaryDetailsView;
    NSTextField * _packageDescriptionTextField;
    NSButton * _packageDescriptionExpandButton;
    NSView * _packageDescriptionMoreLabel;
    NSTextField * _installationNotesTextField;
    NSView * _installationNotesMoreLabel;
    NSButton * _installationNotesExpandButton;
    NSLayoutConstraint * _packageDescriptionCollapsedHeightConstraint;
    NSLayoutConstraint * _installationNotesCollapsedHeightConstraint;
}

// Instance Methods
- (id)init;
- (void)dealloc;
- (void)viewDidLoad;
- (void)viewDidAppear;
- (void)viewDidDisappear;
- (id)packageForCategory:(id)arg1 root:(id)arg2 cache:(id)arg3;
- (void)populatePackages;
- (void)loadIcons;
- (void)setInstaller:(id)arg1;
- (void)setSelectedBottle:(id)arg1;
- (void)setSelectedPackage:(id)arg1;
- (void)updateVisiblePackages;
- (void)setSortDescriptors:(id)arg1;
- (void)setFilterPredicate:(id)arg1;
- (void)updateSummaryDetails;
- (void)openInstallerView;
- (void)optionsButtonClicked:(id)arg1;
- (void)autoPlay:(id)arg1;
- (void)autoPlayWithParsedFile:(id)arg1;
- (void)autoPlayWithAutorunFile:(id)arg1;
- (void)prepareDropinC4pAndAutorun:(id)arg1;
- (void)displayLoadingSheetAndPrepareCrossTie:(id)arg1;
- (void)displayEmptyFileAlert:(id)arg1;
- (void)displayRevokedFileAlert:(id)arg1;
- (NSInteger)numberOfSectionsInCollectionView:(id)arg1;
- (NSInteger)collectionView:(id)arg1 numberOfItemsInSection:(NSInteger)arg2;
- (id)collectionView:(id)arg1 itemForRepresentedObjectAtIndexPath:(id)arg2;
- (void)collectionView:(id)arg1 willDisplayItem:(id)arg2 forRepresentedObjectAtIndexPath:(id)arg3;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)back:(id)arg1;
- (void)back;
- (void)search:(id)arg1;
- (void)install:(id)arg1;
- (void)selectUnknownPackage:(id)arg1;
- (void)editInstallerSource:(id)arg1;
- (void)selectSteamInstall:(id)arg1;
- (void)selectInstallerDownload:(id)arg1;
- (void)selectInstaller:(id)arg1;
- (void)selectBottle:(id)arg1;
- (void)c4pButton:(id)arg1;
- (void)downloadButton:(id)arg1;
- (void)installOptions:(id)arg1;
- (void)installationCompleted;
- (void)installationStarted;
- (id)window;
- (BOOL)performDragOperation:(id)arg1;
- (BOOL)textFieldIsTruncated:(id)arg1;
- (void)startObservingFrameOfView:(id)arg1;
- (void)stopObservingFrameOfView:(id)arg1;
- (void)subviewFrameChanged:(id)arg1;
- (void)updatePackageDescriptionTruncation;
- (void)updateInstallationNotesTruncation;
- (void)expandPackageDescription:(BOOL)arg1;
- (void)expandInstallationNotes:(BOOL)arg1;
- (void)packageDescriptionExpandButtonClicked:(id)arg1;
- (void)installationNotesExpandButtonClicked:(id)arg1;
- (id)delegate;
- (void)setDelegate:(id)arg1;
- (id)packages;
- (void)setPackages:(id)arg1;
- (id)unknownPackage;
- (void)setUnknownPackage:(id)arg1;
- (id)sortDescriptors;
- (id)filterPredicate;
- (BOOL)isHighlighted;
- (void)setIsHighlighted:(BOOL)arg1;
- (id)visiblePackages;
- (void)setVisiblePackages:(id)arg1;
- (id)summaryDetailsControllers;
- (void)setSummaryDetailsControllers:(id)arg1;
- (PackageInstaller *)installer;
- (id)packageView;
- (void)setPackageView:(id)arg1;
- (id)collectionView;
- (void)setCollectionView:(id)arg1;
- (id)loading;
- (void)setLoading:(id)arg1;
- (id)noResultsLabel;
- (void)setNoResultsLabel:(id)arg1;
- (id)searchField;
- (void)setSearchField:(id)arg1;
- (id)installUnlistedAppButton;
- (void)setInstallUnlistedAppButton:(id)arg1;
- (id)packageViewTitle;
- (void)setPackageViewTitle:(id)arg1;
- (id)installerView;
- (void)setInstallerView:(id)arg1;
- (id)installButton;
- (void)setInstallButton:(id)arg1;
- (id)optionsButton;
- (void)setOptionsButton:(id)arg1;
- (id)optionsMenu;
- (void)setOptionsMenu:(id)arg1;
- (id)installerSourceMenu;
- (void)setInstallerSourceMenu:(id)arg1;
- (id)installWithSteamMenuItem;
- (void)setInstallWithSteamMenuItem:(id)arg1;
- (id)downloadInstallerMenuItem;
- (void)setDownloadInstallerMenuItem:(id)arg1;
- (id)summaryDetailsView;
- (void)setSummaryDetailsView:(id)arg1;
- (id)packageDescriptionTextField;
- (void)setPackageDescriptionTextField:(id)arg1;
- (id)packageDescriptionExpandButton;
- (void)setPackageDescriptionExpandButton:(id)arg1;
- (id)packageDescriptionMoreLabel;
- (void)setPackageDescriptionMoreLabel:(id)arg1;
- (id)installationNotesTextField;
- (void)setInstallationNotesTextField:(id)arg1;
- (id)installationNotesMoreLabel;
- (void)setInstallationNotesMoreLabel:(id)arg1;
- (id)installationNotesExpandButton;
- (void)setInstallationNotesExpandButton:(id)arg1;
- (id)packageDescriptionCollapsedHeightConstraint;
- (void)setPackageDescriptionCollapsedHeightConstraint:(id)arg1;
- (id)installationNotesCollapsedHeightConstraint;
- (void)setInstallationNotesCollapsedHeightConstraint:(id)arg1;

@end

#endif /* PackageViewController_h */
