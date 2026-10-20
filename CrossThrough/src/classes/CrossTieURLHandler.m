// CrossTieURLHandler.m — CrossThrough
#import "CrossTieURLHandler.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CrossTieURLHandler

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    objc_destroyWeak((id *)&self->_delegate);
    [self->_downloadProgress release];
    [super dealloc];
}

- (void)downloadWindowWillClose:(id)arg1 {
    if ([[self downloadProgress] path] != nil) {
        [(CXServer *)[NSApp delegate] application:NSApp openFile:[[self downloadProgress] path]];
    }
    if ([[self delegate] respondsToSelector:@selector(crossTieURLDidFinish:)]) {
        [[self delegate] crossTieURLDidFinish:self];
    }
}

- (void)doInstallWithParameters:(id)arg1 {
    NSString *crossTie = [arg1 objectForKey:@"crosstie"];
    if ([crossTie length] == 0) {
        NSLog(@"CrossTie install URL has no 'crosstie' parameter.");
        return;
    }
    NSURL *url = [NSURL URLWithString:crossTie];
    if (url == nil) {
        NSLog(@"CrossTie install URL has invalid 'crosstie' parameter: %@\n", crossTie);
        return;
    }
    DownloadProgressController *downloadProgress = [[DownloadProgressController alloc] initWithURL:url];
    [self setDownloadProgress:downloadProgress];
    [downloadProgress release];
    [[self downloadProgress] showWindow:self];
    [[[self downloadProgress] window] makeFirstResponder:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(downloadWindowWillClose:)
                                                 name:NSWindowWillCloseNotification
                                               object:[[self downloadProgress] window]];
}

- (void)handleCrossTieURL:(id)arg1 {
    NSString *resource = [arg1 resourceSpecifier];
    NSString *verb;
    NSString *query;
    NSRange separator = [resource rangeOfString:@"?"];
    if (separator.location == NSNotFound) {
        verb = resource;
        query = @"";
    } else {
        verb = [resource substringToIndex:separator.location];
        query = [resource substringFromIndex:separator.location + 1];
    }

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    for (NSString *pair in [query componentsSeparatedByString:@"&"]) {
        NSString *key;
        NSString *value;
        NSRange equals = [pair rangeOfString:@"="];
        if (equals.location == NSNotFound) {
            key = pair;
            value = @"";
        } else {
            key = [pair substringToIndex:equals.location];
            value = [pair substringFromIndex:equals.location + 1];
        }
        NSString *decodedKey = [[key stringByRemovingPercentEncoding] lowercaseString];
        NSString *decodedValue = [value stringByRemovingPercentEncoding];
        if (decodedKey != nil && decodedValue != nil) {
            [parameters setObject:decodedValue forKey:decodedKey];
        }
    }

    if ([verb caseInsensitiveCompare:@"install"] == NSOrderedSame) {
        [self doInstallWithParameters:parameters];
    } else {
        NSLog(@"Unknown verb '%@' in CrossTie URL %@\n", verb, arg1);
    }
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
