// TaskStatus.m — CrossThrough
#import "TaskStatus.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation TaskStatus

- (id)initWithTask:(id)arg1 {
    self = [super init];
    if (self) {
        [self setTask:arg1];
        [self setLabel:[[self task] valueForKey:@"label"]];
    }
    return self;
}

- (void)cancel {
    [[self installOp] cancel];
    if ([[(InstallEngineTask *)[self task] canCancel] boolValue]) {
        [(InstallEngineTask *)[self task] cancel];
    }
    [self done];
    [self setSuccess:NO];
}

- (void)done {
    [(InstallEngineTask *)[self task] done];
    [self setFinished:YES];
    [self setInstallOp:nil];
}

- (BOOL)finished {
    return self->_finished;
}

- (void)setFinished:(BOOL)arg1 {
    self->_finished = arg1;
}

- (BOOL)success {
    return self->_success;
}

- (void)setSuccess:(BOOL)arg1 {
    self->_success = arg1;
}

- (id)label {
    return [[self->_label retain] autorelease];
}

- (void)setLabel:(id)arg1 {
    if (self->_label != arg1) {
        [self->_label release];
        self->_label = [arg1 copy];
    }
}

- (id)task {
    return [[self->_task retain] autorelease];
}

- (void)setTask:(id)arg1 {
    if (self->_task != arg1) {
        [self->_task release];
        self->_task = [arg1 retain];
    }
}

- (id)installOp {
    return [[self->_installOp retain] autorelease];
}

- (void)setInstallOp:(id)arg1 {
    if (self->_installOp != arg1) {
        [self->_installOp release];
        self->_installOp = [arg1 retain];
    }
}

- (void)dealloc {
    [self->_label release];
    [self->_task release];
    [self->_installOp release];
    [super dealloc];
}

@end
