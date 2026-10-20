// CXWindowController.m — CrossThrough
#import "CXWindowController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

static NSMutableArray *_selfOwnedControllers = nil;

@implementation CXWindowController

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

- (void)dealloc {
    if ([self isWindowLoaded]) {
        [[self window] setDelegate:nil];
    }
}

- (void)windowDidLoad {
    [super windowDidLoad];
    NSWindow *win = [self window];
    if (win) {
        [win setDelegate:self];
    }
    if (!_selfOwnedControllers) {
        _selfOwnedControllers = [[NSMutableArray alloc] init];
    }
    if (![_selfOwnedControllers containsObject:self]) {
        [_selfOwnedControllers addObject:self];
    }
}

- (void)windowWillClose:(id)arg1 {
    if ([self isWindowLoaded]) {
        NSWindow *closedWin = [arg1 respondsToSelector:@selector(object)] ? [arg1 object] : nil;
        if (closedWin == [self window]) {
            [_selfOwnedControllers removeObject:self];
        }
    }
}

- (void)showWindow:(id)arg1 {
    NSLog(@"[CXWindowController] showWindow called on %@", self);
    NSWindow *win = [self window];
    NSLog(@"[CXWindowController] [self window] = %@", win);
    if (win) {
        NSString *autosaveName = [win frameAutosaveName];
        if (autosaveName && [autosaveName length] > 0) {
            NSString *key = [NSString stringWithFormat:@"NSWindow Frame %@", autosaveName];
            if (![[NSUserDefaults standardUserDefaults] objectForKey:key]) {
                [win center];
            }
        } else {
            [win center];
        }
        [win makeKeyAndOrderFront:arg1];
        [win orderFrontRegardless];
    }
    [super showWindow:arg1];
}

@end
