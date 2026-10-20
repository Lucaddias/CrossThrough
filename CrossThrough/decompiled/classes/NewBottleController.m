// NewBottleController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001b2f0
// -[NewBottleController init]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_30 = self;
    r0 = [[&var_30 super] initWithWindowNibName:@"NewBottle"];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 localizedStringForKey:@"New Bottle" value:@"" table:0x0] retain];
            [r19 setSuggestedBottleName:r21];
            [r21 release];
            [r20 release];
    }
    r0 = r19;
    return r0;


// 0x10001b3a0
// -[NewBottleController setCopyMode:withBottleToCopy:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r20 = [arg3 retain];
    *(int8_t *)(int64_t *)&r19->_copyMode = arg2;
    r21 = [[r19 window] retain];
    if (arg2 != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 localizedStringForKey:@"Make a Copy of %@" value:@"" table:0x0] retain];
            r24 = [[NSString stringWithFormat:r23] retain];
            [r21 setTitle:r24];
            [r24 release];
            r24 = r20;
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 localizedStringForKey:@"Create a Bottle" value:@"" table:0x0] retain];
            [r21 setTitle:r23];
            r24 = 0x0;
    }
    [r23 release];
    [r22 release];
    [r21 release];
    [r19 setBottleToCopy:r24];
    [r20 release];
    return;


