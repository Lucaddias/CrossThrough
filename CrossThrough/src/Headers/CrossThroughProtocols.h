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
@optional
@end

@protocol CXUpdaterDelegate <NSObject>
@optional
@end

@protocol CrossTieURLHandlerDelegate <NSObject>
@optional
@end

@protocol HelperServer <NSObject>
@optional
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