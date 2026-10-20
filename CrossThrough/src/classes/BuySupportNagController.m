// BuySupportNagController.m — CrossThrough
#import "BuySupportNagController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

// Controllers that keep themselves alive until their window closes.
static NSMutableArray *_selfOwnedControllers = nil;

// Pushes a collapsed element out of view by shrinking its spacer.
static const CGFloat kCollapsedSpacerOffset = -10000.0;

@implementation BuySupportNagController

- (id)initWithAppcastItem:(id)arg1 {
    NSString *nibPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"BuySupportNag" ofType:@"nib"];
    if (!nibPath) {
        NSString *sparklePath = [[[NSBundle mainBundle] sharedFrameworksPath] stringByAppendingPathComponent:@"Sparkle.framework"];
        nibPath = [[NSBundle bundleWithPath:sparklePath] pathForResource:@"BuySupportNag" ofType:@"nib"];
    }
    self = [super initWithWindowNibPath:nibPath owner:self];
    if (self) {
        self->_updateItem = [arg1 retain];
        [self setShouldCascadeWindows:NO];
    }
    return self;
}

- (void)setOwnsSelf:(BOOL)arg1 {
    if (!_selfOwnedControllers) {
        _selfOwnedControllers = [[NSMutableArray alloc] init];
    }
    if (self->ownsSelf && !arg1) {
        [_selfOwnedControllers removeObject:self];
    } else if (!self->ownsSelf && arg1) {
        [_selfOwnedControllers addObject:self];
    }
    self->ownsSelf = arg1;
}

- (id)bundleVersion {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    return [version length] != 0 ? version : @"";
}

- (id)bundleDisplayVersion {
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return version ? version : [self bundleVersion];
}

- (id)bundleName {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *name = [bundle objectForInfoDictionaryKey:@"SUBundleName"];
    if ([name length] != 0) {
        return name;
    }
    name = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if ([name length] != 0) {
        return name;
    }
    name = [bundle objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    return [name length] != 0 ? name : @"";
}

- (id)descriptionText {
    NSString *updateVersion = [[self updateItem] displayVersionString];
    NSString *currentVersion = [self bundleDisplayVersion];
    // Same marketing version: disambiguate with the build numbers.
    if ([updateVersion isEqualToString:currentVersion]) {
        updateVersion = [updateVersion stringByAppendingFormat:@" (%@)", [[self updateItem] versionString]];
        currentVersion = [currentVersion stringByAppendingFormat:@" (%@)", [self bundleVersion]];
    }
    NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"%1$@ %2$@ is now available – you have %3$@." value:@"" table:nil];
    return [NSString stringWithFormat:format, [self bundleName], updateVersion, currentVersion];
}

- (void)buyNow:(id)arg1 {
    NSString *renewalURL = [[NSBundle mainBundle] localizedStringForKey:@"https://www.codeweavers.com/store/renewal/" value:@"" table:@"Vendor"];
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:renewalURL]];
}

- (void)windowDidLoad {
    // The label's text has a "%@" for the refresh button's title.
    NSMutableAttributedString *labelText = [[[[self notEntitledLabel] attributedStringValue] mutableCopy] autorelease];
    NSString *text = [NSString stringWithFormat:[labelText string], [[self refreshRegistrationButton] title]];
    if (![self registrationRefreshEnough]) {
        NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"If your support has expired, click '%@' to receive this and future upgrades." value:@"" table:nil];
        text = [[text stringByAppendingString:@" "] stringByAppendingFormat:format, [[self buySupportExtensionButton] title]];
    }
    [labelText replaceCharactersInRange:NSMakeRange(0, [labelText length]) withString:text];
    [[self notEntitledLabel] setAttributedStringValue:labelText];

    if ([self registrationRefreshEnough]) {
        // Refreshing the license is enough: hide "Buy Support Extension" and
        // shrink the window by the space it took.
        [[self window] layoutIfNeeded];
        NSButton *buyButton = [self buySupportExtensionButton];
        NSButton *refreshButton = [self refreshRegistrationButton];
        NSRect buyRect = [buyButton alignmentRectForFrame:[buyButton frame]];
        NSRect refreshRect = [refreshButton alignmentRectForFrame:[refreshButton frame]];
        CGFloat adjustment = (buyRect.origin.x + buyRect.size.width) - (refreshRect.origin.x + refreshRect.size.width);
        if (adjustment < 0.0) {
            adjustment = refreshRect.origin.x - buyRect.origin.x;
        }
        self->_widthAdjustment = adjustment;
        NSLayoutConstraint *spacer = [self refreshRegistrationToBuySupportSpacer];
        [spacer setConstant:[spacer constant] + kCollapsedSpacerOffset];
        NSRect frame = [[self window] frame];
        frame.size.width -= self->_widthAdjustment;
        [[self window] setFrame:frame display:YES];
        [[self window] setDefaultButtonCell:[[self refreshRegistrationButton] cell]];
    }
    if (![self showsReleaseNotes]) {
        NSLayoutConstraint *spacer = [self notEntitledLabelToReleaseNotesBoxSpacer];
        [spacer setConstant:[spacer constant] + kCollapsedSpacerOffset];
        [[self notEntitledLabelToDescriptionLabelSpacer] setPriority:700.0f];
    }
    if ([NSApp activationPolicy] != NSApplicationActivationPolicyRegular) {
        [[self window] setLevel:NSFloatingWindowLevel];
    }
    [[self window] center];
    if ([self showsReleaseNotes]) {
        [self displayReleaseNotes];
    }
}

