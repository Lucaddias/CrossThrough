// CXSetupLib.m — CrossThrough
#import "CXSetupLib.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "c_functions.h"
#import "NativeBottles.h"   // módulo nativo de bottles (substitui a camada Python)

static Class _BottleQuery = nil;
static Class _CXSetup = nil;
static Class _cxUtils = nil;
static Class _pyBottleCollection = nil;
static Class _pyBottleWrapper = nil;
static Class _AppDetector = nil;
static Class _BottleManagement = nil;
static Class _CDDetector = nil;
static Class _DemoUtils = nil;
static Class _C4Profiles = nil;
static Class _pyInstallTask = nil;
static Class _cxAiEngine = nil;
static Class _cxMenu = nil;
static Class _pyIconUtils = nil;
static Class _pyRatingUtils = nil;
static Class _pySystemInfo = nil;
static Class _pyWebUtils = nil;

@implementation CXSetupLib

+ (void)initialize {
    if (self == [CXSetupLib class]) {
        _InitializePython(@"libcxsetup");
        _CXSetup = NSClassFromString(@"CXSetup");
        _cxUtils = NSClassFromString(@"CXUtils");
        _AppDetector = NSClassFromString(@"AppDetector");
        // Bottles: módulo NATIVO (BottleModel.m / CXBottleSupport.m). A camada
        // Python fechada (bottlequery/bottlewrapper/bottlecollection/
        // bottlemanagement .pyc) deixa de ser consultada.
        _BottleQuery = [CTBottleQuery class];
        _pyBottleCollection = [CTBottleCollection class];
        _pyBottleWrapper = [CTBottleWrapper class];
        _BottleManagement = [CTBottleManagement class];
        _CDDetector = NSClassFromString(@"CDDetector");
        _DemoUtils = NSClassFromString(@"DemoUtils");
        _C4Profiles = NSClassFromString(@"C4Profiles");
        _pyInstallTask = NSClassFromString(@"InstallTask");
        _cxAiEngine = NSClassFromString(@"Engine");
        _cxMenu = NSClassFromString(@"CXMenu");
        _pyIconUtils = NSClassFromString(@"IconUtils");
        _pyRatingUtils = NSClassFromString(@"RatingUtils");
        _pySystemInfo = NSClassFromString(@"SystemInfo");
        _pyWebUtils = NSClassFromString(@"WebUtils");
    }
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
