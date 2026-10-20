// InstallationOperation.h — CrossThrough
#ifndef InstallationOperation_h
#define InstallationOperation_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@class InstallationOperation;
@class TaskStatus;

@interface InstallationOperation : NSOperation
{
    TaskStatus * taskStatus;
    SEL completionSelector;
    id selectorTarget;
}

// Instance Methods
- (id)initWithTaskStatus:(id)arg1 completionSelector:(SEL)arg2 andTarget:(id)arg3;
- (void)main;

@end

#endif /* InstallationOperation_h */
