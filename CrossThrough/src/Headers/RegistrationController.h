// RegistrationController.h — CrossThrough
#ifndef RegistrationController_h
#define RegistrationController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class RegistrationController;

@interface RegistrationController : CXObject <NSFileManagerDelegate, NSObject>
{
    Class registrarClass;
    NSURLSession * session;
    NSURLSessionTask * downloadTask;
    SFAuthorization * authorization;
    NSString * localPrefsFolder;
    NSString * globalPrefsFolder;
    NSInteger _registrationWorkInProgress;
    NSInteger _regMode;
    NSString * _login;
    NSString * _login2;
    NSString * _loginErrorText;
    NSString * _password;
    NSString * _password2;
    NSString * _passwordErrorText;
    NSString * _globalRegModeCaption;
    NSString * _accountName;
    NSString * _serialCode;
    NSString * _serialCodeErrorText;
    id /* block */ _completionHandler;
}

// Instance Methods
- (id)init;
- (BOOL)authIfNeeded;
- (id)formatSerialCode:(id)arg1;
- (void)beginRegisterAppWithSerialCodeWithCompletionHandler:(id)arg1;
- (void)beginRegisterAppWithCompletionHandler:(id)arg1;
- (void)handleRegistrationData:(id)arg1;
- (void)handleSerialCodeAccountCreationData:(id)arg1;
- (void)downloadTaskCompleted:(id)arg1 response:(id)arg2 error:(id)arg3 successHandler:(id)arg4 errorMessageText:(id)arg5;
- (BOOL)moveFile:(id)arg1 dest:(id)arg2;
- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 movingItemAtURL:(id)arg3 toURL:(id)arg4;
- (void)cancel;
- (BOOL)validLogin;
- (BOOL)validPassword;
- (BOOL)validSerialCode;
- (id)login;
- (void)setLogin:(id)arg1;
- (id)login2;
- (void)setLogin2:(id)arg1;
- (id)loginErrorText;
- (void)setLoginErrorText:(id)arg1;
- (id)password;
- (void)setPassword:(id)arg1;
- (id)password2;
- (void)setPassword2:(id)arg1;
- (id)passwordErrorText;
- (void)setPasswordErrorText:(id)arg1;
- (NSInteger)registrationWorkInProgress;
- (void)setRegistrationWorkInProgress:(NSInteger)arg1;
- (NSInteger)regMode;
- (void)setRegMode:(NSInteger)arg1;
- (id)globalRegModeCaption;
- (void)setGlobalRegModeCaption:(id)arg1;
- (id)accountName;
- (void)setAccountName:(id)arg1;
- (id)serialCode;
- (void)setSerialCode:(id)arg1;
- (id)serialCodeErrorText;
- (void)setSerialCodeErrorText:(id)arg1;
- (void (^)(BOOL, NSString *, NSString *))completionHandler;
- (void)setCompletionHandler:(id)arg1;

@end

#endif /* RegistrationController_h */
