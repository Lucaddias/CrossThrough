// IconCollectionView.h — CrossThrough
#ifndef IconCollectionView_h
#define IconCollectionView_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class IconCollectionView;

@interface IconCollectionView : NSCollectionView
{
    BOOL _isFirstResponder;
}

// Instance Methods
- (BOOL)acceptsFirstResponder;
- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (void)keyDown:(id)arg1;
- (void)mouseDown:(id)arg1;
- (BOOL)isFirstResponder;
- (void)setIsFirstResponder:(BOOL)arg1;

@end

#endif /* IconCollectionView_h */
