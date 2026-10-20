// PackageTreeNode.m — CrossThrough
#import "PackageTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PackageTreeNode

+ (id)keyPathsForValuesAffectingCountString {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"totalChildren"];
     *   return r0;
     */
    return nil;
}

+ (id)ratingImageWithName:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSImage imageNamed:arg2];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [r0 copy];
     *   [r19 release];
     *   [r20 size];
     *   [r20 size];
     *   [r20 setSize:r2];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)untrustedRatingImage {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   if (*_untrustedRatingImage.untrustedRatingImage == 0x0) {
     *   r0 = [r0 ratingImageWithName:@"sf-symbols.exclamationmark.circle.fill"];
     *   r0 = [r0 retain];
     *   r8 = *_untrustedRatingImage.untrustedRatingImage;
     *   *_untrustedRatingImage.untrustedRatingImage = r0;
     *   [r8 release];
     *   }
     *   r0 = objc_retainAutoreleaseReturnValue(*_untrustedRatingImage.untrustedRatingImage);
     *   return r0;
     */
    return nil;
}

+ (id)starRatingImage {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   if (*_starRatingImage.starRatingImage == 0x0) {
     *   r0 = [r0 ratingImageWithName:@"sf-symbols.star.fill-yellow"];
     *   r0 = [r0 retain];
     *   r8 = *_starRatingImage.starRatingImage;
     *   *_starRatingImage.starRatingImage = r0;
     *   [r8 release];
     *   }
     *   r0 = objc_retainAutoreleaseReturnValue(*_starRatingImage.starRatingImage);
     *   return r0;
     */
    return nil;
}

+ (id)starOutlineRatingImage {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   if (*_starOutlineRatingImage.starOutlineRatingImage == 0x0) {
     *   r0 = [r0 ratingImageWithName:@"sf-symbols.star"];
     *   r0 = [r0 retain];
     *   r8 = *_starOutlineRatingImage.starOutlineRatingImage;
     *   *_starOutlineRatingImage.starOutlineRatingImage = r0;
     *   [r8 release];
     *   }
     *   r0 = objc_retainAutoreleaseReturnValue(*_starOutlineRatingImage.starOutlineRatingImage);
     *   return r0;
     */
    return nil;
}

+ (id)tooltipForRating:(NSInteger)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r8 = *_tooltipForRating:.tooltips;
     *   if (*_tooltipForRating:.tooltips == 0x0) {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r0 = [r0 localizedStringForKey:@"This installation recipe is from an unknown source. Installing may pose a security risk to your system." value:@"" table:0x0];
     *   r0 = [r0 retain];
     *   r8 = *_tooltipForRating:.tooltips;
     *   *_tooltipForRating:.tooltips = r0;
     *   [r8 release];
     *   [r21 release];
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r0 = [r0 localizedStringForKey:@"No ratings have been reported.\n\nAll application entries start at this rating. Over time staff and users can visit the App Compatibility page of the CodeWeavers website and rate how far they got in running this Windows application in CrossOver. If you try t…" value:@"" table:0x0];
     *   r0 = [r0 retain];
     *   ... (55 more lines)
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingTotalChildren {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"children"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingUnknown {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"packageid"];
     *   return r0;
     */
    return nil;
}

+ (void)updateIconList {
    return;
}

+ (id)defaultIcon {
    /*
     * Decompiled from CrossOver 26.3:
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r31 = r31 + 0xfffffffffffffff0;
     *   if (*_defaultIcon.onceToken != -0x1) {
     *   dispatch_once(_defaultIcon.onceToken, ___block_literal_global);
     *   }
     *   r0 = *_defaultIcon.icon;
     *   r0 = objc_retainAutoreleaseReturnValue(r0);
     *   return r0;
     */
    return nil;
}

- (id)initRootWithChildren:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)initWithProfile:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)initWithCategoryID:(id)arg1 name:(id)arg2 children:(id)arg3 sortKey:(id)arg4 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)copyWithZone:(void *)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = arg2;
     *   r20 = self;
     *   r19 = [[objc_opt_class(self) allocWithZone:r21] init];
     *   r22 = sign_extend_64(*(int32_t *)ivar_offset(packageid));
     *   r0 = *(r20 + r22);
     *   r0 = [r0 copyWithZone:r21];
     *   r8 = *(r19 + r22);
     *   *(r19 + r22) = r0;
     *   [r8 release];
     *   r8 = sign_extend_64(*(int32_t *)ivar_offset(packageobject));
     *   objc_storeStrong(r19 + r8, *(r20 + r8));
     *   r22 = sign_extend_64(*(int32_t *)ivar_offset(_softwarePackage));
     *   r0 = *(r20 + r22);
     *   r0 = [r0 copyWithZone:r21];
     *   r8 = *(r19 + r22);
     *   *(r19 + r22) = r0;
     *   ... (71 more lines)
     */
    return nil;
}

- (id)mutableCopyWithZone:(void *)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self copyWithZone:arg2];
     *   return r0;
     */
    return nil;
}

- (void)dealloc {
    return;
}

