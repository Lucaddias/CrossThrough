// RosettaInstallationController.m — CrossThrough
#import "RosettaInstallationController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import <mach/machine.h>

@implementation RosettaInstallationController

- (id)init {
    self = [super initWithWindowNibName:@"RosettaInstallation"];
    if (self) {
        self->_detailsShownConstraints = [[NSMutableArray alloc] init];
        self->_detailsHiddenConstraints = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [self->_task release];
    self->_task = nil;
    [self->_detailsShownConstraints release];
    self->_detailsShownConstraints = nil;
    [self->_detailsHiddenConstraints release];
    self->_detailsHiddenConstraints = nil;
    [self->_progressSheet release];
    self->_progressSheet = nil;
    [super dealloc];
}

- (void)findDetailsConstraints:(id)arg1 {
    if (!arg1) return;
    for (NSLayoutConstraint *c in [arg1 constraints]) {
        NSString *ident = [c identifier];
        if (ident) {
            if ([ident containsString:@"detailsShown"]) {
                [[self detailsShownConstraints] addObject:c];
            }
            if ([ident containsString:@"detailsHidden"]) {
                [[self detailsHiddenConstraints] addObject:c];
            }
        }
    }
    for (NSView *sub in [arg1 subviews]) {
        [self findDetailsConstraints:sub];
    }
}

- (void)windowDidLoad {
    [super windowDidLoad];

    NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"To use %1$@, you need to install Rosetta. Do you want to install it now?" value:@"" table:nil];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName] ?: @"CrossOver";
    NSString *title = [NSString stringWithFormat:fmt, appName];
    [[self titleLabel] setStringValue:title];

    NSString *licStr = [[self licenseLabel] stringValue];
    if ([licStr length] > 0) {
        NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        NSMutableAttributedString *mas = [[[self licenseLabel] attributedStringValue] mutableCopy];
        if (mas && detector) {
            [detector enumerateMatchesInString:licStr options:0 range:NSMakeRange(0, [licStr length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                if ([result resultType] == NSTextCheckingTypeLink && [result URL]) {
                    [mas beginEditing];
                    NSDictionary *attrs = @{
                        NSForegroundColorAttributeName: [NSColor linkColor],
                        NSUnderlineStyleAttributeName: @(1)
                    };
                    [mas addAttributes:attrs range:[result range]];
                    [mas addAttribute:NSLinkAttributeName value:[result URL] range:[result range]];
                    [mas endEditing];
                    *stop = YES;
                }
            }];
            [[self licenseLabel] setAttributedStringValue:mas];
            [[self licenseLabel] setAllowsEditingTextAttributes:YES];
            [mas release];
        }
    }

    [self findDetailsConstraints:[[self progressSheet] contentView]];
    [NSLayoutConstraint deactivateConstraints:[self detailsShownConstraints]];
    [NSLayoutConstraint activateConstraints:[self detailsHiddenConstraints]];
}

- (void)exitButton:(id)arg1 {
    exit(0);
}

- (void)installFailed {
    NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Rosetta installation failed. %1$@ is unable to run, and will now quit." value:@"" table:nil];
    NSString *appName = [[NSRunningApplication currentApplication] localizedName] ?: @"CrossOver";
    NSString *msg = [NSString stringWithFormat:fmt, appName];
    [[self progressSheetDetailsLabel] setStringValue:msg];

    NSImage *cautionImg = [NSImage imageNamed:NSImageNameCaution];
    [[self progressSheetIcon] setImage:cautionImg];
    [[self progressSheetDoneButton] setTitle:@"Quit"];
}

- (void)installButton:(id)arg1 {
    NSWindow *win = [self window];
    NSWindow *sheet = [self progressSheet];

    [win beginSheet:sheet completionHandler:^(NSModalResponse returnCode) {
        if ([NSApp modalWindow] == [self window]) {
            [NSApp abortModal];
        }
        [self close];
    }];

    [[self progressSheetProgressIndicator] startAnimation:self];

    NSTask *task = [[NSTask alloc] init];
    [self setTask:task];
    [task release];

    [self->_task setExecutableURL:[NSURL fileURLWithPath:@"/usr/sbin/softwareupdate" isDirectory:NO]];
    [self->_task setArguments:@[@"--install-rosetta", @"--agree-to-license"]];

    __block typeof(self) weakSelf = self;
    [self->_task setTerminationHandler:^(NSTask *t) {
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            if (!strongSelf) return;

            BOOL installed = NO;
#if TARGET_CPU_ARM64
            installed = CFBundleIsArchitectureLoadable(CPU_TYPE_X86_64);
#else
            installed = YES;
#endif
            if (!installed) {
                [strongSelf installFailed];
            } else {
                NSString *doneMsg = [[NSBundle mainBundle] localizedStringForKey:@"Rosetta installation is complete. Click Done to continue." value:@"" table:nil];
                [[strongSelf progressSheetDetailsLabel] setStringValue:doneMsg];
            }

            [[strongSelf progressSheetProgressIndicator] setIndeterminate:NO];
            [[strongSelf progressSheetDoneButton] setEnabled:YES];
        });
    }];

    NSPipe *pipe = [[NSPipe alloc] init];
    NSFileHandle *readHandle = [pipe fileHandleForReading];
    [readHandle setReadabilityHandler:^(NSFileHandle *fh) {
        NSData *data = [fh availableData];
        if ([data length] > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSTextView *tv = [weakSelf progressSheetTextView];
                if (tv) {
                    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    if (s) {
                        [[[tv textStorage] mutableString] appendString:s];
                        [s release];
                        [tv scrollToEndOfDocument:nil];
                    }
                }
            });
        } else {
            [fh setReadabilityHandler:nil];
        }
    }];

    [self->_task setStandardOutput:pipe];
    [self->_task setStandardError:pipe];
    [pipe release];

    NSTextView *tv = [self progressSheetTextView];
    if (tv) {
        [[[tv textStorage] mutableString] setString:@"% softwareupdate --install-rosetta --agree-to-license\n"];
    }

    NSError *err = nil;
    [self->_task launchAndReturnError:&err];
    if (err) {
        if (tv) {
            [[[tv textStorage] mutableString] setString:[err localizedDescription]];
        }
        [self installFailed];
        [[self progressSheetProgressIndicator] setIndeterminate:NO];
        [[self progressSheetDoneButton] setEnabled:YES];
    }
}

