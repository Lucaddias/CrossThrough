// RosettaInstallationController.m — CrossThrough
#import "RosettaInstallationController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation RosettaInstallationController

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)findDetailsConstraints:(id)arg1 {
    return;
}

- (void)windowDidLoad {
    return;
}

- (void)exitButton:(id)arg1 {
    return;
}

- (void)installFailed {
    return;
}

- (void)installButton:(id)arg1 {
    return;
}

- (void)sheetDoneButton:(id)arg1 {
    return;
}

- (void)sheetDetailDisclosureButton:(id)arg1 {
    return;
}

- (id)task {
    return self->_task;
}

- (void)setTask:(id)arg1 {
    self->_task = arg1;
}

- (id)detailsShownConstraints {
    return self->_detailsShownConstraints;
}

- (void)setDetailsShownConstraints:(id)arg1 {
    self->_detailsShownConstraints = arg1;
}

- (id)detailsHiddenConstraints {
    return self->_detailsHiddenConstraints;
}

- (void)setDetailsHiddenConstraints:(id)arg1 {
    self->_detailsHiddenConstraints = arg1;
}

- (id)licenseLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_licenseLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setLicenseLabel:(id)arg1 {
    return;
}

- (id)titleLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_titleLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setTitleLabel:(id)arg1 {
    return;
}

- (id)progressSheet {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_progressSheet)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setProgressSheet:(id)arg1 {
    return;
}

- (id)progressSheetDetailsLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetDetailsLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressSheetDetailsLabel:(id)arg1 {
    return;
}

- (id)progressSheetDoneButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetDoneButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressSheetDoneButton:(id)arg1 {
    return;
}

- (id)progressSheetIcon {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetIcon);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressSheetIcon:(id)arg1 {
    return;
}

- (id)progressSheetProgressIndicator {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetProgressIndicator);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressSheetProgressIndicator:(id)arg1 {
    return;
}

- (id)progressSheetShowHideDetailsButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetShowHideDetailsButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressSheetShowHideDetailsButton:(id)arg1 {
    return;
}

- (id)progressSheetScrollView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetScrollView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressSheetScrollView:(id)arg1 {
    return;
}

- (id)progressSheetTextView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressSheetTextView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressSheetTextView:(id)arg1 {
    return;
}

@end
