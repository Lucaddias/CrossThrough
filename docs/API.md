# Referência da API

A API pública do `CrossThroughKit`, a biblioteca que o app e o CLI usam, e os
comandos do CLI. O caminho de cada operação está em
[HOW-IT-WORKS.md](HOW-IT-WORKS.md).

O Kit não tem dependências externas: usa só Foundation, CryptoKit e ImageIO. Os tipos são `Sendable`. As operações que rodam o Wine são `async` e
respeitam o cancelamento da `Task`: cancelar encerra o processo e lança
`CancellationError`. Os erros são `LocalizedError`, com a mensagem em português.

## Runtime

### `struct Runtime`

O runtime do Wine validado. A validação confere que:

- o `runtime.json` é legível;
- `bin/wine` e `bin/wineserver` existem;
- o caminho cabe em `maxInstallPathLength`.

| Membro | O que é |
|---|---|
| `init(root: URL) throws` | valida e carrega o runtime de `root` |
| `root`, `manifest` | o diretório e o `runtime.json` decodificado |
| `wine`, `wineserver`, `binDirectory`, `winetricks` | caminhos dentro do runtime |
| `wineDLLDirectory(_ arch: WindowsArch) -> URL` | as DLLs do Wine (`lib/wine/<arch>-windows`) |
| `backendDLLDirectory(_ name: String, _ arch: WindowsArch) -> URL` | as DLLs do DXVK ou do DXMT |
| `static candidates(environment:bundle:executable:) -> [URL]` | onde procurar, em ordem: `CROSSTHROUGH_RUNTIME`, `Contents/SharedSupport` do app (ou relativo ao CLI em `Contents/Helpers`), `runtime/out/` do repositório |
| `static locate(environment:bundle:executable:) throws -> Runtime` | o primeiro candidato que existe. Um candidato que existe mas é inválido vira erro, sem passar para o próximo |

### `struct RuntimeManifest`

O `runtime.json` tem estes campos: `name`, `built` (data ISO 8601), `arch`,
`minimumMacOS`, `maxInstallPathLength`, `wine` (ex.: `wine-11.0`) e
`components`. Cada componente traz `name`, `version`, `url`, `sha256` e
`license`.

### `enum WindowsArch`

`x86_64` (instala em `system32`) e `i386` (instala em `syswow64`).
`systemDirectoryName` dá o nome da pasta.

### `enum RuntimeError`

`notFound(searched:)`, `invalid(path:reason:)`, `pathTooLong(path:length:limit:)`.

## Bottles

### `enum WindowsVersion`

`win11`, `win10`, `win81`, `win8`, `win7`, `vista`, `winxp`. `displayName` dá o
nome por extenso (“Windows 10”). `wineDefault` é `.win10`. `init?(build:)` lê
o número de build do Windows (`CurrentBuild`): 22000 ou mais é Windows 11,
10240 ou mais é Windows 10, e assim por diante.

### `struct BottleConfig`

O `crossthrough.json` na raiz da bottle (`Codable`).

| Campo | O que é |
|---|---|
| `formatVersion` | versão do formato (`currentFormat` = 1) |
| `windowsVersion`, `graphics`, `msync` | versão do Windows, backend gráfico e msync |
| `dllOverrides`, `environment` | ordem de carga de DLLs (`dll` → `n,b`) e variáveis de ambiente |
| `created`, `createdWith` | quando e com qual Wine a bottle foi criada |
| `adopted` | quando a bottle foi adotada de outro programa (nil se nasceu aqui) |
| `recipes` | ids das receitas instaladas nela |

Campos ausentes no JSON voltam ao padrão, então uma configuração antiga continua
legível.

### `struct Bottle`

Uma bottle é um prefixo do Wine (o próprio diretório) com o `crossthrough.json`.
O `id` é o caminho, e o `name` é o nome do diretório.

