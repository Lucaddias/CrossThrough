// PackageInstaller.m — CrossThrough
#import "PackageInstaller.h"
#import "InstallConfiguration.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static void * _PackageInstallerKVOContext = &_PackageInstallerKVOContext;
static NSByteCountFormatter *_byteCountFormatter = nil;

@implementation PackageInstaller

+ (id)keyPathsForValuesAffectingIsUnknownPackage {
    return [NSSet setWithObject:@"package"];
}

- (id)initWithPackage:(id)arg1 {
    self = [super init];
    if (self) {
        BottleCollection *bc = (BottleCollection *)[[CXSetupLib bottleCollectionClass] sharedCollection];
        self->_bottleCollection = [bc retain];

        self->_installConfiguration = [[InstallConfiguration alloc] init];
        [self->_installConfiguration addDelegate:self];

        [self setSelectedPackage:arg1];
        [self addMountedVolumes];

        if (bc) {
            [bc addObserver:self forKeyPath:@"bottleList" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:_PackageInstallerKVOContext];
        }

        self->_currentTasks = [[NSMutableArray alloc] initWithCapacity:4];
        self->_failedTasks = [[NSMutableArray alloc] initWithCapacity:4];
        self->_status = 0;
    }
    return self;
}

- (void)dealloc {
    BottleCollection *bc = (BottleCollection *)self->_bottleCollection;
    if (bc) {
        [bc removeObserver:self forKeyPath:@"bottleList"];
        for (BottleWrapper *b in [bc bottleList]) {
            [b removeObserver:self forKeyPath:@"canInstall" context:_PackageInstallerKVOContext];
            [b removeObserver:self forKeyPath:@"isInstalledPackagesReady" context:_PackageInstallerKVOContext];
        }
        [self->_bottleCollection release];
        self->_bottleCollection = nil;
    }

    [self->_downloadUpdateTimer invalidate];
    [self->_downloadUpdateTimer release];
    self->_downloadUpdateTimer = nil;

    [self->_installConfiguration removeDelegate:self];
    [self->_installConfiguration release];
    self->_installConfiguration = nil;

    [self->_currentTasks release];
    self->_currentTasks = nil;

    [self->_failedTasks release];
    self->_failedTasks = nil;

    [self->_package release];
    self->_package = nil;

    [self->_installEngine release];
    self->_installEngine = nil;

    [self->_installQueue cancelAllOperations];
    [self->_installQueue release];
    self->_installQueue = nil;

    [self->_completionNotes release];
    self->_completionNotes = nil;

    [self->_installationNotes release];
    self->_installationNotes = nil;

    [self->_summaryDetails release];
    self->_summaryDetails = nil;

    [self->_currentTaskDownloadDescription release];
    self->_currentTaskDownloadDescription = nil;

    [super dealloc];
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    if (arg4 != _PackageInstallerKVOContext) {
        [super observeValueForKeyPath:arg1 ofObject:arg2 change:arg3 context:arg4];
        return;
    }

    BottleCollection *bc = (BottleCollection *)[self bottleCollection];
    if (arg2 == bc && [arg1 isEqualToString:@"bottleList"]) {
        NSArray *newBottles = [arg3 objectForKey:NSKeyValueChangeNewKey];
        if ([newBottles isKindOfClass:[NSArray class]]) {
            for (BottleWrapper *b in newBottles) {
                [b loadApplicationInfo];
                [self trackBottle:b];
            }
        }
        NSArray *oldBottles = [arg3 objectForKey:NSKeyValueChangeOldKey];
        if ([oldBottles isKindOfClass:[NSArray class]]) {
            for (BottleWrapper *b in oldBottles) {
                [self stopTrackingBottle:b];
            }
        }
        return;
    }

    if ([arg1 isEqualToString:@"canInstall"]) {
        BOOL canInstall = [[arg3 objectForKey:NSKeyValueChangeNewKey] boolValue];
        if (canInstall) {
            [self addBottleToInstallTask:arg2];
        } else {
            [self removeBottleFromInstallTask:arg2];
        }
    } else if ([arg1 isEqualToString:@"isInstalledPackagesReady"]) {
        [self bottleLoadedInfo:arg2];
    }
}

- (void)setSelectedPackage:(id)arg1 {
    [self setPackage:arg1];
    if (arg1) {
        [[self installConfiguration] setSelectedPackage:arg1 forUser:YES];
    }
    [self updateInstallationNotes];
    [self updateSummaryDetails];
}

- (void)setSelectedBottle:(id)arg1 {
    if (arg1 && [arg1 respondsToSelector:@selector(name)]) {
        [[self installConfiguration] setBottleName:[arg1 name]];
    }
}

- (void)setInstallerSource:(id)arg1 {
    [[self installConfiguration] setInstallerSource:arg1 forUser:YES];
}

