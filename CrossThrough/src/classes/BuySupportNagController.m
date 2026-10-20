// BuySupportNagController.m — CrossThrough
#import "BuySupportNagController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BuySupportNagController

- (id)initWithAppcastItem:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)setOwnsSelf:(BOOL)arg1 {
    return;
}

- (id)bundleVersion {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r19 = [[r0 objectForInfoDictionaryKey:**_kCFBundleVersionKey] retain];
     *   [r20 release];
     *   r20 = @"";
     *   if (r19 != 0x0) {
     *   if ([r19 length] != 0x0) {
     *   r20 = r19;
     *   }
     *   }
     *   r20 = objc_retainAutoreleaseReturnValue(r20);
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return nil;
}

- (id)bundleDisplayVersion {
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
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r19 = [[r0 objectForInfoDictionaryKey:@"CFBundleShortVersionString"] retain];
     *   [r21 release];
     *   if (r19 != 0x0) {
     *   r0 = [r19 retain];
     *   }
     *   else {
     *   r0 = [r20 bundleVersion];
     *   r0 = [r0 retain];
     *   }
     *   [r19 release];
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)bundleName {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r19 = [[r0 objectForInfoDictionaryKey:@"SUBundleName"] retain];
     *   [r20 release];
     *   if (r19 != 0x0) {
     *   if ([r19 length] == 0x0) {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [[r0 objectForInfoDictionaryKey:@"CFBundleDisplayName"] retain];
     *   [r19 release];
     *   [r21 release];
     *   if (r20 != 0x0) {
     *   if ([r20 length] != 0x0) {
     *   r19 = r20;
     *   r0 = [r19 retain];
     *   r20 = r0;
     *   ... (105 more lines)
     */
    return nil;
}

- (id)descriptionText {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x70;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self updateItem];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 displayVersionString] retain];
     *   [r20 release];
     *   r20 = [[r19 bundleDisplayVersion] retain];
     *   if ([r21 isEqualToString:r20] != 0x0) {
     *   r0 = [r19 updateItem];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r23 = [[r0 versionString] retain];
     *   r25 = [[r21 stringByAppendingFormat:@" (%@)", r3] retain];
     *   [r21 release];
     *   ... (22 more lines)
     */
    return nil;
}

- (void)buyNow:(id)arg1 {
    return;
}

- (void)windowDidLoad {
    return;
}

- (BOOL)windowShouldClose:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   [self endWithSelection];
     *   return 0x1;
     */
    return NO;
}

- (void)windowWillClose:(id)arg1 {
    return;
}

- (void)remindMeLater:(id)arg1 {
    return;
}

- (void)refreshRegistration:(id)arg1 {
    return;
}

- (void)skipThisVersion:(id)arg1 {
    return;
}

- (id)applicationIcon {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = **_NSApp;
     *   r0 = [r0 applicationIconImage];
     *   return r0;
     */
    return nil;
}

- (BOOL)showsReleaseNotes {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_50 = r28;
     *   decomp_var_48 = r27;
     *   r31 = r31 + 0xffffffffffffffa0;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r24 = self;
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r19 = [[r0 objectForInfoDictionaryKey:@"SUShowReleaseNotes"] retain];
     *   [r20 release];
     *   if (r19 != 0x0) {
     *   r24 = [r19 boolValue];
     *   [r19 release];
     *   r0 = r24;
     *   }
     *   else {
     *   ... (72 more lines)
     */
    return NO;
}

- (id)titleText {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r22 = [[r0 localizedStringForKey:@"A new version of %@ is available!" value:@"" table:0x0] retain];
     *   r19 = [[self bundleName] retain];
     *   r20 = [[NSString stringWithFormat:r22] retain];
     *   [r19 release];
     *   [r22 release];
     *   [r21 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)displayReleaseNotes {
    return;
}

- (void)endWithSelection {
    return;
}

- (void)webView:(id)arg1 didFinishLoadForFrame:(id)arg2 {
    return;
}

- (void)webView:(id)arg1 decidePolicyForNavigationAction:(id)arg2 request:(id)arg3 frame:(id)arg4 decisionListener:(id)arg5 {
    return;
}

- (id)webView:(id)arg1 contextMenuItemsForElement:(id)arg2 defaultMenuItems:(id)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x130;
     *   var_50 = r28;
     *   decomp_var_48 = r27;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_58 = **___stack_chk_guard;
     *   r0 = [arg4 retain];
     *   r20 = r0;
     *   r0 = [r0 mutableCopy];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   var_120 = q0;
     *   var_110 = q0;
     *   r0 = [r20 retain];
     *   r21 = r0;
     *   r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
     *   if (r0 != 0x0) {
     *   ... (28 more lines)
     */
    return nil;
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
    self->_updateItem = arg1;
}

- (id)releaseNotesSpinner {
    return self->_releaseNotesSpinner;
}

- (void)setReleaseNotesSpinner:(id)arg1 {
    self->_releaseNotesSpinner = arg1;
}

@end
