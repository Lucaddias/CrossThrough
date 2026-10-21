# CrossThrough

Engenharia reversa do CrossOver 26.3 para macOS (CodeWeavers). Os nomes que vêm do app, como classes, caminhos e binários, continuam `CrossOver`.

## Alvo

| Campo | Valor |
|---|---|
| App | `/Applications/CrossOver.app` |
| Versão | 26.3 |
| Binário | `Contents/MacOS/CrossOver` (Mach-O universal: arm64 + x86_64) |
| SHA-256 | `1d245f2f9f52bd56a120616fede8b1eb9cca9fa228319de04a2cbeabd8de7174` |
| Slice analisada | arm64 |
| Ferramentas | REA (MCP) + Hopper Disassembler + objdump (via REA) |

## Progresso

| Etapa | Estado |
|---|---|
| Inventário do bundle (frameworks, libs) | ✅ |
| Índice de procedures (10.627) | ✅ [`INDEX.md`](CrossThrough/decompiled/INDEX.md) |
| Mapa de classes ObjC (94 classes) | ✅ [`objc_methods.json`](CrossThrough/decompiled/objc_methods.json) |
| Descompilação de todos os métodos ObjC (2.108/2.108, 0 erros) | ✅ [`classes/`](CrossThrough/decompiled/classes) |
| Funções C, callbacks e blocos ObjC em `__TEXT,__text` (186/186, 100% de `__text`) | ✅ [`c_functions.c`](CrossThrough/decompiled/c_functions.c) + [`classes/`](CrossThrough/decompiled/classes) |
| Comparação e mapeamento da slice x86_64 (2287/2288 funções pareadas, 6 com referências diferentes) | ✅ [`x86_64/`](CrossThrough/decompiled/x86_64) |
| Scripts Python/Perl em `SharedSupport/CrossOver` (36 entradas de `bin/`, 16 scripts e 66 módulos Perl, 50 módulos Python 3.13 desmontados) | ✅ [`sharedsupport/`](CrossThrough/sharedsupport) |
| Código compilável (Headers, Shims, 94 classes, funções C, Makefile) | ✅ [`src/`](CrossThrough/src) |
| Documentação da arquitetura (GUI ↔ backend: inicialização do Python, ponte PyObjC, processos, privilégios, helper apps) | ✅ [`ARCHITECTURE.md`](CrossThrough/ARCHITECTURE.md) |
| Implementação da GUI (Partes 1–5): 0 métodos com `Decompiled from CrossOver 26.3:`, build sem warnings, telas Home e detalhe do pacote conferidas com o original, download do instalador funcionando | ✅ [`src/classes/`](CrossThrough/src/classes) |
| Testes (`test_wizard`: wizard, motor de instalação e backend; `test_misc`: formatters, categorias de Foundation, ordenação de launchers, presets de log e nibs com outlets conectados) | ✅ [`tests/`](CrossThrough/tests) |

## Arquitetura (resumo)

Detalhes em [`ARCHITECTURE.md`](CrossThrough/ARCHITECTURE.md).

- **GUI nativa em Objective-C/Cocoa.** As classes principais são `MainWindowController`, `BottleViewController`, `PackageViewController` e `PackageInstaller`.
- **`CXServerCrossOver`** (~13,9 mil linhas de pseudocódigo) é a maior classe. Gera os apps "helper" do macOS por bottle (`CrossOverHelper*`, `CFBundleDocumentTypes`, associações de extensão/URL como `steam`, `mailto`) e os menus a partir dos dados da bottle (`%WINEPREFIX%`, `--bottle %@`).
- **Python 3.13 embutido** (`Contents/Frameworks/Python.framework`). A lógica de bottles e instalação fica em `SharedSupport/CrossOver/{bin,lib,share}`: a GUI usa classes Python via PyObjC (`cxobjc.Proxy`), que chamam as ferramentas Perl (`wine`, `cxbottle`, `cxmenu`, `cxassoc`, `cxsu`). Detalhes em [`sharedsupport/`](CrossThrough/sharedsupport).
- **Wine só x86_64.** `wineloader`, `wineserver` e as dylibs de `lib64/` não têm slice arm64; no Apple Silicon o Wine roda sob Rosetta 2.
- **Sparkle 2.4.1** cuida das atualizações (`CXUpdater`, `CXSparkleUserDriver`).
- **CrossTie** (`CrossTieURLHandler`, `LoadingCrossTieSheetController`) é o formato de receitas de instalação.

## Estrutura

