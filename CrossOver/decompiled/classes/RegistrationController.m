// RegistrationController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10005add8
// -[RegistrationController init]
    r31 = r31 - 0x60;
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
    var_50 = self;
    r0 = [[&var_50 super] init];
    r19 = r0;
    if (r0 != 0x0) {
            r19->registrarClass = [CXSetupLib demoUtilsClass];
            r21 = [[NSURLSessionConfiguration defaultSessionConfiguration] retain];
            r22 = [[NSOperationQueue mainQueue] retain];
            r0 = [NSURLSession sessionWithConfiguration:r21 delegate:0x0 delegateQueue:r22];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(session));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            [r22 release];
            [r21 release];
            r0 = [NSFileManager defaultManager];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 URLsForDirectory:0x5 inDomains:0x3];
            r0 = [r0 retain];
            r21 = r0;
            if ([r0 count] <= 0x1) {
                    NSLog(@"Failed to retrieve Library directories.\n");
                    [r19 retain];
                    [r21 release];
                    [r20 release];
            }
            else {
                    r0 = [r21 objectAtIndexedSubscript:0x0];
                    r0 = [r0 retain];
                    r23 = r0;
                    r22 = [[r0 URLByAppendingPathComponent:@"Preferences" isDirectory:0x1] retain];
                    [r23 release];
                    if (r22 != 0x0) {
                            r0 = [r22 stringWithFileSystemRepresentation];
                            r0 = [r0 retain];
                            r9 = sign_extend_64(*(int32_t *)ivar_offset(localPrefsFolder));
                            r8 = *(r19 + r9);
                            *(r19 + r9) = r0;
                            [r8 release];
                            r0 = [r21 objectAtIndexedSubscript:0x1];
                            r0 = [r0 retain];
                            r24 = r0;
                            r23 = [[r0 URLByAppendingPathComponent:@"Preferences" isDirectory:0x1] retain];
                            [r24 release];
                            if (r23 != 0x0) {
                                    r0 = [r23 stringWithFileSystemRepresentation];
                                    r0 = [r0 retain];
                                    r24 = sign_extend_64(*(int32_t *)ivar_offset(globalPrefsFolder));
                                    r8 = *(r19 + r24);
                                    *(r19 + r24) = r0;
                                    [r8 release];
                                    r0 = [r20 isWritableFileAtPath:*(r19 + r24)];
                                    r8 = sign_extend_64(*(int32_t *)ivar_offset(_regMode));
                                    if (r0 != 0x0) {
                                            *(int32_t *)(r19 + r8) = 0x1;
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r24 = r0;
                                            r2 = @"Unlock for all users of this computer";
                                    }
                                    else {
                                            *(int32_t *)(r19 + r8) = 0x0;
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r24 = r0;
                                            r2 = @"Unlock for all users of this computer (requires authentication)";
                                    }
                                    r0 = [r0 localizedStringForKey:r2 value:@"" table:0x0];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    r0 = [r0 copy];
                                    r9 = sign_extend_64(*(int32_t *)ivar_offset(_globalRegModeCaption));
                                    r8 = *(r19 + r9);
                                    *(r19 + r9) = r0;
                                    [r8 release];
                                    [r25 release];
                                    [r24 release];
                                    r24 = 0x0;
                            }
                            else {
                                    NSLog(@"Failed to locate the global Preferences directory.\n");
                                    [r19 retain];
                                    r24 = 0x1;
                            }
                            [r23 release];
                    }
                    else {
                            NSLog(@"Failed to locate the local Preferences directory.\n");
                            [r19 retain];
                            r24 = 0x1;
                    }
                    [r22 release];
                    [r21 release];
                    [r20 release];
                    if (r24 == 0x0) {
                            [r19 retain];
                    }
            }
    }
    else {
            [r19 retain];
    }
    [r19 release];
    r0 = r19;
    return r0;


