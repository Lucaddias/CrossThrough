// LoadingCrossTieSheetController.m — CrossThrough
#import "LoadingCrossTieSheetController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LoadingCrossTieSheetController

- (id)init {
    return [super initWithWindowNibName:@"LoadingCrossTieSheet"];
}

- (void)setCrossTieDisplayName:(id)arg1 {
    if (self->_crossTieDisplayName != arg1) {
        [self->_crossTieDisplayName release];
        self->_crossTieDisplayName = [arg1 copy];
        [self updateLoadingLabel];
    }
}

- (void)windowDidLoad {
    [super windowDidLoad];
    [self updateLoadingLabel];
    [[self progressIndicator] startAnimation:nil];
}

- (void)updateLoadingLabel {
    if ([self loadingLabel] == nil || [[self crossTieDisplayName] length] == 0) {
        return;
    }
    // The nib label carries a "%@" placeholder; swap it in place to keep its attributes.
    NSMutableAttributedString *label = [[[self loadingLabel] attributedStringValue] mutableCopy];
    NSRange placeholder = [[label string] rangeOfString:@"%@"];
    if (placeholder.location != NSNotFound) {
        [label replaceCharactersInRange:placeholder withString:[self crossTieDisplayName]];
    }
    [[self loadingLabel] setAttributedStringValue:label];
    [label release];
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

- (void)dealloc {
    [self->_crossTieDisplayName release];
    objc_destroyWeak((id *)&self->_loadingLabel);
    objc_destroyWeak((id *)&self->_progressIndicator);
    [super dealloc];
}

@end
