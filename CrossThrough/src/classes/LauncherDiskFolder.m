// LauncherDiskFolder.m — CrossThrough
#import "LauncherDiskFolder.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherDiskFolder

+ (id)launcherWithFolderURL:(id)arg1 {
    return [[[self alloc] initWithURL:arg1] autorelease];
}

- (id)initWithURL:(id)arg1 {
    NSString *displayName = [[NSFileManager defaultManager] displayNameAtPath:[arg1 path]];
    self = [super initWithName:displayName];
    if (self) {
        self->_url = [arg1 copy];
    }
    return self;
}

- (void)dealloc {
    [self->_url release];
    [super dealloc];
}

- (id)copyWithZone:(void *)arg1 {
    LauncherDiskFolder *copy = [super copyWithZone:arg1];
    [copy setUrl:self->_url];
    return copy;
}

- (id)icon {
    return [[NSWorkspace sharedWorkspace] iconForFile:[[self url] path]];
}

- (id)description {
    return [NSString stringWithFormat:@"%@ url %@", [super description], [self url]];
}

- (id)url {
    return self->_url;
}

- (void)setUrl:(id)arg1 {
    if (self->_url != arg1) {
        [self->_url release];
        self->_url = [arg1 copy];
    }
}

@end
