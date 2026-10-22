// CXServerCrossOver.m — CrossThrough
#import "CXServerCrossOver.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "NSFileManager+CrossOverAdditions.h"
#import "NSString+CrossOverAdditions.h"
#import "CXApplication.h"
#import "MainWindowController.h"
#import "PreferencesController.h"
#import "CrossTieURLHandler.h"
#import "AskUpdateBottlesOp.h"
#import "RunCommandController.h"
#import "NoBottleController.h"
#import "LauncherFolder.h"
#import "LauncherDiskFolder.h"
#import "LauncherApp.h"
#import "LauncherIconUtils.h"
#import "CDTools.h"
#import "CXBundle.h"
#import "CXTask.h"
#import <math.h>

#import "BuySupportNagController.h"
#import "CrossThroughBranding.h"

@implementation CXServerCrossOver

+ (id)getDefaultProgramsFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    NSString *appDir = [paths count] > 0 ? [paths objectAtIndex:0] : nil;
    if (!appDir) {
        appDir = [@"~/Applications" stringByExpandingTildeInPath];
    }
    NSString *cellar = [self getCellarID];
    return [appDir stringByAppendingPathComponent:cellar];
}

+ (id)getProgramsFolder {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSData *bookmark = [defaults dataForKey:@"ProgramsFolderBookmark"];
    if (bookmark) {
        BOOL stale = NO;
        NSString *path = [fm pathFromBookmarkData:bookmark stale:&stale];
        if (!stale && path) {
            NSString *savedPath = [defaults stringForKey:@"ProgramsFolderPath"];
            if (![savedPath isEqualToString:path]) {
                [defaults setObject:path forKey:@"ProgramsFolderPath"];
            }
            return path;
        } else if (path) {
            NSData *newBm = [fm bookmarkDataFromPath:path];
            if (newBm) {
                [defaults setObject:newBm forKey:@"ProgramsFolderBookmark"];
            }
            NSString *savedPath = [defaults stringForKey:@"ProgramsFolderPath"];
            if (![savedPath isEqualToString:path]) {
                [defaults setObject:path forKey:@"ProgramsFolderPath"];
            }
            return path;
        }
    }
    NSString *path = [defaults stringForKey:@"ProgramsFolderPath"];
    if (path) {
        NSData *newBm = [fm bookmarkDataFromPath:path];
        if (newBm) {
            [defaults setObject:newBm forKey:@"ProgramsFolderBookmark"];
        } else {
            [defaults removeObjectForKey:@"ProgramsFolderBookmark"];
        }
    }
    return path;
}

+ (id)crossTieModDateString {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *path = [[CXSetupLib c4ProfilesClass] getOnlineFilePath];
    if ([fm fileExistsAtPath:path]) {
        NSString *resolved = [path stringByResolvingSymlinksInPath];
        NSDictionary *attrs = [fm attributesOfItemAtPath:resolved error:NULL];
        NSDate *modDate = [attrs objectForKey:NSFileModificationDate];
        NSDateFormatter *df = [[[NSDateFormatter alloc] init] autorelease];
        [df setDateStyle:NSDateFormatterMediumStyle];
        [df setTimeStyle:NSDateFormatterShortStyle];
        NSString *dateStr = [df stringFromDate:modDate];
        return [NSString stringWithFormat:NSLocalizedString(@"Installation recipes were last updated on %@.", @""), dateStr];
    } else {
        return NSLocalizedString(@"Installation recipes have never been updated.", @"");
    }
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *defaultProgramsFolder = [[self class] getDefaultProgramsFolder];
        NSDictionary *defaults = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSDate distantPast], @"LastUpdatedAssociations_v2",
            defaultProgramsFolder ?: @"", @"ProgramsFolderPath",
            [NSDictionary dictionary], @"MostRecentCXFBMenuPlist",
            [NSDictionary dictionary], @"DocTypeToMenuPathMap",
            @0, @"LastHelperVersion",
            @NO, @"AutoUpdateCrossTies",
            @NO, @"AskForRatings",
            @NO, @"Enable32BitBottles",
            nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];

        dockPrefs = [[NSUserDefaults alloc] init];
        programsMenuUpdateDate = [[NSDate distantPast] retain];
        associationsLock = [[NSObject alloc] init];

        NSDictionary *savedDocTypes = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"DocTypeToMenuPathMap"];
        if (savedDocTypes) {
            relateDocTypesToMenus = (NSDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFPropertyListRef)savedDocTypes, kCFPropertyListMutableContainers);
        }

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]] retain];

        [[CXUpdater sharedUpdater] setDelegate:self];
    }
    return self;
}

- (void)dealloc {
    [dockPrefs release];
    [mainWindowController release];
    [preferencesController release];
    [programsMenuUpdateDate release];
    [associationsLock release];
    [helpersToDelete release];
    [associationPlist release];
    [associationPlistDate release];
    [relateDocTypesToMenus release];
    [updateCheckOp release];
    [session release];
    [nextUpdateItem release];
    [_programsMenu release];
    [_launchers release];
    [_urlHandler release];
    [_observedBottles release];
    [super dealloc];
}

- (id)preferencesController {
    if (!preferencesController) {
        preferencesController = [[PreferencesController alloc] init];
    }
    return preferencesController;
}

- (id)mainWindowController {
    if (!mainWindowController) {
        mainWindowController = [[MainWindowController alloc] init];
    }
    return mainWindowController;
}

- (void)applicationWillFinishLaunching:(id)arg1 {
    CTBrandAppMenu();
    AskUpdateBottlesOp *op = [[AskUpdateBottlesOp alloc] init];
    [updateCheckOp release];
    updateCheckOp = op;
    NSOperation *startOp = [self startAppOp];
    if (startOp) {
        [updateCheckOp addDependency:startOp];
    }
    [[NSOperationQueue mainQueue] addOperation:updateCheckOp];
    [super applicationWillFinishLaunching:arg1];
}

- (void)applicationDidFinishLaunching:(id)arg1 {
    [super applicationDidFinishLaunching:arg1];
    if ([@"1" isEqualToString:@"0"]) {
        NSMenu *menu = [[self publishBottleMenuItem] menu];
        [menu removeItem:[self publishBottleMenuItem]];
        [self setPublishBottleMenuItem:nil];
        NSMenu *upMenu = [[self updateBottleMenuItem] menu];
        [upMenu removeItem:[self updateBottleMenuItem]];
        [self setUpdateBottleMenuItem:nil];
    }
}

- (id)startedAppGateOp {
    return updateCheckOp;
}

- (void)openAutoPlayInstallerForC4P:(id)arg1 inBottle:(id)arg2 {
    [[self mainWindowController] showWindow:self];
    [[self mainWindowController] autoPlayWithAutorunFile:arg1 inBottle:arg2];
}

- (void)openAutoPlayInstallerForVolume:(id)arg1 inBottle:(id)arg2 {
    [[self mainWindowController] showWindow:self];
    [[self mainWindowController] autoPlay:arg1 inBottle:arg2];
}

- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1 {
    NSDictionary *dockDomain = [dockPrefs persistentDomainForName:@"com.apple.dock"];
    BOOL bounce = YES;
    NSString *orientation = @"bottom";
    if (dockDomain) {
        NSNumber *anim = [dockDomain objectForKey:@"launchanim"];
        if (anim) {
            bounce = [anim boolValue];
        }
        NSString *orient = [dockDomain objectForKey:@"orientation"];
        if (orient) {
            orientation = orient;
        }
    }
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
        [NSValue valueWithSize:arg1], @"imageSize",
        [NSNumber numberWithBool:bounce], @"bounce",
        orientation, @"orientation",
        nil];
}

- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3 {
    NSImage *badge = [(LaunchFeedbackInfo *)arg1 badgeIcon];
    NSSize badgeSize = [badge size];
    NSSize imgSize = [[arg3 objectForKey:@"imageSize"] sizeValue];
    NSString *orientation = [arg3 objectForKey:@"orientation"];
    BOOL isBottom = [orientation isEqualToString:@"bottom"];
    CGFloat yOffset = isBottom ? imgSize.height : (imgSize.height - (CGFloat)arg2 * (badgeSize.height + 5.0));
    CGFloat xOffset = isBottom ? (CGFloat)arg2 * (badgeSize.width + 5.0) : 0.0;
    
    BOOL bounce = [[arg3 objectForKey:@"bounce"] boolValue];
    if (bounce) {
        double counter = (double)[(LaunchFeedbackInfo *)arg1 lifeCounter] / 3.0;
        double bounceVal = fabs(sin(counter) * 6.0);
        if ([orientation isEqualToString:@"right"]) {
            xOffset = (imgSize.width - 6.0) + bounceVal;
        } else if ([orientation isEqualToString:@"left"]) {
            xOffset = (xOffset - 6.0) + bounceVal;
        } else {
            yOffset = (imgSize.height - 6.0) + bounceVal;
        }
    } else {
        if ([orientation isEqualToString:@"bottom"]) {
            yOffset -= badgeSize.height;
        } else if ([orientation isEqualToString:@"left"]) {
            xOffset = imgSize.width - badgeSize.width;
        } else {
            xOffset = 0.0;
        }
    }
    [badge drawAtPoint:NSMakePoint(xOffset, yOffset) fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0];
}

- (id)startLaunchNotify:(id)arg1 {
    [dockPrefs synchronize];
    return [super startLaunchNotify:arg1];
}

- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2 {
    if ([(CXApplication *)NSApp isDemo]) {
        if (-[lastDemoNagTime timeIntervalSinceNow] <= 3600.0) {
            [super forkExecCommand:arg1 withArgs:arg2];
        } else {
            [lastDemoNagTime release];
            lastDemoNagTime = [[NSDate date] retain];
            [self doPeriodicDemoNagForCommand:arg1 withArgs:arg2];
        }
    } else {
        [super forkExecCommand:arg1 withArgs:arg2];
    }
}

- (void)runClient:(id)arg1 inBottle:(id)arg2 {
    [self runClient:arg1 inBottle:arg2 withDialog:NO];
}

