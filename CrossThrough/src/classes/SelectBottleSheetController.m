// SelectBottleSheetController.m — CrossThrough
#import "SelectBottleSheetController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static NSArray *_orderedCategoryNumbers = nil;
static NSDictionary *_bottleCategoryDisplayNames = nil;
static NSDictionary *_templateCategoryDisplayNames = nil;
static dispatch_once_t _catOnceToken = 0;

@implementation SelectBottleSheetController

+ (id)keyPathsForValuesAffectingCreatingNewBottle {
    return [NSSet setWithObject:@"targetBottle"];
}

+ (id)keyPathsForValuesAffectingConfigurationIsValid {
    return [NSSet setWithObject:@"targetBottle"];
}

- (id)initWithInstallConfiguration:(id)arg1 {
    self = [super initWithWindowNibName:@"SelectBottleSheet"];
    if (self) {
        self->_bottleCollection = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
        self->_installConfiguration = [arg1 retain];
        [self->_installConfiguration addDelegate:self];
    }
    return self;
}

- (void)dealloc {
    [self->_installConfiguration removeDelegate:self];
    [self->_installConfiguration release];
    self->_installConfiguration = nil;
    [self->_bottleCollection release];
    self->_bottleCollection = nil;
    [self->_nameForNewBottle release];
    self->_nameForNewBottle = nil;
    [self->_targetBottle release];
    self->_targetBottle = nil;
    [self->_bottleWarningText release];
    self->_bottleWarningText = nil;
    [self->_categorizedBottles release];
    self->_categorizedBottles = nil;
    [self->_categorizedTemplates release];
    self->_categorizedTemplates = nil;
    objc_destroyWeak((id *)&self->_doneButton);
    objc_destroyWeak((id *)&self->_nameForNewBottleTextField);
    objc_destroyWeak((id *)&self->_bottleListPopUpButton);
    objc_destroyWeak((id *)&self->_makeNewBottleMenuItem);
    objc_destroyWeak((id *)&self->_selectBottlePlaceholderMenuItem);
    objc_destroyWeak((id *)&self->_templateTypesPopUpButton);
    [super dealloc];
}

- (void)windowDidLoad {
    [super windowDidLoad];

    [self setNameForNewBottle:[self.installConfiguration nameForNewBottle]];
    [self setTargetBottle:[self.installConfiguration targetBottle]];
    [self updateMenus];
    [self updateBottleWarningText];

    if ([self creatingNewBottle]) {
        if (![self.installConfiguration isNewBottleNameValid:[self nameForNewBottle]]) {
            NSWindow *win = [self window];
            NSTextField *tf = [self nameForNewBottleTextField];
            if (win && tf) {
                [win makeFirstResponder:tf];
            }
        }
        NSPopUpButton *btn = [self bottleListPopUpButton];
        NSMenuItem *item = [self makeNewBottleMenuItem];
        if (btn && item) {
            [btn selectItem:item];
        }
    }
}

- (BOOL)isTemplate:(id)arg1 {
    if (!arg1) return NO;
    return [[arg1 valueForKey:@"is_template"] boolValue];
}

- (BOOL)creatingNewBottle {
    return [self isTemplate:[self targetBottle]];
}

- (void)setNameForNewBottle:(id)arg1 {
    if (![self->_nameForNewBottle isEqual:arg1]) {
        [self willChangeValueForKey:@"nameForNewBottle"];
        [self->_nameForNewBottle release];
        self->_nameForNewBottle = [arg1 copy];
        [self didChangeValueForKey:@"nameForNewBottle"];
        [self updateBottleWarningText];
    }
}

- (id)stringInSystemFont:(id)arg1 {
    if (!arg1) return nil;
    NSDictionary *attrs = @{
        NSFontAttributeName: [NSFont systemFontOfSize:[NSFont systemFontSize]],
        NSForegroundColorAttributeName: [NSColor labelColor]
    };
    return [[[NSAttributedString alloc] initWithString:arg1 attributes:attrs] autorelease];
}

