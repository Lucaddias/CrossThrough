// PackageTreeNode.h — CrossThrough
#ifndef PackageTreeNode_h
#define PackageTreeNode_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class PackageTreeNode;

@interface PackageTreeNode : CXObject <NSCopying, NSMutableCopying>
{
    NSString * packageid;
    id packageobject;
    NSAttributedString * description;
    NSString * c4pPage;
    NSString * homePage;
    NSString * homePageDescription;
    NSString * medaldatemessage;
    NSMutableArray * children;
    NSMutableArray * unfilteredChildren;
    NSString * sortkey;
    id _ratingImages;
    NSString * _ratingDescription;
    NSString * _ratingTooltip;
    NSString * _softwarePackage;
    NSArray * _localizedNames;
    NSFont * _descriptionFont;
    PackageTreeNode * _container;
    NSImage * _icon;
}

// Class Methods
+ (id)keyPathsForValuesAffectingCountString;
+ (id)ratingImageWithName:(id)arg1;
+ (id)untrustedRatingImage;
+ (id)starRatingImage;
+ (id)starOutlineRatingImage;
+ (id)tooltipForRating:(NSInteger)arg1;
+ (id)keyPathsForValuesAffectingTotalChildren;
+ (id)keyPathsForValuesAffectingUnknown;
+ (void)updateIconList;
+ (id)defaultIcon;

// Instance Methods
- (id)initRootWithChildren:(id)arg1;
- (id)initWithProfile:(id)arg1;
- (id)initWithCategoryID:(id)arg1 name:(id)arg2 children:(id)arg3 sortKey:(id)arg4;
- (id)copyWithZone:(void *)arg1;
- (id)mutableCopyWithZone:(void *)arg1;
- (void)dealloc;
- (id)packageid;
- (id)packageobject;
- (id)countString;
- (id)description;
- (id)descriptionFont;
- (id)c4pPage;
- (id)homePage;
- (id)homePageDescription;
- (id)medaldatemessage;
- (id)ratingImageForIndex:(NSUInteger)arg1;
- (id)ratingImage1;
- (id)ratingImage2;
- (id)ratingImage3;
- (id)ratingImage4;
- (id)ratingImage5;
- (id)ratingTooltip;
- (id)ratingDescription;
- (id)children;
- (void)insertChildren:(id)arg1 atIndexes:(id)arg2;
- (void)removeChildrenAtIndexes:(id)arg1;
- (id)unfilteredChildren;
- (void)insertObject:(id)arg1 inUnfilteredChildrenAtIndex:(NSUInteger)arg2;
- (void)insertUnfilteredChildren:(id)arg1 atIndexes:(id)arg2;
- (void)removeObjectFromUnfilteredChildrenAtIndex:(NSUInteger)arg1;
- (void)removeUnfilteredChildrenAtIndexes:(id)arg1;
- (void)removeAllLeaves;
- (void)replaceAllLeavesWithNewChildren:(id)arg1;
- (void)startObservingChildren;
- (void)stopObservingChildren;
- (BOOL)leaf;
- (id)sortkey;
- (NSUInteger)totalChildren;
- (BOOL)isUnknown;
- (BOOL)isComponent;
- (BOOL)isHighlighted;
- (BOOL)highlighted;
- (BOOL)isRanked;
- (BOOL)ranked;
- (void)filterWithPredicate:(id)arg1;
- (void)filterWithPredicate:(id)arg1 keepEmptyCategories:(BOOL)arg2;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (void)loadIcon;
- (id)softwarePackage;
- (void)setSoftwarePackage:(id)arg1;
- (id)localizedNames;
- (void)setDescriptionFont:(id)arg1;
- (id)container;
- (void)setContainer:(id)arg1;
- (id)icon;
- (void)setIcon:(id)arg1;

@end

#endif /* PackageTreeNode_h */