// Opens a document handed to CrossOver: installers and volumes go to the
// install view, archives and CrossTies to their importers, Windows programs
// run in a bottle (or through the Run Command dialog), and CrossOver helper
// bundles run their own command.
- (void)runClient:(id)arg1 inBottle:(id)arg2 withDialog:(BOOL)arg3 {
    NSString *file = arg1;
    NSString *bottleName = arg2;
    CXBundle *bundle = [CXBundle bundleWithURL:[NSURL fileURLWithPath:file]];
    NSString *ext = [file pathExtension];
    NSString *lastComponent = [file lastPathComponent];
    NSString *bottleArg = nil;
    id bottle = nil;

    if (bottleName) {
        bottleArg = [NSString stringWithFormat:@"--bottle %@", [bottleName stringQuotedForBash]];
        bottle = [[[CXSetupLib bottleCollectionClass] sharedCollection] bottleWithName:bottleName];
    } else {
        NSArray *bottles = [[[CXSetupLib bottleCollectionClass] sharedCollection] bottleList];
        for (BottleWrapper *candidate in bottles) {
            if ([candidate isCanRunCommands] && [[candidate fileIsInBottle:file] boolValue]) {
                bottleArg = [NSString stringWithFormat:@"--bottle %@", [[candidate name] stringQuotedForBash]];
                break;
            }
        }
        if (!bottleArg && ![[NSUserDefaults standardUserDefaults] boolForKey:@"InstallExeFiles"]) {
            for (BottleWrapper *candidate in bottles) {
                if ([candidate isIsDefault] && [candidate isCanRunCommands]) {
                    bottleArg = [NSString stringWithFormat:@"--bottle %@", [[candidate name] stringQuotedForBash]];
                    break;
                }
            }
            // CrossOver 26.3 also has a single-bottle fallback here, but it
            // tests a bottle variable it never assigns, so it never applies.
        }
    }

    BOOL openAsInstaller = NO;
    if ([[[CXSetupLib c4ProfilesClass] getMatchingProfiles:file] count] == 1 ||
        [lastComponent caseInsensitiveCompare:@"setup.exe"] == NSOrderedSame ||
        [lastComponent caseInsensitiveCompare:@"setuppls.exe"] == NSOrderedSame ||
        [lastComponent caseInsensitiveCompare:@"setupse.exe"] == NSOrderedSame ||
        [lastComponent caseInsensitiveCompare:@"autorun.inf"] == NSOrderedSame ||
        [ext caseInsensitiveCompare:@"msi"] == NSOrderedSame) {
        openAsInstaller = YES;
    } else if ([ext caseInsensitiveCompare:@"lnk"] == NSOrderedSame || [ext caseInsensitiveCompare:@"exe"] == NSOrderedSame) {
        if (bottleArg && !arg3) {
            NSString *mode = [ext caseInsensitiveCompare:@"lnk"] == NSOrderedSame ? @"--start" : @"--";
            NSString *wine = [[[NSApp crossOverRoot] stringByAppendingPathComponent:@"bin"] stringByAppendingPathComponent:@"wine"];
            NSString *command = [NSString stringWithFormat:@"%@ %@ %@ %@", [wine stringQuotedForBash], bottleArg, mode, [file stringQuotedForBash]];
            NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:file];
            NSDictionary *args = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:icon, file, [file stringByDeletingLastPathComponent], nil]
                                                             forKeys:[NSArray arrayWithObjects:@"icon", @"doc", @"workdir", nil]];
            [self forkExecCommand:command withArgs:args];
        } else if ([ext caseInsensitiveCompare:@"exe"] == NSOrderedSame &&
                   [[NSUserDefaults standardUserDefaults] boolForKey:@"InstallExeFiles"] && !arg3) {
            openAsInstaller = YES;
        } else if ([[[[CXSetupLib bottleCollectionClass] sharedCollection] bottleList] count] == 0) {
            NoBottleController *controller = [[[NoBottleController alloc] initWithFileToLaunch:file] autorelease];
            [controller showWindow:self];
        } else {
            RunCommandController *controller = [[[RunCommandController alloc] initWithFileToRun:file] autorelease];
            [controller window];
            if (bottle) {
                [controller setSelectedBottle:bottle];
            }
            [controller showWindow:self];
        }
    } else if ([ext caseInsensitiveCompare:@"cxarchive"] == NSOrderedSame) {
        [[self mainWindowController] showWindow:self];
        [[self mainWindowController] importBottleArchiveFromURL:[NSURL fileURLWithPath:file]];
    } else if ([ext caseInsensitiveCompare:@"c4p"] == NSOrderedSame ||
               [ext caseInsensitiveCompare:@"tie"] == NSOrderedSame ||
               [ext caseInsensitiveCompare:@"tie-CrossOver"] == NSOrderedSame) {
        [self openAutoPlayInstallerForC4P:file inBottle:bottle];
    } else if (bundle) {
        if ([bundle objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"]) {
            // The bottle menu's rating helper: no recent item for it.
            if (bottleName) {
                BottleWrapper *rated = [[[CXSetupLib bottleCollectionClass] sharedCollection] bottleWithName:bottleName];
                NSWindow *window = [[self mainWindowController] isWindowLoaded] ? [[self mainWindowController] window] : nil;
                [BottleMenuHandler rateBottle:rated withWindow:window isDeleting:NO];
            }
            return;
        }
        NSString *helperCommand = [bundle objectForInfoDictionaryKey:@"CrossOverHelperCommand"];
        if (helperCommand) {
            NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:file];
            NSDictionary *args = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:icon, file, nil]
                                                             forKeys:[NSArray arrayWithObjects:@"icon", @"doc", nil]];
            [self forkExecCommand:helperCommand withArgs:args];
        } else {
            NSLog(@"CrossOver got non-CrossOver bundle as document: %@\n", file);
        }
    } else if ([CDTools isValidInstallerVolume:file]) {
        openAsInstaller = YES;
    } else {
        [super runClient:file inBottle:bottleName];
    }

    if (openAsInstaller) {
        [self openAutoPlayInstallerForVolume:file inBottle:bottle];
    }
    [self addToRecentItems:file bottle:bottleName];
}

- (void)continueFromDemoCheck {
    id collection = [[CXSetupLib bottleCollectionClass] sharedCollection];
    [collection addChangeDelegate:self];
    [self watchMenuPLists];
    [self refreshPrograms:nil];
    [super continueFromDemoCheck];
    [lastDemoNagTime release];
    lastDemoNagTime = [[NSDate date] retain];
    [CDTools removeCDHelperAndPrefsForAllInstalls];
}

- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2 {
    NSAppleEventDescriptor *param = [arg1 paramDescriptorForKeyword:keyDirectObject];
    NSString *str = [param stringValue];
    if ([str length] > 0) {
        NSURL *url = [NSURL URLWithString:str];
        if (url && [[url scheme] caseInsensitiveCompare:@"com-codeweavers-crossover-crosstie"] == NSOrderedSame) {
            NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
                [self handleCrossTieURL:url];
            }];
            NSOperation *gate = [self startedAppGateOp];
            if (gate) {
                [op addDependency:gate];
            }
            [[NSOperationQueue mainQueue] addOperation:op];
            return NO;
        }
    }
    return [super handleGetURLEvent:arg1 withReplyEvent:arg2];
}

- (void)handleCrossTieURL:(id)arg1 {
    CrossTieURLHandler *handler = [[[CrossTieURLHandler alloc] init] autorelease];
    [self setUrlHandler:handler];
    [[self urlHandler] handleCrossTieURL:arg1];
}

- (void)openScreenSharingHelpPage:(id)arg1 {
    // CrossThrough: abria crossover.codeweavers.com/redirect/teamviewer. Removido.
}

- (void)openHelpInBrowser:(id)arg1 {
    // CrossThrough: abria support.codeweavers.com. Removido.
}

- (void)showMainWindow:(id)arg1 {
    [[self mainWindowController] showWindow:arg1];
}

- (void)showPreferencesWindow:(id)arg1 {
    [[self preferencesController] showWindow:arg1];
}

- (void)bottleCollectionChanged {
    refreshProgramsCreateIsForced = YES;
    [self performSelectorOnMainThread:@selector(queueRefreshPrograms:) withObject:nil waitUntilDone:YES];
    [self watchMenuPLists];
}

- (void)runCommand:(id)arg1 {
    if ([[[self mainWindowController] window] isVisible]) {
        [[self mainWindowController] showWindow:arg1];
    }
    [super runCommand:arg1];
}

- (void)rebuildMenus:(id)arg1 {
    NSFileManager *fm = [NSFileManager defaultManager];
    @synchronized(associationsLock) {
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:NSLocalizedString(@"Rebuild Programs", @"")];
        NSString *programsFolder = [[self class] getProgramsFolder];
        NSString *disp = [fm getDisplayStringForPath:programsFolder];
        NSString *fmt = NSLocalizedString(@"This action will rebuild the %1$@ Applications folder and the program launchers it contains from scratch. This will result in the deletion of the %2$@ folder and any changes that you might have made to its contents. Are you sure you want to do this?", @"");
        [alert setInformativeText:[NSString stringWithFormat:fmt, [[self class] getCellarID], disp]];
        [alert addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
        [alert addButtonWithTitle:NSLocalizedString(@"Rebuild", @"")];
        
        if ([alert runModal] == NSAlertSecondButtonReturn) {
            NSMenu *menu = [[[NSMenu alloc] initWithTitle:@""] autorelease];
            NSMenuItem *loading = [[[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Loading…", @"") action:nil keyEquivalent:@""] autorelease];
            [loading setEnabled:NO];
            [menu addItem:loading];
            [self createProgramsMenuFromSubmenu:menu hasPrograms:NO];
            [self setLaunchers:nil];
            
            NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:programsFolder];
            for (NSString *subpath in enumerator) {
                NSString *fullPath = [programsFolder stringByAppendingPathComponent:subpath];
                CXBundle *b = [CXBundle bundleWithURL:[NSURL fileURLWithPath:fullPath]];
                if (b) {
                    if ([b objectForInfoDictionaryKey:@"CrossOverHelperCommand"]) {
                        [fm removeItemAtPath:fullPath error:NULL];
                    }
                    [enumerator skipDescendants];
                }
            }
            
            NSDirectoryEnumerator *cleanupEnum = [fm enumeratorAtPath:programsFolder];
            for (NSString *subpath in cleanupEnum) {
                NSString *fullPath = [programsFolder stringByAppendingPathComponent:subpath];
                [fm removeFolderIfEmpty:fullPath upTo:programsFolder];
            }
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MostRecentCXFBMenuPlist"];
            [self performSelectorOnMainThread:@selector(queueRefreshPrograms:) withObject:@YES waitUntilDone:YES];
        }
    }
}

- (BOOL)validateMenuItem:(id)arg1 {
    NSMenuItem *menuItem = (NSMenuItem *)arg1;
    BOOL sheetOpen = [NSApp modalWindow] != nil || [[[self mainWindowController] window] attachedSheet] != nil;
    if ([self menusEnabled] && !sheetOpen) {
        SEL act = [menuItem action];
        if (act == @selector(rebuildMenus:)) {
            if (rebuildingPrograms) {
                [menuItem setTitle:NSLocalizedString(@"Rebuilding Programs…", @"")];
                return NO;
            } else {
                [menuItem setTitle:NSLocalizedString(@"Clear and Rebuild Programs…", @"")];
                return YES;
            }
        } else if (act == @selector(refreshPrograms:)) {
            return !rebuildingPrograms;
        } else if (act == @selector(repairBottles:) || act == @selector(repairBottlesDialog:)) {
            id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
            return [[sharedCollection bottleList] count] > 0;
        }
        return YES;
    }
    
    NSString *menuTitle = [[menuItem menu] title];
    if ([menuTitle isEqualToString:@"Help"] || [menuTitle isEqualToString:@"Edit"]) {
        return [menuItem action] != @selector(showMainWindow:);
    }
    return NO;
}

- (void)refreshProgramsAndAssociationsInBackground:(id)arg1 {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    BOOL forceUpdate = [[arg1 objectAtIndex:0] boolValue];
    BOOL forceCreate = [[arg1 objectAtIndex:1] boolValue];
    
    @synchronized(associationsLock) {
        BOOL folderUpdated = [self updateApplicationFolder:forceUpdate];
        NSNumber *menuArg = [NSNumber numberWithBool:folderUpdated | forceCreate];
        [self performSelectorOnMainThread:@selector(createProgramsMenu:) withObject:menuArg waitUntilDone:YES];
        [self refreshAssociations:forceUpdate];
    }
    
    [self performSelectorOnMainThread:@selector(setRebuildingPrograms:) withObject:@NO waitUntilDone:NO];
    [pool release];
}

- (void)setRebuildingPrograms:(id)arg1 {
    rebuildingPrograms = [arg1 boolValue];
    NSMenu *mainMenu = [NSApp mainMenu];
    [mainMenu update];
    for (NSMenuItem *item in [mainMenu itemArray]) {
        [[item submenu] update];
    }
}

- (void)refreshPrograms:(id)arg1 {
    [self setRebuildingPrograms:@YES];
    BOOL updateForced = refreshProgramsUpdateIsForced;
    BOOL createForced = refreshProgramsCreateIsForced;
    refreshProgramsUpdateIsForced = NO;
    refreshProgramsCreateIsForced = NO;
    NSArray *args = [NSArray arrayWithObjects:[NSNumber numberWithBool:updateForced], [NSNumber numberWithBool:createForced], nil];
    [NSThread detachNewThreadSelector:@selector(refreshProgramsAndAssociationsInBackground:) toTarget:self withObject:args];
}

- (void)queueRefreshPrograms:(id)arg1 {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshPrograms:) object:nil];
    [self setRebuildingPrograms:@YES];
    if (arg1) {
        refreshProgramsCreateIsForced = YES;
        if ([arg1 isKindOfClass:[NSNumber class]] && [arg1 boolValue]) {
            refreshProgramsUpdateIsForced = YES;
        }
    }
    [self performSelector:@selector(refreshPrograms:) withObject:nil afterDelay:0.5];
}

