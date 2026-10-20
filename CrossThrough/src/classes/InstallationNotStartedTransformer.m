// InstallationNotStartedTransformer.m — CrossThrough
#import "InstallationNotStartedTransformer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallationNotStartedTransformer

+ (void)load {
    [NSValueTransformer setValueTransformer:[[self alloc] init] forName:@"InstallationNotStartedTransformer"];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

+ (Class)transformedValueClass {
    return [NSNumber class];
}

- (id)transformedValue:(id)arg1 {
    int val = [arg1 respondsToSelector:@selector(intValue)] ? [arg1 intValue] : 0;
    return [NSNumber numberWithBool:(val != 1)];
}

@end
