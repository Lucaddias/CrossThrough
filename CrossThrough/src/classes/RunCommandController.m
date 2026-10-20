// RunCommandController.m — CrossThrough
#import "RunCommandController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "NSString+CrossOverAdditions.h"
#import <fcntl.h>

@implementation RunCommandController

+ (BOOL)automaticallyNotifiesObserversOfSelectedBottle {
    return NO;
}

+ (BOOL)automaticallyNotifiesObserversOfSelectedBottleIndexes {
    return NO;
}

+ (id)keyPathsForValuesAffectingCanRun {
    return [NSSet setWithObjects:@"launcher", @"command", nil];
}

- (id)init {
    self = [super initWithWindowNibName:@"RunCommand"];
    return self;
}

- (id)initWithFileToRun:(id)arg1 {
    self = [self init];
    if (self) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"canRunCommands != FALSE"];
        [self setCanRunFilterPredicate:pred];
        if (arg1) {
            [self setCommand:[NSString stringWithFormat:@"\"%@\"", arg1]];
        }
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self->task release];
    [self->stdOut release];
    [self->_selectedBottle release];
    [self->_selectedBottleIndexes release];
    [self->_launcher release];
    [self->_command release];
    [self->_canRunFilterPredicate release];
    [self->_launcherModeViewController release];
    [self->_loggingOptions release];
    [self->_envVars release];
    [self->_stdErr release];
    [super dealloc];
}

- (void)setSelectedBottle:(id)arg1 {
    if (self->_selectedBottle != arg1) {
        [self willChangeValueForKey:@"selectedBottle"];
        [self->_selectedBottle release];
        self->_selectedBottle = [arg1 retain];
        [self didChangeValueForKey:@"selectedBottle"];
        
        if (self->_selectedBottle) {
            NSArray *arranged = [[self bottleArray] arrangedObjects];
            NSUInteger idx = [arranged indexOfObjectIdenticalTo:self->_selectedBottle];
            if (idx == NSNotFound) {
                [self setSelectedBottleIndexes:nil];
            } else {
                [self setSelectedBottleIndexes:[NSIndexSet indexSetWithIndex:idx]];
            }
            if ([self loggingOptions] && [self->_selectedBottle respondsToSelector:@selector(name)]) {
                [[self loggingOptions] setLogFileName:[self->_selectedBottle name]];
            }
        } else {
            [self setSelectedBottleIndexes:nil];
        }
    }
}

- (void)setSelectedBottleIndexes:(id)arg1 {
    if (self->_selectedBottleIndexes != arg1 && (!self->_selectedBottleIndexes || ![self->_selectedBottleIndexes isEqualToIndexSet:arg1])) {
        [self willChangeValueForKey:@"selectedBottleIndexes"];
        [self->_selectedBottleIndexes release];
        self->_selectedBottleIndexes = arg1 ? [arg1 copy] : [[NSIndexSet alloc] init];
        [self didChangeValueForKey:@"selectedBottleIndexes"];
        
        NSUInteger idx = [self->_selectedBottleIndexes firstIndex];
        if (idx == NSNotFound) {
            [self setSelectedBottle:nil];
        } else {
            NSArray *arranged = [[self bottleArray] arrangedObjects];
            if (idx < [arranged count]) {
                [self setSelectedBottle:[arranged objectAtIndex:idx]];
            }
        }
    }
}

- (void)browseForCommand:(id)arg1 {
    CXApplication *app = (CXApplication *)[CXApplication sharedApplication];
    NSString *root = [app crossOverRoot];
    NSString *binDir = [root stringByAppendingPathComponent:@"bin"];
    NSString *initialDir = nil;
    
    NSArray *selected = [[self bottleArray] selectedObjects];
    if ([selected count] > 0) {
        id bottle = [selected objectAtIndex:0];
        if ([bottle respondsToSelector:@selector(systemDrive)]) {
            initialDir = [bottle systemDrive];
        }
    }
    if (!initialDir) {
        initialDir = binDir;
    }
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setMessage:[[NSBundle mainBundle] localizedStringForKey:@"Please choose a file to run." value:@"" table:nil]];
    if (initialDir) {
        [panel setDirectoryURL:[NSURL fileURLWithPath:initialDir]];
    }
    [panel beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            NSString *filePath = [[panel URL] path];
            if (filePath) {
                [self setCommand:[NSString stringWithFormat:@"\"%@\"", filePath]];
            }
        }
    }];
}

