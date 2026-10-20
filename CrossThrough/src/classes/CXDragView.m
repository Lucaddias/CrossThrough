// CXDragView.m — CrossThrough
#import "CXDragView.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXDragView

- (NSUInteger)draggingEntered:(id)arg1 {
    return 1;
}

- (BOOL)performDragOperation:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r0 = [self delegate];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r21 = [r0 performDragOperation:r20];
     *   [r20 release];
     *   [r19 release];
     *   r0 = r21;
     *   return r0;
     */
    return NO;
}

- (id)delegate {
    return [[self->_delegate retain] autorelease];
}

- (void)setDelegate:(id)arg1 {
    if (self->_delegate != arg1) {
        [self->_delegate release];
        self->_delegate = [arg1 retain];
    }
}

@end
