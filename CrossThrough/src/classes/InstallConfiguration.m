// InstallConfiguration.m — CrossThrough
#import "InstallConfiguration.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallConfiguration

+ (BOOL)automaticallyNotifiesObserversOfSelectedPackage {
    return NO;
}

+ (BOOL)resolveInstanceMethod:(SEL)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x60;
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
     *   r21 = arg2;
     *   r22 = self;
     *   if (*_resolveInstanceMethod:.onceToken != -0x1) {
     *   dispatch_once(_resolveInstanceMethod:.onceToken, ___block_literal_global);
     *   }
     *   r19 = [NSStringFromSelector(r21) retain];
     *   r0 = *_selectorToProperty;
     *   r0 = [r0 objectForKey:r19];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r20 getter];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   ... (64 more lines)
     */
    return NO;
}

+ (id)reasonMain {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXSetupLib cxSetupClass];
     *   r0 = [r0 dependencyReason:@"MAIN"];
     *   return r0;
     */
    return nil;
}

+ (id)reasonSteam {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXSetupLib cxSetupClass];
     *   r0 = [r0 dependencyReason:@"STEAM"];
     *   return r0;
     */
    return nil;
}

+ (id)reasonOverride {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXSetupLib cxSetupClass];
     *   r0 = [r0 dependencyReason:@"OVERRIDE"];
     *   return r0;
     */
    return nil;
}

+ (id)reasonDependency {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXSetupLib cxSetupClass];
     *   r0 = [r0 dependencyReason:@"DEPENDENCY"];
     *   return r0;
     */
    return nil;
}

+ (id)overrideExclude {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXSetupLib cxSetupClass];
     *   r0 = [r0 dependencyOverride:@"EXCLUDE"];
     *   return r0;
     */
    return nil;
}

+ (id)overrideInclude {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXSetupLib cxSetupClass];
     *   r0 = [r0 dependencyOverride:@"INCLUDE"];
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

- (void)dealloc {
    return;
}

- (BOOL)newBottleCollidesWithExistingBottle {
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
     *   if ([self creatingNewBottle] != 0x0) {
     *   r20 = [[r19 bottleCollection] retain];
     *   r21 = [[r19 nameForNewBottle] retain];
     *   r0 = [r20 bottleWithName:r21];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   r19 = 0x1;
     *   }
     *   [r0 release];
     *   [r21 release];
     *   [r20 release];
     *   }
     *   else {
     *   r19 = 0x0;
     *   }
     *   r0 = r19;
     *   return r0;
     */
    return NO;
}

- (BOOL)hasBottle {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   if (([self newBottleCollidesWithExistingBottle] & 0x1) != 0x0) {
     *   r19 = 0x0;
     *   }
     *   else {
     *   r0 = [r19 bottleName];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if ([r0 length] != 0x0) {
     *   r19 = 0x1;
     *   }
     *   [r20 release];
     *   }
     *   r0 = r19;
     *   return r0;
     */
    return NO;
}

- (BOOL)hasInstallerSource {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r0 = [self installerSource];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if ([r0 length] != 0x0) {
     *   r21 = 0x1;
     *   }
     *   else {
     *   r0 = [r21 installerDownloadSource];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if ([r0 length] == 0x0 && ([r21 installWithSteam] & 0x1) == 0x0) {
     *   r21 = [r21 isVirtual];
     *   }
     *   else {
     *   r21 = 0x1;
     *   }
     *   [r20 release];
     *   ... (4 more lines)
     */
    return NO;
}

- (BOOL)hasPackage {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [self profile];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   r19 = 0x1;
     *   }
     *   [r0 release];
     *   r0 = r19;
     *   return r0;
     */
    return NO;
}

- (BOOL)bottleIsCompatibleWithPackage {
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
     *   if ([self hasPackage] != 0x0) {
     *   r0 = [r19 targetBottle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 getCategory] retain];
     *   r22 = [[[CXSetupLib cxSetupClass] bottleCategory:@"INCOMPATIBLE"] retain];
     *   r19 = [r21 isEqualToNumber:r22] ^ 0x1;
     *   [r22 release];
     *   [r21 release];
     *   [r20 release];
     *   }
     *   else {
     *   r19 = 0x1;
     *   }
     *   r0 = r19;
     *   return r0;
     */
    return NO;
}

- (BOOL)creatingNewBottle {
    return self->_installTask;
}

- (void)setInstallerLocale:(id)arg1 {
    return;
}

- (void)setInstallerSource:(id)arg1 forUser:(BOOL)arg2 {
    return;
}

- (void)setInstallerSteam {
    return;
}

- (void)setInstallerDownload {
    return;
}

- (void)setProfile:(id)arg1 {
    return;
}

- (void)setSelectedPackage:(id)arg1 forUser:(BOOL)arg2 {
    return;
}

- (id)profileLanguages {
    return self->_installTask;
}

- (id)dependencyDetails {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self installTask];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 getDependencyDetails] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)installerDetails {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self installTask];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 getInstallerDetails] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)bottleDetails {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self installTask];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 getBottleDetails] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)languageDetails {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self installTask];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 getLanguageDetails] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)miscDetails {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self installTask];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 getMiscDetails] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)updateProfiles {
    return;
}

