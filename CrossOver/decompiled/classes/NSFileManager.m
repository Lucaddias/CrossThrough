// NSFileManager — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100027e74
// -[NSFileManager createDirectoryAtPath:attributes:recursively:]
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
    r23 = arg4;
    r21 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r0 = objc_opt_class(r21);
    r0 = [r0 systemPaths];
    r0 = [r0 retain];
    r24 = r0;
    r22 = [r0 containsObject:r19];
    [r24 release];
    if (r22 != 0x0) {
            r0 = [r20 objectForKey:**_NSFilePosixPermissions];
            r0 = [r0 retain];
            r25 = r0;
            [r0 release];
            if (r25 != 0x0) {
                    if (r23 != 0x0) {
                            r0 = [r21 fileExistsAtPath:r19 isDirectory:&var_41];
                            if (r0 != 0x0) {
                                    if (var_41 != 0x0) {
                                            r23 = 0x1;
                                    }
                                    [r20 release];
                                    [r19 release];
                                    r0 = r23;
                            }
                            else {
                                    r23 = [[r19 stringByDeletingLastPathComponent] retain];
                                    r24 = [r21 createDirectoryAtPath:r23 attributes:r20 recursively:0x1];
                                    [r23 release];
                                    if ((r24 & 0x1) == 0x0) {
                                            [r20 release];
                                            [r19 release];
                                            r0 = 0x0;
                                    }
                                    else {
                                            r0 = [r21 createDirectoryAtPath:r19 withIntermediateDirectories:0x0 attributes:r20 error:0x0];
                                            r23 = r0;
                                            if ((r0 & r22) == 0x1) {
                                                    r22 = [[r19 stringByAppendingPathComponent:@".localized"] retain];
                                                    [r21 createFileAtPath:r22 contents:0x0 attributes:0x0];
                                                    [r22 release];
                                                    r23 = 0x1;
                                            }
                                            [r20 release];
                                            [r19 release];
                                            r0 = r23;
                                    }
                            }
                    }
                    else {
                            r0 = [r21 createDirectoryAtPath:r19 withIntermediateDirectories:0x0 attributes:r20 error:0x0];
                            r23 = r0;
                            if ((r0 & r22) == 0x1) {
                                    r22 = [[r19 stringByAppendingPathComponent:@".localized"] retain];
                                    [r21 createFileAtPath:r22 contents:0x0 attributes:0x0];
                                    [r22 release];
                                    r23 = 0x1;
                            }
                            [r20 release];
                            [r19 release];
                            r0 = r23;
                    }
            }
            else {
                    if (r20 != 0x0) {
                            r0 = [r20 mutableCopy];
                    }
                    else {
                            r0 = [NSMutableDictionary dictionary];
                            r0 = [r0 retain];
                    }
                    r24 = **_NSFilePosixPermissions;
                    r26 = [@(0x1c0) retain];
                    [r0 setObject:r26 forKey:r24];
                    [r26 release];
                    [r20 release];
                    r20 = r0;
                    if (r23 == 0x0) {
                            r0 = [r21 createDirectoryAtPath:r19 withIntermediateDirectories:0x0 attributes:r20 error:0x0];
                            r23 = r0;
                            if ((r0 & r22) == 0x1) {
                                    r22 = [[r19 stringByAppendingPathComponent:@".localized"] retain];
                                    [r21 createFileAtPath:r22 contents:0x0 attributes:0x0];
                                    [r22 release];
                                    r23 = 0x1;
                            }
                            [r20 release];
                            [r19 release];
                            r0 = r23;
                    }
                    else {
                            r0 = [r21 fileExistsAtPath:r19 isDirectory:&var_41];
                            if (r0 != 0x0) {
                                    if (var_41 != 0x0) {
                                            r23 = 0x1;
                                    }
                                    [r20 release];
                                    [r19 release];
                                    r0 = r23;
                            }
                            else {
                                    r23 = [[r19 stringByDeletingLastPathComponent] retain];
                                    r24 = [r21 createDirectoryAtPath:r23 attributes:r20 recursively:0x1];
                                    [r23 release];
                                    if ((r24 & 0x1) == 0x0) {
                                            [r20 release];
                                            [r19 release];
                                            r0 = 0x0;
                                    }
                                    else {
                                            r0 = [r21 createDirectoryAtPath:r19 withIntermediateDirectories:0x0 attributes:r20 error:0x0];
                                            r23 = r0;
                                            if ((r0 & r22) == 0x1) {
                                                    r22 = [[r19 stringByAppendingPathComponent:@".localized"] retain];
                                                    [r21 createFileAtPath:r22 contents:0x0 attributes:0x0];
                                                    [r22 release];
                                                    r23 = 0x1;
                                            }
                                            [r20 release];
                                            [r19 release];
                                            r0 = r23;
                                    }
                            }
                    }
            }
    }
    else {
            if (r23 != 0x0) {
                    r0 = [r21 fileExistsAtPath:r19 isDirectory:&var_41];
                    if (r0 != 0x0) {
                            if (var_41 != 0x0) {
                                    r23 = 0x1;
                            }
                            [r20 release];
                            [r19 release];
                            r0 = r23;
                    }
                    else {
                            r23 = [[r19 stringByDeletingLastPathComponent] retain];
                            r24 = [r21 createDirectoryAtPath:r23 attributes:r20 recursively:0x1];
                            [r23 release];
                            if ((r24 & 0x1) == 0x0) {
                                    [r20 release];
                                    [r19 release];
                                    r0 = 0x0;
                            }
                            else {
                                    r0 = [r21 createDirectoryAtPath:r19 withIntermediateDirectories:0x0 attributes:r20 error:0x0];
                                    r23 = r0;
                                    if ((r0 & r22) == 0x1) {
                                            r22 = [[r19 stringByAppendingPathComponent:@".localized"] retain];
                                            [r21 createFileAtPath:r22 contents:0x0 attributes:0x0];
                                            [r22 release];
                                            r23 = 0x1;
                                    }
                                    [r20 release];
                                    [r19 release];
                                    r0 = r23;
                            }
                    }
            }
            else {
                    r0 = [r21 createDirectoryAtPath:r19 withIntermediateDirectories:0x0 attributes:r20 error:0x0];
                    r23 = r0;
                    if ((r0 & r22) == 0x1) {
                            r22 = [[r19 stringByAppendingPathComponent:@".localized"] retain];
                            [r21 createFileAtPath:r22 contents:0x0 attributes:0x0];
                            [r22 release];
                            r23 = 0x1;
                    }
                    [r20 release];
                    [r19 release];
                    r0 = r23;
            }
    }
    return r0;