// 0x10001b4f8
// -[NewBottleController setupGUI]
    r31 = r31 - 0xd0;
    var_50 = r28;
    decomp_var_48 = r27;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    var_58 = **___stack_chk_guard;
    [self setIsWorking:0x0];
    r19 = [CXSetupLib bottleQueryClass];
    r21 = [[r20 suggestedBottleName] retain];
    r19 = [[r19 uniqueBottleName:r21] retain];
    [r20 setBottleName:r19];
    [r19 release];
    [r21 release];
    r19 = [[[CXSetupLib bottleManagementClass] templates] retain];
    r0 = [NSMutableArray array];
    r0 = [r0 retain];
    var_B8 = *__NSConcreteStackBlock;
    r0 = [r0 retain];
    r21 = r0;
    var_98 = r0;
    [r19 enumerateObjectsWithOptions:0x2 usingBlock:&var_B8];
    [r20 setTemplateArray:r21];
    objc_unsafeClaimAutoreleasedReturnValue([r20 window]);
    r0 = [r20 sourceBottleLabel];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 isHiddenOrHasHiddenAncestor];
    [r22 release];
    if (r23 != 0x0) {
            r0 = [r20 sourceBottleLabel];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 superview] retain];
            r0 = [r20 nameLabelCopyingLabelWidths];
            r0 = [r0 retain];
            r24 = r0;
            var_68 = r0;
            r25 = [[r20 sourceBottleToCreatingSpacer] retain];
            r0 = [NSArray arrayWithObjects:&var_68 count:0x2];
            r26 = [r0 retain];
            [r23 removeConstraints:r26];
            [r26 release];
            [r25 release];
            [r24 release];
            [r23 release];
            [r22 release];
    }
    r0 = [r20 bottleTypePopUp];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 isHiddenOrHasHiddenAncestor];
    [r22 release];
    if (r23 != 0x0) {
            r0 = [r20 bottleTypePopUp];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 superview] retain];
            r0 = [r20 nameLabelTypeLabelWidths];
            r0 = [r0 retain];
            r24 = r0;
            var_78 = r0;
            r25 = [[r20 typeToCreatingSpacer] retain];
            r0 = [NSArray arrayWithObjects:&var_78 count:0x2];
            r26 = [r0 retain];
            [r23 removeConstraints:r26];
            [r26 release];
            [r25 release];
            [r24 release];
            [r23 release];
            [r22 release];
    }
    r0 = [r20 archivePathControl];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 isHiddenOrHasHiddenAncestor];
    [r22 release];
    if (r23 != 0x0) {
            r0 = [r20 archivePathControl];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 superview] retain];
            r0 = [r20 nameLabelRestoringLabelWidths];
            r0 = [r0 retain];
            r24 = r0;
            var_88 = r0;
            r20 = [[r20 archiveToCreatingSpacer] retain];
            r0 = [NSArray arrayWithObjects:&var_88 count:0x2];
            r25 = [r0 retain];
            [r23 removeConstraints:r25];
            [r25 release];
            [r20 release];
            [r24 release];
            [r23 release];
            [r22 release];
    }
    [var_98 release];
    [r21 release];
    [r19 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x10001ba28
// -[NewBottleController createPressed:]
    [self setIsWorking:0x1];
    [NSThread detachNewThreadSelector:@selector(doCreate) toTarget:self withObject:0x0];
    return;


// 0x10001ba64
// -[NewBottleController doCreate]
    r31 = r31 - 0xa0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = objc_autoreleasePoolPush();
    if ([r20 copyMode] != 0x0) {
            r21 = [CXSetupLib bottleManagementClass];
            r22 = [[r20 bottleName] retain];
            r23 = [[r20 bottleToCopy] retain];
            r0 = [r21 duplicateBottle:r22 fromBottle:r23];
            r0 = [r0 retain];
            r21 = r0;
    }
    else {
            r0 = [r20 archiveURL];
            r0 = [r0 retain];
            r23 = r0;
            [r0 release];
            r21 = [CXSetupLib bottleManagementClass];
            r22 = [[r20 bottleName] retain];
            r0 = r20;
            if (r23 != 0x0) {
                    r0 = [r0 archiveURL];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [[r0 path] retain];
                    r21 = [[r21 restoreBottle:r22 fromArchive:r24] retain];
                    [r24 release];
            }
            else {
                    r23 = [[r0 bottleTemplate] retain];
                    r0 = [r21 createBottle:r22 fromTemplate:r23];
                    r0 = [r0 retain];
                    r21 = r0;
            }
    }
    [r23 release];
    [r22 release];
    r0 = [r21 objectAtIndex:0x0];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [r0 boolValue];
    [r22 release];
    if (r23 != 0x0) {
            var_58 = *__NSConcreteStackBlock;
            dispatch_async(*__dispatch_main_q, &var_58);
    }
    else {
            var_88 = *__NSConcreteStackBlock;
            var_60 = [r21 retain];
            dispatch_async(*__dispatch_main_q, &var_88);
            [var_60 release];
    }
    [r21 release];
    objc_autoreleasePoolPop(r19);
    return;


// 0x10001bdac
// -[NewBottleController createFailed:]
    r21 = [arg2 retain];
    r20 = [[NSAlert alloc] init];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 localizedStringForKey:@"Bottle creation failed" value:@"" table:0x0] retain];
    [r20 setMessageText:r23];
    [r23 release];
    [r22 release];
    [r20 setInformativeText:r21];
    [r21 release];
    r19 = [[self window] retain];
    [r20 beginSheetModalForWindow:r19 completionHandler:0x0];
    [r19 release];
    [r20 release];
    return;


// 0x10001be94
// -[NewBottleController exitSuccess:]
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 close];
    [r20 release];
    r20 = [[NSApplication sharedApplication] retain];
    r19 = [[self window] retain];
    [r20 endSheet:r19 returnCode:0x1];
    [r19 release];
    [r20 release];
    return;


// 0x10001bf14
// -[NewBottleController cancelPressed:]
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 close];
    [r20 release];
    r20 = [[NSApplication sharedApplication] retain];
    r19 = [[self window] retain];
    [r20 endSheet:r19 returnCode:0x0];
    [r19 release];
    [r20 release];
    return;


// 0x10001bf94
// +[NewBottleController keyPathsForValuesAffectingCanCreate]
    r0 = [NSSet setWithObject:@"bottleName"];
    return r0;


