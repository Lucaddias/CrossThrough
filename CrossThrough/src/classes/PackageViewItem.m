// PackageViewItem.m — CrossThrough
#import "PackageViewItem.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation PackageViewItem

- (id)init {
    self = [super initWithNibName:@"PackageViewItem" bundle:nil];
    return self;
}

- (id)dividerLine {
    return objc_loadWeakRetained((id *)&self->_dividerLine);
}

- (void)setDividerLine:(id)arg1 {
    objc_storeWeak((id *)&self->_dividerLine, arg1);
}

@end