- (void)setUnknownPackage:(id)arg1 {
    id currentProfile = [[self installConfiguration] profile];
    id pkgObj = [self->_package respondsToSelector:@selector(packageobject)] ? [self->_package packageobject] : nil;

    if (pkgObj != currentProfile) {
        [self setPackage:arg1];
        [[self installConfiguration] setSelectedPackage:arg1 forUser:YES];
        [[self installConfiguration] setNewBottleName:@""];
    }
}

- (BOOL)isUnknownPackage {
    id pkg = [self package];
    if (pkg && [pkg respondsToSelector:@selector(packageid)]) {
        return [[pkg packageid] isEqualToString:@"com.codeweavers.unknown"];
    }
    return NO;
}

- (void)install {
    if ([[self installConfiguration] hasBottle]) {
        if ([[self installConfiguration] hasInstallerSource]) {
            [self startInstallation];
        } else {
            [self selectInstaller:nil];
        }
    } else {
        [self selectBottleWithCompletion:^{
            if ([[self installConfiguration] hasBottle]) {
                [self install];
            }
        }];
    }
}

- (void)cancel {
    if ([self status] == 1 && ![self cancelled]) {
        [self setCancelled:YES];
        [self continueInstallation];
    }
}

- (void)startInstallation {
    [self setCancelled:NO];

    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [self setInstallQueue:q];
    [q release];

    id engine = [[self installConfiguration] newInstallEngine];
    [self setInstallEngine:engine];
    [engine release];

    [self setInstallStepsCancelled:0];
    [self setInstallStepsCompleted:0];
    [self setInstallStepsSkipped:0];

    NSArray *tasks = [engine respondsToSelector:@selector(sortedTasks)] ? [engine sortedTasks] : nil;
    [self setTotalInstallSteps:[tasks count]];

    NSAttributedString *empty = [[NSAttributedString alloc] initWithString:@""];
    [self setCompletionNotes:empty];
    [empty release];

    [self startDownloadProgressTimer];
    [self setStatus:1];

    id d = [self delegate];
    if (d && [d respondsToSelector:@selector(installationStarted)]) {
        [d installationStarted];
    }

    [self spoolAvailableTasks];
}

- (void)selectInstaller:(id)arg1 {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:YES];

    NSString *msg = [[NSBundle mainBundle] localizedStringForKey:@"Please choose a Windows installer file or a directory that will be treated as an installation volume" value:@"" table:nil];
    [panel setMessage:msg];
    NSString *prompt = [[NSBundle mainBundle] localizedStringForKey:@"Choose installer" value:@"" table:nil];
    [panel setPrompt:prompt];
    [panel setAllowedFileTypes:@[@"exe", @"msi", @"bat", @"cmd", @"c4p", @"tie", @"iso", @"bin", @"cue", @"dmg"]];

    id d = [self delegate];
    NSWindow *win = [d respondsToSelector:@selector(window)] ? [d window] : [NSApp mainWindow];

    __block typeof(self) weakSelf = self;
    [panel beginSheetModalForWindow:win completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            NSURL *url = [panel URL];
            NSString *path = [url path];
            [[weakSelf installConfiguration] setInstallerSource:path forUser:YES];
            if (!arg1) {
                [weakSelf install];
            }
        }
    }];
}

- (void)selectBottleWithCompletion:(id)arg1 {
    SelectBottleSheetController *sbc = [[SelectBottleSheetController alloc] initWithInstallConfiguration:[self installConfiguration]];
    id d = [self delegate];
    NSWindow *win = [d respondsToSelector:@selector(window)] ? [d window] : [NSApp mainWindow];

    void (^completionBlock)(void) = [arg1 copy];
    [win beginSheet:[sbc window] completionHandler:^(NSModalResponse returnCode) {
        if (completionBlock) {
            completionBlock();
            [completionBlock release];
        }
        [sbc release];
    }];
}

- (void)installOptions {
    InstallOptionsSheetController *opts = [[InstallOptionsSheetController alloc] initWithInstallConfiguration:[self installConfiguration]];
    id d = [self delegate];
    NSWindow *win = [d respondsToSelector:@selector(window)] ? [d window] : [NSApp mainWindow];

    [win beginSheet:[opts window] completionHandler:^(NSModalResponse returnCode) {
        [opts release];
    }];
}

- (void)queueInstallOperationWithTaskStatus:(id)arg1 {
    InstallationOperation *op = [[InstallationOperation alloc] initWithTaskStatus:arg1 completionSelector:@selector(taskCompleted:) andTarget:self];
    [arg1 setInstallOp:op];
    [[self installQueue] addOperation:op];
    [op release];
}

