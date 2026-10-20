// CXServer.m — CrossThrough
#import "CXServer.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXServer

+ (id)getCellarID {
    /*
     * Decompiled from CrossOver 26.3:
     *   return @"CrossOver";
     */
    return nil;
}

+ (id)getAppSupportDir {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = NSSearchPathForDirectoriesInDomains(0xe, 0x1, 0x1);
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 objectAtIndex:0x0] retain];
     *   [r20 release];
     *   r19 = [[self getCellarID] retain];
     *   r20 = [[r21 stringByAppendingPathComponent:r19] retain];
     *   [r19 release];
     *   [r21 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)getCachesDir {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = NSSearchPathForDirectoriesInDomains(0xd, 0x1, 0x1);
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 objectAtIndex:0x0] retain];
     *   [r19 release];
     *   r19 = [[r20 stringByAppendingPathComponent:@"com.codeweavers.CrossOver"] retain];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)getDefaultBottleDir {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXServer getAppSupportDir];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 stringByAppendingPathComponent:@"Bottles"] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)getBottleDir {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSUserDefaults standardUserDefaults];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 stringForKey:@"BottleDir"] retain];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)fileTypesForBottle:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r1 = _cmd;
     *   r31 = r31 - 0x1b0;
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
     *   r21 = [arg2 retain];
     *   r20 = [[NSMutableArray arrayWithCapacity:0x4] retain];
     *   var_138 = r21;
     *   r21 = [[r21 winePrefix] retain];
     *   r23 = [[NSString stringWithFormat:@"%@/desktopdata/cxassoc/cxassoc_macosx.plist", r3] retain];
     *   [r21 release];
     *   r19 = [[NSFileManager defaultManager] retain];
     *   r21 = [[r23 stringByResolvingSymlink] retain];
     *   r24 = [[r19 attributesOfItemAtPath:r21 error:0x0] retain];
     *   [r21 release];
     *   ... (127 more lines)
     */
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (id)demoRegisterController {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r20 = sign_extend_64(*(int32_t *)ivar_offset(demoRegisterController));
     *   r0 = *(self + r20);
     *   if (r0 == 0x0) {
     *   r0 = [[DemoRegisterController alloc] init];
     *   r8 = *(r19 + r20);
     *   *(r19 + r20) = r0;
     *   [r8 release];
     *   r0 = *(r19 + r20);
     *   }
     *   r0 = objc_retainAutoreleaseReturnValue(r0);
     *   return r0;
     */
    return nil;
}

- (id)shutdownController {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r20 = sign_extend_64(*(int32_t *)ivar_offset(shutdownController));
     *   r0 = *(self + r20);
     *   if (r0 == 0x0) {
     *   r0 = [[ShutdownController alloc] init];
     *   r8 = *(r19 + r20);
     *   *(r19 + r20) = r0;
     *   [r8 release];
     *   r0 = *(r19 + r20);
     *   }
     *   r0 = objc_retainAutoreleaseReturnValue(r0);
     *   return r0;
     */
    return nil;
}

- (void)doPeriodicDemoNagForCommand:(id)arg1 withArgs:(id)arg2 {
    return;
}

- (void)demoCheck {
    return;
}

- (void)registerDemo:(id)arg1 {
    return;
}

- (BOOL)menusEnabled {
    return self->menusEnabled;
}

- (void)setMenusEnabled:(BOOL)arg1 {
    self->menusEnabled = arg1;
}

- (void)continueFromDemoCheck {
    return;
}

- (id)startAppOp {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [self retain];
     *   r19 = r0;
     *   objc_sync_enter(r0);
     *   r20 = sign_extend_64(*(int32_t *)ivar_offset(startAppOp));
     *   if (*(r19 + r20) == 0x0) {
     *   r0 = [[NSOperation alloc] init];
     *   r8 = *(r19 + r20);
     *   *(r19 + r20) = r0;
     *   [r8 release];
     *   }
     *   objc_sync_exit(r19);
     *   [r19 release];
     *   r0 = *(r19 + r20);
     *   r0 = objc_retainAutoreleaseReturnValue(r0);
     *   return r0;
     */
    return nil;
}

- (void)rosettaCheck {
    return;
}

- (void)applicationWillFinishLaunching:(id)arg1 {
    return;
}

- (void)applicationDidFinishLaunching:(id)arg1 {
    return;
}

- (void)checkForHelperUpdate {
    return;
}

- (void)registerForCooperativeActivation {
    return;
}

- (void)otherWineAppWillActivate:(id)arg1 {
    return;
}

- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   {r2:r3} = arg2;
     *   return 0x0;
     */
    return nil;
}

- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3 {
    return;
}

- (void)finishedLaunches {
    return;
}

