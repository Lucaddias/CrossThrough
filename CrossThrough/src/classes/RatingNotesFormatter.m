// RatingNotesFormatter.m — CrossThrough
#import "RatingNotesFormatter.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation RatingNotesFormatter

- (id)stringForObjectValue:(id)arg1 {
    return arg1;
}

- (BOOL)getObjectValue:(id *)arg1 forString:(NSString *)arg2 errorDescription:(NSString **)arg3 {
    *arg1 = [[arg2 copy] autorelease];
    return YES;
}

- (BOOL)isPartialStringValid:(NSString **)arg1 proposedSelectedRange:(NSRangePointer)arg2 originalString:(NSString *)arg3 originalSelectedRange:(NSRange)arg4 errorDescription:(NSString **)arg5 {
    if ([self maxLength] == 0 || (NSInteger)[*arg1 length] < [self maxLength]) {
        return YES;
    }
    NSUInteger caret = arg4.location + arg4.length + [self maxLength] - [arg3 length];
    NSMutableString *truncated = [[*arg1 mutableCopy] autorelease];
    [truncated deleteCharactersInRange:NSMakeRange(caret, [truncated length] - [self maxLength])];
    *arg1 = truncated;
    *arg2 = NSMakeRange(caret, 0);
    return NO;
}

- (NSInteger)maxLength {
    return self->_maxLength;
}

- (void)setMaxLength:(NSInteger)arg1 {
    self->_maxLength = arg1;
}

@end
