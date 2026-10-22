/*
 * BottleHelper.m — reconstrução compilável do "Bottle Helper" do CrossOver 26.3.
 *
 * Alvo: Contents/Resources/Bottle Helper.cpbz2  (bzip2 → cpio → .app)
 *   Contents/MacOS/Bottle Helper — Mach-O universal (x86_64 + arm64)
 *   Slice analisada: arm64 (__text 10.256 bytes)
 *
 * Decompilação: Ghidra 12.1.4 headless via REA (rea decompile --provider ghidra).
 * O comportamento abaixo foi lido do pseudocódigo, não inferido. Cada método traz
 * o nome original e o endereço na slice arm64.
 *
 * O que o helper faz: é um app .app mínimo, gerado por bottle, que o Finder/Dock
 * tratam como aplicativo nativo. Ao ser aberto (clique, documento ou URL), ele
 * relança o CrossOver passando a si mesmo (ou os arquivos/URL recebidos) como
 * documento, junto com o nome e a tag da bottle (lidos do próprio Info.plist),
 * e então se encerra sozinho após 2 s.
 *
 * Códigos de 4 caracteres (AppleEvents) observados:
 *   'GURL' 0x4755524c  classe e ID do evento de URL
 *   '----' 0x2d2d2d2d  keyDirectObject (a URL)
 *   'BtNm' 0x42744e6d  nome da bottle   (CXHelperAppBottleName)
 *   'BtTg' 0x42745467  tag da bottle    (CXHelperAppBottleTag, sem o último char)
 * Opções de launch 0x10100 = kLSLaunchAsync | kLSLaunchDontAddToRecents.
 *
 * O "Menu Helper" (Menu Helper.cpbz2, x86_64) é o mesmo padrão, por programa em
 * vez de por bottle; a reconstrução dele segue a mesma forma.
 */

#import <Cocoa/Cocoa.h>
#import <CoreServices/CoreServices.h>

/* Fallback declarado no CrossOver (NSWorkspace+CrossOverAdditions.m):
 * o seletor base que CX_absolutePath… chama quando não acha candidato. */
@interface NSWorkspace (CrossOverAdditionsBase)
- (NSString *)absolutePathForAppBundleWithIdentifier:(NSString *)bundleID;
@end

#pragma mark - Categoria de launch (NSWorkspace+CrossOverAdditions)

@interface NSWorkspace (CrossOverAdditions)
- (NSString *)CX_findRunningAppBundleWithIdentifier:(NSString *)bundleID;
- (NSString *)CX_absolutePathForAppBundleWithIdentifier:(NSString *)bundleID
                                   orIdentifyingURLScheme:(NSString *)scheme;
- (BOOL)CX_openURLs:(NSArray *)urls
    withAppBundleIdentifier:(NSString *)bundleID
     orIdentifyingURLScheme:(NSString *)scheme
                    options:(NSWorkspaceLaunchOptions)options
 additionalEventParamDescriptor:(NSAppleEventDescriptor *)param;
- (BOOL)CX_launchAppWithBundleIdentifier:(NSString *)bundleID
                  orIdentifyingURLScheme:(NSString *)scheme
                                 options:(NSWorkspaceLaunchOptions)options
          additionalEventParamDescriptor:(NSAppleEventDescriptor *)param;
@end

@implementation NSWorkspace (CrossOverAdditions)

/* -[NSWorkspace(CrossOverAdditions) CX_findRunningAppBundleWithIdentifier:]  @0x10000397c
 * Devolve o caminho do app em execução com esse bundle id, ou nil. */
- (NSString *)CX_findRunningAppBundleWithIdentifier:(NSString *)bundleID {
    NSArray<NSRunningApplication *> *apps =
        [NSRunningApplication runningApplicationsWithBundleIdentifier:bundleID];
    if ([apps count] == 0) {
        return nil;
    }
    return [[[apps objectAtIndex:0] bundleURL] path];
}

/* -[… CX_absolutePathForAppBundleWithIdentifier:orIdentifyingURLScheme:]  @0x100003a18
 * 1) assert(bundleID != nil);
 * 2) se já está rodando, usa o caminho do app em execução;
 * 3) senão, com um scheme, lista os candidatos de LSCopyApplicationURLsForURL(
 *    "scheme://fake") e escolhe o de bundle id igual (case-insensitive), executável,
 *    com maior CFBundleVersion "maior.menor" (desempate pela data de modificação);
 * 4) fallback para o seletor base absolutePathForAppBundleWithIdentifier:. */
