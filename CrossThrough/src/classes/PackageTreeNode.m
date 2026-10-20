// PackageTreeNode.m — CrossThrough
#import "PackageTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static NSImage *_starImg = nil;
static NSImage *_starOutlineImg = nil;
static NSImage *_untrustedImg = nil;
static NSImage *_defIcon = nil;

@implementation PackageTreeNode

+ (id)keyPathsForValuesAffectingCountString {
    return [NSSet setWithObject:@"totalChildren"];
}

+ (id)ratingImageWithName:(id)arg1 {
    NSImage *img = [NSImage imageNamed:arg1];
    if (!img) {
        img = [NSImage imageWithSystemSymbolName:arg1 accessibilityDescription:nil];
    }
    return img;
}

+ (id)untrustedRatingImage {
    if (!_untrustedImg) {
        _untrustedImg = [[NSImage imageNamed:@"sf-symbols.exclamationmark.circle.fill"] retain];
        if (!_untrustedImg) {
            _untrustedImg = [[NSImage imageWithSystemSymbolName:@"exclamationmark.circle.fill" accessibilityDescription:nil] retain];
        }
    }
    return _untrustedImg;
}

+ (id)starRatingImage {
    if (!_starImg) {
        _starImg = [[NSImage imageNamed:@"sf-symbols.star.fill-yellow"] retain];
        if (!_starImg) {
            _starImg = [[NSImage imageWithSystemSymbolName:@"star.fill" accessibilityDescription:nil] retain];
        }
    }
    return _starImg;
}

+ (id)starOutlineRatingImage {
    if (!_starOutlineImg) {
        _starOutlineImg = [[NSImage imageNamed:@"sf-symbols.star"] retain];
        if (!_starOutlineImg) {
            _starOutlineImg = [[NSImage imageWithSystemSymbolName:@"star" accessibilityDescription:nil] retain];
        }
    }
    return _starOutlineImg;
}

+ (id)tooltipForRating:(NSInteger)arg1 {
    switch (arg1) {
        case 5: return @"Runs Great";
        case 4: return @"Runs Well";
        case 3: return @"Limited Functionality";
        case 2: return @"Limited Functionality";
        case 1: return @"Does Not Run";
        default: return @"Unrated";
    }
}

+ (id)keyPathsForValuesAffectingTotalChildren {
    return [NSSet setWithObject:@"children"];
}

+ (id)keyPathsForValuesAffectingUnknown {
    return [NSSet setWithObject:@"packageid"];
}

static IconUtils * s_iconUtils = nil;

+ (void)updateIconList {
    if (!s_iconUtils) {
        Class cls = [CXSetupLib iconUtilsClass];
        if (cls) {
            s_iconUtils = [[cls alloc] init];
        }
    }
    if ([s_iconUtils respondsToSelector:@selector(fetchIconList)]) {
        [s_iconUtils fetchIconList];
    }
}

+ (id)defaultIcon {
    if (!_defIcon) {
        _defIcon = [[NSWorkspace sharedWorkspace] iconForFileType:NSFileTypeForHFSTypeCode(kGenericApplicationIcon)];
        if (_defIcon) [_defIcon retain];
    }
    return _defIcon;
}

- (id)initRootWithChildren:(id)arg1 {
    self = [super init];
    if (self) {
        self->packageid = [@"root" copy];
        self->_softwarePackage = [@"root" copy];
        self->children = arg1 ? [arg1 mutableCopy] : [[NSMutableArray alloc] init];
        self->unfilteredChildren = [self->children mutableCopy];
    }
    return self;
}

