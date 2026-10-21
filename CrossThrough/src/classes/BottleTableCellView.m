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

// The default bottle is shown in bold, including any attributed title.
- (void)updateTextField {
    BOOL isDefault = [[(BottleNode *)[self objectValue] bottle] isIsDefault];
    NSFontTraitMask trait = isDefault ? NSBoldFontMask : NSUnboldFontMask;
    NSCell *cell = [[self textField] cell];
    [cell setFont:[[NSFontManager sharedFontManager] convertFont:[cell font] toHaveTrait:trait]];

    id value = [[self textField] objectValue];
    if ([value isKindOfClass:[NSAttributedString class]]) {
        NSMutableAttributedString *title = [[value mutableCopy] autorelease];
        [value enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, [value length]) options:0 usingBlock:^(id font, NSRange range, BOOL *stop) {
            NSFont *converted = [[NSFontManager sharedFontManager] convertFont:font toHaveTrait:trait];
            if (converted) {
                [title addAttribute:NSFontAttributeName value:converted range:range];
            }
        }];
        [[self textField] setAttributedStringValue:title];
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
    return [objc_loadWeakRetained((id *)&self->_needsUpgradeButton) autorelease];
}

- (void)setNeedsUpgradeButton:(id)arg1 {
    objc_storeWeak((id *)&self->_needsUpgradeButton, arg1);
}

@end
