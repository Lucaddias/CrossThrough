// InstallSummaryDetailViewController.h — CrossThrough
#ifndef InstallSummaryDetailViewController_h
#define InstallSummaryDetailViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class InstallSummaryDetailViewController;

@interface InstallSummaryDetailViewController : CXViewController
{
    BOOL _sendsActionOnMouseDown;
    BOOL _buttonEnabled;
    id _delegate;
    NSImage * _image;
    NSAttributedString * _text;
    SEL _action;
    NSButton * _editButton;
}

// Class Methods
+ (id)keyPathsForValuesAffectingHasAction;

// Instance Methods
- (id)init;
- (BOOL)hasAction;
- (void)select:(id)arg1;
- (void)setSendsActionOnMouseDown:(BOOL)arg1;
- (void)setButtonEnabled:(BOOL)arg1;
- (void)viewDidLoad;
- (id)delegate;
- (void)setDelegate:(id)arg1;
- (id)image;
- (void)setImage:(id)arg1;
- (id)text;
- (void)setText:(id)arg1;
- (SEL)action;
- (void)setAction:(SEL)arg1;
- (BOOL)sendsActionOnMouseDown;
- (BOOL)buttonEnabled;
- (id)editButton;
- (void)setEditButton:(id)arg1;

@end

#endif /* InstallSummaryDetailViewController_h */
