/*
 * MenuHelper.m — reconstrução compilável do "Menu Helper" do CrossOver 26.3.
 *
 * Alvo: Contents/Resources/Menu Helper.cpbz2  (bzip2 → cpio → .app)
 *   Contents/MacOS/Menu Helper — Mach-O x86_64
 *   Slice analisada: x86_64
 *
 * Decompilação: Ghidra 12.1.4 headless via REA. O comportamento abaixo foi lido
 * do pseudocódigo (MenuHelper.decompiled.c); cada método traz o nome original e
 * o endereço. Onde o corpo exato não aparece no decompilado (blocos de dispatch,
 * o helper readData:length:, o layout bruto do cmsg), a reconstrução segue o
 * protocolo documentado do Wine/CrossOver e está marcada com (inferência).
 *
 * O que o helper faz: é um app .app por-programa. Ao ser aberto, roda o programa
 * Windows da bottle via Wine, usando cxmenu/cxstart como tarefa (CXTask na GUI;
 * aqui NSTask, mesma API). Opcionalmente hospeda a app Wine através de um
 * WineLoader embarcado: um socket AF_UNIX com protocolo length-prefixed e
 * passagem de descritores (SCM_RIGHTS) que, do lado nativo, faz dlopen do
 * ntdll.so e salta __wine_main — exatamente a fronteira que faltava em
 * ../../native (lá está o lado cliente do wineserver; aqui, o servidor macdrv
 * que o Wine chama de volta).
 *
 * Diferença para o Bottle Helper: o Bottle Helper delega ao CrossOver; o Menu
 * Helper ELE MESMO roda o programa.
 *
 * Códigos de 4 caracteres (AppleEvents):
 *   'GURL' classe/ID do evento de URL · '----' keyDirectObject
 *   'BtNm' nome da bottle · 'BtTg' tag da bottle (sem o último char)
 */

#import <Cocoa/Cocoa.h>
#import <dispatch/dispatch.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <dlfcn.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <crt_externs.h>   /* _NSGetEnviron */

#pragma mark - Constantes

static NSString *const kCrossOverBundleID = @"com.codeweavers.CrossOver";
static NSString *const kCrossOverScheme   = @"com.codeweavers.private-CrossOver-app-scheme";
static NSString *const kHelperServerName  = @"com.codeweavers.CrossOver.HelperServer";

/* Protocolo do socket do WineLoader (lido de handleConnection @0x200007e75). */
static const uint32_t kWineLoaderRequestMagic  = 0x52c17355; /* pedido esperado */
static const uint32_t kWineLoaderResponseMagic = 0x52c17356; /* resposta de OK  */

#pragma mark - Interfaces reutilizadas

/* O helper fala com o HelperServer do CrossOver por Distributed Objects
 * (NSConnection). Só estes dois seletores são usados. */
@protocol CXHelperServer
- (BOOL)isServerReadyForBottle:(NSString *)bottleName;
- (NSMutableDictionary *)getEnvironmentForXConnection;
@end

/* Na GUI o host de eventos Wine é um controller dedicado; aqui declaramos só o
 * que CXFBHelperApp usa. wineController pode ser nil (então os eventos seguem
 * direto para o NSApplication). */
@protocol CXWineController
- (BOOL)handleEvent:(NSEvent *)event;
- (void)didSendEvent:(NSEvent *)event;
@end

/* A categoria NSWorkspace(CrossOverAdditions) usada em
 * applicationWillFinishLaunching (CX_openURLs:…, CX_absolutePathForAppBundle…) é
 * a mesma reconstruída em BottleHelper.m; num build conjunto dos helpers ela é
 * compartilhada. Declarada aqui para este arquivo compilar isolado. */
@interface NSWorkspace (CrossOverAdditions)
- (NSString *)CX_absolutePathForAppBundleWithIdentifier:(NSString *)bundleID
                                 orIdentifyingURLScheme:(NSString *)scheme;
- (BOOL)CX_openURLs:(NSArray *)urls
    withAppBundleIdentifier:(NSString *)bundleID
     orIdentifyingURLScheme:(NSString *)scheme
                    options:(NSWorkspaceLaunchOptions)options
 additionalEventParamDescriptor:(NSAppleEventDescriptor *)param;
@end

@class WineLoader;

#pragma mark - WineLoaderClientConnection

/* Uma conexão aceita no socket do WineLoader. handleConnection executa o
 * protocolo e, no sucesso, salta __wine_main (que não retorna). */
@interface WineLoaderClientConnection : NSObject {
    WineLoader *_owner;  /* +8  no binário */
    int         _fd;     /* +0x10 */
}
- (instancetype)initWithFileDescriptor:(int)fd owner:(WineLoader *)owner;
- (void)handleConnection;
- (void *)readLengthPrefixedBuffer:(unsigned long long *)outLength;
- (BOOL)readData:(void *)buffer length:(size_t)length;
@end

