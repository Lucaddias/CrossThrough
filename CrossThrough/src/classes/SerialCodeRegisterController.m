// SerialCodeRegisterController.m — CrossThrough
#import "SerialCodeRegisterController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation SerialCodeRegisterController

- (id)init {
    self = [super initWithWindowNibName:@"SerialCodeRegister"];
    if (self) {
        self->_regController = [[RegistrationController alloc] init];
    }
    return self;
}

- (void)registerWithSerialCode:(id)arg1 {
    [self->_regController beginRegisterAppWithSerialCodeWithCompletionHandler:^(BOOL success, NSString *title, NSString *message) {
        if (!title) {
            if (success) {
                [self exitSuccess];
            }
            return;
        }
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert setMessageText:title];
        [alert setInformativeText:message];
        [alert beginSheetModalForWindow:[self window] completionHandler:^(NSModalResponse returnCode) {
            if (success) {
                [self exitSuccess];
            }
        }];
    }];
}

- (void)exitSuccess {
    if ([[self window] isSheet]) {
        [[NSApplication sharedApplication] endSheet:[self window] returnCode:1];
    } else {
        [[self window] close];
    }
}

- (void)cancel:(id)arg1 {
    [self->_regController cancel];
    if ([[self window] isSheet]) {
        [[NSApplication sharedApplication] endSheet:[self window] returnCode:0];
    } else {
        [[self window] close];
    }
}

- (void)openNormalRegistrationWindow:(id)arg1 {
    // Return code 3 asks the presenter to show the account sign-in sheet.
    [[NSApplication sharedApplication] endSheet:[self window] returnCode:3];
}

- (id)regController {
    return self->_regController;
}

- (void)dealloc {
    [self->_regController release];
    [super dealloc];
}

@end
