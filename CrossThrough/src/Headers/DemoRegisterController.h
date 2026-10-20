// DemoRegisterController.h — CrossThrough
#ifndef DemoRegisterController_h
#define DemoRegisterController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "DemoBaseController.h"

@class DemoRegisterController;
@class RegistrationController;

@interface DemoRegisterController : DemoBaseController <NSTextFieldDelegate, NSControlTextEditingDelegate, NSObject>
{
    BOOL _refreshLicenseMode;
    RegistrationController * _regController;
    NSLayoutConstraint * _alreadyPurchasedToEmailSpacer;
    NSTextField * _referToStoreTextField;
    NSTextField * _forgotPasswordTextField;
}

// Class Methods
+ (id)keyPathsForValuesAffectingCanRegister;

// Instance Methods
- (id)init;
- (void)setRefreshLicenseMode:(BOOL)arg1;
- (void)windowDidLoad;
- (BOOL)canRegister;
- (void)registerapp:(id)arg1;
- (void)openSerialCodeWindow:(id)arg1;
- (void)cancel:(id)arg1;
- (void)exitSuccess;
- (void)controlTextDidChange:(id)arg1;
- (id)regController;
- (BOOL)refreshLicenseMode;
- (id)alreadyPurchasedToEmailSpacer;
- (void)setAlreadyPurchasedToEmailSpacer:(id)arg1;
- (id)referToStoreTextField;
- (void)setReferToStoreTextField:(id)arg1;
- (id)forgotPasswordTextField;
- (void)setForgotPasswordTextField:(id)arg1;

@end

#endif /* DemoRegisterController_h */
