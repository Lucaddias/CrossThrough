// DebugChannelFormatter.m — CrossThrough
#import "DebugChannelFormatter.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation DebugChannelFormatter

+ (id)sanitizePartialString:(id)arg1 {
    static dispatch_once_t onceToken;
    static NSCharacterSet *invalidCharacters = nil;
    dispatch_once(&onceToken, ^{
        NSMutableCharacterSet *valid = [[NSMutableCharacterSet alloc] init];
        [valid addCharactersInRange:NSMakeRange('A', 26)];
        [valid addCharactersInRange:NSMakeRange('a', 26)];
        [valid addCharactersInRange:NSMakeRange('0', 10)];
        [valid addCharactersInString:@"_,+-:. "];
        invalidCharacters = [[valid invertedSet] retain];
        [valid release];
    });
    NSMutableString *string = [[arg1 mutableCopy] autorelease];
    NSRange searchRange = NSMakeRange(0, [string length]);
    while (YES) {
        NSRange newline = [string rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:0 range:searchRange];
        if (newline.location == NSNotFound || newline.length == 0) {
            break;
        }
        [string replaceCharactersInRange:newline withString:@","];
        searchRange.location = newline.location + 1;
        searchRange.length = [string length] - searchRange.location;
    }
    while ([string replaceOccurrencesOfString:@",," withString:@"," options:0 range:NSMakeRange(0, [string length])] != 0) {
    }
    return [string stringByRemovingCharactersInSet:invalidCharacters];
}

+ (id)sanitizeChannelString:(id)arg1 {
    NSMutableString *string = [[[self sanitizePartialString:arg1] mutableCopy] autorelease];
    [string replaceOccurrencesOfString:@" +" withString:@" " options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@" " withString:@"" options:NSAnchoredSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@" " withString:@"" options:NSAnchoredSearch | NSBackwardsSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@" ?([,:]) ?" withString:@"$1" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"," withString:@"" options:NSAnchoredSearch range:NSMakeRange(0, [string length])];
    [string replaceOccurrencesOfString:@"," withString:@"" options:NSAnchoredSearch | NSBackwardsSearch range:NSMakeRange(0, [string length])];
    return string;
}

- (id)stringForObjectValue:(id)arg1 {
    return [arg1 description];
}

- (BOOL)getObjectValue:(id *)arg1 forString:(NSString *)arg2 errorDescription:(NSString **)arg3 {
    *arg1 = [[arg2 copy] autorelease];
    return YES;
}

- (BOOL)isPartialStringValid:(NSString **)arg1 proposedSelectedRange:(NSRangePointer)arg2 originalString:(NSString *)arg3 originalSelectedRange:(NSRange)arg4 errorDescription:(NSString **)arg5 {
    NSString *partial = *arg1;
    NSMutableString *result = [NSMutableString string];
    NSUInteger insertedLength = [partial length] - [arg3 length] + arg4.length;
    NSUInteger selectionLocation = arg2->location;
    NSUInteger selectionLength = arg2->length;

    if (arg4.location != 0) {
        NSString *prefix = [[self class] sanitizePartialString:[partial substringToIndex:arg4.location]];
        if (selectionLocation >= arg4.location) {
            selectionLocation = selectionLocation - arg4.location + [prefix length];
        }
        [result appendString:prefix];
    }
    NSUInteger insertedEnd = insertedLength + arg4.location;
    NSString *suffix = [[self class] sanitizePartialString:[partial substringFromIndex:insertedEnd]];

    if (insertedLength != 0) {
        NSString *inserted = [[self class] sanitizePartialString:[partial substringWithRange:NSMakeRange(arg4.location, insertedLength)]];
        if ([inserted length] != 0 && [result length] != 0 &&
            [inserted characterAtIndex:0] == ',' && [result characterAtIndex:[result length] - 1] == ',') {
            inserted = [inserted substringFromIndex:1];
        }
        if ([inserted length] != 0 && [suffix length] != 0 &&
            [inserted characterAtIndex:[inserted length] - 1] == ',' && [suffix characterAtIndex:0] == ',') {
            inserted = [inserted substringToIndex:[inserted length] - 1];
        }
        if ([inserted length] == 0 && arg4.length != 0) {
            inserted = [arg3 substringWithRange:arg4];
            selectionLocation = [result length];
            selectionLength = [inserted length];
        } else if (arg2->location < insertedEnd) {
            BOOL selectsInsertion = arg2->location == arg4.location && arg2->length == insertedLength;
            selectionLocation = [result length] + (selectsInsertion ? 0 : [inserted length]);
            selectionLength = selectsInsertion ? [inserted length] : 0;
        } else {
            selectionLocation = selectionLocation - insertedLength + [inserted length];
            selectionLength = arg2->length;
        }
        [result appendString:inserted];
    }
    [result appendString:suffix];

    NSAssert(selectionLocation + selectionLength <= [result length], @"new selection range extends beyond end of new string");
    if (selectionLocation > [result length]) {
        selectionLength = 0;
        selectionLocation = [result length];
    } else if (selectionLocation + selectionLength > [result length]) {
        selectionLength = [result length] - selectionLocation;
    }

    if (selectionLocation == arg2->location && selectionLength == arg2->length && [result isEqualToString:*arg1]) {
        return YES;
    }
    *arg1 = result;
    *arg2 = NSMakeRange(selectionLocation, selectionLength);
    if (arg5) {
        *arg5 = nil;
    }
    return NO;
}

@end
