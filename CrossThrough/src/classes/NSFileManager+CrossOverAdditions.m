// NSFileManager+CrossOverAdditions.m — CrossThrough
#import "NSFileManager+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static NSSet *_systemPaths = nil;


@implementation NSFileManager (CrossOverAdditions)

+ (id)systemPaths {
    static const NSSearchPathDirectory directories[] = {
        NSApplicationDirectory, NSDemoApplicationDirectory, NSDeveloperApplicationDirectory,
        NSAdminApplicationDirectory, NSLibraryDirectory, NSDeveloperDirectory, NSUserDirectory,
        NSDocumentationDirectory, NSDocumentDirectory, NSCoreServiceDirectory,
        NSDesktopDirectory, NSCachesDirectory, NSApplicationSupportDirectory, NSDownloadsDirectory,
        NSAllApplicationsDirectory, NSAllLibrariesDirectory,
    };
    @synchronized ([NSFileManager class]) {
        if (!_systemPaths) {
            NSMutableSet *paths = [[NSMutableSet alloc] init];
            for (size_t i = 0; i < sizeof(directories) / sizeof(directories[0]); i++) {
                [paths addObjectsFromArray:NSSearchPathForDirectoriesInDomains(directories[i], NSAllDomainsMask, YES)];
            }
            [_systemPaths release];
            _systemPaths = [paths copy];
            [paths release];
        }
    }
    return [[_systemPaths retain] autorelease];
}

- (BOOL)createDirectoryAtPath:(id)arg1 attributes:(id)arg2 recursively:(BOOL)arg3 {
    BOOL isSystemPath = [[[self class] systemPaths] containsObject:arg1];
    NSDictionary *attributes = arg2;
    if (isSystemPath && ![arg2 objectForKey:NSFilePosixPermissions]) {
        NSMutableDictionary *withPermissions = arg2 ? [[arg2 mutableCopy] autorelease] : [NSMutableDictionary dictionary];
        [withPermissions setObject:@0700 forKey:NSFilePosixPermissions];
        attributes = withPermissions;
    }
    if (arg3) {
        BOOL isDirectory = NO;
        if ([self fileExistsAtPath:arg1 isDirectory:&isDirectory]) {
            return isDirectory;
        }
        if (![self createDirectoryAtPath:[arg1 stringByDeletingLastPathComponent] attributes:attributes recursively:YES]) {
            return NO;
        }
    }
    BOOL created = [self createDirectoryAtPath:arg1 withIntermediateDirectories:NO attributes:attributes error:nil];
    if (created && isSystemPath) {
        [self createFileAtPath:[arg1 stringByAppendingPathComponent:@".localized"] contents:nil attributes:nil];
    }
    return created;
}

- (BOOL)isSameFile:(id)arg1 asFile:(id)arg2 {
    if (!arg1 || !arg2) {
        return NO;
    }
    NSURL *url1 = [[NSURL fileURLWithPath:arg1] URLByResolvingSymlinksInPath];
    NSURL *url2 = [[NSURL fileURLWithPath:arg2] URLByResolvingSymlinksInPath];
    id identifier1 = nil;
    id identifier2 = nil;
    if (![url1 getResourceValue:&identifier1 forKey:NSURLFileResourceIdentifierKey error:nil] || !identifier1) {
        return NO;
    }
    if (![url2 getResourceValue:&identifier2 forKey:NSURLFileResourceIdentifierKey error:nil] || !identifier2) {
        return NO;
    }
    return [identifier1 isEqual:identifier2];
}

- (id)getDisplayStringForPath:(id)arg1 {
    NSArray *homeComponents = [self componentsToDisplayForPath:NSHomeDirectory()];
    NSArray *components = [self componentsToDisplayForPath:arg1];
    NSUInteger homeCount = [homeComponents count];
    if ([components count] >= homeCount &&
        [homeComponents isEqualToArray:[components subarrayWithRange:NSMakeRange(0, homeCount)]]) {
        NSArray *rest = [components subarrayWithRange:NSMakeRange(homeCount, [components count] - homeCount)];
        components = [[NSArray arrayWithObject:NSUserName()] arrayByAddingObjectsFromArray:rest];
    }
    NSString *arrow = [[NSBundle mainBundle] localizedStringForKey:@"▹" value:@"" table:nil];
    NSString *separator = [NSString stringWithFormat:@" %@ ", arrow];
    return [components componentsJoinedByString:separator];
}

- (id)pathFromBookmarkData:(id)arg1 stale:(BOOL *)arg2 {
    if ([arg1 length] == 0) {
        return nil;
    }
    BOOL isStale = NO;
    NSURL *home = [NSURL fileURLWithPath:NSHomeDirectory()];
    NSURL *url = [NSURL URLByResolvingBookmarkData:arg1
                                           options:NSURLBookmarkResolutionWithoutUI | NSURLBookmarkResolutionWithoutMounting
                                     relativeToURL:home
                               bookmarkDataIsStale:&isStale
                                             error:nil];
    NSString *path = [url path];
    if ([self isFileInTrash:path]) {
        return nil;
    }
    if (arg2 && path) {
        *arg2 = isStale;
    }
    return path;
}

- (id)bookmarkDataFromPath:(id)arg1 {
    NSURL *url = [NSURL fileURLWithPath:arg1];
    NSURL *home = [NSURL fileURLWithPath:NSHomeDirectory()];
    return [url bookmarkDataWithOptions:0 includingResourceValuesForKeys:@[] relativeToURL:home error:nil];
}

