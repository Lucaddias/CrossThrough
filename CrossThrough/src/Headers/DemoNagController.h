// DemoNagController.h — CrossThrough
#ifndef DemoNagController_h
#define DemoNagController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "DemoBaseController.h"

@class DemoNagController;

@interface DemoNagController : DemoBaseController
{
    id /* block */ _completionHandler;
    NSButton * _registerButton;
    NSButton * _tryNowButton;
    NSButton * _buyButton;
    NSButton * _quitButton;
    NSLayoutConstraint * _registerToQuitSpacer;
    NSLayoutConstraint * _registerToTryNowSpacer;
    NSLayoutConstraint * _buyToRegisterSpacer;
}

// Instance Methods
- (id)init;
- (void)windowDidLoad;
- (void)buy:(id)arg1;
- (void)showSerialCodeRegister;
- (void)registerapp:(id)arg1;
- (void)runapp:(id)arg1;
- (void)cancel:(id)arg1;
- (void)beginWindowWithCompletionHandler:(id)arg1;
- (id)registerButton;
- (void)setRegisterButton:(id)arg1;
- (id)tryNowButton;
- (void)setTryNowButton:(id)arg1;
- (id)buyButton;
- (void)setBuyButton:(id)arg1;
- (id)quitButton;
- (void)setQuitButton:(id)arg1;
- (id)registerToQuitSpacer;
- (void)setRegisterToQuitSpacer:(id)arg1;
- (id)registerToTryNowSpacer;
- (void)setRegisterToTryNowSpacer:(id)arg1;
- (id)buyToRegisterSpacer;
- (void)setBuyToRegisterSpacer:(id)arg1;

@end

#endif /* DemoNagController_h */
