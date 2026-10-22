// LauncherIconUtils.m — CrossThrough
#import "LauncherIconUtils.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

// Icon sizes looked up next to a freedesktop "icons/hicolor/<size>/..." path.
static const int kCXMenuIconSizes[] = { 512, 256, 128, 64, 48, 32, 16 };

// The edge analysis renders into a 1024x1024 alpha bitmap and samples a band
// 50 pixels wide: 1024^2 - 924^2 = 194800 pixels.
static const size_t kEdgeCanvasDimension = 1024;
static const CGFloat kEdgeBandWidth = 50.0;
static const double kEdgeBandPixelCount = 194800.0;

@implementation LauncherIconUtils

+ (id)imageRepsForCXMenuIconsFromURL:(id)arg1 {
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:7];
    [urls addObject:arg1];

    NSMutableArray *components = [[[arg1 pathComponents] mutableCopy] autorelease];
    NSUInteger sizeIndex = [components indexOfObjectWithOptions:NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if (idx < 2) {
            return NO;
        }
        return [[components objectAtIndexedSubscript:idx - 2] isEqualToString:@"icons"] &&
               [[components objectAtIndexedSubscript:idx - 1] isEqualToString:@"hicolor"];
    }];
    if (sizeIndex != NSNotFound) {
        for (size_t i = 0; i < sizeof(kCXMenuIconSizes) / sizeof(kCXMenuIconSizes[0]); i++) {
            int size = kCXMenuIconSizes[i];
            [components replaceObjectAtIndex:sizeIndex withObject:[NSString stringWithFormat:@"%ix%i", size, size]];
            NSURL *url = [NSURL fileURLWithPathComponents:components];
            if (![arg1 isEqual:url]) {
                [urls addObject:url];
            }
        }
    }

    NSMutableArray *reps = [NSMutableArray arrayWithCapacity:[urls count]];
    for (NSURL *url in urls) {
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:data];
            if (rep) {
                [reps addObject:rep];
            }
        }
    }
    return reps;
}

+ (CGFloat)percentOfNonTransparentPixelsAlongEdgeOfImageRep:(id)arg1 {
    const size_t bytesPerRow = 0x2000;
    uint8_t *pixels = calloc(kEdgeCanvasDimension * bytesPerRow, 1);
    if (!pixels) {
        return 0.0;
    }
    CGContextRef context = CGBitmapContextCreate(pixels, kEdgeCanvasDimension, kEdgeCanvasDimension, 8, bytesPerRow, NULL, (CGBitmapInfo)kCGImageAlphaOnly);
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithCGContext:context flipped:NO]];
    [[NSColor whiteColor] set];
    NSRect canvas = NSMakeRect(0, 0, kEdgeCanvasDimension, kEdgeCanvasDimension);
    NSFrameRectWithWidth(canvas, kEdgeBandWidth);
    // Keep only the band pixels the icon also covers.
    [(NSImageRep *)arg1 drawInRect:canvas fromRect:NSZeroRect operation:NSCompositingOperationDestinationIn fraction:1.0 respectFlipped:YES hints:nil];
    [NSGraphicsContext setCurrentContext:nil];

    unsigned long long opaque = 0;
    for (size_t row = 0; row < kEdgeCanvasDimension; row++) {
        const uint8_t *line = pixels + row * bytesPerRow;
        for (size_t col = 0; col < kEdgeCanvasDimension; col++) {
            if (line[col] != 0) {
                opaque++;
            }
        }
    }
    CGContextRelease(context);
    free(pixels);
    return (double)opaque / kEdgeBandPixelCount;
}

