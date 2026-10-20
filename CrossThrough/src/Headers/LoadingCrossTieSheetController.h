// LoadingCrossTieSheetController.h — CrossThrough
#ifndef LoadingCrossTieSheetController_h
#define LoadingCrossTieSheetController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class LoadingCrossTieSheetController;

@interface LoadingCrossTieSheetController : CXWindowController
{
    NSString * _crossTieDisplayName;
    NSTextField * _loadingLabel;
    NSProgressIndicator * _progressIndicator;
}

// Instance Methods
- (id)init;
- (void)setCrossTieDisplayName:(id)arg1;
- (void)windowDidLoad;
- (void)updateLoadingLabel;
- (id)crossTieDisplayName;
- (id)loadingLabel;
- (void)setLoadingLabel:(id)arg1;
- (id)progressIndicator;
- (void)setProgressIndicator:(id)arg1;

@end

#endif /* LoadingCrossTieSheetController_h */
