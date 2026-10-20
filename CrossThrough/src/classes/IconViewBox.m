// IconViewBox.m — CrossThrough
#import "IconViewBox.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation IconViewBox

- (void)dealloc {
    return;
}

- (id)pathForIconHighlight {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self item];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 imageView];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   NSInsetRect([r0 frame], r1, r2);
     *   [r20 release];
     *   [r19 release];
     *   r0 = [NSBezierPath bezierPathWithRoundedRect:r2 xRadius:r3 yRadius:r4];
     *   return r0;
     */
    return nil;
}

- (id)pathForLabelHighlight {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self item];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 textField];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 frame];
     *   [r20 release];
     *   [r19 release];
     *   r0 = [NSBezierPath bezierPathWithRoundedRect:r2 xRadius:r3 yRadius:r4];
     *   return r0;
     */
    return nil;
}

- (id)menuForEvent:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r19 = [arg2 retain];
     *   var_30 = r20;
     *   r0 = [[&var_30 super] menuForEvent:r19];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   if (r0 == 0x0) {
     *   r0 = [r20 item];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 collectionView];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r21 = [[r0 menuForEvent:r19] retain];
     *   [r22 release];
     *   [r20 release];
     *   }
     *   [r19 release];
     *   ... (2 more lines)
     */
    return nil;
}

- (id)hitTest:(NSPoint)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   {r2:r3} = arg2;
     *   r31 = r31 - 0x60;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r22 = self;
     *   var_50 = self;
     *   r0 = [[&var_50 super] hitTest:r2];
     *   r19 = [r0 retain];
     *   r0 = [r22 item];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 textField] retain];
     *   r0 = r19;
     *   if (r19 != r21) {
     *   r0 = [r22 item];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   ... (50 more lines)
     */
    return nil;
}

- (BOOL)isHighlighted {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r22 = self;
     *   r0 = [self item];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 isSelected];
     *   r21 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r22 item];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if ([r0 highlightState] == 0x2) {
     *   r0 = [r22 item];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   if ([r0 highlightState] == 0x1) {
     *   r22 = 0x1;
     *   ... (29 more lines)
     */
    return NO;
}

- (void)drawRect:(NSRect)arg1 {
    return;
}

- (void)updateLabelTextColor {
    return;
}

- (void)viewDidMoveToWindow {
    return;
}

- (void)viewWillMoveToWindow:(id)arg1 {
    return;
}

- (BOOL)hasDarkModeApppearance {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x50;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_28 = **___stack_chk_guard;
     *   r19 = [[self effectiveAppearance] retain];
     *   r8 = *_NSAppearanceNameAqua;
     *   r9 = *_NSAppearanceNameDarkAqua;
     *   r8 = *r8;
     *   r20 = *r9;
     *   var_38 = r8;
     *   r0 = [NSArray arrayWithObjects:&var_38 count:0x2];
     *   r21 = [r0 retain];
     *   r22 = [[r19 bestMatchFromAppearancesWithNames:r21] retain];
     *   [r21 release];
     *   [r19 release];
     *   r19 = [r22 isEqualToString:r20];
     *   r0 = [r22 release];
     *   if (**___stack_chk_guard != var_28) {
     *   __stack_chk_fail();
     *   }
     *   r0 = r19;
     *   ... (1 more lines)
     */
    return NO;
}

- (void)keyStatusDidChange {
    return;
}

- (void)rightMouseDown:(id)arg1 {
    return;
}

- (id)auxField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_auxField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setAuxField:(id)arg1 {
    return;
}

- (id)item {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_item);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setItem:(id)arg1 {
    return;
}

@end
