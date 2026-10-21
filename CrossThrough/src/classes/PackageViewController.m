// PackageViewController.m — CrossThrough
#import "PackageViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "PackageTreeNode.h"
#import "PackageViewItem.h"
#import "PackageInstaller.h"
#import "InstallConfiguration.h"
#import "SummaryDetail.h"
#import "InstallSummaryDetailViewController.h"
#import "SelectBottleSheetController.h"
#import "InstallOptionsSheetController.h"
#import "LoadingCrossTieSheetController.h"
#import "NSAttributedString+CrossOverAdditions.h"
#import "CDTools.h"

@implementation PackageViewController

- (id)init {
    return [super initWithNibName:@"PackageView" bundle:nil];
}

- (void)dealloc {
    if (self->_collectionView) {
        [self->_collectionView removeObserver:self forKeyPath:@"selectionIndexPaths"];
    }
    if (self->_installer) {
        [self->_installer removeObserver:self forKeyPath:@"summaryDetails"];
    }
    if (self->_installerView) {
        [self->_installerView setDelegate:nil];
    }
    if (self->_packageView) {
        [self->_packageView setDelegate:nil];
    }
    if (self->_packageDescriptionTextField) {
        [self stopObservingFrameOfView:self->_packageDescriptionTextField];
    }
    if (self->_installationNotesTextField) {
        [self stopObservingFrameOfView:self->_installationNotesTextField];
    }
    [[NSUserDefaultsController sharedUserDefaultsController] removeObserver:self forKeyPath:@"values.ShowUntestedApps" context:NULL];

    [self->_packages release];
    [self->_visiblePackages release];
    [self->_sortDescriptors release];
    [self->_filterPredicate release];
    [self->_packageViewTitle release];
    [self->_installer release];
    [self->_summaryDetailsControllers release];
    [self->_unknownPackage release];
    [self->_optionsMenu release];
    [self->_installerSourceMenu release];
    [self->_installWithSteamMenuItem release];
    [self->_downloadInstallerMenuItem release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self packageView] setFrame:[[self view] bounds]];
    [(NSView *)[self packageView] setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [[self packageView] registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
    [[self packageView] setDelegate:self];

    [[self installerView] setFrame:[[self view] bounds]];
    [(NSView *)[self installerView] setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [[self installerView] setHidden:YES];
    [[self installerView] registerForDraggedTypes:@[NSPasteboardTypeFileURL]];
    [[self installerView] setDelegate:self];

    NSMutableArray *subviews = [NSMutableArray arrayWithCapacity:2];
    if ([self packageView]) [subviews addObject:[self packageView]];
    if ([self installerView]) [subviews addObject:[self installerView]];
    [[self view] setSubviews:subviews];

    [[self collectionView] registerClass:[PackageViewItem class] forItemWithIdentifier:@"PackageViewItem"];
    [[self collectionView] addObserver:self forKeyPath:@"selectionIndexPaths" options:0 context:NULL];
    NSCollectionViewGridLayout *layout = (NSCollectionViewGridLayout *)[[self collectionView] collectionViewLayout];
    [layout setMinimumInteritemSpacing:40.0];
    [layout setMinimumLineSpacing:20.0];
    [layout setMargins:NSEdgeInsetsMake(20.0, 40.0, 20.0, 40.0)];

    [[self installButton] setBezelColor:[NSColor controlAccentColor]];
    [[self optionsButton] sendActionOn:NSEventMaskLeftMouseDown];
    [[self installUnlistedAppButton] setContentTintColor:[NSColor linkColor]];
    [self startObservingFrameOfView:[self packageDescriptionTextField]];
    [self startObservingFrameOfView:[self installationNotesTextField]];

    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"softwarePackage" ascending:YES selector:@selector(localizedStandardCompare:)];
    [self setSortDescriptors:@[sort]];
    [[NSUserDefaultsController sharedUserDefaultsController] addObserver:self forKeyPath:@"values.ShowUntestedApps" options:0 context:NULL];
    if (![self packages]) {
        [self populatePackages];
    }
    [self back];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    [[self window] makeFirstResponder:[self searchField]];
}

- (void)viewDidDisappear {
    [super viewDidDisappear];
    if ([[self installerView] isHidden]) {
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
    [self updateVisiblePackages];

    // CrossOver fetches the icon list off the main thread, then loads icons.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // fetch_icon_list only guards the download: a reply that is not JSON
        // (codeweavers.com serving its "Offline!" page) raises from json.loads,
        // and CrossOver 26.3 has no handler around this call. Carry on without
        // the icon list rather than let the exception end the app.
        @try {
            [PackageTreeNode updateIconList];
        } @catch (NSException *exception) {
            NSLog(@"Could not fetch the icon list: %@", [exception reason]);
        }
        [self loadIcons];
    });
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
    if (self->_installer != arg1) {
        if (self->_installer) {
            [self->_installer removeObserver:self forKeyPath:@"summaryDetails"];
        }
        [self->_installer release];
        self->_installer = [arg1 retain];
        if (self->_installer) {
            [self->_installer addObserver:self forKeyPath:@"summaryDetails" options:0 context:NULL];
            [self->_installer setDelegate:self];
            [self updateSummaryDetails];
            [self expandPackageDescription:NO];
            [self expandInstallationNotes:NO];
        }
    }
}