- (void)updateLaunchNotify {
    return;
}

- (id)startLaunchNotify:(id)arg1 {
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
     *   r21 = [arg2 retain];
     *   r19 = [[LaunchFeedbackInfo alloc] initWithIcon:r21];
     *   [r21 release];
     *   if (r19 != 0x0) {
     *   [r20->pendingAppLaunches addObject:r19];
     *   r22 = sign_extend_64(*(int32_t *)ivar_offset(launchFeedbackTimer));
     *   r21 = *(r20 + r22);
     *   if (r21 == 0x0) {
     *   r0 = [NSTimer scheduledTimerWithTimeInterval:s0 target:r20 selector:@selector(updateLaunchNotify) userInfo:0x0 repeats:0x1];
     *   r0 = [r0 retain];
     *   r8 = *(r20 + r22);
     *   *(r20 + r22) = r0;
     *   [r8 release];
     *   r21 = *(r20 + r22);
     *   }
     *   r20 = [[NSDate date] retain];
     *   [r21 setFireDate:r20];
     *   ... (6 more lines)
     */
    return nil;
}

- (void)noteTask:(id)arg1 forCommand:(id)arg2 args:(id)arg3 {
    return;
}

- (void)modifyEnvironmentForCommandTask:(id)arg1 {
    return;
}

- (void)forkExecCommand:(id)arg1 {
    return;
}

- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2 {
    return;
}

- (void)observeTaskTermination:(id)arg1 {
    return;
}

- (void)observeTaskErrorOutput:(id)arg1 {
    return;
}

- (void)runClient:(id)arg1 inBottle:(id)arg2 {
    return;
}

- (void)showLicense:(id)arg1 {
    return;
}

- (void)setEnvValue:(id)arg1 forKey:(id)arg2 {
    return;
}

- (void)unsetEnvValueForKey:(id)arg1 {
    return;
}

- (void)setHttpProxyEnvironmentVariableFromSystemConfiguration {
    return;
}

- (void)beginMonitoringSystemConfigurationProxy {
    return;
}

- (id)managedBottlePath {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [NSProcessInfo processInfo];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r0 = [r0 environment];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [[r0 objectForKey:@"CX_MANAGED_BOTTLE_PATH"] retain];
     *   [r21 release];
     *   [r19 release];
     *   if (r20 == 0x0) {
     *   r0 = [NSUserDefaults standardUserDefaults];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r19 = [[r0 objectForKey:@"ManagedBottleDirs"] retain];
     *   [r20 release];
     *   objc_opt_class(@class(NSArray));
     *   if ((objc_opt_isKindOfClass() & 0x1) != 0x0) {
     *   r20 = [[r19 componentsJoinedByString:@":"] retain];
     *   ... (14 more lines)
     */
    return nil;
}

- (void)setEnvironmentVariables {
    return;
}

- (BOOL)validateMenuItem:(id)arg1 {
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
     *   r0 = [arg2 menu];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r19 = [[r0 title] retain];
     *   [r21 release];
     *   if (([r20 menusEnabled] & 0x1) != 0x0) {
     *   r20 = 0x1;
     *   }
     *   else {
     *   if ([r19 compare:@"Help"] == 0x0) {
     *   r20 = 0x1;
     *   }
     *   }
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return NO;
}

- (void)runCommand:(id)arg1 {
    return;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 copyingItemAtURL:(id)arg3 toURL:(id)arg4 {
    /*
     * Decompiled from CrossOver 26.3:
     *   NSLog(@"Error copying %@ to %@: %@", _cmd, arg2, r3);
     *   return 0x0;
     */
    return NO;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 linkingItemAtURL:(id)arg3 toURL:(id)arg4 {
    /*
     * Decompiled from CrossOver 26.3:
     *   NSLog(@"Error linking %@ to %@: %@", _cmd, arg2, r3);
     *   return 0x0;
     */
    return NO;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 movingItemAtURL:(id)arg3 toURL:(id)arg4 {
    /*
     * Decompiled from CrossOver 26.3:
     *   NSLog(@"Error moving %@ to %@: %@", _cmd, arg2, r3);
     *   return 0x0;
     */
    return NO;
}

- (BOOL)fileManager:(id)arg1 shouldProceedAfterError:(id)arg2 removingItemAtURL:(id)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   NSLog(@"Error removing %@: %@", _cmd, arg2);
     *   return 0x0;
     */
    return NO;
}

- (void)replyToApplicationShouldTerminateTrampoline:(id)arg1 {
    return;
}

- (NSUInteger)applicationShouldTerminate:(id)arg1 {
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
     *   r19 = self;
     *   r20 = **_NSApp;
     *   r21 = [arg2 retain];
     *   r20 = [[r20 wineController] retain];
     *   r22 = objc_opt_respondsToSelector();
     *   [r20 release];
     *   if ((r22 & 0x1) != 0x0) {
     *   r0 = **_NSApp;
     *   r0 = [r0 wineController];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [r0 applicationShouldTerminate:r21];
     *   [r21 release];
     *   [r19 release];
     *   }
     *   else {
     *   ... (30 more lines)
     */
    return 0;
}

- (id)applicationIcon {
    /*
     * Decompiled from CrossOver 26.3:
     *   r19 = [[NSWorkspace sharedWorkspace] retain];
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 bundlePath] retain];
     *   r0 = [r19 iconForFile:r21];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r23 = [r0 copy];
     *   [r22 release];
     *   [r21 release];
     *   [r20 release];
     *   [r19 release];
     *   [r23 setSize:r2];
     *   r0 = [r23 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)startedAppGateOp {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self startAppOp];
     *   return r0;
     */
    return nil;
}

- (BOOL)application:(id)arg1 openFile:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r22 = [arg3 retain];
     *   *(int8_t *)(int64_t *)&self->gotLaunchEvent = 0x1;
     *   r0 = [NSAppleEventManager sharedAppleEventManager];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r19 = [[r0 currentAppleEvent] retain];
     *   [r20 release];
     *   r0 = [r19 paramDescriptorForKeyword:0x70726474];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r0 = [r0 descriptorForKeyword:0x42744e6d];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   r24 = [[r0 stringValue] retain];
     *   [r23 release];
     *   var_68 = *__NSConcreteStackBlock;
     *   var_40 = r22;
     *   var_38 = r24;
     *   r24 = [r24 retain];
     *   r22 = [r22 retain];
     *   r0 = [NSBlockOperation blockOperationWithBlock:&var_68];
     *   r23 = [r0 retain];
     *   r21 = [[self startedAppGateOp] retain];
     *   [r23 addDependency:r21];
     *   [r21 release];
     *   ... (13 more lines)
     */
    return NO;
}

- (BOOL)applicationOpenUntitledFile:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   *(int8_t *)(int64_t *)&self->gotLaunchEvent = 0x1;
     *   return 0x1;
     */
    return NO;
}

- (BOOL)applicationShouldOpenUntitledFile:(id)arg1 {
    return YES;
}

- (BOOL)applicationShouldHandleReopen:(id)arg1 hasVisibleWindows:(BOOL)arg2 {
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
     *   r20 = arg3;
     *   r19 = [arg2 retain];
     *   r21 = [[**_NSApp wineController] retain];
     *   r22 = objc_opt_respondsToSelector();
     *   [r21 release];
     *   if ((r22 & 0x1) != 0x0) {
     *   r0 = **_NSApp;
     *   r0 = [r0 wineController];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [r0 applicationShouldHandleReopen:r19 hasVisibleWindows:r20];
     *   [r21 release];
     *   }
     *   else {
     *   r20 = 0x1;
     *   }
     *   ... (3 more lines)
     */
    return NO;
}

- (void)openDocument:(id)arg1 {
    return;
}

- (void)addToRecentItems:(id)arg1 bottle:(id)arg2 {
    return;
}

- (id)makeBottleTaggedName:(id)arg1 withBottleName:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = arg3;
     *   r19 = [arg2 retain];
     *   if (r20 != 0x0) {
     *   r22 = [r20 retain];
     *   r0 = [NSBundle mainBundle];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [[r0 localizedStringForKey:@"%1$@ (%2$@)" value:@"" table:0x0] retain];
     *   [r20 release];
     *   r20 = [[NSString stringWithFormat:r21] retain];
     *   [r22 release];
     *   [r21 release];
     *   }
     *   else {
     *   r20 = [r19 retain];
     *   }
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   ... (1 more lines)
     */
    return nil;
}

- (void)updateRecentItemsMenu {
    return;
}

- (void)openRecent:(id)arg1 {
    return;
}

- (void)clearRecent:(id)arg1 {
    return;
}

- (void)processFirstRun:(BOOL)arg1 {
    return;
}

- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r3 = arg3;
     *   r31 = r31 - 0xc0;
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
     *   r23 = self;
     *   *(int8_t *)(int64_t *)&self->gotLaunchEvent = 0x1;
     *   r0 = [arg2 retain];
     *   r22 = r0;
     *   r0 = [r0 paramDescriptorForKeyword:0x2d2d2d2d];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [[r0 stringValue] retain];
     *   r21 = [[r22 paramDescriptorForKeyword:0x70726474] retain];
     *   [r22 release];
     *   r0 = [r21 descriptorForKeyword:0x42744e6d];
     *   ... (78 more lines)
     */
    return NO;
}

@end
