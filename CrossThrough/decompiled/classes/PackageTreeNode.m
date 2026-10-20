// PackageTreeNode — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100041ca8
// -[PackageTreeNode initRootWithChildren:]
    r31 = r31 - 0x130;
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
    var_48 = **___stack_chk_guard;
    r19 = [arg2 retain];
    var_D8 = self;
    r0 = [[&var_D8 super] init];
    r20 = r0;
    if (r0 != 0x0) {
            r8 = sign_extend_64(*(int32_t *)ivar_offset(packageid));
            r0 = *(r20 + r8);
            *(r20 + r8) = @"root";
            [r0 release];
            r8 = sign_extend_64(*(int32_t *)ivar_offset(_softwarePackage));
            r0 = *(r20 + r8);
            *(r20 + r8) = @"root";
            [r0 release];
            if (r19 != 0x0) {
                    r0 = [r19 mutableCopy];
                    r23 = sign_extend_64(*(int32_t *)ivar_offset(children));
                    r8 = *(r20 + r23);
                    *(r20 + r23) = r0;
                    [r8 release];
                    var_120 = q0;
                    var_110 = q0;
                    r0 = *(r20 + r23);
                    r0 = [r0 retain];
                    r21 = r0;
                    r0 = [r0 countByEnumeratingWithState:&var_120 objects:&decomp_var_c8 count:0x10];
                    if (r0 != 0x0) {
                            r22 = r0;
                            r24 = *var_110;
                            do {
                                    r25 = 0x0;
                                    do {
                                            if (*var_110 != r24) {
                                                    objc_enumerationMutation(r21);
                                            }
                                            [*(var_118 + r25 * 0x8) setContainer:r20];
                                            r25 = r25 + 0x1;
                                    } while (r22 != r25);
                                    r0 = [r21 countByEnumeratingWithState:&var_120 objects:&decomp_var_c8 count:0x10];
                                    r22 = r0;
                            } while (r0 != 0x0);
                    }
            }
            else {
                    r0 = [NSMutableArray array];
                    r0 = [r0 retain];
                    r23 = sign_extend_64(*(int32_t *)ivar_offset(children));
                    r21 = *(r20 + r23);
                    *(r20 + r23) = r0;
            }
            [r21 release];
            r0 = *(r20 + r23);
            r0 = [r0 mutableCopy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(unfilteredChildren));
            r8 = *(r20 + r9);
            *(r20 + r9) = r0;
            [r8 release];
            [r20 startObservingChildren];
    }
    r0 = [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    r0 = r20;
    return r0;


// 0x100041e84
// -[PackageTreeNode initWithProfile:]
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
    r21 = arg2;
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    var_F0 = self;
    r0 = [[&var_F0 super] init];
    r20 = r0;
    if (r0 != 0x0) {
            r0 = [r19 valueForKey:@"appid"];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(packageid));
            r8 = *(r20 + r9);
            *(r20 + r9) = r0;
            [r8 release];
            [r22 release];
            objc_storeStrong((int64_t *)&r20->packageobject, r21);
            var_138 = r19;
            r0 = [r19 valueForKey:@"name"];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_softwarePackage));
            r8 = *(r20 + r9);
            var_140 = r9;
            *(r20 + r9) = r0;
            [r8 release];
            [r21 release];
            r23 = [[NSLocale preferredLanguages] retain];
            r21 = [[NSMutableSet setWithArray:r23] retain];
            [r23 release];
            [r21 addObject:@"en"];
            r22 = [[r20->packageobject valueForKey:@"localized_names"] retain];
            r23 = [[NSMutableArray alloc] init];
            var_130 = q0;
            var_120 = q0;
            r0 = [r22 retain];
            r22 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
            if (r0 != 0x0) {
                    r24 = r0;
                    r19 = *var_120;
                    do {
                            r27 = 0x0;
                            do {
                                    if (*var_120 != r19) {
                                            objc_enumerationMutation(r22);
                                    }
                                    r26 = *(var_128 + r27 * 0x8);
                                    r25 = [[NSLocale canonicalLanguageIdentifierFromString:r26] retain];
                                    if ([r21 containsObject:r25] != 0x0) {
                                            r26 = [[r22 objectForKey:r26] retain];
                                            [r23 addObject:r26];
                                            [r26 release];
                                    }
                                    [r25 release];
                                    r27 = r27 + 0x1;
                            } while (r24 != r27);
                            r0 = [r22 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                            r24 = r0;
                    } while (r0 != 0x0);
            }
            [r22 release];
            r8 = sign_extend_64(*(int32_t *)ivar_offset(_localizedNames));
            r24 = *(r20 + r8);
            *(r20 + r8) = r23;
            r23 = [r23 retain];
            [r24 release];
            r0 = *(r20 + var_140);
            r0 = [r0 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(sortkey));
            r8 = *(r20 + r9);
            *(r20 + r9) = r0;
            [r8 release];
            [r23 release];
            r23 = [[objc_opt_class(r20) defaultIcon] retain];
            [r20 setIcon:r23];
            [r23 release];
            [r22 release];
            [r21 release];
            r19 = var_138;
    }
    r0 = [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = r20;
    return r0;


// 0x1000421c8
// -[PackageTreeNode initWithCategoryID:name:children:sortKey:]
    r31 = r31 - 0x140;
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
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    r23 = [arg5 retain];
    var_F0 = self;
    r0 = [[&var_F0 super] init];
    r22 = r0;
    if (r0 != 0x0) {
            r0 = [r19 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(packageid));
            r8 = *(r22 + r9);
            *(r22 + r9) = r0;
            [r8 release];
            r0 = [r20 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_softwarePackage));
            r8 = *(r22 + r9);
            *(r22 + r9) = r0;
            [r8 release];
            if (r21 != 0x0) {
                    r0 = [r21 mutableCopy];
                    r26 = sign_extend_64(*(int32_t *)ivar_offset(children));
                    r8 = *(r22 + r26);
                    *(r22 + r26) = r0;
                    [r8 release];
                    var_130 = q0;
                    var_120 = q0;
                    r0 = *(r22 + r26);
                    r0 = [r0 retain];
                    r24 = r0;
                    r0 = [r0 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                    if (r0 != 0x0) {
                            r25 = r0;
                            r27 = *var_120;
                            do {
                                    r28 = 0x0;
                                    do {
                                            if (*var_120 != r27) {
                                                    objc_enumerationMutation(r24);
                                            }
                                            [*(var_128 + r28 * 0x8) setContainer:r22];
                                            r28 = r28 + 0x1;
                                    } while (r25 != r28);
                                    r0 = [r24 countByEnumeratingWithState:&var_130 objects:&decomp_var_e0 count:0x10];
                                    r25 = r0;
                            } while (r0 != 0x0);
                    }
            }
            else {
                    r0 = [NSMutableArray array];
                    r0 = [r0 retain];
                    r26 = sign_extend_64(*(int32_t *)ivar_offset(children));
                    r24 = *(r22 + r26);
                    *(r22 + r26) = r0;
            }
            [r24 release];
            r0 = *(r22 + r26);
            r0 = [r0 mutableCopy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(unfilteredChildren));
            r8 = *(r22 + r9);
            *(r22 + r9) = r0;
            [r8 release];
            r0 = [r23 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(sortkey));
            r8 = *(r22 + r9);
            *(r22 + r9) = r0;
            [r8 release];
            [r22 startObservingChildren];
    }
    [r23 release];
    [r21 release];
    [r20 release];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    r0 = r22;
    return r0;


// 0x100042424
// -[PackageTreeNode copyWithZone:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = arg2;
    r20 = self;
    r19 = [[objc_opt_class(self) allocWithZone:r21] init];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(packageid));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r8 = sign_extend_64(*(int32_t *)ivar_offset(packageobject));
    objc_storeStrong(r19 + r8, *(r20 + r8));
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_softwarePackage));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_localizedNames));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(description));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_descriptionFont));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(homePage));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(homePageDescription));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(medaldatemessage));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_ratingDescription));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r23 = sign_extend_64(*(int32_t *)ivar_offset(children));
    if (*(r20 + r23) != 0x0) {
            r0 = [NSMutableArray allocWithZone:r21];
            r0 = [r0 init];
            r8 = *(r19 + r23);
            *(r19 + r23) = r0;
            [r8 release];
    }
    r23 = sign_extend_64(*(int32_t *)ivar_offset(unfilteredChildren));
    if (*(r20 + r23) != 0x0) {
            r0 = [NSMutableArray allocWithZone:r21];
            r0 = [r0 init];
            r8 = *(r19 + r23);
            *(r19 + r23) = r0;
            [r8 release];
    }
    r22 = sign_extend_64(*(int32_t *)ivar_offset(sortkey));
    r0 = *(r20 + r22);
    r0 = [r0 copyWithZone:r21];
    r8 = *(r19 + r22);
    *(r19 + r22) = r0;
    [r8 release];
    r20 = [[r20 icon] retain];
    [r19 setIcon:r20];
    [r20 release];
    [r19 startObservingChildren];
    r0 = r19;
    return r0;