// 0x10005b120
// -[RegistrationController authIfNeeded]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r19 = r0;
    if (([r0 isWritableFileAtPath:r20->globalPrefsFolder] & 0x1) == 0x0) {
            if ([r20 regMode] == 0x1) {
                    r21 = sign_extend_64(*(int32_t *)ivar_offset(authorization));
                    r0 = *(r20 + r21);
                    if (r0 == 0x0) {
                            r0 = [[SFAuthorization alloc] init];
                            r8 = *(r20 + r21);
                            *(r20 + r21) = r0;
                            [r8 release];
                            r0 = *(r20 + r21);
                            if (r0 != 0x0 && ([r0 obtainWithRight:"system.privilege.admin" flags:0x13 error:0x0] & 0x1) != 0x0) {
                                    r20 = 0x1;
                            }
                            else {
                                    r20 = 0x0;
                            }
                    }
                    else {
                            if (([r0 obtainWithRight:"system.privilege.admin" flags:0x13 error:0x0] & 0x1) == 0x0) {
                                    r20 = 0x0;
                            }
                            else {
                                    r20 = 0x1;
                            }
                    }
            }
            else {
                    r8 = sign_extend_64(*(int32_t *)ivar_offset(authorization));
                    r0 = *(r20 + r8);
                    *(r20 + r8) = 0x0;
                    [r0 release];
                    r20 = 0x1;
            }
    }
    else {
            r8 = sign_extend_64(*(int32_t *)ivar_offset(authorization));
            r0 = *(r20 + r8);
            *(r20 + r8) = 0x0;
            [r0 release];
            r20 = 0x1;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x10005b1f8
// -[RegistrationController formatSerialCode:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = [[arg2 stringByReplacingOccurrencesOfString:@"-" withString:@""] retain];
    r21 = [[NSString stringWithString:r20] retain];
    [r20 release];
    r20 = [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
    r19 = [[r21 stringByTrimmingCharactersInSet:r20] retain];
    [r21 release];
    [r20 release];
    r0 = [r19 length];
    if (r0 >= 0x4) {
            r20 = r0;
            r21 = [[r19 stringByReplacingCharactersInRange:0x3 withString:0x0] retain];
            [r19 release];
            if (r20 >= 0x8) {
                    r19 = [[r21 stringByReplacingCharactersInRange:0x8 withString:0x0] retain];
                    [r21 release];
                    if (r20 >= 0xc) {
                            r20 = [[r19 stringByReplacingCharactersInRange:0xd withString:0x0] retain];
                            [r19 release];
                            r19 = r20;
                    }
            }
            else {
                    r19 = r21;
            }
    }
    r0 = [r19 autorelease];
    return r0;


// 0x10005b35c
// -[RegistrationController beginRegisterAppWithSerialCodeWithCompletionHandler:]
    r31 = r31 - 0x80;
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
    [self setCompletionHandler:arg2];
    r0 = [r19 login];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r20 = r0;
            r0 = [r19 password];
            r0 = [r0 retain];
            if (r0 != 0x0) {
                    r21 = r0;
                    r0 = [r19 accountName];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r22 = r0;
                            r0 = [r19 serialCode];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 release];
                            [r22 release];
                            [r21 release];
                            [r20 release];
                            if (r23 != 0x0) {
                                    r21 = [r19 validLogin];
                                    r20 = [r19 validPassword];
                                    r0 = [r19 validSerialCode];
                                    if (r21 != 0x0 && r20 != 0x0 && r0 != 0x0) {
                                            r20 = [[r19 serialCode] retain];
                                            r21 = [[r19 formatSerialCode:r20] retain];
                                            [r19 setSerialCode:r21];
                                            [r21 release];
                                            [r20 release];
                                            r20 = [CXSetupLib demoUtilsClass];
                                            r21 = [[r19 login] retain];
                                            r22 = [[r19 accountName] retain];
                                            r23 = [[r19 password] retain];
                                            r24 = [[r19 serialCode] retain];
                                            r20 = [[r20 createAccountRequestBodyForEmail:r21 name:r22 andPassword:r23 withSerialCode:r24] retain];
                                            [r24 release];
                                            [r23 release];
                                            [r22 release];
                                            [r21 release];
                                            if ([r19 authIfNeeded] != 0x0) {
                                                    r21 = [[NSMutableURLRequest alloc] init];
                                                    r23 = [[[CXSetupLib demoUtilsClass] serialRegistrationURL] retain];
                                                    r22 = [[NSURL URLWithString:r23] retain];
                                                    [r21 setURL:r22];
                                                    [r22 release];
                                                    [r23 release];
                                                    [r21 setHTTPMethod:@"POST"];
                                                    [r21 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                                                    [r21 setHTTPBody:r20];
                                                    r0 = r19->session;
                                                    var_68 = *__NSConcreteStackBlock;
                                                    r0 = [r0 dataTaskWithRequest:r21 completionHandler:&var_68];
                                                    r0 = [r0 retain];
                                                    r22 = sign_extend_64(*(int32_t *)ivar_offset(downloadTask));
                                                    r8 = *(r19 + r22);
                                                    *(r19 + r22) = r0;
                                                    [r8 release];
                                                    if (*(r19 + r22) != 0x0) {
                                                            [r19 setRegistrationWorkInProgress:[r19 registrationWorkInProgress] + 0x1];
                                                            [*(r19 + r22) resume];
                                                            [r21 release];
                                                            [r20 release];
                                                    }
                                                    else {
                                                            [r21 release];
                                                            r0 = r20;
                                                            [r0 release];
                                                            [r19 setCompletionHandler:0x0];
                                                    }
                                            }
                                            else {
                                                    r0 = r20;
                                                    [r0 release];
                                                    [r19 setCompletionHandler:0x0];
                                            }
                                    }
                            }
                            else {
                                    r0 = [r19 completionHandler];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    [r0 release];
                                    if (r20 != 0x0) {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            r22 = [[r0 localizedStringForKey:@"Required field missing" value:@"" table:0x0] retain];
                                            [r20 release];
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            r21 = [[r0 localizedStringForKey:@"You have left a required field blank. Please enter a name, password, email address, and activation code. All fields are required." value:@"" table:0x0] retain];
                                            [r20 release];
                                            r0 = [r19 completionHandler];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            (r0[0x2])();
                                            [r20 release];
                                            [r21 release];
                                            r0 = r22;
                                            [r0 release];
                                    }
                                    [r19 setCompletionHandler:0x0];
                            }
                    }
                    else {
                            [r21 release];
                            [r20 release];
                            r0 = [r19 completionHandler];
                            r0 = [r0 retain];
                            r20 = r0;
                            [r0 release];
                            if (r20 != 0x0) {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r22 = [[r0 localizedStringForKey:@"Required field missing" value:@"" table:0x0] retain];
                                    [r20 release];
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r21 = [[r0 localizedStringForKey:@"You have left a required field blank. Please enter a name, password, email address, and activation code. All fields are required." value:@"" table:0x0] retain];
                                    [r20 release];
                                    r0 = [r19 completionHandler];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    (r0[0x2])();
                                    [r20 release];
                                    [r21 release];
                                    r0 = r22;
                                    [r0 release];
                            }
                            [r19 setCompletionHandler:0x0];
                    }
            }
            else {
                    [r20 release];
                    r0 = [r19 completionHandler];
                    r0 = [r0 retain];
                    r20 = r0;
                    [r0 release];
                    if (r20 != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r22 = [[r0 localizedStringForKey:@"Required field missing" value:@"" table:0x0] retain];
                            [r20 release];
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r21 = [[r0 localizedStringForKey:@"You have left a required field blank. Please enter a name, password, email address, and activation code. All fields are required." value:@"" table:0x0] retain];
                            [r20 release];
                            r0 = [r19 completionHandler];
                            r0 = [r0 retain];
                            r20 = r0;
                            (r0[0x2])();
                            [r20 release];
                            [r21 release];
                            r0 = r22;
                            [r0 release];
                    }
                    [r19 setCompletionHandler:0x0];
            }
    }
    else {
            r0 = [r19 completionHandler];
            r0 = [r0 retain];
            r20 = r0;
            [r0 release];
            if (r20 != 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r22 = [[r0 localizedStringForKey:@"Required field missing" value:@"" table:0x0] retain];
                    [r20 release];
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 localizedStringForKey:@"You have left a required field blank. Please enter a name, password, email address, and activation code. All fields are required." value:@"" table:0x0] retain];
                    [r20 release];
                    r0 = [r19 completionHandler];
                    r0 = [r0 retain];
                    r20 = r0;
                    (r0[0x2])();
                    [r20 release];
                    [r21 release];
                    r0 = r22;
                    [r0 release];
            }
            [r19 setCompletionHandler:0x0];
    }
    return;


