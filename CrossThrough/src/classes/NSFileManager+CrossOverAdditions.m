// NSFileManager+CrossOverAdditions.m — CrossThrough
// Ported from CrossOver 26.3 arm64 (0x100027e74..0x100029008).
#import "NSFileManager+CrossOverAdditions.h"
#import "CrossThrough.h"

static NSSet *_systemPaths;

@implementation NSFileManager (CrossOverAdditions)

+ (id)systemPaths {
    @synchronized ([NSFileManager class]) {
        if (_systemPaths == nil) {
            // The table at 0x10009dc18: every standard directory whose
            // folders get a .localized marker.
            static const NSSearchPathDirectory directories[] = {
                NSApplicationDirectory, NSDemoApplicationDirectory, NSDeveloperApplicationDirectory,
                NSAdminApplicationDirectory, NSLibraryDirectory, NSDeveloperDirectory, NSUserDirectory,
                NSDocumentationDirectory, NSDocumentDirectory, NSCoreServiceDirectory,
                NSDesktopDirectory, NSCachesDirectory, NSApplicationSupportDirectory,
                NSDownloadsDirectory, NSAllApplicationsDirectory, NSAllLibrariesDirectory,
            };
            NSMutableSet *paths = [[NSMutableSet alloc] init];
            for (size_t i = 0; i < sizeof(directories) / sizeof(directories[0]); i++) {
                [paths addObjectsFromArray:NSSearchPathForDirectoriesInDomains(directories[i], NSAllDomainsMask, YES)];
            }
            _systemPaths = [paths copy];
        }
    }
    return _systemPaths;
}

- (BOOL)createDirectoryAtPath:(id)arg1 attributes:(id)arg2 recursively:(BOOL)arg3 {
    BOOL isSystemPath = [[[self class] systemPaths] containsObject:arg1];
    NSDictionary *attributes = arg2;
    if (isSystemPath && [arg2 objectForKey:NSFilePosixPermissions] == nil) {
        NSMutableDictionary *withPermissions = arg2 ? [arg2 mutableCopy] : [NSMutableDictionary dictionary];
        [withPermissions setObject:@(0700) forKey:NSFilePosixPermissions];
        attributes = withPermissions;
    }
    if (arg3) {
        BOOL isDirectory;
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
    if (arg1 == nil || arg2 == nil) {
        return NO;
    }
    NSURL *first = [[NSURL fileURLWithPath:arg1] URLByResolvingSymlinksInPath];
    NSURL *second = [[NSURL fileURLWithPath:arg2] URLByResolvingSymlinksInPath];
    id firstID = nil;
    id secondID = nil;
    if (![first getResourceValue:&firstID forKey:NSURLFileResourceIdentifierKey error:nil] || firstID == nil) {
        return NO;
    }
    if (![second getResourceValue:&secondID forKey:NSURLFileResourceIdentifierKey error:nil] || secondID == nil) {
        return NO;
    }
    return [firstID isEqual:secondID];
}

- (id)getDisplayStringForPath:(id)arg1 {
    NSArray *home = [self componentsToDisplayForPath:NSHomeDirectory()];
    NSArray *components = [self componentsToDisplayForPath:arg1];
    NSUInteger homeCount = [home count];
    if ([components count] >= homeCount &&
        [home isEqualToArray:[components subarrayWithRange:NSMakeRange(0, homeCount)]]) {
        // Show the home folder as just the user name.
        NSArray *rest = [components subarrayWithRange:NSMakeRange(homeCount, [components count] - homeCount)];
        components = [[NSArray arrayWithObject:NSUserName()] arrayByAddingObjectsFromArray:rest];
    }
    NSString *separator = [NSString stringWithFormat:@" %@ ", [[NSBundle mainBundle] localizedStringForKey:@"▹" value:@"" table:nil]];
    return [components componentsJoinedByString:separator];
}

- (id)pathFromBookmarkData:(id)arg1 stale:(BOOL *)arg2 {
    if ([arg1 length] == 0) {
        return nil;
    }
    BOOL stale;
    NSURL *url = [NSURL URLByResolvingBookmarkData:arg1
                                           options:NSURLBookmarkResolutionWithoutUI | NSURLBookmarkResolutionWithoutMounting
                                     relativeToURL:[NSURL fileURLWithPath:NSHomeDirectory()]
                               bookmarkDataIsStale:&stale
                                             error:nil];
    NSString *path = [url path];
    if ([self isFileInTrash:path]) {
        return nil;
    }
    if (arg2 != NULL && path != nil) {
        *arg2 = stale;
    }
    return path;
}

- (id)bookmarkDataFromPath:(id)arg1 {
    return [[NSURL fileURLWithPath:arg1] bookmarkDataWithOptions:0
                                  includingResourceValuesForKeys:@[]
                                                   relativeToURL:[NSURL fileURLWithPath:NSHomeDirectory()]
                                                           error:nil];
}

- (BOOL)makeWritableAtPath:(id)arg1 recursively:(BOOL)arg2 {
    NSError *error = nil;
    NSDictionary *attributes = [self attributesOfItemAtPath:arg1 error:&error];
    if (attributes == nil) {
        NSLog(@"%s: Could not obtain file attributes for %@: %@\n", __func__, arg1, error);
        return NO;
    }
    NSUInteger permissions = [attributes filePosixPermissions];
    if ((permissions & S_IWUSR) == 0) {
        NSDictionary *change = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInteger:permissions | S_IWUSR] forKey:NSFilePosixPermissions];
        if (![self setAttributes:change ofItemAtPath:arg1 error:&error]) {
            NSLog(@"%s: Could not change file attributes for %@: %@\n", __func__, arg1, error);
            return NO;
        }
    }
    if (!arg2) {
        return YES;
    }
    NSDirectoryEnumerator *enumerator = [self enumeratorAtPath:arg1];
    if (enumerator == nil) {
        NSLog(@"%s: Could not make directory enumerator for %@\n", __func__, arg1);
        return NO;
    }
    // Keep going after a failure but report only the first one.
    BOOL success = YES;
    for (NSString *relative in enumerator) {
        @autoreleasepool {
            NSUInteger childPermissions = [[enumerator fileAttributes] filePosixPermissions];
            if ((childPermissions & S_IWUSR) == 0) {
                NSString *child = [arg1 stringByAppendingPathComponent:relative];
                NSDictionary *change = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInteger:childPermissions | S_IWUSR] forKey:NSFilePosixPermissions];
                if (![self setAttributes:change ofItemAtPath:child error:&error] && success) {
                    NSLog(@"%s: Could not change file attributes for %@: %@\n", __func__, child, error);
                    success = NO;
                }
            }
        }
    }
    return success;
}

