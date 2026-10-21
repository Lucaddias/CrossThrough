/*
 * wine_server.c — reconstrução compilável da camada cliente de ligação ao
 * wineserver do CrossOver 26.3: socket de domínio Unix + passagem de
 * descritores (fd passing) via SCM_RIGHTS.
 *
 * Esta é a parte que a descrição do item juntava ao "wineloader": o loader em
 * si (../loader/wineloader.c) NÃO fala com socket nenhum — ele só faz dlopen do
 * ntdll.so e salta para __wine_main. É o ntdll.so (lado Unix) que, dentro de
 * __wine_main, abre o socket do wineserver e passa descritores. Este ficheiro
 * reconstrói esse lado cliente.
 *
 * EVIDÊNCIA (lida dos binários enviados):
 *
 *  lib/wine/x86_64-unix/ntdll.so
 *   (SHA-256 ab32585d767ae631154235861a2e0e8ea61bd09267a2dd341a439e3e8ed071fc):
 *   - exporta wine_server_call (0x31ae0), wine_server_send_fd (0x32e80),
 *     wine_server_fd_to_handle (0x33610).
 *   - wine_server_send_fd (pseudocódigo Hopper/REA, ev_401d3be1...): monta um
 *     msghdr na pilha e faz `sendmsg(fd_socket, &msg, 0)`, esperando retorno 8
 *     (= sizeof(struct send_fd)); em EINTR (errno 4) repete; em EPIPE (errno
 *     0x20) chona server_protocol_perror/abort; caso contrário "sendmsg".
 *     A string "partial write %d\n" confirma o envio parcial.
 *   - strings: "WINESERVERSOCKET=%u", "WINESERVER", "could not exec wineserver",
 *     "server/wineserver", "Bad server socket %d", "version mismatch %d/%d.",
 *     "Too many open files, ulimit -n probably needs to be increased".
 *
 *  bin/wineserver
 *   - strings: "/tmp/.wine-%u", "socket", "lock", "bind: %s", "listen: %s",
 *     "cannot stat config dir", "Protocol error: process %04x: partial sendmsg
 *     %d", "Protocol error: process %04x: partial recvmsg %d for fd",
 *     "couldn't bind to the socket even though we hold the lock".
 *
 *  Protocolo CrossOver (alt-loader), strings em ntdll.so:
 *   - "CX_ALT_LOADER_SOCKET", "CX_ALT_LOADER_SOCKET is not set; nothing to do",
 *     "wineserversocket %d stdin_fd %d stdout_fd %d unixdir %s winedebug %s".
 *
 * O caminho do socket e o esquema de passagem de fd seguem o protocolo
 * documentado do Wine (server/request.c, dlls/ntdll/unix/server.c); onde a
 * reconstrução vai além do que o binário mostra diretamente, está marcado
 * como (inferência).
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/un.h>
#ifdef WINE_SERVER_DEMO
#include <sys/wait.h>
#endif

#include "wine_server.h"

/* Diretório base dos servidores por utilizador: "/tmp/.wine-<uid>".
 * (string "/tmp/.wine-%u" presente tanto em ntdll.so como em wineserver.) */
#define SERVER_DIR_FMT   "/tmp/.wine-%u"
/* Nome do socket dentro do config dir, codificando dev/ino do config dir.
 * O wineserver cria "server-<dev>-<ino>" no diretório por utilizador. */
#define SOCKET_NAME_FMT  "server-%llx-%llx"

/* fd global do socket do wineserver (equivalente ao fd_socket do ntdll.so). */
static int fd_socket = -1;

/*
 * struct send_fd — payload de 8 bytes enviado por wine_server_send_fd.
 * O retorno esperado do sendmsg é exatamente 8 (confirmado no pseudocódigo:
 * `if (rax == 0x8)`), e o descritor real viaja em SCM_RIGHTS fora deste corpo.
 */
struct send_fd
{
    thread_id_t tid;   /* thread que envia */
    int         fd;    /* número do fd DO LADO DO SERVIDOR (meramente informativo) */
};

static thread_id_t current_tid(void)
{
    /* No ntdll.so real vem de NtCurrentTeb()->ClientId; aqui usamos o pid como
     * aproximação compilável. (inferência) */
    return (thread_id_t)getpid();
}

/*
 * server_dir — monta "/tmp/.wine-<uid>" no buffer dado.
 */
