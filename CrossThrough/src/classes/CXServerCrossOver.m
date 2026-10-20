// CXServerCrossOver.m — CrossThrough
#import "CXServerCrossOver.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXServerCrossOver

+ (id)getDefaultProgramsFolder {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = NSSearchPathForDirectoriesInDomains(0x1, 0x1, 0x1);
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r20 = [[r0 objectAtIndex:0x0] retain];
     *   [r21 release];
     *   if (r20 == 0x0) {
     *   r20 = [[@"~/Applications" stringByExpandingTildeInPath] retain];
     *   }
     *   r19 = [[r19 getCellarID] retain];
     *   r21 = [[r20 stringByAppendingPathComponent:r19] retain];
     *   [r19 release];
     *   [r20 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

+ (id)getProgramsFolder {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x50;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = [[NSUserDefaults standardUserDefaults] retain];
     *   r20 = [[NSFileManager defaultManager] retain];
     *   r0 = [r19 dataForKey:@"ProgramsFolderBookmark"];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r20 pathFromBookmarkData:r23 stale:&var_31];
     *   r21 = [r0 retain];
     *   asm { ccmp       w8, #0x0, #0x4, ne };
     *   if (!asm { ccmp       w8, #0x0, #0x4, ne }) {
     *   if (r21 != 0x0) {
     *   r22 = r23;
     *   r0 = [r19 stringForKey:@"ProgramsFolderPath"];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   if (([r0 isEqualToString:r21] & 0x1) == 0x0) {
     *   ... (59 more lines)
     */
    return nil;
}

+ (id)crossTieModDateString {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x70;
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
     *   r19 = [[NSFileManager defaultManager] retain];
     *   r20 = [[[CXSetupLib c4ProfilesClass] getOnlineFilePath] retain];
     *   if ([r19 fileExistsAtPath:r20] != 0x0) {
     *   r22 = [[r20 stringByResolvingSymlink] retain];
     *   r21 = [[r19 attributesOfItemAtPath:r22 error:0x0] retain];
     *   [r22 release];
     *   r22 = [[r21 objectForKey:**_NSFileModificationDate] retain];
     *   r0 = [[NSDateFormatter alloc] init];
     *   r23 = r0;
     *   [r0 setDateStyle:0x4];
     *   [r23 setTimeStyle:0x1];
     *   r25 = [[r23 stringFromDate:r22] retain];
     *   ... (22 more lines)
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

- (id)preferencesController {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r20 = sign_extend_64(*(int32_t *)ivar_offset(preferencesController));
     *   r0 = *(self + r20);
     *   if (r0 == 0x0) {
     *   r0 = [[PreferencesController alloc] init];
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

- (id)mainWindowController {
    if (!self->mainWindowController) {
        self->mainWindowController = [[MainWindowController alloc] init];
    }
    return self->mainWindowController;
}

- (void)applicationWillFinishLaunching:(id)arg1 {
    [super applicationWillFinishLaunching:arg1];
}

- (void)applicationDidFinishLaunching:(id)arg1 {
    NSLog(@"[CrossThrough] App launched: applicationDidFinishLaunching");
    [NSApp activateIgnoringOtherApps:YES];
    [[self mainWindowController] showWindow:self];
}

- (id)startedAppGateOp {
    return self->updateCheckOp;
}

- (void)openAutoPlayInstallerForC4P:(id)arg1 inBottle:(id)arg2 {
    return;
}

- (void)openAutoPlayInstallerForVolume:(id)arg1 inBottle:(id)arg2 {
    return;
}

- (id)launchFeedbackDrawInfoForImageSize:(NSSize)arg1 {
    return self->dockPrefs;
}

- (void)drawLaunchFeedback:(id)arg1 position:(NSInteger)arg2 info:(id)arg3 {
    return;
}

- (id)startLaunchNotify:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = self->dockPrefs;
     *   r21 = [arg2 retain];
     *   [r20 synchronize];
     *   var_30 = self;
     *   r0 = [[&var_30 super] startLaunchNotify:r21];
     *   r19 = [r0 retain];
     *   [r21 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)forkExecCommand:(id)arg1 withArgs:(id)arg2 {
    return;
}

- (void)runClient:(id)arg1 inBottle:(id)arg2 {
    return;
}

- (void)runClient:(id)arg1 inBottle:(id)arg2 withDialog:(BOOL)arg3 {
    return;
}

- (void)continueFromDemoCheck {
    return;
}

- (BOOL)handleGetURLEvent:(id)arg1 withReplyEvent:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x90;
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
     *   r24 = self;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   r0 = [r19 paramDescriptorForKeyword:0x2d2d2d2d];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   r0 = [r0 stringValue];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   if ([r0 length] != 0x0) {
     *   r0 = [NSURL URLWithString:r22];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   if (r0 != 0x0) {
     *   ... (49 more lines)
     */
    return NO;
}

- (void)handleCrossTieURL:(id)arg1 {
    return;
}

- (void)openScreenSharingHelpPage:(id)arg1 {
    return;
}

- (void)openHelpInBrowser:(id)arg1 {
    return;
}

- (void)showMainWindow:(id)arg1 {
    [NSApp activateIgnoringOtherApps:YES];
    [[self mainWindowController] showWindow:arg1];
}

- (void)showPreferencesWindow:(id)arg1 {
    return;
}

- (void)bottleCollectionChanged {
    return;
}

- (void)runCommand:(id)arg1 {
    return;
}

- (void)rebuildMenus:(id)arg1 {
    return;
}

- (BOOL)validateMenuItem:(id)arg1 {
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
     *   r20 = self;
     *   r19 = [arg2 retain];
     *   r0 = **_NSApp;
     *   r0 = [r0 modalWindow];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   if (r0 != 0x0) {
     *   r23 = 0x1;
     *   }
     *   else {
     *   r0 = r20->mainWindowController;
     *   r0 = [r0 window];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r0 = [r0 attachedSheet];
     *   r0 = [r0 retain];
     *   ... (131 more lines)
     */
    return NO;
}

- (void)refreshProgramsAndAssociationsInBackground:(id)arg1 {
    return;
}

- (void)setRebuildingPrograms:(id)arg1 {
    return;
}

- (void)refreshPrograms:(id)arg1 {
    return;
}

- (void)queueRefreshPrograms:(id)arg1 {
    return;
}

- (void)watchMenuPLists {
    return;
}

- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4 {
    return;
}

- (id)getMenuPList {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x150;
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
     *   r20 = [[NSFileManager defaultManager] retain];
     *   var_130 = [[NSMutableDictionary dictionary] retain];
     *   r22 = [[NSMutableArray array] retain];
     *   [self performSelectorOnMainThread:@selector(duplicateBottleList:) withObject:r22 waitUntilDone:0x1];
     *   var_120 = q0;
     *   var_110 = q0;
     *   r0 = [r22 retain];
     *   r19 = r0;
     *   r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
     *   if (r0 != 0x0) {
     *   r27 = r0;
     *   ... (64 more lines)
     */
    return nil;
}

- (void)addProgramsFromMenuPlist:(id)arg1 bottle:(id)arg2 toDictionary:(id)arg3 atPath:(id)arg4 {
    return;
}

- (void)addProgramsFromMenuPlist:(id)arg1 bottle:(id)arg2 toDictionary:(id)arg3 {
    return;
}

- (BOOL)updateApplicationFolder:(BOOL)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r2 = arg2;
     *   r0 = self;
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
     *   r31 = r31 + 0xffffffffffffffa0 - 0x850;
     *   var_60 = **___stack_chk_guard;
     *   r9 = sign_extend_64(*(int32_t *)ivar_offset(inUpdateApplicationFolder));
     *   if (*(int8_t *)(r0 + r9) != 0x0) {
     *   r26 = 0x0;
     *   }
     *   else {
     *   r25 = r0;
     *   var_7FC = r2;
     *   var_880 = r9;
     *   *(int8_t *)(r0 + r9) = 0x1;
     *   ... (890 more lines)
     */
    return NO;
}

- (id)shortenedBundleID:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0xa0;
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
     *   r0 = [arg2 retain];
     *   r20 = r0;
     *   r0 = [r0 componentsSeparatedByString:@"."];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if ([r0 count] >= 0x5) {
     *   r0 = [r19 objectAtIndex:0x3];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   var_60 = r0;
     *   r3 = [r19 count] - 0x4;
     *   r0 = [r19 subarrayWithRange:0x4];
     *   ... (36 more lines)
     */
    return nil;
}

- (void)createProgramsMenuFromSubmenu:(id)arg1 hasPrograms:(BOOL)arg2 {
    return;
}

- (void)createProgramsMenu:(id)arg1 {
    return;
}

- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2 skippingFiles:(id)arg3 {
    return;
}

- (void)addLaunchersInDir:(id)arg1 toFolder:(id)arg2 {
    return;
}

- (void)addLauncherItems:(id)arg1 toMenu:(id)arg2 {
    return;
}

- (void)duplicateBottleList:(id)arg1 {
    return;
}

- (id)combinedAssociationsPropertyListLatestDate:(id *)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r1 = _cmd;
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
     *   r19 = arg2;
     *   r20 = self;
     *   var_60 = **___stack_chk_guard;
     *   r21 = sign_extend_64(*(int32_t *)ivar_offset(associationPlist));
     *   if (*(self + r21) != 0x0) {
     *   r8 = sign_extend_64(*(int32_t *)ivar_offset(associationPlistDate));
     *   if (*(r20 + r8) == 0x0) {
     *   var_158 = r21;
     *   var_150 = r19;
     *   var_140 = [[NSMutableDictionary alloc] init];
     *   r22 = [[NSDate distantPast] retain];
     *   ... (223 more lines)
     */
    return nil;
}

- (void)addDocumentTypeDictionary:(id)arg1 forBottle:(id)arg2 toBundleArray:(id)arg3 andResourcesDir:(id)arg4 {
    return;
}

- (void)informSystemOfUpdatedApp:(id)arg1 {
    return;
}

- (void)adjustProgramHelpersForChangedAssociations:(id)arg1 {
    return;
}

- (void)refreshAssociations:(BOOL)arg1 {
    return;
}

- (id)getAssociationDictionaryForKey:(id)arg1 withExtensionAssociations:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   r31 = r31 + 0xffffffffffffffb0;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   r0 = [r19 componentsSeparatedByString:@"/"];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   if ([r0 count] >= 0x2) {
     *   r23 = 0x1;
     *   while (true) {
     *   r0 = [r21 objectAtIndex:r23];
     *   r0 = [r0 retain];
     *   r22 = r0;
     *   r25 = [r0 length];
     *   [r22 release];
     *   if (r25 == 0x0) {
     *   ... (201 more lines)
     */
    return nil;
}

- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self setupHelperAppForBottleWithTag:arg2 andName:arg3 andExtensions:arg4 usingExistingHelper:0x0];
     *   return r0;
     */
    return NO;
}

- (id)findBestApplicationForDocType:(id)arg1 withProgramsDict:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0xd0;
     *   var_70 = d11;
     *   decomp_var_68 = d10;
     *   var_60 = d9;
     *   decomp_var_58 = d8;
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
     *   var_98 = self;
     *   r24 = [arg2 retain];
     *   r23 = [arg3 retain];
     *   r21 = [@(0x0) retain];
     *   r20 = [[NSArray arrayWithObjects:r21] retain];
     *   r22 = [[NSArray arrayWithObjects:@"rank"] retain];
     *   r25 = [[NSDictionary dictionaryWithObjects:r20 forKeys:r22] retain];
     *   [r22 release];
     *   ... (304 more lines)
     */
    return nil;
}

- (id)findBestApplicationForDocType:(id)arg1 forBottle:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_50 = r28;
     *   decomp_var_48 = r27;
     *   r31 = r31 + 0xffffffffffffffa0;
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
     *   r21 = [arg3 retain];
     *   r23 = [arg2 retain];
     *   r19 = [[NSUserDefaults standardUserDefaults] retain];
     *   r20 = [[r19 dictionaryForKey:@"MostRecentCXFBMenuPlist"] retain];
     *   [r19 release];
     *   r19 = CFPropertyListCreateDeepCopy(0x0, r20, 0x0);
     *   [r20 release];
     *   r20 = [[r19 objectForKey:r21] retain];
     *   [r21 release];
     *   r0 = [r20 valueForKeyPath:@"Children.StartMenu/.Children"];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   ... (31 more lines)
     */
    return nil;
}

- (id)findMenusForAssociations:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x160;
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
     *   r20 = self;
     *   var_60 = **___stack_chk_guard;
     *   r19 = [arg2 retain];
     *   var_128 = [[NSMutableDictionary dictionary] retain];
     *   var_150 = objc_autoreleasePoolPush();
     *   var_140 = r19;
     *   r0 = [r19 keyEnumerator];
     *   r0 = [r0 retain];
     *   var_148 = r0;
     *   r0 = [r0 nextObject];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   ... (68 more lines)
     */
    return nil;
}

- (BOOL)setupHelperAppForBottleWithTag:(id)arg1 andName:(id)arg2 andExtensions:(id)arg3 usingExistingHelper:(id)arg4 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r3 = arg3;
     *   r1 = _cmd;
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
     *   r31 = r31 + 0xffffffffffffffa0 - 0x1c0;
     *   r22 = r3;
     *   r27 = self;
     *   var_60 = **___stack_chk_guard;
     *   r24 = [arg2 retain];
     *   var_178 = [r22 retain];
     *   r26 = [arg4 retain];
     *   r21 = [arg5 retain];
     *   r0 = [[NSFileManager alloc] init];
     *   r28 = r0;
     *   [r0 setDelegate:r27];
     *   ... (2257 more lines)
     */
    return NO;
}

- (void)launchHelper:(id)arg1 {
    return;
}

- (BOOL)exportProgram:(id)arg1 bundleName:(id)arg2 withDictionary:(id)arg3 toFolder:(id)arg4 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r4 = arg4;
     *   r3 = arg3;
     *   r1 = _cmd;
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
     *   r31 = r31 + 0xffffffffffffffa0 - 0x220;
     *   r21 = r4;
     *   r20 = r3;
     *   var_60 = **___stack_chk_guard;
     *   r25 = [arg2 retain];
     *   r24 = [r20 retain];
     *   r21 = [r21 retain];
     *   r27 = [arg5 retain];
     *   r0 = [[NSFileManager alloc] init];
     *   r23 = r0;
     *   ... (1086 more lines)
     */
    return NO;
}

- (BOOL)createIcnsFile:(id)arg1 fromImageFile:(id)arg2 forApp:(BOOL)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x80;
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
     *   r22 = arg4;
     *   r19 = [arg2 retain];
     *   r0 = [arg3 retain];
     *   r20 = r0;
     *   r0 = CGImageSourceCreateWithURL(r0, 0x0);
     *   if (r0 != 0x0) {
     *   r21 = [CGImageSourceGetType(r0) retain];
     *   CFRelease(r0);
     *   r0 = [NSWorkspace sharedWorkspace];
     *   r0 = [r0 retain];
     *   r23 = r0;
     *   r24 = [r0 type:r21 conformsToType:**_kUTTypeAppleICNS];
     *   [r23 release];
     *   if (r24 != 0x0) {
     *   ... (58 more lines)
     */
    return NO;
}

- (BOOL)applicationOpenUntitledFile:(id)arg1 {
    [NSApp activateIgnoringOtherApps:YES];
    [[self mainWindowController] showWindow:arg1];
    return YES;
}

- (void)runCXUpgrade {
    return;
}

- (void)checkForHelperUpdate {
    return;
}

- (void)processFirstRun:(BOOL)arg1 {
    return;
}

- (id)applicationDockMenu:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self programsMenu];
     *   return r0;
     */
    return nil;
}

- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x1c0;
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
     *   r22 = self;
     *   var_60 = **___stack_chk_guard;
     *   r20 = [arg2 retain];
     *   r23 = [arg3 retain];
     *   r24 = (int64_t *)&r22->nextUpdateItem;
     *   r0 = *r24;
     *   *r24 = 0x0;
     *   [r0 release];
     *   r0 = [NSApplication sharedApplication];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r21 = [[r0 licenseExpirationDate] retain];
     *   ... (291 more lines)
     */
    return nil;
}

- (id)sparkleUpdater {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [CXUpdater sharedUpdater];
     *   return r0;
     */
    return nil;
}

- (void)repairBottles:(id)arg1 {
    return;
}

- (void)repairBottlesDialog:(id)arg1 {
    return;
}

- (id)programsMenu {
    return self->_programsMenu;
}

- (void)setProgramsMenu:(id)arg1 {
    self->_programsMenu = arg1;
}

- (id)publishBottleMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_publishBottleMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setPublishBottleMenuItem:(id)arg1 {
    return;
}

- (id)updateBottleMenuItem {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_updateBottleMenuItem);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setUpdateBottleMenuItem:(id)arg1 {
    return;
}

- (id)launchers {
    return self->_launchers;
}

- (void)setLaunchers:(id)arg1 {
    return;
}

- (id)urlHandler {
    return self->_urlHandler;
}

- (void)setUrlHandler:(id)arg1 {
    self->_urlHandler = arg1;
}

- (id)observedBottles {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_observedBottles)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setObservedBottles:(id)arg1 {
    return;
}

@end
