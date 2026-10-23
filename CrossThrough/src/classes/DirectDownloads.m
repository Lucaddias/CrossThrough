// DirectDownloads.m — CrossThrough
#import "DirectDownloads.h"

// Maintained by hand. A key matches any URL that starts with it (the
// redirects add a language suffix such as /en). Only add entries whose
// direct URL serves a file the profile's downloadglob accepts.
NSDictionary *CTDirectDownloadMap(void) {
    static NSDictionary *map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = [@{
            // Steam: the profile accepts SteamInstall.msi or SteamSetup.exe.
            @"http://crossover.codeweavers.com/redirect/steamMSI":
                @"https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe",
        } retain];
    });
    return map;
}

NSString *CTDirectDownloadURL(NSString *url) {
    if (![url isKindOfClass:[NSString class]]) {
        return url;
    }
    NSDictionary *map = CTDirectDownloadMap();
    for (NSString *prefix in map) {
        if ([url hasPrefix:prefix]) {
            return [map objectForKey:prefix];
        }
    }
    return url;
}

// The profile's URL tables are Python dicts bridged as mutable dictionaries,
// so setting a key updates what the install engine reads.
static void rewrite(id urls) {
    if (![urls isKindOfClass:[NSMutableDictionary class]]) {
        return;
    }
    for (id lang in [urls allKeys]) {
        NSString *url = [urls objectForKey:lang];
        NSString *direct = CTDirectDownloadURL(url);
        if (direct != url) {
            [urls setObject:direct forKey:lang];
        }
    }
}

void CTApplyDirectDownloads(NSDictionary *profiles) {
    for (id appid in profiles) {
        id profile = [profiles objectForKey:appid];
        @try {
            rewrite([profile valueForKeyPath:@"app_profile.download_urls"]);
            rewrite([profile valueForKeyPath:@"app_profile.download_urls_64bit"]);
        } @catch (NSException *exception) {
            // Profiles without an app profile have nothing to rewrite.
        }
    }
}
