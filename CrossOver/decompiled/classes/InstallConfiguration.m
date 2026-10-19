// InstallConfiguration — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10005531c
// -[InstallConfiguration init]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_30 = self;
    r0 = [[&var_30 super] init];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [CXSetupLib installTaskClass];
            r0 = [r0 alloc];
            r0 = [r0 initWithDelegate:0x0];
            r21 = sign_extend_64(*(int32_t *)ivar_offset(_installTask));
            r8 = *(r19 + r21);
            *(r19 + r21) = r0;
            [r8 release];
            [*(r19 + r21) setDelegate:r19];
            r0 = [NSMutableArray array];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_delegates));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            r20 = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
            objc_storeWeak((int64_t *)&r19->_bottleCollection, r20);
            [r20 release];
    }
    r0 = r19;
    return r0;


// 0x100055408
// -[InstallConfiguration dealloc]
    [self->_installTask setDelegate:0x0];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x10005545c
// -[InstallConfiguration newBottleCollidesWithExistingBottle]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([self creatingNewBottle] != 0x0) {
            r20 = [[r19 bottleCollection] retain];
            r21 = [[r19 nameForNewBottle] retain];
            r0 = [r20 bottleWithName:r21];
            r0 = [r0 retain];
            if (r0 != 0x0) {
                    r19 = 0x1;
            }
            [r0 release];
            [r21 release];
            [r20 release];
    }
    else {
            r19 = 0x0;
    }
    r0 = r19;
    return r0;


// 0x1000554ec
// -[InstallConfiguration hasBottle]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if (([self newBottleCollidesWithExistingBottle] & 0x1) != 0x0) {
            r19 = 0x0;
    }
    else {
            r0 = [r19 bottleName];
            r0 = [r0 retain];
            r20 = r0;
            if ([r0 length] != 0x0) {
                    r19 = 0x1;
            }
            [r20 release];
    }
    r0 = r19;
    return r0;


// 0x100055544
// -[InstallConfiguration hasInstallerSource]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r0 = [self installerSource];
    r0 = [r0 retain];
    r19 = r0;
    if ([r0 length] != 0x0) {
            r21 = 0x1;
    }
    else {
            r0 = [r21 installerDownloadSource];
            r0 = [r0 retain];
            r20 = r0;
            if ([r0 length] == 0x0 && ([r21 installWithSteam] & 0x1) == 0x0) {
                    r21 = [r21 isVirtual];
            }
            else {
                    r21 = 0x1;
            }
            [r20 release];
    }
    [r19 release];
    r0 = r21;
    return r0;


// 0x1000555d8
// -[InstallConfiguration hasPackage]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [self profile];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r19 = 0x1;
    }
    [r0 release];
    r0 = r19;
    return r0;


// 0x10005560c
// -[InstallConfiguration bottleIsCompatibleWithPackage]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([self hasPackage] != 0x0) {
            r0 = [r19 targetBottle];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 getCategory] retain];
            r22 = [[[CXSetupLib cxSetupClass] bottleCategory:@"INCOMPATIBLE"] retain];
            r19 = [r21 isEqualToNumber:r22] ^ 0x1;
            [r22 release];
            [r21 release];
            [r20 release];
    }
    else {
            r19 = 0x1;
    }
    r0 = r19;
    return r0;


// 0x1000556b4
// -[InstallConfiguration creatingNewBottle]
    r0 = self->_installTask;
    r0 = [r0 GetCreateNewBottle];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 boolValue];
    [r19 release];
    r0 = r20;
    return r0;


// 0x1000556fc
// -[InstallConfiguration setInstallerLocale:]
    [self->_installTask setLocale:arg2];
    return;


// 0x10005570c
// -[InstallConfiguration setInstallerSource:forUser:]
    r20 = self->_installTask;
    r22 = [arg2 retain];
    r19 = [[NSNumber numberWithBool:arg3] retain];
    [r20 setInstallerSource:r22 Requested:r19];
    [r22 release];
    [r19 release];
    return;


// 0x100055784
// -[InstallConfiguration setInstallerSteam]
    [self->_installTask setInstallerSteam];
    return;


// 0x100055794
// -[InstallConfiguration setInstallerDownload]
    [self->_installTask setInstallerDownload];
    return;


