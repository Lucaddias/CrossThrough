// IconViewItem.m — CrossThrough
#import "IconViewItem.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation IconViewItem

- (id)init {
    self = [super initWithNibName:@"IconViewItem" bundle:nil];
    return self;
}

- (void)setRepresentedObject:(id)arg1 {
    [super setRepresentedObject:arg1];
    if (!arg1) return;

    NSImage *icon = [arg1 respondsToSelector:@selector(icon)] ? [arg1 icon] : nil;
    if (icon && [self imageView]) {
        [[self imageView] setImage:icon];
    }
    if ([self textField] && [arg1 respondsToSelector:@selector(softwarePackage)]) {
        [[self textField] setStringValue:[arg1 softwarePackage] ?: @""];
    }
}

- (void)setSelected:(BOOL)arg1 {
    [super setSelected:arg1];
    NSView *v = [self view];
    if ([v respondsToSelector:@selector(updateLabelTextColor)]) {
        [v performSelector:@selector(updateLabelTextColor)];
    }
    [v setNeedsDisplay:YES];
}

- (void)setHighlightState:(NSInteger)arg1 {
    [super setHighlightState:arg1];
    NSView *v = [self view];
    if ([v respondsToSelector:@selector(updateLabelTextColor)]) {
        [v performSelector:@selector(updateLabelTextColor)];
    }
    [v setNeedsDisplay:YES];
}

- (id)draggingImageComponents {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x70;
     *   var_50 = d11;
     *   decomp_var_48 = d10;
     *   var_40 = d9;
     *   decomp_var_38 = d8;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   var_60 = self;
     *   r0 = [[&var_60 super] draggingImageComponents];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r19 = [r0 mutableCopy];
     *   [r21 release];
     *   r0 = [r20 textField];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r0 = [r0 stringValue];
     *   r0 = [r0 retain];
     *   ... (90 more lines)
     */
    return nil;
}

@end
