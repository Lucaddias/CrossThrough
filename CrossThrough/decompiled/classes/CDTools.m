// CDTools — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x1000101d8
// +[CDTools isValidInstallerVolume:requireRemovable:]
    r31 = r31 - 0x170;
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
    r21 = arg3;
    r27 = self;
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r20 = r0;
    [r0 fileExistsAtPath:r19 isDirectory:&var_E1];
    [r20 release];
    asm { ccmp       w23, #0x0, #0x0, ne };
    if (!asm { ccmp       w23, #0x0, #0x0, ne }) {
            if ([r19 compare:@"/"] != 0x0) {
                    if (r21 != 0x0) {
                            r0 = [NSWorkspace sharedWorkspace];
                            r0 = [r0 retain];
                            r20 = r0;
                            var_110 = 0x0;
                            var_108 = 0x0;
                            r0 = [r0 getFileSystemInfoForPath:r19 isRemovable:&var_F9 isWritable:&decomp_var_fa isUnmountable:&decomp_var_fb description:&var_108 type:&var_110];
                            r23 = r0;
                            r21 = [var_108 retain];
                            r22 = [var_110 retain];
                            if (r23 != 0x0) {
                                    if (var_F9 != 0x0) {
                                            if (([r22 isEqualToString:@"cd9660"] & 0x1) != 0x0) {
                                                    [r20 release];
                                                    [r22 release];
                                                    [r21 release];
                                                    r0 = [NSFileManager defaultManager];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    r21 = [[r0 contentsOfDirectoryAtPath:r19 error:0x0] retain];
                                                    [r20 release];
                                                    var_150 = q0;
                                                    var_140 = q0;
                                                    r0 = [r21 retain];
                                                    r21 = r0;
                                                    r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                    if (r0 != 0x0) {
                                                            r24 = r0;
                                                            r28 = *var_140;
                                                            var_158 = r27;
                                                            while (true) {
                                                                    r27 = 0x0;
                                                                    while (true) {
                                                                            if (*var_140 != r28) {
                                                                                    objc_enumerationMutation(r21);
                                                                            }
                                                                            r20 = *(var_148 + r27 * 0x8);
                                                                            if ([r20 caseInsensitiveCompare:@"autorun.inf"] == 0x0) {
                                                                                    temp_0 = 0x7;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"autorun.exe"] == 0x0) {
                                                                                    temp_0 = 0x1;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"setup.exe"] == 0x0) {
                                                                                    temp_0 = 0x1;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"setup.bat"] == 0x0) {
                                                                                    temp_0 = 0x2;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"install.exe"] == 0x0) {
                                                                                    temp_0 = 0x3;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"install.bat"] == 0x0) {
                                                                                    temp_0 = 0x4;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"setuppls.exe"] == 0x0) {
                                                                                    temp_0 = 0x5;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"setupse.exe"] == 0x0) {
                                                                                    temp_0 = 0x0;
                                                                                    break;
                                                                            }
                                                                            r27 = r27 + 0x1;
                                                                            if (r24 != r27) {
                                                                                    continue;
                                                                            }
                                                                            temp_0 = 0x6;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x0) {
                                                                            temp_1 = 0x0;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x1) {
                                                                            temp_1 = 0x1;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x2) {
                                                                            temp_1 = 0x1;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x3) {
                                                                            temp_1 = 0x2;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x4) {
                                                                            temp_1 = 0x3;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x5) {
                                                                            temp_1 = 0x4;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x6) {
                                                                            r0 = [r21 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                                            r24 = r0;
                                                                            r27 = var_158;
                                                                            if (r0 != 0x0) {
                                                                                    continue;
                                                                            }
                                                                            temp_1 = 0x5;
                                                                            break;
                                                                    }
                                                                    temp_1 = 0x6;
                                                                    break;
                                                            }
                                                            switch (temp_1) {
                                                                case 0:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 1:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 2:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 3:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 4:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 5:
                                                                    [r21 release];
                                                                    r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    if ([r0 count] != 0x0) {
                                                                            r20 = 0x1;
                                                                    }
                                                                    break;
                                                                default:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            [r21 release];
                                                            r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                            r0 = [r0 retain];
                                                            r22 = r0;
                                                            if ([r0 count] != 0x0) {
                                                                    r20 = 0x1;
                                                            }
                                                    }
                                                    [r22 release];
                                                    [r21 release];
                                                    r0 = [r19 release];
                                                    if (**___stack_chk_guard != var_60) {
                                                            __stack_chk_fail();
                                                    }
                                                    r0 = r20;
                                            }
                                            else {
                                                    r23 = [r22 isEqualToString:@"udf"];
                                                    [r20 release];
                                                    if ((r23 & 0x1) == 0x0) {
                                                            [r22 release];
                                                            [r21 release];
                                                            r0 = [r19 release];
                                                            if (**___stack_chk_guard != var_60) {
                                                                    __stack_chk_fail();
                                                            }
                                                            r0 = 0x0;
                                                    }
                                                    else {
                                                            [r22 release];
                                                            [r21 release];
                                                            r0 = [NSFileManager defaultManager];
                                                            r0 = [r0 retain];
                                                            r20 = r0;
                                                            r21 = [[r0 contentsOfDirectoryAtPath:r19 error:0x0] retain];
                                                            [r20 release];
                                                            var_150 = q0;
                                                            var_140 = q0;
                                                            r0 = [r21 retain];
                                                            r21 = r0;
                                                            r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                            if (r0 != 0x0) {
                                                                    r24 = r0;
                                                                    r28 = *var_140;
                                                                    var_158 = r27;
                                                                    while (true) {
                                                                            r27 = 0x0;
                                                                            while (true) {
                                                                                    if (*var_140 != r28) {
                                                                                            objc_enumerationMutation(r21);
                                                                                    }
                                                                                    r20 = *(var_148 + r27 * 0x8);
                                                                                    if ([r20 caseInsensitiveCompare:@"autorun.inf"] == 0x0) {
                                                                                            temp_0 = 0x7;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"autorun.exe"] == 0x0) {
                                                                                            temp_0 = 0x1;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"setup.exe"] == 0x0) {
                                                                                            temp_0 = 0x1;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"setup.bat"] == 0x0) {
                                                                                            temp_0 = 0x2;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"install.exe"] == 0x0) {
                                                                                            temp_0 = 0x3;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"install.bat"] == 0x0) {
                                                                                            temp_0 = 0x4;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"setuppls.exe"] == 0x0) {
                                                                                            temp_0 = 0x5;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"setupse.exe"] == 0x0) {
                                                                                            temp_0 = 0x0;
                                                                                            break;
                                                                                    }
                                                                                    r27 = r27 + 0x1;
                                                                                    if (r24 != r27) {
                                                                                            continue;
                                                                                    }
                                                                                    temp_0 = 0x6;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x0) {
                                                                                    temp_1 = 0x0;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x1) {
                                                                                    temp_1 = 0x1;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x2) {
                                                                                    temp_1 = 0x1;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x3) {
                                                                                    temp_1 = 0x2;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x4) {
                                                                                    temp_1 = 0x3;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x5) {
                                                                                    temp_1 = 0x4;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x6) {
                                                                                    r0 = [r21 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                                                    r24 = r0;
                                                                                    r27 = var_158;
                                                                                    if (r0 != 0x0) {
                                                                                            continue;
                                                                                    }
                                                                                    temp_1 = 0x5;
                                                                                    break;
                                                                            }
                                                                            temp_1 = 0x6;
                                                                            break;
                                                                    }
                                                                    switch (temp_1) {
                                                                        case 0:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 1:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 2:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 3:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 4:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 5:
                                                                            [r21 release];
                                                                            r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                            r0 = [r0 retain];
                                                                            r22 = r0;
                                                                            if ([r0 count] != 0x0) {
                                                                                    r20 = 0x1;
                                                                            }
                                                                            break;
                                                                        default:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                    }
                                                            }
                                                            else {
                                                                    [r21 release];
                                                                    r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    if ([r0 count] != 0x0) {
                                                                            r20 = 0x1;
                                                                    }
                                                            }
                                                            [r22 release];
                                                            [r21 release];
                                                            r0 = [r19 release];
                                                            if (**___stack_chk_guard != var_60) {
                                                                    __stack_chk_fail();
                                                            }
                                                            r0 = r20;
                                                    }
                                            }
                                    }
                                    else {
                                            [r20 release];
                                            [r22 release];
                                            [r21 release];
                                            r0 = [r19 release];
                                            if (**___stack_chk_guard != var_60) {
                                                    __stack_chk_fail();
                                            }
                                            r0 = 0x0;
                                    }
                            }
                            else {
                                    [r20 release];
                                    [r22 release];
                                    [r21 release];
                                    r0 = [NSFileManager defaultManager];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r21 = [[r0 contentsOfDirectoryAtPath:r19 error:0x0] retain];
                                    [r20 release];
                                    var_150 = q0;
                                    var_140 = q0;
                                    r0 = [r21 retain];
                                    r21 = r0;
                                    r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                    if (r0 != 0x0) {
                                            r24 = r0;
                                            r28 = *var_140;
                                            var_158 = r27;
                                            while (true) {
                                                    r27 = 0x0;
                                                    while (true) {
                                                            if (*var_140 != r28) {
                                                                    objc_enumerationMutation(r21);
                                                            }
                                                            r20 = *(var_148 + r27 * 0x8);
                                                            if ([r20 caseInsensitiveCompare:@"autorun.inf"] == 0x0) {
                                                                    temp_0 = 0x7;
                                                                    break;
                                                            }
                                                            if ([r20 caseInsensitiveCompare:@"autorun.exe"] == 0x0) {
                                                                    temp_0 = 0x1;
                                                                    break;
                                                            }
                                                            if ([r20 caseInsensitiveCompare:@"setup.exe"] == 0x0) {
                                                                    temp_0 = 0x1;
                                                                    break;
                                                            }
                                                            if ([r20 caseInsensitiveCompare:@"setup.bat"] == 0x0) {
                                                                    temp_0 = 0x2;
                                                                    break;
                                                            }
                                                            if ([r20 caseInsensitiveCompare:@"install.exe"] == 0x0) {
                                                                    temp_0 = 0x3;
                                                                    break;
                                                            }
                                                            if ([r20 caseInsensitiveCompare:@"install.bat"] == 0x0) {
                                                                    temp_0 = 0x4;
                                                                    break;
                                                            }
                                                            if ([r20 caseInsensitiveCompare:@"setuppls.exe"] == 0x0) {
                                                                    temp_0 = 0x5;
                                                                    break;
                                                            }
                                                            if ([r20 caseInsensitiveCompare:@"setupse.exe"] == 0x0) {
                                                                    temp_0 = 0x0;
                                                                    break;
                                                            }
                                                            r27 = r27 + 0x1;
                                                            if (r24 != r27) {
                                                                    continue;
                                                            }
                                                            temp_0 = 0x6;
                                                            break;
                                                    }
                                                    if (temp_0 == 0x0) {
                                                            temp_1 = 0x0;
                                                            break;
                                                    }
                                                    if (temp_0 == 0x1) {
                                                            temp_1 = 0x1;
                                                            break;
                                                    }
                                                    if (temp_0 == 0x2) {
                                                            temp_1 = 0x1;
                                                            break;
                                                    }
                                                    if (temp_0 == 0x3) {
                                                            temp_1 = 0x2;
                                                            break;
                                                    }
                                                    if (temp_0 == 0x4) {
                                                            temp_1 = 0x3;
                                                            break;
                                                    }
                                                    if (temp_0 == 0x5) {
                                                            temp_1 = 0x4;
                                                            break;
                                                    }
                                                    if (temp_0 == 0x6) {
                                                            r0 = [r21 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                            r24 = r0;
                                                            r27 = var_158;
                                                            if (r0 != 0x0) {
                                                                    continue;
                                                            }
                                                            temp_1 = 0x5;
                                                            break;
                                                    }
                                                    temp_1 = 0x6;
                                                    break;
                                            }
                                            switch (temp_1) {
                                                case 0:
                                                    r20 = 0x1;
                                                    r22 = r21;
                                                    break;
                                                case 1:
                                                    r20 = 0x1;
                                                    r22 = r21;
                                                    break;
                                                default:
                                                    if (temp_1 != 0x2 && temp_1 != 0x3) {
                                                            switch (temp_1) {
                                                                case 4:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 5:
                                                                    [r21 release];
                                                                    r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    if ([r0 count] != 0x0) {
                                                                            r20 = 0x1;
                                                                    }
                                                                    break;
                                                                default:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            r20 = 0x1;
                                                            r22 = r21;
                                                    }
                                                    break;
                                            }
                                    }
                                    else {
                                            [r21 release];
                                            r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            if ([r0 count] != 0x0) {
                                                    r20 = 0x1;
                                            }
                                    }
                                    [r22 release];
                                    [r21 release];
                                    r0 = [r19 release];
                                    if (**___stack_chk_guard != var_60) {
                                            __stack_chk_fail();
                                    }
                                    r0 = r20;
                            }
                    }
                    else {
                            r0 = [NSFileManager defaultManager];
                            r0 = [r0 retain];
                            r20 = r0;
                            r21 = [[r0 contentsOfDirectoryAtPath:r19 error:0x0] retain];
                            [r20 release];
                            var_150 = q0;
                            var_140 = q0;
                            r0 = [r21 retain];
                            r21 = r0;
                            r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                            if (r0 != 0x0) {
                                    r24 = r0;
                                    r28 = *var_140;
                                    var_158 = r27;
                                    while (true) {
                                            r27 = 0x0;
                                            while (true) {
                                                    if (*var_140 != r28) {
                                                            objc_enumerationMutation(r21);
                                                    }
                                                    r20 = *(var_148 + r27 * 0x8);
                                                    if ([r20 caseInsensitiveCompare:@"autorun.inf"] == 0x0) {
                                                            temp_0 = 0x7;
                                                            break;
                                                    }
                                                    if ([r20 caseInsensitiveCompare:@"autorun.exe"] == 0x0) {
                                                            temp_0 = 0x1;
                                                            break;
                                                    }
                                                    if ([r20 caseInsensitiveCompare:@"setup.exe"] == 0x0) {
                                                            temp_0 = 0x1;
                                                            break;
                                                    }
                                                    if ([r20 caseInsensitiveCompare:@"setup.bat"] == 0x0) {
                                                            temp_0 = 0x2;
                                                            break;
                                                    }
                                                    if ([r20 caseInsensitiveCompare:@"install.exe"] == 0x0) {
                                                            temp_0 = 0x3;
                                                            break;
                                                    }
                                                    if ([r20 caseInsensitiveCompare:@"install.bat"] == 0x0) {
                                                            temp_0 = 0x4;
                                                            break;
                                                    }
                                                    if ([r20 caseInsensitiveCompare:@"setuppls.exe"] == 0x0) {
                                                            temp_0 = 0x5;
                                                            break;
                                                    }
                                                    if ([r20 caseInsensitiveCompare:@"setupse.exe"] == 0x0) {
                                                            temp_0 = 0x0;
                                                            break;
                                                    }
                                                    r27 = r27 + 0x1;
                                                    if (r24 != r27) {
                                                            continue;
                                                    }
                                                    temp_0 = 0x6;
                                                    break;
                                            }
                                            if (temp_0 == 0x0) {
                                                    temp_1 = 0x0;
                                                    break;
                                            }
                                            if (temp_0 == 0x1) {
                                                    temp_1 = 0x1;
                                                    break;
                                            }
                                            if (temp_0 == 0x2) {
                                                    temp_1 = 0x1;
                                                    break;
                                            }
                                            if (temp_0 == 0x3) {
                                                    temp_1 = 0x2;
                                                    break;
                                            }
                                            if (temp_0 == 0x4) {
                                                    temp_1 = 0x3;
                                                    break;
                                            }
                                            if (temp_0 == 0x5) {
                                                    temp_1 = 0x4;
                                                    break;
                                            }
                                            if (temp_0 == 0x6) {
                                                    r0 = [r21 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                    r24 = r0;
                                                    r27 = var_158;
                                                    if (r0 != 0x0) {
                                                            continue;
                                                    }
                                                    temp_1 = 0x5;
                                                    break;
                                            }
                                            temp_1 = 0x6;
                                            break;
                                    }
                                    switch (temp_1) {
                                        case 0:
                                            r20 = 0x1;
                                            r22 = r21;
                                            break;
                                        case 1:
                                            r20 = 0x1;
                                            r22 = r21;
                                            break;
                                        case 2:
                                            r20 = 0x1;
                                            r22 = r21;
                                            break;
                                        case 3:
                                            r20 = 0x1;
                                            r22 = r21;
                                            break;
                                        case 4:
                                            r20 = 0x1;
                                            r22 = r21;
                                            break;
                                        case 5:
                                            [r21 release];
                                            r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            if ([r0 count] != 0x0) {
                                                    r20 = 0x1;
                                            }
                                            break;
                                        default:
                                            r20 = 0x1;
                                            r22 = r21;
                                            break;
                                    }
                            }
                            else {
                                    [r21 release];
                                    r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    if ([r0 count] != 0x0) {
                                            r20 = 0x1;
                                    }
                            }
                            [r22 release];
                            [r21 release];
                            r0 = [r19 release];
                            if (**___stack_chk_guard != var_60) {
                                    __stack_chk_fail();
                            }
                            r0 = r20;
                    }
            }
            else {
                    r0 = [r19 release];
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = 0x0;
            }
    }
    else {
            r0 = [NSWorkspace sharedWorkspace];
            r0 = [r0 retain];
            r23 = r0;
            var_F8 = 0x0;
            var_F0 = 0x0;
            [r0 getInfoForFile:r19 application:&var_F0 type:&var_F8];
            r20 = [var_F0 retain];
            r22 = [var_F8 retain];
            [r23 release];
            if ([r22 caseInsensitiveCompare:@"exe"] != 0x0) {
                    if ([r22 caseInsensitiveCompare:@"msi"] != 0x0) {
                            if ([r22 caseInsensitiveCompare:@"inf"] != 0x0) {
                                    [r22 release];
                                    [r20 release];
                                    if ([r19 compare:@"/"] != 0x0) {
                                            if (r21 != 0x0) {
                                                    r0 = [NSWorkspace sharedWorkspace];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    var_110 = 0x0;
                                                    var_108 = 0x0;
                                                    r0 = [r0 getFileSystemInfoForPath:r19 isRemovable:&var_F9 isWritable:&decomp_var_fa isUnmountable:&decomp_var_fb description:&var_108 type:&var_110];
                                                    r23 = r0;
                                                    r21 = [var_108 retain];
                                                    r22 = [var_110 retain];
                                                    if (r23 != 0x0) {
                                                            if (var_F9 != 0x0) {
                                                                    if (([r22 isEqualToString:@"cd9660"] & 0x1) != 0x0) {
                                                                            [r20 release];
                                                                            [r22 release];
                                                                            [r21 release];
                                                                            r0 = [NSFileManager defaultManager];
                                                                            r0 = [r0 retain];
                                                                            r20 = r0;
                                                                            r21 = [[r0 contentsOfDirectoryAtPath:r19 error:0x0] retain];
                                                                            [r20 release];
                                                                            var_150 = q0;
                                                                            var_140 = q0;
                                                                            r0 = [r21 retain];
                                                                            r21 = r0;
                                                                            r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                                            if (r0 != 0x0) {
                                                                                    r24 = r0;
                                                                                    r28 = *var_140;
                                                                                    var_158 = r27;
                                                                                    while (true) {
                                                                                            r27 = 0x0;
                                                                                            while (true) {
                                                                                                    if (*var_140 != r28) {
                                                                                                            objc_enumerationMutation(r21);
                                                                                                    }
                                                                                                    r20 = *(var_148 + r27 * 0x8);
                                                                                                    if ([r20 caseInsensitiveCompare:@"autorun.inf"] == 0x0) {
                                                                                                            temp_0 = 0x7;
                                                                                                            break;
                                                                                                    }
                                                                                                    if ([r20 caseInsensitiveCompare:@"autorun.exe"] == 0x0) {
                                                                                                            temp_0 = 0x1;
                                                                                                            break;
                                                                                                    }
                                                                                                    if ([r20 caseInsensitiveCompare:@"setup.exe"] == 0x0) {
                                                                                                            temp_0 = 0x1;
                                                                                                            break;
                                                                                                    }
                                                                                                    if ([r20 caseInsensitiveCompare:@"setup.bat"] == 0x0) {
                                                                                                            temp_0 = 0x2;
                                                                                                            break;
                                                                                                    }
                                                                                                    if ([r20 caseInsensitiveCompare:@"install.exe"] == 0x0) {
                                                                                                            temp_0 = 0x3;
                                                                                                            break;
                                                                                                    }
                                                                                                    if ([r20 caseInsensitiveCompare:@"install.bat"] == 0x0) {
                                                                                                            temp_0 = 0x4;
                                                                                                            break;
                                                                                                    }
                                                                                                    if ([r20 caseInsensitiveCompare:@"setuppls.exe"] == 0x0) {
                                                                                                            temp_0 = 0x5;
                                                                                                            break;
                                                                                                    }
                                                                                                    if ([r20 caseInsensitiveCompare:@"setupse.exe"] == 0x0) {
                                                                                                            temp_0 = 0x0;
                                                                                                            break;
                                                                                                    }
                                                                                                    r27 = r27 + 0x1;
                                                                                                    if (r24 != r27) {
                                                                                                            continue;
                                                                                                    }
                                                                                                    temp_0 = 0x6;
                                                                                                    break;
                                                                                            }
                                                                                            if (temp_0 == 0x0) {
                                                                                                    temp_1 = 0x0;
                                                                                                    break;
                                                                                            }
                                                                                            if (temp_0 == 0x1) {
                                                                                                    temp_1 = 0x1;
                                                                                                    break;
                                                                                            }
                                                                                            if (temp_0 == 0x2) {
                                                                                                    temp_1 = 0x1;
                                                                                                    break;
                                                                                            }
                                                                                            if (temp_0 == 0x3) {
                                                                                                    temp_1 = 0x2;
                                                                                                    break;
                                                                                            }
                                                                                            if (temp_0 == 0x4) {
                                                                                                    temp_1 = 0x3;
                                                                                                    break;
                                                                                            }
                                                                                            if (temp_0 == 0x5) {
                                                                                                    temp_1 = 0x4;
                                                                                                    break;
                                                                                            }
                                                                                            if (temp_0 == 0x6) {
                                                                                                    r0 = [r21 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                                                                    r24 = r0;
                                                                                                    r27 = var_158;
                                                                                                    if (r0 != 0x0) {
                                                                                                            continue;
                                                                                                    }
                                                                                                    temp_1 = 0x5;
                                                                                                    break;
                                                                                            }
                                                                                            temp_1 = 0x6;
                                                                                            break;
                                                                                    }
                                                                                    switch (temp_1) {
                                                                                        case 0:
                                                                                            r20 = 0x1;
                                                                                            r22 = r21;
                                                                                            break;
                                                                                        case 1:
                                                                                            r20 = 0x1;
                                                                                            r22 = r21;
                                                                                            break;
                                                                                        case 2:
                                                                                            r20 = 0x1;
                                                                                            r22 = r21;
                                                                                            break;
                                                                                        case 3:
                                                                                            r20 = 0x1;
                                                                                            r22 = r21;
                                                                                            break;
                                                                                        case 4:
                                                                                            r20 = 0x1;
                                                                                            r22 = r21;
                                                                                            break;
                                                                                        case 5:
                                                                                            [r21 release];
                                                                                            r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                                            r0 = [r0 retain];
                                                                                            r22 = r0;
                                                                                            if ([r0 count] != 0x0) {
                                                                                                    r20 = 0x1;
                                                                                            }
                                                                                            break;
                                                                                        default:
                                                                                            r20 = 0x1;
                                                                                            r22 = r21;
                                                                                            break;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    [r21 release];
                                                                                    r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                                    r0 = [r0 retain];
                                                                                    r22 = r0;
                                                                                    if ([r0 count] != 0x0) {
                                                                                            r20 = 0x1;
                                                                                    }
                                                                            }
                                                                            [r22 release];
                                                                            [r21 release];
                                                                            r0 = [r19 release];
                                                                            if (**___stack_chk_guard != var_60) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                            r0 = r20;
                                                                    }
                                                                    else {
                                                                            r23 = [r22 isEqualToString:@"udf"];
                                                                            [r20 release];
                                                                            if ((r23 & 0x1) == 0x0) {
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    r0 = [r19 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                                    r0 = 0x0;
                                                                            }
                                                                            else {
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    r0 = [NSFileManager defaultManager];
                                                                                    r0 = [r0 retain];
                                                                                    r20 = r0;
                                                                                    r21 = [[r0 contentsOfDirectoryAtPath:r19 error:0x0] retain];
                                                                                    [r20 release];
                                                                                    var_150 = q0;
                                                                                    var_140 = q0;
                                                                                    r0 = [r21 retain];
                                                                                    r21 = r0;
                                                                                    r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                                                    if (r0 != 0x0) {
                                                                                            r24 = r0;
                                                                                            r28 = *var_140;
                                                                                            var_158 = r27;
                                                                                            while (true) {
                                                                                                    r27 = 0x0;
                                                                                                    while (true) {
                                                                                                            if (*var_140 != r28) {
                                                                                                                    objc_enumerationMutation(r21);
                                                                                                            }
                                                                                                            r20 = *(var_148 + r27 * 0x8);
                                                                                                            if ([r20 caseInsensitiveCompare:@"autorun.inf"] == 0x0) {
                                                                                                                    temp_0 = 0x7;
                                                                                                                    break;
                                                                                                            }
                                                                                                            if ([r20 caseInsensitiveCompare:@"autorun.exe"] == 0x0) {
                                                                                                                    temp_0 = 0x1;
                                                                                                                    break;
                                                                                                            }
                                                                                                            if ([r20 caseInsensitiveCompare:@"setup.exe"] == 0x0) {
                                                                                                                    temp_0 = 0x1;
                                                                                                                    break;
                                                                                                            }
                                                                                                            if ([r20 caseInsensitiveCompare:@"setup.bat"] == 0x0) {
                                                                                                                    temp_0 = 0x2;
                                                                                                                    break;
                                                                                                            }
                                                                                                            if ([r20 caseInsensitiveCompare:@"install.exe"] == 0x0) {
                                                                                                                    temp_0 = 0x3;
                                                                                                                    break;
                                                                                                            }
                                                                                                            if ([r20 caseInsensitiveCompare:@"install.bat"] == 0x0) {
                                                                                                                    temp_0 = 0x4;
                                                                                                                    break;
                                                                                                            }
                                                                                                            if ([r20 caseInsensitiveCompare:@"setuppls.exe"] == 0x0) {
                                                                                                                    temp_0 = 0x5;
                                                                                                                    break;
                                                                                                            }
                                                                                                            if ([r20 caseInsensitiveCompare:@"setupse.exe"] == 0x0) {
                                                                                                                    temp_0 = 0x0;
                                                                                                                    break;
                                                                                                            }
                                                                                                            r27 = r27 + 0x1;
                                                                                                            if (r24 != r27) {
                                                                                                                    continue;
                                                                                                            }
                                                                                                            temp_0 = 0x6;
                                                                                                            break;
                                                                                                    }
                                                                                                    if (temp_0 == 0x0) {
                                                                                                            temp_1 = 0x0;
                                                                                                            break;
                                                                                                    }
                                                                                                    if (temp_0 == 0x1) {
                                                                                                            temp_1 = 0x1;
                                                                                                            break;
                                                                                                    }
                                                                                                    if (temp_0 == 0x2) {
                                                                                                            temp_1 = 0x1;
                                                                                                            break;
                                                                                                    }
                                                                                                    if (temp_0 == 0x3) {
                                                                                                            temp_1 = 0x2;
                                                                                                            break;
                                                                                                    }
                                                                                                    if (temp_0 == 0x4) {
                                                                                                            temp_1 = 0x3;
                                                                                                            break;
                                                                                                    }
                                                                                                    if (temp_0 == 0x5) {
                                                                                                            temp_1 = 0x4;
                                                                                                            break;
                                                                                                    }
                                                                                                    if (temp_0 == 0x6) {
                                                                                                            r0 = [r21 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                                                                            r24 = r0;
                                                                                                            r27 = var_158;
                                                                                                            if (r0 != 0x0) {
                                                                                                                    continue;
                                                                                                            }
                                                                                                            temp_1 = 0x5;
                                                                                                            break;
                                                                                                    }
                                                                                                    temp_1 = 0x6;
                                                                                                    break;
                                                                                            }
                                                                                            switch (temp_1) {
                                                                                                case 0:
                                                                                                    r20 = 0x1;
                                                                                                    r22 = r21;
                                                                                                    break;
                                                                                                case 1:
                                                                                                    r20 = 0x1;
                                                                                                    r22 = r21;
                                                                                                    break;
                                                                                                case 2:
                                                                                                    r20 = 0x1;
                                                                                                    r22 = r21;
                                                                                                    break;
                                                                                                case 3:
                                                                                                    r20 = 0x1;
                                                                                                    r22 = r21;
                                                                                                    break;
                                                                                                case 4:
                                                                                                    r20 = 0x1;
                                                                                                    r22 = r21;
                                                                                                    break;
                                                                                                case 5:
                                                                                                    [r21 release];
                                                                                                    r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                                                    r0 = [r0 retain];
                                                                                                    r22 = r0;
                                                                                                    if ([r0 count] != 0x0) {
                                                                                                            r20 = 0x1;
                                                                                                    }
                                                                                                    break;
                                                                                                default:
                                                                                                    r20 = 0x1;
                                                                                                    r22 = r21;
                                                                                                    break;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            [r21 release];
                                                                                            r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                                            r0 = [r0 retain];
                                                                                            r22 = r0;
                                                                                            if ([r0 count] != 0x0) {
                                                                                                    r20 = 0x1;
                                                                                            }
                                                                                    }
                                                                                    [r22 release];
                                                                                    [r21 release];
                                                                                    r0 = [r19 release];
                                                                                    if (**___stack_chk_guard != var_60) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                                    r0 = r20;
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    [r20 release];
                                                                    [r22 release];
                                                                    [r21 release];
                                                                    r0 = [r19 release];
                                                                    if (**___stack_chk_guard != var_60) {
                                                                            __stack_chk_fail();
                                                                    }
                                                                    r0 = 0x0;
                                                            }
                                                    }
                                                    else {
                                                            [r20 release];
                                                            [r22 release];
                                                            [r21 release];
                                                            r0 = [NSFileManager defaultManager];
                                                            r0 = [r0 retain];
                                                            r20 = r0;
                                                            r21 = [[r0 contentsOfDirectoryAtPath:r19 error:0x0] retain];
                                                            [r20 release];
                                                            var_150 = q0;
                                                            var_140 = q0;
                                                            r0 = [r21 retain];
                                                            r21 = r0;
                                                            r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                            if (r0 != 0x0) {
                                                                    r24 = r0;
                                                                    r28 = *var_140;
                                                                    var_158 = r27;
                                                                    while (true) {
                                                                            r27 = 0x0;
                                                                            while (true) {
                                                                                    if (*var_140 != r28) {
                                                                                            objc_enumerationMutation(r21);
                                                                                    }
                                                                                    r20 = *(var_148 + r27 * 0x8);
                                                                                    if ([r20 caseInsensitiveCompare:@"autorun.inf"] == 0x0) {
                                                                                            temp_0 = 0x7;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"autorun.exe"] == 0x0) {
                                                                                            temp_0 = 0x1;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"setup.exe"] == 0x0) {
                                                                                            temp_0 = 0x1;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"setup.bat"] == 0x0) {
                                                                                            temp_0 = 0x2;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"install.exe"] == 0x0) {
                                                                                            temp_0 = 0x3;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"install.bat"] == 0x0) {
                                                                                            temp_0 = 0x4;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"setuppls.exe"] == 0x0) {
                                                                                            temp_0 = 0x5;
                                                                                            break;
                                                                                    }
                                                                                    if ([r20 caseInsensitiveCompare:@"setupse.exe"] == 0x0) {
                                                                                            temp_0 = 0x0;
                                                                                            break;
                                                                                    }
                                                                                    r27 = r27 + 0x1;
                                                                                    if (r24 != r27) {
                                                                                            continue;
                                                                                    }
                                                                                    temp_0 = 0x6;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x0) {
                                                                                    temp_1 = 0x0;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x1) {
                                                                                    temp_1 = 0x1;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x2) {
                                                                                    temp_1 = 0x1;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x3) {
                                                                                    temp_1 = 0x2;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x4) {
                                                                                    temp_1 = 0x3;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x5) {
                                                                                    temp_1 = 0x4;
                                                                                    break;
                                                                            }
                                                                            if (temp_0 == 0x6) {
                                                                                    r0 = [r21 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                                                    r24 = r0;
                                                                                    r27 = var_158;
                                                                                    if (r0 != 0x0) {
                                                                                            continue;
                                                                                    }
                                                                                    temp_1 = 0x5;
                                                                                    break;
                                                                            }
                                                                            temp_1 = 0x6;
                                                                            break;
                                                                    }
                                                                    switch (temp_1) {
                                                                        case 0:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 1:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 2:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 3:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 4:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                        case 5:
                                                                            [r21 release];
                                                                            r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                            r0 = [r0 retain];
                                                                            r22 = r0;
                                                                            if ([r0 count] != 0x0) {
                                                                                    r20 = 0x1;
                                                                            }
                                                                            break;
                                                                        default:
                                                                            r20 = 0x1;
                                                                            r22 = r21;
                                                                            break;
                                                                    }
                                                            }
                                                            else {
                                                                    [r21 release];
                                                                    r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    if ([r0 count] != 0x0) {
                                                                            r20 = 0x1;
                                                                    }
                                                            }
                                                            [r22 release];
                                                            [r21 release];
                                                            r0 = [r19 release];
                                                            if (**___stack_chk_guard != var_60) {
                                                                    __stack_chk_fail();
                                                            }
                                                            r0 = r20;
                                                    }
                                            }
                                            else {
                                                    r0 = [NSFileManager defaultManager];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    r21 = [[r0 contentsOfDirectoryAtPath:r19 error:0x0] retain];
                                                    [r20 release];
                                                    var_150 = q0;
                                                    var_140 = q0;
                                                    r0 = [r21 retain];
                                                    r21 = r0;
                                                    r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                    if (r0 != 0x0) {
                                                            r24 = r0;
                                                            r28 = *var_140;
                                                            var_158 = r27;
                                                            while (true) {
                                                                    r27 = 0x0;
                                                                    while (true) {
                                                                            if (*var_140 != r28) {
                                                                                    objc_enumerationMutation(r21);
                                                                            }
                                                                            r20 = *(var_148 + r27 * 0x8);
                                                                            if ([r20 caseInsensitiveCompare:@"autorun.inf"] == 0x0) {
                                                                                    temp_0 = 0x7;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"autorun.exe"] == 0x0) {
                                                                                    temp_0 = 0x1;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"setup.exe"] == 0x0) {
                                                                                    temp_0 = 0x1;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"setup.bat"] == 0x0) {
                                                                                    temp_0 = 0x2;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"install.exe"] == 0x0) {
                                                                                    temp_0 = 0x3;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"install.bat"] == 0x0) {
                                                                                    temp_0 = 0x4;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"setuppls.exe"] == 0x0) {
                                                                                    temp_0 = 0x5;
                                                                                    break;
                                                                            }
                                                                            if ([r20 caseInsensitiveCompare:@"setupse.exe"] == 0x0) {
                                                                                    temp_0 = 0x0;
                                                                                    break;
                                                                            }
                                                                            r27 = r27 + 0x1;
                                                                            if (r24 != r27) {
                                                                                    continue;
                                                                            }
                                                                            temp_0 = 0x6;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x0) {
                                                                            temp_1 = 0x0;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x1) {
                                                                            temp_1 = 0x1;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x2) {
                                                                            temp_1 = 0x1;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x3) {
                                                                            temp_1 = 0x2;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x4) {
                                                                            temp_1 = 0x3;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x5) {
                                                                            temp_1 = 0x4;
                                                                            break;
                                                                    }
                                                                    if (temp_0 == 0x6) {
                                                                            r0 = [r21 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                                                                            r24 = r0;
                                                                            r27 = var_158;
                                                                            if (r0 != 0x0) {
                                                                                    continue;
                                                                            }
                                                                            temp_1 = 0x5;
                                                                            break;
                                                                    }
                                                                    temp_1 = 0x6;
                                                                    break;
                                                            }
                                                            switch (temp_1) {
                                                                case 0:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 1:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 2:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 3:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 4:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                                case 5:
                                                                    [r21 release];
                                                                    r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    if ([r0 count] != 0x0) {
                                                                            r20 = 0x1;
                                                                    }
                                                                    break;
                                                                default:
                                                                    r20 = 0x1;
                                                                    r22 = r21;
                                                                    break;
                                                            }
                                                    }
                                                    else {
                                                            [r21 release];
                                                            r0 = [r27 identifyInstallablePackagesForVolume:r19];
                                                            r0 = [r0 retain];
                                                            r22 = r0;
                                                            if ([r0 count] != 0x0) {
                                                                    r20 = 0x1;
                                                            }
                                                    }
                                                    [r22 release];
                                                    [r21 release];
                                                    r0 = [r19 release];
                                                    if (**___stack_chk_guard != var_60) {
                                                            __stack_chk_fail();
                                                    }
                                                    r0 = r20;
                                            }
                                    }
                                    else {
                                            r0 = [r19 release];
                                            if (**___stack_chk_guard != var_60) {
                                                    __stack_chk_fail();
                                            }
                                            r0 = 0x0;
                                    }
                            }
                            else {
                                    [r22 release];
                                    [r20 release];
                                    r0 = [r19 release];
                                    if (**___stack_chk_guard != var_60) {
                                            __stack_chk_fail();
                                    }
                                    r0 = 0x1;
                            }
                    }
                    else {
                            [r22 release];
                            [r20 release];
                            r0 = [r19 release];
                            if (**___stack_chk_guard != var_60) {
                                    __stack_chk_fail();
                            }
                            r0 = 0x1;
                    }
            }
            else {
                    [r22 release];
                    [r20 release];
                    r0 = [r19 release];
                    if (**___stack_chk_guard != var_60) {
                            __stack_chk_fail();
                    }
                    r0 = 0x1;
            }
    }
    return r0;