#pragma mark - WineLoader

/* Socket AF_UNIX que escuta a app Wine (loader macdrv). Offsets do binário:
 *   +8 crossOverRoot · +0x10 fd · +0x18 socketPath · +0x20 bound
 *   +0x28 terminateObserver · +0x30 acceptSource · +0x38 hasSource */
@interface WineLoader : NSObject {
    NSString          *_crossOverRoot;
    int                _fd;
    NSString          *_socketPath;
    BOOL               _bound;
    id                 _terminateObserver;
    dispatch_source_t  _acceptSource;
    BOOL               _hasSource;
}
- (instancetype)initWithCrossOverRoot:(NSString *)root;
- (NSString *)socketPath;
- (NSString *)crossOverRoot;
- (BOOL)shouldConnectionProceedWithRequest:(id)request;
@end

@implementation WineLoader

/* -[WineLoader initWithCrossOverRoot:]  @0x200008a10 */
- (instancetype)initWithCrossOverRoot:(NSString *)root {
    self = [super init];
    if (!self) return nil;

    _crossOverRoot = [root copy];
    _fd = socket(AF_UNIX, SOCK_STREAM, 0);          /* socket(1,1,0) */
    if (_fd == -1) { return nil; }
    if (fcntl(_fd, F_SETFL, O_NONBLOCK) != 0) {     /* fcntl(fd,4,4): listener não-bloqueante */
        return nil;
    }

    char *name = tmpnam(NULL);                      /* caminho efêmero do socket */
    if (name == NULL) { return nil; }
    _socketPath = [[NSFileManager defaultManager]
                      stringWithFileSystemRepresentation:name length:strlen(name)];
    if (_socketPath == nil) { return nil; }

    struct sockaddr_un addr;
    memset(&addr, 0, sizeof(addr));
    addr.sun_family = AF_UNIX;
    if (strlcpy(addr.sun_path, name, sizeof(addr.sun_path)) >= sizeof(addr.sun_path)) {
        return nil;                                 /* path longo demais para sockaddr_un */
    }
    addr.sun_len = (unsigned char)(strlen(addr.sun_path) + 3);
    if (bind(_fd, (struct sockaddr *)&addr, sizeof(addr)) != 0) {
        return nil;
    }
    _bound = YES;

    /* Observa o encerramento do app para limpar o socket. O bloco não aparece no
     * decompilado (usingBlock resolvido como 0); (inferência) da limpeza. */
    __weak WineLoader *weakSelf = self;
    _terminateObserver = [[NSNotificationCenter defaultCenter]
        addObserverForName:NSApplicationWillTerminateNotification
                    object:NSApp
                     queue:nil
                usingBlock:^(NSNotification * _Nonnull note) {
                    (void)note;
                    [weakSelf shouldConnectionProceedWithRequest:nil];
                }];

    if (listen(_fd, 5) != 0) { return nil; }

    dispatch_queue_t q = dispatch_get_global_queue(0, 0);
    _acceptSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ,
                                           (uintptr_t)_fd, 0, q);
    if (_acceptSource == NULL) { return nil; }
    _hasSource = YES;

    /* Handler de aceitação (inferência: o corpo do bloco não está no decompilado,
     * mas o papel — accept() e servir a conexão — está claro pela estrutura). */
    __weak WineLoader *weakSelf2 = self;
    dispatch_source_set_event_handler(_acceptSource, ^{
        WineLoader *strong = weakSelf2;
        if (!strong) return;
        int conn = accept(strong->_fd, NULL, NULL);
        if (conn == -1) return;
        WineLoaderClientConnection *c =
            [[WineLoaderClientConnection alloc] initWithFileDescriptor:conn owner:strong];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [c handleConnection];
        });
    });
    dispatch_source_set_cancel_handler(_acceptSource, ^{ /* (inferência) */ });
    dispatch_resume(_acceptSource);
    return self;
}

- (NSString *)socketPath { return _socketPath; }
- (NSString *)crossOverRoot { return _crossOverRoot; }

/* -[WineLoader shouldConnectionProceedWithRequest:]  @0x200008f5c
 * Primeira conexão: desarma o accept, remove o observer, apaga o socket e, se o
 * app ainda não está ativo, abre uma atividade "Running Windows program" (evita
 * App Nap). Devolve NO se já não há source (nada a fazer). */
