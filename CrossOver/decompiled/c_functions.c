// Standalone C functions, callbacks, and helpers — CrossOver 26.3 arm64

// 0x100009260
// ___copy_helper_block_e8_32s
    r0 = arg1[0x4];
    r0 = [r0 retain];
    return r0;


// 0x100009268
// ___destroy_helper_block_e8_32s
    r0 = arg0[0x4];
    r0 = [r0 release];
    return r0;


// 0x100009834
// ___copy_helper_block_e8_32s40s48s
    [arg1[0x4] retain];
    [arg1[0x5] retain];
    r0 = arg1[0x6];
    r0 = [r0 retain];
    return r0;


// 0x100009864
// ___destroy_helper_block_e8_32s40s48s
    [arg0[0x6] release];
    [arg0[0x5] release];
    r0 = arg0[0x4];
    r0 = [r0 release];
    return r0;


// 0x100009a30
// ___copy_helper_block_e8_32b
    r0 = _Block_object_assign(arg0 + 0x20, arg1[0x4], 0x7);
    return r0;


// 0x10000cc44
// ___copy_helper_block_e8_32s40s48s56s
    [arg1[0x4] retain];
    [arg1[0x5] retain];
    [arg1[0x6] retain];
    r0 = arg1[0x7];
    r0 = [r0 retain];
    return r0;


// 0x10000cc7c
// ___destroy_helper_block_e8_32s40s48s56s
    [arg0[0x7] release];
    [arg0[0x6] release];
    [arg0[0x5] release];
    r0 = arg0[0x4];
    r0 = [r0 release];
    return r0;


// 0x10000dd0c
// ___copy_helper_block_e8_32s40s
    [arg1[0x4] retain];
    r0 = arg1[0x5];
    r0 = [r0 retain];
    return r0;


// 0x10000dd34
// ___destroy_helper_block_e8_32s40s
    [arg0[0x5] release];
    r0 = arg0[0x4];
    r0 = [r0 release];
    return r0;


// 0x10000f3dc
// ___copy_helper_block_e8_32s40b
    [arg1[0x4] retain];
    r0 = _Block_object_assign(arg0 + 0x28, arg1[0x5], 0x7);
    return r0;


// 0x100011054
// _InstallersCacheEventStreamCallback
    r0 = [arg1 installersCacheEventStreamCallback];
    return r0;


// 0x1000120a0
// ___copy_helper_block_e8_32r
    r0 = _Block_object_assign(arg0 + 0x20, arg1[0x4], 0x8);
    return r0;


// 0x1000120b0
// ___destroy_helper_block_e8_32r
    r0 = arg0[0x4];
    r0 = _Block_object_dispose(r0, 0x8);
    return r0;


// 0x100013ae4
// sub_100013ae4
    NSLog(@"Exception when launching task: %@\n    for command: %@\n", arg1, arg2);
    r23 = [[NSAlert alloc] init];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r25 = r0;
    r21 = [[r0 localizedStringForKey:@"%@ could not open the document or program." value:@"" table:0x0] retain];
    r19 = [[NSString stringWithFormat:r21] retain];
    [r23 setMessageText:r19];
    [r19 release];
    [r21 release];
    [r25 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 localizedStringForKey:@"An error occurred when attempting to launch a new task." value:@"" table:0x0] retain];
    [r23 setInformativeText:r21];
    [r21 release];
    [r19 release];
    r0 = [NSBundle mainBundle];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [[r0 localizedStringForKey:@"OK" value:@"" table:0x0] retain];
    objc_unsafeClaimAutoreleasedReturnValue([r23 addButtonWithTitle:r21]);
    [r21 release];
    [r19 release];
    [r23 runModal];
    [arg_38 removeObserver:r24 name:0x0 object:r26];
    [r23 release];
    [r20 release];
    r0 = objc_end_catch();
    r0 = loc_100013a60(r0, r1, r2, r3);
    return r0;


// 0x100014aa0
// _observeProxyChange
    r19 = objc_autoreleasePoolPush();
    r0 = [arg2 retain];
    r20 = r0;
    [r0 setHttpProxyEnvironmentVariableFromSystemConfiguration];
    [r20 release];
    r0 = objc_autoreleasePoolPop(r19);
    return r0;


// 0x100014b0c
// sub_100014b0c
    NSLog(@"%s: ignoring exception: %@\n", arg1, arg2);
    [r20 release];
    r0 = objc_end_catch();
    r0 = loc_100014ad4(r0, r1, r2);
    return r0;


