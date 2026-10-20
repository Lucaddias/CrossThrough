// PackageViewController.m — CrossThrough
#import "PackageViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PackageViewController

- (id)init {
    self = [super initWithNibName:@"PackageView" bundle:nil];
    if (self) {
        self->_packages = [[NSMutableArray alloc] init];
        self->_visiblePackages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    // dealloc
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSRect b = [self.view bounds];
    if (self->_packageView) {
        [self->_packageView setFrame:b];
        [self->_packageView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        [self->_packageView setDelegate:self];
    }
    if (self->_installerView) {
        [self->_installerView setFrame:b];
        [self->_installerView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        [self->_installerView setHidden:YES];
        [self->_installerView setDelegate:self];
    }

    NSMutableArray *subviews = [NSMutableArray array];
    if (self->_packageView) [subviews addObject:self->_packageView];
    if (self->_installerView) [subviews addObject:self->_installerView];
    [self.view setSubviews:subviews];

    if (self->_collectionView) {
        [self->_collectionView registerClass:[PackageViewItem class] forItemWithIdentifier:@"PackageViewItem"];
        [self->_collectionView setDataSource:self];
        [self->_collectionView setDelegate:self];
    }

    if (self->_searchField) {
        [self->_searchField setTarget:self];
        [self->_searchField setAction:@selector(search:)];
    }

    if (self->_installUnlistedAppButton) {
        [self->_installUnlistedAppButton setTarget:self];
        [self->_installUnlistedAppButton setAction:@selector(selectUnknownPackage:)];
    }

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"softwarePackage" ascending:YES selector:@selector(localizedStandardCompare:)];
    [self setSortDescriptors:@[sort]];

    if ([self->_packages count] == 0) {
        [self populatePackages];
    }
    [self back];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    if ([self->_packages count] == 0) {
        [self populatePackages];
    }
    if (self->_searchField && [self.view window]) {
        [[self.view window] makeFirstResponder:self->_searchField];
    }
}

- (void)viewDidDisappear {
    [super viewDidDisappear];
    if (self->_installerView && ![self->_installerView isHidden]) {
        [self back];
    }
}

- (id)packageForCategory:(id)arg1 root:(id)arg2 cache:(id)arg3 {
    return nil;
}

- (void)populatePackages {
    NSMutableArray *result = [NSMutableArray array];

    id c4ProfilesClass = [CXSetupLib c4ProfilesClass];
    id profilesSet = nil;
    if (c4ProfilesClass && [c4ProfilesClass respondsToSelector:@selector(profilesSet)]) {
        profilesSet = [c4ProfilesClass profilesSet];
    }

    NSDictionary *dict = nil;
    if (profilesSet && [profilesSet respondsToSelector:@selector(contentsDict)]) {
        dict = [profilesSet contentsDict];
    } else if ([profilesSet isKindOfClass:[NSDictionary class]]) {
        dict = (NSDictionary *)profilesSet;
    }

    if (dict && [dict count] > 0) {
        for (NSString *key in dict) {
            id item = dict[key];
            BOOL isCurrent = YES;
            if ([item respondsToSelector:@selector(valueForKey:)]) {
                id cVal = [item valueForKey:@"is_for_current_product"];
                if (cVal && [cVal respondsToSelector:@selector(boolValue)]) {
                    isCurrent = [cVal boolValue];
                }
            }
            if (isCurrent) {
                PackageTreeNode *node = [[PackageTreeNode alloc] initWithProfile:item];
                if (node) {
                    if ([node isUnknown]) {
                        self->_unknownPackage = node;
                    } else {
                        [result addObject:node];
                    }
                }
            }
        }
    }

    // Default popular applications fallback if dictionary is empty
    if ([result count] == 0) {
        NSArray *popularApps = @[
            @{ @"appid": @"com.blizzard.battlenet", @"name": @"Battle.net Desktop App", @"is_highlighted": @YES, @"is_ranked": @YES, @"app_profile": @{ @"medal_rating": @5 } },
            @{ @"appid": @"com.ea.app", @"name": @"EA App", @"is_highlighted": @YES, @"is_ranked": @YES, @"app_profile": @{ @"medal_rating": @3 } },
            @{ @"appid": @"com.epicgames.launcher", @"name": @"Epic Games Store", @"is_highlighted": @YES, @"is_ranked": @YES, @"app_profile": @{ @"medal_rating": @5 } },
            @{ @"appid": @"com.gog.galaxy", @"name": @"GOG Galaxy", @"is_highlighted": @YES, @"is_ranked": @YES, @"app_profile": @{ @"medal_rating": @3 } },
            @{ @"appid": @"com.quicken.classic", @"name": @"Quicken Classic", @"is_highlighted": @YES, @"is_ranked": @YES, @"app_profile": @{ @"medal_rating": @5 } },
            @{ @"appid": @"com.rockstargames.launcher", @"name": @"Rockstar Games Launcher", @"is_highlighted": @YES, @"is_ranked": @YES, @"app_profile": @{ @"medal_rating": @5 } },
            @{ @"appid": @"com.valvesoftware.steam", @"name": @"Steam", @"is_highlighted": @YES, @"is_ranked": @YES, @"app_profile": @{ @"medal_rating": @4 } },
            @{ @"appid": @"com.ubisoft.connect", @"name": @"Ubisoft Connect", @"is_highlighted": @YES, @"is_ranked": @YES, @"app_profile": @{ @"medal_rating": @3 } }
        ];

        for (NSDictionary *appData in popularApps) {
            PackageTreeNode *node = [[PackageTreeNode alloc] initWithProfile:appData];
            if (node) {
                [result addObject:node];
            }
        }
    }

    [self setPackages:result];
    printf("[PackageViewController] Populated %lu packages\n", (unsigned long)[result count]); fflush(stdout);
    [PackageTreeNode updateIconList];
    [self updateVisiblePackages];
}

- (void)loadIcons {
    NSArray *visible = [NSArray arrayWithArray:self->_visiblePackages];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (PackageTreeNode *node in visible) {
            [node loadIcon];
        }
    });
}

