// NSString — CrossOver 26.3 arm64, Hopper pseudocode via REA

// 0x10002e684
// -[NSString stringQuotedForBash]
    r0 = [self mutableCopy];
    r19 = r0;
    [r0 length];
    [r19 replaceOccurrencesOfString:@"'" withString:@"'\''" options:0x0 range:0x0];
    [r19 insertString:@"'" atIndex:0x0];
    [r19 appendString:@"'"];
    r20 = [r19 copy];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10002e704
// -[NSString stringByRemovingCharactersInSet:]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = [arg2 retain];
    r20 = [NSMutableString alloc];
    r20 = [r20 initWithCapacity:[self length]];
    r0 = [NSScanner scannerWithString:self];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setCharactersToBeSkipped:r19];
    if (([r21 isAtEnd] & 0x1) == 0x0) {
            do {
                    var_38 = 0x0;
                    r0 = [r21 scanUpToCharactersFromSet:r19 intoString:&var_38];
                    r23 = r0;
                    r22 = [var_38 retain];
                    if (r23 != 0x0) {
                            [r20 appendString:r22];
                    }
                    [r22 release];
            } while ([r21 isAtEnd] == 0x0);
    }
    r22 = [r20 copy];
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = [r22 autorelease];
    return r0;


// 0x10002e80c
// -[NSString componentsOfCommandLine]
    r31 = r31 - 0x70;
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
    pthread_once(_initCharacterSetsOnce, _initCharacterSets);
    r19 = [[NSMutableArray alloc] init];
    r20 = [[NSMutableString alloc] init];
    r0 = [NSScanner scannerWithString:self];
    r0 = [r0 retain];
    r21 = r0;
    [r0 setCharactersToBeSkipped:*_emptyCharacterSet];
    if (([r21 isAtEnd] & 0x1) == 0x0) {
            do {
                    [r21 scanCharactersFromSet:*_skipBetweenComponents intoString:0x0];
                    if (([r21 isAtEnd] & 0x1) == 0x0) {
                            if (([r21 isAtEnd] & 0x1) == 0x0) {
                                    while (true) {
                                            var_58 = 0x0;
                                            r0 = [r21 scanUpToCharactersFromSet:*_delimitersOutsideOfQuotes intoString:&var_58];
                                            r25 = r0;
                                            r24 = [var_58 retain];
                                            if (r25 != 0x0) {
                                                    [r20 appendString:r24];
                                            }
                                            if (([r21 scanString:@"\"" intoString:0x0] & 0x1) == 0x0) {
                                                    temp_0 = 0x1;
                                                    break;
                                            }
                                            var_60 = r24;
                                            r0 = [r21 scanUpToString:@"\"" intoString:&var_60];
                                            r26 = r0;
                                            r25 = [var_60 retain];
                                            [r24 release];
                                            if (r26 != 0x0) {
                                                    [r20 appendString:r25];
                                            }
                                            [r21 scanString:@"\"" intoString:0x0];
                                            [r25 release];
                                            if ([r21 isAtEnd] == 0x0) {
                                                    continue;
                                            }
                                            temp_0 = 0x0;
                                            break;
                                    }
                                    if (temp_0 != 0x0) {
                                            [r24 release];
                                    }
                            }
                            r24 = [r20 copy];
                            [r19 addObject:r24];
                            [r24 release];
                            [r20 setString:@""];
                    }
            } while ([r21 isAtEnd] == 0x0);
    }
    r22 = [r19 copy];
    [r21 release];
    [r20 release];
    [r19 release];
    r0 = [r22 autorelease];
    return r0;


// 0x10002eb64
// -[NSString componentsSeparatedIntoAsciiAndNonAscii]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    pthread_once(_initCharacterSetsOnce, _initCharacterSets);
    r19 = [[NSMutableArray alloc] init];
    r0 = [NSScanner scannerWithString:self];
    r0 = [r0 retain];
    r20 = r0;
    [r0 setCharactersToBeSkipped:*_emptyCharacterSet];
    if (([r20 isAtEnd] & 0x1) == 0x0) {
            do {
                    var_38 = 0x0;
                    [r20 scanCharactersFromSet:*_asciiCharacterSet intoString:&var_38];
                    r21 = [var_38 retain];
                    [r19 addObject:r21];
                    var_40 = 0x0;
                    r0 = [r20 scanUpToCharactersFromSet:*_asciiCharacterSet intoString:&var_40];
                    r23 = r0;
                    r22 = [var_40 retain];
                    if (r23 != 0x0) {
                            [r19 addObject:r22];
                    }
                    [r22 release];
                    [r21 release];
            } while ([r20 isAtEnd] == 0x0);
    }
    r21 = [r19 copy];
    [r20 release];
    [r19 release];
    r0 = [r21 autorelease];
    return r0;


