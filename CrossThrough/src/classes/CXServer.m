// CXServer.m — CrossThrough
// Ported from CrossOver 26.3 arm64 (0x100012780..0x100016c80).
// The NSApplication delegate base class: launch sequencing, environment for
// the Wine tools, launching processes with Dock feedback, and recent items.
#import "CXServer.h"
#import "CrossThrough.h"
#import "c_functions.h"

@implementation CXServer

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
        pendingAppLaunches = [[NSMutableArray alloc] initWithCapacity:3];
        tasksInProgress = [[NSMutableDictionary alloc] initWithCapacity:3];
        [helperServer defaultHelperServer];
        backgroundQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (void)dealloc {
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (systemDynamicStore != NULL) {
        CFRunLoopSourceRef source = SCDynamicStoreCreateRunLoopSource(NULL, systemDynamicStore, 0);
        CFRunLoopSourceInvalidate(source);
        CFRelease(source);
        CFRelease(systemDynamicStore);
    }
}

- (id)demoRegisterController {
    if (demoRegisterController == nil) {
        demoRegisterController = [[DemoRegisterController alloc] init];
    }
    return demoRegisterController;
}

- (id)shutdownController {
    if (shutdownController == nil) {
        shutdownController = [[ShutdownController alloc] init];
    }
    return shutdownController;
}

- (void)doPeriodicDemoNagForCommand:(id)arg1 withArgs:(id)arg2 {
    [self setMenusEnabled:NO];
    DemoNagController *nag = [[DemoNagController alloc] init];
    [nag beginWindowWithCompletionHandler:^{
        [self setMenusEnabled:YES];
        [self forkExecCommand:arg1 withArgs:arg2];
    }];
}

- (void)demoCheck {
    if ([(CXApplication *)NSApp isDemo]) {
        DemoNagController *nag = [[DemoNagController alloc] init];
        [nag beginWindowWithCompletionHandler:^{
            [self continueFromDemoCheck];
        }];
    } else {
        [self continueFromDemoCheck];
    }
}

- (void)registerDemo:(id)arg1 {
    [[self demoRegisterController] showWindow:arg1];
}

- (BOOL)menusEnabled {
    return menusEnabled;
}

- (void)setMenusEnabled:(BOOL)arg1 {
    menusEnabled = arg1;
}

- (void)continueFromDemoCheck {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[helperServer defaultHelperServer] setIsReady];
        [[self startAppOp] start];
    });
    [self updateRecentItemsMenu];
    [self setMenusEnabled:YES];
}

// Operations that must wait until launch has finished depend on this one.
- (id)startAppOp {
    @synchronized (self) {
        if (startAppOp == nil) {
            startAppOp = [[NSOperation alloc] init];
        }
    }
    return startAppOp;
}

- (void)rosettaCheck {
#if defined(__arm64__)
    if (@available(macOS 11.0, *)) {
        cpu_type_t x86 = CPU_TYPE_X86_64;
        BOOL loadable = CFBundleIsArchitectureLoadable(x86);
        _CXLog(@"Rosetta is %s", loadable ? "installed" : "not installed");
        if (!loadable) {
            RosettaInstallationController *controller = [[RosettaInstallationController alloc] init];
            [NSApp runModalForWindow:[controller window]];
        }
    }
#endif
}

- (void)applicationWillFinishLaunching:(id)arg1 {
    [self rosettaCheck];
    _PFMoveToApplicationsFolderIfNecessary();
    NSAppleEventManager *manager = [NSAppleEventManager sharedAppleEventManager];
    [manager setEventHandler:self
                 andSelector:@selector(handleGetURLEvent:withReplyEvent:)
               forEventClass:kInternetEventClass
                  andEventID:kAEGetURL];
    [(CXApplication *)[CXApplication sharedApplication] setDaysLeft];
    [(CXApplication *)[CXApplication sharedApplication] setIsDemo];
}