- (id)packageid {
    return self->packageid;
}

- (id)packageobject {
    return self->packageobject;
}

- (id)countString {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   r31 = r31 - 0x40;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   if (*(r0 + sign_extend_64(*(int32_t *)ivar_offset(children))) != 0x0) {
     *   r0 = [r0 totalChildren];
     *   r19 = r0;
     *   if (r0 != 0x1) {
     *   if (r19 == 0x0) {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r2 = @"0 items";
     *   }
     *   else {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r2 = @"%u items";
     *   }
     *   }
     *   ... (16 more lines)
     */
    return nil;
}

- (id)description {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r24 = sign_extend_64(*(int32_t *)ivar_offset(description));
     *   r0 = *(self + r24);
     *   if (r0 == 0x0) {
     *   r0 = r19->packageobject;
     *   if (r0 != 0x0) {
     *   r0 = [r0 valueForKey:@"app_profile"];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r22 = [[r0 valueForKey:@"description"] retain];
     *   r23 = [[r19 descriptionFont] retain];
     *   r0 = [NSAttributedString cx_attributedStringWithHTML:r22 font:r23];
     *   r0 = [r0 retain];
     *   r8 = *(r19 + r24);
     *   *(r19 + r24) = r0;
     *   [r8 release];
     *   ... (8 more lines)
     */
    return nil;
}

- (id)descriptionFont {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r21 = sign_extend_64(*(int32_t *)ivar_offset(_descriptionFont));
     *   r0 = *(self + r21);
     *   if (r0 == 0x0) {
     *   [NSFont labelFontSize];
     *   r0 = [NSFont labelFontOfSize:r2];
     *   r0 = [r0 retain];
     *   r8 = *(r19 + r21);
     *   *(r19 + r21) = r0;
     *   [r8 release];
     *   r0 = *(r19 + r21);
     *   }
     *   r0 = objc_retainAutoreleaseReturnValue(r0);
     *   return r0;
     */
    return nil;
}

- (id)c4pPage {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r21 = sign_extend_64(*(int32_t *)ivar_offset(c4pPage));
     *   r0 = *(self + r21);
     *   if (r0 == 0x0) {
     *   r0 = r19->packageobject;
     *   if (r0 != 0x0) {
     *   r0 = [r0 valueForKey:@"details_url"];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 copy];
     *   r8 = *(r19 + r21);
     *   *(r19 + r21) = r0;
     *   [r8 release];
     *   [r20 release];
     *   r0 = *(r19 + r21);
     *   }
     *   }
     *   r0 = objc_retainAutoreleaseReturnValue(r0);
     *   ... (1 more lines)
     */
    return nil;
}

- (id)homePage {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r23 = sign_extend_64(*(int32_t *)ivar_offset(homePage));
     *   r0 = *(self + r23);
     *   if (r0 == 0x0) {
     *   r0 = r19->packageobject;
     *   if (r0 != 0x0) {
     *   r0 = [r0 valueForKeyPath:@"app_profile.download_page_urls"];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [CXSetupLib cxUtilsClass];
     *   r0 = [r0 getLanguageValue:r20 forLanguage:0x0];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r0 = [r0 objectAtIndex:0x1];
     *   r0 = [r0 retain];
     *   ... (14 more lines)
     */
    return nil;
}

- (id)homePageDescription {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r21 = sign_extend_64(*(int32_t *)ivar_offset(homePageDescription));
     *   if (*(self + r21) == 0x0) {
     *   r22 = sign_extend_64(*(int32_t *)ivar_offset(homePage));
     *   if ([*(r19 + r22) length] != 0x0) {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 localizedStringForKey:@"This software can be downloaded from its <a href=\"%@\">home page</a>." value:@"" table:0x0];
     *   r0 = [r0 retain];
     *   r8 = *(r19 + r21);
     *   *(r19 + r21) = r0;
     *   [r8 release];
     *   [r20 release];
     *   r0 = [NSString alloc];
     *   r0 = [r0 initWithFormat:*(r19 + r21)];
     *   }
     *   else {
     *   ... (9 more lines)
     */
    return nil;
}

- (id)medaldatemessage {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0xa0;
     *   var_50 = r28;
     *   decomp_var_48 = r27;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r26 = sign_extend_64(*(int32_t *)ivar_offset(medaldatemessage));
     *   r0 = *(self + r26);
     *   if (r0 != 0x0) {
     *   r0 = [r0 retain];
     *   r0 = [r0 autorelease];
     *   }
     *   else {
     *   r21 = sign_extend_64(*(int32_t *)ivar_offset(packageobject));
     *   r0 = *(r19 + r21);
     *   if (r0 != 0x0) {
     *   r0 = [r0 valueForKeyPath:@"app_profile.medal_version"];
     *   ... (257 more lines)
     */
    return nil;
}

- (id)ratingImageForIndex:(NSUInteger)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = arg2;
     *   r23 = (int64_t *)&r0->_ratingImages;
     *   if (*r23 == 0x0) {
     *   r20 = r0;
     *   r0 = r0->packageobject;
     *   if (r0 != 0x0) {
     *   r0 = [r0 valueForKeyPath:@"app_profile.medal_rating"];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r21 = [r0 integerValue];
     *   [r22 release];
     *   r22 = 0x0;
     *   do {
     *   if ((r21 & 0xffffffff80000000) == 0x0) {
     *   r0 = objc_opt_class(r20);
     *   ... (31 more lines)
     */
    return nil;
}

- (id)ratingImage1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self ratingImageForIndex:0x0];
     *   return r0;
     */
    return nil;
}

- (id)ratingImage2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self ratingImageForIndex:0x1];
     *   return r0;
     */
    return nil;
}

- (id)ratingImage3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self ratingImageForIndex:0x2];
     *   return r0;
     */
    return nil;
}

- (id)ratingImage4 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self ratingImageForIndex:0x3];
     *   return r0;
     */
    return nil;
}

- (id)ratingImage5 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self ratingImageForIndex:0x4];
     *   return r0;
     */
    return nil;
}