+ (id)maskIconToRoundRect:(id)arg1 destinationDimension:(NSUInteger)arg2 {
    // Icons that only partly fill their edges get shrunk so they sit inside
    // the rounded rectangle instead of being clipped by it.
    CGFloat edgeCoverage = [self percentOfNonTransparentPixelsAlongEdgeOfImageRep:arg1];
    NSRect iconRect = NSMakeRect(100.0, 100.0, 824.0, 824.0);
    if (edgeCoverage > 0.05 && edgeCoverage < 0.9) {
        iconRect = NSInsetRect(iconRect, 80.0, 80.0);
    }
    CGFloat dimension = (CGFloat)arg2;
    CGFloat scale = dimension / 1024.0;
    iconRect = NSMakeRect(iconRect.origin.x * scale, iconRect.origin.y * scale,
                          iconRect.size.width * scale, iconRect.size.height * scale);
    NSRect fullRect = NSMakeRect(0, 0, dimension, dimension);

    NSImage *mask = [[NSBundle mainBundle] imageForResource:@"app-icon-roundrect-mask"];

    NSBitmapImageRep *masked = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL pixelsWide:arg2 pixelsHigh:arg2 bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSDeviceRGBColorSpace bitmapFormat:0 bytesPerRow:0 bitsPerPixel:0];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:masked]];
    [mask drawInRect:fullRect];
    NSDictionary *hints = @{NSImageHintInterpolation: @(NSImageInterpolationHigh)};
    [(NSImageRep *)arg1 drawInRect:iconRect fromRect:NSZeroRect operation:NSCompositingOperationSourceIn fraction:1.0 respectFlipped:YES hints:hints];
    [NSGraphicsContext setCurrentContext:nil];

    NSBitmapImageRep *result = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL pixelsWide:arg2 pixelsHigh:arg2 bitsPerSample:8 samplesPerPixel:4 hasAlpha:YES isPlanar:NO colorSpaceName:NSDeviceRGBColorSpace bitmapFormat:0 bytesPerRow:0 bitsPerPixel:0];
    [NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithBitmapImageRep:result]];
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:NSMakeSize(0.0, scale * -5.0)];
    [shadow setShadowBlurRadius:scale * 25.0];
    [NSGraphicsContext saveGraphicsState];
    [shadow set];
    [mask drawInRect:fullRect];
    [NSGraphicsContext restoreGraphicsState];
    [masked drawInRect:fullRect fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0 respectFlipped:YES hints:nil];
    [NSGraphicsContext setCurrentContext:nil];

    [shadow release];
    [masked release];
    return [result autorelease];
}

+ (BOOL)createIcnsFileAtURL:(id)arg1 fromImageReps:(id)arg2 forApp:(BOOL)arg3 {
    BOOL ok = NO;
    if (arg3) {
        CGImageDestinationRef destination = CGImageDestinationCreateWithURL((CFURLRef)arg1, kUTTypeAppleICNS, 2, NULL);
        if (!destination) {
            NSLog(@"Couldn't create CGImageDestination\n");
            return NO;
        }
        // CrossOver passes @selector(pixelsHigh) to -sortedArrayUsingSelector:;
        // the intent is to pick the largest representation, so sort by height.
        NSArray *sorted = [arg2 sortedArrayUsingComparator:^NSComparisonResult(NSImageRep *a, NSImageRep *b) {
            NSInteger ha = [a pixelsHigh], hb = [b pixelsHigh];
            return ha < hb ? NSOrderedAscending : (ha > hb ? NSOrderedDescending : NSOrderedSame);
        }];
        id largest = [sorted lastObject];
        CGImageDestinationAddImage(destination, [[self maskIconToRoundRect:largest destinationDimension:512] CGImageForProposedRect:NULL context:nil hints:nil], NULL);
        CGImageDestinationAddImage(destination, [[self maskIconToRoundRect:largest destinationDimension:256] CGImageForProposedRect:NULL context:nil hints:nil], NULL);
        ok = CGImageDestinationFinalize(destination);
        if (!ok) {
            NSLog(@"Failed to finalize ICNS file %@", arg1);
        }
        CFRelease(destination);
    } else {
        CGImageDestinationRef destination = CGImageDestinationCreateWithURL((CFURLRef)arg1, kUTTypeAppleICNS, [arg2 count], NULL);
        if (!destination) {
            NSLog(@"Couldn't create CGImageDestination\n");
            return NO;
        }
        for (NSImageRep *rep in arg2) {
            CGImageDestinationAddImage(destination, [rep CGImageForProposedRect:NULL context:nil hints:nil], NULL);
        }
        ok = CGImageDestinationFinalize(destination);
        if (!ok) {
            NSLog(@"Failed to finalize ICNS file %@", arg1);
        }
        CFRelease(destination);
    }
    return ok;
}

@end