- (id)attributedStringWithImageNamed:(id)arg1 {
    NSImage *img = [NSImage imageNamed:arg1];
    NSTextAttachment *attachment = [[[NSTextAttachment alloc] init] autorelease];
    [attachment setImage:img];
    NSMutableAttributedString *str = [[[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy] autorelease];
    [str appendAttributedString:[self stringInSystemFont:@" "]];
    return str;
}

- (id)attributedErrorStringWithString:(id)arg1 {
    NSMutableAttributedString *str = [[[self attributedStringWithImageNamed:@"sf-symbols.xmark.octagon.fill"] mutableCopy] autorelease];
    [str appendAttributedString:[self stringInSystemFont:arg1]];
    return str;
}

- (id)attributedWarningStringWithString:(id)arg1 {
    NSMutableAttributedString *str = [[[self attributedStringWithImageNamed:@"sf-symbols.exclamationmark.circle.fill"] mutableCopy] autorelease];
    [str appendAttributedString:[self stringInSystemFont:arg1]];
    return str;
}

- (void)updateBottleWarningText {
    NSAttributedString *warning = nil;

    if ([self creatingNewBottle]) {
        NSString *name = [self nameForNewBottle];
        if ([name length] == 0) {
            NSString *msg = [[NSBundle mainBundle] localizedStringForKey:@"You must enter a name for the new bottle." value:@"" table:nil];
            warning = [self attributedErrorStringWithString:msg];
        } else if (![self.installConfiguration isNewBottleNameValid:name]) {
            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"You can't name a new bottle '%@'. You must use a different name for your new bottle or select an existing bottle." value:@"" table:nil];
            warning = [self attributedErrorStringWithString:[NSString stringWithFormat:fmt, name]];
        } else if ([[self bottleCollection] bottleWithName:name]) {
            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"You can't name a new bottle '%@'. There is already a bottle by that name. You must use a different name for your new bottle or select an existing bottle." value:@"" table:nil];
            warning = [self attributedErrorStringWithString:[NSString stringWithFormat:fmt, name]];
        } else if (self->_targetBottle) {
            id comp = [self->_targetBottle valueForKey:@"compatible"];
            if (comp && ![comp boolValue]) {
                NSString *msg = [[NSBundle mainBundle] localizedStringForKey:@"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle." value:@"" table:nil];
                warning = [self attributedWarningStringWithString:msg];
            }
        }
    } else if (self->_targetBottle) {
        id comp = [self->_targetBottle valueForKey:@"compatible"];
        if (comp && ![comp boolValue]) {
            NSString *msg = [[NSBundle mainBundle] localizedStringForKey:@"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle." value:@"" table:nil];
            warning = [self attributedWarningStringWithString:msg];
        } else {
            NSString *bName = [self->_targetBottle valueForKey:@"bottlename"];
            id bottle = [[self bottleCollection] bottleWithName:bName];
            NSDictionary *pkgs = [bottle installedPackages];
            NSMutableDictionary *mutPkgs = [NSMutableDictionary dictionaryWithDictionary:pkgs];
            [mutPkgs removeObjectForKey:@"com.codeweavers.c4.cxhtml"];
            if ([mutPkgs count] > 0) {
                NSString *msg = [[NSBundle mainBundle] localizedStringForKey:@"It is recommended that you install this application into a new bottle in order to avoid possible interference between programs." value:@"" table:nil];
                warning = [self stringInSystemFont:msg];
            }
        }
    }

    [self setBottleWarningText:warning];
}

