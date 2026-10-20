// LauncherFolder.h — CrossThrough
#ifndef LauncherFolder_h
#define LauncherFolder_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherItem.h"

@class LauncherFolder;

@interface LauncherFolder : LauncherItem
{
    NSMutableArray * _items;
}

// Instance Methods
- (id)init;
- (id)initWithName:(id)arg1;
- (id)copyWithZone:(void *)arg1;
- (BOOL)isLeaf;
- (id)items;
- (void)setItems:(id)arg1;
- (void)insertObject:(id)arg1 inItemsAtIndex:(NSUInteger)arg2;
- (void)addLauncherItem:(id)arg1;
- (id)description;

@end

#endif /* LauncherFolder_h */
