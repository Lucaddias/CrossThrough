// CXBundle — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10002ac20
// -[CXBundle initWithURL:]
    r31 = r31 - 0x70;
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
    r19 = [arg2 retain];
    var_50 = self;
    r0 = [[&var_50 super] init];
    r20 = r0;
    if (r0 != 0x0) {
            [r20 setUrl:r19];
            r21 = [[NSFileManager defaultManager] retain];
            r0 = [r19 URLByAppendingPathComponent:@"Contents" isDirectory:0x1];
            r0 = [r0 retain];
            r22 = r0;
            r0 = [r0 URLByAppendingPathComponent:@"Info.plist" isDirectory:0x0];
            r0 = [r0 retain];
            r23 = r0;
            r24 = [[r0 path] retain];
            [r21 fileExistsAtPath:r24 isDirectory:&var_51];
            asm { ccmp       w8, #0x0, #0x0, ne };
            if (!asm { ccmp       w8, #0x0, #0x0, ne }) {
                    [r24 release];
            }
            else {
                    r25 = [[r23 path] retain];
                    r26 = [r21 isReadableFileAtPath:r25];
                    [r25 release];
                    [r24 release];
                    if (r26 != 0x0) {
                            if (*__CFBundleFlushCachesForURL != 0x0) {
                                    _CFBundleFlushCachesForURL();
                            }
                            [r20 setCfBundle:CFBundleCreate(0x0, r19)];
                            if ([r20 cfBundle] != 0x0) {
                                    if (*__CFBundleFlushBundleCaches != 0x0) {
                                            [r20 cfBundle];
                                            _CFBundleFlushBundleCaches();
                                    }
                            }
                    }
            }
            r24 = [r20 cfBundle];
            [r23 release];
            [r22 release];
            [r21 release];
            if (r24 != 0x0) {
                    r21 = [r20 retain];
            }
            else {
                    r21 = 0x0;
            }
    }
    else {
            r21 = [r20 retain];
    }
    [r19 release];
    [r20 release];
    r0 = r21;
    return r0;


// 0x10002ae00
// -[CXBundle dealloc]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([self cfBundle] != 0x0) {
            CFRelease([r19 cfBundle]);
    }
    var_20 = r19;
    [[&var_20 super] dealloc];
    return;


// 0x10002ae54
// +[CXBundle bundleWithURL:]
    r20 = [arg2 retain];
    r19 = [[self alloc] initWithURL:r20];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x10002ae9c
// -[CXBundle objectForInfoDictionaryKey:]
    r20 = [arg2 retain];
    r19 = [CFBundleGetValueForInfoDictionaryKey([self cfBundle], r20) retain];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x10002aeec
// -[CXBundle bundleIdentifier]
    r0 = [self cfBundle];
    r0 = CFBundleGetIdentifier(r0);
    return r0;


// 0x10002af00
// -[CXBundle executablePath]
    r0 = [self cfBundle];
    r0 = CFBundleCopyExecutableURL(r0);
    r19 = r0;
    r0 = [r0 path];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [r0 copy];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x10002af58
// -[CXBundle helperVersion]
    r0 = [self cfBundle];
    r0 = CFBundleGetValueForInfoDictionaryKey(r0, @"CXHelperAppVersion");
    r0 = [r0 retain];
    r19 = r0;
    r20 = [r0 unsignedIntValue];
    [r19 release];
    r0 = r20;
    return r0;


// 0x10002afa0
// -[CXBundle icon]
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
    r0 = [self objectForInfoDictionaryKey:@"CFBundleIconFile"];
    r0 = [r0 retain];
    r19 = r0;
    if (r0 != 0x0) {
            r0 = [r21 cfBundle];
            r0 = CFBundleCopyResourceURL(r0, r19, @"icns", 0x0);
            r20 = r0;
            if (r0 != 0x0) {
                    r0 = [NSImage alloc];
                    r0 = [r0 initWithContentsOfURL:r20];
                    r22 = r0;
                    if (r0 == 0x0) {
                            r23 = [[NSWorkspace sharedWorkspace] retain];
                            r0 = [r21 url];
                            r0 = [r0 retain];
                            r21 = r0;
                            r24 = [[r0 path] retain];
                            r22 = [[r23 iconForFile:r24] retain];
                            [r24 release];
                            [r21 release];
                            [r23 release];
                            [r20 release];
                            [r19 release];
                            r0 = [r22 autorelease];
                    }
                    else {
                            [r20 release];
                            [r19 release];
                            r0 = [r22 autorelease];
                    }
            }
            else {
                    r23 = [[NSWorkspace sharedWorkspace] retain];
                    r0 = [r21 url];
                    r0 = [r0 retain];
                    r21 = r0;
                    r24 = [[r0 path] retain];
                    r22 = [[r23 iconForFile:r24] retain];
                    [r24 release];
                    [r21 release];
                    [r23 release];
                    [r20 release];
                    [r19 release];
                    r0 = [r22 autorelease];
            }
    }
    else {
            r23 = [[NSWorkspace sharedWorkspace] retain];
            r0 = [r21 url];
            r0 = [r0 retain];
            r21 = r0;
            r24 = [[r0 path] retain];
            r22 = [[r23 iconForFile:r24] retain];
            [r24 release];
            [r21 release];
            [r23 release];
            [0x0 release];
            [r19 release];
            r0 = [r22 autorelease];
    }
    return r0;


// 0x10002b0b0
// -[CXBundle url]
    r0 = self->_url;
    return r0;


// 0x10002b0c0
// -[CXBundle setUrl:]
    objc_storeStrong((int64_t *)&self->_url, arg2);
    return;


// 0x10002b0d4
// -[CXBundle cfBundle]
    r0 = self->_cfBundle;
    return r0;


// 0x10002b0e4
// -[CXBundle setCfBundle:]
    self->_cfBundle = arg2;
    return;


// 0x10002b0f4
// -[CXBundle .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_url, 0x0);
    return;


