// PythonShim.h — Python C-API declarations for CrossThrough
#ifndef PythonShim_h
#define PythonShim_h

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _object PyObject;
typedef struct _is PyInterpreterState;
typedef struct _ts PyThreadState;

typedef enum { PyGILState_LOCKED, PyGILState_UNLOCKED } PyGILState_STATE;

extern int Py_NoUserSiteDirectory;
extern void Py_InitializeEx(int);
extern void Py_SetProgramName(const wchar_t *);
extern wchar_t *Py_DecodeLocale(const char *, size_t *);
extern void PyMem_RawFree(void *);
extern void PySys_SetArgvEx(int, wchar_t **, int);
extern PyObject *PyUnicode_FromString(const char *);
extern PyObject *PyImport_ImportModule(const char *);
extern int PyObject_SetAttrString(PyObject *, const char *, PyObject *);
extern int PyRun_SimpleFileExFlags(FILE *, const char *, int, void *);
extern void PyErr_Print(void);
extern PyThreadState *PyEval_SaveThread(void);
extern PyGILState_STATE PyGILState_Ensure(void);
extern void PyGILState_Release(PyGILState_STATE);
extern void _Py_Dealloc(PyObject *);

#ifdef __cplusplus
}
#endif

// Forward declare PyObjC bridge classes
@class AIETask;
@class SFAuthorization;

// Wine's Mac driver controller, present once a Wine process hosts the app.
@interface WineApplicationController : NSObject
- (BOOL)handleEvent:(id)arg1;
- (void)didSendEvent:(id)arg1;
@end

// cxinstaller bottle candidates offered for an install.
@interface TargetBottle : NSObject
- (id)getCategory;
@end

@interface RatingUtils : NSObject
- (id)initWithAppID:(id)arg1;
- (id)fetchRating;
- (id)setRating:(id)arg1 Notes:(id)arg2;
@end

@interface BottleWrapper : NSObject
- (void)disableRatingNag;
- (BOOL)isShouldNagForRatings;
- (id)appid;
- (id)name;
- (id)changeableName;
- (void)rename:(id)arg1 completionHandler:(id)arg2;
- (id)winePrefix;
- (id)systemDrive;
- (id)launchers;
- (id)controlPanels;
- (void)reloadInfo;
- (void)addStatusOverride:(id)arg1;
- (void)removeStatusOverride:(id)arg1;
- (void)removeAllStatusOverrides:(id)arg1;
- (id)fileIsInBottle:(id)arg1;
- (BOOL)isCanRunCommands;
- (void)launchControlPanelApplet:(id)arg1;
- (BOOL)isCanInstall;
- (BOOL)isCanRename;
- (BOOL)isCanForceQuit;
- (BOOL)isIsInstalledPackagesReady;
- (void)loadApplicationInfo;
- (BOOL)isIsDefault;
- (void)setIsDefault:(id)arg1 completionHandler:(id)arg2;
- (BOOL)isIsManaged;
- (BOOL)isIsDeleted;
- (BOOL)isIsBusy;
- (BOOL)isIsUsable;
- (BOOL)isIsActive;
- (BOOL)isIsDisabled;
- (BOOL)isIsUpToDate;
- (BOOL)isIsMSyncEnabled;
- (void)enableMSync;
- (void)disableMSync;
- (BOOL)isIsHighResolutionEnabled;
- (BOOL)isIsHighResolutionEnabledReady;
- (void)loadHighResolutionInfo;
- (void)enableHighResolution;
- (void)disableHighResolution;
- (BOOL)isIsPreviewEnabled;
- (void)enablePreview;
- (void)disablePreview;
- (BOOL)isIsDLSSEnabled;
- (BOOL)isIsDLSSAvailable;
- (void)enableDLSS;
- (void)disableDLSS;
- (BOOL)isIsD3DMetalEnabled;
- (BOOL)isIsD3DMetalAvailable;
- (void)setGraphicsBackendD3DMetal;
- (BOOL)isIsDXMTEnabled;
- (BOOL)isIsDXMTAvailable;
- (void)setGraphicsBackendDXMT;
- (BOOL)isIsDXVKEnabled;
- (void)setGraphicsBackendDXVK;
- (void)setGraphicsBackendWine;
- (void)setGraphicsBackendAuto;
- (BOOL)isIsMoltenVKEnabled;
- (void)setVulkanBackendMoltenVK;
- (BOOL)isIsMTLVKEnabled;
- (BOOL)isIsMTLVKAvailable;
- (void)setVulkanBackendMTLVK;
- (void)delete:(id)arg1;
- (void)quit:(id)arg1;
- (void)forceQuit:(id)arg1;
- (void)suspend;
- (void)resume;
- (id)getMissingDependenciesProfile;
- (BOOL)isIsControlPanelReady;
- (id)controlPanelTable;
- (void)loadControlPanelInfo;
- (id)currentDescription;
- (void)setCurrentDescription:(id)arg1;
- (void)writeDescription;
- (BOOL)isIsWineD3DEnabled;
- (id)installedPackages;
@end

@interface BottleCollection : NSObject
+ (id)sharedCollection;
- (id)bottleList;
- (id)bottleWithName:(id)arg1;
- (void)refresh;
- (void)refreshDefaultBottle;
- (void)addChangeDelegate:(id)arg1;
- (void)removeChangeDelegate:(id)arg1;
@end

@interface BottleManagement : NSObject
+ (id)templates;
+ (id)displayNameForTemplate:(id)arg1;
+ (id)createBottle:(id)arg1 fromTemplate:(id)arg2;
+ (id)duplicateBottle:(id)arg1 fromBottle:(id)arg2;
+ (id)restoreBottle:(id)arg1 fromArchive:(id)arg2;
+ (id)archiveBottle:(id)arg1 toPath:(id)arg2;
@end