| Membro | O que é |
|---|---|
| `url`, `config`, `configURL`, `driveC`, `windowsDirectory` | o diretório, a configuração e caminhos internos |
| `static load(from: URL) throws -> Bottle?` | lê a bottle. Devolve nil se não houver `crossthrough.json` |
| `save() throws` | grava o `crossthrough.json` de forma atômica |
| `unixPath(forWindowsPath:) -> URL?` | `C:\…` ou `Z:\…` no caminho do Mac, sem conferir se existe |
| `existingUnixPath(forWindowsPath:) -> URL?` | o mesmo, só para o que existe. Expande `%VAR%`, ignora maiúsculas e minúsculas e atravessa links e junções do Wine |
| `windowsPath(forUnixPath:) -> String` | o caminho inverso, `C:\…` dentro da bottle ou `Z:\…` fora dela |
| `windowsUserName`, `windowsEnvironment`, `expandEnvironment(_:)` | o usuário do Windows e as variáveis (`USERPROFILE`, `APPDATA`, `ProgramFiles`…) |
| `mutating setGraphics(_:runtime:) throws` | troca as DLLs do backend e grava a configuração |
| `mutating setWindowsVersion(_:runtime:) async throws` | roda `winecfg /v` e grava a configuração |
| `mutating update(_ change: (inout BottleConfig) -> Void) throws` | muda o que não mexe em arquivos do Wine (msync, variáveis, DLLs) e grava |

### `struct BottleStore`

O diretório das bottles. O padrão é
`~/Library/Application Support/CrossThrough/Bottles`.

| Membro | O que é |
|---|---|
| `init(root: URL = BottleStore.defaultRoot)` | |
| `url(for name: String) -> URL` | onde fica (ou ficaria) uma bottle |
| `scan() throws -> StoreScan` | as bottles, as danificadas e os prefixos de outro programa, em ordem de nome |
| `list() throws -> [Bottle]`, `bottle(named:) throws -> Bottle` | atalhos de `scan()` |
| `static validateName(_:) throws` | rejeita um nome vazio, com espaço nas pontas, com mais de 64 caracteres, começando com `.`, com `/`, `:` ou caracteres de controle |
| `availableName(base:) -> String` | `base`, ou `base 2`, `base 3`… até achar um livre |
| `create(name:windowsVersion:graphics:runtime:progress:) async throws -> Bottle` | cria e inicializa a bottle. Se falhar, não sobra nada no disco |
| `adopt(_:graphics:runtime:progress:) async throws -> Bottle` | passa a usar um prefixo de outro programa |
| `delete(_:runtime:) async throws` | encerra a bottle e a manda para o Lixo |
| `rename(_:to:runtime:) async throws -> Bottle` | encerra a bottle e renomeia o diretório e os logs |
| `changes(forEventPaths:) -> StoreChanges` | traduz eventos do FSEvents em “bottles mudaram” ou “programas da bottle X mudaram” |

`StoreScan` tem `bottles`, `damaged` (nome e erro) e `foreign`.
`BottleCreationStep` é a etapa mostrada no progresso: `initializing`,
`updating`, `configuringWindows`, `installingGraphics` ou `finishing`. A
propriedade `description` dá o texto.

### `struct ForeignBottle`

Um prefixo do Wine sem `crossthrough.json`. Tem `url`, `id`, `name`, e
`windowsVersion`, lida do `system.reg` (nil se não for identificável).
`static isWinePrefix(_:)` confere se há `system.reg` e `drive_c/`.

### `enum BottleError`

`invalidName(_:reason:)`, `alreadyExists(_:)`, `notFound(_:)`,
`incomplete(name:missing:)`, `commandFailed(command:status:log:)`.

## Rodar o Wine

### `struct Wine`

Liga um runtime a uma bottle.

