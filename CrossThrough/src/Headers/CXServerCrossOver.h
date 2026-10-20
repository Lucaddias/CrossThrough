// CXServerCrossOver.h — CrossThrough
#ifndef CXServerCrossOver_h
#define CXServerCrossOver_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXServer.h"

@class CXServerCrossOver;
@class MainWindowController;
@class PreferencesController;
@class CrossTieURLHandler;

@interface CXServerCrossOver : CXServer <CXUpdaterDelegate, NSObject, BottleCollectionDelegate>
{
    NSUserDefaults * dockPrefs;
    MainWindowController * mainWindowController;
    PreferencesController * preferencesController;
    NSDate * programsMenuUpdateDate;
    id associationsLock;
    NSMutableSet * helpersToDelete;
    NSDictionary * associationPlist;
    NSDate * associationPlistDate;
    NSDictionary * relateDocTypesToMenus;
    BOOL refreshProgramsUpdateIsForced;
    BOOL refreshProgramsCreateIsForced;
    BOOL inUpdateApplicationFolder;
    BOOL rebuildingPrograms;
    NSOperation * updateCheckOp;
    NSURLSession * session;
    SUAppcastItem * nextUpdateItem;
    NSMenu * _programsMenu;
    NSMenuItem * _publishBottleMenuItem;
    NSMenuItem * _updateBottleMenuItem;
    NSArray * _launchers;
    CrossTieURLHandler * _urlHandler;
    NSMutableArray * _observedBottles;
}

// Class Methods
+ (id)getDefaultProgramsFolder;
+ (id)getProgramsFolder;
+ (id)crossTieModDateString;

// Instance Methods
- (id)init;
- (id)preferencesController;
- (id)mainWindowController;
- (void)applicationWillFinishLaunching:(id)arg1;
- (void)applicationDidFinishLaunching:(id)arg1;
- (id)startedAppGateOp;
- (void)openAutoPlayInstallerForC4P:(id)arg1 inBottle:(id)arg2;
- (void)openAutoPlayInstallerForVolume:(id)arg1 inBottle:(id)arg2;
- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1;
- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3;
- (id)startLaunchNotify:(id)arg1;
- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2;
- (void)runClient:(id)arg1 inBottle:(id)arg2;
- (void)runClient:(id)arg1 inBottle:(id)arg2 withDialog:(BOOL)arg3;
- (void)continueFromDemoCheck;
- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2;
- (void)handleCrossTieURL:(id)arg1;
- (void)openScreenSharingHelpPage:(id)arg1;
- (void)openHelpInBrowser:(id)arg1;
- (void)showMainWindow:(id)arg1;
- (void)showPreferencesWindow:(id)arg1;
- (void)bottleCollectionChanged;
- (void)runCommand:(id)arg1;
- (void)rebuildMenus:(id)arg1;
- (BOOL)validateMenuItem:(id)arg1;
- (void)refreshProgramsAndAssociationsInBackground:(id)arg1;
- (void)setRebuildingPrograms:(id)arg1;
- (void)refreshPrograms:(id)arg1;
- (void)queueRefreshPrograms:(id)arg1;
- (void)watchMenuPLists;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (id)getMenuPList;
- (void)addProgramsFromMenuPlist:(id)arg1 bottle:(id)arg2 toDictionary:(id)arg3 atPath:(id)arg4;
- (void)addProgramsFromMenuPlist:(id)arg1 bottle:(id)arg2 toDictionary:(id)arg3;
- (BOOL)updateApplicationFolder:(BOOL)arg1;
- (id)shortenedBundleID:(id)arg1;
- (void)createProgramsMenuFromSubmenu:(id)arg1 hasPrograms:(BOOL)arg2;
- (void)createProgramsMenu:(id)arg1;
- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2 skippingFiles:(id)arg3;
- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2;
- (void)addLauncherItems:(id)arg1 toMenu:(id)arg2;
- (void)duplicateBottleList:(id)arg1;
- (id)combinedAssociationsPropertyListLatestDate:(id *)arg1;
- (void)addDocumentTypeDictionary:(id)arg1 forBottle:(id)arg2 toBundleArray:(id)arg3 andResourcesDir:(id)arg4;
- (void)informSystemOfUpdatedApp:(id)arg1;
- (void)adjustProgramHelpersForChangedAssociations:(id)arg1;
- (void)refreshAssociations:(BOOL)arg1;
- (id)getAssociationDictionaryForKey:(id)arg1 withExtensionAssociations:(id)arg2;
- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3;
- (id)findBestApplicationForDocType:(id)arg1 withProgramsDict:(id)arg2;
- (id)findBestApplicationForDocType:(id)arg1 forBottle:(id)arg2;
- (id)findMenusForAssociations:(id)arg1;
- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3 usingExistingHelper:(id)arg4;
- (void)launchHelper:(id)arg1;
- (BOOL)exportProgram:(id)arg1 bundleName:(id)arg2 withDictionary:(id)arg3 toFolder:(id)arg4;
- (BOOL)createIcnsFile:(id)arg1 fromImageFile:(id)arg2 forApp:(BOOL)arg3;
- (BOOL)applicationOpenUntitledFile:(id)arg1;
- (void)runCXUpgrade;
- (void)checkForHelperUpdate;
- (void)processFirstRun:(BOOL)arg1;
- (id)applicationDockMenu:(id)arg1;
- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2;
- (id)sparkleUpdater;
- (void)repairBottles:(id)arg1;
- (void)repairBottlesDialog:(id)arg1;
- (id)programsMenu;
- (void)setProgramsMenu:(id)arg1;
- (id)publishBottleMenuItem;
- (void)setPublishBottleMenuItem:(id)arg1;
- (id)updateBottleMenuItem;
- (void)setUpdateBottleMenuItem:(id)arg1;
- (id)launchers;
- (void)setLaunchers:(id)arg1;
- (id)urlHandler;
- (void)setUrlHandler:(id)arg1;
- (id)observedBottles;
- (void)setObservedBottles:(id)arg1;

@end

#endif /* CXServerCrossOver_h */