- (void)runCommandPressed:(id)arg1 {
    if ([self canRun]) {
        [self runCommand];
    }
}

- (void)runCommand {
    [self setCommandRunning:YES];
    [[self loggingOptions] sanitizeLogChannels];
    [[self loggingOptions] saveSettingsToRecent];
    
    id bottleObj = nil;
    NSString *bottleName = nil;
    if ([self launcher] && [[self launcher] bottle]) {
        bottleObj = [[self launcher] bottle];
        bottleName = [bottleObj name];
    } else {
        NSArray *selected = [[self bottleArray] selectedObjects];
        if ([selected count] > 0) {
            bottleObj = [selected objectAtIndex:0];
            bottleName = [bottleObj name];
        } else {
            bottleName = @"default";
        }
    }
    
    NSString *launchPath = nil;
    NSArray *args = nil;
    CXApplication *app = (CXApplication *)[CXApplication sharedApplication];
    NSString *binDir = [[app crossOverRoot] stringByAppendingPathComponent:@"bin"];
    
    if ([self launcher]) {
        NSURL *launcherURL = [[self launcher] url];
        CXBundle *bundle = [CXBundle bundleWithURL:launcherURL];
        NSString *menuPath = [bundle objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"];
        launchPath = [binDir stringByAppendingPathComponent:@"cxmenu"];
        args = [NSArray arrayWithObjects:@"--bottle", bottleName ?: @"default", @"--wait-children", @"--start", menuPath ?: @"", nil];
    } else {
        launchPath = [binDir stringByAppendingPathComponent:@"cxstart"];
        args = [NSArray arrayWithObjects:@"--bottle", bottleName ?: @"default", @"--new-console", nil];
    }
    
    NSString *effectiveEnvVars = [self envVars] ? [[self envVars] copy] : @"";
    NSFileHandle *logFileHandle = nil;
    
    if ([[self loggingOptions] createLogFile]) {
        NSString *logPath = [[[self loggingOptions] logFileURL] path];
        if ([logPath length] > 0) {
            args = [args arrayByAddingObject:@"--verbose"];
            args = [args arrayByAddingObject:@"--cx-log"];
            
            NSString *logEnv = [[self loggingOptions] logEnvironment];
            if ([logEnv length] > 0) {
                if ([effectiveEnvVars length] > 0) {
                    effectiveEnvVars = [NSString stringWithFormat:@"%@ %@", logEnv, effectiveEnvVars];
                } else {
                    effectiveEnvVars = [logEnv copy];
                }
            }
            
            int fd = open([logPath fileSystemRepresentation], O_WRONLY | O_CREAT | O_TRUNC, 0666);
            if (fd != -1) {
                logFileHandle = [[[NSFileHandle alloc] initWithFileDescriptor:fd closeOnDealloc:YES] autorelease];
                
                NSMutableString *banner = [NSMutableString string];
                if ([self launcher]) {
                    [banner appendFormat:@"Running launcher: %@ (%@)\nCommand-line options: %@\n",
                     [[self launcher] name],
                     [[[self launcher] url] path] ?: @"",
                     [self command] ?: @""];
                } else {
                    [banner appendFormat:@"Running command: %@\n", [self command] ?: @""];
                }
                [banner appendFormat:@"Bottle: %@\nDebug channels: %@\nExtra environment variables: %@\n\n",
                 bottleName ?: @"default",
                 [[self loggingOptions] logChannels] ?: @"",
                 effectiveEnvVars];
                
                [logFileHandle writeData:[banner dataUsingEncoding:NSUTF8StringEncoding]];
                
                NSString *sysInfo = nil;
                if (bottleObj) {
                    sysInfo = [[CXSetupLib systemInfoClass] systemInformationStringForBottle:bottleObj];
                } else {
                    sysInfo = [[CXSetupLib systemInfoClass] systemInformationString];
                }
                if (sysInfo) {
                    [logFileHandle writeData:[sysInfo dataUsingEncoding:NSUTF8StringEncoding]];
                }
                args = [args arrayByAddingObject:@"-"];
            } else {
                args = [args arrayByAddingObject:logPath];
            }
        }
        
        NSString *debugMsg = [[self loggingOptions] logChannels];
        if ([debugMsg length] > 0) {
            args = [args arrayByAddingObject:@"--debugmsg"];
            args = [args arrayByAddingObject:debugMsg];
        }
    }
    
    if ([effectiveEnvVars length] > 0) {
        args = [args arrayByAddingObject:@"--env"];
        args = [args arrayByAddingObject:effectiveEnvVars];
    }
    
    NSArray *cmdArgs = nil;
    if ([[self command] length] > 0) {
        cmdArgs = [[CXSetupLib cxUtilsClass] cmdLineToArgv:[self command]];
    } else {
        cmdArgs = [NSArray array];
    }
    
    if (![self launcher]) {
        NSString *firstArg = [cmdArgs count] > 0 ? [cmdArgs objectAtIndex:0] : @"";
        NSString *workdir = [[CXSetupLib cxUtilsClass] dirname:firstArg];
        if ([workdir length] > 0) {
            args = [args arrayByAddingObject:@"--workdir"];
            args = [args arrayByAddingObject:workdir];
        }
        args = [args arrayByAddingObject:@"--"];
    }
    
    args = [args arrayByAddingObjectsFromArray:cmdArgs];
    
    [self->task release];
    self->task = (NSTask *)[[CXTask alloc] init];
    [self->task setArguments:args];
    [self->task setLaunchPath:launchPath];
    
    NSPipe *outPipe = [NSPipe pipe];
    [self->task setStandardOutput:outPipe];
    
    if (logFileHandle) {
        [self->task setStandardError:logFileHandle];
        [self setStdErr:[NSData data]];
    } else {
        NSPipe *errPipe = [NSPipe pipe];
        [self->task setStandardError:errPipe];
        [self setStdErr:nil];
    }
    
    [self->stdOut release];
    self->stdOut = nil;
    self->taskComplete = NO;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(getStdout:)
               name:NSFileHandleReadToEndOfFileCompletionNotification
             object:[[self->task standardOutput] fileHandleForReading]];
    
    if (logFileHandle) {
        [nc addObserver:self
               selector:@selector(didTerminate:)
                   name:NSTaskDidTerminateNotification
                 object:self->task];
    } else {
        [nc addObserver:self
               selector:@selector(getStderr:)
                   name:NSFileHandleReadToEndOfFileCompletionNotification
                 object:[[self->task standardError] fileHandleForReading]];
        [nc addObserver:self
               selector:@selector(didTerminate:)
                   name:NSTaskDidTerminateNotification
                 object:self->task];
        
        int errFd = [[[self->task standardError] fileHandleForReading] fileDescriptor];
        int errFlags = fcntl(errFd, F_GETFL, 0);
        fcntl(errFd, F_SETFL, errFlags | O_NONBLOCK);
    }
    
    int outFd = [[[self->task standardOutput] fileHandleForReading] fileDescriptor];
    int outFlags = fcntl(outFd, F_GETFL, 0);
    fcntl(outFd, F_SETFL, outFlags | O_NONBLOCK);
    
    if (!logFileHandle) {
        [[[self->task standardError] fileHandleForReading] readToEndOfFileInBackgroundAndNotify];
    }
    [[[self->task standardOutput] fileHandleForReading] readToEndOfFileInBackgroundAndNotify];
    
    [self->task launch];
}

