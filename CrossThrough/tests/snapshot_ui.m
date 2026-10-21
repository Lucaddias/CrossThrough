// snapshot_ui.m — renders CrossThrough screens to PNG for side-by-side checks
// against the original CrossOver.
//
// Usage: snapshot_ui <output-dir> [package name]
// Writes home.png (the Install view) and detail.png (the package detail view
// for the named package, "Steam" by default). Nothing is installed: the
// harness only selects a package, exactly like a click in the grid.
#import <Cocoa/Cocoa.h>
#import "CrossThrough.h"
#import "MainWindowController.h"
#import "PackageViewController.h"
#import "PackageTreeNode.h"

static void capture(NSWindow *window, NSString *path) {
    NSString *cmd = [NSString stringWithFormat:@"/usr/sbin/screencapture -x -o -l %ld '%@'", (long)[window windowNumber], path];
    int rc = system([cmd UTF8String]);
    printf("[SNAPSHOT] %s -> %s\n", rc == 0 ? "ok" : "FAILED", [path UTF8String]);
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            fprintf(stderr, "usage: %s <output-dir> [package name]\n", argv[0]);
            return 2;
        }
        NSString *outDir = [NSString stringWithUTF8String:argv[1]];
        NSString *packageName = argc > 2 ? [NSString stringWithUTF8String:argv[2]] : @"Steam";
        [[NSFileManager defaultManager] createDirectoryAtPath:outDir withIntermediateDirectories:YES attributes:nil error:NULL];

        [CXApplication sharedApplication];
        [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
        // Keep the persisted window state of the real app untouched.
        [[NSUserDefaults standardUserDefaults] setVolatileDomain:@{@"ApplePersistenceIgnoreState": @YES} forName:NSArgumentDomain];

        MainWindowController *controller = [[MainWindowController alloc] init];
        [controller showWindow:nil];
        [[controller window] setFrame:NSMakeRect(200, 200, 1150, 700) display:YES];
        [NSApp activateIgnoringOtherApps:YES];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            capture([controller window], [outDir stringByAppendingPathComponent:@"home.png"]);

            PackageViewController *pvc = [controller packageViewController];
            PackageTreeNode *target = nil;
            for (PackageTreeNode *node in [pvc visiblePackages]) {
                if ([[node softwarePackage] isEqualToString:packageName]) {
                    target = node;
                    break;
                }
            }
            if (!target) {
                fprintf(stderr, "[SNAPSHOT] package '%s' is not in the visible list\n", [packageName UTF8String]);
                exit(1);
            }
            [pvc setSelectedPackage:target];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                capture([controller window], [outDir stringByAppendingPathComponent:@"detail.png"]);
                exit(0);
            });
        });
        [NSApp run];
    }
    return 0;
}
