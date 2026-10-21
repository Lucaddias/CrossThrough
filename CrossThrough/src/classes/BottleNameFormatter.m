// BottleNameFormatter.m — CrossThrough
#import "BottleNameFormatter.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BottleNameFormatter

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

- (id)stringForObjectValue:(id)arg1 {
    if ([arg1 isKindOfClass:[NSString class]]) {
        return arg1;
    }
    if ([arg1 isKindOfClass:[NSAttributedString class]]) {
        return [(NSAttributedString *)arg1 string];
    }
    return nil;
}

- (BOOL)getObjectValue:(id *)arg1 forString:(id)arg2 errorDescription:(id *)arg3 {
    *arg1 = [[arg2 copy] autorelease];
    return YES;
}

- (BOOL)isPartialStringValid:(id)arg1 newEditingString:(id *)arg2 errorDescription:(id *)arg3 {
    NSCharacterSet *invalidChars = [NSCharacterSet characterSetWithCharactersInString:@"\\/*?:|<>\"'{}"];
    if ([arg1 rangeOfCharacterFromSet:invalidChars].location != NSNotFound) {
        return NO;
    }
    if ([arg1 hasPrefix:@"."]) {
        return NO;
    }
    return YES;
}

@end