- (BOOL)windowShouldClose:(id)arg1 {
    [self endWithSelection];
    return YES;
}

- (void)windowWillClose:(id)arg1 {
    if ([self registrationRefreshEnough]) {
        // Restore the nib width so the saved frame stays consistent.
        [[self window] orderOut:self];
        NSRect frame = [[self window] frame];
        frame.size.width += self->_widthAdjustment;
        [[self window] setFrame:frame display:NO];
    }
    if (self->ownsSelf && [self isWindowLoaded] && [arg1 object] == [self window]) {
        [_selfOwnedControllers removeObject:[[self window] windowController]];
    }
}

- (void)remindMeLater:(id)arg1 {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SUSkippedVersion"];
    [self endWithSelection];
}

- (void)refreshRegistration:(id)arg1 {
    DemoRegisterController *registerController = [[DemoRegisterController alloc] init];
    [registerController setRefreshLicenseMode:YES];
    [registerController showWindow:self];
    [self remindMeLater:nil];
}

- (void)skipThisVersion:(id)arg1 {
    [[NSUserDefaults standardUserDefaults] setObject:[[self updateItem] versionString] forKey:@"SUSkippedVersion"];
    [self endWithSelection];
}

- (id)applicationIcon {
    return [NSApp applicationIconImage];
}

- (BOOL)showsReleaseNotes {
    NSNumber *shows = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SUShowReleaseNotes"];
    if (shows) {
        return [shows boolValue];
    }
    NSString *description = [[self updateItem] itemDescription];
    if (description && [[description stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] != 0) {
        return YES;
    }
    return [[self updateItem] releaseNotesURL] != nil;
}

- (id)titleText {
    NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"A new version of %@ is available!" value:@"" table:nil];
    return [NSString stringWithFormat:format, [self bundleName]];
}

- (void)displayReleaseNotes {
    WebView *webView = [self releaseNotesView];
    [webView setPreferencesIdentifier:@"org.sparkle-project.Sparkle"];
    [[webView preferences] setStandardFontFamily:[[NSFont systemFontOfSize:8.0] familyName]];
    [[webView preferences] setDefaultFontSize:(int)[NSFont systemFontSizeForControlSize:NSControlSizeSmall]];
    [webView setFrameLoadDelegate:self];
    [webView setPolicyDelegate:self];

    // A spinner centered over the notes until the page finishes loading.
    NSProgressIndicator *spinner = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(0.0, 0.0, 32.0, 32.0)];
    [self setReleaseNotesSpinner:spinner];
    [spinner release];
    [spinner setStyle:NSProgressIndicatorStyleSpinning];
    [[self releaseNotesSpinner] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self releaseNotesSpinner] startAnimation:self];
    NSView *container = [webView superview];
    [container addSubview:[self releaseNotesSpinner]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:[self releaseNotesSpinner] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:32.0]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:[self releaseNotesSpinner] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[self releaseNotesSpinner] attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:[self releaseNotesSpinner] attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [container addConstraint:[NSLayoutConstraint constraintWithItem:[self releaseNotesSpinner] attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];

    self->_webViewFinishedLoading = NO;
    NSURL *releaseNotesURL = [[self updateItem] releaseNotesURL];
    if (releaseNotesURL) {
        if ([releaseNotesURL isFileURL]) {
            [[webView mainFrame] loadHTMLString:@"Release notes with file:// URLs are not supported for security reasons&mdash;Javascript would be able to read files on your file system." baseURL:nil];
        } else {
            [[webView mainFrame] loadRequest:[NSURLRequest requestWithURL:releaseNotesURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30.0]];
        }
    } else {
        [[webView mainFrame] loadHTMLString:[[self updateItem] itemDescription] baseURL:nil];
    }
}

- (void)endWithSelection {
    [[self releaseNotesView] stopLoading:self];
    [[self releaseNotesView] setFrameLoadDelegate:nil];
    [[self releaseNotesView] setPolicyDelegate:nil];
    [[self releaseNotesView] removeFromSuperview];
    [self close];
}

- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
    if (![arg2 parentFrame]) {
        self->_webViewFinishedLoading = YES;
        [[self releaseNotesSpinner] setHidden:YES];
        [(WebView *)arg1 display];
    }
}

