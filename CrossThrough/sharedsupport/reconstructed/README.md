# `sharedsupport/reconstructed`: componentes nativos da CodeWeavers

Reconstrução dos binários nativos próprios da CodeWeavers no backend — os que
antes estavam só descritos por inferência em [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md).
O Wine, as dylibs de `lib64`, o Python (`.pyc` em [`../python`](../python)) e as
ferramentas Perl (texto, em [`../TOOLS.md`](../TOOLS.md)) não entram aqui.

Método: decompilação estática com **Ghidra 12.1.4 headless** pelo REA
(`rea decompile --provider ghidra`). O comportamento descrito foi lido do
pseudocódigo, não inferido. Nada foi executado.

| Arquivo | Alvo | Estado |
|---|---|---|
| [`cxbounce.c`](cxbounce.c) | `bin/cxbounce` (x86_64) | Reconstrução **compilável** (C) |
| [`BottleHelper.m`](BottleHelper.m) | `Bottle Helper.cpbz2` → `.app` (universal) | Reconstrução **compilável** (ObjC/ARC) |
| [`MenuHelper.decompiled.c`](MenuHelper.decompiled.c) | `Menu Helper.cpbz2` → `.app` (x86_64) | Pseudocódigo bruto + espec. abaixo |

## cxbounce

Helper setuid do caminho de bottles gerenciadas. `setuid(0)` e `execv` da
ferramenta irmã (`dirname(argv[0])/argv[1]`) com UID real 0. Detalhes no cabeçalho
de [`cxbounce.c`](cxbounce.c).

## Bottle Helper

App `.app` por bottle. Ao ser aberto (clique, documento ou URL), relança o
CrossOver (bundle id `com.codeweavers.CrossOver`, esquema
`com.codeweavers.private-CrossOver-app-scheme`) passando a si mesmo ou os itens
recebidos como documento, com um `NSAppleEventDescriptor` carregando o nome
(`BtNm`) e a tag (`BtTg`, sem o último char) da bottle, lidos do próprio
`Info.plist` (`CXHelperAppBottleName`/`Tag`). Encerra-se 2 s depois. A categoria
`NSWorkspace(CrossOverAdditions)` resolve o app por bundle id (processo em
execução) ou por esquema de URL (melhor `CFBundleVersion`, desempate por data) e
lança via `LSOpenFromURLSpec`. Reconstrução fiel e compilável em
[`BottleHelper.m`](BottleHelper.m).

## Menu Helper

App `.app` por programa. Diferente do Bottle Helper: **ele mesmo** roda o
programa Windows via Wine, em vez de delegar ao CrossOver.

- `CXFBHelperDelegate applicationWillFinishLaunching:` — registra o handler
  `GURL`; guarda `bottleName`/tag do `Info.plist`; monta o descritor `BtNm`/`BtTg`;
  resolve `cxmenuPath`/`cxstartPath`/`menuPath`.
- `applicationOpenUntitledFile:` — roda `cxmenu --bottle <nome> --wait-children
  --enable-alt-loader macdrv --start <menuPath>` como tarefa Wine; `launch`;
  guarda em `taskArray`.
- `handleGetURLEvent:withReplyEvent:` — roda `cxstart --bottle <nome>
  --enable-alt-loader macdrv -- <url>`.
- `application:openFiles:` — separa os arquivos pelas extensões de
  `CFBundleDocumentTypes` e monta os argumentos do `cxmenu` para eles.
- `createWineTaskWithLaunchPath:andArguments:` — pega o ambiente de
  `helperServerProxy getEnvironmentForXConnection`, define
  `CX_LAUNCHER_BUNDLE_NAME = CFBundleName`; se a preferência
  `DisableWineIntegration` não estiver ligada, cria sob demanda um `WineLoader`;
  devolve um `CXTask` com o caminho e os argumentos.
- `CXFBHelperApp sendEvent:` — encaminha o evento ao `wineController handleEvent:`
  antes do `NSApplication sendEvent:`, depois `didSendEvent:` (hospeda a app Wine).
- `wineAppExited:` — remove o observer e a tarefa; sem tarefas e sem WineLoader,
  encerra.

### `WineLoader` / `WineLoaderClientConnection`

Conexão X do Wine embarcada na app nativa (loader `macdrv`):

- `initWithCrossOverRoot:` — cria um socket `AF_UNIX`, `FD_CLOEXEC`, faz `bind`
  num caminho `tmpnam()` e escuta via dispatch source; `socketPath` devolve o
  caminho (passado ao Wine).
- `shouldConnectionProceedWithRequest:` — cancela o dispatch source, remove o
  observer, dá `unlink` no socket e abre uma atividade `NSProcessInfo`
  "Running Windows program" (evita App Nap) quando o app ainda não está ativo.
- `WineLoaderClientConnection handleConnection` — protocolo binário
  length-prefixed sobre o socket, com `recvmsg`/`msghdr` e mensagens de controle
  (passagem de descritores). `readLengthPrefixedBuffer:` lê 8 bytes de tamanho e
  depois o buffer.

Pseudocódigo bruto dos 12 métodos centrais em
[`MenuHelper.decompiled.c`](MenuHelper.decompiled.c).

**Pendente:** a reconstrução compilável do Menu Helper (sobretudo o `WineLoader`:
socket com passagem de fd e o caminho `__wine_main` via `dlopen`) é um esforço
maior e ainda não foi feita. O `CXTask`/`CXTaskSpecialString` já existem na GUI
([`../../src/classes`](../../src/classes)) e podem ser reaproveitados no caminho
de lançamento por `cxmenu`/`cxstart`.
