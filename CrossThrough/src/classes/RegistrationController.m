// RegistrationController.m — CrossThrough
#import "RegistrationController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

#import <SecurityFoundation/SFAuthorization.h>

// Activation codes are 19 characters once the dashes are stripped:
// XXX-XXXX-XXXX-XXXXXXXX.
static const NSUInteger kSerialCodeLength = 19;
// A license download shorter than this can't hold a license and signature.
static const NSUInteger kMinimumLicenseDownloadLength = 64;

@implementation RegistrationController

- (id)init {
    self = [super init];
    if (self) {
        self->registrarClass = [CXSetupLib demoUtilsClass];
        self->session = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                       delegate:nil
                                                  delegateQueue:[NSOperationQueue mainQueue]] retain];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // User domain first, then local (all users).
        NSArray *libraries = [fileManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask | NSLocalDomainMask];
        if ([libraries count] < 2) {
            NSLog(@"Failed to retrieve Library directories.\n");
            return self;
        }
        NSURL *localPrefs = [[libraries objectAtIndexedSubscript:0] URLByAppendingPathComponent:@"Preferences" isDirectory:YES];
        if (!localPrefs) {
            NSLog(@"Failed to locate the local Preferences directory.\n");
            return self;
        }
        self->localPrefsFolder = [[localPrefs stringWithFileSystemRepresentation] retain];
        NSURL *globalPrefs = [[libraries objectAtIndexedSubscript:1] URLByAppendingPathComponent:@"Preferences" isDirectory:YES];
        if (!globalPrefs) {
            NSLog(@"Failed to locate the global Preferences directory.\n");
            return self;
        }
        self->globalPrefsFolder = [[globalPrefs stringWithFileSystemRepresentation] retain];
        NSString *caption;
        if ([fileManager isWritableFileAtPath:self->globalPrefsFolder]) {
            self->_regMode = 1;
            caption = [[NSBundle mainBundle] localizedStringForKey:@"Unlock for all users of this computer" value:@"" table:nil];
        } else {
            self->_regMode = 0;
            caption = [[NSBundle mainBundle] localizedStringForKey:@"Unlock for all users of this computer (requires authentication)" value:@"" table:nil];
        }
        self->_globalRegModeCaption = [caption copy];
    }
    return self;
}

- (BOOL)authIfNeeded {
    // Installing for all users needs admin rights when the global
    // Preferences folder isn't writable; obtain them up front so the license
    // can be moved into place later.
    if ([[NSFileManager defaultManager] isWritableFileAtPath:self->globalPrefsFolder] || [self regMode] != 1) {
        [self->authorization release];
        self->authorization = nil;
        return YES;
    }
    if (!self->authorization) {
        self->authorization = [[SFAuthorization alloc] init];
    }
    AuthorizationFlags flags = kAuthorizationFlagInteractionAllowed | kAuthorizationFlagExtendRights | kAuthorizationFlagPreAuthorize;
    return self->authorization && [self->authorization obtainWithRight:"system.privilege.admin" flags:flags error:NULL];
}

