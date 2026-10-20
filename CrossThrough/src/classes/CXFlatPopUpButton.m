// CXFlatPopUpButton.m — CrossThrough
#import "CXFlatPopUpButton.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXFlatPopUpButton

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

- (void)updateColors {
    return;
}

- (void)viewDidChangeEffectiveAppearance {
    return;
}

- (void)updateBackgroundColorForCurrentState {
    return;
}

- (void)setHovering:(BOOL)arg1 {
    return;
}

- (void)highlight:(BOOL)arg1 {
    return;
}

- (void)setHighlighted:(BOOL)arg1 {
    return;
}

- (void)setEnabled:(BOOL)arg1 {
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

- (id)addItemWithTitle:(id)arg1 toolTip:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r21 = [arg3 retain];
     *   [self addItemWithTitle:arg2];
     *   r0 = [self menu];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 itemArray];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r22 = [[r0 lastObject] retain];
     *   [r20 release];
     *   [r19 release];
     *   [r22 setToolTip:r21];
     *   [r21 release];
     *   r0 = [r22 autorelease];
     *   return r0;
     */
    return nil;
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

- (BOOL)hovering {
    return self->_hovering;
}

- (BOOL)selected {
    return self->_selected;
}

- (void)setSelected:(BOOL)arg1 {
    self->_selected = arg1;
}

@end