- (BOOL)shouldConnectionProceedWithRequest:(id)request {
    (void)request;
    if (_acceptSource == NULL) {
        return NO;
    }
    dispatch_source_cancel(_acceptSource);
    _acceptSource = NULL;
    _hasSource = NO;

    if (_terminateObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:_terminateObserver];
        _terminateObserver = nil;
    }
    if (_bound) {
        unlink([_socketPath fileSystemRepresentation]);
        _bound = NO;
    }
    _socketPath = nil;

    if ([NSApp activationPolicy] == NSApplicationActivationPolicyRegular) {
        /* activationPolicy == 0; mantém a atividade viva (retida de propósito).
         * Opções = &DAT_00efffff lido do binário. */
        id activity = [[NSProcessInfo processInfo]
            beginActivityWithOptions:(NSActivityOptions)0x00efffffULL
                              reason:@"Running Windows program"];
        (void)CFBridgingRetain(activity);
    }
    return YES;
}

@end

#pragma mark - WineLoaderClientConnection (implementação)

@implementation WineLoaderClientConnection

- (instancetype)initWithFileDescriptor:(int)fd owner:(WineLoader *)owner {
    self = [super init];
    if (self) {
        _fd = fd;
        _owner = owner;
    }
    return self;
}

/* -[… readData:length:]  (helper; não decompilado — (inferência) de leitura total
 * com retry em EINTR). */
- (BOOL)readData:(void *)buffer length:(size_t)length {
    char *p = (char *)buffer;
    size_t got = 0;
    while (got < length) {
        ssize_t n = read(_fd, p + got, length - got);
        if (n > 0) { got += (size_t)n; continue; }
        if (n == -1 && errno == EINTR) { continue; }
        return NO; /* EOF precoce ou erro */
    }
    return YES;
}

/* -[… readLengthPrefixedBuffer:]  @0x200007db4
 * Lê 8 bytes de tamanho e depois esse tanto de bytes. */
- (void *)readLengthPrefixedBuffer:(unsigned long long *)outLength {
    if (![self readData:outLength length:8]) {
        NSLog(@"%s: reading length failed, errno %d",
              "-[WineLoaderClientConnection readLengthPrefixedBuffer:]", errno);
        return NULL;
    }
    size_t len = (size_t)*outLength;
    void *buf = malloc(len);
    if (buf == NULL) {
        NSLog(@"%s: failed to allocate buffer of length %llu",
              "-[WineLoaderClientConnection readLengthPrefixedBuffer:]",
              (unsigned long long)len);
        return NULL;
    }
    if (![self readData:buf length:len]) {
        NSLog(@"%s: reading buffer failed, errno %d",
              "-[WineLoaderClientConnection readLengthPrefixedBuffer:]", errno);
        free(buf);
        return NULL;
    }
    return buf;
}

/* -[… handleConnection]  @0x200007e75
 * Protocolo (lido do pseudocódigo):
 *   1. torna o socket bloqueante (limpa O_NONBLOCK);
 *   2. lê o tipo do pedido (4 bytes) == kWineLoaderRequestMagic;
 *   3. lê 3 buffers length-prefixed: working dir (string), environment
 *      (bloco "k=v\0" terminado em \0) e args (argv "\0"-separado);
 *   4. recvmsg com SCM_RIGHTS: 3 fds de std + (opcional) o fd do wineserver;
 *   5. lê 1 byte esperando EOF;
 *   6. dlopen(crossOverRoot/lib/wine/x86_64-unix/ntdll.so) + dlsym(__wine_main);
 *   7. pergunta ao WineLoader shouldConnectionProceedWithRequest: na main queue;
 *   8. responde kWineLoaderResponseMagic, fecha o socket, libera as reservas de
 *      memória (mmap), chdir, reconstrói o environ (pulando WINE_WAIT_CHILD_PIPE
 *      e CX_ALT_LOADER_SOCKET), monta argv, resolve WINELOADER, dup2 dos 3 fds,
 *      exporta WINESERVERSOCKET/WINE_WAIT_CHILD_PIPE e salta __wine_main (que
 *      não retorna).
 * A validação bruta do cmsg no binário usa offsets; aqui usamos as macros CMSG_*
 * portáveis, equivalentes ao mesmo protocolo (inferência de forma, não de
 * comportamento). */
