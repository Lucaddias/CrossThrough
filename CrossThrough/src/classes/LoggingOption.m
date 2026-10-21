// LoggingOption.m — CrossThrough
#import "LoggingOption.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LoggingOption

+ (id)loggingOptionWithName:(id)arg1 channels:(id)arg2 environment:(id)arg3 {
    return [[[self alloc] initWithName:arg1 channels:arg2 environment:arg3] autorelease];
}

+ (id)loggingOptionWithName:(id)arg1 channels:(id)arg2 {
    return [[[self alloc] initWithName:arg1 channels:arg2 environment:@[]] autorelease];
}

+ (id)commonPresets {
    static dispatch_once_t onceToken;
    static NSMutableArray *presets = nil;
    dispatch_once(&onceToken, ^{
        presets = [[NSMutableArray array] retain];
        for (id preset in [[CXSetupLib cxUtilsClass] loggingPresets]) {
            [presets addObject:[self loggingOptionWithName:[preset valueForKey:@"label"]
                                                  channels:[preset valueForKey:@"channels"]
                                               environment:[preset valueForKey:@"environment"]]];
        }
    });
    return [[presets retain] autorelease];
}

- (id)initWithName:(id)arg1 channels:(id)arg2 environment:(id)arg3 {
    self = [super init];
    if (self) {
        self->_name = [arg1 copy];
        self->_logChannels = [arg2 copy];
        self->_logEnvironment = [arg3 copy];
    }
    return self;
}

- (id)name {
    return self->_name;
}

- (void)setName:(id)arg1 {
    if (self->_name != arg1) {
        [self->_name release];
        self->_name = [arg1 copy];
    }
}

- (id)logChannels {
    return self->_logChannels;
}

- (void)setLogChannels:(id)arg1 {
    if (self->_logChannels != arg1) {
        [self->_logChannels release];
        self->_logChannels = [arg1 copy];
    }
}

- (id)logEnvironment {
    return self->_logEnvironment;
}

- (void)setLogEnvironment:(id)arg1 {
    if (self->_logEnvironment != arg1) {
        [self->_logEnvironment release];
        self->_logEnvironment = [arg1 copy];
    }
}

- (void)dealloc {
    [self->_name release];
    [self->_logChannels release];
    [self->_logEnvironment release];
    [super dealloc];
}

@end
