// DemoNagController.m — CrossThrough
#import "DemoNagController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "c_functions.h"

@implementation DemoNagController

- (id)init {
    return [self initWithWindowNibName:@"DemoNag"];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    _CXLog(@"We are keeping the unlock button.\n");
    [[self registerButton] setHidden:NO];
    [[self registerButton] setEnabled:YES];

    // Close the gaps left by whichever buttons the nib hides.
    if ([[self quitButton] isHiddenOrHasHiddenAncestor]) {
        [[[self quitButton] superview] removeConstraint:[self registerToQuitSpacer]];
        if ([[self window] initialFirstResponder] == [self quitButton]) {
            [[self window] setInitialFirstResponder:[self buyButton]];
        }
    }
    if ([[self tryNowButton] isHiddenOrHasHiddenAncestor]) {
        [[[self tryNowButton] superview] removeConstraint:[self registerToTryNowSpacer]];
    }
    if ([[self registerButton] isHiddenOrHasHiddenAncestor]) {
        [[[self registerButton] superview] removeConstraint:[self buyToRegisterSpacer]];
        NSButton *noButton = [[self quitButton] isHiddenOrHasHiddenAncestor] ? [self tryNowButton] : [self quitButton];
        NSDictionary *views = @{@"buyButton": [self buyButton], @"noButton": noButton};
        [[[self window] contentView] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[buyButton]-[noButton]" options:0 metrics:nil views:views]];
    }
    [[self window] recalculateKeyViewLoop];
}

- (void)buy:(id)arg1 {
    NSString *storeURL = [[NSBundle mainBundle] localizedStringForKey:@"https://www.codeweavers.com/store/" value:@"" table:@"Vendor"];
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:storeURL]];
}

- (void)showSerialCodeRegister {
    SerialCodeRegisterController *serialController = [[SerialCodeRegisterController alloc] init];
    [[self window] beginSheet:[serialController window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == 3) {
            [self registerapp:nil];
        } else if (returnCode == 1) {
            [self runapp:nil];
        }
        [serialController release];
    }];
}

- (void)registerapp:(id)arg1 {
    DemoRegisterController *registerController = [[DemoRegisterController alloc] init];
    [[self window] beginSheet:[registerController window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == 2) {
            [self showSerialCodeRegister];
        } else if (returnCode == 1) {
            [self runapp:nil];
        }
        [registerController release];
    }];
}

- (void)runapp:(id)arg1 {
    [[self window] close];
    ((void (^)(void))self->_completionHandler)();
}

- (void)cancel:(id)arg1 {
    [[self window] close];
    exit(0);
}

- (void)beginWindowWithCompletionHandler:(id)arg1 {
    id old = self->_completionHandler;
    self->_completionHandler = [arg1 copy];
    [old release];
    [self showWindow:self];
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

- (void)dealloc {
    [self->_completionHandler release];
    objc_destroyWeak((id *)&self->_registerButton);
    objc_destroyWeak((id *)&self->_tryNowButton);
    objc_destroyWeak((id *)&self->_buyButton);
    objc_destroyWeak((id *)&self->_quitButton);
    objc_destroyWeak((id *)&self->_registerToQuitSpacer);
    objc_destroyWeak((id *)&self->_registerToTryNowSpacer);
    objc_destroyWeak((id *)&self->_buyToRegisterSpacer);
    [super dealloc];
}

@end
