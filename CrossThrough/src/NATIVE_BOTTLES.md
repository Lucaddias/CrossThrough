# Módulo nativo de bottles (remoção da camada Python)

Esta é a etapa 3: reescrever o módulo de bottles em Objective-C nativo,
substituindo as classes Python fechadas (`bottlewrapper`, `bottlecollection`,
`bottlemanagement`, `bottlequery` em `.pyc`, chamadas via PyObjC). A GUI deixa
de depender do interpretador Python **para as bottles** — continua a usá-lo para
o resto (C4Profiles, InstallTask, Engine, etc.).

## Como se liga à GUI

A GUI chega às bottles só por `CXSetupLib`:

```objc
[[CXSetupLib bottleCollectionClass] sharedCollection]   // -> CTBottleCollection
[[CXSetupLib bottleManagementClass] createBottle:…]     // -> CTBottleManagement
[[CXSetupLib bottleQueryClass]      uniqueBottleName:…]  // -> CTBottleQuery
```

`CXSetupLib` passou a devolver as classes nativas `CTBottleCollection`,
`CTBottleWrapper`, `CTBottleManagement` e `CTBottleQuery` (em `BottleModel.m` e
`CXBottleSupport.m`), em vez de `NSClassFromString(@"BottleCollection")` etc. do
Python.

**Porquê o prefixo `CT`:** o PyObjC ainda regista classes Objective-C chamadas
`BottleWrapper`, `BottleCollection`, … ao importar os módulos Python restantes.
Registar classes nativas com os mesmos nomes faz o PyObjC abortar
(`objc.error: BottleQuery is overriding existing Objective-C class`), o que
quebrava o carregamento de *todas* as classes Python. Com nomes distintos não há
colisão; a GUI continua a ver os objetos pelos tipos `BottleWrapper*` /
`BottleCollection*` de `PythonShim.h` (quase sempre via `id`), e por KVC/Cocoa
Bindings — nenhum desses caminhos depende do nome de runtime.

Verificado por `make test`: o log mostra
`BottleCollection=CTBottleCollection, C4Profiles=C4Profiles` e
`ALL WIZARD, ENGINE, AND BACKEND TESTS PASSED SUCCESSFULLY!`.

## Ficheiros

| Ficheiro | Papel |
|---|---|
| `include/NativeBottles.h` | Interfaces de suporte e das classes `CT*` |
| `classes/CXBottleSupport.m` | `CXBottleConfig` (INI `cxbottle.conf`), `CXBottlePaths`, `CXBottleTool`, `CXToolResult` |
| `classes/BottleModel.m` | `CTBottleQuery`, `CTBottleManagement`, `CTBottleCollection`, `CTBottleWrapper` |

## Mapeamento com BRIDGE.md / outlines

### `CTBottleQuery` (era `bottlequery`)

| Seletor | Reconstrução | Evidência |
|---|---|---|
| `uniqueBottleName:` | sanitiza, compara com a lista de bottles e `reserved_names`, acrescenta `-N` | `unique_bottle_name` |
| `isValidNewBottleName:` | sanitiza, rejeita reservados e existentes | `is_valid_new_bottle_name` |

`reserved_names = [default, icons, installers, logs, tie]` e a validação de
prefixo (exige `system.reg` + `cxbottle.conf`) vêm de `bottlequery.py`.

### `CTBottleManagement` (era `bottlemanagement`)

Todos os comandos usam `CX_ROOT/bin/{cxbottle,wine,cxsu}` e os vetores de
argumentos exatos dos esboços:

| Método | Comando |
|---|---|
| `createBottle:fromTemplate:` | `cxbottle --bottle N --create --template T --install` |
| `duplicateBottle:fromBottle:` | `cxbottle --bottle N --copy SRC --install` |
| `restoreBottle:fromArchive:` | `cxbottle --bottle N --restore ARCH --install` (LANG/LC_* = UTF-8) |
| `archiveBottle:toPath:` | `cxbottle --bottle N --tar PATH` (UTF-8) |
| `quitBottle:` | `wine --bottle N --no-update --wl-app wineboot.exe -- --end-session --shutdown --force --kill` |
| `killBottle:` | `wine --bottle N --no-update --ux-app wineserver -k` |
| `isRunning:` | `wine --bottle N --no-update --ux-app wineserver -k0` (código de saída) |
| `deleteBottle:managed:` | `cxbottle --bottle N --removeall --delete --force` (gerida: via `cxsu --ignore-home … --scope private`) |
| `setDefaultBottle:state:` | `cxbottle --default/--undefault --bottle N` |
| `getUpToDate:scope:` | `cxbottle --bottle N --status --scope S` → procura `Status=uptodate` |
| `templates` / `displayNameForTemplate:` | tabela `_TEMPLATE_PROPERTIES`; lista `share/crossover/bottle_templates` |