- (void)setSelectedBottle:(id)arg1 {
    if (arg1) {
        if (!self->_installer) {
            PackageInstaller *installer = [[PackageInstaller alloc] initWithPackage:nil];
            [self setInstaller:installer];
            [installer release];
        }
        [self->_installer setSelectedBottle:arg1];
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *fmt = [bundle localizedStringForKey:@"Install a Windows Application into %@" value:@"" table:nil];
        NSString *bottleName = [arg1 respondsToSelector:@selector(name)] ? [arg1 name] : @"";
        [self setPackageViewTitle:[NSString stringWithFormat:fmt, bottleName]];
    }
}

- (void)setSelectedPackage:(id)arg1 {
    if (!arg1) return;
    if (self->_installer) {
        [self->_installer setSelectedPackage:arg1];
    } else {
        PackageInstaller *installer = [[PackageInstaller alloc] initWithPackage:arg1];
        [self setInstaller:installer];
        [installer release];
    }
    [self openInstallerView];
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

    [self setVisiblePackages:[pkgs subarrayWithRange:NSMakeRange(0, MIN([pkgs count], (NSUInteger)128))]];

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
    [[self packageView] setHidden:NO];
    [[self installerView] setHidden:YES];
    [self setPackageViewTitle:[[NSBundle mainBundle] localizedStringForKey:@"Install a Windows Application" value:@"" table:nil]];
    [[self collectionView] deselectAll:nil];
    [[self window] makeFirstResponder:[self searchField]];
    [self setInstaller:nil];
}

- (void)back {
    [self back:nil];
}

- (void)setSortDescriptors:(id)arg1 {
    if (self->_sortDescriptors != arg1) {
        [self->_sortDescriptors release];
        self->_sortDescriptors = [arg1 retain];
    }
    [self updateVisiblePackages];
}

- (void)setFilterPredicate:(id)arg1 {
    if (self->_filterPredicate != arg1) {
        [self->_filterPredicate release];
        self->_filterPredicate = [arg1 retain];
        [self updateVisiblePackages];
    }
}

