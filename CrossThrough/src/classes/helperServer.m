// helperServer.m — CrossThrough
// Ported from CrossOver 26.3 arm64 (0x100037268..0x1000375f0).
// Distributed Objects server the per-bottle helper apps talk to.
#import "helperServer.h"
#import "CrossThrough.h"

static helperServer *_singleton;

@implementation helperServer

+ (id)defaultHelperServer {
    @synchronized ([helperServer class]) {
        if (_singleton == nil) {
            _singleton = [[helperServer alloc] init];
        }
    }
    return _singleton;
}

- (id)init {
    self = [super init];
    if (self) {
        NSPort *port = [NSPort port];
        _theConnection = [[NSConnection alloc] initWithReceivePort:port sendPort:port];
        [_theConnection setRootObject:[NSProtocolChecker protocolCheckerWithTarget:self protocol:@protocol(HelperServer)]];
        if (![_theConnection registerName:@"com.codeweavers.CrossOver.HelperServer"]) {
            NSLog(@"Failed to register our helper server.  What do we do now?\n");
        }
        isReady = NO;
    }
    return self;
}

- (bycopy id)getEnvironmentForXConnection {
    if (!isReady) {
        return nil;
    }
    NSMutableDictionary *environment = [[[NSProcessInfo processInfo] environment] mutableCopy];
    [environment setObject:[(CXApplication *)NSApp crossOverRoot] forKey:@"CX_ROOT"];
    return environment;
}

- (void)setIsReady {
    isReady = YES;
}

- (BOOL)isServerReady {
    return isReady;
}

- (BOOL)isServerReadyForBottle:(id)arg1 {
    if (!isReady) {
        return NO;
    }
    id bottle = [[[CXSetupLib bottleCollectionClass] sharedCollection] bottleWithName:arg1];
    if (bottle == nil) {
        return NO;
    }
    if ([bottle isIsDisabled]) {
        NSString *reason = [NSString stringWithFormat:@"Bottle \"%@\" is disabled.", [bottle name]];
        @throw [NSException exceptionWithName:@"HelperServerException" reason:reason userInfo:nil];
    }
    return [bottle isCanRunCommands];
}

- (oneway void)raiseWindowsWithTag:(NSInteger)arg1 {
    [NSApp arrangeInFront:nil];
}

- (id)theConnection {
    @synchronized (self) {
        return _theConnection;
    }
}

- (void)setTheConnection:(id)arg1 {
    @synchronized (self) {
        _theConnection = arg1;
    }
}

@end
