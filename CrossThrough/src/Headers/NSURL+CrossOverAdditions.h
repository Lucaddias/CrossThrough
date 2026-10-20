// NSURL+CrossOverAdditions.h — CrossThrough
#ifndef NSURL_CrossOverAdditions_h
#define NSURL_CrossOverAdditions_h

#import <Cocoa/Cocoa.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@interface NSURL (CrossOverAdditions)

// Instance Methods
- (id)stringWithFileSystemRepresentation;

@end

#endif /* NSURL_CrossOverAdditions_h */
