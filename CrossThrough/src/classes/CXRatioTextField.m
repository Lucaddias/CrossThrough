// CXRatioTextField.m — CrossThrough
#import "CXRatioTextField.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXRatioTextField

- (id)initWithCoder:(id)arg1 {
    self = [super initWithCoder:arg1];
    if (self) {
        self->_maxAspectRatio = 19.0 / 3.0;
    }
    return self;
}

- (id)initWithFrame:(NSRect)arg1 {
    self = [super initWithFrame:arg1];
    if (self) {
        self->_maxAspectRatio = 19.0 / 3.0;
    }
    return self;
}

- (NSSize)intrinsicContentSize {
    if (!NSEqualSizes(self->_cachedIntrinsicContentSize, NSZeroSize)) {
        return self->_cachedIntrinsicContentSize;
    }
    // Wrap the text so the field is no wider than _maxAspectRatio times its
    // height, then pick the narrowest width that keeps that height.
    NSCell *cell = [self cell];
    NSSize size = [cell cellSizeForBounds:NSMakeRect(0.0, 0.0, CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat ratio = self->_maxAspectRatio;
    CGFloat bestWidth = size.height * ratio;
    if (size.width > bestWidth) {
        CGFloat singleLineHeight = size.height;
        CGFloat bestHeight = size.height + size.height;

        // Widest width that still satisfies the ratio.
        CGFloat high = size.width;
        CGFloat low = bestWidth;
        while (high - low > 1.0) {
            CGFloat mid = (high + low) * 0.5;
            NSSize trial = [cell cellSizeForBounds:NSMakeRect(0.0, 0.0, mid, CGFLOAT_MAX)];
            ratio = self->_maxAspectRatio;
            if (trial.width > trial.height * ratio) {
                high = mid;
            } else {
                low = mid;
                bestWidth = trial.width;
                bestHeight = trial.height;
            }
        }

        if (bestHeight > singleLineHeight) {
            // Narrowest width that doesn't add another line.
            CGFloat narrowest = bestWidth;
            CGFloat lowWidth = singleLineHeight * ratio;
            CGFloat highWidth = bestWidth;
            while (highWidth - lowWidth > 1.0) {
                CGFloat mid = (highWidth + lowWidth) * 0.5;
                NSSize trial = [cell cellSizeForBounds:NSMakeRect(0.0, 0.0, mid, CGFLOAT_MAX)];
                if (trial.height > bestHeight) {
                    lowWidth = mid;
                } else {
                    narrowest = trial.width;
                    highWidth = mid;
                }
            }
            CGFloat width = narrowest + (bestWidth - narrowest) * 0.25;
            size = [cell cellSizeForBounds:NSMakeRect(0.0, 0.0, width, CGFLOAT_MAX)];
        } else {
            size = NSMakeSize(bestWidth, bestHeight);
        }
    }
    NSRect frame = NSMakeRect(0.0, 0.0, ceil(size.width), ceil(size.height));
    self->_cachedIntrinsicContentSize = [self alignmentRectForFrame:frame].size;
    return self->_cachedIntrinsicContentSize;
}

- (void)invalidateIntrinsicContentSize {
    self->_cachedIntrinsicContentSize = NSZeroSize;
    [super invalidateIntrinsicContentSize];
}

- (void)invalidateIntrinsicContentSizeForCell:(id)arg1 {
    [self invalidateIntrinsicContentSize];
    [super invalidateIntrinsicContentSizeForCell:arg1];
}

- (CGFloat)maxAspectRatio {
    return self->_maxAspectRatio;
}

- (void)setMaxAspectRatio:(CGFloat)arg1 {
    self->_maxAspectRatio = arg1;
}

@end
