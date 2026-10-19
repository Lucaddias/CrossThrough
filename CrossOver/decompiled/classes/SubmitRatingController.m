// SubmitRatingController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100029200
// -[SubmitRatingController initWithBottle:]
    r0 = [self initWithBottle:arg2 isNag:0x0 isDeleting:0x0];
    return r0;


// 0x10002920c
// -[SubmitRatingController initWithBottle:isNag:isDeleting:]
    r3 = arg3;
    r31 = r31 - 0x80;
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
    r21 = arg4;
    r22 = r3;
    r19 = [arg2 retain];
    var_60 = self;
    r0 = [[&var_60 super] initWithWindowNibName:@"SubmitRating"];
    r20 = r0;
    if (r0 != 0x0) {
            if (r19 != 0x0) {
                    r0 = [r19 appid];
                    r0 = [r0 retain];
                    r23 = r0;
                    [r0 release];
                    if (r23 != 0x0) {
                            if (r22 != 0x0) {
                                    r0 = [NSUserDefaults standardUserDefaults];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r24 = [r0 boolForKey:@"AskForRatings"];
                                    [r23 release];
                                    if (r24 != 0x0) {
                                            [r20 setBottle:r19];
                                            r23 = [[r19 appid] retain];
                                            [r20 setAppid:r23];
                                            [r23 release];
                                            [r20 setNag:0x1];
                                            [r20 setDeleting:r21];
                                            r23 = [[[CXSetupLib c4ProfilesClass] profilesSet] retain];
                                            if ((objc_opt_respondsToSelector() & 0x1) != 0x0) {
                                                    r0 = [r23 contentsDict];
                                                    r0 = [r0 retain];
                                            }
                                            else {
                                                    r0 = [r23 retain];
                                            }
                                            r24 = r0;
                                            r26 = [[r20 appid] retain];
                                            r25 = [[NSString stringWithFormat:@"com.codeweavers.c4.%@", r3] retain];
                                            [r26 release];
                                            r0 = [r24 objectForKey:r25];
                                            r0 = [r0 retain];
                                            r26 = r0;
                                            r0 = [r0 valueForKey:@"is_component"];
                                            r0 = [r0 retain];
                                            r27 = r0;
                                            r28 = [r0 boolValue];
                                            [r27 release];
                                            [r26 release];
                                            if (r28 != 0x0) {
                                                    if ((r21 & 0x1) == 0x0) {
                                                            [r19 disableRatingNag];
                                                    }
                                                    [r25 release];
                                                    [r24 release];
                                                    [r23 release];
                                                    [r19 release];
                                                    [r20 release];
                                                    r0 = 0x0;
                                            }
                                            else {
                                                    [r25 release];
                                                    [r24 release];
                                                    [r23 release];
                                                    if ((r21 & 0x1) == 0x0) {
                                                            if (([r19 isShouldNagForRatings] & 0x1) == 0x0) {
                                                                    [r19 release];
                                                                    [r20 release];
                                                                    r0 = 0x0;
                                                            }
                                                            else {
                                                                    r0 = [CXSetupLib ratingUtilsClass];
                                                                    r0 = [r0 alloc];
                                                                    r0 = [r0 initWithAppID:r20->_appid];
                                                                    r25 = sign_extend_64(*(int32_t *)ivar_offset(_ratingUtils));
                                                                    r8 = *(r20 + r25);
                                                                    *(r20 + r25) = r0;
                                                                    [r8 release];
                                                                    r0 = *(r20 + r25);
                                                                    r0 = [r0 fetchRating];
                                                                    r0 = [r0 retain];
                                                                    r23 = r0;
                                                                    r24 = [r0 boolValue];
                                                                    [r23 release];
                                                                    if ((r24 & 0x1) == 0x0) {
                                                                            r0 = *(r20 + r25);
                                                                            r0 = [r0 valueForKey:@"connection_failed"];
                                                                            r0 = [r0 retain];
                                                                            r23 = r0;
                                                                            r24 = [r0 boolValue];
                                                                            [r23 release];
                                                                            if ((r24 & 0x1) == 0x0) {
                                                                                    if (r22 != 0x0) {
                                                                                            r0 = *(r20 + r25);
                                                                                            r0 = [r0 valueForKey:@"rating"];
                                                                                            r0 = [r0 retain];
                                                                                            r22 = r0;
                                                                                            r23 = [r0 integerValue];
                                                                                            [r22 release];
                                                                                            if (r23 != 0x0) {
                                                                                                    if ((r21 & 0x1) == 0x0) {
                                                                                                            [r19 disableRatingNag];
                                                                                                    }
                                                                                                    r21 = 0x0;
                                                                                            }
                                                                                            else {
                                                                                                    r21 = [r20 retain];
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            r21 = [r20 retain];
                                                                                    }
                                                                                    [r19 release];
                                                                                    [r20 release];
                                                                                    r0 = r21;
                                                                            }
                                                                            else {
                                                                                    [r19 release];
                                                                                    [r20 release];
                                                                                    r0 = 0x0;
                                                                            }
                                                                    }
                                                                    else {
                                                                            if (r22 != 0x0) {
                                                                                    r0 = *(r20 + r25);
                                                                                    r0 = [r0 valueForKey:@"rating"];
                                                                                    r0 = [r0 retain];
                                                                                    r22 = r0;
                                                                                    r23 = [r0 integerValue];
                                                                                    [r22 release];
                                                                                    if (r23 != 0x0) {
                                                                                            if ((r21 & 0x1) == 0x0) {
                                                                                                    [r19 disableRatingNag];
                                                                                            }
                                                                                            r21 = 0x0;
                                                                                    }
                                                                                    else {
                                                                                            r21 = [r20 retain];
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r21 = [r20 retain];
                                                                            }
                                                                            [r19 release];
                                                                            [r20 release];
                                                                            r0 = r21;
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            r0 = [CXSetupLib ratingUtilsClass];
                                                            r0 = [r0 alloc];
                                                            r0 = [r0 initWithAppID:r20->_appid];
                                                            r25 = sign_extend_64(*(int32_t *)ivar_offset(_ratingUtils));
                                                            r8 = *(r20 + r25);
                                                            *(r20 + r25) = r0;
                                                            [r8 release];
                                                            r0 = *(r20 + r25);
                                                            r0 = [r0 fetchRating];
                                                            r0 = [r0 retain];
                                                            r23 = r0;
                                                            r24 = [r0 boolValue];
                                                            [r23 release];
                                                            if ((r24 & 0x1) == 0x0) {
                                                                    r0 = *(r20 + r25);
                                                                    r0 = [r0 valueForKey:@"connection_failed"];
                                                                    r0 = [r0 retain];
                                                                    r23 = r0;
                                                                    r24 = [r0 boolValue];
                                                                    [r23 release];
                                                                    if ((r24 & 0x1) == 0x0) {
                                                                            if (r22 != 0x0) {
                                                                                    r0 = *(r20 + r25);
                                                                                    r0 = [r0 valueForKey:@"rating"];
                                                                                    r0 = [r0 retain];
                                                                                    r22 = r0;
                                                                                    r23 = [r0 integerValue];
                                                                                    [r22 release];
                                                                                    if (r23 != 0x0) {
                                                                                            if ((r21 & 0x1) == 0x0) {
                                                                                                    [r19 disableRatingNag];
                                                                                            }
                                                                                            r21 = 0x0;
                                                                                    }
                                                                                    else {
                                                                                            r21 = [r20 retain];
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    r21 = [r20 retain];
                                                                            }
                                                                            [r19 release];
                                                                            [r20 release];
                                                                            r0 = r21;
                                                                    }
                                                                    else {
                                                                            [r19 release];
                                                                            [r20 release];
                                                                            r0 = 0x0;
                                                                    }
                                                            }
                                                            else {
                                                                    if (r22 != 0x0) {
                                                                            r0 = *(r20 + r25);
                                                                            r0 = [r0 valueForKey:@"rating"];
                                                                            r0 = [r0 retain];
                                                                            r22 = r0;
                                                                            r23 = [r0 integerValue];
                                                                            [r22 release];
                                                                            if (r23 != 0x0) {
                                                                                    if ((r21 & 0x1) == 0x0) {
                                                                                            [r19 disableRatingNag];
                                                                                    }
                                                                                    r21 = 0x0;
                                                                            }
                                                                            else {
                                                                                    r21 = [r20 retain];
                                                                            }
                                                                    }
                                                                    else {
                                                                            r21 = [r20 retain];
                                                                    }
                                                                    [r19 release];
                                                                    [r20 release];
                                                                    r0 = r21;
                                                            }
                                                    }
                                            }
                                    }
                                    else {
                                            [r19 release];
                                            [r20 release];
                                            r0 = 0x0;
                                    }
                            }
                            else {
                                    [r20 setBottle:r19];
                                    r23 = [[r19 appid] retain];
                                    [r20 setAppid:r23];
                                    [r23 release];
                                    [r20 setNag:0x0];
                                    [r20 setDeleting:r21];
                                    r0 = [CXSetupLib ratingUtilsClass];
                                    r0 = [r0 alloc];
                                    r0 = [r0 initWithAppID:r20->_appid];
                                    r25 = sign_extend_64(*(int32_t *)ivar_offset(_ratingUtils));
                                    r8 = *(r20 + r25);
                                    *(r20 + r25) = r0;
                                    [r8 release];
                                    r0 = *(r20 + r25);
                                    r0 = [r0 fetchRating];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    r24 = [r0 boolValue];
                                    [r23 release];
                                    if ((r24 & 0x1) == 0x0) {
                                            r0 = *(r20 + r25);
                                            r0 = [r0 valueForKey:@"connection_failed"];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            r24 = [r0 boolValue];
                                            [r23 release];
                                            if ((r24 & 0x1) == 0x0) {
                                                    if (r22 != 0x0) {
                                                            r0 = *(r20 + r25);
                                                            r0 = [r0 valueForKey:@"rating"];
                                                            r0 = [r0 retain];
                                                            r22 = r0;
                                                            r23 = [r0 integerValue];
                                                            [r22 release];
                                                            if (r23 != 0x0) {
                                                                    if ((r21 & 0x1) == 0x0) {
                                                                            [r19 disableRatingNag];
                                                                    }
                                                                    r21 = 0x0;
                                                            }
                                                            else {
                                                                    r21 = [r20 retain];
                                                            }
                                                    }
                                                    else {
                                                            r21 = [r20 retain];
                                                    }
                                                    [r19 release];
                                                    [r20 release];
                                                    r0 = r21;
                                            }
                                            else {
                                                    [r19 release];
                                                    [r20 release];
                                                    r0 = 0x0;
                                            }
                                    }
                                    else {
                                            if (r22 != 0x0) {
                                                    r0 = *(r20 + r25);
                                                    r0 = [r0 valueForKey:@"rating"];
                                                    r0 = [r0 retain];
                                                    r22 = r0;
                                                    r23 = [r0 integerValue];
                                                    [r22 release];
                                                    if (r23 != 0x0) {
                                                            if ((r21 & 0x1) == 0x0) {
                                                                    [r19 disableRatingNag];
                                                            }
                                                            r21 = 0x0;
                                                    }
                                                    else {
                                                            r21 = [r20 retain];
                                                    }
                                            }
                                            else {
                                                    r21 = [r20 retain];
                                            }
                                            [r19 release];
                                            [r20 release];
                                            r0 = r21;
                                    }
                            }
                    }
                    else {
                            [r19 release];
                            [r20 release];
                            r0 = 0x0;
                    }
            }
            else {
                    [r19 release];
                    [r20 release];
                    r0 = 0x0;
            }
    }
    else {
            r21 = [r20 retain];
            [r19 release];
            [r20 release];
            r0 = r21;
    }
    return r0;


// 0x1000295a8
// -[SubmitRatingController windowDidLoad]
    r31 = r31 - 0xe0;
    var_60 = d9;
    decomp_var_58 = d8;
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
    var_68 = **___stack_chk_guard;
    var_98 = self;
    [[&var_98 super] windowDidLoad];
    r21 = objc_loadWeakRetained((int64_t *)&r19->_stackView);
    r22 = objc_loadWeakRetained((int64_t *)&r19->_ratingIndicator);
    [r21 setCustomSpacing:r22 afterView:r3];
    [r22 release];
    [r21 release];
    r20 = objc_loadWeakRetained((int64_t *)&r19->_stackView);
    r21 = objc_loadWeakRetained((int64_t *)&r19->_notesField);
    d0 = 0x4000000000000000;
    [r20 setCustomSpacing:r21 afterView:r3];
    [r21 release];
    [r20 release];
    r20 = [[[CXSetupLib c4ProfilesClass] profilesSet] retain];
    r0 = objc_opt_respondsToSelector();
    var_A0 = r20;
    if ((r0 & 0x1) != 0x0) {
            r0 = [r20 contentsDict];
            r0 = [r0 retain];
    }
    else {
            r0 = [r20 retain];
    }
    r23 = [[r19 appid] retain];
    r21 = [[NSString stringWithFormat:@"com.codeweavers.c4.%@", r3] retain];
    [r23 release];
    var_B0 = r21;
    var_A8 = r0;
    r0 = [r0 objectForKey:r21];
    r0 = [r0 retain];
    r21 = r0;
    r23 = [[r0 valueForKey:@"name"] retain];
    [r21 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r25 = [[r0 localizedStringForKey:@"Submit a Rating for '%@'" value:@"" table:0x0] retain];
    [r21 release];
    r21 = [[NSString stringWithFormat:r25] retain];
    [r19 setDialogTitle:r21];
    [r21 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r21 = r0;
    r24 = [[r0 localizedStringForKey:@"Please leave a rating in order to help us better target our improvements to %@ and to inform other users on how well '%@' works with %@." value:@"" table:0x0] retain];
    [r25 release];
    [r21 release];
    r21 = [[NSString stringWithFormat:r24] retain];
    [r19 setMessage:r21];
    [r21 release];
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_ratingUtils));
    r0 = *(r19 + r22);
    r0 = [r0 valueForKey:@"rating"];
    r0 = [r0 retain];
    r21 = r0;
    [r19 setRating:[r0 integerValue]];
    [r21 release];
    r21 = [[*(r19 + r22) valueForKey:@"notes"] retain];
    [r19 setNotes:r21];
    [r21 release];
    r0 = *(r19 + r22);
    r0 = [r0 valueForKey:@"login_required"];
    r0 = [r0 retain];
    r21 = r0;
    r25 = [r0 boolValue];
    [r21 release];
    if (r25 != 0x0) {
            r0 = [NSBundle mainBundle];
            r0 = [r0 retain];
            r21 = r0;
            r25 = [[r0 localizedStringForKey:@"Log In and Submit Rating…" value:@"" table:0x0] retain];
            r0 = objc_loadWeakRetained((int64_t *)&r19->_submitButton);
            r26 = r0;
            [r0 setTitle:r25];
            [r26 release];
            [r25 release];
            [r21 release];
    }
    r25 = [[NSURL URLWithString:@"https://www.codeweavers.com/login/lostpassword/"] retain];
    r0 = objc_loadWeakRetained((int64_t *)&r19->_forgotPasswordLabel);
    r21 = r0;
    r0 = [r0 attributedStringValue];
    r0 = [r0 retain];
    r27 = r0;
    r26 = [r0 mutableCopy];
    [r27 release];
    [r21 release];
    [r26 length];
    var_88 = **_NSForegroundColorAttributeName;
    r0 = [NSColor blueColor];
    r0 = [r0 retain];
    r22 = r0;
    var_78 = r0;
    r20 = [@(0x1) retain];
    r0 = [NSDictionary dictionaryWithObjects:&var_78 forKeys:&var_88 count:0x2];
    r27 = [r0 retain];
    [r20 release];
    [r22 release];
    [r26 addAttributes:r27 range:0x0];
    [r26 addAttribute:**_NSLinkAttributeName value:r25 range:0x0];
    r0 = objc_loadWeakRetained((int64_t *)&r19->_forgotPasswordLabel);
    r20 = r0;
    [r0 setAttributedStringValue:r26];
    [r20 release];
    r0 = [r19 ratingIndicator];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 ratingImage];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [r0 copy];
    [r22 release];
    [r20 release];
    [r21 size];
    [r21 size];
    [r21 setSize:r2];
    r0 = [r19 ratingIndicator];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setRatingImage:r21];
    [r20 release];
    r0 = [r19 ratingIndicator];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 ratingPlaceholderImage];
    r0 = [r0 retain];
    r22 = r0;
    r28 = [r0 copy];
    [r21 release];
    [r22 release];
    [r20 release];
    [r28 setSize:r2];
    r0 = [r19 ratingIndicator];
    r0 = [r0 retain];
    r19 = r0;
    [r0 setRatingPlaceholderImage:r28];
    [r19 release];
    [r28 release];
    [r27 release];
    [r26 release];
    [r25 release];
    [r24 release];
    [r23 release];
    [var_B0 release];
    [var_A8 release];
    [var_A0 release];
    if (**___stack_chk_guard != var_68) {
            __stack_chk_fail();
    }
    return;


// 0x100029c38
// +[SubmitRatingController keyPathsForValuesAffectingRatingDescription]
    r0 = [NSSet setWithObjects:@"rating"];
    return r0;


// 0x100029c68
// -[SubmitRatingController ratingDescription]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r8 = sign_extend_64(*(int32_t *)ivar_offset(_rating));
    r8 = *(self + r8);
    if (r8 <= 0x5) {
            index_0 = r8;
            switch (index_0) {
                case 0:
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r19 = r0;
                    r2 = @"Unrated";
                    break;
                case 1:
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r19 = r0;
                    r2 = @"Will Not Install";
                    break;
                case 2:
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r19 = r0;
                    r2 = @"Installs, Will Not Run";
                    break;
                case 3:
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r19 = r0;
                    r2 = @"Limited Functionality";
                    break;
                case 4:
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r19 = r0;
                    r2 = @"Runs Well";
                    break;
                default:
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r19 = r0;
                    r2 = @"Runs Great";
                    break;
            }
            r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
            [r19 release];
    }
    else {
            r20 = @"";
    }
    r0 = [r20 autorelease];
    return r0;


// 0x100029db4
// +[SubmitRatingController keyPathsForValuesAffectingCharactersLeft]
    r0 = [NSSet setWithObjects:@"notes"];
    return r0;


// 0x100029de4
// -[SubmitRatingController charactersLeft]
    r0 = [self notesFormatter];
    r0 = [r0 retain];
    r20 = r0;
    r19 = [r0 maxLength] - [self->_notes length];
    [r20 release];
    r0 = r19;
    return r0;


// 0x100029e40
// +[SubmitRatingController keyPathsForValuesAffectingCanSubmit]
    r0 = [NSSet setWithObjects:@"ratingUtils.login_required"];
    return r0;


// 0x100029e8c
// -[SubmitRatingController canSubmit]
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
    if (*(r0 + sign_extend_64(*(int32_t *)ivar_offset(_rating))) >= 0x1) {
            r19 = r0;
            r0 = r0->_ratingUtils;
            r0 = [r0 valueForKey:@"login_required"];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 boolValue];
            [r20 release];
            if (r21 != 0x0) {
                    r21 = sign_extend_64(*(int32_t *)ivar_offset(_email));
                    r0 = *(r19 + r21);
                    r0 = [r0 length];
                    if (r0 != 0x0) {
                            r0 = *(r19 + r21);
                            r0 = [r0 rangeOfString:@"@"];
                            if (r0 != 0x7fffffffffffffff) {
                                    r21 = *(r19 + r21);
                                    [r21 length] + (r0 ^ 0xffffffff);
                                    if ([r21 rangeOfString:@"." options:0x0 range:r0 + 0x1] == 0x7fffffffffffffff) {
                                            r0 = 0x0;
                                    }
                                    else {
                                            r0 = r19->_password;
                                            r0 = [r0 length];
                                            if (r0 != 0x0) {
                                                    r0 = 0x1;
                                            }
                                    }
                            }
                            else {
                                    r0 = 0x0;
                            }
                    }
            }
            else {
                    r0 = 0x1;
            }
    }
    else {
            r0 = 0x0;
    }
    return r0;


// 0x100029f98
// -[SubmitRatingController askAgain]
    r0 = [self deleting];
    r0 = r0 ^ 0x1;
    return r0;


// 0x100029fb0
// -[SubmitRatingController submit:]
    r31 = r31 - 0x60;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self contentViewController];
    r0 = [r0 retain];
    r20 = r0;
    [r0 commitEditing];
    [r20 release];
    r0 = r19->_ratingUtils;
    r0 = [r0 valueForKey:@"login_required"];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 boolValue];
    [r20 release];
    if (r21 != 0x0) {
            [r19 setFailed:0x0];
            [r19 setLoggingIn:0x1];
            r0 = dispatch_get_global_queue(0x19, 0x0);
            r0 = [r0 retain];
            r20 = r0;
            var_48 = *__NSConcreteStackBlock;
            dispatch_async(r0, &var_48);
            [r20 release];
    }
    else {
            [r19 doSubmit];
    }
    return;


