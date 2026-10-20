// LaunchFeedbackInfo.m — CrossThrough
#import "LaunchFeedbackInfo.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

#include <sys/socket.h>
#include <sys/un.h>

@implementation LaunchFeedbackInfo

- (id)initWithIcon:(id)arg1 {
    self = [super init];
    if (self == nil) {
        return nil;
    }

    // The launched app connects to this socket to say it has finished starting.
    int fd = -1;
    struct sockaddr_un address;
    memset(&address, 0, sizeof(address));
    address.sun_family = AF_UNIX;
    const char *path = tmpnam(NULL);
    if (path == NULL || strlcpy(address.sun_path, path, sizeof(address.sun_path)) >= sizeof(address.sun_path)
        || (fd = socket(AF_UNIX, SOCK_STREAM, 0)) < 0
        || bind(fd, (struct sockaddr *)&address, sizeof(address)) != 0
        || listen(fd, 5) != 0) {
        NSLog(@"%s: failed to set up socket; errno %d", __PRETTY_FUNCTION__, errno);
        if (fd >= 0) {
            close(fd);
        }
        [self release];
        return nil;
    }

    self->socketHandle = [[NSFileHandle alloc] initWithFileDescriptor:fd closeOnDealloc:YES];
    if (self->socketHandle == nil) {
        close(fd);
        [self release];
        return nil;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectionAccepted:)
                                                 name:NSFileHandleConnectionAcceptedNotification
                                               object:self->socketHandle];
    [self->socketHandle acceptConnectionInBackgroundAndNotify];

    self->socketPath = [[[NSFileManager defaultManager] stringWithFileSystemRepresentation:path length:strlen(path)] retain];
    if (self->socketPath == nil) {
        [self release];
        return nil;
    }
    self->badgeIcon = [arg1 copy];
    [self->badgeIcon setSize:NSMakeSize(32.0, 32.0)];
    self->lifeCounter = 0;
    return self;
}

- (void)dealloc {
    if (self->socketPath != nil) {
        unlink([self->socketPath fileSystemRepresentation]);
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self->socketHandle closeFile];
    [self->socketHandle release];
    [self->socketPath release];
    [self->badgeIcon release];
    [super dealloc];
}

- (NSInteger)lifeCounter {
    return self->lifeCounter;
}

- (void)setLifeCounter:(NSInteger)arg1 {
    self->lifeCounter = arg1;
}

- (id)socketPath {
    return self->socketPath;
}

- (id)badgeIcon {
    return self->badgeIcon;
}

- (BOOL)notified {
    return self->notified;
}

- (void)setNotified:(BOOL)arg1 {
    self->notified = arg1;
}

- (void)connectionAccepted:(id)arg1 {
    NSFileHandle *connection = [[arg1 userInfo] objectForKey:NSFileHandleNotificationFileHandleItem];
    @try {
        NSData *data = [connection readDataOfLength:sizeof(uint32_t)];
        uint32_t response = 0;
        [data getBytes:&response length:sizeof(response)];
        if ([data length] != sizeof(response) || response != 0x121) {
            NSLog(@"%s: got an unexpected launch-notify response: %u/0x%08x\n", __PRETTY_FUNCTION__, (unsigned)[data length], response);
        }
    } @catch (NSException *exception) {
        NSLog(@"%s: exception trying to read from connection: %@", __PRETTY_FUNCTION__, exception);
    }
    [self setNotified:YES];
}

@end
