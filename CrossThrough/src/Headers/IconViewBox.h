// IconViewBox.h — CrossThrough
#ifndef IconViewBox_h
#define IconViewBox_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class IconViewBox;
@class IconViewItem;

@interface IconViewBox : NSBox
{
    NSTextField * _auxField;
    IconViewItem * _item;
}

// Instance Methods
- (void)dealloc;
- (id)pathForIconHighlight;
- (id)pathForLabelHighlight;
- (id)menuForEvent:(id)arg1;
- (id)hitTest:(NSPoint)arg1;
- (BOOL)isHighlighted;
- (void)drawRect:(NSRect)arg1;
- (void)updateLabelTextColor;
- (void)viewDidMoveToWindow;
- (void)viewWillMoveToWindow:(id)arg1;
- (BOOL)hasDarkModeApppearance;
- (void)keyStatusDidChange;
- (void)rightMouseDown:(id)arg1;
- (id)auxField;
- (void)setAuxField:(id)arg1;
- (id)item;
- (void)setItem:(id)arg1;

@end

#endif /* IconViewBox_h */
