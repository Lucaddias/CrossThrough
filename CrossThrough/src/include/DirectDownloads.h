// DirectDownloads.h — replaces download redirects in the installer profiles
// with the vendors' own URLs, so those installs no longer depend on the
// recipe provider's redirect server.
#ifndef DirectDownloads_h
#define DirectDownloads_h

#import <Foundation/Foundation.h>

// The redirect URL prefix → direct URL table (see DirectDownloads.m).
NSDictionary *CTDirectDownloadMap(void);

// Returns the direct URL for url, or url itself when it is not mapped.
NSString *CTDirectDownloadURL(NSString *url);

// Rewrites download_urls and download_urls_64bit of every profile in
// profiles (appid → profile, as C4ProfilesSet.contentsDict returns them).
void CTApplyDirectDownloads(NSDictionary *profiles);

#endif /* DirectDownloads_h */
