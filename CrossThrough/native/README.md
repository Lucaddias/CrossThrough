# Reconstrução nativa do backend do Wine (CrossOver 26.3)

Este diretório reconstrói, de forma compilável, os dois componentes nativos que
faltavam na análise: o **carregador do Wine** (`wineloader`) e a **camada
cliente de socket + passagem de descritores** do `wineserver`. Tudo vem de
análise estática dos binários enviados (REA + Hopper) e das strings/símbolos
lidos diretamente deles. Onde a reconstrução vai além do que o binário mostra, o
código diz `(inferência)`.

## Sobre a descrição do item

O ponto pendente dizia "Menu Helper (o `WineLoader`: socket com passagem de fd e
`__wine_main` via `dlopen`)". A análise mostra que isso juntava **dois** níveis
distintos:

1. **`wineloader`** (`bin/wineloader`, thin x86_64) faz **só** `dlopen` do
   `ntdll.so` + `__wine_main`. Não tem socket nenhum — os seus imports são
   apenas `dlopen/dlsym/dlerror`, `_NSGetExecutablePath`, `realpath`, `getenv`,
   `strtok` e companhia. Nenhum `socket`/`sendmsg`/`recvmsg`.
2. A **passagem de fd por socket** é do `ntdll.so` (lado Unix) e do
   `wineserver`, dentro/depois de `__wine_main`, não do loader.

Os "Menu Helper.app" (secção 4 do `ARCHITECTURE.md`) acabam por lançar
`bin/wine` → `wineloader` para correr o programa Windows; por isso o loader é o
ponto de entrada nativo que o helper invoca. Reconstruímos os dois níveis.

## `loader/wineloader.c`

Reconstrução de `bin/wineloader`
(SHA-256 `ed1318f573bbcd7f153c6fc4c0de66dcf5642b5967e9665991503acb29ea9159`).

Equivalente ao `wine/loader/main.c` upstream, adaptado a macOS
(`_NSGetExecutablePath` em vez de `/proc/self/exe`). Fluxo, reconstruído do
pseudocódigo de `EntryPoint` (0x100000670) e do helper `strmake`
(sub_100000c00, 0x100000c00):

1. Resolve o caminho real do executável; deriva o `bindir` (dirname).
2. Monta o sufixo de arquitetura `"/x86_64-unix"` (`strmake("/%s-%s","x86_64","unix")`).
3. Escolhe o `ntdll.so`:
   - árvore de build (bindir termina em `/tools/wine`) → `<bindir>/../../dlls/ntdll/ntdll.so`;
   - árvore de instalação → `<dlldir>/wine/x86_64-unix/ntdll.so` (`dlldir` = `/opt/cxoffice/lib`);
   - entradas de `WINEDLLPATH` → `<dir>/x86_64-unix/ntdll.so` e `<dir>/ntdll.so`.
4. `dlopen(path, RTLD_NOW)`; no primeiro que abrir, `dlsym("__wine_main")` e salta
   `__wine_main(argc, argv, environ)`.
5. Erros exatamente como no binário:
   - `"wine: __wine_main function not found in ntdll.so\n"` (símbolo ausente);
   - `"wine: could not load ntdll.so: %s\n"` com `dlerror()` (nenhum candidato abriu);
   - `"Virtual memory exhausted.\n"` em falha de `malloc`.

Todas as strings e constantes (`/opt/cxoffice/{bin,lib}`, `/tools/wine`, formatos
de caminho) são as lidas do binário — ver o cabeçalho do `.c` para os endereços.

## `server/wine_server.c` + `wine_server.h`

Camada **cliente** de ligação ao `wineserver`: socket de domínio Unix e passagem
de descritores por `SCM_RIGHTS`. Baseada em:

- `ntdll.so` (SHA-256 `ab32585d767ae631154235861a2e0e8ea61bd09267a2dd341a439e3e8ed071fc`)
  exporta `wine_server_call` (0x31ae0), `wine_server_send_fd` (0x32e80) e
  `wine_server_fd_to_handle` (0x33610).
- Pseudocódigo de `wine_server_send_fd` (REA `ev_401d3be1…`): `sendmsg(fd_socket,
  &msg, 0)` à espera de retorno 8 (= `sizeof(struct send_fd)`), com o fd real em
  `SCM_RIGHTS`; `EINTR` repete, `EPIPE` aborta, senão `perror("sendmsg")`. A
  string `"partial write %d\n"` cobre o envio parcial.
- Strings de `ntdll.so`/`wineserver`: `"WINESERVERSOCKET=%u"`, `"/tmp/.wine-%u"`,
  `"socket"`, `"lock"`, `"socket path %s is too long for sockaddr_un"`,
  `"Protocol error: process %04x: partial recvmsg %d for fd"`, e o protocolo
  alt-loader do CrossOver (`CX_ALT_LOADER_SOCKET`, `"wineserversocket %d stdin_fd
  %d stdout_fd %d unixdir %s winedebug %s"`).

Funções:

| Função | Papel |
|---|---|
| `server_connect(config_dir)` | Reutiliza `WINESERVERSOCKET` se herdado; senão cria socket Unix close-on-exec e faz `connect()` a `/tmp/.wine-<uid>/server-<dev>-<ino>` |
| `wine_server_send_fd(fd)` | Envia um fd por `SCM_RIGHTS` (reconstrução direta de 0x32e80) |
| `wine_server_recv_fd(&handle)` | Recebe um fd por `SCM_RIGHTS` (simétrico; protocolo documentado) |
| `server_protocol_error_abort(code)` | Fim de ligação quando o servidor morre (EPIPE) |

O caminho do socket (`server-<dev>-<ino>`) e o esquema de recepção seguem o
protocolo documentado do Wine (`dlls/ntdll/unix/server.c`); marcados como
`(inferência)` no código onde não vêm diretamente do binário.

## Compilar e verificar

```bash
cd native
make all      # build/wineloader (x86_64) + build/server-demo (nativo)
make check    # corre o self-test de passagem de fd via SCM_RIGHTS
```

`make check` cria um `socketpair`, envia um descritor de um processo para outro
com `wine_server_send_fd`/`wine_server_recv_fd` e confirma a receção — exercita a
passagem de fd sem precisar de um `wineserver` real. O `wineloader` é gerado
como Mach-O x86_64 (igual ao alvo); em Apple Silicon corre sob Rosetta 2.

## Limites

- O corpo de `__wine_main` (dentro do `ntdll.so`) e a máquina de estados completa
  do `wineserver` não são reconstruídos aqui — só a fronteira que o item pedia:
  carregamento do `ntdll.so` e a primitiva de socket + passagem de fd.
- `wine_server_recv_fd` e o `spawn`/retry do `wineserver` seguem o protocolo
  documentado; o corpo exato dessas rotinas no `ntdll.so` não foi decompilado.
- `thread_id_t` usa o pid como aproximação; no `ntdll.so` real vem do TEB.
