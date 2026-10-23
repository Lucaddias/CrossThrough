// CXTask.m — CrossThrough
// Ported from CrossOver 26.3 arm64 (0x100039774..0x100039bf4).
// NSTask proxy that wraps string arguments in CXTaskSpecialString and re-posts
// the termination notification with itself as the object.
#import "CXTask.h"
#import "CrossThrough.h"

@implementation CXTask

+ (id)argumentsWithStringsReplacedBySpecialStrings:(id)arg1 {
    NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:[arg1 count]];
    for (id argument in arg1) {
        if ([argument isKindOfClass:[NSString class]]) {
            [arguments addObject:[[CXTaskSpecialString alloc] initWithString:argument]];
        } else {
            [arguments addObject:argument];
        }
    }
    return arguments;
}

+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2 {
    NSArray *arguments = [self argumentsWithStringsReplacedBySpecialStrings:arg2];
    NSTask *task = [NSTask launchedTaskWithLaunchPath:arg1 arguments:arguments];
    return [[[self class] alloc] initWithTask:task];
}

- (id)initWithTask:(id)arg1 {
    realTask = arg1;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cxtaskObserveRealTaskTermination:)
                                                 name:NSTaskDidTerminateNotification
                                               object:realTask];
    return self;
}

- (id)init {
    return [self initWithTask:[[NSTask alloc] init]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)cxtaskObserveRealTaskTermination:(id)arg1 {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    [center postNotificationName:[arg1 name] object:self];
}

- (void)setArguments:(id)arg1 {
    [realTask setArguments:[[self class] argumentsWithStringsReplacedBySpecialStrings:arg1]];
}

- (id)forwardingTargetForSelector:(SEL)arg1 {
    return realTask;
}

@end