static void server_dir(char *buf, size_t len)
{
    snprintf(buf, len, SERVER_DIR_FMT, (unsigned)getuid());
}

/*
 * build_socket_addr — monta sockaddr_un para
 * "/tmp/.wine-<uid>/server-<dev>-<ino>", onde dev/ino identificam o config dir
 * da bottle (WINEPREFIX). Devolve 0 em sucesso, -1 em erro.
 *
 * ntdll.so e wineserver imprimem "socket path %s is too long for sockaddr_un"
 * quando o caminho não cabe — replicamos essa verificação.
 */
static int build_socket_addr(const char *config_dir, struct sockaddr_un *addr)
{
    struct stat st;
    char dir[128];
    int n;

    if (stat(config_dir, &st) == -1)
    {
        fprintf(stderr, "cannot stat config dir\n");
        return -1;
    }
    server_dir(dir, sizeof(dir));

    memset(addr, 0, sizeof(*addr));
    addr->sun_family = AF_UNIX;
    n = snprintf(addr->sun_path, sizeof(addr->sun_path),
                 "%s/" SOCKET_NAME_FMT, dir,
                 (unsigned long long)st.st_dev,
                 (unsigned long long)st.st_ino);
    if (n < 0 || (size_t)n >= sizeof(addr->sun_path))
    {
        fprintf(stderr, "socket path is too long for sockaddr_un\n");
        return -1;
    }
    return 0;
}

/*
 * server_connect — liga ao socket do wineserver para o config_dir dado.
 *
 * 1. Se WINESERVERSOCKET estiver no ambiente, o fd já foi herdado do processo
 *    pai (o wineserver/cliente inicial passou-o). É o caso rápido: a ligação
 *    já existe. (string "WINESERVERSOCKET=%u" em ntdll.so)
 * 2. Caso contrário, cria um socket Unix, marca-o close-on-exec e faz connect()
 *    ao caminho "/tmp/.wine-<uid>/server-<dev>-<ino>".
 *
 * Devolve o fd do socket, ou -1 em erro. (No ntdll.so real, uma falha de
 * connect dispara o fork/exec do wineserver — ver spawn_server, abaixo esboçado.)
 */
int server_connect(const char *config_dir)
{
    struct sockaddr_un addr;
    const char *inherited;
    int s;

    inherited = getenv("WINESERVERSOCKET");
    if (inherited)
    {
        fd_socket = atoi(inherited);
        /* marca close-on-exec; "failed to set socket close-on-exec" é avisado
         * mas não fatal no original. */
        fcntl(fd_socket, F_SETFD, FD_CLOEXEC);
        return fd_socket;
    }

    if (build_socket_addr(config_dir, &addr) == -1)
        return -1;

    if ((s = socket(AF_UNIX, SOCK_STREAM, 0)) == -1)
    {
        fprintf(stderr, "failed to create socket; errno %d\n", errno);
        return -1;
    }
    fcntl(s, F_SETFD, FD_CLOEXEC);

    if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) == -1)
    {
        /* "a wine server seems to be running, but I cannot connect to it." →
         * aqui o ntdll real faz spawn_server()+retry. (inferência) */
        close(s);
        return -1;
    }
    fd_socket = s;
    return s;
}

/*
 * wine_server_send_fd — envia um descritor para o wineserver via SCM_RIGHTS.
 * Reconstrução direta do pseudocódigo de 0x32e80 em ntdll.so.
 */
void wine_server_send_fd(int fd)
{
    struct send_fd data;
    struct msghdr msghdr;
    struct iovec vec;
    union {
        struct cmsghdr cmsghdr;
        char buf[CMSG_SPACE(sizeof(int))];
    } cmsg;
    struct cmsghdr *cm;
    ssize_t ret;

    data.tid = current_tid();
    data.fd  = fd;

    vec.iov_base = &data;
    vec.iov_len  = sizeof(data);          /* 8 bytes */

    memset(&cmsg, 0, sizeof(cmsg));
    msghdr.msg_name       = NULL;
    msghdr.msg_namelen    = 0;
    msghdr.msg_iov        = &vec;
    msghdr.msg_iovlen     = 1;
    msghdr.msg_control    = &cmsg;
    msghdr.msg_controllen = sizeof(cmsg);
    msghdr.msg_flags      = 0;

    cm = CMSG_FIRSTHDR(&msghdr);
    cm->cmsg_len   = CMSG_LEN(sizeof(int));
    cm->cmsg_level = SOL_SOCKET;
    cm->cmsg_type  = SCM_RIGHTS;
    *(int *)CMSG_DATA(cm) = fd;           /* o descritor real viaja aqui */

    for (;;)
    {
        ret = sendmsg(fd_socket, &msghdr, 0);
        if (ret == sizeof(data)) return;          /* `if (rax == 0x8)` */
        if (ret >= 0)
        {
            fprintf(stderr, "partial write %d\n", (int)ret);
            return;
        }
        if (errno == EINTR) continue;             /* errno 4 -> repete */
        if (errno == EPIPE)                        /* errno 0x20 -> servidor morreu */
        {
            server_protocol_error_abort(0);
            return;
        }
        perror("sendmsg");
        return;
    }
}

