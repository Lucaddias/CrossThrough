// RunCommandLauncherModeViewController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003874c
// -[RunCommandLauncherModeViewController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithNibName:@"RunCommandLauncherModeView" bundle:0x0];
    return r0;


// 0x10003878c
// -[RunCommandLauncherModeViewController loadView]
    var_30 = self;
    [[&var_30 super] loadView];
    r21 = [[self launcherNameTextField] retain];
    r22 = [[self launcherIconImageView] retain];
    r20 = [[NSLayoutConstraint constraintWithItem:r21 attribute:0xb relatedBy:0x0 toItem:r22 attribute:0xa multiplier:r7 constant:var_30] retain];
    [r22 release];
    [r21 release];
    r0 = [self view];
    r0 = [r0 retain];
    r19 = r0;
    [r0 addConstraint:r20];
    [r19 release];
    [r20 release];
    return;


// 0x100038870
// -[RunCommandLauncherModeViewController launcherIconImageView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_launcherIconImageView);
    r0 = [r0 autorelease];
    return r0;


// 0x100038890
// -[RunCommandLauncherModeViewController setLauncherIconImageView:]
    objc_storeWeak((int64_t *)&self->_launcherIconImageView, arg2);
    return;


// 0x1000388a4
// -[RunCommandLauncherModeViewController launcherNameTextField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_launcherNameTextField);
    r0 = [r0 autorelease];
    return r0;


// 0x1000388c4
// -[RunCommandLauncherModeViewController setLauncherNameTextField:]
    objc_storeWeak((int64_t *)&self->_launcherNameTextField, arg2);
    return;


// 0x1000388d8
// -[RunCommandLauncherModeViewController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_launcherNameTextField);
    objc_destroyWeak((int64_t *)&self->_launcherIconImageView);
    return;


