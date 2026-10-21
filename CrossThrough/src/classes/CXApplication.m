// CXApplication.m — CrossThrough
#import "CXApplication.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "c_functions.h"

@implementation CXApplication

+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *supportPath = [[NSBundle mainBundle] sharedSupportPath];
        if (supportPath) {
            self->crossOverRoot = [[supportPath stringByAppendingPathComponent:@"CrossOver"] retain];
        }
        NSURL *supportURL = [[NSBundle mainBundle] sharedSupportURL];
        if (supportURL) {
            self->crossOverRootURL = [[supportURL URLByAppendingPathComponent:@"CrossOver" isDirectory:YES] retain];
        }
    }
    return self;
}

- (void)setDelegate:(id)arg1 {
    [self setCXServer:arg1];
    [super setDelegate:arg1];
}

- (id)crossOverRoot {
    return self->crossOverRoot;
}

- (id)crossOverRootURL {
    return self->crossOverRootURL;
}

- (BOOL)isDemo {
    return self->isDemo;
}

- (void)setIsDemo {
    self->isDemo = NO;
}

- (NSInteger)daysLeft {
    return self->daysLeft;
}

- (void)setDaysLeft {
    self->daysLeft = 999;
}

- (void)orderFrontStandardAboutPanel:(id)arg1 {
    [super orderFrontStandardAboutPanel:arg1];
}

- (void)reportException:(id)arg1 {
    _CXLog(@"AppKit caught exception: %@", [arg1 debugDescription]);
    [super reportException:arg1];
}

- (void)sendEvent:(id)arg1 {
    if (![(WineApplicationController *)[self wineController] handleEvent:arg1]) {
        [super sendEvent:arg1];
        [(WineApplicationController *)[self wineController] didSendEvent:arg1];
    }
}

- (id)licenseID {
    return self->_licenseID;
}

- (void)setLicenseID:(id)arg1 {
    self->_licenseID = [arg1 copy];
}

- (id)licenseExpirationDate {
    return self->_licenseExpirationDate;
}

- (void)setLicenseExpirationDate:(id)arg1 {
    self->_licenseExpirationDate = [arg1 copy];
}

- (id)wineController {
    return [objc_loadWeakRetained((id *)&self->_wineController) autorelease];
}

- (void)setWineController:(id)arg1 {
    objc_storeWeak((id *)&self->_wineController, arg1);
}

- (id)demoString {
    return self->_demoString;
}

- (void)setDemoString:(id)arg1 {
    self->_demoString = [arg1 copy];
}

- (id)CXServer {
    return [objc_loadWeakRetained((id *)&self->_CXServer) autorelease];
}

- (void)setCXServer:(id)arg1 {
    objc_storeWeak((id *)&self->_CXServer, arg1);
}

@end