// 0x10005b8c4
// -[RegistrationController beginRegisterAppWithCompletionHandler:]
    r31 = r31 - 0x70;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    [self setCompletionHandler:arg2];
    r0 = [r19 login];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r20 = r0;
            r0 = [r19 password];
            r0 = [r0 retain];
            r21 = r0;
            [r0 release];
            [r20 release];
            if (r21 != 0x0) {
                    if ([r19 authIfNeeded] != 0x0) {
                            r20 = [CXSetupLib demoUtilsClass];
                            r21 = [[r19 login] retain];
                            r22 = [[r19 password] retain];
                            r20 = [[r20 licenseUrlForLogin:r21 andPassword:r22] retain];
                            [r22 release];
                            [r21 release];
                            r22 = [[NSURL URLWithString:r20] retain];
                            r21 = [[NSURLRequest requestWithURL:r22 cachePolicy:0x1 timeoutInterval:r4] retain];
                            [r22 release];
                            if (r21 != 0x0) {
                                    r0 = r19->session;
                                    var_58 = *__NSConcreteStackBlock;
                                    r0 = [r0 dataTaskWithRequest:r21 completionHandler:&var_58];
                                    r0 = [r0 retain];
                                    r22 = sign_extend_64(*(int32_t *)ivar_offset(downloadTask));
                                    r8 = *(r19 + r22);
                                    *(r19 + r22) = r0;
                                    [r8 release];
                                    [r19 setRegistrationWorkInProgress:[r19 registrationWorkInProgress] + 0x1];
                                    [*(r19 + r22) resume];
                                    [r21 release];
                                    [r20 release];
                            }
                            else {
                                    [r20 release];
                                    r0 = [r19 completionHandler];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    [r0 release];
                                    if (r20 != 0x0) {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r20 = [[r0 localizedStringForKey:@"Could not unlock" value:@"" table:0x0] retain];
                                            [r21 release];
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r22 = [[r0 localizedStringForKey:@"Failed to begin license download." value:@"" table:0x0] retain];
                                            [r21 release];
                                            r21 = [[r22 stringByAppendingString:@" "] retain];
                                            [r22 release];
                                            r22 = [[[CXSetupLib demoUtilsClass] lastResort] retain];
                                            r23 = [[r21 stringByAppendingString:r22] retain];
                                            [r21 release];
                                            [r22 release];
                                            r0 = [r19 completionHandler];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            (r0[0x2])();
                                            [r21 release];
                                            [r23 release];
                                            [r20 release];
                                    }
                                    [r19 setCompletionHandler:0x0];
                            }
                    }
                    else {
                            r0 = [r19 completionHandler];
                            r0 = [r0 retain];
                            r20 = r0;
                            [r0 release];
                            if (r20 != 0x0) {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r20 = [[r0 localizedStringForKey:@"Could not unlock" value:@"" table:0x0] retain];
                                    [r21 release];
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r22 = [[r0 localizedStringForKey:@"Failed to begin license download." value:@"" table:0x0] retain];
                                    [r21 release];
                                    r21 = [[r22 stringByAppendingString:@" "] retain];
                                    [r22 release];
                                    r22 = [[[CXSetupLib demoUtilsClass] lastResort] retain];
                                    r23 = [[r21 stringByAppendingString:r22] retain];
                                    [r21 release];
                                    [r22 release];
                                    r0 = [r19 completionHandler];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    (r0[0x2])();
                                    [r21 release];
                                    [r23 release];
                                    [r20 release];
                            }
                            [r19 setCompletionHandler:0x0];
                    }
            }
            else {
                    [r19 setCompletionHandler:0x0];
            }
    }
    else {
            [r19 setCompletionHandler:0x0];
    }
    return;


