// SelectBottleSheetController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10002b108
// -[SelectBottleSheetController initWithInstallConfiguration:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = arg2;
    r19 = [arg2 retain];
    var_30 = self;
    r0 = [[&var_30 super] initWithWindowNibName:@"SelectBottleSheet"];
    r21 = r0;
    if (r0 != 0x0) {
            r22 = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
            objc_storeWeak((int64_t *)&r21->_bottleCollection, r22);
            [r22 release];
            objc_storeStrong((int64_t *)&r21->_installConfiguration, r20);
            [r21->_installConfiguration addDelegate:r21];
    }
    [r19 release];
    r0 = r21;
    return r0;


// 0x10002b1d8
// -[SelectBottleSheetController dealloc]
    [self->_installConfiguration removeDelegate:self];
    var_20 = self;
    [[&var_20 super] dealloc];
    return;


// 0x10002b22c
// -[SelectBottleSheetController windowDidLoad]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 nameForNewBottle] retain];
    [r19 setNameForNewBottle:r21];
    [r21 release];
    [r20 release];
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 targetBottle] retain];
    [r19 setTargetBottle:r21];
    [r21 release];
    [r20 release];
    [r19 updateMenus];
    [r19 updateBottleWarningText];
    if ([r19 creatingNewBottle] != 0x0) {
            r20 = [[r19 installConfiguration] retain];
            r21 = [[r19 nameForNewBottle] retain];
            r22 = [r20 isNewBottleNameValid:r21];
            [r21 release];
            [r20 release];
            if ((r22 & 0x1) == 0x0) {
                    r20 = [[r19 window] retain];
                    r21 = [[r19 nameForNewBottleTextField] retain];
                    [r20 makeFirstResponder:r21];
                    [r21 release];
                    [r20 release];
            }
    }
    if ([r19 creatingNewBottle] != 0x0) {
            r20 = [[r19 bottleListPopUpButton] retain];
            r19 = [[r19 makeNewBottleMenuItem] retain];
            [r20 selectItem:r19];
            [r19 release];
            [r20 release];
    }
    return;


// 0x10002b3d4
// -[SelectBottleSheetController isTemplate:]
    r2 = arg2;
    if (r2 != 0x0) {
            r0 = [r2 valueForKey:@"is_template"];
            r0 = [r0 retain];
            r19 = r0;
            r20 = [r0 boolValue];
            [r19 release];
            r0 = r20;
    }
    else {
            r0 = 0x0;
    }
    return r0;


// 0x10002b42c
// -[SelectBottleSheetController creatingNewBottle]
    r20 = [[self targetBottle] retain];
    r19 = [self isTemplate:r20];
    [r20 release];
    r0 = r19;
    return r0;


// 0x10002b474
// +[SelectBottleSheetController keyPathsForValuesAffectingCreatingNewBottle]
    r0 = [NSSet setWithObject:@"targetBottle"];
    return r0;


// 0x10002b488
// -[SelectBottleSheetController setNameForNewBottle:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [arg2 retain];
    r20 = r0;
    r22 = sign_extend_64(*(int32_t *)ivar_offset(_nameForNewBottle));
    if (([r0 isEqual:*(r19 + r22)] & 0x1) == 0x0) {
            [r19 willChangeValueForKey:@"nameForNewBottle"];
            r0 = [r20 copy];
            r8 = *(r19 + r22);
            *(r19 + r22) = r0;
            [r8 release];
            [r19 didChangeValueForKey:@"nameForNewBottle"];
            [r19 updateBottleWarningText];
    }
    [r20 release];
    return;


// 0x10002b510
// -[SelectBottleSheetController stringInSystemFont:]
    r2 = arg2;
    r31 = r31 - 0x60;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_28 = **___stack_chk_guard;
    r19 = [r2 retain];
    if (*_stringInSystemFont:.labelFont == 0x0) {
            var_48 = **_NSFontAttributeName;
            [NSFont systemFontSize];
            r0 = [NSFont systemFontOfSize:r2];
            r0 = [r0 retain];
            r20 = r0;
            var_38 = r0;
            r21 = [[NSColor labelColor] retain];
            r0 = [NSDictionary dictionaryWithObjects:&var_38 forKeys:&var_48 count:0x2];
            r0 = [r0 retain];
            r8 = *_stringInSystemFont:.labelFont;
            *_stringInSystemFont:.labelFont = r0;
            [r8 release];
            [r21 release];
            [r20 release];
    }
    r20 = [[NSAttributedString alloc] initWithString:r19 attributes:*_stringInSystemFont:.labelFont];
    r0 = [r19 release];
    if (**___stack_chk_guard != var_28) {
            __stack_chk_fail();
    }
    r0 = [r20 autorelease];
    return r0;


// 0x10002b648
// -[SelectBottleSheetController attributedStringWithImageNamed:]
    r23 = [arg2 retain];
    [NSFont systemFontSize];
    r0 = [NSFont systemFontOfSize:r2];
    r0 = [r0 retain];
    r19 = r0;
    [r0 ascender];
    [r19 descender];
    r21 = [[NSTextAttachment alloc] init];
    r22 = [[NSImage imageNamed:r23] retain];
    [r23 release];
    [r22 size];
    [r22 size];
    [r22 setSize:r2];
    [r21 setImage:r22];
    r0 = [NSAttributedString attributedStringWithAttachment:r21];
    r0 = [r0 retain];
    r24 = r0;
    r23 = [r0 mutableCopy];
    [r24 release];
    r24 = **_NSBaselineOffsetAttributeName;
    [r19 descender];
    r25 = [[NSNumber numberWithDouble:r2] retain];
    [r23 length];
    [r23 addAttribute:r24 value:r25 range:0x0];
    [r25 release];
    r20 = [[self stringInSystemFont:@" "] retain];
    [r23 appendAttributedString:r20];
    [r20 release];
    [r22 release];
    [r21 release];
    [r19 release];
    r0 = [r23 autorelease];
    return r0;


// 0x10002b800
// -[SelectBottleSheetController attributedErrorStringWithString:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if (*_attributedErrorStringWithString:.errorIconPrefix == 0x0) {
            r0 = [r20 attributedStringWithImageNamed:@"sf-symbols.xmark.octagon.fill"];
            r0 = [r0 retain];
            r8 = *_attributedErrorStringWithString:.errorIconPrefix;
            *_attributedErrorStringWithString:.errorIconPrefix = r0;
            [r8 release];
    }
    r21 = [*_attributedErrorStringWithString:.errorIconPrefix mutableCopy];
    r20 = [[r20 stringInSystemFont:r19] retain];
    [r21 appendAttributedString:r20];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x10002b8a8
