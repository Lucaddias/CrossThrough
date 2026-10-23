// CXSetupLib.m — CrossThrough
// Ported from -[CXSetupLib initialize] (0x100039c10) and the class getters
// (0x10003a050..0x10003a110) of CrossOver 26.3 arm64.
#import "CXSetupLib.h"
#import "CrossThrough.h"
#import "c_functions.h"

// The Python classes are registered with the ObjC runtime by PyObjC once
// libcxsetup.py has run, so they can only be resolved by name.
static Class _BottleQuery;
static Class _CXSetup;
static Class _cxUtils;
static Class _pyBottleCollection;
static Class _pyBottleWrapper;
static Class _AppDetector;
static Class _BottleManagement;
static Class _CDDetector;
static Class _DemoUtils;
static Class _C4Profiles;
static Class _pyInstallTask;
static Class _cxAiEngine;
static Class _cxMenu;
static Class _pyIconUtils;
static Class _pyRatingUtils;
static Class _pySystemInfo;
static Class _pyWebUtils;

static BOOL LoadPythonClass(Class *slot, NSString *name, NSString *logName, id sender) {
    *slot = NSClassFromString(name);
    if (*slot == nil) {
        NSLog(@"Unable to load the %@ class.\n", logName);
        [NSApp terminate:sender];
        return NO;
    }
    return YES;
}

@implementation CXSetupLib

+ (void)initialize {
    if (self != [CXSetupLib class]) {
        return;
    }
    _InitializePython(@"libcxsetup.py");
    // Same order and log names as the original nested checks.
    LoadPythonClass(&_BottleQuery, @"BottleQuery", @"BottleQuery", self) &&
    LoadPythonClass(&_CXSetup, @"CXSetup", @"CXSetup", self) &&
    LoadPythonClass(&_cxUtils, @"CXUtils", @"cxUtils", self) &&
    LoadPythonClass(&_pyBottleCollection, @"BottleCollection", @"BottleCollection", self) &&
    LoadPythonClass(&_pyBottleWrapper, @"BottleWrapper", @"BottleWrapper", self) &&
    LoadPythonClass(&_AppDetector, @"AppDetector", @"AppDetector", self) &&
    LoadPythonClass(&_BottleManagement, @"BottleManagement", @"BottleManagement", self) &&
    LoadPythonClass(&_CDDetector, @"CDDetector", @"CDDetector", self) &&
    LoadPythonClass(&_DemoUtils, @"DemoUtils", @"DemoUtils", self) &&
    LoadPythonClass(&_C4Profiles, @"C4Profiles", @"C4Profiles", self) &&
    LoadPythonClass(&_pyInstallTask, @"InstallTask", @"InstallTask", self) &&
    LoadPythonClass(&_cxAiEngine, @"Engine", @"Engine", self) &&
    LoadPythonClass(&_cxMenu, @"CXMenu", @"cxMenu", self) &&
    LoadPythonClass(&_pyIconUtils, @"IconUtils", @"IconUtils", self) &&
    LoadPythonClass(&_pyRatingUtils, @"RatingUtils", @"RatingUtils", self) &&
    LoadPythonClass(&_pySystemInfo, @"SystemInfo", @"SystemInfo", self) &&
    LoadPythonClass(&_pyWebUtils, @"WebUtils", @"pyWebUtils", self);
}

+ (Class)bottleQueryClass {
    return _BottleQuery;
}

+ (Class)bottleManagementClass {
    return _BottleManagement;
}

+ (Class)cxSetupClass {
    return _CXSetup;
}

+ (Class)appDetectorClass {
    return _AppDetector;
}

+ (Class)cdDetectorClass {
    return _CDDetector;
}

+ (Class)demoUtilsClass {
    return _DemoUtils;
}

+ (Class)c4ProfilesClass {
    return _C4Profiles;
}

+ (Class)installTaskClass {
    return _pyInstallTask;
}

+ (Class)cxAiEngineClass {
    return _cxAiEngine;
}

+ (Class)cxUtilsClass {
    return _cxUtils;
}

+ (Class)cxMenuClass {
    return _cxMenu;
}

+ (Class)bottleCollectionClass {
    return _pyBottleCollection;
}

+ (Class)bottleWrapperClass {
    return _pyBottleWrapper;
}

+ (Class)iconUtilsClass {
    return _pyIconUtils;
}

+ (Class)ratingUtilsClass {
    return _pyRatingUtils;
}

+ (Class)systemInfoClass {
    return _pySystemInfo;
}

+ (Class)webUtilsClass {
    return _pyWebUtils;
}

@end