- (void)updateSummaryDetails {
    if (self->_installButton) {
        [self->_installButton setEnabled:YES];
    }

    InstallConfiguration *config = [self->_installer installConfiguration];
    NSString *steamID = [config steamID];
    NSString *downloadURL = [config downloadURL];
    NSArray *details = [[self->_installer summaryDetails] copy];

    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    BOOL hasSteamOrDownload = (steamID != nil || downloadURL != nil);

    for (SummaryDetail *sd in details) {
        InstallSummaryDetailViewController *vc = [[InstallSummaryDetailViewController alloc] init];
        
        NSAttributedString *as = [NSAttributedString cx_attributedStringWithHTML:[sd label]];
        [vc setText:as];
        [vc setImage:[sd image]];
        [vc setAction:[sd action]];
        [vc setDelegate:self];

        if ([sd action] != @selector(editInstallerSource:)) {
            // Default
        } else if (!hasSteamOrDownload) {
            [vc setSendsActionOnMouseDown:YES];
        }

        [vc setButtonEnabled:([self->_installer status] == 0)];
        [controllers addObject:vc];

        if ([sd type] == 0) {
            if (self->_installButton) {
                [self->_installButton setEnabled:NO];
            }
        }

        [vc release];
    }
    [details release];

    if (self->_summaryDetailsControllers) {
        for (InstallSummaryDetailViewController *oldVC in self->_summaryDetailsControllers) {
            [[oldVC view] removeFromSuperview];
        }
    }

    [self setSummaryDetailsControllers:controllers];

    if (self->_summaryDetailsView) {
        for (InstallSummaryDetailViewController *newVC in controllers) {
            [self->_summaryDetailsView addArrangedSubview:[newVC view]];
        }
    }
    [controllers release];

    if (self->_installWithSteamMenuItem) {
        [self->_installWithSteamMenuItem setHidden:(steamID == nil)];
        [self->_installWithSteamMenuItem setState:[config installWithSteam]];
    }

    if (self->_downloadInstallerMenuItem) {
        [self->_downloadInstallerMenuItem setHidden:(downloadURL == nil)];
        [self->_downloadInstallerMenuItem setState:([config installerDownloadSource] != nil)];
    }
}

- (void)openInstallerView {
    if ([[self installer] status] == 1) {
        [self installationStarted];
    }
    if ([[self installer] status] == 2) {
        [self installationCompleted];
    }
    [[self installer] setDelegate:self];
    if (self->_packageView) [self->_packageView setHidden:YES];
    if (self->_installerView) [self->_installerView setHidden:NO];
    if (self->_installButton) [self->_installButton setHidden:NO];
}

- (void)optionsButtonClicked:(id)sender {
    NSPoint point = NSMakePoint(0, NSHeight([sender bounds]));
    [self.optionsMenu popUpMenuPositioningItem:nil atLocation:point inView:sender];
}

- (void)autoPlay:(id)arg1 {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self autoPlay:arg1];
        });
        return;
    }

    PackageInstaller *inst = [self installer];
    if (!inst) {
        inst = [[[PackageInstaller alloc] initWithPackage:nil] autorelease];
    }

    Class c4Profiles = [CXSetupLib c4ProfilesClass];
    id matching = [c4Profiles getMatchingProfiles:arg1];
    if ([matching count] == 1) {
        for (id key in matching) {
            id prof = matching[key];
            PackageTreeNode *node = [[[PackageTreeNode alloc] initWithProfile:prof] autorelease];
            [inst setSelectedPackage:node];
        }
    }

    [inst setInstallerSource:arg1];
    if (self->_unknownPackage) {
        [inst setUnknownPackage:self->_unknownPackage];
    }
    [self setInstaller:inst];
    [self openInstallerView];
}

- (void)autoPlayWithParsedFile:(id)arg1 {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self autoPlayWithParsedFile:arg1];
        });
        return;
    }

    PackageInstaller *inst = [self installer];
    if (!inst) {
        inst = [[[PackageInstaller alloc] initWithPackage:nil] autorelease];
    }

    [inst autoPlayWithParsedAutorunFile:arg1];
    if (self->_unknownPackage) {
        [inst setUnknownPackage:self->_unknownPackage];
    }
    [self setInstaller:inst];
    [self openInstallerView];
}

