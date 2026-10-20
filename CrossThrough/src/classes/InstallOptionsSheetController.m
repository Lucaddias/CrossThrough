// InstallOptionsSheetController.m — CrossThrough
#import "InstallOptionsSheetController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "InstallDependency.h"
#import "LoggingOption.h"
#import "LoggingOptionsViewController.h"
#import "AddDependenciesViewController.h"

static NSInteger _CompareLanguageEntries(id dict1, id dict2, void *context) {
    NSString *c1 = [dict1 objectForKey:@"canonicalLang"];
    NSString *c2 = [dict2 objectForKey:@"canonicalLang"];
    if ([c1 isEqualToString:c2]) {
        return NSOrderedSame;
    }
    if ([c1 length] == 0) return NSOrderedDescending;
    if ([c2 length] == 0) return NSOrderedAscending;

    NSUInteger r1 = [[dict1 objectForKey:@"rank"] unsignedIntegerValue];
    NSUInteger r2 = [[dict2 objectForKey:@"rank"] unsignedIntegerValue];
    if (r1 != r2) {
        if (r1 < r2) return NSOrderedAscending;
        return NSOrderedDescending;
    }
    NSString *d1 = [dict1 objectForKey:@"displayName"];
    NSString *d2 = [dict2 objectForKey:@"displayName"];
    return [d1 localizedCaseInsensitiveCompare:d2];
}

@implementation InstallOptionsSheetController

- (id)initWithInstallConfiguration:(id)arg1 {
    self = [super initWithWindowNibName:@"InstallOptionsSheet"];
    if (self) {
        self->_installConfiguration = [arg1 retain];
    }
    return self;
}

- (void)dealloc {
    NSTableView *tbl = [self installDependencyTable];
    if (tbl) {
        [tbl setDelegate:nil];
    }
    [self->_installConfiguration removeDelegate:self];
    [self->_installConfiguration release];
    self->_installConfiguration = nil;
    [self->_dependencies release];
    self->_dependencies = nil;
    [self->_environment release];
    self->_environment = nil;
    [self->_logFileURL release];
    self->_logFileURL = nil;
    [self->_loggingOptions release];
    self->_loggingOptions = nil;
    objc_destroyWeak((id *)&self->_installDependencyTable);
    objc_destroyWeak((id *)&self->_installDependencyArrayController);
    objc_destroyWeak((id *)&self->_appLanguagePopUp);
    objc_destroyWeak((id *)&self->_stackView);
    [super dealloc];
}

- (void)windowDidLoad {
    [super windowDidLoad];

    if (![self.installConfiguration hasBottle]) {
        NSTableView *tbl = [self installDependencyTable];
        [[tbl enclosingScrollView] setVerticalScrollElasticity:NSScrollElasticityNone];
        [tbl setAlphaValue:0.5];
    }

    [self.installConfiguration addDelegate:self];
    [self fillDependencyList];

    NSSortDescriptor *sortKey = [NSSortDescriptor sortDescriptorWithKey:@"sortKey" ascending:YES selector:@selector(compareInstallDependencySortKey:)];
    NSSortDescriptor *sortName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
    [[self installDependencyArrayController] setSortDescriptors:@[sortKey, sortName]];

    LoggingOptionsViewController *logVC = [[LoggingOptionsViewController alloc] initWithLogFileName:[self.installConfiguration logFileName]];
    [self setLoggingOptions:logVC];
    [logVC release];

    [self.loggingOptions setLogFileURL:[self.installConfiguration logFileURL]];
    [self.loggingOptions setLogChannels:[self.installConfiguration logChannels]];
    [self.loggingOptions setLogEnvironment:[self.installConfiguration logEnvironment]];
    [self setEnvironment:[self.installConfiguration environment]];

    id preset = [[CXSetupLib cxUtilsClass] installerLoggingPreset];
    if (preset) {
        NSString *lbl = [preset valueForKey:@"label"];
        NSString *chan = [preset valueForKey:@"channels"];
        LoggingOption *opt = [LoggingOption loggingOptionWithName:lbl channels:chan];
        if (opt) {
            [[self.loggingOptions channelCombos] insertObject:opt atIndex:0];
        }
    }

    NSView *logView = [self.loggingOptions view];
    if (logView && self.stackView) {
        [self.stackView insertArrangedSubview:logView atIndex:0];
        NSDictionary *views = @{ @"view": logView };
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views];
        [self.stackView addConstraints:constraints];
    }

    [self updateLanguages];
}

- (void)updateLogFileName {
    [self.loggingOptions setLogFileName:[self.installConfiguration logFileName]];
}