- (void)watchMenuPLists {
    id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
    NSArray *bottleList = [sharedCollection bottleList];
    
    if (_observedBottles) {
        NSArray *observedCopy = [_observedBottles copy];
        for (id bottle in observedCopy) {
            if (![bottleList containsObject:bottle]) {
                [bottle removeObserver:self forKeyPath:@"menuChangedTime"];
                [_observedBottles removeObject:bottle];
            }
        }
        [observedCopy release];
    } else {
        [self setObservedBottles:[NSMutableArray array]];
    }
    
    for (id bottle in bottleList) {
        if (![_observedBottles containsObject:bottle]) {
            [_observedBottles addObject:bottle];
            [bottle addObserver:self forKeyPath:@"menuChangedTime" options:0 context:NULL];
        }
    }
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    if ([arg1 isEqualToString:@"menuChangedTime"]) {
        [self performSelectorOnMainThread:@selector(queueRefreshPrograms:) withObject:nil waitUntilDone:YES];
    } else {
        [super observeValueForKeyPath:arg1 ofObject:arg2 change:arg3 context:arg4];
    }
}

- (id)getMenuPList {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSMutableArray *bottles = [NSMutableArray array];
    [self performSelectorOnMainThread:@selector(duplicateBottleList:) withObject:bottles waitUntilDone:YES];

    for (id bottle in bottles) {
        NSString *plistPath = [NSString stringWithFormat:@"%@/desktopdata/cxmenu/cxmenu_macosx.plist", [bottle winePrefix]];
        if (![fm fileExistsAtPath:plistPath]) continue;
        NSDate *modDate = [[fm attributesOfItemAtPath:[plistPath stringByResolvingSymlink] error:NULL] fileModificationDate];
        NSData *data = [NSData dataWithContentsOfFile:plistPath];
        // Mutable containers: updateApplicationFolder: prunes subtrees in place.
        NSMutableDictionary *plist = data ? [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:NULL error:NULL] : nil;
        if (![plist isKindOfClass:[NSDictionary class]] || ![plist count]) continue;
        NSString *firstKey = [[plist allKeys] objectAtIndex:0];
        if (modDate) {
            [[plist objectForKey:firstKey] setObject:modDate forKey:@"moddate"];
        }
        [result addEntriesFromDictionary:plist];
    }
    return result;
}

- (void)addProgramsFromMenuPlist:(id)arg1 bottle:(id)arg2 toDictionary:(id)arg3 atPath:(id)arg4 {
    [arg1 enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key hasSuffix:@"/"]) {
            NSDictionary *children = [obj objectForKey:@"Children"];
            NSArray *newPath = [arg4 arrayByAddingObject:key];
            [self addProgramsFromMenuPlist:children bottle:arg2 toDictionary:arg3 atPath:newPath];
        } else {
            NSArray *newPath = [arg4 arrayByAddingObject:key];
            NSMutableDictionary *entry = [arg3 objectForKey:newPath];
            if (!entry) {
                entry = [NSMutableDictionary dictionary];
                [arg3 setObject:entry forKey:newPath];
            }
            [entry setObject:obj forKey:arg2];
        }
    }];
}

- (void)addProgramsFromMenuPlist:(id)arg1 bottle:(id)arg2 toDictionary:(id)arg3 {
    [self addProgramsFromMenuPlist:arg1 bottle:arg2 toDictionary:arg3 atPath:[NSArray array]];
}

- (BOOL)updateApplicationFolder:(BOOL)arg1 {
    if (inUpdateApplicationFolder) {
        return NO;
    }
    inUpdateApplicationFolder = YES;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSMutableDictionary *newMenu = [self getMenuPList];
    NSDictionary *saved = [defaults objectForKey:@"MostRecentCXFBMenuPlist"];
    NSMutableDictionary *oldMenu = saved ? [(NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFPropertyListRef)saved, kCFPropertyListMutableContainers) autorelease] : nil;
    [defaults setObject:newMenu forKey:@"MostRecentCXFBMenuPlist"];

    // Flatten both menus into { menu path : { bottle name : entry } }.
    NSMutableDictionary *newPrograms = [NSMutableDictionary dictionary];
    NSMutableDictionary *oldPrograms = [NSMutableDictionary dictionary];
    NSMutableDictionary *nameToTag = [NSMutableDictionary dictionary];
    NSMutableSet *tags = [NSMutableSet setWithArray:[newMenu allKeys]];
    [tags addObjectsFromArray:[oldMenu allKeys]];
    for (NSString *tag in tags) {
        NSDictionary *oldBottle = [oldMenu objectForKey:tag];
        NSMutableDictionary *oldStart = oldBottle ? [oldBottle valueForKeyPath:@"Children.StartMenu/.Children"] : [NSMutableDictionary dictionary];
        NSString *bottleName = [oldBottle objectForKey:@"Description"];
        NSDictionary *newBottle = [newMenu objectForKey:tag];
        NSMutableDictionary *newStart = [NSMutableDictionary dictionary];
        if (newBottle) {
            newStart = [newBottle valueForKeyPath:@"Children.StartMenu/.Children"];
            bottleName = [newBottle objectForKey:@"Description"];
            if (bottleName) [nameToTag setObject:tag forKey:bottleName];
        }
        if (!bottleName) continue;

        // Programs/, Windows Applications/Programs/, Windows Applications/ and the
        // rest of the Start Menu, each without its StartUp/ folder.
        NSArray *subtrees = @[@"Programs/.Children",
                              @"Windows Applications/.Children.Programs/.Children",
                              @"Windows Applications/.Children"];
        NSArray *prune = @[@[@"Programs/"], @[], @[@"Windows Applications/"]];
        for (NSUInteger i = 0; i < [subtrees count]; i++) {
            NSString *keyPath = [subtrees objectAtIndex:i];
            NSMutableDictionary *newSub = [newStart valueForKeyPath:keyPath];
            NSMutableDictionary *oldSub = [oldStart valueForKeyPath:keyPath];
            if (i == 2) {
                [newSub removeObjectForKey:@"Programs/"];
                [oldSub removeObjectForKey:@"Programs/"];
            }
            [oldSub removeObjectForKey:@"StartUp/"];
            [newSub removeObjectForKey:@"StartUp/"];
            if (newSub) [self addProgramsFromMenuPlist:newSub bottle:bottleName toDictionary:newPrograms];
            if (oldSub) [self addProgramsFromMenuPlist:oldSub bottle:bottleName toDictionary:oldPrograms];
            for (NSString *key in [prune objectAtIndex:i]) {
                [oldStart removeObjectForKey:key];
                [newStart removeObjectForKey:key];
            }
        }
        if (newStart) [self addProgramsFromMenuPlist:newStart bottle:bottleName toDictionary:newPrograms];
        if (oldStart) [self addProgramsFromMenuPlist:oldStart bottle:bottleName toDictionary:oldPrograms];
    }

    // Index the helper apps that already exist, by bundle identifier.
    NSMutableDictionary *helpersByID = [NSMutableDictionary dictionary];
    NSMutableSet *unclaimedHelpers = [NSMutableSet set];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *programsFolder = [[self class] getProgramsFolder];
    NSDirectoryEnumerator *enumerator = [fm enumeratorAtURL:[NSURL fileURLWithPath:programsFolder]
                                 includingPropertiesForKeys:@[NSURLIsPackageKey]
                                                    options:NSDirectoryEnumerationSkipsPackageDescendants
                                               errorHandler:nil];
    for (NSURL *url in enumerator) {
        NSNumber *isPackage = nil;
        if (![url getResourceValue:&isPackage forKey:NSURLIsPackageKey error:NULL] || ![isPackage boolValue]) continue;
        CXBundle *bundle = [CXBundle bundleWithURL:url];
        if (![bundle objectForInfoDictionaryKey:@"CrossOverHelperCommand"]) continue;
        NSString *bundleID = [bundle bundleIdentifier];
        if (!bundleID) continue;
        NSMutableSet *urls = [helpersByID objectForKey:bundleID];
        if (!urls) {
            urls = [NSMutableSet set];
            [helpersByID setObject:urls forKey:bundleID];
        }
        [urls addObject:url];
        [unclaimedHelpers addObject:url];
    }
    CFArrayRef handlers = LSCopyAllRoleHandlersForContentType(CFSTR("com.codeweavers.CrossOverHelper.AppDummyType"), kLSRolesAll);
    for (NSString *bundleID in (NSArray *)handlers) {
        NSURL *url = [[NSWorkspace sharedWorkspace] URLForApplicationWithBundleIdentifier:bundleID];
        CXBundle *bundle = url ? [CXBundle bundleWithURL:url] : nil;
        if (![bundle objectForInfoDictionaryKey:@"CrossOverHelperCommand"]) continue;
        NSMutableSet *urls = [helpersByID objectForKey:bundleID];
        if (!urls) {
            urls = [NSMutableSet set];
            [helpersByID setObject:urls forKey:bundleID];
        }
        [urls addObject:url];
    }
    if (handlers) CFRelease(handlers);

    BOOL changedAny = NO;
    NSMutableSet *touchedFolders = [NSMutableSet set];
    NSMutableSet *paths = [NSMutableSet setWithArray:[newPrograms allKeys]];
    [paths addObjectsFromArray:[oldPrograms allKeys]];
    NSString *nameKey = (NSString *)kCFBundleNameKey;
    for (NSArray *path in paths) {
        NSArray *namePath = [path subarrayWithRange:NSMakeRange(0, [path count] - 1)];
        NSURL *folderURL = [NSURL fileURLWithPathComponents:[@[programsFolder] arrayByAddingObjectsFromArray:namePath]];
        NSDictionary *newByBottle = [newPrograms objectForKey:path];
        NSDictionary *oldByBottle = [oldPrograms objectForKey:path];
        NSUInteger newCount = [newByBottle count];
        NSUInteger oldCount = [oldByBottle count];
        // Helpers get a "(bottle)" suffix only while several bottles share the
        // same menu path; when that changes, existing helpers must be renamed.
        BOOL sameNaming = (newCount > 1) == (oldCount > 1);
        NSMutableSet *bottles = [NSMutableSet setWithArray:[newByBottle allKeys]];
        [bottles addObjectsFromArray:[oldByBottle allKeys]];

        for (NSString *bottle in bottles) {
            NSString *idBase = [NSString stringWithFormat:@"com.codeweavers.CrossOverHelper.%@.%@", bottle, [path componentsJoinedByString:@"."]];
            NSString *idTagged = [idBase stringByAppendingFormat:@" (%@)", bottle];
            NSMutableSet *existing = [NSMutableSet set];
            for (NSString *candidate in @[idBase, idTagged, [self shortenedBundleID:idBase], [self shortenedBundleID:idTagged]]) {
                NSSet *urls = [helpersByID objectForKey:candidate];
                if (urls) [existing unionSet:urls];
            }

            NSDictionary *newEntry = [newByBottle objectForKey:bottle];
            NSDictionary *oldEntry = [oldByBottle objectForKey:bottle];
            if (!newEntry) {
                if (oldEntry) [touchedFolders addObject:folderURL];
                continue;
            }
            [unclaimedHelpers minusSet:existing];

            NSMutableDictionary *exportDict = [[newEntry mutableCopy] autorelease];
            NSMutableDictionary *extra = [NSMutableDictionary dictionaryWithCapacity:4];
            [extra setObject:namePath forKey:@"namepath"];
            [extra setObject:bottle forKey:@"bottlename"];
            if ([nameToTag objectForKey:bottle]) [extra setObject:[nameToTag objectForKey:bottle] forKey:@"bottletag"];
            [extra setObject:[path lastObject] forKey:@"origname"];
            [exportDict addEntriesFromDictionary:extra];
            NSString *name = [path lastObject];
            if (newCount >= 2) {
                name = [self makeBottleTaggedName:name withBottleName:bottle];
            }

            BOOL entryChanged = arg1 || !oldEntry || ![newEntry isEqualToDictionary:oldEntry];
            changedAny |= entryChanged;
            // A program the user deleted (old entry, no helper) is not recreated.
            BOOL needExport = (oldEntry == nil);

            for (NSURL *url in existing) {
                NSString *currentName = [[url lastPathComponent] stringByDeletingPathExtension];
                if (sameNaming && !entryChanged) {
                    needExport = NO;
                    continue;
                }
                NSURL *plistURL = [[url URLByAppendingPathComponent:@"Contents"] URLByAppendingPathComponent:@"Info.plist"];
                NSData *data = [NSData dataWithContentsOfURL:plistURL options:0 error:NULL];
                NSPropertyListFormat format = NSPropertyListXMLFormat_v1_0;
                NSError *error = nil;
                NSMutableDictionary *plist = nil;
                NSString *bundleName = nil;
                BOOL renamedByUser = YES;
                if (data) {
                    plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:&format error:&error];
                    if (plist) {
                        bundleName = [plist objectForKey:nameKey];
                        renamedByUser = [bundleName compare:currentName] != NSOrderedSame;
                    } else {
                        NSLog(@"Failed to parse %@: %@\n", plistURL, error);
                    }
                }

                if (entryChanged) {
                    BOOL exported = [self exportProgram:currentName bundleName:name withDictionary:exportDict
                                               toFolder:[[url URLByDeletingLastPathComponent] path]];
                    if (exported) needExport = NO;
                } else if (plist) {
                    if ([bundleName isEqualToString:name]) {
                        needExport = NO;
                    } else {
                        [plist setObject:name forKey:nameKey];
                        NSData *out = [NSPropertyListSerialization dataWithPropertyList:plist format:format options:0 error:&error];
                        if (!out) {
                            NSLog(@"Failed to serialize %@: %@", plistURL, error);
                        } else if (![out writeToURL:plistURL options:NSDataWritingAtomic error:&error]) {
                            NSLog(@"Failed to write %@: %@", plistURL, error);
                        } else {
                            needExport = NO;
                            changedAny = YES;
                        }
                    }
                }

                // Keep the file name in step with the display name unless the user renamed it.
                if (!renamedByUser && [currentName compare:name] != NSOrderedSame) {
                    NSURL *target = [[[url URLByDeletingLastPathComponent] URLByAppendingPathComponent:name] URLByAppendingPathExtension:@"app"];
                    changedAny |= [fm moveItemAtURL:url toURL:target error:NULL];
                }
            }

            if (needExport) {
                NSString *folder = [folderURL path];
                [self exportProgram:name bundleName:nil withDictionary:exportDict toFolder:folder];
                NSString *appPath = [[folder stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"app"];
                [unclaimedHelpers removeObject:[NSURL fileURLWithPath:appPath isDirectory:YES]];
                changedAny = YES;
            }
        }
    }

    // Helpers nobody claimed belong to programs that are gone.
    for (NSURL *url in unclaimedHelpers) {
        if ([fm removeItemAtURL:url error:NULL]) {
            [touchedFolders addObject:[url URLByDeletingLastPathComponent]];
        }
        changedAny = YES;
    }
    for (NSURL *folder in touchedFolders) {
        [fm removeFolderIfEmpty:[folder path] upTo:programsFolder];
    }

    [pool release];
    inUpdateApplicationFolder = NO;
    return changedAny;
}

