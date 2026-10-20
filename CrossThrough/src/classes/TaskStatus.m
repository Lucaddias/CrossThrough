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
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_label)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setLabel:(id)arg1 {
    return;
}

- (id)task {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_task)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setTask:(id)arg1 {
    return;
}

- (id)installOp {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_installOp)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setInstallOp:(id)arg1 {
    return;
}

@end
