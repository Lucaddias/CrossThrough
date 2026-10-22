// CXFlatPopUpButton.m — CrossThrough
#import "CXFlatPopUpButton.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXFlatPopUpButton

- (id)initWithFrame:(NSRect)arg1 {
    self = [super initWithFrame:arg1];
    if (self) {
        [self finishInit];
    }
    return self;
}

- (id)initWithCoder:(id)arg1 {
    self = [super initWithCoder:arg1];
    if (self) {
        [self finishInit];
    }
    return self;
}

- (void)dealloc {
    [self->_normalBackgroundColor release];
    [self->_hoverBackgroundColor release];
    [self->_selectedBackgroundColor release];
    [super dealloc];
}

- (void)finishInit {
    [self setWantsLayer:YES];
    [[self layer] setMasksToBounds:YES];
    [[self layer] setCornerRadius:4.0];
    [self updateColors];
    [self setBordered:NO];
    [self setBezelStyle:NSBezelStyleRegularSquare];
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                                options:NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp | NSTrackingInVisibleRect
                                                                  owner:self
                                                               userInfo:nil];
    [self addTrackingArea:trackingArea];
    [trackingArea release];
}

- (void)updateColors {
    [self setNormalBackgroundColor:[[NSColor secondarySelectedControlColor] colorWithAlphaComponent:0.2]];
    [self setHoverBackgroundColor:[[NSColor secondarySelectedControlColor] colorWithAlphaComponent:0.3]];
    [self setSelectedBackgroundColor:[[NSColor secondarySelectedControlColor] colorWithAlphaComponent:0.5]];
    [self updateBackgroundColorForCurrentState];
}

- (void)viewDidChangeEffectiveAppearance {
    [super viewDidChangeEffectiveAppearance];
    [self updateColors];
}

- (void)updateBackgroundColorForCurrentState {
    [[self layer] setOpacity:[self isEnabled] ? 1.0f : 0.5f];
    NSColor *color;
    if ([self isEnabled] && [self isHighlighted]) {
        color = [self selectedBackgroundColor];
    } else if ([self isEnabled] && [self hovering]) {
        color = [self hoverBackgroundColor];
    } else {
        color = [self normalBackgroundColor];
    }
    [[self layer] setBackgroundColor:[color CGColor]];
}

- (void)setHovering:(BOOL)arg1 {
    if (self->_hovering != arg1) {
        self->_hovering = arg1;
        [self updateBackgroundColorForCurrentState];
    }
}

- (void)highlight:(BOOL)arg1 {
    [super highlight:arg1];
    [self setHighlighted:arg1];
}

- (void)setHighlighted:(BOOL)arg1 {
    [super setHighlighted:arg1];
    [self updateBackgroundColorForCurrentState];
}

- (void)setEnabled:(BOOL)arg1 {
    [super setEnabled:arg1];
    [self updateBackgroundColorForCurrentState];
}

- (void)updateTrackingAreas {
    NSPoint location = [self convertPoint:[[self window] mouseLocationOutsideOfEventStream] fromView:nil];
    [self setHovering:[self mouse:location inRect:[self bounds]]];
    [super updateTrackingAreas];
}

- (void)mouseEntered:(id)arg1 {
    [super mouseEntered:arg1];
    [self setHovering:YES];
}

- (void)mouseExited:(id)arg1 {
    [super mouseExited:arg1];
    [self setHovering:NO];
}

- (void)mouseDown:(id)arg1 {
    [self highlight:YES];
    [super mouseDown:arg1];
    [self highlight:NO];
}

- (id)addItemWithTitle:(id)arg1 toolTip:(id)arg2 {
    [self addItemWithTitle:arg1];
    NSMenuItem *item = [[[self menu] itemArray] lastObject];
    [item setToolTip:arg2];
    return item;
}

- (id)normalBackgroundColor {
    return self->_normalBackgroundColor;
}

- (void)setNormalBackgroundColor:(id)arg1 {
    if (self->_normalBackgroundColor != arg1) {
        [self->_normalBackgroundColor release];
        self->_normalBackgroundColor = [arg1 retain];
    }
}

- (id)hoverBackgroundColor {
    return self->_hoverBackgroundColor;
}

- (void)setHoverBackgroundColor:(id)arg1 {
    if (self->_hoverBackgroundColor != arg1) {
        [self->_hoverBackgroundColor release];
        self->_hoverBackgroundColor = [arg1 retain];
    }
}

- (id)selectedBackgroundColor {
    return self->_selectedBackgroundColor;
}

- (void)setSelectedBackgroundColor:(id)arg1 {
    if (self->_selectedBackgroundColor != arg1) {
        [self->_selectedBackgroundColor release];
        self->_selectedBackgroundColor = [arg1 retain];
    }
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
