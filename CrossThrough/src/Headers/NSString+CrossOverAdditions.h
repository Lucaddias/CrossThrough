// NSString+CrossOverAdditions.h — CrossThrough
#ifndef NSString_CrossOverAdditions_h
#define NSString_CrossOverAdditions_h

#import <Cocoa/Cocoa.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

@interface NSString (CrossOverAdditions)

- (NSString *)stringQuotedForBash;
- (NSString *)stringQuotedForAppleScript;
- (NSString *)stringInFileSystemRepresentationForm;
- (NSArray *)componentsOfCommandLine;
- (NSString *)lastUnixOrWindowsPathComponent;

@end

#endif /* NSString_CrossOverAdditions_h */
