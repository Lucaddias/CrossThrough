// IconCollectionView.m — CrossThrough
#import "IconCollectionView.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation IconCollectionView

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    [self setIsFirstResponder:YES];
    return YES;
}

- (BOOL)resignFirstResponder {
    [self setIsFirstResponder:NO];
    return YES;
}

- (void)keyDown:(id)arg1 {
    [[self nextResponder] keyDown:arg1];
}

- (void)mouseDown:(id)arg1 {
    [super mouseDown:arg1];
    [[self nextResponder] mouseDown:arg1];
}

- (BOOL)isFirstResponder {
    return self->_isFirstResponder;
}

- (void)setIsFirstResponder:(BOOL)arg1 {
    self->_isFirstResponder = arg1;
}

@end