// -[SelectBottleSheetController attributedWarningStringWithString:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if (*_attributedWarningStringWithString:.warningIconPrefix == 0x0) {
            r0 = [r20 attributedStringWithImageNamed:@"sf-symbols.exclamationmark.circle.fill"];
            r0 = [r0 retain];
            r8 = *_attributedWarningStringWithString:.warningIconPrefix;
            *_attributedWarningStringWithString:.warningIconPrefix = r0;
            [r8 release];
    }
    r21 = [*_attributedWarningStringWithString:.warningIconPrefix mutableCopy];
    r20 = [[r20 stringInSystemFont:r19] retain];
    [r21 appendAttributedString:r20];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x10002b950
// -[SelectBottleSheetController updateBottleWarningText]
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
    if ([self creatingNewBottle] != 0x0) {
            r20 = [[r19 installConfiguration] retain];
            r21 = [[r19 nameForNewBottle] retain];
            r22 = [r20 isNewBottleNameValid:r21];
            [r21 release];
            [r20 release];
            if ((r22 & 0x1) != 0x0) {
                    if ([r19 creatingNewBottle] != 0x0) {
                            r20 = [[r19 bottleCollection] retain];
                            r21 = [[r19 nameForNewBottle] retain];
                            r0 = [r20 bottleWithName:r21];
                            r0 = [r0 retain];
                            r22 = r0;
                            [r0 release];
                            [r21 release];
                            [r20 release];
                            if (r22 != 0x0) {
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    r21 = [[r0 localizedStringForKey:@"You can't name a new bottle '%@'. There is already a bottle by that name. You must use a different name for your new bottle or select an existing bottle." value:@"" table:0x0] retain];
                                    [r20 release];
                                    r22 = [[r19 nameForNewBottle] retain];
                                    r20 = [[NSString stringWithFormat:r21] retain];
                                    [r21 release];
                                    r0 = r22;
                                    [r0 release];
                                    r0 = [r19 attributedErrorStringWithString:r20];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    [r20 release];
                                    [r19 setBottleWarningText:r23];
                                    [r23 release];
                            }
                            else {
                                    r0 = [r19 targetBottle];
                                    r0 = [r0 retain];
                                    if (r0 != 0x0) {
                                            r20 = r0;
                                            r0 = [r19 targetBottle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r0 = [r0 valueForKey:@"compatible"];
                                            r0 = [r0 retain];
                                            r22 = r0;
                                            r23 = [r0 boolValue];
                                            [r22 release];
                                            [r21 release];
                                            [r20 release];
                                            if (r23 != 0x0) {
                                                    r0 = [r19 targetBottle];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    r20 = [[r0 getCategory] retain];
                                                    [r21 release];
                                                    r21 = [[[CXSetupLib cxSetupClass] bottleCategory:@"RECOMMENDED"] retain];
                                                    r22 = [r20 isEqualToNumber:r21];
                                                    [r21 release];
                                                    r0 = [r19 installConfiguration];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    if ([r0 hasPackage] != 0x0) {
                                                            if (([r19 creatingNewBottle] & 0x1) != 0x0) {
                                                                    r23 = 0x0;
                                                                    [r21 release];
                                                            }
                                                            else {
                                                                    [r21 release];
                                                                    if ((r22 & 0x1) != 0x0) {
                                                                            r23 = 0x0;
                                                                    }
                                                                    else {
                                                                            r0 = [r19 targetBottle];
                                                                            r0 = [r0 retain];
                                                                            r22 = r0;
                                                                            r21 = [[r0 valueForKey:@"bottlename"] retain];
                                                                            [r22 release];
                                                                            r0 = [r19 bottleCollection];
                                                                            r0 = [r0 retain];
                                                                            r23 = r0;
                                                                            r22 = [[r0 bottleWithName:r21] retain];
                                                                            [r23 release];
                                                                            r25 = [[r22 installedPackages] retain];
                                                                            r24 = [[NSMutableDictionary dictionaryWithDictionary:r25] retain];
                                                                            [r25 release];
                                                                            [r24 removeObjectForKey:@"com.codeweavers.c4.cxhtml"];
                                                                            if ([r24 count] != 0x0) {
                                                                                    r0 = [NSBundle mainBundle];
                                                                                    r0 = [r0 retain];
                                                                                    r23 = r0;
                                                                                    r25 = [[r0 localizedStringForKey:@"It is recommended that you install this application into a new bottle in order to avoid possible interference between programs." value:@"" table:0x0] retain];
                                                                                    [r23 release];
                                                                                    r23 = [[r19 stringInSystemFont:r25] retain];
                                                                                    [r25 release];
                                                                            }
                                                                            else {
                                                                                    r23 = 0x0;
                                                                            }
                                                                            [r24 release];
                                                                            [r22 release];
                                                                            [r21 release];
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            r23 = 0x0;
                                                            [r21 release];
                                                    }
                                                    [r20 release];
                                                    [r19 setBottleWarningText:r23];
                                                    [r23 release];
                                            }
                                            else {
                                                    r0 = [r19 targetBottle];
                                                    r0 = [r0 retain];
                                                    r20 = r0;
                                                    [r0 release];
                                                    if (r20 != 0x0) {
                                                            r20 = [r19 creatingNewBottle];
                                                            r0 = [NSBundle mainBundle];
                                                            r0 = [r0 retain];
                                                            r21 = r0;
                                                            if (r20 == 0x0) {
                                                                    r2 = @"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle.";
                                                            }
                                                            else {
                                                                    r2 = @"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle.";
                                                            }
                                                            r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                                                            [r21 release];
                                                            r0 = [r19 attributedWarningStringWithString:r20];
                                                            r0 = [r0 retain];
                                                            r23 = r0;
                                                            [r20 release];
                                                    }
                                                    else {
                                                            r23 = 0x0;
                                                    }
                                                    [r19 setBottleWarningText:r23];
                                                    [r23 release];
                                            }
                                    }
                                    else {
                                            r0 = [r19 targetBottle];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            [r0 release];
                                            if (r20 != 0x0) {
                                                    r20 = [r19 creatingNewBottle];
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    if (r20 == 0x0) {
                                                            r2 = @"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle.";
                                                    }
                                                    else {
                                                            r2 = @"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle.";
                                                    }
                                                    r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                                                    [r21 release];
                                                    r0 = [r19 attributedWarningStringWithString:r20];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    [r20 release];
                                            }
                                            else {
                                                    r23 = 0x0;
                                            }
                                            [r19 setBottleWarningText:r23];
                                            [r23 release];
                                    }
                            }
                    }
                    else {
                            r0 = [r19 targetBottle];
                            r0 = [r0 retain];
                            if (r0 != 0x0) {
                                    r20 = r0;
                                    r0 = [r19 targetBottle];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r0 = [r0 valueForKey:@"compatible"];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    r23 = [r0 boolValue];
                                    [r22 release];
                                    [r21 release];
                                    [r20 release];
                                    if (r23 != 0x0) {
                                            r0 = [r19 targetBottle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r20 = [[r0 getCategory] retain];
                                            [r21 release];
                                            r21 = [[[CXSetupLib cxSetupClass] bottleCategory:@"RECOMMENDED"] retain];
                                            r22 = [r20 isEqualToNumber:r21];
                                            [r21 release];
                                            r0 = [r19 installConfiguration];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            if ([r0 hasPackage] != 0x0) {
                                                    if (([r19 creatingNewBottle] & 0x1) != 0x0) {
                                                            r23 = 0x0;
                                                            [r21 release];
                                                    }
                                                    else {
                                                            [r21 release];
                                                            if ((r22 & 0x1) != 0x0) {
                                                                    r23 = 0x0;
                                                            }
                                                            else {
                                                                    r0 = [r19 targetBottle];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    r21 = [[r0 valueForKey:@"bottlename"] retain];
                                                                    [r22 release];
                                                                    r0 = [r19 bottleCollection];
                                                                    r0 = [r0 retain];
                                                                    r23 = r0;
                                                                    r22 = [[r0 bottleWithName:r21] retain];
                                                                    [r23 release];
                                                                    r25 = [[r22 installedPackages] retain];
                                                                    r24 = [[NSMutableDictionary dictionaryWithDictionary:r25] retain];
                                                                    [r25 release];
                                                                    [r24 removeObjectForKey:@"com.codeweavers.c4.cxhtml"];
                                                                    if ([r24 count] != 0x0) {
                                                                            r0 = [NSBundle mainBundle];
                                                                            r0 = [r0 retain];
                                                                            r23 = r0;
                                                                            r25 = [[r0 localizedStringForKey:@"It is recommended that you install this application into a new bottle in order to avoid possible interference between programs." value:@"" table:0x0] retain];
                                                                            [r23 release];
                                                                            r23 = [[r19 stringInSystemFont:r25] retain];
                                                                            [r25 release];
                                                                    }
                                                                    else {
                                                                            r23 = 0x0;
                                                                    }
                                                                    [r24 release];
                                                                    [r22 release];
                                                                    [r21 release];
                                                            }
                                                    }
                                            }
                                            else {
                                                    r23 = 0x0;
                                                    [r21 release];
                                            }
                                            [r20 release];
                                            [r19 setBottleWarningText:r23];
                                            [r23 release];
                                    }
                                    else {
                                            r0 = [r19 targetBottle];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            [r0 release];
                                            if (r20 != 0x0) {
                                                    r20 = [r19 creatingNewBottle];
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    if (r20 == 0x0) {
                                                            r2 = @"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle.";
                                                    }
                                                    else {
                                                            r2 = @"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle.";
                                                    }
                                                    r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                                                    [r21 release];
                                                    r0 = [r19 attributedWarningStringWithString:r20];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    [r20 release];
                                            }
                                            else {
                                                    r23 = 0x0;
                                            }
                                            [r19 setBottleWarningText:r23];
                                            [r23 release];
                                    }
                            }
                            else {
                                    r0 = [r19 targetBottle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    [r0 release];
                                    if (r20 != 0x0) {
                                            r20 = [r19 creatingNewBottle];
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            if (r20 == 0x0) {
                                                    r2 = @"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle.";
                                            }
                                            else {
                                                    r2 = @"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle.";
                                            }
                                            r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                                            [r21 release];
                                            r0 = [r19 attributedWarningStringWithString:r20];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            [r20 release];
                                    }
                                    else {
                                            r23 = 0x0;
                                    }
                                    [r19 setBottleWarningText:r23];
                                    [r23 release];
                            }
                    }
            }
            else {
                    r0 = [r19 nameForNewBottle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r22 = [r0 length];
                    [r20 release];
                    r21 = [[NSBundle mainBundle] retain];
                    if (r22 != 0x0) {
                            r22 = [[r21 localizedStringForKey:@"You can't name a new bottle '%@'. You must use a different name for your new bottle or select an existing bottle." value:@"" table:0x0] retain];
                            [r21 release];
                            r21 = [[r19 nameForNewBottle] retain];
                            r20 = [[NSString stringWithFormat:r22] retain];
                            [r22 release];
                    }
                    else {
                            r20 = [[r21 localizedStringForKey:@"You must enter a name for the new bottle." value:@"" table:0x0] retain];
                    }
                    r0 = r21;
                    [r0 release];
                    r0 = [r19 attributedErrorStringWithString:r20];
                    r0 = [r0 retain];
                    r23 = r0;
                    [r20 release];
                    [r19 setBottleWarningText:r23];
                    [r23 release];
            }
    }
    else {
            if ([r19 creatingNewBottle] != 0x0) {
                    r20 = [[r19 bottleCollection] retain];
                    r21 = [[r19 nameForNewBottle] retain];
                    r0 = [r20 bottleWithName:r21];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 release];
                    [r21 release];
                    [r20 release];
                    if (r22 != 0x0) {
                            r0 = [NSBundle mainBundle];
                            r0 = [r0 retain];
                            r20 = r0;
                            r21 = [[r0 localizedStringForKey:@"You can't name a new bottle '%@'. There is already a bottle by that name. You must use a different name for your new bottle or select an existing bottle." value:@"" table:0x0] retain];
                            [r20 release];
                            r22 = [[r19 nameForNewBottle] retain];
                            r20 = [[NSString stringWithFormat:r21] retain];
                            [r21 release];
                            r0 = r22;
                            [r0 release];
                            r0 = [r19 attributedErrorStringWithString:r20];
                            r0 = [r0 retain];
                            r23 = r0;
                            [r20 release];
                            [r19 setBottleWarningText:r23];
                            [r23 release];
                    }
                    else {
                            r0 = [r19 targetBottle];
                            r0 = [r0 retain];
                            if (r0 != 0x0) {
                                    r20 = r0;
                                    r0 = [r19 targetBottle];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r0 = [r0 valueForKey:@"compatible"];
                                    r0 = [r0 retain];
                                    r22 = r0;
                                    r23 = [r0 boolValue];
                                    [r22 release];
                                    [r21 release];
                                    [r20 release];
                                    if (r23 != 0x0) {
                                            r0 = [r19 targetBottle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            r20 = [[r0 getCategory] retain];
                                            [r21 release];
                                            r21 = [[[CXSetupLib cxSetupClass] bottleCategory:@"RECOMMENDED"] retain];
                                            r22 = [r20 isEqualToNumber:r21];
                                            [r21 release];
                                            r0 = [r19 installConfiguration];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            if ([r0 hasPackage] != 0x0) {
                                                    if (([r19 creatingNewBottle] & 0x1) != 0x0) {
                                                            r23 = 0x0;
                                                            [r21 release];
                                                    }
                                                    else {
                                                            [r21 release];
                                                            if ((r22 & 0x1) != 0x0) {
                                                                    r23 = 0x0;
                                                            }
                                                            else {
                                                                    r0 = [r19 targetBottle];
                                                                    r0 = [r0 retain];
                                                                    r22 = r0;
                                                                    r21 = [[r0 valueForKey:@"bottlename"] retain];
                                                                    [r22 release];
                                                                    r0 = [r19 bottleCollection];
                                                                    r0 = [r0 retain];
                                                                    r23 = r0;
                                                                    r22 = [[r0 bottleWithName:r21] retain];
                                                                    [r23 release];
                                                                    r25 = [[r22 installedPackages] retain];
                                                                    r24 = [[NSMutableDictionary dictionaryWithDictionary:r25] retain];
                                                                    [r25 release];
                                                                    [r24 removeObjectForKey:@"com.codeweavers.c4.cxhtml"];
                                                                    if ([r24 count] != 0x0) {
                                                                            r0 = [NSBundle mainBundle];
                                                                            r0 = [r0 retain];
                                                                            r23 = r0;
                                                                            r25 = [[r0 localizedStringForKey:@"It is recommended that you install this application into a new bottle in order to avoid possible interference between programs." value:@"" table:0x0] retain];
                                                                            [r23 release];
                                                                            r23 = [[r19 stringInSystemFont:r25] retain];
                                                                            [r25 release];
                                                                    }
                                                                    else {
                                                                            r23 = 0x0;
                                                                    }
                                                                    [r24 release];
                                                                    [r22 release];
                                                                    [r21 release];
                                                            }
                                                    }
                                            }
                                            else {
                                                    r23 = 0x0;
                                                    [r21 release];
                                            }
                                            [r20 release];
                                            [r19 setBottleWarningText:r23];
                                            [r23 release];
                                    }
                                    else {
                                            r0 = [r19 targetBottle];
                                            r0 = [r0 retain];
                                            r20 = r0;
                                            [r0 release];
                                            if (r20 != 0x0) {
                                                    r20 = [r19 creatingNewBottle];
                                                    r0 = [NSBundle mainBundle];
                                                    r0 = [r0 retain];
                                                    r21 = r0;
                                                    if (r20 == 0x0) {
                                                            r2 = @"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle.";
                                                    }
                                                    else {
                                                            r2 = @"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle.";
                                                    }
                                                    r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                                                    [r21 release];
                                                    r0 = [r19 attributedWarningStringWithString:r20];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    [r20 release];
                                            }
                                            else {
                                                    r23 = 0x0;
                                            }
                                            [r19 setBottleWarningText:r23];
                                            [r23 release];
                                    }
                            }
                            else {
                                    r0 = [r19 targetBottle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    [r0 release];
                                    if (r20 != 0x0) {
                                            r20 = [r19 creatingNewBottle];
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            if (r20 == 0x0) {
                                                    r2 = @"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle.";
                                            }
                                            else {
                                                    r2 = @"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle.";
                                            }
                                            r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                                            [r21 release];
                                            r0 = [r19 attributedWarningStringWithString:r20];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            [r20 release];
                                    }
                                    else {
                                            r23 = 0x0;
                                    }
                                    [r19 setBottleWarningText:r23];
                                    [r23 release];
                            }
                    }
            }
            else {
                    r0 = [r19 targetBottle];
                    r0 = [r0 retain];
                    if (r0 != 0x0) {
                            r20 = r0;
                            r0 = [r19 targetBottle];
                            r0 = [r0 retain];
                            r21 = r0;
                            r0 = [r0 valueForKey:@"compatible"];
                            r0 = [r0 retain];
                            r22 = r0;
                            r23 = [r0 boolValue];
                            [r22 release];
                            [r21 release];
                            [r20 release];
                            if (r23 != 0x0) {
                                    r0 = [r19 targetBottle];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    r20 = [[r0 getCategory] retain];
                                    [r21 release];
                                    r21 = [[[CXSetupLib cxSetupClass] bottleCategory:@"RECOMMENDED"] retain];
                                    r22 = [r20 isEqualToNumber:r21];
                                    [r21 release];
                                    r0 = [r19 installConfiguration];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    if ([r0 hasPackage] != 0x0) {
                                            if (([r19 creatingNewBottle] & 0x1) != 0x0) {
                                                    r23 = 0x0;
                                                    [r21 release];
                                            }
                                            else {
                                                    [r21 release];
                                                    if ((r22 & 0x1) != 0x0) {
                                                            r23 = 0x0;
                                                    }
                                                    else {
                                                            r0 = [r19 targetBottle];
                                                            r0 = [r0 retain];
                                                            r22 = r0;
                                                            r21 = [[r0 valueForKey:@"bottlename"] retain];
                                                            [r22 release];
                                                            r0 = [r19 bottleCollection];
                                                            r0 = [r0 retain];
                                                            r23 = r0;
                                                            r22 = [[r0 bottleWithName:r21] retain];
                                                            [r23 release];
                                                            r25 = [[r22 installedPackages] retain];
                                                            r24 = [[NSMutableDictionary dictionaryWithDictionary:r25] retain];
                                                            [r25 release];
                                                            [r24 removeObjectForKey:@"com.codeweavers.c4.cxhtml"];
                                                            if ([r24 count] != 0x0) {
                                                                    r0 = [NSBundle mainBundle];
                                                                    r0 = [r0 retain];
                                                                    r23 = r0;
                                                                    r25 = [[r0 localizedStringForKey:@"It is recommended that you install this application into a new bottle in order to avoid possible interference between programs." value:@"" table:0x0] retain];
                                                                    [r23 release];
                                                                    r23 = [[r19 stringInSystemFont:r25] retain];
                                                                    [r25 release];
                                                            }
                                                            else {
                                                                    r23 = 0x0;
                                                            }
                                                            [r24 release];
                                                            [r22 release];
                                                            [r21 release];
                                                    }
                                            }
                                    }
                                    else {
                                            r23 = 0x0;
                                            [r21 release];
                                    }
                                    [r20 release];
                                    [r19 setBottleWarningText:r23];
                                    [r23 release];
                            }
                            else {
                                    r0 = [r19 targetBottle];
                                    r0 = [r0 retain];
                                    r20 = r0;
                                    [r0 release];
                                    if (r20 != 0x0) {
                                            r20 = [r19 creatingNewBottle];
                                            r0 = [NSBundle mainBundle];
                                            r0 = [r0 retain];
                                            r21 = r0;
                                            if (r20 == 0x0) {
                                                    r2 = @"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle.";
                                            }
                                            else {
                                                    r2 = @"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle.";
                                            }
                                            r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                                            [r21 release];
                                            r0 = [r19 attributedWarningStringWithString:r20];
                                            r0 = [r0 retain];
                                            r23 = r0;
                                            [r20 release];
                                    }
                                    else {
                                            r23 = 0x0;
                                    }
                                    [r19 setBottleWarningText:r23];
                                    [r23 release];
                            }
                    }
                    else {
                            r0 = [r19 targetBottle];
                            r0 = [r0 retain];
                            r20 = r0;
                            [r0 release];
                            if (r20 != 0x0) {
                                    r20 = [r19 creatingNewBottle];
                                    r0 = [NSBundle mainBundle];
                                    r0 = [r0 retain];
                                    r21 = r0;
                                    if (r20 == 0x0) {
                                            r2 = @"You have selected a bottle which is incompatible with this application. It is strongly recommended to install in a new or compatible bottle.";
                                    }
                                    else {
                                            r2 = @"You have chosen to create a new bottle of a type which is incompatible with this application. It is strongly recommended to install in a compatible bottle.";
                                    }
                                    r20 = [[r0 localizedStringForKey:r2 value:@"" table:0x0] retain];
                                    [r21 release];
                                    r0 = [r19 attributedWarningStringWithString:r20];
                                    r0 = [r0 retain];
                                    r23 = r0;
                                    [r20 release];
                            }
                            else {
                                    r23 = 0x0;
                            }
                            [r19 setBottleWarningText:r23];
                            [r23 release];
                    }
            }
    }
    return;


// 0x10002bed8
// -[SelectBottleSheetController addMenuItemsFromCategories:isBottles:]
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
    r31 = r31 + 0xffffffffffffffa0 - 0x200;
    r19 = arg3;
    r21 = _cmd;
    r20 = self;
    var_60 = **___stack_chk_guard;
    var_228 = [arg2 retain];
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r22 = r0;
            [r0 handleFailureInMethod:r21 object:r20 file:@"SelectBottleSheetController.m" lineNumber:0xe6 description:@"Main thread method or function called on non-main thread"];
            [r22 release];
    }
    if (*_addMenuItemsFromCategories:isBottles:.onceToken != -0x1) {
            dispatch_once(_addMenuItemsFromCategories:isBottles:.onceToken, ___block_literal_global);
    }
    r8 = _addMenuItemsFromCategories:isBottles:.bottleCategoryDisplayNames;
    if (r19 == 0x0) {
            r8 = _addMenuItemsFromCategories:isBottles:.templateCategoryDisplayNames;
    }
    var_238 = [*r8 retain];
    r0 = r20;
    if ((r19 & 0x1) != 0x0) {
            r0 = [r0 bottleListPopUpButton];
            r0 = [r0 retain];
    }
    else {
            r0 = [r0 templateTypesPopUpButton];
            r0 = [r0 retain];
    }
    var_248 = r0;
    var_1E8 = [[r0 menu] retain];
    r8 = &@selector(bottleItemSelected:);
    if (r19 == 0x0) {
            r8 = &@selector(templateItemSelected:);
    }
    r24 = *r8;
    var_1A0 = q0;
    var_190 = q0;
    r0 = *_addMenuItemsFromCategories:isBottles:.orderedCategoryNumbers;
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
    var_220 = r0;
    if (r0 != 0x0) {
            var_1F8 = 0x0;
            var_230 = *var_190;
            var_240 = r21;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_190 != var_230) {
                                    objc_enumerationMutation(r21);
                            }
                            r19 = *(var_198 + r22 * 0x8);
                            r0 = [var_228 objectForKeyedSubscript:r19];
                            r0 = [r0 retain];
                            r23 = r0;
                            if ([r0 count] != 0x0) {
                                    var_200 = r22;
                                    r0 = [var_238 objectForKeyedSubscript:r19];
                                    r0 = [r0 retain];
                                    var_210 = r0;
                                    r0 = [var_1E8 addItemWithTitle:r0 action:0x0 keyEquivalent:@""];
                                    r0 = [r0 retain];
                                    var_218 = r0;
                                    [r0 setEnabled:0x0];
                                    var_1E0 = q0;
                                    var_1D0 = q0;
                                    var_208 = r23;
                                    r0 = [r23 retain];
                                    var_1F0 = r0;
                                    r0 = [r0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
                                    if (r0 != 0x0) {
                                            r27 = r0;
                                            r23 = *var_1D0;
                                            do {
                                                    r19 = 0x0;
                                                    do {
                                                            if (*var_1D0 != r23) {
                                                                    objc_enumerationMutation(var_1F0);
                                                            }
                                                            r28 = *(var_1D8 + r19 * 0x8);
                                                            r25 = [[r28 objectForKeyedSubscript:@"displayname"] retain];
                                                            r26 = [[var_1E8 addItemWithTitle:r25 action:r24 keyEquivalent:@""] retain];
                                                            r28 = [[r28 objectForKeyedSubscript:@"targetBottle"] retain];
                                                            [r26 setRepresentedObject:r28];
                                                            [r28 release];
                                                            [r26 setIndentationLevel:0x1];
                                                            [r26 setTarget:r20];
                                                            r0 = [r20 targetBottle];
                                                            r0 = [r0 retain];
                                                            if (r0 != 0x0) {
                                                                    r28 = r0;
                                                                    r22 = [[r26 representedObject] retain];
                                                                    r0 = [r20 targetBottle];
                                                                    r0 = [r0 retain];
                                                                    r21 = r0;
                                                                    [r0 release];
                                                                    [r22 release];
                                                                    [r28 release];
                                                                    if (r22 == r21) {
                                                                            r21 = [r26 retain];
                                                                            [var_1F8 release];
                                                                            var_1F8 = r21;
                                                                    }
                                                            }
                                                            [r26 release];
                                                            [r25 release];
                                                            r19 = r19 + 0x1;
                                                    } while (r27 != r19);
                                                    r0 = [var_1F0 countByEnumeratingWithState:&var_1E0 objects:&decomp_var_160 count:0x10];
                                                    r27 = r0;
                                            } while (r0 != 0x0);
                                    }
                                    [var_1F0 release];
                                    [var_218 release];
                                    [var_210 release];
                                    r21 = var_240;
                                    r23 = var_208;
                                    r22 = var_200;
                            }
                            [r23 release];
                            r22 = r22 + 0x1;
                    } while (r22 != var_220);
                    r0 = [r21 countByEnumeratingWithState:&var_1A0 objects:&decomp_var_e0 count:0x10];
                    var_220 = r0;
            } while (r0 != 0x0);
            [r21 release];
            r19 = var_248;
            r21 = var_1F8;
            if (r21 != 0x0) {
                    [r19 selectItem:r21];
                    [r21 release];
            }
    }
    else {
            r19 = var_248;
            [r21 release];
    }
    [var_1E8 release];
    [r19 release];
    [var_238 release];
    [var_228 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10002c8dc
// -[SelectBottleSheetController bottleItemSelected:]
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
    r19 = self;
    var_58 = **___stack_chk_guard;
    r20 = [arg2 retain];
    r0 = [r19 makeNewBottleMenuItem];
    r0 = [r0 retain];
    r21 = r0;
    [r0 release];
    if (r21 == r20) {
            r0 = [r19 templateTypesPopUpButton];
            r0 = [r0 retain];
            r21 = r0;
            r0 = [r0 selectedItem];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [r0 isEnabled];
            [r22 release];
            [r21 release];
            if ((r23 & 0x1) == 0x0) {
                    r0 = [r19 installConfiguration];
                    r0 = [r0 retain];
                    r22 = r0;
                    r21 = [[r0 recommendedTemplate] retain];
                    [r22 release];
                    var_120 = q0;
                    var_110 = q0;
                    r0 = [r19 templateTypesPopUpButton];
                    r0 = [r0 retain];
                    r23 = r0;
                    r0 = [r0 menu];
                    r0 = [r0 retain];
                    r24 = r0;
                    r22 = [[r0 itemArray] retain];
                    [r24 release];
                    [r23 release];
                    r0 = [r22 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
                    if (r0 != 0x0) {
                            r23 = r0;
                            r26 = *var_110;
                            while (true) {
                                    r27 = 0x0;
                                    while (true) {
                                            if (*var_110 != r26) {
                                                    objc_enumerationMutation(r22);
                                            }
                                            r24 = *(var_118 + r27 * 0x8);
                                            r0 = [r24 representedObject];
                                            r0 = [r0 retain];
                                            r25 = r0;
                                            [r0 release];
                                            if (r25 == r21) {
                                                    r0 = [r19 templateTypesPopUpButton];
                                                    r0 = [r0 retain];
                                                    r23 = r0;
                                                    [r0 selectItem:r24];
                                                    [r23 release];
                                                    temp_0 = 0x1;
                                                    break;
                                            }
                                            r27 = r27 + 0x1;
                                            if (r23 != r27) {
                                                    continue;
                                            }
                                            temp_0 = 0x0;
                                            break;
                                    }
                                    if (temp_0 == 0x0) {
                                            r0 = [r22 countByEnumeratingWithState:&var_120 objects:&decomp_var_d8 count:0x10];
                                            r23 = r0;
                                            if (r0 != 0x0) {
                                                    continue;
                                            }
                                            temp_1 = 0x0;
                                            break;
                                    }
                                    temp_1 = 0x1;
                                    break;
                            }
                    }
                    [r22 release];
                    [r21 release];
            }
    }
    [r19 updateInstallTaskWithBottleSelection];
    [r20 release];
    if (**___stack_chk_guard != var_58) {
            __stack_chk_fail();
    }
    return;


// 0x10002cb0c
// -[SelectBottleSheetController templateItemSelected:]
    [self updateInstallTaskWithBottleSelection];
    return;


// 0x10002cb10
// -[SelectBottleSheetController updateBottlesList]
    r31 = r31 - 0x180;
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
    r20 = _cmd;
    r19 = self;
    var_60 = **___stack_chk_guard;
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r21 = r0;
            [r0 handleFailureInMethod:r20 object:r19 file:@"SelectBottleSheetController.m" lineNumber:0x14d description:@"Main thread method or function called on non-main thread"];
            [r21 release];
    }
    r20 = [[NSMutableDictionary alloc] initWithCapacity:0x4];
    var_168 = r19;
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r22 = r0;
    r19 = [[r0 bottles] retain];
    [r22 release];
    var_158 = r19;
    r0 = [r19 allKeys];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 sortedArrayUsingSelector:@selector(localizedStandardCompare:)] retain];
    [r22 release];
    var_150 = q0;
    var_140 = q0;
    r0 = [r23 retain];
    var_160 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r23 = r0;
            r28 = *var_140;
            do {
                    r22 = 0x0;
                    do {
                            if (*var_140 != r28) {
                                    objc_enumerationMutation(var_160);
                            }
                            r26 = *(var_148 + r22 * 0x8);
                            r0 = [var_158 objectForKey:r26];
                            r0 = [r0 retain];
                            r24 = r0;
                            r25 = [[r0 getCategory] retain];
                            r0 = [r20 objectForKey:r25];
                            r0 = [r0 retain];
                            r27 = r0;
                            if (r0 == 0x0) {
                                    r27 = [[NSMutableArray alloc] init];
                                    [r20 setObject:r27 forKey:r25];
                            }
                            var_110 = @"displayname";
                            var_F8 = r26;
                            r0 = [NSDictionary dictionaryWithObjects:&var_F8 forKeys:&var_110 count:0x3];
                            r26 = [r0 retain];
                            [r27 addObject:r26];
                            [r26 release];
                            [r27 release];
                            [r25 release];
                            [r24 release];
                            r22 = r22 + 0x1;
                    } while (r23 != r22);
                    r0 = [var_160 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                    r23 = r0;
            } while (r0 != 0x0);
    }
    [var_160 release];
    r19 = var_168;
    [r19 setCategorizedBottles:r20];
    r0 = [r19 bottleListPopUpButton];
    r0 = [r0 retain];
    r24 = r0;
    r23 = [[r0 menu] retain];
    [r24 release];
    if ([r23 numberOfItems] >= 0x3) {
            [r23 removeItemAtIndex:[r23 numberOfItems] - 0x1];
            if ([r23 numberOfItems] > 0x2) {
                    continue;
            }
            break;
    }
    [r19 addMenuItemsFromCategories:r20 isBottles:0x1];
    r0 = [r19 targetBottle];
    r0 = [r0 retain];
    r24 = r0;
    [r0 release];
    if (r24 == 0x0) {
            r24 = [[r19 bottleListPopUpButton] retain];
            r19 = [[r19 selectBottlePlaceholderMenuItem] retain];
            [r24 selectItem:r19];
            [r19 release];
            [r24 release];
    }
    [r23 release];
    [var_160 release];
    [var_158 release];
    [r20 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10002cec0
// -[SelectBottleSheetController updateTemplatesList]
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
    r20 = _cmd;
    r19 = self;
    var_60 = **___stack_chk_guard;
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r21 = r0;
            [r0 handleFailureInMethod:r20 object:r19 file:@"SelectBottleSheetController.m" lineNumber:0x176 description:@"Main thread method or function called on non-main thread"];
            [r21 release];
    }
    r20 = [[NSMutableDictionary alloc] initWithCapacity:0x4];
    var_158 = r19;
    r0 = [r19 installConfiguration];
    r0 = [r0 retain];
    r22 = r0;
    r19 = [[r0 templates] retain];
    [r22 release];
    r0 = [NSMutableArray array];
    r0 = [r0 retain];
    var_108 = *__NSConcreteStackBlock;
    r0 = [r0 retain];
    r22 = r0;
    var_E8 = r0;
    var_160 = r19;
    [r19 enumerateKeysAndObjectsUsingBlock:&var_108];
    var_150 = q0;
    var_140 = q0;
    r0 = [r22 retain];
    r22 = r0;
    r0 = [r0 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
    if (r0 != 0x0) {
            r24 = r0;
            r19 = *var_140;
            do {
                    r21 = 0x0;
                    do {
                            if (*var_140 != r19) {
                                    objc_enumerationMutation(r22);
                            }
                            r26 = *(var_148 + r21 * 0x8);
                            r0 = [r26 objectForKey:@"targetBottle"];
                            r0 = [r0 retain];
                            r25 = r0;
                            r27 = [[r0 getCategory] retain];
                            r0 = [r20 objectForKey:r27];
                            r0 = [r0 retain];
                            r28 = r0;
                            if (r0 == 0x0) {
                                    r28 = [[NSMutableArray alloc] init];
                                    [r20 setObject:r28 forKey:r27];
                            }
                            [r28 addObject:r26];
                            [r28 release];
                            [r27 release];
                            [r25 release];
                            r21 = r21 + 0x1;
                    } while (r24 != r21);
                    r0 = [r22 countByEnumeratingWithState:&var_150 objects:&decomp_var_e0 count:0x10];
                    r24 = r0;
            } while (r0 != 0x0);
    }
    [r22 release];
    [var_158 setCategorizedTemplates:r20];
    r0 = [var_158 templateTypesPopUpButton];
    r0 = [r0 retain];
    r23 = r0;
    r0 = [r0 menu];
    r0 = [r0 retain];
    r24 = r0;
    [r0 removeAllItems];
    [r24 release];
    [r23 release];
    [var_158 addMenuItemsFromCategories:r20 isBottles:0x0];
    [var_E8 release];
    [r22 release];
    [var_160 release];
    [r20 release];
    if (**___stack_chk_guard != var_60) {
            __stack_chk_fail();
    }
    return;


// 0x10002d2d8
// -[SelectBottleSheetController updateMenus]
    [self updateBottlesList];
    [self updateTemplatesList];
    return;


// 0x10002d2fc
// -[SelectBottleSheetController updateInstallTaskWithBottleSelection]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = _cmd;
    r19 = self;
    if (([NSThread isMainThread] & 0x1) == 0x0) {
            r0 = [NSAssertionHandler currentHandler];
            r0 = [r0 retain];
            r21 = r0;
            [r0 handleFailureInMethod:r20 object:r19 file:@"SelectBottleSheetController.m" lineNumber:0x1a4 description:@"Main thread method or function called on non-main thread"];
            [r21 release];
    }
    r0 = [r19 bottleListPopUpButton];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 selectedItem] retain];
    r0 = [r19 makeNewBottleMenuItem];
    r0 = [r0 retain];
    r22 = r0;
    [r0 release];
    [r21 release];
    [r20 release];
    r0 = r19;
    if (r21 != r22) {
            r0 = [r0 bottleListPopUpButton];
            r0 = [r0 retain];
    }
    else {
            r0 = [r0 templateTypesPopUpButton];
            r0 = [r0 retain];
    }
    r20 = r0;
    r0 = [r0 selectedItem];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 representedObject] retain];
    [r19 setTargetBottle:r22];
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 updateBottleWarningText];
    return;