// 0x100028078
// +[NSFileManager systemPaths]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = objc_opt_class(@class(NSFileManager));
    r0 = [r0 retain];
    r19 = r0;
    objc_sync_enter(r0);
    if (*_systemPaths == 0x0) {
            r20 = [[NSMutableSet alloc] init];
            r23 = 0x0;
            do {
                    r21 = [NSSearchPathForDirectoriesInDomains(*(0x10009dc18 + r23), 0xffff, 0x1) retain];
                    [r20 addObjectsFromArray:r21];
                    r23 = r23 + 0x8;
                    [r21 release];
            } while (r23 != 0x80);
            r0 = [r20 copy];
            r8 = *_systemPaths;
            *_systemPaths = r0;
            [r8 release];
            [r20 release];
    }
    objc_sync_exit(r19);
    [r19 release];
    r0 = *_systemPaths;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100028170
// -[NSFileManager isSameFile:asFile:]
    r3 = arg3;
    r2 = arg2;
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = 0x0;
    if (r2 != 0x0 && r3 != 0x0) {
            r21 = [r3 retain];
            r0 = [NSURL fileURLWithPath:r2];
            r0 = [r0 retain];
            r20 = r0;
            r19 = [[r0 URLByResolvingSymlinksInPath] retain];
            [r20 release];
            r22 = [[NSURL fileURLWithPath:r21] retain];
            [r21 release];
            r20 = [[r22 URLByResolvingSymlinksInPath] retain];
            [r22 release];
            var_38 = 0x0;
            [r19 getResourceValue:&var_38 forKey:**_NSURLFileResourceIdentifierKey error:0x0];
            r21 = [var_38 retain];
            asm { ccmp       x0, #0x0, #0x4, ne };
            if (!asm { ccmp       x0, #0x0, #0x4, ne }) {
                    r22 = 0x0;
                    r23 = 0x0;
            }
            else {
                    var_40 = 0x0;
                    r0 = [r20 getResourceValue:&var_40 forKey:**_NSURLFileResourceIdentifierKey error:0x0];
                    r24 = r0;
                    r23 = [var_40 retain];
                    r22 = 0x0;
                    if (r24 != 0x0) {
                            if (r23 != 0x0) {
                                    r22 = [r21 isEqual:r23];
                            }
                    }
            }
            [r23 release];
            [r21 release];
            [r20 release];
            [r19 release];
    }
    r0 = r22;
    return r0;


// 0x1000282e4
// -[NSFileManager getDisplayStringForPath:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = [arg2 retain];
    r22 = [NSHomeDirectory() retain];
    r19 = [[self componentsToDisplayForPath:r22] retain];
    [r22 release];
    r20 = [[self componentsToDisplayForPath:r21] retain];
    [r21 release];
    r21 = [r19 count];
    r22 = [r20 count] - r21;
    if (r22 >= 0x0) {
            r3 = r21;
            r23 = [[r20 subarrayWithRange:0x0] retain];
            r24 = [r19 isEqualToArray:r23];
            [r23 release];
            if (r24 != 0x0) {
                    r24 = [NSUserName() retain];
                    r23 = [[NSArray arrayWithObject:r24] retain];
                    r3 = r22;
                    r21 = [[r20 subarrayWithRange:r21] retain];
                    r22 = [[r23 arrayByAddingObjectsFromArray:r21] retain];
                    [r20 release];
                    [r21 release];
                    [r23 release];
                    [r24 release];
                    r20 = r22;
            }
    }
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 localizedStringForKey:@"▹" value:@"" table:0x0] retain];
    r21 = [[NSString stringWithFormat:@" %@ ", r3] retain];
    [r23 release];
    [r22 release];
    r22 = [[r20 componentsJoinedByString:r21] retain];
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = [r22 autorelease];
    return r0;


