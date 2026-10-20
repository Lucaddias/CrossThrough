// SelectBottleSheetController.m — CrossThrough
#import "SelectBottleSheetController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation SelectBottleSheetController

+ (id)keyPathsForValuesAffectingCreatingNewBottle {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"targetBottle"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingConfigurationIsValid {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"targetBottle"];
     *   return r0;
     */
    return nil;
}

- (id)initWithInstallConfiguration:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (void)windowDidLoad {
    return;
}

- (BOOL)isTemplate:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r2 = arg2;
     *   if (r2 != 0x0) {
     *   r0 = [r2 valueForKey:@"is_template"];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [r0 boolValue];
     *   [r19 release];
     *   r0 = r20;
     *   }
     *   else {
     *   r0 = 0x0;
     *   }
     *   return r0;
     */
    return NO;
}

- (BOOL)creatingNewBottle {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [[self targetBottle] retain];
     *   r19 = [self isTemplate:r20];
     *   [r20 release];
     *   r0 = r19;
     *   return r0;
     */
    return NO;
}

- (void)setNameForNewBottle:(id)arg1 {
    return;
}

- (id)stringInSystemFont:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r2 = arg2;
     *   r31 = r31 - 0x60;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_28 = **___stack_chk_guard;
     *   r19 = [r2 retain];
     *   if (*_stringInSystemFont:.labelFont == 0x0) {
     *   var_48 = **_NSFontAttributeName;
     *   [NSFont systemFontSize];
     *   r0 = [NSFont systemFontOfSize:r2];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   var_38 = r0;
     *   r21 = [[NSColor labelColor] retain];
     *   r0 = [NSDictionary dictionaryWithObjects:&var_38 forKeys:&var_48 count:0x2];
     *   r0 = [r0 retain];
     *   r8 = *_stringInSystemFont:.labelFont;
     *   *_stringInSystemFont:.labelFont = r0;
     *   [r8 release];
     *   [r21 release];
     *   [r20 release];
     *   ... (8 more lines)
     */
    return nil;
}

- (id)attributedStringWithImageNamed:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r23 = [arg2 retain];
     *   [NSFont systemFontSize];
     *   r0 = [NSFont systemFontOfSize:r2];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   [r0 ascender];
     *   [r19 descender];
     *   r21 = [[NSTextAttachment alloc] init];
     *   r22 = [[NSImage imageNamed:r23] retain];
     *   [r23 release];
     *   [r22 size];
     *   [r22 size];
     *   [r22 setSize:r2];
     *   [r21 setImage:r22];
     *   r0 = [NSAttributedString attributedStringWithAttachment:r21];
     *   r0 = [r0 retain];
     *   r24 = r0;
     *   r23 = [r0 mutableCopy];
     *   [r24 release];
     *   r24 = **_NSBaselineOffsetAttributeName;
     *   [r19 descender];
     *   r25 = [[NSNumber numberWithDouble:r2] retain];
     *   [r23 length];
     *   [r23 addAttribute:r24 value:r25 range:0x0];
     *   [r25 release];
     *   ... (8 more lines)
     */
    return nil;
}

- (id)attributedErrorStringWithString:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r19 = [arg2 retain];
     *   if (*_attributedErrorStringWithString:.errorIconPrefix == 0x0) {
     *   r0 = [r20 attributedStringWithImageNamed:@"sf-symbols.xmark.octagon.fill"];
     *   r0 = [r0 retain];
     *   r8 = *_attributedErrorStringWithString:.errorIconPrefix;
     *   *_attributedErrorStringWithString:.errorIconPrefix = r0;
     *   [r8 release];
     *   }
     *   r21 = [*_attributedErrorStringWithString:.errorIconPrefix mutableCopy];
     *   r20 = [[r20 stringInSystemFont:r19] retain];
     *   [r21 appendAttributedString:r20];
     *   [r20 release];
     *   [r19 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)attributedWarningStringWithString:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r19 = [arg2 retain];
     *   if (*_attributedWarningStringWithString:.warningIconPrefix == 0x0) {
     *   r0 = [r20 attributedStringWithImageNamed:@"sf-symbols.exclamationmark.circle.fill"];
     *   r0 = [r0 retain];
     *   r8 = *_attributedWarningStringWithString:.warningIconPrefix;
     *   *_attributedWarningStringWithString:.warningIconPrefix = r0;
     *   [r8 release];
     *   }
     *   r21 = [*_attributedWarningStringWithString:.warningIconPrefix mutableCopy];
     *   r20 = [[r20 stringInSystemFont:r19] retain];
     *   [r21 appendAttributedString:r20];
     *   [r20 release];
     *   [r19 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)updateBottleWarningText {
    return;
}

