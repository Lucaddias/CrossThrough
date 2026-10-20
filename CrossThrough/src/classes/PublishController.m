// PublishController.m — CrossThrough
#import "PublishController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

#import <SecurityFoundation/SFAuthorization.h>

@implementation PublishController

+ (id)keyPathsForValuesAffectingNameCollides {
    return [NSSet setWithObject:@"bottleName"];
}

+ (id)keyPathsForValuesAffectingCanPublish {
    return [NSSet setWithObjects:@"bottleName", @"nameCollides", nil];
}

- (id)init {
    return [super initWithWindowNibName:@"Publish"];
}

- (void)setBottleName:(id)arg1 {
    if (self->_bottleName != arg1) {
        NSString *old = self->_bottleName;
        self->_bottleName = [[arg1 stringInFileSystemRepresentationForm] copy];
        [old release];
    }
}

- (void)setupGUI {
    [self setIsWorking:NO];
    [self setBounceUtil:[NSString stringWithFormat:@"%@/bin/cxbounce", [(CXApplication *)NSApp crossOverRoot]]];
}

- (void)publishPressed:(id)arg1 {
    // Publishing copies the bottle into the system-wide managed scope, which
    // needs admin rights.
    SFAuthorization *authorization = [[SFAuthorization alloc] init];
    [self setAuthorization:authorization];
    [authorization release];
    AuthorizationFlags flags = kAuthorizationFlagInteractionAllowed | kAuthorizationFlagExtendRights | kAuthorizationFlagPreAuthorize;
    if ([[self authorization] obtainWithRight:"system.privilege.admin" flags:flags error:NULL]) {
        [self setIsWorking:YES];
        [NSThread detachNewThreadSelector:@selector(doPublish) toTarget:self withObject:nil];
    }
}

- (void)doPublish {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSArray *arguments = [self publishArguments];
    char *argv[9];
    NSUInteger count = MIN([arguments count], (NSUInteger)8);
    for (NSUInteger i = 0; i < count; i++) {
        argv[i] = (char *)[[arguments objectAtIndex:i] UTF8String];
    }
    argv[count] = NULL;

    FILE *pipe = NULL;
    OSStatus status = AuthorizationExecuteWithPrivileges([[self authorization] authorizationRef], [[self bounceUtil] fileSystemRepresentation], kAuthorizationFlagDefaults, argv, &pipe);
    if (status == errAuthorizationSuccess) {
        char buffer[1024];
        while (read(fileno(pipe), buffer, sizeof(buffer)) > 0) {
        }
        fclose(pipe);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[CXSetupLib bottleCollectionClass] sharedCollection] refresh];
            [self setIsWorking:NO];
            [self exitSuccess:nil];
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setIsWorking:NO];
            [self publishFailed];
        });
    }
    [pool drain];
}

- (void)publishFailed {
    NSAlert *alert = [[[NSAlert alloc] init] autorelease];
    [alert setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Bottle publish failed" value:@"" table:nil]];
    [alert beginSheetModalForWindow:[self window] completionHandler:nil];
}

- (void)exitSuccess:(id)arg1 {
    [[self window] close];
    [[NSApplication sharedApplication] endSheet:[self window] returnCode:1];
}

- (void)cancelPressed:(id)arg1 {
    [[self window] close];
    [[NSApplication sharedApplication] endSheet:[self window] returnCode:0];
}

- (BOOL)nameCollides {
    if ([[self bottleName] length] == 0) {
        return NO;
    }
    return ![[[CXSetupLib bottleQueryClass] isValidNewBottleName:[self bottleName]] boolValue];
}

- (BOOL)canPublish {
    if ([[self bottleName] length] == 0) {
        return NO;
    }
    return ![self nameCollides];
}

- (void)setSourceBottle:(id)arg1 {
    if (self->_sourceBottle != arg1) {
        NSString *old = self->_sourceBottle;
        self->_sourceBottle = [arg1 copy];
        [old release];
        NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"published_%@" value:@"" table:nil];
        [self setBottleName:[[CXSetupLib bottleQueryClass] uniqueBottleName:[NSString stringWithFormat:format, arg1]]];
    }
}

- (id)bottleName {
    return self->_bottleName;
}

- (id)bounceUtil {
    return self->_bounceUtil;
}

- (void)setBounceUtil:(id)arg1 {
    if (self->_bounceUtil != arg1) {
        [self->_bounceUtil release];
        self->_bounceUtil = [arg1 copy];
    }
}

- (id)sourceBottle {
    return self->_sourceBottle;
}

- (id)authorization {
    return [[self->_authorization retain] autorelease];
}

- (void)setAuthorization:(id)arg1 {
    if (self->_authorization != arg1) {
        [self->_authorization release];
        self->_authorization = [arg1 retain];
    }
}

- (BOOL)isWorking {
    return self->_isWorking;
}

- (void)setIsWorking:(BOOL)arg1 {
    self->_isWorking = arg1;
}

- (void)dealloc {
    [self->_bottleName release];
    [self->_bounceUtil release];
    [self->_sourceBottle release];
    [self->_authorization release];
    [super dealloc];
}

- (NSArray *)publishArguments {
    // cxbounce runs "cxbottle --copy <source> --bottle <name> --scope managed --install".
    return @[@"cxbottle", @"--copy", [self sourceBottle] ?: @"", @"--bottle", [self bottleName] ?: @"",
             @"--scope", @"managed", @"--install"];
}

@end
