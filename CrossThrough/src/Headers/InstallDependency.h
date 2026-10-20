// InstallDependency.h — CrossThrough
#ifndef InstallDependency_h
#define InstallDependency_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class InstallDependency;

@interface InstallDependency : CXObject
{
    NSString * _appID;
    InstallDependency * _parent;
    NSString * _name;
    NSNumber * _reason;
    NSString * _reasonString;
    NSUInteger _undo;
}

// Class Methods
+ (id)keyPathsForValuesAffectingManuallyRemoved;
+ (id)keyPathsForValuesAffectingManuallyAdded;
+ (id)keyPathsForValuesAffectingDisplayName;
+ (id)keyPathsForValuesAffectingCanRemove;
+ (id)keyPathsForValuesAffectingCanReAdd;

// Instance Methods
- (id)description;
- (BOOL)isEqual:(id)arg1;
- (NSUInteger)hash;
- (BOOL)isManuallyRemoved;
- (BOOL)isManuallyAdded;
- (id)displayName;
- (BOOL)canRemove;
- (BOOL)canReAdd;
- (NSInteger)depth;
- (id)sortKey;
- (NSInteger)compareInstallDependencySortKey:(id)arg1;
- (NSInteger)compareInstallDependencyWithinDepth:(id)arg1;
- (id)appID;
- (void)setAppID:(id)arg1;
- (id)parent;
- (void)setParent:(id)arg1;
- (id)name;
- (void)setName:(id)arg1;
- (id)reason;
- (void)setReason:(id)arg1;
- (id)reasonString;
- (void)setReasonString:(id)arg1;
- (NSUInteger)undo;
- (void)setUndo:(NSUInteger)arg1;

@end

#endif /* InstallDependency_h */