- (void)autoPlayWithAutorunFile:(id)arg1 {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self autoPlayWithAutorunFile:arg1];
        });
        return;
    }

    Class c4Profiles = [CXSetupLib c4ProfilesClass];
    id taste = [c4Profiles tasteC4PFile:arg1];
    if ([taste boolValue]) {
        [[self window] makeKeyAndOrderFront:self];
        [self displayLoadingSheetAndPrepareCrossTie:arg1];
    } else {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *infoFmt = [bundle localizedStringForKey:@"The CrossTie file '%@' is not from a trusted source!\n\nThis means that CodeWeavers has no knowledge or control over what actions profiles from this file may attempt. Be VERY cautious loading untrusted CrossTies as they can cause great damage to your computer." value:@"" table:nil];
        NSString *fileName = [[NSFileManager defaultManager] displayNameAtPath:arg1];

        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:[bundle localizedStringForKey:@"Load untrusted CrossTie file?" value:@"" table:nil]];
        [alert setInformativeText:[NSString stringWithFormat:infoFmt, fileName]];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"Don't Load" value:@"" table:nil]];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"Load" value:@"" table:nil]];

        [[self window] makeKeyAndOrderFront:self];
        [alert beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSAlertSecondButtonReturn) {
                [self displayLoadingSheetAndPrepareCrossTie:arg1];
            }
        }];
    }
}

- (void)prepareDropinC4pAndAutorun:(id)arg1 {
    Class c4Profiles = [CXSetupLib c4ProfilesClass];
    id res = [c4Profiles prepareSingleUseC4PFile:arg1];
    if ([res count] == 2) {
        id file0 = [res objectAtIndex:0];
        id sig1 = [res objectAtIndex:1];
        if (file0 && ![file0 isKindOfClass:[NSNull class]]) {
            id dropped = [c4Profiles dropinC4PFile:file0 withSig:sig1];
            [[NSFileManager defaultManager] removeItemAtPath:file0 error:nil];
            if (sig1 && ![sig1 isKindOfClass:[NSNull class]]) {
                [[NSFileManager defaultManager] removeItemAtPath:sig1 error:nil];
            }

            if ([dropped valueForKey:@"malware_appid"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self displayRevokedFileAlert:dropped];
                });
            } else if ([[dropped valueForKey:@"useful_for_current_product"] boolValue]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self populatePackages];
                    [self autoPlayWithParsedFile:dropped];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self displayEmptyFileAlert:arg1];
                });
            }
        }
    }
}

- (void)displayLoadingSheetAndPrepareCrossTie:(id)arg1 {
    LoadingCrossTieSheetController *sheet = [[[LoadingCrossTieSheetController alloc] init] autorelease];
    NSString *dName = [[NSFileManager defaultManager] displayNameAtPath:arg1];
    [sheet setCrossTieDisplayName:dName];
    [[self window] beginSheet:[sheet window] completionHandler:^(NSModalResponse returnCode) {
    }];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self prepareDropinC4pAndAutorun:arg1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self window] endSheet:[sheet window]];
            [[sheet window] orderOut:nil];
        });
    });
}

- (void)displayEmptyFileAlert:(id)arg1 {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayEmptyFileAlert:arg1];
        });
        return;
    }

    NSBundle *bundle = [NSBundle mainBundle];
    NSString *fmt = [bundle localizedStringForKey:@"The CrossTie file '%@' does not contain installation profiles for anything that can be installed with this product." value:@"" table:nil];
    NSString *fileName = [[NSFileManager defaultManager] displayNameAtPath:arg1];

    NSAlert *alert = [[[NSAlert alloc] init] autorelease];
    [alert setMessageText:[bundle localizedStringForKey:@"Invalid File" value:@"" table:nil]];
    [alert setInformativeText:[NSString stringWithFormat:fmt, fileName]];
    [alert beginSheetModalForWindow:[self window] completionHandler:nil];
}

