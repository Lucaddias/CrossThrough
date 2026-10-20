// DownloadProgressController.m — CrossThrough
#import "DownloadProgressController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation DownloadProgressController

- (id)initWithURL:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)windowDidLoad {
    return;
}

- (id)formattedSize:(NSInteger)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = arg2;
     *   if (*_formattedSize:.formatter == 0x0) {
     *   r0 = [[NSByteCountFormatter alloc] init];
     *   r8 = *_formattedSize:.formatter;
     *   *_formattedSize:.formatter = r0;
     *   [r8 release];
     *   [*_formattedSize:.formatter setZeroPadsFractionDigits:0x1];
     *   [*_formattedSize:.formatter setFormattingContext:0x1];
     *   }
     *   r0 = *_formattedSize:.formatter;
     *   r0 = [r0 stringFromByteCount:r19];
     *   return r0;
     */
    return nil;
}

- (void)cancel:(id)arg1 {
    return;
}

- (void)didPresentErrorWithRecovery:(BOOL)arg1 contextInfo:(void *)arg2 {
    return;
}

- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didFinishDownloadingToURL:(id)arg3 {
    return;
}

- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didWriteData:(NSInteger)arg3 totalBytesWritten:(NSInteger)arg4 totalBytesExpectedToWrite:(NSInteger)arg5 {
    return;
}

- (void)URLSession:(id)arg1 task:(id)arg2 didCompleteWithError:(id)arg3 {
    return;
}

- (id)caption {
    return [objc_loadWeakRetained((id *)&self->_caption) autorelease];
}

- (void)setCaption:(id)arg1 {
    objc_storeWeak((id *)&self->_caption, arg1);
}

- (id)progressBar {
    return [objc_loadWeakRetained((id *)&self->_progressBar) autorelease];
}

- (void)setProgressBar:(id)arg1 {
    objc_storeWeak((id *)&self->_progressBar, arg1);
}

- (id)progressText {
    return [objc_loadWeakRetained((id *)&self->_progressText) autorelease];
}

- (void)setProgressText:(id)arg1 {
    objc_storeWeak((id *)&self->_progressText, arg1);
}

- (id)path {
    return [[self->_path retain] autorelease];
}

- (void)setPath:(id)arg1 {
    if (self->_path != arg1) {
        [self->_path release];
        self->_path = [arg1 copy];
    }
}

- (id)urlSession {
    return [[self->_urlSession retain] autorelease];
}

- (void)setUrlSession:(id)arg1 {
    if (self->_urlSession != arg1) {
        [self->_urlSession release];
        self->_urlSession = [arg1 retain];
    }
}

- (id)downloadTask {
    return [[self->_downloadTask retain] autorelease];
}

- (void)setDownloadTask:(id)arg1 {
    if (self->_downloadTask != arg1) {
        [self->_downloadTask release];
        self->_downloadTask = [arg1 retain];
    }
}

- (id)progressFormat {
    return [[self->_progressFormat retain] autorelease];
}

- (void)setProgressFormat:(id)arg1 {
    if (self->_progressFormat != arg1) {
        [self->_progressFormat release];
        self->_progressFormat = [arg1 copy];
    }
}

@end
