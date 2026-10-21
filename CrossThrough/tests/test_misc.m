// test_misc.m — formatters, Foundation additions, launcher sorting, logging
// presets and nib loading with connected outlets.
//
// Runs inside the app bundle (make test-misc) so the nibs and the Python
// bridge resolve. Everything it writes lives in a temporary directory that is
// removed at the end; nothing touches bottles or the network.
#import <Cocoa/Cocoa.h>
#import "CrossThrough.h"
#import "BottleNameFormatter.h"
#import "DebugChannelFormatter.h"
#import "RatingNotesFormatter.h"
#import "NSFileManager+CrossOverAdditions.h"
#import "LauncherTreeNode.h"
#import "LoggingOption.h"
#import "LoggingOptionsViewController.h"
#import "DownloadProgressController.h"
#import "RegistrationController.h"

static int failures = 0;

#define CHECK(cond) do { \
    if (cond) { \
        NSLog(@"[TEST] ok   %s", #cond); \
    } else { \
        NSLog(@"[TEST] FAIL %s (%s:%d)", #cond, __FILE__, __LINE__); \
        failures++; \
    } \
} while (0)

static void testBottleNameFormatter(void) {
    BottleNameFormatter *formatter = [[[BottleNameFormatter alloc] init] autorelease];
    CHECK([formatter isPartialStringValid:@"Steam" newEditingString:NULL errorDescription:NULL]);
    CHECK(![formatter isPartialStringValid:@"Steam/Games" newEditingString:NULL errorDescription:NULL]);
    CHECK(![formatter isPartialStringValid:@"Steam\\Games" newEditingString:NULL errorDescription:NULL]);
    CHECK(![formatter isPartialStringValid:@"What?" newEditingString:NULL errorDescription:NULL]);
    CHECK(![formatter isPartialStringValid:@".hidden" newEditingString:NULL errorDescription:NULL]);
    NSAttributedString *title = [[[NSAttributedString alloc] initWithString:@"Office"] autorelease];
    CHECK([[formatter stringForObjectValue:title] isEqualToString:@"Office"]);
    CHECK([formatter stringForObjectValue:@12] == nil);
    id value = nil;
    CHECK([formatter getObjectValue:&value forString:@"Games" errorDescription:NULL] && [value isEqualToString:@"Games"]);
}

static void testDebugChannelFormatter(void) {
    CHECK([[DebugChannelFormatter sanitizeChannelString:@"  +re$lay , warn+heap  \n"] isEqualToString:@"+relay,warn+heap"]);
    CHECK([[DebugChannelFormatter sanitizePartialString:@"+seh\n\n-d3d"] isEqualToString:@"+seh,-d3d"]);
    DebugChannelFormatter *formatter = [[[DebugChannelFormatter alloc] init] autorelease];
    NSString *partial = @"+relay#";
    NSRange selection = NSMakeRange(7, 0);
    BOOL accepted = [formatter isPartialStringValid:&partial proposedSelectedRange:&selection
                                     originalString:@"+relay" originalSelectedRange:NSMakeRange(6, 0) errorDescription:NULL];
    CHECK(!accepted && [partial isEqualToString:@"+relay"]);
}

static void testRatingNotesFormatter(void) {
    RatingNotesFormatter *formatter = [[[RatingNotesFormatter alloc] init] autorelease];
    [formatter setMaxLength:5];
    NSString *partial = @"abc";
    NSRange selection = NSMakeRange(3, 0);
    CHECK([formatter isPartialStringValid:&partial proposedSelectedRange:&selection
                           originalString:@"ab" originalSelectedRange:NSMakeRange(2, 0) errorDescription:NULL]);
    partial = @"abcdef";
    selection = NSMakeRange(6, 0);
    BOOL accepted = [formatter isPartialStringValid:&partial proposedSelectedRange:&selection
                                     originalString:@"abcd" originalSelectedRange:NSMakeRange(4, 0) errorDescription:NULL];
    CHECK(!accepted && [partial isEqualToString:@"abcde"] && selection.location == 5 && selection.length == 0);
}

static void testFileManagerAdditions(NSString *root) {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *deep = [root stringByAppendingPathComponent:@"a/b/c"];
    CHECK([fm createDirectoryAtPath:deep attributes:nil recursively:YES]);
    BOOL isDirectory = NO;
    CHECK([fm fileExistsAtPath:deep isDirectory:&isDirectory] && isDirectory);
    CHECK([fm createDirectoryAtPath:deep attributes:nil recursively:YES]);

    NSString *file = [deep stringByAppendingPathComponent:@"file.txt"];
    [fm createFileAtPath:file contents:[@"crossthrough" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    NSString *link = [root stringByAppendingPathComponent:@"link.txt"];
    [fm createSymbolicLinkAtPath:link withDestinationPath:file error:NULL];
    CHECK([fm isSameFile:file asFile:link]);
    CHECK(![fm isSameFile:file asFile:deep]);
    CHECK([fm isFile:file inDirectory:root]);
    CHECK(![fm isFile:root inDirectory:deep]);
    CHECK(![fm isFileInTrash:file]);

    NSData *bookmark = [fm bookmarkDataFromPath:file];
    CHECK([bookmark length] > 0);
    BOOL stale = YES;
    NSString *resolved = [fm pathFromBookmarkData:bookmark stale:&stale];
    CHECK([fm isSameFile:resolved asFile:file] && !stale);

    [fm setAttributes:@{NSFilePosixPermissions: @0444} ofItemAtPath:file error:NULL];
    CHECK([fm makeWritableAtPath:root recursively:YES]);
    CHECK([[fm attributesOfItemAtPath:file error:NULL] filePosixPermissions] & S_IWUSR);

    NSString *display = [fm getDisplayStringForPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Library"]];
    CHECK([display hasPrefix:NSUserName()] && [display rangeOfString:@" ▹ "].location != NSNotFound);

    [fm removeItemAtPath:file error:NULL];
    [fm removeItemAtPath:link error:NULL];
    [fm removeFolderIfEmpty:deep upTo:root];
    CHECK(![fm fileExistsAtPath:[root stringByAppendingPathComponent:@"a"]]);
    CHECK([fm fileExistsAtPath:root]);
}

static LauncherTreeNode *launcher(NSString *name, NSInteger sortOrder) {
    LauncherTreeNode *node = [[[LauncherTreeNode alloc] init] autorelease];
    [node setName:name];
    [node setSortOrder:sortOrder];
    return node;
}

static void testLauncherSorting(void) {
    NSArray *nodes = @[launcher(@"Steam", 1), launcher(@"App 10", 1), launcher(@"Uninstall", 2),
                       launcher(@"App 9", 1), launcher(@"Run Command", 0)];
    NSArray *sorted = [nodes sortedArrayUsingSelector:@selector(compareSortOrderThenName:)];
    NSArray *names = [sorted valueForKey:@"name"];
    CHECK([names isEqualToArray:(@[@"Run Command", @"App 9", @"App 10", @"Steam", @"Uninstall"])]);
    CHECK([[LauncherTreeNode keyPathsForValuesAffectingSortOrderThenName] containsObject:@"sortOrder"]);
}

static void testLoggingPresets(void) {
    NSArray *presets = [LoggingOption commonPresets];
    CHECK([presets count] > 0);
    for (LoggingOption *option in presets) {
        CHECK([[option name] length] > 0);
    }
    CHECK([LoggingOption commonPresets] == presets);
    LoggingOption *custom = [LoggingOption loggingOptionWithName:@"Relay" channels:@"+relay" environment:@"WINEDEBUG=+relay"];
    CHECK([[custom logChannels] isEqualToString:@"+relay"] && [[custom logEnvironment] isEqualToString:@"WINEDEBUG=+relay"]);
}

static void testLoggingOptionsNib(void) {
    LoggingOptionsViewController *controller = [[[LoggingOptionsViewController alloc] initWithLogFileName:@"Test"] autorelease];
    CHECK([controller view] != nil);
    CHECK([controller channelPresets] != nil);
    CHECK([controller recentChannelsDivider] != nil);
    CHECK([controller recentChannelsMenuItem] != nil);
    CHECK([[controller channelCombos] count] == [[LoggingOption commonPresets] count]);
}

static void testDownloadProgressNib(NSString *root) {
    NSString *payload = [root stringByAppendingPathComponent:@"payload.bin"];
    NSMutableData *bytes = [NSMutableData dataWithLength:256 * 1024];
    [bytes writeToFile:payload atomically:YES];
    NSURL *url = [NSURL fileURLWithPath:payload];

    DownloadProgressController *controller = [[[DownloadProgressController alloc] initWithURL:url] autorelease];
    CHECK([controller window] != nil);
    CHECK([controller caption] != nil);
    CHECK([controller progressBar] != nil);
    CHECK([controller progressText] != nil);
    CHECK([[[controller caption] stringValue] rangeOfString:[url description]].location != NSNotFound);
    CHECK([[controller progressFormat] length] > 0);

    NSDate *deadline = [NSDate dateWithTimeIntervalSinceNow:10.0];
    while (![controller path] && [deadline timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
    NSString *downloaded = [controller path];
    CHECK(downloaded != nil);
    CHECK([[[NSFileManager defaultManager] attributesOfItemAtPath:downloaded error:NULL] fileSize] == [bytes length]);
    if (downloaded) {
        [[NSFileManager defaultManager] removeItemAtPath:downloaded error:NULL];
    }
}

static void testRegistrationController(void) {
    RegistrationController *controller = [[[RegistrationController alloc] init] autorelease];
    CHECK(controller != nil);
    CHECK([[controller globalRegModeCaption] length] > 0);
    BOOL globalWritable = [[NSFileManager defaultManager] isWritableFileAtPath:@"/Library/Preferences"];
    CHECK([controller regMode] == (globalWritable ? 1 : 0));
    CHECK([controller registrationWorkInProgress] == 0);
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        [NSApplication sharedApplication];
        NSString *root = [NSTemporaryDirectory() stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"crossthrough-test-misc-%d", getpid()]];
        [[NSFileManager defaultManager] createDirectoryAtPath:root withIntermediateDirectories:YES attributes:nil error:NULL];

        testBottleNameFormatter();
        testDebugChannelFormatter();
        testRatingNotesFormatter();
        testFileManagerAdditions(root);
        testLauncherSorting();
        testLoggingPresets();
        testLoggingOptionsNib();
        testDownloadProgressNib(root);
        testRegistrationController();

        [[NSFileManager defaultManager] removeItemAtPath:root error:NULL];
        if (failures) {
            NSLog(@"[TEST] %d MISC CHECK(S) FAILED", failures);
            return 1;
        }
        NSLog(@"[TEST] ALL MISC TESTS PASSED");
    }
    return 0;
}
