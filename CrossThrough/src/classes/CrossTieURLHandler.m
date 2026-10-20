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
    return [objc_loadWeakRetained((id *)&self->_delegate) autorelease];
}

- (void)setDelegate:(id)arg1 {
    objc_storeWeak((id *)&self->_delegate, arg1);
}

- (id)downloadProgress {
    return [[self->_downloadProgress retain] autorelease];
}

- (void)setDownloadProgress:(id)arg1 {
    if (self->_downloadProgress != arg1) {
        [self->_downloadProgress release];
        self->_downloadProgress = [arg1 retain];
    }
}

@end
