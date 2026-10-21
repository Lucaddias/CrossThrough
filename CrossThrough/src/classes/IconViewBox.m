// IconViewBox.m — CrossThrough
#import "IconViewBox.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation IconViewBox

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    objc_destroyWeak((id *)&self->_auxField);
    objc_destroyWeak((id *)&self->_item);
    [super dealloc];
}

- (id)pathForIconHighlight {
    NSRect rect = NSInsetRect([[[self item] imageView] frame], -4.0, -4.0);
    return [NSBezierPath bezierPathWithRoundedRect:rect xRadius:18.0 yRadius:18.0];
}

- (id)pathForLabelHighlight {
    NSRect rect = [[[self item] textField] frame];
    rect.origin.y -= 2.0;
    rect.size.height += 2.0;
    return [NSBezierPath bezierPathWithRoundedRect:rect xRadius:4.0 yRadius:4.0];
}

- (id)menuForEvent:(id)arg1 {
    NSMenu *menu = [super menuForEvent:arg1];
    if (!menu) {
        menu = [[[self item] collectionView] menuForEvent:arg1];
    }
    return menu;
}

- (id)hitTest:(NSPoint)arg1 {
    NSView *hit = [super hitTest:arg1];
    if (hit == [[self item] textField] || hit == [[self item] imageView]) {
        return hit;
    }
    if (![[self auxField] isHidden] && hit == [self auxField]) {
        return hit;
    }
    return nil;
}

- (BOOL)isHighlighted {
    IconViewItem *item = [self item];
    if ([item isSelected] && [item highlightState] != NSCollectionViewItemHighlightForDeselection) {
        return YES;
    }
    return [item highlightState] == NSCollectionViewItemHighlightForSelection;
}

- (void)drawRect:(NSRect)arg1 {
    if (![self isHighlighted]) {
        return;
    }
    NSBezierPath *iconPath = [self pathForIconHighlight];
    if (NSIntersectsRect(NSInsetRect([iconPath bounds], -4.0, -4.0), arg1)) {
        [NSGraphicsContext saveGraphicsState];
        NSColor *tint = [self hasDarkModeApppearance] ? [[NSColor whiteColor] colorWithAlphaComponent:0.15]
                                                      : [[NSColor blackColor] colorWithAlphaComponent:0.1];
        [tint set];
        [iconPath fill];
        [NSGraphicsContext restoreGraphicsState];
    }
    NSBezierPath *labelPath = [self pathForLabelHighlight];
    if (NSIntersectsRect([labelPath bounds], arg1)) {
        [NSGraphicsContext saveGraphicsState];
        if ([[self window] isKeyWindow] && [(IconCollectionView *)[[self item] collectionView] isFirstResponder]) {
            [[NSColor alternateSelectedControlColor] set];
        } else {
            [[NSColor secondarySelectedControlColor] set];
        }
        [labelPath fill];
        [NSGraphicsContext restoreGraphicsState];
    }
}

- (void)updateLabelTextColor {
    NSColor *color;
    if ([[self window] isKeyWindow] && [self isHighlighted] &&
        [(IconCollectionView *)[[self item] collectionView] isFirstResponder]) {
        color = [NSColor alternateSelectedControlTextColor];
    } else {
        color = [NSColor controlTextColor];
    }
    [[[self item] textField] setTextColor:color];
}

- (void)viewDidMoveToWindow {
    if ([self window]) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(keyStatusDidChange) name:NSWindowDidBecomeKeyNotification object:[self window]];
        [center addObserver:self selector:@selector(keyStatusDidChange) name:NSWindowDidResignKeyNotification object:[self window]];
    }
}

- (void)viewWillMoveToWindow:(id)arg1 {
    if ([self window] != arg1) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center removeObserver:self name:NSWindowDidBecomeKeyNotification object:[self window]];
        [center removeObserver:self name:NSWindowDidResignKeyNotification object:[self window]];
    }
}

- (BOOL)hasDarkModeApppearance {
    NSAppearanceName match = [[self effectiveAppearance] bestMatchFromAppearancesWithNames:@[NSAppearanceNameAqua, NSAppearanceNameDarkAqua]];
    return [match isEqualToString:NSAppearanceNameDarkAqua];
}

- (void)keyStatusDidChange {
    [self updateLabelTextColor];
    [self setNeedsDisplay:YES];
}

- (void)rightMouseDown:(id)arg1 {
    IconViewItem *item = [self item];
    if (![item isSelected]) {
        NSCollectionView *collectionView = [item collectionView];
        [collectionView deselectAll:self];
        NSIndexPath *indexPath = [collectionView indexPathForItem:item];
        [collectionView selectItemsAtIndexPaths:[NSSet setWithObject:indexPath] scrollPosition:NSCollectionViewScrollPositionNone];
    }
    [[self nextResponder] rightMouseDown:arg1];
}

- (id)auxField {
    return [objc_loadWeakRetained((id *)&self->_auxField) autorelease];
}

- (void)setAuxField:(id)arg1 {
    objc_storeWeak((id *)&self->_auxField, arg1);
}

- (id)item {
    return [objc_loadWeakRetained((id *)&self->_item) autorelease];
}

- (void)setItem:(id)arg1 {
    objc_storeWeak((id *)&self->_item, arg1);
}

@end