```
CrossThrough/
├── Makefile                # compilação completa via Clang e empacotamento .app
├── src/                    # código-fonte compilável
│   ├── Headers/            # 88 headers de classes e 6 de categorias extraídos do Mach-O
│   ├── include/            # CrossThrough.h, shims (Sparkle, Python, HopperCompat, c_functions.h)
│   ├── classes/*.m         # implementações Objective-C das 94 classes e categorias
│   ├── c_functions.m       # funções C e callbacks standalone
│   └── main.m              # ponto de entrada da aplicação (NSApplicationMain)
├── tests/                  # test_wizard, test_misc, snapshot_ui (capturas) e download_probe
├── ARCHITECTURE.md         # como a GUI, o Python, o Perl e o Wine se ligam
├── reproduce.sh            # regenera e confere x86_64/ e sharedsupport/
├── decompiled/             # pseudocódigo bruto do Hopper via REA
│   ├── INDEX.md            # todas as procedures por classe, com endereço
│   ├── objc_methods.json   # classe -> [(endereço, seletor)]
│   ├── classes/*.m         # pseudocódigo por classe (Hopper)
│   ├── c_functions.c       # funções C e blocos fora das classes
│   ├── x86_64/             # mapa arm64 ↔ x86_64 e diferenças entre as slices
│   └── .ingest.py          # converte a saída do REA batch_decompile em classes/*.m
└── sharedsupport/          # ferramentas Perl e biblioteca Python
    ├── README.md           # ferramentas Perl, biblioteca Python, Wine e como se ligam
    ├── TOOLS.md            # inventário de bin/ e lib/perl/ (tools.json)
    ├── python/             # INDEX.md, BRIDGE.md, outline/*.py, dis/*.dis, modules.json
    └── .tools/             # leitor de .pyc 3.13 e geradores dos índices
```

## Como compilar

Para compilar todo o código Objective-C em um binário nativo arm64 do macOS:

```bash
cd CrossThrough
make -j8
```

O binário final é gerado em `build/CrossThrough`. Para empacotar o bundle completo da aplicação (`CrossThrough.app` com `Info.plist` e recursos):

```bash
make app
```

O build segue o original: macOS 11.0 como mínimo e SDK 15.1 como SDK de link, porque o AppKit escolhe o estilo dos controles e da barra de título pela versão do SDK linkado.

Testes e ferramentas de verificação (todos rodam dentro do bundle, para achar nibs e a ponte Python):

```bash
make test        # test_wizard + test_misc
```

```bash
make snapshot    # build/snapshots/home.png e detail.png (SNAPSHOT_PACKAGE=Steam por padrão)
```

```bash
make probe       # tarefas do motor de instalação de PROBE_PACKAGE; PROBE_ARGS=--download baixa a primeira
```

`snapshot_ui <dir> <pacote> install` também aperta Install, captura o progresso do download e cancela. Rode esse modo com `CX_BOTTLE_PATH` e `CX_MANAGED_BOTTLE_PATH` apontando para uma pasta temporária, porque ele cria a bottle de verdade. Nenhum teste executa fluxos que pedem privilégios de administrador (publicar bottles, registro para todos os usuários, atualização de bottles gerenciadas).

## Instalar em /Applications

```bash
make install
```

Copia o bundle para `/Applications/CrossThrough.app` sem as ferramentas de teste, assina ad hoc e registra no LaunchServices. A cópia instalada não declara os tipos de documento, os esquemas de URL nem os tipos exportados do CrossOver, então `.exe`, `.c4p` e links CrossTie continuam abrindo no CrossOver. `INSTALL_DIR=<pasta>` instala em outro lugar. O bundle depende do `/Applications/CrossOver.app` instalado (frameworks, recursos e `SharedSupport`).

## Identidade

O app usa ícone, logo e nome próprios sobre os recursos do CrossOver:

- Ícone: o controle de `resources/icon/controller.webp` sobre fundo preto, recortado pela máscara de ícone da Apple para o macOS não colocá-lo numa placa cinza. `make icon` regenera o PNG e o `.icns`.
- Logo da barra lateral: `resources/logo/CrossThroughLogo*.png`, versões clara e escura no estilo da faixa original. `make logo` regenera.
- Nome: `CFBundleName` e `CFBundleDisplayName` viram CrossThrough; `src/classes/CrossThroughBranding.m` registra a logo com o nome que o `MainWindow.nib` pede e troca o nome nos itens Sobre, Ocultar e Encerrar.

## Diferenças do original

- A lista de ícones da CodeWeavers é buscada em segundo plano, como no CrossOver 26.3, mas o erro de uma resposta que não é JSON (o site fora do ar) é tratado em vez de encerrar o app.
- Os caminhos que a lista de ícones resolveu ficam salvos em `~/Library/Caches/com.crossthrough.app/IconPaths.plist`, e são usados quando a lista não chega, para os ícones já baixados continuarem aparecendo.
