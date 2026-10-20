// InstallConfiguration.m — CrossThrough
#import "InstallConfiguration.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "PropertyDescriptor.h"
#import <objc/runtime.h>

static dispatch_once_t _resolveOnceToken = 0;
static NSMutableDictionary *_selectorToProperty = nil;

@implementation InstallConfiguration

+ (BOOL)automaticallyNotifiesObserversOfSelectedPackage {
    return NO;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (_resolveOnceToken != -1) {
        dispatch_once(&_resolveOnceToken, ^{
            NSDictionary *attrMap = @{
                @"bottleName": @"bottlename",
                @"dependencyOverrides": @"dependency_overrides",
                @"downloadURL": @"download_url",
                @"nameForNewBottle": @"newBottleName",
                @"postInstallURL": @"post_install_url",
                @"steamID": @"steamid",
                @"targetBottle": @"target_bottle"
            };
            _selectorToProperty = [[NSMutableDictionary alloc] init];
            unsigned int count = 0;
            objc_property_t *props = class_copyPropertyList([InstallConfiguration class], &count);
            if (props) {
                for (unsigned int i = 0; i < count; i++) {
                    objc_property_t prop = props[i];
                    char *dynamic = property_copyAttributeValue(prop, "D");
                    if (dynamic) {
                        free(dynamic);
                        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
                        PropertyDescriptor *desc = [[PropertyDescriptor alloc] init];
                        NSString *attr = [attrMap objectForKey:propName];
                        if (!attr) attr = propName;
                        [desc setInstallTaskAttribute:attr];

                        char *type = property_copyAttributeValue(prop, "T");
                        if (type) {
                            if (strcmp(type, "B") == 0 || strcmp(type, "c") == 0) {
                                [desc setBoolTyped:YES];
                            }
                            free(type);
                        }

                        char *getter = property_copyAttributeValue(prop, "G");
                        if (getter) {
                            [desc setGetter:[NSString stringWithUTF8String:getter]];
                            free(getter);
                        } else {
                            [desc setGetter:propName];
                        }
                        [_selectorToProperty setObject:desc forKey:[desc getter]];

                        char *readonly = property_copyAttributeValue(prop, "R");
                        if (readonly) {
                            free(readonly);
                        } else {
                            char *setter = property_copyAttributeValue(prop, "S");
                            if (setter) {
                                [desc setSetter:[NSString stringWithUTF8String:setter]];
                                free(setter);
                            } else {
                                NSString *firstCap = [[propName substringToIndex:1] uppercaseString];
                                NSString *rest = [propName substringFromIndex:1];
                                [desc setSetter:[NSString stringWithFormat:@"set%@%@:", firstCap, rest]];
                            }
                            [_selectorToProperty setObject:desc forKey:[desc setter]];
                        }
                        [desc release];
                    }
                }
                free(props);
            }
        });
    }

    NSString *selStr = NSStringFromSelector(sel);
    PropertyDescriptor *desc = [_selectorToProperty objectForKey:selStr];
    if (desc) {
        if ([[desc getter] isEqualToString:selStr]) {
            BOOL isAttrEqual = [[desc installTaskAttribute] isEqualToString:[desc getter]];
            IMP imp = NULL;
            const char *types = NULL;
            if ([desc boolTyped]) {
                imp = isAttrEqual ? (IMP)_boolGetterMethodFastIMP : (IMP)_boolGetterMethodIMP;
                types = "c@:";
            } else {
                imp = isAttrEqual ? (IMP)_objectGetterMethodFastIMP : (IMP)_objectGetterMethodIMP;
                types = "@@:";
            }
            class_addMethod(self, sel, imp, types);
            return YES;
        } else if ([[desc setter] isEqualToString:selStr]) {
            IMP imp = NULL;
            const char *types = NULL;
            if ([desc boolTyped]) {
                imp = (IMP)_boolSetterMethodIMP;
                types = "v@:c";
            } else {
                imp = (IMP)_objectSetterMethodIMP;
                types = "v@:@";
            }
            class_addMethod(self, sel, imp, types);
            return YES;
        }
    }

    return [super resolveInstanceMethod:sel];
}

