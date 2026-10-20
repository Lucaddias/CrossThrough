// LauncherDiskFolderTreeNode — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10002674c
// -[LauncherDiskFolderTreeNode isOpenable]
    return 0x1;


// 0x100026754
// -[LauncherDiskFolderTreeNode animateOpen]
    return 0x0;


// 0x10002675c
// -[LauncherDiskFolderTreeNode url]
    r0 = [self launcherFolder];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 url] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x1000267a0
// -[LauncherDiskFolderTreeNode openWithErrorHandler:]
    r20 = [[NSWorkspace sharedWorkspace] retain];
    r0 = [self launcherFolder];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 url] retain];
    [r20 openURL:r21];
    [r21 release];
    [r19 release];
    [r20 release];
    return;


// 0x100026820
// -[LauncherDiskFolderTreeNode pasteboardWriter]
    r0 = [self launcherFolder];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 url] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100026864
// -[LauncherDiskFolderTreeNode launcherFolder]
    r0 = self->_launcherFolder;
    return r0;


// 0x100026874
// -[LauncherDiskFolderTreeNode setLauncherFolder:]
    objc_storeStrong((int64_t *)&self->_launcherFolder, arg2);
    return;


// 0x100026888
// -[LauncherDiskFolderTreeNode .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_launcherFolder, 0x0);
    return;


