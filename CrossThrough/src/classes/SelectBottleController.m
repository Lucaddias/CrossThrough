// SelectBottleController.m — CrossThrough
#import "SelectBottleController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static NSArray *_builtInAllowedTypes = nil;
static void *_SelectBottleControllerKVOContextDummy = &_SelectBottleControllerKVOContextDummy;

@implementation SelectBottleController

+ (void)initialize {
    if (self == [SelectBottleController class]) {
        _builtInAllowedTypes = [[NSArray alloc] initWithObjects:@"exe", nil];
    }
}

- (id)init {
    self = [super initWithNibName:@"SelectBottleView" bundle:nil];
    if (self) {
        id sharedBC = [[CXSetupLib bottleCollectionClass] sharedCollection];
        [self setRepresentedObject:sharedBC];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"canRunCommands != FALSE"];
        [self setCanRunFilterPredicate:pred];
    }
    return self;
}

- (void)dealloc {
    id ac = objc_loadWeakRetained((id *)&self->_bottleArrayController);
    if (ac) {
        [ac removeObserver:self forKeyPath:@"selectedObjects" context:_SelectBottleControllerKVOContextDummy];
        [ac release];
    }
    [self->_canRunFilterPredicate release];
    self->_canRunFilterPredicate = nil;
    [self->_selectedBottle release];
    self->_selectedBottle = nil;
    [self->cachedAllowedFileTypes release];
    self->cachedAllowedFileTypes = nil;
    objc_destroyWeak((id *)&self->_bottleArrayController);
    [super dealloc];
}

- (void)awakeFromNib {
    [super awakeFromNib];

    NSArrayController *ac = [self bottleArrayController];
    if (ac) {
        NSSortDescriptor *sortDefault = [[[NSSortDescriptor alloc] initWithKey:@"isDefault" ascending:NO] autorelease];
        NSSortDescriptor *sortName = [[[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)] autorelease];
        [ac setSortDescriptors:@[sortDefault, sortName]];
        [ac addObserver:self forKeyPath:@"selectedObjects" options:NSKeyValueObservingOptionNew context:_SelectBottleControllerKVOContextDummy];
    }
}

- (void)setSelectedBottle:(id)arg1 {
    if (self->_selectedBottle != arg1) {
        [self willChangeValueForKey:@"selectedBottle"];
        [self->_selectedBottle release];
        self->_selectedBottle = [arg1 retain];
        [self didChangeValueForKey:@"selectedBottle"];

        [self->cachedAllowedFileTypes release];
        self->cachedAllowedFileTypes = nil;

        NSWindow *win = [[self view] window];
        if (win && [win respondsToSelector:@selector(validateVisibleColumns)]) {
            [(id)win validateVisibleColumns];
        }
    }
}

- (void)observeValueForKeyPath:(id)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == _SelectBottleControllerKVOContextDummy) {
        NSArray *selected = [[self bottleArrayController] selectedObjects];
        id first = [selected count] > 0 ? [selected objectAtIndex:0] : nil;
        [self setSelectedBottle:first];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (id)allowedFileTypes {
    if (!self->cachedAllowedFileTypes) {
        NSArray *serverTypes = nil;
        if (self->_selectedBottle) {
            serverTypes = [CXServer fileTypesForBottle:self->_selectedBottle];
        }
        if (serverTypes) {
            self->cachedAllowedFileTypes = [[_builtInAllowedTypes arrayByAddingObjectsFromArray:serverTypes] retain];
        } else {
            self->cachedAllowedFileTypes = [_builtInAllowedTypes retain];
        }
    }
    return self->cachedAllowedFileTypes;
}

- (BOOL)panel:(id)sender shouldShowFilename:(id)filename {
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filename isDirectory:&isDir] && isDir) {
        return YES;
    }
    NSString *ext = [filename pathExtension];
    NSArray *allowed = [self allowedFileTypes];
    for (NSString *allowedExt in allowed) {
        if ([ext caseInsensitiveCompare:allowedExt] == NSOrderedSame) {
            return YES;
        }
    }
    return NO;
}

- (id)bottleArrayController {
    return objc_loadWeakRetained((id *)&self->_bottleArrayController);
}

- (void)setBottleArrayController:(id)arg1 {
    objc_storeWeak((id *)&self->_bottleArrayController, arg1);
}

- (id)selectedBottle {
    return self->_selectedBottle;
}

- (id)canRunFilterPredicate {
    return self->_canRunFilterPredicate;
}

- (void)setCanRunFilterPredicate:(id)arg1 {
    if (self->_canRunFilterPredicate != arg1) {
        [self->_canRunFilterPredicate release];
        self->_canRunFilterPredicate = [arg1 copy];
    }
}

@end
