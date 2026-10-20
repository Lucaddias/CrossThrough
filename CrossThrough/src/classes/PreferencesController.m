// PreferencesController.m — CrossThrough
#import "PreferencesController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "c_functions.h"

@implementation PreferencesController

- (id)init {
    self = [super initWithWindowNibName:@"Preferences"];
    return self;
}

- (void)dealloc {
    if (self->_fsEventStream != NULL) {
        FSEventStreamStop(self->_fsEventStream);
        FSEventStreamInvalidate(self->_fsEventStream);
        FSEventStreamRelease(self->_fsEventStream);
        self->_fsEventStream = NULL;
    }
    if (self->_queue) {
        dispatch_release(self->_queue);
        self->_queue = NULL;
    }
    [self->_installersCache release];
    [self->_bottlesFolderURL release];
    [self->_programsFolderURL release];
    [self->_lastUpdated release];
    [super dealloc];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [self updateC4PModDate];
    
    NSString *cachesDir = [CXServerCrossOver getCachesDir];
    NSArray *components = [NSArray arrayWithObjects:cachesDir ?: @"", @"installers", nil];
    NSURL *rawURL = [NSURL fileURLWithPathComponents:components];
    [self->_installersCache release];
    self->_installersCache = [rawURL copy];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:self->_installersCache
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:nil];
    
    self->_queue = dispatch_queue_create("com.codeweavers.CrossOver.installer-cache-sizing", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(self->_queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0));
    
    FSEventStreamContext ctx = {0, (void *)self, (CFAllocatorRetainCallBack)CFRetain, (CFAllocatorReleaseCallBack)CFRelease, (CFAllocatorCopyDescriptionCallBack)CFCopyDescription};
    NSString *cachePath = [self->_installersCache path];
    if (cachePath) {
        NSArray *paths = [NSArray arrayWithObject:cachePath];
        self->_fsEventStream = FSEventStreamCreate(kCFAllocatorDefault,
                                                   (FSEventStreamCallback)_InstallersCacheEventStreamCallback,
                                                   &ctx,
                                                   (CFArrayRef)paths,
                                                   kFSEventStreamEventIdSinceNow,
                                                   2.0,
                                                   kFSEventStreamCreateFlagNone);
        if (self->_fsEventStream) {
            FSEventStreamSetDispatchQueue(self->_fsEventStream, self->_queue);
            FSEventStreamStart(self->_fsEventStream);
        }
    }
    
    [self->_installerCacheSizeLabel setStringValue:[self installerCacheSizeStringWhileCalculating]];
    
    if (self->_queue) {
        dispatch_async(self->_queue, ^{
            [self calculateInstallerCacheSize];
        });
    }
}

- (void)updateC4PModDate {
    [self setLastUpdated:[CXServerCrossOver crossTieModDateString]];
}

- (void)windowWillLoad {
    [super windowWillLoad];
    NSString *bDir = [CXServerCrossOver getBottleDir];
    if (bDir) {
        [self setBottlesFolderURL:[NSURL fileURLWithPath:bDir]];
    }
    NSString *pDir = [CXServerCrossOver getProgramsFolder];
    if (pDir) {
        [self setProgramsFolderURL:[NSURL fileURLWithPath:pDir]];
    }
}

- (void)bottlesFolderChanged:(id)arg1 {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[self bottlesFolderURL] path];
    if (path) {
        [defaults setObject:path forKey:@"BottleDir"];
    }
    CXApplication *app = (CXApplication *)[CXApplication sharedApplication];
    [[app CXServer] setEnvironmentVariables];
    [[[CXSetupLib bottleCollectionClass] sharedCollection] reset];
}

- (void)resetBottlesFolder:(id)arg1 {
    NSString *def = [CXServerCrossOver getDefaultBottleDir];
    if (def) {
        [self setBottlesFolderURL:[NSURL fileURLWithPath:def]];
    }
    [self bottlesFolderChanged:arg1];
}

- (void)browseForBottlesFolder:(id)arg1 {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setMessage:[[NSBundle mainBundle] localizedStringForKey:@"Choose a Bottles Folder" value:@"" table:nil]];
    [panel setPrompt:[[NSBundle mainBundle] localizedStringForKey:@"Choose" value:@"" table:nil]];
    [panel setDelegate:self];
    
    NSString *path = [[self bottlesFolderURL] path];
    if (!path || ![[NSFileManager defaultManager] isWritableFileAtPath:path]) {
        path = [CXServerCrossOver getDefaultBottleDir];
    }
    if (path) {
        [panel setDirectoryURL:[NSURL fileURLWithPath:path]];
    }
    [panel beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            [self setBottlesFolderURL:[panel URL]];
            [self bottlesFolderChanged:nil];
        }
    }];
}

- (void)programsFolderChanged:(id)arg1 {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *path = [[self programsFolderURL] path];
    if (path) {
        NSData *bookmark = [[NSFileManager defaultManager] bookmarkDataFromPath:path];
        if (bookmark) {
            [defaults setObject:bookmark forKey:@"ProgramsFolderBookmark"];
        } else {
            [defaults removeObjectForKey:@"ProgramsFolderBookmark"];
        }
        [defaults setObject:path forKey:@"ProgramsFolderPath"];
    }
}

- (void)resetProgramsFolder:(id)arg1 {
    NSString *def = [CXServerCrossOver getDefaultProgramsFolder];
    if (def) {
        [self setProgramsFolderURL:[NSURL fileURLWithPath:def]];
    }
    [self programsFolderChanged:arg1];
}