// 0x1000284f8
// -[NSFileManager pathFromBookmarkData:stale:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg3;
    r21 = self;
    r0 = [arg2 retain];
    r19 = r0;
    if ([r0 length] != 0x0) {
            r23 = [NSHomeDirectory() retain];
            r24 = [[NSURL fileURLWithPath:r23] retain];
            r0 = [NSURL URLByResolvingBookmarkData:r19 options:0x300 relativeToURL:r24 bookmarkDataIsStale:&var_31 error:0x0];
            r22 = [r0 retain];
            [r24 release];
            [r23 release];
            r23 = [[r22 path] retain];
            r0 = [r21 isFileInTrash:r23];
            r21 = 0x0;
            if ((r0 & 0x1) == 0x0) {
                    if (r20 != 0x0 && r23 != 0x0) {
                            *(int8_t *)r20 = var_31;
                    }
                    r21 = [r23 retain];
            }
            [r23 release];
            [r22 release];
    }
    else {
            r21 = 0x0;
    }
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x100028614
// -[NSFileManager bookmarkDataFromPath:]
    r19 = [[NSURL fileURLWithPath:arg2] retain];
    r20 = **___NSArray0__;
    r22 = [NSHomeDirectory() retain];
    r21 = [[NSURL fileURLWithPath:r22] retain];
    r20 = [[r19 bookmarkDataWithOptions:0x0 includingResourceValuesForKeys:r20 relativeToURL:r21 error:0x0] retain];
    [r21 release];
    [r22 release];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x1000286c4
