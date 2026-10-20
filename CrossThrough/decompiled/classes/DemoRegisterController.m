// DemoRegisterController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100027098
// -[DemoRegisterController init]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_20 = self;
    r0 = [[&var_20 super] initWithWindowNibName:@"DemoRegister"];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [[RegistrationController alloc] init];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_regController));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
    }
    r0 = r19;
    return r0;


// 0x10002710c
// -[DemoRegisterController setRefreshLicenseMode:]
    r2 = arg2;
    r31 = r31 - 0x50;
    var_30 = d9;
    decomp_var_28 = d8;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = r2;
    r19 = self;
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_refreshLicenseMode));
    r8 = *(int8_t *)(self + r22);
    if (r8 == 0x0) {
            if ((r20 & 0x1) != 0x0) {
                    d8 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xc08);
                    r0 = [r19 alreadyPurchasedToEmailSpacer];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 constant];
                    [r21 setConstant:r2];
                    [r21 release];
            }
            else {
                    if (r8 != 0x0 && (r20 & 0x1) == 0x0) {
                            d8 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xc10);
                            r0 = [r19 alreadyPurchasedToEmailSpacer];
                            r0 = [r0 retain];
                            r21 = r0;
                            [r0 constant];
                            [r21 setConstant:r2];
                            [r21 release];
                    }
            }
    }
    else {
            if (r8 != 0x0 && (r20 & 0x1) == 0x0) {
                    d8 = *("ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32" + 0xc10);
                    r0 = [r19 alreadyPurchasedToEmailSpacer];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 constant];
                    [r21 setConstant:r2];
                    [r21 release];
            }
    }
    *(int8_t *)(r19 + r22) = r20;
    if (r20 != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [[r0 localizedStringForKey:@"A new version of %1$@ is now available. Please enter your codeweavers.com account email address and password to update your license file and re-enable automatic updates." value:@"" table:0x0] retain];
            r20 = [[NSString stringWithFormat:r22] retain];
            [r22 release];
            [r21 release];
            [r19 setExpirationText:r20];
            [r20 release];
    }
    return;


// 0x100027248
// -[DemoRegisterController windowDidLoad]
    r31 = r31 - 0xa0;
    var_50 = r28;
    decomp_var_48 = r27;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_58 = **___stack_chk_guard;
    var_88 = self;
    [[&var_88 super] windowDidLoad];
    var_78 = **_NSForegroundColorAttributeName;
    r0 = [NSColor blueColor];
    r0 = [r0 retain];
    r21 = r0;
    var_68 = r0;
    r22 = [@(0x1) retain];
    r0 = [NSDictionary dictionaryWithObjects:&var_68 forKeys:&var_78 count:0x2];
    r20 = [r0 retain];
    [r22 release];
    [r21 release];
    r21 = [[NSURL URLWithString:@"https://store.codeweavers.com"] retain];
    r0 = [r19 referToStoreTextField];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 attributedStringValue];
    r0 = [r0 retain];
    r24 = r0;
    r22 = [r0 mutableCopy];
    [r24 release];
    [r23 release];
    r0 = [r22 string];
    r0 = [r0 retain];
    r25 = r0;
    r23 = [r0 rangeOfString:@"%@"];
    r24 = r1;
    [r25 release];
    if (r23 == 0x7fffffffffffffff) {
            r0 = [r22 mutableString];
            r0 = [r0 retain];
            r23 = r0;
            [r0 appendString:@" "];
            [r23 release];
            r23 = [r22 length];
            r24 = 0x0;
    }
    r25 = [[r21 host] retain];
    [r22 replaceCharactersInRange:r23 withString:r24];
    [r25 release];
    r0 = [r21 host];
    r0 = [r0 retain];
    r24 = r0;
    [r0 length];
    [r24 release];
    [r22 addAttributes:r20 range:r23];
    r27 = *_NSLinkAttributeName;
    [r22 addAttribute:*r27 value:r21 range:r23];
    r0 = [r19 referToStoreTextField];
    r0 = [r0 retain];
    r23 = r0;
    [r0 setAttributedStringValue:r22];
    [r23 release];
    r23 = [[NSURL URLWithString:@"https://www.codeweavers.com/login/lostpassword/"] retain];
    r0 = [r19 forgotPasswordTextField];
    r0 = [r0 retain];
    r25 = r0;
    r0 = [r0 attributedStringValue];
    r0 = [r0 retain];
    r26 = r0;
    r24 = [r0 mutableCopy];
    [r26 release];
    [r25 release];
    [r24 length];
    [r24 addAttributes:r20 range:0x0];
    [r24 addAttribute:*r27 value:r23 range:0x0];
    r0 = [r19 forgotPasswordTextField];
    r0 = [r0 retain];
    r25 = r0;
    r2 = r24;
    [r0 setAttributedStringValue:r2];
    [r25 release];
    if (*(int8_t *)(r19 + sign_extend_64(*(int32_t *)ivar_offset(_refreshLicenseMode))) != 0x0) {
            r0 = [r19 alreadyPurchasedToEmailSpacer];
            r0 = [r0 retain];
            r19 = r0;
            [r0 constant];
            [r19 setConstant:r2];
            [r19 release];
    }
    [r24 release];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x100027600
