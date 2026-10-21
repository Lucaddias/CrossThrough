// NSString+CrossOverAdditions.m — CrossThrough
#import "NSString+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import <CommonCrypto/CommonDigest.h>
#import <pthread.h>
#import <sys/stat.h>

static pthread_once_t _initCharacterSetsOnce = PTHREAD_ONCE_INIT;
static NSCharacterSet *_emptyCharacterSet = nil;
static NSCharacterSet *_skipBetweenComponents = nil;
static NSCharacterSet *_delimitersOutsideOfQuotes = nil;
static NSCharacterSet *_asciiCharacterSet = nil;
static NSCharacterSet *_pathSeparators = nil;
static NSCharacterSet *_nonPathSeparators = nil;

static void _initCharacterSets(void) {
    _emptyCharacterSet = [[NSCharacterSet alloc] init];
    _skipBetweenComponents = [[NSCharacterSet whitespaceAndNewlineCharacterSet] copy];
    NSMutableCharacterSet *delimiters = [_skipBetweenComponents mutableCopy];
    [delimiters addCharactersInString:@"\""];
    _delimitersOutsideOfQuotes = [delimiters copy];
    [delimiters release];
    _asciiCharacterSet = [[NSCharacterSet characterSetWithRange:NSMakeRange(0, 128)] copy];
    _pathSeparators = [[NSCharacterSet characterSetWithCharactersInString:@"/\\"] copy];
    _nonPathSeparators = [[_pathSeparators invertedSet] copy];
}

@implementation NSString (CrossOverAdditions)

- (NSString *)stringQuotedForBash {
    NSMutableString *quoted = [self mutableCopy];
    [quoted replaceOccurrencesOfString:@"'" withString:@"'\\''" options:0 range:NSMakeRange(0, [quoted length])];
    [quoted insertString:@"'" atIndex:0];
    [quoted appendString:@"'"];
    NSString *result = [quoted copy];
    [quoted release];
    return [result autorelease];
}

- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)characterSet {
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:[self length]];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:characterSet];
    while (![scanner isAtEnd]) {
        NSString *chunk = nil;
        if ([scanner scanUpToCharactersFromSet:characterSet intoString:&chunk]) {
            [result appendString:chunk];
        }
    }
    NSString *copy = [result copy];
    [result release];
    return [copy autorelease];
}

// Splits on whitespace; double quotes group text (and may produce an empty
// argument) without being part of it.
- (NSArray *)componentsOfCommandLine {
    pthread_once(&_initCharacterSetsOnce, _initCharacterSets);
    NSMutableArray *components = [[NSMutableArray alloc] init];
    NSMutableString *component = [[NSMutableString alloc] init];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:_emptyCharacterSet];
    while (![scanner isAtEnd]) {
        [scanner scanCharactersFromSet:_skipBetweenComponents intoString:NULL];
        if ([scanner isAtEnd]) {
            break;
        }
        while (![scanner isAtEnd]) {
            NSString *chunk = nil;
            if ([scanner scanUpToCharactersFromSet:_delimitersOutsideOfQuotes intoString:&chunk]) {
                [component appendString:chunk];
            }
            if (![scanner scanString:@"\"" intoString:NULL]) {
                break;
            }
            NSString *quoted = nil;
            if ([scanner scanUpToString:@"\"" intoString:&quoted]) {
                [component appendString:quoted];
            }
            [scanner scanString:@"\"" intoString:NULL];
        }
        NSString *copy = [component copy];
        [components addObject:copy];
        [copy release];
        [component setString:@""];
    }
    NSArray *result = [components copy];
    [component release];
    [components release];
    return [result autorelease];
}