- (void)addMenuItemsFromCategories:(id)categories isBottles:(BOOL)isBottles {
    if (_catOnceToken != -1) {
        dispatch_once(&_catOnceToken, ^{
            id cxSetup = [CXSetupLib cxSetupClass];
            NSNumber *rec = [cxSetup bottleCategory:@"RECOMMENDED"];
            NSNumber *comp = [cxSetup bottleCategory:@"COMPATIBLE"];
            NSNumber *none = [cxSetup bottleCategory:@"NONE"];
            NSNumber *incomp = [cxSetup bottleCategory:@"INCOMPATIBLE"];
            _orderedCategoryNumbers = [[NSArray alloc] initWithObjects:rec, comp, none, incomp, nil];

            NSBundle *mb = [NSBundle mainBundle];
            _bottleCategoryDisplayNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                [mb localizedStringForKey:@"Bottles" value:@"Bottles" table:nil], none,
                [mb localizedStringForKey:@"Recommended Bottles" value:@"Recommended Bottles" table:nil], rec,
                [mb localizedStringForKey:@"Compatible Bottles" value:@"Compatible Bottles" table:nil], comp,
                [mb localizedStringForKey:@"Incompatible Bottles" value:@"Incompatible Bottles" table:nil], incomp,
                nil];

            _templateCategoryDisplayNames = [[NSDictionary alloc] initWithObjectsAndKeys:
                [mb localizedStringForKey:@"Bottle Types" value:@"Bottle Types" table:nil], none,
                [mb localizedStringForKey:@"Recommended Bottle Types" value:@"Recommended Bottle Types" table:nil], rec,
                [mb localizedStringForKey:@"Compatible Bottle Types" value:@"Compatible Bottle Types" table:nil], comp,
                [mb localizedStringForKey:@"Incompatible Bottle Types" value:@"Incompatible Bottle Types" table:nil], incomp,
                nil];
        });
    }

    NSDictionary *catDisplayNames = isBottles ? _bottleCategoryDisplayNames : _templateCategoryDisplayNames;
    NSPopUpButton *popUp = isBottles ? [self bottleListPopUpButton] : [self templateTypesPopUpButton];
    NSMenu *menu = [popUp menu];
    SEL itemAction = isBottles ? @selector(bottleItemSelected:) : @selector(templateItemSelected:);
    NSMenuItem *matchedItem = nil;

    for (NSNumber *catNum in _orderedCategoryNumbers) {
        NSArray *itemsInCat = [categories objectForKey:catNum];
        if ([itemsInCat count] > 0) {
            NSString *headerTitle = [catDisplayNames objectForKey:catNum];
            if (headerTitle) {
                NSMenuItem *headerItem = [menu addItemWithTitle:headerTitle action:NULL keyEquivalent:@""];
                [headerItem setEnabled:NO];
            }

            for (NSDictionary *itemDict in itemsInCat) {
                NSString *dispName = [itemDict objectForKey:@"displayname"];
                id tb = [itemDict objectForKey:@"targetBottle"];
                NSMenuItem *mItem = [menu addItemWithTitle:dispName ?: @"" action:itemAction keyEquivalent:@""];
                [mItem setRepresentedObject:tb];
                [mItem setIndentationLevel:1];
                [mItem setTarget:self];

                if (self->_targetBottle && tb == self->_targetBottle) {
                    matchedItem = mItem;
                }
            }
        }
    }

    if (matchedItem) {
        [popUp selectItem:matchedItem];
    }
}

- (void)bottleItemSelected:(id)arg1 {
    if (arg1 == [self makeNewBottleMenuItem]) {
        NSPopUpButton *tmplPopUp = [self templateTypesPopUpButton];
        if (![[tmplPopUp selectedItem] isEnabled]) {
            id recTmpl = [self.installConfiguration recommendedTemplate];
            for (NSMenuItem *item in [[tmplPopUp menu] itemArray]) {
                if ([item representedObject] == recTmpl) {
                    [tmplPopUp selectItem:item];
                    break;
                }
            }
        }
    }
    [self updateInstallTaskWithBottleSelection];
}

- (void)templateItemSelected:(id)arg1 {
    [self updateInstallTaskWithBottleSelection];
}