@interface BottleQuery : NSObject
+ (id)uniqueBottleName:(id)arg1;
+ (id)isValidNewBottleName:(id)arg1;
@end

@interface CXSetup : NSObject
+ (id)bottleStatus:(id)arg1;
+ (id)bottleCategory:(id)arg1;
+ (id)dependencyReason:(id)arg1;
+ (id)dependencyOverride:(id)arg1;
@end

@interface CXUtils : NSObject
+ (id)loggingPresets;
+ (id)installerLoggingPreset;
+ (id)getLanguageValue:(id)arg1 forLanguage:(id)arg2;
+ (id)sanitizedBottleName:(id)arg1;
+ (id)cmdLineToArgv:(id)arg1;
+ (id)dirname:(id)arg1;
@end

// cxmenu: desktop and Start Menu shortcuts inside a bottle.
@interface CXMenu : NSObject
+ (id)localDesktopPath;
+ (id)localStartMenuPath;
+ (id)createShortcutForBottle:(id)arg1 command:(id)arg2 name:(id)arg3 folder:(id)arg4 localDesktopPath:(id)arg5 andStartMenuPath:(id)arg6;
@end

// systeminfo: the system report written at the top of a Wine log.
@interface SystemInfo : NSObject
+ (id)systemInformationString;
+ (id)systemInformationStringForBottle:(id)arg1;
@end

// cxinstaller: the install plan the GUI edits. PyObjC methods return
// objects, so the boolean answers arrive as NSNumber.
@interface InstallTask : NSObject
+ (id)getMissingDependencies:(id)arg1;
- (id)initWithDelegate:(id)arg1;
- (void)setDelegate:(id)arg1;
- (id)SuggestedDependencyOverrides;
- (void)addDependencyOverrides:(id)arg1 ofType:(id)arg2;
- (void)removeDependencyOverrides:(id)arg1;
- (void)ClearDependencyOverrides;
- (id)GetCreateNewBottle;
- (void)setLocale:(id)arg1;
- (void)setInstallerSource:(id)arg1 Requested:(id)arg2;
- (void)setInstallerSteam;
- (void)setInstallerDownload;
- (void)setProfile:(id)arg1;
- (id)profileLanguages;
- (id)getDependencyDetails;
- (id)getInstallerDetails;
- (id)getBottleDetails;
- (id)getLanguageDetails;
- (id)getMiscDetails;
- (void)updateProfiles;
- (id)isNewBottleNameValid:(id)arg1;
- (void)createNewBottle:(id)arg1 template:(id)arg2;
- (void)setNewBottleName:(id)arg1;
- (void)addSourceMedia:(id)arg1 withLabel:(id)arg2 andDevice:(id)arg3;
- (void)removeSourceMedia:(id)arg1;
- (id)volumeMatchesProfile:(id)arg1;
- (id)addBottle:(id)arg1;
- (void)removeBottle:(id)arg1;
- (void)installedApplicationsReady:(id)arg1;
- (void)triggerBottleAnalysis;
- (void)useAutorunFile:(id)arg1;
- (void)autoFillSettings;
@end

// cxaiengine: schedules the tasks of an InstallTask.
@interface AIEngine : NSObject
- (id)initWithInstallTask:(id)arg1 logFile:(id)arg2 channels:(id)arg3 env:(id)arg4;
@end

// Task objects scheduled on the cxinstaller engine (wrapped by TaskStatus).
@interface InstallEngineTask : NSObject
- (id)main;
- (id)canCancel;
- (void)cancel;
- (void)done;
@end

// c4profiles: the CrossTie profile database.
@interface C4Profiles : NSObject
+ (id)profilesSet;
+ (id)getOnlineFilePath;
+ (id)updateOnlineProfilesFromURL:(id)arg1;
+ (id)getMatchingProfiles:(id)arg1;
+ (id)tasteC4PFile:(id)arg1;
+ (id)prepareSingleUseC4PFile:(id)arg1;
+ (id)dropinC4PFile:(id)arg1 withSig:(id)arg2;
@end

// iconutils: downloads and caches CrossTie application icons.
@interface IconUtils : NSObject
- (id)fetchIconList;
- (id)fetchIcon:(id)arg1;
- (id)getIconPath:(id)arg1;
@end

@interface CDDetector : NSObject
+ (id)findMatchingProfilesForVolume:(id)arg1 inProfiles:(id)arg2;
@end

// demoutils: licensing and activation helpers.
@interface DemoUtils : NSObject
+ (id)createAccountRequestBodyForEmail:(id)arg1 name:(id)arg2 andPassword:(id)arg3 withSerialCode:(id)arg4;
+ (id)serialRegistrationURL;
+ (id)licenseUrlForLogin:(id)arg1 andPassword:(id)arg2;
+ (id)lastResort;
+ (id)checkLicenseDownload:(id)arg1;
+ (id)splitLicenseAndSigFromBuffer:(id)arg1;
+ (id)demoStatusForLicenseFile:(id)arg1 andSig:(id)arg2;
+ (id)checkSerialCodeRegistrationResponse:(id)arg1;
@end

// webutils: CodeWeavers web service helpers.
@interface WebUtils : NSObject
+ (id)createToken:(id)arg1 password:(id)arg2;
+ (void)updateCompatDB;
@end

// Rows of a bottle's installed-software list.
@protocol CXInstalledApplication <NSObject>
- (id)canUninstall;
- (void)uninstall;
@end

#endif /* PythonShim_h */