- (void)displayRevokedFileAlert:(id)arg1 {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayRevokedFileAlert:arg1];
        });
        return;
    }

    NSBundle *bundle = [NSBundle mainBundle];
    NSAlert *alert = [[[NSAlert alloc] init] autorelease];
    [alert setMessageText:[bundle localizedStringForKey:@"Malware Detected" value:@"" table:nil]];
    [alert setInformativeText:[bundle localizedStringForKey:@"This file cannot be used because it would install malicious software or otherwise harm your computer." value:@"" table:nil]];
    [alert addButtonWithTitle:[bundle localizedStringForKey:@"OK" value:@"" table:nil]];
    [alert addButtonWithTitle:[bundle localizedStringForKey:@"More Info" value:@"" table:nil]];
    [alert beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertSecondButtonReturn) {
            NSString *urlStr = [arg1 valueForKey:@"malware_url"];
            if (urlStr) {
                [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:urlStr]];
            }
        }
    }];
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
    NSCollectionView *cv = (NSCollectionView *)arg1;
    PackageViewItem *pvi = (PackageViewItem *)arg2;
    NSIndexPath *ip = (NSIndexPath *)arg3;

    NSInteger total = [cv numberOfItemsInSection:0];
    BOOL hideDivider = NO;
    if (total <= 1) {
        hideDivider = YES;
    } else if (ip.item >= total - 10) {
        NSIndexPath *lastPath = [NSIndexPath indexPathForItem:total - 1 inSection:0];
        NSCollectionViewLayoutAttributes *lastAttr = [cv layoutAttributesForItemAtIndexPath:lastPath];
        NSCollectionViewLayoutAttributes *itemAttr = [cv layoutAttributesForItemAtIndexPath:ip];
        if (lastAttr && itemAttr && CGRectGetMaxY([itemAttr frame]) == CGRectGetMaxY([lastAttr frame])) {
            hideDivider = YES;
        }
    }
    [[pvi dividerLine] setHidden:hideDivider];
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    if ([arg1 isEqualToString:@"selectionIndexPaths"]) {
        NSSet *selectedPaths = [self.collectionView selectionIndexPaths];
        if ([selectedPaths count] == 1) {
            NSIndexPath *indexPath = [selectedPaths anyObject];
            if (indexPath.item < (NSInteger)[self.visiblePackages count]) {
                PackageTreeNode *node = self.visiblePackages[indexPath.item];
                [self setSelectedPackage:node];
            }
        }
    } else if ([arg1 isEqualToString:@"summaryDetails"]) {
        [self updateSummaryDetails];
    } else if ([arg1 isEqualToString:@"values.ShowUntestedApps"]) {
        [self updateVisiblePackages];
        if (self->_collectionView) {
            [self->_collectionView reloadData];
        }
    } else {
        [super observeValueForKeyPath:arg1 ofObject:arg2 change:arg3 context:arg4];
    }
}

- (void)install:(id)arg1 {
    if ([[self installer] status] == 1) {
        [[self installer] cancel];
    } else {
        [[self installer] install];
    }
}

- (void)selectUnknownPackage:(id)arg1 {
    [self setSelectedPackage:[self unknownPackage]];
    [[[self installer] installConfiguration] setNewBottleName:@""];
}

- (void)editInstallerSource:(id)arg1 {
    InstallConfiguration *config = [[self installer] installConfiguration];
    if ([config steamID] != nil || [config downloadURL] != nil) {
        NSPoint point = NSMakePoint(0, NSHeight([arg1 bounds]));
        [[self installerSourceMenu] popUpMenuPositioningItem:nil atLocation:point inView:arg1];
    } else {
        [self selectInstaller:arg1];
    }
}

- (void)selectSteamInstall:(id)arg1 {
    [[[self installer] installConfiguration] setInstallerSteam];
}

- (void)selectInstallerDownload:(id)arg1 {
    [[[self installer] installConfiguration] setInstallerDownload];
}

- (void)selectInstaller:(id)arg1 {
    [[self installer] selectInstaller:arg1];
}