// 0x10005bd44
// -[RegistrationController handleRegistrationData:]
    r31 = r31 - 0xb0;
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
    r20 = self;
    r19 = [arg2 retain];
    [r20 setRegistrationWorkInProgress:[r20 registrationWorkInProgress] + 0x1];
    r22 = [[[CXSetupLib demoUtilsClass] checkLicenseDownload:r19] retain];
    if (r19 != 0x0) {
            if (r22 == 0x0) {
                    if ([r19 length] <= 0x3f) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r21 = r0;
                            r23 = [[r0 localizedStringForKey:@"Download incomplete." value:@"" table:0x0] retain];
                            [r22 release];
                            [r21 release];
                            r22 = r23;
                            if (r23 == 0x0) {
                                    r0 = [CXSetupLib demoUtilsClass];
                                    r0 = [r0 splitLicenseAndSigFromBuffer:r19];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    if (r0 != 0x0) {
                                            r22 = [[r21 objectAtIndexedSubscript:0x0] retain];
                                            r0 = [NSNull null];
                                            r0 = [r0 retain];
                                            if (r22 != r0) {
                                                    r23 = r0;
                                                    r24 = [[r21 objectAtIndexedSubscript:0x1] retain];
                                                    r0 = [NSNull null];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    [r0 release];
                                                    [r24 release];
                                                    [r23 release];
                                                    [r22 release];
                                                    if (r24 != r25) {
                                                            r23 = [[r21 objectAtIndex:0x0] retain];
                                                            r24 = [[r21 objectAtIndex:0x1] retain];
                                                            r0 = [CXSetupLib demoUtilsClass];
                                                            r3 = r24;
                                                            r0 = [r0 demoStatusForLicenseFile:r23 andSig:r3];
                                                            r0 = [r0 retain];
                                                            r25 = r0;
                                                            r0 = [r0 objectAtIndex:0x0];
                                                            r0 = [r0 retain];
                                                            r22 = r0;
                                                            r26 = [r0 boolValue];
                                                            [r22 release];
                                                            if (r26 != 0x0) {
                                                                    r0 = [NSBundle mainBundle];
                                                                    r0 = [r0 retain];
                                                                    r26 = r0;
                                                                    r22 = [[r0 localizedStringForKey:@"Your support contract is not valid for this product. You may need to purchase a support extension or an additional license." value:@"" table:0x0] retain];
                                                                    [r26 release];
                                                                    r0 = [NSFileManager defaultManager];
                                                                    r0 = [r0 retain];
                                                                    r26 = r0;
                                                                    [r0 removeItemAtPath:r23 error:0x0];
                                                                    [r26 removeItemAtPath:r24 error:0x0];
                                                            }
                                                            else {
                                                                    r4 = 0x0;
                                                                    var_80 = [[r24 pathExtension] retain];
                                                                    if ([r20 regMode] != 0x0) {
                                                                            r28 = sign_extend_64(*(int32_t *)ivar_offset(globalPrefsFolder));
                                                                    }
                                                                    else {
                                                                            r28 = sign_extend_64(*(int32_t *)ivar_offset(localPrefsFolder));
                                                                    }
                                                                    r26 = *(r20 + r28);
                                                                    r22 = [[NSString stringWithFormat:@"%@.%@.license", r3, 0x0] retain];
                                                                    r26 = [[r26 stringByAppendingPathComponent:r22] retain];
                                                                    [r22 release];
                                                                    r22 = *(r20 + r28);
                                                                    r28 = [[NSString stringWithFormat:@"%@.%@.%@", r3, r4, r5] retain];
                                                                    r22 = [[r22 stringByAppendingPathComponent:r28] retain];
                                                                    [r28 release];
                                                                    [r20 moveFile:r23 dest:r26];
                                                                    [r20 moveFile:r24 dest:r22];
                                                                    [var_80 release];
                                                                    [r22 release];
                                                                    r22 = 0x0;
                                                            }
                                                            [r26 release];
                                                            [r25 release];
                                                            [r24 release];
                                                    }
                                                    else {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r23 = r0;
                                                            r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                                                    }
                                            }
                                            else {
                                                    [r22 release];
                                                    [r22 release];
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                                            }
                                    }
                                    else {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                                    }
                                    [r23 release];
                                    [r21 release];
                                    r0 = [NSApplication sharedApplication];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 setIsDemo];
                                    [r21 release];
                                    [r20 setRegistrationWorkInProgress:[r20 registrationWorkInProgress] - 0x1];
                                    r0 = [r20 completionHandler];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 release];
                                    if (r21 != 0x0) {
                                            r23 = [[NSBundle mainBundle] retain];
                                            if (r22 != 0x0) {
                                                    r21 = [[r23 localizedStringForKey:@"Unlocking failed" value:@"" table:0x0] retain];
                                                    [r23 release];
                                                    r23 = [r22 retain];
                                            }
                                            else {
                                                    r21 = [[r23 localizedStringForKey:@"Finished unlocking" value:@"" table:0x0] retain];
                                                    [r23 release];
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    r24 = [[r0 localizedStringForKey:@"This copy of %@ is now fully enabled." value:@"" table:0x0] retain];
                                                    [r23 release];
                                                    r23 = [[NSString stringWithFormat:r24] retain];
                                                    [r24 release];
                                            }
                                            if (r22 == 0x0) {
                                                    r24 = 0x1;
                                            }
                                            r0 = [r20 completionHandler];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            (r0[0x2])();
                                            [r25 release];
                                            [r20 setCompletionHandler:0x0];
                                            [r23 release];
                                            [r21 release];
                                    }
                                    if (r22 == 0x0) {
                                            r0 = [r20 login];
                                            r0 = [r0 retain];
                                            if (r0 != 0x0) {
                                                    r21 = r0;
                                                    r0 = [r20 password];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    [r0 release];
                                                    [r21 release];
                                                    if (r23 != 0x0) {
                                                            r0 = dispatch_get_global_queue(0x19, 0x0);
                                                            r0 = [r0 retain];
                                                            r21 = r0;
                                                            var_78 = *__NSConcreteStackBlock;
                                                            dispatch_async(r0, &var_78);
                                                            [r21 release];
                                                    }
                                            }
                                    }
                                    [r22 release];
                                    [r19 release];
                            }
                            else {
                                    r0 = [NSApplication sharedApplication];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 setIsDemo];
                                    [r21 release];
                                    [r20 setRegistrationWorkInProgress:[r20 registrationWorkInProgress] - 0x1];
                                    r0 = [r20 completionHandler];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    [r0 release];
                                    if (r21 != 0x0) {
                                            r23 = [[NSBundle mainBundle] retain];
                                            if (r22 != 0x0) {
                                                    r21 = [[r23 localizedStringForKey:@"Unlocking failed" value:@"" table:0x0] retain];
                                                    [r23 release];
                                                    r23 = [r22 retain];
                                            }
                                            else {
                                                    r21 = [[r23 localizedStringForKey:@"Finished unlocking" value:@"" table:0x0] retain];
                                                    [r23 release];
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    r24 = [[r0 localizedStringForKey:@"This copy of %@ is now fully enabled." value:@"" table:0x0] retain];
                                                    [r23 release];
                                                    r23 = [[NSString stringWithFormat:r24] retain];
                                                    [r24 release];
                                            }
                                            if (r22 == 0x0) {
                                                    r24 = 0x1;
                                            }
                                            r0 = [r20 completionHandler];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            (r0[0x2])();
                                            [r25 release];
                                            [r20 setCompletionHandler:0x0];
                                            [r23 release];
                                            [r21 release];
                                    }
                                    if (r22 == 0x0) {
                                            r0 = [r20 login];
                                            r0 = [r0 retain];
                                            if (r0 != 0x0) {
                                                    r21 = r0;
                                                    r0 = [r20 password];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    [r0 release];
                                                    [r21 release];
                                                    if (r23 != 0x0) {
                                                            r0 = dispatch_get_global_queue(0x19, 0x0);
                                                            r0 = [r0 retain];
                                                            r21 = r0;
                                                            var_78 = *__NSConcreteStackBlock;
                                                            dispatch_async(r0, &var_78);
                                                            [r21 release];
                                                    }
                                            }
                                    }
                                    [r22 release];
                                    [r19 release];
                            }
                    }
                    else {
                            r0 = [CXSetupLib demoUtilsClass];
                            r0 = [r0 splitLicenseAndSigFromBuffer:r19];
                            r0 = [r0 retain];
                            r21 = r0;
                            if (r0 != 0x0) {
                                    r22 = [[r21 objectAtIndexedSubscript:0x0] retain];
                                    r0 = [NSNull null];
                                    r0 = [r0 retain];
                                    if (r22 != r0) {
                                            r23 = r0;
                                            r24 = [[r21 objectAtIndexedSubscript:0x1] retain];
                                            r0 = [NSNull null];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            [r0 release];
                                            [r24 release];
                                            [r23 release];
                                            [r22 release];
                                            if (r24 != r25) {
                                                    r23 = [[r21 objectAtIndex:0x0] retain];
                                                    r24 = [[r21 objectAtIndex:0x1] retain];
                                                    r0 = [CXSetupLib demoUtilsClass];
                                                    r3 = r24;
                                                    r0 = [r0 demoStatusForLicenseFile:r23 andSig:r3];
                                                    r0 = [r0 retain];
                                                    r25 = r0;
                                                    r0 = [r0 objectAtIndex:0x0];
                                                    r0 = [r0 retain];
                                                    r22 = r0;
                                                    r26 = [r0 boolValue];
                                                    [r22 release];
                                                    if (r26 != 0x0) {
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r26 = r0;
                                                            r22 = [[r0 localizedStringForKey:@"Your support contract is not valid for this product. You may need to purchase a support extension or an additional license." value:@"" table:0x0] retain];
                                                            [r26 release];
                                                            r0 = [NSFileManager defaultManager];
                                                            r0 = [r0 retain];
                                                            r26 = r0;
                                                            [r0 removeItemAtPath:r23 error:0x0];
                                                            [r26 removeItemAtPath:r24 error:0x0];
                                                    }
                                                    else {
                                                            var_80 = [[r24 pathExtension] retain];
                                                            if ([r20 regMode] != 0x0) {
                                                                    r28 = sign_extend_64(*(int32_t *)ivar_offset(globalPrefsFolder));
                                                            }
                                                            else {
                                                                    r28 = sign_extend_64(*(int32_t *)ivar_offset(localPrefsFolder));
                                                            }
                                                            r26 = *(r20 + r28);
                                                            r22 = [[NSString stringWithFormat:@"%@.%@.license", r3, r4] retain];
                                                            r26 = [[r26 stringByAppendingPathComponent:r22] retain];
                                                            [r22 release];
                                                            r22 = *(r20 + r28);
                                                            r28 = [[NSString stringWithFormat:@"%@.%@.%@", r3, r4, r5] retain];
                                                            r22 = [[r22 stringByAppendingPathComponent:r28] retain];
                                                            [r28 release];
                                                            [r20 moveFile:r23 dest:r26];
                                                            [r20 moveFile:r24 dest:r22];
                                                            [var_80 release];
                                                            [r22 release];
                                                            r22 = 0x0;
                                                    }
                                                    [r26 release];
                                                    [r25 release];
                                                    [r24 release];
                                            }
                                            else {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                                            }
                                    }
                                    else {
                                            [r22 release];
                                            [r22 release];
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                                    }
                            }
                            else {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                            }
                            [r23 release];
                            [r21 release];
                            r0 = [NSApplication sharedApplication];
                            r0 = [r0 retain];
                            r21 = r0;
                            [r0 setIsDemo];
                            [r21 release];
                            [r20 setRegistrationWorkInProgress:[r20 registrationWorkInProgress] - 0x1];
                            r0 = [r20 completionHandler];
                            r0 = [r0 retain];
                            r21 = r0;
                            [r0 release];
                            if (r21 != 0x0) {
                                    r23 = [[NSBundle mainBundle] retain];
                                    if (r22 != 0x0) {
                                            r21 = [[r23 localizedStringForKey:@"Unlocking failed" value:@"" table:0x0] retain];
                                            [r23 release];
                                            r23 = [r22 retain];
                                    }
                                    else {
                                            r21 = [[r23 localizedStringForKey:@"Finished unlocking" value:@"" table:0x0] retain];
                                            [r23 release];
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r24 = [[r0 localizedStringForKey:@"This copy of %@ is now fully enabled." value:@"" table:0x0] retain];
                                            [r23 release];
                                            r23 = [[NSString stringWithFormat:r24] retain];
                                            [r24 release];
                                    }
                                    if (r22 == 0x0) {
                                            r24 = 0x1;
                                    }
                                    r0 = [r20 completionHandler];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    (r0[0x2])();
                                    [r25 release];
                                    [r20 setCompletionHandler:0x0];
                                    [r23 release];
                                    [r21 release];
                            }
                            if (r22 == 0x0) {
                                    r0 = [r20 login];
                                    r0 = [r0 retain];
                                    if (r0 != 0x0) {
                                            r21 = r0;
                                            r0 = [r20 password];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            [r0 release];
                                            [r21 release];
                                            if (r23 != 0x0) {
                                                    r0 = dispatch_get_global_queue(0x19, 0x0);
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    var_78 = *__NSConcreteStackBlock;
                                                    dispatch_async(r0, &var_78);
                                                    [r21 release];
                                            }
                                    }
                            }
                            [r22 release];
                            [r19 release];
                    }
            }
            else {
                    r0 = [NSApplication sharedApplication];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 setIsDemo];
                    [r21 release];
                    [r20 setRegistrationWorkInProgress:[r20 registrationWorkInProgress] - 0x1];
                    r0 = [r20 completionHandler];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 release];
                    if (r21 != 0x0) {
                            r23 = [[NSBundle mainBundle] retain];
                            if (r22 != 0x0) {
                                    r21 = [[r23 localizedStringForKey:@"Unlocking failed" value:@"" table:0x0] retain];
                                    [r23 release];
                                    r23 = [r22 retain];
                            }
                            else {
                                    r21 = [[r23 localizedStringForKey:@"Finished unlocking" value:@"" table:0x0] retain];
                                    [r23 release];
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r24 = [[r0 localizedStringForKey:@"This copy of %@ is now fully enabled." value:@"" table:0x0] retain];
                                    [r23 release];
                                    r23 = [[NSString stringWithFormat:r24] retain];
                                    [r24 release];
                            }
                            if (r22 == 0x0) {
                                    r24 = 0x1;
                            }
                            r0 = [r20 completionHandler];
                            r0 = [r0 retain];
                            r25 = r0;
                            (r0[0x2])();
                            [r25 release];
                            [r20 setCompletionHandler:0x0];
                            [r23 release];
                            [r21 release];
                    }
                    if (r22 == 0x0) {
                            r0 = [r20 login];
                            r0 = [r0 retain];
                            if (r0 != 0x0) {
                                    r21 = r0;
                                    r0 = [r20 password];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    [r0 release];
                                    [r21 release];
                                    if (r23 != 0x0) {
                                            r0 = dispatch_get_global_queue(0x19, 0x0);
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            var_78 = *__NSConcreteStackBlock;
                                            dispatch_async(r0, &var_78);
                                            [r21 release];
                                    }
                            }
                    }
                    [r22 release];
                    [r19 release];
            }
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r23 = [[r0 localizedStringForKey:@"Download incomplete." value:@"" table:0x0] retain];
            [r22 release];
            [r21 release];
            r22 = r23;
            if (r23 == 0x0) {
                    r4 = 0x0;
                    r0 = [CXSetupLib demoUtilsClass];
                    r0 = [r0 splitLicenseAndSigFromBuffer:r19];
                    r0 = [r0 retain];
                    r21 = r0;
                    if (r0 != 0x0) {
                            r22 = [[r21 objectAtIndexedSubscript:0x0] retain];
                            r0 = [NSNull null];
                            r0 = [r0 retain];
                            if (r22 != r0) {
                                    r23 = r0;
                                    r24 = [[r21 objectAtIndexedSubscript:0x1] retain];
                                    r0 = [NSNull null];
                                    r0 = [r0 retain];
                                    r25 = r0;
                                    [r0 release];
                                    [r24 release];
                                    [r23 release];
                                    [r22 release];
                                    if (r24 != r25) {
                                            r23 = [[r21 objectAtIndex:0x0] retain];
                                            r24 = [[r21 objectAtIndex:0x1] retain];
                                            r0 = [CXSetupLib demoUtilsClass];
                                            r3 = r24;
                                            r0 = [r0 demoStatusForLicenseFile:r23 andSig:r3];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r0 = [r0 objectAtIndex:0x0];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            r26 = [r0 boolValue];
                                            [r22 release];
                                            if (r26 != 0x0) {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r26 = r0;
                                                    r22 = [[r0 localizedStringForKey:@"Your support contract is not valid for this product. You may need to purchase a support extension or an additional license." value:@"" table:0x0] retain];
                                                    [r26 release];
                                                    r0 = [NSFileManager defaultManager];
                                                    r0 = [r0 retain];
                                                    r26 = r0;
                                                    [r0 removeItemAtPath:r23 error:0x0];
                                                    [r26 removeItemAtPath:r24 error:0x0];
                                            }
                                            else {
                                                    var_80 = [[r24 pathExtension] retain];
                                                    if ([r20 regMode] != 0x0) {
                                                            r28 = sign_extend_64(*(int32_t *)ivar_offset(globalPrefsFolder));
                                                    }
                                                    else {
                                                            r28 = sign_extend_64(*(int32_t *)ivar_offset(localPrefsFolder));
                                                    }
                                                    r26 = *(r20 + r28);
                                                    r22 = [[NSString stringWithFormat:@"%@.%@.license", r3, 0x0] retain];
                                                    r26 = [[r26 stringByAppendingPathComponent:r22] retain];
                                                    [r22 release];
                                                    r22 = *(r20 + r28);
                                                    r28 = [[NSString stringWithFormat:@"%@.%@.%@", r3, r4, r5] retain];
                                                    r22 = [[r22 stringByAppendingPathComponent:r28] retain];
                                                    [r28 release];
                                                    [r20 moveFile:r23 dest:r26];
                                                    [r20 moveFile:r24 dest:r22];
                                                    [var_80 release];
                                                    [r22 release];
                                                    r22 = 0x0;
                                            }
                                            [r26 release];
                                            [r25 release];
                                            [r24 release];
                                    }
                                    else {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                                    }
                            }
                            else {
                                    [r22 release];
                                    [r22 release];
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                            }
                    }
                    else {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r23 = r0;
                            r22 = [[r0 localizedStringForKey:@"Download corrupted." value:@"" table:0x0] retain];
                    }
                    [r23 release];
                    [r21 release];
                    r0 = [NSApplication sharedApplication];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 setIsDemo];
                    [r21 release];
                    [r20 setRegistrationWorkInProgress:[r20 registrationWorkInProgress] - 0x1];
                    r0 = [r20 completionHandler];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 release];
                    if (r21 != 0x0) {
                            r27 = &@selector(keyPathsForValuesAffectingCanRegister);
                            r23 = [[NSBundle mainBundle] retain];
                            if (r22 != 0x0) {
                                    r21 = [[r23 localizedStringForKey:@"Unlocking failed" value:@"" table:0x0] retain];
                                    [r23 release];
                                    r23 = [r22 retain];
                            }
                            else {
                                    r21 = [[r23 localizedStringForKey:@"Finished unlocking" value:@"" table:0x0] retain];
                                    [r23 release];
                                    r0 = r27[0x195];
                                    r0 = [r0 mainBundle];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r24 = [[r0 localizedStringForKey:@"This copy of %@ is now fully enabled." value:@"" table:0x0] retain];
                                    [r23 release];
                                    r23 = [[NSString stringWithFormat:r24] retain];
                                    [r24 release];
                            }
                            if (r22 == 0x0) {
                                    r24 = 0x1;
                            }
                            r0 = [r20 completionHandler];
                            r0 = [r0 retain];
                            r25 = r0;
                            (r0[0x2])();
                            [r25 release];
                            [r20 setCompletionHandler:0x0];
                            [r23 release];
                            [r21 release];
                    }
                    if (r22 == 0x0) {
                            r0 = [r20 login];
                            r0 = [r0 retain];
                            if (r0 != 0x0) {
                                    r21 = r0;
                                    r0 = [r20 password];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    [r0 release];
                                    [r21 release];
                                    if (r23 != 0x0) {
                                            r0 = dispatch_get_global_queue(0x19, 0x0);
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            var_78 = *__NSConcreteStackBlock;
                                            dispatch_async(r0, &var_78);
                                            [r21 release];
                                    }
                            }
                    }
                    [r22 release];
                    [r19 release];
            }
            else {
                    r0 = [NSApplication sharedApplication];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 setIsDemo];
                    [r21 release];
                    [r20 setRegistrationWorkInProgress:[r20 registrationWorkInProgress] - 0x1];
                    r0 = [r20 completionHandler];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 release];
                    if (r21 != 0x0) {
                            r27 = &@selector(keyPathsForValuesAffectingCanRegister);
                            r23 = [[NSBundle mainBundle] retain];
                            if (r22 != 0x0) {
                                    r21 = [[r23 localizedStringForKey:@"Unlocking failed" value:@"" table:0x0] retain];
                                    [r23 release];
                                    r23 = [r22 retain];
                            }
                            else {
                                    r21 = [[r23 localizedStringForKey:@"Finished unlocking" value:@"" table:0x0] retain];
                                    [r23 release];
                                    r0 = r27[0x195];
                                    r0 = [r0 mainBundle];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r24 = [[r0 localizedStringForKey:@"This copy of %@ is now fully enabled." value:@"" table:0x0] retain];
                                    [r23 release];
                                    r23 = [[NSString stringWithFormat:r24] retain];
                                    [r24 release];
                            }
                            if (r22 == 0x0) {
                                    r24 = 0x1;
                            }
                            r0 = [r20 completionHandler];
                            r0 = [r0 retain];
                            r25 = r0;
                            (r0[0x2])();
                            [r25 release];
                            [r20 setCompletionHandler:0x0];
                            [r23 release];
                            [r21 release];
                    }
                    if (r22 == 0x0) {
                            r0 = [r20 login];
                            r0 = [r0 retain];
                            if (r0 != 0x0) {
                                    r21 = r0;
                                    r0 = [r20 password];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    [r0 release];
                                    [r21 release];
                                    if (r23 != 0x0) {
                                            r0 = dispatch_get_global_queue(0x19, 0x0);
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            var_78 = *__NSConcreteStackBlock;
                                            dispatch_async(r0, &var_78);
                                            [r21 release];
                                    }
                            }
                    }
                    [r22 release];
                    [r19 release];
            }
    }
    return;


