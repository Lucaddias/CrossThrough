// CXServer.m — CrossThrough
#import "CXServer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import <mach/machine.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <fcntl.h>

#import "helperServer.h"

static void _observeProxyChange(SCDynamicStoreRef store, CFArrayRef changedKeys, void *info) {
    if (info) {
        [(CXServer *)info setHttpProxyEnvironmentVariableFromSystemConfiguration];
    }
}

@implementation CXServer

+ (id)getCellarID {
    return @"CrossOver";
}

+ (id)getAppSupportDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *base = [paths objectAtIndex:0];
    return [base stringByAppendingPathComponent:[self getCellarID]];
}

+ (id)getCachesDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *base = [paths objectAtIndex:0];
    return [base stringByAppendingPathComponent:@"com.codeweavers.CrossOver"];
}

+ (id)getDefaultBottleDir {
    return [[self getAppSupportDir] stringByAppendingPathComponent:@"Bottles"];
}

+ (id)getBottleDir {
    NSString *dir = [[NSUserDefaults standardUserDefaults] stringForKey:@"BottleDir"];
    if (dir && [dir length] > 0) {
        return dir;
    }
    return [self getDefaultBottleDir];
}

+ (id)fileTypesForBottle:(id)arg1 {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:4];
    if (!arg1 || ![arg1 respondsToSelector:@selector(winePrefix)]) {
        return result;
    }

    NSString *plistPath = [NSString stringWithFormat:@"%@/desktopdata/cxassoc/cxassoc_macosx.plist", [arg1 winePrefix]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:[plistPath stringByResolvingSymlinksInPath]]) {
        NSData *data = [NSData dataWithContentsOfFile:plistPath];
        if (data) {
            NSError *error = nil;
            id plist = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:&error];
            if ([plist isKindOfClass:[NSDictionary class]]) {
                NSString *bottleName = [arg1 respondsToSelector:@selector(name)] ? [arg1 name] : nil;
                for (id key in plist) {
                    NSDictionary *entry = [plist objectForKey:key];
                    if ([entry isKindOfClass:[NSDictionary class]]) {
                        NSString *desc = [entry objectForKey:@"Description"];
                        NSDictionary *assoc = [entry objectForKey:@"Extension Associations/"];
                        if (bottleName && desc && [desc caseInsensitiveCompare:bottleName] == NSOrderedSame && [assoc isKindOfClass:[NSDictionary class]]) {
                            for (NSString *assocKey in assoc) {
                                NSDictionary *assocEntry = [assoc objectForKey:assocKey];
                                NSString *ext = [assocEntry isKindOfClass:[NSDictionary class]] ? [assocEntry objectForKey:@"Extension"] : nil;
                                if (!ext) {
                                    NSArray *comps = [assocKey componentsSeparatedByString:@"/"];
                                    if ([comps count] > 0) {
                                        NSString *first = [comps objectAtIndex:0];
                                        if ([first length] > 1) {
                                            ext = [first substringFromIndex:1];
                                        }
                                    }
                                }
                                if (ext) {
                                    [result addObject:ext];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return result;
}

- (id)init {
    self = [super init];
    if (self) {
        NSDictionary *defaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"", @"FirstRunVersion",
                                  [NSNumber numberWithInt:10], @"RecentItemsCount",
                                  [CXServer getDefaultBottleDir], @"BottleDir",
                                  [NSArray array], @"ManagedBottleDirs",
                                  [NSArray array], @"RecentItems",
                                  @"http://ftp.codeweavers.com/pub/crossover/tie/crossover.tie.gz", @"TieURL",
                                  [NSNumber numberWithBool:YES], @"ShowUntestedApps",
                                  [NSNumber numberWithBool:YES], @"InstallExeFiles",
                                  nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
        self->pendingAppLaunches = [[NSMutableArray alloc] initWithCapacity:3];
        self->tasksInProgress = [[NSMutableDictionary alloc] initWithCapacity:3];
        [helperServer defaultHelperServer];
        self->backgroundQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    if (self->systemDynamicStore) {
        CFRunLoopSourceRef src = SCDynamicStoreCreateRunLoopSource(NULL, (SCDynamicStoreRef)self->systemDynamicStore, 0);
        if (src) {
            CFRunLoopRemoveSource(CFRunLoopGetCurrent(), src, kCFRunLoopCommonModes);
            CFRelease(src);
        }
        CFRelease((SCDynamicStoreRef)self->systemDynamicStore);
        self->systemDynamicStore = NULL;
    }

    [self->openRecent release];
    self->openRecent = nil;
    [self->pendingAppLaunches release];
    self->pendingAppLaunches = nil;
    [self->launchFeedbackTimer invalidate];
    [self->launchFeedbackTimer release];
    self->launchFeedbackTimer = nil;
    [self->shutdownController release];
    self->shutdownController = nil;
    [self->demoRegisterController release];
    self->demoRegisterController = nil;
    [self->tasksInProgress release];
    self->tasksInProgress = nil;
    [self->backgroundQueue release];
    self->backgroundQueue = nil;
    [self->startAppOp release];
    self->startAppOp = nil;
    [self->lastDemoNagTime release];
    self->lastDemoNagTime = nil;

    [super dealloc];
}

- (id)demoRegisterController {
    if (!self->demoRegisterController) {
        self->demoRegisterController = [[DemoRegisterController alloc] init];
    }
    return self->demoRegisterController;
}

- (id)shutdownController {
    if (!self->shutdownController) {
        self->shutdownController = [[ShutdownController alloc] init];
    }
    return self->shutdownController;
}

- (void)doPeriodicDemoNagForCommand:(id)arg1 withArgs:(id)arg2 {
    [self setMenusEnabled:NO];
    DemoNagController *nag = [[DemoNagController alloc] init];
    __block typeof(self) weakSelf = self;
    NSString *cmd = [arg1 copy];
    NSDictionary *args = [arg2 copy];
    [nag beginWindowWithCompletionHandler:^(id res) {
        [weakSelf setMenusEnabled:YES];
        [weakSelf forkExecCommand:cmd withArgs:args];
        [cmd release];
        [args release];
    }];
    [nag release];
}

- (void)demoCheck {
    if ([[CXApplication sharedApplication] isDemo]) {
        DemoNagController *nag = [[DemoNagController alloc] init];
        [nag beginWindowWithCompletionHandler:^{
            [self continueFromDemoCheck];
        }];
        [nag release];
    } else {
        [self continueFromDemoCheck];
    }
}

- (void)registerDemo:(id)arg1 {
    [[self demoRegisterController] showWindow:arg1];
}

- (BOOL)menusEnabled {
    return self->menusEnabled;
}

- (void)setMenusEnabled:(BOOL)arg1 {
    self->menusEnabled = arg1;
}

// Releases everything queued behind startAppOp (main window, open-file and
// URL requests) once the demo check has passed.
- (void)continueFromDemoCheck {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[helperServer defaultHelperServer] setIsReady];
        [[self startAppOp] start];
    });
    [self updateRecentItemsMenu];
    [self setMenusEnabled:YES];
}

- (id)startAppOp {
    @synchronized (self) {
        if (!self->startAppOp) {
            self->startAppOp = [[NSOperation alloc] init];
        }
        return self->startAppOp;
    }
}

- (void)rosettaCheck {
#if TARGET_CPU_ARM64
    if (!CFBundleIsArchitectureLoadable(CPU_TYPE_X86_64)) {
        RosettaInstallationController *ric = [[RosettaInstallationController alloc] init];
        [NSApp runModalForWindow:[ric window]];
        [ric release];
    }
#endif
}

- (void)applicationWillFinishLaunching:(id)arg1 {
    [self rosettaCheck];

    [[NSAppleEventManager sharedAppleEventManager] setEventHandler:self
                                                       andSelector:@selector(handleGetURLEvent:withReplyEvent:)
                                                     forEventClass:kInternetEventClass
                                                        andEventID:kAEGetURL];

    [[CXApplication sharedApplication] setDaysLeft];
    [[CXApplication sharedApplication] setIsDemo];
}

- (void)applicationDidFinishLaunching:(id)arg1 {
    if (!self->gotLaunchEvent) {
        [self applicationOpenUntitledFile:[arg1 object]];
    }

    [self setMenusEnabled:NO];

    NSString *firstVer = [[NSUserDefaults standardUserDefaults] stringForKey:@"FirstRunVersion"];
    if (!firstVer || [firstVer caseInsensitiveCompare:@"26.3.0.39832"] != NSOrderedSame) {
        [self processFirstRun:YES];
    }

    [self checkForHelperUpdate];
    [self setEnvironmentVariables];
    [self demoCheck];
    [self registerForCooperativeActivation];
}

- (void)checkForHelperUpdate {
}

- (void)registerForCooperativeActivation {
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(otherWineAppWillActivate:)
                                                            name:@"com.codeweavers.CrossOver.AppWillActivate"
                                                          object:nil];
}

- (void)otherWineAppWillActivate:(id)arg1 {
    [NSApp yieldActivationToApplication:[arg1 object]];
}

- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1 {
    return nil;
}

- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3 {
}

- (void)finishedLaunches {
    [NSApp setApplicationIconImage:[self applicationIcon]];
}

- (void)updateLaunchNotify {
    if ([self->pendingAppLaunches count] == 0) {
        [self->launchFeedbackTimer invalidate];
        self->launchFeedbackTimer = nil;
        [self finishedLaunches];
        return;
    }

    NSImage *baseIcon = [self applicationIcon];
    NSImage *composite = [[NSImage alloc] initWithSize:[baseIcon size]];
    [composite lockFocus];
    [baseIcon drawAtPoint:NSZeroPoint fromRect:NSZeroRect operation:NSCompositingOperationCopy fraction:1.0];

    NSMutableIndexSet *toRemove = [NSMutableIndexSet indexSet];
    for (NSUInteger i = 0; i < [self->pendingAppLaunches count]; i++) {
        LaunchFeedbackInfo *info = [self->pendingAppLaunches objectAtIndex:i];
        if ([info notified] || [info lifeCounter] >= 800) {
            [toRemove addIndex:i];
        } else {
            [self drawLaunchFeedback:info position:i info:nil];
            [info setLifeCounter:[info lifeCounter] + 1];
        }
    }
    [self->pendingAppLaunches removeObjectsAtIndexes:toRemove];
    [composite unlockFocus];

    [NSApp setApplicationIconImage:composite];
    [composite release];
}

- (id)startLaunchNotify:(id)arg1 {
    if (!arg1) return nil;

    LaunchFeedbackInfo *info = [[LaunchFeedbackInfo alloc] initWithIcon:arg1];
    if (info) {
        [self->pendingAppLaunches addObject:info];
        if (!self->launchFeedbackTimer) {
            self->launchFeedbackTimer = [[NSTimer scheduledTimerWithTimeInterval:0.05
                                                                          target:self
                                                                        selector:@selector(updateLaunchNotify)
                                                                        userInfo:nil
                                                                         repeats:YES] retain];
        }
        [self->launchFeedbackTimer setFireDate:[NSDate date]];
    }
    return [info autorelease];
}

- (void)noteTask:(id)arg1 forCommand:(id)arg2 args:(id)arg3 {
}

- (void)modifyEnvironmentForCommandTask:(id)arg1 {
}

- (void)forkExecCommand:(id)arg1 {
    [self forkExecCommand:arg1 withArgs:@{}];
}

- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2 {
    NSString *workdir = [arg2 objectForKey:@"workdir"] ?: NSHomeDirectory();
    NSImage *icon = [arg2 objectForKey:@"icon"];
    LaunchFeedbackInfo *launchInfo = icon ? [self startLaunchNotify:icon] : nil;

    CXTask *task = [[CXTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [task setArguments:@[@"-c", arg1]];
    [task setCurrentDirectoryPath:workdir];
    [task setStandardInput:[NSFileHandle fileHandleWithNullDevice]];
    [task setStandardOutput:[NSFileHandle fileHandleWithNullDevice]];

    NSPipe *errPipe = [NSPipe pipe];
    int fd = [[errPipe fileHandleForReading] fileDescriptor];
    int flags = fcntl(fd, F_GETFL, 0);
    fcntl(fd, F_SETFL, flags | O_NONBLOCK);
    [task setStandardError:errPipe];

    NSMutableDictionary *env = [[helperServer defaultHelperServer] getEnvironmentForXConnection];
    if (launchInfo && [launchInfo socketPath]) {
        [env setObject:[launchInfo socketPath] forKey:@"CX_LAUNCH_NOTIFY_SOCKET"];
    }
    [self modifyEnvironmentForCommandTask:env];
    [task setEnvironment:env];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(observeTaskTermination:)
                                                 name:NSTaskDidTerminateNotification
                                               object:task];

    [task launch];
    [self noteTask:task forCommand:arg1 args:arg2];

    NSFileHandle *readHandle = [errPipe fileHandleForReading];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(observeTaskErrorOutput:)
                                                 name:NSFileHandleReadToEndOfFileCompletionNotification
                                               object:readHandle];
    [readHandle readToEndOfFileInBackgroundAndNotify];

    NSMutableDictionary *taskInfo = [NSMutableDictionary dictionaryWithObject:task forKey:@"task"];
    [taskInfo addEntriesFromDictionary:arg2];
    if (launchInfo) {
        [taskInfo setObject:launchInfo forKey:@"launchFeedbackInfo"];
    }

    NSValue *taskKey = [NSValue valueWithNonretainedObject:task];
    [self->tasksInProgress setObject:taskInfo forKey:taskKey];
    NSValue *readKey = [NSValue valueWithNonretainedObject:readHandle];
    [self->tasksInProgress setObject:taskInfo forKey:readKey];

    [task release];
}

- (void)observeTaskTermination:(id)arg1 {
    id task = [arg1 object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:task];
    NSValue *key = [NSValue valueWithNonretainedObject:task];
    [self->tasksInProgress removeObjectForKey:key];
}

- (void)observeTaskErrorOutput:(id)arg1 {
    id handle = [arg1 object];
    NSValue *key = [NSValue valueWithNonretainedObject:handle];
    NSDictionary *info = [[self->tasksInProgress objectForKey:key] retain];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:handle];

    NSData *data = [[arg1 userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *errStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    if ([errStr length] > 0) {
        NSLog(@"Task error output: %@", errStr);
    }

    if ([errStr containsString:@"No such file or directory"]) {
        NSAlert *alert = [[NSAlert alloc] init];
        NSString *doc = [info objectForKey:@"doc"];
        if (doc) {
            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"%1$@ was unable to start %2$@." value:@"" table:nil];
            NSString *app = [[NSRunningApplication currentApplication] localizedName] ?: @"CrossOver";
            [alert setMessageText:[NSString stringWithFormat:fmt, app, doc]];
        } else {
            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"%@ was unable to start this application." value:@"" table:nil];
            NSString *app = [[NSRunningApplication currentApplication] localizedName] ?: @"CrossOver";
            [alert setMessageText:[NSString stringWithFormat:fmt, app]];
        }
        NSString *sub = [[NSBundle mainBundle] localizedStringForKey:@"Probably it has been uninstalled or its bottle has been deleted.\n" value:@"" table:nil];
        [alert setInformativeText:sub];
        [alert runModal];
        [alert release];
    }
    [info release];
}

- (void)runClient:(id)arg1 inBottle:(id)arg2 {
    NSString *bottleArg = nil;
    if (arg2) {
        bottleArg = [NSString stringWithFormat:@"--bottle %@", [arg2 stringQuotedForBash]];
    } else {
        bottleArg = @"--bottle default";
    }

    NSString *cxRoot = [[CXApplication sharedApplication] crossOverRoot];
    NSString *cxStart = [[cxRoot stringByAppendingPathComponent:@"bin"] stringByAppendingPathComponent:@"cxstart"];
    NSString *cmd = [NSString stringWithFormat:@"%@ %@ --wait-children --enable-alt-loader macdrv --untrusted %@",
                     [cxStart stringQuotedForBash], bottleArg, [arg1 stringQuotedForBash]];

    NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:arg1];
    NSDictionary *args = icon ? @{@"icon": icon} : @{};
    [self forkExecCommand:cmd withArgs:args];
    [self addToRecentItems:arg1 bottle:arg2];
}

- (void)showLicense:(id)arg1 {
    NSString *lic = [[[CXApplication sharedApplication] crossOverRoot] stringByAppendingPathComponent:@"license.txt"];
    [[NSWorkspace sharedWorkspace] openFile:lic];
}

- (void)setEnvValue:(id)arg1 forKey:(id)arg2 {
    if (arg1 && arg2) {
        setenv([arg2 UTF8String], [arg1 UTF8String], 1);
    }
}

- (void)unsetEnvValueForKey:(id)arg1 {
    if (arg1) {
        unsetenv([arg1 UTF8String]);
    }
}

- (void)setHttpProxyEnvironmentVariableFromSystemConfiguration {
    if (!self->systemDynamicStore) return;

    CFDictionaryRef proxies = SCDynamicStoreCopyProxies((SCDynamicStoreRef)self->systemDynamicStore);
    if (!proxies) return;

    NSDictionary *pDict = (NSDictionary *)proxies;
    NSNumber *httpEnabled = [pDict objectForKey:(NSString *)kSCPropNetProxiesHTTPEnable];
    if ([httpEnabled boolValue]) {
        NSString *host = [pDict objectForKey:(NSString *)kSCPropNetProxiesHTTPProxy];
        NSNumber *port = [pDict objectForKey:(NSString *)kSCPropNetProxiesHTTPPort];
        if ([host length] > 0) {
            NSString *val = [NSString stringWithFormat:@"http://%@:%@/", host, port ?: @(80)];
            [self setEnvValue:val forKey:@"http_proxy"];
        } else {
            [self unsetEnvValueForKey:@"http_proxy"];
        }
    } else {
        [self unsetEnvValueForKey:@"http_proxy"];
    }
    CFRelease(proxies);
}

- (void)beginMonitoringSystemConfigurationProxy {
    SCDynamicStoreContext ctx = {0, self, NULL, NULL, NULL};
    self->systemDynamicStore = (id *)SCDynamicStoreCreate(NULL, CFSTR("CrossOver"), _observeProxyChange, &ctx);
    if (self->systemDynamicStore) {
        CFStringRef key = SCDynamicStoreKeyCreateProxies(NULL);
        if (key) {
            CFArrayRef keys = CFArrayCreate(NULL, (const void **)&key, 1, &kCFTypeArrayCallBacks);
            SCDynamicStoreSetNotificationKeys((SCDynamicStoreRef)self->systemDynamicStore, keys, NULL);
            CFRelease(keys);
            CFRelease(key);
        }

        CFRunLoopSourceRef src = SCDynamicStoreCreateRunLoopSource(NULL, (SCDynamicStoreRef)self->systemDynamicStore, 0);
        if (src) {
            CFRunLoopAddSource(CFRunLoopGetCurrent(), src, kCFRunLoopCommonModes);
            CFRelease(src);
        }
        [self setHttpProxyEnvironmentVariableFromSystemConfiguration];
    }
}

- (id)managedBottlePath {
    NSString *env = [[[NSProcessInfo processInfo] environment] objectForKey:@"CX_MANAGED_BOTTLE_PATH"];
    if (env) return env;

    id defs = [[NSUserDefaults standardUserDefaults] objectForKey:@"ManagedBottleDirs"];
    if ([defs isKindOfClass:[NSArray class]]) {
        return [defs componentsJoinedByString:@":"];
    }
    if ([defs isKindOfClass:[NSString class]] && [defs length] > 0) {
        return defs;
    }
    return nil;
}

- (void)setEnvironmentVariables {
    NSString *home = [[[NSProcessInfo processInfo] environment] objectForKey:@"HOME"];
    BOOL isDir = NO;
    if (!home || ![[NSFileManager defaultManager] fileExistsAtPath:home isDirectory:&isDir] || !isDir) {
        home = NSHomeDirectory();
        [self setEnvValue:home forKey:@"HOME"];
    }

    NSString *bDir = [CXServer getBottleDir];
    [self setEnvValue:[bDir stringInFileSystemRepresentationForm] forKey:@"CX_BOTTLE_PATH"];

    NSString *managed = [self managedBottlePath];
    if (managed) {
        [self setEnvValue:managed forKey:@"CX_MANAGED_BOTTLE_PATH"];
    }

    [self beginMonitoringSystemConfigurationProxy];
    [self setEnvValue:[[NSBundle mainBundle] bundlePath] forKey:@"CX_APP_BUNDLE_PATH"];
}

- (BOOL)validateMenuItem:(id)arg1 {
    if ([self menusEnabled]) return YES;
    NSString *title = [[arg1 menu] title];
    return [title isEqualToString:@"Help"];
}

- (void)runCommand:(id)arg1 {
    RunCommandController *rcc = [[RunCommandController alloc] init];
    [rcc showWindow:arg1];
    [rcc release];
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 copyingItemAtURL:(id)arg3 toURL:(id)arg4 {
    NSLog(@"Error copying %@ to %@: %@", arg3, arg4, arg2);
    return NO;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 linkingItemAtURL:(id)arg3 toURL:(id)arg4 {
    NSLog(@"Error linking %@ to %@: %@", arg3, arg4, arg2);
    return NO;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 movingItemAtURL:(id)arg3 toURL:(id)arg4 {
    NSLog(@"Error moving %@ to %@: %@", arg3, arg4, arg2);
    return NO;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 removingItemAtURL:(id)arg3 {
    NSLog(@"Error removing %@: %@", arg3, arg2);
    return NO;
}

- (void)replyToApplicationShouldTerminateTrampoline:(id)arg1 {
    [NSApp replyToApplicationShouldTerminate:[arg1 boolValue]];
}

- (NSUInteger)applicationShouldTerminate:(id)arg1 {
    if ([self->tasksInProgress count] > 0) {
        [[self shutdownController] showWindow:arg1];
        if (self->quitting) {
            return NSTerminateNow;
        } else {
            self->quitting = YES;
            BottleCollection *bc = (BottleCollection *)[[CXSetupLib bottleCollectionClass] sharedCollection];
            if (bc) {
                [[self shutdownController] shutdownAllBottles];
                return NSTerminateLater;
            }
            return NSTerminateCancel;
        }
    }
    return NSTerminateNow;
}

- (id)applicationIcon {
    NSImage *img = [[NSWorkspace sharedWorkspace] iconForFile:[[NSBundle mainBundle] bundlePath]];
    NSImage *cp = [img copy];
    return [cp autorelease];
}

- (id)startedAppGateOp {
    return [self startAppOp];
}

- (BOOL)application:(id)arg1 openFile:(id)arg2 {
    self->gotLaunchEvent = YES;
    NSAppleEventDescriptor *evt = [[NSAppleEventManager sharedAppleEventManager] currentAppleEvent];
    NSString *bottleName = [[evt descriptorForKeyword:0x42744e6d] stringValue]; // 'BtNm'

    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [self runClient:arg2 inBottle:bottleName];
    }];
    [op addDependency:[self startedAppGateOp]];
    [[NSOperationQueue mainQueue] addOperation:op];
    return YES;
}

- (BOOL)applicationOpenUntitledFile:(id)arg1 {
    self->gotLaunchEvent = YES;
    return YES;
}

- (BOOL)applicationShouldOpenUntitledFile:(id)arg1 {
    return YES;
}

- (BOOL)applicationShouldHandleReopen:(id)arg1 hasVisibleWindows:(BOOL)arg2 {
    if (!arg2) {
        [self applicationOpenUntitledFile:arg1];
    }
    return YES;
}

- (void)openDocument:(id)arg1 {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowedFileTypes:@[@"exe", @"msi", @"bat", @"cmd", @"c4p", @"tie"]];
    if ([panel runModal] == NSModalResponseOK) {
        NSString *path = [[panel URL] path];
        [self runClient:path inBottle:nil];
    }
}

- (void)addToRecentItems:(id)arg1 bottle:(id)arg2 {
    if (!arg1) return;

    NSData *bm = [[NSFileManager defaultManager] bookmarkDataFromPath:arg1];
    if (!bm) return;

    NSMutableDictionary *item = [NSMutableDictionary dictionaryWithObject:bm forKey:@"bookmark"];
    if (arg2) {
        [item setObject:arg2 forKey:@"bottle"];
    }

    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recent = [[defs arrayForKey:@"RecentItems"] mutableCopy] ?: [[NSMutableArray alloc] init];

    // Remove duplicates
    for (NSInteger i = [recent count] - 1; i >= 0; i--) {
        NSDictionary *d = [recent objectAtIndex:i];
        NSString *p = [[NSFileManager defaultManager] pathFromBookmarkData:[d objectForKey:@"bookmark"] stale:NULL];
        if ([p isEqualToString:arg1]) {
            [recent removeObjectAtIndex:i];
        }
    }

    [recent insertObject:item atIndex:0];
    NSInteger maxCount = [defs integerForKey:@"RecentItemsCount"] ?: 10;
    while ([recent count] > maxCount) {
        [recent removeLastObject];
    }

    [defs setObject:recent forKey:@"RecentItems"];
    [recent release];
    [self updateRecentItemsMenu];
}

- (id)makeBottleTaggedName:(id)arg1 withBottleName:(id)arg2 {
    if (arg2 && [arg2 length] > 0) {
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"%1$@ (%2$@)" value:@"" table:nil];
        return [NSString stringWithFormat:fmt, arg1, arg2];
    }
    return arg1;
}

- (void)updateRecentItemsMenu {
    if (!self->openRecent) return;

    [self->openRecent removeAllItems];
    NSArray *recents = [[NSUserDefaults standardUserDefaults] arrayForKey:@"RecentItems"];
    NSInteger maxCount = [[NSUserDefaults standardUserDefaults] integerForKey:@"RecentItemsCount"] ?: 10;

    for (NSDictionary *d in recents) {
        NSData *bm = [d objectForKey:@"bookmark"];
        BOOL isStale = NO;
        NSString *path = [[NSFileManager defaultManager] pathFromBookmarkData:bm stale:&isStale];
        if (path) {
            NSString *disp = [[NSFileManager defaultManager] displayNameAtPath:path];
            NSString *bName = [d objectForKey:@"bottle"];
            NSString *title = [self makeBottleTaggedName:disp withBottleName:bName];
            NSMenuItem *mi = [[NSMenuItem alloc] initWithTitle:title action:@selector(openRecent:) keyEquivalent:@""];
            [mi setTarget:self];
            [mi setRepresentedObject:d];
            [self->openRecent addItem:mi];
            [mi release];
            if ([self->openRecent numberOfItems] >= maxCount) break;
        }
    }

    if ([self->openRecent numberOfItems] > 0) {
        [self->openRecent addItem:[NSMenuItem separatorItem]];
        NSString *clearTitle = [[NSBundle mainBundle] localizedStringForKey:@"Clear Menu" value:@"" table:nil];
        NSMenuItem *clearItem = [[NSMenuItem alloc] initWithTitle:clearTitle action:@selector(clearRecent:) keyEquivalent:@""];
        [clearItem setTarget:self];
        [self->openRecent addItem:clearItem];
        [clearItem release];
    }
}

- (void)openRecent:(id)arg1 {
    NSDictionary *d = [arg1 representedObject];
    NSData *bm = [d objectForKey:@"bookmark"];
    BOOL isStale = NO;
    NSString *path = [[NSFileManager defaultManager] pathFromBookmarkData:bm stale:&isStale];
    if (path) {
        [self runClient:path inBottle:[d objectForKey:@"bottle"]];
    }
}

- (void)clearRecent:(id)arg1 {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RecentItems"];
    [self updateRecentItemsMenu];
}

- (void)processFirstRun:(BOOL)arg1 {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:@"26.3.0.39832" forKey:@"FirstRunVersion"];
}

- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2 {
    self->gotLaunchEvent = YES;
    NSAppleEventDescriptor *param = [arg1 paramDescriptorForKeyword:0x2d2d2d2d]; // '----'
    NSString *urlStr = [param stringValue];
    NSAppleEventDescriptor *prdt = [arg1 paramDescriptorForKeyword:0x70726474]; // 'prdt'
    NSString *bottleName = [[prdt descriptorForKeyword:0x42744e6d] stringValue]; // 'BtNm'

    if ([urlStr length] > 0) {
        NSURL *url = [NSURL URLWithString:urlStr];
        if (url && [[url scheme] caseInsensitiveCompare:@"com.codeweavers.private-CrossOver-app-scheme"] != NSOrderedSame) {
            NSString *bottleArg = bottleName ? [NSString stringWithFormat:@"--bottle %@", [bottleName stringQuotedForBash]] : @"--bottle default";
            NSString *cxRoot = [[CXApplication sharedApplication] crossOverRoot];
            NSString *cxStart = [[cxRoot stringByAppendingPathComponent:@"bin"] stringByAppendingPathComponent:@"cxstart"];
            NSString *cmd = [NSString stringWithFormat:@"%@ %@ --wait-children --enable-alt-loader macdrv -- %@",
                             [cxStart stringQuotedForBash], bottleArg, [urlStr stringQuotedForBash]];

            NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
                [self forkExecCommand:cmd];
            }];
            [op addDependency:[self startedAppGateOp]];
            [[NSOperationQueue mainQueue] addOperation:op];
            return YES;
        }
    }
    return NO;
}

@end
