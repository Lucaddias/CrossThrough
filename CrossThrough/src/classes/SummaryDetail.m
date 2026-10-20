// SummaryDetail.m — CrossThrough
#import "SummaryDetail.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation SummaryDetail

+ (id)detailWithType:(NSInteger)arg1 label:(id)arg2 action:(SEL)arg3 {
    SummaryDetail *detail = [[SummaryDetail alloc] init];
    [detail setType:arg1];
    [detail setLabel:arg2];
    [detail setAction:arg3];
    return [detail autorelease];
}

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    [self->_label release];
    self->_label = nil;
    [self->_image release];
    self->_image = nil;
    [super dealloc];
}

- (NSInteger)type {
    return self->_type;
}

- (void)setType:(NSInteger)arg1 {
    self->_type = arg1;
}

- (id)label {
    return self->_label;
}

- (void)setLabel:(id)arg1 {
    if (self->_label != arg1) {
        [self->_label release];
        self->_label = [arg1 copy];
    }
}

- (SEL)action {
    return self->_action;
}

- (void)setAction:(SEL)arg1 {
    self->_action = arg1;
}

- (id)image {
    return self->_image;
}

- (void)setImage:(id)arg1 {
    if (self->_image != arg1) {
        [self->_image release];
        self->_image = [arg1 retain];
    }
}

@end
