// AddDependenciesViewController.m — CrossThrough
#import "AddDependenciesViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation AddDependenciesViewController

+ (id)keyPathsForValuesAffectingInstallConfiguration {
    return [NSSet setWithObject:@"representedObject"];
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (id)installConfiguration {
    return [self representedObject];
}

- (void)loadView {
    return;
}

- (void)addDependencies:(id)arg1 {
    return;
}

- (id)searchField {
    return [objc_loadWeakRetained((id *)&self->_searchField) autorelease];
}

- (void)setSearchField:(id)arg1 {
    objc_storeWeak((id *)&self->_searchField, arg1);
}

- (id)arrayController {
    return [objc_loadWeakRetained((id *)&self->_arrayController) autorelease];
}

- (void)setArrayController:(id)arg1 {
    objc_storeWeak((id *)&self->_arrayController, arg1);
}

- (id)addableDependencies {
    return self->_addableDependencies;
}

- (void)setAddableDependencies:(id)arg1 {
    if (self->_addableDependencies != arg1) {
        [self->_addableDependencies release];
        self->_addableDependencies = [arg1 copy];
    }
}

@end
