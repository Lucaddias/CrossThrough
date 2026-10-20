// DemoNagController.m — CrossThrough
#import "DemoNagController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation DemoNagController

- (id)init {
    self = [super initWithWindowNibName:@"DemoNag"];
    return self;
}

- (void)dealloc {
    [_completionHandler release];
    [super dealloc];
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (void)buy:(id)arg1 {
    NSString *storeURL = [[NSBundle mainBundle] localizedStringForKey:@"https://www.codeweavers.com/store/" value:@"" table:@"Vendor"];
    if (storeURL) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:storeURL]];
    }
}

- (void)showSerialCodeRegister {
    return;
}

- (void)registerapp:(id)arg1 {
    return;
}

- (void)runapp:(id)arg1 {
    [[self window] close];
    if (self->_completionHandler) {
        ((void (^)(id))self->_completionHandler)(nil);
    }
}

- (void)cancel:(id)arg1 {
    [[self window] close];
    exit(0);
}

- (void)beginWindowWithCompletionHandler:(id)arg1 {
    id block = [arg1 copy];
    [_completionHandler release];
    _completionHandler = block;
    [self showWindow:self];
}

- (id)registerButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_registerButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setRegisterButton:(id)arg1 {
    return;
}

- (id)tryNowButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_tryNowButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setTryNowButton:(id)arg1 {
    return;
}

- (id)buyButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_buyButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBuyButton:(id)arg1 {
    return;
}

- (id)quitButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_quitButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setQuitButton:(id)arg1 {
    return;
}

- (id)registerToQuitSpacer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_registerToQuitSpacer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setRegisterToQuitSpacer:(id)arg1 {
    return;
}

- (id)registerToTryNowSpacer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_registerToTryNowSpacer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setRegisterToTryNowSpacer:(id)arg1 {
    return;
}

- (id)buyToRegisterSpacer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_buyToRegisterSpacer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBuyToRegisterSpacer:(id)arg1 {
    return;
}

@end
