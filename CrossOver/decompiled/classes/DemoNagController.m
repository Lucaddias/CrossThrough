// DemoNagController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001eb1c
// -[DemoNagController init]
    r0 = [self initWithWindowNibName:@"DemoNag"];
    return r0;


// 0x10001eb28
// -[DemoNagController windowDidLoad]
    r31 = r31 - 0x60;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_40 = self;
    [[&var_40 super] windowDidLoad];
    _CXLog();
    r0 = [r19 registerButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setHidden:0x0];
    [r20 release];
    r0 = [r19 registerButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:0x1];
    [r20 release];
    r0 = [r19 quitButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isHiddenOrHasHiddenAncestor];
    [r20 release];
    if (r21 != 0x0) {
            r0 = [r19 quitButton];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 superview] retain];
            r22 = [[r19 registerToQuitSpacer] retain];
            [r21 removeConstraint:r22];
            [r22 release];
            [r21 release];
            [r20 release];
            r0 = [r19 window];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 initialFirstResponder] retain];
            r0 = [r19 quitButton];
            r0 = [r0 retain];
            r22 = r0;
            [r0 release];
            [r21 release];
            [r20 release];
            if (r21 == r22) {
                    r20 = [[r19 buyButton] retain];
                    r0 = [r19 window];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 setInitialFirstResponder:r20];
                    [r21 release];
                    [r20 release];
            }
    }
    r0 = [r19 tryNowButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isHiddenOrHasHiddenAncestor];
    [r20 release];
    if (r21 != 0x0) {
            r0 = [r19 tryNowButton];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 superview] retain];
            r22 = [[r19 registerToTryNowSpacer] retain];
            [r21 removeConstraint:r22];
            [r22 release];
            [r21 release];
            [r20 release];
    }
    r0 = [r19 registerButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isHiddenOrHasHiddenAncestor];
    [r20 release];
    if (r21 != 0x0) {
            r0 = [r19 registerButton];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 superview] retain];
            r22 = [[r19 buyToRegisterSpacer] retain];
            [r21 removeConstraint:r22];
            [r22 release];
            [r21 release];
            [r20 release];
            r0 = [r19 quitButton];
            r0 = [r0 retain];
            r21 = r0;
            if (([r0 isHiddenOrHasHiddenAncestor] & 0x1) != 0x0) {
                    r0 = [r19 tryNowButton];
                    r0 = [r0 retain];
            }
            else {
                    r0 = [r19 quitButton];
                    r0 = [r0 retain];
            }
            r20 = r0;
            [r21 release];
            r21 = [[r19 buyButton] retain];
            r22 = [_NSDictionaryOfVariableBindings(@"self.buyButton, noButton", r21) retain];
            [r21 release];
            r21 = [[NSLayoutConstraint constraintsWithVisualFormat:@"[buyButton]-[noButton]" options:0x0 metrics:0x0 views:r22] retain];
            r0 = [r19 window];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 contentView];
            r0 = [r0 retain];
            r24 = r0;
            [r0 addConstraints:r21];
            [r24 release];
            [r23 release];
            [r21 release];
            [r22 release];
            [r20 release];
    }
    r0 = [r19 window];
    r0 = [r0 retain];
    r19 = r0;
    [r0 recalculateKeyViewLoop];
    [r19 release];
    return;


// 0x10001ef14
// -[DemoNagController buy:]
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 localizedStringForKey:@"https://www.codeweavers.com/store/" value:@"" table:@"Vendor"] retain];
    [r19 release];
    r19 = [[NSWorkspace sharedWorkspace] retain];
    r21 = [[NSURL URLWithString:r20] retain];
    [r19 openURL:r21];
    [r21 release];
    [r19 release];
    [r20 release];
    return;


// 0x10001efd0
// -[DemoNagController showSerialCodeRegister]
    r20 = [[SerialCodeRegisterController alloc] init];
    r21 = [[self window] retain];
    r22 = [[r20 window] retain];
    var_48 = *__NSConcreteStackBlock;
    [r21 beginSheet:r22 completionHandler:&var_48];
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x10001f0b8
// -[DemoNagController registerapp:]
    r20 = [[DemoRegisterController alloc] init];
    r21 = [[self window] retain];
    r22 = [[r20 window] retain];
    var_48 = *__NSConcreteStackBlock;
    [r21 beginSheet:r22 completionHandler:&var_48];
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x10001f19c
// -[DemoNagController runapp:]
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 close];
    [r20 release];
    r0 = self->_completionHandler;
    r1 = r0[0x2];
    (r1)(r0, r1);
    return;


// 0x10001f1e4
// -[DemoNagController cancel:]
    [arg2 retain];
    r0 = [self window];
    r0 = [r0 retain];
    r19 = r0;
    [r0 close];
    [r19 release];
    exit(0x0);
    return;


// 0x10001f224
// -[DemoNagController beginWindowWithCompletionHandler:]
    r0 = objc_retainBlock(arg2);
    r9 = sign_extend_64(*(int32_t *)ivar_offset(_completionHandler));
    r8 = *(self + r9);
    *(self + r9) = r0;
    [r8 release];
    [self showWindow:self];
    return;


// 0x10001f268
// -[DemoNagController registerButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_registerButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10001f288
// -[DemoNagController setRegisterButton:]
    objc_storeWeak((int64_t *)&self->_registerButton, arg2);
    return;


// 0x10001f29c
// -[DemoNagController tryNowButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_tryNowButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10001f2bc
// -[DemoNagController setTryNowButton:]
    objc_storeWeak((int64_t *)&self->_tryNowButton, arg2);
    return;


// 0x10001f2d0
// -[DemoNagController buyButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_buyButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10001f2f0
// -[DemoNagController setBuyButton:]
    objc_storeWeak((int64_t *)&self->_buyButton, arg2);
    return;


// 0x10001f304
// -[DemoNagController quitButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_quitButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10001f324
// -[DemoNagController setQuitButton:]
    objc_storeWeak((int64_t *)&self->_quitButton, arg2);
    return;


// 0x10001f338
// -[DemoNagController registerToQuitSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_registerToQuitSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001f358
// -[DemoNagController setRegisterToQuitSpacer:]
    objc_storeWeak((int64_t *)&self->_registerToQuitSpacer, arg2);
    return;


// 0x10001f36c
// -[DemoNagController registerToTryNowSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_registerToTryNowSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001f38c
// -[DemoNagController setRegisterToTryNowSpacer:]
    objc_storeWeak((int64_t *)&self->_registerToTryNowSpacer, arg2);
    return;


// 0x10001f3a0
// -[DemoNagController buyToRegisterSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_buyToRegisterSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001f3c0
// -[DemoNagController setBuyToRegisterSpacer:]
    objc_storeWeak((int64_t *)&self->_buyToRegisterSpacer, arg2);
    return;


// 0x10001f3d4
// -[DemoNagController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_buyToRegisterSpacer);
    objc_destroyWeak((int64_t *)&self->_registerToTryNowSpacer);
    objc_destroyWeak((int64_t *)&self->_registerToQuitSpacer);
    objc_destroyWeak((int64_t *)&self->_quitButton);
    objc_destroyWeak((int64_t *)&self->_buyButton);
    objc_destroyWeak((int64_t *)&self->_tryNowButton);
    objc_destroyWeak((int64_t *)&self->_registerButton);
    objc_storeStrong((int64_t *)&self->_completionHandler, 0x0);
    return;


