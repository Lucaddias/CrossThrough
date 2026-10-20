// NSAttributedString+CrossOverAdditions.m — CrossThrough
#import "NSAttributedString+CrossOverAdditions.h"
#import "NSMutableAttributedString+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSAttributedString (CrossOverAdditions)

+ (id)cx_attributedStringWithHTML:(id)arg1 font:(id)arg2 {
    return [NSMutableAttributedString cx_attributedStringWithHTML:arg1 font:arg2];
}

+ (id)cx_attributedStringWithHTML:(id)arg1 {
    return [NSMutableAttributedString cx_attributedStringWithHTML:arg1];
}

- (id)cx_attributedStringByRemovingTrailingWhitespaceAndNewlines {
    NSMutableAttributedString *str = [[self mutableCopy] autorelease];
    [str cx_removeTrailingWhitespaceAndNewlines];
    return str;
}

@end