- (id)formatSerialCode:(id)arg1 {
    NSString *code = [NSString stringWithString:[arg1 stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    code = [code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSUInteger length = [code length];
    if (length > 3) {
        code = [code stringByReplacingCharactersInRange:NSMakeRange(3, 0) withString:@"-"];
        if (length > 7) {
            code = [code stringByReplacingCharactersInRange:NSMakeRange(8, 0) withString:@"-"];
            if (length > 11) {
                code = [code stringByReplacingCharactersInRange:NSMakeRange(13, 0) withString:@"-"];
            }
        }
    }
    return code;
}

- (void)beginRegisterAppWithSerialCodeWithCompletionHandler:(id)arg1 {
    [self setCompletionHandler:arg1];
    if (![self login] || ![self password] || ![self accountName] || ![self serialCode]) {
        if ([self completionHandler]) {
            NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Required field missing" value:@"" table:nil];
            NSString *message = [[NSBundle mainBundle] localizedStringForKey:@"You have left a required field blank. Please enter a name, password, email address, and activation code. All fields are required." value:@"" table:nil];
            [self completionHandler](NO, title, message);
        }
        [self setCompletionHandler:nil];
        return;
    }
    BOOL loginOK = [self validLogin];
    BOOL passwordOK = [self validPassword];
    BOOL serialOK = [self validSerialCode];
    if (!loginOK || !passwordOK || !serialOK) {
        return;
    }
    [self setSerialCode:[self formatSerialCode:[self serialCode]]];
    NSData *body = [[CXSetupLib demoUtilsClass] createAccountRequestBodyForEmail:[self login] name:[self accountName] andPassword:[self password] withSerialCode:[self serialCode]];
    if (![self authIfNeeded]) {
        [self setCompletionHandler:nil];
        return;
    }
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:[[CXSetupLib demoUtilsClass] serialRegistrationURL]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];
    [self->downloadTask release];
    self->downloadTask = [[self->session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *failure = [[NSBundle mainBundle] localizedStringForKey:@"Activation failed" value:@"" table:nil];
        [self downloadTaskCompleted:data response:response error:error successHandler:^(NSData *result) {
            [self handleSerialCodeAccountCreationData:result];
        } errorMessageText:failure];
        [self->downloadTask release];
        self->downloadTask = nil;
    }] retain];
    if (self->downloadTask) {
        [self setRegistrationWorkInProgress:[self registrationWorkInProgress] + 1];
        [self->downloadTask resume];
    } else {
        [self setCompletionHandler:nil];
    }
}

- (void)beginRegisterAppWithCompletionHandler:(id)arg1 {
    [self setCompletionHandler:arg1];
    if (![self login] || ![self password] || ![self authIfNeeded]) {
        [self setCompletionHandler:nil];
        return;
    }
    NSString *licenseURL = [[CXSetupLib demoUtilsClass] licenseUrlForLogin:[self login] andPassword:[self password]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:licenseURL]
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:180.0];
    if (!request) {
        if ([self completionHandler]) {
            NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Could not unlock" value:@"" table:nil];
            NSString *message = [[[[NSBundle mainBundle] localizedStringForKey:@"Failed to begin license download." value:@"" table:nil]
                                  stringByAppendingString:@" "] stringByAppendingString:[[CXSetupLib demoUtilsClass] lastResort]];
            [self completionHandler](NO, title, message);
        }
        [self setCompletionHandler:nil];
        return;
    }
    [self->downloadTask release];
    self->downloadTask = [[self->session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *failure = [[NSBundle mainBundle] localizedStringForKey:@"Unlocking failed" value:@"" table:nil];
        [self downloadTaskCompleted:data response:response error:error successHandler:^(NSData *result) {
            [self handleRegistrationData:result];
        } errorMessageText:failure];
        [self->downloadTask release];
        self->downloadTask = nil;
    }] retain];
    [self setRegistrationWorkInProgress:[self registrationWorkInProgress] + 1];
    [self->downloadTask resume];
}

- (void)handleRegistrationData:(id)arg1 {
    [self setRegistrationWorkInProgress:[self registrationWorkInProgress] + 1];
    Class demoUtils = [CXSetupLib demoUtilsClass];
    NSString *error = [demoUtils checkLicenseDownload:arg1];
    if (!arg1 || (!error && [arg1 length] < kMinimumLicenseDownloadLength)) {
        error = [[NSBundle mainBundle] localizedStringForKey:@"Download incomplete." value:@"" table:nil];
    } else if (!error) {
        NSArray *parts = [demoUtils splitLicenseAndSigFromBuffer:arg1];
        if (parts && [parts objectAtIndexedSubscript:0] != [NSNull null] && [parts objectAtIndexedSubscript:1] != [NSNull null]) {
            NSString *licenseFile = [parts objectAtIndex:0];
            NSString *sigFile = [parts objectAtIndex:1];
            NSArray *status = [demoUtils demoStatusForLicenseFile:licenseFile andSig:sigFile];
            if ([[status objectAtIndex:0] boolValue]) {
                // Still a demo with this license: it doesn't cover this product.
                error = [[NSBundle mainBundle] localizedStringForKey:@"Your support contract is not valid for this product. You may need to purchase a support extension or an additional license." value:@"" table:nil];
                [[NSFileManager defaultManager] removeItemAtPath:licenseFile error:NULL];
                [[NSFileManager defaultManager] removeItemAtPath:sigFile error:NULL];
            } else {
                NSString *folder = [self regMode] ? self->globalPrefsFolder : self->localPrefsFolder;
                NSString *licenseDest = [folder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@.license", @"com.codeweavers", @"CrossOver"]];
                NSString *sigDest = [folder stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@.%@", @"com.codeweavers", @"CrossOver", [sigFile pathExtension]]];
                [self moveFile:licenseFile dest:licenseDest];
                [self moveFile:sigFile dest:sigDest];
            }
        } else {
            error = [[NSBundle mainBundle] localizedStringForKey:@"Download corrupted." value:@"" table:nil];
        }
    }

    [(CXApplication *)[NSApplication sharedApplication] setIsDemo];
    [self setRegistrationWorkInProgress:[self registrationWorkInProgress] - 1];
    if ([self completionHandler]) {
        NSString *title;
        NSString *message;
        if (error) {
            title = [[NSBundle mainBundle] localizedStringForKey:@"Unlocking failed" value:@"" table:nil];
            message = error;
        } else {
            title = [[NSBundle mainBundle] localizedStringForKey:@"Finished unlocking" value:@"" table:nil];
            message = [NSString stringWithFormat:[[NSBundle mainBundle] localizedStringForKey:@"This copy of %@ is now fully enabled." value:@"" table:nil], @"CrossOver"];
        }
        [self completionHandler](error == nil, title, message);
        [self setCompletionHandler:nil];
    }
    if (!error && [self login] && [self password]) {
        // Sign in to the web services with the same account in the background.
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            [[CXSetupLib webUtilsClass] createToken:[self login] password:[self password]];
        });
    }
}

