// PackageTreeNode.m — CrossThrough
#import "PackageTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "NSAttributedString+CrossOverAdditions.h"

static void *PackageTreeNodeKVOContextDummy = &PackageTreeNodeKVOContextDummy;
static IconUtils *_iconUtils = nil;

@implementation PackageTreeNode

- (id)initRootWithChildren:(id)arg1 {
    self = [super init];
    if (self) {
        self->packageid = @"root";
        self->_softwarePackage = @"root";
        if (arg1 != nil) {
            self->children = [arg1 mutableCopy];
            for (PackageTreeNode *child in self->children) {
                [child setContainer:self];
            }
        } else {
            self->children = [[NSMutableArray alloc] init];
        }
        self->unfilteredChildren = [self->children mutableCopy];
        [self startObservingChildren];
    }
    return self;
}

- (id)initWithProfile:(id)arg1 {
    self = [super init];
    if (self) {
        self->packageid = [[arg1 valueForKey:@"appid"] copy];
        self->packageobject = [arg1 retain];
        self->_softwarePackage = [[arg1 valueForKey:@"name"] copy];

        // Keep the localized names for the user's languages (plus English) so searches match them.
        NSMutableSet *languages = [NSMutableSet setWithArray:[NSLocale preferredLanguages]];
        [languages addObject:@"en"];
        NSDictionary *names = [self->packageobject valueForKey:@"localized_names"];
        NSMutableArray *localizedNames = [[NSMutableArray alloc] init];
        for (NSString *language in names) {
            if ([languages containsObject:[NSLocale canonicalLanguageIdentifierFromString:language]]) {
                [localizedNames addObject:[names objectForKey:language]];
            }
        }
        self->_localizedNames = localizedNames;
        self->sortkey = [self->_softwarePackage copy];
        [self setIcon:[[self class] defaultIcon]];
    }
    return self;
}

