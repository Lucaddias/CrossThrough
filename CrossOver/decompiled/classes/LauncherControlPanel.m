// LauncherControlPanel — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10004122c
// -[LauncherControlPanel initWithControlPanel:bottle:]
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
    r23 = arg2;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [[r19 valueForKey:@"name"] retain];
    var_50 = self;
    r0 = [[&var_50 super] initWithName:r21];
    r22 = r0;
    if (r0 != 0x0) {
            objc_storeStrong((int64_t *)&r22->_controlPanel, r23);
            r0 = [r19 valueForKey:@"icon"];
            r0 = [r0 retain];
            r23 = r0;
            if ([r0 length] != 0x0) {
                    r24 = [[NSImage alloc] initWithContentsOfFile:r23];
            }
            else {
                    r24 = 0x0;
            }
            if (([r24 isValid] & 0x1) == 0x0) {
                    r0 = [NSImage imageNamed:@"exeIcon.icns"];
                    r0 = [r0 retain];
                    r25 = r0;
                    r26 = [r0 copy];
                    [r24 release];
                    [r25 release];
                    r24 = r26;
            }
            [r22 setIcon:r24];
            [r22 setBottle:r20];
            [r24 release];
            [r23 release];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = r22;
    return r0;


// 0x1000413ac
// +[LauncherControlPanel launcherWithControlPanel:bottle:]
    r21 = [arg3 retain];
    r19 = [arg2 retain];
    r20 = [[self alloc] initWithControlPanel:r19 bottle:r21];
    [r21 release];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100041418
// -[LauncherControlPanel copyWithZone:]
    var_20 = self;
    r0 = [[&var_20 super] copyWithZone:arg2];
    r20 = r0;
    r8 = sign_extend_64(*(int32_t *)ivar_offset(_controlPanel));
    objc_storeStrong(r0 + r8, *(self + r8));
    r0 = r20;
    return r0;


// 0x100041474
// -[LauncherControlPanel tooltip]
    r0 = self->_controlPanel;
    r0 = [r0 valueForKey:@"description"];
    return r0;


// 0x10004148c
// -[LauncherControlPanel launchWithErrorHandler:]
    r31 = r31 - 0xa0;
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
    r0 = [r20 bottle];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [r0 isCanRunCommands];
    [r21 release];
    if ((r22 & 0x1) != 0x0) {
            r0 = dispatch_get_global_queue(0x2, 0x0);
            r0 = [r0 retain];
            r21 = r0;
            var_80 = *__NSConcreteStackBlock;
            dispatch_async(r0, &var_80);
            r0 = r21;
            [r0 release];
    }
    else {
            if (r19 != 0x0) {
                    r0 = [NSBundle mainBundle];
                    r0 = [r0 retain];
                    r21 = r0;
                    r22 = [[r0 localizedStringForKey:@"The control panel '%1$@' can't be launched because the bottle '%2$@' is unable to run commands at this time." value:@"" table:0x0] retain];
                    [r21 release];
                    r23 = [[r20 name] retain];
                    r0 = [r20 bottle];
                    r0 = [r0 retain];
                    r24 = r0;
                    r25 = [[r0 name] retain];
                    r20 = [[NSString stringWithFormat:r22] retain];
                    [r22 release];
                    [r25 release];
                    [r24 release];
                    [r23 release];
                    var_58 = **_NSLocalizedDescriptionKey;
                    decomp_var_50 = r20;
                    r0 = [NSDictionary dictionaryWithObjects:&decomp_var_50 forKeys:&var_58 count:0x1];
                    r22 = [r0 retain];
                    r21 = [[NSError errorWithDomain:@"com.codeweavers.CrossOver.LauncherItem" code:0x1 userInfo:r22] retain];
                    [r22 release];
                    (r19[0x2])(r19, r21);
                    [r21 release];
                    r0 = r20;
                    [r0 release];
            }
    }
    [r19 release];
    if (**___stack_chk_guard != var_48) {
            __stack_chk_fail();
    }
    return;


// 0x100041744
// -[LauncherControlPanel description]
    var_30 = self;
    r0 = [[&var_30 super] description];
    r21 = [r0 retain];
    r19 = [[NSString stringWithFormat:@"%@ control panel %@", r3, r4] retain];
    [r21 release];
    r0 = [r19 autorelease];
    return r0;


// 0x1000417d8
// -[LauncherControlPanel .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_controlPanel, 0x0);
    return;


