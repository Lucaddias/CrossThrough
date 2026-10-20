// LauncherControlPanel.m — CrossThrough
#import "LauncherControlPanel.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherControlPanel

+ (id)launcherWithControlPanel:(id)arg1 bottle:(id)arg2 {
    return [[[self alloc] initWithControlPanel:arg1 bottle:arg2] autorelease];
}

- (id)initWithControlPanel:(id)arg1 bottle:(id)arg2 {
    self = [super initWithName:[arg1 valueForKey:@"name"]];
    if (self) {
        self->_controlPanel = [arg1 retain];
        NSString *iconPath = [arg1 valueForKey:@"icon"];
        NSImage *icon = nil;
        if ([iconPath length] != 0) {
            icon = [[[NSImage alloc] initWithContentsOfFile:iconPath] autorelease];
        }
        if (![icon isValid]) {
            icon = [[[NSImage imageNamed:@"exeIcon.icns"] copy] autorelease];
        }
        [self setIcon:icon];
        [self setBottle:arg2];
    }
    return self;
}

- (void)dealloc {
    [self->_controlPanel release];
    [super dealloc];
}

- (id)copyWithZone:(void *)arg1 {
    LauncherControlPanel *copy = [super copyWithZone:arg1];
    if (copy->_controlPanel != self->_controlPanel) {
        [copy->_controlPanel release];
        copy->_controlPanel = [self->_controlPanel retain];
    }
    return copy;
}

- (id)tooltip {
    return [self->_controlPanel valueForKey:@"description"];
}

- (void)launchWithErrorHandler:(id)arg1 {
    void (^errorHandler)(NSError *) = arg1;
    if ([[self bottle] isCanRunCommands]) {
        [self retain];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [[self bottle] launchControlPanelApplet:[self->_controlPanel valueForKey:@"exe"]];
            [self release];
        });
    } else if (errorHandler) {
        NSString *format = [[NSBundle mainBundle] localizedStringForKey:@"The control panel '%1$@' can't be launched because the bottle '%2$@' is unable to run commands at this time." value:@"" table:nil];
        NSString *message = [NSString stringWithFormat:format, [self name], [[self bottle] name]];
        NSError *error = [NSError errorWithDomain:@"com.codeweavers.CrossOver.LauncherItem"
                                             code:1
                                         userInfo:@{NSLocalizedDescriptionKey: message}];
        errorHandler(error);
    }
}

- (id)description {
    return [NSString stringWithFormat:@"%@ control panel %@", [super description], self->_controlPanel];
}

@end
