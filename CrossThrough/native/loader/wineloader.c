/*
 * wineloader — reconstrução compilável do carregador do Wine do CrossOver 26.3
 *
 * Alvo: Contents/SharedSupport/CrossOver/bin/wineloader
 *       (Mach-O thin x86_64, SHA-256 ed1318f573bbcd7f153c6fc4c0de66dcf5642b5967e9665991503acb29ea9159)
 *
 * O binário é o "loader" do Wine (equivalente a wine/loader/main.c), adaptado
 * para macOS: em vez de ler /proc/self/exe, usa _NSGetExecutablePath(). A sua
 * ÚNICA função é localizar ntdll.so (a parte Unix do ntdll), carregá-lo com
 * dlopen(), resolver o símbolo __wine_main e saltar para ele. Não há qualquer
 * código de socket ou de passagem de descritores aqui — essa parte vive em
 * ntdll.so/wineserver (ver ../server/wine_server.c).
 *
 * Toda a estrutura abaixo foi reconstruída a partir do pseudocódigo do Hopper
 * (via REA) de EntryPoint (0x100000670) e do helper strmake (sub_100000c00,
 * 0x100000c00). As strings e constantes são lidas diretamente do binário:
 *
 *   0x100000e7e  "__wine_main"
 *   0x100000e8a  "wine: __wine_main function not found in ntdll.so\n"
 *   0x100000ebc  "Virtual memory exhausted.\n"
 *   0x100000edc  "/opt/cxoffice/bin"              (BINDIR de compilação)
 *   0x100000eee  "/opt/cxoffice/lib"              (DLLDIR de compilação)
 *   0x100000f00  "/tools/wine"                    (marcador de árvore de build)
 *   0x100000f0c  "%s/../../dlls/ntdll/ntdll.so"   (candidato na árvore de build)
 *   0x100000f29  "%s/wine%s/ntdll.so"             (candidato no DLLDIR)
 *   0x100000f3c  "WINEDLLPATH"
 *   0x100000f48  "%s%s/ntdll.so"                  (candidato por entrada de WINEDLLPATH)
 *   0x100000f56  "%s/ntdll.so"                    (fallback por entrada de WINEDLLPATH)
 *   0x100000f62  "wine: could not load ntdll.so: %s\n"
 *   0x100000f85  "x86_64"                         (arch de CPU)
 *   0x100000f8c  "/%s-%s"                         (sufixo -> "/x86_64-unix")
 *   0x100000f93  "unix"
 *   0x100000f98  ":"                              (separador de WINEDLLPATH)
 *
 * Imports observados (External Symbols): _NSGetExecutablePath, dlerror, dlopen,
 * dlsym, exit, fprintf, free, fwrite, getenv, malloc, realloc, realpath, strcat,
 * strcmp, strcpy, strlen, strrchr, strtok, vsnprintf. Nada de socket/sendmsg.
 *
 * __wine_main é chamado como (argc, argv) — o pseudocódigo mostra `(rax)(r13, r12)`
 * com r13=argc e r12=argv. O envp é obtido pelo próprio ntdll a partir de
 * `environ`/apple args; mantemos a assinatura upstream de três argumentos e
 * passamos environ como terceiro, o que é compatível com a chamada observada.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <limits.h>
#include <dlfcn.h>
#include <mach-o/dyld.h>   /* _NSGetExecutablePath */

/* environ do processo (usado como envp para __wine_main). */
extern char **environ;

/* Constantes de compilação, exatamente como embutidas no binário. */
#define BINDIR          "/opt/cxoffice/bin"
#define DLLDIR          "/opt/cxoffice/lib"
#define CPU             "x86_64"
#define BUILD_TAIL      "/tools/wine"   /* se a árvore terminar nisto, é build tree */

typedef void (*wine_main_t)(int argc, char *argv[], char *envp[]);

/*
 * strmake — equivalente a sub_100000c00. Formata para um buffer alocado que
 * cresce e tenta de novo até caber; aborta com "Virtual memory exhausted." se
 * malloc/realloc falharem. O original começa com um buffer de 0x64 bytes.
 */
