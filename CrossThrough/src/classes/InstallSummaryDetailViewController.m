// InstallSummaryDetailViewController.m — CrossThrough
#import "InstallSummaryDetailViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallSummaryDetailViewController

+ (id)keyPathsForValuesAffectingHasAction {
    return [NSSet setWithObject:@"action"];
}

- (id)init {
    self = [super initWithNibName:@"InstallSummaryDetailView" bundle:nil];
    return self;
}

- (void)dealloc {
    objc_destroyWeak((id *)&self->_editButton);
    objc_destroyWeak((id *)&self->_delegate);
    [self->_text release];
    self->_text = nil;
    [self->_image release];
    self->_image = nil;
    [super dealloc];
}

- (BOOL)hasAction {
    return self->_action != NULL;
}

- (void)select:(id)arg1 {
    if (self->_action != NULL) {
        id del = [self delegate];
        if ([del respondsToSelector:self->_action]) {
            [del performSelector:self->_action withObject:arg1];
        }
    }
}

- (void)setSendsActionOnMouseDown:(BOOL)arg1 {
    self->_sendsActionOnMouseDown = arg1;
    NSButton *button = [self editButton];
    if (button) {
        [button sendActionOn:(arg1 ? NSEventMaskLeftMouseDown : NSEventMaskLeftMouseUp)];
    }
}

- (void)setButtonEnabled:(BOOL)arg1 {
    self->_buttonEnabled = arg1;
    NSButton *button = [self editButton];
    if (button) {
        [button setEnabled:arg1];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSendsActionOnMouseDown:[self sendsActionOnMouseDown]];
    [self setButtonEnabled:[self buttonEnabled]];
}

- (id)delegate {
    return objc_loadWeakRetained((id *)&self->_delegate);
}

- (void)setDelegate:(id)arg1 {
    objc_storeWeak((id *)&self->_delegate, arg1);
}

- (id)image {
    return self->_image;
}

- (void)setImage:(id)arg1 {
    if (self->_image != arg1) {
        [self->_image release];
        self->_image = [arg1 copy];
    }
}

- (id)text {
    return self->_text;
}

- (void)setText:(id)arg1 {
    if (self->_text != arg1) {
        [self->_text release];
        self->_text = [arg1 copy];
    }
}

- (SEL)action {
    return self->_action;
}

- (void)setAction:(SEL)arg1 {
    self->_action = arg1;
}

- (BOOL)sendsActionOnMouseDown {
    return self->_sendsActionOnMouseDown;
}

- (BOOL)buttonEnabled {
    return self->_buttonEnabled;
}

- (id)editButton {
    return objc_loadWeakRetained((id *)&self->_editButton);
}

- (void)setEditButton:(id)arg1 {
    objc_storeWeak((id *)&self->_editButton, arg1);
}

@end
