// CXFlatPopUpButton.h — CrossThrough
#ifndef CXFlatPopUpButton_h
#define CXFlatPopUpButton_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXFlatPopUpButton;

@interface CXFlatPopUpButton : NSPopUpButton
{
    BOOL _hovering;
    BOOL _selected;
    NSColor * _normalBackgroundColor;
    NSColor * _hoverBackgroundColor;
    NSColor * _selectedBackgroundColor;
}

// Instance Methods
- (id)initWithFrame:(NSRect)arg1;
- (id)initWithCoder:(id)arg1;
- (void)finishInit;
- (void)updateColors;
- (void)viewDidChangeEffectiveAppearance;
- (void)updateBackgroundColorForCurrentState;
- (void)setHovering:(BOOL)arg1;
- (void)highlight:(BOOL)arg1;
- (void)setHighlighted:(BOOL)arg1;
- (void)setEnabled:(BOOL)arg1;
- (void)updateTrackingAreas;
- (void)mouseEntered:(id)arg1;
- (void)mouseExited:(id)arg1;
- (void)mouseDown:(id)arg1;
- (id)addItemWithTitle:(id)arg1 toolTip:(id)arg2;
- (id)normalBackgroundColor;
- (void)setNormalBackgroundColor:(id)arg1;
- (id)hoverBackgroundColor;
- (void)setHoverBackgroundColor:(id)arg1;
- (id)selectedBackgroundColor;
- (void)setSelectedBackgroundColor:(id)arg1;
- (BOOL)hovering;
- (BOOL)selected;
- (void)setSelected:(BOOL)arg1;

@end

#endif /* CXFlatPopUpButton_h */
