// PreferencesController.h — CrossThrough
#ifndef PreferencesController_h
#define PreferencesController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class PreferencesController;

@interface PreferencesController : CXWindowController <NSOpenSavePanelDelegate, NSObject>
{
    id _installersCache;
    FSEventStreamRef _fsEventStream;
    NSTextField * _installerCacheSizeLabel;
    id _lastUpdated;
}

// Instance Methods
- (id)init;
- (void)dealloc;
- (void)windowDidLoad;
- (void)updateC4PModDate;
- (void)windowWillLoad;
- (void)bottlesFolderChanged:(id)arg1;
- (void)resetBottlesFolder:(id)arg1;
- (void)browseForBottlesFolder:(id)arg1;
- (void)programsFolderChanged:(id)arg1;
- (void)resetProgramsFolder:(id)arg1;
- (void)browseForProgramsFolder:(id)arg1;
- (BOOL)panel:(id)arg1 isValidFilename:(id)arg2;
- (id)installerCacheSizeStringWhileCalculating;
- (void)enumerateCachedInstallersWithBlock:(id)arg1;
- (void)calculateInstallerCacheSize;
- (void)installersCacheEventStreamCallback;
- (void)clearInstallerCache:(id)arg1;
- (void)openInstallerCache:(id)arg1;
- (id)installerCacheSizeLabel;
- (void)setInstallerCacheSizeLabel:(id)arg1;
- (id)bottlesFolderURL;
- (void)setBottlesFolderURL:(id)arg1;
- (id)programsFolderURL;
- (void)setProgramsFolderURL:(id)arg1;
- (id)lastUpdated;
- (void)setLastUpdated:(id)arg1;

@end

#endif /* PreferencesController_h */