- (NSString *)CX_absolutePathForAppBundleWithIdentifier:(NSString *)bundleID
                                   orIdentifyingURLScheme:(NSString *)scheme {
    NSAssert(bundleID != nil, @"Invalid parameter not satisfying: bundleIdentifier != nil");

    NSString *path = [self CX_findRunningAppBundleWithIdentifier:bundleID];

    if (scheme != nil && path == nil) {
        NSFileManager *fm = [NSFileManager defaultManager];
        NSURL *schemeURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@:fake", scheme]];
        CFArrayRef candidates = LSCopyApplicationURLsForURL((__bridge CFURLRef)schemeURL,
                                                            kLSRolesAll);
        NSDate *bestDate = [NSDate distantPast];
        NSURL *bestURL = nil;
        int bestMajor = -1, bestMinor = -1;

        for (NSURL *candURL in (__bridge_transfer NSArray *)candidates) {
            @autoreleasepool {
                NSBundle *b = [NSBundle bundleWithURL:candURL];
                if (!b) continue;
                if ([[b bundleIdentifier] caseInsensitiveCompare:bundleID] != NSOrderedSame) continue;
                if (![fm isExecutableFileAtPath:[b executablePath]]) continue;

                NSString *ver = [b objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
                NSScanner *sc = [NSScanner scannerWithString:ver ?: @""];
                int major = 0, minor = 0;
                if (![sc scanInt:&major]) continue;
                if (![sc scanString:@"." intoString:NULL]) continue;
                if (![sc scanInt:&minor]) continue;
                if (![sc scanString:@"." intoString:NULL]) continue; /* exige "maior.menor." */
                if (major <= 0 || minor < 0) continue;

                NSString *resolved = [[candURL URLByResolvingSymlinksInPath] path];
                NSDate *mdate = [[fm attributesOfItemAtPath:resolved error:NULL] fileModificationDate];

                BOOL better = (bestMajor < major) ||
                              (major == bestMajor && bestMinor < minor) ||
                              (major == bestMajor && minor == bestMinor &&
                               [mdate compare:bestDate] == NSOrderedDescending);
                if (better) {
                    bestMajor = major; bestMinor = minor;
                    bestDate = [mdate copy];
                    bestURL = candURL;
                }
            }
        }
        path = bestURL ? [bestURL path] : nil;
    }

    if (path == nil) {
        path = [self absolutePathForAppBundleWithIdentifier:bundleID];
    }
    return path;
}

/* -[… CX_openURLs:withAppBundleIdentifier:orIdentifyingURLScheme:options:
 *                                      additionalEventParamDescriptor:]  @0x10000408c
 * Resolve o app, monta um LSLaunchURLSpec com os itens e o descritor de evento
 * (BtNm/BtTg) e chama LSOpenFromURLSpec. */
- (BOOL)CX_openURLs:(NSArray *)urls
    withAppBundleIdentifier:(NSString *)bundleID
     orIdentifyingURLScheme:(NSString *)scheme
                    options:(NSWorkspaceLaunchOptions)options
 additionalEventParamDescriptor:(NSAppleEventDescriptor *)param {
    NSAssert(bundleID != nil || scheme != nil,
             @"Invalid parameter not satisfying: bundleIdentifier != nil");

    NSString *appPath = [self CX_absolutePathForAppBundleWithIdentifier:bundleID
                                                 orIdentifyingURLScheme:scheme];
    if (appPath == nil) {
        return NO;
    }

    LSLaunchURLSpec spec;
    memset(&spec, 0, sizeof(spec));
    spec.appURL = (__bridge CFURLRef)[NSURL fileURLWithPath:appPath];
    spec.itemURLs = (__bridge CFArrayRef)urls;
    spec.passThruParams = [param aeDesc];
    spec.launchFlags = (LSLaunchFlags)options;
    spec.asyncRefCon = NULL;

    OSStatus status = LSOpenFromURLSpec(&spec, NULL);
    return status == noErr;
}

/* -[… CX_launchAppWithBundleIdentifier:…]  @0x100003f64
 * Se o app já está rodando, considera lançado; senão chama CX_openURLs sem itens. */
- (BOOL)CX_launchAppWithBundleIdentifier:(NSString *)bundleID
                  orIdentifyingURLScheme:(NSString *)scheme
                                 options:(NSWorkspaceLaunchOptions)options
          additionalEventParamDescriptor:(NSAppleEventDescriptor *)param {
    NSAssert(bundleID != nil, @"Invalid parameter not satisfying: bundleIdentifier != nil");

    if ([self CX_findRunningAppBundleWithIdentifier:bundleID] != nil) {
        return YES;
    }
    return [self CX_openURLs:nil
    withAppBundleIdentifier:bundleID
     orIdentifyingURLScheme:scheme
                    options:options
 additionalEventParamDescriptor:param];
}

@end

#pragma mark - Delegate do helper (CXHelperDelegate)

static NSString *const kCrossOverBundleID = @"com.codeweavers.CrossOver";
static NSString *const kCrossOverScheme   = @"com.codeweavers.private-CrossOver-app-scheme";
static const NSWorkspaceLaunchOptions kHelperLaunchOptions =
    (NSWorkspaceLaunchOptions)(kLSLaunchAsync | kLSLaunchDontAddToRecents); /* 0x10100 */

@interface CXHelperDelegate : NSObject <NSApplicationDelegate>
- (void)scheduleTerminate;
- (BOOL)passURLsToCrossOver:(NSArray *)urls;
- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event
            withReplyEvent:(NSAppleEventDescriptor *)reply;
@end

@implementation CXHelperDelegate

/* -[CXHelperDelegate scheduleTerminate]  @0x1000032f4
 * Reagenda o terminate: do NSApp para daqui a 2 s (cancelando o anterior). */
- (void)scheduleTerminate {
    [NSObject cancelPreviousPerformRequestsWithTarget:NSApp
                                             selector:@selector(terminate:)
                                               object:self];
    [NSApp performSelector:@selector(terminate:) withObject:self afterDelay:2.0];
}

/* -[CXHelperDelegate applicationWillFinishLaunching:]  @0x1000037c0
 * Registra o handler de eventos 'GURL'/'GURL'. */
- (void)applicationWillFinishLaunching:(NSNotification *)note {
    [[NSAppleEventManager sharedAppleEventManager]
        setEventHandler:self
            andSelector:@selector(handleGetURLEvent:withReplyEvent:)
          forEventClass:kInternetEventClass
             andEventID:kAEGetURL];
}

/* -[CXHelperDelegate applicationDidFinishLaunching:]  @0x100003818 */
- (void)applicationDidFinishLaunching:(NSNotification *)note {
    [self scheduleTerminate];
}

/* -[CXHelperDelegate passURLsToCrossOver:]  @0x100003448
 * Lê nome/tag da bottle do próprio Info.plist, monta um recordDescriptor
 * {BtNm, BtTg} e relança o CrossOver com os URLs recebidos. */
- (BOOL)passURLsToCrossOver:(NSArray *)urls {
    NSBundle *mb = [NSBundle mainBundle];
    NSString *bottleName = [mb objectForInfoDictionaryKey:@"CXHelperAppBottleName"];
    NSString *bottleTag  = [mb objectForInfoDictionaryKey:@"CXHelperAppBottleTag"];
    if ([bottleTag length] > 0) {
        bottleTag = [bottleTag substringToIndex:[bottleTag length] - 1]; /* tira o último char */
    }

    NSAppleEventDescriptor *record = [NSAppleEventDescriptor recordDescriptor];
    [record setDescriptor:[NSAppleEventDescriptor descriptorWithString:bottleName ?: @""]
               forKeyword:'BtNm'];
    [record setDescriptor:[NSAppleEventDescriptor descriptorWithString:bottleTag ?: @""]
               forKeyword:'BtTg'];

    BOOL ok = [[NSWorkspace sharedWorkspace] CX_openURLs:urls
                                withAppBundleIdentifier:kCrossOverBundleID
                                 orIdentifyingURLScheme:kCrossOverScheme
                                                options:kHelperLaunchOptions
                             additionalEventParamDescriptor:record];
    [self scheduleTerminate];
    return ok;
}

/* -[CXHelperDelegate applicationOpenUntitledFile:]  @0x100003350
 * Clique no helper sem documento: passa o próprio bundle como item. */
- (BOOL)applicationOpenUntitledFile:(NSApplication *)sender {
    [self scheduleTerminate];
    NSURL *selfURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    return [[NSWorkspace sharedWorkspace] CX_openURLs:@[ selfURL ]
                            withAppBundleIdentifier:kCrossOverBundleID
                             orIdentifyingURLScheme:kCrossOverScheme
                                            options:kHelperLaunchOptions
                         additionalEventParamDescriptor:nil];
}

/* -[CXHelperDelegate application:openFiles:]  @0x100003618
 * Converte os caminhos em fileURLs, repassa e responde ao Launch Services. */
- (void)application:(NSApplication *)sender openFiles:(NSArray<NSString *> *)filenames {
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:[filenames count]];
    for (NSString *path in filenames) {
        [urls addObject:[NSURL fileURLWithPath:path]];
    }
    BOOL ok = [self passURLsToCrossOver:urls];
    [sender replyToOpenOrPrint:(ok ? NSApplicationDelegateReplySuccess
                                   : NSApplicationDelegateReplyFailure)];
    [self scheduleTerminate];
}

/* -[CXHelperDelegate handleGetURLEvent:withReplyEvent:]  @0x10000381c
 * Esquema de URL: extrai '----', repassa a URL ao CrossOver. */
- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event
            withReplyEvent:(NSAppleEventDescriptor *)reply {
    NSString *urlString = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    if ([urlString length] > 0) {
        NSURL *url = [NSURL URLWithString:urlString];
        [self passURLsToCrossOver:@[ url ]];
    }
    [self scheduleTerminate];
}

@end

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        CXHelperDelegate *delegate = [[CXHelperDelegate alloc] init];
        [app setDelegate:delegate];
        return NSApplicationMain(argc, argv);
    }
}
