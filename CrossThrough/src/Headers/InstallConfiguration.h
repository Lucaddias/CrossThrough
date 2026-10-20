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
- (void)setInstallerLocale:(id)arg1;
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
- (id)environment;
- (void)setEnvironment:(id)arg1;
- (id)logChannels;
- (void)setLogChannels:(id)arg1;
- (id)logEnvironment;
- (void)setLogEnvironment:(id)arg1;
- (id)logFileURL;
- (void)setLogFileURL:(id)arg1;
- (id)selectedPackage;
- (id)bottleCollection;

@end

#endif /* InstallConfiguration_h */
