// DebugChannelFormatter.h — CrossThrough
#ifndef DebugChannelFormatter_h
#define DebugChannelFormatter_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class DebugChannelFormatter;

@interface DebugChannelFormatter : NSFormatter

// Class Methods
+ (id)sanitizePartialString:(id)arg1;
+ (id)sanitizeChannelString:(id)arg1;

// Instance Methods
- (id)stringForObjectValue:(id)arg1;
- (BOOL)getObjectValue:(id)arg1 forString:(id *)arg2 errorDescription:(id)arg3;
- (BOOL)isPartialStringValid:(id *)arg1 proposedSelectedRange:(void *)arg2 originalString:(NSRange)arg3 originalSelectedRange:(id)arg4 errorDescription:(NSRange)arg5;

@end

#endif /* DebugChannelFormatter_h */
