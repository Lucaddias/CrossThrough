// CDTools.m — CrossThrough
#import "CDTools.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CDTools

+ (BOOL)isValidInstallerVolume:(id)arg1 requireRemovable:(BOOL)arg2 {
    BOOL isDirectory = NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:arg1 isDirectory:&isDirectory] || !isDirectory) {
        NSString *application = nil;
        NSString *type = nil;
        [[NSWorkspace sharedWorkspace] getInfoForFile:arg1 application:&application type:&type];
        if ([type caseInsensitiveCompare:@"exe"] == NSOrderedSame ||
            [type caseInsensitiveCompare:@"msi"] == NSOrderedSame ||
            [type caseInsensitiveCompare:@"inf"] == NSOrderedSame) {
            return YES;
        }
    }
    if ([arg1 compare:@"/"] == NSOrderedSame) {
        return NO;
    }
    if (arg2) {
        BOOL removable = NO;
        BOOL writable = NO;
        BOOL unmountable = NO;
        NSString *description = nil;
        NSString *fileSystemType = nil;
        if ([[NSWorkspace sharedWorkspace] getFileSystemInfoForPath:arg1 isRemovable:&removable isWritable:&writable isUnmountable:&unmountable description:&description type:&fileSystemType]) {
            if (!removable) {
                return NO;
            }
            if (![fileSystemType isEqualToString:@"cd9660"] && ![fileSystemType isEqualToString:@"udf"]) {
                return NO;
            }
        }
    }
    static NSString *const installerNames[] = {
        @"autorun.inf", @"autorun.exe", @"setup.exe", @"setup.bat",
        @"install.exe", @"install.bat", @"setuppls.exe", @"setupse.exe",
    };
    for (NSString *name in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:arg1 error:nil]) {
        for (size_t i = 0; i < sizeof(installerNames) / sizeof(installerNames[0]); i++) {
            if ([name caseInsensitiveCompare:installerNames[i]] == NSOrderedSame) {
                return YES;
            }
        }
    }
    return [[self identifyInstallablePackagesForVolume:arg1] count] != 0;
}

+ (BOOL)isValidInstallerVolume:(id)arg1 {
    return [self isValidInstallerVolume:arg1 requireRemovable:NO];
}

+ (void)removeCDHelper {
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItems) {
        UInt32 seed = 0;
        NSArray *snapshot = (NSArray *)LSSharedFileListCopySnapshot(loginItems, &seed);
        for (id item in snapshot) {
            LSSharedFileListItemRef itemRef = (LSSharedFileListItemRef)item;
            CFURLRef url = LSSharedFileListItemCopyResolvedURL(itemRef, kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes, NULL);
            if (url) {
                if ([[(NSURL *)url lastPathComponent] caseInsensitiveCompare:@"CrossOver CD Helper.app"] == NSOrderedSame) {
                    LSSharedFileListItemRemove(loginItems, itemRef);
                }
                CFRelease(url);
            } else {
                CFStringRef name = LSSharedFileListItemCopyDisplayName(itemRef);
                if (name) {
                    if (CFEqual(name, CFSTR("CrossOver CD Helper"))) {
                        LSSharedFileListItemRemove(loginItems, itemRef);
                    }
                    CFRelease(name);
                }
            }
        }
        [snapshot release];
        CFRelease(loginItems);
    }
    for (NSRunningApplication *helper in [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.codeweavers.CrossOverCDHelper"]) {
        [helper terminate];
    }
}

+ (id)getListOfAppsHelpedByTheCDHelper {
    NSArray *products = [NSArray arrayWithObjects:@"CrossOver", @"CrossOverGames", nil];
    NSMutableSet *seen = [NSMutableSet setWithCapacity:[products count]];
    NSMutableArray *apps = [NSMutableArray array];
    for (NSString *product in products) {
        if ([seen containsObject:product]) {
            continue;
        }
        NSString *bundleID = [NSString stringWithFormat:@"com.codeweavers.%@", product];
        NSString *scheme = [NSString stringWithFormat:@"com.codeweavers.private-%@-app-scheme", product];
        [apps addObject:[NSDictionary dictionaryWithObjectsAndKeys:bundleID, @"BundleID", scheme, @"IdentifyingURLScheme", product, @"ProductID", nil]];
        [seen addObject:product];
    }
    return apps;
}

+ (void)removeCDHelperAndPrefsForAllInstalls {
    [CDTools removeCDHelper];
    for (NSDictionary *app in [CDTools getListOfAppsHelpedByTheCDHelper]) {
        NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
        if ([defaults persistentDomainForName:[app objectForKey:@"BundleID"]]) {
            CFStringRef bundleID = (CFStringRef)[app objectForKey:@"BundleID"];
            CFPreferencesSetAppValue(CFSTR("AutoLaunch"), NULL, bundleID);
            CFPreferencesSetAppValue(CFSTR("AutoLaunchAppID"), NULL, bundleID);
            CFPreferencesSetAppValue(CFSTR("AutoLaunchAppIdentifyingURLScheme"), NULL, bundleID);
            CFPreferencesAppSynchronize(bundleID);
        }
        [defaults release];
    }
}

+ (id)identifyInstallablePackagesForVolume:(id)arg1 {
    id profiles = [[CXSetupLib c4ProfilesClass] profilesSet];
    return [[CXSetupLib cdDetectorClass] findMatchingProfilesForVolume:arg1 inProfiles:profiles];
}

@end