| Membro | O que é |
|---|---|
| `init(runtime:bottle:verbose: = false)` | `verbose` liga o log do Wine, do DXVK e do MoltenVK |
| `environment(extra:dllOverrides:) -> [String: String]` | o ambiente completo, montado do zero |
| `dllOverrides(extra:) -> String` | o `WINEDLLOVERRIDES`: winemenubuilder desligado, backend, bottle, extras |
| `run(_ arguments:workingDirectory:environment:log:timeout:) async throws -> ProcessResult` | `wine <arguments>` até terminar. Ao fim do tempo, encerra a bottle |
| `launch(_ arguments:workingDirectory:environment:log:onExit:) throws -> RunningProcess` | inicia sem esperar |
| `open(_ program: Program, log:onExit:) throws -> RunningProcess` | abre um programa pelo alvo do atalho (veja HOW-IT-WORKS) |
| `open(file:arguments:log:onExit:) throws -> RunningProcess` | abre um arquivo: o `.exe` direto, o `.msi` pelo `msiexec`, o resto pelo `start` |
| `waitForAll(timeout:stopOnTimeout:) async throws` | `wineserver -w`: espera a bottle esvaziar |
| `waitForPrograms(timeout:poll:) async throws -> Bool` | espera os programas fecharem, sem contar os processos de fundo |
| `processNames() async throws -> [String]` | os processos da bottle, pelo `tasklist` do Wine |
| `stopAll() async throws` | `wineserver -k`: encerra tudo na bottle e grava o registro |

`ProcessResult` tem `status`, `output` (stdout e stderr desta execução), `log`
e `succeeded`. `RunningProcess` tem `log`, `isRunning`, `processIdentifier`,
`terminate()` e `waitUntilExit() async -> Int32`.

### `enum Logs`

Os logs ficam em `~/Library/Logs/CrossThrough/<bottle>/`.
`newLog(for:named:)` cria um arquivo por execução, com a data e o nome do que
rodou.

## Backend gráfico

### `enum GraphicsBackend`

`dxmt`, `dxvk`, `wined3d`.

| Membro | O que é |
|---|---|
| `displayName`, `summary` | nome e descrição para a interface |
| `static managedDLLs` | as seis DLLs que algum backend substitui |
| `nativeDLLs`, `dllOverride` | as DLLs deste backend e a entrada do `WINEDLLOVERRIDES` |
| `isInstalled(in:runtime:) -> Bool` | se a bottle tem exatamente as DLLs deste backend |
| `install(in:runtime:) throws` | copia as DLLs (e restaura as do Wine nas outras), uma a uma, de forma atômica |
| `static advice(for: [Program]) -> GraphicsAdvice?` | recomenda um backend quando um programa conhecido não abre com o padrão |

`GraphicsAdvice` tem `backend`, `program` (o executável que motivou a
recomendação) e `reason` (o texto para o usuário).

## Programas, atalhos e ícones

### `struct Program` e `enum ProgramScanner`

Cada `Program` corresponde a um atalho. Ele tem estes campos:

- `name`;
- `shortcut`, o `.lnk`;
- `source`: `startMenu` ou `desktop`;
- `folder`, as subpastas do Menu Iniciar;
- `target`, `arguments` e `workingDirectory`, já como caminhos do Mac;
- `icon`, um `IconReference` com o arquivo e o índice.

`ProgramScanner.scan(_ bottle:) -> [Program]` devolve os programas da bottle
em ordem de nome, sem desinstaladores, sem atalhos para pastas ou documentos e
sem repetições.

### `struct ShellLink`

Um `.lnk` do Windows lido e gravado pelo Kit, conforme o MS-SHLLINK.

| Membro | O que é |
|---|---|
| `init(contentsOf: URL) throws`, `static parse(_ data: Data) throws -> ShellLink` | lê o atalho |
| `targetCandidates` | os caminhos do alvo encontrados no atalho, do mais confiável ao menos |
| `name`, `relativePath`, `workingDirectory`, `arguments`, `iconLocation`, `iconIndex`, `showCommand` | os campos do atalho |
| `isAdvertised` | atalho do Windows Installer, que não traz caminho |
| `static make(target:workingDirectory:arguments:…) -> Data` | grava um atalho que o Wine e o Windows leem |

