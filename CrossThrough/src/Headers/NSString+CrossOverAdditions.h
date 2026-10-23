// NSString+CrossOverAdditions.h — CrossThrough
#ifndef NSString_CrossOverAdditions_h
#define NSString_CrossOverAdditions_h

#import <Cocoa/Cocoa.h>

@interface NSString (CrossOverAdditions)

- (NSString *)stringQuotedForBash;
- (NSString *)stringByRemovingCharactersInSet:(NSCharacterSet *)set;
- (NSArray *)componentsOfCommandLine;
- (NSArray *)componentsSeparatedIntoAsciiAndNonAscii;
- (NSString *)asciiStringQuotedForAppleScript;
- (NSString *)nonAsciiStringQuotedForAppleScript;
- (NSString *)stringQuotedForAppleScript;
- (const char *)decomposedUTF8String;
- (NSString *)stringInFileSystemRepresentationForm;
- (BOOL)localizedStandardGreaterThan:(NSString *)other;
- (BOOL)localizedStandardLessThan:(NSString *)other;
- (NSString *)lastUnixOrWindowsPathComponent;
- (NSString *)MD5;
- (NSString *)stringByResolvingSymlinksAndAliases;
- (NSString *)stringByIterativelyResolvingSymlinkOrAlias;
- (NSString *)stringByResolvingAlias;
- (NSString *)stringByResolvingSymlink;
- (NSString *)stringByConditionallyResolvingSymlink;
- (NSString *)stringByConditionallyResolvingAlias;

@end

#endif /* NSString_CrossOverAdditions_h */