- (id)initWithCategoryID:(id)arg1 name:(id)arg2 children:(id)arg3 sortKey:(id)arg4 {
    self = [super init];
    if (self) {
        self->packageid = [arg1 copy];
        self->_softwarePackage = [arg2 copy];
        if (arg3 != nil) {
            self->children = [arg3 mutableCopy];
            for (PackageTreeNode *child in self->children) {
                [child setContainer:self];
            }
        } else {
            self->children = [[NSMutableArray alloc] init];
        }
        self->unfilteredChildren = [self->children mutableCopy];
        self->sortkey = [arg4 copy];
        [self startObservingChildren];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    PackageTreeNode *copy = [[[self class] allocWithZone:zone] init];
    copy->packageid = [self->packageid copyWithZone:zone];
    copy->packageobject = [self->packageobject retain];
    copy->_softwarePackage = [self->_softwarePackage copyWithZone:zone];
    copy->_localizedNames = [self->_localizedNames copyWithZone:zone];
    copy->description = [self->description copyWithZone:zone];
    copy->_descriptionFont = [self->_descriptionFont copyWithZone:zone];
    copy->homePage = [self->homePage copyWithZone:zone];
    copy->homePageDescription = [self->homePageDescription copyWithZone:zone];
    copy->medaldatemessage = [self->medaldatemessage copyWithZone:zone];
    copy->_ratingDescription = [self->_ratingDescription copyWithZone:zone];
    // Children are not copied; the copy starts with empty containers of the same kind.
    if (self->children != nil) {
        copy->children = [[NSMutableArray allocWithZone:zone] init];
    }
    if (self->unfilteredChildren != nil) {
        copy->unfilteredChildren = [[NSMutableArray allocWithZone:zone] init];
    }
    copy->sortkey = [self->sortkey copyWithZone:zone];
    [copy setIcon:[self icon]];
    [copy startObservingChildren];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [self copyWithZone:zone];
}

- (void)dealloc {
    [self stopObservingChildren];
    for (PackageTreeNode *child in self->unfilteredChildren) {
        [child setContainer:nil];
    }
    [self->packageid release];
    [self->packageobject release];
    [self->description release];
    [self->c4pPage release];
    [self->homePage release];
    [self->homePageDescription release];
    [self->medaldatemessage release];
    [self->children release];
    [self->unfilteredChildren release];
    [self->sortkey release];
    for (NSUInteger i = 0; i < 5; i++) {
        [self->_ratingImages[i] release];
    }
    [self->_ratingDescription release];
    [self->_ratingTooltip release];
    [self->_softwarePackage release];
    [self->_localizedNames release];
    [self->_descriptionFont release];
    objc_destroyWeak((id *)&self->_container);
    [self->_icon release];
    [super dealloc];
}

- (id)packageid {
    return [[self->packageid retain] autorelease];
}

- (id)packageobject {
    return [[self->packageobject retain] autorelease];
}

+ (id)keyPathsForValuesAffectingCountString {
    return [NSSet setWithObject:@"totalChildren"];
}

- (id)countString {
    if (self->children == nil) {
        return nil;
    }
    NSUInteger count = [self totalChildren];
    NSString *format;
    if (count == 1) {
        format = [[NSBundle mainBundle] localizedStringForKey:@"1 item" value:@"" table:nil];
    } else if (count == 0) {
        format = [[NSBundle mainBundle] localizedStringForKey:@"0 items" value:@"" table:nil];
    } else {
        format = [[NSBundle mainBundle] localizedStringForKey:@"%u items" value:@"" table:nil];
    }
    return [NSString stringWithFormat:format, (unsigned)count];
}

- (id)description {
    if (self->description == nil && self->packageobject != nil) {
        NSString *html = [[self->packageobject valueForKey:@"app_profile"] valueForKey:@"description"];
        self->description = [[NSAttributedString cx_attributedStringWithHTML:html font:[self descriptionFont]] retain];
    }
    return [[self->description retain] autorelease];
}

- (id)descriptionFont {
    if (self->_descriptionFont == nil) {
        self->_descriptionFont = [[NSFont labelFontOfSize:[NSFont labelFontSize]] retain];
    }
    return [[self->_descriptionFont retain] autorelease];
}

- (id)c4pPage {
    if (self->c4pPage == nil && self->packageobject != nil) {
        self->c4pPage = [[self->packageobject valueForKey:@"details_url"] copy];
    }
    return [[self->c4pPage retain] autorelease];
}

- (id)homePage {
    if (self->homePage == nil && self->packageobject != nil) {
        id urls = [self->packageobject valueForKeyPath:@"app_profile.download_page_urls"];
        if (urls != nil) {
            // getLanguageValue returns a (language, value) pair.
            id localized = [[CXSetupLib cxUtilsClass] getLanguageValue:urls forLanguage:nil];
            self->homePage = [[localized objectAtIndex:1] copy];
        }
    }
    return [[self->homePage retain] autorelease];
}

- (id)homePageDescription {
    if (self->homePageDescription == nil) {
        if ([self->homePage length] != 0) {
            NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"This software can be downloaded from its <a href=\"%@\">home page</a>." value:@"" table:nil];
            self->homePageDescription = [[NSString alloc] initWithFormat:format, self->homePage];
        } else {
            self->homePageDescription = @"";
        }
    }
    return [[self->homePageDescription retain] autorelease];
}

// Parses an ISO 8601 medal date, accepting "Z", "+hhmm" and "+hh:mm" suffixes.
- (NSDate *)medalDateFromString:(NSString *)dateString {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [formatter setCalendar:gregorian];
    [gregorian release];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    id date = nil;
    NSRange range = NSMakeRange(0, [dateString length]);
    if (![formatter getObjectValue:&date forString:dateString range:&range error:NULL]) {
        return nil;
    }
    if (range.length >= [dateString length]) {
        return date;
    }
    if (range.length == [dateString length] - 1 && [dateString characterAtIndex:range.length] == 'Z') {
        return date;
    }

    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"];
    range = NSMakeRange(0, [dateString length]);
    date = nil;
    if (![formatter getObjectValue:&date forString:dateString range:&range error:NULL]) {
        return nil;
    }
    if (range.length >= [dateString length]) {
        return date;
    }
    if ([dateString characterAtIndex:range.length] == ':') {
        NSString *withoutColon = [dateString stringByReplacingCharactersInRange:NSMakeRange(range.length, 1) withString:@""];
        return [formatter dateFromString:withoutColon];
    }
    return nil;
}

