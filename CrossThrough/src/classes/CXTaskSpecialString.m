// CXTaskSpecialString.m — CrossThrough
#import "CXTaskSpecialString.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXTaskSpecialString

- (id)initWithString:(id)arg1 {
    self->realString = [arg1 retain];
    return self;
}

- (id)copy {
    return [self copyWithZone:NULL];
}

- (id)mutableCopy {
    return [self mutableCopyWithZone:NULL];
}

- (id)copyWithZone:(void *)arg1 {
    NSString *string = [self->realString copyWithZone:(NSZone *)arg1];
    CXTaskSpecialString *copy = [[CXTaskSpecialString alloc] initWithString:string];
    [string release];
    return copy;
}

- (id)mutableCopyWithZone:(void *)arg1 {
    NSMutableString *string = [self->realString mutableCopyWithZone:(NSZone *)arg1];
    CXTaskSpecialString *copy = [[CXTaskSpecialString alloc] initWithString:string];
    [string release];
    return copy;
}

- (const char *)fileSystemRepresentation {
    return [self->realString UTF8String];
}

- (id)forwardingTargetForSelector:(SEL)arg1 {
    return self->realString;
}

- (void)dealloc {
    [self->realString release];
    [super dealloc];
}

@end
