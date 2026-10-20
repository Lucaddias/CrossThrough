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
            @YES, @"AutoUpdateCrossTies",
            @YES, @"AskForRatings",
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

- (void)runClient:(id)arg1 inBottle:(id)arg2 withDialog:(BOOL)arg3 {
    NSString *file = (NSString *)arg1;
    NSString *bottle = (NSString *)arg2;
    NSString *ext = [[file pathExtension] lowercaseString];
    NSString *lastComp = [file lastPathComponent];
    
    if (!bottle) {
        id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
        for (id b in [sharedCollection bottleList]) {
            if ([b isCanRunCommands] && [[b fileIsInBottle:file] boolValue]) {
                bottle = [b name];
                break;
            }
        }
    }
    
    if ([lastComp caseInsensitiveCompare:@"autorun.inf"] == NSOrderedSame) {
        [self openAutoPlayInstallerForVolume:file inBottle:bottle];
        [self addToRecentItems:file bottle:bottle];
        return;
    }
    
    if ([ext isEqualToString:@"c4p"] || [ext isEqualToString:@"tie"]) {
        [self openAutoPlayInstallerForC4P:file inBottle:bottle];
        [self addToRecentItems:file bottle:bottle];
        return;
    }
    
    if ([ext isEqualToString:@"cxarchive"]) {
        [[self mainWindowController] showWindow:self];
        [[self mainWindowController] importBottleArchiveFromURL:[NSURL fileURLWithPath:file]];
        [self addToRecentItems:file bottle:bottle];
        return;
    }
    
    if (arg3) {
        id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
        NSArray *list = [sharedCollection bottleList];
        if ([list count] > 0) {
            RunCommandController *rcc = [[[RunCommandController alloc] initWithFileToRun:file] autorelease];
            if (bottle) {
                [rcc setSelectedBottle:bottle];
            }
            [rcc showWindow:self];
        } else {
            NoBottleController *nbc = [[[NoBottleController alloc] init] autorelease];
            [nbc showWindow:self];
        }
        [self addToRecentItems:file bottle:bottle];
        return;
    }
    
    [super runClient:file inBottle:bottle];
    [self addToRecentItems:file bottle:bottle];
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
    NSURL *url = [NSURL URLWithString:@"http://crossover.codeweavers.com/redirect/teamviewer"];
    [[NSWorkspace sharedWorkspace] openURL:url];
}

- (void)openHelpInBrowser:(id)arg1 {
    NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"https://support.codeweavers.com/user-guides/crossover-mac-user-guide" value:@"" table:@"Vendor"];
    NSString *urlStr = [NSString stringWithFormat:@"%@", fmt];
    NSURL *url = [NSURL URLWithString:urlStr];
    [[NSWorkspace sharedWorkspace] openURL:url];
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableArray *bottles = [NSMutableArray array];
    [self performSelectorOnMainThread:@selector(duplicateBottleList:) withObject:bottles waitUntilDone:YES];
    
    for (id bottle in bottles) {
        NSString *prefix = [bottle winePrefix];
        NSString *plistPath = [NSString stringWithFormat:@"%@/desktopdata/cxmenu/cxmenu_macosx.plist", prefix];
        if ([fm fileExistsAtPath:plistPath]) {
            NSString *resolved = [plistPath stringByResolvingSymlinksInPath];
            NSDictionary *attrs = [fm attributesOfItemAtPath:resolved error:NULL];
            NSDate *modDate = [attrs fileModificationDate];
            NSData *data = [NSData dataWithContentsOfFile:plistPath];
            if (data) {
                NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
                if ([plist isKindOfClass:[NSDictionary class]] && [[plist allKeys] count] > 0) {
                    NSString *firstKey = [[plist allKeys] objectAtIndex:0];
                    NSMutableDictionary *entry = [[plist objectForKey:firstKey] mutableCopy];
                    if (modDate) {
                        [entry setObject:modDate forKey:@"moddate"];
                    }
                    [dict setObject:entry forKey:firstKey];
                    [entry release];
                }
            }
        }
    }
    return dict;
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
    
    NSDictionary *currentMenu = [self getMenuPList];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *savedMenu = [defaults objectForKey:@"MostRecentCXFBMenuPlist"];
    
    if (!arg1 && [currentMenu isEqualToDictionary:savedMenu]) {
        [pool release];
        inUpdateApplicationFolder = NO;
        return NO;
    }
    
    [defaults setObject:currentMenu forKey:@"MostRecentCXFBMenuPlist"];
    
    NSString *programsFolder = [[self class] getProgramsFolder];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm createDirectoryAtPath:programsFolder attributes:nil recursively:YES];
    
    for (NSString *bottleName in currentMenu) {
        NSDictionary *bottleData = [currentMenu objectForKey:bottleName];
        id children = [bottleData objectForKey:@"Children"];
        if ([children isKindOfClass:[NSDictionary class]]) {
            for (NSString *progKey in children) {
                NSDictionary *progData = [children objectForKey:progKey];
                if (![progKey hasSuffix:@"/"]) {
                    [self exportProgram:progKey bundleName:nil withDictionary:progData toFolder:programsFolder];
                }
            }
        }
    }
    
    [pool release];
    inUpdateApplicationFolder = NO;
    return YES;
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

- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2 skippingFiles:(id)arg3 {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *contents = [fm contentsOfDirectoryAtPath:arg1 error:NULL];
    
    for (NSString *item in contents) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        NSString *fullPath = [arg1 stringByAppendingPathComponent:item];
        NSURL *url = [NSURL fileURLWithPath:fullPath];
        
        NSNumber *resId = nil;
        NSNumber *isSymlink = nil;
        NSNumber *isDir = nil;
        NSNumber *isPkg = nil;
        
        [url getResourceValue:&resId forKey:NSURLFileResourceIdentifierKey error:NULL];
        if (resId && [arg3 containsObject:resId]) {
            [pool release];
            continue;
        }
        if (resId) {
            [arg3 addObject:resId];
        }
        
        [url getResourceValue:&isSymlink forKey:NSURLIsSymbolicLinkKey error:NULL];
        if ([isSymlink boolValue]) {
            url = [url URLByResolvingSymlinksInPath];
            [url getResourceValue:&resId forKey:NSURLFileResourceIdentifierKey error:NULL];
            if (resId && [arg3 containsObject:resId]) {
                [pool release];
                continue;
            }
            if (resId) {
                [arg3 addObject:resId];
            }
        }
        
        [url getResourceValue:&isDir forKey:NSURLIsDirectoryKey error:NULL];
        [url getResourceValue:&isPkg forKey:NSURLIsPackageKey error:NULL];
        
        if ([isDir boolValue]) {
            if ([isPkg boolValue]) {
                CXBundle *b = [CXBundle bundleWithURL:url];
                if (b && ([b objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"] || [b objectForInfoDictionaryKey:@"CrossOverHelperCommand"])) {
                    LauncherApp *app = [LauncherApp launcherWithURL:url];
                    if (app) {
                        [arg2 addLauncherItem:app];
                    }
                }
            } else {
                LauncherDiskFolder *subfolder = [LauncherDiskFolder launcherWithFolderURL:url];
                [self addLaunchersInDir:fullPath toFolder:subfolder skippingFiles:arg3];
                if ([[subfolder items] count] > 0) {
                    [arg2 addLauncherItem:subfolder];
                }
            }
        }
        [pool release];
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
        if (arg1) *arg1 = associationPlistDate;
        return associationPlist;
    }
    
    NSMutableDictionary *comb = [[[NSMutableDictionary alloc] init] autorelease];
    NSDate *latest = [[NSDate distantPast] retain];
    NSMutableArray *bottles = [NSMutableArray array];
    [self performSelectorOnMainThread:@selector(duplicateBottleList:) withObject:bottles waitUntilDone:YES];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    for (id bottle in bottles) {
        NSString *prefix = [bottle winePrefix];
        NSString *assocPath = [NSString stringWithFormat:@"%@/desktopdata/cxassoc/cxassoc_macosx.plist", prefix];
        NSString *resolved = [assocPath stringByResolvingSymlinksInPath];
        NSDictionary *attrs = [fm attributesOfItemAtPath:resolved error:NULL];
        if (attrs) {
            NSDate *mDate = [attrs fileModificationDate];
            if ([mDate isGreaterThan:latest]) {
                [latest release];
                latest = [mDate copy];
            }
            NSData *data = [NSData dataWithContentsOfFile:assocPath];
            if (data) {
                NSError *err = nil;
                id p = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:&err];
                if ([p isKindOfClass:[NSDictionary class]]) {
                    [comb addEntriesFromDictionary:p];
                }
            }
        }
    }
    
    [associationPlist release];
    associationPlist = [comb copy];
    [associationPlistDate release];
    associationPlistDate = latest;
    
    if (arg1) *arg1 = associationPlistDate;
    return associationPlist;
}

