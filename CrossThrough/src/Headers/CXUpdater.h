// CXUpdater.h — CrossThrough
#ifndef CXUpdater_h
#define CXUpdater_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXUpdater;
@class CXSparkleUserDriver;

@interface CXUpdater : NSObject <SPUUpdaterDelegate, NSObject, SPUStandardUserDriverDelegate>
{
    SPUUpdater * _updater;
    CXSparkleUserDriver * _userDriver;
    BOOL _delayShowingUserUpdate;
    id<CXUpdaterDelegate> _delegate;
    CGFloat _updateCheckInterval;
}

// Class Methods
+ (CXUpdater *)sharedUpdater;
+ (id)updaterForBundle:(id)arg1;

// Instance Methods
- (id)initForBundle:(id)arg1;
- (id)init;
- (void)setUserAgentString;
- (BOOL)automaticallyChecksForUpdates;
- (void)setAutomaticallyChecksForUpdates:(BOOL)arg1;
- (CGFloat)updateCheckInterval;
- (void)checkForUpdates:(id)arg1;
- (BOOL)validateMenuItem:(id)arg1;
- (void)checkForUpdatesInBackground;
- (id)lastUpdateCheckDate;
- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2;
- (void)updaterDidNotFindUpdate:(id)arg1;
- (void)updater:(id)arg1 didAbortWithError:(id)arg2;
- (void)updater:(id)arg1 userDidMakeChoice:(NSInteger)arg2 forUpdate:(id)arg3 state:(id)arg4;
- (void)updater:(id)arg1 failedToDownloadUpdate:(id)arg2 error:(id)arg3;
- (void)userDidCancelDownload:(id)arg1;
- (void)setNotLicensed:(BOOL)arg1;
- (void)standardUserDriverWillHandleShowingUpdate:(BOOL)arg1 forUpdate:(id)arg2 state:(id)arg3;
- (void)standardUserDriverWillFinishUpdateSession;
- (id)delegate;
- (void)setDelegate:(id)arg1;
- (void)setUpdateCheckInterval:(CGFloat)arg1;

@end

#endif /* CXUpdater_h */