- (void)selectBottle:(id)arg1 {
    [[self installer] selectBottleWithCompletion:nil];
}

- (void)c4pButton:(id)arg1 {
    NSString *url = [[[self installer] package] c4pPage];
    if (url) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
    }
}

- (void)downloadButton:(id)arg1 {
    NSString *url = [[[self installer] package] homePage];
    if (url) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
    }
}

- (void)installOptions:(id)arg1 {
    [[self installer] installOptions];
}

- (void)installationCompleted {
    [[self installButton] setTitle:[[NSBundle mainBundle] localizedStringForKey:@"Install" value:@"" table:nil]];
    [[self optionsButton] setEnabled:YES];
    if ([[self installer] status] == 2) {
        [[self delegate] revealNewBottle:[[self installer] bottle]];
        [self back];
    } else {
        for (InstallSummaryDetailViewController *controller in [self summaryDetailsControllers]) {
            [controller setButtonEnabled:YES];
        }
        [[self delegate] selectInstallView];
    }
}

- (void)installationStarted {
    [[self installButton] setTitle:[[NSBundle mainBundle] localizedStringForKey:@"Cancel" value:@"" table:nil]];
    [[self optionsButton] setEnabled:NO];
    for (InstallSummaryDetailViewController *controller in [self summaryDetailsControllers]) {
        [controller setButtonEnabled:NO];
    }
}

- (id)window {
    return [[self view] window];
}

- (BOOL)performDragOperation:(id)arg1 {
    return YES;
}

- (BOOL)textFieldIsTruncated:(id)arg1 {
    NSTextField *tf = (NSTextField *)arg1;
    NSRect frame = [tf frame];
    NSRect exp = [[tf cell] expansionFrameWithFrame:frame inView:[tf superview]];
    return !NSEqualRects(exp, NSZeroRect);
}

- (void)startObservingFrameOfView:(id)arg1 {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subviewFrameChanged:) name:NSViewFrameDidChangeNotification object:arg1];
    [arg1 setPostsFrameChangedNotifications:YES];
}

- (void)stopObservingFrameOfView:(id)arg1 {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSViewFrameDidChangeNotification object:arg1];
}

- (void)subviewFrameChanged:(id)arg1 {
    id obj = [arg1 object];
    if (obj == [self packageDescriptionTextField]) {
        [self updatePackageDescriptionTruncation];
    } else if (obj == [self installationNotesTextField]) {
        [self updateInstallationNotesTruncation];
    }
}

- (void)updatePackageDescriptionTruncation {
    BOOL showExpand = NO;
    if ([[self packageDescriptionCollapsedHeightConstraint] isActive]) {
        showExpand = [self textFieldIsTruncated:[self packageDescriptionTextField]];
    }
    [[self packageDescriptionTextField] setSelectable:!showExpand];
    [[self packageDescriptionMoreLabel] setHidden:!showExpand];
    [[self packageDescriptionExpandButton] setHidden:!showExpand];
}

- (void)updateInstallationNotesTruncation {
    BOOL showExpand = NO;
    if ([[self installationNotesCollapsedHeightConstraint] isActive]) {
        showExpand = [self textFieldIsTruncated:[self installationNotesTextField]];
    }
    [[self installationNotesTextField] setSelectable:!showExpand];
    [[self installationNotesMoreLabel] setHidden:!showExpand];
    [[self installationNotesExpandButton] setHidden:!showExpand];
}

- (void)expandPackageDescription:(BOOL)arg1 {
    [[self packageDescriptionCollapsedHeightConstraint] setActive:!arg1];
    [self updatePackageDescriptionTruncation];
}

- (void)expandInstallationNotes:(BOOL)arg1 {
    [[self installationNotesCollapsedHeightConstraint] setActive:!arg1];
    [self updateInstallationNotesTruncation];
}

- (void)packageDescriptionExpandButtonClicked:(id)arg1 {
    [self expandPackageDescription:YES];
}

