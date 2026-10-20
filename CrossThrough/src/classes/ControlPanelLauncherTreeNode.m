// ControlPanelLauncherTreeNode.m — CrossThrough
#import "ControlPanelLauncherTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation ControlPanelLauncherTreeNode

+ (id)keyPathsForValuesAffectingPersistentID {
    return [NSSet setWithObjects:@"bottle.name", @"controlPanel.exe", nil];
}

+ (id)bottleNameFromPersistentID:(id)arg1 {
    if (!arg1) {
        return nil;
    }
    NSScanner *scanner = [NSScanner scannerWithString:arg1];
    [scanner setCharactersToBeSkipped:nil];
    NSString *bottleName = nil;
    if ([scanner scanString:@"ControlPanelLauncherID/" intoString:NULL] &&
        [scanner scanUpToString:@"/" intoString:&bottleName]) {
        return bottleName;
    }
    return nil;
}

- (void)dealloc {
    [self->_persistentID release];
    [self->_controlPanel release];
    [super dealloc];
}

- (BOOL)isOpenable {
    if (![self bottle]) {
        return YES;
    }
    return [[self bottle] isCanRunCommands];
}

- (id)persistentID {
    if (!self->_persistentID) {
        NSString *bottleName = [[self bottle] name];
        NSString *exe = [[self controlPanel] valueForKey:@"exe"];
        if ([bottleName length] != 0 && [exe length] != 0) {
            self->_persistentID = [[NSString alloc] initWithFormat:@"ControlPanelLauncherID/%@/%@", bottleName, exe];
        }
    }
    return [[self->_persistentID retain] autorelease];
}

- (BOOL)canBeFavorite {
    return YES;
}

- (void)openWithErrorHandler:(id)arg1 {
    LauncherControlPanel *launcher = [LauncherControlPanel launcherWithControlPanel:[self controlPanel] bottle:[self bottle]];
    [launcher launchWithErrorHandler:arg1];
}

- (id)controlPanel {
    return self->_controlPanel;
}

- (void)setControlPanel:(id)arg1 {
    if (self->_controlPanel != arg1) {
        [self->_controlPanel release];
        self->_controlPanel = [arg1 retain];
    }
}

@end
