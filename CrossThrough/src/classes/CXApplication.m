// CXApplication.m — CrossThrough
// Ported from CrossOver 26.3 arm64 (0x10001cec4..0x10001e330).
#import "CXApplication.h"
#import "CrossThrough.h"
#import "c_functions.h"

@implementation CXApplication

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

- (id)init {
    self = [super init];
    if (self) {
        crossOverRoot = [[[NSBundle mainBundle] sharedSupportPath] stringByAppendingPathComponent:@"CrossOver"];
        crossOverRootURL = [[[NSBundle mainBundle] sharedSupportURL] URLByAppendingPathComponent:@"CrossOver" isDirectory:YES];
    }
    return self;
}

- (void)setDelegate:(id)arg1 {
    [self setCXServer:arg1];
    [super setDelegate:arg1];
}

- (id)crossOverRoot {
    return crossOverRoot;
}

- (id)crossOverRootURL {
    return crossOverRootURL;
}

- (BOOL)isDemo {
    return isDemo;
}

// License files are looked up as <Library>/Preferences/com.codeweavers.CrossOver.license
// with a .sha256 signature (or the older .sig) next to it, first in the user
// domain and then in the local domain. DemoUtils returns, for each file,
// @[isDemo, registeredTo, expirationDate (yyyy/MM/dd, US Central), licenseID, revoked].
static NSURL *LicenseSignatureURL(NSURL *preferences) {
    NSURL *sig = [preferences URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@.sha256", @"com.codeweavers", @"CrossOver"] isDirectory:NO];
    if (![sig checkResourceIsReachableAndReturnError:nil]) {
        sig = [preferences URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@.sig", @"com.codeweavers", @"CrossOver"] isDirectory:NO];
    }
    return sig;
}

- (void)setIsDemo {
    NSArray *libraries = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask | NSLocalDomainMask];
    if ([libraries count] < 2) {
        NSLog(@"Failed to retrieve Library directories.\n");
        return;
    }
    NSURL *localPreferences = [[libraries objectAtIndexedSubscript:0] URLByAppendingPathComponent:@"Preferences" isDirectory:YES];
    if (localPreferences == nil) {
        NSLog(@"Failed to locate the local Preferences directory.\n");
        return;
    }
    NSURL *localLicense = [localPreferences URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@.license", @"com.codeweavers", @"CrossOver"] isDirectory:NO];
    NSURL *localSig = LicenseSignatureURL(localPreferences);

    NSURL *globalPreferences = [[libraries objectAtIndexedSubscript:1] URLByAppendingPathComponent:@"Preferences" isDirectory:YES];
    if (globalPreferences == nil) {
        NSLog(@"Failed to locate the global Preferences directory.\n");
        return;
    }
    NSURL *globalLicense = [globalPreferences URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@.license", @"com.codeweavers", @"CrossOver"] isDirectory:NO];
    NSURL *globalSig = LicenseSignatureURL(globalPreferences);

    Class demoUtils = [CXSetupLib demoUtilsClass];
    NSArray *localStatus = [demoUtils demoStatusForLicenseFile:[localLicense stringWithFileSystemRepresentation]
                                                        andSig:[localSig stringWithFileSystemRepresentation]];
    NSArray *globalStatus = [demoUtils demoStatusForLicenseFile:[globalLicense stringWithFileSystemRepresentation]
                                                         andSig:[globalSig stringWithFileSystemRepresentation]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Chicago"]];
    [formatter setDateFormat:@"yyyy/MM/dd"];

    BOOL localIsDemo = [[localStatus objectAtIndex:0] boolValue];
    BOOL globalIsDemo = [[globalStatus objectAtIndex:0] boolValue];

    // Prefer a registered license; when both are registered, the one that
    // expires later wins.
    NSArray *license = nil;
    if (!localIsDemo && !globalIsDemo) {
        NSDate *localExpiration = [formatter dateFromString:[localStatus objectAtIndex:2]];
        NSDate *globalExpiration = [formatter dateFromString:[globalStatus objectAtIndex:2]];
        license = ([localExpiration compare:globalExpiration] == NSOrderedAscending) ? globalStatus : localStatus;
    } else if (!localIsDemo) {
        license = localStatus;
    } else if (!globalIsDemo) {
        license = globalStatus;
    }

    if (license != nil) {
        isDemo = NO;
        NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"Registered to: %@" value:@"" table:nil];
        [self setDemoString:[NSString stringWithFormat:format, [license objectAtIndex:1]]];
        [self setLicenseExpirationDate:[formatter dateFromString:[license objectAtIndex:2]]];
        [self setLicenseID:[license objectAtIndex:3]];
        if (registerMenuItem != nil && [registerMenuItem menu] != nil) {
            [[registerMenuItem menu] removeItem:registerMenuItem];
            registerMenuItem = nil;
        }
        return;
    }

    isDemo = YES;
    BOOL revoked = (localStatus != nil && [[localStatus objectAtIndex:4] boolValue]) ||
                   (globalStatus != nil && [[globalStatus objectAtIndex:4] boolValue]);
    if (revoked) {
        NSLog(@"Revoke!\n");
        daysLeft = 0;
    }
    if (daysLeft > 0) {
        NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"This demo version will expire in %d days." value:@"" table:nil];
        [self setDemoString:[NSString stringWithFormat:format, daysLeft]];
    } else {
        [self setDemoString:[[NSBundle mainBundle] localizedStringForKey:@"This demo version has expired." value:@"" table:nil]];
    }
}

- (NSInteger)daysLeft {
    return daysLeft;
}

- (void)setDaysLeft {
    NSDate *firstRun = [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstRunDate"];
    if (firstRun != nil) {
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
        NSDateComponents *elapsed = [calendar components:NSCalendarUnitDay fromDate:firstRun toDate:[NSDate date] options:0];
        int left = 14 - (int)[elapsed day];
        daysLeft = left < 0 ? 0 : left;
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"FirstRunDate"];
        daysLeft = 14;
    }
}

- (void)orderFrontStandardAboutPanel:(id)arg1 {
    // CROSSOVER_STANDARD is "0" in the shipped build, so this always takes the
    // default path.
    if ([@"1" isEqualToString:@"0"]) {
        NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"%@ Standard" value:@"" table:nil];
        NSString *name = [NSString stringWithFormat:format, @"CrossOver"];
        [self orderFrontStandardAboutPanelWithOptions:[NSDictionary dictionaryWithObject:name forKey:@"ApplicationName"]];
    } else {
        [super orderFrontStandardAboutPanel:nil];
    }
}

- (void)reportException:(id)arg1 {
    _CXLog(@"%@", [arg1 debugDescription]);
    [super reportException:arg1];
}

// NSApplication notifications forwarded to the in-process Wine controller,
// paired with the NSApplicationDelegate selector each one maps to.
static const struct {
    NSNotificationName __unsafe_unretained *name;
    SEL selector;
} kWineControllerNotifications[] = {
    { &NSApplicationDidBecomeActiveNotification, @selector(applicationDidBecomeActive:) },
    { &NSApplicationDidChangeScreenParametersNotification, @selector(applicationDidChangeScreenParameters:) },
    { &NSApplicationDidFinishLaunchingNotification, @selector(applicationDidFinishLaunching:) },
    { &NSApplicationDidHideNotification, @selector(applicationDidHide:) },
    { &NSApplicationDidResignActiveNotification, @selector(applicationDidResignActive:) },
    { &NSApplicationDidUnhideNotification, @selector(applicationDidUnhide:) },
    { &NSApplicationDidUpdateNotification, @selector(applicationDidUpdate:) },
    { &NSApplicationWillBecomeActiveNotification, @selector(applicationWillBecomeActive:) },
    { &NSApplicationWillFinishLaunchingNotification, @selector(applicationWillFinishLaunching:) },
    { &NSApplicationWillHideNotification, @selector(applicationWillHide:) },
    { &NSApplicationWillResignActiveNotification, @selector(applicationWillResignActive:) },
    { &NSApplicationWillTerminateNotification, @selector(applicationWillTerminate:) },
    { &NSApplicationWillUnhideNotification, @selector(applicationWillUnhide:) },
    { &NSApplicationWillUpdateNotification, @selector(applicationWillUpdate:) },
};

- (void)setWineController:(id)arg1 {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    size_t count = sizeof(kWineControllerNotifications) / sizeof(kWineControllerNotifications[0]);
    id old = _wineController;
    if (old != nil) {
        for (size_t i = 0; i < count; i++) {
            if ([old respondsToSelector:kWineControllerNotifications[i].selector]) {
                [center removeObserver:old name:*kWineControllerNotifications[i].name object:self];
            }
        }
    }
    _wineController = arg1;
    if (arg1 != nil) {
        for (size_t i = 0; i < count; i++) {
            if ([arg1 respondsToSelector:kWineControllerNotifications[i].selector]) {
                [center addObserver:arg1 selector:kWineControllerNotifications[i].selector name:*kWineControllerNotifications[i].name object:self];
            }
        }
    }
}

- (void)sendEvent:(id)arg1 {
    id<WineApplicationController> controller = _wineController;
    if (![controller handleEvent:arg1]) {
        [super sendEvent:arg1];
        [_wineController didSendEvent:arg1];
    }
}

- (id)licenseID {
    return _licenseID;
}

- (void)setLicenseID:(id)arg1 {
    _licenseID = arg1;
}

- (id)licenseExpirationDate {
    return _licenseExpirationDate;
}

- (void)setLicenseExpirationDate:(id)arg1 {
    _licenseExpirationDate = arg1;
}

- (id)wineController {
    return _wineController;
}

- (id)demoString {
    return _demoString;
}

- (void)setDemoString:(id)arg1 {
    _demoString = arg1;
}

- (id)CXServer {
    return _CXServer;
}

- (void)setCXServer:(id)arg1 {
    _CXServer = arg1;
}

@end
