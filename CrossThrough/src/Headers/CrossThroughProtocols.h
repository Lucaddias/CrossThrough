// CrossThroughProtocols.h — Custom Protocols
// Method lists and type encodings come from __objc_protolist of the arm64
// slice (otool -ov). CrossTieURLHandlerDelegate is not emitted in the binary's
// protocol list, so it stays without requirements.
#ifndef CrossThroughProtocols_h
#define CrossThroughProtocols_h

#import <Cocoa/Cocoa.h>

@protocol BottleCollectionDelegate <NSObject>
- (void)bottleCollectionChanged;
@end

@protocol CXDragViewDelegate <NSObject>
- (BOOL)performDragOperation:(id)arg1;
@end

@protocol CXUpdaterDelegate <NSObject>
@optional
- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2;
- (void)updaterDidNotFindUpdate:(id)arg1;
- (void)updaterDidAbortWithError:(id)arg1 error:(id)arg2;
- (void)updater:(id)arg1 userDidSkipThisVersion:(id)arg2;
- (void)updater:(id)arg1 failedToDownloadUpdate:(id)arg2 error:(id)arg3;
- (void)userDidCancelDownload:(id)arg1;
@end

@protocol HelperServer <NSObject>
- (id)getEnvironmentForXConnection;
- (BOOL)isServerReady;
- (BOOL)isServerReadyForBottle:(id)arg1;
- (oneway void)raiseWindowsWithTag:(NSInteger)arg1;
@end

@protocol IconCollectionViewControllerDelegate <NSObject>
- (void)iconCollectionViewControllerSelectionChanged:(id)arg1;
@end

@protocol InstallConfigurationDelegate <NSObject>
@optional
- (void)profileMediaAdded:(id)arg1;
- (void)profileMediaRemoved:(id)arg1;
- (void)profileChanged;
- (void)sourceChanged;
- (void)bottleCreateChanged;
- (void)bottleNewnameChanged;
- (void)bottleTemplateChanged;
- (void)bottleNameChanged;
- (void)categorizedBottle:(id)arg1;
- (void)categorizedAllBottles;
- (void)analyzedBottle:(id)arg1;
@end

@protocol PackageInstallerDelegate <NSObject>
- (id)window;
- (void)installationStarted;
- (void)installationCompleted;
@end

@protocol PackageViewDelegate <NSObject>
- (void)revealNewBottle:(id)arg1;
- (void)selectInstallView;
@end

@protocol CrossTieURLHandlerDelegate <NSObject>
@optional
@end

#endif /* CrossThroughProtocols_h */
