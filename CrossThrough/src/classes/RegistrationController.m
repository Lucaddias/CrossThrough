// RegistrationController.m — CrossThrough
#import "RegistrationController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation RegistrationController

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (BOOL)authIfNeeded {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [NSFileManager defaultManager];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (([r0 isWritableFileAtPath:r20->globalPrefsFolder] & 0x1) == 0x0) {
     *   if ([r20 regMode] == 0x1) {
     *   r21 = sign_extend_64(*(int32_t *)ivar_offset(authorization));
     *   r0 = *(r20 + r21);
     *   if (r0 == 0x0) {
     *   r0 = [[SFAuthorization alloc] init];
     *   r8 = *(r20 + r21);
     *   *(r20 + r21) = r0;
     *   [r8 release];
     *   r0 = *(r20 + r21);
     *   if (r0 != 0x0 && ([r0 obtainWithRight:"system.privilege.admin" flags:0x13 error:0x0] & 0x1) != 0x0) {
     *   r20 = 0x1;
     *   }
     *   else {
     *   ... (30 more lines)
     */
    return NO;
}

- (id)formatSerialCode:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = [[arg2 stringByReplacingOccurrencesOfString:@"-" withString:@""] retain];
     *   r21 = [[NSString stringWithString:r20] retain];
     *   [r20 release];
     *   r20 = [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
     *   r19 = [[r21 stringByTrimmingCharactersInSet:r20] retain];
     *   [r21 release];
     *   [r20 release];
     *   r0 = [r19 length];
     *   if (r0 >= 0x4) {
     *   r20 = r0;
     *   r21 = [[r19 stringByReplacingCharactersInRange:0x3 withString:0x0] retain];
     *   [r19 release];
     *   if (r20 >= 0x8) {
     *   r19 = [[r21 stringByReplacingCharactersInRange:0x8 withString:0x0] retain];
     *   [r21 release];
     *   if (r20 >= 0xc) {
     *   r20 = [[r19 stringByReplacingCharactersInRange:0xd withString:0x0] retain];
     *   [r19 release];
     *   ... (9 more lines)
     */
    return nil;
}

- (void)beginRegisterAppWithSerialCodeWithCompletionHandler:(id)arg1 {
    return;
}

- (void)beginRegisterAppWithCompletionHandler:(id)arg1 {
    return;
}

- (void)handleRegistrationData:(id)arg1 {
    return;
}

- (void)handleSerialCodeAccountCreationData:(id)arg1 {
    return;
}

- (void)downloadTaskCompleted:(id)arg1 response:(id)arg2 error:(id)arg3 successHandler:(id)arg4 errorMessageText:(id)arg5 {
    return;
}

- (BOOL)moveFile:(id)arg1 dest:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r28;
     *   decomp_var_28 = r27;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r31 = r31 + 0xffffffffffffffc0 - 0x430;
     *   r21 = self;
     *   var_38 = **___stack_chk_guard;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   r22 = sign_extend_64(*(int32_t *)ivar_offset(authorization));
     *   if (*(r21 + r22) != 0x0) {
     *   var_450 = [objc_retainAutorelease(r19) fileSystemRepresentation];
     *   [objc_retainAutorelease(r20) fileSystemRepresentation];
     *   var_458 = 0x0;
     *   r0 = *(r21 + r22);
     *   r0 = [r0 authorizationRef];
     *   r0 = AuthorizationExecuteWithPrivileges(r0, "/bin/mv", 0x0, &var_450, &var_458);
     *   if (r0 == 0x0) {
     *   r21 = 0x1;
     *   }
     *   if (r0 == 0x0) {
     *   ... (22 more lines)
     */
    return NO;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 movingItemAtURL:(id)arg3 toURL:(id)arg4 {
    /*
     * Decompiled from CrossOver 26.3:
     *   NSLog(@"Error moving %@ to %@: %@", _cmd, arg2, r3);
     *   return 0x0;
     */
    return NO;
}

- (void)cancel {
    return;
}

- (BOOL)validLogin {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self login];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 release];
     *   if (r20 != 0x0) {
     *   r0 = [r19 login];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 rangeOfString:@"@"];
     *   [r20 release];
     *   if (r21 == 0x7fffffffffffffff) {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 localizedStringForKey:@"Please enter a valid email address.\n(e.g. myusername@myemailprovider.com)" value:@"" table:0x0] retain];
     *   [r19 setLoginErrorText:r21];
     *   [r21 release];
     *   ... (29 more lines)
     */
    return NO;
}

- (BOOL)validPassword {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self password];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 release];
     *   if (r20 != 0x0) {
     *   r20 = [[r19 password] retain];
     *   r21 = [[r19 password2] retain];
     *   r22 = [r20 isEqualToString:r21];
     *   [r21 release];
     *   [r20 release];
     *   if ((r22 & 0x1) != 0x0) {
     *   [r19 setPasswordErrorText:@""];
     *   r0 = 0x1;
     *   }
     *   else {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   ... (12 more lines)
     */
    return NO;
}

- (BOOL)validSerialCode {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self serialCode];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 release];
     *   if (r20 != 0x0) {
     *   r0 = [r19 serialCode];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 stringByReplacingOccurrencesOfString:@"-" withString:@""] retain];
     *   [r20 release];
     *   r22 = [[NSCharacterSet whitespaceAndNewlineCharacterSet] retain];
     *   r20 = [[r21 stringByTrimmingCharactersInSet:r22] retain];
     *   [r21 release];
     *   [r22 release];
     *   r0 = [r20 length];
     *   ... (28 more lines)
     */
    return NO;
}

- (id)login {
    return self->_login;
}

- (void)setLogin:(id)arg1 {
    return;
}

- (id)login2 {
    return self->_login2;
}

- (void)setLogin2:(id)arg1 {
    return;
}

- (id)loginErrorText {
    return self->_loginErrorText;
}

- (void)setLoginErrorText:(id)arg1 {
    return;
}

- (id)password {
    return self->_password;
}

- (void)setPassword:(id)arg1 {
    return;
}

- (id)password2 {
    return self->_password2;
}

- (void)setPassword2:(id)arg1 {
    return;
}

- (id)passwordErrorText {
    return self->_passwordErrorText;
}

- (void)setPasswordErrorText:(id)arg1 {
    return;
}

- (NSInteger)registrationWorkInProgress {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->_registrationWorkInProgress;
     *   return r0;
     */
    return 0;
}

- (void)setRegistrationWorkInProgress:(NSInteger)arg1 {
    return;
}

- (NSInteger)regMode {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->_regMode;
     *   return r0;
     */
    return 0;
}

- (void)setRegMode:(NSInteger)arg1 {
    return;
}

- (id)globalRegModeCaption {
    return self->_globalRegModeCaption;
}

- (void)setGlobalRegModeCaption:(id)arg1 {
    return;
}

- (id)accountName {
    return self->_accountName;
}

- (void)setAccountName:(id)arg1 {
    return;
}

- (id)serialCode {
    return self->_serialCode;
}

- (void)setSerialCode:(id)arg1 {
    return;
}

- (id)serialCodeErrorText {
    return self->_serialCodeErrorText;
}

- (void)setSerialCodeErrorText:(id)arg1 {
    return;
}

- (void (^)(void))completionHandler {
    return self->_completionHandler;
}

- (void)setCompletionHandler:(id)arg1 {
    return;
}

@end
