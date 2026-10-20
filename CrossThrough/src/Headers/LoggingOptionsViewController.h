// LoggingOptionsViewController.h — CrossThrough
#ifndef LoggingOptionsViewController_h
#define LoggingOptionsViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class LoggingOptionsViewController;

@interface LoggingOptionsViewController : CXViewController
{
    BOOL _createLogFile;
    BOOL _enabled;
    BOOL _logFileNameFromUser;
    NSMutableArray * _channelCombos;
    NSString * _logChannels;
    NSString * _logEnvironment;
    NSString * _logFileName;
    NSURL * _logFileURL;
    NSURL * _logDirectoryURL;
    NSPopUpButton * _channelPresets;
    NSMenuItem * _recentChannelsDivider;
    NSMenuItem * _recentChannelsMenuItem;
}

// Class Methods
+ (id)keyPathsForValuesAffectingEnableControls;

// Instance Methods
- (id)initWithLogFileName:(id)arg1;
- (void)viewDidLoad;
- (void)updateLogFileURL;
- (void)setLogFileName:(id)arg1;
- (void)selectLogFile:(id)arg1;
- (void)clearLoggingChannels:(id)arg1;
- (id)combineChannels:(id)arg1 with:(id)arg2 andDelimiter:(id)arg3;
- (void)addLoggingChannels:(id)arg1;
- (void)addExtraEnvVariables:(id)arg1;
- (BOOL)enableControls;
- (void)sanitizeLogChannels;
- (void)saveSettingsToRecent;
- (void)updateRecentMenuItems;
- (void)restoreRecent:(id)arg1;
- (BOOL)createLogFile;
- (void)setCreateLogFile:(BOOL)arg1;
- (BOOL)enabled;
- (void)setEnabled:(BOOL)arg1;
- (id)channelCombos;
- (void)setChannelCombos:(id)arg1;
- (id)logChannels;
- (void)setLogChannels:(id)arg1;
- (id)logEnvironment;
- (void)setLogEnvironment:(id)arg1;
- (id)logFileName;
- (id)logFileURL;
- (void)setLogFileURL:(id)arg1;
- (id)logDirectoryURL;
- (void)setLogDirectoryURL:(id)arg1;
- (BOOL)logFileNameFromUser;
- (void)setLogFileNameFromUser:(BOOL)arg1;
- (id)channelPresets;
- (void)setChannelPresets:(id)arg1;
- (id)recentChannelsDivider;
- (void)setRecentChannelsDivider:(id)arg1;
- (id)recentChannelsMenuItem;
- (void)setRecentChannelsMenuItem:(id)arg1;

@end

#endif /* LoggingOptionsViewController_h */
