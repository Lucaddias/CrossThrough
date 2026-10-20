// CXSourceList.m — CrossThrough
#import "CXSourceList.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXSourceList

- (NSRect)frameOfCellAtColumn:(NSInteger)arg1 row:(NSInteger)arg2 {
    NSRect r = [super frameOfCellAtColumn:arg1 row:arg2];
    r.size.width = [self frame].size.width;
    return r;
}

- (BOOL)validateProposedFirstResponder:(id)arg1 forEvent:(id)arg2 {
    if ([arg1 isKindOfClass:[NSTextField class]] && [(NSEvent *)arg2 type] == NSEventTypeLeftMouseDown) {
        return NO;
    }
    return [super validateProposedFirstResponder:arg1 forEvent:arg2];
}

@end