- (void)removeFolderIfEmpty:(id)arg1 upTo:(id)arg2 {
    if (![self isFile:arg1 inDirectory:arg2] || [self isSameFile:arg2 asFile:arg1]) {
        return;
    }
    NSArray *contents = [self contentsOfDirectoryAtPath:arg1 error:nil];
    if (contents == nil) {
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
    if (arg1 == nil) {
        return nil;
    }
    NSURL *url = [NSURL fileURLWithPath:arg1];
    if (url == nil) {
        return nil;
    }
    NSURL *trash = [self URLForDirectory:NSTrashDirectory inDomain:NSUserDomainMask appropriateForURL:url create:YES error:nil];
    if (trash == nil) {
        trash = [self URLForDirectory:NSTrashDirectory inDomain:NSLocalDomainMask appropriateForURL:url create:YES error:nil];
    }
    return [trash path];
}

- (BOOL)isFile:(id)arg1 inDirectory:(id)arg2 {
    if (arg1 == nil || arg2 == nil) {
        return NO;
    }
    NSURL *directory = [NSURL fileURLWithPath:arg2];
    NSDictionary *values = [directory resourceValuesForKeys:@[NSURLFileResourceIdentifierKey, NSURLIsSymbolicLinkKey] error:nil];
    id directoryID = [values objectForKey:NSURLFileResourceIdentifierKey];
    if (directoryID == nil) {
        return NO;
    }
    // A symlinked directory also matches through its target.
    id targetID = nil;
    if ([[values objectForKey:NSURLIsSymbolicLinkKey] boolValue]) {
        if (![[directory URLByResolvingSymlinksInPath] getResourceValue:&targetID forKey:NSURLFileResourceIdentifierKey error:nil]) {
            targetID = nil;
        }
    }
    NSURL *url = [NSURL fileURLWithPath:arg1];
    while (url != nil) {
        id itemID = nil;
        if (![url getResourceValue:&itemID forKey:NSURLFileResourceIdentifierKey error:nil]) {
            return NO;
        }
        if ([itemID isEqual:directoryID] || [itemID isEqual:targetID]) {
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
    NSURL *root = [NSURL fileURLWithPath:arg1];
    [root setResourceValue:[NSNull null] forKey:NSURLQuarantinePropertiesKey error:nil];
    for (NSString *relative in [[NSFileManager defaultManager] enumeratorAtPath:arg1]) {
        [[root URLByAppendingPathComponent:relative] setResourceValue:[NSNull null] forKey:NSURLQuarantinePropertiesKey error:nil];
    }
}

@end