// Alternating runs: ASCII at even indexes (possibly empty), non-ASCII at odd.
- (NSArray *)componentsSeparatedIntoAsciiAndNonAscii {
    pthread_once(&_initCharacterSetsOnce, _initCharacterSets);
    NSMutableArray *components = [[NSMutableArray alloc] init];
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:_emptyCharacterSet];
    while (![scanner isAtEnd]) {
        NSString *ascii = nil;
        [scanner scanCharactersFromSet:_asciiCharacterSet intoString:&ascii];
        [components addObject:ascii ?: @""];
        NSString *nonAscii = nil;
        if ([scanner scanUpToCharactersFromSet:_asciiCharacterSet intoString:&nonAscii]) {
            [components addObject:nonAscii];
        }
    }
    NSArray *result = [components copy];
    [components release];
    return [result autorelease];
}

- (NSString *)asciiStringQuotedForAppleScript {
    NSMutableString *quoted = [self mutableCopy];
    [quoted replaceOccurrencesOfString:@"\"" withString:@"\" & quote & \"" options:0 range:NSMakeRange(0, [quoted length])];
    [quoted replaceOccurrencesOfString:@"\\" withString:@"\" & (ASCII character 92) & \"" options:0 range:NSMakeRange(0, [quoted length])];
    [quoted replaceOccurrencesOfString:@"\n" withString:@"\" & return & \"" options:0 range:NSMakeRange(0, [quoted length])];
    [quoted insertString:@"\"" atIndex:0];
    [quoted appendString:@"\""];
    NSString *result = [quoted copy];
    [quoted release];
    return [result autorelease];
}

// «data utf8…» literal, so non-ASCII text survives any script encoding.
- (NSString *)nonAsciiStringQuotedForAppleScript {
    if ([self length] == 0) {
        return @"\"\"";
    }
    NSMutableString *quoted = [[NSMutableString alloc] initWithUTF8String:"(\xC2\xAB" "data utf8"];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char *bytes = [data bytes];
    for (NSUInteger i = 0; i < [data length]; i++) {
        [quoted appendFormat:@"%02x", bytes[i]];
    }
    [quoted appendString:[NSString stringWithUTF8String:"\xC2\xBB as Unicode text)"]];
    NSString *result = [quoted copy];
    [quoted release];
    return [result autorelease];
}

- (NSString *)stringQuotedForAppleScript {
    if ([self length] == 0) {
        return @"\"\"";
    }
    NSMutableString *quoted = [[NSMutableString alloc] init];
    NSArray *components = [self componentsSeparatedIntoAsciiAndNonAscii];
    for (NSUInteger i = 0; i < [components count]; i++) {
        if (i != 0) {
            [quoted appendString:@" & "];
        }
        NSString *component = [components objectAtIndex:i];
        [quoted appendString:(i & 1) ? [component nonAsciiStringQuotedForAppleScript] : [component asciiStringQuotedForAppleScript]];
    }
    NSString *result = [quoted copy];
    [quoted release];
    return [result autorelease];
}

- (const char *)decomposedUTF8String {
    return [[self decomposedStringWithCanonicalMapping] UTF8String];
}

- (NSString *)stringInFileSystemRepresentationForm {
    const char *representation = [self fileSystemRepresentation];
    return [[NSFileManager defaultManager] stringWithFileSystemRepresentation:representation length:strlen(representation)];
}

- (BOOL)localizedStandardGreaterThan:(NSString *)other {
    return [self localizedStandardCompare:other] == NSOrderedDescending;
}

- (BOOL)localizedStandardLessThan:(NSString *)other {
    return [self localizedStandardCompare:other] == NSOrderedAscending;
}

