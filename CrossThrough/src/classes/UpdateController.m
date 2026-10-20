// UpdateController.m — CrossThrough
#import "UpdateController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "c_functions.h"

#import <SecurityFoundation/SFAuthorization.h>

@implementation UpdateController

- (id)initWithManagedBottles:(id)arg1 {
    self = [super initWithWindowNibName:@"Update"];
    if (self) {
        [self setManagedBottlesToUpgrade:([arg1 count] != 0 ? arg1 : nil)];
        [self setUpgradeInProgress:NO];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    NSMutableArray *constraints = [NSMutableArray array];
    if ([[self messageTextField] isHiddenOrHasHiddenAncestor]) {
        [constraints addObject:[self messageToTableSpacing]];
    }
    if ([[self bottleTableScrollView] isHiddenOrHasHiddenAncestor]) {
        [constraints addObject:[self tableToUpgradingSpacing]];
    }
    if ([constraints count] != 0) {
        [[[self window] contentView] removeConstraints:constraints];
    }
    if ([self managedBottlesToUpgrade] == nil) {
        [self finish];
    }
}

- (void)finish {
    if ([NSApp modalWindow] == [self window]) {
        [NSApp abortModal];
    }
    [self close];
}

- (void)updatePressed:(id)arg1 {
    [self setUpgradeInProgress:YES];
    SFAuthorization *authorization = [SFAuthorization authorization];
    AuthorizationFlags flags = kAuthorizationFlagInteractionAllowed | kAuthorizationFlagExtendRights | kAuthorizationFlagPreAuthorize;
    if ([authorization obtainWithRight:"system.privilege.admin" flags:flags error:NULL]) {
        [NSThread detachNewThreadSelector:@selector(doUpdateWithAuthorization:) toTarget:self withObject:authorization];
    } else {
        [self setUpgradeInProgress:NO];
    }
}

- (void)doUpdateWithAuthorization:(id)arg1 {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    for (BottleWrapper *bottle in [self managedBottlesToUpgrade]) {
        _CXLog(@"Updating %@\n", [bottle name]);
        [self updateBottle:bottle WithAuthorization:arg1];
    }
    [self performSelectorOnMainThread:@selector(finish) withObject:nil waitUntilDone:NO];
    [pool drain];
}

- (void)updateBottle:(id)arg1 WithAuthorization:(id)arg2 {
    NSString *binDirectory = [[(CXApplication *)NSApp crossOverRoot] stringByAppendingPathComponent:@"bin"];
    if ([arg1 isIsManaged]) {
        if (arg2 == nil) {
            NSLog(@"We're trying to update a mananged bottle but we aren't authorized.\n");
            return;
        }
        // Managed bottles live in a root-owned prefix, so the update runs through cxbounce.
        NSString *bounceUtil = [binDirectory stringByAppendingPathComponent:@"cxbounce"];
        NSArray *arguments = [self managedUpdateArgumentsForBottleName:[arg1 name]];
        char *argv[8];
        NSUInteger count = MIN([arguments count], (NSUInteger)7);
        for (NSUInteger i = 0; i < count; i++) {
            argv[i] = (char *)[[arguments objectAtIndex:i] UTF8String];
        }
        argv[count] = NULL;

        FILE *pipe = NULL;
        OSStatus status = AuthorizationExecuteWithPrivileges([arg2 authorizationRef], [bounceUtil fileSystemRepresentation], kAuthorizationFlagDefaults, argv, &pipe);
        if (status != errAuthorizationSuccess) {
            NSLog(@"Update of %@ failed.\n", [arg1 name]);
        } else {
            NSString *output = @"";
            if (pipe != NULL) {
                char buffer[1025];
                ssize_t length;
                while ((length = read(fileno(pipe), buffer, sizeof(buffer) - 1)) > 0) {
                    buffer[length] = '\0';
                    output = [output stringByAppendingFormat:@"%s", buffer];
                }
            }
            if ([output length] != 0) {
                NSLog(@"Output from update: %@\n", output);
            }
            if (pipe != NULL) {
                fclose(pipe);
            }
        }
    } else {
        NSString *wine = [binDirectory stringByAppendingPathComponent:@"wine"];
        NSArray *arguments = [NSArray arrayWithObjects:@"--bottle", [arg1 name], @"--ux-app", @"true", nil];
        [[CXTask launchedTaskWithLaunchPath:wine arguments:arguments] waitUntilExit];
    }
    [arg1 performSelectorOnMainThread:@selector(refreshUpToDate) withObject:nil waitUntilDone:YES];
}

- (void)updateLaterPressed:(id)arg1 {
    [self finish];
}

- (id)messageTextField {
    return [objc_loadWeakRetained((id *)&self->_messageTextField) autorelease];
}

- (void)setMessageTextField:(id)arg1 {
    objc_storeWeak((id *)&self->_messageTextField, arg1);
}

- (id)bottleTableScrollView {
    return [objc_loadWeakRetained((id *)&self->_bottleTableScrollView) autorelease];
}

- (void)setBottleTableScrollView:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleTableScrollView, arg1);
}

- (id)messageToTableSpacing {
    return [objc_loadWeakRetained((id *)&self->_messageToTableSpacing) autorelease];
}

- (void)setMessageToTableSpacing:(id)arg1 {
    objc_storeWeak((id *)&self->_messageToTableSpacing, arg1);
}

- (id)tableToUpgradingSpacing {
    return [objc_loadWeakRetained((id *)&self->_tableToUpgradingSpacing) autorelease];
}

- (void)setTableToUpgradingSpacing:(id)arg1 {
    objc_storeWeak((id *)&self->_tableToUpgradingSpacing, arg1);
}

- (id)managedBottlesToUpgrade {
    return [[self->_managedBottlesToUpgrade retain] autorelease];
}

- (void)setManagedBottlesToUpgrade:(id)arg1 {
    if (self->_managedBottlesToUpgrade != arg1) {
        [self->_managedBottlesToUpgrade release];
        self->_managedBottlesToUpgrade = [arg1 retain];
    }
}

- (BOOL)upgradeInProgress {
    return self->_upgradeInProgress;
}

- (void)setUpgradeInProgress:(BOOL)arg1 {
    self->_upgradeInProgress = arg1;
}

- (void)dealloc {
    objc_destroyWeak((id *)&self->_messageTextField);
    objc_destroyWeak((id *)&self->_bottleTableScrollView);
    objc_destroyWeak((id *)&self->_messageToTableSpacing);
    objc_destroyWeak((id *)&self->_tableToUpgradingSpacing);
    [self->_managedBottlesToUpgrade release];
    [super dealloc];
}

- (NSArray *)managedUpdateArgumentsForBottleName:(NSString *)arg1 {
    return [NSArray arrayWithObjects:@"wine", @"--bottle", arg1, @"--scope", @"managed", @"--ux-app", @"true", nil];
}

@end
