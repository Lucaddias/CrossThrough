// SummaryDetail.h — CrossThrough
#ifndef SummaryDetail_h
#define SummaryDetail_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class SummaryDetail;

@interface SummaryDetail : CXObject
{
    NSInteger _type;
    NSString * _label;
    SEL _action;
    NSImage * _image;
}

// Class Methods
+ (id)detailWithType:(NSInteger)arg1 label:(id)arg2 action:(SEL)arg3;

// Instance Methods
- (NSInteger)type;
- (void)setType:(NSInteger)arg1;
- (id)label;
- (void)setLabel:(id)arg1;
- (SEL)action;
- (void)setAction:(SEL)arg1;
- (id)image;
- (void)setImage:(id)arg1;

@end

#endif /* SummaryDetail_h */
