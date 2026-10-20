// PackageViewItem.m — CrossThrough
#import "PackageViewItem.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PackageViewItem

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (id)dividerLine {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_dividerLine);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDividerLine:(id)arg1 {
    return;
}

@end
