// BottleModel.m — CrossThrough
//
// Reconstrução nativa das quatro classes do módulo de bottles, substituindo
// bottlewrapper/bottlecollection/bottlemanagement/bottlequery (.pyc + PyObjC).
// Superfície conforme sharedsupport/python/BRIDGE.md e os esboços em
// sharedsupport/python/outline/. Comandos e chaves de config vêm dos esboços.
// Ver NATIVE_BOTTLES.md para o mapeamento item a item.

#import "NativeBottles.h"

// Chaves de cxbottle.conf (dos esboços / BRIDGE).
static NSString *const kSecBottle = @"Bottle";
static NSString *const kSecEnv    = @"EnvironmentVariables";

// Estados (bottlewrapper STATUS_*).
static NSString *const ST_INIT = @"Scanning…";
static NSString *const ST_READY = @"Ready";
static NSString *const ST_UPGRADE = @"Needs upgrade";
static NSString *const ST_RENAMING = @"Renaming…";
static NSString *const ST_DELETING = @"Deleting…";
static NSString *const ST_DEFAULTING = @"Making default…";
static NSString *const ST_DOWNING = @"Shutting down…";
static NSString *const ST_FORCE_DOWNING = @"Forcing shutdown…";
static NSString *const ST_ARCHIVING = @"Archiving…";
static NSString *const ST_INSTALLING = @"Installing…";
static NSString *const ST_REPAIRING = @"Repairing…";
static NSString *const ST_SUSPENDED = @"Suspended";
static NSString *const ST_DISABLED = @"Disabled";

static NSString *const GB_AUTO = @"Graphics: Auto";
static NSString *const GB_D3DMETAL = @"Graphics: D3DMetal";
static NSString *const GB_DXMT = @"Graphics: DXMT";
static NSString *const GB_DXVK = @"Graphics: DXVK";
static NSString *const GB_WINE = @"Graphics: Wine";

#pragma mark - CTBottleQuery

@implementation CTBottleQuery