// 0x10005c430
// -[RegistrationController handleSerialCodeAccountCreationData:]
    var_40 = r26;
    decomp_var_38 = r25;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r21 = [NSString alloc];
            r0 = objc_retainAutorelease(r19);
            r21 = [r21 initWithBytes:[r0 bytes] length:[r0 length] encoding:0x4];
    }
    else {
            r21 = 0x0;
    }
    r22 = [[[CXSetupLib demoUtilsClass] checkSerialCodeRegistrationResponse:r21] retain];
    r23 = [[r20 completionHandler] retain];
    if (r22 != 0x0) {
            [r23 release];
            if (r23 != 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r24 = r0;
                    r23 = [[r0 localizedStringForKey:@"Activation failed" value:@"" table:0x0] retain];
                    [r24 release];
                    r24 = [r22 retain];
                    r0 = [r20 completionHandler];
                    r0 = [r0 retain];
                    r25 = r0;
                    (r0[0x2])();
                    [r24 release];
                    [r25 release];
                    [r20 setCompletionHandler:0x0];
                    [r23 release];
            }
    }
    else {
            [r20 beginRegisterAppWithCompletionHandler:r23];
            [r23 release];
    }
    [r21 release];
    [r22 release];
    [r19 release];
    return;


// 0x10005c5c4
// -[RegistrationController downloadTaskCompleted:response:error:successHandler:errorMessageText:]
    r31 = r31 - 0x70;
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
    r23 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    r22 = [arg5 retain];
    r24 = [arg6 retain];
    if (r21 != 0x0) {
            r0 = [r21 localizedDescription];
            r0 = [r0 retain];
            r25 = r0;
            if (r0 != 0x0) {
                    [r23 setRegistrationWorkInProgress:0x0];
                    r0 = [r23 completionHandler];
                    r0 = [r0 retain];
                    r26 = r0;
                    [r0 release];
                    if (r26 != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r26 = r0;
                            r27 = [[r0 localizedStringForKey:@"Failed to download license file: %@" value:@"" table:0x0] retain];
                            [r26 release];
                            r26 = [[NSString stringWithFormat:r27] retain];
                            [r27 release];
                            r27 = [[r26 stringByAppendingString:@"\n\n"] retain];
                            [r26 release];
                            r26 = [[[CXSetupLib demoUtilsClass] lastResort] retain];
                            r28 = [[r27 stringByAppendingString:r26] retain];
                            [r27 release];
                            [r26 release];
                            r0 = [r23 completionHandler];
                            r0 = [r0 retain];
                            r26 = r0;
                            (r0[0x2])();
                            [r26 release];
                            [r23 setCompletionHandler:0x0];
                            [r28 release];
                    }
                    [r25 release];
                    [r24 release];
                    [r22 release];
                    [r21 release];
                    [r20 release];
                    [r19 release];
            }
            else {
                    objc_opt_class(@class(NSHTTPURLResponse));
                    if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                            r0 = [r20 retain];
                            r26 = r0;
                            if ([r0 statusCode] == 0xc8) {
                                    [r26 release];
                                    (r22[0x2])(r22, r19);
                                    [r23 setRegistrationWorkInProgress:[r23 registrationWorkInProgress] - 0x1];
                                    [0x0 release];
                                    [r24 release];
                                    [r22 release];
                                    [r21 release];
                                    [r20 release];
                                    [r19 release];
                            }
                            else {
                                    r25 = [[NSHTTPURLResponse localizedStringForStatusCode:[r26 statusCode]] retain];
                                    [r26 release];
                                    if (r25 == 0x0) {
                                            (r22[0x2])(r22, r19);
                                            [r23 setRegistrationWorkInProgress:[r23 registrationWorkInProgress] - 0x1];
                                            [0x0 release];
                                            [r24 release];
                                            [r22 release];
                                            [r21 release];
                                            [r20 release];
                                            [r19 release];
                                    }
                                    else {
                                            [r23 setRegistrationWorkInProgress:0x0];
                                            r0 = [r23 completionHandler];
                                            r0 = [r0 retain];
                                            r26 = r0;
                                            [r0 release];
                                            if (r26 != 0x0) {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r26 = r0;
                                                    r27 = [[r0 localizedStringForKey:@"Failed to download license file: %@" value:@"" table:0x0] retain];
                                                    [r26 release];
                                                    r26 = [[NSString stringWithFormat:r27] retain];
                                                    [r27 release];
                                                    r27 = [[r26 stringByAppendingString:@"\n\n"] retain];
                                                    [r26 release];
                                                    r26 = [[[CXSetupLib demoUtilsClass] lastResort] retain];
                                                    r28 = [[r27 stringByAppendingString:r26] retain];
                                                    [r27 release];
                                                    [r26 release];
                                                    r0 = [r23 completionHandler];
                                                    r0 = [r0 retain];
                                                    r26 = r0;
                                                    (r0[0x2])();
                                                    [r26 release];
                                                    [r23 setCompletionHandler:0x0];
                                                    [r28 release];
                                            }
                                            [r25 release];
                                            [r24 release];
                                            [r22 release];
                                            [r21 release];
                                            [r20 release];
                                            [r19 release];
                                    }
                            }
                    }
                    else {
                            (r22[0x2])(r22, r19);
                            [r23 setRegistrationWorkInProgress:[r23 registrationWorkInProgress] - 0x1];
                            [0x0 release];
                            [r24 release];
                            [r22 release];
                            [r21 release];
                            [r20 release];
                            [r19 release];
                    }
            }
    }
    else {
            objc_opt_class(@class(NSHTTPURLResponse));
            if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
                    r0 = [r20 retain];
                    r26 = r0;
                    if ([r0 statusCode] == 0xc8) {
                            [r26 release];
                            (r22[0x2])(r22, r19);
                            [r23 setRegistrationWorkInProgress:[r23 registrationWorkInProgress] - 0x1];
                            [0x0 release];
                            [r24 release];
                            [r22 release];
                            [r21 release];
                            [r20 release];
                            [r19 release];
                    }
                    else {
                            r25 = [[NSHTTPURLResponse localizedStringForStatusCode:[r26 statusCode]] retain];
                            [r26 release];
                            if (r25 == 0x0) {
                                    (r22[0x2])(r22, r19);
                                    [r23 setRegistrationWorkInProgress:[r23 registrationWorkInProgress] - 0x1];
                                    [0x0 release];
                                    [r24 release];
                                    [r22 release];
                                    [r21 release];
                                    [r20 release];
                                    [r19 release];
                            }
                            else {
                                    [r23 setRegistrationWorkInProgress:0x0];
                                    r0 = [r23 completionHandler];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    [r0 release];
                                    if (r26 != 0x0) {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r26 = r0;
                                            r27 = [[r0 localizedStringForKey:@"Failed to download license file: %@" value:@"" table:0x0] retain];
                                            [r26 release];
                                            r26 = [[NSString stringWithFormat:r27] retain];
                                            [r27 release];
                                            r27 = [[r26 stringByAppendingString:@"\n\n"] retain];
                                            [r26 release];
                                            r26 = [[[CXSetupLib demoUtilsClass] lastResort] retain];
                                            r28 = [[r27 stringByAppendingString:r26] retain];
                                            [r27 release];
                                            [r26 release];
                                            r0 = [r23 completionHandler];
                                            r0 = [r0 retain];
                                            r26 = r0;
                                            (r0[0x2])();
                                            [r26 release];
                                            [r23 setCompletionHandler:0x0];
                                            [r28 release];
                                    }
                                    [r25 release];
                                    [r24 release];
                                    [r22 release];
                                    [r21 release];
                                    [r20 release];
                                    [r19 release];
                            }
                    }
            }
            else {
                    (r22[0x2])(r22, r19);
                    [r23 setRegistrationWorkInProgress:[r23 registrationWorkInProgress] - 0x1];
                    [0x0 release];
                    [r24 release];
                    [r22 release];
                    [r21 release];
                    [r20 release];
                    [r19 release];
            }
    }
    return;