- (void)handleSerialCodeAccountCreationData:(id)arg1 {
    NSString *response = nil;
    if (arg1) {
        response = [[[NSString alloc] initWithBytes:[arg1 bytes] length:[arg1 length] encoding:NSUTF8StringEncoding] autorelease];
    }
    NSString *error = [[CXSetupLib demoUtilsClass] checkSerialCodeRegistrationResponse:response];
    id handler = [[[self completionHandler] retain] autorelease];
    if (!error) {
        // The account exists now; download its license.
        [self beginRegisterAppWithCompletionHandler:handler];
        return;
    }
    if (handler) {
        NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Activation failed" value:@"" table:nil];
        [self completionHandler](NO, title, error);
        [self setCompletionHandler:nil];
    }
}

- (void)downloadTaskCompleted:(id)arg1 response:(id)arg2 error:(id)arg3 successHandler:(id)arg4 errorMessageText:(id)arg5 {
    NSString *failure = [arg3 localizedDescription];
    if (!failure && [arg2 isKindOfClass:[NSHTTPURLResponse class]] && [(NSHTTPURLResponse *)arg2 statusCode] != 200) {
        failure = [NSHTTPURLResponse localizedStringForStatusCode:[(NSHTTPURLResponse *)arg2 statusCode]];
    }
    if (!failure) {
        ((void (^)(NSData *))arg4)(arg1);
        [self setRegistrationWorkInProgress:[self registrationWorkInProgress] - 1];
        return;
    }
    [self setRegistrationWorkInProgress:0];
    if ([self completionHandler]) {
        NSString *message = [NSString stringWithFormat:[[NSBundle mainBundle] localizedStringForKey:@"Failed to download license file: %@" value:@"" table:nil], failure];
        message = [[message stringByAppendingString:@"\n\n"] stringByAppendingString:[[CXSetupLib demoUtilsClass] lastResort]];
        [self completionHandler](NO, arg5, message);
        [self setCompletionHandler:nil];
    }
}

- (BOOL)moveFile:(id)arg1 dest:(id)arg2 {
    if (self->authorization) {
        // Installing for all users: /bin/mv runs with the admin rights
        // obtained in -authIfNeeded.
        char *arguments[] = { (char *)[arg1 fileSystemRepresentation], (char *)[arg2 fileSystemRepresentation], NULL };
        FILE *pipe = NULL;
        OSStatus status = AuthorizationExecuteWithPrivileges([self->authorization authorizationRef], "/bin/mv", kAuthorizationFlagDefaults, arguments, &pipe);
        if (status != errAuthorizationSuccess) {
            return NO;
        }
        char buffer[1024];
        while (read(fileno(pipe), buffer, sizeof(buffer)) > 0) {
        }
        fclose(pipe);
        return YES;
    }
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager setDelegate:self];
    [fileManager removeItemAtPath:arg2 error:NULL];
    BOOL moved = [fileManager moveItemAtPath:arg1 toPath:arg2 error:NULL];
    [fileManager release];
    return moved;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 movingItemAtURL:(id)arg3 toURL:(id)arg4 {
    NSLog(@"Error moving %@ to %@: %@", arg3, arg4, arg2);
    return NO;
}

- (void)cancel {
    if (self->downloadTask) {
        [self->downloadTask cancel];
        [self->downloadTask release];
        self->downloadTask = nil;
    }
    [self setRegistrationWorkInProgress:0];
}

- (BOOL)validLogin {
    if (![self login]) {
        return NO;
    }
    if ([[self login] rangeOfString:@"@"].location == NSNotFound) {
        [self setLoginErrorText:[[NSBundle mainBundle] localizedStringForKey:@"Please enter a valid email address.\n(e.g. myusername@myemailprovider.com)" value:@"" table:nil]];
        return NO;
    }
    if (![[self login] isEqualToString:[self login2]]) {
        [self setLoginErrorText:[[NSBundle mainBundle] localizedStringForKey:@"The provided email addresses do not match" value:@"" table:nil]];
        return NO;
    }
    [self setLoginErrorText:@""];
    return YES;
}

