// SparkleShim.h — Sparkle declarations for CrossThrough
#ifndef SparkleShim_h
#define SparkleShim_h

#import <Cocoa/Cocoa.h>

@protocol SPUStandardUserDriverDelegate <NSObject>
@end

@protocol SPUUpdaterDelegate <NSObject>
@end

@interface SPUStandardUserDriver : NSObject
@end

@interface SPUUpdater : NSObject
@property (weak) id<SPUUpdaterDelegate> delegate;
- (void)checkForUpdates;
@end

@interface SUAppcastItem : NSObject
@property (copy, readonly) NSString *versionString;
@property (copy, readonly) NSString *displayVersionString;
@end

@interface SUStandardVersionComparator : NSObject
+ (SUStandardVersionComparator *)defaultComparator;
- (NSComparisonResult)compareVersion:(NSString *)versionA toVersion:(NSString *)versionB;
@end

#endif /* SparkleShim_h */
