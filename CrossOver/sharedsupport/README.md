# `SharedSupport/CrossOver`: camada de ferramentas

`Contents/SharedSupport/CrossOver` guarda o "CrossOver de verdade": as ferramentas de linha de comando em Perl, a biblioteca Python que a GUI usa e o Wine. A GUI em Objective-C (`Contents/MacOS/CrossOver`, descompilada em [`../decompiled`](../decompiled)) quase não toca o Wine diretamente: ela chama classes Python via PyObjC, e essas classes executam os scripts deste diretório.

Esta análise é estática. Nenhum script, `.pyc` ou binário foi executado.

## Conteúdo

| Arquivo | O que tem |
|---|---|
| [`TOOLS.md`](TOOLS.md) | Tabela de `bin/` (tipo, linhas, módulos usados, opções, variáveis de ambiente, ferramentas chamadas) e de `lib/perl/` (pacotes, quem usa quem, subs, exports), mais hashes |
| [`tools.json`](tools.json) | Os mesmos fatos em JSON, um registro por arquivo |
| [`python/INDEX.md`](python/INDEX.md) | Os 50 módulos Python: docstring, classes, funções, imports e quem importa quem |
| [`python/outline/`](python/outline) | Esboço reconstruído de cada módulo a partir do bytecode: imports, atribuições de módulo, classes, assinaturas, docstrings e nomes referenciados por cada função |
| [`python/dis/`](python/dis) | Desmontagem completa do bytecode CPython 3.13 de cada módulo |
| [`python/modules.json`](python/modules.json) | Fatos por módulo (SHA-256, flags do `.pyc`, `co_filename`, contagens) |
| [`.tools/`](.tools) | Scripts que geram tudo acima (`pyc313.py`, `analyze_python.py`, `analyze_tools.py`, `make_index.py`) |

## Layout

```
SharedSupport/CrossOver/
├── CrossOver-Hosted Application/   # 36 entradas; bin/ é um symlink para cá
├── bin -> CrossOver-Hosted Application
├── etc/CrossOver.conf
├── lib/
│   ├── perl/        # 38 módulos CX*.pm + cópias de XML::DOM/SAX (CPAN)
│   ├── python/      # 50 módulos, só .pyc (CPython 3.13)
│   ├── wine/        # i386-windows (845), x86_64-windows (785), x86_64-unix (34)
│   ├── dxvk/  dxmt/ # tradutores Direct3D → Vulkan / Metal
│   └── cxupgrade/
├── lib64/           # 95 dylibs x86_64 (MoltenVK, SDL2, FreeType, GLib, GStreamer…) e apple_gptk/ (D3DMetal)
└── share/           # crossover/, icons/, images/, locale/, wine/
```

O nome `CrossOver-Hosted Application` parece servir para o processo aparecer com esse nome no macOS. `bin` aponta para ele, então os scripts continuam achando tudo em `$CX_ROOT/bin`.

## Arquitetura dos binários

Os 7 Mach-O de `bin/` são **só x86_64**: `wineloader`, `wineserver`, `cxbounce`, `cxgettext`, `cabextract`, `unrar`, `ps2pdf_gs`. O mesmo vale para as 95 dylibs de `lib64/`. `lib/wine/` tem só `x86_64-unix` (não há `aarch64-unix` nem `i386-unix`). Os executáveis de 32 bits do Windows rodam pelo `i386-windows` (PE) sobre o lado Unix de 64 bits.

O launcher `bin/wine` escolhe o diretório de DLLs pela existência de `lib/wine/aarch64-unix/ntdll.so`. O módulo Python `cxproduct` faz o mesmo teste (`lib/wine/aarch64-unix`, `lib/wine/i386-unix`). Como esses arquivos não existem nesta versão, o host é sempre `x86_64`. Em Apple Silicon, então, todo o Wine roda sob Rosetta 2. Isso explica o `-[CXServer rosettaCheck]` que só existe na slice arm64 da GUI ([`../decompiled/x86_64`](../decompiled/x86_64)).

| Binário | `__text` | Dependências | Mínimo / SDK | Evidence REA |
|---|---|---|---|---|
| `wineloader` | 1.742 bytes (só um carregador; `__PAGEZERO` de 4 GiB) | `libSystem` | macOS 10.15 / SDK 15.1 | `ev_fcbd34d1489a652b09b126d289d05c27b5a4afb1295e692de54b77e373d616ab` |
| `wineserver` | 468.915 bytes, 170 imports | `@rpath/libinotify.0.dylib`, `libSystem` | macOS 10.15 / SDK 15.1 | `ev_503ade64bd75c5f1aed81d20c8057951569c3e76a236efe718100af500d70902` |

### Rosetta e AVX: o mesmo recurso nas três camadas

