# app/: CrossThroughKit, CLI e app

Pacote Swift sem dependências externas (só Foundation, CryptoKit, ImageIO,
AppKit e SwiftUI):

| Alvo | O que é |
|---|---|
| `CrossThroughKit` | biblioteca: runtime, bottles, execução do Wine, atalhos `.lnk`, programas instalados, ícones, winetricks, catálogo, downloads e instalação |
| `crossthrough` | linha de comando sobre o Kit |
| `CrossThroughApp` | o app SwiftUI |

O Wine vem do runtime de `runtime/` (compilado do fonte por `runtime/build.sh`).

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