// 0x10005c878
// -[RegistrationController moveFile:dest:]
    var_30 = r28;
    decomp_var_28 = r27;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xffffffffffffffc0 - 0x430;
    r21 = self;
    var_38 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(authorization));
    if (*(r21 + r22) != 0x0) {
            var_450 = [objc_retainAutorelease(r19) fileSystemRepresentation];
            [objc_retainAutorelease(r20) fileSystemRepresentation];
            var_458 = 0x0;
            r0 = *(r21 + r22);
            r0 = [r0 authorizationRef];
            r0 = AuthorizationExecuteWithPrivileges(r0, "/bin/mv", 0x0, &var_450, &var_458);
            if (r0 == 0x0) {
                    r21 = 0x1;
            }
            if (r0 == 0x0) {
                    do {
                            r0 = fileno(var_458);
                            r0 = read(r0, &decomp_var_438, 0x400);
                    } while (r0 > 0x0);
                    fclose(var_458);
            }
    }
    else {
            r0 = [[NSFileManager alloc] init];
            r22 = r0;
            [r0 setDelegate:r21];
            [r22 removeItemAtPath:r20 error:0x0];
            r21 = [r22 moveItemAtPath:r19 toPath:r20 error:0x0];
            [r22 release];
    }
    [r20 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    r0 = r21;
    return r0;


// 0x10005c9d8
// -[RegistrationController fileManager:shouldProceedAfterError:movingItemAtURL:toURL:]
    NSLog(@"Error moving %@ to %@: %@", _cmd, arg2, r3);
    return 0x0;


// 0x10005ca08
// -[RegistrationController cancel]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = sign_extend_64(*(int32_t *)ivar_offset(downloadTask));
    r0 = *(self + r20);
    if (r0 != 0x0) {
            [r0 cancel];
            r0 = *(r19 + r20);
            *(r19 + r20) = 0x0;
            [r0 release];
    }
    [r19 setRegistrationWorkInProgress:0x0];
    return;


// 0x10005ca4c
// -[RegistrationController validLogin]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self login];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r0 = [r19 login];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 rangeOfString:@"@"];
            [r20 release];
            if (r21 == 0x7fffffffffffffff) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 localizedStringForKey:@"Please enter a valid email address.\n(e.g. myusername@myemailprovider.com)" value:@"" table:0x0] retain];
                    [r19 setLoginErrorText:r21];
                    [r21 release];
                    [r20 release];
                    r0 = 0x0;
            }
            else {
                    r20 = [[r19 login] retain];
                    r21 = [[r19 login2] retain];
                    r22 = [r20 isEqualToString:r21];
                    [r21 release];
                    [r20 release];
                    if ((r22 & 0x1) != 0x0) {
                            [r19 setLoginErrorText:@""];
                            r0 = 0x1;
                    }
                    else {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r21 = [[r0 localizedStringForKey:@"The provided email addresses do not match" value:@"" table:0x0] retain];
                            [r19 setLoginErrorText:r21];
                            [r21 release];
                            [r20 release];
                            r0 = 0x0;
                    }
            }
    }
    else {
            r0 = 0x0;
    }
    return r0;