// 0x1000557a4
// -[InstallConfiguration setProfile:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r0 = [r20 profile];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    if (r21 != r19) {
            [r20->_installTask setProfile:r19];
    }
    [r19 release];
    return;


// 0x10005580c
// +[InstallConfiguration automaticallyNotifiesObserversOfSelectedPackage]
    return 0x0;


// 0x100055814
// -[InstallConfiguration setSelectedPackage:forUser:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg3;
    r22 = arg2;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    r23 = (int64_t *)&r20->_selectedPackage;
    if (*r23 != r0) {
            [r20 willChangeValueForKey:@"selectedPackage"];
            objc_storeStrong(r23, r22);
            [r20 didChangeValueForKey:@"selectedPackage"];
            if (r21 != 0x0) {
                    r21 = [[r19 packageobject] retain];
                    [r20 setProfile:r21];
                    [r21 release];
            }
    }
    [r19 release];
    return;


// 0x1000558c8
// -[InstallConfiguration profileLanguages]
    r0 = self->_installTask;
    r0 = [r0 profileLanguages];
    return r0;


// 0x1000558d8
// +[InstallConfiguration resolveInstanceMethod:]
    r31 = r31 - 0x60;
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
    r21 = arg2;
    r22 = self;
    if (*_resolveInstanceMethod:.onceToken != -0x1) {
            dispatch_once(_resolveInstanceMethod:.onceToken, ___block_literal_global);
    }
    r19 = [NSStringFromSelector(r21) retain];
    r0 = *_selectorToProperty;
    r0 = [r0 objectForKey:r19];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0) {
            r0 = [r20 getter];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [r0 isEqualToString:r19];
            [r23 release];
            r0 = r20;
            if (r24 != 0x0) {
                    r24 = [[r0 installTaskAttribute] retain];
                    r25 = [[r20 getter] retain];
                    r23 = [r24 isEqualToString:r25];
                    [r25 release];
                    [r24 release];
                    if ([r20 boolTyped] != 0x0) {
                            if (r23 == 0x0) {
                                    r2 = _boolGetterMethodIMP;
                            }
                            else {
                                    r2 = _boolGetterMethodFastIMP;
                            }
                            r3 = "c@:";
                    }
                    else {
                            if (r23 == 0x0) {
                                    r2 = _objectGetterMethodIMP;
                            }
                            else {
                                    r2 = _objectGetterMethodFastIMP;
                            }
                            r3 = "@@:";
                    }
                    class_addMethod(r22, r21, r2, r3);
                    r21 = 0x1;
            }
            else {
                    r0 = [r0 setter];
                    r0 = [r0 retain];
                    r23 = r0;
                    r24 = [r0 isEqualToString:r19];
                    [r23 release];
                    if (r24 != 0x0) {
                            if ([r20 boolTyped] != 0x0) {
                                    r2 = _boolSetterMethodIMP;
                                    r3 = "v@:c";
                            }
                            else {
                                    r2 = _objectSetterMethodIMP;
                                    r3 = "v@:@";
                            }
                            class_addMethod(r22, r21, r2, r3);
                            r21 = 0x1;
                    }
                    else {
                            var_50 = r22;
                            r0 = [[&var_50 super] resolveInstanceMethod:r21];
                            r21 = r0;
                    }
            }
    }
    else {
            var_50 = r22;
            r0 = [[&var_50 super] resolveInstanceMethod:r21];
            r21 = r0;
    }
    [r20 release];
    [r19 release];
    r0 = r21;
    return r0;


// 0x10005631c
// -[InstallConfiguration dependencyDetails]
    r0 = [self installTask];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 getDependencyDetails] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100056360
// -[InstallConfiguration installerDetails]
    r0 = [self installTask];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 getInstallerDetails] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x1000563a4
// -[InstallConfiguration bottleDetails]
    r0 = [self installTask];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 getBottleDetails] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x1000563e8
// -[InstallConfiguration languageDetails]
    r0 = [self installTask];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 getLanguageDetails] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10005642c
// -[InstallConfiguration miscDetails]
    r0 = [self installTask];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [[r0 getMiscDetails] retain];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100056470
// -[InstallConfiguration updateProfiles]
    [self->_installTask updateProfiles];
    return;


// 0x100056480
// -[InstallConfiguration isNewBottleNameValid:]
    r0 = self->_installTask;
    r0 = [r0 isNewBottleNameValid:arg2];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 boolValue];
    [r19 release];
    r0 = r20;
    return r0;


