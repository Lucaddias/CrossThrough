// c_functions.h — Standalone C functions for CrossThrough
#ifndef c_functions_h
#define c_functions_h

#import <Cocoa/Cocoa.h>
#import <Security/Security.h>

#ifdef __cplusplus
extern "C" {
#endif

// Main entry point
int main(int argc, const char * argv[]);

// Logging
void _CXLog(NSString *format, ...);

// Python Initialization
void _InitializePython(NSString *scriptName);

// App Relocation (PFMoveToApplicationsFolder)
void _PFMoveToApplicationsFolderIfNecessary(void);
BOOL _IsLaunchedFromDMG(void);
BOOL _PathIsWithinPath(NSString *path, NSString *parent);
BOOL _Trash(NSString *path);

// Helper / Callbacks
void _InstallersCacheEventStreamCallback(ConstFSEventStreamRef streamRef, void *clientCallBackInfo, size_t numEvents, void *eventPaths, const FSEventStreamEventFlags eventFlags[], const FSEventStreamEventId eventIds[]);
void _observeProxyChange(void);
void _initCharacterSets(void);
NSComparisonResult _CompareLanguageEntries(id entry1, id entry2, void *context);

// Dynamic method IMPs
BOOL _boolGetterMethodFastIMP(id self, SEL _cmd);
BOOL _boolGetterMethodIMP(id self, SEL _cmd);
id _objectGetterMethodFastIMP(id self, SEL _cmd);
id _objectGetterMethodIMP(id self, SEL _cmd);
void _boolSetterMethodIMP(id self, SEL _cmd, BOOL val);
void _objectSetterMethodIMP(id self, SEL _cmd, id val);

#ifdef __cplusplus
}
#endif

#endif /* c_functions_h */
