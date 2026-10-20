// test_wizard.m — Test wizard selection and bottle controllers
#import <Cocoa/Cocoa.h>
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

        [pvc release];
        NSLog(@"[TEST] ALL WIZARD TESTS PASSED SUCCESSFULLY! ✅");
    }
    return 0;
}
