// CXBottleSupport.m — CrossThrough
// CXBottleConfig, CXBottlePaths, CXToolResult, CXBottleTool.
// Material de suporte do módulo nativo de bottles. Ver NativeBottles.h e
// NATIVE_BOTTLES.md.

#import "NativeBottles.h"
#import "CXSetupLib.h"

#pragma mark - CXBottleConfig (INI)

@implementation CXBottleConfig {
    NSString *_path;
    // Ordem preservada: lista de secções; cada secção é {@"name", NSMutableArray<NSArray(key,value)>}.
    NSMutableArray<NSMutableDictionary *> *_sections;
}

+ (instancetype)configWithPath:(NSString *)path {
    CXBottleConfig *c = [[[self alloc] init] autorelease];
    if (c) { c->_path = [path copy]; [c->_sections release]; c->_sections = [[NSMutableArray alloc] init]; [c load]; }
    return c;
}

- (instancetype)init { if ((self = [super init])) { _sections = [[NSMutableArray alloc] init]; } return self; }
- (void)dealloc { [_path release]; [_sections release]; [super dealloc]; }

- (NSMutableDictionary *)sectionNamed:(NSString *)name create:(BOOL)create {
    for (NSMutableDictionary *s in _sections)
        if ([[s objectForKey:@"name"] isEqualToString:name]) return s;
    if (!create) return nil;
    NSMutableDictionary *s = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                              name, @"name", [NSMutableArray array], @"keys", nil];
    [_sections addObject:s];
    return s;
}

