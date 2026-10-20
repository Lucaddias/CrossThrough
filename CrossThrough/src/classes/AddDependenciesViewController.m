// AddDependenciesViewController.m — CrossThrough
#import "AddDependenciesViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation AddDependenciesViewController

+ (id)keyPathsForValuesAffectingInstallConfiguration {
    return [NSSet setWithObject:@"representedObject"];
}

- (id)init {
    return [super initWithNibName:@"AddDependenciesView" bundle:nil];
}

- (void)dealloc {
    [[self installConfiguration] removeDelegate:self];
    objc_destroyWeak((id *)&self->_searchField);
    objc_destroyWeak((id *)&self->_arrayController);
    [self->_addableDependencies release];
    [super dealloc];
}

- (id)installConfiguration {
    return [self representedObject];
}

- (void)loadView {
    [super loadView];
    InstallConfiguration *configuration = [self installConfiguration];
    [configuration addDelegate:self];
    NSMutableArray *dependencies = [[NSMutableArray alloc] init];
    for (id appID in [(InstallTask *)[configuration installTask] SuggestedDependencyOverrides]) {
        id profile = [configuration profileForAppID:appID];
        if ([[profile valueForKey:@"is_ranked"] boolValue]) {
            NSString *name = [configuration nameForProfileWithAppID:appID];
            [dependencies addObject:[NSDictionary dictionaryWithObjectsAndKeys:appID, @"appID", name, @"name", nil]];
        }
    }
    [self setAddableDependencies:dependencies];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
    [[self arrayController] setSortDescriptors:[NSArray arrayWithObject:sortByName]];
    [dependencies release];
}

- (void)addDependencies:(id)arg1 {
    NSArray *appIDs = [[[self arrayController] selectedObjects] valueForKey:@"appID"];
    [(InstallTask *)[[self installConfiguration] installTask] addDependencyOverrides:appIDs ofType:[InstallConfiguration overrideInclude]];
    [[self view] tryToPerform:@selector(performClose:) with:arg1];
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
