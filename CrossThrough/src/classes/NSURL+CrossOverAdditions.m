// NSURL+CrossOverAdditions.m — CrossThrough
// Ported from -[NSURL stringWithFileSystemRepresentation] (0x100058ed0).
#import "NSURL+CrossOverAdditions.h"
#import "CrossThrough.h"

@implementation NSURL (CrossOverAdditions)

- (id)stringWithFileSystemRepresentation {
    const char *path = [self fileSystemRepresentation];
    return [[NSFileManager defaultManager] stringWithFileSystemRepresentation:path length:strlen(path)];
}

@end