- (void)addMenuItemsFromCategories:(id)arg1 isBottles:(BOOL)arg2 {
    return;
}

- (void)bottleItemSelected:(id)arg1 {
    return;
}

- (void)templateItemSelected:(id)arg1 {
    return;
}

- (void)updateBottlesList {
    return;
}

- (void)updateTemplatesList {
    return;
}

- (void)updateMenus {
    return;
}

- (void)updateInstallTaskWithBottleSelection {
    return;
}

- (BOOL)configurationIsValid {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [self targetBottle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   if ([r20 creatingNewBottle] != 0x0) {
     *   r21 = [[r20 installConfiguration] retain];
     *   r22 = [[r20 nameForNewBottle] retain];
     *   r20 = [r21 isNewBottleNameValid:r22];
     *   [r22 release];
     *   [r21 release];
     *   }
     *   else {
     *   r20 = 0x1;
     *   }
     *   }
     *   else {
     *   r20 = 0x0;
     *   ... (4 more lines)
     */
    return NO;
}

- (void)done:(id)arg1 {
    return;
}

- (void)cancel:(id)arg1 {
    return;
}

- (void)windowWillClose:(id)arg1 {
    return;
}

- (void)profileChanged {
    return;
}

- (void)bottleCreateChanged {
    return;
}

- (void)bottleNewnameChanged {
    return;
}

- (void)bottleTemplateChanged {
    return;
}

- (void)bottleNameChanged {
    return;
}

- (void)categorizedAllBottles {
    return;
}

- (void)analyzedBottle:(id)arg1 {
    return;
}

- (id)installConfiguration {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_installConfiguration)), 0x1);
     *   return r0;
     */
    return nil;
}

- (id)bottleCollection {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)categorizedBottles {
    return self->_categorizedBottles;
}

- (void)setCategorizedBottles:(id)arg1 {
    self->_categorizedBottles = arg1;
}

- (id)categorizedTemplates {
    return self->_categorizedTemplates;
}

- (void)setCategorizedTemplates:(id)arg1 {
    self->_categorizedTemplates = arg1;
}

- (id)bottleWarningText {
    return self->_bottleWarningText;
}

- (void)setBottleWarningText:(id)arg1 {
    return;
}

- (id)nameForNewBottle {
    return self->_nameForNewBottle;
}

- (id)targetBottle {
    return self->_targetBottle;
}

- (void)setTargetBottle:(id)arg1 {
    self->_targetBottle = arg1;
}

- (id)doneButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_doneButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDoneButton:(id)arg1 {
    return;
}

- (id)nameForNewBottleTextField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_nameForNewBottleTextField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNameForNewBottleTextField:(id)arg1 {
    return;
}

- (id)bottleListPopUpButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleListPopUpButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleListPopUpButton:(id)arg1 {
    return;
}

- (id)makeNewBottleMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_makeNewBottleMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setMakeNewBottleMenuItem:(id)arg1 {
    return;
}

- (id)selectBottlePlaceholderMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_selectBottlePlaceholderMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setSelectBottlePlaceholderMenuItem:(id)arg1 {
    return;
}

- (id)templateTypesPopUpButton {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_templateTypesPopUpButton);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setTemplateTypesPopUpButton:(id)arg1 {
    return;
}

@end
