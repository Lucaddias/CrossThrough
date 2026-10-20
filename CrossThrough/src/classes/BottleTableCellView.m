// BottleTableCellView.m — CrossThrough
#import "BottleTableCellView.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation BottleTableCellView

- (void)dealloc {
    // dealloc
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateTextField];
}

- (void)setBackgroundStyle:(NSInteger)arg1 {
    [super setBackgroundStyle:arg1];
    [[self.textField cell] setBackgroundStyle:arg1];
    [[self.needsUpgradeButton cell] setBackgroundStyle:arg1];
}

- (void)updateTextField {
    id node = [self objectValue];
    id bottle = [node respondsToSelector:@selector(bottle)] ? [node bottle] : nil;
    BOOL isDefault = [bottle respondsToSelector:@selector(isDefault)] ? [bottle isDefault] : NO;
    NSFont *f = [self.textField font] ?: [NSFont systemFontOfSize:13.0];
    NSFontTraitMask trait = isDefault ? NSBoldFontMask : NSUnboldFontMask;
    NSFont *newFont = [[NSFontManager sharedFontManager] convertFont:f toHaveTrait:trait];
    if (newFont) {
        [self.textField setFont:newFont];
    }
}

- (void)viewWillDraw {
    [super viewWillDraw];
    [self updateTextField];
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    [self updateTextField];
}

- (id)needsUpgradeButton {
    return objc_loadWeakRetained((id *)&self->_needsUpgradeButton);
}

- (void)setNeedsUpgradeButton:(id)arg1 {
    objc_storeWeak((id *)&self->_needsUpgradeButton, arg1);
}

@end
