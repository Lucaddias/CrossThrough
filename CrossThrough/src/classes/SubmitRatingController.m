// SubmitRatingController.m — CrossThrough
#import "SubmitRatingController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation SubmitRatingController

+ (id)keyPathsForValuesAffectingRatingDescription {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"rating"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingCharactersLeft {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"notes"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingCanSubmit {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"ratingUtils.login_required"];
     *   return r0;
     */
    return nil;
}

- (id)initWithBottle:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)initWithBottle:(id)arg1 isNag:(BOOL)arg2 isDeleting:(BOOL)arg3 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)windowDidLoad {
    return;
}

- (id)ratingDescription {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r8 = sign_extend_64(*(int32_t *)ivar_offset(_rating));
     *   r8 = *(self + r8);
     *   if (r8 <= 0x5) {
     *   index_0 = r8;
     *   switch (index_0) {
     *   case 0:
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r2 = @"Unrated";
     *   break;
     *   case 1:
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r2 = @"Will Not Install";
     *   break;
     *   case 2:
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   ... (30 more lines)
     */
    return nil;
}

- (NSInteger)charactersLeft {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self notesFormatter];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r19 = [r0 maxLength] - [self->_notes length];
     *   [r20 release];
     *   r0 = r19;
     *   return r0;
     */
    return 0;
}

- (BOOL)canSubmit {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   if (*(r0 + sign_extend_64(*(int32_t *)ivar_offset(_rating))) >= 0x1) {
     *   r19 = r0;
     *   r0 = r0->_ratingUtils;
     *   r0 = [r0 valueForKey:@"login_required"];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 boolValue];
     *   [r20 release];
     *   if (r21 != 0x0) {
     *   r21 = sign_extend_64(*(int32_t *)ivar_offset(_email));
     *   r0 = *(r19 + r21);
     *   r0 = [r0 length];
     *   if (r0 != 0x0) {
     *   r0 = *(r19 + r21);
     *   r0 = [r0 rangeOfString:@"@"];
     *   ... (27 more lines)
     */
    return NO;
}

- (BOOL)askAgain {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self deleting];
     *   r0 = r0 ^ 0x1;
     *   return r0;
     */
    return NO;
}

- (void)submit:(id)arg1 {
    return;
}

- (void)never:(id)arg1 {
    return;
}

- (void)cancel:(id)arg1 {
    return;
}

- (void)close {
    return;
}

- (void)handleLogin:(BOOL)arg1 {
    return;
}

- (void)doSubmit {
    return;
}

- (void)doRegister {
    return;
}

- (void)windowDidBecomeKey:(id)arg1 {
    return;
}

- (void)controlTextDidChange:(id)arg1 {
    return;
}

- (id)stackView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_stackView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setStackView:(id)arg1 {
    return;
}

- (id)ratingIndicator {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_ratingIndicator);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setRatingIndicator:(id)arg1 {
    return;
}

- (id)notesField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_notesField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNotesField:(id)arg1 {
    return;
}

- (id)submitButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_submitButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setSubmitButton:(id)arg1 {
    return;
}

- (id)notesFormatter {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_notesFormatter);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNotesFormatter:(id)arg1 {
    return;
}

- (id)forgotPasswordLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_forgotPasswordLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setForgotPasswordLabel:(id)arg1 {
    return;
}

- (id)emailField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_emailField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setEmailField:(id)arg1 {
    return;
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    self->_bottle = arg1;
}

- (id)dialogTitle {
    return self->_dialogTitle;
}

- (void)setDialogTitle:(id)arg1 {
    return;
}

- (id)message {
    return self->_message;
}

- (void)setMessage:(id)arg1 {
    return;
}

- (NSInteger)rating {
    return self->_rating;
}

- (void)setRating:(NSInteger)arg1 {
    return;
}

- (id)notes {
    return self->_notes;
}

- (void)setNotes:(id)arg1 {
    return;
}

- (void)setCharactersLeft:(NSInteger)arg1 {
    return;
}

- (id)email {
    return self->_email;
}

- (void)setEmail:(id)arg1 {
    return;
}

- (id)password {
    return self->_password;
}

- (void)setPassword:(id)arg1 {
    return;
}

- (BOOL)loggingIn {
    return self->_loggingIn;
}

- (void)setLoggingIn:(BOOL)arg1 {
    self->_loggingIn = arg1;
}

- (BOOL)failed {
    return self->_failed;
}

- (void)setFailed:(BOOL)arg1 {
    self->_failed = arg1;
}

- (BOOL)nag {
    return self->_nag;
}

- (void)setNag:(BOOL)arg1 {
    self->_nag = arg1;
}

- (BOOL)deleting {
    return self->_deleting;
}

- (void)setDeleting:(BOOL)arg1 {
    self->_deleting = arg1;
}

- (id)ratingUtils {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_ratingUtils)), 0x1);
     *   return r0;
     */
    return nil;
}

- (id)appid {
    return self->_appid;
}

- (void)setAppid:(id)arg1 {
    return;
}

@end
