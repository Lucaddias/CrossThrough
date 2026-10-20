// BooleanToLabelColorTransformer.h — CrossThrough
#ifndef BooleanToLabelColorTransformer_h
#define BooleanToLabelColorTransformer_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class BooleanToLabelColorTransformer;

@interface BooleanToLabelColorTransformer : NSValueTransformer

// Class Methods
+ (BOOL)allowsReverseTransformation;
+ (Class)transformedValueClass;

// Instance Methods
- (id)transformedValue:(id)arg1;

@end

#endif /* BooleanToLabelColorTransformer_h */
