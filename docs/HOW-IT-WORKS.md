# Como o CrossThrough funciona

Visão de ponta a ponta: camadas, fluxo de inicialização, chamadas entre a GUI e o backend, e as funções principais de cada parte.

## Camadas

```
┌──────────────────────────────────────────────┐
│ GUI Objective-C/Cocoa (src/classes, 95 .m)   │  janelas, sidebar, grade de apps, wizard
├──────────────────────────────────────────────┤
│ Ponte PyObjC (src/include/PythonShim.h)      │  classes Python vistas como NSObject
├──────────────────────────────────────────────┤
│ Biblioteca Python 3.13 (lib/python/*.pyc)    │  bottles, perfis CrossTie, motor de instalação
├──────────────────────────────────────────────┤
│ Ferramentas Perl (bin/, lib/perl)            │  wine, cxbottle, cxmenu, cxassoc
├──────────────────────────────────────────────┤
│ Wine x86_64 (sob Rosetta 2 no Apple Silicon) │  executa o programa Windows
└──────────────────────────────────────────────┘
```

O CrossThrough compila apenas a camada de GUI. As outras camadas vêm do runtime host, ligadas por `Contents/SharedSupport` (link simbólico) e `Contents/Frameworks` (cópia).

## Inicialização

1. `main.m` chama `NSApplicationMain`, que carrega `MainMenu.nib` e cria `CXApplication`.
2. `CXServerCrossOver` (o delegate, subclasse de `CXServer`) roda `applicationWillFinishLaunching:`:
   - `CTBrandAppMenu()` troca o nome nos menus;
   - agenda `AskUpdateBottlesOp`;
   - `CXServer` verifica o Rosetta e registra o handler de URLs (`kAEGetURL`).
3. `applicationDidFinishLaunching:` → `continueFromDemoCheck` → `refreshPrograms:` monta o menu de programas a partir das bottles.
4. `mainWindowController` cria `MainWindowController`:
   - `init` chama `CTRegisterBrandedLogo()` antes de carregar `MainWindow.nib`;
   - `windowDidLoad` monta a sidebar (`BottleNode`), observa `bottleList` e mostra a tela Install (`PackageViewController`).
5. `PackageViewController populatePackages` lê os perfis (`C4ProfilesSet.contentsDict`), cria um `PackageTreeNode` por app e, em segundo plano, busca a lista de ícones (`updateIconList` → `loadIcons`).

## A ponte GUI ↔ Python

`CXSetupLib` devolve as classes Python por nome (`bottleCollectionClass`, `c4ProfilesClass`, `iconUtilsClass`…). Os métodos Python aparecem como seletores Objective-C, declarados em `PythonShim.h`.

Regras da ponte:

- Todo retorno é objeto. Para ler um booleano use `[[x foo] boolValue]`.
- Uma exceção Python vira `NSException` (`OC_PythonException`). Chamadas que podem falhar por rede devem ficar em `@try`.
- Chamadas longas rodam fora da thread principal. O resultado volta por `dispatch_async(dispatch_get_main_queue(), …)`.

Principais classes Python usadas:

| Classe (módulo) | Uso pela GUI |
|---|---|
| `BottleCollection` (bottlecollection) | lista e observa bottles (`bottleList`, `sharedCollection`) |
| `BottleWrapper` (bottlewrapper) | estado de uma bottle: `isBusy`, versão do Windows, preview |
| `C4ProfilesSet` (c4profilesmanager) | perfis CrossTie: nome, notas, medalhas, instaladores |
| `InstallTask` / motor (cxaiengine) | plano e execução da instalação: downloads, dependências |
| `IconUtils` (iconutils) | lista de ícones da web e cache local |
| `RatingUtils` (ratingutils) | envio de avaliações |

## Fluxo de instalação de um app

1. O usuário clica num app da grade. `PackageViewController setSelectedPackage:` mostra o detalhe.
2. `install:` cria `PackageInstaller` com uma `InstallConfiguration` (bottle, idioma, instalador local ou download).
3. `PackageInstaller` pede ao motor Python o plano de tarefas e executa cada uma:
   - download: `CXDownloader`/`DownloadProgressController`;
   - criação da bottle: `cxbottle`;
   - execução do instalador no Wine.
4. O progresso chega por KVO (`summaryDetails`, `status`, `currentTaskDescription`). Cancelar chama `install:` de novo.

## Classes principais da GUI

| Classe | Responsabilidade |
|---|---|
| `CXApplication` | NSApplication: modo demo, dias de teste |
| `CXServer` / `CXServerCrossOver` | delegate do app: URLs, menus de programas, apps helper por bottle, atualizações |
| `MainWindowController` | janela principal, sidebar e troca de conteúdo (`updateMainContentView`) |
| `PackageViewController` | tela Install: busca, grade de apps populares, detalhe, wizard |
| `PackageTreeNode` | um app do catálogo: nome, medalha, ícone (`loadIcon`) |
| `PackageInstaller`, `InstallConfiguration` | executam e configuram uma instalação |
| `BottleViewController`, `LauncherIconViewController` | conteúdo de uma bottle e seus atalhos |
| `NewBottleController`, `RunCommandController` | criar bottle e rodar comando |
| `PreferencesController`, `LoggingOptionsViewController` | preferências e logs do Wine |
| `CXUpdater`, `CXSparkleUserDriver` | atualizações via Sparkle |
| `CrossTieURLHandler` | abre receitas `.tie` e links de instalação |

## Funções próprias do CrossThrough

| Função | Onde | O que faz |
|---|---|---|
| `CTApplicationName()` | CrossThroughBranding.m | nome do bundle (`CFBundleName`) |
| `CTRegisterBrandedLogo()` | CrossThroughBranding.m | registra a logo clara/escura com os nomes que o nib pede |
| `CTBrandAppMenu()` | CrossThroughBranding.m | nome nos itens Sobre, Ocultar e Encerrar |
| `resolvedIconPath()` | PackageTreeNode.m | guarda o caminho de cada ícone e o usa quando a lista da web falha |

## Build e empacotamento

- `make`: compila `src/` com Clang (mínimo macOS 11.0, SDK de link 15.1).
- `make app`: monta `build/CrossThrough.app` com frameworks, recursos, ícone, logo e `Info.plist` ajustado (`com.crossthrough.app`).
- `make install`: instala no `/Applications`. A cópia instalada:
  - fica sem as ferramentas de teste e sem associações de arquivo;
  - é assinada ad hoc;
  - é registrada no LaunchServices.
- `./install.sh`: faz tudo isso com verificação de pré-requisitos.

## Testes

| Alvo | Cobre |
|---|---|
| `make test` | `test_wizard` (wizard, motor, backend) e `test_misc` (formatters, Foundation, launchers, nibs) |
| `make snapshot` | captura Home e detalhe para comparação visual |
| `make probe` | lista as tarefas de instalação de um pacote; `PROBE_ARGS=--download` baixa a primeira |

Para mais detalhes de baixo nível, veja [`ARCHITECTURE.md`](../CrossThrough/ARCHITECTURE.md) e [`sharedsupport/`](../CrossThrough/sharedsupport).
