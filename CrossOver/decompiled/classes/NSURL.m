// NSURL — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100058ed0
// -[NSURL stringWithFileSystemRepresentation]
    r19 = [objc_retainAutorelease(self) fileSystemRepresentation];
    r20 = [[NSFileManager defaultManager] retain];
    r19 = [[r20 stringWithFileSystemRepresentation:r19 length:strlen(r19)] retain];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


