// LauncherApp — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100040cb4
// -[LauncherApp initWithURL:]
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
    r22 = self;
    r0 = [arg2 retain];
    r19 = r0;
    r0 = [r0 lastPathComponent];
    r0 = [r0 retain];
    r21 = r0;
    r20 = [[r0 stringByDeletingPathExtension] retain];
    [r21 release];
    r0 = [CXBundle bundleWithURL:r19];
    r0 = [r0 retain];
    r21 = r0;
    if (r0 != 0x0) {
            r0 = [r21 objectForInfoDictionaryKey:**_kCFBundleNameKey];
            r0 = [r0 retain];
            r23 = r0;
            if ([r0 isEqualToString:r20] != 0x0) {
                    r0 = [r21 objectForInfoDictionaryKey:@"CXOriginalMenuName"];
                    r0 = [r0 retain];
                    r24 = r0;
                    if (r0 != 0x0) {
                            r25 = [r24 retain];
                            [r20 release];
                            r20 = r25;
                    }
                    [r24 release];
            }
            [r23 release];
    }
    var_50 = r22;
    r0 = [[&var_50 super] initWithName:r20];
    r22 = r0;
    if (r0 != 0x0) {
            r0 = [r19 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_url));
            r8 = *(r22 + r9);
            *(r22 + r9) = r0;
            [r8 release];
            r0 = [r21 objectForInfoDictionaryKey:**_kCFBundleIdentifierKey];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 copy];
            r9 = sign_extend_64(*(int32_t *)ivar_offset(_bundleID));
            r8 = *(r22 + r9);
            *(r22 + r9) = r0;
            [r8 release];
            [r23 release];
            r23 = [[r21 icon] retain];
            [r22 setIcon:r23];
            [r23 release];
            [r22 setHelperVersion:[r21 helperVersion]];
            if (r21 != 0x0) {
                    r23 = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
                    r24 = [[r21 objectForInfoDictionaryKey:@"CXHelperAppBottleName"] retain];
                    r25 = [[r23 bottleWithName:r24] retain];
                    [r22 setBottle:r25];
                    [r25 release];
                    [r24 release];
                    [r23 release];
            }
    }
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = r22;
    return r0;


// 0x100040f14
// +[LauncherApp launcherWithURL:]
    r20 = [arg2 retain];
    r19 = [[self alloc] initWithURL:r20];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100040f5c
// -[LauncherApp copyWithZone:]
    var_20 = self;
    r0 = [[&var_20 super] copyWithZone:arg2];
    r20 = r0;
    [r0 setUrl:self->_url];
    [r20 setBundleID:self->_bundleID];
    r0 = r20;
    return r0;


// 0x100040fc8
// -[LauncherApp launchWithErrorHandler:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r22 = [[NSWorkspace sharedWorkspace] retain];
    r23 = [[self url] retain];
    var_38 = 0x0;
    r0 = [r22 openURL:r23 options:0x10000 configuration:**___NSDictionary0__ error:&var_38];
    r20 = [r0 retain];
    r21 = [var_38 retain];
    [r23 release];
    [r22 release];
    if (r20 != 0x0) {
            if (___isPlatformVersionAtLeast(0x1, 0xe, 0x0, 0x0) != 0x0) {
                    NSLog(@"yielding activation to launcher %@", 0xe);
                    [**_NSApp yieldActivationToApplication:r20];
            }
    }
    else {
            if (r19 != 0x0) {
                    (r19[0x2])(r19, r21);
            }
    }
    [r20 release];
    [r21 release];
    [r19 release];
    return;


// 0x1000410f0
// -[LauncherApp description]
    var_30 = self;
    r0 = [[&var_30 super] description];
    r21 = [r0 retain];
    r19 = [[self url] retain];
    r20 = [[NSString stringWithFormat:@"%@ url %@", r3, r4] retain];
    [r19 release];
    [r21 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100041194
// -[LauncherApp url]
    r0 = self->_url;
    return r0;


// 0x1000411a4
// -[LauncherApp setUrl:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000411b0
// -[LauncherApp bundleID]
    r0 = self->_bundleID;
    return r0;


// 0x1000411c0
// -[LauncherApp setBundleID:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x1000411cc
// -[LauncherApp helperVersion]
    r0 = self->_helperVersion;
    return r0;


// 0x1000411dc
// -[LauncherApp setHelperVersion:]
    self->_helperVersion = arg2;
    return;


// 0x1000411ec
// -[LauncherApp .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_bundleID, 0x0);
    objc_storeStrong((int64_t *)&self->_url, 0x0);
    return;


