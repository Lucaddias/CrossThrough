// CXFlatButton.m — CrossThrough
#import "CXFlatButton.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

// Icons are centered in a fixed-width column so titles line up across a
// stack of buttons, unless flexibleIconWidth is set.
static const CGFloat CXFlatButtonFixedIconWidth = 23.0;
static const CGFloat CXFlatButtonPadding = 10.0;
static const CGFloat CXFlatButtonCornerRadius = 4.0;
static const CGFloat CXFlatButtonMinimumHeight = 32.0;

@implementation CXFlatButton

+ (id)flatButtonWithTitle:(id)arg1 icon:(id)arg2 {
    CXFlatButton *button;
    if (arg2) {
        button = [self buttonWithTitle:arg1 image:arg2 target:nil action:NULL];
    } else {
        button = [self buttonWithTitle:arg1 target:nil action:NULL];
    }
    [button setAlignment:NSTextAlignmentLeft];
    [button setImage:arg2];
    [button setImagePosition:NSImageLeft];
    [button setImageScaling:NSImageScaleProportionallyUpOrDown];
    if (!arg2) {
        [button setFlexibleIconWidth:YES];
    }
    [button sizeToFit];
    return button;
}

+ (id)flatButtonWithTitle:(id)arg1 {
    return [self flatButtonWithTitle:arg1 icon:nil];
}

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
    [self->_titleTextField release];
    [self->_titleTextFieldLeftConstraint release];
    [self->_titleTextFieldZeroWidthConstraint release];
    [self->_normalBackgroundColor release];
    [self->_hoverBackgroundColor release];
    [self->_selectedBackgroundColor release];
    [self->_textColor release];
    [super dealloc];
}

- (void)finishInit {
    [self setBordered:NO];
    [self setWantsLayer:YES];
    [[self layer] setMasksToBounds:YES];
    [[self layer] setCornerRadius:CXFlatButtonCornerRadius];

    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                                options:NSTrackingMouseEnteredAndExited | NSTrackingActiveInActiveApp | NSTrackingInVisibleRect
                                                                  owner:self
                                                               userInfo:nil];
    [self addTrackingArea:trackingArea];
    [trackingArea release];

    [self setTitleTextField:[NSTextField labelWithString:@""]];
    [[self titleTextField] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:[self titleTextField]];

    [[[[self titleTextField] centerYAnchor] constraintEqualToAnchor:[self centerYAnchor]] setActive:YES];

    NSLayoutConstraint *right = [[[self titleTextField] rightAnchor] constraintEqualToAnchor:[self rightAnchor] constant:-CXFlatButtonPadding];
    [right setPriority:NSLayoutPriorityDefaultHigh];
    [right setActive:YES];

    [self setTitleTextFieldLeftConstraint:[[[self titleTextField] leftAnchor] constraintEqualToAnchor:[self leftAnchor]]];
    [self updateTitleConstraints];
    [[self titleTextFieldLeftConstraint] setActive:YES];

    [self setTitleTextFieldZeroWidthConstraint:[[[self titleTextField] widthAnchor] constraintEqualToConstant:0.0]];
    [self updateColors];
    [self reconfigureTitleTextField];
}

- (void)reconfigureTitleTextField {
    NSTextField *field = [self titleTextField];
    [field setFont:[self font]];
    [field setStringValue:[self title]];
    [field setAlignment:[self alignment]];
    [field setControlSize:[self controlSize]];
    [field setLineBreakMode:[self lineBreakMode]];
    [field setUsesSingleLineMode:[self usesSingleLineMode]];
    [field setBaseWritingDirection:[self baseWritingDirection]];
    [field setAllowsExpansionToolTips:[self allowsExpansionToolTips]];
    [self updateTitleTextColor];
    [self updateTitleConstraints];
}

- (void)updateTitleTextColor {
    [[self titleTextField] setTextColor:[self effectiveContentTintColor]];
}

- (void)updateTitleConstraints {
    CGFloat imageWidth = [self alottedWidthForImage];
    CGFloat leading = imageWidth + CXFlatButtonPadding;
    if (imageWidth > 0.0 && [[self title] length] != 0) {
        leading += CXFlatButtonPadding;
    }
    [[self titleTextFieldLeftConstraint] setConstant:leading];
    [[self titleTextFieldZeroWidthConstraint] setActive:[[self title] length] == 0];
    [self invalidateIntrinsicContentSize];
}

