// CXFlippedClipView.h — CrossThrough
#ifndef CXFlippedClipView_h
#define CXFlippedClipView_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXFlippedClipView;

@interface CXFlippedClipView : NSClipView

// Instance Methods
- (BOOL)isFlipped;

@end

#endif /* CXFlippedClipView_h */
