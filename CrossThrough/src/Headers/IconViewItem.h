// IconViewItem.h — CrossThrough
#ifndef IconViewItem_h
#define IconViewItem_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class IconViewItem;

@interface IconViewItem : NSCollectionViewItem

// Instance Methods
- (void)setRepresentedObject:(id)arg1;
- (void)setSelected:(BOOL)arg1;
- (void)setHighlightState:(NSInteger)arg1;
- (id)draggingImageComponents;

@end

#endif /* IconViewItem_h */
