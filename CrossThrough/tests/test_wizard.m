// test_wizard.m — Comprehensive test suite for wizard, engine, and backend controllers
#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>
#import "CrossThrough.h"
#import "PackageViewController.h"
#import "PackageTreeNode.h"
#import "PackageInstaller.h"
#import "InstallConfiguration.h"
#import "SelectBottleSheetController.h"
#import "SelectBottleController.h"
#import "InstallOptionsSheetController.h"
#import "InstallSummaryDetailViewController.h"
#import "SummaryDetail.h"
#import "RosettaInstallationController.h"
#import "SubmitRatingController.h"
#import "CXServer.h"
#import "CXServerCrossOver.h"
#import "CXTask.h"
#import "CXTaskSpecialString.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [NSApplication sharedApplication];
        NSLog(@"[TEST] Initializing CXSetupLib...");
        [CXSetupLib c4ProfilesClass];

        NSLog(@"[TEST] Creating PackageViewController...");
        PackageViewController *pvc = [[PackageViewController alloc] init];
        assert(pvc != nil);

        NSLog(@"[TEST] Loading PackageViewController view...");
        NSView *view = [pvc view];
        assert(view != nil);

        NSArray *visible = [pvc visiblePackages];
        NSLog(@"[TEST] Visible packages count: %lu", (unsigned long)[visible count]);
        assert([visible count] > 0);

        PackageTreeNode *firstApp = [visible objectAtIndex:0];
        NSLog(@"[TEST] First popular app: %@ (appid: %@)", [firstApp description], [firstApp packageid]);

        NSLog(@"[TEST] Simulating app selection...");
        [pvc setSelectedPackage:firstApp];

        PackageInstaller *installer = [pvc installer];
        assert(installer != nil);
        NSLog(@"[TEST] PackageInstaller successfully created: %@", installer);
        assert([installer isUnknownPackage] == NO);
        assert([[installer summaryDetails] count] > 0);

        InstallConfiguration *config = [installer installConfiguration];
        assert(config != nil);
        NSLog(@"[TEST] InstallConfiguration targetBottle: %@, nameForNewBottle: %@", [config targetBottle], [config nameForNewBottle]);

        NSArray *detailsControllers = [pvc summaryDetailsControllers];
        NSLog(@"[TEST] SummaryDetailsControllers count: %lu", (unsigned long)[detailsControllers count]);
        assert([detailsControllers count] > 0);

        for (InstallSummaryDetailViewController *sdvc in detailsControllers) {
            NSLog(@"[TEST] SummaryDetail text: '%@', action: %@", [[sdvc text] string], NSStringFromSelector([sdvc action]));
        }

        NSLog(@"[TEST] Testing SelectBottleSheetController initialization...");
        SelectBottleSheetController *sheetCtrl = [[SelectBottleSheetController alloc] initWithInstallConfiguration:config];
        assert(sheetCtrl != nil);
        // Load window
        NSWindow *sheetWin = [sheetCtrl window];
        assert(sheetWin != nil);
        NSLog(@"[TEST] SelectBottleSheetController window loaded, creatingNewBottle=%d", [sheetCtrl creatingNewBottle]);
        [sheetCtrl release];

        NSLog(@"[TEST] Testing SelectBottleController initialization...");
        SelectBottleController *bottleCtrl = [[SelectBottleController alloc] init];
        assert(bottleCtrl != nil);
        NSView *bottleView = [bottleCtrl view];
        assert(bottleView != nil);
        NSLog(@"[TEST] SelectBottleController view loaded, allowedFileTypes=%@", [bottleCtrl allowedFileTypes]);
        [bottleCtrl release];

        NSLog(@"[TEST] Testing InstallOptionsSheetController initialization...");
        InstallOptionsSheetController *optsCtrl = [[InstallOptionsSheetController alloc] initWithInstallConfiguration:config];
        assert(optsCtrl != nil);
        NSWindow *optsWin = [optsCtrl window];
        assert(optsWin != nil);
        NSLog(@"[TEST] InstallOptionsSheetController window loaded successfully.");
        [optsCtrl release];

        NSLog(@"[TEST] Testing RosettaInstallationController...");
        RosettaInstallationController *rosetta = [[RosettaInstallationController alloc] init];
        assert(rosetta != nil);
        NSWindow *rosettaWin = [rosetta window];
        assert(rosettaWin != nil);
        NSLog(@"[TEST] RosettaInstallationController window loaded: %@", rosettaWin);
        [rosetta release];

        NSLog(@"[TEST] Testing SubmitRatingController metadata and dependencies...");
        NSSet *ratingDescKeys = [SubmitRatingController keyPathsForValuesAffectingRatingDescription];
        assert([ratingDescKeys containsObject:@"rating"]);
        NSSet *charLeftKeys = [SubmitRatingController keyPathsForValuesAffectingCharactersLeft];
        assert([charLeftKeys containsObject:@"notes"]);
        NSSet *canSubmitKeys = [SubmitRatingController keyPathsForValuesAffectingCanSubmit];
        assert([canSubmitKeys containsObject:@"rating"]);
        NSLog(@"[TEST] SubmitRatingController KVO dependencies validated.");

        NSLog(@"[TEST] Testing CXServer class methods and instance...");
        NSString *cellar = [CXServer getCellarID];
        NSLog(@"[TEST] CXServer getCellarID: %@", cellar);
        assert([cellar length] > 0);

        NSString *appSupport = [CXServer getAppSupportDir];
        NSLog(@"[TEST] CXServer getAppSupportDir: %@", appSupport);
        assert([appSupport length] > 0);

        NSString *caches = [CXServer getCachesDir];
        NSLog(@"[TEST] CXServer getCachesDir: %@", caches);
        assert([caches length] > 0);

        NSString *defaultBottleDir = [CXServer getDefaultBottleDir];
        NSLog(@"[TEST] CXServer getDefaultBottleDir: %@", defaultBottleDir);
        assert([defaultBottleDir length] > 0);

        NSString *bottleDir = [CXServer getBottleDir];
        NSLog(@"[TEST] CXServer getBottleDir: %@", bottleDir);
        assert([bottleDir length] > 0);

        CXServer *server = [[CXServer alloc] init];
        assert(server != nil);
        NSLog(@"[TEST] CXServer instance created: %@", server);
        [server release];

        NSLog(@"[TEST] Testing CXServerCrossOver class methods and instance...");
        CXServerCrossOver *cxServer = [[CXServerCrossOver alloc] init];
        assert(cxServer != nil);
        NSLog(@"[TEST] CXServerCrossOver instance created: %@", cxServer);

        NSString *defaultPrograms = [CXServerCrossOver getDefaultProgramsFolder];
        NSLog(@"[TEST] CXServerCrossOver getDefaultProgramsFolder: %@", defaultPrograms);
        assert([defaultPrograms length] > 0);

        NSString *programsFolder = [CXServerCrossOver getProgramsFolder];
        NSLog(@"[TEST] CXServerCrossOver getProgramsFolder: %@", programsFolder);
        assert([programsFolder length] > 0);

        NSString *crossTieMod = [CXServerCrossOver crossTieModDateString];
        NSLog(@"[TEST] CXServerCrossOver crossTieModDateString: %@", crossTieMod);

        [cxServer release];

        NSLog(@"[TEST] Testing CXTaskSpecialString proxy behavior...");
        CXTaskSpecialString *spStr = [[CXTaskSpecialString alloc] initWithString:@"hello_wine"];
        assert(spStr != nil);
        assert(strcmp([spStr fileSystemRepresentation], "hello_wine") == 0);
        assert([(NSString *)spStr length] == 10);
        assert([(NSString *)spStr isEqualToString:@"hello_wine"]);
        CXTaskSpecialString *spCopy = [spStr copy];
        assert([(NSString *)spCopy isEqualToString:@"hello_wine"]);
        [spCopy release];
        [spStr release];
        NSLog(@"[TEST] CXTaskSpecialString validated successfully.");

        NSLog(@"[TEST] Testing CXTask proxy and string transformation...");
        NSArray *rawArgs = @[ @"--bottle", @"Default", @123 ];
        NSArray *converted = [CXTask argumentsWithStringsReplacedBySpecialStrings:rawArgs];
        assert([converted count] == 3);
        assert(object_getClass([converted objectAtIndex:0]) == [CXTaskSpecialString class]);
        assert(object_getClass([converted objectAtIndex:1]) == [CXTaskSpecialString class]);
        assert([[converted objectAtIndex:0] isEqualToString:@"--bottle"]);
        assert([[converted objectAtIndex:1] isEqualToString:@"Default"]);
        assert([[converted objectAtIndex:2] isKindOfClass:[NSNumber class]]);

        CXTask *task = [[CXTask alloc] init];
        assert(task != nil);
        [task setLaunchPath:@"/bin/echo"];
        [task setArguments:@[ @"CrossThroughTaskTest" ]];
        NSPipe *pipe = [NSPipe pipe];
        [task setStandardOutput:pipe];
        [task launch];
        [task waitUntilExit];
        assert([task terminationStatus] == 0);
        NSData *outData = [[pipe fileHandleForReading] readDataToEndOfFile];
        NSString *outStr = [[[NSString alloc] initWithData:outData encoding:NSUTF8StringEncoding] autorelease];
        assert([outStr containsString:@"CrossThroughTaskTest"]);
        [task release];
        NSLog(@"[TEST] CXTask execution and forwarding validated successfully.");

        [pvc release];
        NSLog(@"[TEST] ALL WIZARD, ENGINE, AND BACKEND TESTS PASSED SUCCESSFULLY! ✅");
    }
    return 0;
}
