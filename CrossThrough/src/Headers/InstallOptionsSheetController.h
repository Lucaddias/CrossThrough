// InstallOptionsSheetController.h — CrossThrough
#ifndef InstallOptionsSheetController_h
#define InstallOptionsSheetController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class InstallOptionsSheetController;
@class InstallConfiguration;
@class LoggingOptionsViewController;

@interface InstallOptionsSheetController : CXWindowController <NSWindowDelegate, NSObject, InstallConfigurationDelegate>
{
    NSTableView * _installDependencyTable;
    NSArrayController * _installDependencyArrayController;
    NSPopUpButton * _appLanguagePopUp;
    NSStackView * _stackView;
    NSArray * _dependencies;
    InstallConfiguration * _installConfiguration;
    LoggingOptionsViewController * _loggingOptions;
    NSURL * _logFileURL;
    NSInteger _numberOfLanguages;
    NSString * _environment;
}

// Instance Methods
- (id)initWithInstallConfiguration:(id)arg1;
- (void)dealloc;
- (void)windowDidLoad;
- (void)updateLogFileName;
- (void)addDependenciesOfApp:(id)arg1 fromReasons:(id)arg2 to:(id)arg3;
- (void)addDependenciesForReason:(id)arg1 fromMap:(id)arg2 reasonString:(id)arg3 removedString:(id)arg4 to:(id)arg5;
- (void)fillDependencyList;
- (void)done:(id)arg1;
- (void)removeInstallDependency:(id)arg1;
- (void)reAddDependency:(id)arg1;
- (void)revertInstallDependencies:(id)arg1;
- (void)showAddDependenciesPopover:(id)arg1;
- (void)updateLanguages;
- (void)selectAppLanguage:(id)arg1;
- (void)windowWillClose:(id)arg1;
- (void)profileChanged;
- (void)sourceChanged;
- (void)bottleCreateChanged;
- (void)bottleNameChanged;
- (void)bottleNewnameChanged;
- (void)bottleTemplateChanged;
- (void)analyzedBottle:(id)arg1;
- (id)installDependencyTable;
- (void)setInstallDependencyTable:(id)arg1;
- (id)installDependencyArrayController;
- (void)setInstallDependencyArrayController:(id)arg1;
- (id)appLanguagePopUp;
- (void)setAppLanguagePopUp:(id)arg1;
- (id)stackView;
- (void)setStackView:(id)arg1;
- (id)dependencies;
- (void)setDependencies:(id)arg1;
- (id)installConfiguration;
- (id)loggingOptions;
- (void)setLoggingOptions:(id)arg1;
- (id)logFileURL;
- (NSInteger)numberOfLanguages;
- (void)setNumberOfLanguages:(NSInteger)arg1;
- (id)environment;
- (void)setEnvironment:(id)arg1;

@end

#endif /* InstallOptionsSheetController_h */