// 0x100015568
// sub_100015568
    asm { brk        #0x1 };
    return;


// 0x10002ea0c
// _initCharacterSets
    r0 = [[NSCharacterSet alloc] init];
    r8 = *_emptyCharacterSet;
    *_emptyCharacterSet = r0;
    [r8 release];
    r0 = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    r0 = [r0 retain];
    r19 = r0;
    r0 = [r0 copy];
    r8 = *_skipBetweenComponents;
    *_skipBetweenComponents = r0;
    [r8 release];
    [r19 release];
    r0 = *_skipBetweenComponents;
    r0 = [r0 mutableCopy];
    r19 = r0;
    [r0 addCharactersInString:@"\""];
    r0 = [r19 copy];
    r8 = *_delimitersOutsideOfQuotes;
    *_delimitersOutsideOfQuotes = r0;
    [r8 release];
    r0 = [NSCharacterSet characterSetWithRange:0x0];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 copy];
    r8 = *_asciiCharacterSet;
    *_asciiCharacterSet = r0;
    [r8 release];
    [r20 release];
    r0 = [NSCharacterSet characterSetWithCharactersInString:@"/\"];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 copy];
    r8 = *_pathSeparators;
    *_pathSeparators = r0;
    [r8 release];
    [r20 release];
    r0 = *_pathSeparators;
    r0 = [r0 invertedSet];
    r0 = [r0 retain];
    r20 = r0;
    r0 = [r0 copy];
    r8 = *_nonPathSeparators;
    *_nonPathSeparators = r0;
    [r8 release];
    [r20 release];
    r0 = [r19 release];
    return r0;


// 0x1000301b4
// ___copy_helper_block_e8_32w
    r0 = objc_copyWeak(arg0 + 0x20, arg1 + 0x20);
    return r0;


// 0x1000301c0
// ___destroy_helper_block_e8_32w
    r0 = objc_destroyWeak(arg0 + 0x20);
    return r0;


// 0x100033adc
// _CompareLanguageEntries
    var_40 = r26;
    decomp_var_38 = r25;
    r31 = r31 + 0xffffffffffffffb0;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = [arg0 retain];
    r21 = [arg1 retain];
    r19 = [r20 retain];
    r20 = [r21 retain];
    r21 = [[r19 objectForKey:@"canonicalLang"] retain];
    r22 = [[r20 objectForKey:@"canonicalLang"] retain];
    if (([r21 isEqualToString:r22] & 0x1) != 0x0) {
            r23 = 0x0;
    }
    else {
            if ([r21 length] != 0x0) {
                    if ([r22 length] != 0x0) {
                            r0 = [r19 objectForKey:@"rank"];
                            r0 = [r0 retain];
                            r25 = r0;
                            r24 = [r0 unsignedIntegerValue];
                            [r25 release];
                            r0 = [r20 objectForKey:@"rank"];
                            r0 = [r0 retain];
                            r23 = r0;
                            r25 = [r0 unsignedIntegerValue];
                            [r23 release];
                            if (r24 == r25) {
                                    r24 = [[r19 objectForKey:@"displayName"] retain];
                                    r25 = [[r20 objectForKey:@"displayName"] retain];
                                    r23 = [r24 localizedStandardCompare:r25];
                                    [r25 release];
                                    [r24 release];
                            }
                            else {
                                    if (r24 == 0x7fffffffffffffff) {
                                            r23 = 0x1;
                                    }
                                    else {
                                            r23 = 0xffffffffffffffff;
                                            if (r25 != 0x7fffffffffffffff) {
                                                    asm { cneg       x23, x23, hs };
                                            }
                                    }
                            }
                    }
                    else {
                            r23 = 0xffffffffffffffff;
                    }
            }
            else {
                    r23 = 0x1;
            }
    }
    [r22 release];
    [r21 release];
    [r20 release];
    [r19 release];
    [r20 release];
    [r19 release];
    r0 = r23;
    return r0;


// 0x10003a5b0
// sub_10003a5b0
    r2 = arg2;
    r1 = arg1;
    if (arg0 != 0x0) {
            NSLog(@"Exception when running installation subtask '%@'. %@\n", r1, r2);
    }
    else {
            NSLog(@"Exception when running unlabeled installation subtask. %@\n", r1);
    }
    [r21 release];
    [r20 release];
    r0 = objc_end_catch();
    r0 = loc_10003a4e8(r0, r1);
    return r0;


// 0x10003b4f4
// ___Block_byref_object_copy_
    arg0[0x5] = arg1[0x5];
    arg1[0x5] = 0x0;
    return;


// 0x10003b504
// ___Block_byref_object_dispose_
    r0 = arg0[0x5];
    r0 = [r0 release];
    return r0;


// 0x10003b7cc
// ___copy_helper_block_e8_32s40s48s56s64s72r
    [arg1[0x4] retain];
    [arg1[0x5] retain];
    [arg1[0x6] retain];
    [arg1[0x7] retain];
    [arg1[0x8] retain];
    r0 = _Block_object_assign(arg0 + 0x48, arg1[0x9], 0x8);
    return r0;


// 0x10003b820
// ___destroy_helper_block_e8_32s40s48s56s64s72r
    _Block_object_dispose(arg0[0x9], 0x8);
    [arg0[0x8] release];
    [arg0[0x7] release];
    [arg0[0x6] release];
    [arg0[0x5] release];
    r0 = arg0[0x4];
    r0 = [r0 release];
    return r0;


// 0x10003b954
// ___copy_helper_block_e8_32s40s48r
    [arg1[0x4] retain];
    [arg1[0x5] retain];
    r0 = _Block_object_assign(arg0 + 0x30, arg1[0x6], 0x8);
    return r0;


// 0x10003b990
// ___destroy_helper_block_e8_32s40s48r
    _Block_object_dispose(arg0[0x6], 0x8);
    [arg0[0x5] release];
    r0 = arg0[0x4];
    r0 = [r0 release];
    return r0;


// 0x100040318
// sub_100040318
    NSLog(@"%s: exception trying to read from connection: %@", arg1, arg2);
    [r22 release];
    r0 = objc_end_catch();
    r0 = loc_1000402c4(r0, r1, r2);
    return r0;


// 0x1000417ec
// _CXLog
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [r0 retain];
    if (getenv("CX_LOG") == 0x0) {
            if (getenv("CX_DEBUGMSG") == 0x0) {
                    if (getenv("DEBUG") != 0x0) {
                            NSLogv(r19, &arg_0);
                    }
            }
            else {
                    NSLogv(r19, &arg_0);
            }
    }
    else {
            NSLogv(r19, &arg_0);
    }
    r0 = [r19 release];
    return r0;


// 0x100046084
// ___Block_byref_object_copy__100046084
    arg0[0x5] = arg1[0x5];
    arg1[0x5] = 0x0;
    return;


// 0x100046094
// ___Block_byref_object_dispose__100046094
    r0 = arg0[0x5];
    r0 = [r0 release];
    return r0;


// 0x100046464
// ___copy_helper_block_e8_32s40s48s56r
    [arg1[0x4] retain];
    [arg1[0x5] retain];
    [arg1[0x6] retain];
    r0 = _Block_object_assign(arg0 + 0x38, arg1[0x7], 0x8);
    return r0;


// 0x1000464a8
// ___destroy_helper_block_e8_32s40s48s56r
    _Block_object_dispose(arg0[0x7], 0x8);
    [arg0[0x6] release];
    [arg0[0x5] release];
    r0 = arg0[0x4];
    r0 = [r0 release];
    return r0;


// 0x100049e9c
// sub_100049e9c
    asm { brk        #0x1 };
    return;


// 0x1000541d4
// _InitializePython
    r31 = r31 - 0x80;
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
    r19 = [r0 retain];
    r0 = [NSApplication sharedApplication];
    r0 = [r0 retain];
    r20 = r0;
    r25 = [[r0 crossOverRootURL] retain];
    [r20 release];
    r0 = [r25 URLByDeletingLastPathComponent];
    r0 = [r0 retain];
    r21 = r0;
    r0 = [r0 URLByDeletingLastPathComponent];
    r0 = [r0 retain];
    r22 = r0;
    r27 = [[r0 URLByDeletingLastPathComponent] retain];
    [r22 release];
    [r21 release];
    r21 = [[NSBundle bundleWithURL:r27] retain];
    r0 = [r25 URLByAppendingPathComponent:@"lib" isDirectory:0x1];
    r0 = [r0 retain];
    r22 = r0;
    r23 = [[r0 URLByAppendingPathComponent:@"python" isDirectory:0x1] retain];
    [r22 release];
    r0 = objc_retainAutorelease(r23);
    r22 = r0;
    setenv("PYTHONPATH", [r0 fileSystemRepresentation], 0x1);
    unsetenv("PYTHONEXECUTABLE");
    unsetenv("PYTHONHOME");
    unsetenv("PYTHONINSPECT");
    unsetenv("PYTHONSTARTUP");
    unsetenv("PYTHONUSERBASE");
    r0 = getenv("LC_CTYPE");
    r24 = r0;
    if (r0 == 0x0) {
            setenv("LC_CTYPE", "en_US.UTF-8", 0x1);
    }
    *(int32_t *)*_Py_NoUserSiteDirectory = 0x1;
    Py_SetProgramName(0x10009dd08);
    Py_InitializeEx(0x0);
    r23 = PyGILState_Ensure();
    if (r24 == 0x0) {
            unsetenv("LC_CTYPE");
    }
    r26 = [[r21 URLForResource:@"libcxsetupbase" withExtension:@"py"] retain];
    r0 = [r19 isAbsolutePath];
    var_60 = r27;
    if (r0 != 0x0) {
            r24 = [[NSURL fileURLWithPath:r19 isDirectory:0x0] retain];
    }
    else {
            r27 = [[r19 stringByDeletingPathExtension] retain];
            r28 = [[r19 pathExtension] retain];
            r24 = [[r21 URLForResource:r27 withExtension:r28] retain];
            [r28 release];
            [r27 release];
    }
    r0 = objc_retainAutorelease(r24);
    r24 = r0;
    [r0 fileSystemRepresentation];
    r0 = Py_DecodeLocale();
    var_58 = r0;
    if (r0 == 0x0) {
            [NSException raise:**_NSInternalInconsistencyException format:@"Failed to decode argv[0]."];
    }
    PySys_SetArgvEx(0x1, &var_58, 0x0);
    PyMem_RawFree();
    r0 = PyImport_ImportModule("cxutils");
    r27 = r0;
    if (r0 == 0x0) {
            PyErr_Print();
            [NSException raise:**_NSInternalInconsistencyException format:@"Failed to import cxutils module into Python.  See console for errors."];
    }
    r0 = objc_retainAutorelease(r25);
    r25 = r0;
    [r0 fileSystemRepresentation];
    r0 = PyUnicode_FromString();
    r28 = r0;
    if (r0 == 0x0) {
            PyErr_Print();
            r8 = *r27;
            if ((r8 & 0xffffffff80000000) == 0x0) {
                    *r27 = r8 - 0x1;
                    if (r8 == 0x1) {
                            _Py_Dealloc();
                    }
            }
            [NSException raise:**_NSInternalInconsistencyException format:@"Failed to create Python string for CrossOver root.  See console for errors."];
    }
    if (PyObject_SetAttrString(r27, "CX_ROOT", r28) == -0x1) {
            PyErr_Print();
            r8 = *r28;
            if ((r8 & 0xffffffff80000000) == 0x0) {
                    *r28 = r8 - 0x1;
                    if (r8 == 0x1) {
                            _Py_Dealloc();
                    }
            }
            r8 = *r27;
            if ((r8 & 0xffffffff80000000) == 0x0) {
                    *r27 = r8 - 0x1;
                    if (r8 == 0x1) {
                            _Py_Dealloc();
                    }
            }
            [NSException raise:**_NSInternalInconsistencyException format:@"Failed to set cxutils.CX_ROOT.  See console for errors."];
    }
    r8 = *r28;
    if ((r8 & 0xffffffff80000000) == 0x0) {
            *r28 = r8 - 0x1;
            if (r8 == 0x1) {
                    _Py_Dealloc();
            }
    }
    r8 = *r27;
    if ((r8 & 0xffffffff80000000) == 0x0) {
            *r27 = r8 - 0x1;
            if (r8 == 0x1) {
                    _Py_Dealloc();
            }
    }
    r0 = [r26 retain];
    r0 = objc_retainAutorelease(r0);
    r26 = r0;
    r27 = fopen([r0 fileSystemRepresentation], "r");
    r0 = [r26 lastPathComponent];
    r0 = [r0 retain];
    r0 = objc_retainAutorelease(r0);
    r20 = r0;
    r28 = PyRun_SimpleFileExFlags(r27, [r0 fileSystemRepresentation], 0x1, 0x0);
    [r20 release];
    r27 = r26;
    if (r28 == 0x0) {
            r20 = [r24 retain];
            [r26 release];
            r0 = objc_retainAutorelease(r20);
            r27 = r0;
            r20 = fopen([r0 fileSystemRepresentation], "r");
            r0 = [r27 lastPathComponent];
            r0 = [r0 retain];
            r0 = objc_retainAutorelease(r0);
            var_68 = r25;
            r25 = r24;
            r24 = r19;
            r19 = r23;
            r23 = r21;
            r21 = r22;
            r22 = r0;
            r28 = PyRun_SimpleFileExFlags(r20, [r0 fileSystemRepresentation], 0x1, 0x0);
            r0 = r22;
            r22 = r21;
            r21 = r23;
            r23 = r19;
            r19 = r24;
            r24 = r25;
            r25 = var_68;
            [r0 release];
    }
    PyGILState_Release(r23);
    if (r23 == 0x0) {
            PyEval_SaveThread();
    }
    if (r28 != 0x0) {
            [NSException raise:**_NSInternalInconsistencyException format:@"Failed to run Python script '%@'.  See console for errors."];
    }
    [r27 release];
    [r24 release];
    [r26 release];
    [r22 release];
    [r21 release];
    [var_60 release];
    [r25 release];
    r0 = [r19 release];
    return r0;


// 0x100055f28
// _boolGetterMethodFastIMP
    r19 = arg0->_installTask;
    r20 = [NSStringFromSelector(arg1) retain];
    r0 = [r19 valueForKey:r20];
    r0 = [r0 retain];
    r19 = r0;
    r21 = [r0 boolValue];
    [r19 release];
    [r20 release];
    r0 = r21;
    return r0;


// 0x100055f9c
// _boolGetterMethodIMP
    r20 = *_selectorToProperty;
    r21 = [arg0 retain];
    r19 = [NSStringFromSelector(arg1) retain];
    r20 = [[r20 objectForKey:r19] retain];
    [r19 release];
    r19 = r21->_installTask;
    [r21 release];
    r21 = [[r20 installTaskAttribute] retain];
    r0 = [r19 valueForKey:r21];
    r0 = [r0 retain];
    r19 = r0;
    r22 = [r0 boolValue];
    [r19 release];
    [r21 release];
    [r20 release];
    r0 = r22;
    return r0;


// 0x100056068
// _objectGetterMethodFastIMP
    r19 = arg0->_installTask;
    r20 = [NSStringFromSelector(arg1) retain];
    r19 = [[r19 valueForKey:r20] retain];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x1000560c4
// _objectGetterMethodIMP
    r20 = *_selectorToProperty;
    r21 = [arg0 retain];
    r19 = [NSStringFromSelector(arg1) retain];
    r20 = [[r20 objectForKey:r19] retain];
    [r19 release];
    r19 = r21->_installTask;
    [r21 release];
    r21 = [[r20 installTaskAttribute] retain];
    r19 = [[r19 valueForKey:r21] retain];
    [r21 release];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x100056180
// _boolSetterMethodIMP
    r21 = *_selectorToProperty;
    r22 = [arg0 retain];
    r20 = [NSStringFromSelector(arg1) retain];
    r21 = [[r21 objectForKey:r20] retain];
    [r20 release];
    r20 = r22->_installTask;
    [r22 release];
    r19 = [[NSNumber numberWithBool:arg2] retain];
    r22 = [[r21 installTaskAttribute] retain];
    [r20 setValue:r19 forKey:r22];
    [r22 release];
    [r19 release];
    r0 = [r21 release];
    return r0;


// 0x100056254
// _objectSetterMethodIMP
    r21 = *_selectorToProperty;
    r22 = [arg2 retain];
    r20 = [arg0 retain];
    r19 = [NSStringFromSelector(arg1) retain];
    r21 = [[r21 objectForKey:r19] retain];
    [r19 release];
    r19 = r20->_installTask;
    [r20 release];
    r20 = [[r21 installTaskAttribute] retain];
    [r19 setValue:r22 forKey:r20];
    [r22 release];
    [r20 release];
    r0 = [r21 release];
    return r0;


// 0x100059e98
// _PFMoveToApplicationsFolderIfNecessary
    var_60 = d9;
    decomp_var_58 = d8;
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
    r31 = r31 + 0xffffffffffffff90 - 0x2a0;
    var_70 = **___stack_chk_guard;
    r0 = [NSUserDefaults standardUserDefaults];
    r22 = r0;
    r0 = [r0 boolForKey:@"moveToApplicationsFolderAlertSuppress"];
    if ((r0 & 0x1) == 0x0) goto loc_100059f28;
    goto loc_100059eec;

loc_100059f28:
    r19 = [[NSBundle mainBundle] bundlePath];
    r0 = NSSearchPathForDirectoriesInDomains(0x1, 0xffff, 0x1);
    r20 = r0;
    var_240 = q0;
    var_230 = q0;
    r0 = [r0 countByEnumeratingWithState:&var_240 objects:&var_F0 count:0x10];
    if (r0 == 0x0) goto loc_100059fd4;
    goto loc_100059f70;

loc_100059eec:
    if (**___stack_chk_guard != var_70) {
            __stack_chk_fail();
    }
    return r0;

loc_100059fd4:
    r0 = [r19 pathComponents];
    r20 = r0;
    r0 = [r0 containsObject:@"Applications"];
    if ((r0 & 0x1) == 0x0) {
            var_280 = q0;
            var_270 = q0;
            r0 = [r20 countByEnumeratingWithState:&var_280 objects:&var_170 count:0x10];
            if (r0 != 0x0) {
                    r23 = r0;
                    r24 = *var_270;
                    while (true) {
                            r25 = 0x0;
                            while (true) {
                                    if (*var_270 != r24) {
                                            objc_enumerationMutation(r20);
                                    }
                                    r0 = *(var_278 + r25 * 0x8);
                                    r0 = [r0 caseInsensitiveCompare:@"SteamApps"];
                                    if (r0 == 0x0) {
                                            temp_2 = 0x0;
                                            break;
                                    }
                                    r25 = r25 + 0x1;
                                    if (r23 != r25) {
                                            continue;
                                    }
                                    temp_2 = 0x1;
                                    break;
                            }
                            if (temp_2 == 0x0) {
                                    temp_7 = 0x0;
                                    break;
                            }
                            r0 = [r20 countByEnumeratingWithState:&var_280 objects:&var_170 count:0x10];
                            r23 = r0;
                            if (r0 != 0x0) {
                                    continue;
                            }
                            temp_7 = 0x1;
                            break;
                    }
                    if (temp_7 != 0x0) {
                            r23 = [NSFileManager defaultManager];
                            var_2E4 = _IsLaunchedFromDMG(0x0);
                            r24 = [NSFileManager defaultManager];
                            r0 = NSSearchPathForDirectoriesInDomains(0x1, 0x1, 0x1);
                            r21 = r0;
                            r0 = [r0 count];
                            var_2E0 = r23;
                            if (r0 != 0x0) {
                                    r21 = [r21 objectAtIndex:0x0];
                                    r0 = [r24 fileExistsAtPath:r21 isDirectory:&var_240];
                                    if (r0 != 0x0 && var_240 != 0x0) {
                                            r24 = [r24 contentsOfDirectoryAtPath:r21 error:0x0];
                                            r25 = [NSWorkspace sharedWorkspace];
                                            var_170 = q0;
                                            var_160 = q0;
                                            r0 = [r24 countByEnumeratingWithState:&var_170 objects:&var_F0 count:0x10];
                                            if (r0 != 0x0) {
                                                    r26 = r0;
                                                    r20 = *var_160;
                                                    while (true) {
                                                            r23 = 0x0;
                                                            while (true) {
                                                                    if (*var_160 != r20) {
                                                                            objc_enumerationMutation(r24);
                                                                    }
                                                                    r0 = [r21 stringByAppendingPathComponent:*(var_168 + r23 * 0x8)];
                                                                    r0 = [r0 stringByResolvingSymlinksAndAliases];
                                                                    r0 = [r25 typeOfFile:r0 error:0x0];
                                                                    if (r0 == 0x0) {
                                                                            r23 = r23 + 0x1;
                                                                            if (r26 != r23) {
                                                                                    continue;
                                                                            }
                                                                            temp_0 = 0x0;
                                                                            break;
                                                                    }
                                                                    if ([r25 type:r0 conformsToType:**_kUTTypeApplication] != 0x0) {
                                                                            r24 = [r21 stringByResolvingSymlinksAndAliases];
                                                                            r25 = @"Move to Applications folder in your Home folder?";
                                                                            r23 = var_2E0;
                                                                            temp_0 = 0x1;
                                                                            break;
                                                                    }
                                                                    r23 = r23 + 0x1;
                                                                    if (r26 != r23) {
                                                                            continue;
                                                                    }
                                                                    temp_0 = 0x0;
                                                                    break;
                                                            }
                                                            if (temp_0 == 0x0) {
                                                                    r0 = [r24 countByEnumeratingWithState:&var_170 objects:&var_F0 count:0x10];
                                                                    r26 = r0;
                                                                    r23 = var_2E0;
                                                                    if (r0 != 0x0) {
                                                                            continue;
                                                                    }
                                                                    temp_5 = 0x0;
                                                                    break;
                                                            }
                                                            temp_5 = 0x1;
                                                            break;
                                                    }
                                                    if (temp_5 == 0x0) {
                                                            r24 = [[NSSearchPathForDirectoriesInDomains(0x1, 0x2, 0x1) lastObject] stringByResolvingSymlinksAndAliases];
                                                            r25 = @"Move to Applications folder?";
                                                    }
                                            }
                                            else {
                                                    r24 = [[NSSearchPathForDirectoriesInDomains(0x1, 0x2, 0x1) lastObject] stringByResolvingSymlinksAndAliases];
                                                    r25 = @"Move to Applications folder?";
                                            }
                                    }
                                    else {
                                            r24 = [[NSSearchPathForDirectoriesInDomains(0x1, 0x2, 0x1) lastObject] stringByResolvingSymlinksAndAliases];
                                            r25 = @"Move to Applications folder?";
                                    }
                            }
                            else {
                                    r24 = [[NSSearchPathForDirectoriesInDomains(0x1, 0x2, 0x1) lastObject] stringByResolvingSymlinksAndAliases];
                                    r25 = @"Move to Applications folder?";
                            }
                            r21 = [r24 stringByAppendingPathComponent:[r19 lastPathComponent]];
                            if ([r23 isWritableFileAtPath:r24] != 0x0) {
                                    r0 = [r23 fileExistsAtPath:r21 isDirectory:&var_281];
                                    r20 = 0x0;
                                    if (r0 != 0x0 && var_281 != 0x0) {
                                            r20 = [r23 isWritableFileAtPath:r21] ^ 0x1;
                                    }
                            }
                            else {
                                    r20 = 0x1;
                            }
                            r23 = &@selector(keyPathsForValuesAffectingCanRegister);
                            r24 = [[[NSAlert alloc] init] autorelease];
                            [r24 setMessageText:[[NSBundle mainBundle] localizedStringForKey:r25 value:@"" table:@"MoveApplication"]];
                            r25 = [[NSBundle mainBundle] localizedStringForKey:@"I can move myself to the Applications folder if you'd like." value:@"" table:@"MoveApplication"];
                            r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                            var_2D4 = r20;
                            if (r20 != 0x0) {
                                    r25 = [r25 stringByAppendingString:@" "];
                                    r25 = [r25 stringByAppendingString:[[NSBundle mainBundle] localizedStringForKey:@"Note that this will require an administrator password." value:@"" table:@"MoveApplication"]];
                                    asm { frintm     d8, d0 };
                            }
                            else {
                                    r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                                    asm { frintm     d8, d0 };
                                    if (d8 > r27[0x19b]) {
                                            r0 = NSSearchPathForDirectoriesInDomains(0xf, 0xffff, 0x1);
                                            r26 = r0;
                                            var_170 = q0;
                                            var_160 = q0;
                                            r0 = [r0 countByEnumeratingWithState:&var_170 objects:&var_F0 count:0x10];
                                            if (r0 != 0x0) {
                                                    r27 = r0;
                                                    r23 = *var_160;
                                                    while (true) {
                                                            r20 = 0x0;
                                                            while (true) {
                                                                    if (*var_160 != r23) {
                                                                            objc_enumerationMutation(r26);
                                                                    }
                                                                    if (_PathIsWithinPath(r19, *(var_168 + r20 * 0x8)) != 0x0) {
                                                                            r23 = &@selector(keyPathsForValuesAffectingCanRegister);
                                                                            r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                                                                            temp_3 = 0x1;
                                                                            break;
                                                                    }
                                                                    r20 = r20 + 0x1;
                                                                    if (r27 != r20) {
                                                                            continue;
                                                                    }
                                                                    temp_3 = 0x0;
                                                                    break;
                                                            }
                                                            if (temp_3 == 0x0) {
                                                                    r0 = [r26 countByEnumeratingWithState:&var_170 objects:&var_F0 count:0x10];
                                                                    r27 = r0;
                                                                    if (r0 != 0x0) {
                                                                            continue;
                                                                    }
                                                                    temp_8 = 0x0;
                                                                    break;
                                                            }
                                                            temp_8 = 0x1;
                                                            break;
                                                    }
                                                    if (temp_8 != 0x0) {
                                                            r25 = [r25 stringByAppendingString:@" "];
                                                            r25 = [r25 stringByAppendingString:[[NSBundle mainBundle] localizedStringForKey:@"This will keep your Downloads folder uncluttered." value:@"" table:@"MoveApplication"]];
                                                    }
                                                    else {
                                                            r23 = &@selector(keyPathsForValuesAffectingCanRegister);
                                                            r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                                                    }
                                            }
                                            else {
                                                    r23 = &@selector(keyPathsForValuesAffectingCanRegister);
                                                    r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                                            }
                                    }
                                    else {
                                            if ([[[r19 stringByDeletingLastPathComponent] lastPathComponent] isEqualToString:@"Downloads"] != 0x0) {
                                                    r25 = [r25 stringByAppendingString:@" "];
                                                    r25 = [r25 stringByAppendingString:[[NSBundle mainBundle] localizedStringForKey:@"This will keep your Downloads folder uncluttered." value:@"" table:@"MoveApplication"]];
                                            }
                                    }
                            }
                            [r24 setInformativeText:r25];
                            [r24 addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Move to Applications Folder" value:@"" table:@"MoveApplication"]];
                            [[r24 addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Do Not Move" value:@"" table:@"MoveApplication"]] setKeyEquivalent:@"\x1B"];
                            d9 = r27[0x19b];
                            if (d8 > d9) {
                                    [r24 setShowsSuppressionButton:0x1];
                                    [[[r24 suppressionButton] cell] setControlSize:0x1];
                                    r25 = [[r24 suppressionButton] cell];
                                    [NSFont smallSystemFontSize];
                                    [r25 setFont:[NSFont systemFontOfSize:r2]];
                            }
                            if (([**_NSApp isActive] & 0x1) == 0x0) {
                                    [**_NSApp activateIgnoringOtherApps:0x1];
                            }
                            r25 = [r24 runModal];
                            if (d8 > d9) {
                                    r0 = [r24 suppressionButton];
                                    r0 = [r0 state];
                                    r20 = var_2D4;
                                    if (r0 == 0x1) {
                                            [r22 setBool:0x1 forKey:@"moveToApplicationsFolderAlertSuppress"];
                                            r0 = [r22 synchronize];
                                    }
                                    if (r25 == 0x3e8) {
                                            _CXLog();
                                            if (r20 != 0x0) {
                                                    if ([r21 hasSuffix:@".app"] != 0x0) {
                                                            if ([[r21 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0x0) {
                                                                    if ([[r19 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0x0) {
                                                                            r0 = AuthorizationCreate(0x0, 0x0, 0x0, &var_280);
                                                                            if (r0 == 0x0) {
                                                                                    var_240 = 0x1;
                                                                                    r0 = AuthorizationCopyRights(var_280, &var_240, 0x0, 0x13, 0x0);
                                                                                    if (r0 != 0xffff159a) {
                                                                                            if (r0 == 0x0) {
                                                                                                    if (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges == 0x0) {
                                                                                                            r0 = dlsym(0xfffffffffffffffe, "AuthorizationExecuteWithPrivileges");
                                                                                                            *_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges = r0;
                                                                                                            if (r0 != 0x0) {
                                                                                                                    var_F0 = "-rf";
                                                                                                                    [r21 fileSystemRepresentation];
                                                                                                                    r0 = (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/bin/rm", 0x0, &var_F0, 0x0);
                                                                                                                    if (r0 != 0x0) {
                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                            r0 = [r19 runModal];
                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                    __stack_chk_fail();
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            r0 = wait(&var_1F4);
                                                                                                                            if (r0 != -0x1) {
                                                                                                                                    if ((var_1F4 & 0x7f) == 0x0) {
                                                                                                                                            var_F0 = "--noqtn";
                                                                                                                                            [r19 fileSystemRepresentation];
                                                                                                                                            [r21 fileSystemRepresentation];
                                                                                                                                            r3 = &var_F0;
                                                                                                                                            if ((*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/usr/bin/ditto", 0x0, r3, 0x0) == 0x0) {
                                                                                                                                                    r0 = wait(&var_1F4);
                                                                                                                                                    if (r0 != -0x1) {
                                                                                                                                                            if ((var_1F4 & 0xffffff7f) == 0x0) {
                                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                                                                                            _CXLog();
                                                                                                                                                                    }
                                                                                                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                                                                                                    [r21 stringQuotedForBash];
                                                                                                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                                                            r0 = [var_F0 length];
                                                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                                                                                            }
                                                                                                                                                                    }
                                                                                                                                                                    exit(0x0);
                                                                                                                                                            }
                                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                                    __stack_chk_fail();
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                                    else {
                                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                                    __stack_chk_fail();
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                            __stack_chk_fail();
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                    r0 = [r19 runModal];
                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                            __stack_chk_fail();
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            var_F0 = "-rf";
                                                                                                            [r21 fileSystemRepresentation];
                                                                                                            r0 = (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/bin/rm", 0x0, &var_F0, 0x0);
                                                                                                            if (r0 != 0x0) {
                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                    r0 = [r19 runModal];
                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                            __stack_chk_fail();
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r0 = wait(&var_1F4);
                                                                                                                    if (r0 != -0x1) {
                                                                                                                            if ((var_1F4 & 0x7f) == 0x0) {
                                                                                                                                    var_F0 = "--noqtn";
                                                                                                                                    [r19 fileSystemRepresentation];
                                                                                                                                    [r21 fileSystemRepresentation];
                                                                                                                                    r3 = &var_F0;
                                                                                                                                    if ((*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/usr/bin/ditto", 0x0, r3, 0x0) == 0x0) {
                                                                                                                                            r0 = wait(&var_1F4);
                                                                                                                                            if (r0 != -0x1) {
                                                                                                                                                    if ((var_1F4 & 0xffffff7f) == 0x0) {
                                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                                                                                    _CXLog();
                                                                                                                                                            }
                                                                                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                                                                                            [r21 stringQuotedForBash];
                                                                                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                                    r0 = [var_F0 length];
                                                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                                                                                    }
                                                                                                                                                            }
                                                                                                                                                            exit(0x0);
                                                                                                                                                    }
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                            __stack_chk_fail();
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                            r0 = [r19 runModal];
                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                    __stack_chk_fail();
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                    r0 = [r19 runModal];
                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                            r0 = _CXLog();
                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                            r0 = [r19 runModal];
                                                            if (**___stack_chk_guard != var_70) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                            else {
                                                    if ([var_2E0 fileExistsAtPath:r21] != 0x0) {
                                                            r26 = r23;
                                                            var_2D0 = q0;
                                                            var_2C0 = q0;
                                                            r0 = [NSWorkspace sharedWorkspace];
                                                            r0 = [r0 runningApplications];
                                                            r22 = r0;
                                                            r0 = [r0 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_1f0 count:0x10];
                                                            if (r0 != 0x0) {
                                                                    r23 = r0;
                                                                    r24 = *var_2C0;
                                                                    while (true) {
                                                                            r25 = 0x0;
                                                                            while (true) {
                                                                                    if (*var_2C0 != r24) {
                                                                                            objc_enumerationMutation(r22);
                                                                                    }
                                                                                    r0 = *(var_2C8 + r25 * 0x8);
                                                                                    r0 = [r0 executableURL];
                                                                                    r0 = [r0 path];
                                                                                    r0 = _PathIsWithinPath(r0, r21);
                                                                                    if ((r0 & 0x1) != 0x0) {
                                                                                            _CXLog();
                                                                                            r0 = [NSWorkspace sharedWorkspace];
                                                                                            r0 = [r0 openFile:r21];
                                                                                            temp_4 = 0x1;
                                                                                            break;
                                                                                    }
                                                                                    r25 = r25 + 0x1;
                                                                                    if (r23 != r25) {
                                                                                            continue;
                                                                                    }
                                                                                    temp_4 = 0x0;
                                                                                    break;
                                                                            }
                                                                            if (temp_4 == 0x0) {
                                                                                    r0 = [r22 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_1f0 count:0x10];
                                                                                    r23 = r0;
                                                                                    if (r0 != 0x0) {
                                                                                            continue;
                                                                                    }
                                                                                    temp_9 = 0x0;
                                                                                    break;
                                                                            }
                                                                            temp_9 = 0x1;
                                                                            break;
                                                                    }
                                                                    if (temp_9 != 0x0) {
                                                                            exit(0x0);
                                                                    }
                                                                    r23 = r26;
                                                                    if (_Trash(r21) != 0x0) {
                                                                            r25 = r23;
                                                                            r0 = [NSFileManager defaultManager];
                                                                            r22 = r0;
                                                                            r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                                            r23 = **_NSFileSystemNumber;
                                                                            if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                                    var_F0 = 0x0;
                                                                                    r4 = &var_F0;
                                                                                    r3 = r21;
                                                                                    if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    _CXLog();
                                                                                    r22 = [r19 fileSystemRepresentation];
                                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                                    r2 = [r21 lastPathComponent];
                                                                                    r1 = r23;
                                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                                    if (r0 == 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                    _CXLog();
                                                                                            }
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                                    r23 = r25;
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    _CXLog();
                                                                                    r22 = [r19 fileSystemRepresentation];
                                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                                    r2 = [r21 lastPathComponent];
                                                                                    r1 = r23;
                                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                                    if (r0 == 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                    _CXLog();
                                                                                            }
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                                    r23 = r25;
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    r23 = r26;
                                                                    if (_Trash(r21) != 0x0) {
                                                                            r25 = r23;
                                                                            r0 = [NSFileManager defaultManager];
                                                                            r22 = r0;
                                                                            r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                                            r23 = **_NSFileSystemNumber;
                                                                            if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                                    var_F0 = 0x0;
                                                                                    r4 = &var_F0;
                                                                                    r3 = r21;
                                                                                    if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    _CXLog();
                                                                                    r22 = [r19 fileSystemRepresentation];
                                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                                    r2 = [r21 lastPathComponent];
                                                                                    r1 = r23;
                                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                                    if (r0 == 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                    _CXLog();
                                                                                            }
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                                    r23 = r25;
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    _CXLog();
                                                                                    r22 = [r19 fileSystemRepresentation];
                                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                                    r2 = [r21 lastPathComponent];
                                                                                    r1 = r23;
                                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                                    if (r0 == 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                    _CXLog();
                                                                                            }
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                                    r23 = r25;
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            r25 = r23;
                                                            r0 = [NSFileManager defaultManager];
                                                            r22 = r0;
                                                            r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                            r23 = **_NSFileSystemNumber;
                                                            if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                    var_F0 = 0x0;
                                                                    r4 = &var_F0;
                                                                    r3 = r21;
                                                                    if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                            [r21 stringQuotedForBash];
                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [var_F0 length];
                                                                                    if (r0 != 0x0) {
                                                                                            [var_F0 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                    }
                                                                            }
                                                                            exit(0x0);
                                                                    }
                                                                    _CXLog();
                                                                    r22 = [r19 fileSystemRepresentation];
                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                    r2 = [r21 lastPathComponent];
                                                                    r1 = r23;
                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                    if (r0 == 0x0) {
                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                    _CXLog();
                                                                            }
                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                            [r21 stringQuotedForBash];
                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [var_F0 length];
                                                                                    if (r0 != 0x0) {
                                                                                            [var_F0 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                    }
                                                                            }
                                                                            exit(0x0);
                                                                    }
                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                    r23 = r25;
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    _CXLog();
                                                                    r22 = [r19 fileSystemRepresentation];
                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                    r2 = [r21 lastPathComponent];
                                                                    r1 = r23;
                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                    if (r0 == 0x0) {
                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                    _CXLog();
                                                                            }
                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                            [r21 stringQuotedForBash];
                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [var_F0 length];
                                                                                    if (r0 != 0x0) {
                                                                                            [var_F0 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                    }
                                                                            }
                                                                            exit(0x0);
                                                                    }
                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                    r23 = r25;
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != var_70) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                            else {
                                    r20 = var_2D4;
                                    if (r25 == 0x3e8) {
                                            _CXLog();
                                            if (r20 != 0x0) {
                                                    if ([r21 hasSuffix:@".app"] != 0x0) {
                                                            if ([[r21 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0x0) {
                                                                    if ([[r19 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0x0) {
                                                                            r0 = AuthorizationCreate(0x0, 0x0, 0x0, &var_280);
                                                                            if (r0 == 0x0) {
                                                                                    var_240 = 0x1;
                                                                                    r0 = AuthorizationCopyRights(var_280, &var_240, 0x0, 0x13, 0x0);
                                                                                    if (r0 != 0xffff159a) {
                                                                                            if (r0 == 0x0) {
                                                                                                    if (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges == 0x0) {
                                                                                                            r0 = dlsym(0xfffffffffffffffe, "AuthorizationExecuteWithPrivileges");
                                                                                                            *_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges = r0;
                                                                                                            if (r0 != 0x0) {
                                                                                                                    var_F0 = "-rf";
                                                                                                                    [r21 fileSystemRepresentation];
                                                                                                                    r0 = (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/bin/rm", 0x0, &var_F0, 0x0);
                                                                                                                    if (r0 != 0x0) {
                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                            r0 = [r19 runModal];
                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                    __stack_chk_fail();
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            r0 = wait(&var_1F4);
                                                                                                                            if (r0 != -0x1) {
                                                                                                                                    if ((var_1F4 & 0x7f) == 0x0) {
                                                                                                                                            var_F0 = "--noqtn";
                                                                                                                                            [r19 fileSystemRepresentation];
                                                                                                                                            [r21 fileSystemRepresentation];
                                                                                                                                            r3 = &var_F0;
                                                                                                                                            if ((*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/usr/bin/ditto", 0x0, r3, 0x0) == 0x0) {
                                                                                                                                                    r0 = wait(&var_1F4);
                                                                                                                                                    if (r0 != -0x1) {
                                                                                                                                                            if ((var_1F4 & 0xffffff7f) == 0x0) {
                                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                                                                                            _CXLog();
                                                                                                                                                                    }
                                                                                                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                                                                                                    [r21 stringQuotedForBash];
                                                                                                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                                                            r0 = [var_F0 length];
                                                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                                                                                            }
                                                                                                                                                                    }
                                                                                                                                                                    exit(0x0);
                                                                                                                                                            }
                                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                                    __stack_chk_fail();
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                                    else {
                                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                                    __stack_chk_fail();
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                            __stack_chk_fail();
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                    r0 = [r19 runModal];
                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                            __stack_chk_fail();
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            var_F0 = "-rf";
                                                                                                            [r21 fileSystemRepresentation];
                                                                                                            r0 = (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/bin/rm", 0x0, &var_F0, 0x0);
                                                                                                            if (r0 != 0x0) {
                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                    r0 = [r19 runModal];
                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                            __stack_chk_fail();
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r0 = wait(&var_1F4);
                                                                                                                    if (r0 != -0x1) {
                                                                                                                            if ((var_1F4 & 0x7f) == 0x0) {
                                                                                                                                    var_F0 = "--noqtn";
                                                                                                                                    [r19 fileSystemRepresentation];
                                                                                                                                    [r21 fileSystemRepresentation];
                                                                                                                                    r3 = &var_F0;
                                                                                                                                    if ((*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/usr/bin/ditto", 0x0, r3, 0x0) == 0x0) {
                                                                                                                                            r0 = wait(&var_1F4);
                                                                                                                                            if (r0 != -0x1) {
                                                                                                                                                    if ((var_1F4 & 0xffffff7f) == 0x0) {
                                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                                                                                    _CXLog();
                                                                                                                                                            }
                                                                                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                                                                                            [r21 stringQuotedForBash];
                                                                                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                                    r0 = [var_F0 length];
                                                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                                                                                    }
                                                                                                                                                            }
                                                                                                                                                            exit(0x0);
                                                                                                                                                    }
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                            __stack_chk_fail();
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                            r0 = [r19 runModal];
                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                    __stack_chk_fail();
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                    r0 = [r19 runModal];
                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                            __stack_chk_fail();
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                            r0 = _CXLog();
                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                            r0 = [r19 runModal];
                                                            if (**___stack_chk_guard != var_70) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                            else {
                                                    if ([var_2E0 fileExistsAtPath:r21] != 0x0) {
                                                            r26 = r23;
                                                            var_2D0 = q0;
                                                            var_2C0 = q0;
                                                            r0 = [NSWorkspace sharedWorkspace];
                                                            r0 = [r0 runningApplications];
                                                            r22 = r0;
                                                            r0 = [r0 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_1f0 count:0x10];
                                                            if (r0 != 0x0) {
                                                                    r23 = r0;
                                                                    r24 = *var_2C0;
                                                                    while (true) {
                                                                            r25 = 0x0;
                                                                            while (true) {
                                                                                    if (*var_2C0 != r24) {
                                                                                            objc_enumerationMutation(r22);
                                                                                    }
                                                                                    r0 = *(var_2C8 + r25 * 0x8);
                                                                                    r0 = [r0 executableURL];
                                                                                    r0 = [r0 path];
                                                                                    r0 = _PathIsWithinPath(r0, r21);
                                                                                    if ((r0 & 0x1) != 0x0) {
                                                                                            _CXLog();
                                                                                            r0 = [NSWorkspace sharedWorkspace];
                                                                                            r0 = [r0 openFile:r21];
                                                                                            temp_4 = 0x1;
                                                                                            break;
                                                                                    }
                                                                                    r25 = r25 + 0x1;
                                                                                    if (r23 != r25) {
                                                                                            continue;
                                                                                    }
                                                                                    temp_4 = 0x0;
                                                                                    break;
                                                                            }
                                                                            if (temp_4 == 0x0) {
                                                                                    r0 = [r22 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_1f0 count:0x10];
                                                                                    r23 = r0;
                                                                                    if (r0 != 0x0) {
                                                                                            continue;
                                                                                    }
                                                                                    temp_9 = 0x0;
                                                                                    break;
                                                                            }
                                                                            temp_9 = 0x1;
                                                                            break;
                                                                    }
                                                                    if (temp_9 != 0x0) {
                                                                            exit(0x0);
                                                                    }
                                                                    r23 = r26;
                                                                    if (_Trash(r21) != 0x0) {
                                                                            r25 = r23;
                                                                            r0 = [NSFileManager defaultManager];
                                                                            r22 = r0;
                                                                            r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                                            r23 = **_NSFileSystemNumber;
                                                                            if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                                    var_F0 = 0x0;
                                                                                    r4 = &var_F0;
                                                                                    r3 = r21;
                                                                                    if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    _CXLog();
                                                                                    r22 = [r19 fileSystemRepresentation];
                                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                                    r2 = [r21 lastPathComponent];
                                                                                    r1 = r23;
                                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                                    if (r0 == 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                    _CXLog();
                                                                                            }
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                                    r23 = r25;
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    _CXLog();
                                                                                    r22 = [r19 fileSystemRepresentation];
                                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                                    r2 = [r21 lastPathComponent];
                                                                                    r1 = r23;
                                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                                    if (r0 == 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                    _CXLog();
                                                                                            }
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                                    r23 = r25;
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    r23 = r26;
                                                                    if (_Trash(r21) != 0x0) {
                                                                            r25 = r23;
                                                                            r0 = [NSFileManager defaultManager];
                                                                            r22 = r0;
                                                                            r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                                            r23 = **_NSFileSystemNumber;
                                                                            if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                                    var_F0 = 0x0;
                                                                                    r4 = &var_F0;
                                                                                    r3 = r21;
                                                                                    if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    _CXLog();
                                                                                    r22 = [r19 fileSystemRepresentation];
                                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                                    r2 = [r21 lastPathComponent];
                                                                                    r1 = r23;
                                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                                    if (r0 == 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                    _CXLog();
                                                                                            }
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                                    r23 = r25;
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    _CXLog();
                                                                                    r22 = [r19 fileSystemRepresentation];
                                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                                    r2 = [r21 lastPathComponent];
                                                                                    r1 = r23;
                                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                                    if (r0 == 0x0) {
                                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                    _CXLog();
                                                                                            }
                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                            [r21 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                            if (r0 != 0x0) {
                                                                                                    r0 = [var_F0 length];
                                                                                                    if (r0 != 0x0) {
                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                    }
                                                                                            }
                                                                                            exit(0x0);
                                                                                    }
                                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                                    r23 = r25;
                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                    r0 = [r19 runModal];
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            r25 = r23;
                                                            r0 = [NSFileManager defaultManager];
                                                            r22 = r0;
                                                            r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                            r23 = **_NSFileSystemNumber;
                                                            if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                    var_F0 = 0x0;
                                                                    r4 = &var_F0;
                                                                    r3 = r21;
                                                                    if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                            [r21 stringQuotedForBash];
                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [var_F0 length];
                                                                                    if (r0 != 0x0) {
                                                                                            [var_F0 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                    }
                                                                            }
                                                                            exit(0x0);
                                                                    }
                                                                    _CXLog();
                                                                    r22 = [r19 fileSystemRepresentation];
                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                    r2 = [r21 lastPathComponent];
                                                                    r1 = r23;
                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                    if (r0 == 0x0) {
                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                    _CXLog();
                                                                            }
                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                            [r21 stringQuotedForBash];
                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [var_F0 length];
                                                                                    if (r0 != 0x0) {
                                                                                            [var_F0 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                    }
                                                                            }
                                                                            exit(0x0);
                                                                    }
                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                    r23 = r25;
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    _CXLog();
                                                                    r22 = [r19 fileSystemRepresentation];
                                                                    r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                    r2 = [r21 lastPathComponent];
                                                                    r1 = r23;
                                                                    r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                    if (r0 == 0x0) {
                                                                            [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                    _CXLog();
                                                                            }
                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                            [r21 stringQuotedForBash];
                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                            if (r0 != 0x0) {
                                                                                    r0 = [var_F0 length];
                                                                                    if (r0 != 0x0) {
                                                                                            [var_F0 stringQuotedForBash];
                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                    }
                                                                            }
                                                                            exit(0x0);
                                                                    }
                                                                    NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                    NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                    r23 = r25;
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[NSBundle mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                            }
                                    }
                                    else {
                                            [r22 setBool:0x1 forKey:@"moveToApplicationsFolderAlertSuppress"];
                                            r0 = [r22 synchronize];
                                            if (**___stack_chk_guard != var_70) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                    }
                    else {
                            if (**___stack_chk_guard != var_70) {
                                    __stack_chk_fail();
                            }
                    }
            }
            else {
                    r23 = [NSFileManager defaultManager];
                    var_2E4 = _IsLaunchedFromDMG(0x0);
                    r24 = [NSFileManager defaultManager];
                    r0 = NSSearchPathForDirectoriesInDomains(0x1, 0x1, 0x1);
                    r21 = r0;
                    r0 = [r0 count];
                    var_2E0 = r23;
                    if (r0 != 0x0) {
                            r21 = [r21 objectAtIndex:0x0];
                            r0 = [r24 fileExistsAtPath:r21 isDirectory:&var_240];
                            if (r0 != 0x0 && var_240 != 0x0) {
                                    r24 = [r24 contentsOfDirectoryAtPath:r21 error:0x0];
                                    r25 = [NSWorkspace sharedWorkspace];
                                    var_170 = q0;
                                    var_160 = q0;
                                    r0 = [r24 countByEnumeratingWithState:&var_170 objects:&var_F0 count:0x10];
                                    if (r0 != 0x0) {
                                            r26 = r0;
                                            r20 = *var_160;
                                            while (true) {
                                                    r23 = 0x0;
                                                    while (true) {
                                                            if (*var_160 != r20) {
                                                                    objc_enumerationMutation(r24);
                                                            }
                                                            r0 = [r21 stringByAppendingPathComponent:*(var_168 + r23 * 0x8)];
                                                            r0 = [r0 stringByResolvingSymlinksAndAliases];
                                                            r0 = [r25 typeOfFile:r0 error:0x0];
                                                            if (r0 == 0x0) {
                                                                    r23 = r23 + 0x1;
                                                                    if (r26 != r23) {
                                                                            continue;
                                                                    }
                                                                    temp_0 = 0x0;
                                                                    break;
                                                            }
                                                            if ([r25 type:r0 conformsToType:**_kUTTypeApplication] != 0x0) {
                                                                    r24 = [r21 stringByResolvingSymlinksAndAliases];
                                                                    r25 = @"Move to Applications folder in your Home folder?";
                                                                    r23 = var_2E0;
                                                                    temp_0 = 0x1;
                                                                    break;
                                                            }
                                                            r23 = r23 + 0x1;
                                                            if (r26 != r23) {
                                                                    continue;
                                                            }
                                                            temp_0 = 0x0;
                                                            break;
                                                    }
                                                    if (temp_0 == 0x0) {
                                                            r0 = [r24 countByEnumeratingWithState:&var_170 objects:&var_F0 count:0x10];
                                                            r26 = r0;
                                                            r23 = var_2E0;
                                                            if (r0 != 0x0) {
                                                                    continue;
                                                            }
                                                            temp_5 = 0x0;
                                                            break;
                                                    }
                                                    temp_5 = 0x1;
                                                    break;
                                            }
                                            if (temp_5 == 0x0) {
                                                    r24 = [[NSSearchPathForDirectoriesInDomains(0x1, 0x2, 0x1) lastObject] stringByResolvingSymlinksAndAliases];
                                                    r25 = @"Move to Applications folder?";
                                            }
                                    }
                                    else {
                                            r24 = [[NSSearchPathForDirectoriesInDomains(0x1, 0x2, 0x1) lastObject] stringByResolvingSymlinksAndAliases];
                                            r25 = @"Move to Applications folder?";
                                    }
                            }
                            else {
                                    r24 = [[NSSearchPathForDirectoriesInDomains(0x1, 0x2, 0x1) lastObject] stringByResolvingSymlinksAndAliases];
                                    r25 = @"Move to Applications folder?";
                            }
                    }
                    else {
                            r24 = [[NSSearchPathForDirectoriesInDomains(0x1, 0x2, 0x1) lastObject] stringByResolvingSymlinksAndAliases];
                            r25 = @"Move to Applications folder?";
                    }
                    r21 = [r24 stringByAppendingPathComponent:[r19 lastPathComponent]];
                    if ([r23 isWritableFileAtPath:r24] != 0x0) {
                            r0 = [r23 fileExistsAtPath:r21 isDirectory:&var_281];
                            r20 = 0x0;
                            if (r0 != 0x0 && var_281 != 0x0) {
                                    r20 = [r23 isWritableFileAtPath:r21] ^ 0x1;
                            }
                    }
                    else {
                            r20 = 0x1;
                    }
                    r23 = &@selector(keyPathsForValuesAffectingCanRegister);
                    r24 = [[[NSAlert alloc] init] autorelease];
                    [r24 setMessageText:[[NSBundle mainBundle] localizedStringForKey:r25 value:@"" table:@"MoveApplication"]];
                    r25 = [[NSBundle mainBundle] localizedStringForKey:@"I can move myself to the Applications folder if you'd like." value:@"" table:@"MoveApplication"];
                    r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                    var_2D4 = r20;
                    if (r20 != 0x0) {
                            r25 = [r25 stringByAppendingString:@" "];
                            r25 = [r25 stringByAppendingString:[[NSBundle mainBundle] localizedStringForKey:@"Note that this will require an administrator password." value:@"" table:@"MoveApplication"]];
                            asm { frintm     d8, d0 };
                    }
                    else {
                            r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                            asm { frintm     d8, d0 };
                            if (d8 > r27[0x19b]) {
                                    r0 = NSSearchPathForDirectoriesInDomains(0xf, 0xffff, 0x1);
                                    r26 = r0;
                                    var_170 = q0;
                                    var_160 = q0;
                                    r0 = [r0 countByEnumeratingWithState:&var_170 objects:&var_F0 count:0x10];
                                    if (r0 != 0x0) {
                                            r27 = r0;
                                            r23 = *var_160;
                                            while (true) {
                                                    r20 = 0x0;
                                                    while (true) {
                                                            if (*var_160 != r23) {
                                                                    objc_enumerationMutation(r26);
                                                            }
                                                            if (_PathIsWithinPath(r19, *(var_168 + r20 * 0x8)) != 0x0) {
                                                                    r23 = &@selector(keyPathsForValuesAffectingCanRegister);
                                                                    r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                                                                    temp_3 = 0x1;
                                                                    break;
                                                            }
                                                            r20 = r20 + 0x1;
                                                            if (r27 != r20) {
                                                                    continue;
                                                            }
                                                            temp_3 = 0x0;
                                                            break;
                                                    }
                                                    if (temp_3 == 0x0) {
                                                            r0 = [r26 countByEnumeratingWithState:&var_170 objects:&var_F0 count:0x10];
                                                            r27 = r0;
                                                            if (r0 != 0x0) {
                                                                    continue;
                                                            }
                                                            temp_8 = 0x0;
                                                            break;
                                                    }
                                                    temp_8 = 0x1;
                                                    break;
                                            }
                                            if (temp_8 != 0x0) {
                                                    r25 = [r25 stringByAppendingString:@" "];
                                                    r25 = [r25 stringByAppendingString:[[NSBundle mainBundle] localizedStringForKey:@"This will keep your Downloads folder uncluttered." value:@"" table:@"MoveApplication"]];
                                            }
                                            else {
                                                    r23 = &@selector(keyPathsForValuesAffectingCanRegister);
                                                    r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                                            }
                                    }
                                    else {
                                            r23 = &@selector(keyPathsForValuesAffectingCanRegister);
                                            r27 = "ion\"16@\"NSURLSessionDownloadTask\"24@\"NSURL\"32";
                                    }
                            }
                            else {
                                    if ([[[r19 stringByDeletingLastPathComponent] lastPathComponent] isEqualToString:@"Downloads"] != 0x0) {
                                            r25 = [r25 stringByAppendingString:@" "];
                                            r25 = [r25 stringByAppendingString:[[NSBundle mainBundle] localizedStringForKey:@"This will keep your Downloads folder uncluttered." value:@"" table:@"MoveApplication"]];
                                    }
                            }
                    }
                    r28 = &@selector(keyPathsForValuesAffectingCanRegister);
                    [r24 setInformativeText:r25];
                    [r24 addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Move to Applications Folder" value:@"" table:@"MoveApplication"]];
                    [[r24 addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Do Not Move" value:@"" table:@"MoveApplication"]] setKeyEquivalent:@"\x1B"];
                    d9 = r27[0x19b];
                    if (d8 > d9) {
                            [r24 setShowsSuppressionButton:0x1];
                            [[[r24 suppressionButton] cell] setControlSize:0x1];
                            r25 = [[r24 suppressionButton] cell];
                            [NSFont smallSystemFontSize];
                            [r25 setFont:[NSFont systemFontOfSize:r2]];
                    }
                    if (([**_NSApp isActive] & 0x1) == 0x0) {
                            [**_NSApp activateIgnoringOtherApps:0x1];
                    }
                    r25 = [r24 runModal];
                    if (d8 > d9) {
                            r0 = [r24 suppressionButton];
                            r0 = [r0 state];
                            r20 = var_2D4;
                            if (r0 == 0x1) {
                                    [r22 setBool:0x1 forKey:@"moveToApplicationsFolderAlertSuppress"];
                                    r0 = [r22 synchronize];
                            }
                            if (r25 == 0x3e8) {
                                    _CXLog();
                                    if (r20 != 0x0) {
                                            if ([r21 hasSuffix:@".app"] != 0x0) {
                                                    if ([[r21 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0x0) {
                                                            if ([[r19 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0x0) {
                                                                    r0 = AuthorizationCreate(0x0, 0x0, 0x0, &var_280);
                                                                    if (r0 == 0x0) {
                                                                            var_240 = 0x1;
                                                                            r0 = AuthorizationCopyRights(var_280, &var_240, 0x0, 0x13, 0x0);
                                                                            if (r0 != 0xffff159a) {
                                                                                    if (r0 == 0x0) {
                                                                                            if (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges == 0x0) {
                                                                                                    r0 = dlsym(0xfffffffffffffffe, "AuthorizationExecuteWithPrivileges");
                                                                                                    *_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges = r0;
                                                                                                    if (r0 != 0x0) {
                                                                                                            var_F0 = "-rf";
                                                                                                            [r21 fileSystemRepresentation];
                                                                                                            r0 = (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/bin/rm", 0x0, &var_F0, 0x0);
                                                                                                            if (r0 != 0x0) {
                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                    r0 = [r19 runModal];
                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                            __stack_chk_fail();
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r0 = wait(&var_1F4);
                                                                                                                    if (r0 != -0x1) {
                                                                                                                            if ((var_1F4 & 0x7f) == 0x0) {
                                                                                                                                    var_F0 = "--noqtn";
                                                                                                                                    [r19 fileSystemRepresentation];
                                                                                                                                    [r21 fileSystemRepresentation];
                                                                                                                                    r3 = &var_F0;
                                                                                                                                    if ((*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/usr/bin/ditto", 0x0, r3, 0x0) == 0x0) {
                                                                                                                                            r0 = wait(&var_1F4);
                                                                                                                                            if (r0 != -0x1) {
                                                                                                                                                    if ((var_1F4 & 0xffffff7f) == 0x0) {
                                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                                                                                    _CXLog();
                                                                                                                                                            }
                                                                                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                                                                                            [r21 stringQuotedForBash];
                                                                                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                                    r0 = [var_F0 length];
                                                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                                                                                    }
                                                                                                                                                            }
                                                                                                                                                            exit(0x0);
                                                                                                                                                    }
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                            __stack_chk_fail();
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                            r0 = [r19 runModal];
                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                    __stack_chk_fail();
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                            r0 = [r19 runModal];
                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                    __stack_chk_fail();
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    var_F0 = "-rf";
                                                                                                    [r21 fileSystemRepresentation];
                                                                                                    r0 = (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/bin/rm", 0x0, &var_F0, 0x0);
                                                                                                    if (r0 != 0x0) {
                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                            r0 = [r19 runModal];
                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                    __stack_chk_fail();
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r0 = wait(&var_1F4);
                                                                                                            if (r0 != -0x1) {
                                                                                                                    if ((var_1F4 & 0x7f) == 0x0) {
                                                                                                                            var_F0 = "--noqtn";
                                                                                                                            [r19 fileSystemRepresentation];
                                                                                                                            [r21 fileSystemRepresentation];
                                                                                                                            r3 = &var_F0;
                                                                                                                            if ((*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/usr/bin/ditto", 0x0, r3, 0x0) == 0x0) {
                                                                                                                                    r0 = wait(&var_1F4);
                                                                                                                                    if (r0 != -0x1) {
                                                                                                                                            if ((var_1F4 & 0xffffff7f) == 0x0) {
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                                                                            _CXLog();
                                                                                                                                                    }
                                                                                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                                                                                    [r21 stringQuotedForBash];
                                                                                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                                            r0 = [var_F0 length];
                                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                                    exit(0x0);
                                                                                                                                            }
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                            __stack_chk_fail();
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                            r0 = [r19 runModal];
                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                    __stack_chk_fail();
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                    r0 = [r19 runModal];
                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                            __stack_chk_fail();
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                            r0 = [r19 runModal];
                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                    r0 = _CXLog();
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                            r0 = [r19 runModal];
                                                            if (**___stack_chk_guard != var_70) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                            else {
                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                    r0 = [r19 runModal];
                                                    if (**___stack_chk_guard != var_70) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if ([var_2E0 fileExistsAtPath:r21] != 0x0) {
                                                    r26 = r23;
                                                    var_2D0 = q0;
                                                    var_2C0 = q0;
                                                    r0 = [NSWorkspace sharedWorkspace];
                                                    r0 = [r0 runningApplications];
                                                    r22 = r0;
                                                    r0 = [r0 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_1f0 count:0x10];
                                                    if (r0 != 0x0) {
                                                            r23 = r0;
                                                            r24 = *var_2C0;
                                                            while (true) {
                                                                    r25 = 0x0;
                                                                    while (true) {
                                                                            if (*var_2C0 != r24) {
                                                                                    objc_enumerationMutation(r22);
                                                                            }
                                                                            r0 = *(var_2C8 + r25 * 0x8);
                                                                            r0 = [r0 executableURL];
                                                                            r0 = [r0 path];
                                                                            r0 = _PathIsWithinPath(r0, r21);
                                                                            if ((r0 & 0x1) != 0x0) {
                                                                                    _CXLog();
                                                                                    r0 = [NSWorkspace sharedWorkspace];
                                                                                    r0 = [r0 openFile:r21];
                                                                                    temp_4 = 0x1;
                                                                                    break;
                                                                            }
                                                                            r25 = r25 + 0x1;
                                                                            if (r23 != r25) {
                                                                                    continue;
                                                                            }
                                                                            temp_4 = 0x0;
                                                                            break;
                                                                    }
                                                                    if (temp_4 == 0x0) {
                                                                            r0 = [r22 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_1f0 count:0x10];
                                                                            r23 = r0;
                                                                            if (r0 != 0x0) {
                                                                                    continue;
                                                                            }
                                                                            temp_9 = 0x0;
                                                                            break;
                                                                    }
                                                                    temp_9 = 0x1;
                                                                    break;
                                                            }
                                                            if (temp_9 != 0x0) {
                                                                    exit(0x0);
                                                            }
                                                            r23 = r26;
                                                            if (_Trash(r21) != 0x0) {
                                                                    r25 = r23;
                                                                    r0 = [NSFileManager defaultManager];
                                                                    r22 = r0;
                                                                    r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                                    r23 = **_NSFileSystemNumber;
                                                                    if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                            var_F0 = 0x0;
                                                                            r4 = &var_F0;
                                                                            r3 = r21;
                                                                            if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            _CXLog();
                                                                            r22 = [r19 fileSystemRepresentation];
                                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                            r2 = [r21 lastPathComponent];
                                                                            r1 = r23;
                                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                            if (r0 == 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                            _CXLog();
                                                                                    }
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                            r23 = r25;
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                                    else {
                                                                            _CXLog();
                                                                            r22 = [r19 fileSystemRepresentation];
                                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                            r2 = [r21 lastPathComponent];
                                                                            r1 = r23;
                                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                            if (r0 == 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                            _CXLog();
                                                                                    }
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                            r23 = r25;
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            r23 = r26;
                                                            if (_Trash(r21) != 0x0) {
                                                                    r25 = r23;
                                                                    r0 = [NSFileManager defaultManager];
                                                                    r22 = r0;
                                                                    r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                                    r23 = **_NSFileSystemNumber;
                                                                    if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                            var_F0 = 0x0;
                                                                            r4 = &var_F0;
                                                                            r3 = r21;
                                                                            if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            _CXLog();
                                                                            r22 = [r19 fileSystemRepresentation];
                                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                            r2 = [r21 lastPathComponent];
                                                                            r1 = r23;
                                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                            if (r0 == 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                            _CXLog();
                                                                                    }
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                            r23 = r25;
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                                    else {
                                                                            _CXLog();
                                                                            r22 = [r19 fileSystemRepresentation];
                                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                            r2 = [r21 lastPathComponent];
                                                                            r1 = r23;
                                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                            if (r0 == 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                            _CXLog();
                                                                                    }
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                            r23 = r25;
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    r25 = r23;
                                                    r0 = [NSFileManager defaultManager];
                                                    r22 = r0;
                                                    r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                    r23 = **_NSFileSystemNumber;
                                                    if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                            var_F0 = 0x0;
                                                            r4 = &var_F0;
                                                            r3 = r21;
                                                            if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                    [r21 stringQuotedForBash];
                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                    if (r0 != 0x0) {
                                                                            r0 = [var_F0 length];
                                                                            if (r0 != 0x0) {
                                                                                    [var_F0 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                            }
                                                                    }
                                                                    exit(0x0);
                                                            }
                                                            _CXLog();
                                                            r22 = [r19 fileSystemRepresentation];
                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                            r2 = [r21 lastPathComponent];
                                                            r1 = r23;
                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                            if (r0 == 0x0) {
                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                            _CXLog();
                                                                    }
                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                    [r21 stringQuotedForBash];
                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                    if (r0 != 0x0) {
                                                                            r0 = [var_F0 length];
                                                                            if (r0 != 0x0) {
                                                                                    [var_F0 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                            }
                                                                    }
                                                                    exit(0x0);
                                                            }
                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                            r23 = r25;
                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                            r0 = [r19 runModal];
                                                            if (**___stack_chk_guard != var_70) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                                    else {
                                                            _CXLog();
                                                            r22 = [r19 fileSystemRepresentation];
                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                            r2 = [r21 lastPathComponent];
                                                            r1 = r23;
                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                            if (r0 == 0x0) {
                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                            _CXLog();
                                                                    }
                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                    [r21 stringQuotedForBash];
                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                    if (r0 != 0x0) {
                                                                            r0 = [var_F0 length];
                                                                            if (r0 != 0x0) {
                                                                                    [var_F0 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                            }
                                                                    }
                                                                    exit(0x0);
                                                            }
                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                            r23 = r25;
                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                            r0 = [r19 runModal];
                                                            if (**___stack_chk_guard != var_70) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                    }
                            }
                            else {
                                    if (**___stack_chk_guard != var_70) {
                                            __stack_chk_fail();
                                    }
                            }
                    }
                    else {
                            r20 = var_2D4;
                            if (r25 == 0x3e8) {
                                    _CXLog();
                                    if (r20 != 0x0) {
                                            if ([r21 hasSuffix:@".app"] != 0x0) {
                                                    if ([[r21 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0x0) {
                                                            if ([[r19 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0x0) {
                                                                    r0 = AuthorizationCreate(0x0, 0x0, 0x0, &var_280);
                                                                    if (r0 == 0x0) {
                                                                            var_240 = 0x1;
                                                                            r0 = AuthorizationCopyRights(var_280, &var_240, 0x0, 0x13, 0x0);
                                                                            if (r0 != 0xffff159a) {
                                                                                    if (r0 == 0x0) {
                                                                                            if (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges == 0x0) {
                                                                                                    r0 = dlsym(0xfffffffffffffffe, "AuthorizationExecuteWithPrivileges");
                                                                                                    *_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges = r0;
                                                                                                    if (r0 != 0x0) {
                                                                                                            var_F0 = "-rf";
                                                                                                            [r21 fileSystemRepresentation];
                                                                                                            r0 = (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/bin/rm", 0x0, &var_F0, 0x0);
                                                                                                            if (r0 != 0x0) {
                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                    r0 = [r19 runModal];
                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                            __stack_chk_fail();
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r0 = wait(&var_1F4);
                                                                                                                    if (r0 != -0x1) {
                                                                                                                            if ((var_1F4 & 0x7f) == 0x0) {
                                                                                                                                    var_F0 = "--noqtn";
                                                                                                                                    [r19 fileSystemRepresentation];
                                                                                                                                    [r21 fileSystemRepresentation];
                                                                                                                                    r3 = &var_F0;
                                                                                                                                    if ((*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/usr/bin/ditto", 0x0, r3, 0x0) == 0x0) {
                                                                                                                                            r0 = wait(&var_1F4);
                                                                                                                                            if (r0 != -0x1) {
                                                                                                                                                    if ((var_1F4 & 0xffffff7f) == 0x0) {
                                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                                            if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                                                                                    _CXLog();
                                                                                                                                                            }
                                                                                                                                                            [[NSProcessInfo processInfo] processIdentifier];
                                                                                                                                                            [r21 stringQuotedForBash];
                                                                                                                                                            [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                                                                                            r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                            [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                                                                                            r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                                    r0 = [var_F0 length];
                                                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                                                            [var_F0 stringQuotedForBash];
                                                                                                                                                                            [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                                                                                            r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                            r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                                                                                    }
                                                                                                                                                            }
                                                                                                                                                            exit(0x0);
                                                                                                                                                    }
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            else {
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                                            __stack_chk_fail();
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                            __stack_chk_fail();
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                            r0 = [r19 runModal];
                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                    __stack_chk_fail();
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                            r0 = [r19 runModal];
                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                    __stack_chk_fail();
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                            else {
                                                                                                    var_F0 = "-rf";
                                                                                                    [r21 fileSystemRepresentation];
                                                                                                    r0 = (*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/bin/rm", 0x0, &var_F0, 0x0);
                                                                                                    if (r0 != 0x0) {
                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                            r0 = [r19 runModal];
                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                    __stack_chk_fail();
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r0 = wait(&var_1F4);
                                                                                                            if (r0 != -0x1) {
                                                                                                                    if ((var_1F4 & 0x7f) == 0x0) {
                                                                                                                            var_F0 = "--noqtn";
                                                                                                                            [r19 fileSystemRepresentation];
                                                                                                                            [r21 fileSystemRepresentation];
                                                                                                                            r3 = &var_F0;
                                                                                                                            if ((*_AuthorizedInstall.security_AuthorizationExecuteWithPrivileges)(var_280, "/usr/bin/ditto", 0x0, r3, 0x0) == 0x0) {
                                                                                                                                    r0 = wait(&var_1F4);
                                                                                                                                    if (r0 != -0x1) {
                                                                                                                                            if ((var_1F4 & 0xffffff7f) == 0x0) {
                                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                                                                                            _CXLog();
                                                                                                                                                    }
                                                                                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                                                                                    [r21 stringQuotedForBash];
                                                                                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                                            r0 = [var_F0 length];
                                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                                    exit(0x0);
                                                                                                                                            }
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                            r0 = [r19 runModal];
                                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                                    __stack_chk_fail();
                                                                                                                                            }
                                                                                                                                    }
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                                    r0 = [r19 runModal];
                                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                                            __stack_chk_fail();
                                                                                                                                    }
                                                                                                                            }
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                            r0 = [r19 runModal];
                                                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                                                    __stack_chk_fail();
                                                                                                                            }
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                                                    r0 = [r19 runModal];
                                                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                                                            __stack_chk_fail();
                                                                                                                    }
                                                                                                            }
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                    else {
                                                                                            AuthorizationFree(var_280, 0x0);
                                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                                            r0 = [r19 runModal];
                                                                                            if (**___stack_chk_guard != var_70) {
                                                                                                    __stack_chk_fail();
                                                                                            }
                                                                                    }
                                                                            }
                                                                            else {
                                                                                    AuthorizationFree(var_280, 0x0);
                                                                                    r0 = _CXLog();
                                                                                    if (**___stack_chk_guard != var_70) {
                                                                                            __stack_chk_fail();
                                                                                    }
                                                                            }
                                                                    }
                                                                    else {
                                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                            r0 = [r19 runModal];
                                                            if (**___stack_chk_guard != var_70) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                            else {
                                                    NSLog(@"ERROR -- Could not copy myself to /Applications with authorization");
                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                    r0 = [r19 runModal];
                                                    if (**___stack_chk_guard != var_70) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if ([var_2E0 fileExistsAtPath:r21] != 0x0) {
                                                    r26 = r23;
                                                    var_2D0 = q0;
                                                    var_2C0 = q0;
                                                    r0 = [NSWorkspace sharedWorkspace];
                                                    r0 = [r0 runningApplications];
                                                    r22 = r0;
                                                    r0 = [r0 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_1f0 count:0x10];
                                                    if (r0 != 0x0) {
                                                            r23 = r0;
                                                            r24 = *var_2C0;
                                                            while (true) {
                                                                    r25 = 0x0;
                                                                    while (true) {
                                                                            if (*var_2C0 != r24) {
                                                                                    objc_enumerationMutation(r22);
                                                                            }
                                                                            r0 = *(var_2C8 + r25 * 0x8);
                                                                            r0 = [r0 executableURL];
                                                                            r0 = [r0 path];
                                                                            r0 = _PathIsWithinPath(r0, r21);
                                                                            if ((r0 & 0x1) != 0x0) {
                                                                                    _CXLog();
                                                                                    r0 = [NSWorkspace sharedWorkspace];
                                                                                    r0 = [r0 openFile:r21];
                                                                                    temp_4 = 0x1;
                                                                                    break;
                                                                            }
                                                                            r25 = r25 + 0x1;
                                                                            if (r23 != r25) {
                                                                                    continue;
                                                                            }
                                                                            temp_4 = 0x0;
                                                                            break;
                                                                    }
                                                                    if (temp_4 == 0x0) {
                                                                            r0 = [r22 countByEnumeratingWithState:&var_2D0 objects:&decomp_var_1f0 count:0x10];
                                                                            r23 = r0;
                                                                            if (r0 != 0x0) {
                                                                                    continue;
                                                                            }
                                                                            temp_9 = 0x0;
                                                                            break;
                                                                    }
                                                                    temp_9 = 0x1;
                                                                    break;
                                                            }
                                                            if (temp_9 != 0x0) {
                                                                    exit(0x0);
                                                            }
                                                            r23 = r26;
                                                            if (_Trash(r21) != 0x0) {
                                                                    r25 = r23;
                                                                    r0 = [NSFileManager defaultManager];
                                                                    r22 = r0;
                                                                    r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                                    r23 = **_NSFileSystemNumber;
                                                                    if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                            var_F0 = 0x0;
                                                                            r4 = &var_F0;
                                                                            r3 = r21;
                                                                            if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            _CXLog();
                                                                            r22 = [r19 fileSystemRepresentation];
                                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                            r2 = [r21 lastPathComponent];
                                                                            r1 = r23;
                                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                            if (r0 == 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                            _CXLog();
                                                                                    }
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                            r23 = r25;
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                                    else {
                                                                            _CXLog();
                                                                            r22 = [r19 fileSystemRepresentation];
                                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                            r2 = [r21 lastPathComponent];
                                                                            r1 = r23;
                                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                            if (r0 == 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                            _CXLog();
                                                                                    }
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                            r23 = r25;
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            r23 = r26;
                                                            if (_Trash(r21) != 0x0) {
                                                                    r25 = r23;
                                                                    r0 = [NSFileManager defaultManager];
                                                                    r22 = r0;
                                                                    r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                                    r23 = **_NSFileSystemNumber;
                                                                    if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                                            var_F0 = 0x0;
                                                                            r4 = &var_F0;
                                                                            r3 = r21;
                                                                            if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            _CXLog();
                                                                            r22 = [r19 fileSystemRepresentation];
                                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                            r2 = [r21 lastPathComponent];
                                                                            r1 = r23;
                                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                            if (r0 == 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                            _CXLog();
                                                                                    }
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                            r23 = r25;
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                                    else {
                                                                            _CXLog();
                                                                            r22 = [r19 fileSystemRepresentation];
                                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                                            r2 = [r21 lastPathComponent];
                                                                            r1 = r23;
                                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                                            if (r0 == 0x0) {
                                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                                            _CXLog();
                                                                                    }
                                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                                    [r21 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                                    if (r0 != 0x0) {
                                                                                            r0 = [var_F0 length];
                                                                                            if (r0 != 0x0) {
                                                                                                    [var_F0 stringQuotedForBash];
                                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                                            }
                                                                                    }
                                                                                    exit(0x0);
                                                                            }
                                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                                            r23 = r25;
                                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                            r0 = [r19 runModal];
                                                                            if (**___stack_chk_guard != var_70) {
                                                                                    __stack_chk_fail();
                                                                            }
                                                                    }
                                                            }
                                                            else {
                                                                    r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                                    [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                                    r0 = [r19 runModal];
                                                                    if (**___stack_chk_guard != var_70) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    r25 = r23;
                                                    r0 = [NSFileManager defaultManager];
                                                    r22 = r0;
                                                    r0 = [r0 attributesOfFileSystemForPath:r19 error:0x0];
                                                    r23 = **_NSFileSystemNumber;
                                                    if (([[r0 objectForKey:r23] isEqual:[[r22 attributesOfFileSystemForPath:[r21 stringByDeletingLastPathComponent] error:0x0] objectForKey:r23]] & 0x1) != 0x0) {
                                                            var_F0 = 0x0;
                                                            r4 = &var_F0;
                                                            r3 = r21;
                                                            if ([r22 moveItemAtPath:r19 toPath:r3 error:r4] != 0x0) {
                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                    [r21 stringQuotedForBash];
                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                    if (r0 != 0x0) {
                                                                            r0 = [var_F0 length];
                                                                            if (r0 != 0x0) {
                                                                                    [var_F0 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                            }
                                                                    }
                                                                    exit(0x0);
                                                            }
                                                            _CXLog();
                                                            r22 = [r19 fileSystemRepresentation];
                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                            r2 = [r21 lastPathComponent];
                                                            r1 = r23;
                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                            if (r0 == 0x0) {
                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                            _CXLog();
                                                                    }
                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                    [r21 stringQuotedForBash];
                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                    if (r0 != 0x0) {
                                                                            r0 = [var_F0 length];
                                                                            if (r0 != 0x0) {
                                                                                    [var_F0 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                            }
                                                                    }
                                                                    exit(0x0);
                                                            }
                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                            r23 = r25;
                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                            r0 = [r19 runModal];
                                                            if (**___stack_chk_guard != var_70) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                                    else {
                                                            _CXLog();
                                                            r22 = [r19 fileSystemRepresentation];
                                                            r23 = [[r21 stringByDeletingLastPathComponent] fileSystemRepresentation];
                                                            r2 = [r21 lastPathComponent];
                                                            r1 = r23;
                                                            r0 = FSPathCopyObjectSync(r22, r1, r2, 0x0, 0x0);
                                                            if (r0 == 0x0) {
                                                                    [[NSFileManager defaultManager] clearQuarantine:r21];
                                                                    if ((var_2E4 & 0x1) == 0x0 && (_Trash(r19) & 0x1) == 0x0) {
                                                                            _CXLog();
                                                                    }
                                                                    [[NSProcessInfo processInfo] processIdentifier];
                                                                    [r21 stringQuotedForBash];
                                                                    [NSString stringWithFormat:@"(while /bin/kill -0 %d 2>/dev/null; do sleep 0.1; done; open %@) &", r3, r4];
                                                                    r3 = [NSArray arrayWithObjects:@"-c"];
                                                                    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r3];
                                                                    r0 = _IsLaunchedFromDMG(&var_F0);
                                                                    if (r0 != 0x0) {
                                                                            r0 = [var_F0 length];
                                                                            if (r0 != 0x0) {
                                                                                    [var_F0 stringQuotedForBash];
                                                                                    [NSString stringWithFormat:@"(sleep 5 && hdiutil detach %@) &", r3];
                                                                                    r0 = [NSArray arrayWithObjects:@"-c"];
                                                                                    r0 = [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:r0];
                                                                            }
                                                                    }
                                                                    exit(0x0);
                                                            }
                                                            NSLog(@"ERROR -- Could not copy '%@' to '%@' (%d)", r1, r2, 0x0);
                                                            NSLog(@"ERROR -- Could not copy myself to %@", r1);
                                                            r23 = r25;
                                                            r19 = [[[r23[0x1a5] alloc] init] autorelease];
                                                            [r19 setMessageText:[[r28[0x195] mainBundle] localizedStringForKey:@"Could not move to Applications folder" value:@"" table:@"MoveApplication"]];
                                                            r0 = [r19 runModal];
                                                            if (**___stack_chk_guard != var_70) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                    }
                            }
                            else {
                                    [r22 setBool:0x1 forKey:@"moveToApplicationsFolderAlertSuppress"];
                                    r0 = [r22 synchronize];
                                    if (**___stack_chk_guard != var_70) {
                                            __stack_chk_fail();
                                    }
                            }
                    }
            }
    }
    else {
            if (**___stack_chk_guard != var_70) {
                    __stack_chk_fail();
            }
    }
    return r0;

loc_100059f70:
    r21 = r0;
    r23 = *var_230;
    while (true) {
            r24 = 0x0;
            while (true) {
                    if (*var_230 != r23) {
                            objc_enumerationMutation(r20);
                    }
                    r0 = _PathIsWithinPath(r19, *(var_238 + r24 * 0x8));
                    if ((r0 & 0x1) != 0x0) {
                            temp_1 = 0x0;
                            break;
                    }
                    r24 = r24 + 0x1;
                    if (r21 != r24) {
                            continue;
                    }
                    temp_1 = 0x1;
                    break;
            }
            if (temp_1 == 0x0) {
                    temp_6 = 0x0;
                    break;
            }
            r0 = [r20 countByEnumeratingWithState:&var_240 objects:&var_F0 count:0x10];
            r21 = r0;
            if (r0 != 0x0) {
                    continue;
            }
            temp_6 = 0x1;
            break;
    }
    if (temp_6 == 0x0) goto loc_100059eec;
    goto loc_100059fd4;


// 0x10005ab4c
// _IsLaunchedFromDMG
    var_30 = r28;
    decomp_var_28 = r27;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xffffffffffffffc0 - 0x880;
    r19 = arg0;
    var_38 = **___stack_chk_guard;
    r0 = [NSBundle mainBundle];
    r0 = [r0 bundlePath];
    r0 = [r0 fileSystemRepresentation];
    r0 = statfs(r0, &decomp_var_8b0);
    if (r0 != 0x0) {
            r20 = 0x0;
    }
    else {
            r0 = DASessionCreate(0x0);
            r20 = r0;
            if (r0 != 0x0) {
                    r22 = DADiskCreateFromBSDName(0x0, r20, &decomp_var_8b0 + 0x458);
                    r0 = CFRelease(r20);
                    if (r22 != 0x0) {
                            r21 = DADiskCopyDescription(r22);
                            r0 = CFRelease(r22);
                            if (r21 != 0x0) {
                                    r20 = [[r21 objectForKey:**_kDADiskDescriptionDeviceModelKey] isEqualToString:@"Disk Image"];
                                    r0 = [r21 release];
                                    if (r19 != 0x0) {
                                            if (r20 != 0x0) {
                                                    *r19 = [[NSFileManager defaultManager] stringWithFileSystemRepresentation:&decomp_var_8b0 + 0x58 length:strlen(&decomp_var_8b0 + 0x58)];
                                                    r20 = 0x1;
                                            }
                                    }
                            }
                            else {
                                    r20 = 0x0;
                            }
                    }
                    else {
                            r20 = 0x0;
                    }
            }
    }
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    r0 = r20;
    return r0;


// 0x10005ac90
// _PathIsWithinPath
    var_20 = r22;
    decomp_var_18 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg1;
    r0 = [arg0 pathComponents];
    r20 = r0;
    r21 = [r0 count];
    r0 = [r19 pathComponents];
    r0 = [r0 count];
    if (r21 < r0) {
            r0 = 0x0;
    }
    else {
            r20 = [NSString pathWithComponents:[r20 subarrayWithRange:0x0]];
            r0 = [NSFileManager defaultManager];
            r0 = [r0 isSameFile:r20 asFile:r19];
    }
    return r0;


// 0x10005ad24
// _Trash
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = arg0;
    r20 = [NSWorkspace sharedWorkspace];
    r21 = **_NSWorkspaceRecycleOperation;
    r22 = [r19 stringByDeletingLastPathComponent];
    r0 = [r19 lastPathComponent];
    r0 = [NSArray arrayWithObject:r0];
    r0 = [r20 performFileOperation:r21 source:r22 destination:@"" files:r0 tag:0x0];
    r20 = r0;
    if ((r0 & 0x1) == 0x0) {
            NSLog(@"ERROR -- Could not trash '%@'", r1);
    }
    r0 = r20;
    return r0;


// 0x100064868
// _main
    NSApplicationMain(r0, r1);
    return;


// 0x10006486c
// ___isOSVersionAtLeast
    r0 = arg0;
    var_30 = r22;
    decomp_var_28 = r21;
    r31 = r31 + 0xffffffffffffffd0;
    var_20 = r20;
    decomp_var_18 = r19;
    var_10 = r29;
    decomp_var_8 = r30;
    r19 = arg2;
    r20 = arg1;
    r21 = r0;
    if (*qword_1000c8460 == -0x1) {
            r8 = *(int32_t *)__MergedGlobals;
            bool_7 = r8 >= r21;
            if (r8 > r21) {
                    r0 = 0x1;
            }
            else {
                    if (!bool_7) {
                            r0 = 0x0;
                    }
                    else {
                            r8 = *(int32_t *)dword_1000c8454;
                            bool_10 = r8 >= r20;
                            if (r8 > r20) {
                                    r0 = 0x1;
                            }
                            else {
                                    if (!bool_10) {
                                            r0 = 0x0;
                                    }
                                    else {
                                            if (*(int32_t *)dword_1000c8458 >= r19) {
                                                    r0 = 0x1;
                                            }
                                    }
                            }
                    }
            }
    }
    else {
            r0 = dispatch_once_f(qword_1000c8460, 0x0, _compatibilityInitializeAvailabilityCheck);
            r8 = *(int32_t *)__MergedGlobals;
            bool_1 = r8 >= r21;
            if (r8 <= r21) {
                    if (!bool_1) {
                            r0 = 0x0;
                    }
                    else {
                            r8 = *(int32_t *)dword_1000c8454;
                            bool_5 = r8 >= r20;
                            if (r8 > r20) {
                                    r0 = 0x1;
                            }
                            else {
                                    if (!bool_5) {
                                            r0 = 0x0;
                                    }
                                    else {
                                            if (*(int32_t *)dword_1000c8458 >= r19) {
                                                    r0 = 0x1;
                                            }
                                    }
                            }
                    }
            }
            else {
                    r0 = 0x1;
            }
    }
    return r0;


// 0x100064954
// _compatibilityInitializeAvailabilityCheck
    r0 = __initializeAvailabilityCheck();
    return r0;


// 0x10006495c
// ___isPlatformVersionAtLeast
    r0 = arg0;
    r31 = r31 - 0x40;
    var_30 = r22;
    decomp_var_28 = r21;
    var_20 = r20;
    decomp_var_18 = r19;
    var_10 = r29;
    decomp_var_8 = r30;
    r19 = arg3;
    r20 = arg2;
    r21 = arg1;
    r22 = r0;
    var_38 = **___stack_chk_guard;
    if (*qword_1000c8468 == -0x1) {
            if (*qword_1000c8470 != 0x0) {
                    asm { bfi        w8, w20, #0x8, #0x8 };
                    asm { bfxil      w8, w19, #0x0, #0x8 };
                    r0 = _availability_version_check();
                    if (**___stack_chk_guard != var_38) {
                            __stack_chk_fail();
                    }
            }
            else {
                    if (r22 == 0x1) {
                            if (*qword_1000c8460 == -0x1) {
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_27 = r8 < r21;
                                    if (r8 <= r21) {
                                            if (!bool_27) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_29 = r8 >= r20;
                                                    if (r8 > r20) {
                                                            r0 = 0x1;
                                                    }
                                                    else {
                                                            if (!bool_29) {
                                                                    r0 = 0x0;
                                                            }
                                                            else {
                                                                    if (*(int32_t *)dword_1000c8458 >= r19) {
                                                                            r0 = 0x1;
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    r0 = 0x0;
                                            }
                                    }
                                    else {
                                            r0 = 0x1;
                                    }
                            }
                            else {
                                    r0 = dispatch_once_f(qword_1000c8460, 0x0, _compatibilityInitializeAvailabilityCheck);
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_15 = r8 < r21;
                                    if (r8 <= r21) {
                                            if (!bool_15) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_20 = r8 >= r20;
                                                    if (r8 > r20) {
                                                            r0 = 0x1;
                                                    }
                                                    else {
                                                            if (!bool_20) {
                                                                    r0 = 0x0;
                                                            }
                                                            else {
                                                                    if (*(int32_t *)dword_1000c8458 >= r19) {
                                                                            r0 = 0x1;
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    r0 = 0x0;
                                            }
                                    }
                                    else {
                                            r0 = 0x1;
                                    }
                            }
                    }
                    else {
                            r0 = 0x1;
                    }
                    if (**___stack_chk_guard != var_38) {
                            __stack_chk_fail();
                    }
            }
    }
    else {
            r0 = dispatch_once_f(qword_1000c8468, 0x0, _initializeAvailabilityCheck);
            if (*qword_1000c8470 == 0x0) {
                    if (r22 == 0x1) {
                            if (*qword_1000c8460 == -0x1) {
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_23 = r8 < r21;
                                    if (r8 <= r21) {
                                            if (!bool_23) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_25 = r8 >= r20;
                                                    if (r8 > r20) {
                                                            r0 = 0x1;
                                                    }
                                                    else {
                                                            if (!bool_25) {
                                                                    r0 = 0x0;
                                                            }
                                                            else {
                                                                    if (*(int32_t *)dword_1000c8458 >= r19) {
                                                                            r0 = 0x1;
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    r0 = 0x0;
                                            }
                                    }
                                    else {
                                            r0 = 0x1;
                                    }
                            }
                            else {
                                    r0 = dispatch_once_f(qword_1000c8460, 0x0, _compatibilityInitializeAvailabilityCheck);
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_5 = r8 < r21;
                                    if (r8 <= r21) {
                                            if (!bool_5) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_7 = r8 >= r20;
                                                    if (r8 > r20) {
                                                            r0 = 0x1;
                                                    }
                                                    else {
                                                            if (!bool_7) {
                                                                    r0 = 0x0;
                                                            }
                                                            else {
                                                                    if (*(int32_t *)dword_1000c8458 >= r19) {
                                                                            r0 = 0x1;
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    r0 = 0x0;
                                            }
                                    }
                                    else {
                                            r0 = 0x1;
                                    }
                            }
                    }
                    else {
                            r0 = 0x1;
                    }
                    if (**___stack_chk_guard != var_38) {
                            __stack_chk_fail();
                    }
            }
            else {
                    asm { bfi        w8, w20, #0x8, #0x8 };
                    asm { bfxil      w8, w19, #0x0, #0x8 };
                    r0 = _availability_version_check();
                    if (**___stack_chk_guard != var_38) {
                            __stack_chk_fail();
                    }
            }
    }
    return r0;


// 0x100064aa8
// _initializeAvailabilityCheck
    r0 = __initializeAvailabilityCheck();
    return r0;


// 0x100064ab0
// ___isPlatformOrVariantPlatformVersionAtLeast
    r31 = r31 - 0x70;
    decomp_var_50 = r26;
    decomp_var_48 = r25;
    decomp_var_40 = r24;
    decomp_var_38 = r23;
    decomp_var_30 = r22;
    decomp_var_28 = r21;
    decomp_var_20 = r20;
    decomp_var_18 = r19;
    decomp_var_10 = r29;
    decomp_var_8 = r30;
    r19 = r7;
    r20 = r6;
    r22 = r5;
    r25 = r4;
    r21 = r3;
    r23 = r2;
    r24 = r1;
    r26 = r0;
    decomp_var_58 = **___stack_chk_guard;
    if (*qword_1000c8468 == -0x1) {
            if (*qword_1000c8470 != 0x0) {
                    asm { bfi        w8, w23, #0x8, #0x8 };
                    asm { bfxil      w8, w21, #0x0, #0x8 };
                    asm { bfi        w8, w20, #0x8, #0x8 };
                    asm { bfxil      w8, w19, #0x0, #0x8 };
                    _availability_version_check();
                    if (**___stack_chk_guard != decomp_var_58) {
                            __stack_chk_fail();
                    }
            }
            else {
                    if (r26 == 0x1) {
                            if (*qword_1000c8460 == -0x1) {
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_84 = r8 < r24;
                                    if (r8 <= r24) {
                                            if (!bool_84) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_89 = r8 < r23;
                                                    if (r8 <= r23) {
                                                            if (!bool_89) {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            if (**___stack_chk_guard != decomp_var_58) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != decomp_var_58) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                            else {
                                    dispatch_once_f(qword_1000c8460, 0x0, _compatibilityInitializeAvailabilityCheck);
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_71 = r8 < r24;
                                    if (r8 <= r24) {
                                            if (!bool_71) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_80 = r8 < r23;
                                                    if (r8 <= r23) {
                                                            if (!bool_80) {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            if (**___stack_chk_guard != decomp_var_58) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != decomp_var_58) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                    }
                    else {
                            if (r25 != 0x1) {
                                    ___isPlatformOrVariantPlatformVersionAtLeast.cold.1();
                            }
                            if (*qword_1000c8460 == -0x1) {
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_62 = r8 < r22;
                                    if (r8 <= r22) {
                                            if (!bool_62) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_69 = r8 >= r20;
                                                    if (r8 > r20) {
                                                            if (**___stack_chk_guard != decomp_var_58) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                                    else {
                                                            if (!bool_69) {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != decomp_var_58) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                            else {
                                    dispatch_once_f(qword_1000c8460, 0x0, _compatibilityInitializeAvailabilityCheck);
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_48 = r8 < r22;
                                    if (r8 <= r22) {
                                            if (!bool_48) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_60 = r8 >= r20;
                                                    if (r8 > r20) {
                                                            if (**___stack_chk_guard != decomp_var_58) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                                    else {
                                                            if (!bool_60) {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != decomp_var_58) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                    }
            }
    }
    else {
            dispatch_once_f(qword_1000c8468, 0x0, _initializeAvailabilityCheck);
            if (*qword_1000c8470 == 0x0) {
                    if (r26 == 0x1) {
                            if (*qword_1000c8460 == -0x1) {
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_39 = r8 < r24;
                                    if (r8 <= r24) {
                                            if (!bool_39) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_44 = r8 < r23;
                                                    if (r8 <= r23) {
                                                            if (!bool_44) {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            if (**___stack_chk_guard != decomp_var_58) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != decomp_var_58) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                            else {
                                    dispatch_once_f(qword_1000c8460, 0x0, _compatibilityInitializeAvailabilityCheck);
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_26 = r8 < r24;
                                    if (r8 <= r24) {
                                            if (!bool_26) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_35 = r8 < r23;
                                                    if (r8 <= r23) {
                                                            if (!bool_35) {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                                    else {
                                                            if (**___stack_chk_guard != decomp_var_58) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != decomp_var_58) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                    }
                    else {
                            if (r25 != 0x1) {
                                    ___isPlatformOrVariantPlatformVersionAtLeast.cold.1();
                            }
                            if (*qword_1000c8460 == -0x1) {
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_17 = r8 < r22;
                                    if (r8 <= r22) {
                                            if (!bool_17) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_24 = r8 >= r20;
                                                    if (r8 > r20) {
                                                            if (**___stack_chk_guard != decomp_var_58) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                                    else {
                                                            if (!bool_24) {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != decomp_var_58) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                            else {
                                    dispatch_once_f(qword_1000c8460, 0x0, _compatibilityInitializeAvailabilityCheck);
                                    r8 = *(int32_t *)__MergedGlobals;
                                    bool_5 = r8 < r22;
                                    if (r8 <= r22) {
                                            if (!bool_5) {
                                                    r8 = *(int32_t *)dword_1000c8454;
                                                    bool_15 = r8 >= r20;
                                                    if (r8 > r20) {
                                                            if (**___stack_chk_guard != decomp_var_58) {
                                                                    __stack_chk_fail();
                                                            }
                                                    }
                                                    else {
                                                            if (!bool_15) {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                            else {
                                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                                            __stack_chk_fail();
                                                                    }
                                                            }
                                                    }
                                            }
                                            else {
                                                    if (**___stack_chk_guard != decomp_var_58) {
                                                            __stack_chk_fail();
                                                    }
                                            }
                                    }
                                    else {
                                            if (**___stack_chk_guard != decomp_var_58) {
                                                    __stack_chk_fail();
                                            }
                                    }
                            }
                    }
            }
            else {
                    asm { bfi        w8, w23, #0x8, #0x8 };
                    asm { bfxil      w8, w21, #0x0, #0x8 };
                    asm { bfi        w8, w20, #0x8, #0x8 };
                    asm { bfxil      w8, w19, #0x0, #0x8 };
                    _availability_version_check();
                    if (**___stack_chk_guard != decomp_var_58) {
                            __stack_chk_fail();
                    }
            }
    }
    return;


// 0x100064d0c
// __initializeAvailabilityCheck
    r31 = r31 - 0xc0;
    var_60 = r28;
    decomp_var_58 = r27;
    var_50 = r26;
    decomp_var_48 = r25;
    var_40 = r24;
    decomp_var_38 = r23;
    var_30 = r22;
    decomp_var_28 = r21;
    var_20 = r20;
    decomp_var_18 = r19;
    var_10 = r29;
    decomp_var_8 = r30;
    var_68 = **___stack_chk_guard;
    asm { ccmp       w0, #0x0, #0x0, ne };
    if (!asm { ccmp       w0, #0x0, #0x0, ne }) {
            if (*__availability_version_check != 0x0) {
                    *qword_1000c8470 = *__availability_version_check;
            }
            asm { ccmp       w0, #0x0, #0x0, ne };
            if (!asm { ccmp       w0, #0x0, #0x0, ne }) {
                    r0 = dlsym(0xfffffffffffffffe, "kCFAllocatorNull");
                    if (r0 != 0x0) {
                            r19 = *r0;
                            r0 = dlsym(0xfffffffffffffffe, "CFDataCreateWithBytesNoCopy");
                            if (r0 != 0x0) {
                                    r27 = r0;
                                    r28 = dlsym(0xfffffffffffffffe, "CFPropertyListCreateWithData");
                                    r0 = dlsym(0xfffffffffffffffe, "CFPropertyListCreateFromXMLData");
                                    if ((r28 | r0) != 0x0) {
                                            r21 = r0;
                                            r0 = dlsym(0xfffffffffffffffe, "CFStringCreateWithCStringNoCopy");
                                            if (r0 != 0x0) {
                                                    r24 = r0;
                                                    r0 = dlsym(0xfffffffffffffffe, "CFDictionaryGetValue");
                                                    if (r0 != 0x0) {
                                                            r25 = r0;
                                                            r0 = dlsym(0xfffffffffffffffe, "CFGetTypeID");
                                                            if (r0 != 0x0) {
                                                                    r22 = r0;
                                                                    r0 = dlsym(0xfffffffffffffffe, "CFStringGetTypeID");
                                                                    if (r0 != 0x0) {
                                                                            r26 = r0;
                                                                            r0 = dlsym(0xfffffffffffffffe, "CFStringGetCString");
                                                                            var_90 = r0;
                                                                            if (r0 != 0x0) {
                                                                                    r0 = dlsym(0xfffffffffffffffe, "CFRelease");
                                                                                    if (r0 != 0x0) {
                                                                                            r20 = r0;
                                                                                            r0 = fopen("/System/Library/CoreServices/SystemVersion.plist", "r");
                                                                                            if (r0 != 0x0) {
                                                                                                    r23 = r0;
                                                                                                    var_98 = r20;
                                                                                                    fseek(r0, 0x0, 0x2);
                                                                                                    r0 = ftell(r23);
                                                                                                    if ((r0 & 0xffffffff80000000) == 0x0) {
                                                                                                            r20 = r0;
                                                                                                            rewind(r23);
                                                                                                            r0 = malloc(r20);
                                                                                                            if (r0 != 0x0) {
                                                                                                                    var_A8 = r0;
                                                                                                                    var_A0 = r23;
                                                                                                                    if (fread(r0, 0x1, r20, r23) == r20) {
                                                                                                                            r23 = var_A8;
                                                                                                                            r0 = (r27)(0x0, var_A8, r20, r19);
                                                                                                                            if (r0 != 0x0) {
                                                                                                                                    r27 = r0;
                                                                                                                                    r20 = var_A0;
                                                                                                                                    r1 = r27;
                                                                                                                                    if (r28 != 0x0) {
                                                                                                                                            r0 = (r28)(0x0, r1, 0x0, 0x0);
                                                                                                                                    }
                                                                                                                                    else {
                                                                                                                                            r0 = (r21)(0x0, r1, 0x0, 0x0);
                                                                                                                                    }
                                                                                                                                    r21 = r0;
                                                                                                                                    if (r0 != 0x0) {
                                                                                                                                            r1 = "ProductVersion";
                                                                                                                                            r3 = r19;
                                                                                                                                            r0 = (r24)(0x0, "ProductVersion", 0x600, r3);
                                                                                                                                            if (r0 != 0x0) {
                                                                                                                                                    r1 = r0;
                                                                                                                                                    r19 = (r25)(r21, r1, 0x600, r3);
                                                                                                                                                    (var_98)(r0, r1, r2, r3);
                                                                                                                                                    if (r19 != 0x0) {
                                                                                                                                                            r0 = (r22)(r19, r1);
                                                                                                                                                            if (r0 == (r26)(r0, r1)) {
                                                                                                                                                                    r1 = &decomp_var_88;
                                                                                                                                                                    if ((var_90)(r19, r1, 0x20, 0x8000100) != 0x0) {
                                                                                                                                                                            r1 = "%d.%d.%d";
                                                                                                                                                                            sscanf(&decomp_var_88, "%d.%d.%d");
                                                                                                                                                                    }
                                                                                                                                                            }
                                                                                                                                                    }
                                                                                                                                            }
                                                                                                                                            (var_98)(r21, r1);
                                                                                                                                            r20 = var_A0;
                                                                                                                                    }
                                                                                                                                    (var_98)(r27);
                                                                                                                            }
                                                                                                                            else {
                                                                                                                                    r20 = var_A0;
                                                                                                                            }
                                                                                                                            r0 = r23;
                                                                                                                    }
                                                                                                                    else {
                                                                                                                            r0 = var_A8;
                                                                                                                            r20 = var_A0;
                                                                                                                    }
                                                                                                            }
                                                                                                            else {
                                                                                                                    r20 = r23;
                                                                                                            }
                                                                                                    }
                                                                                                    else {
                                                                                                            r0 = 0x0;
                                                                                                            r20 = r23;
                                                                                                    }
                                                                                                    free(r0);
                                                                                                    r0 = fclose(r20);
                                                                                            }
                                                                                    }
                                                                            }
                                                                    }
                                                            }
                                                    }
                                            }
                                    }
                            }
                    }
            }
    }
    if (**___stack_chk_guard != var_68) {
            __stack_chk_fail();
    }
    return r0;


// 0x100065064
// ___isPlatformOrVariantPlatformVersionAtLeast.cold.1
    __assert_rtn("__isPlatformOrVariantPlatformVersionAtLeast", "os_version_check.c", 0x135, "Platform2 == PLATFORM_MACOS && \"unexpected platform\"");
    return r0;


