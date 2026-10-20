// CrossTieURLHandler.h — CrossThrough
#ifndef CrossTieURLHandler_h
#define CrossTieURLHandler_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class CrossTieURLHandler;
@class DownloadProgressController;

@interface CrossTieURLHandler : NSObject
{
    id<CrossTieURLHandlerDelegate> _delegate;
    DownloadProgressController * _downloadProgress;
}

// Instance Methods
- (void)dealloc;
- (void)downloadWindowWillClose:(id)arg1;
- (void)doInstallWithParameters:(id)arg1;
- (void)handleCrossTieURL:(id)arg1;
- (id)delegate;
- (void)setDelegate:(id)arg1;
- (id)downloadProgress;
- (void)setDownloadProgress:(id)arg1;

@end

#endif /* CrossTieURLHandler_h */
