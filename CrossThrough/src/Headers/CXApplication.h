// CXApplication.h — CrossThrough
#ifndef CXApplication_h
#define CXApplication_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXApplication;
@class CXServer;

@interface CXApplication : NSApplication
{
    NSString * crossOverRoot;
    NSURL * crossOverRootURL;
    BOOL isDemo;
    int daysLeft;
    NSMenuItem * registerMenuItem;
    NSString * _licenseID;
    NSDate * _licenseExpirationDate;
    __weak id<WineApplicationController> _wineController;
    NSString * _demoString;
    __weak CXServer * _CXServer;
}

// Class Methods
+ (BOOL)accessInstanceVariablesDirectly;

// Instance Methods
- (id)init;
- (void)setDelegate:(id)arg1;
- (id)crossOverRoot;
- (id)crossOverRootURL;
- (BOOL)isDemo;
- (void)setIsDemo;
- (NSInteger)daysLeft;
- (void)setDaysLeft;
- (void)orderFrontStandardAboutPanel:(id)arg1;
- (void)reportException:(id)arg1;
- (void)setWineController:(id)arg1;
- (void)sendEvent:(id)arg1;
- (id)licenseID;
- (void)setLicenseID:(id)arg1;
- (id)licenseExpirationDate;
- (void)setLicenseExpirationDate:(id)arg1;
- (id)wineController;
- (id)demoString;
- (void)setDemoString:(id)arg1;
- (id)CXServer;
- (void)setCXServer:(id)arg1;

@end

#endif /* CXApplication_h */
