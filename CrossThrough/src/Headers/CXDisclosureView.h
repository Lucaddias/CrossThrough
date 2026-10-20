// CXDisclosureView.h — CrossThrough
#ifndef CXDisclosureView_h
#define CXDisclosureView_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CXDisclosureView;

@interface CXDisclosureView : NSView
{
    BOOL _on;
    BOOL _gotOnState;
    NSString * _title;
    NSView * _detailView;
    NSString * _autosaveName;
    NSButton * _disclosureTriangle;
    NSButton * _titleButton;
}

// Instance Methods
- (id)initWithFrame:(NSRect)arg1;
- (id)initWithCoder:(id)arg1;
- (void)finishInit;
- (void)setTitle:(id)arg1;
- (void)setOn:(BOOL)arg1;
- (void)setAutosaveName:(id)arg1;
- (void)setDetailView:(id)arg1;
- (void)disclosureTriangleClicked:(id)arg1;
- (void)titleButtonClicked:(id)arg1;
- (NSSize)intrinsicContentSize;
- (void)prepareForInterfaceBuilder;
- (id)title;
- (BOOL)isOn;
- (id)detailView;
- (id)autosaveName;
- (BOOL)gotOnState;
- (void)setGotOnState:(BOOL)arg1;
- (id)disclosureTriangle;
- (void)setDisclosureTriangle:(id)arg1;
- (id)titleButton;
- (void)setTitleButton:(id)arg1;

@end

#endif /* CXDisclosureView_h */