- (void)addTaskToQueue:(id)arg1 {
    id engine = [self installEngine];
    if ([engine respondsToSelector:@selector(schedule:)]) {
        NSNumber *sched = [engine schedule:arg1];
        if ([sched boolValue]) {
            TaskStatus *ts = [[TaskStatus alloc] initWithTask:arg1];
            [[self currentTasks] addObject:ts];
            [self queueInstallOperationWithTaskStatus:ts];
            [ts release];
        }
    }
}

- (id)visibleTask {
    for (TaskStatus *ts in [self currentTasks]) {
        NSString *lbl = [ts label];
        if ([lbl length] > 0 && ![ts finished]) {
            return ts;
        }
    }
    return nil;
}

- (id)currentTaskDescription {
    id vt = [self visibleTask];
    if (vt && [vt respondsToSelector:@selector(label)]) {
        return [vt label];
    }
    return [[NSBundle mainBundle] localizedStringForKey:@"In Process…" value:@"" table:nil];
}

- (void)startDownloadProgressTimer {
    if (!self->_downloadUpdateTimer) {
        self->_downloadUpdateTimer = [[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateDownloadProgress:) userInfo:nil repeats:YES] retain];
    }
}

- (void)stopDownloadProgressTimer {
    if (self->_downloadUpdateTimer) {
        [self->_downloadUpdateTimer invalidate];
        [self->_downloadUpdateTimer release];
        self->_downloadUpdateTimer = nil;
    }
}

- (void)updateDownloadProgress:(id)arg1 {
    id vt = [self visibleTask];
    if (!vt) {
        [self setCurrentTaskDownloadDescription:nil];
        return;
    }

    id t = [vt respondsToSelector:@selector(task)] ? [vt task] : nil;
    if (t && [[t valueForKey:@"download_task"] boolValue]) {
        long long total = [[t valueForKey:@"size"] longLongValue];
        long long downloaded = [[t valueForKey:@"downloaded"] longLongValue];
        if (total > 0 && downloaded > 0) {
            if (!_byteCountFormatter) {
                _byteCountFormatter = [[NSByteCountFormatter alloc] init];
                [_byteCountFormatter setZeroPadsFractionDigits:YES];
                [_byteCountFormatter setFormattingContext:NSFormattingContextStandalone];
            }
            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"%1$@ / %2$@" value:@"" table:nil];
            NSString *downStr = [_byteCountFormatter stringFromByteCount:downloaded];
            NSString *totStr = [_byteCountFormatter stringFromByteCount:total];
            [self setCurrentTaskDownloadDescription:[NSString stringWithFormat:fmt, downStr, totStr]];
            return;
        }
    }
    [self setCurrentTaskDownloadDescription:nil];
}

- (void)spoolAvailableTasks {
    if ([self->_failedTasks count] > 0) {
        [self displayNextFailureMessage];
        return;
    }

    id engine = [self installEngine];
    NSArray *runnable = [engine respondsToSelector:@selector(sortedRunnable)] ? [engine sortedRunnable] : nil;

    [self willChangeValueForKey:@"currentTaskDescription"];
    for (id t in runnable) {
        [self addTaskToQueue:t];
    }
    [self didChangeValueForKey:@"currentTaskDescription"];

    BottleCollection *bc = (BottleCollection *)[self bottleCollection];
    NSString *bName = [[self installConfiguration] bottleName];
    if (bc && bName) {
        BottleWrapper *b = [bc bottleWithName:bName];
        if (b) {
            id installingStatus = [[CXSetupLib cxSetupClass] bottleStatus:@"INSTALLING"];
            if (installingStatus) {
                [b addStatusOverride:installingStatus];
            }
        }
    }
}

- (void)taskCompleted:(id)arg1 {
    if (![[arg1 installOp] isCancelled]) {
        if ([arg1 success]) {
            [arg1 done];
            [[self currentTasks] removeObject:arg1];
            [self setInstallStepsCompleted:[self installStepsCompleted] + 1];
        } else {
            [[self failedTasks] addObject:arg1];
        }
        [self continueInstallation];
    }
}

- (void)addBottleToInstallTask:(id)arg1 {
    if ([self status] == 0) {
        NSDictionary *bottles = [[self installConfiguration] bottles];
        NSString *name = [arg1 respondsToSelector:@selector(name)] ? [arg1 name] : nil;
        if (name && ![bottles objectForKey:name]) {
            [[self installConfiguration] addBottle:arg1];
            if ([arg1 respondsToSelector:@selector(isIsInstalledPackagesReady)] && [arg1 isIsInstalledPackagesReady]) {
                [[self installConfiguration] installedApplicationsReady:arg1];
            }
        }
    }
}

