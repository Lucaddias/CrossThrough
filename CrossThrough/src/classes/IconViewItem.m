// IconViewItem.m — CrossThrough
#import "IconViewItem.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation IconViewItem

- (id)init {
    self = [super initWithNibName:@"IconViewItem" bundle:nil];
    return self;
}

- (void)setRepresentedObject:(id)arg1 {
    [super setRepresentedObject:arg1];
    NSImage *icon = [arg1 icon];
    CGFloat scale = 0.85;
    if ([arg1 isKindOfClass:[LauncherAppTreeNode class]]) {
        scale = [[(LauncherAppTreeNode *)arg1 launcher] helperVersion] > 42 ? 1.2 : 0.85;
    }
    NSRect frame = [[self imageView] frame];
    CGFloat side = scale * frame.size.width;
    CGFloat offset = (side - frame.size.width) * -0.5;
    NSImage *image = [[NSImage alloc] initWithSize:frame.size];
    [image lockFocusFlipped:NO];
    [icon drawInRect:NSMakeRect(offset, offset, side, side)];
    [image unlockFocus];
    [[self imageView] setImage:image];
    [image release];
}

- (void)setSelected:(BOOL)arg1 {
    [super setSelected:arg1];
    [(IconViewBox *)[self view] updateLabelTextColor];
    [[self view] setNeedsDisplay:YES];
}

- (void)setHighlightState:(NSInteger)arg1 {
    [super setHighlightState:arg1];
    [(IconViewBox *)[self view] updateLabelTextColor];
    [[self view] setNeedsDisplay:YES];
}

- (id)draggingImageComponents {
    NSMutableArray *components = [[[super draggingImageComponents] mutableCopy] autorelease];
    if ([[[self textField] stringValue] length] != 0) {
        NSRect labelRect = NSInsetRect([[self textField] frame], -1.0, -1.0);
        NSBitmapImageRep *rep = [[self view] bitmapImageRepForCachingDisplayInRect:labelRect];
        [[self view] cacheDisplayInRect:labelRect toBitmapImageRep:rep];
        NSImage *image = [[NSImage alloc] initWithSize:[rep size]];
        [image addRepresentation:rep];
        NSDraggingImageComponent *label = [NSDraggingImageComponent draggingImageComponentWithKey:NSDraggingImageComponentLabelKey];
        [label setContents:image];
        [label setFrame:NSOffsetRect(labelRect, 0.0, -0.5)];
        NSUInteger index = [components indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [[obj key] isEqualToString:NSDraggingImageComponentLabelKey];
        }];
        if (index == NSNotFound) {
            [components addObject:label];
        } else {
            [components replaceObjectAtIndex:index withObject:label];
        }
        [image release];
    }
    NSTextField *auxField = [(IconViewBox *)[self view] auxField];
    if (auxField && ![auxField isHiddenOrHasHiddenAncestor] && [[auxField stringValue] length] != 0) {
        NSRect auxBounds = [auxField bounds];
        NSBitmapImageRep *rep = [auxField bitmapImageRepForCachingDisplayInRect:auxBounds];
        [auxField cacheDisplayInRect:auxBounds toBitmapImageRep:rep];
        NSImage *image = [[NSImage alloc] initWithSize:[rep size]];
        [image addRepresentation:rep];
        NSDraggingImageComponent *aux = [NSDraggingImageComponent draggingImageComponentWithKey:@"Aux Label"];
        [aux setContents:image];
        [aux setFrame:NSOffsetRect([[self view] convertRect:auxBounds fromView:auxField], 0.0, -0.5)];
        [components addObject:aux];
        [image release];
    }
    return components;
}

@end