// 0x10002a1b8
// -[SubmitRatingController never:]
    r0 = [self bottle];
    r0 = [r0 retain];
    r20 = r0;
    [r0 disableRatingNag];
    [r20 release];
    [self close];
    return;


// 0x10002a1f4
// -[SubmitRatingController cancel:]
    [self close];
    return;


// 0x10002a1f8
// -[SubmitRatingController close]
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 close];
    [r20 release];
    r20 = [[NSApplication sharedApplication] retain];
    r19 = [[self window] retain];
    [r20 endSheet:r19];
    [r19 release];
    [r20 release];
    return;


// 0x10002a274
// -[SubmitRatingController handleLogin:]
    r2 = arg2;
    r0 = self;
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = r0;
    if (r2 != 0x0) {
            [r0 doSubmit];
            [r19 doRegister];
    }
    else {
            [r0 setLoggingIn:r2];
            [r19 setFailed:0x1];
            r19 = (int64_t *)&r19->_emailField;
            r0 = objc_loadWeakRetained(r19);
            r20 = r0;
            r21 = [r0 acceptsFirstResponder];
            [r20 release];
            if (r21 != 0x0) {
                    r0 = objc_loadWeakRetained(r19);
                    r20 = r0;
                    r21 = [[r0 window] retain];
                    r19 = objc_loadWeakRetained(r19);
                    [r21 makeFirstResponder:r19];
                    [r19 release];
                    [r21 release];
                    [r20 release];
            }
            NSBeep();
    }
    return;


