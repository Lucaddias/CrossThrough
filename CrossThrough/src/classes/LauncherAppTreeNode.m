// LauncherAppTreeNode.m — CrossThrough
#import "LauncherAppTreeNode.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LauncherAppTreeNode

+ (id)fromLauncher:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r19 = [[self alloc] init];
     *   r21 = [[r20 name] retain];
     *   [r19 setName:r21];
     *   [r21 release];
     *   r21 = [[r20 icon] retain];
     *   [r19 setIcon:r21];
     *   [r21 release];
     *   r21 = [[r20 bottle] retain];
     *   [r19 setBottle:r21];
     *   [r21 release];
     *   [r19 setLauncher:r20];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingPersistentID {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"launcher.bundleID"];
     *   return r0;
     */
    return nil;
}

- (BOOL)isOpenable {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r0 = [self bottle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r21 bottle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   if (([r0 isCanRunCommands] & 0x1) != 0x0) {
     *   r21 = 0x1;
     *   }
     *   else {
     *   r0 = [r21 bottle];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r21 = [r0 isIsDisabled];
     *   [r22 release];
     *   }
     *   ... (8 more lines)
     */
    return NO;
}

- (BOOL)canRunCommands {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [self bottle];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r20 bottle];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [r0 isCanRunCommands];
     *   [r21 release];
     *   }
     *   else {
     *   r20 = 0x1;
     *   }
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return NO;
}

- (id)url {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self launcher];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 url] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)persistentID {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r22 = sign_extend_64(*(int32_t *)ivar_offset(_persistentID));
     *   r0 = *(self + r22);
     *   if (r0 == 0x0) {
     *   r0 = [r19 launcher];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [[r0 bundleID] retain];
     *   [r21 release];
     *   if ([r20 length] != 0x0) {
     *   r0 = [NSString alloc];
     *   r0 = [r0 initWithFormat:@"ProgramLauncherID/%@", r3];
     *   r8 = *(r19 + r22);
     *   *(r19 + r22) = r0;
     *   [r8 release];
     *   }
     *   [r20 release];
     *   r0 = *(r19 + r22);
     *   ... (3 more lines)
     */
    return nil;
}

- (BOOL)canBeFavorite {
    return YES;
}

- (void)openWithErrorHandler:(id)arg1 {
    return;
}

- (id)pasteboardWriter {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self launcher];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 url] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)launcher {
    return self->_launcher;
}

- (void)setLauncher:(id)arg1 {
    self->_launcher = arg1;
}

@end
