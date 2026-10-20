// CXRatioTextField.h — CrossThrough
#ifndef CXRatioTextField_h
#define CXRatioTextField_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXRatioTextField;

@interface CXRatioTextField : NSTextField
{
    NSSize _cachedIntrinsicContentSize;
    CGFloat _maxAspectRatio;
}

// Instance Methods
- (id)initWithCoder:(id)arg1;
- (id)initWithFrame:(NSRect)arg1;
- (NSSize)intrinsicContentSize;
- (void)invalidateIntrinsicContentSize;
- (void)invalidateIntrinsicContentSizeForCell:(id)arg1;
- (CGFloat)maxAspectRatio;
- (void)setMaxAspectRatio:(CGFloat)arg1;

@end

#endif /* CXRatioTextField_h */