- (void)removeBottleFromInstallTask:(id)arg1 {
    if ([self status] == 0) {
        NSDictionary *bottles = [[self installConfiguration] bottles];
        NSString *name = [arg1 respondsToSelector:@selector(name)] ? [arg1 name] : nil;
        if (name && [bottles objectForKey:name]) {
            [[self installConfiguration] removeBottle:arg1];
        }
    }
}

- (void)trackBottle:(id)arg1 {
    if (arg1) {
        [arg1 addObserver:self forKeyPath:@"canInstall" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:_PackageInstallerKVOContext];
        [arg1 addObserver:self forKeyPath:@"isInstalledPackagesReady" options:0 context:_PackageInstallerKVOContext];
    }
}

- (void)stopTrackingBottle:(id)arg1 {
    if (arg1) {
        [arg1 removeObserver:self forKeyPath:@"canInstall" context:_PackageInstallerKVOContext];
        [arg1 removeObserver:self forKeyPath:@"isInstalledPackagesReady" context:_PackageInstallerKVOContext];
        if ([arg1 respondsToSelector:@selector(isCanInstall)] && [arg1 isCanInstall]) {
            [self removeBottleFromInstallTask:arg1];
        }
    }
}

- (void)bottleLoadedInfo:(id)arg1 {
    if ([self status] == 0) {
        if ([arg1 respondsToSelector:@selector(isIsInstalledPackagesReady)] && [arg1 isIsInstalledPackagesReady]) {
            [[self installConfiguration] installedApplicationsReady:arg1];
        }
    }
}

- (void)continueInstallation {
    id engine = [self installEngine];
    BOOL allDone = [engine respondsToSelector:@selector(allDone)] && [[engine allDone] boolValue];

    if (allDone || [self cancelled]) {
        [self installationOver];
    } else {
        [self spoolAvailableTasks];
    }
}

- (void)cancelTask:(id)arg1 {
    if (arg1) {
        if ([arg1 respondsToSelector:@selector(cancel)]) {
            [arg1 cancel];
        }
        [[self currentTasks] removeObject:arg1];
        [[self failedTasks] removeObject:arg1];
    }
}

- (void)installationOver {
    [self stopDownloadProgressTimer];
    [[self installQueue] cancelAllOperations];

    while ([[self currentTasks] count] > 0) {
        id t = [[self currentTasks] objectAtIndex:0];
        [self cancelTask:t];
    }

    while ([[self failedTasks] count] > 0) {
        id t = [[self failedTasks] objectAtIndex:0];
        [self cancelTask:t];
    }

    id engine = [self installEngine];
    while (engine && [engine respondsToSelector:@selector(allDone)] && ![[engine allDone] boolValue]) {
        NSArray *runnable = [engine respondsToSelector:@selector(sortedRunnable)] ? [engine sortedRunnable] : nil;
        [runnable makeObjectsPerformSelector:@selector(done)];
    }

    [self updateCompletionNotes];

    BottleCollection *bc = (BottleCollection *)[self bottleCollection];
    NSString *bName = [[self installConfiguration] bottleName];
    if (bc && bName) {
        BottleWrapper *b = [bc bottleWithName:bName];
        if (b) {
            [b reloadInfo];
            id installingStatus = [[CXSetupLib cxSetupClass] bottleStatus:@"INSTALLING"];
            if (installingStatus) {
                [b removeAllStatusOverrides:installingStatus];
            }
            [self setBottle:b];
        } else {
            [bc refresh];
        }
    }

    [self setTotalInstallSteps:0];

    if (![self cancelled] && [self installStepsCancelled] == 0) {
        NSString *postUrl = [[self installConfiguration] postInstallURL];
        if ([postUrl length] > 0) {
            NSURL *u = [NSURL URLWithString:postUrl];
            if (u) {
                [[NSWorkspace sharedWorkspace] openURL:u];
            }
        }
    }

    if ([self cancelled]) {
        [self setStatus:0];
        [[self installConfiguration] triggerBottleAnalysis];
    } else {
        [self setStatus:2];
    }

    [self updateInstallationNotes];
    [self updateSummaryDetails];

    id d = [self delegate];
    if (d && [d respondsToSelector:@selector(installationCompleted)]) {
        [d installationCompleted];
    }
}

- (void)addMountedVolumes {
    NSNotificationCenter *nc = [[NSWorkspace sharedWorkspace] notificationCenter];
    [nc addObserver:self selector:@selector(observeMount:) name:NSWorkspaceDidMountNotification object:nil];
    [nc addObserver:self selector:@selector(observeUnmount:) name:NSWorkspaceDidUnmountNotification object:nil];

    NSArray *vols = [[NSFileManager defaultManager] mountedVolumeURLsIncludingResourceValuesForKeys:nil options:NSVolumeEnumerationSkipHiddenVolumes];
    for (NSURL *u in vols) {
        NSString *p = [u path];
        if ([CDTools isValidInstallerVolume:p requireRemovable:YES]) {
            [[self installConfiguration] addSourceMedia:p];
            if ([[self installConfiguration] volumeMatchesProfile:p]) {
                [[self installConfiguration] setInstallerSource:p forUser:NO];
            }
        }
    }
}

