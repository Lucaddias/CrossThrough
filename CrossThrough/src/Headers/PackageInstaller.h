// PackageInstaller.h — CrossThrough
#ifndef PackageInstaller_h
#define PackageInstaller_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class PackageInstaller;

@interface PackageInstaller : CXObject <InstallConfigurationDelegate, NSObject>
{
    BOOL _cancelled;
    NSInteger _status;
    id _package;
    BottleWrapper * _bottle;
    NSString * _currentTaskDownloadDescription;
    NSInteger _totalInstallSteps;
    NSAttributedString * _completionNotes;
    id _summaryDetails;
    NSOperationQueue * _installQueue;
    NSMutableArray * _currentTasks;
    id _downloadUpdateTimer;
}

// Class Methods
+ (id)keyPathsForValuesAffectingIsUnknownPackage;

// Instance Methods
- (id)initWithPackage:(id)arg1;
- (void)dealloc;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)setSelectedPackage:(id)arg1;
- (void)setSelectedBottle:(id)arg1;
- (void)setInstallerSource:(id)arg1;
- (void)setUnknownPackage:(id)arg1;
- (BOOL)isUnknownPackage;
- (void)install;
- (void)cancel;
- (void)startInstallation;
- (void)selectInstaller:(id)arg1;
- (void)selectBottleWithCompletion:(id)arg1;
- (void)installOptions;
- (void)queueInstallOperationWithTaskStatus:(id)arg1;
- (void)addTaskToQueue:(id)arg1;
- (id)visibleTask;
- (id)currentTaskDescription;
- (void)startDownloadProgressTimer;
- (void)stopDownloadProgressTimer;
- (void)updateDownloadProgress:(id)arg1;
- (void)spoolAvailableTasks;
- (void)taskCompleted:(id)arg1;
- (void)addBottleToInstallTask:(id)arg1;
- (void)removeBottleFromInstallTask:(id)arg1;
- (void)trackBottle:(id)arg1;
- (void)stopTrackingBottle:(id)arg1;
- (void)bottleLoadedInfo:(id)arg1;
- (void)continueInstallation;
- (void)cancelTask:(id)arg1;
- (void)installationOver;
- (void)addMountedVolumes;
- (void)observeMount:(id)arg1;
- (void)observeUnmount:(id)arg1;
- (void)autoPlayWithParsedAutorunFile:(id)arg1;
- (void)updateProfiles;
- (void)updateInstallationNotes;
- (id)detailsFromDictionary:(id)arg1 withAction:(SEL)arg2;
- (id)detailsFromDictionary:(id)arg1;
- (void)updateSummaryDetails;
- (void)updateCompletionNotes;
- (void)displayNextFailureMessage;
- (void)profileChanged;
- (void)sourceChanged;
- (void)bottleCreateChanged;
- (void)bottleNewnameChanged;
- (void)bottleTemplateChanged;
- (void)bottleNameChanged;
- (void)categorizedAllBottles;
- (void)analyzedBottle:(id)arg1;
- (id)delegate;
- (void)setDelegate:(id)arg1;
- (id)installConfiguration;
- (void)setInstallConfiguration:(id)arg1;
- (id)package;
- (void)setPackage:(id)arg1;
- (id)bottle;
- (void)setBottle:(id)arg1;
- (id)currentTaskDownloadDescription;
- (void)setCurrentTaskDownloadDescription:(id)arg1;
- (NSInteger)installStepsCancelled;
- (void)setInstallStepsCancelled:(NSInteger)arg1;
- (NSInteger)installStepsCompleted;
- (void)setInstallStepsCompleted:(NSInteger)arg1;
- (NSInteger)installStepsSkipped;
- (void)setInstallStepsSkipped:(NSInteger)arg1;
- (NSInteger)totalInstallSteps;
- (void)setTotalInstallSteps:(NSInteger)arg1;
- (id)completionNotes;
- (void)setCompletionNotes:(id)arg1;
- (id)installationNotes;
- (void)setInstallationNotes:(id)arg1;
- (id)summaryDetails;
- (void)setSummaryDetails:(id)arg1;
- (NSInteger)status;
- (void)setStatus:(NSInteger)arg1;
- (id)installEngine;
- (void)setInstallEngine:(id)arg1;
- (id)installQueue;
- (void)setInstallQueue:(id)arg1;
- (id)currentTasks;
- (void)setCurrentTasks:(id)arg1;
- (id)failedTasks;
- (void)setFailedTasks:(id)arg1;
- (BOOL)cancelled;
- (void)setCancelled:(BOOL)arg1;
- (id)downloadUpdateTimer;
- (void)setDownloadUpdateTimer:(id)arg1;
- (id)bottleCollection;

@end

#endif /* PackageInstaller_h */
