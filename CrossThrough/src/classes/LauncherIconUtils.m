// LauncherIconUtils.m — CrossThrough
#import "LauncherIconUtils.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherIconUtils

+ (id)imageRepsForCXMenuIconsFromURL:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x180;
     *   var_50 = r28;
     *   decomp_var_48 = r27;
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
     *   var_60 = **___stack_chk_guard;
     *   r19 = [arg2 retain];
     *   r0 = [NSMutableArray arrayWithCapacity:0x7];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   [r0 addObject:r19];
     *   r0 = [r19 pathComponents];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 mutableCopy];
     *   [r20 release];
     *   var_108 = *__NSConcreteStackBlock;
     *   ... (64 more lines)
     */
    return nil;
}

+ (CGFloat)percentOfNonTransparentPixelsAlongEdgeOfImageRep:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x60;
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
     *   r19 = [arg2 retain];
     *   r0 = calloc(0x800000, 0x1);
     *   if (r0 != 0x0) {
     *   r20 = r0;
     *   r21 = CGBitmapContextCreate(r0, 0x400, 0x400, 0x8, 0x2000, 0x0, 0x7);
     *   r22 = [[NSGraphicsContext graphicsContextWithCGContext:r21 flipped:0x0] retain];
     *   [NSGraphicsContext setCurrentContext:r22];
     *   [r22 release];
     *   r0 = [NSColor whiteColor];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   [r0 set];
     *   NSFrameRectWithWidth([r22 release], r1);
     *   d0 = 0x0;
     *   ... (64 more lines)
     */
    return 0.0;
}

+ (id)maskIconToRoundRect:(id)arg1 destinationDimension:(NSUInteger)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r1 = _cmd;
     *   r31 = r31 - 0xf0;
     *   var_A0 = d15;
     *   decomp_var_98 = d14;
     *   var_90 = d13;
     *   decomp_var_88 = d12;
     *   var_80 = d11;
     *   decomp_var_78 = d10;
     *   var_70 = d9;
     *   decomp_var_68 = d8;
     *   var_60 = r28;
     *   decomp_var_58 = r27;
     *   var_50 = r26;
     *   decomp_var_48 = r25;
     *   var_40 = r24;
     *   decomp_var_38 = r23;
     *   var_30 = r22;
     *   decomp_var_28 = r21;
     *   var_20 = r20;
     *   decomp_var_18 = r19;
     *   var_10 = r29;
     *   decomp_var_8 = r30;
     *   r20 = arg3;
     *   var_A8 = **___stack_chk_guard;
     *   r22 = [arg2 retain];
     *   ... (67 more lines)
     */
    return nil;
}

+ (BOOL)createIcnsFileAtURL:(id)arg1 fromImageReps:(id)arg2 forApp:(BOOL)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x130;
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
     *   var_48 = **___stack_chk_guard;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   if (arg4 != 0x0) {
     *   r0 = CGImageDestinationCreateWithURL(r19, **_kUTTypeAppleICNS, 0x2, 0x0);
     *   if (r0 != 0x0) {
     *   r21 = r0;
     *   r0 = [r20 sortedArrayUsingSelector:@selector(pixelsHigh)];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   r24 = [[r0 lastObject] retain];
     *   r0 = [r22 maskIconToRoundRect:r24 destinationDimension:0x200];
     *   r0 = [r0 retain];
     *   ... (74 more lines)
     */
    return NO;
}

@end