- (void)updateBottlesList {
    NSMutableDictionary *cats = [NSMutableDictionary dictionaryWithCapacity:4];
    NSDictionary *bottles = [self.installConfiguration bottles];
    NSArray *sortedKeys = [[bottles allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];

    for (NSString *key in sortedKeys) {
        id bottle = [bottles objectForKey:key];
        NSNumber *cat = [bottle respondsToSelector:@selector(getCategory)] ? [bottle getCategory] : nil;
        if (!cat) {
            cat = [[CXSetupLib cxSetupClass] bottleCategory:@"NONE"];
        }
        NSMutableArray *list = [cats objectForKey:cat];
        if (!list) {
            list = [NSMutableArray array];
            [cats setObject:list forKey:cat];
        }
        NSDictionary *dict = @{ @"displayname": key, @"targetBottle": bottle };
        [list addObject:dict];
    }

    [self setCategorizedBottles:cats];

    NSMenu *menu = [[self bottleListPopUpButton] menu];
    while ([menu numberOfItems] > 2) {
        [menu removeItemAtIndex:[menu numberOfItems] - 1];
    }

    [self addMenuItemsFromCategories:cats isBottles:YES];

    if (!self->_targetBottle) {
        NSMenuItem *ph = [self selectBottlePlaceholderMenuItem];
        if (ph) {
            [[self bottleListPopUpButton] selectItem:ph];
        }
    }
}

- (void)updateTemplatesList {
    NSMutableDictionary *cats = [NSMutableDictionary dictionaryWithCapacity:4];
    NSDictionary *templates = [self.installConfiguration templates];

    [templates enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *dispName = [[CXSetupLib bottleManagementClass] displayNameForTemplate:key];
        if (!dispName) dispName = key;
        NSNumber *cat = [obj respondsToSelector:@selector(getCategory)] ? [obj getCategory] : nil;
        if (!cat) {
            cat = [[CXSetupLib cxSetupClass] bottleCategory:@"NONE"];
        }
        NSMutableArray *list = [cats objectForKey:cat];
        if (!list) {
            list = [NSMutableArray array];
            [cats setObject:list forKey:cat];
        }
        NSDictionary *dict = @{ @"displayname": dispName, @"targetBottle": obj };
        [list addObject:dict];
    }];

    [self setCategorizedTemplates:cats];

    NSMenu *menu = [[self templateTypesPopUpButton] menu];
    [menu removeAllItems];

    [self addMenuItemsFromCategories:cats isBottles:NO];
}

- (void)updateMenus {
    [self updateBottlesList];
    [self updateTemplatesList];
}

- (void)updateInstallTaskWithBottleSelection {
    NSMenuItem *sel = [[self bottleListPopUpButton] selectedItem];
    id tb = nil;
    if (sel == [self makeNewBottleMenuItem]) {
        tb = [[[self templateTypesPopUpButton] selectedItem] representedObject];
    } else {
        tb = [sel representedObject];
    }
    [self setTargetBottle:tb];
    [self updateBottleWarningText];
}

- (BOOL)configurationIsValid {
    if (self->_targetBottle != nil) {
        if ([self creatingNewBottle]) {
            return [self.installConfiguration isNewBottleNameValid:[self nameForNewBottle]];
        }
        return YES;
    }
    return NO;
}

- (void)done:(id)arg1 {
    if ([self isTemplate:self->_targetBottle]) {
        NSString *name = [self nameForNewBottle];
        id tmpl = [self->_targetBottle valueForKey:@"template"];
        [self.installConfiguration createNewBottle:name template:tmpl];
    } else if (self->_targetBottle) {
        NSString *bName = [self->_targetBottle valueForKey:@"bottlename"];
        [self.installConfiguration setBottleName:bName];
    }
    [NSApp endSheet:[self window]];
}

- (void)cancel:(id)arg1 {
    [NSApp endSheet:[self window]];
}