- (void)sheetDoneButton:(id)arg1 {
#if TARGET_CPU_ARM64
    if (!CFBundleIsArchitectureLoadable(CPU_TYPE_X86_64)) {
        exit(0);
    }
#endif
    [[self window] endSheet:[self progressSheet]];
}

- (void)sheetDetailDisclosureButton:(id)arg1 {
    NSButton *btn = (NSButton *)arg1;
    NSWindow *sheet = (NSWindow *)[self progressSheet];
    NSRect frame = [sheet frame];
    if ([btn state] == NSControlStateValueOn) {
        NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Hide Details" value:@"" table:nil];
        [[self progressSheetShowHideDetailsButton] setTitle:title];
        frame.size.height += 200.0;
        [[self progressSheetScrollView] setBorderType:NSLineBorder];
        [NSLayoutConstraint deactivateConstraints:[self detailsHiddenConstraints]];
        [NSLayoutConstraint activateConstraints:[self detailsShownConstraints]];
    } else {
        NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Show Details" value:@"" table:nil];
        [[self progressSheetShowHideDetailsButton] setTitle:title];
        frame.size.height -= 200.0;
        [[self progressSheetScrollView] setBorderType:NSNoBorder];
        [NSLayoutConstraint activateConstraints:[self detailsHiddenConstraints]];
        [NSLayoutConstraint deactivateConstraints:[self detailsShownConstraints]];
    }
    [sheet setFrame:frame display:YES animate:YES];
}

- (id)task {
    return self->_task;
}

- (void)setTask:(id)arg1 {
    if (self->_task != arg1) {
        [self->_task release];
        self->_task = [arg1 retain];
    }
}

- (id)detailsShownConstraints {
    return self->_detailsShownConstraints;
}

- (void)setDetailsShownConstraints:(id)arg1 {
    if (self->_detailsShownConstraints != arg1) {
        [self->_detailsShownConstraints release];
        self->_detailsShownConstraints = [arg1 retain];
    }
}

- (id)detailsHiddenConstraints {
    return self->_detailsHiddenConstraints;
}

- (void)setDetailsHiddenConstraints:(id)arg1 {
    if (self->_detailsHiddenConstraints != arg1) {
        [self->_detailsHiddenConstraints release];
        self->_detailsHiddenConstraints = [arg1 retain];
    }
}

- (id)licenseLabel {
    return [objc_loadWeakRetained((id *)&self->_licenseLabel) autorelease];
}

- (void)setLicenseLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_licenseLabel, arg1);
}

- (id)titleLabel {
    return [objc_loadWeakRetained((id *)&self->_titleLabel) autorelease];
}

- (void)setTitleLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_titleLabel, arg1);
}

- (id)progressSheet {
    return self->_progressSheet;
}

- (void)setProgressSheet:(id)arg1 {
    if (self->_progressSheet != arg1) {
        [self->_progressSheet release];
        self->_progressSheet = [arg1 retain];
    }
}

- (id)progressSheetDetailsLabel {
    return [objc_loadWeakRetained((id *)&self->_progressSheetDetailsLabel) autorelease];
}

- (void)setProgressSheetDetailsLabel:(id)arg1 {
    objc_storeWeak((id *)&self->_progressSheetDetailsLabel, arg1);
}

- (id)progressSheetDoneButton {
    return [objc_loadWeakRetained((id *)&self->_progressSheetDoneButton) autorelease];
}

- (void)setProgressSheetDoneButton:(id)arg1 {
    objc_storeWeak((id *)&self->_progressSheetDoneButton, arg1);
}

- (id)progressSheetIcon {
    return [objc_loadWeakRetained((id *)&self->_progressSheetIcon) autorelease];
}

- (void)setProgressSheetIcon:(id)arg1 {
    objc_storeWeak((id *)&self->_progressSheetIcon, arg1);
}

- (id)progressSheetProgressIndicator {
    return [objc_loadWeakRetained((id *)&self->_progressSheetProgressIndicator) autorelease];
}

- (void)setProgressSheetProgressIndicator:(id)arg1 {
    objc_storeWeak((id *)&self->_progressSheetProgressIndicator, arg1);
}

- (id)progressSheetShowHideDetailsButton {
    return [objc_loadWeakRetained((id *)&self->_progressSheetShowHideDetailsButton) autorelease];
}

- (void)setProgressSheetShowHideDetailsButton:(id)arg1 {
    objc_storeWeak((id *)&self->_progressSheetShowHideDetailsButton, arg1);
}

- (id)progressSheetScrollView {
    return [objc_loadWeakRetained((id *)&self->_progressSheetScrollView) autorelease];
}

- (void)setProgressSheetScrollView:(id)arg1 {
    objc_storeWeak((id *)&self->_progressSheetScrollView, arg1);
}

- (id)progressSheetTextView {
    return [objc_loadWeakRetained((id *)&self->_progressSheetTextView) autorelease];
}

- (void)setProgressSheetTextView:(id)arg1 {
    objc_storeWeak((id *)&self->_progressSheetTextView, arg1);
}

@end
