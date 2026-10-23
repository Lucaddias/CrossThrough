// NSString+CrossOverAdditions.m — CrossThrough
// Ported from CrossOver 26.3 arm64 (0x10002e684..0x10002f078, 0x100053dc0,
// 0x100059b64..0x100059e2c).
#import "NSString+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "c_functions.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/stat.h>
#import <pthread.h>

static pthread_once_t _initCharacterSetsOnce = PTHREAD_ONCE_INIT;
static NSCharacterSet *_emptyCharacterSet;
static NSCharacterSet *_skipBetweenComponents;
static NSCharacterSet *_delimitersOutsideOfQuotes;
static NSCharacterSet *_asciiCharacterSet;
static NSCharacterSet *_pathSeparators;
static NSCharacterSet *_nonPathSeparators;

void _initCharacterSets(void) {
    _emptyCharacterSet = [[NSCharacterSet alloc] init];
    _skipBetweenComponents = [[NSCharacterSet whitespaceAndNewlineCharacterSet] copy];
    NSMutableCharacterSet *delimiters = [_skipBetweenComponents mutableCopy];
    [delimiters addCharactersInString:@"\""];
    _delimitersOutsideOfQuotes = [delimiters copy];
    _asciiCharacterSet = [[NSCharacterSet characterSetWithRange:NSMakeRange(0, 0x80)] copy];
    _pathSeparators = [[NSCharacterSet characterSetWithCharactersInString:@"/\\"] copy];
    _nonPathSeparators = [[_pathSeparators invertedSet] copy];
}

@implementation NSString (CrossOverAdditions)

- (NSString *)stringQuotedForBash {
    NSMutableString *quoted = [self mutableCopy];
    [quoted replaceOccurrencesOfString:@"'" withString:@"'\\''" options:0 range:NSMakeRange(0, [quoted length])];
    [quoted insertString:@"'" atIndex:0];
    [quoted appendString:@"'"];
    return [quoted copy];
}

- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)set {
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:[self length]];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:set];
    while (![scanner isAtEnd]) {
        NSString *chunk = nil;
        if ([scanner scanUpToCharactersFromSet:set intoString:&chunk]) {
            [result appendString:chunk];
        }
    }
    return [result copy];
}

- (NSArray *)componentsOfCommandLine {
    pthread_once(&_initCharacterSetsOnce, _initCharacterSets);
    NSMutableArray *components = [[NSMutableArray alloc] init];
    NSMutableString *current = [[NSMutableString alloc] init];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:_emptyCharacterSet];
    while (![scanner isAtEnd]) {
        [scanner scanCharactersFromSet:_skipBetweenComponents intoString:NULL];
        if ([scanner isAtEnd]) {
            break;
        }
        while (![scanner isAtEnd]) {
            NSString *unquoted = nil;
            if ([scanner scanUpToCharactersFromSet:_delimitersOutsideOfQuotes intoString:&unquoted]) {
                [current appendString:unquoted];
            }
            if (![scanner scanString:@"\"" intoString:NULL]) {
                break;
            }
            NSString *quoted = nil;
            if ([scanner scanUpToString:@"\"" intoString:&quoted]) {
                [current appendString:quoted];
            }
            [scanner scanString:@"\"" intoString:NULL];
        }
        [components addObject:[current copy]];
        [current setString:@""];
    }
    return [components copy];
}

- (NSArray *)componentsSeparatedIntoAsciiAndNonAscii {
    pthread_once(&_initCharacterSetsOnce, _initCharacterSets);
    NSMutableArray *components = [[NSMutableArray alloc] init];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:_emptyCharacterSet];
    while (![scanner isAtEnd]) {
        // Even indexes are ASCII runs (possibly empty), odd ones non-ASCII.
        NSString *ascii = nil;
        [scanner scanCharactersFromSet:_asciiCharacterSet intoString:&ascii];
        [components addObject:ascii ? ascii : @""];
        NSString *nonAscii = nil;
        if ([scanner scanUpToCharactersFromSet:_asciiCharacterSet intoString:&nonAscii]) {
            [components addObject:nonAscii];
        }
    }
    return [components copy];
}

- (NSString *)asciiStringQuotedForAppleScript {
    NSMutableString *quoted = [self mutableCopy];
    [quoted replaceOccurrencesOfString:@"\"" withString:@"\" & quote & \"" options:0 range:NSMakeRange(0, [quoted length])];
    [quoted replaceOccurrencesOfString:@"\\" withString:@"\" & (ASCII character 92) & \"" options:0 range:NSMakeRange(0, [quoted length])];
    [quoted replaceOccurrencesOfString:@"\n" withString:@"\" & return & \"" options:0 range:NSMakeRange(0, [quoted length])];
    [quoted insertString:@"\"" atIndex:0];
    [quoted appendString:@"\""];
    return [quoted copy];
}

