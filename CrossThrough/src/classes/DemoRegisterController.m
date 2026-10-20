// DemoRegisterController.m — CrossThrough
#import "DemoRegisterController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

// In license-refresh mode the "already purchased" blurb is pushed out of
// view by collapsing its spacer.
static const CGFloat kRefreshModeSpacerOffset = 10000.0;

@implementation DemoRegisterController

+ (id)keyPathsForValuesAffectingCanRegister {
    return [NSSet setWithObjects:@"regController.login", @"regController.password", nil];
}

- (id)init {
    self = [super initWithWindowNibName:@"DemoRegister"];
    if (self) {
        self->_regController = [[RegistrationController alloc] init];
    }
    return self;
}

- (void)setRefreshLicenseMode:(BOOL)arg1 {
    if (!self->_refreshLicenseMode && arg1) {
        NSLayoutConstraint *spacer = [self alreadyPurchasedToEmailSpacer];
        [spacer setConstant:[spacer constant] - kRefreshModeSpacerOffset];
    } else if (self->_refreshLicenseMode && !arg1) {
        NSLayoutConstraint *spacer = [self alreadyPurchasedToEmailSpacer];
        [spacer setConstant:[spacer constant] + kRefreshModeSpacerOffset];
    }
    self->_refreshLicenseMode = arg1;
    if (arg1) {
        NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"A new version of %1$@ is now available. Please enter your codeweavers.com account email address and password to update your license file and re-enable automatic updates." value:@"" table:nil];
        [self setExpirationText:[NSString stringWithFormat:format, @"CrossOver"]];
    }
}

- (void)windowDidLoad {
    [super windowDidLoad];
    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: [NSColor blueColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};

    // Replace the "%@" placeholder (or append) with a link to the store.
    NSURL *storeURL = [NSURL URLWithString:@"https://store.codeweavers.com"];
    NSMutableAttributedString *storeText = [[[[self referToStoreTextField] attributedStringValue] mutableCopy] autorelease];
    NSRange placeholder = [[storeText string] rangeOfString:@"%@"];
    if (placeholder.location == NSNotFound) {
        [[storeText mutableString] appendString:@" "];
        placeholder = NSMakeRange([storeText length], 0);
    }
    [storeText replaceCharactersInRange:placeholder withString:[storeURL host]];
    NSRange linkRange = NSMakeRange(placeholder.location, [[storeURL host] length]);
    [storeText addAttributes:linkAttributes range:linkRange];
    [storeText addAttribute:NSLinkAttributeName value:storeURL range:linkRange];
    [[self referToStoreTextField] setAttributedStringValue:storeText];

    NSURL *lostPasswordURL = [NSURL URLWithString:@"https://www.codeweavers.com/login/lostpassword/"];
    NSMutableAttributedString *forgotText = [[[[self forgotPasswordTextField] attributedStringValue] mutableCopy] autorelease];
    NSRange wholeRange = NSMakeRange(0, [forgotText length]);
    [forgotText addAttributes:linkAttributes range:wholeRange];
    [forgotText addAttribute:NSLinkAttributeName value:lostPasswordURL range:wholeRange];
    [[self forgotPasswordTextField] setAttributedStringValue:forgotText];

    if (self->_refreshLicenseMode) {
        NSLayoutConstraint *spacer = [self alreadyPurchasedToEmailSpacer];
        [spacer setConstant:[spacer constant] - kRefreshModeSpacerOffset];
    }
}

- (BOOL)canRegister {
    return [[self regController] login] != nil && [[self regController] password] != nil;
}

- (void)registerapp:(id)arg1 {
    [[self regController] beginRegisterAppWithCompletionHandler:^(BOOL success, NSString *title, NSString *message) {
        if (!title) {
            if (success) {
                [self exitSuccess];
            }
            return;
        }
        if (success && [self refreshLicenseMode]) {
            NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            NSString *expiration = [formatter stringFromDate:[(CXApplication *)[NSApplication sharedApplication] licenseExpirationDate]];
            NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"Your license has been updated. Automatic product updates will now be available through %@." value:@"" table:nil];
            message = [NSString stringWithFormat:format, expiration];
        }
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:title];
        [alert setInformativeText:message];
        [alert beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse returnCode) {
            if (success) {
                [self exitSuccess];
            }
        }];
    }];
}

- (void)openSerialCodeWindow:(id)arg1 {
    if ([[self window] isSheet]) {
        // Let whoever presented us switch to the activation-code sheet.
        [[NSApplication sharedApplication] endSheet:[self window] returnCode:2];
        return;
    }
    SerialCodeRegisterController *serialController = [[SerialCodeRegisterController alloc] init];
    [[self window] beginSheet:[serialController window] completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == 1) {
            [[self window] close];
        }
        [serialController release];
    }];
}

- (void)cancel:(id)arg1 {
    [[self regController] cancel];
    if ([[self window] isSheet]) {
        [[NSApplication sharedApplication] endSheet:[self window] returnCode:0];
    } else {
        [[self window] close];
    }
}

- (void)exitSuccess {
    [[self window] close];
    [[NSApplication sharedApplication] endSheet:[self window] returnCode:1];
    if ([self refreshLicenseMode]) {
        [[CXUpdater sharedUpdater] checkForUpdatesInBackground];
    }
}

- (void)controlTextDidChange:(id)arg1 {
    // Push edits through the value binding as the user types so canRegister
    // updates immediately.
    NSTextField *field = [arg1 object];
    NSDictionary *binding = [field infoForBinding:NSValueBinding];
    [[binding valueForKey:NSObservedObjectKey] setValue:[field stringValue] forKeyPath:[binding valueForKey:NSObservedKeyPathKey]];
}

- (id)regController {
    return self->_regController;
}

- (BOOL)refreshLicenseMode {
    return self->_refreshLicenseMode;
}

- (id)alreadyPurchasedToEmailSpacer {
    return [objc_loadWeakRetained((id *)&self->_alreadyPurchasedToEmailSpacer) autorelease];
}

- (void)setAlreadyPurchasedToEmailSpacer:(id)arg1 {
    objc_storeWeak((id *)&self->_alreadyPurchasedToEmailSpacer, arg1);
}

- (id)referToStoreTextField {
    return [objc_loadWeakRetained((id *)&self->_referToStoreTextField) autorelease];
}

- (void)setReferToStoreTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_referToStoreTextField, arg1);
}

- (id)forgotPasswordTextField {
    return [objc_loadWeakRetained((id *)&self->_forgotPasswordTextField) autorelease];
}

- (void)setForgotPasswordTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_forgotPasswordTextField, arg1);
}

- (void)dealloc {
    [self->_regController release];
    objc_destroyWeak((id *)&self->_alreadyPurchasedToEmailSpacer);
    objc_destroyWeak((id *)&self->_referToStoreTextField);
    objc_destroyWeak((id *)&self->_forgotPasswordTextField);
    [super dealloc];
}

@end
