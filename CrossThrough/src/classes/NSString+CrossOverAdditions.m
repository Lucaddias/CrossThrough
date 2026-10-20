// NSString+CrossOverAdditions.m — CrossThrough
#import "NSString+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSString (CrossOverAdditions)

- (NSString *)stringQuotedForBash {
    NSMutableString *str = [self mutableCopy];
    [str replaceOccurrencesOfString:@"'" withString:@"'\\''" options:0 range:NSMakeRange(0, [str length])];
    [str insertString:@"'" atIndex:0];
    [str appendString:@"'"];
    NSString *res = [str copy];
    [str release];
    return [res autorelease];
}

- (NSString *)stringInFileSystemRepresentationForm {
    const char *fsRep = [self fileSystemRepresentation];
    if (!fsRep) {
        return self;
    }
    return [[NSFileManager defaultManager] stringWithFileSystemRepresentation:fsRep length:strlen(fsRep)];
}

- (NSString *)stringQuotedForAppleScript {
    if ([self length] == 0) {
        return @"\"\"";
    }
    NSMutableString *s = [self mutableCopy];
    [s replaceOccurrencesOfString:@"\\" withString:@"\\\\" options:0 range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:0 range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\" & return & \"" options:0 range:NSMakeRange(0, [s length])];
    [s insertString:@"\"" atIndex:0];
    [s appendString:@"\""];
    NSString *res = [s copy];
    [s release];
    return [res autorelease];
}

- (NSArray *)componentsOfCommandLine {
    NSMutableArray *components = [NSMutableArray array];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@" \t\r\n\""];
    
    while (![scanner isAtEnd]) {
        [scanner scanCharactersFromSet:whitespace intoString:nil];
        if ([scanner isAtEnd]) break;
        
        NSMutableString *component = [NSMutableString string];
        while (![scanner isAtEnd]) {
            NSString *chunk = nil;
            if ([scanner scanUpToCharactersFromSet:delimiters intoString:&chunk]) {
                [component appendString:chunk];
            }
            if ([scanner scanString:@"\"" intoString:nil]) {
                NSString *insideQuote = nil;
                [scanner scanUpToString:@"\"" intoString:&insideQuote];
                if (insideQuote) {
                    [component appendString:insideQuote];
                }
                [scanner scanString:@"\"" intoString:nil];
            } else {
                break;
            }
        }
        if ([component length] > 0) {
            [components addObject:component];
        }
    }
    return components;
}

- (NSString *)lastUnixOrWindowsPathComponent {
    NSArray *parts = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/\\"]];
    for (NSInteger i = (NSInteger)[parts count] - 1; i >= 0; i--) {
        NSString *p = [parts objectAtIndex:(NSUInteger)i];
        if ([p length] > 0) {
            return p;
        }
    }
    return self;
}

@end
