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

// Instance Methods
- (id)stringForObjectValue:(id)arg1;
- (BOOL)getObjectValue:(id)arg1 forString:(id *)arg2 errorDescription:(id)arg3;
- (BOOL)isPartialStringValid:(id *)arg1 proposedSelectedRange:(void *)arg2 originalString:(NSRange)arg3 originalSelectedRange:(id)arg4 errorDescription:(NSRange)arg5;
- (NSInteger)maxLength;
- (void)setMaxLength:(NSInteger)arg1;

@end

#endif /* RatingNotesFormatter_h */
