// CrossThroughProtocols.h — Custom Protocols
#ifndef CrossThroughProtocols_h
#define CrossThroughProtocols_h

#import <Cocoa/Cocoa.h>

@protocol BottleCollectionDelegate;
@protocol CXDragViewDelegate;
@protocol CXUpdaterDelegate;
@protocol CrossTieURLHandlerDelegate;
@protocol HelperServer;
@protocol IconCollectionViewControllerDelegate;
@protocol InstallConfigurationDelegate;
@protocol PackageInstallerDelegate;
@protocol PackageViewDelegate;

@protocol BottleCollectionDelegate <NSObject>
@optional
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

@protocol CrossTieURLHandlerDelegate <NSObject>
@optional
- (void)crossTieURLDidFinish:(id)arg1;
@end

// Vended over Distributed Objects as com.codeweavers.CrossOver.HelperServer.
@protocol HelperServer <NSObject>
- (bycopy id)getEnvironmentForXConnection;
- (BOOL)isServerReady;
- (BOOL)isServerReadyForBottle:(id)arg1;
- (oneway void)raiseWindowsWithTag:(NSInteger)arg1;
@end

@protocol IconCollectionViewControllerDelegate <NSObject>
@optional
@end

@protocol InstallConfigurationDelegate <NSObject>
@optional
@end

@protocol PackageInstallerDelegate <NSObject>
@optional
@end

@protocol PackageViewDelegate <NSObject>
@optional
@end

#endif /* CrossThroughProtocols_h */