Um atalho malformado lança `BinaryFormatError` (`truncated` ou `invalid`).

### `enum IconExtractor` e `enum IconCache`

| Membro | O que é |
|---|---|
| `IconExtractor.icoData(for: IconReference) throws -> Data?` | o `.ico` do arquivo, ou o grupo de ícones de um `.exe` ou `.dll` |
| `IconExtractor.icoData(fromPE:index:) throws -> Data?` | o grupo de ícones de um executável PE. Um índice ≥ 0 é a posição; um < 0 é o ID do recurso |
| `IconExtractor.pngData(fromICO:maxPixelSize:) -> Data?` | a melhor imagem do `.ico` (maior, depois a de mais cores) em PNG RGBA |
| `IconCache.png(for:maxPixelSize:) -> Data?` | o mesmo, em cache em `~/Library/Caches/CrossThrough/Icons`; a chave inclui a data do arquivo |

## Catálogo e instalação

### `struct Recipe` e `struct Catalog`

O formato do JSON e as regras do catálogo estão em
[`catalog/README.md`](../catalog/README.md).

| Membro | O que é |
|---|---|
| `Recipe.Category` | `games`, `launchers`, `productivity`, `utilities`, `development`, `multimedia`, `internet` |
| `Recipe.BottleSpec` | a configuração de uma bottle nova (versão do Windows, backend, msync, ambiente, DLLs) |
| `Recipe.Download` | `url`, `sha256` e `fileName`. `resolvedFileName` é o nome do arquivo no cache |
| `Recipe.InstallStep` | `run(arguments:)`, `msi(arguments:)`, `extract(destination:stripTopLevel:)` ou `none` |
| `Recipe.Shortcut` | o atalho criado no Menu Iniciar ao fim |
| `Catalog.load(from:) throws`, `Catalog.locate(environment:…) throws -> URL` | lê o catálogo; `locate` procura `CROSSTHROUGH_CATALOG`, o do app e o do repositório |
| `recipe(id:) -> Recipe?` | |
| `problems(knownVerbs:) -> [String]` | inconsistências: ids repetidos, SHA-256 malformado, verbos que o winetricks não conhece |

`CatalogError` pode ser `notFound(searched:)`, `unsupportedFormat(_:)` ou
`unknownRecipe(_:)`.

### `struct Installer`

`init(runtime:store:)` e
`install(_ recipe:into: InstallTarget, progress:) async throws -> Bottle`.

O destino (`InstallTarget`) é `.newBottle(name:)` ou `.existing(Bottle)`. O
progresso chega como `InstallPhase`:

- `creatingBottle`;
- `configuringBottle`;
- `winetricks`;
- `downloading(received:total:)`;
- `installing`;
- `extracting`;
- `waitingForInstaller`;
- `creatingShortcut`;
- `finished`.

Cada fase tem `description` e, só no download, `fraction`. Os erros
(`InstallError`) são `installerFailed(recipe:status:log:)`,
`shortcutTargetMissing(recipe:target:)` e `extractFailed(recipe:log:)`.

### `enum Downloader`

`fetch(_ download:folder:cacheDirectory:progress:) async throws -> URL` baixa
para `~/Library/Caches/CrossThrough/Downloads/<pasta>`, ou reaproveita um
arquivo que já esteja lá com o SHA-256 certo. Ele confere o SHA-256 e só põe o
arquivo no lugar depois de baixar tudo. `sha256(of:) throws -> String` calcula
o hash. Os erros (`DownloadError`) são `http(status:url:)` e
`checksumMismatch(file:expected:actual:)`.

## Winetricks

### `struct Winetricks`

