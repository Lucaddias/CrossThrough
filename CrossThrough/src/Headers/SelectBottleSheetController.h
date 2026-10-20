// SelectBottleSheetController.h — CrossThrough
#ifndef SelectBottleSheetController_h
#define SelectBottleSheetController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class SelectBottleSheetController;
@class InstallConfiguration;

@interface SelectBottleSheetController : CXWindowController <InstallConfigurationDelegate, NSObject>
{
    InstallConfiguration * _installConfiguration;
    BottleCollection * _bottleCollection;
    NSDictionary * _categorizedBottles;
    NSDictionary * _categorizedTemplates;
    NSAttributedString * _bottleWarningText;
    NSString * _nameForNewBottle;
    TargetBottle * _targetBottle;
    NSButton * _doneButton;
    NSTextField * _nameForNewBottleTextField;
    NSPopUpButton * _bottleListPopUpButton;
    NSMenuItem * _makeNewBottleMenuItem;
    NSMenuItem * _selectBottlePlaceholderMenuItem;
    NSPopUpButton * _templateTypesPopUpButton;
}

// Class Methods
+ (id)keyPathsForValuesAffectingCreatingNewBottle;
+ (id)keyPathsForValuesAffectingConfigurationIsValid;

// Instance Methods
- (id)initWithInstallConfiguration:(id)arg1;
- (void)dealloc;
- (void)windowDidLoad;
- (BOOL)isTemplate:(id)arg1;
- (BOOL)creatingNewBottle;
- (void)setNameForNewBottle:(id)arg1;
- (id)stringInSystemFont:(id)arg1;
- (id)attributedStringWithImageNamed:(id)arg1;
- (id)attributedErrorStringWithString:(id)arg1;
- (id)attributedWarningStringWithString:(id)arg1;
- (void)updateBottleWarningText;
- (void)addMenuItemsFromCategories:(id)arg1 isBottles:(BOOL)arg2;
- (void)bottleItemSelected:(id)arg1;
- (void)templateItemSelected:(id)arg1;
- (void)updateBottlesList;
- (void)updateTemplatesList;
- (void)updateMenus;
- (void)updateInstallTaskWithBottleSelection;
- (BOOL)configurationIsValid;
- (void)done:(id)arg1;
- (void)cancel:(id)arg1;
- (void)windowWillClose:(id)arg1;
- (void)profileChanged;
- (void)bottleCreateChanged;
- (void)bottleNewnameChanged;
- (void)bottleTemplateChanged;
- (void)bottleNameChanged;
- (void)categorizedAllBottles;
- (void)analyzedBottle:(id)arg1;
- (id)installConfiguration;
- (id)bottleCollection;
- (id)categorizedBottles;
- (void)setCategorizedBottles:(id)arg1;
- (id)categorizedTemplates;
- (void)setCategorizedTemplates:(id)arg1;
- (id)bottleWarningText;
- (void)setBottleWarningText:(id)arg1;
- (id)nameForNewBottle;
- (id)targetBottle;
- (void)setTargetBottle:(id)arg1;
- (id)doneButton;
- (void)setDoneButton:(id)arg1;
- (id)nameForNewBottleTextField;
- (void)setNameForNewBottleTextField:(id)arg1;
- (id)bottleListPopUpButton;
- (void)setBottleListPopUpButton:(id)arg1;
- (id)makeNewBottleMenuItem;
- (void)setMakeNewBottleMenuItem:(id)arg1;
- (id)selectBottlePlaceholderMenuItem;
- (void)setSelectBottlePlaceholderMenuItem:(id)arg1;
- (id)templateTypesPopUpButton;
- (void)setTemplateTypesPopUpButton:(id)arg1;

@end

#endif /* SelectBottleSheetController_h */
