// TaskStatus.m — CrossThrough
#import "TaskStatus.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation TaskStatus

- (id)initWithTask:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)cancel {
    return;
}

- (void)done {
    return;
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

@end