- (void)applicationDidFinishLaunching:(id)arg1 {
    if (!gotLaunchEvent) {
        [self applicationOpenUntitledFile:[arg1 object]];
    }
    [self setMenusEnabled:NO];
    NSString *firstRunVersion = [[NSUserDefaults standardUserDefaults] stringForKey:@"FirstRunVersion"];
    if ([firstRunVersion caseInsensitiveCompare:@"26.3.0.39832"] != NSOrderedSame) {
        // The original also evaluates [firstRunVersion length] here and drops
        // the result; processFirstRun: is always told this is an upgrade.
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
    if (@available(macOS 14.0, *)) {
        [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                            selector:@selector(otherWineAppWillActivate:)
                                                                name:@"WineAppWillActivateNotification"
                                                              object:nil
                                                  suspensionBehavior:NSNotificationSuspensionBehaviorDeliverImmediately];
    }
}

- (void)otherWineAppWillActivate:(id)arg1 {
    if (![NSApp isActive]) {
        return;
    }
    pid_t pid = [[[arg1 userInfo] objectForKeyedSubscript:@"ActivatingAppPID"] intValue];
    NSRunningApplication *app = [NSRunningApplication runningApplicationWithProcessIdentifier:pid];
    if (app != nil) {
        if (@available(macOS 14.0, *)) {
            NSLog(@"yielding activation to %@", app);
            [NSApp yieldActivationToApplication:app];
            [app activateFromApplication:[NSRunningApplication currentApplication] options:0];
        }
    }
}

- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1 {
    return nil;
}

- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3 {
}

- (void)finishedLaunches {
}

- (void)updateLaunchNotify {
    NSImage *icon = [self applicationIcon];
    NSSize size = [icon size];
    if ([pendingAppLaunches count] == 0) {
        [launchFeedbackTimer setFireDate:[NSDate distantFuture]];
        [self finishedLaunches];
        return;
    }
    NSImage *badged = [[NSImage alloc] initWithSize:size];
    [badged lockFocus];
    [icon drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0, size.width, size.height) operation:NSCompositingOperationCopy fraction:1.0];
    id info = [self launchFeedbackDrawInfoForImageSize:size];
    NSMutableIndexSet *finished = [NSMutableIndexSet indexSet];
    NSInteger position = 0;
    for (NSUInteger i = 0; i < [pendingAppLaunches count]; i++) {
        LaunchFeedbackInfo *launch = [pendingAppLaunches objectAtIndex:i];
        int counter = [launch lifeCounter];
        // 800 ticks of 0.05s: give up after 40 seconds without a notification.
        if (![launch notified] && counter <= 800) {
            [self drawLaunchFeedback:launch position:position info:info];
            position++;
        } else {
            [finished addIndex:i];
        }
        [launch setLifeCounter:counter + 1];
    }
    [pendingAppLaunches removeObjectsAtIndexes:finished];
    [badged unlockFocus];
    [[NSApplication sharedApplication] setApplicationIconImage:badged];
}

- (id)startLaunchNotify:(id)arg1 {
    LaunchFeedbackInfo *info = [[LaunchFeedbackInfo alloc] initWithIcon:arg1];
    if (info != nil) {
        [pendingAppLaunches addObject:info];
        if (launchFeedbackTimer == nil) {
            launchFeedbackTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateLaunchNotify) userInfo:nil repeats:YES];
        }
        [launchFeedbackTimer setFireDate:[NSDate date]];
    }
    return info;
}

- (void)noteTask:(id)arg1 forCommand:(id)arg2 args:(id)arg3 {
}

- (void)modifyEnvironmentForCommandTask:(id)arg1 {
}

- (void)forkExecCommand:(id)arg1 {
    [self forkExecCommand:arg1 withArgs:[NSDictionary dictionary]];
}

