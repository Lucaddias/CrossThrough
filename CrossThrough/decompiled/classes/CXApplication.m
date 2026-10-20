// CXApplication — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10001cec4
// +[CXApplication accessInstanceVariablesDirectly]
    return 0x0;


// 0x10001cecc
// -[CXApplication init]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_40 = self;
    r0 = [[&var_40 super] init];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [[r0 sharedSupportPath] retain];
            [r20 release];
            r0 = [r21 stringByAppendingPathComponent:@"CrossOver"];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(crossOverRoot));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 sharedSupportURL] retain];
            [r22 release];
            r0 = [r23 URLByAppendingPathComponent:@"CrossOver" isDirectory:0x1];
            r0 = [r0 retain];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(crossOverRootURL));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            [r23 release];
            [r21 release];
    }
    r0 = r19;
    return r0;


// 0x10001cff4
// -[CXApplication setDelegate:]
    r20 = [arg2 retain];
    [self setCXServer:r20];
    var_20 = self;
    [[&var_20 super] setDelegate:r20];
    [r20 release];
    return;


// 0x10001d058
// -[CXApplication crossOverRoot]
    r0 = self->crossOverRoot;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10001d068
// -[CXApplication crossOverRootURL]
    r0 = self->crossOverRootURL;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10001d078
// -[CXApplication isDemo]
    r0 = *(int8_t *)(int64_t *)&self->isDemo;
    return r0;


// 0x10001d088
// -[CXApplication setIsDemo]
    r31 = r31 - 0xc0;
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
    r22 = self;
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [[r0 URLsForDirectory:0x5 inDomains:0x3] retain];
    [r20 release];
    if ([r19 count] > 0x1) goto loc_10001d104;
    goto loc_10001d0f4;

loc_10001d104:
    r0 = [r19 objectAtIndexedSubscript:0x0];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 URLByAppendingPathComponent:@"Preferences" isDirectory:0x1] retain];
    [r21 release];
    if (r20 == 0x0) goto loc_10001d624;
    goto loc_10001d144;

loc_10001d0f4:
    NSLog(@"Failed to retrieve Library directories.\n");
    [r19 release];
    return;

loc_10001d624:
    NSLog(@"Failed to locate the local Preferences directory.\n");
    [r20 release];
    [r19 release];
    return;

loc_10001d144:
    r21 = [[NSString stringWithFormat:@"%@.%@.license", 0x1, r4] retain];
    r28 = [[r20 URLByAppendingPathComponent:r21 isDirectory:0x0] retain];
    [r21 release];
    r21 = [[NSString stringWithFormat:@"%@.%@.sha256", r3, r4] retain];
    r26 = [[r20 URLByAppendingPathComponent:r21 isDirectory:0x0] retain];
    [r21 release];
    if (([r26 checkResourceIsReachableAndReturnError:0x0] & 0x1) == 0x0) {
            r21 = [[NSString stringWithFormat:@"%@.%@.sig", 0x0, r4] retain];
            r24 = [[r20 URLByAppendingPathComponent:r21 isDirectory:0x0] retain];
            [r26 release];
            [r21 release];
            r26 = r24;
    }
    r0 = [r19 objectAtIndexedSubscript:0x1];
    r0 = [r0 retain];
    r21 = r0;
    r24 = [[r0 URLByAppendingPathComponent:@"Preferences" isDirectory:0x1] retain];
    [r21 release];
    var_58 = r24;
    if (r24 == 0x0) goto loc_10001d634;
    goto loc_10001d284;

loc_10001d634:
    NSLog(@"Failed to locate the global Preferences directory.\n");
    [var_58 release];
    [r26 release];
    [r28 release];
    [r20 release];
    [r19 release];
    return;