- (id)medaldatemessage {
    if (self->medaldatemessage != nil || self->packageobject == nil) {
        return [[self->medaldatemessage retain] autorelease];
    }
    NSString *version = [self->packageobject valueForKeyPath:@"app_profile.medal_version"];
    if ([version length] == 0) {
        return nil;
    }

    NSString *dateString = [self->packageobject valueForKeyPath:@"app_profile.medal_date"];
    NSString *formattedDate = nil;
    if ([dateString length] != 0) {
        NSDate *date = [self medalDateFromString:dateString];
        if (date != nil) {
            NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
            [displayFormatter setTimeStyle:NSDateFormatterNoStyle];
            [displayFormatter setDateStyle:NSDateFormatterMediumStyle];
            formattedDate = [displayFormatter stringFromDate:date];
            [displayFormatter release];
        }
    }

    NSString *format;
    if (formattedDate != nil) {
        format = [[NSBundle mainBundle] localizedStringForKey:@"Last tested with CrossOver %1$@ on %2$@." value:@"" table:nil];
    } else {
        format = [[NSBundle mainBundle] localizedStringForKey:@"Last tested with CrossOver %1$@." value:@"" table:nil];
    }
    self->medaldatemessage = [[NSString alloc] initWithFormat:format, version, formattedDate];
    return [[self->medaldatemessage retain] autorelease];
}

+ (id)ratingImageWithName:(id)arg1 {
    NSImage *image = [[[NSImage imageNamed:arg1] copy] autorelease];
    NSSize size = [image size];
    if (size.height > 0) {
        [image setSize:NSMakeSize(size.width * (21.0 / size.height), 21.0)];
    }
    return image;
}

+ (id)untrustedRatingImage {
    static NSImage *untrustedRatingImage = nil;
    if (untrustedRatingImage == nil) {
        untrustedRatingImage = [[self ratingImageWithName:@"sf-symbols.exclamationmark.circle.fill"] retain];
    }
    return untrustedRatingImage;
}

+ (id)starRatingImage {
    static NSImage *starRatingImage = nil;
    if (starRatingImage == nil) {
        starRatingImage = [[self ratingImageWithName:@"sf-symbols.star.fill-yellow"] retain];
    }
    return starRatingImage;
}

+ (id)starOutlineRatingImage {
    static NSImage *starOutlineRatingImage = nil;
    if (starOutlineRatingImage == nil) {
        starOutlineRatingImage = [[self ratingImageWithName:@"sf-symbols.star"] retain];
    }
    return starOutlineRatingImage;
}

- (id)ratingImageForIndex:(NSUInteger)arg1 {
    if (self->_ratingImages[0] == nil && self->packageobject != nil) {
        NSInteger rating = [[self->packageobject valueForKeyPath:@"app_profile.medal_rating"] integerValue];
        for (NSInteger i = 0; i < 5; i++) {
            NSImage *image;
            if (rating < 0) {
                // Untrusted recipes show a single warning badge instead of stars.
                image = (i == 0) ? [[self class] untrustedRatingImage] : nil;
            } else if (i < rating) {
                image = [[self class] starRatingImage];
            } else {
                image = [[self class] starOutlineRatingImage];
            }
            [self->_ratingImages[i] release];
            self->_ratingImages[i] = [image retain];
        }
    }
    if (arg1 >= 5) {
        return nil;
    }
    return [[self->_ratingImages[arg1] retain] autorelease];
}

- (id)ratingImage1 {
    return [self ratingImageForIndex:0];
}

- (id)ratingImage2 {
    return [self ratingImageForIndex:1];
}

- (id)ratingImage3 {
    return [self ratingImageForIndex:2];
}

- (id)ratingImage4 {
    return [self ratingImageForIndex:3];
}

- (id)ratingImage5 {
    return [self ratingImageForIndex:4];
}