- (id)initWithProfile:(id)arg1 {
    self = [super init];
    if (self) {
        self->packageobject = [arg1 retain];
        if ([arg1 isKindOfClass:[NSDictionary class]] || [arg1 respondsToSelector:@selector(valueForKey:)]) {
            self->packageid = [[arg1 valueForKey:@"appid"] copy];
            self->_softwarePackage = [[arg1 valueForKey:@"name"] copy];
        }
        self->children = [[NSMutableArray alloc] init];
        self->unfilteredChildren = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCategoryID:(id)arg1 name:(id)arg2 children:(id)arg3 sortKey:(id)arg4 {
    self = [super init];
    if (self) {
        self->packageid = [arg1 copy];
        self->_softwarePackage = [arg2 copy];
        self->children = arg3 ? [arg3 mutableCopy] : [[NSMutableArray alloc] init];
        self->unfilteredChildren = [self->children mutableCopy];
        self->sortkey = [arg4 copy];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    PackageTreeNode *copy = [[[self class] allocWithZone:zone] init];
    copy->packageid = [self->packageid copy];
    copy->packageobject = [self->packageobject retain];
    copy->_softwarePackage = [self->_softwarePackage copy];
    copy->children = [self->children mutableCopy];
    copy->unfilteredChildren = [self->unfilteredChildren mutableCopy];
    copy->_icon = [self->_icon retain];
    copy->_ratingDescription = [self->_ratingDescription copy];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [self copyWithZone:zone];
}

- (void)dealloc {
    // dealloc
}

- (id)packageid {
    return self->packageid;
}

- (id)packageobject {
    return self->packageobject;
}

- (id)countString {
    return [NSString stringWithFormat:@"%lu", (unsigned long)[self->children count]];
}

- (id)description {
    return self->description;
}

- (id)descriptionFont {
    return self->_descriptionFont;
}

- (id)c4pPage {
    return self->c4pPage;
}

- (id)homePage {
    return self->homePage;
}

- (id)homePageDescription {
    return self->homePageDescription;
}

- (id)medaldatemessage {
    return self->medaldatemessage;
}

- (id)ratingImageForIndex:(NSUInteger)arg1 {
    NSInteger rating = 5;
    if (self->packageobject && [self->packageobject respondsToSelector:@selector(valueForKeyPath:)]) {
        id rVal = [self->packageobject valueForKeyPath:@"app_profile.medal_rating"];
        if (rVal && [rVal respondsToSelector:@selector(integerValue)]) {
            rating = [rVal integerValue];
        }
    }
    if (arg1 < (NSUInteger)rating) {
        return [PackageTreeNode starRatingImage];
    } else {
        return [PackageTreeNode starOutlineRatingImage];
    }
}

- (id)ratingImage1 { return [self ratingImageForIndex:0]; }
- (id)ratingImage2 { return [self ratingImageForIndex:1]; }
- (id)ratingImage3 { return [self ratingImageForIndex:2]; }
- (id)ratingImage4 { return [self ratingImageForIndex:3]; }
- (id)ratingImage5 { return [self ratingImageForIndex:4]; }

- (id)ratingTooltip {
    if (!self->_ratingTooltip) {
        NSInteger rating = 5;
        if (self->packageobject && [self->packageobject respondsToSelector:@selector(valueForKeyPath:)]) {
            id rVal = [self->packageobject valueForKeyPath:@"app_profile.medal_rating"];
            if (rVal && [rVal respondsToSelector:@selector(integerValue)]) {
                rating = [rVal integerValue];
            }
        }
        self->_ratingTooltip = [[PackageTreeNode tooltipForRating:rating] copy];
    }
    return self->_ratingTooltip;
}

- (id)ratingDescription {
    if (!self->_ratingDescription) {
        NSInteger rating = 5;
        if (self->packageobject && [self->packageobject respondsToSelector:@selector(valueForKeyPath:)]) {
            id rVal = [self->packageobject valueForKeyPath:@"app_profile.medal_rating"];
            if (rVal && [rVal respondsToSelector:@selector(integerValue)]) {
                rating = [rVal integerValue];
            }
        }
        self->_ratingDescription = [[PackageTreeNode tooltipForRating:rating] copy];
    }
    return self->_ratingDescription;
}

- (id)children {
    return self->children;
}

- (void)insertChildren:(id)arg1 atIndexes:(id)arg2 {
    [self->children insertObjects:arg1 atIndexes:arg2];
}

- (void)removeChildrenAtIndexes:(id)arg1 {
    [self->children removeObjectsAtIndexes:arg1];
}

- (id)unfilteredChildren {
    return self->unfilteredChildren;
}

- (void)insertObject:(id)arg1 inUnfilteredChildrenAtIndex:(NSUInteger)arg2 {
    [self->unfilteredChildren insertObject:arg1 atIndex:arg2];
}

- (void)insertUnfilteredChildren:(id)arg1 atIndexes:(id)arg2 {
    [self->unfilteredChildren insertObjects:arg1 atIndexes:arg2];
}

- (void)removeObjectFromUnfilteredChildrenAtIndex:(NSUInteger)arg1 {
    [self->unfilteredChildren removeObjectAtIndex:arg1];
}

- (void)removeUnfilteredChildrenAtIndexes:(id)arg1 {
    [self->unfilteredChildren removeObjectsAtIndexes:arg1];
}

- (void)removeAllLeaves {
    [self->children removeAllObjects];
}

- (void)replaceAllLeavesWithNewChildren:(id)arg1 {
    [self->children setArray:arg1];
}

- (void)startObservingChildren {
}

- (void)stopObservingChildren {
}

- (BOOL)leaf {
    return [self->children count] == 0;
}

- (id)sortkey {
    return self->sortkey ?: self->_softwarePackage;
}

- (NSUInteger)totalChildren {
    return [self->children count];
}

- (BOOL)isUnknown {
    if (self->packageobject && [self->packageobject respondsToSelector:@selector(valueForKeyPath:)]) {
        id val = [self->packageobject valueForKeyPath:@"is_unknown"];
        if (val && [val respondsToSelector:@selector(boolValue)]) {
            return [val boolValue];
        }
    }
    return [self->packageid isEqualToString:@"unknown"];
}

- (BOOL)isComponent {
    if (self->packageobject && [self->packageobject respondsToSelector:@selector(valueForKeyPath:)]) {
        id val = [self->packageobject valueForKeyPath:@"is_component"];
        if (val && [val respondsToSelector:@selector(boolValue)]) {
            return [val boolValue];
        }
    }
    return NO;
}

- (BOOL)isHighlighted {
    if (self->packageobject && [self->packageobject respondsToSelector:@selector(valueForKeyPath:)]) {
        id val = [self->packageobject valueForKeyPath:@"is_highlighted"];
        if (val && [val respondsToSelector:@selector(boolValue)]) {
            return [val boolValue];
        }
    }
    return NO;
}

- (BOOL)highlighted {
    return [self isHighlighted];
}

- (BOOL)isRanked {
    if (self->packageobject && [self->packageobject respondsToSelector:@selector(valueForKeyPath:)]) {
        id val = [self->packageobject valueForKeyPath:@"is_ranked"];
        if (val && [val respondsToSelector:@selector(boolValue)]) {
            return [val boolValue];
        }
    }
    return YES;
}

- (BOOL)ranked {
    return [self isRanked];
}

- (void)filterWithPredicate:(id)arg1 {
    [self filterWithPredicate:arg1 keepEmptyCategories:NO];
}

- (void)filterWithPredicate:(id)arg1 keepEmptyCategories:(BOOL)arg2 {
    if (arg1) {
        [self->children setArray:[self->unfilteredChildren filteredArrayUsingPredicate:arg1]];
    } else {
        [self->children setArray:self->unfilteredChildren];
    }
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
}

- (void)loadIcon {
    if (self->_icon && self->_icon != [PackageTreeNode defaultIcon]) return;
    if (!s_iconUtils) {
        Class cls = [CXSetupLib iconUtilsClass];
        if (cls) {
            s_iconUtils = [[cls alloc] init];
        }
    }
    if (s_iconUtils && self->packageid) {
        if ([s_iconUtils respondsToSelector:@selector(fetchIcon:)]) {
            [s_iconUtils fetchIcon:self->packageid];
        }
        if ([s_iconUtils respondsToSelector:@selector(getIconPath:)]) {
            NSString *iconPath = [s_iconUtils getIconPath:self->packageid];
            if (iconPath && [[NSFileManager defaultManager] fileExistsAtPath:iconPath]) {
                NSImage *img = [[NSImage alloc] initWithContentsOfFile:iconPath];
                if (img) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self setIcon:img];
                        [img release];
                    });
                    return;
                }
            }
        }
    }
}

- (id)softwarePackage {
    return self->_softwarePackage ?: self->packageid;
}

- (void)setSoftwarePackage:(id)arg1 {
    if (self->_softwarePackage != arg1) {
        self->_softwarePackage = [arg1 copy];
    }
}

- (id)localizedNames {
    return self->_localizedNames;
}

- (void)setDescriptionFont:(id)arg1 {
    self->_descriptionFont = arg1;
}

- (id)container {
    return objc_loadWeakRetained((id *)&self->_container);
}

- (void)setContainer:(id)arg1 {
    objc_storeWeak((id *)&self->_container, arg1);
}

- (id)icon {
    if (!self->_icon || self->_icon == [PackageTreeNode defaultIcon]) {
        [self loadIcon];
    }
    return self->_icon ?: [PackageTreeNode defaultIcon];
}

- (void)setIcon:(id)arg1 {
    [self willChangeValueForKey:@"icon"];
    if (self->_icon != arg1) {
        [self->_icon release];
        self->_icon = [arg1 retain];
    }
    [self didChangeValueForKey:@"icon"];
}

@end
