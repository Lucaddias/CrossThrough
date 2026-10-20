// InstallSummaryDetailViewController.m — CrossThrough
#import "InstallSummaryDetailViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallSummaryDetailViewController

+ (id)keyPathsForValuesAffectingHasAction {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"action"];
     *   return r0;
     */
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (BOOL)hasAction {
    /*
     * Decompiled from CrossOver 26.3:
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r31 = r31 + 0xfffffffffffffff0;
     *   r0 = [self action];
     *   if (r0 != 0x0) {
     *   r0 = 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (void)select:(id)arg1 {
    return;
}

- (void)setSendsActionOnMouseDown:(BOOL)arg1 {
    self->_sendsActionOnMouseDown = arg1;
}

- (void)setButtonEnabled:(BOOL)arg1 {
    self->_buttonEnabled = arg1;
}

- (void)viewDidLoad {
    return;
}

- (id)delegate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_delegate);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDelegate:(id)arg1 {
    return;
}

- (id)image {
    return self->_image;
}

- (void)setImage:(id)arg1 {
    return;
}

- (id)text {
    return self->_text;
}

- (void)setText:(id)arg1 {
    return;
}

- (SEL)action {
    return self->_action;
}

- (void)setAction:(SEL)arg1 {
    return;
}

- (BOOL)sendsActionOnMouseDown {
    return self->_sendsActionOnMouseDown;
}

- (BOOL)buttonEnabled {
    return self->_buttonEnabled;
}

- (id)editButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_editButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setEditButton:(id)arg1 {
    return;
}

@end
