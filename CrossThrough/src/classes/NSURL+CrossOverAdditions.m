// NSURL+CrossOverAdditions.m — CrossThrough
#import "NSURL+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSURL (CrossOverAdditions)

- (id)stringWithFileSystemRepresentation {
    const char *representation = [self fileSystemRepresentation];
    return [[NSFileManager defaultManager] stringWithFileSystemRepresentation:representation length:strlen(representation)];
}

@end
