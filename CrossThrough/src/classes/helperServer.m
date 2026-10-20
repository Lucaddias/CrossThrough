// helperServer.m — CrossThrough
#import "helperServer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static helperServer *_singleton = nil;

@implementation helperServer

+ (id)defaultHelperServer {
    @synchronized([helperServer class]) {
        if (!_singleton) {
            _singleton = [[helperServer alloc] init];
        }
    }
    return _singleton;
}

- (id)init {
    self = [super init];
    if (self) {
        NSPort *port = [NSPort port];
        self->_theConnection = [[NSConnection alloc] initWithReceivePort:port sendPort:port];
        // Only the HelperServer protocol is reachable by clients.
        [self->_theConnection setRootObject:[NSProtocolChecker protocolCheckerWithTarget:self protocol:@protocol(HelperServer)]];
        if (![self->_theConnection registerName:@"com.codeweavers.CrossOver.HelperServer"]) {
            NSLog(@"Failed to register our helper server.  What do we do now?\n");
        }
        self->isReady = NO;
    }
    return self;
}

- (bycopy id)getEnvironmentForXConnection {
    if (!self->isReady) {
        return nil;
    }
    NSMutableDictionary *environment = [[[[NSProcessInfo processInfo] environment] mutableCopy] autorelease];
    [environment setObject:[(CXApplication *)NSApp crossOverRoot] forKey:@"CX_ROOT"];
    return environment;
}

- (void)setIsReady {
    self->isReady = YES;
}

- (BOOL)isServerReady {
    return self->isReady;
}

- (BOOL)isServerReadyForBottle:(id)arg1 {
    if (!self->isReady) {
        return NO;
    }
    BottleWrapper *bottle = [[[CXSetupLib bottleCollectionClass] sharedCollection] bottleWithName:arg1];
    if (!bottle) {
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
    return [[self->_theConnection retain] autorelease];
}

- (void)setTheConnection:(id)arg1 {
    if (self->_theConnection != arg1) {
        [self->_theConnection release];
        self->_theConnection = [arg1 retain];
    }
}

- (void)dealloc {
    [self->_theConnection release];
    [super dealloc];
}

@end
