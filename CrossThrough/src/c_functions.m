// c_functions.m — Standalone C functions for CrossThrough
#import <Cocoa/Cocoa.h>
#import "CrossThrough.h"
#import "c_functions.h"
#import <sys/stat.h>

void _CXLog(NSString *format, ...) {
    // Only logs when one of the CrossOver debug variables is set (0x1000417ec).
    if (getenv("CX_LOG") == NULL && getenv("CX_DEBUGMSG") == NULL && getenv("DEBUG") == NULL) {
        return;
    }
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
}

static void PyDecRef(PyObject *obj) {
    // Py_DECREF for 3.13: immortal objects have the top bit of ob_refcnt set.
    Py_ssize_t *refcnt = (Py_ssize_t *)obj;
    if ((*refcnt & (Py_ssize_t)0xffffffff80000000) == 0) {
        if (--(*refcnt) == 0) {
            _Py_Dealloc(obj);
        }
    }
}

void _InitializePython(NSString *scriptName) {
    NSURL *crossOverRootURL = [(CXApplication *)NSApp crossOverRootURL];
    // <bundle>/Contents/SharedSupport/CrossOver -> <bundle>
    NSURL *bundleURL = [[[crossOverRootURL URLByDeletingLastPathComponent] URLByDeletingLastPathComponent] URLByDeletingLastPathComponent];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    NSURL *pythonPath = [[crossOverRootURL URLByAppendingPathComponent:@"lib" isDirectory:YES] URLByAppendingPathComponent:@"python" isDirectory:YES];

    setenv("PYTHONPATH", [pythonPath fileSystemRepresentation], 1);
    unsetenv("PYTHONEXECUTABLE");
    unsetenv("PYTHONHOME");
    unsetenv("PYTHONINSPECT");
    unsetenv("PYTHONSTARTUP");
    unsetenv("PYTHONUSERBASE");

    const char *lcCType = getenv("LC_CTYPE");
    if (lcCType == NULL) {
        setenv("LC_CTYPE", "en_US.UTF-8", 1);
    }

    Py_NoUserSiteDirectory = 1;
    Py_SetProgramName(L"/usr/bin/python3");
    Py_InitializeEx(0);
    PyGILState_STATE gilState = PyGILState_Ensure();
    if (lcCType == NULL) {
        unsetenv("LC_CTYPE");
    }

    NSURL *baseScript = [bundle URLForResource:@"libcxsetupbase" withExtension:@"py"];
    NSURL *script;
    if ([scriptName isAbsolutePath]) {
        script = [NSURL fileURLWithPath:scriptName isDirectory:NO];
    } else {
        script = [bundle URLForResource:[scriptName stringByDeletingPathExtension] withExtension:[scriptName pathExtension]];
    }

    wchar_t *argv0 = Py_DecodeLocale([script fileSystemRepresentation], NULL);
    if (argv0 == NULL) {
        [NSException raise:NSInternalInconsistencyException format:@"Failed to decode argv[0]."];
    }
    PySys_SetArgvEx(1, &argv0, 0);
    PyMem_RawFree(argv0);

    PyObject *cxutils = PyImport_ImportModule("cxutils");
    if (cxutils == NULL) {
        PyErr_Print();
        [NSException raise:NSInternalInconsistencyException format:@"Failed to import cxutils module into Python.  See console for errors."];
    }
    PyObject *root = PyUnicode_FromString([crossOverRootURL fileSystemRepresentation]);
    if (root == NULL) {
        PyErr_Print();
        PyDecRef(cxutils);
        [NSException raise:NSInternalInconsistencyException format:@"Failed to create Python string for CrossOver root.  See console for errors."];
    }
    if (PyObject_SetAttrString(cxutils, "CX_ROOT", root) == -1) {
        PyErr_Print();
        PyDecRef(root);
        PyDecRef(cxutils);
        [NSException raise:NSInternalInconsistencyException format:@"Failed to set cxutils.CX_ROOT.  See console for errors."];
    }
    PyDecRef(root);
    PyDecRef(cxutils);

    NSURL *running = baseScript;
    FILE *fp = fopen([running fileSystemRepresentation], "r");
    int result = PyRun_SimpleFileExFlags(fp, [[running lastPathComponent] fileSystemRepresentation], 1, NULL);
    if (result == 0) {
        running = script;
        fp = fopen([running fileSystemRepresentation], "r");
        result = PyRun_SimpleFileExFlags(fp, [[running lastPathComponent] fileSystemRepresentation], 1, NULL);
    }

    PyGILState_Release(gilState);
    if (gilState == PyGILState_LOCKED) {
        PyEval_SaveThread();
    }
    if (result != 0) {
        [NSException raise:NSInternalInconsistencyException format:@"Failed to run Python script '%@'.  See console for errors.", [running path]];
    }
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
    // Notify package installers
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InstallersCacheChanged" object:nil];
}

void _observeProxyChange(void) {
    // System proxy configuration change notification
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