- (void)setInstaller:(id)arg1 {
    self->_installer = arg1;
}

- (void)setSelectedBottle:(id)arg1 {
}

- (void)setSelectedPackage:(id)arg1 {
}

- (void)updateVisiblePackages {
    static NSPredicate *rankedPredicate = nil;
    static NSPredicate *highlightedPredicate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rankedPredicate = [[NSPredicate predicateWithFormat:@"ranked != FALSE"] retain];
        highlightedPredicate = [[NSPredicate predicateWithFormat:@"highlighted != FALSE"] retain];
    });

    NSArray *pkgs = self->_packages;
    BOOL showUntested = [[NSUserDefaults standardUserDefaults] boolForKey:@"ShowUntestedApps"];
    NSPredicate *filter = self->_filterPredicate;

    if (showUntested) {
        if (filter) {
            [self setIsHighlighted:NO];
            pkgs = [pkgs filteredArrayUsingPredicate:filter];
        } else {
            [self setIsHighlighted:YES];
            pkgs = [pkgs filteredArrayUsingPredicate:highlightedPredicate];
        }
    } else {
        if (filter) {
            [self setIsHighlighted:NO];
            NSPredicate *compound = [NSCompoundPredicate andPredicateWithSubpredicates:@[rankedPredicate, filter]];
            pkgs = [pkgs filteredArrayUsingPredicate:compound];
        } else {
            [self setIsHighlighted:YES];
            NSPredicate *compound = [NSCompoundPredicate andPredicateWithSubpredicates:@[rankedPredicate, highlightedPredicate]];
            pkgs = [pkgs filteredArrayUsingPredicate:compound];
        }
    }

    if (self->_sortDescriptors) {
        pkgs = [pkgs sortedArrayUsingDescriptors:self->_sortDescriptors];
    }

    self->_visiblePackages = [pkgs mutableCopy];
    printf("[PackageViewController] updateVisiblePackages: visible count=%lu, isHighlighted=%d\n", 
           (unsigned long)[self->_visiblePackages count], self->_isHighlighted); fflush(stdout);

    if (self->_collectionView) {
        [self->_collectionView reloadData];
    }

    if (self->_noResultsLabel) {
        [self->_noResultsLabel setHidden:([self->_visiblePackages count] > 0)];
    }
    if (self->_loading) {
        [self->_loading setHidden:YES];
    }

    [self loadIcons];
}