// 0x10002a33c
// -[SubmitRatingController doSubmit]
    [self setFailed:0x0];
    [self setLoggingIn:0x1];
    r0 = dispatch_get_global_queue(0x19, 0x0);
    r0 = [r0 retain];
    r20 = r0;
    var_38 = *__NSConcreteStackBlock;
    dispatch_async(r0, &var_38);
    [r20 release];
    return;


// 0x10002a580
// -[SubmitRatingController doRegister]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([**_NSApp isDemo] != 0x0) {
            r0 = [r19 email];
            r0 = [r0 retain];
            if (r0 != 0x0) {
                    r20 = r0;
                    r0 = [r19 password];
                    r0 = [r0 retain];
                    r21 = r0;
                    [r0 release];
                    [r20 release];
                    if (r21 != 0x0) {
                            r20 = [[RegistrationController alloc] init];
                            r21 = [[r19 email] retain];
                            [r20 setLogin:r21];
                            [r21 release];
                            r19 = [[r19 password] retain];
                            [r20 setPassword:r19];
                            [r19 release];
                            [r20 beginRegisterAppWithCompletionHandler:0x0];
                            [r20 release];
                    }
            }
    }
    return;


// 0x10002a674
// -[SubmitRatingController windowDidBecomeKey:]
    r0 = objc_loadWeakRetained((int64_t *)&self->_ratingIndicator);
    r20 = r0;
    [r0 setRefusesFirstResponder:0x0];
    [r20 release];
    r0 = objc_loadWeakRetained((int64_t *)&self->_submitButton);
    r20 = r0;
    r21 = [[r0 cell] retain];
    r0 = objc_loadWeakRetained((int64_t *)&self->_submitButton);
    r19 = r0;
    r0 = [r0 window];
    r0 = [r0 retain];
    r22 = r0;
    [r0 setDefaultButtonCell:r21];
    [r22 release];
    [r19 release];
    [r21 release];
    [r20 release];
    return;