- (void)observeMount:(id)arg1 {
    NSString *devPath = [[arg1 userInfo] objectForKey:@"NSDevicePath"];
    if (devPath && [CDTools isValidInstallerVolume:devPath requireRemovable:YES]) {
        [[self installConfiguration] addSourceMedia:devPath];
        [[self installConfiguration] setInstallerSource:devPath forUser:NO];
    }
}

- (void)observeUnmount:(id)arg1 {
    NSString *devPath = [[arg1 userInfo] objectForKey:@"NSDevicePath"];
    if (devPath) {
        [[self installConfiguration] removeSourceMedia:devPath];
    }
}

- (void)autoPlayWithParsedAutorunFile:(id)arg1 {
    [[self installConfiguration] useAutorunFile:arg1];
    [[self installConfiguration] autoFillSettings];
}

- (void)updateProfiles {
    if ([self status] == 0) {
        [[self installConfiguration] updateProfiles];
    }
}

- (void)updateInstallationNotes {
    if ([self status] != 1) {
        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
        if ([[self installConfiguration] hasPackage]) {
            NSString *notes = [[self installConfiguration] installationNotes];
            if ([notes length] > 0) {
                NSFont *font = [NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSControlSizeRegular]];
                NSAttributedString *as = [NSAttributedString cx_attributedStringWithHTML:notes font:font];
                if (as) {
                    [mas appendAttributedString:as];
                }
            }
        }
        if (![[mas string] isEqualToString:[[self installationNotes] string]]) {
            [self setInstallationNotes:mas];
        }
        [mas release];
    }
}

- (id)detailsFromDictionary:(id)arg1 withAction:(SEL)arg2 {
    NSMutableArray *res = [NSMutableArray array];
    if (!arg1) return res;

    for (NSString *key in arg1) {
        NSArray *items = [arg1 objectForKey:key];
        if ([items isKindOfClass:[NSArray class]]) {
            for (id item in items) {
                NSInteger type = 2; // note
                if ([key isEqualToString:@"errors"]) {
                    type = 0;
                } else if ([key isEqualToString:@"warnings"]) {
                    type = 1;
                }
                SummaryDetail *sd = [SummaryDetail detailWithType:type label:item action:arg2];
                if (sd) {
                    [res addObject:sd];
                }
            }
        }
    }
    return res;
}

- (id)detailsFromDictionary:(id)arg1 {
    return [self detailsFromDictionary:arg1 withAction:NULL];
}

- (void)updateSummaryDetails {
    if ([self status] != 1) {
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:[self detailsFromDictionary:[[self installConfiguration] miscDetails]]];
        [arr addObjectsFromArray:[self detailsFromDictionary:[[self installConfiguration] installerDetails] withAction:@selector(editInstallerSource:)]];
        [arr addObjectsFromArray:[self detailsFromDictionary:[[self installConfiguration] bottleDetails] withAction:@selector(selectBottle:)]];
        [arr addObjectsFromArray:[self detailsFromDictionary:[[self installConfiguration] languageDetails] withAction:@selector(installOptions:)]];
        [arr addObjectsFromArray:[self detailsFromDictionary:[[self installConfiguration] dependencyDetails]]];

        BOOL hasBottleDetail = NO;
        for (SummaryDetail *sd in arr) {
            if ([sd action] == @selector(selectBottle:)) {
                hasBottleDetail = YES;
                break;
            }
        }
        if (!hasBottleDetail) {
            NSString *bName = [[self installConfiguration] bottleName] ?: [[self installConfiguration] nameForNewBottle];
            if ([bName length] == 0) {
                bName = @"New Bottle";
            }
            NSString *bottleLabel = [NSString stringWithFormat:@"Install into <b>%@</b>", bName];
            SummaryDetail *bottleDetail = [SummaryDetail detailWithType:2 label:bottleLabel action:@selector(selectBottle:)];
            if (bottleDetail) [arr addObject:bottleDetail];
        }

        BOOL hasInstallerDetail = NO;
        for (SummaryDetail *sd in arr) {
            if ([sd action] == @selector(editInstallerSource:)) {
                hasInstallerDetail = YES;
                break;
            }
        }
        if (!hasInstallerDetail) {
            NSString *src = [[self installConfiguration] installerSource];
            NSString *srcLabel = [src length] > 0 ? [NSString stringWithFormat:@"Installer: <b>%@</b>", [src lastPathComponent]] : @"Select installer source";
            SummaryDetail *srcDetail = [SummaryDetail detailWithType:([src length] > 0 ? 2 : 1) label:srcLabel action:@selector(editInstallerSource:)];
            if (srcDetail) [arr addObject:srcDetail];
        }

        for (SummaryDetail *sd in arr) {
            NSString *symName = @"sf-symbols.checkmark.circle";
            if ([sd type] == 0) {
                symName = @"sf-symbols.xmark.octagon.fill";
            } else if ([sd type] == 1) {
                symName = @"sf-symbols.exclamationmark.circle.fill";
            }
            NSImage *img = [NSImage imageNamed:symName];
            if (!img && [NSImage respondsToSelector:@selector(imageWithSystemSymbolName:accessibilityDescription:)]) {
                NSString *sfName = [symName stringByReplacingOccurrencesOfString:@"sf-symbols." withString:@""];
                img = [NSImage imageWithSystemSymbolName:sfName accessibilityDescription:nil];
            }
            [sd setImage:img];
        }
        [self setSummaryDetails:arr];
    }
}

