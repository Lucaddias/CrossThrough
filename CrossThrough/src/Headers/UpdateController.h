// UpdateController.h — CrossThrough
#ifndef UpdateController_h
#define UpdateController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class UpdateController;

@interface UpdateController : CXWindowController
{
    BOOL _upgradeInProgress;
    NSTextField * _messageTextField;
    NSScrollView * _bottleTableScrollView;
    NSLayoutConstraint * _messageToTableSpacing;
    NSLayoutConstraint * _tableToUpgradingSpacing;
    NSArray * _managedBottlesToUpgrade;
}

// Instance Methods
- (id)initWithManagedBottles:(id)arg1;
- (void)windowDidLoad;
- (void)finish;
- (void)updatePressed:(id)arg1;
- (void)doUpdateWithAuthorization:(id)arg1;
- (void)updateBottle:(id)arg1 WithAuthorization:(id)arg2;
- (void)updateLaterPressed:(id)arg1;
- (id)messageTextField;
- (void)setMessageTextField:(id)arg1;
- (id)bottleTableScrollView;
- (void)setBottleTableScrollView:(id)arg1;
- (id)messageToTableSpacing;
- (void)setMessageToTableSpacing:(id)arg1;
- (id)tableToUpgradingSpacing;
- (void)setTableToUpgradingSpacing:(id)arg1;
- (id)managedBottlesToUpgrade;
- (void)setManagedBottlesToUpgrade:(id)arg1;
- (BOOL)upgradeInProgress;
- (void)setUpgradeInProgress:(BOOL)arg1;

@end

#endif /* UpdateController_h */