- (BOOL)isNewBottleNameValid:(id)arg1 {
    return self->_installTask;
}

- (void)createNewBottle:(id)arg1 template:(id)arg2 {
    return;
}

- (void)setNewBottleName:(id)arg1 {
    return;
}

- (void)addSourceMedia:(id)arg1 withLabel:(id)arg2 andDevice:(id)arg3 {
    return;
}

- (void)addSourceMedia:(id)arg1 {
    return;
}

- (void)removeSourceMedia:(id)arg1 {
    return;
}

- (BOOL)volumeMatchesProfile:(id)arg1 {
    return self->_installTask;
}

- (id)profiles {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = [[self->_installTask valueForKey:@"profiles"] retain];
     *   if ((objc_opt_respondsToSelector() & 0x1) != 0x0) {
     *   r0 = [r19 contentsDict];
     *   r0 = [r0 retain];
     *   }
     *   else {
     *   r0 = [r19 retain];
     *   }
     *   [r19 release];
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)profileForAppID:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r0 = [self profiles];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r21 = [[r0 objectForKey:r20] retain];
     *   [r20 release];
     *   [r19 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)nameForProfileWithAppID:(id)arg1 {
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
     *   r0 = [arg2 retain];
     *   r19 = r0;
     *   if ([r0 isEqualToString:@"com.codeweavers.unknown"] != 0x0) {
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 localizedStringForKey:@"Unlisted application" value:@"" table:0x0] retain];
     *   }
     *   else {
     *   r0 = [r20 profiles];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 objectForKey:r19];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r21 = [[r0 valueForKey:@"name"] retain];
     *   [r22 release];
     *   ... (5 more lines)
     */
    return nil;
}

- (id)addBottle:(id)arg1 {
    return self->_installTask;
}

- (void)removeBottle:(id)arg1 {
    return;
}

- (void)installedApplicationsReady:(id)arg1 {
    return;
}

- (void)triggerBottleAnalysis {
    return;
}

- (id)recommendedTemplate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [[self templates] retain];
     *   r19 = [[self->_installTask valueForKey:@"new_bottle_template"] retain];
     *   r21 = [[r20 valueForKey:r19] retain];
     *   [r19 release];
     *   [r20 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)useAutorunFile:(id)arg1 {
    return;
}

- (void)autoFillSettings {
    return;
}

- (id)logFileName {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r19 = [[NSMutableArray arrayWithObject:@"Install"] retain];
     *   r0 = [r21 bottleName];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 release];
     *   if (r20 != 0x0) {
     *   r20 = [[r21 bottleName] retain];
     *   [r19 addObject:r20];
     *   [r20 release];
     *   }
     *   r0 = [r21 profile];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if (r0 != 0x0 && ([r21 creatingNewBottle] & 0x1) == 0x0) {
     *   r21 = [[r20 valueForKey:@"name"] retain];
     *   r22 = [[[CXSetupLib cxUtilsClass] sanitizedBottleName:r21] retain];
     *   [r19 addObject:r22];
     *   ... (8 more lines)
     */
    return nil;
}

- (id)newInstallEngine {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x60;
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
     *   r0 = [self logEnvironment];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if ([r0 length] != 0x0) {
     *   [r20 release];
     *   r21 = [[r19 logEnvironment] retain];
     *   r22 = [[r19 environment] retain];
     *   r20 = [[NSString stringWithFormat:@"%@ %@", r3, r4] retain];
     *   [r22 release];
     *   [r21 release];
     *   }
     *   else {
     *   r0 = [r19 environment];
     *   ... (46 more lines)
     */
    return nil;
}

- (void)addDelegate:(id)arg1 {
    return;
}

- (void)removeDelegate:(id)arg1 {
    return;
}

- (void)forwardDelegateMethod:(SEL)arg1 {
    return;
}

- (void)forwardDelegateMethod:(SEL)arg1 withObject:(id)arg2 {
    return;
}

- (void)profileMediaAdded:(id)arg1 {
    return;
}

- (void)profileMediaRemoved:(id)arg1 {
    return;
}

- (void)profileChanged {
    return;
}

- (void)sourceChanged {
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

- (void)categorizedBottle:(id)arg1 {
    return;
}

- (void)categorizedAllBottles {
    return;
}

- (void)analyzedBottle:(id)arg1 {
    return;
}

- (id)installTask {
    return self->_installTask;
}

- (id)delegates {
    return self->_delegates;
}

- (void)setDelegates:(id)arg1 {
    self->_delegates = arg1;
}

- (id)environment {
    return self->_environment;
}

- (void)setEnvironment:(id)arg1 {
    return;
}

- (id)logChannels {
    return self->_logChannels;
}

- (void)setLogChannels:(id)arg1 {
    return;
}

- (id)logEnvironment {
    return self->_logEnvironment;
}

- (void)setLogEnvironment:(id)arg1 {
    return;
}

- (id)logFileURL {
    return self->_logFileURL;
}

- (void)setLogFileURL:(id)arg1 {
    return;
}

- (id)selectedPackage {
    return self->_selectedPackage;
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

@end
