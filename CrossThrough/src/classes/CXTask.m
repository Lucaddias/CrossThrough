// CXTask.m — CrossThrough
#import "CXTask.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXTask

+ (id)argumentsWithStringsReplacedBySpecialStrings:(id)arg1 {
    NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:[arg1 count]];
    for (id argument in arg1) {
        if ([argument isKindOfClass:[NSString class]]) {
            CXTaskSpecialString *special = [[CXTaskSpecialString alloc] initWithString:argument];
            [arguments addObject:special];
            [special release];
        } else {
            [arguments addObject:argument];
        }
    }
    return arguments;
}

+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2 {
    NSArray *arguments = [self argumentsWithStringsReplacedBySpecialStrings:arg2];
    NSTask *task = [NSTask launchedTaskWithLaunchPath:arg1 arguments:arguments];
    return [[[[self class] alloc] initWithTask:task] autorelease];
}

- (id)initWithTask:(id)arg1 {
    self->realTask = [arg1 retain];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cxtaskObserveRealTaskTermination:) name:NSTaskDidTerminateNotification object:self->realTask];
    return self;
}

- (id)init {
    NSTask *task = [[NSTask alloc] init];
    self = [self initWithTask:task];
    [task release];
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self->realTask release];
    [super dealloc];
}

- (void)cxtaskObserveRealTaskTermination:(id)arg1 {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
    [center postNotificationName:[arg1 name] object:self];
}

- (void)setArguments:(id)arg1 {
    [self->realTask setArguments:[[self class] argumentsWithStringsReplacedBySpecialStrings:arg1]];
}

- (id)forwardingTargetForSelector:(SEL)arg1 {
    return self->realTask;
}

@end