- (void)search:(id)sender {
    NSString *query = [[sender stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([query length] > 0) {
        NSMutableString *wildcard = [NSMutableString stringWithString:@"*"];
        NSArray *words = [query componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        for (NSString *w in words) {
            if ([w length] > 0) {
                NSString *esc = [w stringByReplacingOccurrencesOfString:@"*" withString:@"\\*"];
                esc = [esc stringByReplacingOccurrencesOfString:@"?" withString:@"\\?"];
                [wildcard appendString:esc];
                [wildcard appendString:@"*"];
            }
        }
        NSPredicate *tmpl = [NSPredicate predicateWithFormat:@"softwarePackage LIKE[cd] $SEARCH"];
        NSPredicate *pred = [tmpl predicateWithSubstitutionVariables:@{@"SEARCH": wildcard}];
        [self setFilterPredicate:pred];
    } else {
        [self setFilterPredicate:nil];
    }
    if (self->_collectionView) {
        [self->_collectionView reloadData];
        [self->_collectionView scrollPoint:NSZeroPoint];
    }
}

- (void)back:(id)sender {
    if (self->_packageView) [self->_packageView setHidden:NO];
    if (self->_installerView) [self->_installerView setHidden:YES];
    [self setPackageViewTitle:[[NSBundle mainBundle] localizedStringForKey:@"Install a Windows Application" value:@"Install a Windows Application" table:nil]];
    if (self->_collectionView) [self->_collectionView deselectAll:nil];
    if (self->_searchField && [self.view window]) {
        [[self.view window] makeFirstResponder:self->_searchField];
    }
    [self setInstaller:nil];
}

- (void)back {
    [self back:nil];
}

- (void)setSortDescriptors:(id)arg1 {
    self->_sortDescriptors = [arg1 copy];
}

- (void)setFilterPredicate:(id)arg1 {
    if (self->_filterPredicate != arg1) {
        [self->_filterPredicate release];
        self->_filterPredicate = [arg1 retain];
        [self updateVisiblePackages];
    }
}

- (void)updateSummaryDetails {
}

- (void)openInstallerView {
    if (self->_packageView) [self->_packageView setHidden:YES];
    if (self->_installerView) [self->_installerView setHidden:NO];
}

- (void)optionsButtonClicked:(id)arg1 {
}

- (void)autoPlay:(id)arg1 {
}

- (void)autoPlayWithParsedFile:(id)arg1 {
}

- (void)autoPlayWithAutorunFile:(id)arg1 {
}

- (void)prepareDropinC4pAndAutorun:(id)arg1 {
}

- (void)displayLoadingSheetAndPrepareCrossTie:(id)arg1 {
}

- (void)displayEmptyFileAlert:(id)arg1 {
}

- (void)displayRevokedFileAlert:(id)arg1 {
}

- (NSInteger)numberOfSectionsInCollectionView:(id)arg1 {
    return 1;
}

- (NSInteger)collectionView:(id)arg1 numberOfItemsInSection:(NSInteger)arg2 {
    return [self->_visiblePackages count];
}

- (id)collectionView:(id)arg1 itemForRepresentedObjectAtIndexPath:(id)arg2 {
    PackageViewItem *item = [arg1 makeItemWithIdentifier:@"PackageViewItem" forIndexPath:arg2];
    NSIndexPath *ip = (NSIndexPath *)arg2;
    if (ip.item < (NSInteger)[self->_visiblePackages count]) {
        [item setRepresentedObject:self->_visiblePackages[ip.item]];
    }
    return item;
}

- (void)collectionView:(id)arg1 willDisplayItem:(id)arg2 forRepresentedObjectAtIndexPath:(id)arg3 {
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
}


- (void)install:(id)arg1 {
    [self openInstallerView];
}

- (void)selectUnknownPackage:(id)arg1 {
    [self openInstallerView];
}

- (void)editInstallerSource:(id)arg1 {
}

- (void)selectSteamInstall:(id)arg1 {
}

- (void)selectInstallerDownload:(id)arg1 {
}

- (void)selectInstaller:(id)arg1 {
}

- (void)selectBottle:(id)arg1 {
}

- (void)c4pButton:(id)arg1 {
}

- (void)downloadButton:(id)arg1 {
}

- (void)installOptions:(id)arg1 {
}

- (void)installationCompleted {
}

- (void)installationStarted {
}

- (id)window {
    return [self.view window];
}

- (BOOL)performDragOperation:(id)arg1 {
    return YES;
}

- (BOOL)textFieldIsTruncated:(id)arg1 {
    return NO;
}

- (void)startObservingFrameOfView:(id)arg1 {
}

- (void)stopObservingFrameOfView:(id)arg1 {
}

- (void)subviewFrameChanged:(id)arg1 {
}

- (void)updatePackageDescriptionTruncation {
}

- (void)updateInstallationNotesTruncation {
}

- (void)expandPackageDescription:(BOOL)arg1 {
}

- (void)expandInstallationNotes:(BOOL)arg1 {
}

- (void)packageDescriptionExpandButtonClicked:(id)arg1 {
}

- (void)installationNotesExpandButtonClicked:(id)arg1 {
}

- (id)delegate {
    return objc_loadWeakRetained((id *)&self->_delegate);
}

- (void)setDelegate:(id)arg1 {
    objc_storeWeak((id *)&self->_delegate, arg1);
}

- (id)packages {
    return self->_packages;
}

- (void)setPackages:(id)arg1 {
    self->_packages = [arg1 mutableCopy];
}

- (id)unknownPackage {
    return self->_unknownPackage;
}

- (void)setUnknownPackage:(id)arg1 {
    self->_unknownPackage = arg1;
}

- (id)sortDescriptors {
    return self->_sortDescriptors;
}

- (id)filterPredicate {
    return self->_filterPredicate;
}

- (BOOL)isHighlighted {
    return self->_isHighlighted;
}

- (void)setIsHighlighted:(BOOL)arg1 {
    [self willChangeValueForKey:@"isHighlighted"];
    self->_isHighlighted = arg1;
    [self didChangeValueForKey:@"isHighlighted"];
}

- (id)visiblePackages {
    return self->_visiblePackages;
}

- (void)setVisiblePackages:(id)arg1 {
    self->_visiblePackages = [arg1 mutableCopy];
}

- (id)summaryDetailsControllers {
    return self->_summaryDetailsControllers;
}

- (void)setSummaryDetailsControllers:(id)arg1 {
    self->_summaryDetailsControllers = [arg1 copy];
}

- (id)installer {
    return self->_installer;
}

- (id)packageView {
    return objc_loadWeakRetained((id *)&self->_packageView);
}

- (void)setPackageView:(id)arg1 {
    objc_storeWeak((id *)&self->_packageView, arg1);
}

- (id)collectionView {
    return objc_loadWeakRetained((id *)&self->_collectionView);
}

- (void)setCollectionView:(id)arg1 {
    objc_storeWeak((id *)&self->_collectionView, arg1);
}

- (id)loading {
    return objc_loadWeakRetained((id *)&self->_loading);
}

- (void)setLoading:(id)arg1 {
    objc_storeWeak((id *)&self->_loading, arg1);
}

- (id)noResultsLabel {
    return objc_loadWeakRetained((id *)&self->_noResultsLabel);
}

- (void)setNoResultsLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_noResultsLabel, arg1);
}

- (id)searchField {
    return objc_loadWeakRetained((id *)&self->_searchField);
}

- (void)setSearchField:(id)arg1 {
    objc_storeWeak((id *)&self->_searchField, arg1);
}

- (id)installUnlistedAppButton {
    return objc_loadWeakRetained((id *)&self->_installUnlistedAppButton);
}

- (void)setInstallUnlistedAppButton:(id)arg1 {
    objc_storeWeak((id *)&self->_installUnlistedAppButton, arg1);
}

- (id)packageViewTitle {
    return self->_packageViewTitle;
}

- (void)setPackageViewTitle:(id)arg1 {
    [self willChangeValueForKey:@"packageViewTitle"];
    if (self->_packageViewTitle != arg1) {
        [self->_packageViewTitle release];
        self->_packageViewTitle = [arg1 copy];
    }
    [self didChangeValueForKey:@"packageViewTitle"];
}

- (id)installerView {
    return objc_loadWeakRetained((id *)&self->_installerView);
}

- (void)setInstallerView:(id)arg1 {
    objc_storeWeak((id *)&self->_installerView, arg1);
}

- (id)installButton {
    return objc_loadWeakRetained((id *)&self->_installButton);
}

- (void)setInstallButton:(id)arg1 {
    objc_storeWeak((id *)&self->_installButton, arg1);
}

- (id)optionsButton {
    return objc_loadWeakRetained((id *)&self->_optionsButton);
}

- (void)setOptionsButton:(id)arg1 {
    objc_storeWeak((id *)&self->_optionsButton, arg1);
}

- (id)optionsMenu {
    return self->_optionsMenu;
}

- (void)setOptionsMenu:(id)arg1 {
    self->_optionsMenu = arg1;
}

- (id)installerSourceMenu {
    return self->_installerSourceMenu;
}

- (void)setInstallerSourceMenu:(id)arg1 {
    self->_installerSourceMenu = arg1;
}

- (id)installWithSteamMenuItem {
    return self->_installWithSteamMenuItem;
}

- (void)setInstallWithSteamMenuItem:(id)arg1 {
    self->_installWithSteamMenuItem = arg1;
}

- (id)downloadInstallerMenuItem {
    return self->_downloadInstallerMenuItem;
}

- (void)setDownloadInstallerMenuItem:(id)arg1 {
    self->_downloadInstallerMenuItem = arg1;
}

- (id)summaryDetailsView {
    return objc_loadWeakRetained((id *)&self->_summaryDetailsView);
}

- (void)setSummaryDetailsView:(id)arg1 {
    objc_storeWeak((id *)&self->_summaryDetailsView, arg1);
}

- (id)packageDescriptionTextField {
    return objc_loadWeakRetained((id *)&self->_packageDescriptionTextField);
}

- (void)setPackageDescriptionTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_packageDescriptionTextField, arg1);
}

