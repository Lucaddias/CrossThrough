// LauncherItem.h — CrossThrough
#ifndef LauncherItem_h
#define LauncherItem_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class LauncherItem;

@interface LauncherItem : CXObject <NSCopying>
{
    NSString * _name;
}

// Instance Methods
- (id)init;
- (id)initWithName:(id)arg1;
- (id)copyWithZone:(void *)arg1;
- (id)icon;
- (id)bottle;
- (BOOL)isLeaf;
- (id)tooltip;
- (id)description;
- (id)name;
- (void)setName:(id)arg1;

@end

#endif /* LauncherItem_h */
