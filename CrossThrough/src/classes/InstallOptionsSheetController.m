// InstallOptionsSheetController.m — CrossThrough
#import "InstallOptionsSheetController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallOptionsSheetController

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

- (void)updateLogFileName {
    return;
}

- (void)addDependenciesOfApp:(id)arg1 fromReasons:(id)arg2 to:(id)arg3 {
    return;
}

- (void)addDependenciesForReason:(id)arg1 fromMap:(id)arg2 reasonString:(id)arg3 removedString:(id)arg4 to:(id)arg5 {
    return;
}

- (void)fillDependencyList {
    return;
}

- (void)done:(id)arg1 {
    return;
}

- (void)removeInstallDependency:(id)arg1 {
    return;
}

- (void)reAddDependency:(id)arg1 {
    return;
}

- (void)revertInstallDependencies:(id)arg1 {
    return;
}

- (void)showAddDependenciesPopover:(id)arg1 {
    return;
}

- (void)updateLanguages {
    return;
}

- (void)selectAppLanguage:(id)arg1 {
    return;
}

- (void)windowWillClose:(id)arg1 {
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

- (void)bottleNameChanged {
    return;
}

- (void)bottleNewnameChanged {
    return;
}

- (void)bottleTemplateChanged {
    return;
}

- (void)analyzedBottle:(id)arg1 {
    return;
}

- (id)installDependencyTable {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installDependencyTable);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallDependencyTable:(id)arg1 {
    return;
}

- (id)installDependencyArrayController {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_installDependencyArrayController);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setInstallDependencyArrayController:(id)arg1 {
    return;
}

- (id)appLanguagePopUp {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_appLanguagePopUp);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setAppLanguagePopUp:(id)arg1 {
    return;
}

- (id)stackView {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_stackView);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setStackView:(id)arg1 {
    return;
}

- (id)dependencies {
    return self->_dependencies;
}

- (void)setDependencies:(id)arg1 {
    return;
}

- (id)installConfiguration {
    return self->_installConfiguration;
}

- (id)loggingOptions {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_loggingOptions)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setLoggingOptions:(id)arg1 {
    return;
}

- (id)logFileURL {
    return self->_logFileURL;
}

- (NSInteger)numberOfLanguages {
    return self->_numberOfLanguages;
}

- (void)setNumberOfLanguages:(NSInteger)arg1 {
    return;
}

- (id)environment {
    return self->_environment;
}

- (void)setEnvironment:(id)arg1 {
    return;
}

@end
