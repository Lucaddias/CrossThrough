// CXTask.m — CrossThrough
#import "CXTask.h"
#import "CXTaskSpecialString.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXTask

+ (id)argumentsWithStringsReplacedBySpecialStrings:(id)arg1 {
    if (!arg1) return nil;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[arg1 count]];
    for (id item in arg1) {
        if ([item isKindOfClass:[NSString class]]) {
            CXTaskSpecialString *special = [[CXTaskSpecialString alloc] initWithString:item];
            [result addObject:special];
            [special release];
        } else {
            [result addObject:item];
        }
    }
    return result;
}

+ (id)launchedTaskWithLaunchPath:(id)arg1 arguments:(id)arg2 {
    NSArray *specialArgs = [self argumentsWithStringsReplacedBySpecialStrings:arg2];
    NSTask *task = [NSTask launchedTaskWithLaunchPath:arg1 arguments:specialArgs];
    return [[[self alloc] initWithTask:task] autorelease];
}

- (id)initWithTask:(id)arg1 {
    self->realTask = [arg1 retain];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cxtaskObserveRealTaskTermination:)
                                                 name:NSTaskDidTerminateNotification
                                               object:self->realTask];
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
    self->realTask = nil;
    [super dealloc];
}

- (void)cxtaskObserveRealTaskTermination:(id)arg1 {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSString *name = [arg1 respondsToSelector:@selector(name)] ? [arg1 name] : NSTaskDidTerminateNotification;
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self];
}

- (void)setArguments:(id)arg1 {
    NSArray *special = [[self class] argumentsWithStringsReplacedBySpecialStrings:arg1];
    [self->realTask setArguments:special];
}

- (void)setTerminationHandler:(id)arg1 {
    [self->realTask setTerminationHandler:arg1];
}

- (void)setLaunchPath:(NSString *)path { [self->realTask setLaunchPath:path]; }
- (NSString *)launchPath { return [self->realTask launchPath]; }
- (void)setCurrentDirectoryPath:(NSString *)path { [self->realTask setCurrentDirectoryPath:path]; }
- (NSString *)currentDirectoryPath { return [self->realTask currentDirectoryPath]; }
- (void)setStandardInput:(id)input { [self->realTask setStandardInput:input]; }
- (id)standardInput { return [self->realTask standardInput]; }
- (void)setStandardOutput:(id)output { [self->realTask setStandardOutput:output]; }
- (id)standardOutput { return [self->realTask standardOutput]; }
- (void)setStandardError:(id)error { [self->realTask setStandardError:error]; }
- (id)standardError { return [self->realTask standardError]; }
- (void)setEnvironment:(NSDictionary *)env { [self->realTask setEnvironment:env]; }
- (NSDictionary *)environment { return [self->realTask environment]; }
- (void)launch { [self->realTask launch]; }
- (void)waitUntilExit { [self->realTask waitUntilExit]; }
- (int)terminationStatus { return [self->realTask terminationStatus]; }
- (BOOL)isRunning { return [self->realTask isRunning]; }
- (void)terminate { [self->realTask terminate]; }
- (void)interrupt { [self->realTask interrupt]; }
- (id)arguments { return [self->realTask arguments]; }
- (int)processIdentifier { return [self->realTask processIdentifier]; }

- (id)forwardingTargetForSelector:(SEL)arg1 {
    return self->realTask;
}

@end
