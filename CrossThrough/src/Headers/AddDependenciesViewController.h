// AddDependenciesViewController.h — CrossThrough
#ifndef AddDependenciesViewController_h
#define AddDependenciesViewController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXViewController.h"

@class AddDependenciesViewController;

@interface AddDependenciesViewController : CXViewController <InstallConfigurationDelegate, NSObject>
{
    NSSearchField * _searchField;
    NSArrayController * _arrayController;
    NSArray * _addableDependencies;
}

// Class Methods
+ (id)keyPathsForValuesAffectingInstallConfiguration;

// Instance Methods
- (id)init;
- (void)dealloc;
- (id)installConfiguration;
- (void)loadView;
- (void)addDependencies:(id)arg1;
- (id)searchField;
- (void)setSearchField:(id)arg1;
- (id)arrayController;
- (void)setArrayController:(id)arg1;
- (id)addableDependencies;
- (void)setAddableDependencies:(id)arg1;

@end

#endif /* AddDependenciesViewController_h */