- **GUI**: `-[RunCommandController AVXSelected:]` acrescenta `ROSETTA_ADVERTISE_AVX=0` ao ambiente do comando. `supportsAVX` só retorna `YES` na arm64 com macOS ≥ 15.
- **`bin/wine`**: se a variável não estiver definida, o script a define como `1`. Se ela vier `0` ou vazia, o script a **remove**. O comentário do script explica que o Rosetta trata qualquer valor como "ligado", então desligar exige apagar a variável.
- **Rosetta**: com a variável presente, anuncia AVX ao código x86_64 traduzido.

## Ferramentas Perl de `bin/`

Todas usam `CXLog`, `CXUtils` e `CXOpts` (log, utilitários, parser de opções) e leem `CX_ROOT`. As que trabalham com uma bottle aceitam `--bottle` / `CX_BOTTLE` e `WINEPREFIX`.

| Ferramenta | Linhas | Papel |
|---|---|---|
| `wine` | 1247 | Launcher principal. Monta o ambiente da bottle (`WINEPREFIX`, `WINEDLLPATH`, `WINELOADER`, `WINESERVER`, `WINEDLLOVERRIDES`, `WINEDEBUG`, GStreamer, D3DMetal/`libd3dshared`, `ROSETTA_ADVERTISE_AVX`) e inicia o programa. Os modos de seleção do alvo são `--ux-app` (programa Unix), `--wl-app`/`--wl32-app` (programa Windows via loader), `--cx-app` e `--start*` (por arquivo, MIME, classe ou verbo). Também tem `--wait-children`, `--new-console`, `--dll`, `--winver`. Antes de executar um arquivo não confiável ou um `.exe`, chama `cxavscan` conforme `[CrossOver] AntiVirusScan` (`start`, `untrusted` ou `never`): código 0 continua, 1 (vírus) aborta, 2 (antivírus quebrado) aborta. `cxstart`, `regedit`, `regsvr32` e `autorun` são symlinks para ele |
| `cxbottle` | 1740 | CLI de bottles: criar, apagar, copiar, renomear, restaurar, empacotar (`--tar`, `--cpio`, `--deb`, `--rpm`), marcar como padrão, mudar a descrição e o UUID, `--template`, `--scope` (privada ou gerenciada). Chama `cxmenu` e `cxassoc` para instalar ou remover a integração com o desktop |
| `cxmenu` | 1509 | Sincroniza os atalhos do menu Iniciar da bottle com o sistema hospedeiro (`--sync`, `--install`, `--uninstall`, `--query`, `--mode`, `--menu-root`, `--mmenu-never`). Backends em `CXMenu*.pm`; no macOS é `CXMenuMacOSX` |
| `cxassoc` | 1679 | O mesmo para associações de arquivo e MIME (`--sync`, `--mode`, `--mime`, `--tie`). Backend macOS: `CXAssocMacOSX` |
| `wineshelllink` | 150 | Ponte chamada pelo Wine quando um programa Windows cria um atalho; repassa para `cxmenu` |
| `wineprefixcreate` | 363 | Cria ou atualiza o prefixo da bottle a partir de um diretório de referência (`--snapshot`, `--copy`, `--ref-dir`, via `CXReplicateDir` e `CXUpgrade`) |
| `cxreboot` | 186 | Simula o reinício do Windows dentro da bottle, com aviso via `cxmessage` |
| `cxuninstall` | 445 | Remove o CrossOver e a integração das bottles com o desktop (chama `cxmenu`/`cxassoc`). Avisa que cada usuário precisa rodar o próprio `cxuninstall` antes. Lê `CX_PURGE` e o log do instalador MojoSetup |
| `cxsu` | 410 | Executa um comando como root, com pedido de senha (`--description`, `--ignore-home`, `--wait`). A biblioteca Python o usa para bottles gerenciadas (`--scope managed`) e para instalar pacotes do sistema |
| `cxavscan` | 289 | Passa um arquivo pelo antivírus configurado antes da instalação (`--gui`, `--quiet`) |
| `cxwinassoc` | 291 | Registra classe, extensão ou MIME no registro Windows da bottle |
| `cxnativeopen` | 317 | Abre um arquivo ou URL com o aplicativo nativo do host |
| `cxtemplate` | 228 | Consulta e preenche os templates de bottle (`--template`, `--query`, `--param`) |
| `cxgarcon-terminal` | 292 | Abre um terminal com título e comando definidos |
| `cxlogfilter` | 333 | Filtra e corta logs (`--head`, `--tail`, `--fifo`) |
| `cxmessage` | 96 | Mostra uma caixa de mensagem simples |

Scripts shell: `locate_gui.sh` (descobre o ambiente gráfico e o menu XDG), `cxgetsysinfo` (coleta informações do sistema), `cxselinux` (contextos SELinux), `cxps2pdf`/`ps2pdf*` (impressão: PostScript → PDF via `ps2pdf_gs`).

