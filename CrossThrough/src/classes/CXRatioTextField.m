// CXRatioTextField.m — CrossThrough
#import "CXRatioTextField.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXRatioTextField

- (id)initWithCoder:(id)arg1 {
    self = [super initWithCoder:arg1];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)initWithFrame:(NSRect)arg1 {
    self = [super initWithFrame:arg1];
    if (self) {
        // Initialized
    }
    return self;
}

- (NSSize)intrinsicContentSize {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x90;
     *   var_70 = d15;
     *   decomp_var_68 = d14;
     *   var_60 = d13;
     *   decomp_var_58 = d12;
     *   var_50 = d11;
     *   decomp_var_48 = d10;
     *   var_40 = d9;
     *   decomp_var_38 = d8;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r21 = (int64_t *)&self->_cachedIntrinsicContentSize;
     *   r0 = NSEqualSizes(self, _cmd);
     *   if ((r0 & 0x1) != 0x0) {
     *   r0 = [r19 cell];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   d2 = 0x7fefffffffffffff;
     *   ... (88 more lines)
     */
    return NSZeroSize;
}

- (void)invalidateIntrinsicContentSize {
    return;
}

- (void)invalidateIntrinsicContentSizeForCell:(id)arg1 {
    return;
}

- (CGFloat)maxAspectRatio {
    return self->_maxAspectRatio;
}

- (void)setMaxAspectRatio:(CGFloat)arg1 {
    self->_maxAspectRatio = arg1;
}

@end
