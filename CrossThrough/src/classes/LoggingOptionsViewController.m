// LoggingOptionsViewController.m — CrossThrough
#import "LoggingOptionsViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

// Most recent channel/environment pairs, newest first.
static NSString * const kRecentLoggingOptionsKey = @"RecentLoggingOptions";
static const NSUInteger kMaxRecentLoggingOptions = 3;
// Recent entries longer than this are shown elided in the menu.
static const NSUInteger kMaxRecentTitleLength = 40;

@implementation LoggingOptionsViewController

+ (id)keyPathsForValuesAffectingEnableControls {
    return [NSSet setWithArray:@[@"createLogFile", @"enabled"]];
}

- (id)initWithLogFileName:(id)arg1 {
    self = [super initWithNibName:@"LoggingOptionsView" bundle:nil];
    if (self) {
        [self setEnabled:YES];
        [self setLogFileName:arg1];
        [self setLogFileNameFromUser:NO];
        [self setChannelCombos:[NSMutableArray arrayWithArray:[LoggingOption commonPresets]]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self logFileURL]) {
        [self setCreateLogFile:YES];
        [self setLogDirectoryURL:[[self logFileURL] URLByDeletingLastPathComponent]];
        [self setLogFileNameFromUser:YES];
    } else {
        [self setCreateLogFile:NO];
        [self setLogDirectoryURL:[[NSFileManager defaultManager] URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL]];
        if (![self logDirectoryURL]) {
            [self setLogDirectoryURL:[NSURL fileURLWithPath:[@"~/Library" stringByExpandingTildeInPath] isDirectory:YES]];
        }
        [self setLogDirectoryURL:[[self logDirectoryURL] URLByAppendingPathComponent:@"Logs" isDirectory:YES]];
        [self setLogDirectoryURL:[[self logDirectoryURL] URLByAppendingPathComponent:@"CrossOver" isDirectory:YES]];
        [self updateLogFileURL];
    }
    [[NSFileManager defaultManager] createDirectoryAtURL:[self logDirectoryURL] withIntermediateDirectories:YES attributes:nil error:NULL];
    [self updateRecentMenuItems];

    for (LoggingOption *option in [self channelCombos]) {
        NSString *toolTip = [[[option logChannels] sortedArrayUsingSelector:@selector(localizedStandardCompare:)] componentsJoinedByString:@","];
        if ([[option logEnvironment] count] != 0) {
            toolTip = [NSString stringWithFormat:@"%@\n%@", toolTip, [[option logEnvironment] componentsJoinedByString:@"\n"]];
        }
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:[option name] action:@selector(addLoggingChannels:) keyEquivalent:@""];
        [item setTarget:self];
        [item setRepresentedObject:option];
        [item setToolTip:toolTip];
        [item setIndentationLevel:1];
        [[[self channelPresets] menu] addItem:item];
        [item release];
    }
}

- (void)updateLogFileURL {
    if ([self logFileNameFromUser]) {
        return;
    }
    // Pick "<name>.cxlog", then "<name> 2.cxlog", ... until the name is free.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    int attempt = 1;
    BOOL exists;
    do {
        NSMutableString *fileName = [[[self logFileName] mutableCopy] autorelease];
        if (attempt != 1) {
            [fileName appendFormat:@" %d", attempt];
        }
        [fileName appendString:@".cxlog"];
        [self setLogFileURL:[[self logDirectoryURL] URLByAppendingPathComponent:fileName isDirectory:NO]];
        exists = [fileManager fileExistsAtPath:[[self logFileURL] path]];
        attempt++;
    } while (exists);
}

- (void)setLogFileName:(id)arg1 {
    if (self->_logFileName != arg1) {
        NSString *old = self->_logFileName;
        self->_logFileName = [arg1 copy];
        [old release];
        [self updateLogFileURL];
    }
}

- (void)selectLogFile:(id)arg1 {
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setMessage:[[NSBundle mainBundle] localizedStringForKey:@"Select a log file" value:@"" table:nil]];
    [panel setAllowedFileTypes:@[@"cxlog"]];
    [panel setAllowsOtherFileTypes:YES];
    [panel setCanSelectHiddenExtension:YES];
    NSString *fileName = [[self logFileURL] lastPathComponent];
    if (fileName) {
        [panel setNameFieldStringValue:fileName];
    }
    [panel setDirectoryURL:[self logDirectoryURL]];
    [panel setShowsTagField:NO];
    [panel beginSheetModalForWindow:[[self view] window] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            [self setLogFileNameFromUser:YES];
            [self setLogFileURL:[panel URL]];
            [self setLogDirectoryURL:[[self logFileURL] URLByDeletingLastPathComponent]];
        }
    }];
}

