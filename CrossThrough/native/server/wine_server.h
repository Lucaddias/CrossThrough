/*
 * wine_server.h — interface da camada cliente de ligação ao wineserver.
 * Ver wine_server.c para a evidência.
 */
#ifndef WINE_SERVER_H
#define WINE_SERVER_H

#include <stdint.h>

/* Tipos do protocolo do Wine (server_protocol.h). */
typedef uint32_t thread_id_t;   /* client_ptr/thread id */
typedef uint32_t obj_handle_t;  /* handle de objeto do servidor */

/* Liga ao wineserver do config_dir dado (WINEPREFIX). Devolve o fd do socket
 * ou -1. Reutiliza WINESERVERSOCKET quando herdado do processo pai. */
int  server_connect(const char *config_dir);

/* Envia um descritor para o wineserver via SCM_RIGHTS (sendmsg). */
void wine_server_send_fd(int fd);

/* Recebe um descritor do wineserver via SCM_RIGHTS (recvmsg). Devolve o fd
 * recebido (ou -1) e, se handle_out != NULL, o obj_handle associado. */
int  wine_server_recv_fd(obj_handle_t *handle_out);

/* Aborta a ligação quando o wineserver desaparece (EPIPE). */
void server_protocol_error_abort(int code);

#endif /* WINE_SERVER_H */
