// c_functions.m — Standalone C functions for CrossThrough
#import <Cocoa/Cocoa.h>
#import "CrossThrough.h"
#import "c_functions.h"
#import <sys/stat.h>

void _CXLog(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
}

void _InitializePython(NSString *scriptName) {
    NSString *bundleRoot = [[NSBundle mainBundle] sharedSupportPath];
    NSString *crossOverRoot = [bundleRoot stringByAppendingPathComponent:@"CrossOver"];
    NSString *pythonPath = [crossOverRoot stringByAppendingPathComponent:@"lib/python"];
    
    setenv("PYTHONPATH", [pythonPath UTF8String], 1);
    unsetenv("PYTHONEXECUTABLE");
    unsetenv("PYTHONHOME");
    unsetenv("PYTHONINSPECT");
    unsetenv("PYTHONSTARTUP");
    unsetenv("PYTHONUSERBASE");
    
    if (!getenv("LC_CTYPE")) {
        setenv("LC_CTYPE", "en_US.UTF-8", 1);
    }
    
    Py_NoUserSiteDirectory = 1;
    Py_InitializeEx(0);
    
    PyObject *cxutils = PyImport_ImportModule("cxutils");
    if (cxutils) {
        PyObject *rootStr = PyUnicode_FromString([crossOverRoot UTF8String]);
        PyObject_SetAttrString(cxutils, "CX_ROOT", rootStr);
    }
    
    NSString *setupBasePath = [[NSBundle mainBundle] pathForResource:@"libcxsetupbase" ofType:@"py"];
    if (setupBasePath) {
        FILE *f = fopen([setupBasePath UTF8String], "r");
        if (f) {
            PyRun_SimpleFileExFlags(f, [setupBasePath UTF8String], 1, NULL);
        }
    }
    
    NSString *setupPath = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"py"];
    if (setupPath) {
        FILE *f = fopen([setupPath UTF8String], "r");
        if (f) {
            PyRun_SimpleFileExFlags(f, [setupPath UTF8String], 1, NULL);
        }
    }
    
    PyEval_SaveThread();
}

BOOL _IsLaunchedFromDMG(void) {
    NSString *appPath = [[NSBundle mainBundle] bundlePath];
    return [appPath hasPrefix:@"/Volumes/"];
}

BOOL _PathIsWithinPath(NSString *path, NSString *parent) {
    NSString *stdPath = [path stringByStandardizingPath];
    NSString *stdParent = [parent stringByStandardizingPath];
    return [stdPath hasPrefix:stdParent];
}

BOOL _Trash(NSString *path) {
    NSError *error = nil;
    NSURL *url = [NSURL fileURLWithPath:path];
    return [[NSFileManager defaultManager] trashItemAtURL:url resultingItemURL:nil error:&error];
}

void _PFMoveToApplicationsFolderIfNecessary(void) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"moveToApplicationsFolderAlertSuppress"]) {
        return;
    }
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSArray *appsPaths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSAllDomainsMask, YES);
    for (NSString *appDir in appsPaths) {
        if (_PathIsWithinPath(bundlePath, appDir)) {
            return;
        }
    }
    // Already in Applications or suppression set
}

void _InstallersCacheEventStreamCallback(ConstFSEventStreamRef streamRef, void *clientCallBackInfo, size_t numEvents, void *eventPaths, const FSEventStreamEventFlags eventFlags[], const FSEventStreamEventId eventIds[]) {
    id controller = (id)clientCallBackInfo;
    if ([controller respondsToSelector:@selector(installersCacheEventStreamCallback)]) {
        [controller installersCacheEventStreamCallback];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InstallersCacheChanged" object:nil];
}

void _observeProxyChange(void) {
    // System proxy configuration change notification
}

void _initCharacterSets(void) {
    // Initialize character sets
}

NSComparisonResult _CompareLanguageEntries(id entry1, id entry2, void *context) {
    if ([entry1 respondsToSelector:@selector(localizedStandardCompare:)]) {
        return [entry1 localizedStandardCompare:entry2];
    }
    return NSOrderedSame;
}

BOOL _boolGetterMethodFastIMP(id self, SEL _cmd) {
    return NO;
}

BOOL _boolGetterMethodIMP(id self, SEL _cmd) {
    return NO;
}

id _objectGetterMethodFastIMP(id self, SEL _cmd) {
    return nil;
}

id _objectGetterMethodIMP(id self, SEL _cmd) {
    return nil;
}

void _boolSetterMethodIMP(id self, SEL _cmd, BOOL val) {
}

void _objectSetterMethodIMP(id self, SEL _cmd, id val) {
}