// 0x10001bfa8
// -[NewBottleController canCreate]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self bottleName];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 length] != 0x0) {
            r21 = [CXSetupLib bottleQueryClass];
            r22 = [[r20 bottleName] retain];
            r0 = [r21 isValidNewBottleName:r22];
            r0 = [r0 retain];
            r21 = r0;
            r20 = [r0 boolValue];
            [r21 release];
            [r22 release];
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x10001c04c
// -[NewBottleController bottle]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottle)), 0x1);
    return r0;


// 0x10001c05c
// -[NewBottleController setBottle:]
    objc_setProperty_atomic();
    return;


// 0x10001c068
// -[NewBottleController suggestedBottleName]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_suggestedBottleName)), 0x1);
    return r0;


// 0x10001c078
// -[NewBottleController setSuggestedBottleName:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001c084
// -[NewBottleController archiveURL]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_archiveURL)), 0x1);
    return r0;


// 0x10001c094
// -[NewBottleController setArchiveURL:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001c0a0
// -[NewBottleController bottleTypePopUp]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleTypePopUp);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c0c0
// -[NewBottleController setBottleTypePopUp:]
    objc_storeWeak((int64_t *)&self->_bottleTypePopUp, arg2);
    return;


// 0x10001c0d4
// -[NewBottleController nameLabelTypeLabelWidths]
    r0 = objc_loadWeakRetained((int64_t *)&self->_nameLabelTypeLabelWidths);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c0f4
// -[NewBottleController setNameLabelTypeLabelWidths:]
    objc_storeWeak((int64_t *)&self->_nameLabelTypeLabelWidths, arg2);
    return;


// 0x10001c108
// -[NewBottleController typeToCreatingSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_typeToCreatingSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c128
// -[NewBottleController setTypeToCreatingSpacer:]
    objc_storeWeak((int64_t *)&self->_typeToCreatingSpacer, arg2);
    return;


// 0x10001c13c
// -[NewBottleController sourceBottleLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_sourceBottleLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c15c
// -[NewBottleController setSourceBottleLabel:]
    objc_storeWeak((int64_t *)&self->_sourceBottleLabel, arg2);
    return;


// 0x10001c170
// -[NewBottleController nameLabelCopyingLabelWidths]
    r0 = objc_loadWeakRetained((int64_t *)&self->_nameLabelCopyingLabelWidths);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c190
// -[NewBottleController setNameLabelCopyingLabelWidths:]
    objc_storeWeak((int64_t *)&self->_nameLabelCopyingLabelWidths, arg2);
    return;


// 0x10001c1a4
// -[NewBottleController sourceBottleToCreatingSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_sourceBottleToCreatingSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c1c4
// -[NewBottleController setSourceBottleToCreatingSpacer:]
    objc_storeWeak((int64_t *)&self->_sourceBottleToCreatingSpacer, arg2);
    return;


// 0x10001c1d8
// -[NewBottleController archivePathControl]
    r0 = objc_loadWeakRetained((int64_t *)&self->_archivePathControl);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c1f8
// -[NewBottleController setArchivePathControl:]
    objc_storeWeak((int64_t *)&self->_archivePathControl, arg2);
    return;


// 0x10001c20c
// -[NewBottleController nameLabelRestoringLabelWidths]
    r0 = objc_loadWeakRetained((int64_t *)&self->_nameLabelRestoringLabelWidths);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c22c
// -[NewBottleController setNameLabelRestoringLabelWidths:]
    objc_storeWeak((int64_t *)&self->_nameLabelRestoringLabelWidths, arg2);
    return;


// 0x10001c240
// -[NewBottleController archiveToCreatingSpacer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_archiveToCreatingSpacer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001c260
// -[NewBottleController setArchiveToCreatingSpacer:]
    objc_storeWeak((int64_t *)&self->_archiveToCreatingSpacer, arg2);
    return;


// 0x10001c274
// -[NewBottleController bottleName]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleName)), 0x1);
    return r0;


// 0x10001c284
// -[NewBottleController setBottleName:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001c290
// -[NewBottleController bottleToCopy]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleToCopy)), 0x1);
    return r0;


// 0x10001c2a0
// -[NewBottleController setBottleToCopy:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001c2ac
// -[NewBottleController bottleTemplate]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleTemplate)), 0x1);
    return r0;


