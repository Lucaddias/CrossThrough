// CXBundle.h — CrossThrough
#ifndef CXBundle_h
#define CXBundle_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class CXBundle;

@interface CXBundle : CXObject
{
    NSURL * _url;
    CFBundleRef _cfBundle;
}

// Class Methods
+ (id)bundleWithURL:(id)arg1;

// Instance Methods
- (id)initWithURL:(id)arg1;
- (void)dealloc;
- (id)objectForInfoDictionaryKey:(id)arg1;
- (id)bundleIdentifier;
- (id)executablePath;
- (NSUInteger)helperVersion;
- (id)icon;
- (id)url;
- (void)setUrl:(id)arg1;
- (CFBundleRef)cfBundle;
- (void)setCfBundle:(void *)arg1;

@end

#endif /* CXBundle_h */
