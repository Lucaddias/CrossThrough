// InstallConfiguration.h — CrossThrough
#ifndef InstallConfiguration_h
#define InstallConfiguration_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class InstallConfiguration;
@class PackageTreeNode;

@interface InstallConfiguration : CXObject
{
    InstallTask * _installTask;
    NSMutableArray * _delegates;
    NSString * _environment;
    NSString * _logChannels;
    NSString * _logEnvironment;
    NSURL * _logFileURL;
    PackageTreeNode * _selectedPackage;
    BottleCollection * _bottleCollection;
}

@property (nonatomic, copy) NSString *bottleName;
@property (nonatomic, readonly, copy) NSDictionary *bottles;
@property (nonatomic, readonly) BOOL newBottleCollidesWithExistingBottle;
@property (nonatomic, readonly) BOOL hasBottle;
@property (nonatomic, readonly) BOOL hasInstallerSource;
@property (nonatomic, readonly) BOOL hasPackage;
@property (nonatomic, readonly) BOOL bottleIsCompatibleWithPackage;
@property (nonatomic, readonly) BOOL creatingNewBottle;
@property (nonatomic, readonly, copy) NSDictionary *dependencyOverrides;
@property (nonatomic, readonly, copy) NSString *downloadURL;
@property (nonatomic, readonly, copy) NSString *installationNotes;
@property (nonatomic, readonly, copy) NSString *installerDownloadSource;
@property (nonatomic, copy) NSString *installerLocale;
@property (nonatomic, readonly, copy) NSString *installerSource;
@property (nonatomic, readonly) BOOL installWithSteam;
@property (nonatomic, copy) NSString *environment;
@property (nonatomic, copy) NSString *logChannels;
@property (nonatomic, copy) NSString *logEnvironment;
@property (nonatomic, readonly, copy) NSString *logFileName;
@property (nonatomic, copy) NSURL *logFileURL;
@property (nonatomic, readonly, copy) NSString *nameForNewBottle;
@property (nonatomic, readonly, copy) NSString *postInstallURL;
@property (nonatomic, readonly) id profile;
@property (nonatomic, readonly, copy) NSArray *profileLanguages;
@property (nonatomic, readonly) PackageTreeNode *selectedPackage;
@property (nonatomic, readonly, copy) NSString *steamID;
@property (nonatomic, readonly) id targetBottle;
@property (nonatomic, readonly, copy) NSDictionary *templates;
@property (nonatomic, readonly, getter=isVirtual) BOOL virtual;
@property (nonatomic, readonly) BOOL is64bit;
@property (nonatomic, readonly, copy) NSDictionary *dependencyDetails;
@property (nonatomic, readonly, copy) NSDictionary *installerDetails;
@property (nonatomic, readonly, copy) NSDictionary *bottleDetails;
@property (nonatomic, readonly, copy) NSDictionary *languageDetails;
@property (nonatomic, readonly, copy) NSDictionary *miscDetails;

// Class Methods
+ (BOOL)automaticallyNotifiesObserversOfSelectedPackage;
+ (BOOL)resolveInstanceMethod:(SEL)arg1;
+ (id)reasonMain;
+ (id)reasonSteam;
+ (id)reasonOverride;
+ (id)reasonDependency;
+ (id)overrideExclude;
+ (id)overrideInclude;

// Instance Methods
- (id)init;
- (void)dealloc;
- (BOOL)newBottleCollidesWithExistingBottle;
- (BOOL)hasBottle;
- (BOOL)hasInstallerSource;
- (BOOL)hasPackage;
- (BOOL)bottleIsCompatibleWithPackage;
- (BOOL)creatingNewBottle;
- (void)setInstallerLocale:(NSString *)arg1;
- (void)setInstallerSource:(id)arg1 forUser:(BOOL)arg2;
- (void)setInstallerSteam;
- (void)setInstallerDownload;
- (void)setProfile:(id)arg1;
- (void)setSelectedPackage:(id)arg1 forUser:(BOOL)arg2;
- (id)profileLanguages;
- (id)dependencyDetails;
- (id)installerDetails;
- (id)bottleDetails;
- (id)languageDetails;
- (id)miscDetails;
- (void)updateProfiles;
- (BOOL)isNewBottleNameValid:(id)arg1;
- (void)createNewBottle:(id)arg1 template:(id)arg2;
- (void)setNewBottleName:(id)arg1;
- (void)addSourceMedia:(id)arg1 withLabel:(id)arg2 andDevice:(id)arg3;
- (void)addSourceMedia:(id)arg1;
- (void)removeSourceMedia:(id)arg1;
- (BOOL)volumeMatchesProfile:(id)arg1;
- (id)profiles;
- (id)profileForAppID:(id)arg1;
- (id)nameForProfileWithAppID:(id)arg1;
- (id)addBottle:(id)arg1;
- (void)removeBottle:(id)arg1;
- (void)installedApplicationsReady:(id)arg1;
- (void)triggerBottleAnalysis;
- (id)recommendedTemplate;
- (void)useAutorunFile:(id)arg1;
- (void)autoFillSettings;
- (id)logFileName;
- (id)newInstallEngine;
- (void)addDelegate:(id)arg1;
- (void)removeDelegate:(id)arg1;
- (void)forwardDelegateMethod:(SEL)arg1;
- (void)forwardDelegateMethod:(SEL)arg1 withObject:(id)arg2;
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
- (id)installTask;
- (id)delegates;
- (void)setDelegates:(id)arg1;
- (NSString *)environment;
- (void)setEnvironment:(NSString *)arg1;
- (NSString *)logChannels;
- (void)setLogChannels:(NSString *)arg1;
- (NSString *)logEnvironment;
- (void)setLogEnvironment:(NSString *)arg1;
- (NSURL *)logFileURL;
- (void)setLogFileURL:(NSURL *)arg1;
- (id)selectedPackage;
- (id)bottleCollection;

@end

#endif /* InstallConfiguration_h */
