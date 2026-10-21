// SubmitRatingController.m — CrossThrough
#import "SubmitRatingController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation SubmitRatingController

+ (id)keyPathsForValuesAffectingRatingDescription {
    return [NSSet setWithObject:@"rating"];
}

+ (id)keyPathsForValuesAffectingCharactersLeft {
    return [NSSet setWithObject:@"notes"];
}

+ (id)keyPathsForValuesAffectingCanSubmit {
    return [NSSet setWithObjects:@"rating", @"ratingUtils.login_required", @"email", @"password", nil];
}

- (id)initWithBottle:(id)arg1 {
    return [self initWithBottle:arg1 isNag:NO isDeleting:NO];
}

- (id)initWithBottle:(id)arg1 isNag:(BOOL)arg2 isDeleting:(BOOL)arg3 {
    self = [super initWithWindowNibName:@"SubmitRating"];
    if (self) {
        // CrossThrough: o envio de avaliações fala com www.codeweavers.com
        // (ratingutils, webutils: fetchRating, setRating:Notes:, createToken:password:).
        // O recurso foi removido; nunca abrimos o painel de avaliação.
        [self release];
        return nil;
    }
    if (self) {
        if (!arg1 || ![arg1 appid]) {
            [self release];
            return nil;
        }

        if (arg2) {
            BOOL ask = [[NSUserDefaults standardUserDefaults] boolForKey:@"AskForRatings"];
            if (!ask) {
                [self release];
                return nil;
            }
        }

        [self setBottle:arg1];
        [self setAppid:[arg1 appid]];
        [self setNag:arg2];
        [self setDeleting:arg3];

        id profilesClass = (id)[CXSetupLib c4ProfilesClass];
        id profilesSet = [profilesClass respondsToSelector:@selector(profilesSet)] ? [profilesClass profilesSet] : nil;
        NSDictionary *contentsDict = [profilesSet respondsToSelector:@selector(contentsDict)] ? [(id)profilesSet contentsDict] : profilesSet;
        NSString *c4key = [NSString stringWithFormat:@"com.codeweavers.c4.%@", self->_appid];
        id profile = [contentsDict objectForKey:c4key];
        BOOL isComponent = [[profile valueForKey:@"is_component"] boolValue];

        if (isComponent) {
            if (!arg3) {
                [arg1 disableRatingNag];
            }
            [self release];
            return nil;
        }

        if (!arg3) {
            if ([arg1 respondsToSelector:@selector(isShouldNagForRatings)] && ![arg1 isShouldNagForRatings]) {
                [self release];
                return nil;
            }
        }

        Class ratingUtilsClass = [CXSetupLib ratingUtilsClass];
        if (ratingUtilsClass) {
            self->_ratingUtils = [[ratingUtilsClass alloc] initWithAppID:self->_appid];
            NSNumber *fetchResult = [self->_ratingUtils fetchRating];
            if (![fetchResult boolValue] && [[self->_ratingUtils valueForKey:@"connection_failed"] boolValue]) {
                [self release];
                return nil;
            }

            if (arg2) {
                NSInteger existingRating = [[self->_ratingUtils valueForKey:@"rating"] integerValue];
                if (existingRating != 0) {
                    if (!arg3) {
                        [arg1 disableRatingNag];
                    }
                    [self release];
                    return nil;
                }
            }
        }
    }
    return self;
}

- (void)dealloc {
    [self->_appid release];
    self->_appid = nil;
    [self->_password release];
    self->_password = nil;
    [self->_email release];
    self->_email = nil;
    [self->_notes release];
    self->_notes = nil;
    [self->_message release];
    self->_message = nil;
    [self->_dialogTitle release];
    self->_dialogTitle = nil;
    [self->_bottle release];
    self->_bottle = nil;
    [self->_ratingUtils release];
    self->_ratingUtils = nil;
    [super dealloc];
}

