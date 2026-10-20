// NSMutableAttributedString+CrossOverAdditions.m — CrossThrough
#import "NSMutableAttributedString+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSMutableAttributedString (CrossOverAdditions)

+ (id)cx_attributedStringWithHTML:(id)arg1 font:(id)arg2 {
    if (!arg1) return nil;
    NSData *data = [arg1 dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) return nil;

    NSDictionary *options = @{ NSCharacterEncodingDocumentOption: @(NSUTF8StringEncoding) };
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithHTML:data options:options documentAttributes:NULL];
    if (!str) {
        str = [[NSMutableAttributedString alloc] initWithString:arg1];
    }

    NSFont *font = arg2;
    if (!font) {
        font = [NSFont systemFontOfSize:[NSFont systemFontSize]];
    }

    if ([str length] > 0) {
        [str addAttribute:NSForegroundColorAttributeName value:[NSColor labelColor] range:NSMakeRange(0, [str length])];
        if (font) {
            [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [str length])];
        }
        [str cx_removeTrailingWhitespaceAndNewlines];
    }

    return [str autorelease];
}

+ (id)cx_attributedStringWithHTML:(id)arg1 {
    return [self cx_attributedStringWithHTML:arg1 font:nil];
}

- (void)cx_removeTrailingWhitespaceAndNewlines {
    NSRange r = [[self string] rangeOfString:@"[\\s\\v]+$" options:NSRegularExpressionSearch];
    if (r.location != NSNotFound) {
        [self deleteCharactersInRange:r];
    }
}

@end