- (void)addDocumentTypeDictionary:(id)arg1 forBottle:(id)arg2 toBundleArray:(id)arg3 andResourcesDir:(id)arg4 {
    NSArray *extensions = [arg1 objectForKey:@"CFBundleTypeExtensions"];
    NSString *firstExt = [extensions count] > 0 ? [extensions objectAtIndex:0] : nil;
    if (!firstExt) return;
    
    NSString *icnsPath = [[arg4 stringByAppendingPathComponent:firstExt] stringByAppendingPathExtension:@"icns"];
    NSString *robustIcon = [arg1 objectForKey:@"RobustIconSourceFile"];
    if (robustIcon && arg2) {
        id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
        id b = [sharedCollection bottleWithName:arg2];
        NSString *winePrefix = [b winePrefix];
        if (winePrefix) {
            robustIcon = [robustIcon stringByReplacingOccurrencesOfString:@"%WINEPREFIX%" withString:winePrefix];
        }
    }
    if (robustIcon) {
        robustIcon = [robustIcon stringByReplacingOccurrencesOfString:@"%CX_ROOT%" withString:[(CXApplication *)NSApp crossOverRoot]];
        if ([[NSFileManager defaultManager] fileExistsAtPath:robustIcon]) {
            [self createIcnsFile:[NSURL fileURLWithPath:icnsPath] fromImageFile:[NSURL fileURLWithPath:robustIcon] forApp:NO];
        }
    }
    [arg3 addObject:arg1];
}

- (void)informSystemOfUpdatedApp:(id)arg1 {
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm setAttributes:@{NSFileModificationDate: [NSDate date]} ofItemAtPath:arg1 error:NULL];
    [[NSWorkspace sharedWorkspace] noteFileSystemChanged:arg1];
    NSURL *url = [NSURL fileURLWithPath:arg1];
    LSRegisterURL((CFURLRef)url, true);
}

- (void)adjustProgramHelpersForChangedAssociations:(id)arg1 {
    NSDictionary *menus = [self findMenusForAssociations:arg1];
    NSMutableSet *keys = [NSMutableSet setWithArray:[menus allKeys]];
    if (relateDocTypesToMenus) {
        [keys addObjectsFromArray:[relateDocTypesToMenus allKeys]];
    }
    
    [relateDocTypesToMenus release];
    relateDocTypesToMenus = [menus retain];
    [[NSUserDefaults standardUserDefaults] setObject:relateDocTypesToMenus forKey:@"DocTypeToMenuPathMap"];
}

- (void)refreshAssociations:(BOOL)arg1 {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastUpdated = [defaults objectForKey:@"LastUpdatedAssociations_v2"];
    
    [associationPlist release];
    associationPlist = nil;
    
    NSDate *latestDate = nil;
    NSDictionary *combined = [self combinedAssociationsPropertyListLatestDate:&latestDate];
    [self adjustProgramHelpersForChangedAssociations:combined];
    
    if (arg1 || ![latestDate isEqualToDate:lastUpdated]) {
        if (combined && [combined count] > 0 && latestDate) {
            [defaults setObject:latestDate forKey:@"LastUpdatedAssociations_v2"];
        } else {
            [defaults removeObjectForKey:@"LastUpdatedAssociations_v2"];
        }
        
        NSArray *roles = (NSArray *)LSCopyAllRoleHandlersForContentType((CFStringRef)@"com.codeweavers.CrossOverHelper.AppDummyType", kLSRolesAll);
        if (roles) {
            [helpersToDelete release];
            helpersToDelete = [[NSMutableSet alloc] initWithArray:roles];
            CFRelease((CFTypeRef)roles);
        }
        
        for (NSString *bottle in combined) {
            NSDictionary *bottleAssocs = [combined objectForKey:bottle];
            NSDictionary *extAssocs = [bottleAssocs objectForKey:@"Extension Associations/"];
            if (extAssocs) {
                [self setupHelperAppForBottleWithTag:bottle andName:bottle andExtensions:[extAssocs allKeys]];
            }
        }
    }
    [pool release];
}