- (void)windowWillClose:(id)arg1 {
    [self.installConfiguration removeDelegate:self];
    [super windowWillClose:arg1];
}

#pragma mark - Delegate Notifications

- (void)profileChanged {
    [self updateMenus];
    [self updateBottleWarningText];
}

- (void)bottleCreateChanged {
    [self updateMenus];
    [self updateBottleWarningText];
}

- (void)bottleNewnameChanged {
    [self updateBottleWarningText];
}

- (void)bottleTemplateChanged {
    [self updateMenus];
    [self updateBottleWarningText];
}

- (void)bottleNameChanged {
    [self updateMenus];
    [self updateBottleWarningText];
}

- (void)categorizedAllBottles {
    [self updateMenus];
}

- (void)analyzedBottle:(id)arg1 {
    [self updateMenus];
}

#pragma mark - Properties Accessors

- (id)installConfiguration {
    return self->_installConfiguration;
}

- (id)bottleCollection {
    if (self->_bottleCollection) {
        return self->_bottleCollection;
    }
    return [[CXSetupLib bottleCollectionClass] sharedCollection];
}

- (id)categorizedBottles {
    return self->_categorizedBottles;
}

- (void)setCategorizedBottles:(id)arg1 {
    if (self->_categorizedBottles != arg1) {
        [self->_categorizedBottles release];
        self->_categorizedBottles = [arg1 retain];
    }
}

- (id)categorizedTemplates {
    return self->_categorizedTemplates;
}

- (void)setCategorizedTemplates:(id)arg1 {
    if (self->_categorizedTemplates != arg1) {
        [self->_categorizedTemplates release];
        self->_categorizedTemplates = [arg1 retain];
    }
}

- (id)bottleWarningText {
    return self->_bottleWarningText;
}

- (void)setBottleWarningText:(id)arg1 {
    if (self->_bottleWarningText != arg1) {
        [self->_bottleWarningText release];
        self->_bottleWarningText = [arg1 copy];
    }
}

- (id)nameForNewBottle {
    return self->_nameForNewBottle;
}

- (id)targetBottle {
    return self->_targetBottle;
}

- (void)setTargetBottle:(id)arg1 {
    if (self->_targetBottle != arg1) {
        [self willChangeValueForKey:@"targetBottle"];
        [self->_targetBottle release];
        self->_targetBottle = [arg1 retain];
        [self didChangeValueForKey:@"targetBottle"];
    }
}

- (id)doneButton {
    return objc_loadWeakRetained((id *)&self->_doneButton);
}

- (void)setDoneButton:(id)arg1 {
    objc_storeWeak((id *)&self->_doneButton, arg1);
}

- (id)nameForNewBottleTextField {
    return objc_loadWeakRetained((id *)&self->_nameForNewBottleTextField);
}

- (void)setNameForNewBottleTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_nameForNewBottleTextField, arg1);
}

- (id)bottleListPopUpButton {
    return objc_loadWeakRetained((id *)&self->_bottleListPopUpButton);
}

- (void)setBottleListPopUpButton:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleListPopUpButton, arg1);
}

- (id)makeNewBottleMenuItem {
    return objc_loadWeakRetained((id *)&self->_makeNewBottleMenuItem);
}

- (void)setMakeNewBottleMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_makeNewBottleMenuItem, arg1);
}

- (id)selectBottlePlaceholderMenuItem {
    return objc_loadWeakRetained((id *)&self->_selectBottlePlaceholderMenuItem);
}

- (void)setSelectBottlePlaceholderMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_selectBottlePlaceholderMenuItem, arg1);
}

- (id)templateTypesPopUpButton {
    return objc_loadWeakRetained((id *)&self->_templateTypesPopUpButton);
}

- (void)setTemplateTypesPopUpButton:(id)arg1 {
    objc_storeWeak((id *)&self->_templateTypesPopUpButton, arg1);
}

@end