- (id)shortenedBundleID:(id)arg1 {
    NSString *bundleID = (NSString *)arg1;
    NSArray *parts = [bundleID componentsSeparatedByString:@"."];
    if ([parts count] >= 5) {
        NSString *tag = [parts objectAtIndex:3];
        NSArray *sub = [parts subarrayWithRange:NSMakeRange(4, [parts count] - 4)];
        NSString *joined = [sub componentsJoinedByString:@"."];
        NSString *p0 = [parts objectAtIndex:0];
        NSString *p1 = [parts objectAtIndex:1];
        NSString *p2 = [parts objectAtIndex:2];
        NSString *tagMD5 = [tag MD5];
        NSString *joinedMD5 = [joined MD5];
        NSArray *newParts = [NSArray arrayWithObjects:p0, p1, p2, tagMD5, joinedMD5, nil];
        bundleID = [newParts componentsJoinedByString:@"."];
    }
    if ([bundleID length] >= 113) {
        NSString *prefix = [bundleID substringToIndex:56];
        NSString *suffix = [bundleID substringFromIndex:[bundleID length] - 55];
        bundleID = [NSString stringWithFormat:@"%@-%@", prefix, suffix];
    }
    return bundleID;
}

- (void)createProgramsMenuFromSubmenu:(id)arg1 hasPrograms:(BOOL)arg2 {
    NSMenu *menu = (NSMenu *)arg1;
    id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
    NSUInteger count = [[sharedCollection bottleList] count];
    
    if (count > 0) {
        if (arg2) {
            [menu addItem:[NSMenuItem separatorItem]];
        }
        NSMenuItem *runCmd = [[[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Run Command…", @"") action:@selector(runCommand:) keyEquivalent:@""] autorelease];
        [menu addItem:runCmd];
    } else {
        NSMenuItem *noSoft = [[[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"No Software is Installed", @"") action:nil keyEquivalent:@""] autorelease];
        [noSoft setEnabled:NO];
        [menu addItem:noSoft];
    }
    [self setProgramsMenu:menu];
}

- (void)createProgramsMenu:(id)arg1 {
    NSMenu *menu = [[[NSMenu alloc] initWithTitle:@""] autorelease];
    NSString *folder = [[self class] getProgramsFolder];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:folder]) {
        NSString *resolved = [folder stringByResolvingSymlinksInPath];
        NSDictionary *attrs = [fm attributesOfItemAtPath:resolved error:NULL];
        NSDate *modDate = [attrs fileModificationDate];
        BOOL forced = [arg1 boolValue];
        
        if (!forced && [modDate isEqualToDate:programsMenuUpdateDate]) {
            return;
        }
        
        [programsMenuUpdateDate release];
        programsMenuUpdateDate = [modDate retain];
        
        LauncherFolder *lf = [[[LauncherFolder alloc] initWithName:nil] autorelease];
        [self addLaunchersInDir:folder toFolder:lf];
        [self addLauncherItems:[lf items] toMenu:menu];
        [self setLaunchers:[lf items]];
        
        [self createProgramsMenuFromSubmenu:menu hasPrograms:([menu numberOfItems] > 0)];
    } else {
        [programsMenuUpdateDate release];
        programsMenuUpdateDate = [[NSDate distantPast] retain];
        [self setLaunchers:[NSArray array]];
        [self createProgramsMenuFromSubmenu:menu hasPrograms:NO];
    }
}

// Mirrors a Programs folder into launcher items. Each file is visited once by
// identity (links also under their target's), helper bundles become launchers
// and subfolders with launchers become folders. Bundles and folders keep the
// path the user sees, not the link target.
- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2 skippingFiles:(id)arg3 {
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:arg1 error:NULL];
    for (NSString *item in contents) {
        @autoreleasepool {
            NSString *path = [arg1 stringByAppendingPathComponent:item];
            NSURL *url = [NSURL fileURLWithPath:path];
            NSArray *keys = [NSArray arrayWithObjects:NSURLFileResourceIdentifierKey, NSURLIsSymbolicLinkKey, NSURLIsDirectoryKey, NSURLIsPackageKey, nil];
            NSDictionary *values = [url resourceValuesForKeys:keys error:NULL];
            id identifier = [values objectForKey:NSURLFileResourceIdentifierKey];
            if (!identifier || [arg3 containsObject:identifier]) {
                continue;
            }
            [arg3 addObject:identifier];
            if ([[values objectForKey:NSURLIsSymbolicLinkKey] boolValue]) {
                values = [[url URLByResolvingSymlinksInPath] resourceValuesForKeys:keys error:NULL];
                identifier = [values objectForKey:NSURLFileResourceIdentifierKey];
                if (!identifier || [arg3 containsObject:identifier]) {
                    continue;
                }
                [arg3 addObject:identifier];
            }
            if (![[values objectForKey:NSURLIsDirectoryKey] boolValue]) {
                continue;
            }
            if ([[values objectForKey:NSURLIsPackageKey] boolValue]) {
                CXBundle *bundle = [CXBundle bundleWithURL:url];
                if (!bundle) {
                    continue;
                }
                BOOL bottleHelper = [bundle objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"] &&
                                    [bundle objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
                if (bottleHelper || [bundle objectForInfoDictionaryKey:@"CrossOverHelperCommand"]) {
                    [arg2 addLauncherItem:[LauncherApp launcherWithURL:url]];
                }
            } else {
                LauncherDiskFolder *folder = [LauncherDiskFolder launcherWithFolderURL:url];
                [self addLaunchersInDir:path toFolder:folder skippingFiles:arg3];
                if ([[folder items] count] != 0) {
                    [arg2 addLauncherItem:folder];
                }
            }
        }
    }
}

- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2 {
    NSMutableSet *skip = [NSMutableSet set];
    [self addLaunchersInDir:arg1 toFolder:arg2 skippingFiles:skip];
}

- (void)addLauncherItems:(id)arg1 toMenu:(id)arg2 {
    for (LauncherItem *item in (NSArray *)arg1) {
        NSMenuItem *mi = [[[NSMenuItem alloc] init] autorelease];
        if ([item isLeaf]) {
            NSImage *icon = [[item icon] copy];
            if (icon) {
                [icon setSize:NSMakeSize(16.0, 16.0)];
                [mi setImage:icon];
                [icon release];
            }
            [mi setTarget:self];
            [mi setAction:@selector(launchHelper:)];
            if ([item respondsToSelector:@selector(url)]) {
                NSURL *u = [(id)item url];
                [mi setRepresentedObject:@{@"Helper": [u path] ?: @""}];
                [mi setTitle:[[[u lastPathComponent] stringByDeletingPathExtension] ?: @"" stringByReplacingOccurrencesOfString:@"_" withString:@" "]];
            } else {
                [mi setTitle:[item name] ?: @""];
            }
        } else {
            NSMenu *sub = [[[NSMenu alloc] init] autorelease];
            if ([item respondsToSelector:@selector(items)]) {
                [self addLauncherItems:[(id)item items] toMenu:sub];
            }
            [mi setSubmenu:sub];
            if ([item respondsToSelector:@selector(url)]) {
                NSURL *u = [(id)item url];
                [mi setTitle:[[u lastPathComponent] stringByDeletingPathExtension] ?: @""];
            } else {
                [mi setTitle:[item name] ?: @""];
            }
        }
        [arg2 addItem:mi];
    }
}

- (void)duplicateBottleList:(id)arg1 {
    if (![NSThread isMainThread]) {
        [[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd object:self file:@"CXServerCrossOver.m" lineNumber:1440 description:@"Main thread method or function called on non-main thread"];
    }
    id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
    [arg1 setArray:[sharedCollection bottleList]];
}

- (id)combinedAssociationsPropertyListLatestDate:(id *)arg1 {
    if (associationPlist && associationPlistDate) {
        if (arg1) *arg1 = [[associationPlistDate retain] autorelease];
        return associationPlist;
    }

    NSMutableDictionary *combined = [NSMutableDictionary dictionary];
    NSDate *latest = [NSDate distantPast];
    NSMutableArray *bottles = [NSMutableArray array];
    [self performSelectorOnMainThread:@selector(duplicateBottleList:) withObject:bottles waitUntilDone:YES];

    for (id bottle in bottles) {
        NSString *assocPath = [NSString stringWithFormat:@"%@/desktopdata/cxassoc/cxassoc_macosx.plist", [bottle winePrefix]];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:[assocPath stringByResolvingSymlink] error:NULL];
        if (!attrs) continue;
        NSDate *modDate = [attrs fileModificationDate];
        if ([modDate isGreaterThan:latest]) {
            latest = [[modDate copy] autorelease];
        }
        NSData *data = [NSData dataWithContentsOfFile:assocPath];
        if (!data) continue;
        NSError *error = nil;
        id plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:&error];
        if (plist) {
            if ([plist isKindOfClass:[NSDictionary class]]) {
                [combined addEntriesFromDictionary:plist];
            }
        } else {
            NSLog(@"Failed to parse cxassoc plist %@: %@\n", assocPath, error);
        }
    }

    [associationPlist release];
    associationPlist = [combined copy];
    [associationPlistDate release];
    associationPlistDate = [latest copy];
    if (arg1) *arg1 = [[associationPlistDate retain] autorelease];
    return associationPlist;
}

- (void)addDocumentTypeDictionary:(id)arg1 forBottle:(id)arg2 toBundleArray:(id)arg3 andResourcesDir:(id)arg4 {
    NSFileManager *fm = [[NSFileManager alloc] init];
    [fm setDelegate:self];
    NSString *ext = [[arg1 objectForKey:@"CFBundleTypeExtensions"] objectAtIndex:0];
    NSString *icnsPath = [[arg4 stringByAppendingPathComponent:ext] stringByAppendingPathExtension:@"icns"];

    // Prefer the bottle-relative icon, then the plain icon source, then the generic document icon.
    NSString *robustIcon = [arg1 objectForKey:@"RobustIconSourceFile"];
    if (robustIcon) {
        NSString *winePrefix = nil;
        if (arg2) {
            winePrefix = [[[[CXSetupLib bottleCollectionClass] sharedCollection] bottleWithName:arg2] winePrefix];
        }
        if (winePrefix) {
            robustIcon = [robustIcon stringByReplacingOccurrencesOfString:@"%WINEPREFIX%" withString:winePrefix options:NSAnchoredSearch range:NSMakeRange(0, [robustIcon length])];
        } else if ([robustIcon hasPrefix:@"%WINEPREFIX%"]) {
            robustIcon = nil;
        }
        if (robustIcon) {
            NSString *source = [robustIcon stringByReplacingOccurrencesOfString:@"%CX_ROOT%" withString:[(CXApplication *)NSApp crossOverRoot] options:NSAnchoredSearch range:NSMakeRange(0, [robustIcon length])];
            if ([fm fileExistsAtPath:source] &&
                [self createIcnsFile:[NSURL fileURLWithPath:icnsPath] fromImageFile:[NSURL fileURLWithPath:source] forApp:NO]) {
                goto done;
            }
        }
    }
    {
        NSString *icon = [arg1 objectForKey:@"IconSourceFile"];
        if (icon) {
            NSString *source = [icon stringByReplacingOccurrencesOfString:@"%CX_ROOT%" withString:[(CXApplication *)NSApp crossOverRoot] options:NSAnchoredSearch range:NSMakeRange(0, [icon length])];
            if ([fm fileExistsAtPath:source] &&
                [self createIcnsFile:[NSURL fileURLWithPath:icnsPath] fromImageFile:[NSURL fileURLWithPath:source] forApp:NO]) {
                goto done;
            }
        }
        NSString *generic = [[NSBundle mainBundle] pathForResource:@"genericDocumentIcon" ofType:@"icns"];
        BOOL isDir = NO;
        if ([fm fileExistsAtPath:icnsPath isDirectory:&isDir] && !isDir) {
            [fm removeItemAtPath:icnsPath error:NULL];
        }
        if (generic) {
            [fm copyItemAtPath:generic toPath:icnsPath error:NULL];
            [fm makeWritableAtPath:icnsPath recursively:NO];
        }
    }
done:
    [arg3 addObject:arg1];
    [fm release];
}

- (void)informSystemOfUpdatedApp:(id)arg1 {
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm setAttributes:@{NSFileModificationDate: [NSDate date]} ofItemAtPath:arg1 error:NULL];
    [[NSWorkspace sharedWorkspace] noteFileSystemChanged:arg1];
    NSURL *url = [NSURL fileURLWithPath:arg1];
    LSRegisterURL((CFURLRef)url, true);
}

