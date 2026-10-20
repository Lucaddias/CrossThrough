// PackageViewItem.h — CrossThrough
#ifndef PackageViewItem_h
#define PackageViewItem_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class PackageViewItem;

@interface PackageViewItem : NSCollectionViewItem
{
    NSBox * _dividerLine;
}

// Instance Methods
- (id)init;
- (id)dividerLine;
- (void)setDividerLine:(id)arg1;

@end

#endif /* PackageViewItem_h */
