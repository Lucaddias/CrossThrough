// DownloadProgressController — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10002daf8
// -[DownloadProgressController initWithURL:]
    r31 = r31 - 0x40;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    var_30 = self;
    r0 = [[&var_30 super] initWithWindowNibName:@"DownloadProgress"];
    r20 = r0;
    if (r0 != 0x0) {
            r22 = [[NSURLSessionConfiguration defaultSessionConfiguration] retain];
            r0 = [NSURLSession sessionWithConfiguration:r22 delegate:r20 delegateQueue:0x0];
            r0 = [r0 retain];
            r21 = sign_extend_64(*(int32_t *)ivar_offset(_urlSession));
            r8 = *(r20 + r21);
            *(r20 + r21) = r0;
            [r8 release];
            [r22 release];
            r0 = *(r20 + r21);
            r0 = [r0 downloadTaskWithURL:r19];
            r0 = [r0 retain];
            r21 = sign_extend_64(*(int32_t *)ivar_offset(_downloadTask));
            r8 = *(r20 + r21);
            *(r20 + r21) = r0;
            [r8 release];
            [*(r20 + r21) resume];
    }
    [r19 release];
    r0 = r20;
    return r0;


// 0x10002dbf8
// -[DownloadProgressController windowDidLoad]
    r0 = [self caption];
    r0 = [r0 retain];
    r20 = r0;
    r21 = [[r0 stringValue] retain];
    [r20 release];
    r0 = self->_downloadTask;
    r0 = [r0 originalRequest];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 URL] retain];
    r20 = [[NSString stringWithFormat:r21] retain];
    [r21 release];
    [r23 release];
    [r22 release];
    r0 = [self caption];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setStringValue:r20];
    [r21 release];
    r0 = [self progressBar];
    r0 = [r0 retain];
    r21 = r0;
    [r0 startAnimation:self];
    [r21 release];
    r0 = [self progressText];
    r0 = [r0 retain];
    r21 = r0;
    r22 = [[r0 stringValue] retain];
    [self setProgressFormat:r22];
    [r22 release];
    [r21 release];
    [r20 release];
    return;


// 0x10002dd48
// -[DownloadProgressController formattedSize:]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg2;
    if (*_formattedSize:.formatter == 0x0) {
            r0 = [[NSByteCountFormatter alloc] init];
            r8 = *_formattedSize:.formatter;
            *_formattedSize:.formatter = r0;
            [r8 release];
            [*_formattedSize:.formatter setZeroPadsFractionDigits:0x1];
            [*_formattedSize:.formatter setFormattingContext:0x1];
    }
    r0 = *_formattedSize:.formatter;
    r0 = [r0 stringFromByteCount:r19];
    return r0;


// 0x10002ddac
// -[DownloadProgressController cancel:]
    [self->_downloadTask cancel];
    [self setPath:0x0];
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 orderOut:self];
    [r20 release];
    [self close];
    return;


// 0x10002de0c
// -[DownloadProgressController didPresentErrorWithRecovery:contextInfo:]
    [self setPath:0x0];
    r0 = [self window];
    r0 = [r0 retain];
    r20 = r0;
    [r0 orderOut:self];
    [r20 release];
    [self close];
    return;


