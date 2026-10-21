// LauncherDiskFolderTreeNode.m — CrossThrough
#import "LauncherDiskFolderTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherDiskFolderTreeNode

- (void)dealloc {
    [self->_launcherFolder release];
    [super dealloc];
}

- (BOOL)isOpenable {
    return YES;
}

- (BOOL)animateOpen {
    return NO;
}

- (id)url {
    return [[self launcherFolder] url];
}

- (void)openWithErrorHandler:(id)arg1 {
    [[NSWorkspace sharedWorkspace] openURL:[[self launcherFolder] url]];
}

- (id)pasteboardWriter {
    return [[self launcherFolder] url];
}

- (id)launcherFolder {
    return self->_launcherFolder;
}

- (void)setLauncherFolder:(id)arg1 {
    if (self->_launcherFolder != arg1) {
        [self->_launcherFolder release];
        self->_launcherFolder = [arg1 retain];
    }
}

@end