- (void)handleConnection {
    @autoreleasepool {
        /* Todas as variáveis do caminho de limpeza declaradas/inicializadas antes
         * de qualquer goto, para nenhum salto pular uma inicialização. */
        unsigned long long cwdLen = 0, envLen = 0, argsLen = 0;
        char *cwd = NULL, *env = NULL, *args = NULL;
        char **argv = NULL;
        void *ntdll = NULL;
        int argc = 0;
        int stdFds[3] = { -1, -1, -1 };
        int wineserverFd = -1;

        int flags = fcntl(_fd, F_GETFL);
        if (flags == -1) {
            NSLog(@"%s: fcntl(F_GETFL) failed, errno %d",
                  "-[WineLoaderClientConnection handleConnection]", errno);
            goto cleanup;
        }
        if (fcntl(_fd, F_SETFL, flags & ~O_NONBLOCK) == -1) {
            NSLog(@"%s: fcntl(F_SETFL) failed, errno %d",
                  "-[WineLoaderClientConnection handleConnection]", errno);
            goto cleanup;
        }

        uint32_t requestType = 0;
        if (![self readData:&requestType length:4]) {
            NSLog(@"%s: reading request type failed, errno %d",
                  "-[WineLoaderClientConnection handleConnection]", errno);
            goto cleanup;
        }
        if (requestType != kWineLoaderRequestMagic) {
            NSLog(@"%s: unknown request type 0x%08x",
                  "-[WineLoaderClientConnection handleConnection]", requestType);
            goto cleanup;
        }

        cwd = [self readLengthPrefixedBuffer:&cwdLen];
        if (cwd == NULL) {
            NSLog(@"%s: reading working directory failed",
                  "-[WineLoaderClientConnection handleConnection]");
            goto cleanup;
        }
        if (cwdLen == 0) { free(cwd); cwd = NULL; }
        else if (!(cwd[cwdLen - 1] == '\0' && strlen(cwd) + 1 == cwdLen)) {
            NSLog(@"%s: working directory is not a single null-terminated string",
                  "-[WineLoaderClientConnection handleConnection]");
            goto cleanup;
        }

        env = [self readLengthPrefixedBuffer:&envLen];
        if (env == NULL) {
            NSLog(@"%s: reading environment failed",
                  "-[WineLoaderClientConnection handleConnection]");
            goto cleanup;
        }
        if (!(envLen == 0 || env[envLen - 1] == '\0')) {
            NSLog(@"%s: environment is not null-terminated",
                  "-[WineLoaderClientConnection handleConnection]");
            goto cleanup;
        }

        args = [self readLengthPrefixedBuffer:&argsLen];
        if (args == NULL) {
            NSLog(@"%s: reading args failed",
                  "-[WineLoaderClientConnection handleConnection]");
            goto cleanup;
        }
        if (argsLen == 0) {
            NSLog(@"%s: args list is empty",
                  "-[WineLoaderClientConnection handleConnection]");
            goto cleanup;
        }
        if (args[argsLen - 1] != '\0') {
            NSLog(@"%s: args is not null-terminated",
                  "-[WineLoaderClientConnection handleConnection]");
            goto cleanup;
        }
        /* argc = 1 (argv[0]) + um por cada '\0' em args. */
        argc = 1;
        for (unsigned long long i = 0; i < argsLen; i++) {
            if (args[i] == '\0') argc++;
        }
        argv = (char **)malloc((size_t)argc * sizeof(char *) + sizeof(char *));
        if (argv == NULL) {
            NSLog(@"%s: failed to allocate argv with %d elements",
                  "-[WineLoaderClientConnection handleConnection]", argc);
            goto cleanup;
        }

        /* Recebe os descritores por SCM_RIGHTS: 3 de std + (opcional) o do
         * wineserver. recvmsg com 1 byte de payload (local_31). */
        {
            char ctrl[CMSG_SPACE(4 * sizeof(int))];
            char dummy = 0;
            struct iovec iov = { .iov_base = &dummy, .iov_len = 1 };
            struct msghdr msg;
            memset(&msg, 0, sizeof(msg));
            msg.msg_iov = &iov;
            msg.msg_iovlen = 1;
            msg.msg_control = ctrl;
            msg.msg_controllen = sizeof(ctrl);

            ssize_t r;
            do { r = recvmsg(_fd, &msg, MSG_WAITALL); }
            while (r == -1 && errno == EINTR);

            if (r != 1 || (msg.msg_flags & MSG_CTRUNC)) {
                NSLog(@"%s: failed to receive file descriptors%s",
                      "-[WineLoaderClientConnection handleConnection]",
                      r == -1 ? "" : "");
                goto cleanup;
            }
            struct cmsghdr *cm = CMSG_FIRSTHDR(&msg);
            if (cm == NULL || cm->cmsg_level != SOL_SOCKET || cm->cmsg_type != SCM_RIGHTS) {
                NSLog(@"%s: failed to receive file descriptors",
                      "-[WineLoaderClientConnection handleConnection]");
                goto cleanup;
            }
            int nfds = (int)((cm->cmsg_len - CMSG_LEN(0)) / sizeof(int));
            int *fds = (int *)CMSG_DATA(cm);
            for (int i = 0; i < nfds && i < 3; i++) stdFds[i] = fds[i];
            if (nfds >= 4) wineserverFd = fds[3];
        }

        /* Espera o EOF (o lado Wine fecha a ponta de escrita). */
        {
            char b;
            ssize_t r;
            do { r = read(_fd, &b, 1); }
            while (r == -1 && errno == EINTR);
            if (r == -1) {
                NSLog(@"%s: failed to read EOF, errno %d",
                      "-[WineLoaderClientConnection handleConnection]", errno);
                goto cleanup;
            }
            if (r != 0) {
                NSLog(@"%s: got extraneous data instead of EOF",
                      "-[WineLoaderClientConnection handleConnection]");
                goto cleanup;
            }
        }

        /* Seção "ponto sem retorno", em escopo próprio: declara variáveis strong
         * e __block e usa um bloco que captura self, então os goto cleanup de
         * cima não podem cruzar suas vidas (exigência do ARC). */
        {
        /* dlopen do ntdll.so e resolução de __wine_main. */
        NSString *ntdllPath = [[[[[_owner crossOverRoot]
            stringByAppendingPathComponent:@"lib"]
            stringByAppendingPathComponent:@"wine"]
            stringByAppendingPathComponent:@"x86_64-unix"]
            stringByAppendingPathComponent:@"ntdll.so"];
        ntdll = dlopen([ntdllPath fileSystemRepresentation], 0);
        if (ntdll == NULL) {
            NSLog(@"Failed to load %@: %s", ntdllPath, dlerror());
            goto cleanup;
        }
        void (*wine_main)(int, char **) =
            (void (*)(int, char **))dlsym(ntdll, "__wine_main");
        if (wine_main == NULL) {
            NSLog(@"Failed to find symbol __wine_main in %@: %s", ntdllPath, dlerror());
            goto cleanup;
        }

        /* Confirma na main queue que esta conexão deve prosseguir (desarma o
         * accept e abre a atividade). Se não, aborta. */
        __block BOOL proceed = NO;
        dispatch_sync(dispatch_get_main_queue(), ^{
            proceed = [_owner shouldConnectionProceedWithRequest:nil];
        });
        if (!proceed) { goto cleanup; }

        /* Responde OK. */
        {
            uint32_t resp = kWineLoaderResponseMagic;
            char *p = (char *)&resp;
            size_t sent = 0;
            while (sent < 4) {
                ssize_t n = write(_fd, p + sent, 4 - sent);
                if (n < 1) {
                    if (errno == EINTR) continue;
                    NSLog(@"%s: failed to send response, errno %d",
                          "-[WineLoaderClientConnection handleConnection]", errno);
                    goto cleanup;
                }
                sent += (size_t)n;
            }
        }
        close(_fd);
        _fd = -1;

        /* A partir daqui o processo VIRA o processo Wine. */
        if (cwd != NULL && cwd[0] != '\0') { chdir(cwd); }

        /* Reconstrói o environ a partir do bloco recebido, pulando as duas
         * variáveis que o loader define por conta própria. */
        {
            char **fresh = (char **)malloc(sizeof(char *));
            fresh[0] = NULL;
            *_NSGetEnviron() = fresh;    /* zera o environ herdado */
            char *p = env;
            unsigned long long remaining = envLen;
            while (remaining != 0) {
                size_t n = strlen(p);
                char *eq = strchr(p, '=');
                if (eq == NULL) {
                    NSLog(@"%s: environment buffer has malformed string %s",
                          "-[WineLoaderClientConnection handleConnection]", p);
                    goto cleanup;
                }
                *eq = '\0';
                if (strcmp(p, "WINE_WAIT_CHILD_PIPE") != 0 &&
                    strcmp(p, "CX_ALT_LOADER_SOCKET") != 0) {
                    setenv(p, eq + 1, 1);
                }
                p += n + 1;
                remaining -= (n + 1);
            }
        }

        /* argv[0] = WINELOADER (do env) ou <crossOverRoot>/bin/wineloader. */
        {
            char *loader = getenv("WINELOADER");
            if (loader != NULL) {
                argv[0] = loader;
            } else {
                NSString *wl = [[[_owner crossOverRoot]
                    stringByAppendingPathComponent:@"bin"]
                    stringByAppendingPathComponent:@"wineloader"];
                const char *u = [wl UTF8String];
                if (u == NULL || (argv[0] = strdup(u)) == NULL) {
                    NSLog(@"failed to construct wineloader path string");
                    goto cleanup;
                }
            }
            /* argv[1..] a partir do buffer de args. */
            char *a = args;
            for (int i = 1; i < argc; i++) {
                argv[i] = a;
                a += strlen(a) + 1;
            }
            argv[argc] = NULL;
        }

        /* dup2 dos 3 fds de std recebidos para 0/1/2. */
        for (int i = 0; i < 3; i++) {
            dup2(stdFds[i], i);
            close(stdFds[i]);
            stdFds[i] = -1;
        }
        /* O fd do wineserver fica close-on-exec e é exportado. */
        if (wineserverFd >= 0) {
            if (fcntl(wineserverFd, F_SETFD, FD_CLOEXEC) == -1) {
                NSLog(@"%s: failed to set received Wineserver socket to close-on-exec, errno %d",
                      "-[WineLoaderClientConnection handleConnection]", errno);
            }
            setenv("WINESERVERSOCKET",
                   [[NSString stringWithFormat:@"%d", wineserverFd] UTF8String], 1);
            setenv("WINE_WAIT_CHILD_PIPE",
                   [[NSString stringWithFormat:@"%d", wineserverFd] UTF8String], 1);
        }

        wine_main(argc, argv);   /* não retorna */
        /* fallthrough defensivo */
        }

    cleanup:
        if (cwd)  free(cwd);
        if (env)  free(env);
        if (args) free(args);
        if (argv) free(argv);
        for (int i = 0; i < 3; i++) if (stdFds[i] != -1) close(stdFds[i]);
        if (wineserverFd != -1) close(wineserverFd);
        if (ntdll) dlclose(ntdll);
        if (_fd != -1) { close(_fd); _fd = -1; }
    }
    return;
}

