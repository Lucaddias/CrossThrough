// AddDependenciesViewController.m — CrossThrough
#import "AddDependenciesViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation AddDependenciesViewController

+ (id)keyPathsForValuesAffectingInstallConfiguration {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"representedObject"];
     *   return r0;
     */
    return nil;
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
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self representedObject];
     *   return r0;
     */
    return nil;
}

- (void)loadView {
    return;
}

- (void)addDependencies:(id)arg1 {
    return;
}

- (id)searchField {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_searchField);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setSearchField:(id)arg1 {
    return;
}

- (id)arrayController {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_arrayController);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setArrayController:(id)arg1 {
    return;
}

- (id)addableDependencies {
    return self->_addableDependencies;
}

- (void)setAddableDependencies:(id)arg1 {
    return;
}

@end