// 0x10002a724
// -[SubmitRatingController controlTextDidChange:]
    r0 = [arg2 object];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 infoForBinding:**_NSValueBinding];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 valueForKey:**_NSObservedObjectKey] retain];
    r22 = [[r19 stringValue] retain];
    r23 = [[r20 valueForKey:**_NSObservedKeyPathKey] retain];
    [r21 setValue:r22 forKeyPath:r23];
    [r23 release];
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    return;


// 0x10002a800
// -[SubmitRatingController stackView]
    r0 = objc_loadWeakRetained((int64_t *)&self->_stackView);
    r0 = [r0 autorelease];
    return r0;


// 0x10002a820
// -[SubmitRatingController setStackView:]
    objc_storeWeak((int64_t *)&self->_stackView, arg2);
    return;


// 0x10002a834
// -[SubmitRatingController ratingIndicator]
    r0 = objc_loadWeakRetained((int64_t *)&self->_ratingIndicator);
    r0 = [r0 autorelease];
    return r0;


// 0x10002a854
// -[SubmitRatingController setRatingIndicator:]
    objc_storeWeak((int64_t *)&self->_ratingIndicator, arg2);
    return;


// 0x10002a868
// -[SubmitRatingController notesField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_notesField);
    r0 = [r0 autorelease];
    return r0;


