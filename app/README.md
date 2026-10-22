# app/: CrossThroughKit, CLI e app

Pacote Swift sem dependências externas (só Foundation, CryptoKit, ImageIO,
AppKit e SwiftUI):

| Alvo | O que é |
|---|---|
| `CrossThroughKit` | biblioteca: runtime, bottles, execução do Wine, atalhos `.lnk`, programas instalados, ícones, winetricks, catálogo, downloads e instalação |
| `crossthrough` | linha de comando sobre o Kit |
| `CrossThroughApp` | o app SwiftUI |

O Wine vem do runtime de `runtime/` (compilado do fonte por `runtime/build.sh`).

## O app

`scripts/bundle.sh` monta o `CrossThrough.app` (universal, assinado ad hoc) em
`~/Library/Caches/CrossThrough-dev/app`; `--debug` compila mais rápido. O
`install.sh` da raiz roda os testes, chama o `bundle.sh` e instala em
`/Applications`:

```bash
../install.sh
```

| Dentro do app | O que é |
|---|---|
| `Contents/MacOS/CrossThrough` | o app SwiftUI |
| `Contents/Helpers/crossthrough` | o CLI, que acha o runtime do app sozinho |
| `Contents/Resources/catalog.json` | o catálogo de receitas (`catalog/`) |
| `Contents/SharedSupport/CrossThroughRuntime` | o runtime do Wine, como o `runtime/build.sh` o monta |

O caminho do runtime instalado tem no máximo 150 caracteres (o
`maxInstallPathLength` do `runtime.json`); o `install.sh` confere antes de
instalar.

### Capturas sem gravação de tela

Com `CROSSTHROUGH_SNAPSHOT=<pasta>`, o app passa pelas telas principais, grava
um PNG de cada janela e sai. A janela desenha a si mesma (`cacheDisplay`), então
o macOS não pede permissão de gravação de tela:

```bash
CROSSTHROUGH_SNAPSHOT=/tmp/telas ~/Library/Caches/CrossThrough-dev/app/CrossThrough.app/Contents/MacOS/CrossThrough
```

`CROSSTHROUGH_SNAPSHOT_ALL=1` inclui todas as receitas e bottles.
`CROSSTHROUGH_SNAPSHOT_INSTALL=<receita>` instala a receita numa bottle nova
pelo app, abre o programa, fecha e fotografa cada etapa.
`CROSSTHROUGH_SNAPSHOT_ADOPT=1` adota o primeiro prefixo de outro programa.
Os dois últimos mexem nas bottles: use com `CROSSTHROUGH_BOTTLES` apontando
para uma cópia (`cp -cR` clona no APFS sem ocupar espaço).

## Compilar e testar

O repositório fica no iCloud Drive neste Mac (`~/Documents`), e o FileProvider
põe atributos estendidos nos bundles que o build cria; o `codesign` do bundle
de testes recusa esses atributos. Por isso o build vai para fora da pasta:

```bash
swift build --scratch-path ~/Library/Caches/CrossThrough-dev/build
```

```bash
swift test --scratch-path ~/Library/Caches/CrossThrough-dev/build
```

Os testes que usam o Wine de verdade (criar bottle, rodar, renomear) precisam
do runtime compilado e levam por volta de 30 s:

```bash
CROSSTHROUGH_INTEGRATION=1 swift test --scratch-path ~/Library/Caches/CrossThrough-dev/build
```

## CLI

Com o build fora do repositório, o CLI não acha o runtime sozinho; aponte
`CROSSTHROUGH_RUNTIME` para ele:

```bash
export CROSSTHROUGH_RUNTIME="$PWD/../runtime/out/CrossThroughRuntime"
```

```bash
~/Library/Caches/CrossThrough-dev/build/debug/crossthrough help
```

Fluxo típico:

```bash
crossthrough install 7zip
```

```bash
crossthrough programs 7-Zip
```

```bash
crossthrough open 7-Zip "7-Zip File Manager"
```

