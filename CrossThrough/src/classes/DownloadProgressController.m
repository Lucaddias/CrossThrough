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
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_caption);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setCaption:(id)arg1 {
    return;
}

- (id)progressBar {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressBar);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressBar:(id)arg1 {
    return;
}

- (id)progressText {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_progressText);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setProgressText:(id)arg1 {
    return;
}

- (id)path {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_path)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setPath:(id)arg1 {
    return;
}

- (id)urlSession {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_urlSession)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setUrlSession:(id)arg1 {
    return;
}

- (id)downloadTask {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_downloadTask)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setDownloadTask:(id)arg1 {
    return;
}

- (id)progressFormat {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_progressFormat)), 0x1);
     *   return r0;
     */
    return nil;
}

- (void)setProgressFormat:(id)arg1 {
    return;
}

@end
