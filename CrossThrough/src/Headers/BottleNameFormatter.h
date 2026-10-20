// BottleNameFormatter.h — CrossThrough
#ifndef BottleNameFormatter_h
#define BottleNameFormatter_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class BottleNameFormatter;

@interface BottleNameFormatter : NSFormatter

// Class Methods
+ (BOOL)accessInstanceVariablesDirectly;

// Instance Methods
- (id)stringForObjectValue:(id)arg1;
- (BOOL)getObjectValue:(id *)arg1 forString:(id)arg2 errorDescription:(id *)arg3;
- (BOOL)isPartialStringValid:(id)arg1 newEditingString:(id *)arg2 errorDescription:(id *)arg3;

@end

#endif /* BottleNameFormatter_h */