// 0x10002ec90
// -[NSString asciiStringQuotedForAppleScript]
    r0 = [self mutableCopy];
    r19 = r0;
    [r0 length];
    [r19 replaceOccurrencesOfString:@"\"" withString:@"\" & quote & \"" options:0x0 range:0x0];
    [r19 length];
    [r19 replaceOccurrencesOfString:@"\" withString:@"\" & (ASCII character 92) & \"" options:0x0 range:0x0];
    [r19 length];
    [r19 replaceOccurrencesOfString:@"\n" withString:@"\" & return & \"" options:0x0 range:0x0];
    [r19 insertString:@"\"" atIndex:0x0];
    [r19 appendString:@"\""];
    r20 = [r19 copy];
    [r19 release];
    r0 = [r20 autorelease];
    return r0;


// 0x10002ed68
// -[NSString nonAsciiStringQuotedForAppleScript]
    r31 = r31 - 0x50;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    if ([self length] != 0x0) {
            r19 = [[NSMutableString alloc] initWithUTF8String:"(\xC2\xABdata utf8"];
            r0 = [r20 dataUsingEncoding:0x4];
            r0 = [r0 retain];
            r0 = objc_retainAutorelease(r0);
            r20 = r0;
            r21 = [r0 bytes];
            r0 = [r20 length];
            if (r0 >= 0x1) {
                    r23 = r0 + 0x1;
                    do {
                            r21 = r21 + 0x1;
                            [r19 appendFormat:@"%02x", r3];
                            r23 = r23 - 0x1;
                    } while (r23 > 0x1);
            }
            r21 = [[NSString stringWithUTF8String:"\xC2\xBB as Unicode text)"] retain];
            [r19 appendString:r21];
            [r21 release];
            r21 = [r19 copy];
            [r20 release];
            [r19 release];
    }
    else {
            r21 = @"\"\"";
    }
    r0 = [r21 autorelease];
    return r0;


// 0x10002ee80
// -[NSString stringQuotedForAppleScript]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r20 = self;
    if ([self length] != 0x0) {
            r19 = [[NSMutableString alloc] init];
            r0 = [r20 componentsSeparatedIntoAsciiAndNonAscii];
            r0 = [r0 retain];
            r20 = r0;
            if ([r0 count] != 0x0) {
                    r21 = 0x0;
                    do {
                            if (r21 != 0x0) {
                                    [r19 appendString:@" & "];
                            }
                            r0 = [r20 objectAtIndex:r21];
                            r0 = [r0 retain];
                            r23 = r0;
                            if ((r21 & 0x1) == 0x0) {
                                    r0 = [r0 asciiStringQuotedForAppleScript];
                                    r0 = [r0 retain];
                            }
                            else {
                                    r0 = [r0 nonAsciiStringQuotedForAppleScript];
                                    r0 = [r0 retain];
                            }
                            [r19 appendString:r0];
                            [r0 release];
                            [r23 release];
                            r21 = r21 + 0x1;
                    } while ([r20 count] > r21);
            }
            r21 = [r19 copy];
            [r20 release];
            [r19 release];
    }
    else {
            r21 = @"\"\"";
    }
    r0 = [r21 autorelease];
    return r0;


// 0x10002ef94
// -[NSString decomposedUTF8String]
    r0 = [self decomposedStringWithCanonicalMapping];
    r0 = [r0 retain];
    r0 = objc_retainAutorelease(r0);
    r19 = r0;
    r20 = [r0 UTF8String];
    [r19 release];
    r0 = r20;
    return r0;


// 0x10002efd4
// -[NSString stringInFileSystemRepresentationForm]
    r19 = [objc_retainAutorelease(self) fileSystemRepresentation];
    r20 = [[NSFileManager defaultManager] retain];
    r19 = [[r20 stringWithFileSystemRepresentation:r19 length:strlen(r19)] retain];
    [r20 release];
    r0 = [r19 autorelease];
    return r0;


// 0x10002f040
// -[NSString localizedStandardGreaterThan:]
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    r0 = [self localizedStandardCompare:arg2];
    if (r0 == 0x1) {
            r0 = 0x1;
    }
    return r0;


// 0x10002f05c
// -[NSString localizedStandardLessThan:]
    saved_fp = r29;
    decomp_var_m8 = r30;
    r31 = r31 + 0xfffffffffffffff0;
    r0 = [self localizedStandardCompare:arg2];
    if (r0 == -0x1) {
            r0 = 0x1;
    }
    return r0;


