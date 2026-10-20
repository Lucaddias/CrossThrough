// NSFileManager+CrossOverAdditions.h — CrossThrough
#ifndef NSFileManager_CrossOverAdditions_h
#define NSFileManager_CrossOverAdditions_h

#import <Cocoa/Cocoa.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@interface NSFileManager (CrossOverAdditions)

// Class Methods
+ (id)systemPaths;

// Instance Methods
- (BOOL)createDirectoryAtPath:(id)arg1 attributes:(id)arg2 recursively:(BOOL)arg3;
- (BOOL)isSameFile:(id)arg1 asFile:(id)arg2;
- (id)getDisplayStringForPath:(id)arg1;
- (id)pathFromBookmarkData:(id)arg1 stale:(BOOL *)arg2;
- (id)bookmarkDataFromPath:(id)arg1;
- (BOOL)makeWritableAtPath:(id)arg1 recursively:(BOOL)arg2;
- (void)removeFolderIfEmpty:(id)arg1 upTo:(id)arg2;
- (BOOL)isFileInTrash:(id)arg1;
- (id)trashForFile:(id)arg1;
- (BOOL)isFile:(id)arg1 inDirectory:(id)arg2;
- (void)clearQuarantine:(id)arg1;

@end

#endif /* NSFileManager_CrossOverAdditions_h */
