// NSFileManager+CrossOverAdditions.m — CrossThrough
#import "NSFileManager+CrossOverAdditions.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NSFileManager (CrossOverAdditions)

+ (id)systemPaths {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = objc_opt_class(@class(NSFileManager));
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   objc_sync_enter(r0);
     *   if (*_systemPaths == 0x0) {
     *   r20 = [[NSMutableSet alloc] init];
     *   r23 = 0x0;
     *   do {
     *   r21 = [NSSearchPathForDirectoriesInDomains(*(0x10009dc18 + r23), 0xffff, 0x1) retain];
     *   [r20 addObjectsFromArray:r21];
     *   r23 = r23 + 0x8;
     *   [r21 release];
     *   } while (r23 != 0x80);
     *   r0 = [r20 copy];
     *   r8 = *_systemPaths;
     *   *_systemPaths = r0;
     *   ... (8 more lines)
     */
    return nil;
}

- (BOOL)createDirectoryAtPath:(id)arg1 attributes:(id)arg2 recursively:(BOOL)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x60;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r23 = arg4;
     *   r21 = self;
     *   r19 = [arg2 retain];
     *   r20 = [arg3 retain];
     *   r0 = objc_opt_class(r21);
     *   r0 = [r0 systemPaths];
     *   r0 = [r0 retain];
     *   r24 = r0;
     *   r22 = [r0 containsObject:r19];
     *   [r24 release];
     *   if (r22 != 0x0) {
     *   r0 = [r20 objectForKey:**_NSFilePosixPermissions];
     *   r0 = [r0 retain];
     *   r25 = r0;
     *   ... (163 more lines)
     */
    return NO;
}

- (BOOL)isSameFile:(id)arg1 asFile:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r3 = arg3;
     *   r2 = arg2;
     *   r31 = r31 - 0x50;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r22 = 0x0;
     *   if (r2 != 0x0 && r3 != 0x0) {
     *   r21 = [r3 retain];
     *   r0 = [NSURL fileURLWithPath:r2];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r19 = [[r0 URLByResolvingSymlinksInPath] retain];
     *   [r20 release];
     *   r22 = [[NSURL fileURLWithPath:r21] retain];
     *   [r21 release];
     *   r20 = [[r22 URLByResolvingSymlinksInPath] retain];
     *   [r22 release];
     *   var_38 = 0x0;
     *   [r19 getResourceValue:&var_38 forKey:**_NSURLFileResourceIdentifierKey error:0x0];
     *   ... (25 more lines)
     */
    return NO;
}

- (id)getDisplayStringForPath:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x50;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = [arg2 retain];
     *   r22 = [NSHomeDirectory() retain];
     *   r19 = [[self componentsToDisplayForPath:r22] retain];
     *   [r22 release];
     *   r20 = [[self componentsToDisplayForPath:r21] retain];
     *   [r21 release];
     *   r21 = [r19 count];
     *   r22 = [r20 count] - r21;
     *   if (r22 >= 0x0) {
     *   r3 = r21;
     *   r23 = [[r20 subarrayWithRange:0x0] retain];
     *   r24 = [r19 isEqualToArray:r23];
     *   [r23 release];
     *   if (r24 != 0x0) {
     *   r24 = [NSUserName() retain];
     *   r23 = [[NSArray arrayWithObject:r24] retain];
     *   ... (23 more lines)
     */
    return nil;
}

- (id)pathFromBookmarkData:(id)arg1 stale:(BOOL *)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x50;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = arg3;
     *   r21 = self;
     *   r0 = [arg2 retain];
     *   r19 = r0;
     *   if ([r0 length] != 0x0) {
     *   r23 = [NSHomeDirectory() retain];
     *   r24 = [[NSURL fileURLWithPath:r23] retain];
     *   r0 = [NSURL URLByResolvingBookmarkData:r19 options:0x300 relativeToURL:r24 bookmarkDataIsStale:&var_31 error:0x0];
     *   r22 = [r0 retain];
     *   [r24 release];
     *   [r23 release];
     *   r23 = [[r22 path] retain];
     *   r0 = [r21 isFileInTrash:r23];
     *   r21 = 0x0;
     *   if ((r0 & 0x1) == 0x0) {
     *   if (r20 != 0x0 && r23 != 0x0) {
     *   ... (13 more lines)
     */
    return nil;
}

- (id)bookmarkDataFromPath:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r19 = [[NSURL fileURLWithPath:arg2] retain];
     *   r20 = **___NSArray0__;
     *   r22 = [NSHomeDirectory() retain];
     *   r21 = [[NSURL fileURLWithPath:r22] retain];
     *   r20 = [[r19 bookmarkDataWithOptions:0x0 includingResourceValuesForKeys:r20 relativeToURL:r21 error:0x0] retain];
     *   [r21 release];
     *   [r22 release];
     *   [r19 release];
     *   r0 = [r20 autorelease];
     *   return r0;
     */
    return nil;
}

- (BOOL)makeWritableAtPath:(id)arg1 recursively:(BOOL)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r1 = _cmd;
     *   r31 = r31 - 0x190;
     *   var_50 = r28;
     *   decomp_var_48 = r27;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r23 = arg3;
     *   var_60 = **___stack_chk_guard;
     *   r19 = [arg2 retain];
     *   var_E8 = 0x0;
     *   var_150 = self;
     *   r0 = [self attributesOfItemAtPath:r19 error:&var_E8];
     *   r21 = [r0 retain];
     *   r22 = [var_E8 retain];
     *   if (r21 == 0x0) goto loc_1000289f4;
     *   goto loc_10002873c;
     *   loc_1000289f4:
     *   ... (261 more lines)
     */
    return NO;
}

- (void)removeFolderIfEmpty:(id)arg1 upTo:(id)arg2 {
    return;
}

- (BOOL)isFileInTrash:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r21 = [[self trashForFile:r20] retain];
     *   r19 = [self isFile:r20 inDirectory:r21];
     *   [r20 release];
     *   [r21 release];
     *   r0 = r19;
     *   return r0;
     */
    return NO;
}

- (id)trashForFile:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r2 = arg2;
     *   r0 = self;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   if (r2 != 0x0) {
     *   r20 = r0;
     *   r0 = [NSURL fileURLWithPath:r2];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r20 URLForDirectory:0x66 inDomain:0x1 appropriateForURL:r19 create:0x1 error:0x0];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   if (r0 == 0x0) {
     *   r21 = [[r20 URLForDirectory:0x66 inDomain:0x2 appropriateForURL:r19 create:0x1 error:0x0] retain];
     *   }
     *   r20 = [[r21 path] retain];
     *   [r21 release];
     *   }
     *   else {
     *   ... (9 more lines)
     */
    return nil;
}

- (BOOL)isFile:(id)arg1 inDirectory:(id)arg2 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x90;
     *   var_50 = r28;
     *   decomp_var_48 = r27;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = arg3;
     *   var_58 = **___stack_chk_guard;
     *   r0 = [arg2 retain];
     *   r19 = r0;
     *   r23 = 0x0;
     *   if (r0 != 0x0 && r20 != 0x0) {
     *   r20 = [[NSURL fileURLWithPath:r20] retain];
     *   r8 = *_NSURLFileResourceIdentifierKey;
     *   r9 = *_NSURLIsSymbolicLinkKey;
     *   r23 = *r8;
     *   r24 = *r9;
     *   var_68 = r23;
     *   ... (106 more lines)
     */
    return NO;
}

- (void)clearQuarantine:(id)arg1 {
    return;
}

@end
