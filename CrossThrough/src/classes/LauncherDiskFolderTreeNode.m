// LauncherDiskFolderTreeNode.m — CrossThrough
#import "LauncherDiskFolderTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherDiskFolderTreeNode

- (BOOL)isOpenable {
    return YES;
}

- (BOOL)animateOpen {
    return NO;
}

- (id)url {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self launcherFolder];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 url] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)openWithErrorHandler:(id)arg1 {
    return;
}

- (id)pasteboardWriter {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self launcherFolder];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 url] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)launcherFolder {
    return self->_launcherFolder;
}

- (void)setLauncherFolder:(id)arg1 {
    self->_launcherFolder = arg1;
}

@end
