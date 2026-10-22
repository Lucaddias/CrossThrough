// CXBundle.m — CrossThrough
#import "CXBundle.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

// Private CoreFoundation calls CrossOver makes when available, so a helper
// app rewritten on disk is not read from a stale bundle cache.
extern void _CFBundleFlushCachesForURL(CFURLRef url) __attribute__((weak_import));
extern void _CFBundleFlushBundleCaches(CFBundleRef bundle) __attribute__((weak_import));


@implementation CXBundle

+ (id)bundleWithURL:(id)arg1 {
    return [[[self alloc] initWithURL:arg1] autorelease];
}

- (id)initWithURL:(id)arg1 {
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setUrl:arg1];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *infoPlist = [[arg1 URLByAppendingPathComponent:@"Contents" isDirectory:YES] URLByAppendingPathComponent:@"Info.plist" isDirectory:NO];
    BOOL isDirectory = NO;
    if ([fileManager fileExistsAtPath:[infoPlist path] isDirectory:&isDirectory] && !isDirectory &&
        [fileManager isReadableFileAtPath:[infoPlist path]]) {
        if (_CFBundleFlushCachesForURL) {
            _CFBundleFlushCachesForURL((CFURLRef)arg1);
        }
        [self setCfBundle:CFBundleCreate(NULL, (CFURLRef)arg1)];
        if ([self cfBundle] && _CFBundleFlushBundleCaches) {
            _CFBundleFlushBundleCaches([self cfBundle]);
        }
    }
    if (![self cfBundle]) {
        [self release];
        return nil;
    }
    return self;
}

- (void)dealloc {
    if ([self cfBundle]) {
        CFRelease([self cfBundle]);
    }
    [self->_url release];
    [super dealloc];
}

- (id)objectForInfoDictionaryKey:(id)arg1 {
    return [[(id)CFBundleGetValueForInfoDictionaryKey([self cfBundle], (CFStringRef)arg1) retain] autorelease];
}

- (id)bundleIdentifier {
    return (NSString *)CFBundleGetIdentifier([self cfBundle]);
}

- (id)executablePath {
    NSURL *executableURL = (NSURL *)CFBundleCopyExecutableURL([self cfBundle]);
    NSString *path = [[[executableURL path] copy] autorelease];
    [executableURL release];
    return path;
}

- (NSUInteger)helperVersion {
    return [(id)CFBundleGetValueForInfoDictionaryKey([self cfBundle], CFSTR("CXHelperAppVersion")) unsignedIntValue];
}

- (id)icon {
    NSString *iconFile = [self objectForInfoDictionaryKey:@"CFBundleIconFile"];
    if (iconFile) {
        NSURL *iconURL = (NSURL *)CFBundleCopyResourceURL([self cfBundle], (CFStringRef)iconFile, CFSTR("icns"), NULL);
        if (iconURL) {
            NSImage *image = [[NSImage alloc] initWithContentsOfURL:iconURL];
            [iconURL release];
            if (image) {
                return [image autorelease];
            }
        }
    }
    return [[NSWorkspace sharedWorkspace] iconForFile:[[self url] path]];
}

- (id)url {
    return self->_url;
}

- (void)setUrl:(id)arg1 {
    if (self->_url != arg1) {
        [self->_url release];
        self->_url = [arg1 retain];
    }
}

- (CFBundleRef)cfBundle {
    return self->_cfBundle;
}

- (void)setCfBundle:(CFBundleRef)arg1 {
    self->_cfBundle = arg1;
}

@end