@end

#pragma mark - CXFBHelperDelegate

@interface CXFBHelperDelegate : NSObject <NSApplicationDelegate> {
    NSString *_bottleName;
    NSString *_menuPath;
    NSString *_crossOverRoot;
    NSString *_cxmenuPath;
    NSString *_cxstartPath;
    NSString *_winePath;
    id<CXHelperServer> _helperServerProxy;
    NSMutableArray *_taskArray;
    WineLoader *_wineLoader;
}
- (NSTask *)createWineTaskWithLaunchPath:(NSString *)launchPath
                            andArguments:(NSArray *)arguments;
- (void)formatMenuItemsWithBundleName:(NSMenu *)menu;
- (void)wineAppExited:(NSNotification *)note;
- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event
            withReplyEvent:(NSAppleEventDescriptor *)reply;
@end

@implementation CXFBHelperDelegate

- (instancetype)init {
    self = [super init];
    if (self) { _taskArray = [[NSMutableArray alloc] init]; }
    return self;
}

/* -[CXFBHelperDelegate applicationWillFinishLaunching:]  @0x200002edd */
- (void)applicationWillFinishLaunching:(NSNotification *)note {
    (void)note;
    [[NSAppleEventManager sharedAppleEventManager]
        setEventHandler:self
            andSelector:@selector(handleGetURLEvent:withReplyEvent:)
          forEventClass:kInternetEventClass
             andEventID:kAEGetURL];

    NSBundle *mb = [NSBundle mainBundle];
    _bottleName = [[mb objectForInfoDictionaryKey:@"CXHelperAppBottleName"] copy];

    NSString *tag = [mb objectForInfoDictionaryKey:@"CXHelperAppBottleTag"];
    if ([tag length] > 0) tag = [tag substringToIndex:[tag length] - 1];

    /* Traz o CrossOver à frente, carregando nome/tag da bottle no evento. */
    NSAppleEventDescriptor *record = [NSAppleEventDescriptor recordDescriptor];
    [record setDescriptor:[NSAppleEventDescriptor descriptorWithString:_bottleName ?: @""]
               forKeyword:'BtNm'];
    [record setDescriptor:[NSAppleEventDescriptor descriptorWithString:tag ?: @""]
               forKeyword:'BtTg'];
    NSURL *selfURL = [[NSBundle mainBundle] bundleURL];
    [[NSWorkspace sharedWorkspace] CX_openURLs:@[ selfURL ]
                      withAppBundleIdentifier:kCrossOverBundleID
                       orIdentifyingURLScheme:kCrossOverScheme
                                      options:(NSWorkspaceLaunchOptions)0x300
                   additionalEventParamDescriptor:record];

    /* Conecta ao HelperServer (até 10 tentativas, 1 s entre elas). */
    for (int tries = 10; _helperServerProxy == nil && tries > 0; tries--) {
        _helperServerProxy = (id<CXHelperServer>)
            [NSConnection rootProxyForConnectionWithRegisteredName:kHelperServerName host:nil];
        if (_helperServerProxy == nil) sleep(1);
    }
    if (_helperServerProxy == nil) {
        NSLog(@"Unable to locate a CrossOver helper server.  We should really tell someone about this.");
        [NSApp terminate:self];
    }
    [(NSDistantObject *)_helperServerProxy setProtocolForProxy:@protocol(CXHelperServer)];

    _bottleName = [[mb objectForInfoDictionaryKey:@"CXHelperAppBottleName"] copy];
    while (![_helperServerProxy isServerReadyForBottle:_bottleName]) {
        sleep(1);
    }

    _menuPath = [[mb objectForInfoDictionaryKey:@"CrossOverHelperMenuPath"] copy];

    /* crossOverRoot = <CrossOver.app>/Contents/SharedSupport/CrossOver. */
    NSString *coPath = [[NSWorkspace sharedWorkspace]
        CX_absolutePathForAppBundleWithIdentifier:kCrossOverBundleID
                           orIdentifyingURLScheme:kCrossOverScheme];
    NSBundle *co = [NSBundle bundleWithPath:coPath];
    _crossOverRoot = [[[co sharedSupportPath]
        stringByAppendingPathComponent:@"CrossOver"] copy];

    NSString *bin = [_crossOverRoot stringByAppendingPathComponent:@"bin"];
    _cxmenuPath  = [[bin stringByAppendingPathComponent:@"cxmenu"] copy];
    _cxstartPath = [[bin stringByAppendingPathComponent:@"cxstart"] copy];
    _winePath    = [[bin stringByAppendingPathComponent:@"wine"] copy];

    [self formatMenuItemsWithBundleName:[NSApp mainMenu]];
}

