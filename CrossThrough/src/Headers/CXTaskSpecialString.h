// CXTaskSpecialString.h — CrossThrough
#ifndef CXTaskSpecialString_h
#define CXTaskSpecialString_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXTaskSpecialString;

@interface CXTaskSpecialString : NSProxy <NSCopying, NSMutableCopying>
{
    NSString * realString;
}

// Instance Methods
- (id)initWithString:(id)arg1;
- (id)copy;
- (id)mutableCopy;
- (id)copyWithZone:(void *)arg1;
- (id)mutableCopyWithZone:(void *)arg1;
- (id)fileSystemRepresentation;
- (id)forwardingTargetForSelector:(SEL)arg1;

@end

#endif /* CXTaskSpecialString_h */
