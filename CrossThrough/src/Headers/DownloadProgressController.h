// DownloadProgressController.h — CrossThrough
#ifndef DownloadProgressController_h
#define DownloadProgressController_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXWindowController.h"

@class DownloadProgressController;

@interface DownloadProgressController : CXWindowController <NSURLSessionDownloadDelegate, NSURLSessionTaskDelegate, NSURLSessionDelegate, NSObject>
{
    NSTextField * _caption;
    NSProgressIndicator * _progressBar;
    NSTextField * _progressText;
    NSString * _path;
    NSURLSession * _urlSession;
    NSURLSessionDownloadTask * _downloadTask;
    NSString * _progressFormat;
}

// Instance Methods
- (id)initWithURL:(id)arg1;
- (void)windowDidLoad;
- (id)formattedSize:(NSInteger)arg1;
- (void)cancel:(id)arg1;
- (void)didPresentErrorWithRecovery:(BOOL)arg1 contextInfo:(void *)arg2;
- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didFinishDownloadingToURL:(id)arg3;
- (void)URLSession:(id)arg1 downloadTask:(id)arg2 didWriteData:(NSInteger)arg3 totalBytesWritten:(NSInteger)arg4 totalBytesExpectedToWrite:(NSInteger)arg5;
- (void)URLSession:(id)arg1 task:(id)arg2 didCompleteWithError:(id)arg3;
- (id)caption;
- (void)setCaption:(id)arg1;
- (id)progressBar;
- (void)setProgressBar:(id)arg1;
- (id)progressText;
- (void)setProgressText:(id)arg1;
- (id)path;
- (void)setPath:(id)arg1;
- (id)urlSession;
- (void)setUrlSession:(id)arg1;
- (id)downloadTask;
- (void)setDownloadTask:(id)arg1;
- (id)progressFormat;
- (void)setProgressFormat:(id)arg1;

@end

#endif /* DownloadProgressController_h */