- (void)webView:(id)arg1 decidePolicyForNavigationAction:(id)arg2 request:(id)arg3 frame:(id)arg4 decisionListener:(id)arg5 {
    // Once the notes are shown, links open in the browser.
    if (self->_webViewFinishedLoading) {
        [[NSWorkspace sharedWorkspace] openURL:[arg3 URL]];
        [arg5 ignore];
    } else {
        [arg5 use];
    }
}

- (id)webView:(id)arg1 contextMenuItemsForElement:(id)arg2 defaultMenuItems:(id)arg3 {
    NSMutableArray *items = [[arg3 mutableCopy] autorelease];
    for (NSMenuItem *item in arg3) {
        switch ([item tag]) {
            case WebMenuItemTagOpenLinkInNewWindow:
            case WebMenuItemTagDownloadLinkToDisk:
            case WebMenuItemTagOpenImageInNewWindow:
            case WebMenuItemTagDownloadImageToDisk:
            case WebMenuItemTagOpenFrameInNewWindow:
            case WebMenuItemTagGoBack:
            case WebMenuItemTagGoForward:
            case WebMenuItemTagStop:
            case WebMenuItemTagReload:
                [items removeObjectIdenticalTo:item];
                break;
            default:
                break;
        }
    }
    return items;
}

- (id)notEntitledLabel {
    return [objc_loadWeakRetained((id *)&self->_notEntitledLabel) autorelease];
}

- (void)setNotEntitledLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_notEntitledLabel, arg1);
}

- (id)refreshRegistrationButton {
    return [objc_loadWeakRetained((id *)&self->_refreshRegistrationButton) autorelease];
}

- (void)setRefreshRegistrationButton:(id)arg1 {
    objc_storeWeak((id *)&self->_refreshRegistrationButton, arg1);
}

- (id)buySupportExtensionButton {
    return [objc_loadWeakRetained((id *)&self->_buySupportExtensionButton) autorelease];
}

- (void)setBuySupportExtensionButton:(id)arg1 {
    objc_storeWeak((id *)&self->_buySupportExtensionButton, arg1);
}

- (id)releaseNotesView {
    return [objc_loadWeakRetained((id *)&self->_releaseNotesView) autorelease];
}

- (void)setReleaseNotesView:(id)arg1 {
    objc_storeWeak((id *)&self->_releaseNotesView, arg1);
}

- (BOOL)registrationRefreshEnough {
    return self->_registrationRefreshEnough;
}

- (void)setRegistrationRefreshEnough:(BOOL)arg1 {
    self->_registrationRefreshEnough = arg1;
}

- (id)refreshRegistrationToBuySupportSpacer {
    return [objc_loadWeakRetained((id *)&self->_refreshRegistrationToBuySupportSpacer) autorelease];
}

- (void)setRefreshRegistrationToBuySupportSpacer:(id)arg1 {
    objc_storeWeak((id *)&self->_refreshRegistrationToBuySupportSpacer, arg1);
}

- (id)notEntitledLabelToReleaseNotesBoxSpacer {
    return [objc_loadWeakRetained((id *)&self->_notEntitledLabelToReleaseNotesBoxSpacer) autorelease];
}

- (void)setNotEntitledLabelToReleaseNotesBoxSpacer:(id)arg1 {
    objc_storeWeak((id *)&self->_notEntitledLabelToReleaseNotesBoxSpacer, arg1);
}

- (id)notEntitledLabelToDescriptionLabelSpacer {
    return [objc_loadWeakRetained((id *)&self->_notEntitledLabelToDescriptionLabelSpacer) autorelease];
}

- (void)setNotEntitledLabelToDescriptionLabelSpacer:(id)arg1 {
    objc_storeWeak((id *)&self->_notEntitledLabelToDescriptionLabelSpacer, arg1);
}

- (id)updateItem {
    return self->_updateItem;
}

- (void)setUpdateItem:(id)arg1 {
    if (self->_updateItem != arg1) {
        [self->_updateItem release];
        self->_updateItem = [arg1 retain];
    }
}

- (id)releaseNotesSpinner {
    return self->_releaseNotesSpinner;
}

- (void)setReleaseNotesSpinner:(id)arg1 {
    if (self->_releaseNotesSpinner != arg1) {
        [self->_releaseNotesSpinner release];
        self->_releaseNotesSpinner = [arg1 retain];
    }
}

- (void)dealloc {
    [self->_updateItem release];
    [self->_releaseNotesSpinner release];
    objc_destroyWeak((id *)&self->_notEntitledLabel);
    objc_destroyWeak((id *)&self->_refreshRegistrationButton);
    objc_destroyWeak((id *)&self->_buySupportExtensionButton);
    objc_destroyWeak((id *)&self->_releaseNotesView);
    objc_destroyWeak((id *)&self->_refreshRegistrationToBuySupportSpacer);
    objc_destroyWeak((id *)&self->_notEntitledLabelToReleaseNotesBoxSpacer);
    objc_destroyWeak((id *)&self->_notEntitledLabelToDescriptionLabelSpacer);
    [super dealloc];
}

@end
