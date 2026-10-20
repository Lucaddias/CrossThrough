// BuySupportNagController.h — CrossThrough
#ifndef BuySupportNagController_h
#define BuySupportNagController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class BuySupportNagController;

@interface BuySupportNagController : NSWindowController <NSWindowDelegate, NSObject, WebFrameLoadDelegate, WebPolicyDelegate>
{
    BOOL ownsSelf;
    CGFloat _widthAdjustment;
    BOOL _webViewFinishedLoading;
    BOOL _registrationRefreshEnough;
    NSTextField * _notEntitledLabel;
    NSButton * _refreshRegistrationButton;
    NSButton * _buySupportExtensionButton;
    WebView * _releaseNotesView;
    NSLayoutConstraint * _refreshRegistrationToBuySupportSpacer;
    NSLayoutConstraint * _notEntitledLabelToReleaseNotesBoxSpacer;
    NSLayoutConstraint * _notEntitledLabelToDescriptionLabelSpacer;
    SUAppcastItem * _updateItem;
    NSProgressIndicator * _releaseNotesSpinner;
}

// Instance Methods
- (id)initWithAppcastItem:(id)arg1;
- (void)setOwnsSelf:(BOOL)arg1;
- (id)bundleVersion;
- (id)bundleDisplayVersion;
- (id)bundleName;
- (id)descriptionText;
- (void)buyNow:(id)arg1;
- (void)windowDidLoad;
- (BOOL)windowShouldClose:(id)arg1;
- (void)windowWillClose:(id)arg1;
- (void)remindMeLater:(id)arg1;
- (void)refreshRegistration:(id)arg1;
- (void)skipThisVersion:(id)arg1;
- (id)applicationIcon;
- (BOOL)showsReleaseNotes;
- (id)titleText;
- (void)displayReleaseNotes;
- (void)endWithSelection;
- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2;
- (void)webView:(id)arg1 decidePolicyForNavigationAction:(id)arg2 request:(id)arg3 frame:(id)arg4 decisionListener:(id)arg5;
- (id)webView:(id)arg1 contextMenuItemsForElement:(id)arg2 defaultMenuItems:(id)arg3;
- (id)notEntitledLabel;
- (void)setNotEntitledLabel:(id)arg1;
- (id)refreshRegistrationButton;
- (void)setRefreshRegistrationButton:(id)arg1;
- (id)buySupportExtensionButton;
- (void)setBuySupportExtensionButton:(id)arg1;
- (id)releaseNotesView;
- (void)setReleaseNotesView:(id)arg1;
- (BOOL)registrationRefreshEnough;
- (void)setRegistrationRefreshEnough:(BOOL)arg1;
- (id)refreshRegistrationToBuySupportSpacer;
- (void)setRefreshRegistrationToBuySupportSpacer:(id)arg1;
- (id)notEntitledLabelToReleaseNotesBoxSpacer;
- (void)setNotEntitledLabelToReleaseNotesBoxSpacer:(id)arg1;
- (id)notEntitledLabelToDescriptionLabelSpacer;
- (void)setNotEntitledLabelToDescriptionLabelSpacer:(id)arg1;
- (id)updateItem;
- (void)setUpdateItem:(id)arg1;
- (id)releaseNotesSpinner;
- (void)setReleaseNotesSpinner:(id)arg1;

@end

#endif /* BuySupportNagController_h */
