// TaskStatus.h — CrossThrough
#ifndef TaskStatus_h
#define TaskStatus_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class TaskStatus;
@class InstallationOperation;

@interface TaskStatus : CXObject
{
    BOOL _finished;
    BOOL _success;
    NSString * _label;
    AIETask * _task;
    InstallationOperation * _installOp;
}

// Instance Methods
- (id)initWithTask:(id)arg1;
- (void)cancel;
- (void)done;
- (BOOL)finished;
- (void)setFinished:(BOOL)arg1;
- (BOOL)success;
- (void)setSuccess:(BOOL)arg1;
- (id)label;
- (void)setLabel:(id)arg1;
- (id)task;
- (void)setTask:(id)arg1;
- (id)installOp;
- (void)setInstallOp:(id)arg1;

@end

#endif /* TaskStatus_h */
