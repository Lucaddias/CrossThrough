// InstallDependency.m — CrossThrough
#import "InstallDependency.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation InstallDependency

+ (id)keyPathsForValuesAffectingManuallyRemoved {
    return [NSSet setWithObject:@"undo"];
}

+ (id)keyPathsForValuesAffectingManuallyAdded {
    return [NSSet setWithObject:@"undo"];
}

+ (id)keyPathsForValuesAffectingDisplayName {
    return [NSSet setWithObjects:@"name", nil];
}

+ (id)keyPathsForValuesAffectingCanRemove {
    return [NSSet setWithObjects:@"reason", nil];
}

+ (id)keyPathsForValuesAffectingCanReAdd {
    return [NSSet setWithObject:@"manuallyRemoved"];
}

- (id)init {
    self = [super init];
    return self;
}

- (void)dealloc {
    [self->_appID release];
    self->_appID = nil;
    [self->_parent release];
    self->_parent = nil;
    [self->_name release];
    self->_name = nil;
    [self->_reason release];
    self->_reason = nil;
    [self->_reasonString release];
    self->_reasonString = nil;
    [super dealloc];
}

- (id)description {
    return [NSString stringWithFormat:@"%@ appID %@ reason %@ %@ undo %lu",
            [super description],
            [self appID],
            [self reason],
            [self reasonString],
            (unsigned long)[self undo]];
}

- (BOOL)isEqual:(id)arg1 {
    if (arg1 == self) return YES;
    if ([arg1 isMemberOfClass:[self class]]) {
        return [[self appID] isEqualToString:[arg1 appID]];
    }
    return NO;
}

- (NSUInteger)hash {
    return [[self appID] hash];
}

- (BOOL)isManuallyRemoved {
    return [self undo] == 1;
}

- (BOOL)isManuallyAdded {
    return [self undo] == 2;
}

- (id)displayName {
    NSFont *font = [NSFont systemFontOfSize:[NSFont systemFontSize]];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    if ([self isManuallyRemoved]) {
        [attrs setObject:@(1) forKey:NSStrikethroughStyleAttributeName];
    }
    NSString *n = [self name] ?: @"";
    return [[[NSAttributedString alloc] initWithString:n attributes:attrs] autorelease];
}

- (BOOL)canRemove {
    if ([self isManuallyRemoved]) {
        return NO;
    }
    return ![[self reason] isEqualToNumber:[InstallConfiguration reasonMain]];
}

- (BOOL)canReAdd {
    return [self isManuallyRemoved];
}

- (NSInteger)depth {
    NSInteger d = 0;
    InstallDependency *p = [self parent];
    while (p) {
        d++;
        p = [p parent];
    }
    return d;
}

- (id)sortKey {
    return self;
}

- (NSInteger)compareInstallDependencySortKey:(id)arg1 {
    if (self == arg1) return NSOrderedSame;
    NSInteger d1 = [self depth];
    NSInteger d2 = [arg1 depth];
    if (d1 < d2) {
        return NSOrderedAscending;
    } else if (d1 > d2) {
        return NSOrderedDescending;
    }
    return [self compareInstallDependencyWithinDepth:arg1];
}

- (NSInteger)compareInstallDependencyWithinDepth:(id)arg1 {
    NSComparisonResult res = [[self reason] compare:[arg1 reason]];
    if (res == NSOrderedSame) {
        if ([self parent] && [arg1 parent]) {
            res = [[self parent] compareInstallDependencyWithinDepth:[arg1 parent]];
            if (res != NSOrderedSame) return res;
        }
        return [[self name] localizedStandardCompare:[arg1 name]];
    }
    return res;
}

- (id)appID {
    return self->_appID;
}

- (void)setAppID:(id)arg1 {
    if (self->_appID != arg1) {
        [self->_appID release];
        self->_appID = [arg1 copy];
    }
}

- (id)parent {
    return self->_parent;
}

- (void)setParent:(id)arg1 {
    if (self->_parent != arg1) {
        [self->_parent release];
        self->_parent = [arg1 retain];
    }
}

- (id)name {
    return self->_name;
}

- (void)setName:(id)arg1 {
    if (self->_name != arg1) {
        [self->_name release];
        self->_name = [arg1 copy];
    }
}

- (id)reason {
    return self->_reason;
}

- (void)setReason:(id)arg1 {
    if (self->_reason != arg1) {
        [self->_reason release];
        self->_reason = [arg1 retain];
    }
}

- (id)reasonString {
    return self->_reasonString;
}

- (void)setReasonString:(id)arg1 {
    if (self->_reasonString != arg1) {
        [self->_reasonString release];
        self->_reasonString = [arg1 copy];
    }
}

- (NSUInteger)undo {
    return self->_undo;
}

- (void)setUndo:(NSUInteger)arg1 {
    self->_undo = arg1;
}

@end