- (void)clearLoggingChannels:(id)arg1 {
    [self setLogChannels:nil];
    [self setLogEnvironment:nil];
}

- (id)combineChannels:(id)arg1 with:(id)arg2 andDelimiter:(id)arg3 {
    // Appends the entries of arg2 that arg1 doesn't already contain.
    NSArray *existing = [arg1 componentsSeparatedByString:arg3];
    NSString *base = arg1 ? arg1 : @"";
    NSMutableString *added = [NSMutableString string];
    if ([existing count] != 0) {
        NSSet *existingSet = [NSSet setWithArray:existing];
        for (NSString *channel in arg2) {
            if (![existingSet containsObject:channel]) {
                if ([added length] != 0) {
                    [added appendString:arg3];
                }
                [added appendString:channel];
            }
        }
    } else {
        [added setString:[arg2 componentsJoinedByString:arg3]];
    }
    if ([added length] == 0) {
        return base;
    }
    if ([base length] != 0 && ![base hasSuffix:arg3]) {
        base = [base stringByAppendingString:arg3];
    }
    return [base stringByAppendingString:added];
}

- (void)addLoggingChannels:(id)arg1 {
    LoggingOption *option = [arg1 representedObject];
    NSString *channels = [[self logChannels] stringByRemovingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self setLogChannels:[self combineChannels:channels with:[option logChannels] andDelimiter:@","]];
    [self addExtraEnvVariables:arg1];
}

- (void)addExtraEnvVariables:(id)arg1 {
    LoggingOption *option = [arg1 representedObject];
    [self setLogEnvironment:[self combineChannels:[self logEnvironment] with:[option logEnvironment] andDelimiter:@" "]];
}

- (BOOL)enableControls {
    return [self createLogFile] && [self enabled];
}

- (void)sanitizeLogChannels {
    [self setLogChannels:[DebugChannelFormatter sanitizeChannelString:[self logChannels]]];
}

- (void)saveSettingsToRecent {
    if (![self createLogFile]) {
        return;
    }
    if ([[self logChannels] length] == 0 && [[self logEnvironment] length] == 0) {
        return;
    }
    NSArray *entry = @[[self logChannels] ?: @"", [self logEnvironment] ?: @""];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recent = [[[defaults arrayForKey:kRecentLoggingOptionsKey] mutableCopy] autorelease];
    if (!recent) {
        recent = [NSMutableArray array];
    }
    NSUInteger index = [recent indexOfObject:entry];
    if (index != NSNotFound) {
        [recent removeObjectAtIndex:index];
    }
    [recent insertObject:entry atIndex:0];
    if ([recent count] > kMaxRecentLoggingOptions) {
        [recent removeObjectsInRange:NSMakeRange(kMaxRecentLoggingOptions, [recent count] - kMaxRecentLoggingOptions)];
    }
    [defaults setObject:recent forKey:kRecentLoggingOptionsKey];
    [self updateRecentMenuItems];
}

- (void)updateRecentMenuItems {
    NSArray *recent = [[NSUserDefaults standardUserDefaults] arrayForKey:kRecentLoggingOptionsKey];
    BOOL hidden = [recent count] == 0;
    [[self recentChannelsMenuItem] setHidden:hidden];
    [[self recentChannelsDivider] setHidden:hidden];

    // The recent entries live between the "Recent" header and the divider.
    NSMenu *menu = [[self channelPresets] menu];
    NSInteger firstIndex = [menu indexOfItem:[self recentChannelsMenuItem]] + 1;
    while ([[[self channelPresets] menu] itemAtIndex:firstIndex] != [self recentChannelsDivider]) {
        [[[self channelPresets] menu] removeItemAtIndex:firstIndex];
    }

    NSInteger offset = 0;
    for (NSArray *entry in recent) {
        NSString *channels = [entry objectAtIndexedSubscript:0];
        NSString *environment = [entry objectAtIndexedSubscript:1];
        NSMutableString *toolTip = [NSMutableString string];
        NSString *title = nil;
        if ([channels length] != 0) {
            title = channels;
            [toolTip setString:channels];
            if ([environment length] != 0) {
                [toolTip appendFormat:@"\n%@", environment];
            }
        } else if ([environment length] != 0) {
            title = environment;
            [toolTip setString:environment];
        }
        NSUInteger length = [title length];
        if (length > kMaxRecentTitleLength) {
            title = [NSString stringWithFormat:@"%@…%@", [title substringToIndex:19], [title substringFromIndex:length - 20]];
        }
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:title ?: @"" action:@selector(restoreRecent:) keyEquivalent:@""];
        [item setTarget:self];
        [item setRepresentedObject:entry];
        [item setIndentationLevel:1];
        if (length > kMaxRecentTitleLength || ([channels length] != 0 && [environment length] != 0)) {
            [item setToolTip:toolTip];
        }
        [[[self channelPresets] menu] insertItem:item atIndex:firstIndex + offset];
        [item release];
        offset++;
    }
}

