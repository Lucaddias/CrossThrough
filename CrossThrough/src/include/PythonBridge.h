// PythonBridge.h — selectors the GUI sends to the Python classes in
// SharedSupport/CrossOver/lib/python (see sharedsupport/python/BRIDGE.md).
// PyObjC registers these at runtime, so they are declared here only to give
// the compiler the original signatures. BOOL vs id return types follow how the
// original arm64 code consumes each result.
#ifndef PythonBridge_h
#define PythonBridge_h

#import <Cocoa/Cocoa.h>

@interface NSObject (CXPythonBridgeClassMethods)
// DemoUtils (demoutils)
+ (NSArray *)demoStatusForLicenseFile:(NSString *)licenseFile andSig:(NSString *)sigFile;
// CXSetup (Resources/libcxsetup.py)
+ (void)setEnvValue:(NSString *)value forKey:(NSString *)key;
+ (void)unsetEnvValueForKey:(NSString *)key;
// BottleCollection (bottlecollection)
+ (id)sharedCollection;
@end

@interface NSObject (CXPythonBridgeInstanceMethods)
// BottleCollection
- (void)addChangeDelegate:(id)delegate;
- (NSArray *)bottleList;
- (id)bottleWithName:(NSString *)name;
- (void)refresh;
@end

#endif /* PythonBridge_h */
