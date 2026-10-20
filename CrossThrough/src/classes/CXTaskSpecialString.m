// CXTaskSpecialString.m — CrossThrough
#import "CXTaskSpecialString.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXTaskSpecialString

- (id)initWithString:(id)arg1 {
    self->realString = [arg1 retain];
    return self;
}

- (void)dealloc {
    [self->realString release];
    self->realString = nil;
    [super dealloc];
}

- (id)copy {
    return [self copyWithZone:NULL];
}

- (id)mutableCopy {
    return [self mutableCopyWithZone:NULL];
}

- (id)copyWithZone:(NSZone *)arg1 {
    id copied = [self->realString copyWithZone:arg1];
    CXTaskSpecialString *res = [[CXTaskSpecialString alloc] initWithString:copied];
    [copied release];
    return res;
}

- (id)mutableCopyWithZone:(NSZone *)arg1 {
    id copied = [self->realString mutableCopyWithZone:arg1];
    CXTaskSpecialString *res = [[CXTaskSpecialString alloc] initWithString:copied];
    [copied release];
    return res;
}

- (const char *)fileSystemRepresentation {
    return [self->realString UTF8String];
}

- (id)forwardingTargetForSelector:(SEL)arg1 {
    return self->realString;
}

@end