// 0x1000105f8
// +[CDTools isValidInstallerVolume:]
    r0 = [self isValidInstallerVolume:arg2 requireRemovable:0x0];
    return r0;


// 0x100010600
// +[CDTools removeCDHelper]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x1b0;
    var_60 = **___stack_chk_guard;
    r0 = LSSharedFileListCreate(0x0, **_kLSSharedFileListSessionLoginItems, 0x0);
    if (r0 != 0x0) {
            r19 = r0;
            r0 = LSSharedFileListCopySnapshot(r0, &decomp_var_164);
            r20 = r0;
            if (r0 != 0x0) {
                    var_1B0 = q0;
                    var_1A0 = q0;
                    var_1F8 = r20;
                    r0 = [r20 retain];
                    r21 = r0;
                    r0 = [r0 countByEnumeratingWithState:&var_1B0 objects:&decomp_var_e0 count:0x10];
                    if (r0 != 0x0) {
                            r23 = r0;
                            r20 = *var_1A0;
                            do {
                                    r22 = 0x0;
                                    while (true) {
                                            if (*var_1A0 != r20) {
                                                    objc_enumerationMutation(r21);
                                            }
                                            r25 = *(var_1A8 + r22 * 0x8);
                                            r0 = LSSharedFileListItemCopyResolvedURL(r25, 0x3, 0x0);
                                            if (r0 != 0x0) {
                                                    r26 = r0;
                                                    r0 = [r0 lastPathComponent];
                                                    r0 = [r0 retain];
                                                    r27 = r0;
                                                    r28 = [r0 caseInsensitiveCompare:@"CrossOver CD Helper.app"];
                                                    [r27 release];
                                                    if (r28 == 0x0) {
                                                            LSSharedFileListItemRemove(r19, r25);
                                                    }
                                                    CFRelease(r26);
                                                    r22 = r22 + 0x1;
                                                    if (r23 != r22) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                            else {
                                                    r0 = LSSharedFileListItemCopyDisplayName(r25);
                                                    if (r0 != 0x0) {
                                                            r26 = r0;
                                                            if (CFEqual(r0, @"CrossOver CD Helper") != 0x0) {
                                                                    LSSharedFileListItemRemove(r19, r25);
                                                            }
                                                            CFRelease(r26);
                                                            r22 = r22 + 0x1;
                                                            if (r23 != r22) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                                    else {
                                                            r22 = r22 + 0x1;
                                                            if (r23 != r22) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                    }
                                    r0 = [r21 countByEnumeratingWithState:&var_1B0 objects:&decomp_var_e0 count:0x10];
                                    r23 = r0;
                            } while (r0 != 0x0);
                    }
                    [r21 release];
                    r20 = var_1F8;
            }
            CFRelease(r19);
            [r20 release];
    }
    var_1F0 = q0;
    var_1E0 = q0;
    r0 = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.codeweavers.CrossOverCDHelper"];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_1F0 objects:&decomp_var_160 count:0x10];
    if (r0 != 0x0) {
            r20 = r0;
            r21 = *var_1E0;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_1E0 != r21) {
                                    objc_enumerationMutation(r19);
                            }
                            [*(var_1E8 + r22 * 0x8) terminate];
                            r22 = r22 + 0x1;
                    } while (r20 != r22);
                    r0 = [r19 countByEnumeratingWithState:&var_1F0 objects:&decomp_var_160 count:0x10];
                    r20 = r0;
            } while (r0 != 0x0);
    }
    [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x100010868
// +[CDTools getListOfAppsHelpedByTheCDHelper]
    r31 = r31 - 0x170;
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
    r0 = [NSArray arrayWithObjects:@"CrossOver"];
    r0 = [r0 retain];
    r21 = r0;
    var_128 = [[NSMutableArray arrayWithCapacity:[r0 count]] retain];
    r20 = [[NSMutableSet setWithCapacity:[r21 count]] retain];
    var_120 = q0;
    var_110 = q0;
    r0 = [r21 retain];
    r21 = r0;
    r3 = &decomp_var_e0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:r3 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r24 = *var_110;
            do {
                    r19 = 0x0;
                    do {
                            if (*var_110 != r24) {
                                    objc_enumerationMutation(r21);
                            }
                            r25 = *(var_118 + r19 * 0x8);
                            if (([r20 containsObject:r25] & 0x1) == 0x0) {
                                    r26 = [[NSString stringWithFormat:@"com.codeweavers.%@", r3] retain];
                                    r27 = [[NSString stringWithFormat:@"com.codeweavers.private-%@-app-scheme", r3] retain];
                                    r28 = [[NSDictionary dictionaryWithObjectsAndKeys:r26] retain];
                                    [var_128 addObject:r28];
                                    [r28 release];
                                    [r20 addObject:r25];
                                    [r27 release];
                                    [r26 release];
                            }
                            r19 = r19 + 0x1;
                    } while (r22 != r19);
                    r3 = &decomp_var_e0;
                    r0 = [r21 countByEnumeratingWithState:&var_120 objects:r3 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    [r20 release];
    r0 = [r21 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = [var_128 autorelease];
    return r0;


// 0x100010ab4
// +[CDTools removeCDHelperAndPrefsForAllInstalls]
    r31 = r31 - 0x130;
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
    [CDTools removeCDHelper];
    var_120 = q0;
    var_110 = q0;
    r0 = [CDTools getListOfAppsHelpedByTheCDHelper];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r23 = *var_110;
            do {
                    r24 = 0x0;
                    do {
                            if (*var_110 != r23) {
                                    objc_enumerationMutation(r19);
                            }
                            r27 = *(var_118 + r24 * 0x8);
                            r25 = [[NSUserDefaults alloc] init];
                            r28 = [[r27 objectForKey:@"BundleID"] retain];
                            r26 = [[r25 persistentDomainForName:r28] retain];
                            [r28 release];
                            if (r26 != 0x0) {
                                    r27 = [r27 objectForKey:@"BundleID"];
                                    CFPreferencesSetAppValue(@"AutoLaunch", 0x0, r27);
                                    CFPreferencesSetAppValue(@"AutoLaunchAppID", 0x0, r27);
                                    CFPreferencesSetAppValue(@"AutoLaunchAppIdentifyingURLScheme", 0x0, r27);
                                    CFPreferencesAppSynchronize(r27);
                            }
                            [r26 release];
                            [r25 release];
                            r24 = r24 + 0x1;
                    } while (r21 != r24);
                    r0 = [r19 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x100010c78
// +[CDTools identifyInstallablePackagesForVolume:]
    r20 = [arg2 retain];
    r19 = [[[CXSetupLib c4ProfilesClass] profilesSet] retain];
    r21 = [[[CXSetupLib cdDetectorClass] findMatchingProfilesForVolume:r20 inProfiles:r19] retain];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


