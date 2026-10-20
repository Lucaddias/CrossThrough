// CDTools.h — CrossThrough
#ifndef CDTools_h
#define CDTools_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class CDTools;

@interface CDTools : CXObject

// Class Methods
+ (BOOL)isValidInstallerVolume:(id)arg1 requireRemovable:(BOOL)arg2;
+ (BOOL)isValidInstallerVolume:(id)arg1;
+ (void)removeCDHelper;
+ (id)getListOfAppsHelpedByTheCDHelper;
+ (void)removeCDHelperAndPrefsForAllInstalls;
+ (id)identifyInstallablePackagesForVolume:(id)arg1;

@end

#endif /* CDTools_h */
