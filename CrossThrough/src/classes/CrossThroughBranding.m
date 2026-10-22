// CrossThroughBranding.m — CrossThrough
#import "CrossThroughBranding.h"

NSString *CTApplicationName(void) {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey] ?: @"CrossThrough";
}

NSString *CTNeutralizeProductName(NSString *s) {
    if (![s isKindOfClass:[NSString class]]) {
        return s;
    }
    return [s stringByReplacingOccurrencesOfString:@"CrossOver" withString:CTApplicationName()];
}

// The logo ships as loose PNGs (CrossThroughLogo, CrossThroughLogo-dark), not
// in the asset catalog borrowed from CrossOver, so the light and dark variants
// are picked at draw time from the appearance being drawn.
static NSImage *brandedLogo(NSImage *light, NSImage *dark) {
    NSImage *logo = [NSImage imageWithSize:[light size] flipped:NO drawingHandler:^BOOL(NSRect rect) {
        NSAppearanceName match = [[NSAppearance currentDrawingAppearance]
            bestMatchFromAppearancesWithNames:@[NSAppearanceNameAqua, NSAppearanceNameDarkAqua]];
        NSImage *variant = [match isEqualToString:NSAppearanceNameDarkAqua] ? dark : light;
        [variant drawInRect:rect fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0];
        return YES;
    }];
    [logo setCacheMode:NSImageCacheNever];
    return logo;
}

void CTRegisterBrandedLogo(void) {
    static BOOL registered = NO;
    if (registered) {
        return;
    }
    NSImage *light = [[NSBundle mainBundle] imageForResource:@"CrossThroughLogo"];
    NSImage *dark = [[NSBundle mainBundle] imageForResource:@"CrossThroughLogo-dark"];
    if (!light || !dark) {
        return;
    }
    registered = YES;
    // Named images stay registered for the life of the app; keep them alive.
    for (NSString *name in @[@"welcomeCrossOverIcon", @"welcomeCrossOverPreviewIcon"]) {
        NSImage *logo = [brandedLogo(light, dark) retain];
        [logo setName:name];
    }
}

void CTBrandAppMenu(void) {
    NSString *name = CTApplicationName();
    NSMenu *appMenu = [[[NSApp mainMenu] itemAtIndex:0] submenu];
    for (NSMenuItem *item in [appMenu itemArray]) {
        SEL action = [item action];
        if (action == @selector(orderFrontStandardAboutPanel:) || action == @selector(hide:) || action == @selector(terminate:)) {
            [item setTitle:[[item title] stringByReplacingOccurrencesOfString:@"CrossOver" withString:name]];
        }
    }
}