- (void)addDependenciesOfApp:(id)arg1 fromReasons:(id)arg2 to:(id)arg3 {
    NSString *appID = [arg1 appID];
    id tb = [self.installConfiguration targetBottle];
    NSDictionary *installers = [tb valueForKey:@"installers"];

    NSArray *key = @[[InstallConfiguration reasonDependency], appID ?: @""];
    NSArray *deps = [arg2 objectForKey:key];

    for (NSString *depID in deps) {
        id isInstalled = [installers objectForKey:depID];
        if (isInstalled) {
            InstallDependency *dep = [[[InstallDependency alloc] init] autorelease];
            [dep setAppID:depID];
            [dep setParent:arg1];
            [dep setName:[self.installConfiguration nameForProfileWithAppID:depID]];
            [dep setReason:[InstallConfiguration reasonDependency]];

            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Required by %@" value:@"" table:nil];
            [dep setReasonString:[NSString stringWithFormat:fmt, [self.installConfiguration nameForProfileWithAppID:appID]]];

            [arg3 addObject:dep];
            [self addDependenciesOfApp:dep fromReasons:arg2 to:arg3];
        } else {
            NSDictionary *overrides = [self.installConfiguration dependencyOverrides];
            NSNumber *ov = [overrides objectForKey:depID];
            if ([ov isEqualToNumber:[InstallConfiguration overrideExclude]]) {
                InstallDependency *dep = [[[InstallDependency alloc] init] autorelease];
                [dep setAppID:depID];
                [dep setParent:arg1];
                [dep setName:[self.installConfiguration nameForProfileWithAppID:depID]];
                [dep setReason:[InstallConfiguration reasonDependency]];
                [dep setUndo:1];

                NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Required by %@, Manually Removed" value:@"" table:nil];
                [dep setReasonString:[NSString stringWithFormat:fmt, [self.installConfiguration nameForProfileWithAppID:appID]]];

                [arg3 addObject:dep];
            }
        }
    }
}

- (void)addDependenciesForReason:(id)arg1 fromMap:(id)arg2 reasonString:(id)arg3 removedString:(id)arg4 to:(id)arg5 {
    BOOL isOverride = [arg1 isEqualToNumber:[InstallConfiguration reasonOverride]];
    id tb = [self.installConfiguration targetBottle];
    NSDictionary *installers = [tb valueForKey:@"installers"];

    NSArray *key = @[arg1, [NSNull null]];
    NSArray *appIDs = [arg2 objectForKey:key];

    for (NSString *appID in appIDs) {
        id isInstalled = [installers objectForKey:appID];
        if (isInstalled) {
            InstallDependency *dep = [[[InstallDependency alloc] init] autorelease];
            [dep setAppID:appID];
            [dep setName:[self.installConfiguration nameForProfileWithAppID:appID]];
            [dep setReason:arg1];
            [dep setReasonString:arg3];
            if (isOverride) {
                [dep setUndo:2];
            }
            [arg5 addObject:dep];
            [self addDependenciesOfApp:dep fromReasons:arg2 to:arg5];
        } else if (arg4) {
            NSDictionary *overrides = [self.installConfiguration dependencyOverrides];
            NSNumber *ov = [overrides objectForKey:appID];
            if ([ov isEqualToNumber:[InstallConfiguration overrideExclude]]) {
                InstallDependency *dep = [[[InstallDependency alloc] init] autorelease];
                [dep setAppID:appID];
                [dep setName:[self.installConfiguration nameForProfileWithAppID:appID]];
                [dep setReason:arg1];
                [dep setReasonString:arg4];
                [dep setUndo:1];
                [arg5 addObject:dep];
            }
        }
    }
}

- (void)fillDependencyList {
    id tb = [self.installConfiguration targetBottle];
    if ([[tb valueForKey:@"analyzed"] boolValue]) {
        NSMutableArray *deps = [NSMutableArray array];
        NSMutableDictionary *reasonsMap = [NSMutableDictionary dictionary];

        NSDictionary *reasons = [tb valueForKey:@"reasons"];
        [reasons enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSMutableArray *list = [reasonsMap objectForKey:obj];
            if (!list) {
                list = [NSMutableArray array];
                [reasonsMap setObject:list forKey:obj];
            }
            [list addObject:key];
        }];

        NSString *mainStr = [[NSBundle mainBundle] localizedStringForKey:@"Selected for install" value:@"" table:nil];
        [self addDependenciesForReason:[InstallConfiguration reasonMain] fromMap:reasonsMap reasonString:mainStr removedString:nil to:deps];

        NSString *steamStr = [[NSBundle mainBundle] localizedStringForKey:@"Installing via Steam" value:@"" table:nil];
        NSString *steamRemStr = [[NSBundle mainBundle] localizedStringForKey:@"Installing via Steam, Manually Removed" value:@"" table:nil];
        [self addDependenciesForReason:[InstallConfiguration reasonSteam] fromMap:reasonsMap reasonString:steamStr removedString:steamRemStr to:deps];

        NSString *ovStr = [[NSBundle mainBundle] localizedStringForKey:@"Manually added" value:@"" table:nil];
        [self addDependenciesForReason:[InstallConfiguration reasonOverride] fromMap:reasonsMap reasonString:ovStr removedString:nil to:deps];

        [self setDependencies:deps];
    } else {
        [self setDependencies:nil];
    }
}

