// PropertyDescriptor.h — CrossThrough
#ifndef PropertyDescriptor_h
#define PropertyDescriptor_h

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"

#import "CXObject.h"

@class PropertyDescriptor;

@interface PropertyDescriptor : CXObject
{
    BOOL _boolTyped;
    NSString * _installTaskAttribute;
    NSString * _getter;
    NSString * _setter;
}

// Instance Methods
- (id)description;
- (id)installTaskAttribute;
- (void)setInstallTaskAttribute:(id)arg1;
- (BOOL)boolTyped;
- (void)setBoolTyped:(BOOL)arg1;
- (id)getter;
- (void)setGetter:(id)arg1;
- (id)setter;
- (void)setSetter:(id)arg1;

@end

#endif /* PropertyDescriptor_h */
