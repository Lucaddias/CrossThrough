// CXSparkleUserDriver.h — CrossThrough
#ifndef CXSparkleUserDriver_h
#define CXSparkleUserDriver_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXSparkleUserDriver;

@interface CXSparkleUserDriver : SPUStandardUserDriver
{
    BOOL _isNotLicensed;
}

// Instance Methods
- (void)setNotLicensed:(BOOL)arg1;
- (void)showUpdateFoundWithAppcastItem:(id)arg1 state:(id)arg2 reply:(id)arg3;

@end

#endif /* CXSparkleUserDriver_h */