- (void)setFlexibleIconWidth:(BOOL)arg1 {
    self->_flexibleIconWidth = arg1;
    [self updateTitleConstraints];
    [self reconfigureIcon];
}

- (void)reconfigureIcon {
    [self setNeedsDisplay:YES];
}

- (NSEdgeInsets)imageAlignmentRectInsets {
    if (![self image]) {
        return NSEdgeInsetsZero;
    }
    NSRect alignmentRect = [[self image] alignmentRect];
    NSSize size = [[self image] size];
    return NSEdgeInsetsMake(size.height - (alignmentRect.origin.y + alignmentRect.size.height),
                            alignmentRect.origin.x,
                            alignmentRect.origin.y,
                            size.width - (alignmentRect.origin.x + alignmentRect.size.width));
}

- (NSRect)rectByRemovingInsets:(NSEdgeInsets)arg1 fromRect:(NSRect)arg2 {
    return NSMakeRect(arg2.origin.x - arg1.left,
                      arg2.origin.y - arg1.top,
                      arg2.size.width + arg1.left + arg1.right,
                      arg2.size.height + arg1.top + arg1.bottom);
}

- (NSRect)rectByRoundingRect:(NSRect)arg1 toPixelScale:(CGFloat)arg2 {
    NSRect scaled = NSIntegralRect(NSMakeRect(arg1.origin.x * arg2, arg1.origin.y * arg2,
                                              arg1.size.width * arg2, arg1.size.height * arg2));
    return NSMakeRect(scaled.origin.x / arg2, scaled.origin.y / arg2,
                      scaled.size.width / arg2, scaled.size.height / arg2);
}

- (NSSize)imageAlignmentRectSizeForCapHeight:(CGFloat)arg1 scaleFactor:(CGFloat *)arg2 {
    if (![self image]) {
        if (arg2) {
            *arg2 = 1.0;
        }
        return NSZeroSize;
    }
    NSRect alignmentRect = [[self image] alignmentRect];
    CGFloat scale = arg1 / alignmentRect.size.height;
    NSSize size = NSMakeSize(alignmentRect.size.width * scale, arg1);
    if (![self flexibleIconWidth] && size.width > CXFlatButtonFixedIconWidth) {
        NSLog(@"Scaling to cap height resulted in an icon of width %.1f (max is %.1f); scaling to max icon width instead. Increase CXFlatButtonFixedIconWidth or use flexibleIconWidth to ensure proper alignment.", size.width, CXFlatButtonFixedIconWidth);
        scale = CXFlatButtonFixedIconWidth / alignmentRect.size.width;
        size = NSMakeSize(CXFlatButtonFixedIconWidth, alignmentRect.size.height * scale);
    }
    if (arg2) {
        *arg2 = scale;
    }
    return size;
}

- (CGFloat)alottedWidthForImage {
    if (![self flexibleIconWidth]) {
        return CXFlatButtonFixedIconWidth;
    }
    return [self imageAlignmentRectSizeForCapHeight:[[[self titleTextField] font] capHeight] scaleFactor:NULL].width;
}

- (NSRect)imageFrame {
    if (![self image]) {
        return NSZeroRect;
    }
    // Align the icon's alignment rect with the title's cap height.
    NSTextField *field = [self titleTextField];
    CGFloat capTop = NSMinY([field frame]) + [field firstBaselineOffsetFromTop];
    CGFloat capHeight = [[field font] capHeight];
    capTop -= capHeight;

    CGFloat scale = 1.0;
    NSSize size = [self imageAlignmentRectSizeForCapHeight:capHeight scaleFactor:&scale];
    CGFloat x = CXFlatButtonPadding;
    if (![self flexibleIconWidth]) {
        x = (CXFlatButtonFixedIconWidth - size.width) * 0.5 + CXFlatButtonPadding;
    }
    CGFloat y = capTop + (capHeight - size.height) * 0.5;

    NSEdgeInsets insets = [self imageAlignmentRectInsets];
    insets.top *= scale;
    insets.left *= scale;
    insets.bottom *= scale;
    insets.right *= scale;
    NSRect frame = [self rectByRemovingInsets:insets fromRect:NSMakeRect(x, y, size.width, size.height)];

    CGFloat backingScale = [[[self window] screen] backingScaleFactor];
    return [self rectByRoundingRect:frame toPixelScale:fmax(backingScale, 1.0)];
}

