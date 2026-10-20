// InstallationNotStartedTransformer.h — CrossThrough
#ifndef InstallationNotStartedTransformer_h
#define InstallationNotStartedTransformer_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class InstallationNotStartedTransformer;

@interface InstallationNotStartedTransformer : NSValueTransformer

// Class Methods
+ (BOOL)allowsReverseTransformation;
+ (Class)transformedValueClass;

// Instance Methods
- (id)transformedValue:(id)arg1;

@end

#endif /* InstallationNotStartedTransformer_h */