- (void)getStdout:(id)arg1 {
    NSNotification *notif = (NSNotification *)arg1;
    NSData *data = [[notif userInfo] objectForKey:NSFileHandleNotificationDataItem];
    [self->stdOut release];
    self->stdOut = [data copy];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[notif name] object:[notif object]];
    
    if (self->stdOut != nil && self->_stdErr != nil && self->taskComplete) {
        [self commandComplete];
    }
}

- (void)getStderr:(id)arg1 {
    NSNotification *notif = (NSNotification *)arg1;
    NSData *data = [[notif userInfo] objectForKey:NSFileHandleNotificationDataItem];
    [self setStdErr:data];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[notif name] object:[notif object]];
    
    if (self->stdOut != nil && self->_stdErr != nil && self->taskComplete) {
        [self commandComplete];
    }
}

- (void)didTerminate:(id)arg1 {
    NSNotification *notif = (NSNotification *)arg1;
    self->taskComplete = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[notif name] object:[notif object]];
    
    if (self->stdOut != nil && self->_stdErr != nil && self->taskComplete) {
        [self commandComplete];
    }
}

- (void)commandComplete {
    int termStatus = [self->task terminationStatus];
    if (termStatus != 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Command results" value:@"" table:nil]];
        
        NSString *info = nil;
        if ([self launcher]) {
            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"%1$@ returned status %2$d." value:@"" table:nil];
            info = [NSString stringWithFormat:fmt, [[self launcher] name], termStatus];
        } else {
            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"The command %@ returned %d." value:@"" table:nil];
            info = [NSString stringWithFormat:fmt, [self command] ?: @"", termStatus];
        }
        [alert setInformativeText:info];
        [alert addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"OK" value:@"" table:nil]];
        
        NSString *outStr = self->stdOut ? [[[NSString alloc] initWithData:self->stdOut encoding:NSUTF8StringEncoding] autorelease] : @"";
        NSString *errStr = self->_stdErr ? [[[NSString alloc] initWithData:self->_stdErr encoding:NSUTF8StringEncoding] autorelease] : @"";
        
        NSMutableString *fullOutput = [NSMutableString string];
        if ([outStr length] > 0) {
            [fullOutput appendString:[[NSBundle mainBundle] localizedStringForKey:@"Command output:" value:@"" table:nil]];
            [fullOutput appendString:@"\n"];
            [fullOutput appendString:outStr];
            if ([errStr length] > 0) {
                [fullOutput appendString:@"\n\n"];
            }
        }
        if ([errStr length] > 0) {
            [fullOutput appendString:[[NSBundle mainBundle] localizedStringForKey:@"Command error text:" value:@"" table:nil]];
            [fullOutput appendString:@"\n"];
            [fullOutput appendString:errStr];
        }
        
        if ([fullOutput length] > 0 && [self failAlertAccessoryView] && [self failAlertTextView]) {
            [alert setAccessoryView:[self failAlertAccessoryView]];
            NSTextContainer *tc = [[self failAlertTextView] textContainer];
            [tc setHeightTracksTextView:NO];
            [tc setWidthTracksTextView:NO];
            [tc setContainerSize:NSMakeSize(FLT_MAX, FLT_MAX)];
            [[self failAlertTextView] setString:fullOutput];
        }
        
        [alert beginSheetModalForWindow:[self window] completionHandler:nil];
        [alert release];
    }
    
    [self setCommandRunning:NO];
    [[self loggingOptions] updateLogFileURL];
}