- (void)load {
    [_sections removeAllObjects];
    NSString *text = [NSString stringWithContentsOfFile:_path encoding:NSUTF8StringEncoding error:NULL];
    if (!text) return;
    NSMutableDictionary *cur = nil;
    for (NSString *raw in [text componentsSeparatedByString:@"\n"]) {
        NSString *line = [raw stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([line length] == 0 || [line hasPrefix:@";"] || [line hasPrefix:@"#"]) continue;
        if ([line hasPrefix:@"["] && [line hasSuffix:@"]"]) {
            NSString *name = [line substringWithRange:NSMakeRange(1, [line length] - 2)];
            cur = [self sectionNamed:name create:YES];
            continue;
        }
        NSRange eq = [line rangeOfString:@"="];
        if (eq.location == NSNotFound) continue;
        if (!cur) cur = [self sectionNamed:@"" create:YES];
        NSString *k = [[line substringToIndex:eq.location] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *v = [[line substringFromIndex:eq.location + 1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [[cur objectForKey:@"keys"] addObject:@[k, v]];
    }
}

- (NSString *)stringForSection:(NSString *)section key:(NSString *)key default:(NSString *)def {
    NSMutableDictionary *s = [self sectionNamed:section create:NO];
    if (!s) return def;
    for (NSArray *kv in [s objectForKey:@"keys"])
        if ([[kv objectAtIndex:0] isEqualToString:key]) return [kv objectAtIndex:1];
    return def;
}

- (BOOL)boolForSection:(NSString *)section key:(NSString *)key default:(BOOL)def {
    NSString *v = [self stringForSection:section key:key default:nil];
    if (!v) return def;
    // Wine/CrossOver tratam "1"/"y"/"t" como verdadeiro.
    unichar c = [v length] ? [[v lowercaseString] characterAtIndex:0] : '0';
    return (c == '1' || c == 'y' || c == 't');
}

- (void)setString:(NSString *)value section:(NSString *)section key:(NSString *)key {
    NSMutableDictionary *s = [self sectionNamed:section create:YES];
    NSMutableArray *keys = [s objectForKey:@"keys"];
    for (NSUInteger i = 0; i < [keys count]; i++)
        if ([[[keys objectAtIndex:i] objectAtIndex:0] isEqualToString:key]) {
            [keys replaceObjectAtIndex:i withObject:@[key, value ?: @""]];
            return;
        }
    [keys addObject:@[key, value ?: @""]];
}

- (void)unsetSection:(NSString *)section key:(NSString *)key {
    NSMutableDictionary *s = [self sectionNamed:section create:NO];
    if (!s) return;
    NSMutableArray *keys = [s objectForKey:@"keys"];
    for (NSUInteger i = 0; i < [keys count]; i++)
        if ([[[keys objectAtIndex:i] objectAtIndex:0] isEqualToString:key]) { [keys removeObjectAtIndex:i]; return; }
}

- (BOOL)save {
    if (!_path) return NO;
    NSMutableString *out = [NSMutableString string];
    for (NSMutableDictionary *s in _sections) {
        NSString *name = [s objectForKey:@"name"];
        NSArray *keys = [s objectForKey:@"keys"];
        if ([keys count] == 0) continue;
        if ([name length]) [out appendFormat:@"[%@]\n", name];
        for (NSArray *kv in keys)
            [out appendFormat:@"%@=%@\n", [kv objectAtIndex:0], [kv objectAtIndex:1]];
        [out appendString:@"\n"];
    }
    // Bloqueio por ficheiro (lock_file/save_and_unlock_file): escrita atómica.
    NSError *err = nil;
    BOOL ok = [out writeToFile:_path atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (!ok) NSLog(@"[bottles] Unable to save config %@: %@", _path, err);
    return ok;
}

@end

#pragma mark - CXBottlePaths

@implementation CXBottlePaths

+ (NSString *)crossOverRoot {
    // CX_ROOT = <bundle>/Contents/SharedSupport/CrossOver (igual a CXApplication).
    NSString *ss = [[NSBundle mainBundle] sharedSupportPath];
    if (ss) return [ss stringByAppendingPathComponent:@"CrossOver"];
    return nil;
}

+ (NSString *)privateBottleDir {
    NSString *dir = [[NSUserDefaults standardUserDefaults] stringForKey:@"BottleDir"];
    if ([dir length]) return dir;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *base = [[paths firstObject] stringByAppendingPathComponent:@"CrossOver"];
    return [base stringByAppendingPathComponent:@"Bottles"];
}

+ (NSArray<NSString *> *)reservedNames {
    return @[@"default", @"icons", @"installers", @"logs", @"tie"];
}

+ (BOOL)isValidWinePrefix:(NSString *)prefix {
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL dir = NO;
    if (![fm fileExistsAtPath:prefix isDirectory:&dir] || !dir) return NO;
    // _validate_wineprefix: exige system.reg e cxbottle.conf.
    if (![fm fileExistsAtPath:[prefix stringByAppendingPathComponent:@"system.reg"]]) return NO;
    if (![fm fileExistsAtPath:[prefix stringByAppendingPathComponent:@"cxbottle.conf"]]) return NO;
    return [fm isReadableFileAtPath:prefix];
}

+ (NSArray<NSString *> *)bottleNames {
    NSMutableArray *out = [NSMutableArray array];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *reserved = [self reservedNames];
    for (NSString *entry in [fm contentsOfDirectoryAtPath:[self privateBottleDir] error:NULL]) {
        if ([reserved containsObject:[entry lowercaseString]]) continue;
        NSString *prefix = [[self privateBottleDir] stringByAppendingPathComponent:entry];
        if ([self isValidWinePrefix:prefix]) [out addObject:entry];
    }
    return out;
}

+ (NSString *)prefixForBottle:(NSString *)name {
    if ([name length] == 0) return nil;
    NSString *prefix = [[self privateBottleDir] stringByAppendingPathComponent:name];
    return [self isValidWinePrefix:prefix] ? prefix : nil;
}

+ (NSString *)configPathForBottle:(NSString *)name {
    NSString *prefix = [self prefixForBottle:name];
    return prefix ? [prefix stringByAppendingPathComponent:@"cxbottle.conf"] : nil;
}

+ (NSString *)defaultBottleName {
    // get_default_bottle: o link "default" dentro do dir de bottles aponta para a bottle.
    NSString *link = [[self privateBottleDir] stringByAppendingPathComponent:@"default"];
    NSString *target = [[NSFileManager defaultManager] destinationOfSymbolicLinkAtPath:link error:NULL];
    if ([target length]) return [target lastPathComponent];
    return nil;
}

@end

#pragma mark - CXToolResult / CXBottleTool

@implementation CXToolResult
- (void)dealloc { [_output release]; [super dealloc]; }
@end

@implementation CXBottleTool

+ (NSString *)toolPath:(NSString *)name {
    return [[[CXBottlePaths crossOverRoot] stringByAppendingPathComponent:@"bin"] stringByAppendingPathComponent:name];
}

+ (CXToolResult *)run:(NSArray<NSString *> *)argv { return [self run:argv env:nil]; }

+ (CXToolResult *)run:(NSArray<NSString *> *)argv env:(NSDictionary *)extraEnv {
    CXToolResult *res = [[[CXToolResult alloc] init] autorelease];
    if ([argv count] == 0) { res.success = NO; res.output = @""; return res; }
    NSTask *task = [[[NSTask alloc] init] autorelease];
    [task setLaunchPath:[argv objectAtIndex:0]];
    [task setArguments:[argv subarrayWithRange:NSMakeRange(1, [argv count] - 1)]];
    if (extraEnv) {
        NSMutableDictionary *env = [[[[NSProcessInfo processInfo] environment] mutableCopy] autorelease];
        [env addEntriesFromDictionary:extraEnv];
        [task setEnvironment:env];
    }
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    [task setStandardError:pipe];
    @try {
        [task launch];
        NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
        [task waitUntilExit];
        res.output = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease] ?: @"";
        res.success = ([task terminationStatus] == 0);
    } @catch (NSException *e) {
        res.success = NO;
        res.output = [e reason] ?: @"launch failed";
    }
    return res;
}

+ (int)system:(NSArray<NSString *> *)argv {
    if ([argv count] == 0) return -1;
    NSTask *task = [[[NSTask alloc] init] autorelease];
    [task setLaunchPath:[argv objectAtIndex:0]];
    [task setArguments:[argv subarrayWithRange:NSMakeRange(1, [argv count] - 1)]];
    @try { [task launch]; [task waitUntilExit]; return [task terminationStatus]; }
    @catch (NSException *e) { return -1; }
}

@end
