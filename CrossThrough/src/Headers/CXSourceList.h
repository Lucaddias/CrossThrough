// CXSourceList.h — CrossThrough
#ifndef CXSourceList_h
#define CXSourceList_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXSourceList;

@interface CXSourceList : NSOutlineView

// Instance Methods
- (NSRect)frameOfCellAtColumn:(NSInteger)arg1 row:(NSInteger)arg2;
- (BOOL)validateProposedFirstResponder:(id)arg1 forEvent:(id)arg2;

@end

#endif /* CXSourceList_h */
