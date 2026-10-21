// download_probe.m — inspects the install engine CrossThrough builds for a
// package and, with --download, runs only its installer download task.
//
// Usage: download_probe [package name] [--download]  (or: make probe)
// The download task runs on a background thread exactly like
// InstallationOperation does; no bottle is created and no installer runs.
#import <Cocoa/Cocoa.h>
#import "CrossThrough.h"
#import "PackageViewController.h"
#import "PackageTreeNode.h"
#import "PackageInstaller.h"
#import "InstallConfiguration.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSString *packageName = @"Steam";
        BOOL runDownload = NO;
        for (int i = 1; i < argc; i++) {
            if (strcmp(argv[i], "--download") == 0) {
                runDownload = YES;
            } else {
                packageName = [NSString stringWithUTF8String:argv[i]];
            }
        }

        [NSApplication sharedApplication];
        PackageViewController *pvc = [[PackageViewController alloc] init];
        [pvc view];
        PackageTreeNode *target = nil;
        for (PackageTreeNode *node in [pvc packages]) {
            if ([node leaf] && [[node softwarePackage] isEqualToString:packageName]) {
                target = node;
                break;
            }
        }
        if (!target) {
            fprintf(stderr, "[PROBE] no package named '%s'\n", [packageName UTF8String]);
            return 1;
        }
        [pvc setSelectedPackage:target];
        InstallConfiguration *config = [[pvc installer] installConfiguration];
        printf("[PROBE] package=%s hasBottle=%d hasInstallerSource=%d bottleName=%s downloadURL=%s\n",
               [[target softwarePackage] UTF8String], [config hasBottle], [config hasInstallerSource],
               [[[config bottleName] description] UTF8String], [[[config downloadURL] description] UTF8String]);

        id engine = [config newInstallEngine];
        if (!engine) {
            fprintf(stderr, "[PROBE] newInstallEngine returned nil\n");
            return 1;
        }
        id downloadTask = nil;
        for (id task in [engine sortedTasks]) {
            BOOL isDownload = [[task valueForKey:@"download_task"] boolValue];
            printf("[PROBE] task %-28s download=%d label=%s\n", [NSStringFromClass([task class]) UTF8String], isDownload,
                   [[[task valueForKey:@"label"] description] UTF8String]);
            if (isDownload && !downloadTask) {
                downloadTask = task;
            }
        }
        for (id task in [engine sortedRunnable]) {
            printf("[PROBE] runnable %s\n", [[[task valueForKey:@"label"] description] UTF8String]);
        }
        if (!runDownload) {
            return 0;
        }
        if (!downloadTask) {
            fprintf(stderr, "[PROBE] the engine has no download task\n");
            return 1;
        }

        printf("[PROBE] schedule: %s\n", [[[engine schedule:downloadTask] description] UTF8String]);
        __block BOOL finished = NO;
        __block BOOL success = NO;
        [NSThread detachNewThreadWithBlock:^{
            success = [[(InstallEngineTask *)downloadTask main] boolValue];
            finished = YES;
        }];
        while (!finished) {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
            printf("[PROBE] downloaded %lld / %lld\n", [[downloadTask valueForKey:@"downloaded"] longLongValue],
                   [[downloadTask valueForKey:@"size"] longLongValue]);
        }
        printf("[PROBE] download task finished: %s\n", success ? "success" : "FAILED");
        return success ? 0 : 1;
    }
}