- (id)getAssociationDictionaryForKey:(id)arg1 withExtensionAssociations:(id)arg2 {
    NSDictionary *entry = [arg2 objectForKey:arg1];
    if (!entry) return nil;
    
    NSString *ext = [entry objectForKey:@"Extension"];
    if (!ext) {
        NSArray *parts = [(NSString *)arg1 componentsSeparatedByString:@"/"];
        if ([parts count] > 0) {
            ext = [[parts objectAtIndex:0] hasPrefix:@"."] ? [[parts objectAtIndex:0] substringFromIndex:1] : [parts objectAtIndex:0];
        }
    }
    if (!ext) return nil;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
    [dict setObject:@[ext] forKey:@"CFBundleTypeExtensions"];
    [dict setObject:ext forKey:@"CFBundleTypeIconFile"];
    if ([entry objectForKey:@"Icon"]) {
        [dict setObject:[entry objectForKey:@"Icon"] forKey:@"IconSourceFile"];
    }
    if ([entry objectForKey:@"RobustIcon"]) {
        [dict setObject:[entry objectForKey:@"RobustIcon"] forKey:@"RobustIconSourceFile"];
    }
    [dict setObject:@"Editor" forKey:@"CFBundleTypeRole"];
    [dict setObject:@"Default" forKey:@"LSHandlerRank"];
    return dict;
}

- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3 {
    return [self setupHelperAppForBottleWithTag:arg1 andName:arg2 andExtensions:arg3 usingExistingHelper:nil];
}

- (id)findBestApplicationForDocType:(id)arg1 withProgramsDict:(id)arg2 {
    NSDictionary *best = @{@"rank": @0};
    NSString *assocApp = [arg1 objectForKey:@"CXAssocationAppName"];
    if (!assocApp || ![arg2 isKindOfClass:[NSDictionary class]]) {
        return best;
    }
    for (NSString *progKey in (NSDictionary *)arg2) {
        NSDictionary *prog = [arg2 objectForKey:progKey];
        if ([prog objectForKey:@"Children"]) {
            NSDictionary *childMatch = [self findBestApplicationForDocType:arg1 withProgramsDict:[prog objectForKey:@"Children"]];
            if ([[childMatch objectForKey:@"rank"] intValue] > [[best objectForKey:@"rank"] intValue]) {
                best = childMatch;
            }
        } else {
            if ([assocApp caseInsensitiveCompare:progKey] == NSOrderedSame) {
                return @{@"rank": @100, @"menuPath": progKey};
            }
            if ([assocApp rangeOfString:progKey options:NSCaseInsensitiveSearch].location != NSNotFound) {
                int rank = 50 + (int)((float)[progKey length] / (float)[assocApp length] * 40.0f);
                if (rank > [[best objectForKey:@"rank"] intValue]) {
                    best = @{@"rank": [NSNumber numberWithInt:rank], @"menuPath": progKey};
                }
            }
        }
    }
    return best;
}

- (id)findBestApplicationForDocType:(id)arg1 forBottle:(id)arg2 {
    NSDictionary *menu = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"MostRecentCXFBMenuPlist"];
    NSDictionary *bottleMenu = [menu objectForKey:arg2];
    NSDictionary *startMenu = [bottleMenu valueForKeyPath:@"Children.StartMenu/.Children"];
    NSDictionary *programs = [startMenu valueForKeyPath:@"Programs/.Children"];
    NSDictionary *winApps = [startMenu valueForKeyPath:@"Windows Applications/.Children"];
    
    NSDictionary *progMatch = [self findBestApplicationForDocType:arg1 withProgramsDict:programs];
    NSDictionary *winMatch = [self findBestApplicationForDocType:arg1 withProgramsDict:winApps];
    
    NSDictionary *best = ([[progMatch objectForKey:@"rank"] intValue] >= [[winMatch objectForKey:@"rank"] intValue]) ? progMatch : winMatch;
    return [best objectForKey:@"menuPath"];
}