// 0x10002d438
// -[SelectBottleSheetController configurationIsValid]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [self targetBottle];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            if ([r20 creatingNewBottle] != 0x0) {
                    r21 = [[r20 installConfiguration] retain];
                    r22 = [[r20 nameForNewBottle] retain];
                    r20 = [r21 isNewBottleNameValid:r22];
                    [r22 release];
                    [r21 release];
            }
            else {
                    r20 = 0x1;
            }
    }
    else {
            r20 = 0x0;
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x10002d4e0
// +[SelectBottleSheetController keyPathsForValuesAffectingConfigurationIsValid]
    r0 = [NSSet setWithObjects:@"targetBottle"];
    return r0;


// 0x10002d524
// -[SelectBottleSheetController done:]
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
    r20 = [[self targetBottle] retain];
    r21 = [r19 isTemplate:r20];
    [r20 release];
    r0 = r19;
    if (r21 != 0x0) {
            r20 = [[r0 installConfiguration] retain];
            r21 = [[r19 nameForNewBottle] retain];
            r0 = [r19 targetBottle];
            r0 = [r0 retain];
            r22 = r0;
            r23 = [[r0 valueForKey:@"template"] retain];
            [r20 createNewBottle:r21 template:r23];
            [r23 release];
            [r22 release];
            [r21 release];
            [r20 release];
    }
    else {
            r0 = [r0 targetBottle];
            r0 = [r0 retain];
            r20 = r0;
            [r0 release];
            if (r20 != 0x0) {
                    r0 = [r19 targetBottle];
                    r0 = [r0 retain];
                    r20 = r0;
                    r21 = [[r0 valueForKey:@"bottlename"] retain];
                    r0 = [r19 installConfiguration];
                    r0 = [r0 retain];
                    r22 = r0;
                    [r0 setBottleName:r21];
                    [r22 release];
                    [r21 release];
                    [r20 release];
            }
    }
    r20 = **_NSApp;
    r19 = [[r19 window] retain];
    [r20 endSheet:r19];
    [r19 release];
    return;


// 0x10002d694
// -[SelectBottleSheetController cancel:]
    r19 = **_NSApp;
    r20 = [[self window] retain];
    [r19 endSheet:r20];
    [r20 release];
    return;


// 0x10002d6d8
// -[SelectBottleSheetController windowWillClose:]
    r20 = [arg2 retain];
    r0 = [self installConfiguration];
    r0 = [r0 retain];
    r21 = r0;
    [r0 removeDelegate:self];
    [r21 release];
    var_30 = self;
    [[&var_30 super] windowWillClose:r20];
    [r20 release];
    return;


// 0x10002d75c
// -[SelectBottleSheetController profileChanged]
    [self updateMenus];
    [self updateBottleWarningText];
    return;


// 0x10002d780
// -[SelectBottleSheetController bottleCreateChanged]
    [self updateMenus];
    [self updateBottleWarningText];
    return;


// 0x10002d7a4
// -[SelectBottleSheetController bottleNewnameChanged]
    [self updateBottleWarningText];
    return;


// 0x10002d7a8
// -[SelectBottleSheetController bottleTemplateChanged]
    [self updateMenus];
    [self updateBottleWarningText];
    return;


// 0x10002d7cc
// -[SelectBottleSheetController bottleNameChanged]
    [self updateMenus];
    [self updateBottleWarningText];
    return;


// 0x10002d7f0
// -[SelectBottleSheetController categorizedAllBottles]
    [self updateMenus];
    return;


// 0x10002d7f4
// -[SelectBottleSheetController analyzedBottle:]
    [self updateMenus];
    return;


// 0x10002d7f8
// -[SelectBottleSheetController installConfiguration]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_installConfiguration)), 0x1);
    return r0;


// 0x10002d808
// -[SelectBottleSheetController bottleCollection]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleCollection);
    r0 = [r0 autorelease];
    return r0;


// 0x10002d828
// -[SelectBottleSheetController categorizedBottles]
    r0 = self->_categorizedBottles;
    return r0;


// 0x10002d838
// -[SelectBottleSheetController setCategorizedBottles:]
    objc_storeStrong((int64_t *)&self->_categorizedBottles, arg2);
    return;


// 0x10002d84c
// -[SelectBottleSheetController categorizedTemplates]
    r0 = self->_categorizedTemplates;
    return r0;


// 0x10002d85c
// -[SelectBottleSheetController setCategorizedTemplates:]
    objc_storeStrong((int64_t *)&self->_categorizedTemplates, arg2);
    return;


// 0x10002d870
// -[SelectBottleSheetController bottleWarningText]
    r0 = self->_bottleWarningText;
    return r0;


// 0x10002d880
// -[SelectBottleSheetController setBottleWarningText:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x10002d88c
// -[SelectBottleSheetController nameForNewBottle]
    r0 = self->_nameForNewBottle;
    return r0;


// 0x10002d89c
// -[SelectBottleSheetController targetBottle]
    r0 = self->_targetBottle;
    return r0;


// 0x10002d8ac
// -[SelectBottleSheetController setTargetBottle:]
    objc_storeStrong((int64_t *)&self->_targetBottle, arg2);
    return;


// 0x10002d8c0
// -[SelectBottleSheetController doneButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_doneButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10002d8e0
// -[SelectBottleSheetController setDoneButton:]
    objc_storeWeak((int64_t *)&self->_doneButton, arg2);
    return;


// 0x10002d8f4
// -[SelectBottleSheetController nameForNewBottleTextField]
    r0 = objc_loadWeakRetained((int64_t *)&self->_nameForNewBottleTextField);
    r0 = [r0 autorelease];
    return r0;


// 0x10002d914
// -[SelectBottleSheetController setNameForNewBottleTextField:]
    objc_storeWeak((int64_t *)&self->_nameForNewBottleTextField, arg2);
    return;


// 0x10002d928
// -[SelectBottleSheetController bottleListPopUpButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_bottleListPopUpButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10002d948
// -[SelectBottleSheetController setBottleListPopUpButton:]
    objc_storeWeak((int64_t *)&self->_bottleListPopUpButton, arg2);
    return;


// 0x10002d95c
// -[SelectBottleSheetController makeNewBottleMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_makeNewBottleMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x10002d97c
// -[SelectBottleSheetController setMakeNewBottleMenuItem:]
    objc_storeWeak((int64_t *)&self->_makeNewBottleMenuItem, arg2);
    return;


// 0x10002d990
// -[SelectBottleSheetController selectBottlePlaceholderMenuItem]
    r0 = objc_loadWeakRetained((int64_t *)&self->_selectBottlePlaceholderMenuItem);
    r0 = [r0 autorelease];
    return r0;


// 0x10002d9b0
// -[SelectBottleSheetController setSelectBottlePlaceholderMenuItem:]
    objc_storeWeak((int64_t *)&self->_selectBottlePlaceholderMenuItem, arg2);
    return;


// 0x10002d9c4
// -[SelectBottleSheetController templateTypesPopUpButton]
    r0 = objc_loadWeakRetained((int64_t *)&self->_templateTypesPopUpButton);
    r0 = [r0 autorelease];
    return r0;


// 0x10002d9e4
// -[SelectBottleSheetController setTemplateTypesPopUpButton:]
    objc_storeWeak((int64_t *)&self->_templateTypesPopUpButton, arg2);
    return;


// 0x10002d9f8
// -[SelectBottleSheetController .cxx_destruct]
    objc_destroyWeak((int64_t *)&self->_templateTypesPopUpButton);
    objc_destroyWeak((int64_t *)&self->_selectBottlePlaceholderMenuItem);
    objc_destroyWeak((int64_t *)&self->_makeNewBottleMenuItem);
    objc_destroyWeak((int64_t *)&self->_bottleListPopUpButton);
    objc_destroyWeak((int64_t *)&self->_nameForNewBottleTextField);
    objc_destroyWeak((int64_t *)&self->_doneButton);
    objc_storeStrong((int64_t *)&self->_targetBottle, 0x0);
    objc_storeStrong((int64_t *)&self->_nameForNewBottle, 0x0);
    objc_storeStrong((int64_t *)&self->_bottleWarningText, 0x0);
    objc_storeStrong((int64_t *)&self->_categorizedTemplates, 0x0);
    objc_storeStrong((int64_t *)&self->_categorizedBottles, 0x0);
    objc_destroyWeak((int64_t *)&self->_bottleCollection);
    objc_storeStrong((int64_t *)&self->_installConfiguration, 0x0);
    return;