- (void)windowDidLoad {
    [super windowDidLoad];

    NSStackView *sv = [self stackView];
    if (sv) {
        NSView *rInd = [self ratingIndicator];
        if (rInd) [sv setCustomSpacing:8.0 afterView:rInd];
        NSView *nField = [self notesField];
        if (nField) [sv setCustomSpacing:2.0 afterView:nField];
    }

    id profilesClass = (id)[CXSetupLib c4ProfilesClass];
    id profilesSet = [profilesClass respondsToSelector:@selector(profilesSet)] ? [profilesClass profilesSet] : nil;
    NSDictionary *contentsDict = [profilesSet respondsToSelector:@selector(contentsDict)] ? [(id)profilesSet contentsDict] : profilesSet;
    NSString *c4key = [NSString stringWithFormat:@"com.codeweavers.c4.%@", self->_appid];
    id profile = [contentsDict objectForKey:c4key];
    NSString *appName = [profile valueForKey:@"name"] ?: self->_appid;

    NSString *titleFmt = [[NSBundle mainBundle] localizedStringForKey:@"Submit a Rating for '%@'" value:@"" table:nil];
    [self setDialogTitle:[NSString stringWithFormat:titleFmt, appName]];

    NSString *crossover = [[NSRunningApplication currentApplication] localizedName] ?: @"CrossOver";
    NSString *msgFmt = [[NSBundle mainBundle] localizedStringForKey:@"Please leave a rating in order to help us better target our improvements to %@ and to inform other users on how well '%@' works with %@." value:@"" table:nil];
    [self setMessage:[NSString stringWithFormat:msgFmt, crossover, appName, crossover]];

    if (self->_ratingUtils) {
        [self setRating:[[self->_ratingUtils valueForKey:@"rating"] integerValue]];
        [self setNotes:[self->_ratingUtils valueForKey:@"notes"]];

        if ([[self->_ratingUtils valueForKey:@"login_required"] boolValue]) {
            NSString *loginTitle = [[NSBundle mainBundle] localizedStringForKey:@"Log In and Submit Rating…" value:@"" table:nil];
            [[self submitButton] setTitle:loginTitle];
        }
    }

    NSTextField *pwLabel = [self forgotPasswordLabel];
    if (pwLabel) {
        NSURL *lostPwUrl = [NSURL URLWithString:@"https://www.codeweavers.com/login/lostpassword/"];
        NSMutableAttributedString *mas = [[pwLabel attributedStringValue] mutableCopy];
        if (mas && [mas length] > 0) {
            NSRange fullRange = NSMakeRange(0, [mas length]);
            NSDictionary *attrs = @{
                NSForegroundColorAttributeName: [NSColor blueColor],
                NSUnderlineStyleAttributeName: @(1)
            };
            [mas addAttributes:attrs range:fullRange];
            [mas addAttribute:NSLinkAttributeName value:lostPwUrl range:fullRange];
            [pwLabel setAttributedStringValue:mas];
            [mas release];
        }
    }

    NSLevelIndicator *indicator = [self ratingIndicator];
    if (indicator) {
        NSImage *img = [[indicator ratingImage] copy];
        if (img) {
            [indicator setRatingImage:img];
            [img release];
        }
        NSImage *ph = [[indicator ratingPlaceholderImage] copy];
        if (ph) {
            [indicator setRatingPlaceholderImage:ph];
            [ph release];
        }
    }
}