- (id)findMenusForAssociations:(id)arg1 {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *bottle in (NSDictionary *)arg1) {
        NSDictionary *bottleData = [arg1 objectForKey:bottle];
        NSDictionary *extAssocs = [bottleData objectForKey:@"Extension Associations/"];
        for (NSString *extKey in extAssocs) {
            NSDictionary *dict = [self getAssociationDictionaryForKey:extKey withExtensionAssociations:extAssocs];
            if (dict) {
                NSString *menuPath = [self findBestApplicationForDocType:dict forBottle:bottle];
                if (menuPath) {
                    NSMutableDictionary *bottleMap = [result objectForKey:bottle];
                    if (!bottleMap) {
                        bottleMap = [NSMutableDictionary dictionary];
                        [result setObject:bottleMap forKey:bottle];
                    }
                    [bottleMap setObject:menuPath forKey:extKey];
                }
            }
        }
    }
    return result;
}

- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3 usingExistingHelper:(id)arg4 {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *helperPath = (NSString *)arg4;
    if (!helperPath) {
        NSString *programsFolder = [[self class] getProgramsFolder];
        NSString *helperName = [NSString stringWithFormat:@"%@ Helper.app", arg2];
        helperPath = [programsFolder stringByAppendingPathComponent:helperName];
    }
    
    NSString *contentsPath = [helperPath stringByAppendingPathComponent:@"Contents"];
    NSString *plistPath = [contentsPath stringByAppendingPathComponent:@"Info.plist"];
    
    NSMutableDictionary *infoPlist = nil;
    if ([fm fileExistsAtPath:plistPath]) {
        NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
        infoPlist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListMutableContainers format:NULL error:NULL];
    }
    
    if (!infoPlist) {
        NSString *archivePath = [[NSBundle mainBundle] pathForResource:@"Bottle Helper" ofType:@"cpbz2"];
        if (!archivePath) {
            archivePath = [[NSBundle mainBundle] pathForResource:@"Menu Helper" ofType:@"cpbz2"];
        }
        if (archivePath) {
            [fm createDirectoryAtPath:helperPath attributes:nil recursively:YES];
            NSTask *task = [NSTask launchedTaskWithLaunchPath:@"/usr/bin/ditto" arguments:@[@"-x", @"-k", archivePath, helperPath]];
            [task waitUntilExit];
            [fm makeWritableAtPath:helperPath recursively:YES];
            
            NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
            if (plistData) {
                infoPlist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListMutableContainers format:NULL error:NULL];
            }
        }
    }
    
    if (infoPlist) {
        [infoPlist setObject:arg2 forKey:@"CXHelperAppBottleName"];
        [infoPlist setObject:arg1 forKey:@"CXHelperAppBottleTag"];
        [infoPlist setObject:@43 forKey:@"CXHelperAppVersion"];
        
        NSString *bundleID = [self shortenedBundleID:[NSString stringWithFormat:@"com.codeweavers.CrossOverHelper.%@.%@", arg1, arg2]];
        [infoPlist setObject:bundleID forKey:(NSString *)kCFBundleIdentifierKey];
        [infoPlist setObject:arg2 forKey:(NSString *)kCFBundleNameKey];
        
        NSData *updatedData = [NSPropertyListSerialization dataWithPropertyList:infoPlist format:NSPropertyListXMLFormat_v1_0 options:0 error:NULL];
        [updatedData writeToFile:plistPath atomically:YES];
        
        [self informSystemOfUpdatedApp:helperPath];
        return YES;
    }
    return NO;
}

- (void)launchHelper:(id)arg1 {
    NSDictionary *dict = [arg1 representedObject];
    NSString *helper = [dict objectForKey:@"Helper"];
    if (helper) {
        [[NSWorkspace sharedWorkspace] launchApplication:helper];
    }
}

