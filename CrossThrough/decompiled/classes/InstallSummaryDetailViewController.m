// InstallSummaryDetailViewController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000366b4
// -[InstallSummaryDetailViewController init]
    var_10 = self;
    r0 = [[&var_10 super] initWithNibName:@"InstallSummaryDetailView" bundle:0x0];
    return r0;


// 0x1000366f4
// -[InstallSummaryDetailViewController hasAction]
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    r0 = [self action];
    if (r0 != 0x0) {
            r0 = 0x1;
    }
    return r0;


// 0x100036710
// +[InstallSummaryDetailViewController keyPathsForValuesAffectingHasAction]
    r0 = [NSSet setWithObject:@"action"];
    return r0;


// 0x100036724
// -[InstallSummaryDetailViewController select:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if ([r20 action] != 0x0) {
            r21 = [[r20 delegate] retain];
            [r21 performSelector:[r20 action] withObject:r19];
            [r21 release];
    }
    [r19 release];
    return;


// 0x100036798
// -[InstallSummaryDetailViewController setSendsActionOnMouseDown:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    *(int8_t *)(int64_t *)&self->_sendsActionOnMouseDown = arg2;
    r0 = [self editButton];
    r0 = [r0 retain];
    r20 = r0;
    if (arg2 == 0x0) {
            r2 = 0x4;
    }
    else {
            r2 = 0x2;
    }
    [r0 sendActionOn:r2];
    [r20 release];
    return;


// 0x1000367e8
// -[InstallSummaryDetailViewController setButtonEnabled:]
    *(int8_t *)(int64_t *)&self->_buttonEnabled = arg2;
    r0 = [self editButton];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setEnabled:arg2];
    [r20 release];
    return;


// 0x10003682c
// -[InstallSummaryDetailViewController viewDidLoad]
    var_20 = self;
    [[&var_20 super] viewDidLoad];
    [self setSendsActionOnMouseDown:[self sendsActionOnMouseDown]];
    [self setButtonEnabled:[self buttonEnabled]];
    return;


// 0x100036894
// -[InstallSummaryDetailViewController delegate]
    r0 = objc_loadWeakRetained((int64_t *)&self->_delegate);
    r0 = [r0 autorelease];
    return r0;


// 0x1000368b4
// -[InstallSummaryDetailViewController setDelegate:]
    objc_storeWeak((int64_t *)&self->_delegate, arg2);
    return;


// 0x1000368c8
// -[InstallSummaryDetailViewController image]
    r0 = self->_image;
    return r0;


// 0x1000368d8
// -[InstallSummaryDetailViewController setImage:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000368e4
// -[InstallSummaryDetailViewController text]
    r0 = self->_text;
    return r0;


// 0x1000368f4
// -[InstallSummaryDetailViewController setText:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100036900
// -[InstallSummaryDetailViewController action]
    r0 = self->_action;
    return r0;


// 0x100036910
// -[InstallSummaryDetailViewController setAction:]
    self->_action = arg2;
    return;


// 0x100036920
// -[InstallSummaryDetailViewController sendsActionOnMouseDown]
    r0 = *(int8_t *)(int64_t *)&self->_sendsActionOnMouseDown;
    return r0;


// 0x100036930
// -[InstallSummaryDetailViewController buttonEnabled]
    r0 = *(int8_t *)(int64_t *)&self->_buttonEnabled;
    return r0;


// 0x100036940
// -[InstallSummaryDetailViewController editButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_editButton);
    r0 = [r0 autorelease];
    return r0;


// 0x100036960
// -[InstallSummaryDetailViewController setEditButton:]
    objc_storeWeak((int64_t *)&self->_editButton, arg2);
    return;


// 0x100036974
// -[InstallSummaryDetailViewController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_editButton);
    objc_storeStrong((int64_t *)&self->_text, 0x0);
    objc_storeStrong((int64_t *)&self->_image, 0x0);
    objc_destroyWeak((int64_t *)&self->_delegate);
    return;