// +[DemoRegisterController keyPathsForValuesAffectingCanRegister]
    r0 = [NSSet setWithObjects:@"regController.login"];
    return r0;


// 0x100027638
// -[DemoRegisterController canRegister]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r0 = [self regController];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 login];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0) {
            r0 = [r21 regController];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 password];
            r0 = [r0 retain];
            if (r0 != 0x0) {
                    r21 = 0x1;
            }
            [r0 release];
            [r22 release];
    }
    else {
            r21 = 0x0;
    }
    [r20 release];
    [r19 release];
    r0 = r21;
    return r0;


// 0x1000276d0
// -[DemoRegisterController registerapp:]
    r0 = [self regController];
    r0 = [r0 retain];
    r20 = r0;
    var_38 = *__NSConcreteStackBlock;
    [r0 beginRegisterAppWithCompletionHandler:&var_38];
    [r20 release];
    return;


// 0x100027970
// -[DemoRegisterController openSerialCodeWindow:]
    r31 = r31 - 0x60;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isSheet];
    [r20 release];
    if (r21 != 0x0) {
            r20 = [[NSApplication sharedApplication] retain];
            r19 = [[r19 window] retain];
            [r20 endSheet:r19 returnCode:0x2];
            [r19 release];
            [r20 release];
    }
    else {
            r20 = [[SerialCodeRegisterController alloc] init];
            r21 = [[r19 window] retain];
            r22 = [[r20 window] retain];
            var_48 = *__NSConcreteStackBlock;
            [r21 beginSheet:r22 completionHandler:&var_48];
            [r22 release];
            [r21 release];
            [r20 release];
    }
    return;


// 0x100027aec
// -[DemoRegisterController cancel:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self regController];
    r0 = [r0 retain];
    r20 = r0;
    [r0 cancel];
    [r20 release];
    r0 = [r19 window];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 isSheet];
    [r20 release];
    if (r21 != 0x0) {
            r20 = [[NSApplication sharedApplication] retain];
            r19 = [[r19 window] retain];
            [r20 endSheet:r19 returnCode:0x0];
            [r19 release];
    }
    else {
            r0 = [r19 window];
            r0 = [r0 retain];
            r20 = r0;
            [r0 close];
    }
    [r20 release];
    return;


// 0x100027bb8
// -[DemoRegisterController exitSuccess]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 close];
    [r20 release];
    r20 = [[NSApplication sharedApplication] retain];
    r21 = [[self window] retain];
    [r20 endSheet:r21 returnCode:0x1];
    [r21 release];
    [r20 release];
    if ([self refreshLicenseMode] != 0x0) {
            r0 = [CXUpdater sharedUpdater];
            r0 = [r0 retain];
            r19 = r0;
            [r0 checkForUpdatesInBackground];
            [r19 release];
    }
    return;


// 0x100027c80
// -[DemoRegisterController controlTextDidChange:]
    r0 = [arg2 object];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 infoForBinding:**_NSValueBinding];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 valueForKey:**_NSObservedObjectKey] retain];
    r22 = [[r19 stringValue] retain];
    r23 = [[r20 valueForKey:**_NSObservedKeyPathKey] retain];
    [r21 setValue:r22 forKeyPath:r23];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x100027d5c
