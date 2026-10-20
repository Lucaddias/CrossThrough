// CXSetupLib.h — CrossThrough
#ifndef CXSetupLib_h
#define CXSetupLib_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXSetupLib;

@interface CXSetupLib : NSObject

// Class Methods
+ (void)initialize;
+ (Class)bottleQueryClass;
+ (Class)bottleManagementClass;
+ (Class)cxSetupClass;
+ (Class)appDetectorClass;
+ (Class)cdDetectorClass;
+ (Class)demoUtilsClass;
+ (Class)c4ProfilesClass;
+ (Class)installTaskClass;
+ (Class)cxAiEngineClass;
+ (Class)cxUtilsClass;
+ (Class)cxMenuClass;
+ (Class)bottleCollectionClass;
+ (Class)bottleWrapperClass;
+ (Class)iconUtilsClass;
+ (Class)ratingUtilsClass;
+ (Class)systemInfoClass;
+ (Class)webUtilsClass;

@end

#endif /* CXSetupLib_h */