// Runs a shell command line through /bin/sh -c. Recognized args: "icon"
// (Dock launch feedback), "workdir", and anything else is kept with the task
// record ("doc" names the document in error messages).
- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2 {
    NSImage *icon = [arg2 objectForKey:@"icon"];
    NSString *workdir = [arg2 objectForKey:@"workdir"];
    if (workdir == nil) {
        workdir = NSHomeDirectory();
    }
    LaunchFeedbackInfo *feedback = icon ? [self startLaunchNotify:icon] : nil;

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    CXTask *task = (CXTask *)[[CXTask alloc] init];
    NSTask *taskView = (NSTask *)task;
    [taskView setLaunchPath:@"/bin/sh"];
    [task setArguments:[NSArray arrayWithObjects:@"-c", arg1, nil]];
    [taskView setCurrentDirectoryPath:workdir];
    [taskView setStandardInput:[NSFileHandle fileHandleWithNullDevice]];
    [taskView setStandardOutput:[NSFileHandle fileHandleWithNullDevice]];
    NSPipe *errorPipe = [NSPipe pipe];
    int fd = [[errorPipe fileHandleForReading] fileDescriptor];
    fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK);
    [taskView setStandardError:errorPipe];

    NSMutableDictionary *environment = [[helperServer defaultHelperServer] getEnvironmentForXConnection];
    if (feedback != nil) {
        [environment setObject:[feedback socketPath] forKey:@"CX_LAUNCH_NOTIFY_SOCKET"];
    }
    [self modifyEnvironmentForCommandTask:environment];
    [taskView setEnvironment:environment];

    [center addObserver:self selector:@selector(observeTaskTermination:) name:NSTaskDidTerminateNotification object:task];
    [taskView launch];
    [self noteTask:task forCommand:arg1 args:arg2];

    NSFileHandle *errorHandle = [errorPipe fileHandleForReading];
    [center addObserver:self selector:@selector(observeTaskErrorOutput:) name:NSFileHandleReadToEndOfFileCompletionNotification object:errorHandle];
    [errorHandle readToEndOfFileInBackgroundAndNotify];

    NSMutableDictionary *record = [NSMutableDictionary dictionaryWithObject:task forKey:@"task"];
    [record addEntriesFromDictionary:arg2];
    if (feedback != nil) {
        [record setObject:feedback forKey:@"launchFeedbackInfo"];
    }
    [tasksInProgress setObject:record forKey:[NSValue valueWithNonretainedObject:task]];
    [tasksInProgress setObject:record forKey:[NSValue valueWithNonretainedObject:errorHandle]];
}

- (void)observeTaskTermination:(id)arg1 {
    id task = [arg1 object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:task];
    [tasksInProgress removeObjectForKey:[NSValue valueWithNonretainedObject:task]];
}

- (void)observeTaskErrorOutput:(id)arg1 {
    id handle = [arg1 object];
    NSValue *key = [NSValue valueWithNonretainedObject:handle];
    NSDictionary *record = [tasksInProgress objectForKey:key];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:handle];
    NSData *data = [[arg1 userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([output length] != 0) {
        NSLog(@"Task error output: %@\n", output);
    }

    NSString *message = nil;
    NSString *information = nil;
    NSBundle *bundle = [NSBundle mainBundle];
    if ([output rangeOfString:@"(error 31)"].location != NSNotFound) {
        if ([record objectForKey:@"doc"] != nil) {
            message = [NSString stringWithFormat:[bundle localizedStringForKey:@"%1$@ was unable to open %2$@." value:@"" table:nil], @"CrossOver", [record objectForKey:@"doc"]];
        } else {
            message = [NSString stringWithFormat:[bundle localizedStringForKey:@"%@ was unable to open this document." value:@"" table:nil], @"CrossOver"];
        }
        information = [bundle localizedStringForKey:@"Possible reasons for this error are:\n\n• The application associated with this document has been deleted\n• The application associated with this document is not in the default bottle\n" value:@"" table:nil];
    } else if ([output rangeOfString:@"No such file or directory"].location != NSNotFound) {
        if ([record objectForKey:@"doc"] != nil) {
            message = [NSString stringWithFormat:[bundle localizedStringForKey:@"%1$@ was unable to start %2$@." value:@"" table:nil], @"CrossOver", [record objectForKey:@"doc"]];
        } else {
            message = [NSString stringWithFormat:[bundle localizedStringForKey:@"%@ was unable to start this application." value:@"" table:nil], @"CrossOver"];
        }
        information = [bundle localizedStringForKey:@"Probably it has been uninstalled or its bottle has been deleted.\n" value:@"" table:nil];
    }
    if (message != nil) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:message];
        [alert setInformativeText:information];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"OK" value:@"" table:nil]];
        if ([record objectForKey:@"icon"] != nil) {
            [alert setIcon:[record objectForKey:@"icon"]];
        }
        [alert runModal];
    }

    LaunchFeedbackInfo *feedback = [record objectForKey:@"launchFeedbackInfo"];
    if (feedback != nil) {
        [feedback setLifeCounter:0x7fffffff];
    }
    [tasksInProgress removeObjectForKey:key];
}