+ (NSString *)sanitize:(NSString *)name {
    // CXUtils.sanitize_bottlename (aproximação): sem separadores de caminho,
    // sem ':', sem espaços nas pontas.
    NSString *s = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    s = [s stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    s = [s stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    return s;
}

+ (id)uniqueBottleName:(id)inBasename {
    NSString *base = [self sanitize:inBasename];
    NSArray *existing = [CXBottlePaths bottleNames];
    NSArray *reserved = [CXBottlePaths reservedNames];
    NSMutableSet *taken = [NSMutableSet set];
    for (NSString *n in existing) [taken addObject:[n lowercaseString]];
    for (NSString *n in reserved) [taken addObject:[n lowercaseString]];

    if (![taken containsObject:[base lowercaseString]]) return base;
    for (int i = 2; i < 1000; i++) {
        NSString *cand = [NSString stringWithFormat:@"%@-%d", base, i];
        if (![taken containsObject:[cand lowercaseString]]) return cand;
    }
    return base;
}

+ (id)isValidNewBottleName:(id)name {
    NSString *s = [self sanitize:name];
    if ([s length] == 0) return @NO;
    NSString *lower = [s lowercaseString];
    if ([[CXBottlePaths reservedNames] containsObject:lower]) return @NO;
    for (NSString *n in [CXBottlePaths bottleNames])
        if ([[n lowercaseString] isEqualToString:lower]) return @NO;
    return @YES;
}

@end

#pragma mark - CTBottleManagement

// Tabela _TEMPLATE_PROPERTIES (ordem, nome de exibição) do esboço.
static NSArray *TemplateTable(void) {
    return @[ @[@"win98",       @0,  @"Windows 98 (deprecated)"],
              @[@"win2000",     @1,  @"Windows 2000 (deprecated)"],
              @[@"winxp",       @2,  @"Windows XP 32-bit (deprecated)"],
              @[@"winxp_64",    @3,  @"Windows XP"],
              @[@"winvista",    @4,  @"Windows Vista 32-bit (deprecated)"],
              @[@"winvista_64", @5,  @"Windows Vista"],
              @[@"win7",        @6,  @"Windows 7 32-bit (deprecated)"],
              @[@"win7_64",     @7,  @"Windows 7"],
              @[@"win8",        @8,  @"Windows 8 32-bit (deprecated)"],
              @[@"win8_64",     @9,  @"Windows 8"],
              @[@"win10",       @10, @"Windows 10 32-bit (deprecated)"],
              @[@"win10_64",    @11, @"Windows 10"],
              @[@"win11_64",    @12, @"Windows 11"] ];
}

@implementation CTBottleManagement

+ (NSString *)cxbottle { return [CXBottleTool toolPath:@"cxbottle"]; }
+ (NSString *)wine { return [CXBottleTool toolPath:@"wine"]; }

+ (id)pairFrom:(CXToolResult *)r { return @[@(r.success), r.output ?: @""]; }

+ (id)templates {
    // Lista CX_ROOT/share/crossover/bottle_templates; filtra 32-bit a menos
    // que Enable32BitBottles esteja ligado. Sem o dir, devolve os 64-bit da tabela.
    NSString *dir = [[[[CXBottlePaths crossOverRoot]
                       stringByAppendingPathComponent:@"share"]
                      stringByAppendingPathComponent:@"crossover"]
                     stringByAppendingPathComponent:@"bottle_templates"];
    NSArray *entries = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:NULL];
    NSMutableArray *out = [NSMutableArray array];
    if (entries) {
        for (NSArray *t in TemplateTable()) {
            NSString *key = [t objectAtIndex:0];
            if ([entries containsObject:key] && [key hasSuffix:@"_64"]) [out addObject:key];
        }
        if ([out count]) return out;
    }
    // Fallback: os templates de 64 bits conhecidos.
    for (NSArray *t in TemplateTable())
        if ([[t objectAtIndex:0] hasSuffix:@"_64"]) [out addObject:[t objectAtIndex:0]];
    return out;
}

+ (id)displayNameForTemplate:(id)template {
    for (NSArray *t in TemplateTable())
        if ([[t objectAtIndex:0] isEqualToString:template]) return [t objectAtIndex:2];
    return @"Unknown";
}

+ (id)createBottle:(id)name fromTemplate:(id)tmpl {
    NSString *t = [tmpl length] ? tmpl : @"win10_64";
    CXToolResult *r = [CXBottleTool run:@[[self cxbottle], @"--bottle", name,
                                          @"--create", @"--template", t, @"--install"]];
    return [self pairFrom:r];
}

+ (id)duplicateBottle:(id)name fromBottle:(id)src {
    CXToolResult *r = [CXBottleTool run:@[[self cxbottle], @"--bottle", name,
                                          @"--copy", src, @"--install"]];
    return [self pairFrom:r];
}

+ (NSDictionary *)utf8Env {
    return @{ @"LANG": @"en_US.UTF-8", @"LC_CTYPE": @"UTF-8", @"LC_ALL": @"en_US.UTF-8" };
}

+ (id)restoreBottle:(id)name fromArchive:(id)archive {
    CXToolResult *r = [CXBottleTool run:@[[self cxbottle], @"--bottle", name,
                                          @"--restore", archive, @"--install"]
                                     env:[self utf8Env]];
    return [self pairFrom:r];
}

+ (id)archiveBottle:(id)name toPath:(id)path {
    CXToolResult *r = [CXBottleTool run:@[[self cxbottle], @"--bottle", name, @"--tar", path]
                                     env:[self utf8Env]];
    return [self pairFrom:r];
}

// ---- funções de módulo ----

+ (BOOL)quitBottle:(NSString *)name {
    CXToolResult *r = [CXBottleTool run:@[[self wine], @"--bottle", name, @"--no-update",
                                          @"--wl-app", @"wineboot.exe", @"--",
                                          @"--end-session", @"--shutdown", @"--force", @"--kill"]];
    return r.success;
}

+ (BOOL)killBottle:(NSString *)name {
    CXToolResult *r = [CXBottleTool run:@[[self wine], @"--bottle", name, @"--no-update",
                                          @"--ux-app", @"wineserver", @"-k"]];
    return r.success;
}

+ (BOOL)isRunning:(NSString *)name {
    // wineserver -k0: devolve 0 se há servidor a correr para a bottle.
    int st = [CXBottleTool system:@[[self wine], @"--bottle", name, @"--no-update",
                                    @"--ux-app", @"wineserver", @"-k0"]];
    return st == 0;
}

+ (BOOL)deleteBottle:(NSString *)name managed:(BOOL)managed {
    NSArray *argv;
    if (managed) {
        // cxsu --ignore-home cxbottle --bottle N --removeall --delete --force --scope private
        argv = @[[CXBottleTool toolPath:@"cxsu"], @"--ignore-home", [self cxbottle],
                 @"--bottle", name, @"--removeall", @"--delete", @"--force", @"--scope", @"private"];
    } else {
        argv = @[[self cxbottle], @"--bottle", name, @"--removeall", @"--delete", @"--force"];
    }
    CXToolResult *r = [CXBottleTool run:argv];
    if (!r.success) NSLog(@"[bottles] Failed to delete %@. %@", name, r.output);
    return r.success;
}

+ (BOOL)renameBottle:(NSString *)name to:(NSString *)newName {
    // Espelha rename_bottle: falha se o destino já existe; move o prefixo e
    // volta a registar a nova bottle (parcialmente inferido — ver NATIVE_BOTTLES.md).
    if ([CXBottlePaths prefixForBottle:newName]) {
        NSLog(@"[bottles] Cannot rename; that bottle already exists.");
        return NO;
    }
    NSString *oldPrefix = [CXBottlePaths prefixForBottle:name];
    if (!oldPrefix) return NO;
    BOOL wasDefault = [[CXBottlePaths defaultBottleName] isEqualToString:name];
    NSString *newPrefix = [[oldPrefix stringByDeletingLastPathComponent]
                           stringByAppendingPathComponent:newName];
    // Desregistar menus/associações da bottle antiga.
    [CXBottleTool run:@[[self cxbottle], @"--bottle", name, @"--removeall"]];
    if (![[NSFileManager defaultManager] moveItemAtPath:oldPrefix toPath:newPrefix error:NULL]) {
        NSLog(@"[bottles] Failed to move bottle dir for rename.");
        return NO;
    }
    NSArray *argv = wasDefault
        ? @[[self cxbottle], @"--bottle", newName, @"--new-uuid", @"--install", @"--default"]
        : @[[self cxbottle], @"--bottle", newName, @"--new-uuid", @"--install"];
    CXToolResult *r = [CXBottleTool run:argv];
    return r.success;
}

+ (BOOL)setDefaultBottle:(NSString *)name state:(BOOL)state {
    CXToolResult *r = [CXBottleTool run:@[[self cxbottle],
                                          state ? @"--default" : @"--undefault",
                                          @"--bottle", name]];
    return r.success;
}

+ (BOOL)getUpToDate:(NSString *)name scope:(NSString *)scope {
    CXToolResult *r = [CXBottleTool run:@[[self cxbottle], @"--bottle", name,
                                          @"--status", @"--scope", scope ?: @"private"]];
    return r.success && [r.output rangeOfString:@"Status=uptodate"].location != NSNotFound;
}

@end

#pragma mark - CTBottleCollection

static CTBottleCollection *gSharedCollection = nil;

@implementation CTBottleCollection {
    NSMutableArray *_bottleList;
    NSMutableArray *_changeDelegates;
}

+ (id)sharedCollection {
    @synchronized (self) {
        if (!gSharedCollection) {
            gSharedCollection = [[CTBottleCollection alloc] init];
            [gSharedCollection refresh];
        }
    }
    return gSharedCollection;
}

- (instancetype)init {
    if ((self = [super init])) {
        _bottleList = [[NSMutableArray alloc] init];
        _changeDelegates = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)dealloc { [_bottleList release]; [_changeDelegates release]; [super dealloc]; }

- (id)bottleList { return _bottleList; }

- (id)bottleWithName:(id)name {
    for (CTBottleWrapper *b in _bottleList)
        if ([[b name] isEqualToString:name]) return b;
    return nil;
}

- (void)refresh {
    NSArray *names = [CXBottlePaths bottleNames];
    NSMutableSet *wanted = [NSMutableSet setWithArray:names];

    // Remover as que já não existem.
    NSMutableArray *toRemove = [NSMutableArray array];
    for (CTBottleWrapper *b in _bottleList)
        if (![wanted containsObject:[b name]]) [toRemove addObject:b];
    for (CTBottleWrapper *b in toRemove) {
        [b removeObservers];
        [_bottleList removeObject:b];
    }
    // Adicionar as novas.
    for (NSString *name in names) {
        if (![self bottleWithName:name]) {
            CTBottleWrapper *b = [[[CTBottleWrapper alloc] initWithName:name] autorelease];
            [b addMenuObservers];
            [_bottleList addObject:b];
        }
    }
    [self refreshDefaultBottle];
    [self notifyChanged];
}

- (void)reset {
    for (CTBottleWrapper *b in [[_bottleList copy] autorelease]) [b removeObservers];
    [_bottleList removeAllObjects];
    [self refresh];
}

- (void)refreshDefaultBottle {
    NSString *def = [CXBottlePaths defaultBottleName];
    for (CTBottleWrapper *b in _bottleList)
        [b setValue:@([[b name] isEqualToString:def]) forKey:@"isDefaultFlag"];
}

- (void)addChangeDelegate:(id)d { if (d && ![_changeDelegates containsObject:d]) [_changeDelegates addObject:d]; }
- (void)removeChangeDelegate:(id)d { [_changeDelegates removeObject:d]; }

- (void)notifyChanged {
    for (id d in [[_changeDelegates copy] autorelease])
        if ([d respondsToSelector:@selector(bottleCollectionChanged)])
            [d performSelector:@selector(bottleCollectionChanged)];
}

- (BOOL)has32BitBottle {
    for (CTBottleWrapper *b in _bottleList)
        if ([b respondsToSelector:@selector(is32Bit)] && [(id)b is32Bit]) return YES;
    return NO;
}

@end

#pragma mark - CTBottleWrapper

@implementation CTBottleWrapper {
    NSString *_name;
    NSString *_winePrefix;
    NSString *_systemDrive;
    NSString *_arch;
    NSString *_currentDescription;
    NSString *_graphicsState;
    NSMutableArray *_statusOverrides;
    NSString *_status;
    BOOL _isDefaultFlag;
    BOOL _upToDate;
    BOOL _installedPackagesReady;
    NSDictionary *_installedPackages;
}

- (instancetype)initWithName:(NSString *)name {
    if ((self = [super init])) {
        _name = [name copy];
        _statusOverrides = [[NSMutableArray alloc] init];
        _status = ST_INIT;
        _upToDate = YES;
        [self initialize];
    }
    return self;
}
- (void)dealloc {
    [_name release]; [_winePrefix release]; [_systemDrive release]; [_arch release];
    [_currentDescription release]; [_graphicsState release]; [_statusOverrides release];
    [_installedPackages release];
    [super dealloc];
}

- (void)initialize {
    [_winePrefix release];
    _winePrefix = [[CXBottlePaths prefixForBottle:_name] copy];
    [_systemDrive release];
    _systemDrive = [[_winePrefix stringByAppendingPathComponent:@"drive_c"] copy];
    [self loadBasicInfo];
    _status = ST_READY;
}

- (CXBottleConfig *)config {
    return [CXBottleConfig configWithPath:[CXBottlePaths configPathForBottle:_name]];
}

- (NSString *)getConfigSection:(NSString *)s key:(NSString *)k default:(NSString *)d {
    return [[self config] stringForSection:s key:k default:d];
}
- (void)setConfigSection:(NSString *)s key:(NSString *)k value:(NSString *)v {
    CXBottleConfig *c = [self config];
    [c setString:v section:s key:k];
    if (![c save]) NSLog(@"[bottles] Unable to set a config value in bottle %@", _name);
}

#pragma mark basic info / identity

- (void)loadBasicInfo {
    CXBottleConfig *c = [self config];
    [_arch release];
    _arch = [[c stringForSection:kSecBottle key:@"WineArch" default:@"win64"] copy];
    [_currentDescription release];
    _currentDescription = [[c stringForSection:kSecBottle key:@"Description" default:@""] copy];
    [self loadGraphicsBackendInfo];
}

- (NSString *)name { return _name; }
- (NSString *)bottleName { return _name; }
- (NSString *)changeableName { return _name; }
- (NSString *)winePrefix { return _winePrefix; }
- (NSString *)systemDrive { return _systemDrive; }

- (id)appid {
    NSString *v = [self getConfigSection:kSecEnv key:@"CX_BOTTLE_CREATOR_APPID" default:@""];
    if ([v hasPrefix:@"com.codeweavers.c4."]) return [v substringFromIndex:[@"com.codeweavers.c4." length]];
    return v;
}

- (id)currentDescription { return _currentDescription; }
- (void)setCurrentDescription:(id)desc {
    [_currentDescription release]; _currentDescription = [desc copy];
}
- (void)writeDescription {
    [self setConfigSection:kSecBottle key:@"Description" value:_currentDescription ?: @""];
}

- (NSString *)displayName {
    return _isDefaultFlag ? [NSString stringWithFormat:@"%@ (default)", _name] : _name;
}

- (void)setIsDefaultFlag:(NSNumber *)flag { _isDefaultFlag = [flag boolValue]; }
- (BOOL)isDefault { return _isDefaultFlag; }
- (BOOL)isIsDefault { return _isDefaultFlag; }

- (BOOL)isManaged {
    return [[self getConfigSection:kSecBottle key:@"Updater" default:@""] length] > 0;
}
- (BOOL)isIsManaged { return [self isManaged]; }

- (BOOL)is32Bit { return [_arch isEqualToString:@"win32"]; }

#pragma mark graphics / vulkan / dlss / msync / preview

- (void)loadGraphicsBackendInfo {
    NSString *v = [self getConfigSection:kSecEnv key:@"CX_GRAPHICS_BACKEND" default:@""];
    [_graphicsState release];
    if      ([v isEqualToString:@"d3dmetal"]) _graphicsState = [GB_D3DMETAL copy];
    else if ([v isEqualToString:@"dxmt"])     _graphicsState = [GB_DXMT copy];
    else if ([v isEqualToString:@"dxvk"])     _graphicsState = [GB_DXVK copy];
    else if ([v isEqualToString:@"wined3d"])  _graphicsState = [GB_WINE copy];
    else                                       _graphicsState = [GB_AUTO copy];
}
- (void)setGraphics:(NSString *)value state:(NSString *)state {
    [self setConfigSection:kSecEnv key:@"CX_GRAPHICS_BACKEND" value:value];
    [_graphicsState release]; _graphicsState = [state copy];
    [self bottleChanged];
}
- (void)setGraphicsBackendAuto     { [self setGraphics:@"" state:GB_AUTO]; }
- (void)setGraphicsBackendD3DMetal { [self setGraphics:@"d3dmetal" state:GB_D3DMETAL]; }
- (void)setGraphicsBackendDXMT     { [self setGraphics:@"dxmt" state:GB_DXMT]; }
- (void)setGraphicsBackendDXVK     { [self setGraphics:@"dxvk" state:GB_DXVK]; }
- (void)setGraphicsBackendWine     { [self setGraphics:@"wined3d" state:GB_WINE]; }
- (BOOL)isIsD3DMetalEnabled { return [_graphicsState isEqualToString:GB_D3DMETAL]; }
- (BOOL)isIsDXMTEnabled     { return [_graphicsState isEqualToString:GB_DXMT]; }
- (BOOL)isIsDXVKEnabled     { return [_graphicsState isEqualToString:GB_DXVK]; }
- (BOOL)isIsD3DMetalAvailable { return YES; }   // depende de macOS/Apple Silicon; (inferência)
- (BOOL)isIsDXMTAvailable     { return YES; }

- (void)setVulkanBackendMoltenVK { [self setConfigSection:kSecEnv key:@"CX_LIBVULKAN" value:@"libMoltenVK.dylib"]; [self bottleChanged]; }
- (void)setVulkanBackendMTLVK    { [self setConfigSection:kSecEnv key:@"CX_LIBVULKAN" value:@"libvulkan.dylib"]; [self bottleChanged]; }
- (BOOL)isIsMoltenVKEnabled { return [[self getConfigSection:kSecEnv key:@"CX_LIBVULKAN" default:@""] isEqualToString:@"libMoltenVK.dylib"]; }
- (BOOL)isIsMTLVKEnabled    { return [[self getConfigSection:kSecEnv key:@"CX_LIBVULKAN" default:@""] isEqualToString:@"libvulkan.dylib"]; }
- (BOOL)isIsMTLVKAvailable  { return YES; }

- (void)enableDLSS {
    [self setConfigSection:kSecEnv key:@"D3DM_ENABLE_METALFX" value:@"1"];
    [self setConfigSection:kSecEnv key:@"DXMT_ENABLE_NVEXT" value:@"1"];
    [self bottleChanged];
}
- (void)disableDLSS {
    [self setConfigSection:kSecEnv key:@"D3DM_ENABLE_METALFX" value:@"0"];
    [self setConfigSection:kSecEnv key:@"DXMT_ENABLE_NVEXT" value:@"0"];
    [self bottleChanged];
}
- (BOOL)isIsDLSSEnabled {
    return [[self getConfigSection:kSecEnv key:@"D3DM_ENABLE_METALFX" default:@"0"] isEqualToString:@"1"];
}
- (BOOL)isIsDLSSAvailable { return [self isIsD3DMetalEnabled] || [self isIsDXMTEnabled]; }

- (void)enableMSync  { [self setConfigSection:kSecEnv key:@"WINEMSYNC" value:@"1"]; [self bottleChanged]; }
- (void)disableMSync { [self setConfigSection:kSecEnv key:@"WINEMSYNC" value:@"0"]; [self bottleChanged]; }
- (BOOL)isIsMSyncEnabled { return [[self getConfigSection:kSecEnv key:@"WINEMSYNC" default:@"0"] isEqualToString:@"1"]; }

- (void)enablePreview  { [self setConfigSection:kSecBottle key:@"Preview" value:@"1"]; [self removeAllStatusOverrides:ST_DISABLED]; }
- (void)disablePreview { [self setConfigSection:kSecBottle key:@"Preview" value:@"0"]; [self addStatusOverride:ST_DISABLED]; }
- (BOOL)isIsPreviewEnabled { return [[self getConfigSection:kSecBottle key:@"Preview" default:@"1"] isEqualToString:@"1"]; }

#pragma mark high-resolution / control panel / packages (dependem de registo via cxmanip)

- (void)loadHighResolutionInfo { /* via cxmanip getregkey; ver NATIVE_BOTTLES.md */ }
- (void)enableHighResolution { /* SetHighResolutionEnabledStateOperation */ }
- (void)disableHighResolution { }
- (BOOL)isIsHighResolutionEnabled { return NO; }
- (BOOL)isIsHighResolutionEnabledReady { return YES; }

- (void)loadControlPanelInfo { /* wine --no-gui --wl-app cxcplinfo.exe --all */ }
- (BOOL)isControlPanelReady { return YES; }

- (void)loadApplicationInfo { _installedPackagesReady = YES; }
- (BOOL)isIsInstalledPackagesReady { return _installedPackagesReady; }
- (id)installedPackages { return _installedPackages ?: @{}; }

- (id)getMissingDependenciesProfile { return nil; }
- (id)launchers { return @[]; }
- (id)controlPanels { return @[]; }
- (id)getCategory { return nil; }

#pragma mark status model

- (void)addStatusOverride:(id)status {
    if (status && ![_statusOverrides containsObject:status]) [_statusOverrides addObject:status];
    [self bottleChanged];
}
- (void)removeStatusOverride:(id)status {
    [_statusOverrides removeObject:status];
    [self bottleChanged];
}
- (void)removeAllStatusOverrides:(id)status {
    while ([_statusOverrides containsObject:status]) [_statusOverrides removeObject:status];
    [self bottleChanged];
}
- (NSString *)status { return [_statusOverrides lastObject] ?: _status; }
- (BOOL)hasOverride:(NSString *)s { return [_statusOverrides containsObject:s]; }

- (BOOL)isIsBusy {
    return [self hasOverride:ST_RENAMING] || [self hasOverride:ST_DELETING] ||
           [self hasOverride:ST_REPAIRING] || [self hasOverride:ST_ARCHIVING] ||
           [self hasOverride:ST_INSTALLING] || [self hasOverride:ST_DOWNING] ||
           [self hasOverride:ST_FORCE_DOWNING];
}
- (BOOL)isIsDisabled { return [self hasOverride:ST_DISABLED]; }
- (BOOL)isIsUsable {
    NSString *st = [self status];
    return [st isEqualToString:ST_INIT] || [st isEqualToString:ST_UPGRADE] ||
           [st isEqualToString:ST_READY] || [st isEqualToString:ST_DEFAULTING];
}
- (BOOL)isIsActive { return ![self hasOverride:ST_DISABLED] && _upToDate; }
- (BOOL)isIsUpToDate { return _upToDate; }
- (BOOL)isIsDeleted { BOOL d=NO; return !([[NSFileManager defaultManager] fileExistsAtPath:_winePrefix isDirectory:&d] && d); }
- (BOOL)isCanRunCommands { return _upToDate && ![self isManaged] && ![self isIsBusy] && ![self isIsDisabled]; }
- (BOOL)isCanInstall { return ![self isManaged] && [self isIsUsable]; }
- (BOOL)isCanRename { return ![self isIsBusy] && ![self isManaged]; }
- (BOOL)isCanForceQuit { return [self hasOverride:ST_DOWNING] && ![self hasOverride:ST_FORCE_DOWNING]; }

- (id)fileIsInBottle:(id)filename {
    NSString *real = [[filename stringByResolvingSymlinksInPath] stringByStandardizingPath];
    NSString *root = [[_systemDrive stringByResolvingSymlinksInPath] stringByStandardizingPath];
    return @([real hasPrefix:root]);
}

#pragma mark rating nag

- (void)disableRatingNag { [self setConfigSection:kSecBottle key:@"AskForRatings" value:@"0"]; [self bottleChanged]; }
- (BOOL)isShouldNagForRatings { return [[self getConfigSection:kSecBottle key:@"AskForRatings" default:@"1"] isEqualToString:@"1"]; }

#pragma mark observers / lifecycle

- (void)addMenuObservers { }        // cxfsnotifier do .version/menu; (não reconstruído)
- (void)removeMenuObservers { }
- (void)removeObservers { }
- (void)reloadInfo { [self loadBasicInfo]; [self bottleChanged]; }
- (void)refreshUpToDate {
    if ([self isManaged]) _upToDate = [CTBottleManagement getUpToDate:_name scope:@"managed"];
    else _upToDate = YES;
    [self bottleChanged];
}
- (void)suspend { [self addStatusOverride:ST_SUSPENDED]; }
- (void)resume  { [self removeStatusOverride:ST_SUSPENDED]; }

// KVO: notifica as chaves derivadas ligadas por Cocoa Bindings.
- (void)bottleChanged {
    static NSArray *keys = nil;
    if (!keys) keys = [@[@"status", @"displayName", @"isDefault", @"isActive", @"isBusy",
                         @"isUsable", @"canRunCommands", @"canInstall", @"canForceQuit",
                         @"isMSyncEnabled", @"isDLSSEnabled", @"isPreviewEnabled",
                         @"isD3DMetalEnabled", @"isDXMTEnabled", @"isDXVKEnabled",
                         @"isMoltenVKEnabled", @"isMTLVKEnabled"] retain];
    for (NSString *k in keys) {
        [self willChangeValueForKey:k];
        [self didChangeValueForKey:k];
    }
}

// Operações assíncronas: executam em background e chamam o callback na main.
- (void)runOp:(BOOL(^)(void))body override:(NSString *)override callback:(id)callback {
    [self addStatusOverride:override];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        BOOL ok = body();
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeStatusOverride:override];
            if ([callback isKindOfClass:NSClassFromString(@"NSBlock")]) ((void(^)(BOOL))callback)(ok);
        });
    });
}

- (void)quit:(id)callback {
    [self runOp:^BOOL{ return [CTBottleManagement quitBottle:self->_name]; }
       override:ST_DOWNING callback:callback];
}
- (void)forceQuit:(id)callback {
    [self runOp:^BOOL{ return [CTBottleManagement killBottle:self->_name]; }
       override:ST_FORCE_DOWNING callback:callback];
}
- (void)delete:(id)callback {
    [self runOp:^BOOL{ return [CTBottleManagement deleteBottle:self->_name managed:[self isManaged]]; }
       override:ST_DELETING callback:callback];
}
- (void)rename:(id)newName completionHandler:(id)callback {
    NSString *nn = newName;
    [self runOp:^BOOL{ return [CTBottleManagement renameBottle:self->_name to:nn]; }
       override:ST_RENAMING callback:callback];
}
- (void)setIsDefault:(id)state completionHandler:(id)callback {
    BOOL s = [state boolValue];
    [self runOp:^BOOL{ return [CTBottleManagement setDefaultBottle:self->_name state:s]; }
       override:ST_DEFAULTING callback:callback];
}

@end
