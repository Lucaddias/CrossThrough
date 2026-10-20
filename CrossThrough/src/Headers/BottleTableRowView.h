// BottleTableRowView.h — CrossThrough
#ifndef BottleTableRowView_h
#define BottleTableRowView_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class BottleTableRowView;

@interface BottleTableRowView : NSTableRowView

// Instance Methods
- (void)drawRect:(NSRect)arg1;
- (BOOL)isEmphasized;

@end

#endif /* BottleTableRowView_h */