| Membro | O que é |
|---|---|
| `init(wine: Wine)` | |
| `environment() -> [String: String]` | o ambiente da bottle com `WINE`, `WINESERVER`, o `cabextract` no `PATH` e o cache em `~/Library/Caches/CrossThrough` |
| `run(_ verbs:log:timeout:) async throws -> ProcessResult` | `winetricks -q <verbos>` e espera a bottle esvaziar |
| `static installedVerbs(in: Bottle) -> [String]` | o que o `winetricks.log` da bottle registra |
| `static verbs(runtime:) throws -> [WinetricksVerb]` | todos os verbos do script do runtime, lidos das declarações `w_metadata` sem rodar o script, com categoria, título, editora, ano e tipo de mídia |

Os erros (`WinetricksError`) são `invalidVerb(_:)` e
`failed(verbs:status:log:reason:)`.

## Configuração como texto

`enum ConfigText` converte variáveis e ordem de DLLs em texto, uma entrada
`NOME=valor` por linha, e o texto de volta:

- `format(_:) -> String`;
- `parseEnvironment(_:) throws -> [String: String]`;
- `parseDLLOverrides(_:) throws -> [String: String]`.

Linhas vazias e as que começam com `#` são ignoradas. Um nome inválido lança
`ConfigText.ParseError` com o número da linha.

## CLI

`crossthrough <comando> [argumentos]`. Dentro do app, o CLI fica em
`Contents/Helpers/crossthrough` e acha o runtime e o catálogo do app sozinho.

| Comando | Faz |
|---|---|
| `runtime` | mostra o runtime em uso, os componentes e as licenças |
| `bottles` | lista as bottles e os prefixos de outro programa |
| `create <bottle> [--windows <versão>] [--graphics <backend>]` | cria uma bottle |
| `adopt <bottle> [--graphics <backend>]` | adota um prefixo de outro programa (sem `--graphics`, usa o recomendado) |
| `delete <bottle>` | manda a bottle para o Lixo |
| `rename <bottle> <novo nome>` | |
| `graphics <bottle> [backend]` | mostra ou troca o backend gráfico (`dxmt`, `dxvk`, `wined3d`) |
| `windows <bottle> [versão]` | mostra ou troca a versão do Windows (`win11` … `winxp`) |
| `programs <bottle>` | os programas instalados |
| `open <bottle> <programa>` | abre um programa pelo nome e espera fechar |
| `run <bottle> <arquivo> [args...]` | roda um `.exe`, `.msi` ou outro arquivo e espera terminar |
| `icon <bottle> <programa> <saída.png>` | salva o ícone de um programa |
| `winetricks <bottle> <verbos...>` | instala dependências |
| `verbs [categoria]` | lista os verbos do winetricks |
| `catalog` | lista as receitas |
| `install <receita> [--bottle <nome>]` | instala uma receita, numa bottle nova se não houver `--bottle` |
| `stop <bottle>` | encerra tudo o que roda na bottle |

`--verbose` liga o log detalhado do Wine, do DXVK e do MoltenVK.

## Variáveis de ambiente

| Variável | Efeito |
|---|---|
| `CROSSTHROUGH_RUNTIME` | usa outro runtime |
| `CROSSTHROUGH_CATALOG` | usa outro `catalog.json` |
| `CROSSTHROUGH_BOTTLES` | usa outro diretório de bottles (no app e no CLI) |
| `CROSSTHROUGH_SNAPSHOT=<pasta>` | o app fotografa as telas e sai (veja `app/README.md`) |
| `CROSSTHROUGH_SNAPSHOT_ALL`, `CROSSTHROUGH_SNAPSHOT_INSTALL=<receita>`, `CROSSTHROUGH_SNAPSHOT_ADOPT` | variações das capturas: todas as telas, uma instalação de verdade, uma adoção de verdade |
| `CROSSTHROUGH_INTEGRATION=1` | liga os testes que rodam o Wine de verdade |