### Módulos Perl (`lib/perl/`)

- **Base**: `CXLog`, `CXUtils`, `CXOpts`, `CXConfig` (leitura de `.conf`), `CXRWConfig` (leitura e escrita), `CXRecode` (codificação), `CXBottle` (localização e escopo das bottles), `CXUpgrade`, `CXReplicateDir`.
- **Menus**: `CXMenu` (núcleo) e backends `CXMenuMacOSX`, `CXMenuWindows`, `CXMenuXDG`, `CXMenuDebian`, `CXMenuCDE`, `CXMenuDtop`, `CXMenuShortcut`, `CXMenuPerm`, `CXMenuCheck`.
- **Associações**: `CXAssoc` e backends `CXAssocMacOSX`, `CXAssocWindows`, `CXAssocXDG`, `CXAssocDebian`, `CXAssocCDE`, `CXAssocMailcap`, `CXAssocMcap`, `CXAssocCheck`, `CXMimeMcap`.
- **Formatos**: `CXPlist` (plist do macOS), `CXTinySAX*` e `CXXMLDOM` (XML), `CXDebian`/`CXRPM` (empacotamento), `CXCDE`.

Boa parte desse código é compartilhada com o CrossOver Linux (backends XDG, Debian, RPM, CDE, Mailcap; `cxselinux`, `cxgetsysinfo`, `locate_gui.sh`). No Mac, os caminhos usados são os backends `MacOSX` e `Windows`.

## Biblioteca Python (`lib/python/`)

São 50 módulos distribuídos só como `.pyc` CPython 3.13 (hash-based, flags 3), com 1529 code objects e 75.506 instruções. O Python vem embarcado em `Contents/Frameworks/Python.framework` (3.13, com PyObjC). Não há executável `python`: a GUI carrega `libpython3.13.dylib` e inicia o interpretador ela mesma (`_InitializePython`).

Grupos por função:

| Grupo | Módulos |
|---|---|
| Modelo de bottles | `bottlequery` (consulta e manipulação), `bottlewrapper` (`BottleWrapper`, 12 classes: estado observável de uma bottle, incluindo `isD3DMetalAvailable`, `isDXMTAvailable`, `isMoltenVKAvailable`), `bottlecollection`, `bottlemanagement` (criar, copiar, apagar, encerrar) |
| Perfis C4 (banco de aplicativos) | `c4profiles` (26 classes), `c4parser`, `c4profilesmanager`, `fileupdate` (download com verificação de assinatura) |
| Motor de instalação (AIE) | `cxaiengine`, `cxaiebase` (`AIETask`, `AIEScheduler`), `cxaiecore` (prepara o instalador, chama `cxavscan`, monta o comando `wine`, reinicia via `wineboot`), `cxaiemedia`, `cxaiemisc` (roda `cxmenu --sync` / `cxassoc --sync` depois da instalação) |
| Tarefa de instalação da GUI | `installtask` (`InstallTask`, `SourceMedia`, `TargetBottle`, `TargetTemplate`) |
| Detecção | `appdetector` (aplicativos instalados e desinstaladores), `cddetector`, `downloaddetector`, `globtree`, `cxglob` |
| Correções do sistema | `cxfixes`, `cxfixesobjs`, `cxfixesparser`, `cxfixesdialog` (instala pacotes do host via `cxsu`; herança do Linux, usa `gi`) |
| Menus e associações | `cxmenu`, `cxassoc` (wrappers de `bin/cxmenu` e `bin/cxassoc`) |
| Rede | `cxurlget` (escolhe `cxurlget_nsurl`, via `NSURLSession`/PyObjC, ou `cxurlget_urllib`), `proxyinfo` |
| Registro, demo, avaliações | `demoutils` (licença, chama `cxsu` e `cxregister`), `ratingutils`, `webutils`, `iconutils` |
| Diagnóstico e sistema | `cxdiag` (cache do `cxdiag`), `systeminfo`, `cxwhich` |
| Infraestrutura | `cxutils` (inclui `run()`/`system()`, que executam todos os comandos externos), `cxlog`, `cxconfig`, `cxfsnotifier`, `cxobservable`, `cxevent`, `cxproduct`, `distversion`, `iso8601`, `cxopt`, `cxhtmlutils`, `pyop` |
| Ponte Objective-C | `cxobjc` |

### Ponte PyObjC (`cxobjc`)

`cxobjc` define `CXMacObject` (subclasse de `Foundation.NSObject`) e `Proxy`, mais decoradores e descritores (`object_property`, `array_property`, `method`) que publicam atributos Python como propriedades KVO/KVC do Objective-C. O descritor `object_property` aceita `python_name`, `typestr` (por exemplo `cxobjc.BOOL`), `read_only`, `getter` e `depends_on`. Assim o Cocoa Bindings da GUI observa diretamente o estado Python.

