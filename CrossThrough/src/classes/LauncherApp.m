// LauncherApp.m — CrossThrough
#import "LauncherApp.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherApp

+ (id)launcherWithURL:(id)arg1 {
    return [[[self alloc] initWithURL:arg1] autorelease];
}

- (id)initWithURL:(id)arg1 {
    NSString *name = [[arg1 lastPathComponent] stringByDeletingPathExtension];
    CXBundle *bundle = [CXBundle bundleWithURL:arg1];
    if (bundle) {
        // Helper apps are renamed to unique bundle names; prefer the menu name
        // the user saw in Windows.
        if ([[bundle objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey] isEqualToString:name]) {
            NSString *originalName = [bundle objectForInfoDictionaryKey:@"CXOriginalMenuName"];
            if (originalName) {
                name = originalName;
            }
        }
    }
    self = [super initWithName:name];
    if (self) {
        self->_url = [arg1 copy];
        self->_bundleID = [[bundle objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey] copy];
        [self setIcon:[bundle icon]];
        [self setHelperVersion:[bundle helperVersion]];
        if (bundle) {
            id collection = [[CXSetupLib bottleCollectionClass] sharedCollection];
            NSString *bottleName = [bundle objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
            [self setBottle:[collection bottleWithName:bottleName]];
        }
    }
    return self;
}

- (void)dealloc {
    [self->_url release];
    [self->_bundleID release];
    [super dealloc];
}

- (id)copyWithZone:(void *)arg1 {
    LauncherApp *copy = [super copyWithZone:arg1];
    [copy setUrl:self->_url];
    [copy setBundleID:self->_bundleID];
    return copy;
}

- (void)launchWithErrorHandler:(id)arg1 {
    void (^errorHandler)(NSError *) = arg1;
    NSError *error = nil;
    NSRunningApplication *app = [[NSWorkspace sharedWorkspace] openURL:[self url]
                                                               options:NSWorkspaceLaunchAsync
                                                         configuration:@{}
                                                                 error:&error];
    if (app) {
        if (@available(macOS 14.0, *)) {
            NSLog(@"yielding activation to launcher %@", app);
            [NSApp yieldActivationToApplication:app];
        }
    } else if (errorHandler) {
        errorHandler(error);
    }
}

- (id)description {
    return [NSString stringWithFormat:@"%@ url %@", [super description], [self url]];
}

- (id)url {
    return self->_url;
}

- (void)setUrl:(id)arg1 {
    if (self->_url != arg1) {
        [self->_url release];
        self->_url = [arg1 copy];
    }
}

- (id)bundleID {
    return self->_bundleID;
}

- (void)setBundleID:(id)arg1 {
    if (self->_bundleID != arg1) {
        [self->_bundleID release];
        self->_bundleID = [arg1 copy];
    }
}

- (NSUInteger)helperVersion {
    return self->_helperVersion;
}

- (void)setHelperVersion:(NSUInteger)arg1 {
    self->_helperVersion = arg1;
}

@end