// 0x10004267c
// -[PackageTreeNode mutableCopyWithZone:]
    r0 = [self copyWithZone:arg2];
    return r0;


// 0x100042680
// -[PackageTreeNode dealloc]
    r31 = r31 - 0x120;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_38 = **___stack_chk_guard;
    [self stopObservingChildren];
    var_100 = q0;
    var_F0 = q0;
    r0 = r19->unfilteredChildren;
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r22 = *var_F0;
            do {
                    r23 = 0x0;
                    do {
                            if (*var_F0 != r22) {
                                    objc_enumerationMutation(r20);
                            }
                            [*(var_F8 + r23 * 0x8) setContainer:0x0];
                            r23 = r23 + 0x1;
                    } while (r21 != r23);
                    r0 = [r20 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    var_110 = r19;
    [[&var_110 super] dealloc];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x10004279c
// -[PackageTreeNode packageid]
    r0 = self->packageid;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000427ac
// -[PackageTreeNode packageobject]
    r0 = self->packageobject;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000427bc
// +[PackageTreeNode keyPathsForValuesAffectingCountString]
    r0 = [NSSet setWithObject:@"totalChildren"];
    return r0;


// 0x1000427d0
// -[PackageTreeNode countString]
    r0 = self;
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (*(r0 + sign_extend_64(*(int32_t *)ivar_offset(children))) != 0x0) {
            r0 = [r0 totalChildren];
            r19 = r0;
            if (r0 != 0x1) {
                    if (r19 == 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r2 = @"0 items";
                    }
                    else {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r2 = @"%u items";
                    }
            }
            else {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r2 = @"1 item";
            }
            r21 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
            [r20 release];
            r19 = [[NSString stringWithFormat:r21] retain];
            [r21 release];
    }
    else {
            r19 = 0x0;
    }
    r0 = [r19 autorelease];
    return r0;


// 0x1000428d4
// -[PackageTreeNode description]
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
    r24 = sign_extend_64(*(int32_t *)ivar_offset(description));
    r0 = *(self + r24);
    if (r0 == 0x0) {
            r0 = r19->packageobject;
            if (r0 != 0x0) {
                    r0 = [r0 valueForKey:@"app_profile"];
                    r0 = [r0 retain];
                    r20 = r0;
                    r22 = [[r0 valueForKey:@"description"] retain];
                    r23 = [[r19 descriptionFont] retain];
                    r0 = [NSAttributedString cx_attributedStringWithHTML:r22 font:r23];
                    r0 = [r0 retain];
                    r8 = *(r19 + r24);
                    *(r19 + r24) = r0;
                    [r8 release];
                    [r23 release];
                    [r22 release];
                    [r20 release];
                    r0 = *(r19 + r24);
            }
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000429b0
// -[PackageTreeNode descriptionFont]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(_descriptionFont));
    r0 = *(self + r21);
    if (r0 == 0x0) {
            [NSFont labelFontSize];
            r0 = [NSFont labelFontOfSize:r2];
            r0 = [r0 retain];
            r8 = *(r19 + r21);
            *(r19 + r21) = r0;
            [r8 release];
            r0 = *(r19 + r21);
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100042a18
// -[PackageTreeNode c4pPage]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(c4pPage));
    r0 = *(self + r21);
    if (r0 == 0x0) {
            r0 = r19->packageobject;
            if (r0 != 0x0) {
                    r0 = [r0 valueForKey:@"details_url"];
                    r0 = [r0 retain];
                    r20 = r0;
                    r0 = [r0 copy];
                    r8 = *(r19 + r21);
                    *(r19 + r21) = r0;
                    [r8 release];
                    [r20 release];
                    r0 = *(r19 + r21);
            }
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100042a94
// -[PackageTreeNode homePage]
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
    r23 = sign_extend_64(*(int32_t *)ivar_offset(homePage));
    r0 = *(self + r23);
    if (r0 == 0x0) {
            r0 = r19->packageobject;
            if (r0 != 0x0) {
                    r0 = [r0 valueForKeyPath:@"app_profile.download_page_urls"];
                    r0 = [r0 retain];
                    r20 = r0;
                    if (r0 != 0x0) {
                            r0 = [CXSetupLib cxUtilsClass];
                            r0 = [r0 getLanguageValue:r20 forLanguage:0x0];
                            r0 = [r0 retain];
                            r21 = r0;
                            r0 = [r0 objectAtIndex:0x1];
                            r0 = [r0 retain];
                            r22 = r0;
                            r0 = [r0 copy];
                            r8 = *(r19 + r23);
                            *(r19 + r23) = r0;
                            [r8 release];
                            [r22 release];
                            [r21 release];
                    }
                    [r20 release];
                    r0 = *(r19 + r23);
            }
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100042b64
// -[PackageTreeNode homePageDescription]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(homePageDescription));
    if (*(self + r21) == 0x0) {
            r22 = sign_extend_64(*(int32_t *)ivar_offset(homePage));
            if ([*(r19 + r22) length] != 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r0 = [r0 localizedStringForKey:@"This software can be downloaded from its <a href=\"%@\">home page</a>." value:@"" table:0x0];
                    r0 = [r0 retain];
                    r8 = *(r19 + r21);
                    *(r19 + r21) = r0;
                    [r8 release];
                    [r20 release];
                    r0 = [NSString alloc];
                    r0 = [r0 initWithFormat:*(r19 + r21)];
            }
            else {
                    r0 = @"";
            }
            r8 = *(r19 + r21);
            *(r19 + r21) = r0;
            [r8 release];
    }
    r0 = *(r19 + r21);
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100042c40
// -[PackageTreeNode medaldatemessage]
    r31 = r31 - 0xa0;
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
    r19 = self;
    r26 = sign_extend_64(*(int32_t *)ivar_offset(medaldatemessage));
    r0 = *(self + r26);
    if (r0 != 0x0) {
            r0 = [r0 retain];
            r0 = [r0 autorelease];
    }
    else {
            r21 = sign_extend_64(*(int32_t *)ivar_offset(packageobject));
            r0 = *(r19 + r21);
            if (r0 != 0x0) {
                    r0 = [r0 valueForKeyPath:@"app_profile.medal_version"];
                    r0 = [r0 retain];
                    r20 = r0;
                    if (r0 != 0x0) {
                            if ([r20 length] != 0x0) {
                                    r0 = *(r19 + r21);
                                    r0 = [r0 valueForKeyPath:@"app_profile.medal_date"];
                                    r0 = [r0 retain];
                                    if (r0 != 0x0) {
                                            r21 = r0;
                                            if ([r0 length] != 0x0) {
                                                    r22 = [[NSDateFormatter alloc] init];
                                                    r23 = [[NSCalendar alloc] initWithCalendarIdentifier:**_NSCalendarIdentifierGregorian];
                                                    [r22 setCalendar:r23];
                                                    [r23 release];
                                                    r23 = [[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"] retain];
                                                    [r22 setLocale:r23];
                                                    [r23 release];
                                                    [r22 setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss"];
                                                    r23 = [[NSTimeZone timeZoneWithAbbreviation:@"UTC"] retain];
                                                    [r22 setTimeZone:r23];
                                                    [r23 release];
                                                    r0 = [r21 length];
                                                    var_60 = 0x0;
                                                    var_58 = r0;
                                                    var_68 = 0x0;
                                                    r0 = [r22 getObjectValue:&var_68 forString:r21 range:&var_60 error:0x0];
                                                    r24 = r0;
                                                    r23 = [var_68 retain];
                                                    if (r24 != 0x0) {
                                                            if (var_58 < [r21 length]) {
                                                                    if (var_58 == [r21 length] - 0x1) {
                                                                            if ([r21 characterAtIndex:var_58] != 0x5a) {
                                                                                    [r22 setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"];
                                                                                    r0 = [r21 length];
                                                                                    var_78 = 0x0;
                                                                                    var_70 = r0;
                                                                                    var_80 = 0x0;
                                                                                    r0 = [r22 getObjectValue:&var_80 forString:r21 range:&var_78 error:0x0];
                                                                                    r25 = r0;
                                                                                    r24 = [var_80 retain];
                                                                                    [r23 release];
                                                                                    if (r25 != 0x0) {
                                                                                            if (var_70 < [r21 length]) {
                                                                                                    if ([r21 characterAtIndex:var_70] == 0x3a) {
                                                                                                            r25 = [[r21 stringByReplacingCharactersInRange:var_70 withString:0x1] retain];
                                                                                                            [r21 release];
                                                                                                            r23 = [[r22 dateFromString:r25] retain];
                                                                                                            r21 = r25;
                                                                                                    }
                                                                                                    else {
                                                                                                            r23 = 0x0;
                                                                                                    }
                                                                                                    [r24 release];
                                                                                                    r24 = r23;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            [r24 release];
                                                                                            r24 = 0x0;
                                                                                    }
                                                                                    r23 = r24;
                                                                            }
                                                                    }
                                                                    else {
                                                                            [r22 setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"];
                                                                            r0 = [r21 length];
                                                                            var_78 = 0x0;
                                                                            var_70 = r0;
                                                                            var_80 = 0x0;
                                                                            r0 = [r22 getObjectValue:&var_80 forString:r21 range:&var_78 error:0x0];
                                                                            r25 = r0;
                                                                            r24 = [var_80 retain];
                                                                            [r23 release];
                                                                            if (r25 != 0x0) {
                                                                                    if (var_70 < [r21 length]) {
                                                                                            if ([r21 characterAtIndex:var_70] == 0x3a) {
                                                                                                    r25 = [[r21 stringByReplacingCharactersInRange:var_70 withString:0x1] retain];
                                                                                                    [r21 release];
                                                                                                    r23 = [[r22 dateFromString:r25] retain];
                                                                                                    r21 = r25;
                                                                                                    [r24 release];
                                                                                                    r24 = r23;
                                                                                                    r23 = r24;
                                                                                            }
                                                                                            else {
                                                                                                    [r24 release];
                                                                                                    r23 = 0x0;
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r23 = r24;
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    [r24 release];
                                                                                    r23 = 0x0;
                                                                            }
                                                                    }
                                                            }
                                                            if (r23 != 0x0) {
                                                                    r24 = [[NSDateFormatter alloc] init];
                                                                    [r22 release];
                                                                    [r24 setTimeStyle:0x0];
                                                                    [r24 setDateStyle:0x2];
                                                                    r22 = [[r24 stringFromDate:r23] retain];
                                                                    [r21 release];
                                                                    [r24 release];
                                                                    [r23 release];
                                                                    r21 = r22;
                                                                    if (r22 != 0x0) {
                                                                            r0 = [NSBundle mainBundle];
                                                                            r0 = [r0 retain];
                                                                            r22 = r0;
                                                                            r0 = [r0 localizedStringForKey:@"Last tested with CrossOver %1$@ on %2$@." value:@"" table:0x0];
                                                                            r0 = [r0 retain];
                                                                            r8 = *(r19 + r26);
                                                                            *(r19 + r26) = r0;
                                                                            [r8 release];
                                                                            [r22 release];
                                                                            r0 = [NSString stringWithFormat:*(r19 + r26)];
                                                                            r0 = [r0 retain];
                                                                            r8 = *(r19 + r26);
                                                                            *(r19 + r26) = r0;
                                                                            [r8 release];
                                                                            [r21 release];
                                                                            [r20 release];
                                                                            r0 = *(r19 + r26);
                                                                            r0 = [r0 retain];
                                                                            r0 = [r0 autorelease];
                                                                    }
                                                                    else {
                                                                            r0 = [NSBundle mainBundle];
                                                                            r0 = [r0 retain];
                                                                            r21 = r0;
                                                                            r0 = [r0 localizedStringForKey:@"Last tested with CrossOver %1$@." value:@"" table:0x0];
                                                                            r0 = [r0 retain];
                                                                            r8 = *(r19 + r26);
                                                                            *(r19 + r26) = r0;
                                                                            [r8 release];
                                                                            [r21 release];
                                                                            r0 = [NSString stringWithFormat:*(r19 + r26)];
                                                                            r0 = [r0 retain];
                                                                            r21 = *(r19 + r26);
                                                                            *(r19 + r26) = r0;
                                                                            [r21 release];
                                                                            [r20 release];
                                                                            r0 = *(r19 + r26);
                                                                            r0 = [r0 retain];
                                                                            r0 = [r0 autorelease];
                                                                    }
                                                            }
                                                            else {
                                                                    [r21 release];
                                                                    [r22 release];
                                                                    r0 = [NSBundle mainBundle];
                                                                    r0 = [r0 retain];
                                                                    r21 = r0;
                                                                    r0 = [r0 localizedStringForKey:@"Last tested with CrossOver %1$@." value:@"" table:0x0];
                                                                    r0 = [r0 retain];
                                                                    r8 = *(r19 + r26);
                                                                    *(r19 + r26) = r0;
                                                                    [r8 release];
                                                                    [r21 release];
                                                                    r0 = [NSString stringWithFormat:*(r19 + r26)];
                                                                    r0 = [r0 retain];
                                                                    r21 = *(r19 + r26);
                                                                    *(r19 + r26) = r0;
                                                                    [r21 release];
                                                                    [r20 release];
                                                                    r0 = *(r19 + r26);
                                                                    r0 = [r0 retain];
                                                                    r0 = [r0 autorelease];
                                                            }
                                                    }
                                                    else {
                                                            [r23 release];
                                                            [r21 release];
                                                            [r22 release];
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r21 = r0;
                                                            r0 = [r0 localizedStringForKey:@"Last tested with CrossOver %1$@." value:@"" table:0x0];
                                                            r0 = [r0 retain];
                                                            r8 = *(r19 + r26);
                                                            *(r19 + r26) = r0;
                                                            [r8 release];
                                                            [r21 release];
                                                            r0 = [NSString stringWithFormat:*(r19 + r26)];
                                                            r0 = [r0 retain];
                                                            r21 = *(r19 + r26);
                                                            *(r19 + r26) = r0;
                                                            [r21 release];
                                                            [r20 release];
                                                            r0 = *(r19 + r26);
                                                            r0 = [r0 retain];
                                                            r0 = [r0 autorelease];
                                                    }
                                            }
                                            else {
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r22 = r0;
                                                    r0 = [r0 localizedStringForKey:@"Last tested with CrossOver %1$@ on %2$@." value:@"" table:0x0];
                                                    r0 = [r0 retain];
                                                    r8 = *(r19 + r26);
                                                    *(r19 + r26) = r0;
                                                    [r8 release];
                                                    [r22 release];
                                                    r0 = [NSString stringWithFormat:*(r19 + r26)];
                                                    r0 = [r0 retain];
                                                    r8 = *(r19 + r26);
                                                    *(r19 + r26) = r0;
                                                    [r8 release];
                                                    [r21 release];
                                                    [r20 release];
                                                    r0 = *(r19 + r26);
                                                    r0 = [r0 retain];
                                                    r0 = [r0 autorelease];
                                            }
                                    }
                                    else {
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r0 = [r0 localizedStringForKey:@"Last tested with CrossOver %1$@." value:@"" table:0x0];
                                            r0 = [r0 retain];
                                            r8 = *(r19 + r26);
                                            *(r19 + r26) = r0;
                                            [r8 release];
                                            [r21 release];
                                            r0 = [NSString stringWithFormat:*(r19 + r26)];
                                            r0 = [r0 retain];
                                            r21 = *(r19 + r26);
                                            *(r19 + r26) = r0;
                                            [r21 release];
                                            [r20 release];
                                            r0 = *(r19 + r26);
                                            r0 = [r0 retain];
                                            r0 = [r0 autorelease];
                                    }
                            }
                            else {
                                    [r20 release];
                                    r0 = [0x0 autorelease];
                            }
                    }
                    else {
                            [r20 release];
                            r0 = [0x0 autorelease];
                    }
            }
            else {
                    r0 = [r0 retain];
                    r0 = [r0 autorelease];
            }
    }
    return r0;


// 0x1000430ac
// +[PackageTreeNode ratingImageWithName:]
    r0 = [NSImage imageNamed:arg2];
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 copy];
    [r19 release];
    [r20 size];
    [r20 size];
    [r20 setSize:r2];
    r0 = [r20 autorelease];
    return r0;


// 0x100043124
// +[PackageTreeNode untrustedRatingImage]
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (*_untrustedRatingImage.untrustedRatingImage == 0x0) {
            r0 = [r0 ratingImageWithName:@"sf-symbols.exclamationmark.circle.fill"];
            r0 = [r0 retain];
            r8 = *_untrustedRatingImage.untrustedRatingImage;
            *_untrustedRatingImage.untrustedRatingImage = r0;
            [r8 release];
    }
    r0 = objc_retainAutoreleaseReturnValue(*_untrustedRatingImage.untrustedRatingImage);
    return r0;


// 0x100043174
// +[PackageTreeNode starRatingImage]
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (*_starRatingImage.starRatingImage == 0x0) {
            r0 = [r0 ratingImageWithName:@"sf-symbols.star.fill-yellow"];
            r0 = [r0 retain];
            r8 = *_starRatingImage.starRatingImage;
            *_starRatingImage.starRatingImage = r0;
            [r8 release];
    }
    r0 = objc_retainAutoreleaseReturnValue(*_starRatingImage.starRatingImage);
    return r0;


// 0x1000431c4
// +[PackageTreeNode starOutlineRatingImage]
    r0 = self;
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (*_starOutlineRatingImage.starOutlineRatingImage == 0x0) {
            r0 = [r0 ratingImageWithName:@"sf-symbols.star"];
            r0 = [r0 retain];
            r8 = *_starOutlineRatingImage.starOutlineRatingImage;
            *_starOutlineRatingImage.starOutlineRatingImage = r0;
            [r8 release];
    }
    r0 = objc_retainAutoreleaseReturnValue(*_starOutlineRatingImage.starOutlineRatingImage);
    return r0;


// 0x100043214
// -[PackageTreeNode ratingImageForIndex:]
    r0 = self;
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg2;
    r23 = (int64_t *)&r0->_ratingImages;
    if (*r23 == 0x0) {
            r20 = r0;
            r0 = r0->packageobject;
            if (r0 != 0x0) {
                    r0 = [r0 valueForKeyPath:@"app_profile.medal_rating"];
                    r0 = [r0 retain];
                    r22 = r0;
                    r21 = [r0 integerValue];
                    [r22 release];
                    r22 = 0x0;
                    do {
                            if ((r21 & 0xffffffff80000000) == 0x0) {
                                    r0 = objc_opt_class(r20);
                                    if (r22 < r21) {
                                            r0 = [r0 starRatingImage];
                                            r0 = [r0 retain];
                                    }
                                    else {
                                            r0 = [r0 starOutlineRatingImage];
                                            r0 = [r0 retain];
                                    }
                                    r8 = r0;
                                    r0 = *(r23 + r22 * 0x8);
                                    *(r23 + r22 * 0x8) = r8;
                            }
                            else {
                                    if (r22 != 0x0) {
                                            r0 = *(r23 + r22 * 0x8);
                                            *(r23 + r22 * 0x8) = 0x0;
                                    }
                                    else {
                                            r8 = [[objc_opt_class(r20) untrustedRatingImage] retain];
                                            r0 = *r23;
                                            *r23 = r8;
                                    }
                            }
                            [r0 release];
                            r22 = r22 + 0x1;
                    } while (r22 != 0x5);
            }
    }
    r0 = *(r23 + r19 * 0x8);
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10004331c
// -[PackageTreeNode ratingImage1]
    r0 = [self ratingImageForIndex:0x0];
    return r0;


// 0x100043324
// -[PackageTreeNode ratingImage2]
    r0 = [self ratingImageForIndex:0x1];
    return r0;


// 0x10004332c
// -[PackageTreeNode ratingImage3]
    r0 = [self ratingImageForIndex:0x2];
    return r0;


// 0x100043334
// -[PackageTreeNode ratingImage4]
    r0 = [self ratingImageForIndex:0x3];
    return r0;


// 0x10004333c
// -[PackageTreeNode ratingImage5]
    r0 = [self ratingImageForIndex:0x4];
    return r0;


// 0x100043344
// +[PackageTreeNode tooltipForRating:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r8 = *_tooltipForRating:.tooltips;
    if (*_tooltipForRating:.tooltips == 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 localizedStringForKey:@"This installation recipe is from an unknown source. Installing may pose a security risk to your system." value:@"" table:0x0];
            r0 = [r0 retain];
            r8 = *_tooltipForRating:.tooltips;
            *_tooltipForRating:.tooltips = r0;
            [r8 release];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 localizedStringForKey:@"No ratings have been reported.\n\nAll application entries start at this rating. Over time staff and users can visit the App Compatibility page of the CodeWeavers website and rate how far they got in running this Windows application in CrossOver. If you try t…" value:@"" table:0x0];
            r0 = [r0 retain];
            r8 = *0x1000c83e8;
            *0x1000c83e8 = r0;
            [r8 release];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 localizedStringForKey:@"This application won't get through installation.\n\nMost installers are standardized and CrossOver will be able to run them without a problem. However some companies customize the installer, or write their own, and the custom programming fails in CrossOver. …" value:@"" table:0x0];
            r0 = [r0 retain];
            r8 = *0x1000c83f0;
            *0x1000c83f0 = r0;
            [r8 release];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 localizedStringForKey:@"This application installs, but fails to run.\n\nThe Windows application immediately closes or freezes when you try to run it. You may be able to add various dependencies or try different workarounds to get this application to start, so please check the Suppo…" value:@"" table:0x0];
            r0 = [r0 retain];
            r8 = *0x1000c83f8;
            *0x1000c83f8 = r0;
            [r8 release];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 localizedStringForKey:@"This application installs and runs, but has problems.\n\nThis application runs, but there are significant functional gaps. CrossOver translates Windows commands to their corresponding Mac commands and back. When a Windows program uses commands that CrossOver…" value:@"" table:0x0];
            r0 = [r0 retain];
            r8 = *0x1000c8400;
            *0x1000c8400 = r0;
            [r8 release];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 localizedStringForKey:@"This application installs and runs quite well, with only minor glitches found.\n\nThe core functionality of this Windows application works fine under CrossOver. There still may be some extra functions that don't work right, but overall this application shoul…" value:@"" table:0x0];
            r0 = [r0 retain];
            r8 = *0x1000c8408;
            *0x1000c8408 = r0;
            [r8 release];
            [r21 release];
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 localizedStringForKey:@"This application installs and runs great, the same as it would in Windows.\n\nPractically all of the application is functional. Using this application in CrossOver should be the same as running the application on native Windows OS." value:@"" table:0x0];
            r0 = [r0 retain];
            r8 = *0x1000c8410;
            *0x1000c8410 = r0;
            [r8 release];
            [r21 release];
    }
    r22 = _tooltipForRating:.tooltips;
    asm { csinv      x8, x19, xzr, ge };
    r0 = *(r22 + r8 * 0x8 + 0x8);
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100043598
// -[PackageTreeNode ratingTooltip]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_ratingTooltip));
    r0 = *(self + r22);
    if (r0 == 0x0) {
            r0 = r19->packageobject;
            if (r0 != 0x0) {
                    r0 = [r0 valueForKeyPath:@"app_profile.medal_rating"];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [r0 integerValue];
                    [r20 release];
                    r0 = objc_opt_class(r19);
                    r0 = [r0 tooltipForRating:r21];
                    r0 = [r0 retain];
                    r8 = *(r19 + r22);
                    *(r19 + r22) = r0;
                    [r8 release];
                    r0 = *(r19 + r22);
            }
    }
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100043630
// -[PackageTreeNode ratingDescription]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_ratingDescription));
    if (*(self + r22) == 0x0) {
            r0 = r19->packageobject;
            if (r0 != 0x0) {
                    r0 = [r0 valueForKeyPath:@"app_profile.medal_rating"];
                    r0 = [r0 retain];
                    r21 = r0;
                    r20 = [r0 integerValue];
                    [r21 release];
                    if (r20 <= 0x5) {
                            index_0 = r20;
                            switch (index_0) {
                                case 0:
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r2 = @"Untested";
                                    break;
                                case 1:
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r2 = @"Will Not Install";
                                    break;
                                case 2:
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r2 = @"Installs, Will Not Run";
                                    break;
                                case 3:
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r2 = @"Limited Functionality";
                                    break;
                                case 4:
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r2 = @"Runs Well";
                                    break;
                                default:
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r2 = @"Runs Great";
                                    break;
                            }
                    }
                    else {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r2 = @"Untrusted";
                    }
                    r0 = [r0 localizedStringForKey:r2 value:@"" table:0x0];
                    r0 = [r0 retain];
                    r8 = *(r19 + r22);
                    *(r19 + r22) = r0;
                    [r8 release];
                    [r20 release];
            }
    }
    r0 = *(r19 + r22);
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000437e8
// -[PackageTreeNode children]
    r0 = self->children;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000437f8
// -[PackageTreeNode insertChildren:atIndexes:]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = _cmd;
    r20 = self;
    r19 = [arg2 retain];
    r21 = [arg3 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r23 = r0;
            [r0 handleFailureInMethod:r22 object:r20 file:@"PackageTreeNode.m" lineNumber:0x1ee description:@"Main thread method or function called on non-main thread"];
            [r23 release];
    }
    r22 = sign_extend_64(*(int32_t *)ivar_offset(children));
    [*(r20 + r22) insertObjects:r19 atIndexes:r21];
    [*(r20 + r22) addObserver:r20 toObjectsAtIndexes:r21 forKeyPath:@"totalChildren" options:0x8 context:_PackageTreeNodeKVOContextDummy];
    [r21 release];
    [r19 release];
    return;


// 0x1000438e4
// -[PackageTreeNode removeChildrenAtIndexes:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r21 = _cmd;
    r19 = self;
    r20 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r19 file:@"PackageTreeNode.m" lineNumber:0x1fa description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    r21 = sign_extend_64(*(int32_t *)ivar_offset(children));
    [*(r19 + r21) removeObserver:r19 fromObjectsAtIndexes:r20 forKeyPath:@"totalChildren" context:_PackageTreeNodeKVOContextDummy];
    [*(r19 + r21) removeObjectsAtIndexes:r20];
    [r20 release];
    return;


// 0x1000439a8
// -[PackageTreeNode unfilteredChildren]
    r0 = self->unfilteredChildren;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000439b8
// -[PackageTreeNode insertObject:inUnfilteredChildrenAtIndex:]
    r21 = self->unfilteredChildren;
    r22 = [arg2 retain];
    [r21 insertObject:r22 atIndex:arg3];
    [r22 setContainer:self];
    [r22 release];
    return;


// 0x100043a18
// -[PackageTreeNode insertUnfilteredChildren:atIndexes:]
    r31 = r31 - 0x110;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    var_38 = **___stack_chk_guard;
    r21 = [arg2 retain];
    [r19->unfilteredChildren insertObjects:r21 atIndexes:arg3];
    var_100 = q0;
    var_F0 = q0;
    r0 = [r21 retain];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r22 = *var_F0;
            do {
                    r23 = 0x0;
                    do {
                            if (*var_F0 != r22) {
                                    objc_enumerationMutation(r20);
                            }
                            [*(var_F8 + r23 * 0x8) setContainer:r19];
                            r23 = r23 + 0x1;
                    } while (r21 != r23);
                    r0 = [r20 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    [r20 release];
    [r20 release];
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    return;


// 0x100043b3c
// -[PackageTreeNode removeObjectFromUnfilteredChildrenAtIndex:]
    r22 = sign_extend_64(*(int32_t *)ivar_offset(unfilteredChildren));
    r0 = *(self + r22);
    r0 = [r0 objectAtIndex:arg2];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setContainer:0x0];
    [r21 release];
    [*(self + r22) removeObjectAtIndex:arg2];
    return;


// 0x100043b98
// -[PackageTreeNode removeUnfilteredChildrenAtIndexes:]
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
    r20 = self;
    var_48 = **___stack_chk_guard;
    r19 = [arg2 retain];
    var_110 = q0;
    var_100 = q0;
    r23 = sign_extend_64(*(int32_t *)ivar_offset(unfilteredChildren));
    r0 = *(r20 + r23);
    r0 = [r0 objectsAtIndexes:r19];
    r0 = [r0 retain];
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
                            [*(var_108 + r25 * 0x8) setContainer:0x0];
                            r25 = r25 + 0x1;
                    } while (r22 != r25);
                    r0 = [r21 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    [*(r20 + r23) removeObjectsAtIndexes:r19];
    [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100043cc8
// -[PackageTreeNode removeAllLeaves]
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
    r20 = [[NSMutableIndexSet indexSet] retain];
    r23 = sign_extend_64(*(int32_t *)ivar_offset(unfilteredChildren));
    if ([*(r19 + r23) count] != 0x0) {
            r21 = 0x0;
            do {
                    r0 = *(r19 + r23);
                    r0 = [r0 objectAtIndex:r21];
                    r0 = [r0 retain];
                    r22 = r0;
                    if ([r0 leaf] != 0x0) {
                            [r20 addIndex:r21];
                    }
                    [r22 release];
                    r21 = r21 + 0x1;
            } while (r21 < [*(r19 + r23) count]);
    }
    [r19 removeUnfilteredChildrenAtIndexes:r20];
    [r20 release];
    return;


// 0x100043d7c
// -[PackageTreeNode replaceAllLeavesWithNewChildren:]
    r20 = [arg2 retain];
    [self removeAllLeaves];
    r22 = [self->unfilteredChildren count];
    [r20 count];
    r21 = [[NSIndexSet indexSetWithIndexesInRange:r22] retain];
    [self insertUnfilteredChildren:r20 atIndexes:r21];
    [r20 release];
    [r21 release];
    return;


// 0x100043e10
// -[PackageTreeNode startObservingChildren]
    r20 = self->children;
    [r20 count];
    r21 = [[NSIndexSet indexSetWithIndexesInRange:0x0] retain];
    [r20 addObserver:self toObjectsAtIndexes:r21 forKeyPath:@"totalChildren" options:0x8 context:_PackageTreeNodeKVOContextDummy];
    [r21 release];
    return;


// 0x100043e94
// -[PackageTreeNode stopObservingChildren]
    r20 = self->children;
    [r20 count];
    r21 = [[NSIndexSet indexSetWithIndexesInRange:0x0] retain];
    [r20 removeObserver:self fromObjectsAtIndexes:r21 forKeyPath:@"totalChildren" context:_PackageTreeNodeKVOContextDummy];
    [r21 release];
    return;


// 0x100043f14
// -[PackageTreeNode leaf]
    r0 = self;
    if (*(r0 + sign_extend_64(*(int32_t *)ivar_offset(children))) == 0x0) {
            r0 = 0x1;
    }
    return r0;


// 0x100043f2c
// -[PackageTreeNode sortkey]
    r0 = self->sortkey;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100043f3c
// +[PackageTreeNode keyPathsForValuesAffectingTotalChildren]
    r0 = [NSSet setWithObject:@"children"];
    return r0;


// 0x100043f50
// -[PackageTreeNode totalChildren]
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
    var_48 = **___stack_chk_guard;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(children));
    r19 = [*(self + r21) count];
    var_110 = q0;
    var_100 = q0;
    r0 = *(self + r21);
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
    if (r0 != 0x0) {
            r21 = r0;
            r24 = *var_100;
            do {
                    r25 = 0x0;
                    do {
                            if (*var_100 != r24) {
                                    objc_enumerationMutation(r20);
                            }
                            r22 = *(var_108 + r25 * 0x8);
                            r0 = [r22 children];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r0 release];
                            if (r23 != 0x0) {
                                    r19 = r19 + [r22 totalChildren] - 0x1;
                            }
                            r25 = r25 + 0x1;
                    } while (r21 != r25);
                    r0 = [r20 countByEnumeratingWithState:&var_110 objects:&decomp_var_c8 count:0x10];
                    r21 = r0;
            } while (r0 != 0x0);
    }
    r0 = [r20 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    r0 = r19;
    return r0;


// 0x100044088
// +[PackageTreeNode keyPathsForValuesAffectingUnknown]
    r0 = [NSSet setWithObject:@"packageid"];
    return r0;


// 0x10004409c
// -[PackageTreeNode isUnknown]
    r0 = self->packageid;
    r0 = [r0 isEqualToString:@"com.codeweavers.unknown"];
    return r0;


// 0x1000440b4
// -[PackageTreeNode isComponent]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = self->packageobject;
    if (r0 != 0x0) {
            r0 = [r0 valueForKeyPath:@"is_component"];
            r0 = [r0 retain];
            r19 = r0;
            r20 = [r0 boolValue];
            [r19 release];
            r0 = r20;
    }
    else {
            r0 = 0x1;
    }
    return r0;


// 0x100044110
// -[PackageTreeNode isHighlighted]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = self->packageobject;
    if (r0 != 0x0) {
            r0 = [r0 valueForKeyPath:@"is_highlighted"];
            r0 = [r0 retain];
            r19 = r0;
            r20 = [r0 boolValue];
            [r19 release];
            r0 = r20;
    }
    else {
            r0 = 0x1;
    }
    return r0;


// 0x10004416c
// -[PackageTreeNode isRanked]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = self->packageobject;
    if (r0 != 0x0) {
            r0 = [r0 valueForKeyPath:@"is_ranked"];
            r0 = [r0 retain];
            r19 = r0;
            r20 = [r0 boolValue];
            [r19 release];
            r0 = r20;
    }
    else {
            r0 = 0x1;
    }
    return r0;


// 0x1000441c8
// -[PackageTreeNode filterWithPredicate:]
    [self filterWithPredicate:arg2 keepEmptyCategories:0x1];
    return;


// 0x1000441d0
// -[PackageTreeNode filterWithPredicate:keepEmptyCategories:]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x1a0;
    r23 = arg3;
    var_60 = **___stack_chk_guard;
    r19 = [arg2 retain];
    var_1A0 = q0;
    var_190 = q0;
    r24 = sign_extend_64(*(int32_t *)ivar_offset(unfilteredChildren));
    var_1E8 = self;
    r0 = *(self + r24);
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r22 = r0;
            r20 = *var_190;
            do {
                    r25 = 0x0;
                    do {
                            if (*var_190 != r20) {
                                    objc_enumerationMutation(r21);
                            }
                            [*(var_198 + r25 * 0x8) filterWithPredicate:r19 keepEmptyCategories:r23];
                            r25 = r25 + 0x1;
                    } while (r22 != r25);
                    r0 = [r21 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
                    r22 = r0;
            } while (r0 != 0x0);
    }
    [r21 release];
    r21 = var_1E8;
    r20 = [*(r21 + r24) retain];
    if (r19 != 0x0) {
            r22 = [[r20 filteredArrayUsingPredicate:r19] retain];
            [r20 release];
            r20 = r22;
    }
    r22 = [[NSMutableSet setWithArray:r20] retain];
    if (r19 != 0x0) {
            var_1F0 = r20;
            var_1E0 = q0;
            var_1D0 = q0;
            r0 = *(r21 + r24);
            r0 = [r0 retain];
            r24 = r0;
            r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
            if (r0 != 0x0) {
                    r25 = r0;
                    r21 = *var_1D0;
                    do {
                            r20 = 0x0;
                            while (true) {
                                    if (*var_1D0 != r21) {
                                            objc_enumerationMutation(r24);
                                    }
                                    r26 = *(var_1D8 + r20 * 0x8);
                                    r0 = [r26 leaf];
                                    if ((r0 & 0x1) == 0x0) {
                                            if ((r23 & 0x1) == 0x0) {
                                                    r0 = [r26 children];
                                                    r0 = [r0 retain];
                                                    r27 = r0;
                                                    r28 = [r0 count];
                                                    [r27 release];
                                                    if (r28 != 0x0) {
                                                            [r22 addObject:r26];
                                                            r20 = r20 + 0x1;
                                                            if (r25 != r20) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                                    else {
                                                            r20 = r20 + 0x1;
                                                            if (r25 != r20) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                            else {
                                                    if ((r0 & 0x1) != 0x0) {
                                                            r20 = r20 + 0x1;
                                                            if (r25 != r20) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                                    else {
                                                            [r22 addObject:r26];
                                                            r20 = r20 + 0x1;
                                                            if (r25 != r20) {
                                                                    continue;
                                                            }
                                                            break;
                                                    }
                                            }
                                    }
                                    else {
                                            if ((r0 & 0x1) != 0x0) {
                                                    r20 = r20 + 0x1;
                                                    if (r25 != r20) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                            else {
                                                    [r22 addObject:r26];
                                                    r20 = r20 + 0x1;
                                                    if (r25 != r20) {
                                                            continue;
                                                    }
                                                    break;
                                            }
                                    }
                            }
                            r0 = [r24 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
                            r25 = r0;
                    } while (r0 != 0x0);
            }
            [r24 release];
            r23 = [[NSMutableIndexSet indexSet] retain];
            r26 = *(int32_t *)ivar_offset(children);
            r21 = var_1E8;
            if ([*(r21 + (r26 << r64)) count] != 0x0) {
                    r24 = 0x0;
                    asm { sxtw       x20, w26 };
                    do {
                            r25 = [[*(r21 + r20) objectAtIndex:r24] retain];
                            if (([r22 containsObject:r25] & 0x1) != 0x0) {
                                    [r22 removeObject:r25];
                            }
                            else {
                                    [r23 addIndex:r24];
                            }
                            [r25 release];
                            r24 = r24 + 0x1;
                    } while ([*(r21 + r20) count] > r24);
            }
            if ([r23 count] != 0x0) {
                    [r21 removeChildrenAtIndexes:r23];
            }
            r20 = var_1F0;
    }
    else {
            r26 = sign_extend_64(*(int32_t *)ivar_offset(children));
            r23 = [[NSSet setWithArray:*(r21 + r26)] retain];
            [r22 minusSet:r23];
    }
    [r23 release];
    if ([r22 count] != 0x0) {
            r23 = [[r22 allObjects] retain];
            r25 = [*(r21 + (r26 << r64)) count];
            [r22 count];
            r24 = [[NSIndexSet indexSetWithIndexesInRange:r25] retain];
            [r21 insertChildren:r23 atIndexes:r24];
            [r24 release];
            [r23 release];
    }
    [r22 release];
    [r20 release];
    [r19 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x1000445ac
// -[PackageTreeNode observeValueForKeyPath:ofObject:change:context:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = arg5;
    r23 = arg3;
    r24 = arg2;
    r21 = _cmd;
    r20 = self;
    r19 = [arg4 retain];
    if (r22 != _PackageTreeNodeKVOContextDummy) {
            var_40 = r20;
            [[&var_40 super] observeValueForKeyPath:r24 ofObject:r23 change:r19 context:r22];
    }
    else {
            if (([NSThread isMainThread] & 0x1) == 0x0) {
                    r0 = [NSAssertionHandler currentHandler];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 handleFailureInMethod:r21 object:r20 file:@"PackageTreeNode.m" lineNumber:0x2c7 description:@"Main thread method or function called on non-main thread"];
                    [r22 release];
            }
            r0 = [r19 objectForKey:**_NSKeyValueChangeNotificationIsPriorKey];
            r0 = [r0 retain];
            r21 = r0;
            r22 = [r0 boolValue];
            [r21 release];
            r0 = r20;
            if (r22 != 0x0) {
                    [r0 willChangeValueForKey:@"totalChildren"];
            }
            else {
                    [r0 didChangeValueForKey:@"totalChildren"];
            }
    }
    [r19 release];
    return;


// 0x1000446e4
// +[PackageTreeNode updateIconList]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    if (*_iconUtils == 0x0) {
            r0 = [CXSetupLib iconUtilsClass];
            r0 = [[r0 alloc] init];
            r8 = *_iconUtils;
            *_iconUtils = r0;
            [r8 release];
    }
    objc_unsafeClaimAutoreleasedReturnValue([*_iconUtils fetchIconList]);
    return;


// 0x100044738
// +[PackageTreeNode defaultIcon]
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    if (*_defaultIcon.onceToken != -0x1) {
            dispatch_once(_defaultIcon.onceToken, ___block_literal_global);
    }
    r0 = *_defaultIcon.icon;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x1000447cc
// -[PackageTreeNode loadIcon]
    r31 = r31 - 0x60;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = *_iconUtils;
    r21 = sign_extend_64(*(int32_t *)ivar_offset(packageid));
    objc_unsafeClaimAutoreleasedReturnValue([r0 fetchIcon:*(r20 + r21)]);
    r0 = *_iconUtils;
    r0 = [r0 getIconPath:*(r20 + r21)];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [NSData dataWithContentsOfFile:r19];
            r0 = [r0 retain];
            r21 = r0;
            if (r0 != 0x0) {
                    r0 = [NSImage alloc];
                    r0 = [r0 initWithData:r21];
                    r22 = r0;
                    if (r0 != 0x0) {
                            var_50 = *__NSConcreteStackBlock;
                            var_28 = [r22 retain];
                            dispatch_async(*__dispatch_main_q, &var_50);
                            [var_28 release];
                    }
                    [r22 release];
            }
            [r21 release];
    }
    [r19 release];
    return;


// 0x1000448e4
// -[PackageTreeNode softwarePackage]
    r0 = self->_softwarePackage;
    return r0;


// 0x1000448f4
// -[PackageTreeNode setSoftwarePackage:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100044900
// -[PackageTreeNode localizedNames]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_localizedNames)), 0x1);
    return r0;


// 0x100044910
// -[PackageTreeNode setDescriptionFont:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10004491c
// -[PackageTreeNode container]
    r0 = objc_loadWeakRetained((int64_t *)&self->_container);
    r0 = [r0 autorelease];
    return r0;


// 0x10004493c
// -[PackageTreeNode setContainer:]
    objc_storeWeak((int64_t *)&self->_container, arg2);
    return;


// 0x100044950
// -[PackageTreeNode icon]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_icon)), 0x1);
    return r0;


// 0x100044960
// -[PackageTreeNode setIcon:]
    objc_setProperty_atomic();
    return;


// 0x10004496c
// -[PackageTreeNode .cxx_destruct]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    objc_storeStrong((int64_t *)&self->_icon, 0x0);
    objc_destroyWeak((int64_t *)&r19->_container);
    objc_storeStrong((int64_t *)&r19->_descriptionFont, 0x0);
    objc_storeStrong((int64_t *)&r19->_localizedNames, 0x0);
    objc_storeStrong((int64_t *)&r19->_softwarePackage, 0x0);
    objc_storeStrong((int64_t *)&r19->_ratingTooltip, 0x0);
    objc_storeStrong((int64_t *)&r19->_ratingDescription, 0x0);
    r20 = (int64_t *)&r19->_ratingImages;
    r21 = 0x20;
    do {
            objc_storeStrong(r20 + r21, 0x0);
            r21 = r21 - 0x8;
    } while (r21 != -0x8);
    objc_storeStrong((int64_t *)&r19->sortkey, 0x0);
    objc_storeStrong((int64_t *)&r19->unfilteredChildren, 0x0);
    objc_storeStrong((int64_t *)&r19->children, 0x0);
    objc_storeStrong((int64_t *)&r19->medaldatemessage, 0x0);
    objc_storeStrong((int64_t *)&r19->homePageDescription, 0x0);
    objc_storeStrong((int64_t *)&r19->homePage, 0x0);
    objc_storeStrong((int64_t *)&r19->c4pPage, 0x0);
    objc_storeStrong((int64_t *)&r19->description, 0x0);
    objc_storeStrong((int64_t *)&r19->packageobject, 0x0);
    objc_storeStrong((int64_t *)&r19->packageid, 0x0);
    return;


// === Block Invocations for PackageTreeNode ===

// 0x100044778
// ___30+[PackageTreeNode defaultIcon]_block_invoke
    r0 = [NSImage imageNamed:@"exeIcon.icns"];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 copy];
    r8 = *_defaultIcon.icon;
    *_defaultIcon.icon = r0;
    [r8 release];
    [r19 release];
    return;


// 0x1000448dc
// ___27-[PackageTreeNode loadIcon]_block_invoke
    r0 = arg0[0x4];
    r0 = [r0 setIcon:r0[0x5]];
    return r0;