// 0x10002f078
// -[NSString lastUnixOrWindowsPathComponent]
    var_30 = r24;
    decomp_var_28 = r23;
    r31 = r31 + 0xffffffffffffffc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    pthread_once(_initCharacterSetsOnce, _initCharacterSets);
    r0 = [r19 rangeOfString:@":" options:0x4];
    if (r0 == 0x7fffffffffffffff) {
            [r19 length];
            r20 = 0x0;
    }
    else {
            r20 = r0 + _initCharacterSets;
            [r19 length] - r20;
    }
    r1 = _initCharacterSets;
    r0 = [r19 rangeOfCharacterFromSet:*_nonPathSeparators options:0x4 range:r20];
    if (r0 == 0x7fffffffffffffff) {
            r0 = @"/";
    }
    else {
            r23 = r0 + _initCharacterSets;
            r21 = r23 - r20;
            r0 = [r19 rangeOfCharacterFromSet:*_pathSeparators options:0x4 range:r20];
            r8 = r0 + r1;
            r9 = r23 - r8;
            bool_3 = r0 == 0x7fffffffffffffff;
            if (!bool_3) {
                    r2 = r8;
            }
            else {
                    r2 = r20;
            }
            r0 = [r19 substringWithRange:r2];
            r0 = [r0 retain];
    }
    r0 = [r0 autorelease];
    return r0;


// 0x100053dc0
// -[NSString MD5]
    r31 = r31 - 0xc0;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_18 = **___stack_chk_guard;
    r0 = objc_retainAutorelease(self);
    r0 = [r0 UTF8String];
    CC_MD5(r0, strlen(r0), &var_28);
    r0 = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", var_1C, var_1B, var_1A, var_19, r7, var_28, var_27, var_26, var_25, var_24, var_23, var_22, var_21, var_20, var_1F, var_1E];
    r0 = [r0 retain];
    if (**___stack_chk_guard != var_18) {
            __stack_chk_fail();
    }
    r0 = [r0 autorelease];
    return r0;