// 0x10002a888
// -[SubmitRatingController setNotesField:]
    objc_storeWeak((int64_t *)&self->_notesField, arg2);
    return;


// 0x10002a89c
// -[SubmitRatingController submitButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_submitButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10002a8bc
// -[SubmitRatingController setSubmitButton:]
    objc_storeWeak((int64_t *)&self->_submitButton, arg2);
    return;


// 0x10002a8d0
// -[SubmitRatingController notesFormatter]
    r0 = objc_loadWeakRetained((int64_t *)&self->_notesFormatter);
    r0 = [r0 autorelease];
    return r0;


// 0x10002a8f0
// -[SubmitRatingController setNotesFormatter:]
    objc_storeWeak((int64_t *)&self->_notesFormatter, arg2);
    return;


// 0x10002a904
// -[SubmitRatingController forgotPasswordLabel]
    r0 = objc_loadWeakRetained((int64_t *)&self->_forgotPasswordLabel);
    r0 = [r0 autorelease];
    return r0;


// 0x10002a924
// -[SubmitRatingController setForgotPasswordLabel:]
    objc_storeWeak((int64_t *)&self->_forgotPasswordLabel, arg2);
    return;


// 0x10002a938
// -[SubmitRatingController emailField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_emailField);
    r0 = [r0 autorelease];
    return r0;


