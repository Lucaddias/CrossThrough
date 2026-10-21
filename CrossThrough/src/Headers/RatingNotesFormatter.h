// RatingNotesFormatter.h — CrossThrough
#ifndef RatingNotesFormatter_h
#define RatingNotesFormatter_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class RatingNotesFormatter;

@interface RatingNotesFormatter : NSFormatter
{
    NSInteger _maxLength;
}

// Instance Methods
- (id)stringForObjectValue:(id)arg1;
- (BOOL)getObjectValue:(id *)arg1 forString:(NSString *)arg2 errorDescription:(NSString **)arg3;
- (BOOL)isPartialStringValid:(NSString **)arg1 proposedSelectedRange:(NSRangePointer)arg2 originalString:(NSString *)arg3 originalSelectedRange:(NSRange)arg4 errorDescription:(NSString **)arg5;
- (NSInteger)maxLength;
- (void)setMaxLength:(NSInteger)arg1;

@end

#endif /* RatingNotesFormatter_h */