- (void)installationNotesExpandButtonClicked:(id)arg1 {
    [self expandInstallationNotes:YES];
}

- (id)delegate {
    return [objc_loadWeakRetained((id *)&self->_delegate) autorelease];
}

- (void)setDelegate:(id)arg1 {
    objc_storeWeak((id *)&self->_delegate, arg1);
}

- (id)packages {
    return self->_packages;
}

- (void)setPackages:(id)arg1 {
    if (self->_packages != arg1) {
        [self->_packages release];
        self->_packages = [arg1 retain];
    }
}

- (id)unknownPackage {
    return self->_unknownPackage;
}

- (void)setUnknownPackage:(id)arg1 {
    if (self->_unknownPackage != arg1) {
        [self->_unknownPackage release];
        self->_unknownPackage = [arg1 retain];
    }
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
    self->_isHighlighted = arg1;
}

- (id)visiblePackages {
    return self->_visiblePackages;
}

- (void)setVisiblePackages:(id)arg1 {
    if (self->_visiblePackages != arg1) {
        [self->_visiblePackages release];
        self->_visiblePackages = [arg1 retain];
    }
}

- (id)summaryDetailsControllers {
    return self->_summaryDetailsControllers;
}

- (void)setSummaryDetailsControllers:(id)arg1 {
    if (self->_summaryDetailsControllers != arg1) {
        [self->_summaryDetailsControllers release];
        self->_summaryDetailsControllers = [arg1 copy];
    }
}

- (id)installer {
    return self->_installer;
}

- (id)packageView {
    return [objc_loadWeakRetained((id *)&self->_packageView) autorelease];
}

- (void)setPackageView:(id)arg1 {
    objc_storeWeak((id *)&self->_packageView, arg1);
}

- (id)collectionView {
    return [objc_loadWeakRetained((id *)&self->_collectionView) autorelease];
}

- (void)setCollectionView:(id)arg1 {
    objc_storeWeak((id *)&self->_collectionView, arg1);
}

- (id)loading {
    return [objc_loadWeakRetained((id *)&self->_loading) autorelease];
}

- (void)setLoading:(id)arg1 {
    objc_storeWeak((id *)&self->_loading, arg1);
}

- (id)noResultsLabel {
    return [objc_loadWeakRetained((id *)&self->_noResultsLabel) autorelease];
}

- (void)setNoResultsLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_noResultsLabel, arg1);
}

- (id)searchField {
    return [objc_loadWeakRetained((id *)&self->_searchField) autorelease];
}

- (void)setSearchField:(id)arg1 {
    objc_storeWeak((id *)&self->_searchField, arg1);
}

- (id)installUnlistedAppButton {
    return [objc_loadWeakRetained((id *)&self->_installUnlistedAppButton) autorelease];
}

- (void)setInstallUnlistedAppButton:(id)arg1 {
    objc_storeWeak((id *)&self->_installUnlistedAppButton, arg1);
}

- (id)packageViewTitle {
    return self->_packageViewTitle;
}

- (void)setPackageViewTitle:(id)arg1 {
    if (self->_packageViewTitle != arg1) {
        [self->_packageViewTitle release];
        self->_packageViewTitle = [arg1 copy];
    }
}

- (id)installerView {
    return [objc_loadWeakRetained((id *)&self->_installerView) autorelease];
}

- (void)setInstallerView:(id)arg1 {
    objc_storeWeak((id *)&self->_installerView, arg1);
}

- (id)installButton {
    return [objc_loadWeakRetained((id *)&self->_installButton) autorelease];
}

- (void)setInstallButton:(id)arg1 {
    objc_storeWeak((id *)&self->_installButton, arg1);
}

- (id)optionsButton {
    return [objc_loadWeakRetained((id *)&self->_optionsButton) autorelease];
}

- (void)setOptionsButton:(id)arg1 {
    objc_storeWeak((id *)&self->_optionsButton, arg1);
}