+ (id)tooltipForRating:(NSInteger)arg1 {
    // tooltips[0] is for untrusted (negative) ratings; tooltips[1 + n] for medal rating n.
    static NSString *tooltips[7];
    if (tooltips[0] == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        tooltips[0] = [[bundle localizedStringForKey:@"This installation recipe is from an unknown source. Installing may pose a security risk to your system." value:@"" table:nil] retain];
        tooltips[1] = [[bundle localizedStringForKey:@"No ratings have been reported.\n\nAll application entries start at this rating. Over time staff and users can visit the App Compatibility page of the CodeWeavers website and rate how far they got in running this Windows application in CrossOver. If you try this application please submit a rating for how this application worked, or didn't, in CrossOver." value:@"" table:nil] retain];
        tooltips[2] = [[bundle localizedStringForKey:@"This application won't get through installation.\n\nMost installers are standardized and CrossOver will be able to run them without a problem. However some companies customize the installer, or write their own, and the custom programming fails in CrossOver. The Windows application itself might be functional, but there's no way to get it out of the installer." value:@"" table:nil] retain];
        tooltips[3] = [[bundle localizedStringForKey:@"This application installs, but fails to run.\n\nThe Windows application immediately closes or freezes when you try to run it. You may be able to add various dependencies or try different workarounds to get this application to start, so please check the Support section of the CodeWeavers website for more information and tutorials. If the program still won't launch then whatever programming this Windows application needs to work doesn't exist yet in CrossOver." value:@"" table:nil] retain];
        tooltips[4] = [[bundle localizedStringForKey:@"This application installs and runs, but has problems.\n\nThis application runs, but there are significant functional gaps. CrossOver translates Windows commands to their corresponding Mac commands and back. When a Windows program uses commands that CrossOver doesn't know how to translate the Windows program may not respond when you click things, have garbled output, or crash. You might be able to add different dependencies or try workarounds to get this application to run better, so please check this application's page at the CodeWeavers website. It's also possible that programming added in a future release of CrossOver might help this Windows application run better, so check back later." value:@"" table:nil] retain];
        tooltips[5] = [[bundle localizedStringForKey:@"This application installs and runs quite well, with only minor glitches found.\n\nThe core functionality of this Windows application works fine under CrossOver. There still may be some extra functions that don't work right, but overall this application should be mostly usable. We don't maintain a list of what specific functions work/don't work per-application in our compatibility database, but you may want to check this application's Forums at the CodeWeavers website and see if other users have reported any particular details about running this Windows application in CrossOver." value:@"" table:nil] retain];
        tooltips[6] = [[bundle localizedStringForKey:@"This application installs and runs great, the same as it would in Windows.\n\nPractically all of the application is functional. Using this application in CrossOver should be the same as running the application on native Windows OS." value:@"" table:nil] retain];
    }
    NSInteger index = (arg1 >= 0) ? MIN(arg1, (NSInteger)5) : -1;
    return tooltips[index + 1];
}

- (id)ratingTooltip {
    if (self->_ratingTooltip == nil && self->packageobject != nil) {
        NSInteger rating = [[self->packageobject valueForKeyPath:@"app_profile.medal_rating"] integerValue];
        self->_ratingTooltip = [[[self class] tooltipForRating:rating] retain];
    }
    return [[self->_ratingTooltip retain] autorelease];
}

