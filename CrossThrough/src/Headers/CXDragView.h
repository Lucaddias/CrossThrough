// CXDragView.h — CrossThrough
#ifndef CXDragView_h
#define CXDragView_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXDragView;

@interface CXDragView : NSView
{
    id _delegate;
}

// Instance Methods
- (NSUInteger)draggingEntered:(id)arg1;
- (BOOL)performDragOperation:(id)arg1;
- (id)delegate;
- (void)setDelegate:(id)arg1;

@end

#endif /* CXDragView_h */
