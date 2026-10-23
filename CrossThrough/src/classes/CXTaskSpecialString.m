// CXTaskSpecialString.m — CrossThrough
// Ported from CrossOver 26.3 arm64 (0x10003965c..0x100039760).
// A string proxy handed to NSTask so that its fileSystemRepresentation is the
// plain UTF-8 string instead of the decomposed (NFD) form NSString produces.
#import "CXTaskSpecialString.h"
#import "CrossThrough.h"

@implementation CXTaskSpecialString

- (id)initWithString:(id)arg1 {
    realString = arg1;
    return self;
}

- (id)copy {
    return [self copyWithZone:NULL];
}

- (id)mutableCopy {
    return [self mutableCopyWithZone:NULL];
}

- (id)copyWithZone:(NSZone *)arg1 {
    return [[CXTaskSpecialString alloc] initWithString:[realString copyWithZone:arg1]];
}

- (id)mutableCopyWithZone:(NSZone *)arg1 {
    return [[CXTaskSpecialString alloc] initWithString:[realString mutableCopyWithZone:arg1]];
}

- (const char *)fileSystemRepresentation {
    return [realString UTF8String];
}

- (id)forwardingTargetForSelector:(SEL)arg1 {
    return realString;
}

@end
