// AskUpdateBottlesOp — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003a644
// -[AskUpdateBottlesOp main]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [[NSPredicate predicateWithFormat:@"isManaged != FALSE AND isUpToDate == FALSE"] retain];
    r0 = [CXSetupLib bottleCollectionClass];
    r0 = [r0 sharedCollection];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 bottleList];
    r0 = [r0 retain];
    r22 = r0;
    r20 = [[r0 filteredArrayUsingPredicate:r19] retain];
    [r22 release];
    [r21 release];
    if ([r20 count] != 0x0) {
            r0 = [UpdateController alloc];
            r0 = [r0 initWithManagedBottles:r20];
            r21 = r0;
            r22 = **_NSApp;
            r23 = [[r0 window] retain];
            [r22 runModalForWindow:r23];
            [r23 release];
            [r21 release];
    }
    [r20 release];
    [r19 release];
    return;


