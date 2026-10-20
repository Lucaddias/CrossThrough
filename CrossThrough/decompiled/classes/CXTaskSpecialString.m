// CXTaskSpecialString — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003965c
// -[CXTaskSpecialString initWithString:]
    objc_storeStrong((int64_t *)&self->realString, arg2);
    r0 = self;
    return r0;


// 0x100039690
// -[CXTaskSpecialString copy]
    r0 = [self copyWithZone:0x0];
    return r0;


// 0x100039698
// -[CXTaskSpecialString mutableCopy]
    r0 = [self mutableCopyWithZone:0x0];
    return r0;


// 0x1000396a0
// -[CXTaskSpecialString copyWithZone:]
    r19 = [self->realString copyWithZone:arg2];
    r20 = [[CXTaskSpecialString alloc] initWithString:r19];
    [r19 release];
    r0 = r20;
    return r0;


// 0x1000396f0
// -[CXTaskSpecialString mutableCopyWithZone:]
    r19 = [self->realString mutableCopyWithZone:arg2];
    r20 = [[CXTaskSpecialString alloc] initWithString:r19];
    [r19 release];
    r0 = r20;
    return r0;


// 0x100039740
// -[CXTaskSpecialString fileSystemRepresentation]
    r0 = self->realString;
    r0 = [r0 UTF8String];
    return r0;


// 0x100039750
// -[CXTaskSpecialString forwardingTargetForSelector:]
    r0 = self->realString;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x100039760
// -[CXTaskSpecialString .cxx_destruct]
    objc_storeStrong((int64_t *)&self->realString, 0x0);
    return;


