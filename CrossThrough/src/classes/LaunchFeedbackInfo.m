// LaunchFeedbackInfo.m — CrossThrough
// Ported from CrossOver 26.3 arm64 (0x10003fe98..0x10004034c).
// A launched Windows program connects to socketPath (CX_LAUNCH_NOTIFY_SOCKET)
// and writes 0x121 once it is up, which ends the Dock badge animation.
#import "LaunchFeedbackInfo.h"
#import "CrossThrough.h"
#import <sys/socket.h>
#import <sys/un.h>

@implementation LaunchFeedbackInfo

- (id)initWithIcon:(id)arg1 {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    struct sockaddr_un address;
    memset(&address, 0, sizeof(address));
    address.sun_len = sizeof(address);
    address.sun_family = AF_UNIX;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    const char *name = tmpnam(NULL);
#pragma clang diagnostic pop
    if (name == NULL || strlcpy(address.sun_path, name, sizeof(address.sun_path)) >= sizeof(address.sun_path)) {
        if (name != NULL) {
            errno = ENAMETOOLONG;
        }
        NSLog(@"%s: failed to set up socket; errno %d", __func__, errno);
        return nil;
    }
    int fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (fd < 0 || bind(fd, (struct sockaddr *)&address, sizeof(address)) != 0 || listen(fd, 5) != 0) {
        NSLog(@"%s: failed to set up socket; errno %d", __func__, errno);
        if (fd >= 0) {
            close(fd);
        }
        return nil;
    }
    socketHandle = [[NSFileHandle alloc] initWithFileDescriptor:fd closeOnDealloc:YES];
    if (socketHandle == nil) {
        close(fd);
        return nil;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectionAccepted:)
                                                 name:NSFileHandleConnectionAcceptedNotification
                                               object:socketHandle];
    [socketHandle acceptConnectionInBackgroundAndNotify];
    socketPath = [[NSFileManager defaultManager] stringWithFileSystemRepresentation:name length:strlen(name)];
    if (socketPath == nil) {
        return nil;
    }
    badgeIcon = [arg1 copy];
    [badgeIcon setSize:NSMakeSize(32.0, 32.0)];
    lifeCounter = 0;
    return self;
}

- (void)dealloc {
    if (socketPath != nil) {
        unlink([socketPath fileSystemRepresentation]);
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [socketHandle closeFile];
}

- (int)lifeCounter {
    return lifeCounter;
}

- (void)setLifeCounter:(int)arg1 {
    lifeCounter = arg1;
}

- (id)socketPath {
    return socketPath;
}

- (id)badgeIcon {
    return badgeIcon;
}

- (BOOL)notified {
    return notified;
}

- (void)setNotified:(BOOL)arg1 {
    notified = arg1;
}

- (void)connectionAccepted:(id)arg1 {
    NSFileHandle *connection = [[arg1 userInfo] objectForKey:NSFileHandleNotificationFileHandleItem];
    uint32_t response = 0;
    NSData *data = [connection readDataOfLength:4];
    [data getBytes:&response length:4];
    if ([data length] != 4 || response != 0x121) {
        NSLog(@"%s: got an unexpected launch-notify response: %u/0x%08x\n", __func__, (unsigned)[data length], response);
    }
    [self setNotified:YES];
}

@end