/* -[CXFBHelperDelegate applicationOpenUntitledFile:]  @0x200002200
 * cxmenu --bottle <nome> --wait-children --enable-alt-loader macdrv --start <menuPath> */
- (BOOL)applicationOpenUntitledFile:(NSApplication *)sender {
    (void)sender;
    NSArray *args = @[ @"--bottle", _bottleName ?: @"",
                       @"--wait-children", @"--enable-alt-loader", @"macdrv",
                       @"--start", _menuPath ?: @"" ];
    NSTask *task = [self createWineTaskWithLaunchPath:_cxmenuPath andArguments:args];
    if (task != nil) {
        [task launch];
        [_taskArray addObject:task];
    }
    return YES;
}

/* -[CXFBHelperDelegate handleGetURLEvent:withReplyEvent:]  @0x2000037ab
 * cxstart --bottle <nome> --enable-alt-loader macdrv -- <url> */
- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event
            withReplyEvent:(NSAppleEventDescriptor *)reply {
    (void)reply;
    NSString *url = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
    if ([url length] > 0) {
        NSArray *args = @[ @"--bottle", _bottleName ?: @"",
                           @"--enable-alt-loader", @"macdrv", @"--", url ];
        NSTask *task = [self createWineTaskWithLaunchPath:_cxstartPath andArguments:args];
        if (task != nil) {
            [task launch];
            [_taskArray addObject:task];
        }
    }
}

