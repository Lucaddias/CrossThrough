// SubmitRatingController.h — CrossThrough
#ifndef SubmitRatingController_h
#define SubmitRatingController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class SubmitRatingController;
@class RatingNotesFormatter;

@interface SubmitRatingController : CXWindowController <NSTextFieldDelegate, NSControlTextEditingDelegate, NSObject, NSWindowDelegate>
{
    RatingUtils * _ratingUtils;
    BOOL _loggingIn;
    BOOL _failed;
    BOOL _nag;
    BOOL _deleting;
    NSStackView * _stackView;
    NSLevelIndicator * _ratingIndicator;
    NSTextField * _notesField;
    NSButton * _submitButton;
    RatingNotesFormatter * _notesFormatter;
    NSTextField * _forgotPasswordLabel;
    NSTextField * _emailField;
    BottleWrapper * _bottle;
    NSString * _dialogTitle;
    NSString * _message;
    NSInteger _rating;
    NSString * _notes;
    NSInteger _charactersLeft;
    NSString * _email;
    NSString * _password;
    NSString * _appid;
}

// Class Methods
+ (id)keyPathsForValuesAffectingRatingDescription;
+ (id)keyPathsForValuesAffectingCharactersLeft;
+ (id)keyPathsForValuesAffectingCanSubmit;

// Instance Methods
- (id)initWithBottle:(id)arg1;
- (id)initWithBottle:(id)arg1 isNag:(BOOL)arg2 isDeleting:(BOOL)arg3;
- (void)windowDidLoad;
- (id)ratingDescription;
- (NSInteger)charactersLeft;
- (BOOL)canSubmit;
- (BOOL)askAgain;
- (void)submit:(id)arg1;
- (void)never:(id)arg1;
- (void)cancel:(id)arg1;
- (void)close;
- (void)handleLogin:(BOOL)arg1;
- (void)doSubmit;
- (void)doRegister;
- (void)windowDidBecomeKey:(id)arg1;
- (void)controlTextDidChange:(id)arg1;
- (id)stackView;
- (void)setStackView:(id)arg1;
- (id)ratingIndicator;
- (void)setRatingIndicator:(id)arg1;
- (id)notesField;
- (void)setNotesField:(id)arg1;
- (id)submitButton;
- (void)setSubmitButton:(id)arg1;
- (id)notesFormatter;
- (void)setNotesFormatter:(id)arg1;
- (id)forgotPasswordLabel;
- (void)setForgotPasswordLabel:(id)arg1;
- (id)emailField;
- (void)setEmailField:(id)arg1;
- (id)bottle;
- (void)setBottle:(id)arg1;
- (id)dialogTitle;
- (void)setDialogTitle:(id)arg1;
- (id)message;
- (void)setMessage:(id)arg1;
- (NSInteger)rating;
- (void)setRating:(NSInteger)arg1;
- (id)notes;
- (void)setNotes:(id)arg1;
- (void)setCharactersLeft:(NSInteger)arg1;
- (id)email;
- (void)setEmail:(id)arg1;
- (id)password;
- (void)setPassword:(id)arg1;
- (BOOL)loggingIn;
- (void)setLoggingIn:(BOOL)arg1;
- (BOOL)failed;
- (void)setFailed:(BOOL)arg1;
- (BOOL)nag;
- (void)setNag:(BOOL)arg1;
- (BOOL)deleting;
- (void)setDeleting:(BOOL)arg1;
- (id)ratingUtils;
- (id)appid;
- (void)setAppid:(id)arg1;

@end

#endif /* SubmitRatingController_h */
