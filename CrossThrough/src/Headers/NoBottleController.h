// NoBottleController.h — CrossThrough
#ifndef NoBottleController_h
#define NoBottleController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class NoBottleController;

@interface NoBottleController : CXWindowController
{
    NSProgressIndicator * ProgBar;
    NSString * suggestedBottleName;
    BOOL _isWorking;
    NSURL * _fileToLaunch;
    NSString * _nameForNewBottle;
    NSString * _bottleTemplate;
    NSString * _fileToLaunchString;
    NSArray * _templateArray;
}

// Class Methods
+ (id)keyPathsForValuesAffectingCanCreate;

// Instance Methods
- (id)initWithFileToLaunch:(id)arg1;
- (void)awakeFromNib;
- (void)createPressed:(id)arg1;
- (void)doCreate;
- (void)createFailed:(id)arg1;
- (void)exitSuccess:(id)arg1;
- (void)cancelPressed:(id)arg1;
- (void)scopeChanged:(id)arg1;
- (BOOL)canCreate;
- (id)fileToLaunch;
- (void)setFileToLaunch:(id)arg1;
- (id)nameForNewBottle;
- (void)setNameForNewBottle:(id)arg1;
- (id)bottleTemplate;
- (void)setBottleTemplate:(id)arg1;
- (id)fileToLaunchString;
- (void)setFileToLaunchString:(id)arg1;
- (BOOL)isWorking;
- (void)setIsWorking:(BOOL)arg1;
- (id)templateArray;
- (void)setTemplateArray:(id)arg1;

@end

#endif /* NoBottleController_h */