/* -[CXFBHelperDelegate application:openFiles:]  @0x2000022e9
 * Separa os arquivos: extensão registrada em CFBundleDocumentTypes → cxstart --;
 * caso contrário → cxmenu --start <menuPath>. Um arquivo por tarefa. */
- (void)application:(NSApplication *)sender openFiles:(NSArray<NSString *> *)filenames {
    NSArray *exts = [[[NSBundle mainBundle]
        objectForInfoDictionaryKey:@"CFBundleDocumentTypes"]
        valueForKeyPath:@"@distinctUnionOfArrays.CFBundleTypeExtensions"];
    NSSet *extSet = [NSSet setWithArray:(exts ?: @[])];

    NSArray *cxstartBase = @[ @"--bottle", _bottleName ?: @"",
                              @"--wait-children", @"--enable-alt-loader", @"macdrv", @"--" ];
    NSArray *cxmenuBase  = @[ @"--bottle", _bottleName ?: @"",
                              @"--wait-children", @"--enable-alt-loader", @"macdrv",
                              @"--start", _menuPath ?: @"" ];

    BOOL allOK = YES;
    for (NSString *file in filenames) {
        @autoreleasepool {
            BOOL registered = [extSet containsObject:[file pathExtension]];
            NSString *launchPath = registered ? _cxstartPath : _cxmenuPath;
            NSMutableArray *args =
                [(registered ? cxstartBase : cxmenuBase) mutableCopy];
            [args addObject:file];
            NSTask *task = [self createWineTaskWithLaunchPath:launchPath andArguments:args];
            if (task == nil) {
                allOK = NO;
            } else {
                [task launch];
                [_taskArray addObject:task];
            }
        }
    }
    [sender replyToOpenOrPrint:(allOK ? NSApplicationDelegateReplySuccess
                                      : NSApplicationDelegateReplyFailure)];
}

/* -[CXFBHelperDelegate createWineTaskWithLaunchPath:andArguments:]  @0x2000027ed
 * Monta a tarefa Wine: ambiente do HelperServer + CX_LAUNCHER_BUNDLE_NAME; se a
 * integração Wine não estiver desligada, cria sob demanda um WineLoader e
 * publica seu socket em CX_WINEWRAPPER_ALT_LOADER_SOCKET; std in/out no
 * /dev/null; observa o término para wineAppExited:. (CXTask na GUI; NSTask aqui.) */
