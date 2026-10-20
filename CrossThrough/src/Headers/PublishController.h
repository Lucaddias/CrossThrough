// PublishController.h — CrossThrough
#ifndef PublishController_h
#define PublishController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class PublishController;

@interface PublishController : CXWindowController
{
    BOOL _isWorking;
    NSString * _bottleName;
    NSString * _bounceUtil;
    NSString * _sourceBottle;
    SFAuthorization * _authorization;
}

// Class Methods
+ (id)keyPathsForValuesAffectingNameCollides;
+ (id)keyPathsForValuesAffectingCanPublish;

// Instance Methods
- (id)init;
- (void)setBottleName:(id)arg1;
- (void)setupGUI;
- (void)publishPressed:(id)arg1;
- (void)doPublish;
- (void)publishFailed;
- (void)exitSuccess:(id)arg1;
- (void)cancelPressed:(id)arg1;
- (BOOL)nameCollides;
- (BOOL)canPublish;
- (void)setSourceBottle:(id)arg1;
- (id)bottleName;
- (id)bounceUtil;
- (void)setBounceUtil:(id)arg1;
- (id)sourceBottle;
- (id)authorization;
- (void)setAuthorization:(id)arg1;
- (BOOL)isWorking;
- (void)setIsWorking:(BOOL)arg1;

@end

#endif /* PublishController_h */
