// RosettaInstallationController.h — CrossThrough
#ifndef RosettaInstallationController_h
#define RosettaInstallationController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class RosettaInstallationController;

@interface RosettaInstallationController : CXWindowController
{
    NSTask * _task;
    NSMutableArray * _detailsShownConstraints;
    NSMutableArray * _detailsHiddenConstraints;
    NSTextField * _licenseLabel;
    NSTextField * _titleLabel;
    NSWindow * _progressSheet;
    NSTextField * _progressSheetDetailsLabel;
    NSButton * _progressSheetDoneButton;
    NSImageView * _progressSheetIcon;
    NSProgressIndicator * _progressSheetProgressIndicator;
    NSButton * _progressSheetShowHideDetailsButton;
    NSScrollView * _progressSheetScrollView;
    NSTextView * _progressSheetTextView;
}

// Instance Methods
- (id)init;
- (void)findDetailsConstraints:(id)arg1;
- (void)windowDidLoad;
- (void)exitButton:(id)arg1;
- (void)installFailed;
- (void)installButton:(id)arg1;
- (void)sheetDoneButton:(id)arg1;
- (void)sheetDetailDisclosureButton:(id)arg1;
- (id)task;
- (void)setTask:(id)arg1;
- (id)detailsShownConstraints;
- (void)setDetailsShownConstraints:(id)arg1;
- (id)detailsHiddenConstraints;
- (void)setDetailsHiddenConstraints:(id)arg1;
- (id)licenseLabel;
- (void)setLicenseLabel:(id)arg1;
- (id)titleLabel;
- (void)setTitleLabel:(id)arg1;
- (id)progressSheet;
- (void)setProgressSheet:(id)arg1;
- (id)progressSheetDetailsLabel;
- (void)setProgressSheetDetailsLabel:(id)arg1;
- (id)progressSheetDoneButton;
- (void)setProgressSheetDoneButton:(id)arg1;
- (id)progressSheetIcon;
- (void)setProgressSheetIcon:(id)arg1;
- (id)progressSheetProgressIndicator;
- (void)setProgressSheetProgressIndicator:(id)arg1;
- (id)progressSheetShowHideDetailsButton;
- (void)setProgressSheetShowHideDetailsButton:(id)arg1;
- (id)progressSheetScrollView;
- (void)setProgressSheetScrollView:(id)arg1;
- (id)progressSheetTextView;
- (void)setProgressSheetTextView:(id)arg1;

@end

#endif /* RosettaInstallationController_h */
