// LoadingCrossTieSheetController.m — CrossThrough
#import "LoadingCrossTieSheetController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LoadingCrossTieSheetController

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)setCrossTieDisplayName:(id)arg1 {
    return;
}

- (void)windowDidLoad {
    return;
}

- (void)updateLoadingLabel {
    return;
}

- (id)crossTieDisplayName {
    return self->_crossTieDisplayName;
}

- (id)loadingLabel {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_loadingLabel);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setLoadingLabel:(id)arg1 {
    return;
}

- (id)progressIndicator {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressIndicator);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressIndicator:(id)arg1 {
    return;
}

@end