// 0x10002a958
// -[SubmitRatingController setEmailField:]
    objc_storeWeak((int64_t *)&self->_emailField, arg2);
    return;


// 0x10002a96c
// -[SubmitRatingController bottle]
    r0 = self->_bottle;
    return r0;


// 0x10002a97c
// -[SubmitRatingController setBottle:]
    objc_storeStrong((int64_t *)&self->_bottle, arg2);
    return;


// 0x10002a990
// -[SubmitRatingController dialogTitle]
    r0 = self->_dialogTitle;
    return r0;


// 0x10002a9a0
// -[SubmitRatingController setDialogTitle:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10002a9ac
// -[SubmitRatingController message]
    r0 = self->_message;
    return r0;


// 0x10002a9bc
// -[SubmitRatingController setMessage:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10002a9c8
// -[SubmitRatingController rating]
    r0 = self->_rating;
    return r0;


// 0x10002a9d8
// -[SubmitRatingController setRating:]
    self->_rating = arg2;
    return;


// 0x10002a9e8
// -[SubmitRatingController notes]
    r0 = self->_notes;
    return r0;


// 0x10002a9f8
// -[SubmitRatingController setNotes:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10002aa04
// -[SubmitRatingController setCharactersLeft:]
    self->_charactersLeft = arg2;
    return;