static id _objectGetterMethodIMP(id self, SEL _cmd) {
    InstallConfiguration *config = (InstallConfiguration *)self;
    PropertyDescriptor *desc = [_selectorToProperty objectForKey:NSStringFromSelector(_cmd)];
    NSString *attr = [desc installTaskAttribute] ?: NSStringFromSelector(_cmd);
    return [config->_installTask valueForKey:attr];
}

static id _objectGetterMethodFastIMP(id self, SEL _cmd) {
    InstallConfiguration *config = (InstallConfiguration *)self;
    return [config->_installTask valueForKey:NSStringFromSelector(_cmd)];
}

static BOOL _boolGetterMethodIMP(id self, SEL _cmd) {
    InstallConfiguration *config = (InstallConfiguration *)self;
    PropertyDescriptor *desc = [_selectorToProperty objectForKey:NSStringFromSelector(_cmd)];
    NSString *attr = [desc installTaskAttribute] ?: NSStringFromSelector(_cmd);
    return [[config->_installTask valueForKey:attr] boolValue];
}

static BOOL _boolGetterMethodFastIMP(id self, SEL _cmd) {
    InstallConfiguration *config = (InstallConfiguration *)self;
    return [[config->_installTask valueForKey:NSStringFromSelector(_cmd)] boolValue];
}

static void _objectSetterMethodIMP(id self, SEL _cmd, id value) {
    InstallConfiguration *config = (InstallConfiguration *)self;
    PropertyDescriptor *desc = [_selectorToProperty objectForKey:NSStringFromSelector(_cmd)];
    NSString *attr = [desc installTaskAttribute];
    [config->_installTask setValue:value forKey:attr];
}

static void _boolSetterMethodIMP(id self, SEL _cmd, BOOL value) {
    InstallConfiguration *config = (InstallConfiguration *)self;
    PropertyDescriptor *desc = [_selectorToProperty objectForKey:NSStringFromSelector(_cmd)];
    NSString *attr = [desc installTaskAttribute];
    [config->_installTask setValue:@(value) forKey:attr];
}

+ (id)reasonMain {
    return [[CXSetupLib cxSetupClass] dependencyReason:@"MAIN"];
}

+ (id)reasonSteam {
    return [[CXSetupLib cxSetupClass] dependencyReason:@"STEAM"];
}

+ (id)reasonOverride {
    return [[CXSetupLib cxSetupClass] dependencyReason:@"OVERRIDE"];
}

+ (id)reasonDependency {
    return [[CXSetupLib cxSetupClass] dependencyReason:@"DEPENDENCY"];
}

+ (id)overrideExclude {
    return [[CXSetupLib cxSetupClass] dependencyOverride:@"EXCLUDE"];
}

+ (id)overrideInclude {
    return [[CXSetupLib cxSetupClass] dependencyOverride:@"INCLUDE"];
}

- (id)init {
    self = [super init];
    if (self) {
        Class taskClass = [CXSetupLib installTaskClass];
        if (taskClass) {
            self->_installTask = [(InstallTask *)[taskClass alloc] initWithDelegate:self];
        }
        self->_delegates = [[NSMutableArray alloc] init];
        self->_bottleCollection = [[[CXSetupLib bottleCollectionClass] sharedCollection] retain];
    }
    return self;
}

- (void)dealloc {
    [self->_installTask setDelegate:nil];
    [self->_installTask release];
    self->_installTask = nil;
    [self->_delegates release];
    self->_delegates = nil;
    [self->_environment release];
    [self->_logChannels release];
    [self->_logEnvironment release];
    [self->_logFileURL release];
    [self->_selectedPackage release];
    [self->_bottleCollection release];
    self->_bottleCollection = nil;
    [super dealloc];
}

#pragma mark - Bottle & Package Compatibility