- (void)runClient:(id)arg1 inBottle:(id)arg2 {
    NSString *bottleArg = arg2 ? [NSString stringWithFormat:@"--bottle %@", [arg2 stringQuotedForBash]] : @"--bottle default";
    NSString *cxstart = [[[(CXApplication *)NSApp crossOverRoot] stringByAppendingPathComponent:@"bin"] stringByAppendingPathComponent:@"cxstart"];
    NSString *command = [NSString stringWithFormat:@"%@ %@ --wait-children --enable-alt-loader macdrv --untrusted %@",
                         [cxstart stringQuotedForBash], bottleArg, [arg1 stringQuotedForBash]];
    NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:arg1];
    NSDictionary *args = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:icon, nil]
                                                     forKeys:[NSArray arrayWithObjects:@"icon", nil]];
    [self forkExecCommand:command withArgs:args];
    [self addToRecentItems:arg1 bottle:arg2];
}

- (void)showLicense:(id)arg1 {
    [[NSWorkspace sharedWorkspace] openFile:[[(CXApplication *)NSApp crossOverRoot] stringByAppendingPathComponent:@"license.txt"]];
}

+ (id)getCellarID {
    return @"CrossOver";
}

+ (id)getAppSupportDir {
    NSString *base = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [base stringByAppendingPathComponent:[self getCellarID]];
}

+ (id)getCachesDir {
    NSString *base = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [base stringByAppendingPathComponent:@"com.codeweavers.CrossOver"];
}

+ (id)getDefaultBottleDir {
    return [[CXServer getAppSupportDir] stringByAppendingPathComponent:@"Bottles"];
}

+ (id)getBottleDir {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"BottleDir"];
}

- (void)setEnvValue:(id)arg1 forKey:(id)arg2 {
    [[CXSetupLib cxSetupClass] setEnvValue:arg1 forKey:arg2];
}

- (void)unsetEnvValueForKey:(id)arg1 {
    [[CXSetupLib cxSetupClass] unsetEnvValueForKey:arg1];
}

- (void)setHttpProxyEnvironmentVariableFromSystemConfiguration {
    NSDictionary *proxies = (__bridge_transfer NSDictionary *)SCDynamicStoreCopyProxies(systemDynamicStore);
    NSString *proxy = nil;
    if ([[proxies objectForKey:(__bridge NSString *)kSCPropNetProxiesHTTPEnable] boolValue]) {
        NSString *host = [proxies objectForKey:(__bridge NSString *)kSCPropNetProxiesHTTPProxy];
        NSNumber *port = [proxies objectForKey:(__bridge NSString *)kSCPropNetProxiesHTTPPort];
        if ([host length] != 0) {
            proxy = [NSString stringWithFormat:@"http://%@:%@/", host, port];
        }
    }
    if (proxy != nil) {
        [self setEnvValue:proxy forKey:@"http_proxy"];
    } else {
        [self unsetEnvValueForKey:@"http_proxy"];
    }
}

