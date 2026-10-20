// LauncherDiskFolder.h — CrossThrough
#ifndef LauncherDiskFolder_h
#define LauncherDiskFolder_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "LauncherFolder.h"

@class LauncherDiskFolder;

@interface LauncherDiskFolder : LauncherFolder
{
    NSURL * _url;
}

// Class Methods
+ (id)launcherWithFolderURL:(id)arg1;

// Instance Methods
- (id)initWithURL:(id)arg1;
- (id)copyWithZone:(void *)arg1;
- (id)icon;
- (id)description;
- (id)url;
- (void)setUrl:(id)arg1;

@end

#endif /* LauncherDiskFolder_h */