// 0x10002de58
// -[DownloadProgressController URLSession:downloadTask:didFinishDownloadingToURL:]
    r31 = r31 - 0xa0;
    var_50 = r28;
    decomp_var_48 = r27;
    var_40 = r26;
    decomp_var_38 = r25;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r22 = self;
    var_58 = **___stack_chk_guard;
    r19 = [arg2 retain];
    r20 = [arg3 retain];
    r21 = [arg4 retain];
    r0 = [r20 error];
    r0 = [r0 retain];
    r23 = r0;
    if (r0 != 0x0) {
            [r22 URLSession:r19 task:r20 didCompleteWithError:r23];
            [r23 release];
            [r21 release];
            [r20 release];
            [r19 release];
            if (**___stack_chk_guard != var_58) {
                    __stack_chk_fail();
            }
    }
    else {
            r23 = [[r20 response] retain];
            objc_opt_class(@class(NSHTTPURLResponse));
            r24 = objc_opt_isKindOfClass();
            [r23 release];
            if ((r24 & 0x1) != 0x0) {
                    r0 = [r20 response];
                    r0 = [r0 retain];
                    r24 = r0;
                    if ([r0 statusCode] == 0xc8) {
                            [r24 release];
                            r0 = [NSFileManager defaultManager];
                            r0 = [r0 retain];
                            r24 = r0;
                            r25 = [[r0 temporaryDirectory] retain];
                            r0 = [r20 response];
                            r0 = [r0 retain];
                            r26 = r0;
                            r27 = [[r0 suggestedFilename] retain];
                            r23 = [[r25 URLByAppendingPathComponent:r27 isDirectory:0x0] retain];
                            [r27 release];
                            [r26 release];
                            [r25 release];
                            [r24 release];
                            r0 = [NSFileManager defaultManager];
                            r0 = [r0 retain];
                            r24 = r0;
                            [r0 moveItemAtURL:r21 toURL:r23 error:0x0];
                            [r24 release];
                            r24 = [[r23 path] retain];
                            [r22 setPath:r24];
                            [r24 release];
                            var_90 = *__NSConcreteStackBlock;
                            dispatch_async(*__dispatch_main_q, &var_90);
                            [r23 release];
                            [r21 release];
                            [r20 release];
                            [r19 release];
                            if (**___stack_chk_guard != var_58) {
                                    __stack_chk_fail();
                            }
                    }
                    else {
                            r25 = [r24 statusCode];
                            var_68 = @"NSLocalizedDescriptionKey";
                            r0 = [r24 statusCode];
                            r0 = [NSHTTPURLResponse localizedStringForStatusCode:r0];
                            r0 = [r0 retain];
                            r26 = r0;
                            var_60 = r0;
                            r0 = [NSDictionary dictionaryWithObjects:&var_60 forKeys:&var_68 count:0x1];
                            r27 = [r0 retain];
                            r23 = [[NSError errorWithDomain:@"HTTPStatusErrorDomain" code:r25 userInfo:r27] retain];
                            [r27 release];
                            [r26 release];
                            [r24 release];
                            if (r23 == 0x0) {
                                    r0 = [NSFileManager defaultManager];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    r25 = [[r0 temporaryDirectory] retain];
                                    r0 = [r20 response];
                                    r0 = [r0 retain];
                                    r26 = r0;
                                    r27 = [[r0 suggestedFilename] retain];
                                    r23 = [[r25 URLByAppendingPathComponent:r27 isDirectory:0x0] retain];
                                    [r27 release];
                                    [r26 release];
                                    [r25 release];
                                    [r24 release];
                                    r0 = [NSFileManager defaultManager];
                                    r0 = [r0 retain];
                                    r24 = r0;
                                    [r0 moveItemAtURL:r21 toURL:r23 error:0x0];
                                    [r24 release];
                                    r24 = [[r23 path] retain];
                                    [r22 setPath:r24];
                                    [r24 release];
                                    var_90 = *__NSConcreteStackBlock;
                                    dispatch_async(*__dispatch_main_q, &var_90);
                                    [r23 release];
                                    [r21 release];
                                    [r20 release];
                                    [r19 release];
                                    if (**___stack_chk_guard != var_58) {
                                            __stack_chk_fail();
                                    }
                            }
                            else {
                                    [r22 URLSession:r19 task:r20 didCompleteWithError:r23];
                                    [r23 release];
                                    [r21 release];
                                    [r20 release];
                                    [r19 release];
                                    if (**___stack_chk_guard != var_58) {
                                            __stack_chk_fail();
                                    }
                            }
                    }
            }
            else {
                    r0 = [NSFileManager defaultManager];
                    r0 = [r0 retain];
                    r24 = r0;
                    r25 = [[r0 temporaryDirectory] retain];
                    r0 = [r20 response];
                    r0 = [r0 retain];
                    r26 = r0;
                    r27 = [[r0 suggestedFilename] retain];
                    r23 = [[r25 URLByAppendingPathComponent:r27 isDirectory:0x0] retain];
                    [r27 release];
                    [r26 release];
                    [r25 release];
                    [r24 release];
                    r0 = [NSFileManager defaultManager];
                    r0 = [r0 retain];
                    r24 = r0;
                    [r0 moveItemAtURL:r21 toURL:r23 error:0x0];
                    [r24 release];
                    r24 = [[r23 path] retain];
                    [r22 setPath:r24];
                    [r24 release];
                    var_90 = *__NSConcreteStackBlock;
                    dispatch_async(*__dispatch_main_q, &var_90);
                    [r23 release];
                    [r21 release];
                    [r20 release];
                    [r19 release];
                    if (**___stack_chk_guard != var_58) {
                            __stack_chk_fail();
                    }
            }
    }
    return;


