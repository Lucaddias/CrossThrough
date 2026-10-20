// CXFlatButton.m — CrossThrough
#import "CXFlatButton.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXFlatButton

+ (id)flatButtonWithTitle:(id)arg1 icon:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r19 = [arg2 retain];
     *   r0 = [arg3 retain];
     *   r20 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r21 buttonWithTitle:r19 image:r20 target:0x0 action:0x0];
     *   r0 = [r0 retain];
     *   }
     *   else {
     *   r0 = [r21 buttonWithTitle:r19 target:0x0 action:0x0];
     *   r0 = [r0 retain];
     *   }
     *   r21 = r0;
     *   [r0 setAlignment:0x0];
     *   [r21 setImage:r20];
     *   [r21 setImagePosition:0x2];
     *   [r21 setImageScaling:0x3];
     *   if (r20 == 0x0) {
     *   ... (7 more lines)
     */
    return nil;
}

+ (id)flatButtonWithTitle:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self flatButtonWithTitle:arg2 icon:0x0];
     *   return r0;
     */
    return nil;
}

- (id)initWithFrame:(NSRect)arg1 {
    self = [super initWithFrame:arg1];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)initWithCoder:(id)arg1 {
    self = [super initWithCoder:arg1];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)finishInit {
    return;
}

- (void)reconfigureTitleTextField {
    return;
}

- (void)updateTitleTextColor {
    return;
}

- (void)updateTitleConstraints {
    return;
}

- (void)setFlexibleIconWidth:(BOOL)arg1 {
    self->_flexibleIconWidth = arg1;
}

- (void)reconfigureIcon {
    return;
}

- (id)imageAlignmentRectInsets {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_40 = d13;
     *   decomp_var_38 = d12;
     *   r31 = r31 + 0xffffffffffffffb0;
     *   var_30 = d11;
     *   decomp_var_28 = d10;
     *   var_20 = d9;
     *   decomp_var_18 = d8;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self image];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 release];
     *   if (r20 != 0x0) {
     *   r0 = [r19 image];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 alignmentRect];
     *   d8 = d0;
     *   d9 = d1;
     *   [r20 release];
     *   r0 = [r19 image];
     *   ... (11 more lines)
     */
    return nil;
}

- (NSRect)rectByRemovingInsets:(id)arg1 fromRect:(NSRect)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   {r2:r3:r4:r5} = arg2;
     *   r0 = self;
     *   return r0;
     */
    return NSZeroRect;
}

- (NSRect)rectByRoundingRect:(NSRect)arg1 toPixelScale:(CGFloat)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   {r2:r3:r4:r5} = arg2;
     *   r0 = NSIntegralRect(self);
     *   return r0;
     */
    return NSZeroRect;
}

- (NSSize)imageAlignmentRectSizeForCapHeight:(CGFloat)arg1 scaleFactor:(CGFloat *)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r2 = arg3;
     *   r1 = _cmd;
     *   r31 = r31 - 0x70;
     *   var_50 = d13;
     *   decomp_var_48 = d12;
     *   var_40 = d11;
     *   decomp_var_38 = d10;
     *   var_30 = d9;
     *   decomp_var_28 = d8;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = r2;
     *   d8 = d0;
     *   r20 = self;
     *   r0 = [self image];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r0 = [r0 release];
     *   if (r21 != 0x0) {
     *   r0 = [r20 image];
     *   r0 = [r0 retain];
     *   ... (41 more lines)
     */
    return NSZeroSize;
}

- (CGFloat)alottedWidthForImage {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = d9;
     *   decomp_var_28 = d8;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self flexibleIconWidth];
     *   d8 = 0x4037000000000000;
     *   if (r0 != 0x0) {
     *   r0 = [r19 titleTextField];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 font];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   [r0 capHeight];
     *   [r19 imageAlignmentRectSizeForCapHeight:0x0 scaleFactor:r3];
     *   d8 = d0;
     *   [r21 release];
     *   r0 = [r20 release];
     *   }
     *   ... (1 more lines)
     */
    return 0.0;
}

- (NSRect)imageFrame {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x70;
     *   var_50 = d13;
     *   decomp_var_48 = d12;
     *   var_40 = d11;
     *   decomp_var_38 = d10;
     *   var_30 = d9;
     *   decomp_var_28 = d8;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self image];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 release];
     *   if (r20 != 0x0) {
     *   r0 = [r19 titleTextField];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 frame];
     *   r0 = [r19 titleTextField];
     *   r0 = [r0 retain];
     *   ... (44 more lines)
     */
    return NSZeroRect;
}

- (void)drawRect:(NSRect)arg1 {
    return;
}

- (void)updateColors {
    return;
}

- (id)effectiveContentTintColor {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [self contentTintColor];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 release];
     *   r0 = self;
     *   if (r20 != 0x0) {
     *   r0 = [r0 contentTintColor];
     *   r0 = [r0 retain];
     *   }
     *   else {
     *   r0 = [r0 textColor];
     *   r0 = [r0 retain];
     *   }
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)updateBackgroundColorForCurrentState {
    return;
}