- (void)done:(id)arg1 {
    [self.installConfiguration setEnvironment:self.environment];

    if ([self.loggingOptions createLogFile]) {
        [self.installConfiguration setLogFileURL:[self.loggingOptions logFileURL]];
        [self.loggingOptions sanitizeLogChannels];
        [self.installConfiguration setLogChannels:[self.loggingOptions logChannels]];
        [self.installConfiguration setLogEnvironment:[self.loggingOptions logEnvironment]];
        [self.loggingOptions saveSettingsToRecent];
    } else {
        [self.installConfiguration setLogFileURL:nil];
        [self.installConfiguration setLogChannels:nil];
        [self.installConfiguration setLogEnvironment:nil];
    }

    [NSApp endSheet:[self window]];
}

- (void)removeInstallDependency:(id)arg1 {
    NSInteger row = [[self installDependencyTable] rowForView:arg1];
    if (row != -1) {
        NSArray *arranged = [[self installDependencyArrayController] arrangedObjects];
        InstallDependency *dep = [arranged objectAtIndex:row];
        id task = [self.installConfiguration installTask];
        if ([dep isManuallyAdded]) {
            [task removeDependencyOverrides:@[[dep appID]]];
        } else {
            [task addDependencyOverrides:@[[dep appID]] ofType:[InstallConfiguration overrideExclude]];
        }
    }
}

- (void)reAddDependency:(id)arg1 {
    NSInteger row = [[self installDependencyTable] rowForView:arg1];
    if (row != -1) {
        NSArray *arranged = [[self installDependencyArrayController] arrangedObjects];
        InstallDependency *dep = [arranged objectAtIndex:row];
        [[self.installConfiguration installTask] removeDependencyOverrides:@[[dep appID]]];
    }
}

- (void)revertInstallDependencies:(id)arg1 {
    [[self.installConfiguration installTask] ClearDependencyOverrides];
}

- (void)showAddDependenciesPopover:(id)arg1 {
    AddDependenciesViewController *vc = [[[AddDependenciesViewController alloc] init] autorelease];
    [vc setRepresentedObject:self.installConfiguration];

    NSPopover *popover = [[[NSPopover alloc] init] autorelease];
    [popover setContentViewController:vc];
    [popover setBehavior:NSPopoverBehaviorTransient];
    [popover showRelativeToRect:[arg1 bounds] ofView:arg1 preferredEdge:NSRectEdgeMaxY];
}