- (NSTask *)createWineTaskWithLaunchPath:(NSString *)launchPath
                            andArguments:(NSArray *)arguments {
    NSMutableDictionary *env = [_helperServerProxy getEnvironmentForXConnection];
    NSString *bundleName = [[NSBundle mainBundle]
        objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    [env setObject:(bundleName ?: @"") forKey:@"CX_LAUNCHER_BUNDLE_NAME"];

    NSDictionary *domain = [[NSUserDefaults standardUserDefaults]
        persistentDomainForName:kCrossOverBundleID];
    BOOL disableIntegration =
        [[domain objectForKey:@"DisableWineIntegration"] boolValue];

    if (!disableIntegration) {
        if (_wineLoader == nil) {
            _wineLoader = [[WineLoader alloc] initWithCrossOverRoot:_crossOverRoot];
        }
        NSString *socketPath = [_wineLoader socketPath];
        if ([socketPath length] != 0) {
            [env setObject:socketPath forKey:@"CX_WINEWRAPPER_ALT_LOADER_SOCKET"];
        }
    }

    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:launchPath];
    if (arguments != nil) [task setArguments:arguments];
    [task setCurrentDirectoryPath:NSHomeDirectory()];
    [task setStandardInput:[NSFileHandle fileHandleWithNullDevice]];
    [task setStandardOutput:[NSFileHandle fileHandleWithNullDevice]];
    [task setEnvironment:env];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wineAppExited:)
                                                 name:NSTaskDidTerminateNotification
                                               object:task];
    return task;
}

/* -[CXFBHelperDelegate formatMenuItemsWithBundleName:]  @0x200002b40
 * Substitui o marcador do nome do app nos títulos dos itens (recursivo nos
 * submenus). (inferência: o decompilador rotulou o marcador de forma ambígua;
 * o CrossOver usa "%@" como placeholder do nome.) */
- (void)formatMenuItemsWithBundleName:(NSMenu *)menu {
    NSString *bundleName = [[NSBundle mainBundle]
        objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey] ?: @"";
    static NSString *const kPlaceholder = @"%@"; /* (inferência) */

    for (NSInteger i = 0; i < [menu numberOfItems]; i++) {
        NSMenuItem *item = [menu itemAtIndex:i];
        if ([item isSeparatorItem]) continue;

        if ([[item attributedTitle] length] == 0) {
            NSString *title = [item title];
            if ([title length] != 0 &&
                [title rangeOfString:kPlaceholder].location != NSNotFound) {
                [item setTitle:[title stringByReplacingOccurrencesOfString:kPlaceholder
                                                                withString:bundleName]];
            }
        } else {
            NSAttributedString *at = [item attributedTitle];
            if ([[at string] rangeOfString:kPlaceholder].location != NSNotFound) {
                NSMutableAttributedString *mut = [at mutableCopy];
                [[mut mutableString]
                    replaceOccurrencesOfString:kPlaceholder
                                    withString:bundleName
                                       options:0
                                         range:NSMakeRange(0, [mut length])];
                [item setAttributedTitle:mut];
            }
        }
        if ([item hasSubmenu]) {
            [self formatMenuItemsWithBundleName:[item submenu]];
        }
    }
}

/* -[CXFBHelperDelegate wineAppExited:]  @0x2000036b8
 * Remove o observer e a tarefa; sem tarefas e sem WineLoader ativo, encerra. */
- (void)wineAppExited:(NSNotification *)note {
    id task = [note object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:task];
    [_taskArray removeObject:task];

    if ([_taskArray count] == 0) {
        BOOL wineLoaderActive = (_wineLoader != nil && [_wineLoader socketPath] != nil);
        if (!wineLoaderActive) {
            [NSApp terminate:self];
        }
    }
}

@end

#pragma mark - CXFBHelperApp

/* -[CXFBHelperApp sendEvent:]  @0x200001f96
 * Encaminha o evento ao wineController (host da app Wine) antes do
 * NSApplication; se ele consumir, não repassa; senão, super sendEvent: e depois
 * didSendEvent:. */
@interface CXFBHelperApp : NSApplication
- (id<CXWineController>)wineController;
@end

@implementation CXFBHelperApp

- (id<CXWineController>)wineController {
    return nil; /* preenchido quando o host macdrv está ativo */
}

- (void)sendEvent:(NSEvent *)event {
    id<CXWineController> wc = [self wineController];
    if ([wc handleEvent:event]) {
        return;
    }
    [super sendEvent:event];
    [[self wineController] didSendEvent:event];
}

@end

#pragma mark - main

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSApplication *app = [CXFBHelperApp sharedApplication];
        CXFBHelperDelegate *delegate = [[CXFBHelperDelegate alloc] init];
        [app setDelegate:delegate];
        return NSApplicationMain(argc, argv);
    }
}