// 0x100059b64
// -[NSString stringByResolvingSymlinksAndAliases]
    r31 = r31 - 0x110;
    var_30 = r24;
    decomp_var_28 = r23;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    var_38 = **___stack_chk_guard;
    r0 = [self stringByStandardizingPath];
    r19 = r0;
    r0 = [r0 hasPrefix:@"/"];
    if (r0 != 0x0) {
            r0 = [r19 pathComponents];
            r20 = r0;
            r19 = [r0 objectAtIndex:0x0];
            [r20 count] - 0x1;
            r0 = [r20 subarrayWithRange:0x1];
            r20 = r0;
            var_100 = q0;
            var_F0 = q0;
            r0 = [r0 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
            if (r0 != 0x0) {
                    r21 = r0;
                    r22 = *var_F0;
                    while (true) {
                            r23 = 0x0;
                            while (true) {
                                    if (*var_F0 != r22) {
                                            objc_enumerationMutation(r20);
                                    }
                                    r0 = [r19 stringByAppendingPathComponent:*(var_F8 + r23 * 0x8)];
                                    r0 = [r0 stringByIterativelyResolvingSymlinkOrAlias];
                                    r19 = r0;
                                    if (r0 == 0x0) {
                                            temp_0 = 0x0;
                                            break;
                                    }
                                    r23 = r23 + 0x1;
                                    if (r21 != r23) {
                                            continue;
                                    }
                                    temp_0 = 0x1;
                                    break;
                            }
                            if (temp_0 == 0x0) {
                                    temp_1 = 0x1;
                                    break;
                            }
                            r0 = [r20 countByEnumeratingWithState:&var_100 objects:&decomp_var_b8 count:0x10];
                            r21 = r0;
                            if (r0 != 0x0) {
                                    continue;
                            }
                            temp_1 = 0x0;
                            break;
                    }
            }
    }
    else {
            r19 = 0x0;
    }
    if (**___stack_chk_guard != var_38) {
            __stack_chk_fail();
    }
    r0 = r19;
    return r0;


// 0x100059ca4
// -[NSString stringByIterativelyResolvingSymlinkOrAlias]
    r31 = r31 - 0xc0;
    var_20 = r22;
    decomp_var_18 = r21;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [NSFileManager defaultManager];
    r0 = [r0 fileSystemRepresentationWithPath:r19];
    r0 = lstat(r0, &decomp_var_b0);
    if ((r0 & 0xffffffff80000000) == 0x0) {
            r20 = 0x0;
            while (true) {
                    r8 = var_AC;
                    r9 = r8 & 0xf000;
                    if (r9 == 0xa000) {
                            r21 = r20;
                            if ((r8 & 0xf000) != 0xa000) {
                                    r0 = [NSFileManager defaultManager];
                                    r0 = [r0 fileSystemRepresentationWithPath:r21];
                                    r0 = lstat(r0, &decomp_var_b0);
                                    if (r0 >= 0x0) {
                                            r19 = r21;
                                    }
                                    else {
                                            r19 = 0x0;
                                    }
                                    continue;
                            }
                            r0 = [r19 stringByConditionallyResolvingSymlink];
                            r21 = r0;
                            if (r0 != 0x0) {
                                    r0 = [NSFileManager defaultManager];
                                    r0 = [r0 fileSystemRepresentationWithPath:r21];
                                    r0 = lstat(r0, &decomp_var_b0);
                                    if (r0 >= 0x0) {
                                            r19 = r21;
                                    }
                                    else {
                                            r19 = 0x0;
                                    }
                                    continue;
                            }
                            temp_0 = 0x1;
                            break;
                    }
                    if (r9 == 0x4000) {
                            temp_0 = 0x0;
                            break;
                    }
                    r0 = [r19 stringByConditionallyResolvingAlias];
                    if (r0 == 0x0) {
                            temp_0 = 0x0;
                            break;
                    }
                    r20 = r0;
                    r8 = var_AC;
                    r21 = r20;
                    if ((r8 & 0xf000) != 0xa000) {
                            r0 = [NSFileManager defaultManager];
                            r0 = [r0 fileSystemRepresentationWithPath:r21];
                            r0 = lstat(r0, &decomp_var_b0);
                            if (r0 >= 0x0) {
                                    r19 = r21;
                            }
                            else {
                                    r19 = 0x0;
                            }
                            continue;
                    }
                    r0 = [r19 stringByConditionallyResolvingSymlink];
                    r21 = r0;
                    if (r0 != 0x0) {
                            r0 = [NSFileManager defaultManager];
                            r0 = [r0 fileSystemRepresentationWithPath:r21];
                            r0 = lstat(r0, &decomp_var_b0);
                            if (r0 >= 0x0) {
                                    r19 = r21;
                            }
                            else {
                                    r19 = 0x0;
                            }
                            continue;
                    }
                    temp_0 = 0x1;
                    break;
            }
            if (temp_0 != 0x0) {
                    r19 = 0x0;
            }
    }
    else {
            r19 = 0x0;
    }
    r0 = r19;
    return r0;


// 0x100059d6c
// -[NSString stringByResolvingAlias]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self stringByConditionallyResolvingAlias];
    if (r0 == 0x0) {
            r0 = r19;
    }
    return r0;


// 0x100059d94
// -[NSString stringByResolvingSymlink]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [self stringByConditionallyResolvingSymlink];
    if (r0 == 0x0) {
            r0 = r19;
    }
    return r0;


// 0x100059dbc
// -[NSString stringByConditionallyResolvingSymlink]
    var_10 = r20;
    decomp_var_8 = r19;
    r31 = r31 + 0xffffffffffffffe0;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r19 = self;
    r0 = [NSFileManager defaultManager];
    r0 = [r0 destinationOfSymbolicLinkAtPath:r19 error:0x0];
    r20 = r0;
    if (r0 != 0x0 && ([r20 hasPrefix:@"/"] & 0x1) == 0x0) {
            r0 = [r19 stringByDeletingLastPathComponent];
            r0 = [r0 stringByAppendingPathComponent:r20];
            r0 = [r0 stringByStandardizingPath];
    }
    else {
            r0 = r20;
    }
    return r0;


// 0x100059e2c
// -[NSString stringByConditionallyResolvingAlias]
    r31 = r31 - 0x30;
    var_10 = r20;
    decomp_var_8 = r19;
    saved_fp = r29;
    decomp_var_m8 = r30;
    r0 = [NSURL fileURLWithPath:self];
    if (r0 != 0x0) {
            r0 = [NSURL bookmarkDataWithContentsOfURL:r0 error:0x0];
            if (r0 != 0x0) {
                    r0 = [NSURL URLByResolvingBookmarkData:r0 options:0x300 relativeToURL:0x0 bookmarkDataIsStale:&decomp_var_11 error:0x0];
                    if (r0 != 0x0) {
                            r0 = [r0 path];
                    }
            }
    }
    return r0;