- (id)ratingTooltip {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r22 = sign_extend_64(*(int32_t *)ivar_offset(_ratingTooltip));
     *   r0 = *(self + r22);
     *   if (r0 == 0x0) {
     *   r0 = r19->packageobject;
     *   if (r0 != 0x0) {
     *   r0 = [r0 valueForKeyPath:@"app_profile.medal_rating"];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 integerValue];
     *   [r20 release];
     *   r0 = objc_opt_class(r19);
     *   r0 = [r0 tooltipForRating:r21];
     *   r0 = [r0 retain];
     *   r8 = *(r19 + r22);
     *   *(r19 + r22) = r0;
     *   [r8 release];
     *   r0 = *(r19 + r22);
     *   ... (4 more lines)
     */
    return nil;
}

- (id)ratingDescription {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r22 = sign_extend_64(*(int32_t *)ivar_offset(_ratingDescription));
     *   if (*(self + r22) == 0x0) {
     *   r0 = r19->packageobject;
     *   if (r0 != 0x0) {
     *   r0 = [r0 valueForKeyPath:@"app_profile.medal_rating"];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [r0 integerValue];
     *   [r21 release];
     *   if (r20 <= 0x5) {
     *   index_0 = r20;
     *   switch (index_0) {
     *   case 0:
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r2 = @"Untested";
     *   ... (50 more lines)
     */
    return nil;
}

- (id)children {
    return self->children;
}

- (void)insertChildren:(id)arg1 atIndexes:(id)arg2 {
    return;
}

- (void)removeChildrenAtIndexes:(id)arg1 {
    return;
}

- (id)unfilteredChildren {
    return self->unfilteredChildren;
}

- (void)insertObject:(id)arg1 inUnfilteredChildrenAtIndex:(NSUInteger)arg2 {
    return;
}

- (void)insertUnfilteredChildren:(id)arg1 atIndexes:(id)arg2 {
    return;
}

- (void)removeObjectFromUnfilteredChildrenAtIndex:(NSUInteger)arg1 {
    return;
}

- (void)removeUnfilteredChildrenAtIndexes:(id)arg1 {
    return;
}

- (void)removeAllLeaves {
    return;
}

- (void)replaceAllLeavesWithNewChildren:(id)arg1 {
    return;
}

- (void)startObservingChildren {
    return;
}

- (void)stopObservingChildren {
    return;
}

- (BOOL)leaf {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   if (*(r0 + sign_extend_64(*(int32_t *)ivar_offset(children))) == 0x0) {
     *   r0 = 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (id)sortkey {
    return self->sortkey;
}

- (NSUInteger)totalChildren {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x120;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_48 = **___stack_chk_guard;
     *   r21 = sign_extend_64(*(int32_t *)ivar_offset(children));
     *   r19 = [*(self + r21) count];
     *   var_110 = q0;
     *   var_100 = q0;
     *   r0 = *(self + r21);
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
     *   if (r0 != 0x0) {
     *   r21 = r0;
     *   r24 = *var_100;
     *   do {
     *   r25 = 0x0;
     *   ... (24 more lines)
     */
    return 0;
}

- (BOOL)isUnknown {
    return self->packageid;
}

- (BOOL)isComponent {
    return self->packageobject;
}

- (BOOL)isHighlighted {
    return self->packageobject;
}

- (BOOL)isRanked {
    return self->packageobject;
}

- (void)filterWithPredicate:(id)arg1 {
    return;
}

- (void)filterWithPredicate:(id)arg1 keepEmptyCategories:(BOOL)arg2 {
    return;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (void)loadIcon {
    return;
}

- (id)softwarePackage {
    return self->_softwarePackage;
}

- (void)setSoftwarePackage:(id)arg1 {
    return;
}

- (id)localizedNames {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_localizedNames)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setDescriptionFont:(id)arg1 {
    return;
}

- (id)container {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_container);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setContainer:(id)arg1 {
    return;
}

- (id)icon {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_icon)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setIcon:(id)arg1 {
    return;
}

@end
