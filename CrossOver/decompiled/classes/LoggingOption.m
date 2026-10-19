// LoggingOption — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100034128
// +[LoggingOption loggingOptionWithName:channels:environment:]
    r22 = [arg4 retain];
    r19 = [arg3 retain];
    r20 = [arg2 retain];
    r21 = [[self alloc] initWithName:r20 channels:r19 environment:r22];
    [r22 release];
    [r19 release];
    [r20 release];
    r0 = [r21 autorelease];
    return r0;


// 0x1000341b0
// +[LoggingOption loggingOptionWithName:channels:]
    r21 = [arg3 retain];
    r19 = [arg2 retain];
    r20 = [[self alloc] initWithName:r19 channels:r21 environment:**___NSArray0__];
    [r21 release];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x100034228
// +[LoggingOption commonPresets]
    r31 = r31 - 0x40;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_28 = *__NSConcreteStackBlock;
    if (*_commonPresets.onceToken != -0x1) {
            dispatch_once(_commonPresets.onceToken, &var_28);
    }
    r0 = *_commonPresets.presets;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100034480
// -[LoggingOption initWithName:channels:environment:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    var_30 = self;
    r0 = [[&var_30 super] init];
    r22 = r0;
    if (r0 != 0x0) {
            r0 = [r19 copy];
            r8 = r22[0x1];
            r22[0x1] = r0;
            [r8 release];
            r0 = [r20 copy];
            r8 = r22[0x2];
            r22[0x2] = r0;
            [r8 release];
            r0 = [r21 copy];
            r8 = r22[0x3];
            r22[0x3] = r0;
            [r8 release];
    }
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = r22;
    return r0;


// 0x100034560
// -[LoggingOption name]
    r0 = self[0x1];
    return r0;


// 0x100034568
// -[LoggingOption setName:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100034570
// -[LoggingOption logChannels]
    r0 = self[0x2];
    return r0;


// 0x100034578
// -[LoggingOption setLogChannels:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100034580
// -[LoggingOption logEnvironment]
    r0 = self[0x3];
    return r0;


// 0x100034588
// -[LoggingOption setLogEnvironment:]
    objc_setProperty_nonatomic_copy();
    return;


// 0x100034590
// -[LoggingOption .cxx_destruct]
    objc_storeStrong(self + 0x18, 0x0);
    objc_storeStrong(self + 0x10, 0x0);
    objc_storeStrong(self + 0x8, 0x0);
    return;


