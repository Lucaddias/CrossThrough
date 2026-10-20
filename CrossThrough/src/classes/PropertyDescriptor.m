// PropertyDescriptor.m — CrossThrough
#import "PropertyDescriptor.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PropertyDescriptor

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    [self->_installTaskAttribute release];
    [self->_getter release];
    [self->_setter release];
    [super dealloc];
}

- (id)description {
    return [NSString stringWithFormat:@"%@ installTaskAttribute %@ bool %@ getter %@ setter %@",
            [super description],
            self->_installTaskAttribute,
            self->_boolTyped ? @"YES" : @"NO",
            self->_getter,
            self->_setter];
}

- (id)installTaskAttribute {
    return self->_installTaskAttribute;
}

- (void)setInstallTaskAttribute:(id)arg1 {
    if (self->_installTaskAttribute != arg1) {
        [self->_installTaskAttribute release];
        self->_installTaskAttribute = [arg1 copy];
    }
}

- (BOOL)boolTyped {
    return self->_boolTyped;
}

- (void)setBoolTyped:(BOOL)arg1 {
    self->_boolTyped = arg1;
}

- (id)getter {
    return self->_getter;
}

- (void)setGetter:(id)arg1 {
    if (self->_getter != arg1) {
        [self->_getter release];
        self->_getter = [arg1 copy];
    }
}

- (id)setter {
    return self->_setter;
}

- (void)setSetter:(id)arg1 {
    if (self->_setter != arg1) {
        [self->_setter release];
        self->_setter = [arg1 copy];
    }
}

@end
