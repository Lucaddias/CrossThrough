// BooleanToLabelColorTransformer.m — CrossThrough
#import "BooleanToLabelColorTransformer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BooleanToLabelColorTransformer

+ (void)load {
    [NSValueTransformer setValueTransformer:[[self alloc] init] forName:@"BooleanToLabelColorTransformer"];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

+ (Class)transformedValueClass {
    return [NSColor class];
}

- (id)transformedValue:(id)arg1 {
    if ([arg1 respondsToSelector:@selector(boolValue)] && [arg1 boolValue]) {
        return [NSColor controlTextColor];
    } else {
        return [NSColor disabledControlTextColor];
    }
}

@end
