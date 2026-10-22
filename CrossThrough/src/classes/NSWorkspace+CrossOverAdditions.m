// NSWorkspace+CrossOverAdditions.m — CrossThrough
#import "NSWorkspace+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSWorkspace (CrossOverAdditions)

- (id)CX_findRunningAppBundleWithIdentifier:(id)arg1 {
    NSArray *running = [NSRunningApplication runningApplicationsWithBundleIdentifier:arg1];
    if ([running count] == 0) {
        return nil;
    }
    return [[[running objectAtIndex:0] bundleURL] path];
}

- (id)CX_absolutePathForAppBundleWithIdentifier:(id)arg1 orIdentifyingURLScheme:(id)arg2 {
    NSParameterAssert(arg1 != nil);
    NSString *path = [self CX_findRunningAppBundleWithIdentifier:arg1];
    if (arg2 && !path) {
        NSFileManager *fileManager = [[NSFileManager defaultManager] retain];
        NSURL *schemeURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@:fake", arg2]];
        NSArray *candidates = (NSArray *)LSCopyApplicationURLsForURL((CFURLRef)schemeURL, kLSRolesAll);
        NSURL *bestURL = nil;
        NSDate *bestDate = [[NSDate distantPast] retain];
        int bestMajor = -1;
        int bestMinor = -1;
        for (NSURL *candidate in candidates) {
            @autoreleasepool {
                CXBundle *bundle = [CXBundle bundleWithURL:candidate];
                if (!bundle || [[bundle bundleIdentifier] caseInsensitiveCompare:arg1] != NSOrderedSame) {
                    continue;
                }
                if (![fileManager isExecutableFileAtPath:[bundle executablePath]]) {
                    continue;
                }
                NSScanner *scanner = [NSScanner scannerWithString:[bundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]];
                int major = 0;
                int minor = 0;
                if (![scanner scanInt:&major] || ![scanner scanString:@"." intoString:NULL] ||
                    ![scanner scanInt:&minor] || ![scanner scanString:@"." intoString:NULL] ||
                    major < 1 || minor < 0) {
                    continue;
                }
                NSDictionary *attributes = [fileManager attributesOfItemAtPath:[[candidate URLByResolvingSymlinksInPath] path] error:nil];
                NSDate *modificationDate = [attributes fileModificationDate];
                if (major > bestMajor || (major == bestMajor && minor > bestMinor) ||
                    (major == bestMajor && minor == bestMinor && [modificationDate compare:bestDate] == NSOrderedDescending)) {
                    [bestURL release];
                    bestURL = [candidate retain];
                    bestMajor = major;
                    bestMinor = minor;
                    [bestDate release];
                    bestDate = [modificationDate copy];
                }
            }
        }
        path = [bestURL path];
        [bestDate release];
        [bestURL autorelease];
        [candidates release];
        [fileManager release];
    }
    if (!path) {
        path = [self absolutePathForAppBundleWithIdentifier:arg1];
    }
    return path;
}

- (BOOL)CX_launchAppWithBundleIdentifier:(id)arg1 orIdentifyingURLScheme:(id)arg2 options:(NSUInteger)arg3 additionalEventParamDescriptor:(id)arg4 {
    NSParameterAssert(arg1 != nil);
    if ([self CX_findRunningAppBundleWithIdentifier:arg1]) {
        return YES;
    }
    return [self CX_openURLs:nil withAppBundleIdentifier:arg1 orIdentifyingURLScheme:arg2 options:arg3 additionalEventParamDescriptor:arg4];
}

- (BOOL)CX_openURLs:(id)arg1 withAppBundleIdentifier:(id)arg2 orIdentifyingURLScheme:(id)arg3 options:(NSUInteger)arg4 additionalEventParamDescriptor:(id)arg5 {
    NSParameterAssert(arg2 != nil);
    NSString *appPath = [self CX_absolutePathForAppBundleWithIdentifier:arg2 orIdentifyingURLScheme:arg3];
    if (!appPath) {
        return NO;
    }
    LSLaunchURLSpec spec = {
        .appURL = (CFURLRef)[NSURL fileURLWithPath:appPath],
        .itemURLs = (CFArrayRef)arg1,
        .passThruParams = [(NSAppleEventDescriptor *)arg5 aeDesc],
        .launchFlags = (LSLaunchFlags)arg4,
        .asyncRefCon = NULL,
    };
    return LSOpenFromURLSpec(&spec, NULL) == noErr;
}

@end