- (void)updateCompletionNotes {
    NSString *msg = nil;
    if ([self cancelled]) {
        msg = [[NSBundle mainBundle] localizedStringForKey:@"The installation was canceled." value:@"" table:nil];
    } else if ([self installStepsCancelled] != 0) {
        msg = [[NSBundle mainBundle] localizedStringForKey:@"The installation failed." value:@"" table:nil];
    } else if ([[self installConfiguration] installWithSteam]) {
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"%@ has configured the bottle '%@' for installing %@ via Steam. You will need to finish the installation in Steam." value:@"" table:nil];
        NSString *appName = [[NSRunningApplication currentApplication] localizedName] ?: @"CrossOver";
        NSString *bName = [[self installConfiguration] bottleName] ?: @"";
        NSString *pkgName = [self package] ? [[self package] description] : @"";
        msg = [NSString stringWithFormat:fmt, appName, bName, pkgName];
    } else if ([self installStepsSkipped] != 0) {
        msg = [[NSBundle mainBundle] localizedStringForKey:@"The installation is complete, but some tasks were skipped." value:@"" table:nil];
    } else {
        msg = [[NSBundle mainBundle] localizedStringForKey:@"The installation is complete." value:@"" table:nil];
    }

    NSMutableString *ms = [NSMutableString stringWithString:msg ?: @""];
    NSString *logPath = [self->_installEngine respondsToSelector:@selector(valueForKey:)] ? [self->_installEngine valueForKey:@"logfile"] : nil;
    if ([logPath length] > 0) {
        NSURL *logURL = [NSURL fileURLWithPath:logPath];
        NSString *diagFmt = [[NSBundle mainBundle] localizedStringForKey:@"More diagnostic information can be found in the <a href = \"%@\">debug log</a>." value:@"" table:nil];
        [ms appendString:@" "];
        [ms appendFormat:diagFmt, [logURL absoluteString]];
    }

    NSAttributedString *as = [NSAttributedString cx_attributedStringWithHTML:ms];
    [self setCompletionNotes:as];
}

