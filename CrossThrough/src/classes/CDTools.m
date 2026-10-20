// CDTools.m — CrossThrough
#import "CDTools.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CDTools

+ (BOOL)isValidInstallerVolume:(id)arg1 requireRemovable:(BOOL)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x170;
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
     *   r21 = arg3;
     *   r27 = self;
     *   var_60 = **___stack_chk_guard;
     *   r19 = [arg2 retain];
     *   r0 = [NSFileManager defaultManager];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   [r0 fileExistsAtPath:r19 isDirectory:&var_E1];
     *   [r20 release];
     *   asm { ccmp       w23, #0x0, #0x0, ne };
     *   if (!asm { ccmp       w23, #0x0, #0x0, ne }) {
     *   if ([r19 compare:@"/"] != 0x0) {
     *   ... (1367 more lines)
     */
    return NO;
}

+ (BOOL)isValidInstallerVolume:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self isValidInstallerVolume:arg2 requireRemovable:0x0];
     *   return r0;
     */
    return NO;
}

+ (void)removeCDHelper {
    return;
}

+ (id)getListOfAppsHelpedByTheCDHelper {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x170;
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
     *   r0 = [NSArray arrayWithObjects:@"CrossOver"];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   var_128 = [[NSMutableArray arrayWithCapacity:[r0 count]] retain];
     *   r20 = [[NSMutableSet setWithCapacity:[r21 count]] retain];
     *   var_120 = q0;
     *   var_110 = q0;
     *   r0 = [r21 retain];
     *   r21 = r0;
     *   r3 = &decomp_var_e0;
     *   r0 = [r0 countByEnumeratingWithState:&var_120 objects:r3 count:0x10];
     *   ... (35 more lines)
     */
    return nil;
}

+ (void)removeCDHelperAndPrefsForAllInstalls {
    return;
}

+ (id)identifyInstallablePackagesForVolume:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r19 = [[[CXSetupLib c4ProfilesClass] profilesSet] retain];
     *   r21 = [[[CXSetupLib cdDetectorClass] findMatchingProfilesForVolume:r20 inProfiles:r19] retain];
     *   [r20 release];
     *   [r19 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

@end