// 0x1000564c8
// -[InstallConfiguration createNewBottle:template:]
    [self->_installTask createNewBottle:arg2 template:arg3];
    return;


// 0x1000564d8
// -[InstallConfiguration setNewBottleName:]
    [self->_installTask setNewBottleName:arg2];
    return;


// 0x1000564e8
// -[InstallConfiguration addSourceMedia:withLabel:andDevice:]
    [self->_installTask addSourceMedia:arg2 withLabel:arg3 andDevice:arg4];
    return;


// 0x1000564f8
// -[InstallConfiguration addSourceMedia:]
    r21 = [arg2 retain];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r20 = r0;
    r22 = [[r0 displayNameAtPath:r21] retain];
    [r20 release];
    [self addSourceMedia:r21 withLabel:r22 andDevice:@""];
    [r21 release];
    [r22 release];
    return;


// 0x100056584
// -[InstallConfiguration removeSourceMedia:]
    [self->_installTask removeSourceMedia:arg2];
    return;


// 0x100056594
// -[InstallConfiguration volumeMatchesProfile:]
    r0 = self->_installTask;
    r0 = [r0 volumeMatchesProfile:arg2];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 boolValue];
    [r19 release];
    r0 = r20;
    return r0;


// 0x1000565dc
// -[InstallConfiguration profiles]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [[self->_installTask valueForKey:@"profiles"] retain];
    if ((objc_opt_respondsToSelector() & 0x1) != 0x0) {
            r0 = [r19 contentsDict];
            r0 = [r0 retain];
    }
    else {
            r0 = [r19 retain];
    }
    [r19 release];
    r0 = [r0 autorelease];
    return r0;


// 0x100056654
// -[InstallConfiguration profileForAppID:]
    r20 = [arg2 retain];
    r0 = [self profiles];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 objectForKey:r20] retain];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x1000566c0
// -[InstallConfiguration nameForProfileWithAppID:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg2 retain];
    r19 = r0;
    if ([r0 isEqualToString:@"com.codeweavers.unknown"] != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 localizedStringForKey:@"Unlisted application" value:@"" table:0x0] retain];
    }
    else {
            r0 = [r20 profiles];
            r0 = [r0 retain];
            r20 = r0;
            r0 = [r0 objectForKey:r19];
            r0 = [r0 retain];
            r22 = r0;
            r21 = [[r0 valueForKey:@"name"] retain];
            [r22 release];
    }
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x10005679c
// -[InstallConfiguration addBottle:]
    r0 = self->_installTask;
    r0 = [r0 addBottle:arg2];
    return r0;


// 0x1000567ac
// -[InstallConfiguration removeBottle:]
    objc_unsafeClaimAutoreleasedReturnValue([self->_installTask removeBottle:arg2]);
    return;


// 0x1000567d4
// -[InstallConfiguration installedApplicationsReady:]
    [self->_installTask installedApplicationsReady:arg2];
    return;


// 0x1000567e4
// -[InstallConfiguration triggerBottleAnalysis]
    [self->_installTask triggerBottleAnalysis];
    return;


// 0x1000567f4
// -[InstallConfiguration recommendedTemplate]
    r20 = [[self templates] retain];
    r19 = [[self->_installTask valueForKey:@"new_bottle_template"] retain];
    r21 = [[r20 valueForKey:r19] retain];
    [r19 release];
    [r20 release];
    r0 = [r21 autorelease];
    return r0;


// 0x100056878
// -[InstallConfiguration useAutorunFile:]
    [self->_installTask useAutorunFile:arg2];
    return;


// 0x100056888
// -[InstallConfiguration autoFillSettings]
    [self->_installTask autoFillSettings];
    return;


// 0x100056898
// -[InstallConfiguration logFileName]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [[NSMutableArray arrayWithObject:@"Install"] retain];
    r0 = [r21 bottleName];
    r0 = [r0 retain];
    r20 = r0;
    [r0 release];
    if (r20 != 0x0) {
            r20 = [[r21 bottleName] retain];
            [r19 addObject:r20];
            [r20 release];
    }
    r0 = [r21 profile];
    r0 = [r0 retain];
    r20 = r0;
    if (r0 != 0x0 && ([r21 creatingNewBottle] & 0x1) == 0x0) {
            r21 = [[r20 valueForKey:@"name"] retain];
            r22 = [[[CXSetupLib cxUtilsClass] sanitizedBottleName:r21] retain];
            [r19 addObject:r22];
            [r22 release];
            [r21 release];
    }
    r21 = [[r19 componentsJoinedByString:@"-"] retain];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x1000569cc