- (id)optionsMenu {
    return self->_optionsMenu;
}

- (void)setOptionsMenu:(id)arg1 {
    if (self->_optionsMenu != arg1) {
        [self->_optionsMenu release];
        self->_optionsMenu = [arg1 retain];
    }
}

- (id)installerSourceMenu {
    return self->_installerSourceMenu;
}

- (void)setInstallerSourceMenu:(id)arg1 {
    if (self->_installerSourceMenu != arg1) {
        [self->_installerSourceMenu release];
        self->_installerSourceMenu = [arg1 retain];
    }
}

- (id)installWithSteamMenuItem {
    return self->_installWithSteamMenuItem;
}

- (void)setInstallWithSteamMenuItem:(id)arg1 {
    if (self->_installWithSteamMenuItem != arg1) {
        [self->_installWithSteamMenuItem release];
        self->_installWithSteamMenuItem = [arg1 retain];
    }
}

- (id)downloadInstallerMenuItem {
    return self->_downloadInstallerMenuItem;
}

- (void)setDownloadInstallerMenuItem:(id)arg1 {
    if (self->_downloadInstallerMenuItem != arg1) {
        [self->_downloadInstallerMenuItem release];
        self->_downloadInstallerMenuItem = [arg1 retain];
    }
}

- (id)summaryDetailsView {
    return [objc_loadWeakRetained((id *)&self->_summaryDetailsView) autorelease];
}

- (void)setSummaryDetailsView:(id)arg1 {
    objc_storeWeak((id *)&self->_summaryDetailsView, arg1);
}

- (id)packageDescriptionTextField {
    return [objc_loadWeakRetained((id *)&self->_packageDescriptionTextField) autorelease];
}

- (void)setPackageDescriptionTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_packageDescriptionTextField, arg1);
}

- (id)packageDescriptionExpandButton {
    return [objc_loadWeakRetained((id *)&self->_packageDescriptionExpandButton) autorelease];
}

- (void)setPackageDescriptionExpandButton:(id)arg1 {
    objc_storeWeak((id *)&self->_packageDescriptionExpandButton, arg1);
}

- (id)packageDescriptionMoreLabel {
    return [objc_loadWeakRetained((id *)&self->_packageDescriptionMoreLabel) autorelease];
}

- (void)setPackageDescriptionMoreLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_packageDescriptionMoreLabel, arg1);
}

- (id)installationNotesTextField {
    return [objc_loadWeakRetained((id *)&self->_installationNotesTextField) autorelease];
}

- (void)setInstallationNotesTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_installationNotesTextField, arg1);
}

- (id)installationNotesMoreLabel {
    return [objc_loadWeakRetained((id *)&self->_installationNotesMoreLabel) autorelease];
}

- (void)setInstallationNotesMoreLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_installationNotesMoreLabel, arg1);
}

- (id)installationNotesExpandButton {
    return [objc_loadWeakRetained((id *)&self->_installationNotesExpandButton) autorelease];
}

- (void)setInstallationNotesExpandButton:(id)arg1 {
    objc_storeWeak((id *)&self->_installationNotesExpandButton, arg1);
}

- (id)packageDescriptionCollapsedHeightConstraint {
    return [objc_loadWeakRetained((id *)&self->_packageDescriptionCollapsedHeightConstraint) autorelease];
}

- (void)setPackageDescriptionCollapsedHeightConstraint:(id)arg1 {
    objc_storeWeak((id *)&self->_packageDescriptionCollapsedHeightConstraint, arg1);
}

- (id)installationNotesCollapsedHeightConstraint {
    return [objc_loadWeakRetained((id *)&self->_installationNotesCollapsedHeightConstraint) autorelease];
}

- (void)setInstallationNotesCollapsedHeightConstraint:(id)arg1 {
    objc_storeWeak((id *)&self->_installationNotesCollapsedHeightConstraint, arg1);
}

@end
