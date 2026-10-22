// AskUpdateBottlesOp.m — CrossThrough
#import "AskUpdateBottlesOp.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation AskUpdateBottlesOp

- (void)main {
    NSPredicate *needsUpdate = [NSPredicate predicateWithFormat:@"isManaged != FALSE AND isUpToDate == FALSE"];
    NSArray *bottles = [[[[CXSetupLib bottleCollectionClass] sharedCollection] bottleList] filteredArrayUsingPredicate:needsUpdate];
    if ([bottles count] != 0) {
        UpdateController *controller = [[UpdateController alloc] initWithManagedBottles:bottles];
        [NSApp runModalForWindow:[controller window]];
        [controller release];
    }
}

@end
