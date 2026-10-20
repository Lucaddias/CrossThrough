// InstallDependency.m — CrossThrough
#import "InstallDependency.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallDependency

+ (id)keyPathsForValuesAffectingManuallyRemoved {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"undo"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingManuallyAdded {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"undo"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingDisplayName {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"name"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingCanRemove {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObjects:@"reason"];
     *   return r0;
     */
    return nil;
}

+ (id)keyPathsForValuesAffectingCanReAdd {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [NSSet setWithObject:@"manuallyRemoved"];
     *   return r0;
     */
    return nil;
}

- (id)description {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_40 = self;
     *   r0 = [[&var_40 super] description];
     *   r21 = [r0 retain];
     *   r22 = [[self appID] retain];
     *   r23 = [[self reason] retain];
     *   r24 = [[self reasonString] retain];
     *   [self undo];
     *   r19 = [[NSString stringWithFormat:@"%@ appID %@ reason %@ %@ undo %lu", r3, r4, r5, r6, r7] retain];
     *   [r24 release];
     *   [r23 release];
     *   [r22 release];
     *   [r21 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (BOOL)isEqual:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [arg2 retain];
     *   r19 = r0;
     *   if (r0 != r20) {
     *   if ([r19 isMemberOfClass:objc_opt_class(r20)] != 0x0) {
     *   r21 = [[r20 appID] retain];
     *   r22 = [[r19 appID] retain];
     *   r20 = [r21 isEqualToString:r22];
     *   [r22 release];
     *   [r21 release];
     *   }
     *   else {
     *   r20 = 0x0;
     *   }
     *   }
     *   else {
     *   r20 = 0x1;
     *   }
     *   ... (3 more lines)
     */
    return NO;
}

- (NSUInteger)hash {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self appID];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [r0 hash];
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return 0;
}

- (BOOL)isManuallyRemoved {
    /*
     * Decompiled from CrossOver 26.3:
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r31 = r31 + 0xfffffffffffffff0;
     *   r0 = [self undo];
     *   if (r0 == 0x1) {
     *   r0 = 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (BOOL)isManuallyAdded {
    /*
     * Decompiled from CrossOver 26.3:
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r31 = r31 + 0xfffffffffffffff0;
     *   r0 = [self undo];
     *   if (r0 == 0x2) {
     *   r0 = 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (id)displayName {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   [NSFont systemFontSize];
     *   r21 = [[NSFont systemFontOfSize:r2] retain];
     *   r20 = [[NSMutableDictionary dictionaryWithObject:r21 forKey:**_NSFontAttributeName] retain];
     *   [r21 release];
     *   if ([r19 isManuallyRemoved] != 0x0) {
     *   r21 = [@(0x1) retain];
     *   [r20 setObject:r21 forKey:**_NSStrikethroughStyleAttributeName];
     *   [r21 release];
     *   }
     *   r21 = [NSAttributedString alloc];
     *   r19 = [[r19 name] retain];
     *   r21 = [r21 initWithString:r19 attributes:r20];
     *   [r19 release];
     *   [r20 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (BOOL)canRemove {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   if (([self isManuallyRemoved] & 0x1) != 0x0) {
     *   r0 = 0x0;
     *   }
     *   else {
     *   r19 = [[r19 reason] retain];
     *   r20 = [[InstallConfiguration reasonMain] retain];
     *   r21 = [r19 isEqualToNumber:r20];
     *   [r20 release];
     *   [r19 release];
     *   r0 = r21 ^ 0x1;
     *   }
     *   return r0;
     */
    return NO;
}

- (BOOL)canReAdd {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self isManuallyRemoved];
     *   return r0;
     */
    return NO;
}

- (NSInteger)depth {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r0 = [self parent];
     *   r0 = [r0 retain];
     *   if (r0 != 0x0) {
     *   r20 = r0;
     *   r19 = 0x0;
     *   do {
     *   r19 = r19 + 0x1;
     *   r21 = [[r20 parent] retain];
     *   [r20 release];
     *   r20 = r21;
     *   } while (r21 != 0x0);
     *   }
     *   else {
     *   r19 = 0x0;
     *   }
     *   r0 = r19;
     *   return r0;
     */
    return 0;
}

- (id)sortKey {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = self;
     *   return r0;
     */
    return nil;
}

- (NSInteger)compareInstallDependencySortKey:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   r31 = r31 + 0xffffffffffffffd0;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r20 = self;
     *   r0 = [arg2 retain];
     *   r19 = r0;
     *   if (r20 != r0) {
     *   r21 = [r20 depth];
     *   r0 = [r19 depth];
     *   bool_2 = r21 <= r0;
     *   if (r21 < r0) {
     *   r20 = 0xffffffffffffffff;
     *   }
     *   else {
     *   if (!bool_2) {
     *   r20 = 0x1;
     *   }
     *   else {
     *   r20 = [r20 compareInstallDependencyWithinDepth:r19];
     *   }
     *   }
     *   ... (7 more lines)
     */
    return 0;
}

- (NSInteger)compareInstallDependencyWithinDepth:(id)arg1 {
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
     *   r20 = self;
     *   r19 = [arg2 retain];
     *   r22 = [[r20 reason] retain];
     *   r23 = [[r19 reason] retain];
     *   r21 = [r22 compare:r23];
     *   [r23 release];
     *   [r22 release];
     *   if (r21 == 0x0) {
     *   r0 = [r20 parent];
     *   r0 = [r0 retain];
     *   r21 = r0;
     *   [r0 release];
     *   if (r21 != 0x0) {
     *   r20 = [[r20 parent] retain];
     *   r22 = [[r19 parent] retain];
     *   r21 = [r20 compareInstallDependencyWithinDepth:r22];
     *   ... (7 more lines)
     */
    return 0;
}

- (id)appID {
    return self->_appID;
}

- (void)setAppID:(id)arg1 {
    return;
}

- (id)parent {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = objc_loadWeakRetained((int64_t *)&self->_parent);
     *   r0 = [r0 autorelease];
     *   return r0;
     */
    return nil;
}

- (void)setParent:(id)arg1 {
    return;
}

- (id)name {
    return self->_name;
}

- (void)setName:(id)arg1 {
    return;
}

- (id)reason {
    return self->_reason;
}

- (void)setReason:(id)arg1 {
    return;
}

- (id)reasonString {
    return self->_reasonString;
}

- (void)setReasonString:(id)arg1 {
    return;
}

- (NSUInteger)undo {
    return self->_undo;
}

- (void)setUndo:(NSUInteger)arg1 {
    return;
}

@end
