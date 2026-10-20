// CXDisclosureView.m — CrossThrough
#import "CXDisclosureView.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXDisclosureView

- (id)initWithFrame:(NSRect)arg1 {
    self = [super initWithFrame:arg1];
    if (self) {
        [self finishInit];
    }
    return self;
}

- (id)initWithCoder:(id)arg1 {
    self = [super initWithCoder:arg1];
    if (self) {
        [self finishInit];
    }
    return self;
}

- (void)finishInit {
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self setDisclosureTriangle:[NSButton buttonWithTitle:@" " target:self action:@selector(disclosureTriangleClicked:)]];
    [[self disclosureTriangle] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self disclosureTriangle] setBezelStyle:NSBezelStyleDisclosure];
    [[self disclosureTriangle] setButtonType:NSButtonTypeOnOff];
    [self addSubview:[self disclosureTriangle]];

    if (!self->_title) {
        self->_title = @"";
    }
    [self setTitleButton:[NSButton buttonWithTitle:self->_title target:self action:@selector(titleButtonClicked:)]];
    [[self titleButton] setContentTintColor:[NSColor headerColor]];
    [[self titleButton] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self titleButton] setBordered:NO];
    [[self titleButton] setAlignment:NSTextAlignmentLeft];
    [[self titleButton] setLineBreakMode:NSLineBreakByTruncatingTail];
    [[self titleButton] setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSControlSizeSmall] weight:NSFontWeightSemibold]];
    [self addSubview:[self titleButton]];

    // [title][triangle], with the triangle on the trailing edge.
    [[[[self titleButton] leadingAnchor] constraintEqualToAnchor:[self leadingAnchor]] setActive:YES];
    [[[[self titleButton] topAnchor] constraintEqualToAnchor:[self topAnchor]] setActive:YES];
    [[[[self titleButton] bottomAnchor] constraintEqualToAnchor:[self bottomAnchor]] setActive:YES];
    [[[[self titleButton] rightAnchor] constraintEqualToAnchor:[[self disclosureTriangle] leftAnchor]] setActive:YES];
    [[[[self disclosureTriangle] centerYAnchor] constraintEqualToAnchor:[[self titleButton] centerYAnchor]] setActive:YES];
    [[[[self disclosureTriangle] rightAnchor] constraintEqualToAnchor:[self rightAnchor]] setActive:YES];

    // Restore the saved state, else keep any state set from the nib, else open.
    NSNumber *saved = [self autosaveName] ? [[NSUserDefaults standardUserDefaults] objectForKey:[self autosaveName]] : nil;
    if (saved) {
        [self setOn:[saved boolValue]];
    } else {
        [self setOn:[self gotOnState] ? [self isOn] : YES];
    }
}

- (void)setTitle:(id)arg1 {
    NSString *old = self->_title;
    self->_title = [arg1 copy];
    [old release];
    [[self titleButton] setTitle:self->_title];
    [self invalidateIntrinsicContentSize];
}

- (void)setOn:(BOOL)arg1 {
    self->_gotOnState = YES;
    self->_on = arg1;
    [[self disclosureTriangle] setState:arg1 ? NSControlStateValueOn : NSControlStateValueOff];
    [[self detailView] setHidden:!arg1];
    if ([self autosaveName]) {
        [[NSUserDefaults standardUserDefaults] setBool:arg1 forKey:[self autosaveName]];
    }
}

- (void)setAutosaveName:(id)arg1 {
    NSString *old = self->_autosaveName;
    self->_autosaveName = [arg1 copy];
    [old release];
    if (!self->_autosaveName) {
        return;
    }
    NSNumber *saved = [[NSUserDefaults standardUserDefaults] objectForKey:[self autosaveName]];
    if (saved) {
        [self setOn:[saved boolValue]];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:[self isOn] forKey:[self autosaveName]];
    }
}

- (void)setDetailView:(id)arg1 {
    objc_storeWeak((id *)&self->_detailView, arg1);
    [[self detailView] setHidden:![self isOn]];
}

- (void)disclosureTriangleClicked:(id)arg1 {
    [self setOn:![self isOn]];
}

- (void)titleButtonClicked:(id)arg1 {
    [[self disclosureTriangle] performClick:nil];
}

- (NSSize)intrinsicContentSize {
    CGFloat height = [[self titleButton] intrinsicContentSize].height;
    return NSMakeSize(NSMaxX([(NSButton *)[self disclosureTriangle] frame]), height);
}

- (void)prepareForInterfaceBuilder {
    [self invalidateIntrinsicContentSize];
    [super prepareForInterfaceBuilder];
}

- (id)title {
    return self->_title;
}

- (BOOL)isOn {
    return self->_on;
}

- (id)detailView {
    return [objc_loadWeakRetained((id *)&self->_detailView) autorelease];
}

- (id)autosaveName {
    return self->_autosaveName;
}

- (BOOL)gotOnState {
    return self->_gotOnState;
}

- (void)setGotOnState:(BOOL)arg1 {
    self->_gotOnState = arg1;
}

- (id)disclosureTriangle {
    return self->_disclosureTriangle;
}

- (void)setDisclosureTriangle:(id)arg1 {
    if (self->_disclosureTriangle != arg1) {
        [self->_disclosureTriangle release];
        self->_disclosureTriangle = [arg1 retain];
    }
}

- (id)titleButton {
    return self->_titleButton;
}

- (void)setTitleButton:(id)arg1 {
    if (self->_titleButton != arg1) {
        [self->_titleButton release];
        self->_titleButton = [arg1 retain];
    }
}

- (void)dealloc {
    [self->_title release];
    [self->_autosaveName release];
    [self->_disclosureTriangle release];
    [self->_titleButton release];
    objc_destroyWeak((id *)&self->_detailView);
    [super dealloc];
}

@end