// 0x10002aa14
// -[SubmitRatingController email]
    r0 = self->_email;
    return r0;


// 0x10002aa24
// -[SubmitRatingController setEmail:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10002aa30
// -[SubmitRatingController password]
    r0 = self->_password;
    return r0;


// 0x10002aa40
// -[SubmitRatingController setPassword:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10002aa4c
// -[SubmitRatingController loggingIn]
    r0 = *(int8_t *)(int64_t *)&self->_loggingIn;
    return r0;


// 0x10002aa5c
// -[SubmitRatingController setLoggingIn:]
    *(int8_t *)(int64_t *)&self->_loggingIn = arg2;
    return;


// 0x10002aa6c
// -[SubmitRatingController failed]
    r0 = *(int8_t *)(int64_t *)&self->_failed;
    return r0;


// 0x10002aa7c
// -[SubmitRatingController setFailed:]
    *(int8_t *)(int64_t *)&self->_failed = arg2;
    return;


// 0x10002aa8c
// -[SubmitRatingController nag]
    r0 = *(int8_t *)(int64_t *)&self->_nag;
    return r0;


// 0x10002aa9c
// -[SubmitRatingController setNag:]
    *(int8_t *)(int64_t *)&self->_nag = arg2;
    return;


// 0x10002aaac
// -[SubmitRatingController deleting]
    r0 = *(int8_t *)(int64_t *)&self->_deleting;
    return r0;