As classes publicadas desse jeito (subclasses de `cxobjc.Proxy`) são `BottleWrapper`, `BottleCollection`, `BottleManagement`, `BottleQuery`, `InstallTask`, `AIEScheduler`, `C4Profiles`, `AppDetector`, `InstalledApplication`, `CDDetector`, `CXMenu`, `CXUtils`, `DemoUtils`, `RatingUtils`, `WebUtils`, `IconUtils` e `SystemInfo`.

### Fontes `.py` em `Contents/Resources`

Só dois arquivos vêm como fonte:

- `libcxsetupbase.py` (24 linhas) prepara o ambiente: KVC do PyObjC, depuração do PyObjC quando o log está ligado e despejo das pilhas Python via `NSLog` em `SIGINFO`.
- `libcxsetup.py` (48 linhas) importa os 15 módulos que a GUI usa e define `CXSetup(Foundation.NSObject)` com métodos de classe chamados do Objective-C (`setEnvValue_forKey_`, `unsetEnvValueForKey_`, `bottleCategory_`, `dependencyReason_`, `dependencyOverride_`, `bottleStatus_`).

### Python → ferramentas Perl

As chamadas usam `cxutils.run`/`system` com o caminho `CX_ROOT/bin/<ferramenta>`:

| Ferramenta | Chamada por |
|---|---|
| `wine` | `appdetector` (desinstaladores), `bottlequery` (`cxcplinfo.exe`, `cxmanip`), `bottlemanagement` (`wineserver -k`, `wineboot --end-session --shutdown`), `cxaiecore` (instalador, `wineboot --restart`) |
| `cxbottle` | `bottlemanagement` |
| `cxsu` | `bottlemanagement` (bottles gerenciadas), `cxfixes`, `demoutils` |
| `cxmenu` | `cxmenu`, `cxaiemisc` |
| `cxassoc` | `cxassoc`, `cxaiemisc` |
| `cxavscan` | `cxaiecore` |
| `wineserver` | `bottlemanagement`, `cxaiecore` (via `wine --ux-app`) |
| `cxdiag` | `cxdiag` |

## Método

1. **Inventário** (`analyze_tools.py`): percorre `bin/` e `lib/perl/` e classifica cada arquivo pelo cabeçalho (Mach-O, `#!` perl ou sh, `.pm`, symlink). Para Perl, extrai os pacotes (respeitando blocos `{ package X; … }`), `use`/`require`, subs, `@EXPORT`, `$ENV{…}`, as opções declaradas em `add_options` e os caminhos `{CX_ROOT}/bin/…` usados (ignorando os que só aparecem em testes `-x`/`-f`).
2. **Bytecode Python** (`pyc313.py`): leitor próprio do formato marshal do CPython 3.13 e do cabeçalho `.pyc`. Ele não usa o `marshal` do Python local, porque o 3.14 tem outro formato de code object. A tabela de opcodes (150 entradas) é reconstruída a partir do `_opcode_metadata.pyc` **embarcado no próprio CrossOver**, então os nomes batem com o interpretador que roda os módulos. O desmontador trata caches inline, `EXTENDED_ARG`, tabela de exceções e tabela de linhas. O esboço vem de uma pilha simbólica sobre o bytecode de nível de módulo e de classe.
3. **Fontes `.py`**: lidas com `ast`, só para estrutura.
4. **Binários**: `inspect_macho` do REA em `wineloader` e `wineserver` (Evidence acima). As arquiteturas de todos os Mach-O vêm do cabeçalho fat ou thin.

Para regenerar (o `ast` precisa de Python ≥ 3.13; a leitura do `.pyc` independe da versão local):

```bash
python3 -I .tools/analyze_python.py /Applications/CrossOver.app python && python3 -I .tools/analyze_tools.py /Applications/CrossOver.app . && python3 -I .tools/make_index.py .
```

## Limites

- **O corpo das funções Python não foi descompilado.** O esboço traz assinaturas, docstrings, atribuições de módulo e de classe e os nomes, atributos e strings que cada função usa. A lógica completa está só na desmontagem em `python/dis/`.
- O esboço é reconstruído de forma linear. Expressões condicionais no nível de módulo podem sair simplificadas. Em `c4profiles.py`, 3 trechos ficaram marcados como `# <unparsed …>`.
- Linhas do esboço que parecem código dentro de docstrings (por exemplo, exemplos de uso em `cxobjc`) são texto da docstring.
- Os fatos de Perl vêm de expressões regulares sobre o texto, não de um parser Perl. Chamadas com caminho montado dinamicamente podem faltar em "Chama".
- `XML::*` são cópias de módulos CPAN. Só o inventário e os hashes foram registrados.
- Nada foi executado. Comportamento em tempo de execução (o que de fato roda, em que ordem) é inferência a partir do código.
