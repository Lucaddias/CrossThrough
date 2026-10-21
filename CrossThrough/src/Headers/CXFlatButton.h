// CXFlatButton.h — CrossThrough
#ifndef CXFlatButton_h
#define CXFlatButton_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXFlatButton;

@interface CXFlatButton : NSButton
{
    BOOL _cx_hasDestructiveAction;
    BOOL _flexibleIconWidth;
    BOOL _hovering;
    NSTextField * _titleTextField;
    NSLayoutConstraint * _titleTextFieldLeftConstraint;
    NSLayoutConstraint * _titleTextFieldZeroWidthConstraint;
    NSColor * _normalBackgroundColor;
    NSColor * _hoverBackgroundColor;
    NSColor * _selectedBackgroundColor;
    NSColor * _textColor;
}

// Class Methods
+ (id)flatButtonWithTitle:(id)arg1 icon:(id)arg2;
+ (id)flatButtonWithTitle:(id)arg1;

// Instance Methods
- (id)initWithFrame:(NSRect)arg1;
- (id)initWithCoder:(id)arg1;
- (void)finishInit;
- (void)reconfigureTitleTextField;
- (void)updateTitleTextColor;
- (void)updateTitleConstraints;
- (void)setFlexibleIconWidth:(BOOL)arg1;
- (void)reconfigureIcon;
- (NSEdgeInsets)imageAlignmentRectInsets;
- (NSRect)rectByRemovingInsets:(NSEdgeInsets)arg1 fromRect:(NSRect)arg2;
- (NSRect)rectByRoundingRect:(NSRect)arg1 toPixelScale:(CGFloat)arg2;
- (NSSize)imageAlignmentRectSizeForCapHeight:(CGFloat)arg1 scaleFactor:(CGFloat *)arg2;
- (CGFloat)alottedWidthForImage;
- (NSRect)imageFrame;
- (void)drawRect:(NSRect)arg1;
- (void)updateColors;
- (id)effectiveContentTintColor;
- (void)updateBackgroundColorForCurrentState;
- (void)viewDidChangeEffectiveAppearance;
- (void)setHovering:(BOOL)arg1;
- (void)updateTrackingAreas;
- (void)mouseEntered:(id)arg1;
- (void)mouseExited:(id)arg1;
- (void)mouseDown:(id)arg1;
- (void)drawFocusRingMask;
- (NSEdgeInsets)alignmentRectInsets;
- (CGFloat)firstBaselineOffsetFromTop;
- (NSSize)intrinsicContentSize;
- (void)prepareForInterfaceBuilder;
- (void)setFont:(id)arg1;
- (void)setTitle:(id)arg1;
- (void)setAlignment:(NSInteger)arg1;
- (void)setControlSize:(NSUInteger)arg1;
- (void)setLineBreakMode:(NSUInteger)arg1;
- (void)setUsesSingleLineMode:(BOOL)arg1;
- (void)setBaseWritingDirection:(NSInteger)arg1;
- (void)setAllowsExpansionToolTips:(BOOL)arg1;
- (void)setImage:(id)arg1;
- (void)setEnabled:(BOOL)arg1;
- (void)highlight:(BOOL)arg1;
- (void)setHighlighted:(BOOL)arg1;
- (void)setShowsBorderOnlyWhileMouseInside:(BOOL)arg1;
- (void)setBezelColor:(id)arg1;
- (void)setHasDestructiveAction:(BOOL)arg1;
- (BOOL)hasDestructiveAction;
- (void)setContentTintColor:(id)arg1;
- (BOOL)flexibleIconWidth;
- (id)titleTextField;
- (void)setTitleTextField:(id)arg1;
- (id)titleTextFieldLeftConstraint;
- (void)setTitleTextFieldLeftConstraint:(id)arg1;
- (id)titleTextFieldZeroWidthConstraint;
- (void)setTitleTextFieldZeroWidthConstraint:(id)arg1;
- (BOOL)hovering;
- (id)normalBackgroundColor;
- (void)setNormalBackgroundColor:(id)arg1;
- (id)hoverBackgroundColor;
- (void)setHoverBackgroundColor:(id)arg1;
- (id)selectedBackgroundColor;
- (void)setSelectedBackgroundColor:(id)arg1;
- (id)textColor;
- (void)setTextColor:(id)arg1;

@end

#endif /* CXFlatButton_h */
