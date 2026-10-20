// RunCommandLauncherModeViewController.m — CrossThrough
#import "RunCommandLauncherModeViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation RunCommandLauncherModeViewController

- (id)init {
    self = [super initWithNibName:@"RunCommandLauncherModeView" bundle:nil];
    return self;
}

- (void)loadView {
    [super loadView];
    NSTextField *nameField = [self launcherNameTextField];
    NSImageView *iconView = [self launcherIconImageView];
    if (nameField && iconView && self.view) {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:nameField
                                                                      attribute:NSLayoutAttributeCenterY
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:iconView
                                                                      attribute:NSLayoutAttributeCenterY
                                                                     multiplier:1.0
                                                                       constant:0.0];
        [self.view addConstraint:constraint];
    }
}

- (id)launcherIconImageView {
    return self->_launcherIconImageView;
}

- (void)setLauncherIconImageView:(id)arg1 {
    self->_launcherIconImageView = arg1;
}

- (id)launcherNameTextField {
    return self->_launcherNameTextField;
}

- (void)setLauncherNameTextField:(id)arg1 {
    self->_launcherNameTextField = arg1;
}

@end
