// SparkleShim.h — Sparkle declarations for CrossThrough
#ifndef SparkleShim_h
#define SparkleShim_h

#import <Cocoa/Cocoa.h>

@protocol SPUStandardUserDriverDelegate <NSObject>
@end

@protocol SPUUpdaterDelegate <NSObject>
@end

typedef NS_ENUM(NSInteger, SPUUserUpdateChoice) {
    SPUUserUpdateChoiceSkip,
    SPUUserUpdateChoiceInstall,
    SPUUserUpdateChoiceDismiss,
};

@interface SPUStandardUserDriver : NSObject
- (instancetype)initWithHostBundle:(NSBundle *)hostBundle delegate:(id<SPUStandardUserDriverDelegate>)delegate;
- (void)showUpdateFoundWithAppcastItem:(id)appcastItem state:(id)state reply:(void (^)(SPUUserUpdateChoice))reply;
@end

@interface SPUUpdater : NSObject
@property (weak) id<SPUUpdaterDelegate> delegate;
@property (nonatomic) BOOL automaticallyChecksForUpdates;
@property (nonatomic) NSTimeInterval updateCheckInterval;
@property (nonatomic, readonly) BOOL canCheckForUpdates;
@property (nonatomic, readonly, copy) NSDate *lastUpdateCheckDate;
@property (nonatomic, copy) NSString *userAgentString;
- (instancetype)initWithHostBundle:(NSBundle *)hostBundle applicationBundle:(NSBundle *)applicationBundle userDriver:(id)userDriver delegate:(id<SPUUpdaterDelegate>)delegate;
- (BOOL)startUpdater:(NSError **)error;
- (void)checkForUpdates;
- (void)checkForUpdatesInBackground;
@end

@interface SUAppcastItem : NSObject
@property (copy, readonly) NSString *versionString;
@property (copy, readonly) NSString *displayVersionString;
@property (copy, readonly) NSDate *date;
@property (copy, readonly) NSString *itemDescription;
@property (strong, readonly) NSURL *releaseNotesURL;
@end

@interface SUStandardVersionComparator : NSObject
+ (SUStandardVersionComparator *)defaultComparator;
- (NSComparisonResult)compareVersion:(NSString *)versionA toVersion:(NSString *)versionB;
@end

#endif /* SparkleShim_h */