- (void)beginMonitoringSystemConfigurationProxy {
    SCDynamicStoreContext context = { 0, (__bridge void *)self, NULL, NULL, NULL };
    systemDynamicStore = SCDynamicStoreCreate(NULL, CFSTR("CrossOver"), (SCDynamicStoreCallBack)_observeProxyChange, &context);
    CFStringRef proxiesKey = SCDynamicStoreKeyCreateProxies(NULL);
    NSArray *keys = [NSArray arrayWithObject:(__bridge id)proxiesKey];
    SCDynamicStoreSetNotificationKeys(systemDynamicStore, (__bridge CFArrayRef)keys, NULL);
    CFRunLoopSourceRef source = SCDynamicStoreCreateRunLoopSource(NULL, systemDynamicStore, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
    CFRelease(source);
    [self setHttpProxyEnvironmentVariableFromSystemConfiguration];
    CFRelease(proxiesKey);
}

- (id)managedBottlePath {
    NSString *path = [[[NSProcessInfo processInfo] environment] objectForKey:@"CX_MANAGED_BOTTLE_PATH"];
    if (path != nil) {
        return path;
    }
    id dirs = [[NSUserDefaults standardUserDefaults] objectForKey:@"ManagedBottleDirs"];
    if ([dirs isKindOfClass:[NSArray class]]) {
        dirs = [dirs componentsJoinedByString:@":"];
    }
    if ([dirs isKindOfClass:[NSString class]] && [dirs length] != 0) {
        return dirs;
    }
    return nil;
}

- (void)setEnvironmentVariables {
    NSString *home = [[[NSProcessInfo processInfo] environment] objectForKey:@"HOME"];
    BOOL isDirectory = NO;
    if ([home length] == 0 || ![[NSFileManager defaultManager] fileExistsAtPath:home isDirectory:&isDirectory] || !isDirectory) {
        home = NSHomeDirectory();
        _CXLog(@"Setting HOME to %@", home);
        [self setEnvValue:home forKey:@"HOME"];
    }
    [self setEnvValue:[[CXServer getBottleDir] stringInFileSystemRepresentationForm] forKey:@"CX_BOTTLE_PATH"];
    NSString *managed = [self managedBottlePath];
    if (managed != nil) {
        [self setEnvValue:managed forKey:@"CX_MANAGED_BOTTLE_PATH"];
    }
    [self beginMonitoringSystemConfigurationProxy];
    [self setEnvValue:[[NSBundle mainBundle] bundlePath] forKey:@"CX_APP_BUNDLE_PATH"];
}

- (BOOL)validateMenuItem:(id)arg1 {
    NSString *title = [[arg1 menu] title];
    if ([self menusEnabled]) {
        return YES;
    }
    return [title compare:@"Help"] == NSOrderedSame;
}

- (void)runCommand:(id)arg1 {
    if ([NSApp respondsToSelector:@selector(activate)]) {
        if (@available(macOS 14.0, *)) {
            [NSApp activate];
        }
    } else {
        [NSApp activateIgnoringOtherApps:YES];
    }
    RunCommandController *controller = [[RunCommandController alloc] init];
    [controller showWindow:self];
}

+ (id)fileTypesForBottle:(id)arg1 {
    NSMutableArray *types = [NSMutableArray arrayWithCapacity:4];
    NSString *plistPath = [NSString stringWithFormat:@"%@/desktopdata/cxassoc/cxassoc_macosx.plist", [arg1 winePrefix]];
    if ([[NSFileManager defaultManager] attributesOfItemAtPath:[plistPath stringByResolvingSymlink] error:nil] == nil) {
        return types;
    }
    NSData *data = [NSData dataWithContentsOfFile:plistPath];
    if (data == nil) {
        return types;
    }
    NSError *error = nil;
    id plist = [NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:&error];
    if (plist == nil) {
        NSLog(@"Failed to parse cxassoc plist %@: %@\n", plistPath, error);
        return types;
    }
    if (![plist isKindOfClass:[NSDictionary class]]) {
        return types;
    }
    for (id key in plist) {
        NSDictionary *entry = [plist objectForKey:key];
        NSString *description = [entry objectForKey:@"Description"];
        NSDictionary *associations = [entry objectForKey:@"Extension Associations/"];
        if ([description caseInsensitiveCompare:[arg1 name]] != NSOrderedSame) {
            continue;
        }
        for (NSString *association in associations) {
            NSArray *parts = [association componentsSeparatedByString:@"/"];
            NSString *extension = [[associations objectForKey:association] objectForKey:@"Extension"];
            if (extension == nil) {
                // ".ext/..." -> "ext"
                extension = [[parts objectAtIndex:0] substringFromIndex:1];
            }
            [types addObject:extension];
        }
    }
    return types;
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
    @try {
        [[NSApplication sharedApplication] replyToApplicationShouldTerminate:[arg1 boolValue]];
        [[self shutdownController] close];
        shutdownController = nil;
    } @finally {
        quitting = NO;
    }
}

- (NSUInteger)applicationShouldTerminate:(id)arg1 {
    id<WineApplicationController> wine = [(CXApplication *)NSApp wineController];
    if ([wine respondsToSelector:@selector(applicationShouldTerminate:)]) {
        return [wine applicationShouldTerminate:arg1];
    }
    [[self shutdownController] showWindow:arg1];
    if (quitting) {
        return NSTerminateLater;
    }
    quitting = YES;
    if ([[CXSetupLib bottleCollectionClass] sharedCollection] != nil) {
        [[self shutdownController] shutdownAllBottles];
        return NSTerminateLater;
    }
    return NSTerminateNow;
}

- (id)applicationIcon {
    NSImage *icon = [[[NSWorkspace sharedWorkspace] iconForFile:[[NSBundle mainBundle] bundlePath]] copy];
    [icon setSize:NSMakeSize(128.0, 128.0)];
    return icon;
}

- (id)startedAppGateOp {
    return [self startAppOp];
}

- (BOOL)application:(id)arg1 openFile:(id)arg2 {
    gotLaunchEvent = YES;
    NSAppleEventDescriptor *event = [[NSAppleEventManager sharedAppleEventManager] currentAppleEvent];
    // 'prdt' / 'BtNm': the bottle a helper app asked us to open the file in.
    NSAppleEventDescriptor *properties = [event paramDescriptorForKeyword:'prdt'];
    NSString *bottle = [[properties descriptorForKeyword:'BtNm'] stringValue];
    NSBlockOperation *open = [NSBlockOperation blockOperationWithBlock:^{
        [self runClient:arg2 inBottle:bottle];
    }];
    [open addDependency:[self startedAppGateOp]];
    [[NSOperationQueue mainQueue] addOperation:open];
    return YES;
}

- (BOOL)applicationOpenUntitledFile:(id)arg1 {
    gotLaunchEvent = YES;
    return YES;
}

- (BOOL)applicationShouldOpenUntitledFile:(id)arg1 {
    return YES;
}

- (BOOL)applicationShouldHandleReopen:(id)arg1 hasVisibleWindows:(BOOL)arg2 {
    id<WineApplicationController> wine = [(CXApplication *)NSApp wineController];
    if ([wine respondsToSelector:@selector(applicationShouldHandleReopen:hasVisibleWindows:)]) {
        return [wine applicationShouldHandleReopen:arg1 hasVisibleWindows:arg2];
    }
    return YES;
}

- (void)openDocument:(id)arg1 {
    SelectBottleController *selector = [[SelectBottleController alloc] init];
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:YES];
    NSBundle *bundle = [NSBundle mainBundle];
    [panel setMessage:[bundle localizedStringForKey:@"If possible, the selected document will be opened in the appropriate Windows application.\nAvailable file types may vary depending on which bottle is selected below." value:@"" table:nil]];
    [panel setPrompt:[bundle localizedStringForKey:@"Open" value:@"" table:nil]];
    [panel setTitle:[bundle localizedStringForKey:@"Open" value:@"" table:nil]];
    [panel setCanCreateDirectories:NO];
    [panel setAccessoryView:[selector view]];
    [panel setDelegate:(id<NSOpenSavePanelDelegate>)selector];
    [panel beginWithCompletionHandler:^(NSModalResponse result) {
        if (result != NSModalResponseOK) {
            return;
        }
        NSString *bottleName = [[selector selectedBottle] name];
        for (NSURL *url in [panel URLs]) {
            [self runClient:[[url path] stringInFileSystemRepresentationForm] inBottle:bottleName];
        }
    }];
}