// 0x10005cba4
// -[RegistrationController validPassword]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self password];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r20 = [[r19 password] retain];
            r21 = [[r19 password2] retain];
            r22 = [r20 isEqualToString:r21];
            [r21 release];
            [r20 release];
            if ((r22 & 0x1) != 0x0) {
                    [r19 setPasswordErrorText:@""];
                    r0 = 0x1;
            }
            else {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 localizedStringForKey:@"The provided passwords do not match" value:@"" table:0x0] retain];
                    [r19 setPasswordErrorText:r21];
                    [r21 release];
                    [r20 release];
                    r0 = 0x0;
            }
    }
    else {
            r0 = 0x0;
    }
    return r0;


// 0x10005cca0
// -[RegistrationController validSerialCode]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self serialCode];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r0 = [r19 serialCode];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 stringByReplacingOccurrencesOfString:@"-" withString:@""] retain];
            [r20 release];
            r22 = [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
            r20 = [[r21 stringByTrimmingCharactersInSet:r22] retain];
            [r21 release];
            [r22 release];
            r0 = [r20 length];
            bool_3 = r0 != 0x13;
            if (r0 == 0x13) {
                    r21 = 0x1;
            }
            if (!bool_3) {
                    [r19 setSerialCodeErrorText:@""];
            }
            else {
                    r23 = [r20 length];
                    r22 = [[NSBundle mainBundle] retain];
                    if (r23 <= 0x12) {
                            r2 = @"This activation code is not valid - it is too short.\n(Example: XXX-XXXX-XXXX-XXXXXXXX).";
                    }
                    else {
                            r2 = @"This activation code is not valid - it is too long.\n(Example: XXX-XXXX-XXXX-XXXXXXXX).";
                    }
                    r23 = [[r22 localizedStringForKey:r2 value:@"" table:0x0] retain];
                    [r19 setSerialCodeErrorText:r23];
                    [r23 release];
                    [r22 release];
            }
            [r20 release];
    }
    else {
            r21 = 0x0;
    }
    r0 = r21;
    return r0;