- (id)ratingDescription {
    if (self->_ratingDescription == nil && self->packageobject != nil) {
        NSInteger rating = [[self->packageobject valueForKeyPath:@"app_profile.medal_rating"] integerValue];
        NSString *key;
        switch (rating) {
            case 0: key = @"Untested"; break;
            case 1: key = @"Will Not Install"; break;
            case 2: key = @"Installs, Will Not Run"; break;
            case 3: key = @"Limited Functionality"; break;
            case 4: key = @"Runs Well"; break;
            case 5: key = @"Runs Great"; break;
            default: key = @"Untrusted"; break;
        }
        self->_ratingDescription = [[[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil] retain];
    }
    return [[self->_ratingDescription retain] autorelease];
}

- (id)children {
    return [[self->children retain] autorelease];
}

- (void)insertChildren:(id)arg1 atIndexes:(id)arg2 {
    NSAssert([NSThread isMainThread], @"Main thread method or function called on non-main thread");
    [self->children insertObjects:arg1 atIndexes:arg2];
    [self->children addObserver:self toObjectsAtIndexes:arg2 forKeyPath:@"totalChildren" options:NSKeyValueObservingOptionPrior context:PackageTreeNodeKVOContextDummy];
}

- (void)removeChildrenAtIndexes:(id)arg1 {
    NSAssert([NSThread isMainThread], @"Main thread method or function called on non-main thread");
    [self->children removeObserver:self fromObjectsAtIndexes:arg1 forKeyPath:@"totalChildren" context:PackageTreeNodeKVOContextDummy];
    [self->children removeObjectsAtIndexes:arg1];
}

- (id)unfilteredChildren {
    return [[self->unfilteredChildren retain] autorelease];
}

- (void)insertObject:(id)arg1 inUnfilteredChildrenAtIndex:(NSUInteger)arg2 {
    [self->unfilteredChildren insertObject:arg1 atIndex:arg2];
    [arg1 setContainer:self];
}

- (void)insertUnfilteredChildren:(id)arg1 atIndexes:(id)arg2 {
    [self->unfilteredChildren insertObjects:arg1 atIndexes:arg2];
    for (PackageTreeNode *child in arg1) {
        [child setContainer:self];
    }
}

- (void)removeObjectFromUnfilteredChildrenAtIndex:(NSUInteger)arg1 {
    [[self->unfilteredChildren objectAtIndex:arg1] setContainer:nil];
    [self->unfilteredChildren removeObjectAtIndex:arg1];
}

- (void)removeUnfilteredChildrenAtIndexes:(id)arg1 {
    for (PackageTreeNode *child in [self->unfilteredChildren objectsAtIndexes:arg1]) {
        [child setContainer:nil];
    }
    [self->unfilteredChildren removeObjectsAtIndexes:arg1];
}

- (void)removeAllLeaves {
    NSMutableIndexSet *leaves = [NSMutableIndexSet indexSet];
    for (NSUInteger i = 0; i < [self->unfilteredChildren count]; i++) {
        if ([[self->unfilteredChildren objectAtIndex:i] leaf]) {
            [leaves addIndex:i];
        }
    }
    [self removeUnfilteredChildrenAtIndexes:leaves];
}

- (void)replaceAllLeavesWithNewChildren:(id)arg1 {
    [self removeAllLeaves];
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self->unfilteredChildren count], [arg1 count])];
    [self insertUnfilteredChildren:arg1 atIndexes:indexes];
}

- (void)startObservingChildren {
    NSIndexSet *all = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self->children count])];
    [self->children addObserver:self toObjectsAtIndexes:all forKeyPath:@"totalChildren" options:NSKeyValueObservingOptionPrior context:PackageTreeNodeKVOContextDummy];
}

- (void)stopObservingChildren {
    NSIndexSet *all = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self->children count])];
    [self->children removeObserver:self fromObjectsAtIndexes:all forKeyPath:@"totalChildren" context:PackageTreeNodeKVOContextDummy];
}

- (BOOL)leaf {
    // Profiles have no children array at all; categories always have one, even when empty.
    return self->children == nil;
}

- (id)sortkey {
    return [[self->sortkey retain] autorelease];
}

+ (id)keyPathsForValuesAffectingTotalChildren {
    return [NSSet setWithObject:@"children"];
}

- (NSUInteger)totalChildren {
    // Categories count as their contents rather than as one item.
    NSUInteger total = [self->children count];
    for (PackageTreeNode *child in self->children) {
        if ([child children] != nil) {
            total = total + [child totalChildren] - 1;
        }
    }
    return total;
}

+ (id)keyPathsForValuesAffectingUnknown {
    return [NSSet setWithObject:@"packageid"];
}

- (BOOL)isUnknown {
    return [self->packageid isEqualToString:@"com.codeweavers.unknown"];
}

- (BOOL)isComponent {
    if (self->packageobject == nil) {
        return YES;
    }
    return [[self->packageobject valueForKeyPath:@"is_component"] boolValue];
}

- (BOOL)isHighlighted {
    if (self->packageobject == nil) {
        return YES;
    }
    return [[self->packageobject valueForKeyPath:@"is_highlighted"] boolValue];
}

- (BOOL)highlighted {
    return [self isHighlighted];
}

- (BOOL)isRanked {
    if (self->packageobject == nil) {
        return YES;
    }
    return [[self->packageobject valueForKeyPath:@"is_ranked"] boolValue];
}