- (id)packageDescriptionExpandButton {
    return objc_loadWeakRetained((id *)&self->_packageDescriptionExpandButton);
}

- (void)setPackageDescriptionExpandButton:(id)arg1 {
    objc_storeWeak((id *)&self->_packageDescriptionExpandButton, arg1);
}

- (id)packageDescriptionMoreLabel {
    return objc_loadWeakRetained((id *)&self->_packageDescriptionMoreLabel);
}

- (void)setPackageDescriptionMoreLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_packageDescriptionMoreLabel, arg1);
}

- (id)installationNotesTextField {
    return objc_loadWeakRetained((id *)&self->_installationNotesTextField);
}

- (void)setInstallationNotesTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_installationNotesTextField, arg1);
}

- (id)installationNotesMoreLabel {
    return objc_loadWeakRetained((id *)&self->_installationNotesMoreLabel);
}

- (void)setInstallationNotesMoreLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_installationNotesMoreLabel, arg1);
}

- (id)installationNotesExpandButton {
    return objc_loadWeakRetained((id *)&self->_installationNotesExpandButton);
}

- (void)setInstallationNotesExpandButton:(id)arg1 {
    objc_storeWeak((id *)&self->_installationNotesExpandButton, arg1);
}

- (id)packageDescriptionCollapsedHeightConstraint {
    return objc_loadWeakRetained((id *)&self->_packageDescriptionCollapsedHeightConstraint);
}

- (void)setPackageDescriptionCollapsedHeightConstraint:(id)arg1 {
    objc_storeWeak((id *)&self->_packageDescriptionCollapsedHeightConstraint, arg1);
}

- (id)installationNotesCollapsedHeightConstraint {
    return objc_loadWeakRetained((id *)&self->_installationNotesCollapsedHeightConstraint);
}

- (void)setInstallationNotesCollapsedHeightConstraint:(id)arg1 {
    objc_storeWeak((id *)&self->_installationNotesCollapsedHeightConstraint, arg1);
}

@end