- (void)setCommand:(id)arg1 {
    if (self->_command != arg1) {
        NSString *decomp = [arg1 decomposedStringWithCanonicalMapping];
        [self->_command release];
        self->_command = [decomp copy];
    }
}

- (void)setCommandRunning:(BOOL)arg1 {
    self->_commandRunning = arg1;
    [[self loggingOptions] setEnabled:!arg1];
}

- (id)bottleCollection {
    return [[CXSetupLib bottleCollectionClass] sharedCollection];
}

- (void)createIcon:(id)arg1 {
    NSArray *selected = [[self bottleArray] selectedObjects];
    if ([selected count] > 0) {
        id bottle = [selected objectAtIndex:0];
        NSString *desktopPath = [[CXSetupLib cxMenuClass] localDesktopPath];
        NSString *startMenuPath = [[CXSetupLib cxMenuClass] localStartMenuPath];
        NSArray *components = [[self command] componentsOfCommandLine];
        NSString *first = [components count] > 0 ? [components objectAtIndex:0] : @"";
        NSString *baseName = [[first lastUnixOrWindowsPathComponent] stringByDeletingPathExtension];
        if ([components count] >= 2) {
            for (NSUInteger i = 1; i < [components count]; i++) {
                NSString *c = [components objectAtIndex:i];
                NSString *lastComp = [c lastUnixOrWindowsPathComponent];
                if ([[lastComp pathExtension] length] > 0) {
                    baseName = [lastComp stringByDeletingPathExtension];
                    break;
                }
            }
        }
        [[CXSetupLib cxMenuClass] createShortcutForBottle:[bottle name]
                                                  command:[self command]
                                                     name:baseName
                                                   folder:startMenuPath
                                         localDesktopPath:desktopPath
                                         andStartMenuPath:startMenuPath];
        CXApplication *app = (CXApplication *)[CXApplication sharedApplication];
        if ([[app delegate] respondsToSelector:@selector(refreshPrograms:)]) {
            [[app delegate] refreshPrograms:nil];
        }
    } else {
        NSLog(@"We can't create an icon when there is no current bottle.\n");
    }
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"isDefault" ascending:NO];
    NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    [[self bottleArray] setSortDescriptors:[NSArray arrayWithObjects:sd1, sd2, nil]];
    [sd1 release];
    [sd2 release];
    
    NSString *logName = nil;
    if ([self launcher]) {
        logName = [[self launcher] name];
    } else {
        NSArray *selected = [[self bottleArray] selectedObjects];
        if ([selected count] > 0) {
            logName = [[selected objectAtIndex:0] name];
        } else {
            logName = @"log";
        }
    }
    
    LoggingOptionsViewController *loggingOptions = [[LoggingOptionsViewController alloc] initWithLogFileName:logName];
    [self setLoggingOptions:loggingOptions];
    [loggingOptions release];
    
    if ([self loggingViewContainer] && [[self loggingOptions] view]) {
        NSView *container = [self loggingViewContainer];
        NSView *lView = [[self loggingOptions] view];
        [container setSubviews:[NSArray arrayWithObject:lView]];
        NSDictionary *views = NSDictionaryOfVariableBindings(lView);
        [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lView]|" options:0 metrics:nil views:views]];
        [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lView]|" options:0 metrics:nil views:views]];
    }
    
    NSView *modeView = nil;
    if ([self launcher]) {
        RunCommandLauncherModeViewController *lmvc = [[RunCommandLauncherModeViewController alloc] init];
        [self setLauncherModeViewController:lmvc];
        [lmvc release];
        [[self launcherModeViewController] setRepresentedObject:self];
        modeView = [[self launcherModeViewController] view];
        NSString *titleFmt = [[NSBundle mainBundle] localizedStringForKey:@"Run '%@'" value:@"" table:nil];
        [[self window] setTitle:[NSString stringWithFormat:titleFmt, [[self launcher] name]]];
    } else {
        modeView = [self nonLauncherModeView];
        if ([self nonLauncherModeCommandTextField]) {
            [[self window] setInitialFirstResponder:[self nonLauncherModeCommandTextField]];
        }
    }
    
    if (modeView && [self modeSpecificViewContainer]) {
        NSView *container = [self modeSpecificViewContainer];
        [container addSubview:modeView];
        NSDictionary *views = [NSDictionary dictionaryWithObject:modeView forKey:@"viewToUse"];
        [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[viewToUse]|" options:0 metrics:nil views:views]];
        [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[viewToUse]|" options:0 metrics:nil views:views]];
    }
    
    [[self window] recalculateKeyViewLoop];
    [[[self window] standardWindowButton:NSWindowZoomButton] setEnabled:NO];
}

- (void)windowWillClose:(id)arg1 {
    NSNotification *notif = (NSNotification *)arg1;
    [[self launcherModeViewController] setRepresentedObject:nil];
    [super windowWillClose:notif];
}

- (BOOL)canRun {
    if ([self launcher] != nil) {
        return YES;
    }
    return [[self command] length] > 0;
}

- (BOOL)supportsAVX {
    if (@available(macOS 15.0, *)) {
        return YES;
    }
    return NO;
}

- (void)appendEnvVar:(id)arg1 {
    NSString *var = (NSString *)arg1;
    if ([[self envVars] length] > 0) {
        [self setEnvVars:[NSString stringWithFormat:@"%@ %@", [self envVars], var]];
    } else {
        [self setEnvVars:var];
    }
}

- (void)metalHudSelected:(id)arg1 {
    [self appendEnvVar:@"MTL_HUD_ENABLED=1"];
}

- (void)AVXSelected:(id)arg1 {
    [self appendEnvVar:@"ROSETTA_ADVERTISE_AVX=0"];
}

- (id)bottleArray {
    return self->_bottleArray;
}

- (void)setBottleArray:(id)arg1 {
    self->_bottleArray = arg1;
}

- (id)selectedBottle {
    return self->_selectedBottle;
}

- (id)selectedBottleIndexes {
    return self->_selectedBottleIndexes;
}

- (id)failAlertAccessoryView {
    return self->_failAlertAccessoryView;
}

- (void)setFailAlertAccessoryView:(id)arg1 {
    self->_failAlertAccessoryView = arg1;
}

- (id)failAlertTextView {
    return self->_failAlertTextView;
}

- (void)setFailAlertTextView:(id)arg1 {
    self->_failAlertTextView = arg1;
}

- (BOOL)enableLoggingChannelsControls {
    return self->_enableLoggingChannelsControls;
}

- (id)launcher {
    return self->_launcher;
}

- (void)setLauncher:(id)arg1 {
    if (self->_launcher != arg1) {
        [self->_launcher release];
        self->_launcher = [arg1 retain];
    }
}

- (id)loggingViewContainer {
    return self->_loggingViewContainer;
}

- (void)setLoggingViewContainer:(id)arg1 {
    self->_loggingViewContainer = arg1;
}

- (id)modeSpecificViewContainer {
    return self->_modeSpecificViewContainer;
}

- (void)setModeSpecificViewContainer:(id)arg1 {
    self->_modeSpecificViewContainer = arg1;
}

- (id)nonLauncherModeView {
    return self->_nonLauncherModeView;
}

- (void)setNonLauncherModeView:(id)arg1 {
    self->_nonLauncherModeView = arg1;
}

- (id)nonLauncherModeCommandTextField {
    return self->_nonLauncherModeCommandTextField;
}

- (void)setNonLauncherModeCommandTextField:(id)arg1 {
    self->_nonLauncherModeCommandTextField = arg1;
}

- (id)command {
    return self->_command;
}

- (BOOL)commandRunning {
    return self->_commandRunning;
}

- (id)canRunFilterPredicate {
    return self->_canRunFilterPredicate;
}

- (void)setCanRunFilterPredicate:(id)arg1 {
    if (self->_canRunFilterPredicate != arg1) {
        [self->_canRunFilterPredicate release];
        self->_canRunFilterPredicate = [arg1 copy];
    }
}

- (id)launcherModeViewController {
    return self->_launcherModeViewController;
}

- (void)setLauncherModeViewController:(id)arg1 {
    if (self->_launcherModeViewController != arg1) {
        [self->_launcherModeViewController release];
        self->_launcherModeViewController = [arg1 retain];
    }
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

- (id)envVars {
    return self->_envVars;
}

- (void)setEnvVars:(id)arg1 {
    if (self->_envVars != arg1) {
        [self->_envVars release];
        self->_envVars = [arg1 copy];
    }
}

- (id)stdErr {
    return self->_stdErr;
}

- (void)setStdErr:(id)arg1 {
    if (self->_stdErr != arg1) {
        [self->_stdErr release];
        self->_stdErr = [arg1 copy];
    }
}

@end