/*
 * wine_server_recv_fd — recebe um descritor do wineserver via SCM_RIGHTS.
 * Simétrico do envio; o wineserver imprime "partial recvmsg %d for fd" no caso
 * parcial. (protocolo documentado; o corpo exato do ntdll não foi decompilado)
 */
int wine_server_recv_fd(obj_handle_t *handle_out)
{
    struct msghdr msghdr;
    struct iovec vec;
    obj_handle_t data = 0;
    union {
        struct cmsghdr cmsghdr;
        char buf[CMSG_SPACE(sizeof(int))];
    } cmsg;
    struct cmsghdr *cm;
    ssize_t ret;
    int fd = -1;

    vec.iov_base = &data;
    vec.iov_len  = sizeof(data);

    memset(&cmsg, 0, sizeof(cmsg));
    msghdr.msg_name       = NULL;
    msghdr.msg_namelen    = 0;
    msghdr.msg_iov        = &vec;
    msghdr.msg_iovlen     = 1;
    msghdr.msg_control    = &cmsg;
    msghdr.msg_controllen = sizeof(cmsg);
    msghdr.msg_flags      = 0;

    for (;;)
    {
        ret = recvmsg(fd_socket, &msghdr, 0);
        if (ret >= 0) break;
        if (errno == EINTR) continue;
        if (errno == EPIPE) { server_protocol_error_abort(0); return -1; }
        perror("recvmsg");
        return -1;
    }

    for (cm = CMSG_FIRSTHDR(&msghdr); cm; cm = CMSG_NXTHDR(&msghdr, cm))
    {
        if (cm->cmsg_level == SOL_SOCKET && cm->cmsg_type == SCM_RIGHTS)
            fd = *(int *)CMSG_DATA(cm);
    }
    if (handle_out) *handle_out = data;
    return fd;
}

/*
 * server_protocol_error_abort — equivalente a sub_5a830(0) chamado em EPIPE.
 * No ntdll real termina o processo quando o wineserver desaparece.
 */
void server_protocol_error_abort(int code)
{
    fprintf(stderr, "wine client error: server connection lost\n");
    exit(code ? code : 1);
}

#ifdef WINE_SERVER_DEMO
/*
 * Auto-verificação compilável: cria um socketpair, finge que um lado é o
 * wineserver, envia um fd por SCM_RIGHTS e confirma que o outro lado o recebe.
 * Exercita wine_server_send_fd/recv_fd sem precisar de um wineserver real.
 */
int main(void)
{
    int sv[2];
    int payload_fd, got;
    char tmpl[] = "/tmp/wsdemoXXXXXX";
    obj_handle_t h = 0;

    if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) == -1) { perror("socketpair"); return 1; }
    payload_fd = mkstemp(tmpl);
    if (payload_fd == -1) { perror("mkstemp"); return 1; }
    unlink(tmpl);

    if (fork() == 0)
    {
        /* filho: papel de "wineserver", recebe o fd */
        fd_socket = sv[1];
        close(sv[0]);
        got = wine_server_recv_fd(&h);
        _exit(got >= 0 ? 0 : 2);
    }
    /* pai: papel de cliente, envia o fd */
    fd_socket = sv[0];
    close(sv[1]);
    wine_server_send_fd(payload_fd);

    int status = 0; wait(&status);
    if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
    {
        printf("wine_server fd-passing OK (fd enviado via SCM_RIGHTS)\n");
        return 0;
    }
    fprintf(stderr, "demo falhou\n");
    return 1;
}
#endif