static char *strmake(const char *fmt, ...)
{
    int n;
    size_t size = 100;      /* 0x64 */
    char *buf, *tmp;
    va_list ap;

    if (!(buf = malloc(size)))
    {
        fwrite("Virtual memory exhausted.\n", 1, 26, stderr);
        exit(1);
    }
    for (;;)
    {
        va_start(ap, fmt);
        n = vsnprintf(buf, size, fmt, ap);
        va_end(ap);
        if (n == -1) size *= 2;
        else if ((size_t)n >= size) size = n + 1;
        else return buf;
        free(buf);
        if (!(buf = malloc(size)))
        {
            fwrite("Virtual memory exhausted.\n", 1, 26, stderr);
            exit(1);
        }
        tmp = buf; (void)tmp;
    }
}

/*
 * try_dlopen_and_run — tenta dlopen(path, RTLD_NOW); se abrir, resolve
 * __wine_main e salta. Se abrir mas o símbolo faltar, é erro fatal (igual ao
 * original: a busca não continua depois de um ntdll.so válido ter sido aberto).
 * Devolve apenas em caso de FALHA do dlopen (para o chamador tentar o próximo
 * candidato); caso contrário não retorna.
 */
static void *try_dlopen_and_run(const char *path, int argc, char *argv[])
{
    void *handle = dlopen(path, RTLD_NOW);
    if (handle)
    {
        wine_main_t wine_main = (wine_main_t)dlsym(handle, "__wine_main");
        if (wine_main)
            wine_main(argc, argv, environ);
        fwrite("wine: __wine_main function not found in ntdll.so\n", 1, 49, stderr);
        exit(1);
    }
    return NULL;
}

/* Diretório do executável real (dirname), resolvido via realpath. */
static char *get_bindir(char *argv0)
{
    char buf[PATH_MAX];
    uint32_t size = sizeof(buf);
    char *real = NULL, *slash;

    if (_NSGetExecutablePath(buf, &size) == 0)
        real = realpath(buf, NULL);
    if (!real)
        real = realpath(argv0, NULL);   /* fallback para argv[0] */
    if (!real)
        return NULL;

    slash = strrchr(real, '/');
    if (slash) *slash = '\0';           /* dirname */
    return real;                        /* caller liberta */
}

int main(int argc, char *argv[])
{
    char *bindir = get_bindir(argv[0]);
    const char *dlldir = DLLDIR;
    char *arch_suffix = strmake("/%s-%s", CPU, "unix");   /* "/x86_64-unix" */
    char *path;
    char *dllpath, *dir;

    /*
     * Árvore de build: se o executável está em ".../tools/wine", o ntdll.so
     * está em "<bindir>/../../dlls/ntdll/ntdll.so".
     */
    if (bindir)
    {
        size_t len = strlen(bindir);
        size_t taillen = strlen(BUILD_TAIL);
        if (len >= taillen && strcmp(bindir + len - taillen, BUILD_TAIL) == 0)
        {
            path = strmake("%s/../../dlls/ntdll/ntdll.so", bindir);
            try_dlopen_and_run(path, argc, argv);
            free(path);
            fprintf(stderr, "wine: could not load ntdll.so: %s\n", dlerror());
            exit(1);
        }
    }

    /* Árvore de instalação: "<dlldir>/wine/x86_64-unix/ntdll.so". */
    path = strmake("%s/wine%s/ntdll.so", dlldir, arch_suffix);
    try_dlopen_and_run(path, argc, argv);
    free(path);

    /* WINEDLLPATH: para cada entrada <dir>, tentar
     * "<dir>/x86_64-unix/ntdll.so" e depois "<dir>/ntdll.so". */
    dllpath = getenv("WINEDLLPATH");
    if (!dllpath)
    {
        fprintf(stderr, "wine: could not load ntdll.so: %s\n", dlerror());
        exit(1);
    }
    dllpath = strdup(dllpath);
    for (dir = strtok(dllpath, ":"); dir; dir = strtok(NULL, ":"))
    {
        path = strmake("%s%s/ntdll.so", dir, arch_suffix);
        if (try_dlopen_and_run(path, argc, argv)) { free(path); continue; }
        free(path);
        path = strmake("%s/ntdll.so", dir);
        if (try_dlopen_and_run(path, argc, argv)) { free(path); continue; }
        free(path);
    }

    fprintf(stderr, "wine: could not load ntdll.so: %s\n", dlerror());
    exit(1);
    return 1;
}
