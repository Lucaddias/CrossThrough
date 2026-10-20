// IconCollectionView.m — CrossThrough
#import "IconCollectionView.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation IconCollectionView

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    /*
     * Decompiled from CrossOver 26.3:
     *   [self setIsFirstResponder:0x1];
     *   return 0x1;
     */
    return NO;
}

- (BOOL)resignFirstResponder {
    /*
     * Decompiled from CrossOver 26.3:
     *   [self setIsFirstResponder:0x0];
     *   return 0x1;
     */
    return NO;
}

- (void)keyDown:(id)arg1 {
    return;
}

- (void)mouseDown:(id)arg1 {
    return;
}

- (BOOL)isFirstResponder {
    return self->_isFirstResponder;
}

- (void)setIsFirstResponder:(BOOL)arg1 {
    self->_isFirstResponder = arg1;
}

@end
