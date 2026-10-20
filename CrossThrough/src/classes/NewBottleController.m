// NewBottleController.m — CrossThrough
#import "NewBottleController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NewBottleController

+ (id)keyPathsForValuesAffectingCanCreate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"bottleName"];
     *   return r0;
     */
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)setCopyMode:(BOOL)arg1 withBottleToCopy:(id)arg2 {
    return;
}

- (void)setupGUI {
    return;
}

- (void)createPressed:(id)arg1 {
    return;
}

- (void)doCreate {
    return;
}

- (void)createFailed:(id)arg1 {
    return;
}

- (void)exitSuccess:(id)arg1 {
    return;
}

- (void)cancelPressed:(id)arg1 {
    return;
}

- (BOOL)canCreate {
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
     *   r0 = [self bottleName];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if ([r0 length] != 0x0) {
     *   r21 = [CXSetupLib bottleQueryClass];
     *   r22 = [[r20 bottleName] retain];
     *   r0 = [r21 isValidNewBottleName:r22];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [r0 boolValue];
     *   [r21 release];
     *   [r22 release];
     *   }
     *   else {
     *   r20 = 0x0;
     *   }
     *   [r19 release];
     *   ... (2 more lines)
     */
    return NO;
}

- (id)bottle {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottle)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setBottle:(id)arg1 {
    return;
}

- (id)suggestedBottleName {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_suggestedBottleName)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setSuggestedBottleName:(id)arg1 {
    return;
}

- (id)archiveURL {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_archiveURL)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setArchiveURL:(id)arg1 {
    return;
}

- (id)bottleTypePopUp {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_bottleTypePopUp);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setBottleTypePopUp:(id)arg1 {
    return;
}

- (id)nameLabelTypeLabelWidths {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_nameLabelTypeLabelWidths);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNameLabelTypeLabelWidths:(id)arg1 {
    return;
}

- (id)typeToCreatingSpacer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_typeToCreatingSpacer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setTypeToCreatingSpacer:(id)arg1 {
    return;
}

- (id)sourceBottleLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_sourceBottleLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setSourceBottleLabel:(id)arg1 {
    return;
}

- (id)nameLabelCopyingLabelWidths {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_nameLabelCopyingLabelWidths);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNameLabelCopyingLabelWidths:(id)arg1 {
    return;
}

- (id)sourceBottleToCreatingSpacer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_sourceBottleToCreatingSpacer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setSourceBottleToCreatingSpacer:(id)arg1 {
    return;
}

- (id)archivePathControl {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_archivePathControl);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setArchivePathControl:(id)arg1 {
    return;
}

- (id)nameLabelRestoringLabelWidths {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_nameLabelRestoringLabelWidths);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setNameLabelRestoringLabelWidths:(id)arg1 {
    return;
}

- (id)archiveToCreatingSpacer {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_archiveToCreatingSpacer);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setArchiveToCreatingSpacer:(id)arg1 {
    return;
}

- (id)bottleName {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleName)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setBottleName:(id)arg1 {
    return;
}

- (id)bottleToCopy {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleToCopy)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setBottleToCopy:(id)arg1 {
    return;
}

- (id)bottleTemplate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleTemplate)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setBottleTemplate:(id)arg1 {
    return;
}

- (id)templateArray {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_templateArray)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setTemplateArray:(id)arg1 {
    return;
}

- (BOOL)copyMode {
    return self->_copyMode;
}

- (BOOL)isWorking {
    return self->_isWorking;
}

- (void)setIsWorking:(BOOL)arg1 {
    self->_isWorking = arg1;
}

@end