- (void)addToRecentItems:(id)arg1 bottle:(id)arg2 {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory;
    if (![fileManager fileExistsAtPath:arg1 isDirectory:&isDirectory] || isDirectory) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recent = [[defaults arrayForKey:@"RecentItems"] mutableCopy];
    NSInteger maxCount = [defaults integerForKey:@"RecentItemsCount"];
    NSData *bookmark = [fileManager bookmarkDataFromPath:arg1];
    if (bookmark == nil) {
        return;
    }
    NSUInteger existing = [recent indexOfObjectPassingTest:^BOOL(id item, NSUInteger idx, BOOL *stop) {
        NSString *itemBottle = [item objectForKey:@"bottle"];
        if ((itemBottle == nil) != (arg2 == nil)) {
            return NO;
        }
        if (itemBottle != nil && ![itemBottle isEqualToString:arg2]) {
            return NO;
        }
        NSString *path = [fileManager pathFromBookmarkData:[item objectForKey:@"bookmark"] stale:NULL];
        return [fileManager isSameFile:path asFile:arg1];
    }];
    if (existing != NSNotFound) {
        [recent removeObjectAtIndex:existing];
    }
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    [item setObject:bookmark forKey:@"bookmark"];
    if (arg2 != nil) {
        [item setObject:arg2 forKey:@"bottle"];
    }
    [recent insertObject:item atIndex:0];
    if ((NSInteger)[recent count] >= maxCount) {
        [recent removeObjectsInRange:NSMakeRange(maxCount, [recent count] - maxCount)];
    }
    [defaults setObject:recent forKey:@"RecentItems"];
    [self updateRecentItemsMenu];
}