- (void)updateLanguages {
    NSArray *langs = [self.installConfiguration profileLanguages];
    NSString *currentLocale = [self.installConfiguration installerLocale];

    [[self appLanguagePopUp] removeAllItems];
    [[self appLanguagePopUp] selectItem:nil];
    [self setNumberOfLanguages:[langs count]];

    if ([langs count] == 0) {
        [[self appLanguagePopUp] synchronizeTitleAndSelectedItem];
        return;
    }

    NSArray *preferred = [NSLocale preferredLanguages];
    NSMutableArray *entries = [NSMutableArray arrayWithCapacity:[langs count]];

    for (NSString *lang in langs) {
        NSString *canon = @"";
        NSString *disp = @"";
        NSUInteger rank = NSNotFound;

        if ([lang length] > 0) {
            canon = [NSLocale canonicalLanguageIdentifierFromString:lang];
            disp = [[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:lang];
            rank = [preferred indexOfObject:canon];
        } else {
            disp = [[NSBundle mainBundle] localizedStringForKey:@"Other Language" value:@"" table:nil];
            rank = NSNotFound;
        }

        NSDictionary *entry = @{
            @"lang": lang ?: @"",
            @"canonicalLang": canon ?: @"",
            @"displayName": disp ?: @"",
            @"rank": @(rank)
        };
        [entries addObject:entry];
    }

    [entries sortUsingFunction:_CompareLanguageEntries context:NULL];

    NSMenuItem *selectedItem = nil;
    NSUInteger lastRank = NSNotFound;
    BOOL hasAddedSeparator = NO;

    for (NSDictionary *entry in entries) {
        NSString *lang = [entry objectForKey:@"lang"];
        NSString *disp = [entry objectForKey:@"displayName"];
        NSUInteger rank = [[entry objectForKey:@"rank"] unsignedIntegerValue];

        if (!hasAddedSeparator) {
            if (lastRank != NSNotFound && (rank == NSNotFound || [lang length] == 0)) {
                [[[self appLanguagePopUp] menu] addItem:[NSMenuItem separatorItem]];
                hasAddedSeparator = YES;
            } else if ([lang length] == 0) {
                [[[self appLanguagePopUp] menu] addItem:[NSMenuItem separatorItem]];
                hasAddedSeparator = YES;
            }
        }
        lastRank = rank;

        NSMenuItem *item = [[[self appLanguagePopUp] menu] addItemWithTitle:disp action:@selector(selectAppLanguage:) keyEquivalent:@""];
        [item setTarget:self];
        [item setRepresentedObject:lang];

        if (currentLocale && [lang isEqualToString:currentLocale]) {
            selectedItem = item;
        }
    }

    if (selectedItem) {
        [[self appLanguagePopUp] selectItem:selectedItem];
    }
    [[self appLanguagePopUp] synchronizeTitleAndSelectedItem];
}

- (void)selectAppLanguage:(id)arg1 {
    NSString *lang = [arg1 representedObject];
    [self.installConfiguration setInstallerLocale:lang];
}

- (void)windowWillClose:(id)arg1 {
    [self.installConfiguration removeDelegate:self];
    [super windowWillClose:arg1];
}

#pragma mark - Delegates

- (void)profileChanged {
    [self fillDependencyList];
    [self updateLanguages];
    [self updateLogFileName];
}

- (void)sourceChanged {
    [self fillDependencyList];
    [self updateLogFileName];
}

- (void)bottleCreateChanged {
    [self fillDependencyList];
    [self updateLogFileName];
}

- (void)bottleNameChanged {
    [self fillDependencyList];
    [self updateLogFileName];
}

- (void)bottleNewnameChanged {
    [self fillDependencyList];
    [self updateLogFileName];
}

- (void)bottleTemplateChanged {
    [self fillDependencyList];
    [self updateLogFileName];
}

- (void)analyzedBottle:(id)arg1 {
    if (arg1 == [self.installConfiguration targetBottle]) {
        [self fillDependencyList];
    }
}

#pragma mark - Properties Accessors

- (id)installDependencyTable {
    return objc_loadWeakRetained((id *)&self->_installDependencyTable);
}

- (void)setInstallDependencyTable:(id)arg1 {
    objc_storeWeak((id *)&self->_installDependencyTable, arg1);
}

- (id)installDependencyArrayController {
    return objc_loadWeakRetained((id *)&self->_installDependencyArrayController);
}

- (void)setInstallDependencyArrayController:(id)arg1 {
    objc_storeWeak((id *)&self->_installDependencyArrayController, arg1);
}

- (id)appLanguagePopUp {
    return objc_loadWeakRetained((id *)&self->_appLanguagePopUp);
}

- (void)setAppLanguagePopUp:(id)arg1 {
    objc_storeWeak((id *)&self->_appLanguagePopUp, arg1);
}

- (id)stackView {
    return objc_loadWeakRetained((id *)&self->_stackView);
}

- (void)setStackView:(id)arg1 {
    objc_storeWeak((id *)&self->_stackView, arg1);
}

- (id)dependencies {
    return self->_dependencies;
}

- (void)setDependencies:(id)arg1 {
    if (self->_dependencies != arg1) {
        [self->_dependencies release];
        self->_dependencies = [arg1 copy];
    }
}

- (id)installConfiguration {
    return self->_installConfiguration;
}

- (id)loggingOptions {
    return self->_loggingOptions;
}

- (void)setLoggingOptions:(id)arg1 {
    if (self->_loggingOptions != arg1) {
        [self->_loggingOptions release];
        self->_loggingOptions = [arg1 retain];
    }
}

- (id)logFileURL {
    return self->_logFileURL;
}

- (NSInteger)numberOfLanguages {
    return self->_numberOfLanguages;
}

- (void)setNumberOfLanguages:(NSInteger)arg1 {
    self->_numberOfLanguages = arg1;
}

- (id)environment {
    return self->_environment;
}

- (void)setEnvironment:(id)arg1 {
    if (self->_environment != arg1) {
        [self->_environment release];
        self->_environment = [arg1 copy];
    }
}

@end
