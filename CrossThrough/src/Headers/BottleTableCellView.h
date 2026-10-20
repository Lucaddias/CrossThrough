// BottleTableCellView.h — CrossThrough
#ifndef BottleTableCellView_h
#define BottleTableCellView_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class BottleTableCellView;

@interface BottleTableCellView : NSTableCellView
{
    BOOL _observing;
    NSButton * _needsUpgradeButton;
}

// Instance Methods
- (void)dealloc;
- (void)awakeFromNib;
- (void)setBackgroundStyle:(NSInteger)arg1;
- (void)updateTextField;
- (void)viewWillDraw;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (id)needsUpgradeButton;
- (void)setNeedsUpgradeButton:(id)arg1;

@end

#endif /* BottleTableCellView_h */
