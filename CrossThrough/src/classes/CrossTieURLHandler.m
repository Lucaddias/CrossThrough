// CrossTieURLHandler.m — CrossThrough
#import "CrossTieURLHandler.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CrossTieURLHandler

- (void)dealloc {
    return;
}

- (void)downloadWindowWillClose:(id)arg1 {
    return;
}

- (void)doInstallWithParameters:(id)arg1 {
    return;
}

- (void)handleCrossTieURL:(id)arg1 {
    return;
}

- (id)delegate {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained(self + 0x8);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setDelegate:(id)arg1 {
    return;
}

- (id)downloadProgress {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, 0x10, 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setDownloadProgress:(id)arg1 {
    return;
}

@end
