// SelectBottleController.h — CrossThrough
#ifndef SelectBottleController_h
#define SelectBottleController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class SelectBottleController;

@interface SelectBottleController : CXViewController <NSOpenSavePanelDelegate, NSObject>
{
    NSArray * cachedAllowedFileTypes;
    NSArrayController * _bottleArrayController;
    BottleWrapper * _selectedBottle;
    NSPredicate * _canRunFilterPredicate;
}

// Class Methods
+ (void)initialize;

// Instance Methods
- (id)init;
- (void)dealloc;
- (void)awakeFromNib;
- (void)setSelectedBottle:(id)arg1;
- (void)observeValueForKeyPath:(id)arg1 ofObject:(id)arg2 change:(id)arg3 context:(void *)arg4;
- (id)allowedFileTypes;
- (BOOL)panel:(id)arg1 shouldShowFilename:(id)arg2;
- (id)bottleArrayController;
- (void)setBottleArrayController:(id)arg1;
- (id)selectedBottle;
- (id)canRunFilterPredicate;
- (void)setCanRunFilterPredicate:(id)arg1;

@end

#endif /* SelectBottleController_h */