### `CTBottleCollection` (era `bottlecollection`)

`sharedCollection` (singleton), `bottleList`, `bottleWithName:`, `refresh`
(varre o dir de bottles, adiciona/remove *wrappers*, marca a default), `reset`,
`refreshDefaultBottle`, `addChangeDelegate:`/`removeChangeDelegate:`
(notifica `bottleCollectionChanged`), `has32BitBottle`. Conforme
`bottlecollection.py`.

### `CTBottleWrapper` (era `bottlewrapper`)

Propriedades e seletores respaldados por `cxbottle.conf` + processos:

- **Identidade:** `name`, `appid` (`EnvironmentVariables/CX_BOTTLE_CREATOR_APPID`,
  prefixo `com.codeweavers.c4.`), `winePrefix`, `systemDrive` (`<prefix>/drive_c`),
  `currentDescription`/`writeDescription` (`Bottle/Description`), `displayName`,
  `isDefault`, `isManaged` (`Bottle/Updater` não vazio), `is32Bit`
  (`Bottle/WineArch == win32`).
- **Backends gráficos/vulkan:** `setGraphicsBackend{Auto,D3DMetal,DXMT,DXVK,Wine}`
  e `setVulkanBackend{MoltenVK,MTLVK}` gravam `EnvironmentVariables/CX_GRAPHICS_BACKEND`
  (`""`/`d3dmetal`/`dxmt`/`dxvk`/`wined3d`) e `CX_LIBVULKAN`; os getters
  `isIs…Enabled` leem de volta.
- **DLSS / MSync / Preview:** `D3DM_ENABLE_METALFX`+`DXMT_ENABLE_NVEXT`,
  `WINEMSYNC`, `Bottle/Preview` — valores exatos dos esboços.
- **Rating nag:** `disableRatingNag`/`shouldNagForRatings` (`Bottle/AskForRatings`).
- **Estado:** modelo `status` + `status_overrides` com os mesmos `STATUS_*`, e os
  BOOL derivados (`isBusy`, `isUsable`, `isActive`, `canRunCommands`, `canInstall`,
  `canForceQuit`, `canRename`, `isDisabled`) calculados como no esboço.
- **Ciclo de vida:** `quit:`, `forceQuit:`, `delete:`, `rename:completionHandler:`,
  `setIsDefault:completionHandler:` correm em fila de background e chamam o
  callback na thread principal, delegando em `CTBottleManagement` (espelha as
  `*Operation` de `pyop`).
- **KVO:** `bottleChanged` emite `willChange/didChange` para as chaves ligadas
  por Cocoa Bindings.

## Limites e inferências

- **Registo do Windows / cxmanip.** `load_high_resolution_info`,
  `load_control_panel_info`, `windows_version*` e a edição de registo dependem do
  subprocesso `cxmanip` (`wine --no-wait --no-gui --bottle N --wl-app cxmanip`) e
  do seu protocolo de texto (`getregkey`/`setregkey`/`rmregvalue`/`getwindowsdir`).
  Essas rotinas ficam como *stubs* seguros (listas vazias, `ready = YES`),
  documentadas aqui; o cliente `cxmanip` completo é trabalho futuro.
- **Bottles geridas.** Só o diretório privado (`~/…/CrossOver/Bottles`) é varrido;
  `get_managed_bottle_path` (fora do home, root) não é incluído na varredura.
- **`renameBottle:to:`** segue `rename_bottle` (recusa destino existente, move o
  prefixo, re-regista com `--new-uuid`/`--install`/`--default`), mas a ordem
  exata de `--removeall`/rename/registo é parcialmente inferida.
- **`sanitize`** aproxima `CXUtils.sanitize_bottlename`; o corpo exato da função
  Python não foi decompilado.
- **Observadores de ficheiro** (`cxfsnotifier` em `.version`/menus) não são
  reconstruídos; `addMenuObservers`/`removeObservers` são no-ops.