// 0x10005ce18
// -[RegistrationController login]
    r0 = self->_login;
    return r0;


// 0x10005ce28
// -[RegistrationController setLogin:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005ce34
// -[RegistrationController login2]
    r0 = self->_login2;
    return r0;


// 0x10005ce44
// -[RegistrationController setLogin2:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005ce50
// -[RegistrationController loginErrorText]
    r0 = self->_loginErrorText;
    return r0;


// 0x10005ce60
// -[RegistrationController setLoginErrorText:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005ce6c
// -[RegistrationController password]
    r0 = self->_password;
    return r0;


// 0x10005ce7c
// -[RegistrationController setPassword:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005ce88
// -[RegistrationController password2]
    r0 = self->_password2;
    return r0;


// 0x10005ce98
// -[RegistrationController setPassword2:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005cea4
// -[RegistrationController passwordErrorText]
    r0 = self->_passwordErrorText;
    return r0;


// 0x10005ceb4
// -[RegistrationController setPasswordErrorText:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005cec0
// -[RegistrationController registrationWorkInProgress]
    r0 = *(int32_t *)(int64_t *)&self->_registrationWorkInProgress;
    return r0;


// 0x10005ced0
// -[RegistrationController setRegistrationWorkInProgress:]
    *(int32_t *)(int64_t *)&self->_registrationWorkInProgress = arg2;
    return;


// 0x10005cee0
// -[RegistrationController regMode]
    r0 = *(int32_t *)(int64_t *)&self->_regMode;
    return r0;


// 0x10005cef0
// -[RegistrationController setRegMode:]
    *(int32_t *)(int64_t *)&self->_regMode = arg2;
    return;


// 0x10005cf00
// -[RegistrationController globalRegModeCaption]
    r0 = self->_globalRegModeCaption;
    return r0;


// 0x10005cf10
// -[RegistrationController setGlobalRegModeCaption:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005cf1c
// -[RegistrationController accountName]
    r0 = self->_accountName;
    return r0;


// 0x10005cf2c
// -[RegistrationController setAccountName:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005cf38
// -[RegistrationController serialCode]
    r0 = self->_serialCode;
    return r0;


// 0x10005cf48
// -[RegistrationController setSerialCode:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005cf54
// -[RegistrationController serialCodeErrorText]
    r0 = self->_serialCodeErrorText;
    return r0;


// 0x10005cf64
// -[RegistrationController setSerialCodeErrorText:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005cf70
// -[RegistrationController completionHandler]
    r0 = self->_completionHandler;
    return r0;


// 0x10005cf80
// -[RegistrationController setCompletionHandler:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10005cf8c
// -[RegistrationController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_completionHandler, 0x0);
    objc_storeStrong((int64_t *)&self->_serialCodeErrorText, 0x0);
    objc_storeStrong((int64_t *)&self->_serialCode, 0x0);
    objc_storeStrong((int64_t *)&self->_accountName, 0x0);
    objc_storeStrong((int64_t *)&self->_globalRegModeCaption, 0x0);
    objc_storeStrong((int64_t *)&self->_passwordErrorText, 0x0);
    objc_storeStrong((int64_t *)&self->_password2, 0x0);
    objc_storeStrong((int64_t *)&self->_password, 0x0);
    objc_storeStrong((int64_t *)&self->_loginErrorText, 0x0);
    objc_storeStrong((int64_t *)&self->_login2, 0x0);
    objc_storeStrong((int64_t *)&self->_login, 0x0);
    objc_storeStrong((int64_t *)&self->globalPrefsFolder, 0x0);
    objc_storeStrong((int64_t *)&self->localPrefsFolder, 0x0);
    objc_storeStrong((int64_t *)&self->authorization, 0x0);
    objc_storeStrong((int64_t *)&self->downloadTask, 0x0);
    objc_storeStrong((int64_t *)&self->session, 0x0);
    return;