- (void)drawRect:(NSRect)arg1 {
    if (![self image]) {
        return;
    }
    NSRect frame = [self imageFrame];
    if (![self needsToDrawRect:frame]) {
        return;
    }
    [[self image] drawInRect:frame];
    if ([[self image] isTemplate]) {
        [[self effectiveContentTintColor] setFill];
        NSRectFillUsingOperation(frame, NSCompositingOperationSourceAtop);
    }
}

- (void)updateColors {
    if ([self bezelColor]) {
        [self setNormalBackgroundColor:[[self bezelColor] colorWithAlphaComponent:0.8]];
        [self setHoverBackgroundColor:[[self bezelColor] colorWithAlphaComponent:0.9]];
        [self setSelectedBackgroundColor:[self bezelColor]];
    } else if ([self hasDestructiveAction]) {
        [self setNormalBackgroundColor:[[NSColor systemRedColor] colorWithAlphaComponent:0.05]];
        [self setHoverBackgroundColor:[[NSColor systemRedColor] colorWithAlphaComponent:0.1]];
        [self setSelectedBackgroundColor:[[NSColor systemRedColor] colorWithAlphaComponent:0.15]];
    } else {
        [self setNormalBackgroundColor:[[NSColor secondarySelectedControlColor] colorWithAlphaComponent:0.2]];
        [self setHoverBackgroundColor:[[NSColor secondarySelectedControlColor] colorWithAlphaComponent:0.3]];
        [self setSelectedBackgroundColor:[[NSColor secondarySelectedControlColor] colorWithAlphaComponent:0.5]];
    }
    [self setTextColor:[self hasDestructiveAction] ? [NSColor systemRedColor] : [NSColor labelColor]];
    if ([self showsBorderOnlyWhileMouseInside]) {
        [self setNormalBackgroundColor:[NSColor clearColor]];
    }
    [self updateBackgroundColorForCurrentState];
    [self updateTitleTextColor];
    [self reconfigureIcon];
}