// 0x10002aabc
// -[SubmitRatingController setDeleting:]
    *(int8_t *)(int64_t *)&self->_deleting = arg2;
    return;


// 0x10002aacc
// -[SubmitRatingController ratingUtils]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_ratingUtils)), 0x1);
    return r0;


// 0x10002aadc
// -[SubmitRatingController appid]
    r0 = self->_appid;
    return r0;


// 0x10002aaec
// -[SubmitRatingController setAppid:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10002aaf8
// -[SubmitRatingController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_appid, 0x0);
    objc_storeStrong((int64_t *)&self->_password, 0x0);
    objc_storeStrong((int64_t *)&self->_email, 0x0);
    objc_storeStrong((int64_t *)&self->_notes, 0x0);
    objc_storeStrong((int64_t *)&self->_message, 0x0);
    objc_storeStrong((int64_t *)&self->_dialogTitle, 0x0);
    objc_storeStrong((int64_t *)&self->_bottle, 0x0);
    objc_destroyWeak((int64_t *)&self->_emailField);
    objc_destroyWeak((int64_t *)&self->_forgotPasswordLabel);
    objc_destroyWeak((int64_t *)&self->_notesFormatter);
    objc_destroyWeak((int64_t *)&self->_submitButton);
    objc_destroyWeak((int64_t *)&self->_notesField);
    objc_destroyWeak((int64_t *)&self->_ratingIndicator);
    objc_destroyWeak((int64_t *)&self->_stackView);
    objc_storeStrong((int64_t *)&self->_ratingUtils, 0x0);
    return;