- (BOOL)exportProgram:(id)arg1 bundleName:(id)arg2 withDictionary:(id)arg3 toFolder:(id)arg4 {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *program = (NSString *)arg1;
    NSString *bundleName = (NSString *)arg2;
    NSDictionary *dict = (NSDictionary *)arg3;
    NSString *folder = (NSString *)arg4;
    
    NSString *appTitle = bundleName ?: program;
    NSString *appBundleName = [appTitle stringByAppendingPathExtension:@"app"];
    NSString *appPath = [folder stringByAppendingPathComponent:appBundleName];
    NSString *contents = [appPath stringByAppendingPathComponent:@"Contents"];
    
    NSString *bottleName = [dict objectForKey:@"bottlename"];
    NSString *bottleTag = [dict objectForKey:@"bottletag"];
    NSString *origName = [dict objectForKey:@"origname"] ?: program;
    
    NSString *rawBundleID = [NSString stringWithFormat:@"com.codeweavers.CrossOverHelper.%@.%@", bottleTag ?: bottleName, origName];
    NSString *bundleID = [self shortenedBundleID:rawBundleID];
    
    NSString *archivePath = [[NSBundle mainBundle] pathForResource:@"Menu Helper" ofType:@"cpbz2"];
    if (!archivePath) {
        return NO;
    }
    
    [fm createDirectoryAtPath:appPath attributes:nil recursively:YES];
    NSTask *ditto = [NSTask launchedTaskWithLaunchPath:@"/usr/bin/ditto" arguments:@[@"-x", @"-k", archivePath, appPath]];
    [ditto waitUntilExit];
    if ([ditto terminationStatus] != 0) {
        return NO;
    }
    [fm makeWritableAtPath:appPath recursively:YES];
    
    NSString *resDir = [contents stringByAppendingPathComponent:@"Resources"];
    NSString *icnsDest = [resDir stringByAppendingPathComponent:@"CrossOverHelper.icns"];
    
    NSString *robustIcon = [dict objectForKey:@"RobustIcon"];
    if (robustIcon && bottleName) {
        id sharedCollection = [[CXSetupLib bottleCollectionClass] sharedCollection];
        id b = [sharedCollection bottleWithName:bottleName];
        NSString *winePrefix = [b winePrefix];
        if (winePrefix) {
            robustIcon = [robustIcon stringByReplacingOccurrencesOfString:@"%WINEPREFIX%" withString:winePrefix];
        }
    }
    if (robustIcon) {
        robustIcon = [robustIcon stringByReplacingOccurrencesOfString:@"%CX_ROOT%" withString:[(CXApplication *)NSApp crossOverRoot]];
        if ([fm fileExistsAtPath:robustIcon]) {
            [self createIcnsFile:[NSURL fileURLWithPath:icnsDest] fromImageFile:[NSURL fileURLWithPath:robustIcon] forApp:YES];
        }
    }
    
    NSString *infoPath = [contents stringByAppendingPathComponent:@"Info.plist"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:infoPath] ?: [NSMutableDictionary dictionary];
    [infoDict setObject:bundleID forKey:(NSString *)kCFBundleIdentifierKey];
    [infoDict setObject:appTitle forKey:(NSString *)kCFBundleNameKey];
    [infoDict setObject:origName forKey:@"CrossOverHelperCommand"];
    if (bottleName) [infoDict setObject:bottleName forKey:@"CXHelperAppBottleName"];
    if (bottleTag) [infoDict setObject:bottleTag forKey:@"CXHelperAppBottleTag"];
    [infoDict setObject:@43 forKey:@"CXHelperAppVersion"];
    
    [infoDict writeToFile:infoPath atomically:YES];
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
    NSMutableArray *args = [NSMutableArray arrayWithObject:@"--productid"];
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
    
    NSDate *expDate = [(CXApplication *)NSApp licenseExpirationDate];
    NSString *currentVer = @"26.3.0.39832";
    SUStandardVersionComparator *comp = [SUStandardVersionComparator defaultComparator];
    
    SUAppcastItem *bestItem = nil;
    for (SUAppcastItem *item in [arg1 items]) {
        NSString *v = [item versionString];
        if ([comp compareVersion:v toVersion:currentVer] != NSOrderedDescending) {
            continue;
        }
        if (!bestItem || [comp compareVersion:v toVersion:[bestItem versionString]] == NSOrderedDescending) {
            NSDate *relDate = [item date];
            if (!expDate || !relDate || [relDate compare:expDate] != NSOrderedDescending) {
                bestItem = item;
            }
        }
    }
    return bestItem;
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
    } else if (resp == NSAlertThirdButtonReturn) {
        NSURL *url = [NSURL URLWithString:@"https://support.codeweavers.com/troubleshooting/antivirus-software-eg-bitdefender-avast-and-avg-and-crossover"];
        [[NSWorkspace sharedWorkspace] openURL:url];
    }
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
