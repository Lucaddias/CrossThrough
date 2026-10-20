// NSWorkspace+CrossOverAdditions.h — CrossThrough
#ifndef NSWorkspace_CrossOverAdditions_h
#define NSWorkspace_CrossOverAdditions_h

#import <Cocoa/Cocoa.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@interface NSWorkspace (CrossOverAdditions)

// Instance Methods
- (id)CX_findRunningAppBundleWithIdentifier:(id)arg1;
- (id)CX_absolutePathForAppBundleWithIdentifier:(id)arg1 orIdentifyingURLScheme:(id)arg2;
- (BOOL)CX_launchAppWithBundleIdentifier:(id)arg1 orIdentifyingURLScheme:(id)arg2 options:(NSUInteger)arg3 additionalEventParamDescriptor:(id)arg4;
- (BOOL)CX_openURLs:(id)arg1 withAppBundleIdentifier:(id)arg2 orIdentifyingURLScheme:(id)arg3 options:(NSUInteger)arg4 additionalEventParamDescriptor:(id)arg5;

@end

#endif /* NSWorkspace_CrossOverAdditions_h */