- (BOOL)ranked {
    return [self isRanked];
}

- (void)filterWithPredicate:(id)arg1 {
    [self filterWithPredicate:arg1 keepEmptyCategories:YES];
}

- (void)filterWithPredicate:(id)arg1 keepEmptyCategories:(BOOL)arg2 {
    for (PackageTreeNode *child in self->unfilteredChildren) {
        [child filterWithPredicate:arg1 keepEmptyCategories:arg2];
    }

    NSArray *matching = self->unfilteredChildren;
    if (arg1 != nil) {
        matching = [matching filteredArrayUsingPredicate:arg1];
    }
    NSMutableSet *wanted = [NSMutableSet setWithArray:matching];

    if (arg1 != nil) {
        // Categories stay visible when they still hold something (or always, if asked to).
        for (PackageTreeNode *child in self->unfilteredChildren) {
            if (![child leaf] && (arg2 || [[child children] count] != 0)) {
                [wanted addObject:child];
            }
        }
        NSMutableIndexSet *unwanted = [NSMutableIndexSet indexSet];
        for (NSUInteger i = 0; i < [self->children count]; i++) {
            id child = [self->children objectAtIndex:i];
            if ([wanted containsObject:child]) {
                [wanted removeObject:child];
            } else {
                [unwanted addIndex:i];
            }
        }
        if ([unwanted count] != 0) {
            [self removeChildrenAtIndexes:unwanted];
        }
    } else {
        [wanted minusSet:[NSSet setWithArray:self->children]];
    }

    if ([wanted count] != 0) {
        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange([self->children count], [wanted count])];
        [self insertChildren:[wanted allObjects] atIndexes:indexes];
    }
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    if (arg4 != PackageTreeNodeKVOContextDummy) {
        [super observeValueForKeyPath:arg1 ofObject:arg2 change:arg3 context:arg4];
        return;
    }
    NSAssert([NSThread isMainThread], @"Main thread method or function called on non-main thread");
    // A child's count is about to change (or just did), so ours does too.
    if ([[arg3 objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue]) {
        [self willChangeValueForKey:@"totalChildren"];
    } else {
        [self didChangeValueForKey:@"totalChildren"];
    }
}

+ (void)updateIconList {
    if (_iconUtils == nil) {
        _iconUtils = [[[CXSetupLib iconUtilsClass] alloc] init];
    }
    [_iconUtils fetchIconList];
}

+ (id)defaultIcon {
    static NSImage *icon = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        icon = [[NSImage imageNamed:@"exeIcon.icns"] copy];
    });
    return icon;
}

- (void)loadIcon {
    [_iconUtils fetchIcon:self->packageid];
    NSString *iconPath = [_iconUtils getIconPath:self->packageid];
    if (iconPath == nil) {
        return;
    }
    NSData *data = [NSData dataWithContentsOfFile:iconPath];
    if (data == nil) {
        return;
    }
    NSImage *image = [[NSImage alloc] initWithData:data];
    if (image != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setIcon:image];
        });
    }
    [image release];
}

- (id)softwarePackage {
    return self->_softwarePackage;
}

- (void)setSoftwarePackage:(id)arg1 {
    if (self->_softwarePackage != arg1) {
        [self->_softwarePackage release];
        self->_softwarePackage = [arg1 copy];
    }
}

- (id)localizedNames {
    return [[self->_localizedNames retain] autorelease];
}

- (void)setDescriptionFont:(id)arg1 {
    if (self->_descriptionFont != arg1) {
        [self->_descriptionFont release];
        self->_descriptionFont = [arg1 copy];
    }
}

- (id)container {
    return [objc_loadWeakRetained((id *)&self->_container) autorelease];
}

- (void)setContainer:(id)arg1 {
    objc_storeWeak((id *)&self->_container, arg1);
}

- (id)icon {
    @synchronized (self) {
        return [[self->_icon retain] autorelease];
    }
}

- (void)setIcon:(id)arg1 {
    @synchronized (self) {
        if (self->_icon != arg1) {
            [self->_icon release];
            self->_icon = [arg1 retain];
        }
    }
}

@end