- (BOOL)newBottleCollidesWithExistingBottle {
    if ([self creatingNewBottle]) {
        id bc = [self bottleCollection];
        NSString *name = [self nameForNewBottle];
        if (name && [bc bottleWithName:name]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)hasBottle {
    if ([self newBottleCollidesWithExistingBottle]) {
        return NO;
    }
    NSString *name = [self bottleName];
    return [name length] > 0;
}

- (BOOL)hasInstallerSource {
    NSString *src = [self installerSource];
    if ([src length] > 0) {
        return YES;
    }
    NSString *dl = [self installerDownloadSource];
    if ([dl length] == 0 && ![self installWithSteam]) {
        return [self isVirtual];
    }
    return YES;
}

- (BOOL)hasPackage {
    return [self profile] != nil;
}

- (BOOL)bottleIsCompatibleWithPackage {
    if ([self hasPackage]) {
        TargetBottle *tb = (TargetBottle *)[self targetBottle];
        if (!tb) return YES;
        NSNumber *cat = [tb getCategory];
        NSNumber *incomp = [[CXSetupLib cxSetupClass] bottleCategory:@"INCOMPATIBLE"];
        return ![cat isEqualToNumber:incomp];
    }
    return YES;
}

- (BOOL)creatingNewBottle {
    return [self->_installTask GetCreateNewBottle];
}

- (void)setInstallerLocale:(NSString *)arg1 {
    [self->_installTask setLocale:arg1];
}

- (void)setInstallerSource:(id)arg1 forUser:(BOOL)arg2 {
    [self->_installTask setInstallerSource:arg1 Requested:@(arg2)];
}

- (void)setInstallerSteam {
    [self->_installTask setInstallerSteam];
}

- (void)setInstallerDownload {
    [self->_installTask setInstallerDownload];
}

- (void)setProfile:(id)arg1 {
    if ([self profile] != arg1) {
        [self->_installTask setProfile:arg1];
    }
}

- (void)setSelectedPackage:(id)arg1 forUser:(BOOL)arg2 {
    if (self->_selectedPackage != arg1) {
        [self willChangeValueForKey:@"selectedPackage"];
        [self->_selectedPackage release];
        self->_selectedPackage = [arg1 retain];
        [self didChangeValueForKey:@"selectedPackage"];
        if (arg2) {
            id prof = [arg1 packageobject];
            [self setProfile:prof];
        }
    }
}

- (id)profileLanguages {
    return [self->_installTask profileLanguages];
}

#pragma mark - Details

- (id)dependencyDetails {
    return [self->_installTask getDependencyDetails];
}

- (id)installerDetails {
    return [self->_installTask getInstallerDetails];
}

- (id)bottleDetails {
    return [self->_installTask getBottleDetails];
}

- (id)languageDetails {
    return [self->_installTask getLanguageDetails];
}

- (id)miscDetails {
    return [self->_installTask getMiscDetails];
}

- (void)updateProfiles {
    [self->_installTask updateProfiles];
}

- (BOOL)isNewBottleNameValid:(id)arg1 {
    return [self->_installTask isNewBottleNameValid:arg1];
}

- (void)createNewBottle:(id)arg1 template:(id)arg2 {
    [self->_installTask createNewBottle:arg1 template:arg2];
}

- (void)setNewBottleName:(id)arg1 {
    [self->_installTask setNewBottleName:arg1];
}

- (void)addSourceMedia:(id)arg1 withLabel:(id)arg2 andDevice:(id)arg3 {
    [self->_installTask addSourceMedia:arg1 withLabel:arg2 andDevice:arg3];
}

- (void)addSourceMedia:(id)arg1 {
    NSString *displayName = [[NSFileManager defaultManager] displayNameAtPath:arg1];
    [self addSourceMedia:arg1 withLabel:displayName andDevice:@""];
}

- (void)removeSourceMedia:(id)arg1 {
    [self->_installTask removeSourceMedia:arg1];
}

- (BOOL)volumeMatchesProfile:(id)arg1 {
    return [self->_installTask volumeMatchesProfile:arg1];
}

- (id)profiles {
    id p = [self->_installTask valueForKey:@"profiles"];
    if ([p respondsToSelector:@selector(contentsDict)]) {
        return [p contentsDict];
    }
    return p;
}

- (id)profileForAppID:(id)arg1 {
    return [[self profiles] objectForKey:arg1];
}

- (id)nameForProfileWithAppID:(id)arg1 {
    if ([arg1 isEqualToString:@"com.codeweavers.unknown"]) {
        return [[NSBundle mainBundle] localizedStringForKey:@"Unlisted application" value:@"" table:nil];
    }
    id prof = [self profileForAppID:arg1];
    return [prof valueForKey:@"name"];
}

- (id)addBottle:(id)arg1 {
    return [self->_installTask addBottle:arg1];
}

- (void)removeBottle:(id)arg1 {
    [self->_installTask removeBottle:arg1];
}

- (void)installedApplicationsReady:(id)arg1 {
    [self->_installTask installedApplicationsReady:arg1];
}

- (void)triggerBottleAnalysis {
    [self->_installTask triggerBottleAnalysis];
}

- (id)recommendedTemplate {
    NSDictionary *tmpls = [self templates];
    id tmplKey = [self->_installTask valueForKey:@"new_bottle_template"];
    return [tmpls valueForKey:tmplKey];
}

- (void)useAutorunFile:(id)arg1 {
    [self->_installTask useAutorunFile:arg1];
}

- (void)autoFillSettings {
    [self->_installTask autoFillSettings];
}

- (id)logFileName {
    NSMutableArray *parts = [NSMutableArray arrayWithObject:@"Install"];
    NSString *bottleName = [self bottleName];
    if (bottleName) {
        [parts addObject:bottleName];
    }
    id prof = [self profile];
    if (prof && ![self creatingNewBottle]) {
        NSString *name = [prof valueForKey:@"name"];
        NSString *sanitized = [[CXSetupLib cxUtilsClass] sanitizedBottleName:name];
        if (sanitized) {
            [parts addObject:sanitized];
        }
    }
    return [parts componentsJoinedByString:@"-"];
}

- (id)newInstallEngine {
    NSString *env = nil;
    if ([self.logEnvironment length] > 0) {
        if ([self.environment length] > 0) {
            env = [NSString stringWithFormat:@"%@ %@", self.logEnvironment, self.environment];
        } else {
            env = self.logEnvironment;
        }
    } else if ([self.environment length] > 0) {
        env = self.environment;
    }

    NSString *logPath = [self->_logFileURL path];
    if ([logPath length] == 0) logPath = nil;
    NSString *channels = [self->_logChannels length] > 0 ? self->_logChannels : nil;

    return [(Engine *)[[CXSetupLib cxAiEngineClass] alloc] initWithInstallTask:self->_installTask
                                                            logFile:logPath
                                                           channels:channels
                                                                env:env];
}

#pragma mark - Delegates & Forwarding

- (void)addDelegate:(id)arg1 {
    if (arg1 && ![self->_delegates containsObject:arg1]) {
        [self->_delegates addObject:arg1];
    }
}

- (void)removeDelegate:(id)arg1 {
    if (arg1) {
        [self->_delegates removeObject:arg1];
    }
}

- (void)forwardDelegateMethod:(SEL)arg1 {
    NSArray *dels = [self->_delegates copy];
    for (id d in dels) {
        if ([d respondsToSelector:arg1]) {
            [d performSelector:arg1];
        }
    }
    [dels release];
}

- (void)forwardDelegateMethod:(SEL)arg1 withObject:(id)arg2 {
    NSArray *dels = [self->_delegates copy];
    for (id d in dels) {
        if ([d respondsToSelector:arg1]) {
            [d performSelector:arg1 withObject:arg2];
        }
    }
    [dels release];
}

- (void)profileMediaAdded:(id)arg1 {
    [self forwardDelegateMethod:_cmd withObject:arg1];
}

- (void)profileMediaRemoved:(id)arg1 {
    [self forwardDelegateMethod:_cmd withObject:arg1];
}

- (void)profileChanged {
    [self forwardDelegateMethod:_cmd];
}

- (void)sourceChanged {
    [self forwardDelegateMethod:_cmd];
}

- (void)bottleCreateChanged {
    [self forwardDelegateMethod:_cmd];
}

- (void)bottleNewnameChanged {
    [self forwardDelegateMethod:_cmd];
}

- (void)bottleTemplateChanged {
    [self forwardDelegateMethod:_cmd];
}

- (void)bottleNameChanged {
    [self forwardDelegateMethod:_cmd];
}

- (void)categorizedBottle:(id)arg1 {
    [self forwardDelegateMethod:_cmd withObject:arg1];
}

- (void)categorizedAllBottles {
    [self forwardDelegateMethod:_cmd];
}

- (void)analyzedBottle:(id)arg1 {
    [self forwardDelegateMethod:_cmd withObject:arg1];
}

#pragma mark - Properties Accessors

- (id)installTask {
    return self->_installTask;
}

- (id)delegates {
    return self->_delegates;
}

- (void)setDelegates:(id)arg1 {
    if (self->_delegates != arg1) {
        [self->_delegates release];
        self->_delegates = [arg1 retain];
    }
}

- (id)environment {
    return self->_environment;
}

- (void)setEnvironment:(id)arg1 {
    if (self->_environment != arg1) {
        [self->_environment release];
        self->_environment = [arg1 copy];
    }
}

- (id)logChannels {
    return self->_logChannels;
}

- (void)setLogChannels:(id)arg1 {
    if (self->_logChannels != arg1) {
        [self->_logChannels release];
        self->_logChannels = [arg1 copy];
    }
}

- (id)logEnvironment {
    return self->_logEnvironment;
}

- (void)setLogEnvironment:(id)arg1 {
    if (self->_logEnvironment != arg1) {
        [self->_logEnvironment release];
        self->_logEnvironment = [arg1 copy];
    }
}

- (id)logFileURL {
    return self->_logFileURL;
}

- (void)setLogFileURL:(id)arg1 {
    if (self->_logFileURL != arg1) {
        [self->_logFileURL release];
        self->_logFileURL = [arg1 copy];
    }
}

- (id)selectedPackage {
    return self->_selectedPackage;
}

- (id)bottleCollection {
    if (self->_bottleCollection) {
        return self->_bottleCollection;
    }
    return [[CXSetupLib bottleCollectionClass] sharedCollection];
}

#pragma mark - Direct Dynamic Properties

- (NSString *)bottleName {
    return [self->_installTask valueForKey:@"bottlename"];
}

- (void)setBottleName:(NSString *)name {
    [self->_installTask setValue:name forKey:@"bottlename"];
}

- (NSDictionary *)bottles {
    return [self->_installTask valueForKey:@"bottles"] ?: [NSDictionary dictionary];
}

- (NSDictionary *)templates {
    return [self->_installTask valueForKey:@"templates"] ?: [NSDictionary dictionary];
}

- (id)targetBottle {
    return [self->_installTask valueForKey:@"target_bottle"];
}

- (NSString *)nameForNewBottle {
    return [self->_installTask valueForKey:@"newBottleName"];
}

- (NSString *)downloadURL {
    return [self->_installTask valueForKey:@"download_url"];
}

- (NSString *)steamID {
    return [self->_installTask valueForKey:@"steamid"];
}

- (BOOL)installWithSteam {
    return [[self->_installTask valueForKey:@"installWithSteam"] boolValue];
}

- (NSString *)installerDownloadSource {
    return [self->_installTask valueForKey:@"installerDownloadSource"];
}

- (NSString *)installerSource {
    return [self->_installTask valueForKey:@"installerSource"];
}

- (BOOL)isVirtual {
    return [[self->_installTask valueForKey:@"isVirtual"] boolValue];
}

- (NSDictionary *)dependencyOverrides {
    return [self->_installTask valueForKey:@"dependency_overrides"];
}

- (NSString *)installationNotes {
    return [self->_installTask valueForKey:@"installationNotes"];
}

- (NSString *)postInstallURL {
    return [self->_installTask valueForKey:@"post_install_url"];
}

- (id)profile {
    return [self->_installTask valueForKey:@"profile"];
}

- (BOOL)is64bit {
    return [[self->_installTask valueForKey:@"is64bit"] boolValue];
}

@end