- (void)adjustProgramHelpersForChangedAssociations:(id)arg1 {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *programsFolder = [[self class] getProgramsFolder];
    NSMutableDictionary *helpersByTag = [NSMutableDictionary dictionary];
    NSMutableDictionary *namesByTag = [NSMutableDictionary dictionary];

    // Index the existing per-program helper apps by bottle tag and menu path.
    NSDirectoryEnumerator *enumerator = [fm enumeratorAtPath:programsFolder];
    NSString *relativePath;
    while ((relativePath = [enumerator nextObject])) {
        NSString *fullPath = [programsFolder stringByAppendingPathComponent:relativePath];
        NSString *plistPath = [[fullPath stringByAppendingPathComponent:@"Contents"] stringByAppendingPathComponent:@"Info.plist"];
        BOOL isDir = NO;
        if (![fm fileExistsAtPath:plistPath isDirectory:&isDir] || isDir) continue;
        if (![fm isReadableFileAtPath:plistPath] || ![fm isWritableFileAtPath:plistPath]) continue;
        [enumerator skipDescendants];

        NSData *data = [NSData dataWithContentsOfFile:plistPath];
        if (!data) continue;
        NSPropertyListFormat format = NSPropertyListXMLFormat_v1_0;
        NSMutableDictionary *plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:&format error:NULL];
        NSString *menuPath = [plist objectForKey:@"CrossOverHelperMenuPath"];
        NSString *tag = [plist objectForKey:@"CXHelperAppBottleTag"];
        if (!menuPath || !tag) continue;
        NSString *bottleName = [plist objectForKey:@"CXHelperAppBottleName"];
        if (bottleName) {
            [namesByTag setObject:bottleName forKey:tag];
        }
        NSMutableDictionary *helpers = [helpersByTag objectForKey:tag];
        if (!helpers) {
            helpers = [NSMutableDictionary dictionary];
            [helpersByTag setObject:helpers forKey:tag];
        }
        [helpers setObject:@{@"plist": plist,
                             @"menuPath": menuPath,
                             @"fullPath": fullPath,
                             @"plistFormat": [NSNumber numberWithUnsignedInteger:format]}
                    forKey:menuPath];
    }

    NSDictionary *menus = [self findMenusForAssociations:arg1];
    NSMutableSet *tags = [NSMutableSet setWithArray:[menus allKeys]];
    [tags addObjectsFromArray:[relateDocTypesToMenus allKeys]];

    for (NSString *tag in tags) {
        NSString *bottleName = [namesByTag objectForKey:tag];
        NSDictionary *extAssocs = [[arg1 objectForKey:tag] objectForKey:@"Extension Associations/"];
        if (!extAssocs) extAssocs = @{};
        NSDictionary *helpers = [helpersByTag objectForKey:tag];
        if (!helpers) continue;

        NSDictionary *oldMap = [relateDocTypesToMenus objectForKey:tag];
        if (!oldMap) oldMap = @{};
        NSDictionary *newMap = [menus objectForKey:tag];
        if (!newMap) newMap = @{};

        // Work out which extensions moved away from (removed) or onto (added) each menu entry.
        NSMutableSet *oldKeys = [NSMutableSet setWithArray:[oldMap allKeys]];
        NSMutableSet *newKeys = [NSMutableSet setWithArray:[newMap allKeys]];
        NSMutableSet *common = [[newKeys mutableCopy] autorelease];
        [common intersectSet:oldKeys];
        [oldKeys minusSet:common];
        [newKeys minusSet:common];
        for (NSString *ext in common) {
            if (![[oldMap objectForKey:ext] isEqualToString:[newMap objectForKey:ext]]) {
                [oldKeys addObject:ext];
                [newKeys addObject:ext];
            }
        }
        NSDictionary *removed = [oldMap dictionaryWithValuesForKeys:[oldKeys allObjects]];
        NSDictionary *added = [newMap dictionaryWithValuesForKeys:[newKeys allObjects]];
        if (![removed count] && ![added count]) continue;

        for (NSString *menuPath in helpers) {
            NSDictionary *info = [helpers objectForKey:menuPath];
            NSString *fullPath = [info objectForKey:@"fullPath"];
            NSString *contents = [fullPath stringByAppendingPathComponent:@"Contents"];
            NSString *resources = [contents stringByAppendingPathComponent:@"Resources"];
            NSString *plistPath = [contents stringByAppendingPathComponent:@"Info.plist"];
            NSMutableDictionary *plist = [info objectForKey:@"plist"];
            NSPropertyListFormat format = [[info objectForKey:@"plistFormat"] unsignedIntegerValue];

            NSArray *removedExts = [removed allKeysForObject:menuPath];
            NSArray *addedExts = [added allKeysForObject:menuPath];
            if (![removedExts count] && ![addedExts count]) continue;

            NSMutableArray *docTypes = [plist objectForKey:@"CFBundleDocumentTypes"];
            if (!docTypes) {
                if (![addedExts count]) continue;
                docTypes = [NSMutableArray arrayWithCapacity:[addedExts count]];
                [plist setObject:docTypes forKey:@"CFBundleDocumentTypes"];
            }

            NSMutableSet *removedSet = [NSMutableSet setWithCapacity:[removedExts count]];
            for (NSString *key in removedExts) {
                NSString *first = [[key componentsSeparatedByString:@"/"] objectAtIndex:0];
                if ([first length] > 1) {
                    [removedSet addObject:[[first substringFromIndex:1] lowercaseString]];
                }
            }

            BOOL changed = NO;
            for (NSInteger i = (NSInteger)[docTypes count] - 1; i >= 0; i--) {
                NSDictionary *docType = [docTypes objectAtIndex:i];
                NSArray *exts = [docType objectForKey:@"CFBundleTypeExtensions"];
                NSString *ext = [exts count] ? [[exts objectAtIndex:0] lowercaseString] : nil;
                if (ext && [removedSet containsObject:ext]) {
                    NSString *iconFile = [docType objectForKey:@"CFBundleTypeIconFile"];
                    if (iconFile) {
                        [fm removeItemAtPath:[[resources stringByAppendingPathComponent:iconFile] stringByAppendingPathExtension:@"icns"] error:NULL];
                    }
                    [docTypes removeObjectAtIndex:i];
                    changed = YES;
                }
            }
            for (NSString *key in addedExts) {
                NSDictionary *docType = [self getAssociationDictionaryForKey:key withExtensionAssociations:extAssocs];
                if (docType) {
                    [self addDocumentTypeDictionary:docType forBottle:bottleName toBundleArray:docTypes andResourcesDir:resources];
                    changed = YES;
                }
            }

            if (changed) {
                NSData *data = [NSPropertyListSerialization dataWithPropertyList:plist format:format options:0 error:NULL];
                if (data && [data writeToFile:plistPath atomically:YES]) {
                    [self informSystemOfUpdatedApp:fullPath];
                }
            }
        }
    }

    [relateDocTypesToMenus release];
    relateDocTypesToMenus = [menus retain];
    [[NSUserDefaults standardUserDefaults] setObject:relateDocTypesToMenus forKey:@"DocTypeToMenuPathMap"];
}