// -[InstallConfiguration newInstallEngine]
    r31 = r31 - 0x60;
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
    r19 = self;
    r0 = [self logEnvironment];
    r0 = [r0 retain];
    r20 = r0;
    if ([r0 length] != 0x0) {
            [r20 release];
            r21 = [[r19 logEnvironment] retain];
            r22 = [[r19 environment] retain];
            r20 = [[NSString stringWithFormat:@"%@ %@", r3, r4] retain];
            [r22 release];
            [r21 release];
    }
    else {
            r0 = [r19 environment];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 length];
            [r21 release];
            [r20 release];
            if (r22 != 0x0) {
                    r21 = [[r19 logEnvironment] retain];
                    r22 = [[r19 environment] retain];
                    r20 = [[NSString stringWithFormat:@"%@ %@", r3, r4] retain];
                    [r22 release];
                    [r21 release];
            }
            else {
                    r20 = 0x0;
            }
    }
    r22 = [[CXSetupLib cxAiEngineClass] alloc];
    r23 = r19->_installTask;
    r25 = sign_extend_64(*(int32_t *)ivar_offset(_logFileURL));
    r0 = *(r19 + r25);
    r0 = [r0 path];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 length];
    r24 = r0;
    if (r0 != 0x0) {
            r25 = [[*(r19 + r25) path] retain];
    }
    else {
            r25 = 0x0;
    }
    r26 = sign_extend_64(*(int32_t *)ivar_offset(_logChannels));
    if ([*(r19 + r26) length] != 0x0) {
            r4 = *(r19 + r26);
    }
    else {
            r4 = 0x0;
    }
    r19 = [r22 initWithInstallTask:r23 logFile:r25 channels:r4 env:r20];
    if (r24 != 0x0) {
            [r25 release];
    }
    [r21 release];
    [r20 release];
    r0 = r19;
    return r0;


// 0x100056b80
// +[InstallConfiguration reasonMain]
    r0 = [CXSetupLib cxSetupClass];
    r0 = [r0 dependencyReason:@"MAIN"];
    return r0;


// 0x100056ba4
// +[InstallConfiguration reasonSteam]
    r0 = [CXSetupLib cxSetupClass];
    r0 = [r0 dependencyReason:@"STEAM"];
    return r0;


// 0x100056bc8
// +[InstallConfiguration reasonOverride]
    r0 = [CXSetupLib cxSetupClass];
    r0 = [r0 dependencyReason:@"OVERRIDE"];
    return r0;


// 0x100056bec
// +[InstallConfiguration reasonDependency]
    r0 = [CXSetupLib cxSetupClass];
    r0 = [r0 dependencyReason:@"DEPENDENCY"];
    return r0;


// 0x100056c10
// +[InstallConfiguration overrideExclude]
    r0 = [CXSetupLib cxSetupClass];
    r0 = [r0 dependencyOverride:@"EXCLUDE"];
    return r0;


// 0x100056c34
// +[InstallConfiguration overrideInclude]
    r0 = [CXSetupLib cxSetupClass];
    r0 = [r0 dependencyOverride:@"INCLUDE"];
    return r0;


// 0x100056c58
// -[InstallConfiguration addDelegate:]
    r20 = [arg2 retain];
    r0 = [self delegates];
    r0 = [r0 retain];
    r19 = r0;
    [r0 addObject:r20];
    [r20 release];
    [r19 release];
    return;


// 0x100056ca8
// -[InstallConfiguration removeDelegate:]
    r20 = [arg2 retain];
    r0 = [self delegates];
    r0 = [r0 retain];
    r19 = r0;
    [r0 removeObject:r20];
    [r20 release];
    [r19 release];
    return;


