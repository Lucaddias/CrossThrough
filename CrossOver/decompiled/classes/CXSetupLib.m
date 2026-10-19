// CXSetupLib — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x100039c10
// +[CXSetupLib initialize]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    if (objc_opt_class(@class(CXSetupLib)) == r19) {
            _InitializePython();
            r0 = NSClassFromString(@"BottleQuery");
            *_BottleQuery = r0;
            if (r0 != 0x0) {
                    r0 = NSClassFromString(@"CXSetup");
                    *_CXSetup = r0;
                    if (r0 != 0x0) {
                            r0 = NSClassFromString(@"CXUtils");
                            *_cxUtils = r0;
                            if (r0 != 0x0) {
                                    r0 = NSClassFromString(@"BottleCollection");
                                    *_pyBottleCollection = r0;
                                    if (r0 != 0x0) {
                                            r0 = NSClassFromString(@"BottleWrapper");
                                            *_pyBottleWrapper = r0;
                                            if (r0 != 0x0) {
                                                    r0 = NSClassFromString(@"AppDetector");
                                                    *_AppDetector = r0;
                                                    if (r0 != 0x0) {
                                                            r0 = NSClassFromString(@"BottleManagement");
                                                            *_BottleManagement = r0;
                                                            if (r0 != 0x0) {
                                                                    r0 = NSClassFromString(@"CDDetector");
                                                                    *_CDDetector = r0;
                                                                    if (r0 != 0x0) {
                                                                            r0 = NSClassFromString(@"DemoUtils");
                                                                            *_DemoUtils = r0;
                                                                            if (r0 != 0x0) {
                                                                                    r0 = NSClassFromString(@"C4Profiles");
                                                                                    *_C4Profiles = r0;
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = NSClassFromString(@"InstallTask");
                                                                                            *_pyInstallTask = r0;
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = NSClassFromString(@"Engine");
                                                                                                    *_cxAiEngine = r0;
                                                                                                    if (r0 != 0x0) {
                                                                                                            r0 = NSClassFromString(@"CXMenu");
                                                                                                            *_cxMenu = r0;
                                                                                                            if (r0 != 0x0) {
                                                                                                                    r0 = NSClassFromString(@"IconUtils");
                                                                                                                    *_pyIconUtils = r0;
                                                                                                                    if (r0 != 0x0) {
                                                                                                                            r0 = NSClassFromString(@"RatingUtils");
                                                                                                                            *_pyRatingUtils = r0;
                                                                                                                            if (r0 != 0x0) {
                                                                                                                                    r0 = NSClassFromString(@"SystemInfo");
                                                                                                                                    *_pySystemInfo = r0;
                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                            r0 = NSClassFromString(@"WebUtils");
                                                                                                                                            *_pyWebUtils = r0;
                                                                                                                                            if (r0 == 0x0) {
                                                                                                                                                    NSLog(@"Unable to load the pyWebUtils class.\n");
                                                                                                                                                    [**_NSApp terminate:r19];
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            NSLog(@"Unable to load the SystemInfo class.\n");
                                                                                                                                            [**_NSApp terminate:r19];
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    NSLog(@"Unable to load the RatingUtils class.\n");
                                                                                                                                    [**_NSApp terminate:r19];
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            NSLog(@"Unable to load the IconUtils class.\n");
                                                                                                                            [**_NSApp terminate:r19];
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    NSLog(@"Unable to load the cxMenu class.\n");
                                                                                                                    [**_NSApp terminate:r19];
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            NSLog(@"Unable to load the Engine class.\n");
                                                                                                            [**_NSApp terminate:r19];
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    NSLog(@"Unable to load the InstallTask class.\n");
                                                                                                    [**_NSApp terminate:r19];
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            NSLog(@"Unable to load the C4Profiles class.\n");
                                                                                            [**_NSApp terminate:r19];
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    NSLog(@"Unable to load the DemoUtils class.\n");
                                                                                    [**_NSApp terminate:r19];
                                                                            }
                                                                    }
                                                                    else {
                                                                            NSLog(@"Unable to load the CDDetector class.\n");
                                                                            [**_NSApp terminate:r19];
                                                                    }
                                                            }
                                                            else {
                                                                    NSLog(@"Unable to load the BottleManagement class.\n");
                                                                    [**_NSApp terminate:r19];
                                                            }
                                                    }
                                                    else {
                                                            NSLog(@"Unable to load the AppDetector class.\n");
                                                            [**_NSApp terminate:r19];
                                                    }
                                            }
                                            else {
                                                    NSLog(@"Unable to load the BottleWrapper class.\n");
                                                    [**_NSApp terminate:r19];
                                            }
                                    }
                                    else {
                                            NSLog(@"Unable to load the BottleCollection class.\n");
                                            [**_NSApp terminate:r19];
                                    }
                            }
                            else {
                                    NSLog(@"Unable to load the cxUtils class.\n");
                                    [**_NSApp terminate:r19];
                            }
                    }
                    else {
                            NSLog(@"Unable to load the CXSetup class.\n");
                            [**_NSApp terminate:r19];
                    }
            }
            else {
                    NSLog(@"Unable to load the BottleQuery class.\n");
                    [**_NSApp terminate:r19];
            }
    }
    return;


// 0x10003a050
// +[CXSetupLib bottleQueryClass]
    r0 = *_BottleQuery;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a05c
// +[CXSetupLib bottleManagementClass]
    r0 = *_BottleManagement;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a068
// +[CXSetupLib cxSetupClass]
    r0 = *_CXSetup;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a074
// +[CXSetupLib appDetectorClass]
    r0 = *_AppDetector;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a080
// +[CXSetupLib cdDetectorClass]
    r0 = *_CDDetector;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a08c
// +[CXSetupLib demoUtilsClass]
    r0 = *_DemoUtils;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a098
// +[CXSetupLib c4ProfilesClass]
    r0 = *_C4Profiles;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a0a4
// +[CXSetupLib installTaskClass]
    r0 = *_pyInstallTask;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a0b0
// +[CXSetupLib cxAiEngineClass]
    r0 = *_cxAiEngine;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a0bc
// +[CXSetupLib cxUtilsClass]
    r0 = *_cxUtils;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a0c8
// +[CXSetupLib cxMenuClass]
    r0 = *_cxMenu;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a0d4
// +[CXSetupLib bottleCollectionClass]
    r0 = *_pyBottleCollection;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a0e0
// +[CXSetupLib bottleWrapperClass]
    r0 = *_pyBottleWrapper;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a0ec
// +[CXSetupLib iconUtilsClass]
    r0 = *_pyIconUtils;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a0f8
// +[CXSetupLib ratingUtilsClass]
    r0 = *_pyRatingUtils;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a104
// +[CXSetupLib systemInfoClass]
    r0 = *_pySystemInfo;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


// 0x10003a110
// +[CXSetupLib webUtilsClass]
    r0 = *_pyWebUtils;
    r0 = objc_retainAutoreleaseReturnValue(r0);
    return r0;