- (id)makeBottleTaggedName:(id)arg1 withBottleName:(id)arg2 {
    if (arg2 == nil) {
        return arg1;
    }
    NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"%1$@ (%2$@)" value:@"" table:nil];
    return [NSString stringWithFormat:format, arg1, arg2];
}

- (void)updateRecentItemsMenu {
    [openRecent removeAllItems];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *items = [defaults arrayForKey:@"RecentItems"];
    NSInteger maxCount = [defaults integerForKey:@"RecentItemsCount"];
    NSMutableArray *kept = [NSMutableArray arrayWithCapacity:[items count]];
    NSMutableIndexSet *missing = [NSMutableIndexSet indexSet];

    for (NSDictionary *item in items) {
        NSDictionary *entry = item;
        BOOL stale = NO;
        NSString *path = [fileManager pathFromBookmarkData:[entry objectForKey:@"bookmark"] stale:&stale];
        if (path != nil && stale) {
            NSData *refreshed = [fileManager bookmarkDataFromPath:path];
            if (refreshed != nil) {
                NSMutableDictionary *updated = [entry mutableCopy];
                [updated setObject:refreshed forKey:@"bookmark"];
                entry = updated;
            }
        }
        [kept addObject:entry];
        if (path == nil) {
            // Unresolvable items are dropped first when trimming below.
            [missing addIndex:[kept count] - 1];
            continue;
        }
        NSString *title = [self makeBottleTaggedName:[fileManager displayNameAtPath:path] withBottleName:[entry objectForKey:@"bottle"]];
        NSMenuItem *menuItem = [[NSMenuItem alloc] initWithTitle:title action:@selector(openRecent:) keyEquivalent:@""];
        [menuItem setTarget:self];
        [menuItem setRepresentedObject:entry];
        [openRecent addItem:menuItem];
        if ([openRecent numberOfItems] >= maxCount) {
            break;
        }
    }

    while ((NSInteger)[kept count] >= maxCount && (NSInteger)[kept count] > 0) {
        if ([missing count] != 0) {
            NSUInteger last = [missing lastIndex];
            [kept removeObjectAtIndex:last];
            [missing removeIndex:last];
        } else {
            [kept removeObjectsInRange:NSMakeRange(maxCount, [kept count] - maxCount)];
        }
        if ((NSInteger)[kept count] <= maxCount) {
            break;
        }
    }
    [defaults setObject:kept forKey:@"RecentItems"];

    NSMenuItem *clear = [[NSMenuItem alloc] initWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Clear" value:@"" table:nil]
                                                   action:@selector(clearRecent:)
                                            keyEquivalent:@""];
    [clear setTarget:self];
    if ([openRecent numberOfItems] != 0) {
        [openRecent addItem:[NSMenuItem separatorItem]];
    } else {
        [clear setAction:NULL];
    }
    [openRecent addItem:clear];
}