// 0x10001c2bc
// -[NewBottleController setBottleTemplate:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001c2c8
// -[NewBottleController templateArray]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_templateArray)), 0x1);
    return r0;


// 0x10001c2d8
// -[NewBottleController setTemplateArray:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001c2e4
// -[NewBottleController copyMode]
    r0 = *(int8_t *)(int64_t *)&self->_copyMode & 0x1;
    return r0;


// 0x10001c2f8
// -[NewBottleController isWorking]
    r0 = *(int8_t *)(int64_t *)&self->_isWorking & 0x1;
    return r0;


// 0x10001c30c
// -[NewBottleController setIsWorking:]
    *(int8_t *)(int64_t *)&self->_isWorking = arg2;
    return;


// 0x10001c31c
// -[NewBottleController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_templateArray, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleTemplate, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleToCopy, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleName, 0x0);
    objc_destroyWeak((int64_t *)&self->_archiveToCreatingSpacer);
    objc_destroyWeak((int64_t *)&self->_nameLabelRestoringLabelWidths);
    objc_destroyWeak((int64_t *)&self->_archivePathControl);
    objc_destroyWeak((int64_t *)&self->_sourceBottleToCreatingSpacer);
    objc_destroyWeak((int64_t *)&self->_nameLabelCopyingLabelWidths);
    objc_destroyWeak((int64_t *)&self->_sourceBottleLabel);
    objc_destroyWeak((int64_t *)&self->_typeToCreatingSpacer);
    objc_destroyWeak((int64_t *)&self->_nameLabelTypeLabelWidths);
    objc_destroyWeak((int64_t *)&self->_bottleTypePopUp);
    objc_storeStrong((int64_t *)&self->_archiveURL, 0x0);
    objc_storeStrong((int64_t *)&self->_suggestedBottleName, 0x0);
    objc_storeStrong((int64_t *)&self->_bottle, 0x0);
    return;


// === Block Invocations for NewBottleController ===

// 0x10001b8d8
// ___31-[NewBottleController setupGUI]_block_invoke
    r31 = r31 - 0x80;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg0;
    var_48 = **___stack_chk_guard;
    r19 = [arg1 retain];
    r21 = [[[CXSetupLib bottleManagementClass] displayNameForTemplate:r19] retain];
    var_68 = @"name";
    var_58 = r19;
    r0 = [NSDictionary dictionaryWithObjects:&var_58 forKeys:&var_68 count:0x2];
    r22 = [r0 retain];
    [r20[0x4] addObject:r22];
    r0 = r20[0x5];
    r0 = [r0 bottleTemplate];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r23 = r0;
            r0 = r20[0x5];
            r0 = [r0 bottleTemplate];
            r0 = [r0 retain];
            r24 = r0;
            r25 = [r0 compare:@"win10_64"];
            [r24 release];
            [r23 release];
            if (r25 != 0x0) {
                    [r20[0x5] setBottleTemplate:r19];
            }
    }
    else {
            [r20[0x5] setBottleTemplate:r19];
    }
    [r22 release];
    [r21 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return r0;


// 0x10001bc94
// ___31-[NewBottleController doCreate]_block_invoke
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r20 = r0;
    [r0 refresh];
    [r20 release];
    r20 = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
    r21 = [[arg0[0x4] bottleName] retain];
    r22 = [[r20 bottleWithName:r21] retain];
    [arg0[0x4] setBottle:r22];
    [r22 release];
    [r21 release];
    [r20 release];
    [arg0[0x4] setIsWorking:0x0];
    r0 = arg0[0x4];
    r0 = [r0 exitSuccess:0x0];
    return r0;


// 0x10001bd5c
// ___31-[NewBottleController doCreate]_block_invoke.25
    [arg0[0x4] setIsWorking:0x0];
    r20 = [[arg0[0x5] objectAtIndex:0x1] retain];
    [arg0[0x4] createFailed:r20];
    r0 = [r20 release];
    return r0;


