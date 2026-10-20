// SummaryDetail.m — CrossThrough
#import "SummaryDetail.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation SummaryDetail

+ (id)detailWithType:(NSInteger)arg1 label:(id)arg2 action:(SEL)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r22 = [arg3 retain];
     *   r0 = [[SummaryDetail alloc] init];
     *   r21 = r0;
     *   [r0 setType:arg2];
     *   [r21 setLabel:r22];
     *   [r22 release];
     *   [r21 setAction:arg4];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (NSInteger)type {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = *(int32_t *)(int64_t *)&self->_type;
     *   return r0;
     */
    return 0;
}

- (void)setType:(NSInteger)arg1 {
    return;
}

- (id)label {
    return self->_label;
}

- (void)setLabel:(id)arg1 {
    return;
}

- (SEL)action {
    return self->_action;
}

- (void)setAction:(SEL)arg1 {
    return;
}

- (id)image {
    return self->_image;
}

- (void)setImage:(id)arg1 {
    self->_image = arg1;
}

@end