- (id)effectiveContentTintColor {
    if ([self contentTintColor]) {
        return [self contentTintColor];
    }
    return [self textColor];
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

- (void)viewDidChangeEffectiveAppearance {
    [super viewDidChangeEffectiveAppearance];
    [self updateColors];
}

- (void)setHovering:(BOOL)arg1 {
    if (self->_hovering != arg1) {
        self->_hovering = arg1;
        [self updateBackgroundColorForCurrentState];
    }
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

- (void)drawFocusRingMask {
    [[NSBezierPath bezierPathWithRoundedRect:[self bounds] xRadius:CXFlatButtonCornerRadius yRadius:CXFlatButtonCornerRadius] fill];
}

- (NSEdgeInsets)alignmentRectInsets {
    return NSEdgeInsetsZero;
}

- (CGFloat)firstBaselineOffsetFromTop {
    NSFont *font = [[self titleTextField] font];
    CGFloat lineHeight = [font ascender] - [font descender];
    return ([self bounds].size.height - lineHeight) * 0.5 + [font ascender];
}

- (NSSize)intrinsicContentSize {
    NSSize titleSize = NSZeroSize;
    if ([[self title] length] != 0) {
        titleSize = [[self titleTextField] intrinsicContentSize];
    }
    if (titleSize.width == NSViewNoIntrinsicMetric) {
        titleSize.width = 0.0;
    }
    if (titleSize.height == NSViewNoIntrinsicMetric) {
        titleSize.height = 0.0;
    }
    CGFloat width = [self alottedWidthForImage] + CXFlatButtonPadding;
    width += [[self title] length] == 0 ? -0.0 : titleSize.width;
    width += CXFlatButtonPadding;
    return NSMakeSize(width, fmax(titleSize.height, CXFlatButtonMinimumHeight));
}

- (void)prepareForInterfaceBuilder {
    [self invalidateIntrinsicContentSize];
    [super prepareForInterfaceBuilder];
}

- (void)setFont:(id)arg1 {
    [super setFont:arg1];
    [self reconfigureTitleTextField];
}

- (void)setTitle:(id)arg1 {
    [super setTitle:arg1];
    [self reconfigureTitleTextField];
}

- (void)setAlignment:(NSInteger)arg1 {
    [super setAlignment:arg1];
    [self reconfigureTitleTextField];
}

- (void)setControlSize:(NSUInteger)arg1 {
    [super setControlSize:arg1];
    [self reconfigureTitleTextField];
}

- (void)setLineBreakMode:(NSUInteger)arg1 {
    // Only the truncating modes make sense for a one-line title; anything
    // else falls back to clipping.
    if (arg1 < NSLineBreakByTruncatingHead || arg1 > NSLineBreakByTruncatingMiddle) {
        arg1 = NSLineBreakByClipping;
    }
    [super setLineBreakMode:arg1];
    [self reconfigureTitleTextField];
}

- (void)setUsesSingleLineMode:(BOOL)arg1 {
    [super setUsesSingleLineMode:arg1];
    [self reconfigureTitleTextField];
}

- (void)setBaseWritingDirection:(NSInteger)arg1 {
    [super setBaseWritingDirection:arg1];
    [self reconfigureTitleTextField];
}

- (void)setAllowsExpansionToolTips:(BOOL)arg1 {
    [super setAllowsExpansionToolTips:arg1];
    [self reconfigureTitleTextField];
}

- (void)setImage:(id)arg1 {
    [super setImage:arg1];
    [self reconfigureIcon];
}

- (void)setEnabled:(BOOL)arg1 {
    [super setEnabled:arg1];
    [self updateBackgroundColorForCurrentState];
}

- (void)highlight:(BOOL)arg1 {
    [super highlight:arg1];
    [self setHighlighted:arg1];
}

- (void)setHighlighted:(BOOL)arg1 {
    [super setHighlighted:arg1];
    [self updateBackgroundColorForCurrentState];
}

- (void)setShowsBorderOnlyWhileMouseInside:(BOOL)arg1 {
    [super setShowsBorderOnlyWhileMouseInside:arg1];
    [self updateColors];
}

- (void)setBezelColor:(id)arg1 {
    [super setBezelColor:arg1];
    [self updateColors];
}

- (void)setHasDestructiveAction:(BOOL)arg1 {
    self->_cx_hasDestructiveAction = arg1;
    if (@available(macOS 11.0, *)) {
        [super setHasDestructiveAction:arg1];
    }
    [self updateColors];
}

- (BOOL)hasDestructiveAction {
    if (@available(macOS 11.0, *)) {
        return [super hasDestructiveAction];
    }
    return self->_cx_hasDestructiveAction;
}

- (void)setContentTintColor:(id)arg1 {
    [super setContentTintColor:arg1];
    [self updateTitleTextColor];
    [self reconfigureIcon];
}

- (BOOL)flexibleIconWidth {
    return self->_flexibleIconWidth;
}

- (id)titleTextField {
    return self->_titleTextField;
}

- (void)setTitleTextField:(id)arg1 {
    if (self->_titleTextField != arg1) {
        [self->_titleTextField release];
        self->_titleTextField = [arg1 retain];
    }
}

- (id)titleTextFieldLeftConstraint {
    return self->_titleTextFieldLeftConstraint;
}

- (void)setTitleTextFieldLeftConstraint:(id)arg1 {
    if (self->_titleTextFieldLeftConstraint != arg1) {
        [self->_titleTextFieldLeftConstraint release];
        self->_titleTextFieldLeftConstraint = [arg1 retain];
    }
}

- (id)titleTextFieldZeroWidthConstraint {
    return self->_titleTextFieldZeroWidthConstraint;
}

- (void)setTitleTextFieldZeroWidthConstraint:(id)arg1 {
    if (self->_titleTextFieldZeroWidthConstraint != arg1) {
        [self->_titleTextFieldZeroWidthConstraint release];
        self->_titleTextFieldZeroWidthConstraint = [arg1 retain];
    }
}

- (BOOL)hovering {
    return self->_hovering;
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

- (id)textColor {
    return self->_textColor;
}

- (void)setTextColor:(id)arg1 {
    if (self->_textColor != arg1) {
        [self->_textColor release];
        self->_textColor = [arg1 retain];
    }
}

@end
