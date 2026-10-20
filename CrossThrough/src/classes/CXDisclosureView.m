// CXDisclosureView.m — CrossThrough
#import "CXDisclosureView.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXDisclosureView

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

- (void)setTitle:(id)arg1 {
    return;
}

- (void)setOn:(BOOL)arg1 {
    self->_on = arg1;
}

- (void)setAutosaveName:(id)arg1 {
    return;
}

- (void)setDetailView:(id)arg1 {
    return;
}

- (void)disclosureTriangleClicked:(id)arg1 {
    return;
}

- (void)titleButtonClicked:(id)arg1 {
    return;
}

- (NSSize)intrinsicContentSize {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self titleButton];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 intrinsicContentSize];
     *   [r20 release];
     *   r0 = [self disclosureTriangle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   CGRectGetMaxX([r0 frame]);
     *   r0 = [r19 release];
     *   return r0;
     */
    return NSZeroSize;
}

- (void)prepareForInterfaceBuilder {
    return;
}

- (id)title {
    return self->_title;
}

- (BOOL)isOn {
    return self->_on;
}

- (id)detailView {
    return [objc_loadWeakRetained((id *)&self->_detailView) autorelease];
}

- (id)autosaveName {
    return self->_autosaveName;
}

- (BOOL)gotOnState {
    return self->_gotOnState;
}

- (void)setGotOnState:(BOOL)arg1 {
    self->_gotOnState = arg1;
}

- (id)disclosureTriangle {
    return self->_disclosureTriangle;
}

- (void)setDisclosureTriangle:(id)arg1 {
    self->_disclosureTriangle = arg1;
}

- (id)titleButton {
    return self->_titleButton;
}

- (void)setTitleButton:(id)arg1 {
    self->_titleButton = arg1;
}

@end