// Last component of a Unix or Windows path, ignoring a drive prefix and
// trailing separators; "/" when there is none.
- (NSString *)lastUnixOrWindowsPathComponent {
    pthread_once(&_initCharacterSetsOnce, _initCharacterSets);
    NSRange colon = [self rangeOfString:@":" options:NSBackwardsSearch];
    NSUInteger start = colon.location == NSNotFound ? 0 : NSMaxRange(colon);
    NSRange last = [self rangeOfCharacterFromSet:_nonPathSeparators options:NSBackwardsSearch range:NSMakeRange(start, [self length] - start)];
    if (last.location == NSNotFound) {
        return @"/";
    }
    NSUInteger end = NSMaxRange(last);
    NSRange separator = [self rangeOfCharacterFromSet:_pathSeparators options:NSBackwardsSearch range:NSMakeRange(start, end - start)];
    if (separator.location == NSNotFound) {
        return [self substringWithRange:NSMakeRange(start, end - start)];
    }
    return [self substringWithRange:NSMakeRange(NSMaxRange(separator), end - NSMaxRange(separator))];
}

- (NSString *)MD5 {
    const char *string = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, (CC_LONG)strlen(string), digest);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            digest[0], digest[1], digest[2], digest[3], digest[4], digest[5], digest[6], digest[7],
            digest[8], digest[9], digest[10], digest[11], digest[12], digest[13], digest[14], digest[15]];
}

// Resolves every component of an absolute path; nil if any step fails.
- (NSString *)stringByResolvingSymlinksAndAliases {
    NSString *path = [self stringByStandardizingPath];
    if (![path hasPrefix:@"/"]) {
        return nil;
    }
    NSArray *components = [path pathComponents];
    NSString *resolved = [components objectAtIndex:0];
    for (NSString *component in [components subarrayWithRange:NSMakeRange(1, [components count] - 1)]) {
        resolved = [[resolved stringByAppendingPathComponent:component] stringByIterativelyResolvingSymlinkOrAlias];
        if (!resolved) {
            return nil;
        }
    }
    return resolved;
}

// Follows symlinks and aliases at this path until it reaches something that
// is neither; nil if a link cannot be read or a target is missing.
- (NSString *)stringByIterativelyResolvingSymlinkOrAlias {
    NSString *path = self;
    struct stat info;
    if (lstat([[NSFileManager defaultManager] fileSystemRepresentationWithPath:path], &info) < 0) {
        return nil;
    }
    while (YES) {
        NSString *next = nil;
        if (S_ISLNK(info.st_mode)) {
            next = [path stringByConditionallyResolvingSymlink];
            if (!next) {
                return nil;
            }
        } else if (!S_ISDIR(info.st_mode)) {
            next = [path stringByConditionallyResolvingAlias];
        }
        if (!next) {
            return path;
        }
        path = next;
        if (lstat([[NSFileManager defaultManager] fileSystemRepresentationWithPath:path], &info) < 0) {
            return nil;
        }
    }
}

- (NSString *)stringByResolvingAlias {
    return [self stringByConditionallyResolvingAlias] ?: self;
}

- (NSString *)stringByResolvingSymlink {
    return [self stringByConditionallyResolvingSymlink] ?: self;
}

- (NSString *)stringByConditionallyResolvingSymlink {
    NSString *destination = [[NSFileManager defaultManager] destinationOfSymbolicLinkAtPath:self error:nil];
    if (destination && ![destination hasPrefix:@"/"]) {
        return [[[self stringByDeletingLastPathComponent] stringByAppendingPathComponent:destination] stringByStandardizingPath];
    }
    return destination;
}

- (NSString *)stringByConditionallyResolvingAlias {
    NSURL *url = [NSURL fileURLWithPath:self];
    if (!url) {
        return nil;
    }
    NSData *bookmark = [NSURL bookmarkDataWithContentsOfURL:url error:nil];
    if (!bookmark) {
        return nil;
    }
    BOOL isStale = NO;
    NSURL *resolved = [NSURL URLByResolvingBookmarkData:bookmark
                                                options:NSURLBookmarkResolutionWithoutUI | NSURLBookmarkResolutionWithoutMounting
                                          relativeToURL:nil
                                    bookmarkDataIsStale:&isStale
                                                  error:nil];
    return [resolved path];
}

@end