- (id)ratingDescription {
    NSString *key = nil;
    switch (self->_rating) {
        case 0: key = @"Unrated"; break;
        case 1: key = @"Will Not Install"; break;
        case 2: key = @"Installs, Will Not Run"; break;
        case 3: key = @"Limited Functionality"; break;
        case 4: key = @"Runs Well"; break;
        case 5: key = @"Runs Great"; break;
        default: return @"";
    }
    return [[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil];
}

- (NSInteger)charactersLeft {
    NSInteger max = 2000;
    if (self->_notesFormatter && [self->_notesFormatter respondsToSelector:@selector(maxLength)]) {
        max = [self->_notesFormatter maxLength];
    }
    return max - [self->_notes length];
}

- (BOOL)canSubmit {
    if (self->_rating < 1) return NO;
    if (self->_ratingUtils && [[self->_ratingUtils valueForKey:@"login_required"] boolValue]) {
        if ([self->_email length] == 0) return NO;
        NSRange atRange = [self->_email rangeOfString:@"@"];
        if (atRange.location == NSNotFound) return NO;
        NSRange dotRange = [self->_email rangeOfString:@"." options:0 range:NSMakeRange(atRange.location + 1, [self->_email length] - atRange.location - 1)];
        if (dotRange.location == NSNotFound) return NO;
        if ([self->_password length] == 0) return NO;
    }
    return YES;
}

- (BOOL)askAgain {
    return ![self deleting];
}

- (void)submit:(id)arg1 {
    [[self contentViewController] commitEditing];

    if (self->_ratingUtils && [[self->_ratingUtils valueForKey:@"login_required"] boolValue]) {
        [self setFailed:NO];
        [self setLoggingIn:YES];

        __block typeof(self) weakSelf = self;
        NSString *email = [self email];
        NSString *password = [self password];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            id webUtils = (id)[CXSetupLib webUtilsClass];
            BOOL ok = NO;
            if (webUtils && [webUtils respondsToSelector:@selector(createToken:password:)]) {
                ok = [[webUtils createToken:email password:password] boolValue];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf handleLogin:ok];
            });
        });
    } else {
        [self doSubmit];
    }
}

- (void)never:(id)arg1 {
    if (self->_bottle) {
        [self->_bottle disableRatingNag];
    }
    [self close];
}

- (void)cancel:(id)arg1 {
    [self close];
}

- (void)close {
    [[self window] close];
    [[NSApplication sharedApplication] endSheet:[self window]];
}

- (void)handleLogin:(BOOL)arg1 {
    if (arg1) {
        [self doSubmit];
        [self doRegister];
    } else {
        [self setLoggingIn:NO];
        [self setFailed:YES];
        NSTextField *ef = [self emailField];
        if (ef && [ef acceptsFirstResponder]) {
            [[ef window] makeFirstResponder:ef];
        }
        NSBeep();
    }
}

- (void)doSubmit {
    [self setFailed:NO];
    [self setLoggingIn:YES];

    __block typeof(self) weakSelf = self;
    NSInteger ratingVal = self->_rating;
    NSString *notesVal = self->_notes ?: @"";

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        BOOL ok = NO;
        if (weakSelf->_ratingUtils && [weakSelf->_ratingUtils respondsToSelector:@selector(setRating:Notes:)]) {
            ok = [[weakSelf->_ratingUtils setRating:@(ratingVal) Notes:notesVal] boolValue];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            if (!strongSelf) return;

            [strongSelf setLoggingIn:NO];
            if (ok) {
                [strongSelf close];
            } else {
                NSString *subTitle = [[NSBundle mainBundle] localizedStringForKey:@"Submit Rating" value:@"" table:nil];
                [[strongSelf submitButton] setTitle:subTitle];
                [strongSelf setFailed:YES];
                NSBeep();
            }
        });
    });
}

- (void)doRegister {
    if ([[CXApplication sharedApplication] isDemo]) {
        NSString *email = [self email];
        NSString *password = [self password];
        if ([email length] > 0 && [password length] > 0) {
            RegistrationController *rc = [[RegistrationController alloc] init];
            if ([rc respondsToSelector:@selector(setLogin:)]) {
                [rc setLogin:email];
            }
            if ([rc respondsToSelector:@selector(setPassword:)]) {
                [rc setPassword:password];
            }
            if ([rc respondsToSelector:@selector(beginRegisterAppWithCompletionHandler:)]) {
                [rc beginRegisterAppWithCompletionHandler:nil];
            }
            [rc release];
        }
    }
}