// -[NSFileManager makeWritableAtPath:recursively:]
    r1 = _cmd;
    r31 = r31 - 0x190;
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
    r23 = arg3;
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    var_E8 = 0x0;
    var_150 = self;
    r0 = [self attributesOfItemAtPath:r19 error:&var_E8];
    r21 = [r0 retain];
    r22 = [var_E8 retain];
    if (r21 == 0x0) goto loc_1000289f4;
    goto loc_10002873c;

loc_1000289f4:
    NSLog(@"%s: Could not obtain file attributes for %@: %@\n", r1, r2, r3);
    r20 = r22;
    [r21 release];
    [r20 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = 0x0;
    return r0;

loc_10002873c:
    r0 = [r21 filePosixPermissions];
    if ((r0 & 0x80) != 0x0) goto loc_1000287dc;
    goto loc_100028748;

loc_1000287dc:
    if (r23 == 0x0) goto loc_100028a64;
    goto .l4;

loc_100028748:
    r24 = [[NSNumber numberWithUnsignedInteger:r0 | 0x80] retain];
    r25 = [[NSDictionary dictionaryWithObject:r24 forKey:**_NSFilePosixPermissions] retain];
    var_F0 = r22;
    r2 = r25;
    r3 = r19;
    r0 = [var_150 setAttributes:r2 ofItemAtPath:r3 error:&var_F0];
    r26 = r0;
    r20 = [var_F0 retain];
    [r22 release];
    [r25 release];
    [r24 release];
    if ((r26 & 0x1) == 0x0) goto loc_100028a18;
    goto loc_1000287d8;

loc_100028a64:
    r20 = r22;
    r22 = 0x1;
    goto .l8;

.l4:
    r0 = [var_150 enumeratorAtPath:r19];
    r0 = [r0 retain];
    if (r0 == 0x0) goto .l2;
    goto .l3;

loc_100028a18:
    NSLog(@"%s: Could not change file attributes for %@: %@\n", r1, r2, r3);
    [r21 release];
    [r20 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = 0x0;
    return r0;

loc_1000287d8:
    r22 = r20;
    if (r23 == 0x0) goto .l9;
    goto loc_1000287e0;

.l8:
    [r21 release];
    [r20 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = r22;
    return r0;

.l2:
    NSLog(@"%s: Could not make directory enumerator for %@\n", r1, r2);
    r20 = r22;
    r22 = 0x0;
    goto .l8;

.l3:
    var_130 = q0;
    var_120 = q0;
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
    if (r0 == 0x0) goto .l5;
    goto .l6;

.l9:
    r20 = r22;
    r22 = 0x1;
    goto loc_100028a6c;

loc_1000287e0:
    r0 = [var_150 enumeratorAtPath:r19];
    r0 = [r0 retain];
    if (r0 == 0x0) goto loc_100028a3c;
    goto loc_1000287f8;

.l5:
    [r23 release];
    [r23 release];
    r20 = r22;
    r22 = 0x1;
    goto .l8;

.l6:
    r25 = r0;
    var_168 = r21;
    r24 = *var_120;
    var_160 = **_NSFilePosixPermissions;
    var_158 = r23;
    var_13C = 0x1;
    goto .l11;

loc_100028a6c:
    [r21 release];
    [r20 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = r22;
    return r0;

loc_100028a3c:
    NSLog(@"%s: Could not make directory enumerator for %@\n", r1, r2);
    r20 = r22;
    r22 = 0x0;
    goto loc_100028a6c;

loc_1000287f8:
    var_130 = q0;
    var_120 = q0;
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
    if (r0 == 0x0) goto loc_100028a54;
    goto loc_100028820;

.l11:
    r21 = 0x0;
    var_148 = r25;
    goto .l12;

loc_100028a54:
    [r23 release];
    [r23 release];
    r20 = r22;
    r22 = 0x1;
    goto loc_100028a6c;

loc_100028820:
    r25 = r0;
    var_168 = r21;
    r24 = *var_120;
    var_160 = **_NSFilePosixPermissions;
    var_158 = r23;
    var_13C = 0x1;
    goto loc_100028848;

.l12:
    if (*var_120 != r24) {
            objc_enumerationMutation(r23);
    }
    r28 = [*(var_128 + r21 * 0x8) retain];
    r27 = objc_autoreleasePoolPush();
    r0 = [r23 fileAttributes];
    r0 = [r0 retain];
    r20 = r0;
    r26 = [r0 filePosixPermissions];
    [r20 release];
    if ((r26 & 0x80) == 0x0) {
            r23 = r24;
            r24 = r19;
            r20 = [[r19 stringByAppendingPathComponent:r28] retain];
            [r28 release];
            r26 = [[NSNumber numberWithUnsignedInteger:r26 | 0x80] retain];
            r19 = [[NSDictionary dictionaryWithObject:r26 forKey:var_160] retain];
            var_138 = r22;
            r2 = r19;
            r3 = r20;
            r0 = [var_150 setAttributes:r2 ofItemAtPath:r3 error:&var_138];
            r25 = r0;
            r28 = [var_138 retain];
            [r22 release];
            [r19 release];
            [r26 release];
            if ((r25 & 0x1) == 0x0 && (var_13C & 0x1) != 0x0) {
                    NSLog(@"%s: Could not change file attributes for %@: %@\n", r1, r2, r3);
                    var_13C = 0x0;
            }
            r22 = r28;
            r19 = r24;
            r24 = r23;
            r23 = var_158;
            r25 = var_148;
    }
    else {
            r20 = r28;
    }
    objc_autoreleasePoolPop(r27);
    [r20 release];
    r21 = r21 + 0x1;
    if (r25 != r21) {
            continue;
    }
    break;

loc_100028848:
    r21 = 0x0;
    var_148 = r25;
    goto loc_100028850;
    r0 = [r23 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
    r25 = r0;
    if (r0 != 0x0) {
            continue;
    }
    break;

loc_100028850:
    if (*var_120 != r24) {
            objc_enumerationMutation(r23);
    }
    r28 = [*(var_128 + r21 * 0x8) retain];
    r27 = objc_autoreleasePoolPush();
    r0 = [r23 fileAttributes];
    r0 = [r0 retain];
    r20 = r0;
    r26 = [r0 filePosixPermissions];
    [r20 release];
    if ((r26 & 0x80) == 0x0) {
            r23 = r24;
            r24 = r19;
            r20 = [[r19 stringByAppendingPathComponent:r28] retain];
            [r28 release];
            r26 = [[NSNumber numberWithUnsignedInteger:r26 | 0x80] retain];
            r19 = [[NSDictionary dictionaryWithObject:r26 forKey:var_160] retain];
            var_138 = r22;
            r2 = r19;
            r3 = r20;
            r0 = [var_150 setAttributes:r2 ofItemAtPath:r3 error:&var_138];
            r25 = r0;
            r28 = [var_138 retain];
            [r22 release];
            [r19 release];
            [r26 release];
            if ((r25 & 0x1) == 0x0 && (var_13C & 0x1) != 0x0) {
                    NSLog(@"%s: Could not change file attributes for %@: %@\n", r1, r2, r3);
                    var_13C = 0x0;
            }
            r22 = r28;
            r19 = r24;
            r24 = r23;
            r23 = var_158;
            r25 = var_148;
    }
    else {
            r20 = r28;
    }
    objc_autoreleasePoolPop(r27);
    [r20 release];
    r21 = r21 + 0x1;
    if (r25 != r21) {
            continue;
    }
    break;
    [r23 release];
    [r23 release];
    r20 = r22;
    r22 = var_13C & 0x1;
    r21 = var_168;
    goto .l8;
    r0 = [r23 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
    r25 = r0;
    if (r0 != 0x0) {
            continue;
    }
    break;
    [r23 release];
    [r23 release];
    r20 = r22;
    r22 = var_13C & 0x1;
    r21 = var_168;
    goto loc_100028a6c;


// 0x100028ac4
// -[NSFileManager removeFolderIfEmpty:upTo:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = self;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    if ([r21 isFile:r19 inDirectory:r20] != 0x0) {
            if (([r21 isSameFile:r20 asFile:r19] & 0x1) == 0x0) {
                    r0 = [r21 contentsOfDirectoryAtPath:r19 error:0x0];
                    r0 = [r0 retain];
                    r22 = r0;
                    if (r0 != 0x0) {
                            if ([r22 count] != 0x0) {
                                    if ([r22 count] == 0x1) {
                                            r0 = [r22 objectAtIndex:0x0];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r24 = [r0 caseInsensitiveCompare:@".DS_Store"];
                                            [r23 release];
                                            if (r24 == 0x0) {
                                                    if ([r21 removeItemAtPath:r19 error:0x0] != 0x0) {
                                                            r23 = [[r19 stringByDeletingLastPathComponent] retain];
                                                            [r21 removeFolderIfEmpty:r23 upTo:r20];
                                                            [r23 release];
                                                    }
                                                    [r22 release];
                                                    [r20 release];
                                                    [r19 release];
                                            }
                                            else {
                                                    [r22 release];
                                                    [r20 release];
                                                    [r19 release];
                                            }
                                    }
                                    else {
                                            [r22 release];
                                            [r20 release];
                                            [r19 release];
                                    }
                            }
                            else {
                                    if ([r21 removeItemAtPath:r19 error:0x0] != 0x0) {
                                            r23 = [[r19 stringByDeletingLastPathComponent] retain];
                                            [r21 removeFolderIfEmpty:r23 upTo:r20];
                                            [r23 release];
                                    }
                                    [r22 release];
                                    [r20 release];
                                    [r19 release];
                            }
                    }
                    else {
                            [r22 release];
                            [r20 release];
                            [r19 release];
                    }
            }
            else {
                    [r20 release];
                    [r19 release];
            }
    }
    else {
            [r20 release];
            [r19 release];
    }
    return;


// 0x100028bf8
// -[NSFileManager isFileInTrash:]
    r20 = [arg2 retain];
    r21 = [[self trashForFile:r20] retain];
    r19 = [self isFile:r20 inDirectory:r21];
    [r20 release];
    [r21 release];
    r0 = r19;
    return r0;


// 0x100028c68
// -[NSFileManager trashForFile:]
    r2 = arg2;
    r0 = self;
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (r2 != 0x0) {
            r20 = r0;
            r0 = [NSURL fileURLWithPath:r2];
            r0 = [r0 retain];
            r19 = r0;
            if (r0 != 0x0) {
                    r0 = [r20 URLForDirectory:0x66 inDomain:0x1 appropriateForURL:r19 create:0x1 error:0x0];
                    r0 = [r0 retain];
                    r21 = r0;
                    if (r0 == 0x0) {
                            r21 = [[r20 URLForDirectory:0x66 inDomain:0x2 appropriateForURL:r19 create:0x1 error:0x0] retain];
                    }
                    r20 = [[r21 path] retain];
                    [r21 release];
            }
            else {
                    r20 = 0x0;
            }
            [r19 release];
    }
    else {
            r20 = 0x0;
    }
    r0 = [r20 autorelease];
    return r0;


// 0x100028d38
// -[NSFileManager isFile:inDirectory:]
    r31 = r31 - 0x90;
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
    r20 = arg3;
    var_58 = **___stack_chk_guard;
    r0 = [arg2 retain];
    r19 = r0;
    r23 = 0x0;
    if (r0 != 0x0 && r20 != 0x0) {
            r20 = [[NSURL fileURLWithPath:r20] retain];
            r8 = *_NSURLFileResourceIdentifierKey;
            r9 = *_NSURLIsSymbolicLinkKey;
            r23 = *r8;
            r24 = *r9;
            var_68 = r23;
            r0 = [NSArray arrayWithObjects:&var_68 count:0x2];
            r22 = [r0 retain];
            r21 = [[r20 resourceValuesForKeys:r22 error:0x0] retain];
            [r22 release];
            r0 = [r21 objectForKey:r23];
            r0 = [r0 retain];
            r22 = r0;
            if (r0 != 0x0) {
                    r0 = [r21 objectForKey:r24];
                    r0 = [r0 retain];
                    r25 = r0;
                    r0 = [r0 boolValue];
                    var_80 = r20;
                    if ((r0 & 0x1) != 0x0) {
                            r0 = [r20 URLByResolvingSymlinksInPath];
                            r0 = [r0 retain];
                            r26 = r0;
                            var_70 = 0x0;
                            r0 = [r0 getResourceValue:&var_70 forKey:r23 error:0x0];
                            r27 = r0;
                            r24 = [var_70 retain];
                            [r26 release];
                            [r25 release];
                            if ((r27 & 0x1) == 0x0) {
                                    [r24 release];
                                    r24 = 0x0;
                            }
                    }
                    else {
                            [r25 release];
                            [0x0 release];
                            r24 = 0x0;
                    }
                    r0 = [NSURL fileURLWithPath:r19];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r25 = r0;
                            while (true) {
                                    var_78 = 0x0;
                                    r0 = [r25 getResourceValue:&var_78 forKey:r23 error:0x0];
                                    r28 = r0;
                                    r27 = [var_78 retain];
                                    if (r28 == 0x0) {
                                            temp_0 = 0x1;
                                            break;
                                    }
                                    if (([r27 isEqual:r22] & 0x1) != 0x0) {
                                            temp_0 = 0x2;
                                            break;
                                    }
                                    if (([r27 isEqual:r24] & 0x1) != 0x0) {
                                            temp_0 = 0x2;
                                            break;
                                    }
                                    r0 = [r25 path];
                                    r0 = [r0 retain];
                                    r28 = r0;
                                    r20 = [r0 isEqualToString:@"/"];
                                    [r28 release];
                                    if (r20 != 0x0) {
                                            temp_0 = 0x1;
                                            break;
                                    }
                                    r20 = [[r25 URLByDeletingLastPathComponent] retain];
                                    [r25 release];
                                    [r27 release];
                                    r25 = r20;
                                    if (r20 != 0x0) {
                                            continue;
                                    }
                                    temp_0 = 0x0;
                                    break;
                            }
                            if (temp_0 != 0x0) {
                                    if (temp_0 != 0x1) {
                                            r23 = 0x1;
                                    }
                                    else {
                                            r23 = 0x0;
                                    }
                                    [r27 release];
                                    [r25 release];
                            }
                            else {
                                    r23 = 0x0;
                            }
                    }
                    else {
                            r23 = 0x0;
                    }
                    [r24 release];
                    r20 = var_80;
            }
            else {
                    r23 = 0x0;
            }
            [r22 release];
            [r21 release];
            [r20 release];
    }
    r0 = [r19 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    r0 = r23;
    return r0;


// 0x100029008
// -[NSFileManager clearQuarantine:]
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
    r19 = [arg2 retain];
    r20 = [[NSURL fileURLWithPath:r19] retain];
    r22 = [[NSNull null] retain];
    [r20 setResourceValue:r22 forKey:**_NSURLQuarantinePropertiesKey error:0x0];
    [r22 release];
    r0 = [NSFileManager defaultManager];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 enumeratorAtPath:r19] retain];
    [r22 release];
    var_120 = q0;
    var_110 = q0;
    r0 = [r23 retain];
    r22 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r27 = *var_110;
            do {
                    r28 = 0x0;
                    do {
                            if (*var_110 != r27) {
                                    objc_enumerationMutation(r22);
                            }
                            r21 = **_NSURLQuarantinePropertiesKey;
                            r24 = [[r20 URLByAppendingPathComponent:*(var_118 + r28 * 0x8)] retain];
                            r25 = [[NSNull null] retain];
                            [r24 setResourceValue:r25 forKey:r21 error:0x0];
                            [r25 release];
                            [r24 release];
                            r28 = r28 + 0x1;
                    } while (r23 != r28);
                    r0 = [r22 countByEnumeratingWithState:&var_120 objects:&decomp_var_e0 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [r22 release];
    [r22 release];
    [r20 release];
    [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