- (NSString *)nonAsciiStringQuotedForAppleScript {
    if ([self length] == 0) {
        return @"\"\"";
    }
    NSMutableString *quoted = [[NSMutableString alloc] initWithUTF8String:"(\xC2\xAB" "data utf8"];
    NSData *utf8 = [self dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char *bytes = [utf8 bytes];
    for (NSUInteger i = 0; i < [utf8 length]; i++) {
        [quoted appendFormat:@"%02x", bytes[i]];
    }
    [quoted appendString:[NSString stringWithUTF8String:"\xC2\xBB as Unicode text)"]];
    return [quoted copy];
}

- (NSString *)stringQuotedForAppleScript {
    if ([self length] == 0) {
        return @"\"\"";
    }
    NSMutableString *quoted = [[NSMutableString alloc] init];
    NSArray *parts = [self componentsSeparatedIntoAsciiAndNonAscii];
    for (NSUInteger i = 0; i < [parts count]; i++) {
        if (i != 0) {
            [quoted appendString:@" & "];
        }
        NSString *part = [parts objectAtIndex:i];
        [quoted appendString:(i & 1) ? [part nonAsciiStringQuotedForAppleScript] : [part asciiStringQuotedForAppleScript]];
    }
    return [quoted copy];
}

- (const char *)decomposedUTF8String {
    return [[self decomposedStringWithCanonicalMapping] UTF8String];
}

- (NSString *)stringInFileSystemRepresentationForm {
    const char *path = [self fileSystemRepresentation];
    return [[NSFileManager defaultManager] stringWithFileSystemRepresentation:path length:strlen(path)];
}

- (BOOL)localizedStandardGreaterThan:(NSString *)other {
    return [self localizedStandardCompare:other] == NSOrderedDescending;
}

- (BOOL)localizedStandardLessThan:(NSString *)other {
    return [self localizedStandardCompare:other] == NSOrderedAscending;
}

- (NSString *)lastUnixOrWindowsPathComponent {
    pthread_once(&_initCharacterSetsOnce, _initCharacterSets);
    // Skip a "C:" style drive prefix, then take the last run of
    // non-separator characters.
    NSUInteger start = 0;
    NSRange colon = [self rangeOfString:@":" options:NSBackwardsSearch];
    if (colon.location != NSNotFound) {
        start = colon.location + colon.length;
    }
    NSRange search = NSMakeRange(start, [self length] - start);
    NSRange lastChar = [self rangeOfCharacterFromSet:_nonPathSeparators options:NSBackwardsSearch range:search];
    if (lastChar.location == NSNotFound) {
        return @"/";
    }
    NSUInteger end = lastChar.location + lastChar.length;
    NSRange separator = [self rangeOfCharacterFromSet:_pathSeparators options:NSBackwardsSearch range:NSMakeRange(start, end - start)];
    NSUInteger from = (separator.location == NSNotFound) ? start : separator.location + separator.length;
    return [self substringWithRange:NSMakeRange(from, end - from)];
}

- (NSString *)MD5 {
    const char *utf8 = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CC_MD5(utf8, (CC_LONG)strlen(utf8), digest);
#pragma clang diagnostic pop
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            digest[0], digest[1], digest[2], digest[3], digest[4], digest[5], digest[6], digest[7],
            digest[8], digest[9], digest[10], digest[11], digest[12], digest[13], digest[14], digest[15]];
}

- (NSString *)stringByResolvingSymlinksAndAliases {
    NSString *path = [self stringByStandardizingPath];
    if (![path hasPrefix:@"/"]) {
        return nil;
    }
    NSArray *components = [path pathComponents];
    NSString *resolved = [components objectAtIndex:0];
    for (NSString *component in [components subarrayWithRange:NSMakeRange(1, [components count] - 1)]) {
        resolved = [[resolved stringByAppendingPathComponent:component] stringByIterativelyResolvingSymlinkOrAlias];
        if (resolved == nil) {
            return nil;
        }
    }
    return resolved;
}

- (NSString *)stringByIterativelyResolvingSymlinkOrAlias {
    NSString *path = self;
    struct stat st;
    if (lstat([[NSFileManager defaultManager] fileSystemRepresentationWithPath:path], &st) < 0) {
        return nil;
    }
    while (YES) {
        NSString *next;
        if ((st.st_mode & S_IFMT) == S_IFLNK) {
            next = [path stringByConditionallyResolvingSymlink];
        } else if ((st.st_mode & S_IFMT) == S_IFDIR) {
            return path;
        } else {
            next = [path stringByConditionallyResolvingAlias];
            if (next == nil) {
                return path;
            }
        }
        if (next == nil) {
            return nil;
        }
        if (lstat([[NSFileManager defaultManager] fileSystemRepresentationWithPath:next], &st) < 0) {
            return nil;
        }
        path = next;
    }
}

- (NSString *)stringByResolvingAlias {
    NSString *resolved = [self stringByConditionallyResolvingAlias];
    return resolved ? resolved : self;
}

- (NSString *)stringByResolvingSymlink {
    NSString *resolved = [self stringByConditionallyResolvingSymlink];
    return resolved ? resolved : self;
}

- (NSString *)stringByConditionallyResolvingSymlink {
    NSString *destination = [[NSFileManager defaultManager] destinationOfSymbolicLinkAtPath:self error:nil];
    if (destination != nil && ![destination hasPrefix:@"/"]) {
        return [[[self stringByDeletingLastPathComponent] stringByAppendingPathComponent:destination] stringByStandardizingPath];
    }
    return destination;
}

- (NSString *)stringByConditionallyResolvingAlias {
    NSURL *url = [NSURL fileURLWithPath:self];
    if (url == nil) {
        return nil;
    }
    NSData *bookmark = [NSURL bookmarkDataWithContentsOfURL:url error:nil];
    if (bookmark == nil) {
        return nil;
    }
    BOOL stale;
    NSURL *resolved = [NSURL URLByResolvingBookmarkData:bookmark
                                                options:NSURLBookmarkResolutionWithoutUI | NSURLBookmarkResolutionWithoutMounting
                                          relativeToURL:nil
                                    bookmarkDataIsStale:&stale
                                                  error:nil];
    return [resolved path];
}

@end
