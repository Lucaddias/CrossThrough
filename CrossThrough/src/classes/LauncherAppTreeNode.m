// LauncherAppTreeNode.m — CrossThrough
#import "LauncherAppTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherAppTreeNode

+ (id)fromLauncher:(id)arg1 {
    LauncherAppTreeNode *node = [[self alloc] init];
    [node setName:[arg1 name]];
    [node setIcon:[arg1 icon]];
    [node setBottle:[arg1 bottle]];
    [node setLauncher:arg1];
    return [node autorelease];
}

+ (id)keyPathsForValuesAffectingPersistentID {
    return [NSSet setWithObject:@"launcher.bundleID"];
}

- (void)dealloc {
    [self->_persistentID release];
    [self->_launcher release];
    [super dealloc];
}

- (BOOL)isOpenable {
    if (![self bottle]) {
        return YES;
    }
    // A disabled bottle can still be opened: the launch offers to fix it.
    return [[self bottle] isCanRunCommands] || [[self bottle] isIsDisabled];
}

- (BOOL)canRunCommands {
    if (![self bottle]) {
        return YES;
    }
    return [[self bottle] isCanRunCommands];
}

- (id)url {
    return [[self launcher] url];
}

- (id)persistentID {
    if (!self->_persistentID) {
        NSString *bundleID = [[self launcher] bundleID];
        if ([bundleID length] != 0) {
            self->_persistentID = [[NSString alloc] initWithFormat:@"ProgramLauncherID/%@", bundleID];
        }
    }
    return [[self->_persistentID retain] autorelease];
}

- (BOOL)canBeFavorite {
    return YES;
}

- (void)openWithErrorHandler:(id)arg1 {
    LauncherApp *launcher = [[self launcher] retain];
    id errorHandler = [arg1 copy];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [launcher launchWithErrorHandler:errorHandler];
        [launcher release];
        [errorHandler release];
    });
}

- (id)pasteboardWriter {
    return [[self launcher] url];
}

- (id)launcher {
    return self->_launcher;
}

- (void)setLauncher:(id)arg1 {
    if (self->_launcher != arg1) {
        [self->_launcher release];
        self->_launcher = [arg1 retain];
    }
}

@end