// 0x100056cf8
// -[InstallConfiguration forwardDelegateMethod:]
    r31 = r31 - 0x120;
    var_40 = r28;
    decomp_var_38 = r27;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg2;
    var_48 = **___stack_chk_guard;
    var_110 = q0;
    var_100 = q0;
    r0 = self->_delegates;
    r0 = [r0 copy];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r23 = *var_100;
            do {
                    r24 = 0x0;
                    do {
                            if (*var_100 != r23) {
                                    objc_enumerationMutation(r20);
                            }
                            r22 = *(var_108 + r24 * 0x8);
                            if ((objc_opt_respondsToSelector() & 0x1) != 0x0) {
                                    [r22 performSelector:r19];
                            }
                            r24 = r24 + 0x1;
                    } while (r21 != r24);
                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100056e10
// -[InstallConfiguration forwardDelegateMethod:withObject:]
    r31 = r31 - 0x120;
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
    r19 = arg2;
    var_48 = **___stack_chk_guard;
    r20 = [arg3 retain];
    var_110 = q0;
    var_100 = q0;
    r0 = self->_delegates;
    r0 = [r0 copy];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r24 = *var_100;
            do {
                    r25 = 0x0;
                    do {
                            if (*var_100 != r24) {
                                    objc_enumerationMutation(r21);
                            }
                            r23 = *(var_108 + r25 * 0x8);
                            if ((objc_opt_respondsToSelector() & 0x1) != 0x0) {
                                    [r23 performSelector:r19 withObject:r20];
                            }
                            r25 = r25 + 0x1;
                    } while (r22 != r25);
                    r0 = [r21 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100056f44
// -[InstallConfiguration profileMediaAdded:]
    [self forwardDelegateMethod:_cmd withObject:arg2];
    return;


// 0x100056f50
// -[InstallConfiguration profileMediaRemoved:]
    [self forwardDelegateMethod:_cmd withObject:arg2];
    return;


// 0x100056f5c
// -[InstallConfiguration profileChanged]
    [self forwardDelegateMethod:_cmd];
    return;


// 0x100056f64
// -[InstallConfiguration sourceChanged]
    [self forwardDelegateMethod:_cmd];
    return;


// 0x100056f6c
// -[InstallConfiguration bottleCreateChanged]
    [self forwardDelegateMethod:_cmd];
    return;


// 0x100056f74
// -[InstallConfiguration bottleNewnameChanged]
    [self forwardDelegateMethod:_cmd];
    return;


// 0x100056f7c
// -[InstallConfiguration bottleTemplateChanged]
    [self forwardDelegateMethod:_cmd];
    return;


// 0x100056f84
// -[InstallConfiguration bottleNameChanged]
    [self forwardDelegateMethod:_cmd];
    return;


// 0x100056f8c
// -[InstallConfiguration categorizedBottle:]
    [self forwardDelegateMethod:_cmd withObject:arg2];
    return;


// 0x100056f98
// -[InstallConfiguration categorizedAllBottles]
    [self forwardDelegateMethod:_cmd];
    return;


// 0x100056fa0
// -[InstallConfiguration analyzedBottle:]
    [self forwardDelegateMethod:_cmd withObject:arg2];
    return;


// 0x100056fac
// -[InstallConfiguration installTask]
    r0 = self->_installTask;
    return r0;


// 0x100056fbc
// -[InstallConfiguration delegates]
    r0 = self->_delegates;
    return r0;


// 0x100056fcc
// -[InstallConfiguration setDelegates:]
    objc_storeStrong((int64_t *)&self->_delegates, arg2);
    return;


// 0x100056fe0
// -[InstallConfiguration environment]
    r0 = self->_environment;
    return r0;


// 0x100056ff0
// -[InstallConfiguration setEnvironment:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100056ffc
// -[InstallConfiguration logChannels]
    r0 = self->_logChannels;
    return r0;


// 0x10005700c
// -[InstallConfiguration setLogChannels:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100057018
// -[InstallConfiguration logEnvironment]
    r0 = self->_logEnvironment;
    return r0;


// 0x100057028
// -[InstallConfiguration setLogEnvironment:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100057034
// -[InstallConfiguration logFileURL]
    r0 = self->_logFileURL;
    return r0;


// 0x100057044
// -[InstallConfiguration setLogFileURL:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100057050
// -[InstallConfiguration selectedPackage]
    r0 = self->_selectedPackage;
    return r0;


// 0x100057060
// -[InstallConfiguration bottleCollection]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
    r0 = [r0 autorelease];
    return r0;


// 0x100057080
// -[InstallConfiguration .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_bottleCollection);
    objc_storeStrong((int64_t *)&self->_selectedPackage, 0x0);
    objc_storeStrong((int64_t *)&self->_logFileURL, 0x0);
    objc_storeStrong((int64_t *)&self->_logEnvironment, 0x0);
    objc_storeStrong((int64_t *)&self->_logChannels, 0x0);
    objc_storeStrong((int64_t *)&self->_environment, 0x0);
    objc_storeStrong((int64_t *)&self->_delegates, 0x0);
    objc_storeStrong((int64_t *)&self->_installTask, 0x0);
    return;


// === Block Invocations for InstallConfiguration ===

// 0x100055ae0
// ___46+[InstallConfiguration resolveInstanceMethod:]_block_invoke
    r31 = r31 - 0x110;
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
    var_60 = **___stack_chk_guard;
    var_D0 = @"bottleName";
    var_98 = @"bottlename";
    r0 = [NSDictionary dictionaryWithObjects:&var_98 forKeys:&var_D0 count:0x7];
    var_E0 = [r0 retain];
    r26 = [[NSMutableDictionary alloc] init];
    r0 = objc_opt_class(@class(InstallConfiguration));
    r0 = class_copyPropertyList(r0, &var_D4);
    r21 = r0;
    if (var_D4 != 0x0) {
            r19 = 0x0;
            var_E8 = r26;
            do {
                    r28 = objc_autoreleasePoolPush();
                    r0 = *(r21 + r19 * 0x8);
                    r0 = property_copyAttributeValue(r0, "D");
                    if (r0 != 0x0) {
                            free(r0);
                            r27 = [[NSString stringWithUTF8String:property_getName(*(r21 + r19 * 0x8))] retain];
                            r23 = [[PropertyDescriptor alloc] init];
                            r24 = [[var_E0 objectForKey:r27] retain];
                            r2 = r24;
                            [r23 setInstallTaskAttribute:r2];
                            [r24 release];
                            r0 = [r23 installTaskAttribute];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 release];
                            if (r24 == 0x0) {
                                    r2 = r27;
                                    [r23 setInstallTaskAttribute:r2];
                            }
                            r0 = *(r21 + r19 * 0x8);
                            r0 = property_copyAttributeValue(r0, "T");
                            r24 = r0;
                            if (strcmp(r0, "B") == 0x0) {
                                    r2 = 0x1;
                            }
                            [r23 setBoolTyped:r2];
                            free(r24);
                            r0 = *(r21 + r19 * 0x8);
                            r0 = property_copyAttributeValue(r0, "G");
                            if (r0 != 0x0) {
                                    r25 = [[NSString stringWithUTF8String:r0] retain];
                                    [r23 setGetter:r25];
                                    [r25 release];
                                    free(r0);
                            }
                            else {
                                    [r23 setGetter:r27];
                            }
                            r24 = [[r23 getter] retain];
                            r3 = r24;
                            [r26 setObject:r23 forKey:r3];
                            [r24 release];
                            r0 = *(r21 + r19 * 0x8);
                            r0 = property_copyAttributeValue(r0, "R");
                            if (r0 != 0x0) {
                                    free(r0);
                            }
                            else {
                                    r0 = *(r21 + r19 * 0x8);
                                    r0 = property_copyAttributeValue(r0, "S");
                                    if (r0 != 0x0) {
                                            r24 = [[NSString stringWithUTF8String:r0] retain];
                                            [r23 setSetter:r24];
                                            [r24 release];
                                            free(r0);
                                    }
                                    else {
                                            r0 = [r27 substringToIndex:0x1];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            r26 = [[r0 uppercaseString] retain];
                                            r22 = [[r27 substringFromIndex:0x1] retain];
                                            r24 = [[NSString stringWithFormat:@"set%@%@:", r3, r4] retain];
                                            [r23 setSetter:r24];
                                            [r24 release];
                                            [r22 release];
                                            r0 = r26;
                                            r26 = var_E8;
                                            [r0 release];
                                            [r25 release];
                                    }
                                    r22 = [[r23 setter] retain];
                                    [r26 setObject:r23 forKey:r22];
                                    [r22 release];
                            }
                            [r23 release];
                            [r27 release];
                    }
                    objc_autoreleasePoolPop(r28);
                    r19 = r19 + 0x1;
            } while (r19 < var_D4);
    }
    free(r21);
    r0 = *_selectorToProperty;
    *_selectorToProperty = r26;
    [r0 release];
    [var_E0 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