- (void)refreshAssociations:(BOOL)arg1 {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSFileManager *fm = [[NSFileManager alloc] init];
    [fm setDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastUpdated = [defaults objectForKey:@"LastUpdatedAssociations_v2"];

    [associationPlist release];
    associationPlist = nil;

    NSDate *latestDate = nil;
    NSDictionary *combined = [self combinedAssociationsPropertyListLatestDate:&latestDate];
    [self adjustProgramHelpersForChangedAssociations:combined];

    if (arg1 || ![latestDate isEqualToDate:lastUpdated]) {
        if ([combined count] && latestDate) {
            [defaults setObject:latestDate forKey:@"LastUpdatedAssociations_v2"];
        } else {
            [defaults removeObjectForKey:@"LastUpdatedAssociations_v2"];
        }

        // Every helper registered for the dummy type is a candidate for deletion;
        // setupHelperAppForBottleWithTag: removes the ones that are still wanted.
        CFArrayRef handlers = LSCopyAllRoleHandlersForContentType(CFSTR("com.codeweavers.CrossOverHelper.AppDummyType"), kLSRolesAll);
        [helpersToDelete release];
        helpersToDelete = [[NSMutableSet alloc] initWithArray:(NSArray *)handlers];

        for (NSString *tag in combined) {
            NSDictionary *bottleAssocs = [combined objectForKey:tag];
            [self setupHelperAppForBottleWithTag:tag
                                         andName:[bottleAssocs objectForKey:@"Description"]
                                   andExtensions:[bottleAssocs objectForKey:@"Extension Associations/"]];
        }

        if ([helpersToDelete count]) {
            NSArray *homeComponents = [[NSHomeDirectory() stringByStandardizingPath] pathComponents];
            BOOL deleted;
            do {
                deleted = NO;
                for (NSString *bundleID in helpersToDelete) {
                    NSString *path = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:bundleID];
                    if (!path || ![fm fileExistsAtPath:path]) continue;
                    NSArray *components = [[path stringByStandardizingPath] pathComponents];
                    NSUInteger n = MIN([components count], [homeComponents count]);
                    // Only delete helpers that live inside the user's home directory.
                    if ([[components subarrayWithRange:NSMakeRange(0, n)] isEqualToArray:homeComponents] &&
                        [fm isDeletableFileAtPath:path] &&
                        [fm removeItemAtPath:path error:NULL]) {
                        deleted = YES;
                    }
                }
            } while (deleted);
        }
        [helpersToDelete release];
        helpersToDelete = nil;
        if (handlers) CFRelease(handlers);
    }
    [fm release];
    [pool release];
}

- (id)getAssociationDictionaryForKey:(id)arg1 withExtensionAssociations:(id)arg2 {
    NSArray *parts = [(NSString *)arg1 componentsSeparatedByString:@"/"];
    // Only plain ".ext" keys and ".ext/open" verbs (when no plain key exists) qualify.
    for (NSUInteger i = 1; i < [parts count]; i++) {
        NSString *part = [parts objectAtIndex:i];
        if (![part length]) continue;
        if (i != 2) return nil;
        if ([part caseInsensitiveCompare:@"open"] != NSOrderedSame) return nil;
        if ([arg2 objectForKey:[parts objectAtIndex:0]]) return nil;
    }

    NSDictionary *entry = [arg2 objectForKey:arg1];
    NSString *ext = [entry objectForKey:@"Extension"];
    if (!ext) {
        ext = [[parts objectAtIndex:0] substringFromIndex:1];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
    if (ext) {
        [dict setObject:[NSArray arrayWithObject:ext] forKey:@"CFBundleTypeExtensions"];
        [dict setObject:ext forKey:@"CFBundleTypeIconFile"];
    }
    static NSString *const keyMap[][2] = {
        {@"Icon", @"IconSourceFile"},
        {@"RobustIcon", @"RobustIconSourceFile"},
        {@"Description", @"CFBundleTypeName"},
        {@"Application ID", @"CXAssocationAppID"},
        {@"Application Name", @"CXAssocationAppName"},
        {@"Command", @"CXAssocationCommand"},
        {@"Verb", @"CXAssocationVerb"},
        {@"Verb Name", @"CXAssocationVerbName"},
    };
    for (size_t i = 0; i < sizeof(keyMap) / sizeof(keyMap[0]); i++) {
        id value = [entry objectForKey:keyMap[i][0]];
        if (value) {
            [dict setObject:value forKey:keyMap[i][1]];
        }
    }
    [dict setObject:@"Editor" forKey:@"CFBundleTypeRole"];
    return dict;
}

- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3 {
    return [self setupHelperAppForBottleWithTag:arg1 andName:arg2 andExtensions:arg3 usingExistingHelper:nil];
}

- (id)findBestApplicationForDocType:(id)arg1 withProgramsDict:(id)arg2 {
    NSDictionary *best = @{@"rank": @0, @"menuPath": @""};
    NSString *appName = [arg1 objectForKey:@"CXAssocationAppName"];
    if (!appName) return best;

    for (NSString *key in [(NSDictionary *)arg2 keyEnumerator]) {
        NSDictionary *entry = [arg2 objectForKey:key];
        NSDictionary *children = [entry objectForKey:@"Children"];
        if (children) {
            NSDictionary *childBest = [self findBestApplicationForDocType:arg1 withProgramsDict:children];
            if ([[childBest objectForKey:@"rank"] intValue] > [[best objectForKey:@"rank"] intValue]) {
                best = childBest;
            }
            continue;
        }

        NSString *rawPath = [entry objectForKey:@"RawPath"];
        if ([appName compare:key options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return @{@"rank": @100, @"menuPath": rawPath};
        }
#define CX_CONSIDER(r) do { \
            NSInteger cxRank = (r); \
            if ([[best objectForKey:@"rank"] integerValue] < cxRank) { \
                best = @{@"rank": [NSNumber numberWithInteger:cxRank], @"menuPath": rawPath}; \
            } \
        } while (0)
        // Ranks: substring matches score 93-99, matches after trimming
        // version digits 83-90, shared words score their word count.
        if ([appName rangeOfString:key options:NSCaseInsensitiveSearch].location != NSNotFound) {
            CX_CONSIDER((int)((float)[key length] / (float)[appName length] * 5.0 + 0.5) + 93);
        }
        if ([key rangeOfString:appName options:NSCaseInsensitiveSearch].location != NSNotFound) {
            CX_CONSIDER((int)((float)[appName length] / (float)[key length] * 5.0 + 0.5) + 94);
        }
        NSString *trimmed = [[key stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]]
                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([appName compare:trimmed options:NSCaseInsensitiveSearch] == NSOrderedSame &&
            [[best objectForKey:@"rank"] integerValue] <= 89) {
            best = @{@"rank": @90, @"menuPath": rawPath};
        }
        if ([trimmed length] && [appName rangeOfString:trimmed options:NSCaseInsensitiveSearch].location != NSNotFound) {
            CX_CONSIDER((int)((float)[trimmed length] / (float)[appName length] * 5.0 + 0.5) + 84);
        }
        if ([trimmed length] && [trimmed rangeOfString:appName options:NSCaseInsensitiveSearch].location != NSNotFound) {
            CX_CONSIDER((int)((float)[appName length] / (float)[trimmed length] * 5.0 + 0.5) + 83);
        }
#undef CX_CONSIDER
        NSSet *appWords = [NSSet setWithArray:[appName componentsSeparatedByString:@" "]];
        NSMutableSet *keyWords = [NSMutableSet setWithArray:[key componentsSeparatedByString:@" "]];
        [keyWords intersectSet:appWords];
        NSInteger shared = (NSInteger)[keyWords count];
        if (shared >= 2 && (NSUInteger)shared > [appWords count] - 2 &&
            shared > [[best objectForKey:@"rank"] integerValue]) {
            best = @{@"rank": [NSNumber numberWithInteger:shared], @"menuPath": rawPath};
        }
    }
    return best;
}

- (id)findBestApplicationForDocType:(id)arg1 forBottle:(id)arg2 {
    NSDictionary *menu = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"MostRecentCXFBMenuPlist"];
    NSDictionary *copy = menu ? [(NSDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFPropertyListRef)menu, kCFPropertyListImmutable) autorelease] : nil;
    NSDictionary *startMenu = [[copy objectForKey:arg2] valueForKeyPath:@"Children.StartMenu/.Children"];
    NSDictionary *programs = [startMenu objectForKey:@"Programs/"];
    NSDictionary *winApps = [startMenu objectForKey:@"Windows Applications/"];

    NSDictionary *progBest = [self findBestApplicationForDocType:arg1 withProgramsDict:[programs objectForKey:@"Children"]];
    NSDictionary *winBest = [self findBestApplicationForDocType:arg1 withProgramsDict:[winApps objectForKey:@"Children"]];
    NSDictionary *best = [[progBest objectForKey:@"rank"] intValue] > [[winBest objectForKey:@"rank"] intValue] ? progBest : winBest;
    return [best objectForKey:@"menuPath"];
}

- (id)findMenusForAssociations:(id)arg1 {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *tag in (NSDictionary *)arg1) {
        NSDictionary *extAssocs = [[arg1 objectForKey:tag] objectForKey:@"Extension Associations/"];
        for (NSString *extKey in extAssocs) {
            NSDictionary *docType = [self getAssociationDictionaryForKey:extKey withExtensionAssociations:extAssocs];
            if (!docType) continue;
            NSString *menuPath = [self findBestApplicationForDocType:docType forBottle:tag];
            NSMutableDictionary *bottleMap = [result objectForKey:tag];
            if (!bottleMap) {
                bottleMap = [NSMutableDictionary dictionary];
                [result setObject:bottleMap forKey:tag];
            }
            if (menuPath) {
                [bottleMap setObject:menuPath forKey:extKey];
            }
        }
    }
    return result;
}

- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3 usingExistingHelper:(id)arg4 {
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
    [fm setDelegate:self];
    NSString *helperPath = arg4;
    NSString *bundleIdBase = nil;
    NSString *appName = nil;
    BOOL created = NO;

    if (helperPath) {
        if (![fm isWritableFileAtPath:helperPath]) {
            NSLog(@"Specified helper app %@ is not writable.\n", helperPath);
            return NO;
        }
    } else {
        bundleIdBase = [NSString stringWithFormat:@"com.codeweavers.CrossOverHelper.%@", arg1];
        [helpersToDelete removeObject:bundleIdBase];
        helperPath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:bundleIdBase];
        if (helperPath && ![fm isWritableFileAtPath:helperPath]) {
            helperPath = nil;
        }
        appName = [NSString stringWithFormat:@"CrossOver Helper (%@).app", arg2];

        if (!helperPath) {
            NSString *helpersDir = [[[self class] getAppSupportDir] stringByAppendingPathComponent:@"Helpers"];
            if (!helpersDir) {
                NSLog(@"Unable to determine directory for helpers.\n");
                return NO;
            }
            BOOL isDir = NO;
            if (![fm fileExistsAtPath:helpersDir isDirectory:&isDir]) {
                if (![fm createDirectoryAtPath:helpersDir attributes:nil recursively:YES]) {
                    NSLog(@"Couldn't create %@\n", helpersDir);
                    return NO;
                }
            } else if (!isDir) {
                NSLog(@"There's a file in the way; can't create directory %@\n", helpersDir);
                return NO;
            }

            helperPath = [helpersDir stringByAppendingPathComponent:appName];
            if (!helperPath) {
                NSLog(@"Unable to determine location of helper app.\n");
                return NO;
            }
            if ([fm fileExistsAtPath:helperPath]) {
                if (![[NSWorkspace sharedWorkspace] isFilePackageAtPath:helperPath]) {
                    NSLog(@"There's a file or non-package directory in the way; can't create helper app %@\n", helperPath);
                    return NO;
                }
            } else {
                NSString *archive = [[NSBundle mainBundle] pathForResource:@"Bottle Helper" ofType:@"cpbz2"];
                if (!archive) {
                    NSLog(@"Unable to determine helperAppContentsArchive.\n");
                    return NO;
                }
                if (![fm removeItemAtPath:[helperPath stringByAppendingPathComponent:@"Contents"] error:NULL] &&
                    ![fm createDirectoryAtPath:helperPath attributes:nil recursively:YES]) {
                    NSLog(@"Failed to create the associations helper app bundle dir '%@'\n", helperPath);
                    return NO;
                }
                CXTask *ditto = [CXTask launchedTaskWithLaunchPath:@"/usr/bin/ditto"
                                                         arguments:@[@"-x", @"--noqtn", @"--noacl", archive, helperPath]];
                [ditto waitUntilExit];
                if ([ditto terminationReason] == NSTaskTerminationReasonExit && [ditto terminationStatus] == 0) {
                    [fm makeWritableAtPath:helperPath recursively:YES];
                    created = YES;
                } else {
                    NSLog(@"Failed to extract the associations helper app archive '%@' to '%@'\n", archive, helperPath);
                    return NO;
                }
            }
        }
    }

    NSString *contents = [helperPath stringByAppendingPathComponent:@"Contents"];
    NSString *plistPath = [contents stringByAppendingPathComponent:@"Info.plist"];
    NSData *data = [NSData dataWithContentsOfFile:plistPath];
    NSPropertyListFormat format = NSPropertyListXMLFormat_v1_0;
    NSError *error = nil;
    NSMutableDictionary *plist = data ? [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:&format error:&error] : nil;
    if (!plist) {
        NSLog(@"Couldn't parse %@: %@\n", plistPath, error);
        if (created) [fm removeItemAtPath:helperPath error:NULL];
        return NO;
    }

    [plist setObject:arg2 forKey:@"CXHelperAppBottleName"];
    [plist setObject:arg1 forKey:@"CXHelperAppBottleTag"];
    [plist setObject:@43 forKey:@"CXHelperAppVersion"];
    if (arg4) {
        NSString *shortened = bundleIdBase ? [self shortenedBundleID:bundleIdBase] : nil;
        if (![plist valueForKey:(NSString *)kCFBundleIdentifierKey] && shortened) {
            [plist setObject:shortened forKey:(NSString *)kCFBundleIdentifierKey];
        }
        if (![plist valueForKey:(NSString *)kCFBundleNameKey] && appName) {
            [plist setObject:appName forKey:(NSString *)kCFBundleNameKey];
        }
    } else {
        [plist setObject:[self shortenedBundleID:bundleIdBase] forKey:(NSString *)kCFBundleIdentifierKey];
        [plist setObject:appName forKey:(NSString *)kCFBundleNameKey];
        if (![plist valueForKey:(NSString *)kUTImportedTypeDeclarationsKey]) {
            NSDictionary *dummyType = [NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.AppDummyType" forKey:(NSString *)kUTTypeIdentifierKey];
            [plist setObject:[NSArray arrayWithObject:dummyType] forKey:(NSString *)kUTImportedTypeDeclarationsKey];
        }
    }

    // Program helpers only take the extensions mapped to their own menu entry;
    // the bottle helper takes the ones that have no program.
    NSString *resources = [contents stringByAppendingPathComponent:@"Resources"];
    NSString *helperMenu = [plist objectForKey:@"CrossOverHelperMenuPath"];
    NSMutableArray *docTypes = [NSMutableArray arrayWithCapacity:[arg3 count] + 1];
    NSDictionary *menuMap = [relateDocTypesToMenus objectForKey:arg1];
    for (NSString *key in (NSDictionary *)arg3) {
        NSDictionary *docType = [self getAssociationDictionaryForKey:key withExtensionAssociations:arg3];
        if (!docType) continue;
        NSString *menuForExt = [menuMap objectForKey:key];
        BOOL take = helperMenu ? ([menuForExt length] && [menuForExt compare:helperMenu options:NSCaseInsensitiveSearch] == NSOrderedSame)
                               : ([menuForExt length] == 0);
        if (take) {
            [self addDocumentTypeDictionary:docType forBottle:arg2 toBundleArray:docTypes andResourcesDir:resources];
        }
    }
    if (!arg4) {
        [docTypes addObject:@{@"LSItemContentTypes": @[@"com.codeweavers.CrossOverHelper.AppDummyType"],
                              @"CFBundleTypeRole": @"Viewer"}];
    }
    [plist setObject:docTypes forKey:@"CFBundleDocumentTypes"];
    [plist setObject:@[@{@"CFBundleURLName": @"Email Address URL", @"CFBundleURLSchemes": @[@"mailto"]}]
              forKey:@"CFBundleURLTypes"];

    NSData *out = [NSPropertyListSerialization dataWithPropertyList:plist format:format options:0 error:&error];
    if (!out) {
        NSLog(@"Failed to serialize %@: %@\n", plistPath, error);
        if (created) [fm removeItemAtPath:helperPath error:NULL];
        return NO;
    }
    if (![out writeToFile:plistPath atomically:YES]) {
        NSLog(@"Failed to write %@\n", plistPath);
        if (created) [fm removeItemAtPath:helperPath error:NULL];
        return NO;
    }
    [self informSystemOfUpdatedApp:helperPath];
    return YES;
}

- (void)launchHelper:(id)arg1 {
    NSDictionary *dict = [arg1 representedObject];
    NSString *helper = [dict objectForKey:@"Helper"];
    if (helper) {
        [[NSWorkspace sharedWorkspace] launchApplication:helper];
    }
}

- (BOOL)exportProgram:(id)arg1 bundleName:(id)arg2 withDictionary:(id)arg3 toFolder:(id)arg4 {
    NSFileManager *fm = [[[NSFileManager alloc] init] autorelease];
    [fm setDelegate:self];
    NSString *displayName = arg2 ? arg2 : arg1;
    NSString *appPath = [[arg4 stringByAppendingPathComponent:arg1] stringByAppendingPathExtension:@"app"];
    NSString *contents = [appPath stringByAppendingPathComponent:@"Contents"];
    NSArray *namePath = [arg3 objectForKey:@"namepath"];
    NSString *bottleName = [arg3 objectForKey:@"bottlename"];
    NSString *bottleTag = [arg3 objectForKey:@"bottletag"];
    NSString *origName = [arg3 objectForKey:@"origname"];
    NSString *bundleID = [NSString stringWithFormat:@"com.codeweavers.CrossOverHelper.%@.%@",
                          bottleName, [[namePath arrayByAddingObject:origName] componentsJoinedByString:@"."]];

    if (![fm removeItemAtPath:contents error:NULL] &&
        ![fm createDirectoryAtPath:appPath attributes:nil recursively:YES]) {
        return NO;
    }
    NSString *archive = [[NSBundle mainBundle] pathForResource:@"Menu Helper" ofType:@"cpbz2"];
    if (!archive) return NO;
    NSTask *ditto = [NSTask launchedTaskWithLaunchPath:@"/usr/bin/ditto"
                                             arguments:@[@"-x", @"--noqtn", @"--noacl", archive, appPath]];
    [ditto waitUntilExit];
    if ([ditto terminationReason] != NSTaskTerminationReasonExit || [ditto terminationStatus] != 0) {
        return NO;
    }
    [fm makeWritableAtPath:appPath recursively:YES];

    // Icon: bottle-relative source, then the plain source, then the generic exe icon.
    NSString *resources = [contents stringByAppendingPathComponent:@"Resources"];
    NSString *icnsPath = [resources stringByAppendingPathComponent:@"CrossOverHelper.icns"];
    BOOL haveIcon = NO;
    NSString *robustIcon = [arg3 objectForKey:@"RobustIcon"];
    if (robustIcon) {
        NSString *winePrefix = [[[[CXSetupLib bottleCollectionClass] sharedCollection] bottleWithName:bottleName] winePrefix];
        if (winePrefix) {
            robustIcon = [robustIcon stringByReplacingOccurrencesOfString:@"%WINEPREFIX%" withString:winePrefix options:NSAnchoredSearch range:NSMakeRange(0, [robustIcon length])];
        }
        NSString *source = [robustIcon stringByReplacingOccurrencesOfString:@"%CX_ROOT%" withString:[(CXApplication *)NSApp crossOverRoot] options:NSAnchoredSearch range:NSMakeRange(0, [robustIcon length])];
        haveIcon = source && [fm fileExistsAtPath:source] &&
                   [self createIcnsFile:[NSURL fileURLWithPath:icnsPath] fromImageFile:[NSURL fileURLWithPath:source] forApp:YES];
    }
    if (!haveIcon) {
        NSString *icon = [arg3 objectForKey:@"Icon"];
        haveIcon = icon && [fm fileExistsAtPath:icon] &&
                   [self createIcnsFile:[NSURL fileURLWithPath:icnsPath] fromImageFile:[NSURL fileURLWithPath:icon] forApp:YES];
    }
    if (!haveIcon) {
        NSString *exeIcon = [[NSBundle mainBundle] pathForResource:@"exeIcon" ofType:@"icns"];
        if (exeIcon) {
            [fm copyItemAtPath:exeIcon toPath:icnsPath error:NULL];
        }
        [fm makeWritableAtPath:icnsPath recursively:NO];
    }

    NSString *plistPath = [[resources stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Info.plist"];
    NSData *data = [NSData dataWithContentsOfFile:plistPath];
    NSPropertyListFormat format = NSPropertyListXMLFormat_v1_0;
    NSError *error = nil;
    NSMutableDictionary *plist = data ? [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListMutableContainers format:&format error:&error] : nil;
    if (!plist) {
        NSLog(@"Failed to load %@: %@\n", plistPath, error);
        [fm removeItemAtPath:appPath error:NULL];
        return NO;
    }

    [plist setObject:[self shortenedBundleID:bundleID] forKey:@"CFBundleIdentifier"];
    if ([arg3 objectForKey:@"Command"]) [plist setObject:[arg3 objectForKey:@"Command"] forKey:@"CrossOverHelperCommand"];
    if (bottleName) [plist setObject:bottleName forKey:@"CXHelperAppBottleName"];
    [plist setObject:[NSNumber numberWithInt:43] forKey:@"CXHelperAppVersion"];
    if (bottleTag) [plist setObject:bottleTag forKey:@"CXHelperAppBottleTag"];
    if (origName) [plist setObject:origName forKey:@"CXOriginalMenuName"];
    [plist setObject:displayName forKey:(NSString *)kCFBundleNameKey];
    NSString *rawPath = [arg3 objectForKey:@"RawPath"];
    if (rawPath) {
        [plist setObject:rawPath forKey:@"CrossOverHelperMenuPath"];
    }

    // The menu dummy type keeps Launch Services aware of the helper; real document
    // types are added later by adjustProgramHelpersForChangedAssociations:.
    NSDictionary *dummyType = [NSDictionary dictionaryWithObject:@"com.codeweavers.CrossOverHelper.MenuDummyType" forKey:(NSString *)kUTTypeIdentifierKey];
    [plist setObject:[NSArray arrayWithObject:dummyType] forKey:(NSString *)kUTImportedTypeDeclarationsKey];
    NSMutableArray *docTypes = [NSMutableArray array];
    [docTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                         [NSArray arrayWithObject:@"com.codeweavers.CrossOverHelper.MenuDummyType"], @"LSItemContentTypes",
                         @"Viewer", @"CFBundleTypeRole", nil]];
    [plist setObject:docTypes forKey:@"CFBundleDocumentTypes"];

    // BIZTEL and Steam launchers also claim their URL schemes.
    NSMutableArray *urlTypes = [NSMutableArray arrayWithCapacity:2];
    if ([arg1 caseInsensitiveCompare:@"BIZTEL"] == NSOrderedSame ||
        (rawPath && [[rawPath lastPathComponent] caseInsensitiveCompare:@"BIZTEL"] == NSOrderedSame)) {
        [urlTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                             @"Call Phone Number URL", @"CFBundleURLName",
                             [NSArray arrayWithObject:@"callto"], @"CFBundleURLSchemes",
                             @"Viewer", @"CFBundleTypeRole", nil]];
    }
    if ([arg1 caseInsensitiveCompare:@"Steam"] == NSOrderedSame ||
        (rawPath && [[rawPath lastPathComponent] caseInsensitiveCompare:@"Steam"] == NSOrderedSame)) {
        [urlTypes addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                             @"Steam URL", @"CFBundleURLName",
                             [NSArray arrayWithObject:@"steam"], @"CFBundleURLSchemes",
                             @"Viewer", @"CFBundleTypeRole", nil]];
    }
    if ([urlTypes count]) {
        [plist setObject:urlTypes forKey:@"CFBundleURLTypes"];
    }

    NSData *out = [NSPropertyListSerialization dataWithPropertyList:plist format:format options:0 error:&error];
    if (!out) {
        NSLog(@"Failed to serialize %@: %@\n", plistPath, error);
        [fm removeItemAtPath:appPath error:NULL];
        return NO;
    }
    if (![out writeToFile:plistPath options:NSDataWritingAtomic error:&error]) {
        NSLog(@"Failed to write %@\n    %@\n", plistPath, error);
        [fm removeItemAtPath:appPath error:NULL];
        return NO;
    }

    // Extensions previously routed to this program are reset so the next
    // association pass re-adds them to the fresh bundle.
    NSMutableDictionary *menuMap = [relateDocTypesToMenus objectForKey:bottleTag];
    if (rawPath && [menuMap isKindOfClass:[NSMutableDictionary class]]) {
        for (NSString *key in [menuMap allKeysForObject:rawPath]) {
            [menuMap setObject:@"" forKey:key];
        }
    }
    if (relateDocTypesToMenus) {
        [[NSUserDefaults standardUserDefaults] setObject:relateDocTypesToMenus forKey:@"DocTypeToMenuPathMap"];
    }
    [self informSystemOfUpdatedApp:appPath];
    return YES;
}