- (void)restoreRecent:(id)arg1 {
    NSArray *entry = [arg1 representedObject];
    [self setLogChannels:[entry objectAtIndexedSubscript:0]];
    [self setLogEnvironment:[entry objectAtIndexedSubscript:1]];
}

- (BOOL)createLogFile {
    return self->_createLogFile;
}

- (void)setCreateLogFile:(BOOL)arg1 {
    self->_createLogFile = arg1;
}

- (BOOL)enabled {
    return self->_enabled;
}

- (void)setEnabled:(BOOL)arg1 {
    self->_enabled = arg1;
}

- (id)channelCombos {
    return [[self->_channelCombos retain] autorelease];
}

- (void)setChannelCombos:(id)arg1 {
    if (self->_channelCombos != arg1) {
        [self->_channelCombos release];
        self->_channelCombos = [arg1 retain];
    }
}

- (id)logChannels {
    return [[self->_logChannels retain] autorelease];
}

- (void)setLogChannels:(id)arg1 {
    if (self->_logChannels != arg1) {
        [self->_logChannels release];
        self->_logChannels = [arg1 copy];
    }
}

- (id)logEnvironment {
    return [[self->_logEnvironment retain] autorelease];
}

- (void)setLogEnvironment:(id)arg1 {
    if (self->_logEnvironment != arg1) {
        [self->_logEnvironment release];
        self->_logEnvironment = [arg1 copy];
    }
}

- (id)logFileName {
    return self->_logFileName;
}

- (id)logFileURL {
    return self->_logFileURL;
}

- (void)setLogFileURL:(id)arg1 {
    if (self->_logFileURL != arg1) {
        [self->_logFileURL release];
        self->_logFileURL = [arg1 copy];
    }
}

- (id)logDirectoryURL {
    return [[self->_logDirectoryURL retain] autorelease];
}

- (void)setLogDirectoryURL:(id)arg1 {
    if (self->_logDirectoryURL != arg1) {
        [self->_logDirectoryURL release];
        self->_logDirectoryURL = [arg1 copy];
    }
}

- (BOOL)logFileNameFromUser {
    return self->_logFileNameFromUser;
}

- (void)setLogFileNameFromUser:(BOOL)arg1 {
    self->_logFileNameFromUser = arg1;
}

- (id)channelPresets {
    return [objc_loadWeakRetained((id *)&self->_channelPresets) autorelease];
}

- (void)setChannelPresets:(id)arg1 {
    objc_storeWeak((id *)&self->_channelPresets, arg1);
}

- (id)recentChannelsDivider {
    return [objc_loadWeakRetained((id *)&self->_recentChannelsDivider) autorelease];
}

- (void)setRecentChannelsDivider:(id)arg1 {
    objc_storeWeak((id *)&self->_recentChannelsDivider, arg1);
}

- (id)recentChannelsMenuItem {
    return [objc_loadWeakRetained((id *)&self->_recentChannelsMenuItem) autorelease];
}

- (void)setRecentChannelsMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_recentChannelsMenuItem, arg1);
}

- (void)dealloc {
    [self->_channelCombos release];
    [self->_logChannels release];
    [self->_logEnvironment release];
    [self->_logFileName release];
    [self->_logFileURL release];
    [self->_logDirectoryURL release];
    objc_destroyWeak((id *)&self->_channelPresets);
    objc_destroyWeak((id *)&self->_recentChannelsDivider);
    objc_destroyWeak((id *)&self->_recentChannelsMenuItem);
    [super dealloc];
}

@end
