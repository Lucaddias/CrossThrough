// DemoNagController.m — CrossThrough
#import "DemoNagController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation DemoNagController

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)windowDidLoad {
    return;
}

- (void)buy:(id)arg1 {
    return;
}

- (void)showSerialCodeRegister {
    return;
}

- (void)registerapp:(id)arg1 {
    return;
}

- (void)runapp:(id)arg1 {
    return;
}

- (void)cancel:(id)arg1 {
    return;
}

- (void)beginWindowWithCompletionHandler:(id)arg1 {
    return;
}

- (id)registerButton {
    return [objc_loadWeakRetained((id *)&self->_registerButton) autorelease];
}

- (void)setRegisterButton:(id)arg1 {
    objc_storeWeak((id *)&self->_registerButton, arg1);
}

- (id)tryNowButton {
    return [objc_loadWeakRetained((id *)&self->_tryNowButton) autorelease];
}

- (void)setTryNowButton:(id)arg1 {
    objc_storeWeak((id *)&self->_tryNowButton, arg1);
}

- (id)buyButton {
    return [objc_loadWeakRetained((id *)&self->_buyButton) autorelease];
}

- (void)setBuyButton:(id)arg1 {
    objc_storeWeak((id *)&self->_buyButton, arg1);
}

- (id)quitButton {
    return [objc_loadWeakRetained((id *)&self->_quitButton) autorelease];
}

- (void)setQuitButton:(id)arg1 {
    objc_storeWeak((id *)&self->_quitButton, arg1);
}

- (id)registerToQuitSpacer {
    return [objc_loadWeakRetained((id *)&self->_registerToQuitSpacer) autorelease];
}

- (void)setRegisterToQuitSpacer:(id)arg1 {
    objc_storeWeak((id *)&self->_registerToQuitSpacer, arg1);
}

- (id)registerToTryNowSpacer {
    return [objc_loadWeakRetained((id *)&self->_registerToTryNowSpacer) autorelease];
}

- (void)setRegisterToTryNowSpacer:(id)arg1 {
    objc_storeWeak((id *)&self->_registerToTryNowSpacer, arg1);
}

- (id)buyToRegisterSpacer {
    return [objc_loadWeakRetained((id *)&self->_buyToRegisterSpacer) autorelease];
}

- (void)setBuyToRegisterSpacer:(id)arg1 {
    objc_storeWeak((id *)&self->_buyToRegisterSpacer, arg1);
}

@end