- (BOOL)createIcnsFile:(id)arg1 fromImageFile:(id)arg2 forApp:(BOOL)arg3 {
    CGImageSourceRef isrc = CGImageSourceCreateWithURL((CFURLRef)arg2, NULL);
    if (!isrc) return NO;
    
    CFStringRef type = CGImageSourceGetType(isrc);
    BOOL isIcns = UTTypeConformsTo(type, kUTTypeAppleICNS);
    CFRelease(isrc);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if (isIcns) {
        [fm removeItemAtURL:arg1 error:NULL];
        return [fm copyItemAtURL:arg2 toURL:arg1 error:NULL];
    } else {
        NSArray *reps = [LauncherIconUtils imageRepsForCXMenuIconsFromURL:arg2];
        if ([reps count] > 0) {
            return [LauncherIconUtils createIcnsFileAtURL:arg1 fromImageReps:reps forApp:arg3];
        }
    }
    return NO;
}

- (BOOL)applicationOpenUntitledFile:(id)arg1 {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [[self mainWindowController] showWindow:nil];
    }];
    if (updateCheckOp) {
        [op addDependency:updateCheckOp];
    }
    [op setQueuePriority:NSOperationQueuePriorityHigh];
    [[NSOperationQueue mainQueue] addOperation:op];
    return [super applicationOpenUntitledFile:arg1];
}

- (void)runCXUpgrade {
    NSString *root = [(CXApplication *)NSApp crossOverRoot];
    NSString *upgradePath = [[root stringByAppendingPathComponent:@"lib"] stringByAppendingPathComponent:@"cxupgrade"];
    NSMutableArray *args = [NSMutableArray arrayWithObjects:@"--productid", @"CrossOver", nil];
    NSString *firstRunVer = [[NSUserDefaults standardUserDefaults] stringForKey:@"FirstRunVersion"];
    if ([firstRunVer length] > 0) {
        [args addObject:@"--old-version"];
        [args addObject:firstRunVer];
    }
    NSTask *task = [NSTask launchedTaskWithLaunchPath:upgradePath arguments:args];
    [task waitUntilExit];
}

- (void)checkForHelperUpdate {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults integerForKey:@"LastHelperVersion"] != 43) {
        refreshProgramsUpdateIsForced = YES;
        [defaults setInteger:43 forKey:@"LastHelperVersion"];
    }
    [super checkForHelperUpdate];
}

- (void)processFirstRun:(BOOL)arg1 {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSDate date] forKey:@"FirstRunDate"];
    [super processFirstRun:arg1];
    if (arg1) {
        [self runCXUpgrade];
    }
    if ([defaults objectForKey:@"MostRecentCXMenuPlist"] || [defaults objectForKey:@"LastUpdatedAssociations"]) {
        [defaults removeObjectForKey:@"MostRecentCXFBMenuPlist"];
        [defaults removeObjectForKey:@"LastUpdatedAssociations_v2"];
        refreshProgramsUpdateIsForced = YES;
        [defaults removeObjectForKey:@"MostRecentCXMenuPlist"];
        [defaults removeObjectForKey:@"LastUpdatedAssociations"];
    }
    [(CXApplication *)NSApp setDaysLeft];
}

- (id)applicationDockMenu:(id)arg1 {
    return [self programsMenu];
}

- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2 {
    [nextUpdateItem release];
    nextUpdateItem = nil;

    NSDate *expiration = [(CXApplication *)[NSApplication sharedApplication] licenseExpirationDate];
    NSString *currentVersion = @"26.3.0.39832";
    SUAppcastItem *newest = nil;
    SUAppcastItem *best = nil;
    for (SUAppcastItem *item in [arg1 items]) {
        SUStandardVersionComparator *comparator = [SUStandardVersionComparator defaultComparator];
        if ([comparator compareVersion:[item versionString] toVersion:currentVersion] != NSOrderedDescending) {
            continue;
        }
        if (!newest || [comparator compareVersion:[item versionString] toVersion:[newest versionString]] == NSOrderedDescending) {
            newest = item;
        }
        // The oldest newer release is the one the support nag talks about.
        if (!nextUpdateItem || [comparator compareVersion:[item versionString] toVersion:[nextUpdateItem versionString]] == NSOrderedAscending) {
            [nextUpdateItem release];
            nextUpdateItem = [item retain];
        }
        // Only releases published while the license was supported qualify.
        if (expiration && [[item date] compare:expiration] == NSOrderedDescending) {
            continue;
        }
        if (!best || [comparator compareVersion:[item versionString] toVersion:[best versionString]] == NSOrderedDescending) {
            best = item;
        }
    }

    if (newest && !best) {
        [arg2 setNotLicensed:YES];
        NSString *licenseID = [(CXApplication *)[NSApplication sharedApplication] licenseID];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.codeweavers.com/bin/query/supportperiod/%@/%@", licenseID, @"crossmac"]];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:url]
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *failure = [error localizedDescription];
            if (!failure && [response isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)response statusCode] != 200) {
                failure = [NSHTTPURLResponse localizedStringForStatusCode:[(NSHTTPURLResponse *)response statusCode]];
            }
            if (failure) {
                NSLog(@"Download of license expiration failed: %@\n", failure);
            } else {
                BOOL refreshEnough = NO;
                if (data) {
                    NSString *body = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
                    if ([body rangeOfString:@"NOT FOUND"].location != NSNotFound) {
                        NSLog(@"Unable to validate this license file at all.\n");
                    } else {
                        // A refreshed license that covers the next release only needs re-registering.
                        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                        [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
                        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss xx"];
                        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                        NSDate *supportEnd = [formatter dateFromString:body];
                        refreshEnough = [supportEnd compare:[nextUpdateItem date]] == NSOrderedDescending;
                    }
                }
                BuySupportNagController *nag = [[BuySupportNagController alloc] initWithAppcastItem:nextUpdateItem];
                [nag setOwnsSelf:YES];
                [nag setRegistrationRefreshEnough:refreshEnough];
                [[nag window] makeKeyAndOrderFront:self];
                [nag release];
            }
            [nextUpdateItem release];
            nextUpdateItem = nil;
            [arg2 setNotLicensed:NO];
        }];
        [task resume];
        return nil;
    }
    return best;
}

- (id)sparkleUpdater {
    return [CXUpdater sharedUpdater];
}

- (void)repairBottles:(id)arg1 {
    NSString *root = [(CXApplication *)NSApp crossOverRoot];
    NSString *wine = [[root stringByAppendingPathComponent:@"bin"] stringByAppendingPathComponent:@"wine"];
    id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
    NSArray *bottles = [sharedCollection bottleList];
    
    for (id bottle in bottles) {
        id status = [[CXSetupLib cxSetupClass] bottleStatus:@"REPAIRING"];
        [bottle addStatusOverride:status];
        
        NSArray *args = @[@"--bottle", [bottle name], @"--wl-app", @"wineboot", @"-u"];
        CXTask *task = [CXTask launchedTaskWithLaunchPath:wine arguments:args];
        [task setTerminationHandler:^(NSTask *t) {
            [bottle removeStatusOverride:status];
        }];
    }
}

- (void)repairBottlesDialog:(id)arg1 {
    NSAlert *alert = [[[NSAlert alloc] init] autorelease];
    [alert setAlertStyle:NSAlertStyleInformational];
    [alert setMessageText:NSLocalizedString(@"Repair Bottles?", @"")];
    [alert setInformativeText:NSLocalizedString(@"CrossOver will attempt to repair bottles that may have been damaged by anti-virus software. Such anti-virus software may have incorrectly deleted or \"quarantined\" certain critical files needed for CrossOver to work. CrossOver's files do not contain viruses…", @"")];
    [alert addButtonWithTitle:NSLocalizedString(@"Repair", @"")];
    [alert addButtonWithTitle:NSLocalizedString(@"Cancel", @"")];
    [alert addButtonWithTitle:NSLocalizedString(@"Learn More", @"")];
    
    NSModalResponse resp = [alert runModal];
    if (resp == NSAlertFirstButtonReturn) {
        [self repairBottles:arg1];
    }
    // CrossThrough: "Learn More" abria support.codeweavers.com. Removido.
}

- (id)programsMenu {
    return _programsMenu;
}

- (void)setProgramsMenu:(id)arg1 {
    if (_programsMenu != arg1) {
        [_programsMenu release];
        _programsMenu = [arg1 retain];
    }
}

- (id)publishBottleMenuItem {
    return _publishBottleMenuItem;
}

- (void)setPublishBottleMenuItem:(id)arg1 {
    _publishBottleMenuItem = arg1;
}

- (id)updateBottleMenuItem {
    return _updateBottleMenuItem;
}

- (void)setUpdateBottleMenuItem:(id)arg1 {
    _updateBottleMenuItem = arg1;
}

- (id)launchers {
    return _launchers;
}

- (void)setLaunchers:(id)arg1 {
    if (_launchers != arg1) {
        [_launchers release];
        _launchers = [arg1 copy];
    }
}

- (id)urlHandler {
    return _urlHandler;
}

- (void)setUrlHandler:(id)arg1 {
    if (_urlHandler != arg1) {
        [_urlHandler release];
        _urlHandler = [arg1 retain];
    }
}

- (id)observedBottles {
    return _observedBottles;
}

- (void)setObservedBottles:(id)arg1 {
    if (_observedBottles != arg1) {
        [_observedBottles release];
        _observedBottles = [arg1 retain];
    }
}

@end
