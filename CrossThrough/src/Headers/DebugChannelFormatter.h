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
- (BOOL)getObjectValue:(id *)arg1 forString:(NSString *)arg2 errorDescription:(NSString **)arg3;
- (BOOL)isPartialStringValid:(NSString **)arg1 proposedSelectedRange:(NSRangePointer)arg2 originalString:(NSString *)arg3 originalSelectedRange:(NSRange)arg4 errorDescription:(NSString **)arg5;

@end

#endif /* DebugChannelFormatter_h */
