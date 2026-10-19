// CXWindowController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10003927c
// +[CXWindowController accessInstanceVariablesDirectly]
    return 0x0;


// 0x100039284
// -[CXWindowController dealloc]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if ([self isWindowLoaded] != 0x0) {
            r0 = [r19 window];
            r0 = [r0 retain];
            r20 = r0;
            [r0 setDelegate:0x0];
            [r20 release];
    }
    var_20 = r19;
    [[&var_20 super] dealloc];
    return;


// 0x1000392f0
// -[CXWindowController windowDidLoad]
    r31 = r31 - 0x60;
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
    var_40 = self;
    [[&var_40 super] windowDidLoad];
    r0 = [r19 window];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 delegate];
    r0 = [r0 retain];
    if (r0 != 0x0) {
            r22 = r0;
            r0 = [r19 window];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 delegate];
            r0 = [r0 retain];
            r24 = r0;
            [r0 release];
            [r23 release];
            [r22 release];
            [r21 release];
            if (r24 != r19) {
                    r21 = [[NSAssertionHandler currentHandler] retain];
                    r22 = [[r19 window] retain];
                    [r21 handleFailureInMethod:r20 object:r19 file:@"CXWindowController.m" lineNumber:0x1e description:@"Window %p should not have a delegate; CXWindowController %p needs to be the delegate.\n"];
                    [r22 release];
                    [r21 release];
            }
    }
    else {
            [r21 release];
    }
    r0 = [r19 window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setDelegate:r19];
    [r20 release];
    if (*_selfOwnedControllers == 0x0) {
            r0 = [[NSMutableArray alloc] init];
            r8 = *_selfOwnedControllers;
            *_selfOwnedControllers = r0;
            [r8 release];
    }
    [*_selfOwnedControllers addObject:r19];
    return;


// 0x100039470
// -[CXWindowController windowWillClose:]
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    if ([r20 isWindowLoaded] != 0x0) {
            r21 = [[r19 object] retain];
            r0 = [r20 window];
            r0 = [r0 retain];
            r22 = r0;
            [r0 release];
            [r21 release];
            if (r21 == r22) {
                    r21 = *_selfOwnedControllers;
                    r0 = [r20 window];
                    r0 = [r0 retain];
                    r20 = r0;
                    r22 = [[r0 windowController] retain];
                    [r21 removeObject:r22];
                    [r22 release];
                    [r20 release];
            }
    }
    [r19 release];
    return;


// 0x100039534
// -[CXWindowController showWindow:]
    r31 = r31 - 0x60;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r19 = [arg2 retain];
    r0 = [r20 window];
    r0 = [r0 retain];
    r22 = r0;
    r21 = [[r0 frameAutosaveName] retain];
    [r22 release];
    if (r21 != 0x0) {
            r22 = [[NSString stringWithFormat:@"NSWindow Frame %@", r3] retain];
            r0 = [NSUserDefaults standardUserDefaults];
            r0 = [r0 retain];
            r23 = r0;
            r0 = [r0 objectForKey:r22];
            r0 = [r0 retain];
            r24 = r0;
            [r0 release];
            [r23 release];
            if (r24 == 0x0) {
                    r0 = [r20 window];
                    r0 = [r0 retain];
                    r23 = r0;
                    [r0 center];
                    [r23 release];
            }
            [r22 release];
    }
    var_40 = r20;
    [[&var_40 super] showWindow:r19];
    [r21 release];
    [r19 release];
    return;


