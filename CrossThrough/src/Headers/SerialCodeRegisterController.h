// SerialCodeRegisterController.h — CrossThrough
#ifndef SerialCodeRegisterController_h
#define SerialCodeRegisterController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "DemoBaseController.h"

@class SerialCodeRegisterController;
@class RegistrationController;

@interface SerialCodeRegisterController : DemoBaseController
{
    RegistrationController * _regController;
}

// Instance Methods
- (id)init;
- (void)registerWithSerialCode:(id)arg1;
- (void)exitSuccess;
- (void)cancel:(id)arg1;
- (void)openNormalRegistrationWindow:(id)arg1;
- (id)regController;

@end

#endif /* SerialCodeRegisterController_h */
