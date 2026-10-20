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
    return [objc_loadWeakRetained((id *)&self->_loadingLabel) autorelease];
}

- (void)setLoadingLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_loadingLabel, arg1);
}

- (id)progressIndicator {
    return [objc_loadWeakRetained((id *)&self->_progressIndicator) autorelease];
}

- (void)setProgressIndicator:(id)arg1 {
    objc_storeWeak((id *)&self->_progressIndicator, arg1);
}

@end