// 0x10002e1b8
// -[DownloadProgressController URLSession:downloadTask:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:]
    var_38 = *__NSConcreteStackBlock;
    dispatch_async(*__dispatch_main_q, &var_38);
    return;


// 0x10002e3d8
// -[DownloadProgressController URLSession:task:didCompleteWithError:]
    r31 = r31 - 0x50;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    r0 = [arg4 retain];
    r19 = r0;
    if (r0 != 0x0) {
            var_40 = *__NSConcreteStackBlock;
            var_18 = [r19 retain];
            dispatch_async(*__dispatch_main_q, &var_40);
            [var_18 release];
    }
    [r19 release];
    return;


// 0x10002e4e0
// -[DownloadProgressController caption]
    r0 = objc_loadWeakRetained((int64_t *)&self->_caption);
    r0 = [r0 autorelease];
    return r0;


// 0x10002e500
// -[DownloadProgressController setCaption:]
    objc_storeWeak((int64_t *)&self->_caption, arg2);
    return;


// 0x10002e514
// -[DownloadProgressController progressBar]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressBar);
    r0 = [r0 autorelease];
    return r0;


// 0x10002e534
// -[DownloadProgressController setProgressBar:]
    objc_storeWeak((int64_t *)&self->_progressBar, arg2);
    return;


// 0x10002e548
// -[DownloadProgressController progressText]
    r0 = objc_loadWeakRetained((int64_t *)&self->_progressText);
    r0 = [r0 autorelease];
    return r0;


// 0x10002e568
// -[DownloadProgressController setProgressText:]
    objc_storeWeak((int64_t *)&self->_progressText, arg2);
    return;


// 0x10002e57c
// -[DownloadProgressController path]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_path)), 0x1);
    return r0;


// 0x10002e58c
// -[DownloadProgressController setPath:]
    objc_setProperty_atomic_copy();
    return;


// 0x10002e598
// -[DownloadProgressController urlSession]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_urlSession)), 0x1);
    return r0;


// 0x10002e5a8
// -[DownloadProgressController setUrlSession:]
    objc_setProperty_atomic();
    return;


// 0x10002e5b4
// -[DownloadProgressController downloadTask]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_downloadTask)), 0x1);
    return r0;


// 0x10002e5c4
// -[DownloadProgressController setDownloadTask:]
    objc_setProperty_atomic();
    return;


// 0x10002e5d0
// -[DownloadProgressController progressFormat]
    r0 = objc_getProperty(self, _cmd, sign_extend_64(*(int32_t *)ivar_offset(_progressFormat)), 0x1);
    return r0;


// 0x10002e5e0
// -[DownloadProgressController setProgressFormat:]
    objc_setProperty_atomic_copy();
    return;


// 0x10002e5ec
// -[DownloadProgressController .cxx_destruct]
    objc_storeStrong((int64_t *)&self->_progressFormat, 0x0);
    objc_storeStrong((int64_t *)&self->_downloadTask, 0x0);
    objc_storeStrong((int64_t *)&self->_urlSession, 0x0);
    objc_storeStrong((int64_t *)&self->_path, 0x0);
    objc_destroyWeak((int64_t *)&self->_progressText);
    objc_destroyWeak((int64_t *)&self->_progressBar);
    objc_destroyWeak((int64_t *)&self->_caption);
    return;