loc_10001d284:
    var_70 = r20;
    r20 = r22;
    r21 = [[NSString stringWithFormat:@"%@.%@.license", 0x1, r4] retain];
    r24 = var_58;
    var_68 = [[r24 URLByAppendingPathComponent:r21 isDirectory:0x0] retain];
    [r21 release];
    r21 = [[NSString stringWithFormat:@"%@.%@.sha256", r3, r4] retain];
    r27 = [[r24 URLByAppendingPathComponent:r21 isDirectory:0x0] retain];
    [r21 release];
    if (([r27 checkResourceIsReachableAndReturnError:0x0] & 0x1) == 0x0) {
            r21 = [[NSString stringWithFormat:@"%@.%@.sig", 0x0, r4] retain];
            r25 = [[r24 URLByAppendingPathComponent:r21 isDirectory:0x0] retain];
            [r27 release];
            [r21 release];
            r27 = r25;
    }
    r22 = r20;
    r21 = [CXSetupLib demoUtilsClass];
    var_80 = r28;
    r25 = [[r28 stringWithFileSystemRepresentation] retain];
    var_78 = r26;
    r26 = [[r26 stringWithFileSystemRepresentation] retain];
    r28 = [[r21 demoStatusForLicenseFile:r25 andSig:r26] retain];
    [r26 release];
    [r25 release];
    r21 = [CXSetupLib demoUtilsClass];
    r25 = [[var_68 stringWithFileSystemRepresentation] retain];
    var_88 = r27;
    r0 = r27;
    r27 = r28;
    r26 = [[r0 stringWithFileSystemRepresentation] retain];
    r20 = [[r21 demoStatusForLicenseFile:r25 andSig:r26] retain];
    [r26 release];
    [r25 release];
    r25 = [[NSDateFormatter alloc] init];
    r21 = [[NSCalendar alloc] initWithCalendarIdentifier:**_NSCalendarIdentifierGregorian];
    [r25 setCalendar:r21];
    [r21 release];
    r21 = [[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"] retain];
    [r25 setLocale:r21];
    [r21 release];
    r21 = [[NSTimeZone timeZoneWithName:@"America/Chicago"] retain];
    [r25 setTimeZone:r21];
    [r21 release];
    [r25 setDateFormat:@"yyyy/MM/dd"];
    r0 = [r28 objectAtIndex:0x0];
    r0 = [r0 retain];
    r26 = r0;
    r21 = [r0 boolValue];
    [r26 release];
    var_60 = r20;
    r0 = [r20 objectAtIndex:0x0];
    r0 = [r0 retain];
    r28 = r0;
    r26 = [r0 boolValue];
    [r28 release];
    r20 = var_70;
    if ((r21 & 0x1) != 0x0) goto .l64;
    goto loc_10001d570;

.l64:
    if ((r21 & 0x1) == 0x0) goto .l58;
    goto loc_10001d648;

loc_10001d570:
    if ((r26 & 0x1) != 0x0) goto loc_10001d644;
    goto loc_10001d574;

.l58:
    r24 = r22;
    r0 = r27;
    r21 = [r0 retain];
    r8 = *(int32_t *)ivar_offset(isDemo);
    if (r21 == 0x0) goto .l65;
    goto .l66;

loc_10001d648:
    if (r26 == 0x0) goto .l48;
    goto .l52;

loc_10001d644:
    if ((r21 & 0x1) == 0x0) goto loc_10001d654;
    goto .l37;

loc_10001d574:
    r24 = r22;
    *(int8_t *)(int64_t *)&r22->isDemo = 0x0;
    r21 = [[r27 objectAtIndex:0x2] retain];
    r26 = [[r25 dateFromString:r21] retain];
    [r21 release];
    r22 = var_60;
    r21 = [[r22 objectAtIndex:0x2] retain];
    r28 = [[r25 dateFromString:r21] retain];
    [r21 release];
    if ([r26 compare:r28] != -0x1) {
            r0 = r27;
    }
    else {
            r0 = r22;
    }
    r21 = [r0 retain];
    [r28 release];
    [r26 release];
    r23 = &@class(LoadingCrossTieSheetController);
    r8 = *(int32_t *)ivar_offset(isDemo);
    if (r21 == 0x0) goto .l81;
    goto .l82;

.l65:
    r22 = r24;
    *(int8_t *)(r22 + (r8 << r64)) = 0x1;
    asm { ccmp       x8, #0x0, #0x4, ne };
    bool_106 = asm { ccmp       x8, #0x0, #0x4, ne };
    if (!bool_106) {
            r0 = [r27 objectAtIndex:0x4];
            r0 = [r0 retain];
            r21 = r0;
            if ([r0 boolValue] != 0x0) {
                    r0 = [var_60 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r26 = r0;
                    if ([r0 boolValue] != 0x0) {
                            [r26 release];
                            [r21 release];
                            NSLog(@"Revoke!\n");
                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                    }
                    else {
                            var_98 = r26;
                            var_90 = r21;
                            r0 = [r27 objectAtIndex:0x4];
                            r0 = [r0 retain];
                            r26 = r0;
                            if ([r0 boolValue] != 0x0) {
                                    [r26 release];
                                    if ((0x1 & 0x1) != 0x0) {
                                            [var_98 release];
                                            if (0x1 == 0x0) {
                                                    if (0x1 != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                            else {
                                                    [var_90 release];
                                                    if ((0x1 & 0x1) != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                    }
                                    else {
                                            if (0x1 != 0x0) {
                                                    [var_90 release];
                                                    if ((0x1 & 0x1) != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                            else {
                                                    if (0x1 != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                    }
                            }
                            else {
                                    if (var_60 == 0x0) {
                                            if (r27 == 0x0) {
                                                    if (0x1 == 0x0) {
                                                            if (0x0 != 0x0) {
                                                                    [var_90 release];
                                                                    if ((0x0 & 0x1) != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    if (0x0 != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            [var_98 release];
                                                            if ((0x0 & 0x1) == 0x0) {
                                                                    if (0x0 != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    [var_90 release];
                                                                    if ((0x0 & 0x1) != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    [r26 release];
                                                    if ((0x1 & 0x1) == 0x0) {
                                                            if (0x0 != 0x0) {
                                                                    [var_90 release];
                                                                    if ((0x0 & 0x1) != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    if (0x0 != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            [var_98 release];
                                                            if ((0x0 & 0x1) == 0x0) {
                                                                    if (0x0 != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    [var_90 release];
                                                                    if ((0x0 & 0x1) != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                    }
                                            }
                                    }
                                    else {
                                            r0 = [var_60 objectAtIndex:0x4];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r21 = [r0 boolValue];
                                            [r23 release];
                                            if (r27 != 0x0) {
                                                    [r26 release];
                                                    if ((0x1 & 0x1) == 0x0) {
                                                            if (0x1 != 0x0) {
                                                                    [var_90 release];
                                                                    if ((r21 & 0x1) != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    if (r21 != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            [var_98 release];
                                                            if ((0x1 & 0x1) == 0x0) {
                                                                    if (r21 != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    [var_90 release];
                                                                    if ((r21 & 0x1) != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (0x1 == 0x0) {
                                                            if (0x0 != 0x0) {
                                                                    [var_90 release];
                                                                    if ((r21 & 0x1) != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    if (r21 != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            [var_98 release];
                                                            if ((0x0 & 0x1) == 0x0) {
                                                                    if (r21 != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    [var_90 release];
                                                                    if ((r21 & 0x1) != 0x0) {
                                                                            NSLog(@"Revoke!\n");
                                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                                    }
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
            else {
                    var_90 = r21;
                    r0 = [r27 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r26 = r0;
                    if ([r0 boolValue] != 0x0) {
                            [r26 release];
                            if ((0x0 & 0x1) != 0x0) {
                                    [var_98 release];
                                    if (0x1 == 0x0) {
                                            if (0x1 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((0x1 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    if (0x1 != 0x0) {
                                            [var_90 release];
                                            if ((0x1 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (0x1 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            if (var_60 == 0x0) {
                                    if (r27 == 0x0) {
                                            if (0x0 == 0x0) {
                                                    if (0x0 != 0x0) {
                                                            [var_90 release];
                                                            if ((0x0 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            if (0x0 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [var_98 release];
                                                    if ((0x0 & 0x1) == 0x0) {
                                                            if (0x0 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [var_90 release];
                                                            if ((0x0 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                    }
                                    else {
                                            [r26 release];
                                            if ((0x0 & 0x1) == 0x0) {
                                                    if (0x0 != 0x0) {
                                                            [var_90 release];
                                                            if ((0x0 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            if (0x0 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [var_98 release];
                                                    if ((0x0 & 0x1) == 0x0) {
                                                            if (0x0 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [var_90 release];
                                                            if ((0x0 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                    }
                            }
                            else {
                                    r0 = [var_60 objectAtIndex:0x4];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r21 = [r0 boolValue];
                                    [r23 release];
                                    if (r27 != 0x0) {
                                            [r26 release];
                                            if ((0x0 & 0x1) == 0x0) {
                                                    if (0x1 != 0x0) {
                                                            [var_90 release];
                                                            if ((r21 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            if (r21 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [var_98 release];
                                                    if ((0x1 & 0x1) == 0x0) {
                                                            if (r21 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [var_90 release];
                                                            if ((r21 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                    }
                                    else {
                                            if (0x0 == 0x0) {
                                                    if (0x0 != 0x0) {
                                                            [var_90 release];
                                                            if ((r21 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            if (r21 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [var_98 release];
                                                    if ((0x0 & 0x1) == 0x0) {
                                                            if (r21 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [var_90 release];
                                                            if ((r21 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    else {
            if (r27 != 0x0) {
                    r0 = [r27 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r26 = r0;
                    if ([r0 boolValue] != 0x0) {
                            [r26 release];
                            if ((0x0 & 0x1) != 0x0) {
                                    [var_98 release];
                                    if (0x1 == 0x0) {
                                            if (0x1 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((0x1 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    if (0x1 != 0x0) {
                                            [var_90 release];
                                            if ((0x1 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (0x1 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            if (var_60 == 0x0) {
                                    if (r27 == 0x0) {
                                            if (0x0 == 0x0) {
                                                    if (0x0 != 0x0) {
                                                            [var_90 release];
                                                            if ((0x0 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            if (0x0 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [var_98 release];
                                                    if ((0x0 & 0x1) == 0x0) {
                                                            if (0x0 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [var_90 release];
                                                            if ((0x0 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                    }
                                    else {
                                            [r26 release];
                                            if ((0x0 & 0x1) == 0x0) {
                                                    if (0x0 != 0x0) {
                                                            [var_90 release];
                                                            if ((0x0 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            if (0x0 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [var_98 release];
                                                    if ((0x0 & 0x1) == 0x0) {
                                                            if (0x0 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [var_90 release];
                                                            if ((0x0 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                    }
                            }
                            else {
                                    r0 = [var_60 objectAtIndex:0x4];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r21 = [r0 boolValue];
                                    [r23 release];
                                    if (r27 != 0x0) {
                                            [r26 release];
                                            if ((0x0 & 0x1) == 0x0) {
                                                    if (0x1 != 0x0) {
                                                            [var_90 release];
                                                            if ((r21 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            if (r21 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [var_98 release];
                                                    if ((0x1 & 0x1) == 0x0) {
                                                            if (r21 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [var_90 release];
                                                            if ((r21 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                    }
                                    else {
                                            if (0x0 == 0x0) {
                                                    if (0x0 != 0x0) {
                                                            [var_90 release];
                                                            if ((r21 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            if (r21 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                            else {
                                                    [var_98 release];
                                                    if ((0x0 & 0x1) == 0x0) {
                                                            if (r21 != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [var_90 release];
                                                            if ((r21 & 0x1) != 0x0) {
                                                                    NSLog(@"Revoke!\n");
                                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
            else {
                    if (var_60 != 0x0) {
                            r0 = [var_60 objectAtIndex:0x4];
                            r0 = [r0 retain];
                            r23 = r0;
                            r21 = [r0 boolValue];
                            [r23 release];
                            if (r27 != 0x0) {
                                    [r26 release];
                                    if ((0x0 & 0x1) == 0x0) {
                                            if (0x1 != 0x0) {
                                                    [var_90 release];
                                                    if ((r21 & 0x1) != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                            else {
                                                    if (r21 != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                    }
                                    else {
                                            [var_98 release];
                                            if ((0x1 & 0x1) == 0x0) {
                                                    if (r21 != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                            else {
                                                    [var_90 release];
                                                    if ((r21 & 0x1) != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                    }
                            }
                            else {
                                    if (0x0 == 0x0) {
                                            if (0x0 != 0x0) {
                                                    [var_90 release];
                                                    if ((r21 & 0x1) != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                            else {
                                                    if (r21 != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                    }
                                    else {
                                            [var_98 release];
                                            if ((0x0 & 0x1) == 0x0) {
                                                    if (r21 != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                            else {
                                                    [var_90 release];
                                                    if ((r21 & 0x1) != 0x0) {
                                                            NSLog(@"Revoke!\n");
                                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    r28 = sign_extend_64(*(int32_t *)ivar_offset(daysLeft));
    if (*(int32_t *)(r22 + r28) > 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r23 = [[r0 localizedStringForKey:@"This demo version will expire in %d days." value:@"" table:0x0] retain];
            r21 = [[NSString stringWithFormat:r23] retain];
            [r22 setDemoString:r21];
            [r21 release];
            r0 = r23;
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r21 = [[r0 localizedStringForKey:@"This demo version has expired." value:@"" table:0x0] retain];
            [r22 setDemoString:r21];
            r0 = r21;
    }
    [r0 release];
    r21 = 0x0;
    r22 = var_88;
    r28 = var_80;
    goto .l62;

.l66:
    var_90 = r27;
    asm { sxtw       x8, w8 };
    *(int8_t *)(r24 + r8) = 0x0;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r28 = r0;
    r27 = [[r0 localizedStringForKey:@"Registered to: %@" value:@"" table:0x0] retain];
    r23 = [[r21 objectAtIndex:0x1] retain];
    r26 = [[NSString stringWithFormat:r27] retain];
    [r24 setDemoString:r26];
    [r26 release];
    [r23 release];
    [r27 release];
    [r28 release];
    r23 = [[r21 objectAtIndex:0x2] retain];
    r26 = [[r25 dateFromString:r23] retain];
    [r24 setLicenseExpirationDate:r26];
    [r26 release];
    [r23 release];
    r23 = [[r21 objectAtIndex:0x3] retain];
    [r24 setLicenseID:r23];
    [r23 release];
    r27 = sign_extend_64(*(int32_t *)ivar_offset(registerMenuItem));
    r0 = *(r24 + r27);
    if (r0 == 0x0) goto .l59;
    goto .l60;

.l48:
    r24 = r22;
    r0 = var_60;
    r21 = [r0 retain];
    r23 = &@class(LoadingCrossTieSheetController);
    r8 = *(int32_t *)ivar_offset(isDemo);
    if (r21 == 0x0) goto .l25;
    goto .l26;

.l52:
    r23 = &@class(LoadingCrossTieSheetController);
    r8 = *(int32_t *)ivar_offset(isDemo);
    *(int8_t *)(r22 + (r8 << r64)) = 0x1;
    asm { ccmp       x8, #0x0, #0x4, ne };
    bool_94 = asm { ccmp       x8, #0x0, #0x4, ne };
    if (asm { ccmp       x8, #0x0, #0x4, ne }) {
            r23 = 0x1;
    }
    if (bool_94) goto .l49;
    goto .l53;

loc_10001d654:
    r24 = r22;
    r0 = r27;
    r21 = [r0 retain];
    r23 = &@class(LoadingCrossTieSheetController);
    r8 = *(int32_t *)ivar_offset(isDemo);
    if (r21 == 0x0) goto loc_10001d80c;
    goto loc_10001d678;

.l37:
    if (r26 == 0x0) goto loc_10001d660;
    goto loc_10001d64c;

.l81:
    r22 = r24;
    *(int8_t *)(r22 + (r8 << r64)) = 0x1;
    asm { ccmp       x8, #0x0, #0x4, ne };
    bool_130 = asm { ccmp       x8, #0x0, #0x4, ne };
    if (asm { ccmp       x8, #0x0, #0x4, ne }) {
            r23 = 0x1;
    }
    if (bool_130) goto .l69;
    goto .l79;

.l82:
    var_90 = r27;
    asm { sxtw       x8, w8 };
    *(int8_t *)(r24 + r8) = 0x0;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r28 = r0;
    r27 = [[r0 localizedStringForKey:@"Registered to: %@" value:@"" table:0x0] retain];
    r23 = [[r21 objectAtIndex:0x1] retain];
    r26 = [[NSString stringWithFormat:r27] retain];
    [r24 setDemoString:r26];
    [r26 release];
    [r23 release];
    [r27 release];
    [r28 release];
    r23 = [[r21 objectAtIndex:0x2] retain];
    r26 = [[r25 dateFromString:r23] retain];
    [r24 setLicenseExpirationDate:r26];
    [r26 release];
    [r23 release];
    r23 = [[r21 objectAtIndex:0x3] retain];
    [r24 setLicenseID:r23];
    [r23 release];
    r27 = sign_extend_64(*(int32_t *)ivar_offset(registerMenuItem));
    r0 = *(r24 + r27);
    if (r0 == 0x0) goto .l67;
    goto .l73;

.l62:
    [r26 release];
    r26 = var_78;
    goto .l63;

.l59:
    r28 = var_80;
    r26 = var_78;
    r27 = var_90;
    r22 = var_88;
    goto .l63;

.l60:
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 release];
    if (r23 == 0x0) goto .l59;
    goto .l61;

.l25:
    r22 = r24;
    *(int8_t *)(r22 + (r8 << r64)) = 0x1;
    asm { ccmp       x8, #0x0, #0x4, ne };
    bool_44 = asm { ccmp       x8, #0x0, #0x4, ne };
    if (asm { ccmp       x8, #0x0, #0x4, ne }) {
            r23 = 0x1;
    }
    if (bool_44) goto .l13;
    goto .l23;

.l26:
    var_90 = r27;
    asm { sxtw       x8, w8 };
    *(int8_t *)(r24 + r8) = 0x0;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r28 = r0;
    r27 = [[r0 localizedStringForKey:@"Registered to: %@" value:@"" table:0x0] retain];
    r23 = [[r21 objectAtIndex:0x1] retain];
    r26 = [[NSString stringWithFormat:r27] retain];
    [r24 setDemoString:r26];
    [r26 release];
    [r23 release];
    [r27 release];
    [r28 release];
    r23 = [[r21 objectAtIndex:0x2] retain];
    r26 = [[r25 dateFromString:r23] retain];
    [r24 setLicenseExpirationDate:r26];
    [r26 release];
    [r23 release];
    r23 = [[r21 objectAtIndex:0x3] retain];
    [r24 setLicenseID:r23];
    [r23 release];
    r27 = sign_extend_64(*(int32_t *)ivar_offset(registerMenuItem));
    r0 = *(r24 + r27);
    if (r0 == 0x0) goto .l11;
    goto .l17;

.l49:
    if (r27 == 0x0) goto .l54;
    goto .l50;

.l53:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 boolValue] == 0x0) goto .l55;
    goto .l51;

loc_10001d80c:
    r22 = r24;
    *(int8_t *)(r22 + (r8 << r64)) = 0x1;
    asm { ccmp       x8, #0x0, #0x4, ne };
    bool_19 = asm { ccmp       x8, #0x0, #0x4, ne };
    if (asm { ccmp       x8, #0x0, #0x4, ne }) {
            r23 = 0x1;
    }
    if (bool_19) goto .l2;
    goto .l9;

loc_10001d678:
    var_90 = r27;
    asm { sxtw       x8, w8 };
    *(int8_t *)(r24 + r8) = 0x0;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r28 = r0;
    r27 = [[r0 localizedStringForKey:@"Registered to: %@" value:@"" table:0x0] retain];
    r23 = [[r21 objectAtIndex:0x1] retain];
    r26 = [[NSString stringWithFormat:r27] retain];
    [r24 setDemoString:r26];
    [r26 release];
    [r23 release];
    [r27 release];
    [r28 release];
    r23 = [[r21 objectAtIndex:0x2] retain];
    r26 = [[r25 dateFromString:r23] retain];
    [r24 setLicenseExpirationDate:r26];
    [r26 release];
    [r23 release];
    r23 = [[r21 objectAtIndex:0x3] retain];
    [r24 setLicenseID:r23];
    [r23 release];
    r27 = sign_extend_64(*(int32_t *)ivar_offset(registerMenuItem));
    r0 = *(r24 + r27);
    if (r0 == 0x0) goto loc_10001d800;
    goto loc_10001d7b0;

loc_10001d660:
    r24 = r22;
    r0 = var_60;
    r21 = [r0 retain];
    r23 = &@class(LoadingCrossTieSheetController);
    r8 = *(int32_t *)ivar_offset(isDemo);
    if (r21 == 0x0) goto .l44;
    goto .l45;

loc_10001d64c:
    r23 = &@class(LoadingCrossTieSheetController);
    r8 = *(int32_t *)ivar_offset(isDemo);
    *(int8_t *)(r22 + (r8 << r64)) = 0x1;
    asm { ccmp       x8, #0x0, #0x4, ne };
    bool_8 = asm { ccmp       x8, #0x0, #0x4, ne };
    if (asm { ccmp       x8, #0x0, #0x4, ne }) {
            r23 = 0x1;
    }
    if (bool_8) goto loc_10001d884;
    goto loc_10001d830;

.l69:
    if (r27 == 0x0) goto .l72;
    goto .l80;

.l79:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 boolValue] == 0x0) goto .l78;
    goto .l71;

.l67:
    r28 = var_80;
    r26 = var_78;
    r27 = var_90;
    r22 = var_88;
    goto .l77;

.l73:
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 release];
    if (r23 == 0x0) goto .l67;
    goto .l75;

.l63:
    [r25 release];
    [r21 release];
    [var_60 release];
    [r27 release];
    [r22 release];
    [var_68 release];
    [var_58 release];
    [r26 release];
    [r28 release];
    [r20 release];
    [r19 release];
    return;

.l61:
    r0 = *(r24 + r27);
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 removeItem:*(r24 + r27)];
    [r23 release];
    r26 = *(r24 + r27);
    *(r24 + r27) = 0x0;
    r22 = var_88;
    r28 = var_80;
    r27 = var_90;
    goto .l62;

.l13:
    if (r27 == 0x0) goto .l16;
    goto .l24;

.l23:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 boolValue] == 0x0) goto .l22;
    goto .l15;

.l11:
    r28 = var_80;
    r26 = var_78;
    r27 = var_90;
    r22 = var_88;
    goto .l21;

.l17:
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 release];
    if (r23 == 0x0) goto .l11;
    goto .l19;

.l54:
    if (var_60 != 0x0) {
            r28 = 0x0;
            r0 = [var_60 objectAtIndex:0x4];
            r0 = [r0 retain];
            r23 = r0;
            r21 = [r0 boolValue];
            [r23 release];
            if (r27 != 0x0) {
                    r23 = 0x1;
                    [r26 release];
                    if ((r28 & 0x1) == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
            else {
                    r23 = 0x0;
                    if (r28 == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
    }
    goto .l47;

.l50:
    r28 = 0x0;
    goto .l57;

.l55:
    var_90 = r21;
    r28 = 0x0;
    goto .l57;

.l51:
    r0 = [var_60 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] == 0x0) goto .l84;
    goto .l56;

.l2:
    if (r27 == 0x0) goto .l5;
    goto .l10;

.l9:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 boolValue] == 0x0) goto .l8;
    goto .l4;

loc_10001d800:
    r28 = var_80;
    r26 = var_78;
    r27 = var_90;
    r22 = var_88;
    goto loc_10001da54;

loc_10001d7b0:
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 release];
    if (r23 == 0x0) goto loc_10001d800;
    goto loc_10001d7c8;

.l44:
    r22 = r24;
    *(int8_t *)(r22 + (r8 << r64)) = 0x1;
    asm { ccmp       x8, #0x0, #0x4, ne };
    bool_68 = asm { ccmp       x8, #0x0, #0x4, ne };
    if (asm { ccmp       x8, #0x0, #0x4, ne }) {
            r23 = 0x1;
    }
    if (bool_68) goto .l31;
    goto .l42;

.l45:
    var_90 = r27;
    asm { sxtw       x8, w8 };
    *(int8_t *)(r24 + r8) = 0x0;
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r28 = r0;
    r27 = [[r0 localizedStringForKey:@"Registered to: %@" value:@"" table:0x0] retain];
    r23 = [[r21 objectAtIndex:0x1] retain];
    r26 = [[NSString stringWithFormat:r27] retain];
    [r24 setDemoString:r26];
    [r26 release];
    [r23 release];
    [r27 release];
    [r28 release];
    r23 = [[r21 objectAtIndex:0x2] retain];
    r26 = [[r25 dateFromString:r23] retain];
    [r24 setLicenseExpirationDate:r26];
    [r26 release];
    [r23 release];
    r23 = [[r21 objectAtIndex:0x3] retain];
    [r24 setLicenseID:r23];
    [r23 release];
    r27 = sign_extend_64(*(int32_t *)ivar_offset(registerMenuItem));
    r0 = *(r24 + r27);
    if (r0 == 0x0) goto .l29;
    goto .l35;

loc_10001d884:
    if (r27 == 0x0) goto loc_10001d8f4;
    goto loc_10001d888;

loc_10001d830:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 boolValue] == 0x0) goto loc_10001d890;
    goto loc_10001d850;

.l72:
    if (var_60 != 0x0) {
            r28 = 0x0;
            r0 = [var_60 objectAtIndex:0x4];
            r0 = [r0 retain];
            r23 = r0;
            r21 = [r0 boolValue];
            [r23 release];
            if (r27 != 0x0) {
                    r23 = 0x1;
                    [r26 release];
                    if ((r28 & 0x1) == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
            else {
                    r23 = 0x0;
                    if (r28 == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
    }
    goto .l68;

.l80:
    r28 = 0x0;
    goto .l74;

.l78:
    var_90 = r21;
    r28 = 0x0;
    goto .l74;

.l71:
    r0 = [var_60 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] == 0x0) goto .l83;
    goto .l70;

.l77:
    [r25 release];
    [r21 release];
    [var_60 release];
    [r27 release];
    [r22 release];
    [var_68 release];
    [var_58 release];
    [r26 release];
    [r28 release];
    [r20 release];
    [r19 release];
    return;

.l75:
    r0 = *(r24 + r27);
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 removeItem:*(r24 + r27)];
    [r23 release];
    r26 = *(r24 + r27);
    *(r24 + r27) = 0x0;
    r22 = var_88;
    r28 = var_80;
    r27 = var_90;
    goto .l76;

.l16:
    if (var_60 != 0x0) {
            r28 = 0x0;
            r0 = [var_60 objectAtIndex:0x4];
            r0 = [r0 retain];
            r23 = r0;
            r21 = [r0 boolValue];
            [r23 release];
            if (r27 != 0x0) {
                    r23 = 0x1;
                    [r26 release];
                    if ((r28 & 0x1) == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
            else {
                    r23 = 0x0;
                    if (r28 == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
    }
    goto .l12;

.l24:
    r28 = 0x0;
    goto .l18;

.l22:
    var_90 = r21;
    r28 = 0x0;
    goto .l18;

.l15:
    r0 = [var_60 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] == 0x0) goto .l27;
    goto .l14;

.l21:
    [r25 release];
    [r21 release];
    [var_60 release];
    [r27 release];
    [r22 release];
    [var_68 release];
    [var_58 release];
    [r26 release];
    [r28 release];
    [r20 release];
    [r19 release];
    return;

.l19:
    r0 = *(r24 + r27);
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 removeItem:*(r24 + r27)];
    [r23 release];
    r26 = *(r24 + r27);
    *(r24 + r27) = 0x0;
    r22 = var_88;
    r28 = var_80;
    r27 = var_90;
    goto .l20;

.l47:
    r28 = sign_extend_64(*(int32_t *)ivar_offset(daysLeft));
    if (*(int32_t *)(r22 + r28) > 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r23 = [[r0 localizedStringForKey:@"This demo version will expire in %d days." value:@"" table:0x0] retain];
            r21 = [[NSString stringWithFormat:r23] retain];
            [r22 setDemoString:r21];
            [r21 release];
            r0 = r23;
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r21 = [[r0 localizedStringForKey:@"This demo version has expired." value:@"" table:0x0] retain];
            [r22 setDemoString:r21];
            r0 = r21;
    }
    [r0 release];
    r22 = var_88;
    r28 = var_80;
    [r26 release];
    r26 = var_78;
    [r25 release];
    [0x0 release];
    [var_60 release];
    [r27 release];
    [r22 release];
    [var_68 release];
    [var_58 release];
    [r26 release];
    [r28 release];
    [r20 release];
    [r19 release];
    return;

.l57:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] != 0x0) {
            [r26 release];
            r21 = 0x1;
            if ((r28 & 0x1) != 0x0) {
                    [var_98 release];
                    if ((r23 & 0x1) == 0x0) {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
            else {
                    if (r23 != 0x0) {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
    }
    else {
            if (var_60 == 0x0) {
                    r23 = 0x0;
                    r21 = 0x0;
                    if (r27 == 0x0) {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
            else {
                    r0 = [var_60 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r23 = r0;
                    r21 = [r0 boolValue];
                    [r23 release];
                    if (r27 != 0x0) {
                            r23 = 0x1;
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
    }
    goto .l47;

.l84:
    var_98 = r26;
    var_90 = r21;
    r28 = 0x1;
    goto .l57;

.l56:
    [r26 release];
    [r21 release];
    NSLog(@"Revoke!\n");
    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
    goto .l47;

.l5:
    if (var_60 != 0x0) {
            r28 = 0x0;
            r0 = [var_60 objectAtIndex:0x4];
            r0 = [r0 retain];
            r23 = r0;
            r21 = [r0 boolValue];
            [r23 release];
            if (r27 != 0x0) {
                    r23 = 0x1;
                    [r26 release];
                    if ((r28 & 0x1) == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
            else {
                    r23 = 0x0;
                    if (r28 == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
    }
    goto .l1;

.l10:
    r28 = 0x0;
    goto .l7;

.l8:
    var_90 = r21;
    r28 = 0x0;
    goto .l7;

.l4:
    r0 = [var_60 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] == 0x0) goto loc_10001dad4;
    goto .l3;

loc_10001da54:
    [r25 release];
    [r21 release];
    [var_60 release];
    [r27 release];
    [r22 release];
    [var_68 release];
    [var_58 release];
    [r26 release];
    [r28 release];
    [r20 release];
    [r19 release];
    return;

loc_10001d7c8:
    r0 = *(r24 + r27);
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 removeItem:*(r24 + r27)];
    [r23 release];
    r26 = *(r24 + r27);
    *(r24 + r27) = 0x0;
    r22 = var_88;
    r28 = var_80;
    r27 = var_90;
    goto loc_10001da48;

.l31:
    if (r27 == 0x0) goto .l34;
    goto .l43;

.l42:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r21 = r0;
    if ([r0 boolValue] == 0x0) goto .l41;
    goto .l33;

.l29:
    r28 = var_80;
    r26 = var_78;
    r27 = var_90;
    r22 = var_88;
    goto .l40;

.l35:
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 release];
    if (r23 == 0x0) goto .l29;
    goto .l38;

loc_10001d8f4:
    if (var_60 != 0x0) {
            r28 = 0x0;
            r0 = [var_60 objectAtIndex:0x4];
            r0 = [r0 retain];
            r23 = r0;
            r21 = [r0 boolValue];
            [r23 release];
            if (r27 != 0x0) {
                    r23 = 0x1;
                    [r26 release];
                    if ((r28 & 0x1) == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
            else {
                    r23 = 0x0;
                    if (r28 == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
    }
    goto loc_10001d960;

loc_10001d888:
    r28 = 0x0;
    goto loc_10001d898;

loc_10001d890:
    var_90 = r21;
    r28 = 0x0;
    goto loc_10001d898;

loc_10001d850:
    r0 = [var_60 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] == 0x0) goto .l28;
    goto loc_10001d870;

.l68:
    r28 = sign_extend_64(*(int32_t *)ivar_offset(daysLeft));
    if (*(int32_t *)(r22 + r28) > 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r23 = [[r0 localizedStringForKey:@"This demo version will expire in %d days." value:@"" table:0x0] retain];
            r21 = [[NSString stringWithFormat:r23] retain];
            [r22 setDemoString:r21];
            [r21 release];
            r0 = r23;
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r21 = [[r0 localizedStringForKey:@"This demo version has expired." value:@"" table:0x0] retain];
            [r22 setDemoString:r21];
            r0 = r21;
    }
    [r0 release];
    r21 = 0x0;
    r22 = var_88;
    r28 = var_80;
    goto .l76;

.l74:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] != 0x0) {
            [r26 release];
            r21 = 0x1;
            if ((r28 & 0x1) != 0x0) {
                    [var_98 release];
                    if ((r23 & 0x1) == 0x0) {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
            else {
                    if (r23 != 0x0) {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
    }
    else {
            if (var_60 == 0x0) {
                    r23 = 0x0;
                    r21 = 0x0;
                    if (r27 == 0x0) {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
            else {
                    r0 = [var_60 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r23 = r0;
                    r21 = [r0 boolValue];
                    [r23 release];
                    if (r27 != 0x0) {
                            r23 = 0x1;
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
    }
    goto .l68;

.l83:
    var_98 = r26;
    var_90 = r21;
    r28 = 0x1;
    goto .l74;

.l70:
    [r26 release];
    [r21 release];
    NSLog(@"Revoke!\n");
    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
    goto .l68;

.l76:
    [r26 release];
    r26 = var_78;
    goto .l77;

.l12:
    r28 = sign_extend_64(*(int32_t *)ivar_offset(daysLeft));
    if (*(int32_t *)(r22 + r28) > 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r23 = [[r0 localizedStringForKey:@"This demo version will expire in %d days." value:@"" table:0x0] retain];
            r21 = [[NSString stringWithFormat:r23] retain];
            [r22 setDemoString:r21];
            [r21 release];
            r0 = r23;
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r21 = [[r0 localizedStringForKey:@"This demo version has expired." value:@"" table:0x0] retain];
            [r22 setDemoString:r21];
            r0 = r21;
    }
    [r0 release];
    r21 = 0x0;
    r22 = var_88;
    r28 = var_80;
    goto .l20;

.l18:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] != 0x0) {
            [r26 release];
            r21 = 0x1;
            if ((r28 & 0x1) != 0x0) {
                    [var_98 release];
                    if ((r23 & 0x1) == 0x0) {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
            else {
                    if (r23 != 0x0) {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
    }
    else {
            if (var_60 == 0x0) {
                    r23 = 0x0;
                    r21 = 0x0;
                    if (r27 == 0x0) {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
            else {
                    r0 = [var_60 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r23 = r0;
                    r21 = [r0 boolValue];
                    [r23 release];
                    if (r27 != 0x0) {
                            r23 = 0x1;
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
    }
    goto .l12;

.l27:
    var_98 = r26;
    var_90 = r21;
    r28 = 0x1;
    goto .l18;

.l14:
    [r26 release];
    [r21 release];
    NSLog(@"Revoke!\n");
    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
    goto .l12;

.l20:
    [r26 release];
    r26 = var_78;
    goto .l21;

.l1:
    r28 = sign_extend_64(*(int32_t *)ivar_offset(daysLeft));
    if (*(int32_t *)(r22 + r28) > 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r23 = [[r0 localizedStringForKey:@"This demo version will expire in %d days." value:@"" table:0x0] retain];
            r21 = [[NSString stringWithFormat:r23] retain];
            [r22 setDemoString:r21];
            [r21 release];
            r0 = r23;
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r21 = [[r0 localizedStringForKey:@"This demo version has expired." value:@"" table:0x0] retain];
            [r22 setDemoString:r21];
            r0 = r21;
    }
    [r0 release];
    r21 = 0x0;
    r22 = var_88;
    r28 = var_80;
    goto loc_10001da48;

.l7:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] != 0x0) {
            [r26 release];
            r21 = 0x1;
            if ((r28 & 0x1) != 0x0) {
                    [var_98 release];
                    if ((r23 & 0x1) == 0x0) {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
            else {
                    if (r23 != 0x0) {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
    }
    else {
            if (var_60 == 0x0) {
                    r23 = 0x0;
                    r21 = 0x0;
                    if (r27 == 0x0) {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
            else {
                    r0 = [var_60 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r23 = r0;
                    r21 = [r0 boolValue];
                    [r23 release];
                    if (r27 != 0x0) {
                            r23 = 0x1;
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
    }
    goto .l1;

loc_10001dad4:
    var_98 = r26;
    var_90 = r21;
    r28 = 0x1;
    goto .l7;

.l3:
    [r26 release];
    [r21 release];
    NSLog(@"Revoke!\n");
    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
    goto .l1;

loc_10001da48:
    [r26 release];
    r26 = var_78;
    goto loc_10001da54;

.l34:
    if (var_60 != 0x0) {
            r28 = 0x0;
            r0 = [var_60 objectAtIndex:0x4];
            r0 = [r0 retain];
            r23 = r0;
            r21 = [r0 boolValue];
            [r23 release];
            if (r27 != 0x0) {
                    r23 = 0x1;
                    [r26 release];
                    if ((r28 & 0x1) == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
            else {
                    r23 = 0x0;
                    if (r28 == 0x0) {
                            if (r23 != 0x0) {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
                    else {
                            [var_98 release];
                            if ((r23 & 0x1) == 0x0) {
                                    if (r21 != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                            else {
                                    [var_90 release];
                                    if ((r21 & 0x1) != 0x0) {
                                            NSLog(@"Revoke!\n");
                                            *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                    }
                            }
                    }
            }
    }
    goto .l30;

.l43:
    r28 = 0x0;
    goto .l36;

.l41:
    var_90 = r21;
    r28 = 0x0;
    goto .l36;

.l33:
    r0 = [var_60 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] == 0x0) goto .l46;
    goto .l32;

.l40:
    [r25 release];
    [r21 release];
    [var_60 release];
    [r27 release];
    [r22 release];
    [var_68 release];
    [var_58 release];
    [r26 release];
    [r28 release];
    [r20 release];
    [r19 release];
    return;

.l38:
    r0 = *(r24 + r27);
    r0 = [r0 menu];
    r0 = [r0 retain];
    r23 = r0;
    [r0 removeItem:*(r24 + r27)];
    [r23 release];
    r26 = *(r24 + r27);
    *(r24 + r27) = 0x0;
    r22 = var_88;
    r28 = var_80;
    r27 = var_90;
    goto .l39;

loc_10001d960:
    r28 = sign_extend_64(*(int32_t *)ivar_offset(daysLeft));
    if (*(int32_t *)(r22 + r28) > 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r23 = [[r0 localizedStringForKey:@"This demo version will expire in %d days." value:@"" table:0x0] retain];
            r21 = [[NSString stringWithFormat:r23] retain];
            [r22 setDemoString:r21];
            [r21 release];
            r0 = r23;
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r21 = [[r0 localizedStringForKey:@"This demo version has expired." value:@"" table:0x0] retain];
            [r22 setDemoString:r21];
            r0 = r21;
    }
    [r0 release];
    r22 = var_88;
    r28 = var_80;
    [r26 release];
    r26 = var_78;
    [r25 release];
    [0x0 release];
    [var_60 release];
    [r27 release];
    [r22 release];
    [var_68 release];
    [var_58 release];
    [r26 release];
    [r28 release];
    [r20 release];
    [r19 release];
    return;

loc_10001d898:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] != 0x0) {
            [r26 release];
            r21 = 0x1;
            if ((r28 & 0x1) != 0x0) {
                    [var_98 release];
                    if ((r23 & 0x1) == 0x0) {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
            else {
                    if (r23 != 0x0) {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
    }
    else {
            if (var_60 == 0x0) {
                    r23 = 0x0;
                    r21 = 0x0;
                    if (r27 == 0x0) {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
            else {
                    r0 = [var_60 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r23 = r0;
                    r21 = [r0 boolValue];
                    [r23 release];
                    if (r27 != 0x0) {
                            r23 = 0x1;
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
    }
    goto loc_10001d960;

.l28:
    var_98 = r26;
    var_90 = r21;
    r28 = 0x1;
    goto loc_10001d898;

loc_10001d870:
    [r26 release];
    [r21 release];
    NSLog(@"Revoke!\n");
    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
    goto loc_10001d960;

.l30:
    r28 = sign_extend_64(*(int32_t *)ivar_offset(daysLeft));
    if (*(int32_t *)(r22 + r28) > 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r23 = [[r0 localizedStringForKey:@"This demo version will expire in %d days." value:@"" table:0x0] retain];
            r21 = [[NSString stringWithFormat:r23] retain];
            [r22 setDemoString:r21];
            [r21 release];
            r0 = r23;
    }
    else {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r26 = r0;
            r21 = [[r0 localizedStringForKey:@"This demo version has expired." value:@"" table:0x0] retain];
            [r22 setDemoString:r21];
            r0 = r21;
    }
    [r0 release];
    r21 = 0x0;
    r22 = var_88;
    r28 = var_80;
    goto .l39;

.l36:
    r0 = [r27 objectAtIndex:0x4];
    r0 = [r0 retain];
    r26 = r0;
    if ([r0 boolValue] != 0x0) {
            [r26 release];
            r21 = 0x1;
            if ((r28 & 0x1) != 0x0) {
                    [var_98 release];
                    if ((r23 & 0x1) == 0x0) {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
            else {
                    if (r23 != 0x0) {
                            [var_90 release];
                            if ((r21 & 0x1) != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
                    else {
                            if (r21 != 0x0) {
                                    NSLog(@"Revoke!\n");
                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                            }
                    }
            }
    }
    else {
            if (var_60 == 0x0) {
                    r23 = 0x0;
                    r21 = 0x0;
                    if (r27 == 0x0) {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
            else {
                    r0 = [var_60 objectAtIndex:0x4];
                    r0 = [r0 retain];
                    r23 = r0;
                    r21 = [r0 boolValue];
                    [r23 release];
                    if (r27 != 0x0) {
                            r23 = 0x1;
                            [r26 release];
                            if ((r28 & 0x1) == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
                    else {
                            r23 = 0x0;
                            if (r28 == 0x0) {
                                    if (r23 != 0x0) {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                            else {
                                    [var_98 release];
                                    if ((r23 & 0x1) == 0x0) {
                                            if (r21 != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                                    else {
                                            [var_90 release];
                                            if ((r21 & 0x1) != 0x0) {
                                                    NSLog(@"Revoke!\n");
                                                    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
                                            }
                                    }
                            }
                    }
            }
    }
    goto .l30;

.l46:
    var_98 = r26;
    var_90 = r21;
    r28 = 0x1;
    goto .l36;

.l32:
    [r26 release];
    [r21 release];
    NSLog(@"Revoke!\n");
    *(int32_t *)(int64_t *)&r22->daysLeft = 0x0;
    goto .l30;

.l39:
    [r26 release];
    r26 = var_78;
    goto .l40;


// 0x10001dae0
// -[CXApplication daysLeft]
    r0 = *(int32_t *)(int64_t *)&self->daysLeft;
    return r0;


// 0x10001daf0
// -[CXApplication setDaysLeft]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [NSUserDefaults standardUserDefaults];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 objectForKey:@"FirstRunDate"] retain];
    [r21 release];
    if (r20 != 0x0) {
            r21 = [[NSCalendar alloc] initWithCalendarIdentifier:**_NSCalendarIdentifierGregorian];
            r22 = [[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"] retain];
            [r21 setLocale:r22];
            [r22 release];
            r22 = [[NSDate date] retain];
            r23 = [[r21 components:0x10 fromDate:r20 toDate:r22 options:0x0] retain];
            [r22 release];
            r0 = [r23 day];
            r8 = sign_extend_64(*(int32_t *)ivar_offset(daysLeft));
            r9 = 0xe - r0;
            if (r9 < 0x0) {
                    r9 = 0x0;
            }
            *(int32_t *)(r19 + r8) = r9;
            [r23 release];
            [r21 release];
    }
    else {
            r21 = [[NSUserDefaults standardUserDefaults] retain];
            r22 = [[NSDate date] retain];
            [r21 setObject:r22 forKey:@"FirstRunDate"];
            [r22 release];
            [r21 release];
            *(int32_t *)(int64_t *)&r19->daysLeft = 0xe;
    }
    [r20 release];
    return;


// 0x10001dc88
// -[CXApplication orderFrontStandardAboutPanel:]
    r31 = r31 - 0x60;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([@"1" isEqualToString:@"0"] != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 localizedStringForKey:@"%@ Standard" value:@"" table:0x0] retain];
            r21 = [[NSString stringWithFormat:r23] retain];
            r20 = [[NSDictionary dictionaryWithObject:r21 forKey:@"ApplicationName"] retain];
            [r19 orderFrontStandardAboutPanelWithOptions:r20];
            [r20 release];
            [r21 release];
            [r23 release];
            [r22 release];
    }
    else {
            var_40 = r19;
            [[&var_40 super] orderFrontStandardAboutPanel:0x0];
    }
    return;


// 0x10001ddc4
// -[CXApplication reportException:]
    r0 = [arg2 retain];
    r20 = r0;
    r21 = [[r0 debugDescription] retain];
    _CXLog();
    [r21 release];
    var_30 = self;
    [[&var_30 super] reportException:r20];
    [r20 release];
    return;


// 0x10001de4c
// -[CXApplication setWineController:]
    r31 = r31 - 0x150;
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
    r19 = [arg2 retain];
    var_138 = [**_NSApplicationDidBecomeActiveNotification retain];
    [**_NSApplicationDidChangeScreenParametersNotification retain];
    [**_NSApplicationDidFinishLaunchingNotification retain];
    [**_NSApplicationDidHideNotification retain];
    [**_NSApplicationDidResignActiveNotification retain];
    [**_NSApplicationDidUnhideNotification retain];
    [**_NSApplicationDidUpdateNotification retain];
    [**_NSApplicationWillBecomeActiveNotification retain];
    [**_NSApplicationWillFinishLaunchingNotification retain];
    [**_NSApplicationWillHideNotification retain];
    [**_NSApplicationWillResignActiveNotification retain];
    [**_NSApplicationWillTerminateNotification retain];
    [**_NSApplicationWillUnhideNotification retain];
    [**_NSApplicationWillUpdateNotification retain];
    r21 = [[NSNotificationCenter defaultCenter] retain];
    r22 = (int64_t *)&r20->_wineController;
    r0 = objc_loadWeakRetained(r22);
    r23 = r0;
    [r0 release];
    if (r23 != 0x0) {
            r25 = 0x0;
            r26 = &var_138;
            do {
                    r23 = objc_loadWeakRetained(r22);
                    r27 = r26 + r25;
                    r24 = objc_opt_respondsToSelector();
                    [r23 release];
                    if ((r24 & 0x1) != 0x0) {
                            r23 = objc_loadWeakRetained(r22);
                            [r21 removeObserver:r23 name:*r27 object:r20];
                            [r23 release];
                    }
                    r25 = r25 + 0x10;
            } while (r25 != 0xe0);
    }
    [objc_storeWeak(r22, r19) retain];
    [r19 release];
    if (r19 != 0x0) {
            r25 = 0x0;
            r26 = &var_138;
            do {
                    r23 = objc_loadWeakRetained(r22);
                    r27 = r26 + r25;
                    r24 = objc_opt_respondsToSelector();
                    [r23 release];
                    if ((r24 & 0x1) != 0x0) {
                            r23 = objc_loadWeakRetained(r22);
                            [r21 addObserver:r23 selector:r27[0x1] name:*r27 object:r20];
                            [r23 release];
                    }
                    r25 = r25 + 0x10;
            } while (r25 != 0xe0);
    }
    [r21 release];
    r20 = 0xd0;
    r21 = &var_138;
    do {
            [*(r21 + r20) release];
            r20 = r20 - 0x10;
    } while (r20 != -0x10);
    [r19 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x10001e1d4
// -[CXApplication sendEvent:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [arg2 retain];
    r20 = (int64_t *)&r21->_wineController;
    r0 = objc_loadWeakRetained(r20);
    r22 = r0;
    r23 = [r0 handleEvent:r19];
    [r22 release];
    if ((r23 & 0x1) == 0x0) {
            var_40 = r21;
            [[&var_40 super] sendEvent:r19];
            r0 = objc_loadWeakRetained(r20);
            r20 = r0;
            [r0 didSendEvent:r19];
            [r20 release];
    }
    [r19 release];
    return;


// 0x10001e288
// -[CXApplication licenseID]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_licenseID)), 0x1);
    return r0;


// 0x10001e298
// -[CXApplication setLicenseID:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001e2a4
// -[CXApplication licenseExpirationDate]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_licenseExpirationDate)), 0x1);
    return r0;


// 0x10001e2b4
// -[CXApplication setLicenseExpirationDate:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001e2c0
// -[CXApplication wineController]
    r0 = objc_loadWeakRetained((int64_t *)&self->_wineController);
    r0 = [r0 autorelease];
    return r0;


// 0x10001e2e0
// -[CXApplication demoString]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_demoString)), 0x1);
    return r0;


// 0x10001e2f0
// -[CXApplication setDemoString:]
    objc_setProperty_atomic_copy();
    return;


// 0x10001e2fc
// -[CXApplication CXServer]
    r0 = objc_loadWeakRetained((int64_t *)&self->_CXServer);
    r0 = [r0 autorelease];
    return r0;


// 0x10001e31c
// -[CXApplication setCXServer:]
    objc_storeWeak((int64_t *)&self->_CXServer, arg2);
    return;


// 0x10001e330
// -[CXApplication .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_CXServer);
    objc_storeStrong((int64_t *)&self->_demoString, 0x0);
    objc_destroyWeak((int64_t *)&self->_wineController);
    objc_storeStrong((int64_t *)&self->_licenseExpirationDate, 0x0);
    objc_storeStrong((int64_t *)&self->_licenseID, 0x0);
    objc_storeStrong((int64_t *)&self->registerMenuItem, 0x0);
    objc_storeStrong((int64_t *)&self->crossOverRootURL, 0x0);
    objc_storeStrong((int64_t *)&self->crossOverRoot, 0x0);
    return;