- (BOOL)validPassword {
    if (![self password]) {
        return NO;
    }
    if (![[self password] isEqualToString:[self password2]]) {
        [self setPasswordErrorText:[[NSBundle mainBundle] localizedStringForKey:@"The provided passwords do not match" value:@"" table:nil]];
        return NO;
    }
    [self setPasswordErrorText:@""];
    return YES;
}

- (BOOL)validSerialCode {
    if (![self serialCode]) {
        return NO;
    }
    NSString *code = [[[self serialCode] stringByReplacingOccurrencesOfString:@"-" withString:@""]
                      stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([code length] == kSerialCodeLength) {
        [self setSerialCodeErrorText:@""];
        return YES;
    }
    NSString *key = [code length] < kSerialCodeLength
        ? @"This activation code is not valid - it is too short.\n(Example: XXX-XXXX-XXXX-XXXXXXXX)."
        : @"This activation code is not valid - it is too long.\n(Example: XXX-XXXX-XXXX-XXXXXXXX).";
    [self setSerialCodeErrorText:[[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil]];
    return NO;
}

- (id)login {
    return self->_login;
}

- (void)setLogin:(id)arg1 {
    if (self->_login != arg1) {
        [self->_login release];
        self->_login = [arg1 copy];
    }
}

- (id)login2 {
    return self->_login2;
}

- (void)setLogin2:(id)arg1 {
    if (self->_login2 != arg1) {
        [self->_login2 release];
        self->_login2 = [arg1 copy];
    }
}

- (id)loginErrorText {
    return self->_loginErrorText;
}

- (void)setLoginErrorText:(id)arg1 {
    if (self->_loginErrorText != arg1) {
        [self->_loginErrorText release];
        self->_loginErrorText = [arg1 copy];
    }
}

- (id)password {
    return self->_password;
}

- (void)setPassword:(id)arg1 {
    if (self->_password != arg1) {
        [self->_password release];
        self->_password = [arg1 copy];
    }
}

- (id)password2 {
    return self->_password2;
}

- (void)setPassword2:(id)arg1 {
    if (self->_password2 != arg1) {
        [self->_password2 release];
        self->_password2 = [arg1 copy];
    }
}

- (id)passwordErrorText {
    return self->_passwordErrorText;
}

- (void)setPasswordErrorText:(id)arg1 {
    if (self->_passwordErrorText != arg1) {
        [self->_passwordErrorText release];
        self->_passwordErrorText = [arg1 copy];
    }
}

- (NSInteger)registrationWorkInProgress {
    return self->_registrationWorkInProgress;
}

- (void)setRegistrationWorkInProgress:(NSInteger)arg1 {
    self->_registrationWorkInProgress = arg1;
}

- (NSInteger)regMode {
    return self->_regMode;
}

- (void)setRegMode:(NSInteger)arg1 {
    self->_regMode = arg1;
}

- (id)globalRegModeCaption {
    return self->_globalRegModeCaption;
}

- (void)setGlobalRegModeCaption:(id)arg1 {
    if (self->_globalRegModeCaption != arg1) {
        [self->_globalRegModeCaption release];
        self->_globalRegModeCaption = [arg1 copy];
    }
}

- (id)accountName {
    return self->_accountName;
}

- (void)setAccountName:(id)arg1 {
    if (self->_accountName != arg1) {
        [self->_accountName release];
        self->_accountName = [arg1 copy];
    }
}

- (id)serialCode {
    return self->_serialCode;
}

- (void)setSerialCode:(id)arg1 {
    if (self->_serialCode != arg1) {
        [self->_serialCode release];
        self->_serialCode = [arg1 copy];
    }
}

- (id)serialCodeErrorText {
    return self->_serialCodeErrorText;
}

- (void)setSerialCodeErrorText:(id)arg1 {
    if (self->_serialCodeErrorText != arg1) {
        [self->_serialCodeErrorText release];
        self->_serialCodeErrorText = [arg1 copy];
    }
}

- (void (^)(BOOL, NSString *, NSString *))completionHandler {
    return self->_completionHandler;
}

- (void)setCompletionHandler:(id)arg1 {
    if (self->_completionHandler != arg1) {
        [self->_completionHandler release];
        self->_completionHandler = [arg1 copy];
    }
}

- (void)dealloc {
    [self->session release];
    [self->downloadTask release];
    [self->authorization release];
    [self->localPrefsFolder release];
    [self->globalPrefsFolder release];
    [self->_login release];
    [self->_login2 release];
    [self->_loginErrorText release];
    [self->_password release];
    [self->_password2 release];
    [self->_passwordErrorText release];
    [self->_globalRegModeCaption release];
    [self->_accountName release];
    [self->_serialCode release];
    [self->_serialCodeErrorText release];
    [self->_completionHandler release];
    [super dealloc];
}

@end
