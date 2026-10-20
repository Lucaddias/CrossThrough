// NSURL+CrossOverAdditions.m — CrossThrough
#import "NSURL+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSURL (CrossOverAdditions)

- (id)stringWithFileSystemRepresentation {
    /*
     * Decompiled from CrossOver 26.3:
     *   r19 = [objc_retainAutorelease(self) fileSystemRepresentation];
     *   r20 = [[NSFileManager defaultManager] retain];
     *   r19 = [[r20 stringWithFileSystemRepresentation:r19 length:strlen(r19)] retain];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

@end
