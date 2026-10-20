// DownloadProgressController.m — CrossThrough
#import "DownloadProgressController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation DownloadProgressController

- (id)initWithURL:(id)arg1 {
    self = [super initWithWindowNibName:@"DownloadProgress"];
    if (self) {
        self->_urlSession = [[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil] retain];
        self->_downloadTask = [[self->_urlSession downloadTaskWithURL:arg1] retain];
        [self->_downloadTask resume];
    }
    return self;
}

- (void)windowDidLoad {
    // The nib's caption and progress text are format strings.
    NSString *caption = [NSString stringWithFormat:[[self caption] stringValue], [[self->_downloadTask originalRequest] URL]];
    [[self caption] setStringValue:caption];
    [[self progressBar] startAnimation:self];
    [self setProgressFormat:[[self progressText] stringValue]];
}

- (id)formattedSize:(NSInteger)arg1 {
    static NSByteCountFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSByteCountFormatter alloc] init];
        [formatter setZeroPadsFractionDigits:YES];
        [formatter setFormattingContext:NSFormattingContextDynamic];
    }
    return [formatter stringFromByteCount:arg1];
}

- (void)cancel:(id)arg1 {
    [self->_downloadTask cancel];
    [self setPath:nil];
    [[self window] orderOut:self];
    [self close];
}

- (void)didPresentErrorWithRecovery:(BOOL)arg1 contextInfo:(void *)arg2 {
    [self setPath:nil];
    [[self window] orderOut:self];
    [self close];
}

- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didFinishDownloadingToURL:(id)arg3 {
    NSError *error = [arg2 error];
    if (!error && [[arg2 response] isKindOfClass:[NSHTTPURLResponse class]]) {
        NSInteger status = [(NSHTTPURLResponse *)[arg2 response] statusCode];
        if (status != 200) {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSHTTPURLResponse localizedStringForStatusCode:status]};
            error = [NSError errorWithDomain:@"HTTPStatusErrorDomain" code:status userInfo:userInfo];
        }
    }
    if (error) {
        [self URLSession:arg1 task:arg2 didCompleteWithError:error];
        return;
    }
    // The temporary download disappears when this returns; keep it under the
    // server's suggested name.
    NSURL *destination = [[[NSFileManager defaultManager] temporaryDirectory] URLByAppendingPathComponent:[[arg2 response] suggestedFilename] isDirectory:NO];
    [[NSFileManager defaultManager] moveItemAtURL:arg3 toURL:destination error:NULL];
    [self setPath:[destination path]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self window] orderOut:self];
        [self close];
    });
}

- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didWriteData:(NSInteger)arg3 totalBytesWritten:(NSInteger)arg4 totalBytesExpectedToWrite:(NSInteger)arg5 {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (arg5 == NSURLSessionTransferSizeUnknown) {
            [[self progressBar] setIndeterminate:YES];
            [[self progressText] setStringValue:[self formattedSize:arg4]];
        } else {
            [[self progressBar] setIndeterminate:NO];
            [[self progressBar] setDoubleValue:(double)arg4 / (double)arg5 * 100.0];
            [[self progressText] setStringValue:[NSString stringWithFormat:[self progressFormat], [self formattedSize:arg4], [self formattedSize:arg5]]];
        }
        [[self progressText] setHidden:NO];
    });
}

- (void)URLSession:(id)arg1 task:(id)arg2 didCompleteWithError:(id)arg3 {
    if (!arg3) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self window] presentError:arg3 modalForWindow:[self window] delegate:self didPresentSelector:@selector(didPresentErrorWithRecovery:contextInfo:) contextInfo:NULL];
    });
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

- (void)dealloc {
    [self->_path release];
    [self->_urlSession release];
    [self->_downloadTask release];
    [self->_progressFormat release];
    objc_destroyWeak((id *)&self->_caption);
    objc_destroyWeak((id *)&self->_progressBar);
    objc_destroyWeak((id *)&self->_progressText);
    [super dealloc];
}

@end
