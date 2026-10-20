// NewBottleController.h — CrossThrough
#ifndef NewBottleController_h
#define NewBottleController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class NewBottleController;

@interface NewBottleController : CXWindowController
{
    BOOL _copyMode;
    BOOL _isWorking;
    BottleWrapper * _bottle;
    NSString * _suggestedBottleName;
    NSURL * _archiveURL;
    NSPopUpButton * _bottleTypePopUp;
    NSLayoutConstraint * _nameLabelTypeLabelWidths;
    NSLayoutConstraint * _typeToCreatingSpacer;
    NSTextField * _sourceBottleLabel;
    NSLayoutConstraint * _nameLabelCopyingLabelWidths;
    NSLayoutConstraint * _sourceBottleToCreatingSpacer;
    NSPathControl * _archivePathControl;
    NSLayoutConstraint * _nameLabelRestoringLabelWidths;
    NSLayoutConstraint * _archiveToCreatingSpacer;
    NSString * _bottleName;
    NSString * _bottleToCopy;
    NSString * _bottleTemplate;
    NSArray * _templateArray;
}

// Class Methods
+ (id)keyPathsForValuesAffectingCanCreate;

// Instance Methods
- (id)init;
- (void)setCopyMode:(BOOL)arg1 withBottleToCopy:(id)arg2;
- (void)setupGUI;
- (void)createPressed:(id)arg1;
- (void)doCreate;
- (void)createFailed:(id)arg1;
- (void)exitSuccess:(id)arg1;
- (void)cancelPressed:(id)arg1;
- (BOOL)canCreate;
- (id)bottle;
- (void)setBottle:(id)arg1;
- (id)suggestedBottleName;
- (void)setSuggestedBottleName:(id)arg1;
- (id)archiveURL;
- (void)setArchiveURL:(id)arg1;
- (id)bottleTypePopUp;
- (void)setBottleTypePopUp:(id)arg1;
- (id)nameLabelTypeLabelWidths;
- (void)setNameLabelTypeLabelWidths:(id)arg1;
- (id)typeToCreatingSpacer;
- (void)setTypeToCreatingSpacer:(id)arg1;
- (id)sourceBottleLabel;
- (void)setSourceBottleLabel:(id)arg1;
- (id)nameLabelCopyingLabelWidths;
- (void)setNameLabelCopyingLabelWidths:(id)arg1;
- (id)sourceBottleToCreatingSpacer;
- (void)setSourceBottleToCreatingSpacer:(id)arg1;
- (id)archivePathControl;
- (void)setArchivePathControl:(id)arg1;
- (id)nameLabelRestoringLabelWidths;
- (void)setNameLabelRestoringLabelWidths:(id)arg1;
- (id)archiveToCreatingSpacer;
- (void)setArchiveToCreatingSpacer:(id)arg1;
- (id)bottleName;
- (void)setBottleName:(id)arg1;
- (id)bottleToCopy;
- (void)setBottleToCopy:(id)arg1;
- (id)bottleTemplate;
- (void)setBottleTemplate:(id)arg1;
- (id)templateArray;
- (void)setTemplateArray:(id)arg1;
- (BOOL)copyMode;
- (BOOL)isWorking;
- (void)setIsWorking:(BOOL)arg1;

@end

#endif /* NewBottleController_h */