- (void)browseForProgramsFolder:(id)arg1 {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setMessage:[[NSBundle mainBundle] localizedStringForKey:@"Choose a Programs Folder" value:@"" table:nil]];
    [panel setPrompt:[[NSBundle mainBundle] localizedStringForKey:@"Choose" value:@"" table:nil]];
    [panel setDelegate:self];
    
    NSString *path = [[self programsFolderURL] path];
    if (!path || ![[NSFileManager defaultManager] isWritableFileAtPath:path]) {
        path = [CXServerCrossOver getDefaultProgramsFolder];
    }
    if (path) {
        [panel setDirectoryURL:[NSURL fileURLWithPath:path]];
    }
    [panel beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            [self setProgramsFolderURL:[panel URL]];
            [self programsFolderChanged:nil];
        }
    }];
}

- (BOOL)panel:(id)sender isValidFilename:(id)filename {
    BOOL writable = [[NSFileManager defaultManager] isWritableFileAtPath:filename];
    if (!writable) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Please select a writable folder" value:@"" table:nil]];
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"In order for %@ to install Windows applications, you must have write permissions to this folder." value:@"" table:nil];
        NSString *appName = [[NSRunningApplication currentApplication] localizedName] ?: @"CrossOver";
        [alert setInformativeText:[NSString stringWithFormat:fmt, appName]];
        [alert addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"OK" value:@"" table:nil]];
        [alert runModal];
        [alert release];
    }
    return writable;
}

- (id)installerCacheSizeStringWhileCalculating {
    return [[NSBundle mainBundle] localizedStringForKey:@"Calculating…" value:@"" table:nil];
}

- (void)enumerateCachedInstallersWithBlock:(void (^)(NSURL *itemURL))block {
    if (!block || !self->_installersCache) return;
    NSCharacterSet *hexSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdef"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *resolved = [self->_installersCache URLByResolvingSymlinksInPath];
    NSArray *keys = [NSArray arrayWithObjects:NSURLNameKey, NSURLIsDirectoryKey, NSURLTotalFileAllocatedSizeKey, nil];
    NSDirectoryEnumerator *enumerator = [fm enumeratorAtURL:resolved
                                 includingPropertiesForKeys:keys
                                                    options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsPackageDescendants
                                               errorHandler:nil];
    for (NSURL *itemURL in enumerator) {
        NSNumber *isDir = nil;
        if ([itemURL getResourceValue:&isDir forKey:NSURLIsDirectoryKey error:nil] && [isDir boolValue]) {
            continue;
        }
        NSString *name = nil;
        if ([itemURL getResourceValue:&name forKey:NSURLNameKey error:nil] && name) {
            if ([name length] >= 34 && [name characterAtIndex:32] == '.') {
                BOOL isHex = YES;
                for (NSUInteger i = 0; i < 32; i++) {
                    if (![hexSet characterIsMember:[name characterAtIndex:i]]) {
                        isHex = NO;
                        break;
                    }
                }
                if (isHex) {
                    block(itemURL);
                }
            }
        }
    }
}

- (void)calculateInstallerCacheSize {
    __block unsigned long long total = 0;
    [self enumerateCachedInstallersWithBlock:^(NSURL *itemURL) {
        NSNumber *size = nil;
        if ([itemURL getResourceValue:&size forKey:NSURLTotalFileAllocatedSizeKey error:nil] && size) {
            total += [size unsignedLongLongValue];
        }
    }];
    NSString *str = [NSByteCountFormatter stringFromByteCount:(long long)total countStyle:NSByteCountFormatterCountStyleFile];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_installerCacheSizeLabel setStringValue:str];
    });
}

- (void)installersCacheEventStreamCallback {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->_installerCacheSizeLabel setStringValue:[self installerCacheSizeStringWhileCalculating]];
    });
    [self calculateInstallerCacheSize];
}

- (void)clearInstallerCache:(id)sender {
    if (!self->_queue) return;
    dispatch_async(self->_queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_installerCacheSizeLabel setStringValue:[[NSBundle mainBundle] localizedStringForKey:@"Clearing…" value:@"" table:nil]];
        });
        NSMutableArray *items = [NSMutableArray array];
        [self enumerateCachedInstallersWithBlock:^(NSURL *itemURL) {
            [items addObject:itemURL];
        }];
        NSFileManager *fm = [NSFileManager defaultManager];
        for (NSURL *url in items) {
            NSError *err = nil;
            if (![fm removeItemAtURL:url error:&err]) {
                NSLog(@"Failed to delete cached installer %@: %@\n", url, err);
            }
        }
        [self calculateInstallerCacheSize];
    });
}

- (void)openInstallerCache:(id)sender {
    if (self->_installersCache) {
        [[NSWorkspace sharedWorkspace] openURL:self->_installersCache];
    }
}

- (id)installerCacheSizeLabel {
    return self->_installerCacheSizeLabel;
}

- (void)setInstallerCacheSizeLabel:(id)arg1 {
    self->_installerCacheSizeLabel = arg1;
}

- (id)bottlesFolderURL {
    return self->_bottlesFolderURL;
}

- (void)setBottlesFolderURL:(id)arg1 {
    if (self->_bottlesFolderURL != arg1) {
        [self->_bottlesFolderURL release];
        self->_bottlesFolderURL = [arg1 copy];
    }
}

- (id)programsFolderURL {
    return self->_programsFolderURL;
}

- (void)setProgramsFolderURL:(id)arg1 {
    if (self->_programsFolderURL != arg1) {
        [self->_programsFolderURL release];
        self->_programsFolderURL = [arg1 copy];
    }
}

- (id)lastUpdated {
    return self->_lastUpdated;
}

- (void)setLastUpdated:(id)arg1 {
    if (self->_lastUpdated != arg1) {
        [self->_lastUpdated release];
        self->_lastUpdated = [arg1 copy];
    }
}

@end
