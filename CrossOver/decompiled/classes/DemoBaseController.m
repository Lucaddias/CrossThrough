// DemoBaseController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100053ea8
// -[DemoBaseController initWithWindowNibName:]
    r31 = r31 - 0x50;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_30 = self;
    r0 = [[&var_30 super] initWithWindowNibName:arg2];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [NSApplication sharedApplication];
            r0 = [r0 retain];
            r20 = r0;
            r21 = [r0 daysLeft];
            [r20 release];
            if (r21 > 0x0) {
                    r22 = [[NSBundle mainBundle] retain];
                    if (r21 == 0x1) {
                            r20 = [[r22 localizedStringForKey:@"This is a time limited trial version of %@. It will stop working in 1 day." value:@"" table:0x0] retain];
                            [r22 release];
                    }
                    else {
                            r20 = [[r22 localizedStringForKey:@"This is a time limited trial version of %1$@. It will stop working in %2$d days." value:@"" table:0x0] retain];
                            [r22 release];
                    }
            }
            else {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r21 = r0;
                    r20 = [[r0 localizedStringForKey:@"This trial version of %1$@ has expired." value:@"" table:0x0] retain];
                    [r21 release];
            }
            r21 = [[NSString stringWithFormat:r20] retain];
            [r20 release];
            r0 = [r21 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_expirationText));
            r8 = *(r19 + r9);
            *(r19 + r9) = r0;
            [r8 release];
            [r21 release];
    }
    r0 = r19;
    return r0;


// 0x100054074
// -[DemoBaseController expirationText]
    r0 = self->_expirationText;
    return r0;


// 0x100054084
// -[DemoBaseController setExpirationText:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100054090
// -[DemoBaseController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_expirationText, 0x0);
    return;


