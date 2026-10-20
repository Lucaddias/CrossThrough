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
@class TargetBottle;
@class SFAuthorization;

@interface WineApplicationController : NSObject
- (BOOL)handleEvent:(NSEvent *)event;
- (void)didSendEvent:(NSEvent *)event;
@end

@interface RatingUtils : NSObject
- (id)initWithAppID:(id)arg1;
- (id)fetchRating;
- (id)setRating:(id)arg1 Notes:(id)arg2;
@end

@interface TargetBottle : NSObject
- (id)getCategory;
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
- (BOOL)isCanInstall;
- (BOOL)isCanRename;
- (BOOL)isCanForceQuit;
- (BOOL)isIsInstalledPackagesReady;
- (void)loadApplicationInfo;
- (BOOL)isIsDefault;
- (BOOL)isDefault;
- (id)installedPackages;
- (id)getCategory;
- (id)currentDescription;
- (void)setCurrentDescription:(id)desc;
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
- (id)getMissingDependenciesProfile;
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

@interface IconUtils : NSObject
- (void)fetchIconList;
- (void)fetchIcon:(id)arg1;
- (id)getIconPath:(id)arg1;
@end

@interface NSObject (CXDynamicClassMethods)
+ (id)profilesSet;
+ (id)getMatchingProfiles:(id)arg1;
+ (id)getOnlineFilePath;
+ (id)updateOnlineProfilesFromURL:(id)arg1;
+ (id)tasteC4PFile:(id)arg1;
+ (id)prepareSingleUseC4PFile:(id)arg1;
+ (id)dropinC4PFile:(id)arg1 withSig:(id)arg2;

+ (id)localStartMenuPath;
+ (id)localDesktopPath;
+ (id)createShortcutForBottle:(id)arg1 command:(id)arg2 name:(id)arg3 folder:(id)arg4 localDesktopPath:(id)arg5 andStartMenuPath:(id)arg6;

+ (id)sanitizedBottleName:(id)arg1;
+ (id)cmdLineToArgv:(id)arg1;
+ (id)basename:(id)arg1;
+ (id)dirname:(id)arg1;
+ (id)getLanguageValue:(id)arg1 forLanguage:(id)arg2;
+ (id)installerLoggingPreset;
+ (id)loggingPresets;

+ (id)systemInformationString;
+ (id)systemInformationStringForBottle:(id)arg1;

+ (id)bottleStatus:(id)arg1;
+ (id)bottleCategory:(id)arg1;
+ (id)dependencyReason:(id)arg1;
+ (id)dependencyOverride:(id)arg1;
+ (void)setEnvValue:(id)arg1 forKey:(id)arg2;
+ (void)unsetEnvValueForKey:(id)arg1;
@end

@interface InstallTask : NSObject
- (id)initWithDelegate:(id)arg1;
- (void)setDelegate:(id)delegate;
- (id)delegate;
- (void)setLocale:(id)locale;
- (void)setInstallerSource:(id)source Requested:(id)requested;
- (void)setInstallerSteam;
- (void)setInstallerDownload;
- (void)setProfile:(id)profile;
- (id)profileLanguages;
- (id)getDependencyDetails;
- (id)getInstallerDetails;
- (id)getBottleDetails;
- (id)getLanguageDetails;
- (id)getMiscDetails;
- (void)updateProfiles;
- (BOOL)isNewBottleNameValid:(id)name;
- (void)createNewBottle:(id)name template:(id)tmpl;
- (void)setNewBottleName:(id)name;
- (void)addSourceMedia:(id)media withLabel:(id)label andDevice:(id)dev;
- (void)removeSourceMedia:(id)media;
- (BOOL)volumeMatchesProfile:(id)vol;
- (id)addBottle:(id)bottle;
- (void)removeBottle:(id)bottle;
- (void)installedApplicationsReady:(id)apps;
- (void)triggerBottleAnalysis;
- (void)useAutorunFile:(id)file;
- (void)autoFillSettings;
- (id)GetCreateNewBottle;
- (void)addDependencyOverrides:(id)overrides ofType:(id)type;
- (void)removeDependencyOverrides:(id)overrides;
- (void)ClearDependencyOverrides;
- (id)SuggestedDependencyOverrides;
@end

@interface Engine : NSObject
- (id)initWithInstallTask:(id)task logFile:(id)log channels:(id)chan env:(id)env;
@end

#endif /* PythonShim_h */