- (void)displayNextFailureMessage {
    id d = [self delegate];
    NSWindow *win = [d respondsToSelector:@selector(window)] ? [d window] : [NSApp mainWindow];
    if ([win attachedSheet]) {
        return;
    }

    if ([self->_failedTasks count] == 0) return;

    TaskStatus *ts = [[self->_failedTasks objectAtIndex:0] retain];
    [ts setInstallOp:nil];
    [self->_failedTasks removeObject:ts];

    AIETask *task = [ts task];
    NSString *lbl = [ts label];
    BOOL needsDownload = [[task valueForKey:@"needs_download"] boolValue];

    NSString *msg = nil;
    if (needsDownload) {
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Could not download the '%@' installer." value:@"" table:nil];
        NSString *coreName = [task valueForKeyPath:@"aiecore.name"] ?: lbl;
        msg = [NSString stringWithFormat:fmt, coreName];
    } else if ([lbl length] > 0) {
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"The '%@' task failed." value:@"" table:nil];
        msg = [NSString stringWithFormat:fmt, lbl];
    } else {
        msg = [[NSBundle mainBundle] localizedStringForKey:@"An unknown installer task failed." value:@"" table:nil];
    }

    NSString *info = [[NSBundle mainBundle] localizedStringForKey:@"Continuing with the install may produce unpredictable results." value:@"" table:nil];
    NSString *err = [task valueForKey:@"error"];
    if ([err length] > 0) {
        info = [info stringByAppendingFormat:@"\n%@", err];
    }

    NSTextField *accView = nil;
    if (needsDownload) {
        NSString *dlUrl = [task valueForKey:@"download_page_url"];
        if ([dlUrl length] > 0) {
            NSString *extra = [[NSBundle mainBundle] localizedStringForKey:@"If you have a working internet connection via your browser, you can download this file here:" value:@"" table:nil];
            info = [info stringByAppendingFormat:@"\n\n%@", extra];
            NSString *html = [NSString stringWithFormat:@"<a href = \"%@\">%@</a>", dlUrl, dlUrl];
            NSAttributedString *as = [NSAttributedString cx_attributedStringWithHTML:html];
            accView = [NSTextField labelWithAttributedString:as];
            [accView setAllowsEditingTextAttributes:YES];
            [accView setSelectable:YES];
        }
    }

    [[self installQueue] setSuspended:YES];

    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:msg];
    [alert setInformativeText:info];
    if (accView) [alert setAccessoryView:accView];

    NSButton *b1 = [alert addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Cancel Installation" value:@"" table:nil]];
    [b1 setTag:1000];
    NSButton *b2 = [alert addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Skip This Step" value:@"" table:nil]];
    [b2 setTag:1001];

    if (needsDownload) {
        NSButton *b3 = [alert addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Pick Installer File" value:@"" table:nil]];
        [b3 setTag:1002];
    }

    NSButton *b4 = [alert addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Try Again" value:@"" table:nil]];
    [b4 setTag:1003];

    __block typeof(self) weakSelf = self;
    [alert beginSheetModalForWindow:win completionHandler:^(NSModalResponse returnCode) {
        [[alert window] orderOut:weakSelf];
        switch (returnCode) {
            case 1003: // Try again
                [weakSelf queueInstallOperationWithTaskStatus:ts];
                [[weakSelf installQueue] setSuspended:NO];
                [weakSelf continueInstallation];
                break;

            case 1002: { // Pick installer file
                NSOpenPanel *op = [NSOpenPanel openPanel];
                [op setCanChooseFiles:YES];
                [op setCanChooseDirectories:NO];
                NSString *pPrompt = [[NSBundle mainBundle] localizedStringForKey:@"Use this installer" value:@"" table:nil];
                [op setPrompt:pPrompt];
                [op setAllowedFileTypes:@[@"exe", @"msi", @"bat", @"cmd", @"c4p", @"tie", @"iso", @"bin", @"dmg"]];
                [op beginSheetModalForWindow:win completionHandler:^(NSModalResponse r) {
                    [op orderOut:weakSelf];
                    if (r == NSModalResponseOK) {
                        NSString *chosenPath = [[op URL] path];
                        [[ts task] setValue:chosenPath forKeyPath:@"aiecore.state.install_source"];
                        [weakSelf queueInstallOperationWithTaskStatus:ts];
                    } else {
                        [[weakSelf failedTasks] insertObject:ts atIndex:0];
                        [weakSelf displayNextFailureMessage];
                    }
                    [[weakSelf installQueue] setSuspended:NO];
                }];
                break;
            }

            default:
                if (returnCode == 1000) { // Cancel
                    [weakSelf setCancelled:YES];
                    [weakSelf setInstallStepsCancelled:[weakSelf installStepsCancelled] + 1];
                    [task done];
                } else { // Skip
                    [task done];
                    [[weakSelf currentTasks] removeObject:ts];
                    [weakSelf setInstallStepsCompleted:[weakSelf installStepsCompleted] + 1];
                    [weakSelf setInstallStepsSkipped:[weakSelf installStepsSkipped] + 1];
                }
                [[weakSelf installQueue] setSuspended:NO];
                [weakSelf continueInstallation];
                break;
        }
        [alert release];
        [ts release];
    }];
}

- (void)profileChanged {
    id profile = [[self installConfiguration] profile];
    id currentObj = [self->_package respondsToSelector:@selector(packageobject)] ? [self->_package packageobject] : nil;

    if (currentObj != profile) {
        if (profile) {
            PackageTreeNode *node = [[PackageTreeNode alloc] initWithProfile:profile];
            [self setPackage:node];
            [node release];
        }
        [[self installConfiguration] setSelectedPackage:[self package] forUser:NO];
        [self updateInstallationNotes];
        [self updateSummaryDetails];
    } else {
        [self updateInstallationNotes];
        [self updateSummaryDetails];
    }
}

- (void)sourceChanged {
    [self updateInstallationNotes];
    [self updateSummaryDetails];
}

- (void)bottleCreateChanged {
    [self updateInstallationNotes];
    [self updateSummaryDetails];
}

- (void)bottleNewnameChanged {
    [self updateInstallationNotes];
    [self updateSummaryDetails];
}

- (void)bottleTemplateChanged {
    [self updateInstallationNotes];
    [self updateSummaryDetails];
}

- (void)bottleNameChanged {
    [self updateInstallationNotes];
    [self updateSummaryDetails];
}

- (void)categorizedAllBottles {
}

- (void)analyzedBottle:(id)arg1 {
    [self updateInstallationNotes];
    [self updateSummaryDetails];
}

- (id)delegate {
    return objc_loadWeakRetained((id *)&self->_delegate);
}

- (void)setDelegate:(id)arg1 {
    objc_storeWeak((id *)&self->_delegate, arg1);
}

- (id)installConfiguration {
    return self->_installConfiguration;
}

- (void)setInstallConfiguration:(id)arg1 {
    if (self->_installConfiguration != arg1) {
        [self->_installConfiguration release];
        self->_installConfiguration = [arg1 retain];
    }
}

- (id)package {
    return self->_package;
}

- (void)setPackage:(id)arg1 {
    if (self->_package != arg1) {
        [self->_package release];
        self->_package = [arg1 retain];
    }
}

- (id)bottle {
    return objc_loadWeakRetained((id *)&self->_bottle);
}

- (void)setBottle:(id)arg1 {
    objc_storeWeak((id *)&self->_bottle, arg1);
}

- (id)currentTaskDownloadDescription {
    return self->_currentTaskDownloadDescription;
}

- (void)setCurrentTaskDownloadDescription:(id)arg1 {
    if (self->_currentTaskDownloadDescription != arg1) {
        [self->_currentTaskDownloadDescription release];
        self->_currentTaskDownloadDescription = [arg1 retain];
    }
}

- (NSInteger)installStepsCancelled {
    return self->_installStepsCancelled;
}

- (void)setInstallStepsCancelled:(NSInteger)arg1 {
    self->_installStepsCancelled = arg1;
}

- (NSInteger)installStepsCompleted {
    return self->_installStepsCompleted;
}

- (void)setInstallStepsCompleted:(NSInteger)arg1 {
    self->_installStepsCompleted = arg1;
}

- (NSInteger)installStepsSkipped {
    return self->_installStepsSkipped;
}

- (void)setInstallStepsSkipped:(NSInteger)arg1 {
    self->_installStepsSkipped = arg1;
}

- (NSInteger)totalInstallSteps {
    return self->_totalInstallSteps;
}

- (void)setTotalInstallSteps:(NSInteger)arg1 {
    self->_totalInstallSteps = arg1;
}

- (id)completionNotes {
    return self->_completionNotes;
}

- (void)setCompletionNotes:(id)arg1 {
    if (self->_completionNotes != arg1) {
        [self->_completionNotes release];
        self->_completionNotes = [arg1 copy];
    }
}

- (id)installationNotes {
    return self->_installationNotes;
}

- (void)setInstallationNotes:(id)arg1 {
    if (self->_installationNotes != arg1) {
        [self->_installationNotes release];
        self->_installationNotes = [arg1 copy];
    }
}

- (id)summaryDetails {
    return self->_summaryDetails;
}

- (void)setSummaryDetails:(id)arg1 {
    if (self->_summaryDetails != arg1) {
        [self->_summaryDetails release];
        self->_summaryDetails = [arg1 copy];
    }
}

- (NSInteger)status {
    return self->_status;
}

- (void)setStatus:(NSInteger)arg1 {
    self->_status = arg1;
}

- (id)installEngine {
    return self->_installEngine;
}

- (void)setInstallEngine:(id)arg1 {
    if (self->_installEngine != arg1) {
        [self->_installEngine release];
        self->_installEngine = [arg1 retain];
    }
}

- (id)installQueue {
    return self->_installQueue;
}

- (void)setInstallQueue:(id)arg1 {
    if (self->_installQueue != arg1) {
        [self->_installQueue release];
        self->_installQueue = [arg1 retain];
    }
}

- (id)currentTasks {
    return self->_currentTasks;
}

- (void)setCurrentTasks:(id)arg1 {
    if (self->_currentTasks != arg1) {
        [self->_currentTasks release];
        self->_currentTasks = [arg1 retain];
    }
}

- (id)failedTasks {
    return self->_failedTasks;
}

- (void)setFailedTasks:(id)arg1 {
    if (self->_failedTasks != arg1) {
        [self->_failedTasks release];
        self->_failedTasks = [arg1 retain];
    }
}

- (BOOL)cancelled {
    return self->_cancelled;
}

- (void)setCancelled:(BOOL)arg1 {
    self->_cancelled = arg1;
}

- (id)downloadUpdateTimer {
    return self->_downloadUpdateTimer;
}

- (void)setDownloadUpdateTimer:(id)arg1 {
    if (self->_downloadUpdateTimer != arg1) {
        [self->_downloadUpdateTimer release];
        self->_downloadUpdateTimer = [arg1 retain];
    }
}

- (id)bottleCollection {
    return objc_loadWeakRetained((id *)&self->_bottleCollection);
}

@end
