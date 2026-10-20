// LoggingOption.h — CrossThrough
#ifndef LoggingOption_h
#define LoggingOption_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class LoggingOption;

@interface LoggingOption : NSObject
{
    NSString * _name;
    NSArray * _logChannels;
    NSArray * _logEnvironment;
}

// Class Methods
+ (id)loggingOptionWithName:(id)arg1 channels:(id)arg2 environment:(id)arg3;
+ (id)loggingOptionWithName:(id)arg1 channels:(id)arg2;
+ (id)commonPresets;

// Instance Methods
- (id)initWithName:(id)arg1 channels:(id)arg2 environment:(id)arg3;
- (id)name;
- (void)setName:(id)arg1;
- (id)logChannels;
- (void)setLogChannels:(id)arg1;
- (id)logEnvironment;
- (void)setLogEnvironment:(id)arg1;

@end

#endif /* LoggingOption_h */
