// NoBottleController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100054774
// -[NoBottleController initWithFileToLaunch:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    var_30 = self;
    r0 = [[&var_30 super] initWithWindowNibName:@"NoBottle"];
    r20 = r0;
    if (r0 != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 localizedStringForKey:@"New Bottle" value:@"" table:0x0];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(suggestedBottleName));
            r8 = *(r20 + r9);
            *(r20 + r9) = r0;
            [r8 release];
            [r21 release];
            [r20 setFileToLaunchString:r19];
            r21 = [[NSURL fileURLWithPath:r19] retain];
            [r20 setFileToLaunch:r21];
            [r21 release];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100054878
// -[NoBottleController awakeFromNib]
    [self setIsWorking:0x0];
    r20 = [[[CXSetupLib bottleQueryClass] uniqueBottleName:self->suggestedBottleName] retain];
    [self setNameForNewBottle:r20];
    [r20 release];
    r20 = [[[CXSetupLib bottleManagementClass] templates] retain];
    r0 = [NSMutableArray array];
    r0 = [r0 retain];
    var_50 = *__NSConcreteStackBlock;
    var_30 = r0;
    r21 = [r0 retain];
    [r20 enumerateObjectsWithOptions:0x2 usingBlock:&var_50];
    [self setTemplateArray:r21];
    [var_30 release];
    [r21 release];
    [r20 release];
    return;


// 0x100054acc
// -[NoBottleController createPressed:]
    [self setIsWorking:0x1];
    [NSThread detachNewThreadSelector:@selector(doCreate) toTarget:self withObject:0x0];
    return;


// 0x100054b08
// -[NoBottleController doCreate]
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
    r21 = [CXSetupLib bottleManagementClass];
    r22 = [[r20 nameForNewBottle] retain];
    r23 = [[r20 bottleTemplate] retain];
    r21 = [[r21 createBottle:r22 fromTemplate:r23] retain];
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


// 0x100054cf4
// -[NoBottleController createFailed:]
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


// 0x100054ddc
// -[NoBottleController exitSuccess:]
    r0 = [self window];
    r0 = [r0 retain];
    r19 = r0;
    [r0 close];
    [r19 release];
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r19 = r0;
    [r0 refresh];
    r21 = [[self nameForNewBottle] retain];
    r22 = [[r19 bottleWithName:r21] retain];
    [r21 release];
    [BottleMenuHandler toggleDefaultBottle:r22];
    r0 = [CXApplication sharedApplication];
    r0 = [r0 retain];
    r21 = r0;
    r23 = [[r0 CXServer] retain];
    r24 = [[self fileToLaunchString] retain];
    r20 = [[self nameForNewBottle] retain];
    [r23 runClient:r24 inBottle:r20];
    [r20 release];
    [r24 release];
    [r23 release];
    [r21 release];
    [r22 release];
    [r19 release];
    return;


// 0x100054f14
// -[NoBottleController cancelPressed:]
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


// 0x100054f94
// -[NoBottleController scopeChanged:]
    return;


// 0x100054f98
// +[NoBottleController keyPathsForValuesAffectingCanCreate]
    r0 = [NSSet setWithObject:@"nameForNewBottle"];
    return r0;


// 0x100054fac
// -[NoBottleController canCreate]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self nameForNewBottle];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 length] != 0x0) {
            r20 = 0x1;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x100054fec
// -[NoBottleController fileToLaunch]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_fileToLaunch)), 0x1);
    return r0;


// 0x100054ffc
// -[NoBottleController setFileToLaunch:]
    objc_setProperty_atomic_copy();
    return;


// 0x100055008
// -[NoBottleController nameForNewBottle]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_nameForNewBottle)), 0x1);
    return r0;


// 0x100055018
// -[NoBottleController setNameForNewBottle:]
    objc_setProperty_atomic_copy();
    return;


// 0x100055024
// -[NoBottleController bottleTemplate]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_bottleTemplate)), 0x1);
    return r0;


// 0x100055034
// -[NoBottleController setBottleTemplate:]
    objc_setProperty_atomic_copy();
    return;


// 0x100055040
// -[NoBottleController fileToLaunchString]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_fileToLaunchString)), 0x1);
    return r0;


// 0x100055050
// -[NoBottleController setFileToLaunchString:]
    objc_setProperty_atomic_copy();
    return;


// 0x10005505c
// -[NoBottleController isWorking]
    r0 = *(int8_t *)(int64_t *)&self->_isWorking & 0x1;
    return r0;


// 0x100055070
// -[NoBottleController setIsWorking:]
    *(int8_t *)(int64_t *)&self->_isWorking = arg2;
    return;


// 0x100055080
// -[NoBottleController templateArray]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_templateArray)), 0x1);
    return r0;


// 0x100055090
// -[NoBottleController setTemplateArray:]
    objc_setProperty_atomic_copy();
    return;


// 0x10005509c
// -[NoBottleController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_templateArray, 0x0);
    objc_storeStrong((int64_t *)&self->_fileToLaunchString, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleTemplate, 0x0);
    objc_storeStrong((int64_t *)&self->_nameForNewBottle, 0x0);
    objc_storeStrong((int64_t *)&self->_fileToLaunch, 0x0);
    objc_storeStrong((int64_t *)&self->suggestedBottleName, 0x0);
    objc_storeStrong((int64_t *)&self->ProgBar, 0x0);
    return;


// === Block Invocations for NoBottleController ===

// 0x10005497c
// ___34-[NoBottleController awakeFromNib]_block_invoke
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
            r25 = [r0 compare:@"win7"];
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


// 0x100054c74
// ___30-[NoBottleController doCreate]_block_invoke
    [arg0[0x4] setIsWorking:0x0];
    r0 = arg0[0x4];
    r0 = [r0 exitSuccess:0x0];
    return r0;


// 0x100054ca4
// ___30-[NoBottleController doCreate]_block_invoke.20
    [arg0[0x4] setIsWorking:0x0];
    r20 = [[arg0[0x5] objectAtIndex:0x1] retain];
    [arg0[0x4] createFailed:r20];
    r0 = [r20 release];
    return r0;