- (void)viewDidChangeEffectiveAppearance {
    return;
}

- (void)setHovering:(BOOL)arg1 {
    return;
}

- (void)updateTrackingAreas {
    return;
}

- (void)mouseEntered:(id)arg1 {
    return;
}

- (void)mouseExited:(id)arg1 {
    return;
}

- (void)mouseDown:(id)arg1 {
    return;
}

- (void)drawFocusRingMask {
    return;
}

- (id)alignmentRectInsets {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   return r0;
     */
    return nil;
}

- (CGFloat)firstBaselineOffsetFromTop {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self titleTextField];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 font];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   [r0 ascender];
     *   r0 = [self titleTextField];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r0 = [r0 font];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   [r0 descender];
     *   [r23 release];
     *   [r22 release];
     *   [r21 release];
     *   [r20 release];
     *   [self bounds];
     *   r0 = [self titleTextField];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 font];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   ... (4 more lines)
     */
    return 0.0;
}

- (NSSize)intrinsicContentSize {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_40 = d11;
     *   decomp_var_38 = d10;
     *   r31 = r31 + 0xffffffffffffffb0;
     *   var_30 = d9;
     *   decomp_var_28 = d8;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self title];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 length];
     *   [r20 release];
     *   if (r21 != 0x0) {
     *   r0 = [r19 titleTextField];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 intrinsicContentSize];
     *   d8 = d0;
     *   d9 = d1;
     *   [r20 release];
     *   ... (25 more lines)
     */
    return NSZeroSize;
}

- (void)prepareForInterfaceBuilder {
    return;
}

- (void)setFont:(id)arg1 {
    return;
}

- (void)setTitle:(id)arg1 {
    return;
}

- (void)setAlignment:(NSInteger)arg1 {
    return;
}

- (void)setControlSize:(NSUInteger)arg1 {
    return;
}

- (void)setLineBreakMode:(NSUInteger)arg1 {
    return;
}

- (void)setUsesSingleLineMode:(BOOL)arg1 {
    return;
}

- (void)setBaseWritingDirection:(NSInteger)arg1 {
    return;
}

- (void)setAllowsExpansionToolTips:(BOOL)arg1 {
    return;
}

- (void)setImage:(id)arg1 {
    return;
}

- (void)setEnabled:(BOOL)arg1 {
    return;
}

- (void)highlight:(BOOL)arg1 {
    return;
}

- (void)setHighlighted:(BOOL)arg1 {
    return;
}

- (void)setShowsBorderOnlyWhileMouseInside:(BOOL)arg1 {
    return;
}

- (void)setBezelColor:(id)arg1 {
    return;
}

- (void)setHasDestructiveAction:(BOOL)arg1 {
    self->_cx_hasDestructiveAction = arg1;
}

- (BOOL)hasDestructiveAction {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x30;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = ___isPlatformVersionAtLeast(0x1, 0xb, 0x0, 0x0);
     *   if (r0 != 0x0) {
     *   var_20 = r19;
     *   r0 = [[&var_20 super] hasDestructiveAction];
     *   }
     *   else {
     *   if (*(int8_t *)(r19 + sign_extend_64(*(int32_t *)ivar_offset(_cx_hasDestructiveAction))) != 0x0) {
     *   r0 = 0x1;
     *   }
     *   }
     *   return r0;
     */
    return NO;
}

- (void)setContentTintColor:(id)arg1 {
    return;
}

- (BOOL)flexibleIconWidth {
    return self->_flexibleIconWidth;
}

- (id)titleTextField {
    return self->_titleTextField;
}

- (void)setTitleTextField:(id)arg1 {
    self->_titleTextField = arg1;
}

- (id)titleTextFieldLeftConstraint {
    return self->_titleTextFieldLeftConstraint;
}

- (void)setTitleTextFieldLeftConstraint:(id)arg1 {
    self->_titleTextFieldLeftConstraint = arg1;
}

- (id)titleTextFieldZeroWidthConstraint {
    return self->_titleTextFieldZeroWidthConstraint;
}

- (void)setTitleTextFieldZeroWidthConstraint:(id)arg1 {
    self->_titleTextFieldZeroWidthConstraint = arg1;
}

- (BOOL)hovering {
    return self->_hovering;
}

- (id)normalBackgroundColor {
    return self->_normalBackgroundColor;
}

- (void)setNormalBackgroundColor:(id)arg1 {
    self->_normalBackgroundColor = arg1;
}

- (id)hoverBackgroundColor {
    return self->_hoverBackgroundColor;
}

- (void)setHoverBackgroundColor:(id)arg1 {
    self->_hoverBackgroundColor = arg1;
}

- (id)selectedBackgroundColor {
    return self->_selectedBackgroundColor;
}

- (void)setSelectedBackgroundColor:(id)arg1 {
    self->_selectedBackgroundColor = arg1;
}

- (id)textColor {
    return self->_textColor;
}

- (void)setTextColor:(id)arg1 {
    self->_textColor = arg1;
}

@end
