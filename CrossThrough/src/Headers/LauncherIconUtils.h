// LauncherIconUtils.h — CrossThrough
#ifndef LauncherIconUtils_h
#define LauncherIconUtils_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class LauncherIconUtils;

@interface LauncherIconUtils : NSObject

// Class Methods
+ (id)imageRepsForCXMenuIconsFromURL:(id)arg1;
+ (CGFloat)percentOfNonTransparentPixelsAlongEdgeOfImageRep:(id)arg1;
+ (id)maskIconToRoundRect:(id)arg1 destinationDimension:(NSUInteger)arg2;
+ (BOOL)createIcnsFileAtURL:(id)arg1 fromImageReps:(id)arg2 forApp:(BOOL)arg3;

@end

#endif /* LauncherIconUtils_h */