// -[DemoRegisterController regController]
    r0 = self->_regController;
    return r0;


// 0x100027d6c
// -[DemoRegisterController refreshLicenseMode]
    r0 = *(int8_t *)(int64_t *)&self->_refreshLicenseMode;
    return r0;


// 0x100027d7c
// -[DemoRegisterController alreadyPurchasedToEmailSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_alreadyPurchasedToEmailSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x100027d9c
// -[DemoRegisterController setAlreadyPurchasedToEmailSpacer:]
    objc_storeWeak((int64_t *)&self->_alreadyPurchasedToEmailSpacer, arg2);
    return;


// 0x100027db0
// -[DemoRegisterController referToStoreTextField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_referToStoreTextField);
    r0 = [r0 autorelease];
    return r0;


// 0x100027dd0
// -[DemoRegisterController setReferToStoreTextField:]
    objc_storeWeak((int64_t *)&self->_referToStoreTextField, arg2);
    return;


// 0x100027de4
// -[DemoRegisterController forgotPasswordTextField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_forgotPasswordTextField);
    r0 = [r0 autorelease];
    return r0;


// 0x100027e04
// -[DemoRegisterController setForgotPasswordTextField:]
    objc_storeWeak((int64_t *)&self->_forgotPasswordTextField, arg2);
    return;


// 0x100027e18
// -[DemoRegisterController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_forgotPasswordTextField);
    objc_destroyWeak((int64_t *)&self->_referToStoreTextField);
    objc_destroyWeak((int64_t *)&self->_alreadyPurchasedToEmailSpacer);
    objc_storeStrong((int64_t *)&self->_regController, 0x0);
    return;


// === Block Invocations for DemoRegisterController ===

// 0x100027744
// ___38-[DemoRegisterController registerapp:]_block_invoke
    r31 = r31 - 0x90;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = arg1;
    r21 = arg0;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    if (r19 != 0x0) {
            if (r22 != 0x0 && [r21[0x4] refreshLicenseMode] != 0x0) {
                    r0 = [[NSDateFormatter alloc] init];
                    r23 = r0;
                    [r0 setDateStyle:0x2];
                    [r23 setTimeStyle:0x0];
                    r0 = [NSApplication sharedApplication];
                    r0 = [r0 retain];
                    r24 = r0;
                    r25 = [[r0 licenseExpirationDate] retain];
                    r26 = [[r23 stringFromDate:r25] retain];
                    [r25 release];
                    [r24 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r24 = r0;
                    r25 = [[r0 localizedStringForKey:@"Your license has been updated. Automatic product updates will now be available through %@." value:@"" table:0x0] retain];
                    [r20 release];
                    [r24 release];
                    r20 = [[NSString stringWithFormat:r25] retain];
                    [r25 release];
                    [r26 release];
                    [r23 release];
            }
            r0 = [[NSAlert alloc] init];
            r23 = r0;
            [r0 setMessageText:r19];
            [r23 setInformativeText:r20];
            r24 = [[r21[0x4] window] retain];
            var_70 = *__NSConcreteStackBlock;
            [r23 beginSheetModalForWindow:r24 completionHandler:&var_70];
            [r24 release];
            [r23 release];
    }
    else {
            if (r22 != 0x0) {
                    [r21[0x4] exitSuccess];
            }
    }
    [r20 release];
    r0 = [r19 release];
    return r0;


// 0x10002795c
// ___38-[DemoRegisterController registerapp:]_block_invoke_2
    r0 = arg0;
    if (r0[0x28] != 0x0) {
            [r0[0x4] exitSuccess];
    }
    return;


// 0x100027aac
// ___47-[DemoRegisterController openSerialCodeWindow:]_block_invoke
    r0 = arg0;
    if (r1 == 0x1) {
            r0 = r0[0x4];
            r0 = [r0 window];
            r0 = [r0 retain];
            r19 = r0;
            [r0 close];
            [r19 release];
    }
    return;