As bottles ficam em `~/Library/Application Support/CrossThrough/Bottles`
(`CROSSTHROUGH_BOTTLES` troca o diretório), os logs em
`~/Library/Logs/CrossThrough/<bottle>/` e os downloads, o cache do winetricks e
os ícones em `~/Library/Caches/CrossThrough`.

## Como o Kit roda o Wine

- O ambiente é montado do zero (como `env -i`): nada do ambiente de quem chama
  chega ao Wine. `WINEDLLOVERRIDES` junta o backend gráfico, os overrides da
  bottle e os da chamada; o `winemenubuilder` fica desligado.
- A saída vai para um arquivo de log, nunca para um pipe: processos que o
  programa deixa vivos (wineserver, services.exe) segurariam o pipe.
- Um programa do Menu Iniciar roda direto pelo alvo do atalho, com os
  argumentos dele, e o código de saída volta. Atalhos do Windows Installer
  (sem caminho) vão pelo `start` do Wine, e aí o Kit acompanha a bottle com
  `wineserver -w` até tudo nela fechar.
- `crossthrough.json` na raiz da bottle guarda a configuração do CrossThrough
  (versão do Windows, backend gráfico, msync, overrides, ambiente e as receitas
  instaladas). O resto da bottle é um prefixo comum do Wine.

## Bottles de outro programa

Uma pasta em `Bottles/` sem `crossthrough.json` mas com `system.reg` e
`drive_c/` é um prefixo do Wine criado por outro programa. O app a mostra na
barra lateral, e o CLI a lista em `crossthrough bottles`. Adotar
(`crossthrough adopt <nome>`, ou o botão Usar no CrossThrough) faz quatro
coisas:

1. lê a versão do Windows do registro (`CurrentBuild` em
   `HKLM\Software\Microsoft\Windows NT\CurrentVersion`, no `system.reg`);
2. roda `wineboot --update`, que atualiza o Windows da bottle para o Wine do
   runtime sem tocar nos programas nem nos dados;
3. instala o backend gráfico escolhido;
4. grava o `crossthrough.json`, com a data da adoção.

Os arquivos do outro programa (`cxbottle.conf` e afins) ficam como estão.
Adotar de novo uma bottle já adotada não faz nada.

## Atalhos e pontos de reparse

Os programas de uma bottle saem dos atalhos `.lnk` do Menu Iniciar. Instaladores
como o do EA app apontam os atalhos para um link simbólico do NTFS (em
`C:\Program Files\Electronic Arts\EA Desktop`, `EA Desktop` →
`13.813.0.6326\EA Desktop`, a pasta da versão atual). O Wine grava links
simbólicos e junções como um item `<nome>?` com o
`REPARSE_DATA_BUFFER` do Windows no atributo estendido `user.WINEREPARSE`.
`ReparsePoint.swift` lê esse buffer (links relativos e absolutos, até 63
saltos, como o Wine), e `Bottle.existingUnixPath(forWindowsPath:)` passa por
eles ao achar o executável e o ícone de um atalho.

Os ícones vêm do `.ico` dentro do executável. O ImageIO reordena as imagens de
um `.ico` e informa 8 bits para todas, então o Kit escolhe a imagem pelo
diretório do próprio `.ico` (a maior, e entre as do mesmo tamanho a de mais
cores) e redesenha em RGBA de 8 bits: as imagens de paleta saem do ImageIO em
4 bits por canal, e gravadas direto em PNG ficariam quase transparentes.

## Qual backend gráfico

`GraphicsBackend.advice(for:)` recomenda um backend a partir dos programas da
bottle, quando algum não abre com o padrão. Hoje é um caso: o EA app
(`EALauncher.exe`, `EADesktop.exe`) é feito com o Chromium, que precisa de swap
chain entre processos. O DXMT ainda não tem isso, e com o DXVK o
`EALaunchHelper` trava; com o Wine (OpenGL) ele abre. A adoção já escolhe o
backend recomendado, e os ajustes da bottle avisam quando o escolhido é outro.