- (BOOL)makeWritableAtPath:(id)arg1 recursively:(BOOL)arg2 {
    NSError *error = nil;
    NSDictionary *attributes = [self attributesOfItemAtPath:arg1 error:&error];
    if (!attributes) {
        NSLog(@"%s: Could not obtain file attributes for %@: %@\n", __PRETTY_FUNCTION__, arg1, error);
        return NO;
    }
    NSUInteger permissions = [attributes filePosixPermissions];
    if (!(permissions & S_IWUSR)) {
        NSDictionary *writable = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInteger:permissions | S_IWUSR] forKey:NSFilePosixPermissions];
        if (![self setAttributes:writable ofItemAtPath:arg1 error:&error]) {
            NSLog(@"%s: Could not change file attributes for %@: %@\n", __PRETTY_FUNCTION__, arg1, error);
            return NO;
        }
    }
    if (!arg2) {
        return YES;
    }
    NSDirectoryEnumerator *enumerator = [self enumeratorAtPath:arg1];
    if (!enumerator) {
        NSLog(@"%s: Could not make directory enumerator for %@\n", __PRETTY_FUNCTION__, arg1);
        return NO;
    }
    BOOL ok = YES;
    for (NSString *relativePath in enumerator) {
        @autoreleasepool {
            NSUInteger itemPermissions = [[enumerator fileAttributes] filePosixPermissions];
            if (!(itemPermissions & S_IWUSR)) {
                NSString *path = [arg1 stringByAppendingPathComponent:relativePath];
                NSDictionary *writable = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInteger:itemPermissions | S_IWUSR] forKey:NSFilePosixPermissions];
                NSError *itemError = nil;
                if (![self setAttributes:writable ofItemAtPath:path error:&itemError] && ok) {
                    NSLog(@"%s: Could not change file attributes for %@: %@\n", __PRETTY_FUNCTION__, path, itemError);
                    ok = NO;
                }
            }
        }
    }
    return ok;
}

- (void)removeFolderIfEmpty:(id)arg1 upTo:(id)arg2 {
    if (![self isFile:arg1 inDirectory:arg2] || [self isSameFile:arg2 asFile:arg1]) {
        return;
    }
    NSArray *contents = [self contentsOfDirectoryAtPath:arg1 error:nil];
    if (!contents) {
        return;
    }
    BOOL empty = [contents count] == 0 ||
                 ([contents count] == 1 && [[contents objectAtIndex:0] caseInsensitiveCompare:@".DS_Store"] == NSOrderedSame);
    if (empty && [self removeItemAtPath:arg1 error:nil]) {
        [self removeFolderIfEmpty:[arg1 stringByDeletingLastPathComponent] upTo:arg2];
    }
}

- (BOOL)isFileInTrash:(id)arg1 {
    return [self isFile:arg1 inDirectory:[self trashForFile:arg1]];
}

- (id)trashForFile:(id)arg1 {
    if (!arg1) {
        return nil;
    }
    NSURL *url = [NSURL fileURLWithPath:arg1];
    if (!url) {
        return nil;
    }
    NSURL *trash = [self URLForDirectory:NSTrashDirectory inDomain:NSUserDomainMask appropriateForURL:url create:YES error:nil];
    if (!trash) {
        trash = [self URLForDirectory:NSTrashDirectory inDomain:NSLocalDomainMask appropriateForURL:url create:YES error:nil];
    }
    return [trash path];
}

- (BOOL)isFile:(id)arg1 inDirectory:(id)arg2 {
    if (!arg1 || !arg2) {
        return NO;
    }
    NSURL *directoryURL = [NSURL fileURLWithPath:arg2];
    NSDictionary *values = [directoryURL resourceValuesForKeys:@[NSURLFileResourceIdentifierKey, NSURLIsSymbolicLinkKey] error:nil];
    id directoryID = [values objectForKey:NSURLFileResourceIdentifierKey];
    if (!directoryID) {
        return NO;
    }
    id resolvedID = nil;
    if ([[values objectForKey:NSURLIsSymbolicLinkKey] boolValue]) {
        if (![[directoryURL URLByResolvingSymlinksInPath] getResourceValue:&resolvedID forKey:NSURLFileResourceIdentifierKey error:nil]) {
            resolvedID = nil;
        }
    }
    NSURL *url = [NSURL fileURLWithPath:arg1];
    while (url) {
        id identifier = nil;
        if (![url getResourceValue:&identifier forKey:NSURLFileResourceIdentifierKey error:nil]) {
            return NO;
        }
        if ([identifier isEqual:directoryID] || [identifier isEqual:resolvedID]) {
            return YES;
        }
        if ([[url path] isEqualToString:@"/"]) {
            return NO;
        }
        url = [url URLByDeletingLastPathComponent];
    }
    return NO;
}

- (void)clearQuarantine:(id)arg1 {
    NSURL *url = [NSURL fileURLWithPath:arg1];
    [url setResourceValue:[NSNull null] forKey:NSURLQuarantinePropertiesKey error:nil];
    for (NSString *relativePath in [[NSFileManager defaultManager] enumeratorAtPath:arg1]) {
        [[url URLByAppendingPathComponent:relativePath] setResourceValue:[NSNull null] forKey:NSURLQuarantinePropertiesKey error:nil];
    }
}

@end