- (void)windowDidBecomeKey:(id)arg1 {
    [[self ratingIndicator] setRefusesFirstResponder:NO];
    NSButton *sb = [self submitButton];
    if (sb) {
        [[sb window] setDefaultButtonCell:[sb cell]];
    }
}

- (void)controlTextDidChange:(id)arg1 {
    id obj = [arg1 object];
    NSDictionary *info = [obj infoForBinding:NSValueBinding];
    if (info) {
        id target = [info objectForKey:NSObservedObjectKey];
        NSString *keyPath = [info objectForKey:NSObservedKeyPathKey];
        if (target && keyPath) {
            [target setValue:[obj stringValue] forKeyPath:keyPath];
        }
    }
}

- (id)stackView {
    return objc_loadWeakRetained((id *)&self->_stackView);
}

- (void)setStackView:(id)arg1 {
    objc_storeWeak((id *)&self->_stackView, arg1);
}

- (id)ratingIndicator {
    return objc_loadWeakRetained((id *)&self->_ratingIndicator);
}

- (void)setRatingIndicator:(id)arg1 {
    objc_storeWeak((id *)&self->_ratingIndicator, arg1);
}

- (id)notesField {
    return objc_loadWeakRetained((id *)&self->_notesField);
}

- (void)setNotesField:(id)arg1 {
    objc_storeWeak((id *)&self->_notesField, arg1);
}

- (id)submitButton {
    return objc_loadWeakRetained((id *)&self->_submitButton);
}

- (void)setSubmitButton:(id)arg1 {
    objc_storeWeak((id *)&self->_submitButton, arg1);
}

- (id)notesFormatter {
    return objc_loadWeakRetained((id *)&self->_notesFormatter);
}

- (void)setNotesFormatter:(id)arg1 {
    objc_storeWeak((id *)&self->_notesFormatter, arg1);
}

- (id)forgotPasswordLabel {
    return objc_loadWeakRetained((id *)&self->_forgotPasswordLabel);
}

- (void)setForgotPasswordLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_forgotPasswordLabel, arg1);
}

- (id)emailField {
    return objc_loadWeakRetained((id *)&self->_emailField);
}

- (void)setEmailField:(id)arg1 {
    objc_storeWeak((id *)&self->_emailField, arg1);
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    if (self->_bottle != arg1) {
        [self->_bottle release];
        self->_bottle = [arg1 retain];
    }
}

- (id)dialogTitle {
    return self->_dialogTitle;
}

- (void)setDialogTitle:(id)arg1 {
    if (self->_dialogTitle != arg1) {
        [self->_dialogTitle release];
        self->_dialogTitle = [arg1 copy];
    }
}

- (id)message {
    return self->_message;
}

- (void)setMessage:(id)arg1 {
    if (self->_message != arg1) {
        [self->_message release];
        self->_message = [arg1 copy];
    }
}

- (NSInteger)rating {
    return self->_rating;
}

- (void)setRating:(NSInteger)arg1 {
    self->_rating = arg1;
}

- (id)notes {
    return self->_notes;
}

- (void)setNotes:(id)arg1 {
    if (self->_notes != arg1) {
        [self->_notes release];
        self->_notes = [arg1 copy];
    }
}

- (void)setCharactersLeft:(NSInteger)arg1 {
    self->_charactersLeft = arg1;
}

- (id)email {
    return self->_email;
}

- (void)setEmail:(id)arg1 {
    if (self->_email != arg1) {
        [self->_email release];
        self->_email = [arg1 copy];
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
    return self->_ratingUtils;
}

- (id)appid {
    return self->_appid;
}

- (void)setAppid:(id)arg1 {
    if (self->_appid != arg1) {
        [self->_appid release];
        self->_appid = [arg1 copy];
    }
}

@end