- (void)openRecent:(id)arg1 {
    NSDictionary *item = [arg1 representedObject];
    NSString *path = [[NSFileManager defaultManager] pathFromBookmarkData:[item objectForKey:@"bookmark"] stale:NULL];
    if (path != nil) {
        [self runClient:path inBottle:[item objectForKey:@"bottle"]];
    } else {
        NSBeep();
        [self updateRecentItemsMenu];
    }
}

- (void)clearRecent:(id)arg1 {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RecentItems"];
    [self updateRecentItemsMenu];
}

- (void)processFirstRun:(BOOL)arg1 {
    [[NSUserDefaults standardUserDefaults] setObject:@"26.3.0.39832" forKey:@"FirstRunVersion"];
}

// Returns YES when the URL was not handled here, so subclasses can take it.
- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2 {
    gotLaunchEvent = YES;
    NSString *urlString = [[arg1 paramDescriptorForKeyword:keyDirectObject] stringValue];
    NSAppleEventDescriptor *properties = [arg1 paramDescriptorForKeyword:'prdt'];
    NSString *bottle = [[properties descriptorForKeyword:'BtNm'] stringValue];
    if ([urlString length] == 0) {
        return NO;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    if ([[url scheme] caseInsensitiveCompare:@"com.codeweavers.private-CrossOver-app-scheme"] == NSOrderedSame) {
        return YES;
    }
    NSString *bottleArg = bottle ? [NSString stringWithFormat:@"--bottle %@", [bottle stringQuotedForBash]] : @"--bottle default";
    NSString *cxstart = [[[(CXApplication *)NSApp crossOverRoot] stringByAppendingPathComponent:@"bin"] stringByAppendingPathComponent:@"cxstart"];
    NSString *command = [NSString stringWithFormat:@"%@ %@ --wait-children --enable-alt-loader macdrv -- %@",
                         [cxstart stringQuotedForBash], bottleArg, [urlString stringQuotedForBash]];
    NSBlockOperation *launch = [NSBlockOperation blockOperationWithBlock:^{
        [self forkExecCommand:command];
    }];
    [launch addDependency:[self startedAppGateOp]];
    [[NSOperationQueue mainQueue] addOperation:launch];
    return NO;
}

@end
