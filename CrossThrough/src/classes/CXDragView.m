// CXDragView.m — CrossThrough
#import "CXDragView.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXDragView

- (NSUInteger)draggingEntered:(id)arg1 {
    return 1;
}

- (BOOL)performDragOperation:(id)arg1 {
    return [(id<CXDragViewDelegate>)[self delegate] performDragOperation:arg1];
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

- (void)dealloc {
    [self->_delegate release];
    [super dealloc];
}

@end
